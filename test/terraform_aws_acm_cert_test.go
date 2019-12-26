package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"

)

func TestBlah(t *testing.T) {
	t.Parallel()

	tempTestFolder := test_structure.CopyTerraformFolderToTemp(t, "../", "examples/simple")

	testName := fmt.Sprintf("terratest-%s", strings.ToLower(random.UniqueId()))
	awsRegion := "us-west-2"
	zoneName := "truss.coffee"
	domainName := "infra-test.truss.coffee"
	acmDomain := fmt.Sprintf("%s.%s", testName, domainName)
	//"${var.test_name}.${local.zone_name}"
	//zoneName := "truss.coffee"

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: tempTestFolder,

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"test_name":   testName,
			"region":      awsRegion,
			"domain_name": domainName,
			"environment": testName,
			"zone_name":   zoneName,
		},

		// Environment variables to set when running Terraform
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	acmARN := terraform.Output(t, terraformOptions, "acm_arn")

	// Terratest Get the ACM ARN
	ttACMARN := aws.GetAcmCertificateArn(t, awsRegion, acmDomain)

	assert.Equal(t, acmARN, ttACMARN)

}
