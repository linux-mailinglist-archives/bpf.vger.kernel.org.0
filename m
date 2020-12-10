Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D81A2D50C6
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 03:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgLJCRR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 21:17:17 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48838 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728228AbgLJCRJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Dec 2020 21:17:09 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0BA2EXCe013702;
        Wed, 9 Dec 2020 18:16:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=MhnqrAFBOa2/XKepTtjeLDIUvh8d9fXUa51Uqkx9j+4=;
 b=Xat8D7nwonDF5/CQPRhcVo2ax499pNNZdCdOVwsqO/eJqtticmCP9kzX8NYG6ci7S1hr
 IEIgUOqQE5ZPnNsrZf6hrSkIiMhyavvi8iqEDZyMh7qrKIVO5OmuVhaB3otZb9VjB2bt
 iA95REBdAjssfumfd+CRd0xPSTsT3Kd3jTE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 35ac7qmtbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Dec 2020 18:16:13 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Dec 2020 18:16:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpEd+aHJ8HSjfE08/1Py2iu0tFpd5xxxjkk742rl7BBmQKv8p7yUW1BI9okHomH2cV+pkefryiyNCU3YkYAoLyJVARmIcsEFcN8+PeKT8Q+qy/U4p245mtqgIrfTZEibK9pAiYPuLSyk/1XfNdOF4LE/047L+m/1oL2408Ak2D9fvvweG+AXSaXdR0sSDESd5ocqT+mrZuukwVYNndRJPIU5m2zxeJ06EGILOUssfst7q4Q97vaJY62dvwUu537dI2afNvO0oA3FeDf/VGvjkPCUz9UHYgfaZpCg8tR4YO3lTZny+nvBeakLShTin6pUBkIDC9m7JGETunEVnzh/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhnqrAFBOa2/XKepTtjeLDIUvh8d9fXUa51Uqkx9j+4=;
 b=Y/ur+77ZVBHbYV3yJPY0M8m110dt0zJldsTJAjPDaZa706oKxfsyn3Wi1IynCtXDhQX1RG0ZT0Ad/wOrPVo3+VK32/CEZ84vroWx3idcuQ9tzUrVZ3Lio5LmCcYxJLriSnk3FNP3dt4OEy3sVIb+nL+RWsFeq/WMncsReP9VO7U7rsJzFBcRcKveIMNBFPR5gdRJEBZKpEN5z2YyhhI3D9WFJ9Se+qBXLUWNnFoX1pifOnF3OnDiQf2nr9F6MN7o+xo+l/Wec2qHay8htuwcYgwh4oTRYCbFROEFchg5GhQ5KqeT0qG+P96//72ClxsZKWIluhwYXIaOXRtwji6x1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhnqrAFBOa2/XKepTtjeLDIUvh8d9fXUa51Uqkx9j+4=;
 b=YAfIrvLjb9n/O8LRslmo46C+ZdN2Gvor6bahc6YR5FvLgyG9PrYrdUBBj4l/ptJ6Nkc+q52K409649mGBK1VdMwsuDj1Dz4DOtirIoG0laWMpS4PU9yOk//aAMzxM89+Ff/jp/Qrti7ZSY/SJ6msViSqw9zMqOLyMsmmWnT7Tco=
