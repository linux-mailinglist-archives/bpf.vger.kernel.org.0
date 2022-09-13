Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081D95B6B92
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 12:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiIMK0Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 06:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiIMK0G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 06:26:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ECA5A15C
        for <bpf@vger.kernel.org>; Tue, 13 Sep 2022 03:26:01 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D6bikC026546;
        Tue, 13 Sep 2022 03:25:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dlB5t///jRXTcKrXZVfpy+77HUXlx2GcT+kjzwpQ1B8=;
 b=MY1cAC0IekMaIIVvzzXFMEjiw35hgX72RFZa5ldsmunisKSsp0An3Ad35a6Wn17ngnM4
 QM4jOlX3u7j0Gpg1bYWBrsPPkoQzEucY/T0qFn11xovbfxpT2oFomSdoYD0k5QtY5QUg
 br/XTBDVDPttyFV8pTzwSpYRvPmBW+qHzJs= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jjgwk2gk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 03:25:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXg+ciJ44dhMFUGUI6EQmkCahuLmtGLBvLKKGeB9uDfq1zyZ/c1kxF5ij/Xz84rgMw14g9TuKMfHbJD/CCbZv8AHAW46Kr4yNUkfbt2UGrB4IXjye3hXc1Z+NG8vrlQSVJyXSf8fcA911u3ULEw9p17Wuu0gzxYyrsN+HTK0jk5n378Zny7us0LRBaF4ofH+sUS7LuXvlj5KDdSImJhLysG+Vijojg/D9COw8Jw0oSXcLDahxFff1Fi+O8TL1GLS1dzi2BVWVnYH5oNFWzi3A4npmmjrSAI3S0SV19dNofGJfEwKMgshHehbTMToW2w7nLx01z60CmjiLxhO+CHcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlB5t///jRXTcKrXZVfpy+77HUXlx2GcT+kjzwpQ1B8=;
 b=T+C3XivjGqIMiKdXUrbGbQW0oor9OxoxVGJf9ynF6FPgOeQRKF0PHiQU9eOa/hGEtDZL2+pjYYR6GkcvAhvMeKPm5wj3bGEN2V9+DUi3sMGzY03dVS3n65oXWLe4CsccbtN3MAMPd01CRUqChkDt2mQqVwO1g94w3IKXIwwmnaeHzXlHLEi45c9bQDvpZD4OD54OwyzfHFF/hkiUhqqvJybaesQ09yErBFfAhqFzVEg/p+mALWk+JmN81Vw2taZzbSL27fEkbJ8PHcOwYZbS2nZhQB0SaYK02+FP7cf9uIcOtCffh4kfx0YT/NhEH+yc8yIXKsXTZO5dydHNtFY3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB5297.namprd15.prod.outlook.com (2603:10b6:806:235::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 10:25:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 10:25:45 +0000
Message-ID: <3f02ec3c-6998-e211-bf9f-70af325ece87@fb.com>
Date:   Tue, 13 Sep 2022 11:25:39 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow ringbuf memory to be used as map
 key
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Liam Wisehart <liamwisehart@fb.com>
References: <20220912101106.2765921-1-davemarchevsky@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220912101106.2765921-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::44) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: 88cf9db4-dd3f-4e28-c6bc-08da957251b8
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i92kC//QhZl5uGlmO2ewaPikZY8SWmm+tClBh/JXomoDqippWDYjJftJ4FbBw9psmXX33cSdc+o58htVI7jQMWEQKnLZVO2OQtw6oAI5XY5CCrckrf3MEKpvrdeTu6abV//KCmJoeGfMIS5utNyYYoyyBnP2huf5a8ZTiHByx011Y4dCoA8zQCcaGsCP8F1XFubeoMIO6AfyR/nFyCaQ79hRjUFemHDLdXoxZn4t/UXDFkLDqAyLBj/vHpPdOeSq7ozljQuRf8GDKXbogu7wkuMGv7KHZfy4kNft86EA9eIZNRZzBCafDb8TaNgsvHQVMKwiSiZ+dZv4ex6eTIaH17pk/tTM6WfLkfts1DEQYf3Y+LPgN5IAROPph6WXhZ5zg8tqesCDs0ExyDEsR8VRzVQYM72956uaYIhDbiINNYLslXuHFV1g8MjLeoFFV0MFho0qvwV4i/f3glVEhB9cfZqOKQEsJD7ho2bsR9MOXCLEo9JHUIkIZGR0JVXhO+5rp6Y/pNkNxeiZtCB2fPXsE4aA8YrfaXSdeA4HGT1rYSKBv/xUHqr7Ew62nBXnIWhSRTdBhyZW3Q0k6ts9LZ44OmfGqlP6nSEC0e4qbsaUg8JKxrmQBxfRnkj8y90ygBPLSRt7b1YpYjKe55wQiA/dcPAtF5BKyj5IWu9v1USxbw61tkgtElxLrqrhXULWi0tJbhGS09Q9noM8L281+BnPag6DPglZZWQpS9LaAhsKa/k9lSmVbz/AuEFPnNBNUavHaPTXN18oJsmUFoskydget3GskH7JnJc/RMLACkUWh7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(31696002)(66946007)(4326008)(31686004)(8676002)(186003)(66476007)(478600001)(5660300002)(66556008)(54906003)(38100700002)(86362001)(8936002)(6666004)(6512007)(41300700001)(6486002)(6506007)(53546011)(316002)(2906002)(2616005)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU5TNnV2aVNaWUkwbEFzN3NQOTNHa3U0eXRWZzBCR3Q3TTFJQ2RGM1Y1TVdh?=
 =?utf-8?B?T0xycERUb3JtZG5vZzRIR00wNVZTWk1aR1dia042OGN1RFkwR2MyWWh1VlJX?=
 =?utf-8?B?S1k2SXlGR3hTT1B3Umk0R25DRXBoMXFkYWk3eUdiT00yZW1FUTc5ZTJsYWVw?=
 =?utf-8?B?NXBPTVpjRGNjMFg2MndabjhzYmxaV1dKNGpnM1hVQ2t5WDBpVlhNdW5UT3pZ?=
 =?utf-8?B?anA4ZHAwdjRMNmVjWXZRVXpXY280VWlhbmprWUhrR3BKck1SMjRlMzNvbzA4?=
 =?utf-8?B?VGdXbkI3TjFNcnZQamlTOXpyLytaMEFVRDh3SWpnTUtSWWF5cDJ2N0tFaWNw?=
 =?utf-8?B?MVc3Yk15M1c2RjJlQTNqQXlDeUMwRHZ1aXZSYlNrYTQrT2IrMXBGRm1sMW0w?=
 =?utf-8?B?QVM1UzNxSFRlNVd0REEyWWRFdnkva2Fjb2FJRGxXWlpac3pHa0ZIMFE1d0Qv?=
 =?utf-8?B?OEZ5QW0rQVp3ZnlldTBPSmF6SEluNG5OS2FnRjM4NklHZmxQU29Ca29NTkVv?=
 =?utf-8?B?dmJVMWlaZDRyWXYySDFBekZ4MHFyU09oTER0MDMzOFpuaVhYQU01ZjdBcU01?=
 =?utf-8?B?QjJDUUJveDNGOWdNanFhS2lSWk9oV0p0YmZXUktyRUlUYUQxUVdaSyt6VTBS?=
 =?utf-8?B?dTdVUjlWL3dab2VIQ095N1RDRVpXZndpeUJlSnFnL01vOEhDU1FuR0VFYmp5?=
 =?utf-8?B?ZTJSVEhSendhNlV0cmg1dDFvSXU3dndPYUYxNlBEOHRFNjVNUVRnL01RbklJ?=
 =?utf-8?B?K3VqTGpPbk9BWUljWW01WW5xSEdBREEvZ1BUNVVIcVdvL1B3TVlTUEF3S1li?=
 =?utf-8?B?U1o1VFlBWk51THRkU0hhN1NsSXVpMHRTQVZod1hCQWdWMW9aZS84eis0elVa?=
 =?utf-8?B?SGpzRlJFN2h3MlZjT2FSSXRYbmZCdmpxVWZpWllvajdvbnlqa3U0d1BhaXkv?=
 =?utf-8?B?UGM1SFNJZ1RpdHhsbGs2SUNkTExkbzZGZ0NFYkRJNUVFa0MzcmlrUTlza1RQ?=
 =?utf-8?B?S0wyNWExVXU4Y1dmdFZYdDByTTErYUF1VVEwaVFoTG05NXkvTmd6dTRtdFho?=
 =?utf-8?B?NGt3cWVyNzhBQnp3eEd5czUyVGFaa0x6dE5PK1orYjdnekFWWUNHK0JpbDFl?=
 =?utf-8?B?d3hkaTR3RDJ0UE5pN2pCbXhRY29wdFRYQ1M3c1hNcWN0N0VtbDgzOC9sZ1Ew?=
 =?utf-8?B?ZGtZQVlmbHNYL3BORmNyd2FlSDROT2JkNUhyUThYVlh6TE5rOTVseDF5R3Rl?=
 =?utf-8?B?aXhydW0xeis0cnZBSGlHUm4rWmFjbGlkbWZMTS9QbmxUTGlIdDhyczBxTysv?=
 =?utf-8?B?Uyt1ZnlMM1d2b3VaV1VRZWc0dTRQL0p2WEhuVHBJaXU5NXFTUVVUWjFKczVJ?=
 =?utf-8?B?d3dHVmExeW9NcENFalhRY2RxRFRFNDdOK1krOHdPOHRjb0s2T1k4YWlRN3pR?=
 =?utf-8?B?aGdyWWxCTjJpOWZkVjhPV3VuZ1RNRzhCdHc0aVo3djVkM0pEVEluNjNtdFpl?=
 =?utf-8?B?N0tuVDVBM0grQWdqdFRWUWVmZDFTSXJ1TGRiTkdXZFRHdWFPaDB1QWZTS1No?=
 =?utf-8?B?bitVTVFuYkZSRVBYajZWZVdkZk5UbEVDUXFHeS9XSER1ZjBDRlZWNjdZUStL?=
 =?utf-8?B?M1lCcEhGYXhtdnN0NFRLNmpqM0UyRWNEY1ViR3VSR1BFS3BSWFJPL0FoYzhq?=
 =?utf-8?B?blRYTWx6dTRxajN5c3NqemJxNll6S1B4amh4ZjBIWG9YN0ZHVjNuVlhUUnVo?=
 =?utf-8?B?QXY2azY4VVBaNFViWmJ6bUxUUlNvVDdTTjNxWXl4RmhHVER6YlJ0NXArY1pY?=
 =?utf-8?B?N3VaWUZvUnNVYzVNQVhFaG9ZQTF2M0ZSUEFUS1FCV2l5L05YS3IzWXB4dm5s?=
 =?utf-8?B?d20zTFVaa0NlMG9KQ1VJbEgxYTlNU3dxQ0NLUDM0NlN5dCtTVm9uVDhPcmNO?=
 =?utf-8?B?b2dDY1FUM2M4dXUzNG1EYlpSZUM3WGtrZG9PVG4za0NRSE16WWRkZkNDZWtQ?=
 =?utf-8?B?TXBhaW9PdjlmbXUrdElOYTdjMjlHSjBIODZPNCs5V3ZmcG4wSU1nYnJ2UE9U?=
 =?utf-8?B?ZWxwaVhlZHEyYVlsOEhKK3ZNeS9lKzdvVkZTanREQ1pzbEZmRHIvSFhkVzRq?=
 =?utf-8?Q?x4Euqu0ZmXqvxbg29UtRoso/R?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cf9db4-dd3f-4e28-c6bc-08da957251b8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 10:25:45.7627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IaC+BRauKH8pa8Mjbompcg2V55m+gThFu3ssVuKYgoIP/vU+JTdDNLP5YFWw1kf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5297
