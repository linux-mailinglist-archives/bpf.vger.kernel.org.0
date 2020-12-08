Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399712D2163
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 04:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgLHDUN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 22:20:13 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30652 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727037AbgLHDUN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Dec 2020 22:20:13 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B83AZx2018533;
        Mon, 7 Dec 2020 19:19:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=7IM57sWt05CdhrpvYla4q6VzUgEPAofhtX/8EnspQQA=;
 b=BR96Ry825WzW0XckMy80QOiXF7vz5I5NOP8FSIbByNxqBBRMUkjbzQUNkMWUotnTHCQh
 dIlCUI1/XcSoo1SIykYNrrsRQWK5D3406w8JmqOgBwF3SW97E63u2b4oclSmxMz3oLoM
 Yq+RC97DYHbGhPZbcBzeIgalEDUu8WAxZYc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3588ktx5qx-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Dec 2020 19:19:16 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 19:19:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elYHSin9wczQaBqdZuSBXjHiOMVroSDzllnqmpxkeVlxlKqTZ0TUiNCWvDAlWEyUYoh0gVXNATMYYWrE5iox3hZPHpZDjPSonPWsrsR623oZ+t8+244ypHVfGuKvLNoT+BV6vRLa7SFRxLK7qMZjmncN5Qes2nMY4a832MQ5jpkelwTa+5dZdaco17lWyKCbfC/7Zh6n2WOnZRz1jCfqJXqdw0VZH+3Kbz0GElyA/hsbE+NONrvNhTR1bcOEuzikB3RAYephpvxtqJqkExN/1D1lNyP5mcSaEL5aFyJFq+BIopMDNSCUhQfhBCF41Ga1qYAZ398ui+gMH4bAT6VBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llWD5eWnwG+/KFjMab4a0eQQKousje0qg//wP+e/128=;
 b=dFUvLXpTq+XYSZSdVEK6LVBxPNmOr52KjI4MQjOcc1yXtpG2S0DXaZE+OMEeAhreRYwbpU5efNOLPrSRmdbNcji5QRximhM2do6EmmVw62Yzxpu+OIimDLnZo13bM7G66p+rUXPf7jLJzZEXRM5zVANLeN90ci5tAIe4MfJUkysXG80X19nWF9/nCFen6we8K7D7WKHXzhoQEb4WKnDahChw6oJxusDpKWeSk/l/1oFlpNmagqP1yoluvypI2CV4ZnhAiiMnauXWZF60W5SQoU6dVF3H68LRh4bTx1kvvplK5hVmdn5y1TGNk5pWuZHmd5ctIA+WBVOJ8ZgqKKegqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llWD5eWnwG+/KFjMab4a0eQQKousje0qg//wP+e/128=;
 b=RXHoDPOeP2MZSU5xh9HZY/HELYASyiSIXfyGGhzAT5+A8YfmLiHBuXdoMrBqAbpzfXfHAkq6mmKZL+c6DfCkHhGSrfJ8OTp+N91Oz1iUl3nLScLF9fY0zr5J5VbmgyFjt+4BV/cNsGTdkPEcf87paoqrBCwhHmQHJeUjZbfax1c=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3620.namprd15.prod.outlook.com (2603:10b6:a03:1f8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23; Tue, 8 Dec
 2020 03:19:00 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 03:19:00 +0000
Subject: Re: [PATCH bpf-next v4 10/11] bpf: Add tests for new BPF atomic
 operations
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-11-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3adb88d5-b8d8-9c15-a988-7c10f86686fd@fb.com>
Date:   Mon, 7 Dec 2020 19:18:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201207160734.2345502-11-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:4c73]
X-ClientProxiedBy: MW4PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:303:114::14) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::113f] (2620:10d:c090:400::5:4c73) by MW4PR03CA0369.namprd03.prod.outlook.com (2603:10b6:303:114::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Tue, 8 Dec 2020 03:18:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98ebc467-ac3d-40ab-0c3b-08d89b28021c
X-MS-TrafficTypeDiagnostic: BY5PR15MB3620:
X-Microsoft-Antispam-PRVS: <BY5PR15MB36201F5A8307C5778DCA751CD3CD0@BY5PR15MB3620.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: haM4k5DZ716Jeqc5dsgfBKpzPCwuthBB0ddRSc8NckUfjGyhXJJH+Y9stxvwadrqp7VKUiwjpcurBus/sBKm+XDZkOlAEFfGDPFmBuVhDDID2Y+HH5231e6tn6IyHftDd65MkkLu2Q1Wk00aY85twHl/ZXuQrX598qP8/9BDaXyOKUbamDQshMjY3GRE5d0THLLK7e4wOnd58etRSfWEbLKiea3XbJMPK/MBWH8jW/FWyWWZGUOWRl0++0FS8IFkJT8nc1Z3t0dbCalbQVI8Swhtoc+t/W3Lqw1TOjRqX3ZyuOwSBD4sJd5P8UGNajJCc9aivKTFnkRYg2kez7Uum9KGQK6BRvNQjfazgw8z2lij1AJZMVQBkjSYj6ZCtibE+fkdavNqO0EVlHcsobi2CTbFPMyc512j66lOSon1Y5vwFN//O1+txPh13RhAq4C0qaFzW5tYxucXPQMlnhqnQoeiiPRWAe6/oMMR4lod4k4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(376002)(39860400002)(366004)(66476007)(8676002)(53546011)(66946007)(4326008)(16526019)(66556008)(8936002)(2906002)(31686004)(52116002)(2616005)(186003)(54906003)(31696002)(478600001)(316002)(6486002)(966005)(83380400001)(36756003)(5660300002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RzlIWDJCSmUwVUNIelNoMGFFOVRzTXVwNUdaR0Z2R3BxbFFwaUJOVGJhVkFF?=
 =?utf-8?B?eHhPK084TVFUbVkzQm9MdDljeGkzZWVXYm96OGh0cHdSVUR6Um9NNlRzdGhI?=
 =?utf-8?B?V2RnR20vWnVVNHRiNVI2MjA4Tmh5Wk45a3FBcXJlRW1DRUhMNVVFZTk4ZGd2?=
 =?utf-8?B?YXhsNHdZYWhUYmlXWURaRWhvUjEwclp6cEQ0V29yU1BIcDRyYmtSbXY2eUpw?=
 =?utf-8?B?UVFFcEhHcTFZTGZ2aExUOGFVN1JsNHg1aUUrUGVSWWxJbGZuZ0JTRXQvR1BT?=
 =?utf-8?B?YTU4dndHd2xOL0NkMW5OTkJ1a1QrRk9CRDVkRTJhWThyeDNkMjExeE0vR24w?=
 =?utf-8?B?YmVoZmlUeVQ1R2JPUUJoVE9hQjNBS2ZsODJtcHNOOEFaQmR6Rm9WeU5QNmtN?=
 =?utf-8?B?OU1jVlFDOTM0cUhJTlk2aU44Q0ZHd2NjVERjZGdXbTE0M21wQXpLTFc1T04r?=
 =?utf-8?B?RnRrVjZWcjUydW5OOS84ZzJkYWNta0hqOGphYzl0aUJWcmpoTVdrOFdxQkMz?=
 =?utf-8?B?bjZzVFFmZG5kdzlNVWI2RVpCeElkSWNUdXowNExkdDhnaVdWbmU5dm9QaGpV?=
 =?utf-8?B?Q2NWNGFkYmhPR3hGQlVucWdwdVgvTVhjK3NqMk9kSzBtRE9JNUh0bHZZSU1x?=
 =?utf-8?B?aTVIbldaWG1yZHlxOHFuQlhtR0xOZ3VxSC9jZ2k4b3lDZHdKVjkxK09Dd0pk?=
 =?utf-8?B?TTBsZDNkc2hKOFMvaSs4eVhmZm92TjFUTTNRelk1L2pTRC85RExrYU9vK1I1?=
 =?utf-8?B?U29oaUY1eHZLSG14MDcydG5CWXl3L2tzcTQzQURGZkRZdmgyZkFrTHNpdHlP?=
 =?utf-8?B?ZFc3NVQ1Vk5qbVp5WDdBN1hGcFRHM0wrcHVMbXJtZVd5RUR2bFR3VEJuQ0xS?=
 =?utf-8?B?N05scWF5dkJrYTdlQ0tHdy81VUJ1YWE0TUUrUnJHT29xUlZyZmcyT3UreXA2?=
 =?utf-8?B?K3Z5VDlSaDMzY2s1UTRZZjFja09RUTFrRVBhZXFqZGwxaFp4WTIxVXVrb0hl?=
 =?utf-8?B?T0Uxc1NQZW1HblVXalhIbWNtTzMzMU80dGozNFBwUFEwdGVmYmRwc3FKSlh4?=
 =?utf-8?B?UjZaVGQ4VC9pOHR2V0Z0MTBrMThYSG9CbjYvT1VUU2dtVWtNSjNDaXloREcw?=
 =?utf-8?B?N2U3L3BMNHhUQVBYMWkyY0FGREszRXc0TnRKQTMzbE9uN2FWM2Z5YlVBQ2Fu?=
 =?utf-8?B?SW9iNFYxU0YvY0xrWmVnZTRXajR6bGtPUWovc0RCcnNDK2Y5WHNmNEN5N09h?=
 =?utf-8?B?c0p4dCtqbzhaSFZncDZZdTN0VFpPS0R1emF2SFhIdDRCVDJ4Y2JvZnExMW9x?=
 =?utf-8?B?Y0R1NmxCdU5qWUN3cHljdzZ2REVHRnVobkhUd3pVSFh0Ulh0TFI1emJqOFR0?=
 =?utf-8?B?YjNBRmQ3OXZ1Nmc9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 03:19:00.8375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ebc467-ac3d-40ab-0c3b-08d89b28021c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVF/5YGawrHu+PA/UvJp+oaV9DWklKR+PR5C2iltFkYOorj7xa3d6RnbHjuMYexR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3620
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_19:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/7/20 8:07 AM, Brendan Jackman wrote:
> The prog_test that's added depends on Clang/LLVM features added by
> Yonghong in commit 286daafd6512 (was https://reviews.llvm.org/D72184 ).
> 
> Note the use of a define called ENABLE_ATOMICS_TESTS: this is used
> to:
> 
>   - Avoid breaking the build for people on old versions of Clang
>   - Avoid needing separate lists of test objects for no_alu32, where
>     atomics are not supported even if Clang has the feature.
> 
> The atomics_test.o BPF object is built unconditionally both for
> test_progs and test_progs-no_alu32. For test_progs, if Clang supports
> atomics, ENABLE_ATOMICS_TESTS is defined, so it includes the proper
> test code. Otherwise, progs and global vars are defined anyway, as
> stubs; this means that the skeleton user code still builds.
> 
> The atomics_test.o userspace object is built once and used for both
> test_progs and test_progs-no_alu32. A variable called skip_tests is
> defined in the BPF object's data section, which tells the userspace
> object whether to skip the atomics test.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Ack with minor comments below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/testing/selftests/bpf/Makefile          |  10 +
>   .../selftests/bpf/prog_tests/atomics.c        | 246 ++++++++++++++++++
>   tools/testing/selftests/bpf/progs/atomics.c   | 154 +++++++++++
>   .../selftests/bpf/verifier/atomic_and.c       |  77 ++++++
>   .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++++
>   .../selftests/bpf/verifier/atomic_fetch_add.c | 106 ++++++++
>   .../selftests/bpf/verifier/atomic_or.c        |  77 ++++++
>   .../selftests/bpf/verifier/atomic_xchg.c      |  46 ++++
>   .../selftests/bpf/verifier/atomic_xor.c       |  77 ++++++
>   9 files changed, 889 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics.c
>   create mode 100644 tools/testing/selftests/bpf/progs/atomics.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index ac25ba5d0d6c..13bc1d736164 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -239,6 +239,12 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 			\
>   	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
>   	     -I$(abspath $(OUTPUT)/../usr/include)
>   
> +# BPF atomics support was added to Clang in llvm-project commit 286daafd6512
> +# (release 12.0.0).
> +BPF_ATOMICS_SUPPORTED = $(shell \
> +	echo "int x = 0; int foo(void) { return __sync_val_compare_and_swap(&x, 1, 2); }" \
> +	| $(CLANG) -x cpp-output -S -target bpf -mcpu=v3 - -o /dev/null && echo 1 || echo 0)

'-x c' here more intuitive?

> +
>   CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
>   	       -Wno-compare-distinct-pointer-types
>   
> @@ -399,11 +405,15 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
>   		       $(wildcard progs/btf_dump_test_case_*.c)
>   TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
>   TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
> +ifeq ($(BPF_ATOMICS_SUPPORTED),1)
> +  TRUNNER_BPF_CFLAGS += -DENABLE_ATOMICS_TESTS
> +endif
>   TRUNNER_BPF_LDFLAGS := -mattr=+alu32
>   $(eval $(call DEFINE_TEST_RUNNER,test_progs))
>   
>   # Define test_progs-no_alu32 test runner.
>   TRUNNER_BPF_BUILD_RULE := CLANG_NOALU32_BPF_BUILD_RULE
> +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
>   TRUNNER_BPF_LDFLAGS :=
>   $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
>   
> diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/tools/testing/selftests/bpf/prog_tests/atomics.c
> new file mode 100644
> index 000000000000..c841a3abc2f7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
> @@ -0,0 +1,246 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +
> +#include "atomics.skel.h"
> +
> +static void test_add(struct atomics *skel)
> +{
> +	int err, prog_fd;
> +	__u32 duration = 0, retval;
> +	struct bpf_link *link;
> +
> +	link = bpf_program__attach(skel->progs.add);
> +	if (CHECK(IS_ERR(link), "attach(add)", "err: %ld\n", PTR_ERR(link)))
> +		return;
> +
> +	prog_fd = bpf_program__fd(skel->progs.add);
> +	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
> +				NULL, NULL, &retval, &duration);
> +	if (CHECK(err || retval, "test_run add",
> +		  "err %d errno %d retval %d duration %d\n", err, errno, retval, duration))
> +		goto cleanup;
> +
> +	ASSERT_EQ(skel->data->add64_value, 3, "add64_value");
> +	ASSERT_EQ(skel->bss->add64_result, 1, "add64_result");
> +
> +	ASSERT_EQ(skel->data->add32_value, 3, "add32_value");
> +	ASSERT_EQ(skel->bss->add32_result, 1, "add32_result");
> +
> +	ASSERT_EQ(skel->bss->add_stack_value_copy, 3, "add_stack_value");
> +	ASSERT_EQ(skel->bss->add_stack_result, 1, "add_stack_result");
> +
> +	ASSERT_EQ(skel->data->add_noreturn_value, 3, "add_noreturn_value");
> +
> +cleanup:
> +	bpf_link__destroy(link);
> +}
> +
[...]
> +
> +__u64 xchg64_value = 1;
> +__u64 xchg64_result = 0;
> +__u32 xchg32_value = 1;
> +__u32 xchg32_result = 0;
> +
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(xchg, int a)
> +{
> +#ifdef ENABLE_ATOMICS_TESTS
> +	__u64 val64 = 2;
> +	__u32 val32 = 2;
> +
> +	__atomic_exchange(&xchg64_value, &val64, &xchg64_result, __ATOMIC_RELAXED);
> +	__atomic_exchange(&xchg32_value, &val32, &xchg32_result, __ATOMIC_RELAXED);

Interesting to see this also works. I guess we probably won't advertise 
this, right? Currently for LLVM, the memory ordering parameter is ignored.

> +#endif
> +
> +	return 0;
> +}
[...]
