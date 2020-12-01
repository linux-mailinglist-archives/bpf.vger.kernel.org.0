Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AABF2C961D
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 04:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgLAD4G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Nov 2020 22:56:06 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27896 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbgLAD4G (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Nov 2020 22:56:06 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B13kwPk015811;
        Mon, 30 Nov 2020 19:55:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=YU4zfJ1vwtMHvuFAyZXMIxBuVBga2ezrBzwirK93HEs=;
 b=RtQSmkMbwJjLDS1PApmK5o9Xt7qB8k2zNjFwXR64atE8z43aQlGGpGZnEBuprFANTV6e
 ZWUDl6an9oqJemxVvUFY1jy8at3VfHYO/kckNg1rmRwi7aXhOot0ohOUmulVVOeYsQbR
 RoGuAbwFZKA8AKkpd1EVqbYiawoWeVUBIHQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 354d4g8ck7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 19:55:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 19:55:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dw5NnHvybVmwZDgm7kbUPQ1caPoFOi2CT9B2onkjb+kGh4yoVvfxT0gNb8DV5xHfFDUqhc1xq713BbLOr5VY6OW56bNAOxmW6NMFUtGQhar2VDlRwG29mb2CkwK2clI0gJzAIHRD5+eqA6ZAAitGPkMGWa1P3/xyXvrr75Xz+WuZlw4cWvDOdBGAQXOjyxWiWr2uDFXyqNBtgeLmbJyKWTUgdsLGhfeFnag4PkIBo3TPlC7S116sLjZM7H391zI2y9O+40tzF0gtIlvC9CQ2QSZIU2aS/7a55uJoYORfV43BxJciFuReIfk1BhW7GeqAa7CnIDCbtWbX1Pm40UqVqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT+XTBuck2XokF1OKP6qV/S4FRjf8bQ9SrBz4L8r1LI=;
 b=FMYdvK0j9vYpYRWE+tEe+NegHGqmhyCB1EWiQmjtZ97s4YfFRTajpEmtNWwK7P+KnFBMXoVnsVVG7JJNKRWEVfEl3YZyb0KMmiqZ4KHHX9tHl/dN+5lIWC7kWQpgAdQZcgc+OvgqvwX4IU+3XtfgCEkPPKeIQEE8A8M/QqgWCPf4zNVWDM8q3Cgzy8emeppSlPVN0mw8UupXpvpIgSrfxDf7VyniIhTnnXBJKFlG/ymLellzd3ej4X6m1EEpCw2Bs3oGuhrJUoz+B1KsI96bbq9oS1y25f3Xj++BBh2LsimfKsYnChF2e2Pl7cdJUzYbbQVhnPU4bA1xpUx8CME8dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT+XTBuck2XokF1OKP6qV/S4FRjf8bQ9SrBz4L8r1LI=;
 b=QzE9SksQhP8R5TqhiaLpb3wIpKoc0s9yn07PaoeYQZiYIuu8MTgZIHx4rRHmfN9a/kPZYuR0KJhEUd35S/zYbKJOrBeBQgbP2Jf7/Y304W2iIf7eUqbDzeubNYVTvCVzvV6MBBcqneQ34zKv49cB7VTsCLaomAw/e8VqphnhTE0=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3415.namprd15.prod.outlook.com (2603:10b6:a03:112::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Tue, 1 Dec
 2020 03:55:05 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Tue, 1 Dec 2020
 03:55:04 +0000
Subject: Re: [PATCH v2 bpf-next 12/13] bpf: Add tests for new BPF atomic
 operations
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-13-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <1e1656a9-6f0e-f17e-176c-37d996641e9a@fb.com>
Date:   Mon, 30 Nov 2020 19:55:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <20201127175738.1085417-13-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:d184]
X-ClientProxiedBy: MW4PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:303:8d::34) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1841] (2620:10d:c090:400::5:d184) by MW4PR03CA0179.namprd03.prod.outlook.com (2603:10b6:303:8d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend Transport; Tue, 1 Dec 2020 03:55:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08d02d13-e8b0-4b5e-63a7-08d895ace2ed
X-MS-TrafficTypeDiagnostic: BYAPR15MB3415:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3415F39B340AC47A0556F868D3F40@BYAPR15MB3415.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvpIgk1tnt7/Z3wSG/R7kgziInXiiJGESmxFIIh+dufSk6fb2juX2J5XujyHB/KQ+HR8OrHDfQ/Vgk4nxhQSGDBqhCniv4q+JX8vpkJvcM5sgwWjTGHl8lCRdRjPvLBKeuQ6S7LQ4X58Eqpelx10jIHrsFqq3avxKC9rBd4YCTn74PsqDd7WURruRzs3YfntVn3lOKgoV5XHJ2oIe9D485lJ+W+CoCpVN5C2Jzy0jHp5HklHjxG7D3FyFA8fVLrIBLcfVkWJn64/T1wwfPQ7orAscJQoIpReoRvVddoT1obwSyOrm8d3P6MUDDhieBYH1qts43BQX0yFNUxF09Yi5YUiylaAdBjMdIFYz10wqOTPG2KrwAD1VXT2fKFcCou3l13xl8UNstzUBHHaFgIxpXNHgJfy7S5hDbIb9R4b1nrAI22OYfLZjuzMhlmfUzkoWtBuPhiqggKEqZF+SF3HhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(366004)(136003)(66946007)(53546011)(83380400001)(66574015)(66476007)(36756003)(86362001)(5660300002)(316002)(2616005)(4326008)(8676002)(66556008)(966005)(6486002)(54906003)(478600001)(16526019)(31686004)(31696002)(186003)(2906002)(8936002)(52116002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L1pZOVEyUlZNbWVWQkw5NGRhWXpDQ1VqUDBZaVJDSUZ3RzlycEVQemRjMkdR?=
 =?utf-8?B?Mm5SWHg1ZWlBZmpWbFN2SkQ4SVp4QUlydEZYaGNIZXVQa2RVMW5mZVhaY2tv?=
 =?utf-8?B?M3JQeHdZMjhWaExSNXpOd2g4NHZRRFgzbmdrOGs3VEY5UHVBdGxIelgzK3My?=
 =?utf-8?B?d2tpMzNQSVhSWDIzL3o0RlhudHVERDRwYll1dHhvZ1poaU55ekQ1cnExYi9N?=
 =?utf-8?B?V0FPVDFHKzZMR1h1OFVUaFI4VDBFQndBKzJrMjY4RHFFblpsdy9PQjNDOTg5?=
 =?utf-8?B?cUwyalAwbnlwSEpxNDJyS1N3d01nY1BqMjFJZFB5Z1pGdWkvR243Y1NkNTQ2?=
 =?utf-8?B?OHRYdVFSN1lURmVtTmZ0TUF3T0xGOU11SWhDM0VuUXRGaXVoQzFuUjRNUzR2?=
 =?utf-8?B?akhubUFCV09uSUlsVHhPdzh5VEhnVXBkYW56ZThZWlZwM3ZLVDVWWXl1MDdO?=
 =?utf-8?B?K2dOSDZldUd1S3RaWE1xMlZCVFM4R2EyV3VhMHc0Q1A3SUQxcXRFcE1Pa0lD?=
 =?utf-8?B?YlVoL1krSHdxL0JXYlJYMndVMHFabjRocDdDcVN1TWtpbzE3b294bWVkWVpN?=
 =?utf-8?B?QXQvQ2ZQZTFxMUpsamRsTlcrSkJLQk5OcFE4TXNuY2JYcHlFRllGYXllSVJV?=
 =?utf-8?B?aTlMMzk4dlhRWWNKblFrcTJrUXQyV09qeVRHNGJaNkFqK1pYZXN3MFliaDcv?=
 =?utf-8?B?NEdRNlk5R0lDcXRLOUtUaG1kQ21kMkk5Y0FFOFdBYXRZSStGK1dZcmQzV1lW?=
 =?utf-8?B?WGRzdk9nR2lrZkRtTDg4cWtuY0lmL0M5TmUrU0psQUpyVXBjeGp0VSs4UjM0?=
 =?utf-8?B?ZHgySHdoVktuSEtvWWpFelJ4dWJtVGdNUVpXMDJHYjd3ekFuWXF6Zml4Y24r?=
 =?utf-8?B?VW1GUnlIU2MrY2ZPL1kvV0xhMEZQR09YZzNCM1JjUjltc0pXbTNTMmhxOUN5?=
 =?utf-8?B?dFBzVFJwVk44NTVTY05xcHdIYnM0Q1F2cis5OGFHeURwWFQxS0FqZGFWeGlp?=
 =?utf-8?B?aVYrWFFxRk1mZHNqRmVjcXQ2SmY1RUZJV2lCdVY5cFdnY01iUzdBeVhlMWxC?=
 =?utf-8?B?dTMxVmIvSDVZUVFseXRHQ3FBYSttRE5kMlRaMm9YVG8rNGdNVFdXN0JtQkxw?=
 =?utf-8?B?eUVsRm5LUlBRaXZ3UmdFanJPeG1LNHN1Y2hPQk9ZUndQSWw4RmtEMW1Rajc0?=
 =?utf-8?B?MUkyZXZJdzJIak1XZFB4cFU1SHhidk9DYjFhd0ozQzFGTlFpeXhyNDZaQjEv?=
 =?utf-8?B?ajZVZXNtK2JOajJnSGFEeHdscVRoRDl4SG5qVG5ET0JTcEVtemdmcVpHWXF2?=
 =?utf-8?B?YlVEL3VXSHIrZUZqcmdiREVxV2F5RGlaMEo5VU9BdlFrb1lGTm9ZUSt5eEMw?=
 =?utf-8?B?ZXVlN3NMV2JqU2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d02d13-e8b0-4b5e-63a7-08d895ace2ed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 03:55:04.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1YPy32I2u3ca7n1xf83XqsyLxKWpYEr1KbD+th/sgFCGOpiLi5RR6FTcKOEiDuT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3415
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_12:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/27/20 9:57 AM, Brendan Jackman wrote:
> This relies on the work done by Yonghong Song in
> https://reviews.llvm.org/D72184
> 
> Note the hackery in the Makefile that is necessary to avoid breaking
> tests for people who haven't yet got a version of Clang supporting
> V4. It seems like this hackery ought to be confined to
> tools/build/feature - I tried implementing that and found that it
> ballooned into an explosion of nightmares at the top of
> tools/testing/selftests/bpf/Makefile without actually improving the
> clarity of the CLANG_BPF_BUILD_RULE code at all. Hence the simple
> $(shell) call...
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   tools/testing/selftests/bpf/Makefile          |  12 +-
>   .../selftests/bpf/prog_tests/atomics_test.c   | 329 ++++++++++++++++++
>   .../selftests/bpf/progs/atomics_test.c        | 124 +++++++
>   .../selftests/bpf/verifier/atomic_and.c       |  77 ++++
>   .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++
>   .../selftests/bpf/verifier/atomic_fetch_add.c | 106 ++++++
>   .../selftests/bpf/verifier/atomic_or.c        |  77 ++++
>   .../selftests/bpf/verifier/atomic_sub.c       |  44 +++
>   .../selftests/bpf/verifier/atomic_xchg.c      |  46 +++
>   .../selftests/bpf/verifier/atomic_xor.c       |  77 ++++
>   tools/testing/selftests/bpf/verifier/ctx.c    |   2 +-
>   11 files changed, 987 insertions(+), 3 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics_test.c
>   create mode 100644 tools/testing/selftests/bpf/progs/atomics_test.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_sub.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 3d5940cd110d..5eadfd09037d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -228,6 +228,12 @@ IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
>   			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
>   MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
>   
> +# Determine if Clang supports BPF arch v4, and therefore atomics.
> +CLANG_SUPPORTS_V4=$(if $(findstring v4,$(shell $(CLANG) --target=bpf -mcpu=? 2>&1)),true,)
> +ifeq ($(CLANG_SUPPORTS_V4),true)
> +	CFLAGS += -DENABLE_ATOMICS_TESTS
> +endif
> +
>   CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
>   BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 			\
>   	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
> @@ -250,7 +256,9 @@ define CLANG_BPF_BUILD_RULE
>   	$(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
>   	$(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm			\
>   		-c $1 -o - || echo "BPF obj compilation failed") | 	\
> -	$(LLC) -mattr=dwarfris -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
> +	$(LLC) -mattr=dwarfris -march=bpf				\
> +		-mcpu=$(if $(CLANG_SUPPORTS_V4),v4,v3)			\
> +		$4 -filetype=obj -o $2
>   endef
>   # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
>   define CLANG_NOALU32_BPF_BUILD_RULE
> @@ -391,7 +399,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
>   TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
>   		       $(wildcard progs/btf_dump_test_case_*.c)
>   TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
> -TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
> +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) $(if $(CLANG_SUPPORTS_V4),-DENABLE_ATOMICS_TESTS,)

If the compiler indeed supports cpu v4 (i.e., atomic insns), 
-DENABLE_ATOMICS_TESTS will be added to TRUNNER_BPF_FLAGS and
eventually -DENABLE_ATOMICS_TESTS is also available for
no-alu32 test and this will cause compilation error.

I did the following hack to workaround the issue, i.e., only adds
the definition to default (alu32) test run.

index 5eadfd09037d..3d1320fd93eb 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -230,9 +230,6 @@ MENDIAN=$(if 
$(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)

  # Determine if Clang supports BPF arch v4, and therefore atomics.
  CLANG_SUPPORTS_V4=$(if $(findstring v4,$(shell $(CLANG) --target=bpf 
-mcpu=? 2>&1)),true,)
-ifeq ($(CLANG_SUPPORTS_V4),true)
-       CFLAGS += -DENABLE_ATOMICS_TESTS
-endif

  CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
  BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)                  \
@@ -255,6 +252,7 @@ $(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
  define CLANG_BPF_BUILD_RULE
         $(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
         $(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm                     \
+               $(if $(CLANG_SUPPORTS_V4),-DENABLE_ATOMICS_TESTS,)      \
                 -c $1 -o - || echo "BPF obj compilation failed") |      \
         $(LLC) -mattr=dwarfris -march=bpf                               \
                 -mcpu=$(if $(CLANG_SUPPORTS_V4),v4,v3)                  \
@@ -399,7 +397,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c 
cgroup_helpers.c trace_helpers.c      \
  TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read                          \
                        $(wildcard progs/btf_dump_test_case_*.c)
  TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
-TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) $(if 
$(CLANG_SUPPORTS_V4),-DENABLE_ATOMICS_TESTS,)
+TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
  TRUNNER_BPF_LDFLAGS := -mattr=+alu32
  $(eval $(call DEFINE_TEST_RUNNER,test_progs))


>   TRUNNER_BPF_LDFLAGS := -mattr=+alu32
>   $(eval $(call DEFINE_TEST_RUNNER,test_progs))
>   
> diff --git a/tools/testing/selftests/bpf/prog_tests/atomics_test.c b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
> new file mode 100644
> index 000000000000..8ecc0392fdf9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +
> +#ifdef ENABLE_ATOMICS_TESTS
> +
> +#include "atomics_test.skel.h"
> +
> +static void test_add(void)
[...]
> +
> +#endif /* ENABLE_ATOMICS_TESTS */
> diff --git a/tools/testing/selftests/bpf/progs/atomics_test.c b/tools/testing/selftests/bpf/progs/atomics_test.c
> new file mode 100644
> index 000000000000..3139b00937e5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/atomics_test.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#ifdef ENABLE_ATOMICS_TESTS
> +
> +__u64 add64_value = 1;
> +__u64 add64_result = 0;
> +__u32 add32_value = 1;
> +__u32 add32_result = 0;
> +__u64 add_stack_value_copy = 0;
> +__u64 add_stack_result = 0;
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(add, int a)
> +{
> +	__u64 add_stack_value = 1;
> +
> +	add64_result = __sync_fetch_and_add(&add64_value, 2);
> +	add32_result = __sync_fetch_and_add(&add32_value, 2);
> +	add_stack_result = __sync_fetch_and_add(&add_stack_value, 2);
> +	add_stack_value_copy = add_stack_value;
> +
> +	return 0;
> +}
> +
> +__s64 sub64_value = 1;
> +__s64 sub64_result = 0;
> +__s32 sub32_value = 1;
> +__s32 sub32_result = 0;
> +__s64 sub_stack_value_copy = 0;
> +__s64 sub_stack_result = 0;
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(sub, int a)
> +{
> +	__u64 sub_stack_value = 1;
> +
> +	sub64_result = __sync_fetch_and_sub(&sub64_value, 2);
> +	sub32_result = __sync_fetch_and_sub(&sub32_value, 2);
> +	sub_stack_result = __sync_fetch_and_sub(&sub_stack_value, 2);
> +	sub_stack_value_copy = sub_stack_value;
> +
> +	return 0;
> +}
> +
> +__u64 and64_value = (0x110ull << 32);
> +__u64 and64_result = 0;
> +__u32 and32_value = 0x110;
> +__u32 and32_result = 0;
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(and, int a)
> +{
> +
> +	and64_result = __sync_fetch_and_and(&and64_value, 0x011ull << 32);
> +	and32_result = __sync_fetch_and_and(&and32_value, 0x011);
> +
> +	return 0;
> +}
> +
> +__u64 or64_value = (0x110ull << 32);
> +__u64 or64_result = 0;
> +__u32 or32_value = 0x110;
> +__u32 or32_result = 0;
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(or, int a)
> +{
> +	or64_result = __sync_fetch_and_or(&or64_value, 0x011ull << 32);
> +	or32_result = __sync_fetch_and_or(&or32_value, 0x011);
> +
> +	return 0;
> +}
> +
> +__u64 xor64_value = (0x110ull << 32);
> +__u64 xor64_result = 0;
> +__u32 xor32_value = 0x110;
> +__u32 xor32_result = 0;
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(xor, int a)
> +{
> +	xor64_result = __sync_fetch_and_xor(&xor64_value, 0x011ull << 32);
> +	xor32_result = __sync_fetch_and_xor(&xor32_value, 0x011);
> +
> +	return 0;
> +}

All above __sync_fetch_and_{add, sub, and, or, xor} produces a return
value used later. To test atomic_<op> instructions, it will be good if
you can add some tests which ignores the return value.

> +
> +__u64 cmpxchg64_value = 1;
> +__u64 cmpxchg64_result_fail = 0;
> +__u64 cmpxchg64_result_succeed = 0;
> +__u32 cmpxchg32_value = 1;
> +__u32 cmpxchg32_result_fail = 0;
> +__u32 cmpxchg32_result_succeed = 0;
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(cmpxchg, int a)
> +{
> +	cmpxchg64_result_fail = __sync_val_compare_and_swap(
> +		&cmpxchg64_value, 0, 3);
> +	cmpxchg64_result_succeed = __sync_val_compare_and_swap(
> +		&cmpxchg64_value, 1, 2);
> +
> +	cmpxchg32_result_fail = __sync_val_compare_and_swap(
> +		&cmpxchg32_value, 0, 3);
> +	cmpxchg32_result_succeed = __sync_val_compare_and_swap(
> +		&cmpxchg32_value, 1, 2);
> +
> +	return 0;
> +}
> +
> +__u64 xchg64_value = 1;
> +__u64 xchg64_result = 0;
> +__u32 xchg32_value = 1;
> +__u32 xchg32_result = 0;
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(xchg, int a)
> +{
> +	__u64 val64 = 2;
> +	__u32 val32 = 2;
> +
> +	__atomic_exchange(&xchg64_value, &val64, &xchg64_result, __ATOMIC_RELAXED);
> +	__atomic_exchange(&xchg32_value, &val32, &xchg32_result, __ATOMIC_RELAXED);
> +
> +	return 0;
> +}
> +
> +#endif /* ENABLE_ATOMICS_TESTS */
[...]
