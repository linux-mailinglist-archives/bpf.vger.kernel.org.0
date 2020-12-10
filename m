Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E792D6C35
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 01:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbgLJX5M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 18:57:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21244 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728980AbgLJX44 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Dec 2020 18:56:56 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BANt5W7018508;
        Thu, 10 Dec 2020 15:55:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Nwmg8/CPtibsVxNacNz5JTWxDk/HqTloaYk1cbOSdCc=;
 b=m66VvduHcOMI53gp+SHp9+gSudNcaZig7L0BkD2HauMt3vc9QS69vpNJLKiWtxi86S/s
 7hNRDaLcOhy1PhKCYm39spLsM4D4ZML6sLJeLm9LnHewv+c22iC7Xy+4hl59kd15JtMS
 6vZDwL4NpydZ1ryCDJp6a6Ds7OK8JRybaUo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35avdhc77m-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Dec 2020 15:55:58 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Dec 2020 15:55:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVnTHIw+iRUZQViwiVL6ESS24zeJpnyc4DOtpBoTaUg4FosagehnShYBqh5tiTUEFJDJ5rbFu3fUGrUrfnyzIaXAVokpbOAmdtlNpeVQpeaG7CsxEYP7eXRXzlQwVdgaNuLZf6TTdsFZ2WRJUEK11o4FBU18kDCEq1Q8hEJUW3B0nudVLnaUSw2O7W56DxYuxdgU4v4WiLjUn7BEyb7f+o/CqvVQu3bNaZ5Q7witq5mzPmJul2ol6CLFTlOT2yPUAnd7tqGaQ26BZCqIGxUchQxeiTIeij53ua85BSUk3SWaKppNClGPGKWeCkkXwzORPu9sF6ZjKDQ/WyWui0c6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nwmg8/CPtibsVxNacNz5JTWxDk/HqTloaYk1cbOSdCc=;
 b=bjwZRZJ3GnWYyjSqetICXCjUejCuApC1abO26WFshdyhsWjOKsuryrs9maTIP0ltcsoGkAsOPH/WzcAAYdCXPk0fWmFj3dLPVjjXtbxHC+h/xjxKunpdxQsCgkPdNzH2RyU9rzjWaXT0FgXkUG6yG0mtFicnNLjGyXdzwurrqev6ORjZZIir2AcpW7axQPOcO6Vv8JiskGQIllklzH3vB5E8Cwf1cqvsZ8jAaMCUbVyPFCU6WimI5cM/ws93BW2yQxv9c6vkSlaprxVdmUn97mJWgeKyIawaka0z0a0SfcrycETWm8m/Upp3wd5CF1hnfjZQgktwJVxjl4lYoIYLLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nwmg8/CPtibsVxNacNz5JTWxDk/HqTloaYk1cbOSdCc=;
 b=hIi6UKaY/te2oBziwlnF0mfiy4veCrLO70Ghcr5YkyUI2fMF1ZWFtTbpQeo6dbYJ2in7N1omhdWshDvSMDGOIsDPUvww4g5EMYAf0dkd4mVyAyzTu6kFmeixnw7uYoGciQo0bt9L/ebbxcWTHgLCvRkoJUGIZrSInOOV1bZ9nTQ=