X-Proofpoint-ORIG-GUID: cvC39btp5Fy1cOg_xnU8lx6KGcBt15tu
X-Proofpoint-GUID: cvC39btp5Fy1cOg_xnU8lx6KGcBt15tu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_03,2022-09-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/12/22 11:11 AM, Dave Marchevsky wrote:
> This patch adds support for the following pattern:
> 
>    struct some_data *data = bpf_ringbuf_reserve(&ringbuf, sizeof(struct some_data, 0));

Maybe add:
	if (!data)
		return;
in the example code? Otherwise, the code looks invalid.

>    bpf_map_lookup_elem(&another_map, &data->some_field);
>    bpf_ringbuf_submit(data);
> 
> Currently the verifier does not consider bpf_ringbuf_reserve's
> PTR_TO_MEM ret type a valid key input to bpf_map_lookup_elem. Since
> PTR_TO_MEM is by definition a valid region of memory, it is safe to use
> it as a key for lookups.

bpf_ringbuf_reserve return types also has MEM_ALLOC. Maybe should
mention in the above commit message.

> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   kernel/bpf/verifier.c                         |  2 +
>   tools/testing/selftests/bpf/Makefile          |  8 ++-
>   .../selftests/bpf/prog_tests/ringbuf.c        | 10 +++
>   .../bpf/progs/test_ringbuf_map_key.c          | 69 +++++++++++++++++++
>   4 files changed, 86 insertions(+), 3 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c259d734f863..d093618aed99 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5626,6 +5626,8 @@ static const struct bpf_reg_types map_key_value_types = {
>   		PTR_TO_PACKET_META,
>   		PTR_TO_MAP_KEY,
>   		PTR_TO_MAP_VALUE,
> +		PTR_TO_MEM,

PTR_TO_MEM is okay. But bpf_ringbuf_reserve() will trigger
PTR_TO_MEM | MEM_ALLOC. So suggest to add PTR_TO_MEM unless
you find a use case for it.

> +		PTR_TO_MEM | MEM_ALLOC,
>   	},
>   };
>   
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 6cd327f1f216..231d9c1364c9 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -351,9 +351,11 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
>   		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
>   		test_usdt.skel.h
>   
> -LSKELS := fentry_test.c fexit_test.c fexit_sleep.c \
> -	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
> -	map_ptr_kern.c core_kern.c core_kern_overflow.c
> +LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c 		\
> +	trace_printk.c trace_vprintk.c map_ptr_kern.c 			\
> +	core_kern.c core_kern_overflow.c test_ringbuf.c			\
> +	test_ringbuf_map_key.c

