Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145F75BD7A3
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 00:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiISWxw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 18:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiISWxu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 18:53:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6611402D9
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 15:53:49 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMNNKd029717;
        Mon, 19 Sep 2022 15:53:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=1IflY0NnQ5IkGsV4B0qJgGrTjyThqctaI/YXXUX9XGY=;
 b=P1ivLvSyp8jLKl0kC9tRlOb7wihlKeEDOALEcPvNo+AmWGois3T3lmTPZpJ4DloDD2Xe
 74Qq+lUkldDOqGBSbD0X2+ZZTOD1gxMR1hi/dX7p8Yir5lypm3DCmAmRRgLawmNOD/pc
 gAtEyk4oOWogQ8mNyAqw4KA3S6D+0rrpQZE= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jpkp3pjm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 15:53:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpQdXXRRJTjThPZPGJh3TS+GSjsBYmXW27d7CeC7d7m19XOd31W7AA/lSnEYDElA01XxTy+dyllKVTrgbn2yJgET2Nk3bDXSelt6siFdiqyb6mOBhZr/isw9xC/XvQWa8+pFS67DNNkbmvVSscBjxk70zCkyICInoGWCTyQJ0245TGQVwlreVarwcJF/ClDrfCYtOrdD2b6bQuYmYQrSLJsdBFKMUiw94Bczz2lt5fsfzFf8cEnWHuroVYWmRwoVxkuo8R08KbbM9wnVCRG/upQ11OG/sm/v6n9AyDGuUca4w1iwPWLeTO/mnEDj9pRF2G2JMnIpR8AVvSAaCWbAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IflY0NnQ5IkGsV4B0qJgGrTjyThqctaI/YXXUX9XGY=;
 b=MVuAs5PVEUkn3oC3R+fWfv3yX1B3v3TBrS/2Zxte9A4WnyHvqUhKxySWh4eqZbY4CZlJtGLgXRKwhwqqPgpIBVgC5zdBfxfp29Ow0rJ5ad1JYvtVacGO0IzyFLOmGyAkjDIHdU5cHB8xRHIovUY0UZ6fwqGejJyVg359ZGgUUsTJSnGbYh+7Lwv4Mu6GNlayBPnZPpulT0mOQ+qOel3l6zVjxdIznmV3biihQOiODdJ+F7bqQnrooDjmIdpGBnM+eSZsSb4JgjQzJhFZQTPfmze4y2dJHVt+UtHYJL/YZFPJn+2NB/ok/P4q4PL+IR4ShlbDMveDWRb4oHZWpC39bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY3PR15MB5010.namprd15.prod.outlook.com (2603:10b6:a03:3c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 22:53:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 22:53:31 +0000
Message-ID: <26e3f391-076e-49ce-89d6-21aa16f3c054@fb.com>
Date:   Mon, 19 Sep 2022 15:53:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add test verifying
 bpf_ringbuf_reserve retval use in map ops
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20220914123600.927632-1-davemarchevsky@fb.com>
 <20220914123600.927632-2-davemarchevsky@fb.com>
Content-Language: en-US
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220914123600.927632-2-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BY3PR15MB5010:EE_
X-MS-Office365-Filtering-Correlation-Id: fbac638e-b8a5-43ae-d58f-08da9a91c65f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4xeT0bXGypbaucohxTsiAv/mhUTMuG7Xw86iIw4bepjEQ1erjdOH8YSr8phhmyaCz+NXzyx9KXGPItBIyjvDDBtIdOPhQ5ngJ3tqap8D8D+KZo4UKQLDJdDjp6oPrcBEhol0lRmaKQDotq8EV7fYsgbQlYJqjkczDf2RNsm/CEuHEHRzora99g2AUx/ExqcgpMzoN/lEIeKZxomW327OVqjAAH3Mm6fCPH7yCYLw+tx9KZsceYlf9jvuDxGu206EsOEAJIEJiyyNK9b9/beehFfPHV/KV9TP7EQcNc0VKRpTjfuQzkjNqg76ni4qoYHJuGFU/w9L5YRPNU562PWzrS0kki+0ausoq4fwbz/HZlHQw1cyZT9UqazxDLG2kZQr33kGCoczJtVkJgSAJmh3tvX3S/ZwYeSmIXuSQDQjMpeLZrLnmzTeWKmIiQDEoR5ga/0McGGNrUcmXqgx8622bizvCPL8VGTvqxKpSov3aAhqqCYfYK0nmyJ5ag8tihabCgGE0Axe9ce6cA1Ei2I0DY/B97ti/Pvyb63SrN39cPvkKKhHnFvPks3e7XiEEkT/PRMCXX1zv5oM9lQ3ANv4IYiWuozMLGxLpnsCNUwna9s3F7cet76m3CMcj4Go73OzkSRajfm7po8UkghMONQDuCsJGqQ5YDUVyC/zGh38SlCN79W4QApnUxyQ3xk+wOkw1GhAMR/DmROOwY8uMt6GJsqxFKTt2GxLo9eis129qynH35mTnHQZgUqcN/DvCTFJ6qY79ZbY66kJdEdcn8tXd/AxFjs2xQo35Y2FUXHOFQeCc9tcd2bhnZzz6lo+98gdc8aXzdMe11kV5PQtlU/Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(66946007)(2616005)(38100700002)(36756003)(186003)(66556008)(66476007)(84970400001)(2906002)(83380400001)(316002)(41300700001)(86362001)(8936002)(53546011)(6666004)(54906003)(8676002)(6486002)(4326008)(6512007)(6506007)(478600001)(31696002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzNmbldaS1R0SlV5MmpHcmhkWWlNdHArWmt6VmxWUm1oWVViOG1ocE9Ob1Ev?=
 =?utf-8?B?WUJNRXFyd014MTRDL0RHeUdBMVZVT29FNVpidkQyZmNBRGhaU2FJblYvMGxE?=
 =?utf-8?B?di9mdWRMQ0gxNjRLQlZ0ME9qODdGaUhjVU5YTTlhdjlyRkVWbTlwdTFTNUM5?=
 =?utf-8?B?dUNlb3ZCMzZDaEdwRGFpS3lYQ1NsamtCaG5NSmdUS3RPUnNpNHVhbXRuVWFK?=
 =?utf-8?B?dHJWL3d4RkpoYTdQQ1RIUHBYbnBWSnlnNEdna28rZHZRM2R4bWNiRzdjbEsx?=
 =?utf-8?B?djk0TGpsZndSbEZBUVlVWjJ2S3hObTJmNkx2Z3NheEpnb3VKWHRZbVhwRWN4?=
 =?utf-8?B?cFlJWVBCc0NtQVl2N0RNc09MR045ZzQ5WHpWcEVuajd0emdrbmpmUnhtNDJq?=
 =?utf-8?B?ZEtTYTZ4anNmbVBYY1BZYURHWm0rSndRMk1aampKRml6U0JFUGFPT3BPaWZZ?=
 =?utf-8?B?ZmxEK09UMGcwMC9PZmoyelI5b0l4Q0ZsZTVpbms5Sm5DK2c5R3BKTkRHamdO?=
 =?utf-8?B?T1hYYkFJcTY2alJkQngvQ1dIMjdqb3NLcjF4d0JIV3FRUHVLQWJCSkEvdTdG?=
 =?utf-8?B?UWRuRWsyNS82Rnd5ang5RkN4dXFCMWJIWkNXS2xrMDdDUWdPK2FOVUtlbVpX?=
 =?utf-8?B?ZXk1TUMzWjRUS0lScjFydEdBWXFpVDdZV0MwWUVibVA3RlNEeFN6alVXZlpI?=
 =?utf-8?B?SDNZS2FpZ3p3ZFFSaVlac0xFNGlqMksrMzZXSE0rNExhUDVteHVYMHl3OERn?=
 =?utf-8?B?VkRSaE9sVGVBdlZsbERXM0xPUlpBRjVzek9lV05hZkpVcE9Ndzdack1pZXo4?=
 =?utf-8?B?ZmpwWlhZUnRNRWFJZ2p1d3JhYkdURUNQc1ZHbmpGYVZoY0NNQ25BK2ZFeEVD?=
 =?utf-8?B?a0dsM0ZhcnQxQ1pQaWlSV1lyYWRWRFg3Q3ZyTmtSaUFFL2ZQaGsreHVURzZy?=
 =?utf-8?B?V0p4MlBqV3BHaDAwa2hLaVZyMmlNUm5MVlpnam93cnNjakxZWm9RUlJERWcw?=
 =?utf-8?B?aVVJNkl4aFZLWkxQTmtVMEZmazdiMlMyZDdHaWxmdjBXeXkxY09IMjlza0Vh?=
 =?utf-8?B?SG0zZm55RnVYSDlyaEVvNjVDdThSZHRIWDFUWksxQzhDakt4cHNZbytiaVJ5?=
 =?utf-8?B?OGFaRmRlWHdTck1ZbnF1dTdzM3BqWm9LSnBlWGZ5d2F1UTVjK1RqMmJwdktx?=
 =?utf-8?B?MUU5VnVMY1Z5L0xvOGJLaituSnhuYmNreFNzTjhHVmlSSDlkdEVKa3AydFBK?=
 =?utf-8?B?T1BqZE5Pc0tkYkhvMVJhbkQ4YXF4WG0wdm5ERXdibzNMb0hoSXJmSzdyVHU2?=
 =?utf-8?B?dElPZVBQVUVFUWY0U1VHa0JQMjFkYmhxcFVldjJzRlg1cFFOSHRJMEVBT1pz?=
 =?utf-8?B?amQ3TEJrWFo1OHhWWXIzRDg3eXdrQVdiUnliM1lEM1lVMnQ0aWZINU1Fd3c0?=
 =?utf-8?B?VDJOMUtLNkFQeGt4aEtSSk91dDN1TThnWjhPY2pRUi9mU0IxODVBQmFPTHJM?=
 =?utf-8?B?RnJZamtub1JsRmpsc1haNGl0OTBpVkxnQUh6RlRmeHRaZ21uSk5oS1N3cVFN?=
 =?utf-8?B?RllaN0NMbWJsS2dwWUFXRHM0cWRJOEdrNWU5MitGVWNzRjQ3ME5vc2Y1WnJt?=
 =?utf-8?B?bS9aeVlJZnpPeGFNdEdMYS8rVGh4azZCU2hlNnNHTTlVZ2x1d2hPalE0cXc2?=
 =?utf-8?B?eHYycFRQUHF1bG4rcHpTQzczd2hSRldnV3RWR2xxWWZzRzFiZkduQXRuaU5S?=
 =?utf-8?B?UWZZQTU2MktldXZ5TWw4U0RJRlZvdk02R3cwdTVCTGo2QXc5Z1BNWkNTR1k3?=
 =?utf-8?B?a1dhejdzbE1VSTlDN3M5NG9RbU9iVkM2Mzd5UHJFdTZjVjYrNlJRai9ReDVh?=
 =?utf-8?B?MWxDeGhLQXhiMjJOSWt6T2p5OGdxWmtwTWN1VXJGOVZ6TldWRVlaOC93c3px?=
 =?utf-8?B?cStrV0x4Njg0R1RGVm9TclZxcCtwZEczZUxyVTY5bVhYZE9QOE02WUhMd3VC?=
 =?utf-8?B?ekZ6a2hrVFJhR0lPblJINldIeDZXcHRrSDF6dnZFU3czWUZuTXYrOHBKZmNo?=
 =?utf-8?B?SVdNeGExVDUycTA5QkZkbDJ5UzN5Yk5TaUx0Ump1UUJRL1FaUnAwd0RUdHR0?=
 =?utf-8?Q?bC7HJt4Gj5bGZERnjsPg59Nkm?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbac638e-b8a5-43ae-d58f-08da9a91c65f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 22:53:31.6857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aad9KLMvdsndNv079G/95CH5LrIo18aVbm8Krs31zWhqcgVvIWAwL58mn/3o1ls0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5010
X-Proofpoint-ORIG-GUID: Sl0CUCX-RzYbu7Rsp4kXoNvVzDpI-Eea
X-Proofpoint-GUID: Sl0CUCX-RzYbu7Rsp4kXoNvVzDpI-Eea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/14/22 5:36 AM, Dave Marchevsky wrote:
> Add a test_ringbuf_map_key test prog, borrowing heavily from extant
> test_ringbuf.c. The program tries to use the result of
> bpf_ringbuf_reserve as map_key, which was not possible before previouis
> commits in this series. The test runner added to prog_tests/ringbuf.c
> verifies that the program loads and does basic sanity checks to confirm
> that it runs as expected.
> 
> Also, refactor test_ringbuf such that runners for existing test_ringbuf
> and newly-added test_ringbuf_map_key are subtests of 'ringbuf' top-level
> test.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
> v1->v2: lore.kernel.org/bpf/20220912101106.2765921-1-davemarchevsky@fb.com
> 
> * Actually run the program instead of just loading (Yonghong)
> * Add a bpf_map_update_elem call to the test (Yonghong)
> * Refactor runner such that existing test and newly-added test are
>    subtests of 'ringbuf' top-level test (Yonghong)
> * Remove unused globals in test prog (Yonghong)
> 
>   tools/testing/selftests/bpf/Makefile          |  8 ++-
>   .../selftests/bpf/prog_tests/ringbuf.c        | 63 ++++++++++++++++-
>   .../bpf/progs/test_ringbuf_map_key.c          | 70 +++++++++++++++++++
>   3 files changed, 137 insertions(+), 4 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
> 
[...]
> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
> new file mode 100644
> index 000000000000..495f85c6e120
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct sample {
> +	int pid;
> +	int seq;
> +	long value;
> +	char comm[16];
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_RINGBUF);
> +	__uint(max_entries, 4096);
> +} ringbuf SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 1000);
> +	__type(key, struct sample);
> +	__type(value, int);
> +} hash_map SEC(".maps");
> +
> +/* inputs */
> +int pid = 0;
> +
> +/* inner state */
> +long seq = 0;
> +
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int test_ringbuf_mem_map_key(void *ctx)
> +{
> +	int cur_pid = bpf_get_current_pid_tgid() >> 32;
> +	struct sample *sample, sample_copy;
> +	int *lookup_val;
> +
> +	if (cur_pid != pid)
> +		return 0;
> +
> +	sample = bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
> +	if (!sample)
> +		return 0;
> +
> +	sample->pid = pid;
> +	bpf_get_current_comm(sample->comm, sizeof(sample->comm));
> +	sample->seq = ++seq;
> +	sample->value = 42;
> +
> +	/* test using 'sample' (PTR_TO_MEM | MEM_ALLOC) as map key arg
> +	 */
> +	lookup_val = (int *)bpf_map_lookup_elem(&hash_map, sample);
> +
> +	/* memcpy is necessary so that verifier doesn't complain with:
> +	 *   verifier internal error: more than one arg with ref_obj_id R3
> +	 * when trying to do bpf_map_update_elem(&hash_map, sample, &sample->seq, BPF_ANY);
> +	 *
> +	 * Since bpf_map_lookup_elem above uses 'sample' as key, test using
> +	 * sample field as value below
> +	 */

If I understand correctly, the above error is due to the following 
verifier code:

         if (reg->ref_obj_id) {
                 if (meta->ref_obj_id) {
                         verbose(env, "verifier internal error: more 
than one arg with ref_obj_id R%d %u %u\n",
                                 regno, reg->ref_obj_id,
                                 meta->ref_obj_id);
                         return -EFAULT;
                 }
                 meta->ref_obj_id = reg->ref_obj_id;
         }

So this is an internal error. So normally this should not happen.
Could you investigate and fix the issue?

> +	__builtin_memcpy(&sample_copy, sample, sizeof(struct sample));
> +	bpf_map_update_elem(&hash_map, &sample_copy, &sample->seq, BPF_ANY);
> +
> +	bpf_ringbuf_submit(sample, 0);
> +	return 0;
> +}