Authentication-Results: iogearbox.net; dkim=none (message not signed)
 header.d=none;iogearbox.net; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3303.namprd15.prod.outlook.com (2603:10b6:a03:10e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Thu, 10 Dec
 2020 23:55:54 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3654.017; Thu, 10 Dec 2020
 23:55:54 +0000
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Drop the need for LLVM's llc
To:     Andrew Delgadillo <adelg@google.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, <daniel@iogearbox.net>
References: <20201209205301.2586678-1-adelg@google.com>
 <20201210194157.3218806-1-adelg@google.com>
 <20201210194157.3218806-2-adelg@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <6bdcc1e4-5ce2-7876-e48f-bce04f7298b6@fb.com>
Date:   Thu, 10 Dec 2020 15:55:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201210194157.3218806-2-adelg@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ca19]
X-ClientProxiedBy: BYAPR01CA0040.prod.exchangelabs.com (2603:10b6:a03:94::17)
 To BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::113f] (2620:10d:c090:400::5:ca19) by BYAPR01CA0040.prod.exchangelabs.com (2603:10b6:a03:94::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 23:55:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 700a9597-2b0c-4ede-c2bc-08d89d6721c3
X-MS-TrafficTypeDiagnostic: BYAPR15MB3303:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3303B7076B810C644505E86FD3CB0@BYAPR15MB3303.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgPIr/wzDYsd7qlSeTw70jCs8n8DCv5HEFP3vVaC2M0ed3H7/0N1fc5n0aatmRMlMnDM5U2piDBzxAdXLmQI+3iKeEew14IaMongGtF6ch6pEl09SxnpySuU6nY7jZ+/SSsGVoiSMyC63VcorLMlROp4AQ5PN2ndWpq5WgaerwQdR5TA64kFyKPx+a/Frt12HGCTjHx3pS/RVjaKexik91dGVYU4zbJxLquLna7SRhf2kyqNSh+LJzjYLgTweUpeiXpmTzK8ONhQVvBxo3oBaUJeuYdUBTBLmv9mYJXxv2eQdaolcY7wf1AuhgOyc0LF26G9pm8g0sozJzv5mLObPxZZk+djeEUaN4pM7r0yViKLVQcWy+nchFioVIrnHobA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(2616005)(31686004)(83380400001)(2906002)(8676002)(508600001)(5660300002)(86362001)(110136005)(31696002)(53546011)(66556008)(8936002)(6486002)(186003)(16526019)(66946007)(36756003)(52116002)(66476007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SjhvSW1iOWNSNzJQeDExalQ0K1BERWlIMXUwS1ZnMGZob0kycGp1a2JuOEhK?=
 =?utf-8?B?OEtWUU82WHNra2xDVHNGM3MybitucHJNUUQ1ZmQ5VU45NnVpanA3S0dxaFhv?=
 =?utf-8?B?aDNCWTdWcGo5WEd1c1JIT1MzT1JWSGM4Zi9HRzE5bVJrL3IyQzdLVTdPTTRM?=
 =?utf-8?B?UnNaQzF3dk5PaTZHUkc4YjA1NVlTSUVuSFhUVGltdDdveFBSOHVLdmp1blFW?=
 =?utf-8?B?L3U5Vk1DaXJuMWdRVWhJd3VpODFWZzk0NDl0bnQ2RlZpYkhBSGMwbXBZcVZo?=
 =?utf-8?B?aTRHdFRiUWNmWXZwNnI5Z1VoeTAvaG1LdW42V2I3TlRHcE45MWJTYWQvbTBV?=
 =?utf-8?B?T2VuOU83c3F0a1M5WnB4L3RhK0U2cUYrUzE1ckwzNGRHT2w1RDVFTnY0YmY4?=
 =?utf-8?B?c2wvV2tndWNIYkNvVTQwVURucXNuK3FFdzJEVDJQcHlNbWtlUTY1R2d5Nnk0?=
 =?utf-8?B?aVVqZWVBbzJEQ0NGVmlLdGU4TTRMamFTRjRCUEtQaHAyL3IvaFE2OUdjcUdE?=
 =?utf-8?B?ZUVDMkRKbGIyck12NU80eGRPbC9uVTYybm4yYkErNDBrSXpncjBRYmxldEt6?=
 =?utf-8?B?M09FaUh6R29wcnFLSzZxZDlYVlhVMlM4dGFKNWdsUm1iZ1M2dkp2YnVKc042?=
 =?utf-8?B?c2RBNk5IVGtyZXdoekZ0NmN5YlZwZ0t1VGplVi9qZXAxalBWVkxUeGUzdWYx?=
 =?utf-8?B?NC8wYVJMZjVjSDVDb3c1dWpSTjFrSzJDNXp1REVIK2ZCZWlvSzBlMCttU1VY?=
 =?utf-8?B?eFFFVjZHTGNzWTExU0dRbFNrdktUL2NqTnhtcHFQT2FmdmlLRk43eVJnQVFI?=
 =?utf-8?B?ejNaYVhFN0xSUWlEa2hBTEQzSUtaM09rd2UvTlA1a0JpSnI1K0lnSUtIZlhY?=
 =?utf-8?B?R0VvYnJuaVgvYTMvMngxR3MzRDhyaHhSS2xoL25iMWtSeGJzREd6eFFhamJx?=
 =?utf-8?B?OHRuN0Z3ZStHTjdHb0dvZEF4VVlrZURsTmQ4SE9vVS9wMmRBYTM1b1ZLV1RM?=
 =?utf-8?B?MlpnMXpWNmxVU0tuUkFIdWxtK2V0Q0llUmtMUldKRUh6c01OSnovUW4wZ1NW?=
 =?utf-8?B?OEJSWEdORUdzMHphT0RrT3dZOUd1VDhzdVJWWU1DRmRiSUdYTnBhUlR6ZUVH?=
 =?utf-8?B?ci9tTS9uWG1wT29tYTF6bUxFbWZQak5VTXdwcncxY2hLRjM4V3RmdWpiUzZW?=
 =?utf-8?B?QzI5a2RIbHFoVEZXUndocTRPVlJybUZhSyt4RkFhY1BUdjhzUHlady9nN2ZG?=
 =?utf-8?B?aDJRaEFjTUpvOGZUVlJ0T1JqSC9CMzc2TFZKRURvbU1zMzdrV2VucmRJKzNN?=
 =?utf-8?B?eHpmeWc2M1JIaHNrQ2JQMnZGSG11c3RiUlI1dTcxak1XbWl4WTJOVWlHeXVy?=
 =?utf-8?B?T2g0V0loT0dNNlE9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 23:55:54.5665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 700a9597-2b0c-4ede-c2bc-08d89d6721c3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KUbagI0BKHqx1x51apw4B48F+WLP9JGd0lZdb4eXf09UvqHQyTQLTAmrA+Kg7hk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3303
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-10_11:2020-12-09,2020-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012100154
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/10/20 11:41 AM, Andrew Delgadillo wrote:
> LLC is meant for compiler development and debugging. Consequently, it
> exposes many low level options about its backend. To avoid future bugs
> introduced by using the raw LLC tool, use clang directly so that all
> appropriate options are passed to the back end.
> 
> Additionally, simplify the Makefile by removing the
> CLANG_NATIVE_BPF_BUILD_RULE as it is not being use, stop passing
> dwarfris attr since elfutils/libdw now supports the bpf backend (which
> should work with any recent pahole), and stop passing alu32 since
> -mcpu=v3 implies alu32.
> 
> Signed-off-by: Andrew Delgadillo <adelg@google.com>
> ---
> Changes since v1:
> * do not pass +dwarfris
> * do not pass +alu32 when using -mcpu=v3
> ---
>   tools/testing/selftests/bpf/Makefile | 19 +++----------------
>   1 file changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 944ae17a39ed..a96f63dfd8dc 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -19,7 +19,6 @@ ifneq ($(wildcard $(GENHDR)),)
>   endif
>   
>   CLANG		?= clang
> -LLC		?= llc
>   LLVM_OBJCOPY	?= llvm-objcopy
>   BPF_GCC		?= $(shell command -v bpf-gcc;)
>   SAN_CFLAGS	?=
> @@ -256,24 +255,13 @@ $(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
>   # $3 - CFLAGS
>   # $4 - LDFLAGS

You can remove TRUNNER_BPF_LDFLAGS completely, so we won't have $4 here.

>   define CLANG_BPF_BUILD_RULE
> -	$(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
> -	$(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm			\
> -		-c $1 -o - || echo "BPF obj compilation failed") | 	\
> -	$(LLC) -mattr=dwarfris -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
> +	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
> +	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -o $2 -mcpu=v3 $4

and $4 here.

>   endef
>   # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
>   define CLANG_NOALU32_BPF_BUILD_RULE
> -	$(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
> -	$(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm			\
> -		-c $1 -o - || echo "BPF obj compilation failed") | 	\
> -	$(LLC) -march=bpf -mcpu=v2 $4 -filetype=obj -o $2
> -endef
> -# Similar to CLANG_BPF_BUILD_RULE, but using native Clang and bpf LLC
> -define CLANG_NATIVE_BPF_BUILD_RULE
>   	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
> -	$(Q)($(CLANG) $3 -O2 -emit-llvm					\
> -		-c $1 -o - || echo "BPF obj compilation failed") | 	\
> -	$(LLC) -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
> +	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -o $2 -mcpu=v2 $4

and $4 here.

>   endef
>   # Build BPF object using GCC
>   define GCC_BPF_BUILD_RULE
> @@ -402,7 +390,6 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
>   		       $(wildcard progs/btf_dump_test_case_*.c)
>   TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
>   TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
> -TRUNNER_BPF_LDFLAGS := -mattr=+alu32
>   $(eval $(call DEFINE_TEST_RUNNER,test_progs))
>   
>   # Define test_progs-no_alu32 test runner.
> 
