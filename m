Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D01591D12
	for <lists+bpf@lfdr.de>; Sun, 14 Aug 2022 00:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbiHMWuv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 13 Aug 2022 18:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239744AbiHMWuu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 13 Aug 2022 18:50:50 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDE325D3
        for <bpf@vger.kernel.org>; Sat, 13 Aug 2022 15:50:47 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27DMCXAj007089;
        Sat, 13 Aug 2022 15:50:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=kOR0PLTfBr5/ZpCHcAjVU+kO5WwEbe+Lz4PdgZ1yAMo=;
 b=Kqop/Kn998CWCLgdmKnDE/Rmyiq1iHg0UuRMyX1bsQQsrc7S7atilCnNfVKUoYUmVl4c
 fEBjkHoijapnNhRUKDjSFfFRJghKnTVQ+pmANOoYHCEDgs5AohV6ZGXQzT7CxRISYDcy
 onxWld9ZjHiNlGQEbp7MgQbygaTifFEnPt8= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hx9fyb2c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Aug 2022 15:50:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeqcbmgac7tyYsqinitEwWb4lzaGHOz7w+Rk+NUArCEfG82eQxnLNq0oPKn9ui/tgxBJDGC2qhJ4CTw20xqbM2szMkHnIE4IZqW7y7w8GGiG2nmKDR2eTnXnESoXKuU5iW9ncuySO5dFHrsIYsEVvwdr0uV18Higi7SlUE32nFGQjzdZb41D+Bm7wRq+rgXEPyvPHWqczUBrg6PsAS6kww+n2aZVuxlcU6/ol+7DNUSHT3mdqiCCRFfFTRe+ham2c75dbQ85cCpcobRSTG4kcVDM+J3GRVOSAwhPaAtn48HgB3qWLn9b1/YTloVcZMZz4IBN72jwk3ii2lxdflpusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOR0PLTfBr5/ZpCHcAjVU+kO5WwEbe+Lz4PdgZ1yAMo=;
 b=LfE3o1cs4Oi8Kce7pDcZZZAWtM74BR2FnuLxIam+K+Eg2CrEyCEx5fRwKyIBsmJAGngLKlQzU3umMQWs8WGCsqrOhXg0Y7J2v/uzhRpZyEMp27C9Us2NPzW71gmtqyf/ftyJPvka6zQDPePQSOAQhCzybj0tvxyng59uOWJ5SE5reSAWUAkAzKxuBa8/wSMuPXvI4wlVpTkmhKy3+HP5JD6adT5pgwQunV9lxyjRCDyX22OVA95KTlHVdTJFXe1YN1qKmxTB74muODkhle0FnrOkzTSr6CRoviS9k9g1vRqTDu3b3O43zr1PMaRLdjoq5IGcy5IZllcohIOFYTLyCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3864.namprd15.prod.outlook.com (2603:10b6:5:2b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Sat, 13 Aug
 2022 22:50:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5525.010; Sat, 13 Aug 2022
 22:50:31 +0000
Message-ID: <c5d5bfbc-3b25-dad2-450d-405f4b28272d@fb.com>
Date:   Sat, 13 Aug 2022 15:50:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Test parameterized task
 BPF iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220811001654.1316689-1-kuifeng@fb.com>
 <20220811001654.1316689-4-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220811001654.1316689-4-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0144.namprd04.prod.outlook.com
 (2603:10b6:303:84::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98650c38-d57e-4a79-84d3-08da7d7e39cf
X-MS-TrafficTypeDiagnostic: DM6PR15MB3864:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYPBnsd8FHMN8XCQB9zaCiYaZSd1Zw+h8cmnuDPdoh8puQEF2hhAB0GZcx0bGay+2J4QZoNUkKvXaVINlH7XnIewsueyTdo89hidVwAi4oxt9QIT30wV7+89YDxXX7qTJZ1oHxhEsPUSiZwMtHvTkDDifJJrtWV9Sb4MjSm3nPGOi4i9YLl4Km1vqoiEKQFXmyoi4Zn5Ts3w5SzbKp6KMCYUrZgyChmVf/o9VEXxdmGq9MpnOl4oLh6v09dyJ0qihFbR7VRRGhYG0Wpiwt+udzRLIq78xJquX1ArblaJwOlpQ/OMiQRTwy26sjdGm5W37gYsJ/75Bnw3WUYOubb5aRu5IzxkpcZVyT1ev9rCYk0l9/Hng86PSfSyWawxEST6ramzIBw1dGS3tmuJvpWKP0/bmko611tS5harQdyK6alrJI+WifD071/F0ZK9Mw240vZ8Dq/ErxFsmEd87qMcAWq6dZErUfzUV0SxTuHJfZHzvsYRIllonQjyyfNrkoyD//S+FbNjVs6y8vLfzsZ3V+fMUkPyERw68tzWrM1BsMJWwu5Gq98XJcjIqMKpDQxX9LGrXaP9nKw7aPfnBC+1TjdIMK0pMEM2F8rqDLWomMmmR5yA95kj9VCYl1VfENxDZd8QzSEooYf6vmarduBD389ylslDHY4+DlQYHS7cZBB2q7tdnew7uHk8awgg5PUWVc8uwmUcWtKQFi82MbF+30hz1x5TpoJNUxW2EB3NRTSgodmCblkBecJ6wLkI4NUo6JcqJoYU/te52r6fqKLLXU6Qrrs95hg34P+XWGKX/N8UMmwsgMjfFDg6rdU3BM9I/EZSMU7JDz/t8Rs0Mj3t7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(53546011)(316002)(6506007)(36756003)(6636002)(83380400001)(6512007)(41300700001)(31686004)(2616005)(186003)(478600001)(2906002)(86362001)(6486002)(30864003)(31696002)(5660300002)(8936002)(66556008)(8676002)(66476007)(38100700002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGtpdHhGU3NnS1R2QmZwNnFlWXVnTlZZbndEb3QwVHNtUWpoTVl4cG9nMHRo?=
 =?utf-8?B?SWU2V1ZQNVgzUjRyYUM3d2pFUkhwYnNvV3EzdXZLMW05WUxwNGZIenNzNTVS?=
 =?utf-8?B?bjh0QUlCUVBzRUwzNGxzQTNyaDE2dWJlYUY1d1ZuUXk3czJ1L05OdUNtMXM5?=
 =?utf-8?B?aVpBQ2kwWHY2TTFidkJ4R2Iyc1czcG0xcHVUeEFqT3J5T1Y1bHNJYldMRmdZ?=
 =?utf-8?B?VDB0ckVGT1Zkb0N0UFZ1U1dRT2xBVmNGNndjZnJMaVJlK3FiVW9tN04vUHUr?=
 =?utf-8?B?VDFycFZSdWx3K3YwVTZoWmI5SlArN0xOeXFoOExXaW4vdDNKbGFldmhoNDZm?=
 =?utf-8?B?ZlkrTm85SlNQZ2V6L1RuNkRwNXhnN2E3Qi9wQmoxQTQyL0VXSkxxQkljNDU2?=
 =?utf-8?B?cTZMMWdPMkxZcUt6ZlJUUVJ3bm5ZWnJLMjQ3SHNBNjFyR3hhMlZHdlhxckts?=
 =?utf-8?B?dEJkRlhqcHRXVTdSZDlCdXNIekI5MHB5NGdKdkJsWnZCMFVUbGJFOEpuelI1?=
 =?utf-8?B?bnlSVi85Z0t5ZUhyRThIdVdMeTJoK284V2RwZG54ZXh1bDJ1Mk5ZUXIyVU10?=
 =?utf-8?B?VEJLWUNuZERMOVowODZWankvNG5rQmxXNUY5ZzRJc2JCTkpibjh6L1FXaXFU?=
 =?utf-8?B?OGlwNm03Z2FwbWtqMnhYdksyb01SU1dZaWpCNUFmdndSMmo5bzhycHAyZDZp?=
 =?utf-8?B?Yk0xRUxPbEQ0RUh0ei9aZ0dwY0FoaXE1d3JScnBjdS80Q3RscDhVUFhaYzlh?=
 =?utf-8?B?NjRVenBYVzBzc2QrZkQ3RHYrSFNXV0pROCtoc2VQamRvbHR5NWRDWHVoZHFW?=
 =?utf-8?B?bk1jWDJtODBsMjBjK21XSzgxSys3M2NHckJwcDZBRWVXTUtyemVKZ1FHaUZM?=
 =?utf-8?B?VVZOZTI3T082UnFzZ1hIQkxhMmJUeXYwU1Yvb1QwTjl6Sm10OGd1YTNCRk82?=
 =?utf-8?B?R3ZTQmtlRTdCand6WTJ3N2R3UEVlelo5SWtaYWNyTCt1UmJGdnhLTlh1cjVm?=
 =?utf-8?B?akp0ME1HNXhuTDNBQmpWWGFhMjNyS25RU1ZIRTlZVXphNnlmZ01DMld3MDNJ?=
 =?utf-8?B?L2wrakZjSkdNcFFCMXNhL1FMK1YwRW8wbHdYS0xyVVFmR0RiR1dnQkZpTU92?=
 =?utf-8?B?Tzl0REtiODQ1cEpsczBRbUR3Mmh5TEZtWjdxV21NSTgyenYvVnVNY2l5UUFS?=
 =?utf-8?B?MFJpNnRuN2lGT1JWQnQ4c1BXYjRmU05OK01JR3hZWTVLeVpHSVMrNWlScWtW?=
 =?utf-8?B?MlhEVkRiWWJlaWs1ZWkxdDk4cXBKSUM5YVE0bW5DZ1BXSlZjL2puQXFFN0hO?=
 =?utf-8?B?OXgrTllHRDNGOHNDbE80S0tQRm9NbW5QYkYzK1ZmZmp1S1IvaEFGWUJJVXZN?=
 =?utf-8?B?NWRkWDQ1VnlwNzhGd0VNVTdpV2JYcmNNQVNZNVdadGd3S2hvRWtld2pIZ1VI?=
 =?utf-8?B?ZXI4OWVzWHJSMXdtbCtrYmNlN1piMTJhSy80b3VHNlJnZTY1eDJ4WExHaHR2?=
 =?utf-8?B?WlBCa2QxNGpydEhtNGdlVjdCdEVSTzNxaEtmTTlPOW1tUmxTWWVrMy9EeXpN?=
 =?utf-8?B?T3NCY2tnMFNzSGRTZXE2dXIwc1VGYXJiSVY2eFZBRXo0RUk1VXJmc3o0Q0xL?=
 =?utf-8?B?SkM1VllrcnZ2SEZFM0xOR2lQR1FFVWh0alhDV0VjVCtUSnJSOW56ZG94NVdY?=
 =?utf-8?B?aEJBSjB3SFBnbW5uOFpVeU0wWHRvcWxMbENRMDkxd0h0Q1puQXAvQTVRK1dt?=
 =?utf-8?B?U2UzMmdxOVREM0JSYkhkNjUwR05MSGpyMm5xeGFvVE5uR0s4UUV5VWtod1JZ?=
 =?utf-8?B?UkducTJ3OVkvSnpuZE95cDhMMHpqUC9xOHh6RklnOW9Yb1BMUThRZk9leXk2?=
 =?utf-8?B?b3I0ejZGQ2NscXNSbEhLYURXSmFlOVpjWElZNFRsRllTcHozTXZWdjNRb3Rq?=
 =?utf-8?B?ZkZzR3pUQ1dFdEFaY3FLRlVIVVl3NmRUaytKSk5vblIzeWdrV0dBeVBjY3ph?=
 =?utf-8?B?WUpUaWl1YnBKcFp5NlhWRGdTZGQ5SFp6b2FTY0s5WWdUM0JiY1hKSUFYOVE5?=
 =?utf-8?B?aHJ5ZFU1eFlxaFFKcGpjOGxJQ01vbUxnMFdGSFZRc3B4bWd2UEhob2g4Q2hy?=
 =?utf-8?B?WkZTL1N6STFpTElMMEhqVS9QcENBR29Qa3RiajZWWnNQaDN3VHNhSzRmSmRL?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98650c38-d57e-4a79-84d3-08da7d7e39cf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 22:50:31.6536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPT8o4RrhR9Ejs7cjYUXV8/08C/rotw6gDxN7f57xX+hih/8YGnWBdkCXg1Vx2Mx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3864
X-Proofpoint-ORIG-GUID: g6RrIfPAoyUSTAnyeMjG2YIEOwyypG64
X-Proofpoint-GUID: g6RrIfPAoyUSTAnyeMjG2YIEOwyypG64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-13_11,2022-08-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/10/22 5:16 PM, Kui-Feng Lee wrote:
> Test iterators of vma, files, and tasks of tasks.
> 
> Ensure the API works appropriately to visit all tasks,
> tasks in a process, or a particular task.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>   .../selftests/bpf/prog_tests/bpf_iter.c       | 204 ++++++++++++++++--
>   .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
>   .../selftests/bpf/progs/bpf_iter_task.c       |   9 +
>   .../selftests/bpf/progs/bpf_iter_task_file.c  |   7 +
>   .../selftests/bpf/progs/bpf_iter_task_vma.c   |   6 +-
>   5 files changed, 203 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index a33874b081b6..e66f1f3db562 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -1,6 +1,9 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright (c) 2020 Facebook */
>   #include <test_progs.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +#include <signal.h>

do we need unistd.h and signal.h?

>   #include "bpf_iter_ipv6_route.skel.h"
>   #include "bpf_iter_netlink.skel.h"
>   #include "bpf_iter_bpf_map.skel.h"
> @@ -42,13 +45,13 @@ static void test_btf_id_or_null(void)
>   	}
>   }
>   
> -static void do_dummy_read(struct bpf_program *prog)
> +static void do_dummy_read(struct bpf_program *prog, struct bpf_iter_attach_opts *opts)
>   {
>   	struct bpf_link *link;
>   	char buf[16] = {};
>   	int iter_fd, len;
>   
> -	link = bpf_program__attach_iter(prog, NULL);
> +	link = bpf_program__attach_iter(prog, opts);
>   	if (!ASSERT_OK_PTR(link, "attach_iter"))
>   		return;
>   
> @@ -91,7 +94,7 @@ static void test_ipv6_route(void)
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_ipv6_route__open_and_load"))
>   		return;
>   
> -	do_dummy_read(skel->progs.dump_ipv6_route);
> +	do_dummy_read(skel->progs.dump_ipv6_route, NULL);
>   
>   	bpf_iter_ipv6_route__destroy(skel);
>   }
> @@ -104,7 +107,7 @@ static void test_netlink(void)
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_netlink__open_and_load"))
>   		return;
>   
> -	do_dummy_read(skel->progs.dump_netlink);
> +	do_dummy_read(skel->progs.dump_netlink, NULL);
>   
>   	bpf_iter_netlink__destroy(skel);
>   }
> @@ -117,24 +120,139 @@ static void test_bpf_map(void)
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_map__open_and_load"))
>   		return;
>   
> -	do_dummy_read(skel->progs.dump_bpf_map);
> +	do_dummy_read(skel->progs.dump_bpf_map, NULL);
>   
>   	bpf_iter_bpf_map__destroy(skel);
>   }
>   
> -static void test_task(void)
> +static int pidfd_open(pid_t pid, unsigned int flags)
> +{
> +	return syscall(SYS_pidfd_open, pid, flags);
> +}
> +
> +static void check_bpf_link_info(const struct bpf_program *prog)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	union bpf_iter_link_info linfo;
> +	struct bpf_link_info info = {};
> +	__u32 info_len;
> +	struct bpf_link *link;
> +	int err;