Maybe put the selftest in a separate patch?

> +
>   # Generate both light skeleton and libbpf skeleton for these
>   LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
>   	kfunc_call_test_subprog.c
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> index 9a80fe8a6427..1cf458d1a179 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> @@ -13,6 +13,7 @@
>   #include <linux/perf_event.h>
>   #include <linux/ring_buffer.h>
>   #include "test_ringbuf.lskel.h"
> +#include "test_ringbuf_map_key.lskel.h"
>   
>   #define EDONE 7777
>   
> @@ -297,3 +298,12 @@ void test_ringbuf(void)
>   	ring_buffer__free(ringbuf);
>   	test_ringbuf_lskel__destroy(skel);
>   }
> +
> +void test_ringbuf_map_key(void)
> +{
> +	struct test_ringbuf_map_key_lskel *skel_map_key;
> +
> +	skel_map_key = test_ringbuf_map_key_lskel__open_and_load();
> +	ASSERT_OK_PTR(skel_map_key, "test_ringbuf_map_key_lskel__open_and_load failed");
> +	test_ringbuf_map_key_lskel__destroy(skel_map_key);
> +}

This adds another *top* test in ringbuf.c.
Should we add test_ringbuf_map_key as a subtest
for test_ringbuf test so in the future more subtests
could be added in the umbrella of test_ringbuf test?

> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
> new file mode 100644
> index 000000000000..96a791a9762e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
> @@ -0,0 +1,69 @@
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
> +long value = 0;
> +long flags = 0;

I didn't see these values are assigned in user space.
So you can simplify the code by remove 'flags'
and manually inline the 'value'.

> +
> +/* outputs */
> +long total = 0;
> +long dropped = 0;

'total' is not used. 'dropped' is not checked by user
space application, so it can be dropped too.

> +
> +/* inner state */
> +long seq = 0;
> +
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int test_ringbuf_mem_map_key(void *ctx)
> +{
> +	int cur_pid = bpf_get_current_pid_tgid() >> 32;
> +	struct sample *sample;
> +	int *lookup_val;
> +	int zero = 0;
> +
> +	if (cur_pid != pid)
> +		return 0;
> +
> +	sample = bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
> +	if (!sample) {
> +		__sync_fetch_and_add(&dropped, 1);
> +		return 0;
> +	}
> +
> +	sample->pid = pid;
> +	bpf_get_current_comm(sample->comm, sizeof(sample->comm));
> +	sample->value = value;
> +	sample->seq = seq++;
> +
> +	/* This prog is never run, successful load w/ below use of sample mem
> +	 * as map key is considered success
> +	 */
> +	lookup_val = (int *)bpf_map_lookup_elem(&hash_map, sample);

Maybe add code for bpf_map_update_elem() as well since that is also
common use case?
This way, you can check the result in user space after 
bpf_map_update_elem().

> +	bpf_ringbuf_submit(sample, 0);
> +	return 0;
> +}
