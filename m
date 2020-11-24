Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6811B2C19F4
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 01:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgKXA1M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 19:27:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21852 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729299AbgKXA1L (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Nov 2020 19:27:11 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AO0AmoY008577;
        Mon, 23 Nov 2020 16:26:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JZCChHuPFVwhHNhrSGqc3zDxiQeam3gdfLWufLDymDg=;
 b=p6lzj2oKJldHv4mH+KJ54wNePBYdvifaxIFbTxagVXf8h+5Ca8XAq+WsT4AjFE1SJXMm
 e6WLL3+VW5cKsuiI806Z2As4z5tjEWoPZdIHE7FC0XE3u4Agcwf+H+mNGdMo6TUbE6uG
 03JVFOIKE3YEXsJabvjRX+9mSzfrDbq2KUQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34y19ssut2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 Nov 2020 16:26:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 23 Nov 2020 16:26:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHknqqi65Nx6gwF4XmGTxFgfdV/jrYqD7K3nmehm4ZYlUzj60z8AdUmJiEFK41Sz1f0+6i67IWfcBIGuySjeCl1E7Yg/Z8JD7QAIOInAc0I75FlJiknP7yPfX/xXkOAXyaLz8PoiwFlR9f6bKpPuy8uDBeCc7rUPqa/UiV/8gu4FjbIKY6ULT9M9FYNTse1U/dW+FnLMOvxseWrz7t+Npo9zianTSN9FX6eoiZDvkkCsIchcDsUCGKgjRdYGzzm2mRULQCGr7RsKfO/guPeHFQ0uI62flLisYnl9csdiWkudxJOrcb0CALKPF/Tx4dQ/p8ln1Gsx0/AOXdDlLqB41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ywy/dYBeQqPwiVUxcVA1NLFtEOMfCTFNCzuYtPvVH9s=;
 b=mUMZ20m7f+LZ7ivOxm7v9W0pRZiY0OALcQ02cqEk4fOd+iJevWJMUDXPHMr/SHzOObu0pzsb3qkUazOfI14II7sTj2nQmgkeD+2jICKIaLyN6M50PHEghxGUyipGwO5PrMqXWgnCfLiuO58VT2l1jh2bKIAuxOjTkqeE/FsY9SPuWKmgTWw1RjedlbMoo60WbiDkZBpjskU7sBxwn53DU/dKX9WPlxE1cPxNncmS2G7aibaLOKCk2DKEQdc3kJ2gsSu1YVn5L1etRpE+GJiMfTykpDgQ4oyEUrznQOM2sZDr21IHT1H9DNudD+gia31zdpqRc0BRf02c8XB5Eedpsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ywy/dYBeQqPwiVUxcVA1NLFtEOMfCTFNCzuYtPvVH9s=;
 b=FG0ZTHHtb5JYrsru3PVbFRxji8bw+ijutHpN8sRx4qGYHceFB5NBrMZitbJkb6ZNlmbxOFhOo/IRVvZXhMuXD+Vqte0aHNkr1uhRp34vzViXWYp28M75WIWqjObrc84o+0bxj2jbcltfACPWMDIYk2dpFYv8eOcPw6LWQzEI/Ys=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2696.namprd15.prod.outlook.com (2603:10b6:a03:156::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 00:26:48 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3589.029; Tue, 24 Nov 2020
 00:26:48 +0000
Subject: Re: [PATCH 7/7] bpf: Add tests for new BPF atomic operations
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
References: <20201123173202.1335708-1-jackmanb@google.com>
 <20201123173202.1335708-8-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c4cf639c-f499-5179-45f4-0fe374eb7444@fb.com>
Date:   Mon, 23 Nov 2020 16:26:45 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201123173202.1335708-8-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:1b2e]
X-ClientProxiedBy: MWHPR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:300:ed::21) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1039] (2620:10d:c090:400::5:1b2e) by MWHPR20CA0035.namprd20.prod.outlook.com (2603:10b6:300:ed::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend Transport; Tue, 24 Nov 2020 00:26:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8be1ba55-8476-4dee-4bc5-08d8900fa1a2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2696:
X-Microsoft-Antispam-PRVS: <BYAPR15MB269668BEACC4F1F874F6552ED3FB0@BYAPR15MB2696.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2dK/81P06x6X1B9ktzLqwnvcDx2/20hPkB/vfS+Mdgz5NMcWPk6cLJ6Xs0Zlaz89aEmuvu7BcBCczPpRKgZQobX/q8bc+jLEVx4JdVq7UlksfsL4qFbnclOfLnqJ8Ok8gfaprr2sE9RImwygLAq2O/PcheFL6hVFiI4E9CgMn238ukdo9wqqIoz68j2dNiKu3+2rOMF8oXkQuu/erdHzao/vOZPJ4eJJot9/NcNsoAPyrAXxWbR+PI8qvDbxOeKpX1OzRpj3BoDSruvoZKB5EZldpLv5cBBpYcwYIFIXghI1id0bLMUKphbLpqFa1QjHsS/T3SAjyRG/C0mc9WmHOvT9MSFuQVsHZkigjJ79+olgyu4CcApkFc0Gfdq0TsLvpRzAuFmJDqsNV5PQnR6gkJiagaIfdpAIZKzlBc2/GleH9/L++zO1Dyy9G1Q7APP7VDezNsTHJLlBxRe5Y4zHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(396003)(136003)(366004)(966005)(478600001)(66946007)(66476007)(86362001)(186003)(53546011)(66556008)(8936002)(16526019)(6486002)(8676002)(2906002)(5660300002)(83380400001)(4326008)(2616005)(36756003)(316002)(31686004)(31696002)(52116002)(54906003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: WtKSQgcQnFfYk2V6ux06GWZooI3k0G8xfVRlXnbs9evVRDkWpvBvQf9hhsG5oknl7UXSztHcVkrjay6N+UeexjDrrp3wUEdkevOW7LfXBuC5scajeB50gGZlVpBnKC+Ef7wPHMoqfPn+JuYYhpQFppTPEUgi/VeJxXFhjSjm3KWr98MCRlhScc+S9hbAf5GqoG0U5VF6voSReRUX9ObpxQIvuGrtc1Tifq8n5cITVzLJttutLPxHmEUXroSoQ7XiA+fg9i06VHBlinDgF5mtVWY+yV4BUBdToqOAMnVBRTd2XTSfXsLeobAIJvJE/Dz5lMvVWzPNFghzuokZYITJnEPx3zmAfQmcGoLB+dwjnZjDQ4x75WK84fZtVoHpjOL1pDSCTJxsZy3/VmM6rk1EHeOwG032PUAf9+H6sEAQQjn4vLItqiU/29hXp8FlCnjzTs9P6dR8dE1ieQ4Sm18ymY7pDGPIi7RshLwAWDpYBA++7eTgaQBIQgon/b7Q85m4mTz1ihHPtAnmXQvwaBlwGK8oWhFXZb2fbUxS+LkJQFBzdsL+8Xe49AV0dJhMVf3TPPKLAifOxOniYUd81r/KYmNpL4U+Lhj+cOQyQffjkRjtbgsgzmphGTH/yzNzwXb75ZdwDAyGlUwLlMRSFi2c0VNuUtXxmgfKtZ3u6DAKtH9MipRqvGr8MZziWZ6SqeuwlOd01cPcFKEo6DVp2en4U9T5PAgZiNroY2nWhBJSpyqWj00HRK7onFeeTavXRiS3HtAgACVtg2c4wXngCuY+IKRCC9lMIKCQ5tk+EOdfbx0HXNYnhnXttd7woVlwkhKI1k3LGBlLS9x8lN+x4vuybAuzTdNd7yeDMtDk6hq21LDXJrtVKPUWH7mSH5u/v1PYLSqfM+z2VYNjxthR6MnrjU8tXN8UCuSZLE2nsO81uv8=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be1ba55-8476-4dee-4bc5-08d8900fa1a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 00:26:48.4771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxVQHjnsqBSSNiA436dvwZaypODDzJ0UnhsqjcUZnyMyWzF4JUSKC+WzBxoBRGov
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2696
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_19:2020-11-23,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/23/20 9:32 AM, Brendan Jackman wrote:
> This relies on the work done by Yonghong Song in
> https://reviews.llvm.org/D72184
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   tools/testing/selftests/bpf/Makefile          |   2 +-
>   .../selftests/bpf/prog_tests/atomics_test.c   | 145 ++++++++++++++++++
>   .../selftests/bpf/progs/atomics_test.c        |  61 ++++++++
>   .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 ++++++++++++
>   .../selftests/bpf/verifier/atomic_fetch_add.c | 106 +++++++++++++
>   .../selftests/bpf/verifier/atomic_xchg.c      | 113 ++++++++++++++
>   6 files changed, 522 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics_test.c
>   create mode 100644 tools/testing/selftests/bpf/progs/atomics_test.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 3d5940cd110d..4e28640ca2d8 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -250,7 +250,7 @@ define CLANG_BPF_BUILD_RULE
>   	$(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
>   	$(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm			\
>   		-c $1 -o - || echo "BPF obj compilation failed") | 	\
> -	$(LLC) -mattr=dwarfris -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
> +	$(LLC) -mattr=dwarfris -march=bpf -mcpu=v4 $4 -filetype=obj -o $2

We have an issue here. If we change -mcpu=v4 here, we will force
people to use trunk llvm to run selftests which is not a good idea.

I am wondering whether we can single out progs/atomics_test.c, which 
will be compiled with -mcpu=v4 and run with test_progs.

test_progs-no_alu32 runs tests without alu32. Since -mcpu=v4 implies
alu32, atomic tests should be skipped in test_progs-no-alu32.

In bpf_helpers.h, we already use __clang_major__ macro to compare
to clang version,

#if __clang_major__ >= 8 && defined(__bpf__)
static __always_inline void
bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
{
         if (!__builtin_constant_p(slot))
                 __bpf_unreachable();
...

I think we could also use __clang_major__ in progs/atomics_test.c
to enable tested intrinsics only if __clang_major__ >= 12? This
way, the same code can be compiled with -mcpu=v2/v3.

Alternatively, you can also use a macro at clang command line like
    clang -mcpu=v4 -DENABLE_ATOMIC ...
    clang -mcpu=v3/v2 ...

progs/atomics_test.c:
    #ifdef ENABLE_ATOMIC
      ... atomic_intrinsics ...
    #endif


>   endef
>   # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
>   define CLANG_NOALU32_BPF_BUILD_RULE
> diff --git a/tools/testing/selftests/bpf/prog_tests/atomics_test.c b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
> new file mode 100644
> index 000000000000..a4859d88fc11
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +
> +#include "atomics_test.skel.h"
> +
> +static void test_add(void)
> +{
> +	struct atomics_test *atomics_skel = NULL;
> +	int err, prog_fd;
> +	__u32 duration = 0, retval;
> +
> +	atomics_skel = atomics_test__open_and_load();
> +	if (CHECK(!atomics_skel, "atomics_skel_load", "atomics skeleton failed\n"))
> +		goto cleanup;
> +
> +	err = atomics_test__attach(atomics_skel);
> +	if (CHECK(err, "atomics_attach", "atomics attach failed: %d\n", err))
> +		goto cleanup;
> +
> +	prog_fd = bpf_program__fd(atomics_skel->progs.add);
> +	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
> +				NULL, NULL, &retval, &duration);
> +	if (CHECK(err || retval, "test_run add",
> +		  "err %d errno %d retval %d duration %d\n",
> +		  err, errno, retval, duration))
> +		goto cleanup;
> +
> +	CHECK(atomics_skel->data->add64_value != 3, "add64_value",
> +	      "64bit atomic add value was not incremented (got %lld want 2)\n",
> +	      atomics_skel->data->add64_value);
> +	CHECK(atomics_skel->bss->add64_result != 1, "add64_result",
> +	      "64bit atomic add bad return value (got %lld want 1)\n",
> +	      atomics_skel->bss->add64_result);
> +
> +	CHECK(atomics_skel->data->add32_value != 3, "add32_value",
> +	      "32bit atomic add value was not incremented (got %d want 2)\n",
> +	      atomics_skel->data->add32_value);
> +	CHECK(atomics_skel->bss->add32_result != 1, "add32_result",
> +	      "32bit atomic add bad return value (got %d want 1)\n",
> +	      atomics_skel->bss->add32_result);
> +
> +	CHECK(atomics_skel->bss->add_stack_value_copy != 3, "add_stack_value",
> +	      "_stackbit atomic add value was not incremented (got %lld want 2)\n",
> +	      atomics_skel->bss->add_stack_value_copy);
> +	CHECK(atomics_skel->bss->add_stack_result != 1, "add_stack_result",
> +	      "_stackbit atomic add bad return value (got %lld want 1)\n",
> +	      atomics_skel->bss->add_stack_result);
> +
> +cleanup:
> +	atomics_test__destroy(atomics_skel);
> +}
> +
[...]
> diff --git a/tools/testing/selftests/bpf/progs/atomics_test.c b/tools/testing/selftests/bpf/progs/atomics_test.c
> new file mode 100644
> index 000000000000..d81f45eb6c45
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/atomics_test.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +__u64 add64_value = 1;
> +__u64 add64_result;
> +__u32 add32_value = 1;
> +__u32 add32_result;
> +__u64 add_stack_value_copy;
> +__u64 add_stack_result;

To please llvm10, let us initialize all unitialized globals explicitly like
    __u64 add64_result = 0;
    __u32 add32_result = 0;
    ...

llvm11 and above are okay but llvm10 put those uninitialized globals
into COM section (not .bss or .data sections) which BTF did not
handle them.

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
> +__u64 cmpxchg64_value = 1;
> +__u64 cmpxchg64_result_fail;
> +__u64 cmpxchg64_result_succeed;
> +__u32 cmpxchg32_value = 1;
> +__u32 cmpxchg32_result_fail;
> +__u32 cmpxchg32_result_succeed;

same here. explicitly initializing cmpxchg64_result_fail, 
cmpxchg64_result_succeed, cmpxchg32_result_fail, cmpxchg32_result_succeed.

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
> +__u64 xchg64_result;
> +__u32 xchg32_value = 1;
> +__u32 xchg32_result;

explicitly initializing xchg64_result, xchg32_result.

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
[...]