Reverse christmas tree style?

> +
> +	memset(&linfo, 0, sizeof(linfo));
> +	linfo.task.tid = getpid();
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +
> +	link = bpf_program__attach_iter(prog, &opts);
> +	if (!ASSERT_OK_PTR(link, "attach_iter"))
> +		return;
> +
> +	info_len = sizeof(info);
> +	err = bpf_obj_get_info_by_fd(bpf_link__fd(link), &info, &info_len);
> +	if (ASSERT_OK(err, "bpf_obj_get_info_by_fd"))
> +		ASSERT_EQ(info.iter.task.tid, getpid(), "check_task_tid");
> +
> +	bpf_link__destroy(link);
> +}
> +
> +static pthread_mutex_t do_nothing_mutex;
> +
> +static void *do_nothing_wait(void *arg)
> +{
> +	pthread_mutex_lock(&do_nothing_mutex);
> +	pthread_mutex_unlock(&do_nothing_mutex);
> +
> +	pthread_exit(arg);
> +}
> +
> +static void test_task_(struct bpf_iter_attach_opts *opts, int num_unknown, int num_known)

The function test_task_ name is weird. Maybe test_task_common?

>   {
>   	struct bpf_iter_task *skel;
> +	pthread_t thread_id;
> +	void *ret;
>   
>   	skel = bpf_iter_task__open_and_load();
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
>   		return;
>   
> -	do_dummy_read(skel->progs.dump_task);
> +	if (!ASSERT_OK(pthread_mutex_init(&do_nothing_mutex, NULL), "pthread_mutex_init"))
> +		goto done;
> +	if (!ASSERT_OK(pthread_mutex_lock(&do_nothing_mutex), "pthread_mutex_lock"))
> +		goto done;
> +
> +	if (!ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL),
> +		  "pthread_create"))
> +		goto done;
> +
> +
> +	skel->bss->tid = getpid();
> +
> +	do_dummy_read(skel->progs.dump_task, opts);
> +
> +	if (!ASSERT_OK(pthread_mutex_unlock(&do_nothing_mutex), "pthread_mutex_unlock"))
> +		goto done;
> +
> +	if (num_unknown >= 0)
> +		ASSERT_EQ(skel->bss->num_unknown_tid, num_unknown, "check_num_unknown_tid");
> +	if (num_known >= 0)
> +		ASSERT_EQ(skel->bss->num_known_tid, num_known, "check_num_known_tid");
>   
> +	ASSERT_FALSE(pthread_join(thread_id, &ret) || ret != NULL,
> +		     "pthread_join");
> +
> +done:
>   	bpf_iter_task__destroy(skel);
>   }
>   
> +static void test_task(void)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	union bpf_iter_link_info linfo;
> +
> +	memset(&linfo, 0, sizeof(linfo));
> +	linfo.task.tid = getpid();
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +
> +	test_task_(&opts, 0, 1);
> +
> +	test_task_(NULL, -1, 1);
> +}
> +
> +static void test_task_tgid(void)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	union bpf_iter_link_info linfo;
> +
> +	memset(&linfo, 0, sizeof(linfo));
> +	linfo.task.tgid = getpid();
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +
> +	test_task_(&opts, 1, 1);
> +}
> +
> +static void test_task_pidfd(void)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	union bpf_iter_link_info linfo;
> +	int pidfd;
> +
> +	pidfd = pidfd_open(getpid(), 0);
> +	if (!ASSERT_GE(pidfd, 0, "pidfd_open"))
> +		return;
> +
> +	memset(&linfo, 0, sizeof(linfo));
> +	linfo.task.pid_fd = pidfd;

