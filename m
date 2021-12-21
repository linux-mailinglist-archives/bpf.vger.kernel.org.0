Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AD347B92E
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 05:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhLUE3K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Dec 2021 23:29:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51102 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232088AbhLUE3K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Dec 2021 23:29:10 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BL0mg6b007871;
        Mon, 20 Dec 2021 20:28:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=H8NDUJPV2poGwzvAyZBLLVuk5jm2LgqSBnuNwihIrOE=;
 b=Trl/6cRfaJBfqSHypTTuzjPYJM6L9Uo3trX3qP3K9SLjI7IIE1L1roXNPfkjYf8JgNht
 2ODJ+CC0n+i2VnV6Ou/6PuALSYQcJrzYMhvAoXhtR35GbMjXjHc0ZxQ005XbP2DTQP/q
 DVI5JHrqmmXwdOewvf+PRnakQRCf8vbry5I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d2wuabu4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Dec 2021 20:28:55 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 20:28:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lp6i2eLnUBuT7woxqaB8/zzBg3LPwFp5vZsrSJSdirkqOe9F70GRluBkRfNJ0BPfLBdsVupdP9T9ekNSvpTPdUXLoSiLtdJUDXd3vEfjDe2wsHkWBx4M1oPbN1bfFBhhSVjPmNbvGbRz82yGpFVbsXRDVE7h5uKCuvTlazBoQsduPBdJ2ZlDUBWGytGQ7PHA0VrvVvFuPfiLQMx/F5IH+923VyirFJ4Y/MnmNCobfHSLMWF12vzgZJD15CubYfzgder6nrwfK4ckzgW1pmzLiAI3uOzlPXEycYVi/ZwK5E9bYEm3xnR11hUp2l3DOHZr0Ozpd5V/BeRzNcJwV1agdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8NDUJPV2poGwzvAyZBLLVuk5jm2LgqSBnuNwihIrOE=;
 b=PLLKs6RxrHfw8tgmE4j3SFeI5G3dFTgO1mUz3rcsGBlk7bLTo3Q08MKAMo3bHLsZf6Zq0NV6wU5kgImlKHjBjdiGsg0Ja+LtOW7Re5t2ShcM8Vm1LXJwmq9BPCfnxDrHffswUgQotXOvVVYyQE65dbHXinU3SFoyoZBlSnFP66W4WQNaPsTWmBeElfaiJbly/eANlTMCtWhmxCvuXlCs5phYx1zMXYme4VCxVRed/RVawRJDtY+kL0vZFZyW8Cso6iY1rtZAU3ZiwMZMRXgl7Y+Kuj+Lm3ulyy6oP8npGTd8T4x8nWkJUaJbYfyeclzl2ZLpC91MR9uzjek/BevVyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2285.namprd15.prod.outlook.com (2603:10b6:805:19::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.18; Tue, 21 Dec
 2021 04:28:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 04:28:52 +0000
Message-ID: <cd32b6d2-bbca-7442-419a-653f0fb5c3c7@fb.com>
Date:   Mon, 20 Dec 2021 20:28:48 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH bpf-next] bpf/selftests: Test bpf_d_path on rdonly_mem.
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>, <bpf@vger.kernel.org>
References: <20211220201204.653248-1-haoluo@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211220201204.653248-1-haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:303:8d::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37c91add-d941-493c-4ed5-08d9c43a64a3
X-MS-TrafficTypeDiagnostic: SN6PR15MB2285:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB2285D2B49E71B7072CC41CE7D37C9@SN6PR15MB2285.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Vws9IxIWcbIZMHJ0PD6JuB/hDSGELtMVtGqgl/CqTNjktNPMxlLbjZJIv2yzGmRXUNj3H6iM6NK43WOynMG+WXu63eoGHSKjGYi4MJUJVR/mGi4smM3tVg5SAXXFPmoXeMHVPFPJdsvd6mYwUA/Rd8HzLX//YVemtLtAc8YeQ8x1UQo3B2BTUfIYX2hD0svfagmKQHu6zs/IaE3Z8u1cMaGhqo8eoSxVPzsjmZiRdCg55tCU+r1ZZoKjqll9/l+GO6PA6TVnToe/AVxtP8UVazwU9Jl5Q1jlwKhT0UGcTZCvq1GTfeo8pGRnzJx5+i9OrSMVXb0cDNAzONDHNhBGFSgOlduj/Av59aKo0qZ5S3NUJ5xhgGS+fENYHIMoxslXCHC7kuE0dE+UKmfpczXEMw973vga9B2jo+g1CXKFL97GuLwtjCCxG7V0e3JOa4TM2a+/e548FsjHZ30OsoN/6TnlOsn9y5SU1ZjuStMoyN7vU03zkGIf471irJfURQioLx9B29cGMjraxUTTlNuRpd5dh2aqphQ/N7pyKXj4Yyxr5dUxIkEph96j5II66NnacGgyq4F4KY0Y7TeK5Eu2XOiFSiCg+C2ro/6wvRu2GkDDmgIPaS5EUfKXPlXX47YVe/1lyuAbPwoLYiFSIuIVXVOWkgdxC/u/h1ARrSPdXRxWFCsLepyhU7SdjGTe7b2e6o5VOR7OG8dnwgPx1yxB3Q3gD6VPq5zFiZkBMno+vM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(110136005)(8936002)(54906003)(2616005)(316002)(6666004)(53546011)(86362001)(52116002)(31686004)(5660300002)(66476007)(36756003)(31696002)(66946007)(6486002)(6512007)(8676002)(38100700002)(66556008)(4326008)(2906002)(186003)(508600001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVFrSDg1RUUrYzhVdHROalRvalIyNjYvZnNBMTdhTUwxU3FDTktmeFkxK2VN?=
 =?utf-8?B?Mi9xRU5DaWdBVEZobG03T3J1bmhDZEttZmo1RGwvV09uZDlEVVNpRlFLUjMy?=
 =?utf-8?B?TkY1aTg2VEM3OW9zYzdwam5Ia1RnT0lxMlhqMVN2OXRuc0QyMUhVb0xDaTdN?=
 =?utf-8?B?R3Y5WEpqbGovTUdPYUt0YjVsVHA5ZDhUYWpKZTdmR1U4SWF4Y2VtcHRicUhV?=
 =?utf-8?B?SGoyMkJMWllNd2Q5ZXRha25JcWdPeVBMbkQwK1ByRFBxL2pnQkJSaHFDTkZO?=
 =?utf-8?B?aGFibVRraGF3Tzg1VGtRQkZ5ZWUydHRpQ2lkVHhFY2tSdEx3aUZQdU1jQ0J0?=
 =?utf-8?B?ejZMMmFueG5vZUdxSkNuRlc0cjRmMXlOSEZKZzFtK04yQ3hlWVRNaXRqeGJk?=
 =?utf-8?B?R1lQaENRUCtvbHN3M25YZ3U4bDhSNFhxVzgyS0owdXZjeHN2L0tzMHVDL0VV?=
 =?utf-8?B?dFNuVjhYU05xQ1lwRTRpWWFjeXhCWUlhOXNGWUVhMUcwNlo1ZFd2VGM1WW5V?=
 =?utf-8?B?NnEzR1NIQVIwVWY0UGRrdEN6R1FLU1hIQVNobGxMa2ZSbEtzZUR6eUZsaWhZ?=
 =?utf-8?B?NHZPM0NHUE1VeEs5ZEoxUStDTnlVSGlTYU1yNUk1UkVTdFVtOExtUmNxRmhh?=
 =?utf-8?B?cU52WUx6cFhiQ2QzOE1qcW5GVDgraWJVb1M3U3R0Q25PQjJpWklQNEdGMTBC?=
 =?utf-8?B?WG8vRW1PTEx1cEZwcDZqZHhKMElTY1FVSDhxL01ZeDY5SmJ6dU5JUWlaRk9J?=
 =?utf-8?B?WnFTYWVXd0doQVU5Q3lYNUJOL1dHSExFaGRybEhNVGdTQVZGbTA2KzZjRGxy?=
 =?utf-8?B?L0FHVDBNeEZtQVFvbVJtaWhTOU1RTzc2eERmVXpFZndDRHlZR0ZvUDdEQ3dE?=
 =?utf-8?B?cjh5YVljNUhTbHNjU2o2N012dHErY0FINU5NTVNhZlBTa0JrRlllQjZsTDZx?=
 =?utf-8?B?VWVNeWdhWEFQN0xjQ2RtMHUrZVJaRWlTWlh0d3BXbWsrNVd0WHNiemZ4ZVRK?=
 =?utf-8?B?d2txaXhBWGNBMXc1c1lCZXQ2UzN2TEZVaXl2aDYyTm5wdFJaeEdZN3V3dUtr?=
 =?utf-8?B?M0pnN0VKWnE1L0FPL0VJQ0ZOMzRuQnE1eEtDYWtaUkJXbWo2Wk1QSHUvdFgw?=
 =?utf-8?B?cE9zU1o0UVk5OVQvZmJsYmpucVl1VitaQkdJV2FnZzlJaVJubnhYRFJXUFow?=
 =?utf-8?B?elQ0V3BFTm9WQnFnNlZUTkJpaUpzZWFpbXJkM0RmSzl5UXczMUpZSlNOT0NF?=
 =?utf-8?B?d1IrYTl3UmhnTzRFd1ZGTDIyVHdCWUppRkE5bjR5UXVPUFpUdEg2Y2FlSGIw?=
 =?utf-8?B?aVdzdkhjWkFUdGlFZC9pQmoxYm0xbFRyY3BKcmQ0SnZQUUk3UktlL2JqeURI?=
 =?utf-8?B?UzFjb1dMRks1c3VleGo0OCtwTnJML2g0VE1pbGlJUDJTVjNSc29DdzYvY0VG?=
 =?utf-8?B?UmROTjlvQjAxa3dmZDhlRWpOMlEwSlQ4L2F0UUlvWEFHem84R2FNR1Jhc1l4?=
 =?utf-8?B?WDlZb0g4OVFXYnRDUWFONlVnR05DZDBRUVo2U0lsek1LRy9TY2ZBSTFiVHg2?=
 =?utf-8?B?VWFtNy83ZitlUEErWmRLVXJVQStGVlFhRG1kY05pVVlaZFNTTXUzMldNQ3BK?=
 =?utf-8?B?RGNGRk9xNVRIOVIrTCtPbi9vSkRBMWkrYWhFdVFyaTJRZmRhVU8yTEJmUGIy?=
 =?utf-8?B?N3o4ZXVyUlNEUXBZRUx6Qm9jVVpvT2crUjFXbzRHbkR4dDBqcXpTSWNUcmF5?=
 =?utf-8?B?dndPazg1SmxSeHUyQjNlcmI2eDFWV0daWWI4OUtDVGd2cURQZ2I0N0dxTWhF?=
 =?utf-8?B?Q0pLbnV0V0JCd3d2TkhETUZVaHhSVGNRMHFMRlYzZFBUelRvN1hkZHdTWVVU?=
 =?utf-8?B?aHRxaWFJQUNQV1A2MmUvNU04OXJsbHN6dzY3S0NmWXVlOHVxSmEwNkxINWdl?=
 =?utf-8?B?RDZjQU5TNlozWWJ4UCt3d2Q1RkVJK2lLbjYwSFA2Q0VBN3JkbE5PbzQ2YjU1?=
 =?utf-8?B?VUIwN0RtYUtFbDJJUmQ5ZFN6VzhCWHprQ1BkZXNqYjVDclJMOWdzZXB2dEVM?=
 =?utf-8?B?bXppNnVLL01UbWMyaExWMHNDZmMycWpTVmdwaXZkbDNET25hOXp5SnlZQzMw?=
 =?utf-8?Q?cMCC9pcX7gAbHA/0NiAKRf++K?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c91add-d941-493c-4ed5-08d9c43a64a3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 04:28:52.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFFt2iP9QLiPCVhIEk45BXgUMYxSCKYHD64nFrOuC33Y1FkkreYu4AIlEAktvTM4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2285
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 7XwBTwnUk7tPujv7Rft2qX_pWh8wNDyZ
X-Proofpoint-GUID: 7XwBTwnUk7tPujv7Rft2qX_pWh8wNDyZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_01,2021-12-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1011 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/20/21 12:12 PM, Hao Luo wrote:
> The second parameter of bpf_d_path() can only accept writable
> memories. rdonly_mem obtained from bpf_per_cpu_ptr() can not
> be passed into bpf_d_path for modification. This patch adds
> a selftest to verify this behavior.
> 
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>   .../testing/selftests/bpf/prog_tests/d_path.c | 22 +++++++++++++-
>   .../bpf/progs/test_d_path_check_rdonly_mem.c  | 30 +++++++++++++++++++
>   2 files changed, 51 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
> index 0a577a248d34..f8d8c5a5dfba 100644
> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> @@ -9,6 +9,7 @@
>   #define MAX_FILES		7
>   
>   #include "test_d_path.skel.h"
> +#include "test_d_path_check_rdonly_mem.skel.h"
>   
>   static int duration;
>   
> @@ -99,7 +100,7 @@ static int trigger_fstat_events(pid_t pid)
>   	return ret;
>   }
>   
> -void test_d_path(void)
> +static void test_d_path_basic(void)
>   {
>   	struct test_d_path__bss *bss;
>   	struct test_d_path *skel;
> @@ -155,3 +156,22 @@ void test_d_path(void)
>   cleanup:
>   	test_d_path__destroy(skel);
>   }
> +
> +static void test_d_path_check_rdonly_mem(void)
> +{
> +	struct test_d_path_check_rdonly_mem *skel;
> +
> +	skel = test_d_path_check_rdonly_mem__open_and_load();
> +	ASSERT_ERR_PTR(skel, "unexpected load of a prog using d_path to write rdonly_mem\n");
> +
> +	test_d_path_check_rdonly_mem__destroy(skel);

You shouldn't call test_d_path_check_rdonly_mem__destroy(skel) if skel 
is an ERR_PTR. Maybe
	if (!ASSERT_ERR_PTR(...))
		test_d_path_check_rdonly_mem__destroy(skel);

> +}
> +
> +void test_d_path(void)
> +{
> +	if (test__start_subtest("basic"))
> +		test_d_path_basic();
> +
> +	if (test__start_subtest("check_rdonly_mem"))
> +		test_d_path_check_rdonly_mem();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c b/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
> new file mode 100644
> index 000000000000..c7a9655d5850
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Google */
> +
> +#include "vmlinux.h"
> +
> +#include "vmlinux.h"

duplicated vmlinux.h.

> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +extern const int bpf_prog_active __ksym;
> +
> +SEC("fentry/security_inode_getattr")
> +int BPF_PROG(d_path_check_rdonly_mem, struct path *path, struct kstat *stat,
> +	     __u32 request_mask, unsigned int query_flags)
> +{
> +	char *active;

int *active?
It may not matter since the program is rejected by the kernel but
with making it conforms to kernel definition we have one less thing
to worry about the verification.

> +	__u32 cpu;
> +
> +	cpu = bpf_get_smp_processor_id();
> +	active = (char *)bpf_per_cpu_ptr(&bpf_prog_active, cpu);

int *

> +	if (active) {
> +		/* FAIL here! 'active' is a rdonly_mem. bpf helpers that

'active' points to readonly memory.

> +		 * update its arguments can not write into it.
> +		 */
> +		bpf_d_path(path, active, sizeof(int));
> +	}
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
