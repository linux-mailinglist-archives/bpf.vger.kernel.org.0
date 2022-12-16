Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC3C64F2CE
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 21:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLPU4S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 15:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLPU4R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 15:56:17 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A987B8FC6
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 12:56:15 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGJxOvo003557;
        Fri, 16 Dec 2022 12:55:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ZZi5LzEjT93UoijX+j45u3ccfAORfDOyerEEvehRMP0=;
 b=TRrW4+GxZbJNK1esbmZMOpoT2EyrccvydzsI8i7MjE7T5x9Ojl9VCPYzzFWMyO5uVxeV
 JfkQLqmUbr0PZrFbbx1Ho31yLz5TC2bPMasNdR/8TEIpZpLEkjO4jIOIstzYkG6M9QsX
 +WdzyBkcersl6+3bYrIv4TYN1j7vrZ7rzzW02c3reOs5mAHVycUrogAkpbGslH/esFH4
 TEJhlGJPsWu8vUZ1mwgTzkN00/K/cn7vgdRGSRa5xjN/TbuHMUBnzDCNm0Cvz0KPQEpr
 JWG0vP4rXPD17Rz8jzte5ep5luZsPSb+WURTUkVox5eWW298YUZVsz6ZsmZgGGgYjk3X +g== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mgdt16mq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 12:55:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQVQO1imJiiWOlEUPinHMqz767UHe0ivnKFssojihquscf5jLmoTm7sufipqs+FnRn6ndQxARgtYqPtvsCBQw5AI/Wlfa3qnMNAoPafZEUP1yB27Y0VdvepSQATi14ZtakL0yzuVHljUdjxijDUnQAxlX6SoK14a2mwJIanbgXB6XaY7FLzaE9KzOCfyJUyQ4+8N8ydgB7jl69+UmeMWbv9D5DeEHlrluSlMpL8rcnJIzAeNm+JNXofqjxT+aCzdB29mg/tpJvo0eS3Slzgc59TJ67rk/I3bo82w/8jUHkidX5+dZktqnPkhEnAEGdfsvqNAikOVR4OyFtlIL5qmRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZi5LzEjT93UoijX+j45u3ccfAORfDOyerEEvehRMP0=;
 b=g4Ge/3jZjiGRmX99YCn0/q0d74bKj5K8p3m4BPchXeof/KX0ySZ/3MdzoFqnQDLTh8n+6x412zlE5toZD3kLhGHxbtLgAU3JWEU3g6D/YG5htIGekAd9J5oREWSsnu8xktAey+lEwtgBEgG5ADOEoTnf9mCkNI8M/9Ti+hWyWXK1zAmogey0gk8h1GZG5dfuR7PkefUbgXul8uKVthRZ3xRgjGpy8j+ZwQ2JiVcn1rNG8bbCqXRejzQtlC6tSQhHfd7nASHWEIVsa+CN80LrQgSGUOryzoTmX/kPi1craTtsf0FyyXyBRYva6Q0bxSDc7ziOaWC4i8eOOVf2aHIrKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH7PR15MB5498.namprd15.prod.outlook.com (2603:10b6:510:1f5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Fri, 16 Dec
 2022 20:55:56 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.015; Fri, 16 Dec 2022
 20:55:56 +0000
Message-ID: <517c48e2-6183-b5d9-e167-bdbb52a042f8@meta.com>
Date:   Fri, 16 Dec 2022 12:55:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add verifier test
 exercising jit PROBE_MEM logic
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
References: <20221216183122.2040142-1-davemarchevsky@fb.com>
 <20221216183122.2040142-2-davemarchevsky@fb.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221216183122.2040142-2-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH7PR15MB5498:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a3fffb-4a70-4e88-d2a1-08dadfa7ed5e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0eAWm1A98C+p0H1E+128OKttLDj1376XwGjxu39y3rytjbeEWB+hKlHOHULamLsNcPcOU1N9EuGF+LLH5TY+ipV4hasqIyiRzYelJJNdD8lBymxpnOP7knEcBc5uOLpVT4K5Nt3oGaKtomk+oPOZdrHVn82geJylS6k27E2dNWNhbFEsxf920K9l3xd37RBjQ3bqqgWznwQ4IFY7TQCdD7vuxPoEU8NUZnw+LoxE3fDTkq2fR49HvMK0H33etKjQdtj+wL5ZU2Os1ibQzfUyMi6NsF0zNR5GLUL/fmpR5loQwS/+Cfrl5vtmYHWe+0YuyjE2L5oe3U7Sm2vPro2Y/aD8A+hzHflVlOr/VpkT6vjrlsiVysdGv/N9LyPD3twa9q+txZaDxcx0EyyeutvyFij2RngIhV1DXBRnvpTkQA7zVW6riCde8D00kCAutLdTJ+IxvHJXdeTuhSJF1T6NI7KcsDUij9HQE5OSsItWmCAHDsd/BmJv/fQjt0zBILH6sUWoTioOGrS1RopMdvLsmXYBZKP9G78x9xtu4GiO9HAgwsomm5vupZ2uZ5RJjDULkTNEQmaAgKoxmEqLqELUZxYv3d7P66bF755a9XlO078nTbNF1r/ttYoSwgMPhbKN9rTX1gbO+xSxbYLv2IDu6YCcJ5/6G7S4iJdIJR9N+D5KLFQwsPK1aB70O/kphgBIL88qJj8zp1mrl74EA1iAR5ts4FVglu/oYD7bDrpbD0RFL4AWVu/CoxeFAUWK4WmR4XW1YAN9SQbPpezw++tDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199015)(83380400001)(2616005)(86362001)(31696002)(478600001)(4326008)(41300700001)(66556008)(6512007)(66476007)(53546011)(54906003)(186003)(6486002)(6506007)(8676002)(6666004)(38100700002)(5660300002)(2906002)(66946007)(316002)(8936002)(84970400001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXZUc0RxTWRnODdGeVhYb3RJM1dRcGVrSmlHc1F6RVFSNlljc3Q2aWt4cW1m?=
 =?utf-8?B?VFc5dE1QMFQ2TnhXRTVSRFQ4MW1qZjlxTW5YYysrbmo5ODlabUhPZ1BjRUVW?=
 =?utf-8?B?dnR6R0p5NHJleFcyY2lCMTVwTXZlb09TUmd2RHRrdnp2VGpVUFZrb290T2ZC?=
 =?utf-8?B?L3JuZ3pURFRUZnJkSElGTUFwdFhZU2d5cjVpUWhNcWlQMGVpeTFaMXBaTUt2?=
 =?utf-8?B?MjJGQ09OdVFTTzAvN0E2ZEhkNFJBNnRqVXhoTFlGYkNvTStOUnBDOFp6K0hI?=
 =?utf-8?B?QUphUG5wd3UzVkkvOWNpS0x2NFB2d1g2bzBMS0xTVEtjdTdjSUpqZWV1aEZB?=
 =?utf-8?B?MTB6NWlHMU5hS0NBSWc1K3BJUlFWcTlmY1VtQ0dZSE5sWVhtWno1bFgxSkx0?=
 =?utf-8?B?YXQ0YW9Zdm9SdlNuSjNKbmhKTjZKMy9aeTR5YkEwaEM2bG5ydUMwTFc1dWF3?=
 =?utf-8?B?dEpLWTNLWFBtZ0NQVklVSmdIQWJFTkFBbkVaalBPN09ObVJBb0tkVUtsVXpD?=
 =?utf-8?B?WGZtSlBPZFdxVCtkSWR3TjFDTm9yTVJuM2srYytpcWVIQy9Sb2J5TTJyaGU5?=
 =?utf-8?B?cVdpQWhkdUNKR05JZUtJRnNtMzFYV2VIRlhoS0FqM1ZwQUQwMHd1a25yK3Mx?=
 =?utf-8?B?WEVGS1htc2dqUEFCWHBVUDc4UlljbEowQmE3cGZoSnVuVGNWUWF5Rm1EeHkv?=
 =?utf-8?B?a2d5NEg3VFZUWHRBbnRUbDJKdFYrTDQ3Y3FXcDUxQUtlNXY5c1haQnR6cmFG?=
 =?utf-8?B?SGowaTVHTFNxMlBFZ2cySHBoekpFZlhRM2I3SjQwNlo1b3o5TnpsQjF4cjRy?=
 =?utf-8?B?d29PTXM3Z3gwdkZFUDdmS2owL1VHN0JJcW9KMW56UmRsdmNhVVpQcmpFZnBP?=
 =?utf-8?B?YkxPQ2VTRHNNMEhFRnpNenpCOFpxclJHN1o1Ny8zSkM2L09OL0N6alRoTk0w?=
 =?utf-8?B?UEJMY1pCaHlFdWNuclpZQWFmUXpGckZGWnkyMkY5MGtuWkdjZm9qS2JHYmJZ?=
 =?utf-8?B?VDdzTmtUZEdFSkUrYXIyc0pjUENnMWtGSS9SNFVnT0dVcERxY1Y2QW9pcXhG?=
 =?utf-8?B?MldCK25JRVBDTzUwZXlXRzF5WFRPeWovZkpYU3lPQnR0K1RuOElKbkh2SUw1?=
 =?utf-8?B?a1BGbVpvL21HMUtqalI2OEU5UDNwNU9LeksvMFhqWFIrZEhZWE8vRitXbE1q?=
 =?utf-8?B?Mm5uUlUwQW44R2l5R1BhRmdNbmNid0FxdzBHQ3BOQ0xnYmdJdWFlcDg5R1V4?=
 =?utf-8?B?akx6bU4yaTVvRkdiSzB2TmxmTG42Z3QwQ05WbkVsRVVqWmRRL1ZxeDZROWN6?=
 =?utf-8?B?NkpZbndjVjA1c1ZZL05PKzBYazhMYWZtY1VnWG5saVZkbkVTK2dNQVVmZjZO?=
 =?utf-8?B?c1FVb3dPdklNUGs3SGhDRlVmNmtMTDNBUHNBY2VyTHZOUVgxK2toTGFsNHhi?=
 =?utf-8?B?SXgzSjdxZlJSRmdJNEpwVVhEWGhVSThMcmh3cmUxWVU2MDdXeS9DY3lqcGxS?=
 =?utf-8?B?NHVLY2pJTkEvdTdMQXVKTmJwYzBrWmNjdTFaVkRReFB2TnFQV2dPUHBXN0hY?=
 =?utf-8?B?UVhWbElaK2xzWllBVFlLakVlcXFmQlFDKzZUTi9lQlRRckxwbG5kNUZKbnFQ?=
 =?utf-8?B?NlpQQTlEVkZqcHJZMG5xSW83MlFGbEloVzhwNnI3SE1TRTdqWWdEQThHU2U3?=
 =?utf-8?B?TFMwUU8zeDJoNFQ2YjY4ajhRWDcwVzlpZGJ2MVhjVXdVdlNGOFBnbk5aRSsx?=
 =?utf-8?B?dGErMnFJeXdNTkxvVUI2KzhKK281M0oxc2tqZ3FFRnpwdXBhYk9tWmo0MWtQ?=
 =?utf-8?B?MXBXYm9DZzFvd1RTNGVPbFVHa2lDdWE0bWkwS2U5ZDg4cjFTd1JCcnRSTWpD?=
 =?utf-8?B?SGRxQUdGN0lYcHVHZm9vb3BycEJ3ajM5RkFhSk1ET29CZFhWSkJTVHRHTUhQ?=
 =?utf-8?B?R3MvcTFBcWxnQWhtQm5maHFDclkwL2ttdkthODQyVE8xRzB0MjZTaFl3OTho?=
 =?utf-8?B?RUR0SlFLTzQ5ejA3RlNOWXcxMGFCdjcybDFZdFVvU1I0SW5OZVVQbmh2TXFU?=
 =?utf-8?B?dGtYMWtaTmR3SFZ5TG0vcERVekxxd04yS21zNnpxa2F4cW41S2JEaDRYdHhJ?=
 =?utf-8?B?eVp0U2FRSUxCU1RMU0d2am00cUZKS2hqNnVlTXZRTnBVVDcrWDJLZGFSRWkv?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a3fffb-4a70-4e88-d2a1-08dadfa7ed5e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 20:55:56.2699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jhk4CiUecczVQT4jKG0QInchPgYVg1CWMWYsB3HZh01uzFNTZovxZBCQcw/8fPUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5498
X-Proofpoint-GUID: t3_dFVsIu-dUurLWVpUAkg_7IEw3URc6
X-Proofpoint-ORIG-GUID: t3_dFVsIu-dUurLWVpUAkg_7IEw3URc6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/16/22 10:31 AM, Dave Marchevsky wrote:
> This patch adds a test exercising logic that was fixed / improved in
> the previous patch in the series, as well as general sanity checking for
> jit's PROBE_MEM logic which should've been unaffected by the previous
> patch.
> 
> The added verifier test does the following:
>    * Acquire a referenced kptr to struct prog_test_ref_kfunc using
>      existing net/bpf/test_run.c kfunc
>      * Helper returns ptr to a specific prog_test_ref_kfunc whose first
>        two fields - both ints - have been prepopulated w/ vals 42 and
>        108, respectively
>    * kptr_xchg the acquired ptr into an arraymap
>    * Do a direct map_value load of the just-added ptr
>      * Goal of all this setup is to get an unreferenced kptr pointing to
>        struct with ints of known value, which is the result of this step
>    * Using unreferenced kptr obtained in previous step, do loads of
>      prog_test_ref_kfunc.a (offset 0) and .b (offset 4)
>    * Then incr the kptr by 8 and load prog_test_ref_kfunc.a again (this
>      time at offset -8)
>    * Add all the loaded ints together and return
> 
> Before the PROBE_MEM fixes in previous patch, the loads at offset 0 and
> 4 would succeed, while the load at offset -8 would incorrectly fail
> runtime check emitted by the JIT and 0 out dst reg as a result. This
> confirmed by retval of 150 for this test before previous patch - since
> second .a read is 0'd out - and a retval of 192 with the fixed logic.
> 
> The test exercises the two optimizations to fixed logic added in last
> patch as well:
>    * First load, with insn "r8 = *(u32 *)(r9 + 0)" exercises "insn->off
>      is 0, no need to add / sub from src_reg" optimization
>    * Third load, with insn "r9 = *(u32 *)(r9 - 8)" exercises "src_reg ==
>      dst_reg, no need to restore src_reg after load" optimization
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Ack with one nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
> v1 -> v2: lore.kernel.org/bpf/20221213182726.325137-2-davemarchevsky@fb.com
>    * Rewrite the test to be a "normal" C prog in selftests/bpf/progs. Result
>      is a much easier-to-understand test with assembly used only for the 3
>      loads. (Yonghong)
> 
>   .../selftests/bpf/prog_tests/jit_probe_mem.c  | 28 +++++++++
>   .../selftests/bpf/progs/jit_probe_mem.c       | 61 +++++++++++++++++++
>   2 files changed, 89 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/jit_probe_mem.c
>   create mode 100644 tools/testing/selftests/bpf/progs/jit_probe_mem.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/jit_probe_mem.c b/tools/testing/selftests/bpf/prog_tests/jit_probe_mem.c
> new file mode 100644
> index 000000000000..5639428607e6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/jit_probe_mem.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +
> +#include "jit_probe_mem.skel.h"
> +
> +void test_jit_probe_mem(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		.data_in = &pkt_v4,
> +		.data_size_in = sizeof(pkt_v4),
> +		.repeat = 1,
> +	);
> +	struct jit_probe_mem *skel;
> +	int ret;
> +
> +	skel = jit_probe_mem__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "jit_probe_mem__open_and_load"))
> +		return;
> +
> +	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_jit_probe_mem), &opts);
> +	ASSERT_OK(ret, "jit_probe_mem ret");
> +	ASSERT_OK(opts.retval, "jit_probe_mem opts.retval");
> +	ASSERT_EQ(skel->data->total_sum, 192, "jit_probe_mem total_sum");
> +
> +	jit_probe_mem__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/jit_probe_mem.c b/tools/testing/selftests/bpf/progs/jit_probe_mem.c
> new file mode 100644
> index 000000000000..3bb8af4df837
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/jit_probe_mem.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +
> +static struct prog_test_ref_kfunc __kptr_ref *v;
> +long total_sum = -1;
> +
> +extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
> +extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
> +
> +SEC("tc")
> +int test_jit_probe_mem(struct __sk_buff *ctx)
> +{
> +	struct prog_test_ref_kfunc *p;
> +	unsigned long zero = 0, sum;
> +
> +	p = bpf_kfunc_call_test_acquire(&zero);
> +	if (!p)
> +		return 1;
> +
> +	p = bpf_kptr_xchg(&v, p);
> +	if (p)
> +		goto release_out;
> +
> +	/* Direct map value access of kptr, should be PTR_UNTRUSTED */
> +	p = v;
> +	if (!p)
> +		return 1;
> +
> +	asm volatile (
> +		"r9 = %[p];\n"
> +		"%[sum] = 0;\n"
> +
> +		/* r8 = p->a */
> +		"r8 = *(u32 *)(r9 + 0);\n"
> +		"%[sum] += r8;\n"
> +
> +		/* r8 = p->b */
> +		"r8 = *(u32 *)(r9 + 4);\n"
> +		"%[sum] += r8;\n"
> +
> +		"r9 += 8;\n"
> +		/* r9 = p->a */
> +		"r9 = *(u32 *)(r9 - 8);\n"
> +		"%[sum] += r9;\n"

All these '\n' are not necessary.

> +
> +		: [sum] "=r"(sum)
> +		: [p] "r"(p)
> +		: "r8", "r9"
> +	);
> +
> +	total_sum = sum;
> +	return 0;
> +release_out:
> +	bpf_kfunc_call_test_release(p);
> +	return 1;
> +}
> +
> +char _license[] SEC("license") = "GPL";