In kernel, pidfd has to be > 0 to be effective.
So in the above, you should use ASSERT_GT instead of
ASSERT_GE. For test_progs, pidfd == 0 won't happen
since the program does not close stdin.

> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +
> +	test_task_(&opts, 1, 1);
> +
> +	close(pidfd);
> +}
> +
>   static void test_task_sleepable(void)
>   {
>   	struct bpf_iter_task *skel;
> @@ -143,7 +261,7 @@ static void test_task_sleepable(void)
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
>   		return;
>   
> -	do_dummy_read(skel->progs.dump_task_sleepable);
> +	do_dummy_read(skel->progs.dump_task_sleepable, NULL);
>   
>   	ASSERT_GT(skel->bss->num_expected_failure_copy_from_user_task, 0,
>   		  "num_expected_failure_copy_from_user_task");
> @@ -161,8 +279,8 @@ static void test_task_stack(void)
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_stack__open_and_load"))
>   		return;
>   
> -	do_dummy_read(skel->progs.dump_task_stack);
> -	do_dummy_read(skel->progs.get_task_user_stacks);
> +	do_dummy_read(skel->progs.dump_task_stack, NULL);
> +	do_dummy_read(skel->progs.get_task_user_stacks, NULL);
>   
>   	bpf_iter_task_stack__destroy(skel);
>   }
> @@ -174,7 +292,9 @@ static void *do_nothing(void *arg)
>   
>   static void test_task_file(void)
>   {
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
>   	struct bpf_iter_task_file *skel;
> +	union bpf_iter_link_info linfo;
>   	pthread_t thread_id;
>   	void *ret;
>   
> @@ -188,15 +308,31 @@ static void test_task_file(void)
>   		  "pthread_create"))
>   		goto done;
>   
> -	do_dummy_read(skel->progs.dump_task_file);
> +	memset(&linfo, 0, sizeof(linfo));
> +	linfo.task.tid = getpid();
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +
> +	do_dummy_read(skel->progs.dump_task_file, &opts);
>   
>   	if (!ASSERT_FALSE(pthread_join(thread_id, &ret) || ret != NULL,
>   		  "pthread_join"))
>   		goto done;
>   
>   	ASSERT_EQ(skel->bss->count, 0, "check_count");
> +	ASSERT_EQ(skel->bss->unique_tgid_count, 1, "check_unique_tgid_count");
>   
> -done:
> +	skel->bss->count = 0;
> +	skel->bss->unique_tgid_count = 0;
> +
> +	do_dummy_read(skel->progs.dump_task_file, NULL);
> +
> +	ASSERT_GE(skel->bss->count, 0, "check_count");
> +	ASSERT_GE(skel->bss->unique_tgid_count, 1, "check_unique_tgid_count");