Authentication-Results: iogearbox.net; dkim=none (message not signed)
 header.d=none;iogearbox.net; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB4118.namprd15.prod.outlook.com (2603:10b6:a02:bf::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Thu, 10 Dec
 2020 02:16:10 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Thu, 10 Dec 2020
 02:16:10 +0000
Subject: Re: [PATCH bpf-next] selftests/bpf: Drop the need for LLVM's llc
To:     Andrew Delgadillo <adelg@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20201209205301.2586678-1-adelg@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <dddc8f10-9757-b335-4bf1-1f19c00807c8@fb.com>
Date:   Wed, 9 Dec 2020 18:16:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201209205301.2586678-1-adelg@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:bc44]
X-ClientProxiedBy: BY5PR17CA0063.namprd17.prod.outlook.com
 (2603:10b6:a03:167::40) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::113f] (2620:10d:c090:400::5:bc44) by BY5PR17CA0063.namprd17.prod.outlook.com (2603:10b6:a03:167::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 02:16:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1660b1a1-ee3f-4b65-d07b-08d89cb18fb2
X-MS-TrafficTypeDiagnostic: BYAPR15MB4118:
X-Microsoft-Antispam-PRVS: <BYAPR15MB4118ED857863EFC65EB7EC31D3CB0@BYAPR15MB4118.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WL/nMGCjPW4mS8yxTkqpfpXoyal/FdKoEMQjUGrIxXgoD8nAfvfye022AuyykmGX0yz41s2lAaMfm5zETwmaI1DnnmbiW9N4RMGdmJSMpqRw0c39XS3fTUqq7VnTV56KMUYobwZtUEfD5hoR0jHy04zvNYEhvX4B2svlFidCgxpF1A2LXD5JOp7970w4BxNNMDri9FMry8352TPFKAXH7Vp1ZwfBOzS1leUjvngrPOP18G+Rb8devo8XdLunBq4Pp31Bz/abSuWtzcjzUVJ2+gK6WrlUyPHK2ROPQs7bQ304Et/prfgk9VK18Pu2b9ykPJEJsejPa7ibViI37h6chiXo/WPldQASGBk9XK/x89G/HgXDkr7lSTe/LFxKkkfOIHcaQ7nLrFk7rF992iknG0adC1YMi4XJqIRtIhax7XJd+qjAwU9Y0V3SaRP2SsMdam0w7p1kYlue/zkGCWqhbBJ7ARULdtIEDdJgX+IEPIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(86362001)(52116002)(8676002)(31696002)(16526019)(966005)(53546011)(508600001)(54906003)(31686004)(4326008)(36756003)(186003)(6486002)(2906002)(66476007)(66946007)(83380400001)(8936002)(5660300002)(2616005)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NEw4M1VXVVBYN2ZwOWg3OWFoQmxNSEQwNWdBWS9sckllNG1FbE5iRFNiSDlm?=
 =?utf-8?B?Y2M3c0gwUmxzbUZRRU5BNXhqZm1PWTlEWEU3OFlXME9xN080SkFpQXFvMGZN?=
 =?utf-8?B?NEJlU3pwV0lmbVo0WFA4bGdUSURVbk50Njg2N29TMEdVb2FiTHNsZTFQVDVD?=
 =?utf-8?B?bUR0UUxSR2w5emhUcy9JakE3eXJGd0NEYXRFb1hIWnJ4aEEwd1B6TEk0U0RX?=
 =?utf-8?B?MkJRTDNlWmttc3cwOVpqL3M5UXZyM2Irc1JsOHJCYld0T0oxbnJ6bHVLTVJp?=
 =?utf-8?B?bGs5QTNQTHRyY2hNaGZHbmZrU2YzTlArNldyYjUvclhGbFRjbXMwL0RJVy9U?=
 =?utf-8?B?S3A5dUZzVlVwVFY1Qzc5bVV1UnVDUEYvVitpMmx5Z0t6M0NTT0RFQTZtc2hv?=
 =?utf-8?B?cmV2c0EzVGRUdEwrUC9RYitlRDM5YkE1aTMzN0p5Zk1nbkl2UUIrdG9GOGZt?=
 =?utf-8?B?ZFFtcjdOVkJIaC9pMmJTT3RKNlVocHpzcnI5VmZBNGxvV1hVWm1tS2YvWnhW?=
 =?utf-8?B?cWpSQnN6ZkVaWlViVlN1c25oRytjbTZCSFF5R3BwVlRKRjRRLzFmTTdWTWNh?=
 =?utf-8?B?SGFSWHpzNE8xdmw4Y1FXZ3lCcEhSMzd6U1J2UlZTb09NbTVDcVg4bTBuRjZE?=
 =?utf-8?B?cXJTcDZDVGJiR3VlQWUwN1h6cm12L25NZHV6Y3VuWGJ6ZHg5d05hZUloQVUr?=
 =?utf-8?B?N2RIN25NZ3NKSkx5YXdzWFloY0MvV0hIdFd0TTl6cWgyOEdiWDhzN2VRTGQz?=
 =?utf-8?B?UzJLTDk0a0kzLzhhYmlWVGxLVWtXQ2xLVkVSM3c3ekhzNGJYRDJlWkdINEln?=
 =?utf-8?B?M3lmd2pvWmc0Y3RxNzBYZzJIYmFIQ1pVS2RremxtY1ZUMUMxaWJWaGtYV0ZT?=
 =?utf-8?B?OEZzWXZ0WktwWm5kRlRMZFVBL1F0N0dGN3pCTHZsR1ZtbldrcmFBOUNkTFEv?=
 =?utf-8?B?NlBhUnZzSHJXd3ljdmJwTWVMVm9ZdEkxd283VC8yRDVMbXdIdi9aaGJKVm5n?=
 =?utf-8?B?cWFYYzZ3VGc5SUh3K0o3L2VYN3o2blpqeWYzRTZkWjR4V1lvTFZVd1hQVW96?=
 =?utf-8?B?T0IwV0k0MEVqeXZiNUZyWnlFNm5ITW9sZjdJaXY1VVc3MnoyN3p6REJDZ2Rx?=
 =?utf-8?B?MTZCNHRjcy90RkpMM3NqSWNmTFdrY3UvQWdZQUxjdzZ5SHNPQWYvNHMzTHBO?=
 =?utf-8?B?S1AzYndNcFJGT3BObGlYM3RuTzUwT1ZiZkVrdXRSYUVQcC9DNXNXZ2dWSnI4?=
 =?utf-8?B?SU5mSmxjNVJoUENNNm5BRGtLNVVneUdGK0hrZEtKSGFCaGU3cklUd2xDQXNk?=
 =?utf-8?B?aDQwbGtVamIxRWZHRlRlNFY2dXF1cllRRSt0RFV2TFpyYXE4KzFuc3M4Ty9S?=
 =?utf-8?B?ZnZHeUV5dVRnQ0E9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 02:16:10.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 1660b1a1-ee3f-4b65-d07b-08d89cb18fb2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqjG1mnT3GH4Y/VGWc2H6GzmVGd40KUe54BwvtwAljBKrmOHmqPbfptCVvVUNrEs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4118
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_19:2020-12-09,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100015
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/9/20 12:53 PM, Andrew Delgadillo wrote:
> LLC is meant for compiler development and debugging. Consequently, it
> exposes many low level options about its backend. To avoid future bugs
> introduced by using the raw LLC tool, use clang directly so that all
> appropriate options are passed to the back end.

Agree that this indeed make build system simpler.

> 
> Additionally, the native clang build rule was not being use in the
> selftests Makefile, so remove it.

This is true too. Otherwise, native clang build will require both
clang and llc runs.

The patch looks good and I have a few comments and hopefully
you can accommodate.

> 
> Signed-off-by: Andrew Delgadillo <adelg@google.com>
> ---
>   tools/testing/selftests/bpf/Makefile | 20 ++++----------------
>   1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 944ae17a39ed..74870d365b62 100644
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
>   define CLANG_BPF_BUILD_RULE
> -	$(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
> -	$(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm			\
> -		-c $1 -o - || echo "BPF obj compilation failed") | 	\
> -	$(LLC) -mattr=dwarfris -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
> +	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
> +	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -o $2 -Xclang -target-feature -Xclang +dwarfris -mcpu=v3 $4

Yes, we still use +dwarfris here.
The original llvm patch which introduded +dwarfris is:
 
https://github.com/llvm/llvm-project/commit/03e1c8b8f9cc7b898217b7789d3887a903443c93
it is to workaround an elfutils/libdw issue as it does not support bpf 
backend so pahole cannot display debuginfo structures properly.
Subsequently, the elfutils/libdw bpf support is added at
 
https://sourceware.org/git/?p=elfutils.git;a=commitdiff;h=c1990d36cfe37a30bcc49422c37a6767fd190559

Any recent pahole should already build with the above fix.
I tested with pahole 1.16 it works fine for binaries built without
+dwarfris. Also BTF now can be used to dump structures.

So could you also accommodate the change to remove +dwarfris option?


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
>   endef
>   # Build BPF object using GCC
>   define GCC_BPF_BUILD_RULE
> @@ -402,7 +390,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
>   		       $(wildcard progs/btf_dump_test_case_*.c)
>   TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
>   TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
> -TRUNNER_BPF_LDFLAGS := -mattr=+alu32
> +TRUNNER_BPF_LDFLAGS := -Xclang -target-feature -Xclang +alu32

The +alu32 is only used for non-alu32 case where -mcpu=v3 actually 
implies alu32. So let us remove TRUNNER_BPF_LDFLAGS flag from Makefile too.

>   $(eval $(call DEFINE_TEST_RUNNER,test_progs))
>   
>   # Define test_progs-no_alu32 test runner.
> 