This is not precise. ASSERT_EQ will be better, right?
Maybe reset last_tgid as well?

> +
> +	check_bpf_link_info(skel->progs.dump_task_file);
> +
> + done:
>   	bpf_iter_task_file__destroy(skel);
>   }
>   
> @@ -274,7 +410,7 @@ static void test_tcp4(void)
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_tcp4__open_and_load"))
>   		return;
>   
> -	do_dummy_read(skel->progs.dump_tcp4);
> +	do_dummy_read(skel->progs.dump_tcp4, NULL);
>   
>   	bpf_iter_tcp4__destroy(skel);
>   }
> @@ -287,7 +423,7 @@ static void test_tcp6(void)
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_tcp6__open_and_load"))
>   		return;
>   
> -	do_dummy_read(skel->progs.dump_tcp6);
> +	do_dummy_read(skel->progs.dump_tcp6, NULL);
>   
>   	bpf_iter_tcp6__destroy(skel);
>   }
> @@ -300,7 +436,7 @@ static void test_udp4(void)
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_udp4__open_and_load"))
>   		return;
>   
> -	do_dummy_read(skel->progs.dump_udp4);
> +	do_dummy_read(skel->progs.dump_udp4, NULL);
>   
>   	bpf_iter_udp4__destroy(skel);
>   }
> @@ -313,7 +449,7 @@ static void test_udp6(void)
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_udp6__open_and_load"))
>   		return;
>   
> -	do_dummy_read(skel->progs.dump_udp6);
> +	do_dummy_read(skel->progs.dump_udp6, NULL);
>   
>   	bpf_iter_udp6__destroy(skel);
>   }
> @@ -326,7 +462,7 @@ static void test_unix(void)
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_unix__open_and_load"))
>   		return;
>   
> -	do_dummy_read(skel->progs.dump_unix);
> +	do_dummy_read(skel->progs.dump_unix, NULL);
>   
>   	bpf_iter_unix__destroy(skel);
>   }
> @@ -988,7 +1124,7 @@ static void test_bpf_sk_storage_get(void)
>   	if (!ASSERT_OK(err, "bpf_map_update_elem"))
>   		goto close_socket;
>   
> -	do_dummy_read(skel->progs.fill_socket_owner);
> +	do_dummy_read(skel->progs.fill_socket_owner, NULL);
>   
>   	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
>   	if (CHECK(err || val != getpid(), "bpf_map_lookup_elem",
> @@ -996,7 +1132,7 @@ static void test_bpf_sk_storage_get(void)
>   	    getpid(), val, err))
>   		goto close_socket;
>   
> -	do_dummy_read(skel->progs.negate_socket_local_storage);
> +	do_dummy_read(skel->progs.negate_socket_local_storage, NULL);
>   
>   	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
>   	CHECK(err || val != -getpid(), "bpf_map_lookup_elem",
> @@ -1116,7 +1252,7 @@ static void test_link_iter(void)
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_link__open_and_load"))
>   		return;
>   
> -	do_dummy_read(skel->progs.dump_bpf_link);
> +	do_dummy_read(skel->progs.dump_bpf_link, NULL);
>   
>   	bpf_iter_bpf_link__destroy(skel);
>   }
> @@ -1129,7 +1265,7 @@ static void test_ksym_iter(void)
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_ksym__open_and_load"))
>   		return;
>   
> -	do_dummy_read(skel->progs.dump_ksym);
> +	do_dummy_read(skel->progs.dump_ksym, NULL);
>   
>   	bpf_iter_ksym__destroy(skel);
>   }
> @@ -1154,7 +1290,7 @@ static void str_strip_first_line(char *str)
>   	*dst = '\0';
>   }
>   
> -static void test_task_vma(void)
> +static void test_task_vma_(struct bpf_iter_attach_opts *opts)

test_task_vma_common?

>   {
>   	int err, iter_fd = -1, proc_maps_fd = -1;
>   	struct bpf_iter_task_vma *skel;
> @@ -1166,13 +1302,14 @@ static void test_task_vma(void)
>   		return;
>   
>   	skel->bss->pid = getpid();
> +	skel->bss->one_task = opts ? 1 : 0;
>   
>   	err = bpf_iter_task_vma__load(skel);
>   	if (!ASSERT_OK(err, "bpf_iter_task_vma__load"))
>   		goto out;
>   
>   	skel->links.proc_maps = bpf_program__attach_iter(
> -		skel->progs.proc_maps, NULL);
> +		skel->progs.proc_maps, opts);
>   
>   	if (!ASSERT_OK_PTR(skel->links.proc_maps, "bpf_program__attach_iter")) {
>   		skel->links.proc_maps = NULL;
> @@ -1211,12 +1348,29 @@ static void test_task_vma(void)
>   	str_strip_first_line(proc_maps_output);
>   
>   	ASSERT_STREQ(task_vma_output, proc_maps_output, "compare_output");
> +
> +	check_bpf_link_info(skel->progs.proc_maps);
> +
>   out:
>   	close(proc_maps_fd);
>   	close(iter_fd);
>   	bpf_iter_task_vma__destroy(skel);
>   }
>   
> +static void test_task_vma(void)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	union bpf_iter_link_info linfo;
> +
> +	memset(&linfo, 0, sizeof(linfo));
> +	linfo.task.tid = getpid();
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +
> +	test_task_vma_(&opts);
> +	test_task_vma_(NULL);
> +}
> +
[...]
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
> index 4ea6a37d1345..44f4a31c2ddd 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
> @@ -20,6 +20,7 @@ char _license[] SEC("license") = "GPL";
>   #define D_PATH_BUF_SIZE 1024
>   char d_path_buf[D_PATH_BUF_SIZE] = {};
>   __u32 pid = 0;
> +__u32 one_task = 0;
>   
>   SEC("iter/task_vma") int proc_maps(struct bpf_iter__task_vma *ctx)
>   {
> @@ -33,8 +34,11 @@ SEC("iter/task_vma") int proc_maps(struct bpf_iter__task_vma *ctx)
>   		return 0;
>   
>   	file = vma->vm_file;
> -	if (task->tgid != pid)
> +	if (task->tgid != pid) {
> +		if (one_task)
> +			BPF_SEQ_PRINTF(seq, "unexpected task (%d != %d)", task->tgid, pid);

This doesn't sound good. Is it possible we add a global variable to 
indicate this condition and do an ASSERT in bpf_iter.c file?

>   		return 0;
> +	}
>   	perm_str[0] = (vma->vm_flags & VM_READ) ? 'r' : '-';
>   	perm_str[1] = (vma->vm_flags & VM_WRITE) ? 'w' : '-';
>   	perm_str[2] = (vma->vm_flags & VM_EXEC) ? 'x' : '-';
