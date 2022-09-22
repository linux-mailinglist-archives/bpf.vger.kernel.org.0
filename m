Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76E25E695C
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 19:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiIVROI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 13:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiIVRNr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 13:13:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A861103FDF
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 10:13:37 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MH09Xc031622;
        Thu, 22 Sep 2022 10:13:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=J3Sc+DTnXBxDVGPRDApp1FgTU0An3z/YXjIS/bq+Hkg=;
 b=YSyD6HY2zBOrYoFsMoXiH/6xEXhY67VAlLllTj1LC/uVl4/Tm3ngYnV2jBrPEyF2pkeg
 QAQ3b6ogZYH/euALAfeawPphp5tGYJ8wRi/ca4z2nlDyTAAwOqUXS6aFLSBYByNAoJmM
 YLKtIbkpE9PflsS08PP46szN03J+a+Xgoag= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jrenwd298-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 10:13:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvd8jOIw9aQRqZ7jnzI8y6UFIMANyejOA+bvHEvHcaO6L/h1P9ocRJrxc65rB6V17b9he9/b1QcQdIHBbHCbwb5LE9kFUKDKZ2FfKJJ0f+gUuzBwWwso3AdRPuuVVziRycNZ73ZVgiT/JIYLc+PgBGTgCQ2NjtAscCvqN4pts4c7dSMFOmGrz3MASrTwBPJHbd7yC7KOiZCpv8Djkd05KKyBsBj0J+WPz65QxfFaN6xCDStCf+Ysn6FlGl3bP0qDiCoBHaV5bs1r2ku0zMtFT3IJSsGXQyWn/ZjL6UNO0oEDNAACnB4nd2gTfNTtP7na+jV8LyJtiHAkyShBMVQwFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3Sc+DTnXBxDVGPRDApp1FgTU0An3z/YXjIS/bq+Hkg=;
 b=DT3yK75GMpS5ZRHDSHb+F/6xNOP3uy+4F0Q5cJE5efjXsvWgPTzF3mdAbvRzXdoHT+qdu/by3FDaWARbkvEaUN5w1Nf/FBuYYqIjNsDX3mjDsG8COc9Q1+rSlylZQvxNhNUzZPABhTQGbCT0MPyq5D7QTF4t8J4hTjHvHcG+iiLlHavAx5xC/v/9whXRc18ISXWonoNEG6qDbQJ9deUfC4o8h88usMGh4wjafIdW2r37ZvNN9cOlPLHV9NFn/qWcdWUXo2lODCaEALR+LYd99z+vh5tmowyMFggidD94TajowgCtDNawq1+8/04m1bcg1zI0S3rXwcC2dxRvNkf76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY3PR15MB5108.namprd15.prod.outlook.com (2603:10b6:a03:3cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 17:13:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5654.014; Thu, 22 Sep 2022
 17:13:18 +0000
Message-ID: <6b39c7e2-6526-7c27-620d-f0e7c781140d@fb.com>
Date:   Thu, 22 Sep 2022 10:13:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH v3 bpf-next 2/2] selftests/bpf: Add test verifying
 bpf_ringbuf_reserve retval use in map ops
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20220922142208.3009672-1-davemarchevsky@fb.com>
 <20220922142208.3009672-2-davemarchevsky@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220922142208.3009672-2-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BY3PR15MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db45c12-04e1-4899-584f-08da9cbdbe6d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4NiXWQdrBNaaq2GHFWAuOH1/v176MrmrysQnIglJZVx6AACNZlkq+NudXDCvdwclQaFoXYuaKoUlT+9lJ7kMMzKml6opliHqwBSbDGJ6nAxaZhqSgtsVaMlZacPNSD3weYrGkykBC17SZLHhg0rLlQo0QwN1cFg4Sd8Vf0P4EU7WctZ0mDvf28HWaVsdZyqj0oSHU3CkDYwutIfUmNkKZr1TbzDVccYuYzpUsINV7Yg6aUBFOROFi+B2tC47yZA5J+DCsWRnxag82XKDtxUA05LqjiDuh+Pt+y7IS6+LrWlFD8f9RWRhjrV+GidHjJTyvePL1PN1l+TwlQ4dBiYqRmpmltZ3y5rXwRdl8CqNOUYedsITxIeoMgakSIB2qLYrOhmTRs+etgtv5rwh6dm2cpQQKFkm4qfFaPuqt7jANcg1Slr0033RuDqk6rs3ovZtTk/+tS91HNrjbgzwJ7wudh3YrMRMk5CnpKPjcYxHcXmSOAQFSUAsKFL5viDoVkTOlTXNgN70flU6TGY/Wa1n+IVgsk3v+sjXzD7CsI3otcLtD56E/jOFS+eB8GFXnMguX8LC397w1hzeC5FVRvhhlQgN6FvJhBMp87SIaXUAtrWAqRhznekSC4ft2ZGCdRFAtZiLLxBQBNUu/6QQR0LKVi5KgoZSomd7yIYdqRd8FCvRpPPha5xnSe16S/oAzaQ48/2PdF0iets6V88nW76iFvc/+pv95OVbtReRvA6AOyp50/TR2kzfjcpErtMQWJsIXNF6Qo/bVtpafy68yy8rpsijeblBbR2hYll7+foc1vDbINJKLn+yNOTl264Y9m20/WSgG0NHBFEbED5L9ZweeWZsZwEVBTvmKwspPm44mp8JfGi8QJEq9J1b42dM6Po
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(186003)(53546011)(84970400001)(6666004)(2616005)(6512007)(8936002)(6506007)(83380400001)(2906002)(5660300002)(6486002)(478600001)(54906003)(66556008)(8676002)(66476007)(4326008)(66946007)(41300700001)(316002)(36756003)(38100700002)(31686004)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkY3YUxqa2lVZTFSSFJFKzl6eGh1S2hkUDdYUUI3RldNUTM5MEFoL2ZXeklp?=
 =?utf-8?B?cndJaldTNFI1cTNPL2tBVlYwQmRiSHZOZWRaUFU4MUFBVWdqWlplanFHb1dN?=
 =?utf-8?B?RjVhOVNDMFB1dGdnT2RyL0JtdzlkU2NHbkF3NnpjQjBFWkdTaFUvb0p5VGk3?=
 =?utf-8?B?eVpHanlMSkdqYWNEK2RGUUVyWjB4SWtRYlMyRU1JVjYyeUhJSXpXRjdlUjFL?=
 =?utf-8?B?TGV2RFE3Ti96SzFib3VXTUtjSzJlZGl4UjRsNnBFTStEcGdmcmpCUzZscUlL?=
 =?utf-8?B?SEVIUHZ1WnRhb25SckpvMjJIaW5leUJjS0VBRUhlaHN0anNXZjZzNmwyVU5J?=
 =?utf-8?B?LzRVVTFqL2xLbkxVWEgxTlVaTGNpTHQ3S3FHQk4ySW00Qk0yOGNicGZQTlV6?=
 =?utf-8?B?LzNLWGZqM2FaVHRXdHVIMDRHdWlnNDJDQnVUZkFtRzk2c2hGaDBTUlhQdUo2?=
 =?utf-8?B?NHF4L3k2cFBIenpoNnJCRDNEL1pRKzFjOTd1WXE1ZmVKVXFBaTlOcGpwcHJW?=
 =?utf-8?B?dnRTeERWR09FQ0lzRGcwRlZ6OXhUK2JjSzFDQ1QzZCs3NEJaS3NJbGloa0dV?=
 =?utf-8?B?emR4UjhINVd3d3hjWDZxM3JKRnRmK2lLdXJwdHJrQTd4Y0tibnB2UEpYN2RE?=
 =?utf-8?B?SW81NjhQTElhcUt0L0NLazlpb3ZWUkx4NE9WK2wwYjlncmh4dzRuckNTaG1s?=
 =?utf-8?B?YVZBT0FoV0VuTWtQOXpIYmEyRzlXYjdJMDVIc0tWUEpHWjAyMXZ2bDBqMmkx?=
 =?utf-8?B?bmdmNGFISzdoUUgwVG8vbWg2TXp0cklhTTF1U1BpdGVHMlJlVEppbGZWWlll?=
 =?utf-8?B?UXJJZ0E0MyszL29RUDZmRzVZVVJPRzVmWG5nNnp0QjBzdGxtR0lxNU1Zc3Zm?=
 =?utf-8?B?cUllWDIvZkJVNk5sako4aTR6VG11bXZMQ3UwcDRNMnYwRXo1MFFFMXlUYUg5?=
 =?utf-8?B?UGdHY0NBMCtVeE1TNjZPMFJBenpSUzJHbDV0M01WRDNNVUduQlB0UEI4ajZD?=
 =?utf-8?B?ODFTOTB6cUZGMjY2dGlMdFZ5RncxTmVmTGNCU0l0bm1GNzdiaHVTQ09hTVBz?=
 =?utf-8?B?NUFkYUFuR2FYcmlIc0VFcFJUQTduYU1jUldhc2JPeEVkak82YWt2ZUFNY3Js?=
 =?utf-8?B?V1ppU3JjMFp3dDZSR3pxTVNEbnQwMXFyNnNZTXZCOTVWRlRHVm44RE80N3BO?=
 =?utf-8?B?aHJGU3k5STg0UHdwQndaT0lwK3dkWWtxQXowVGcwaDM2MkJ3RmdDWDdnL0pU?=
 =?utf-8?B?RXd1d1RwYjhVbTNRM3YyYWkyOEZCd3RMQ1BqZnJNdWZoZVZPdU1mNmpiQnhs?=
 =?utf-8?B?U2hnWlpWb0xFakczcnJlQysvUVFRcjhiaU1jang4cGFaSmNlbktzNnliMEFC?=
 =?utf-8?B?K2Z1eTNPS29lY085L1ZPa2JXazBDeld4YlNjcVJwemdta09YT1RoMWpaK0Ur?=
 =?utf-8?B?NjRTSkFRa1FuZ3o4UE1nS2RnaHlzYSs3ckpCUlZpNk4vUmpyVzlQQTB5aElo?=
 =?utf-8?B?VU1CZ1M1UlRhempCaGJ0THNjdHZpamY5U29LS1l2TkZrZWl6eTFRM1oxVWlD?=
 =?utf-8?B?ci9UZEVIRi9ZRmZJYUFvR21Mc3VER3Z3L256bmZmN0NvN3I0OFlsaEFxblda?=
 =?utf-8?B?aFp2R0dETldBSXZ1T3E1U2RpaDM2MHloRDlRV1dEb1FUclRXSSsxWkV3aDRt?=
 =?utf-8?B?cDZXOEJjczdsTjFVdXJCNnQ4MHhjcWhUUjhRSXZwcXliRzZ1QTZCVzVtTGFT?=
 =?utf-8?B?UzAzcHZiT0ZvU3ZLeHhobzVSaEZjcWY1UWtzN3Z0MksxU0hrNXRDK09SRURT?=
 =?utf-8?B?OUU1NUp0RXRZV0tSUmluZ1l4Z1lzMEtXOXFRMVI0a295N2ZlbDdhQlAyRVhr?=
 =?utf-8?B?WlQxbllieEg3WkFTLzJ1cWdLbjRPMWtkRnpQU1ZUYnhrSlQzeVd6ZlZkb0hq?=
 =?utf-8?B?VHhwTkx2NUJqK3lvTERaSG5Ielk1MVdwSnliTFFGQ0wyL0dJaXRzVzY2NDRZ?=
 =?utf-8?B?alNxQXZaTFo2d05Ld2lVYTc2UjJHM2xwTFR6cWhRd3pOc05SeFFkQWtiV1RY?=
 =?utf-8?B?YjFBZ3BDOUc1UEtxRTljazNRNFVpZzFDdmNiM3dsREwxR2RhZzZTS2dZT3V1?=
 =?utf-8?B?YkZHOENOSWlwWnBUVUFYaFF5U1d0YVhzcHE3bFJ5ZEEwY1RPNWI1b0lQdU1q?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db45c12-04e1-4899-584f-08da9cbdbe6d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:13:18.5185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yUObWgfhJas0UDOSzK3F7kNSQqI+CQl/22gWhp+JJS9zpImNrjqAqyx55LiIJil
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5108
X-Proofpoint-GUID: bWjtCZCFE4ibfj1_ZLkFvsDhb_Tumx_M
X-Proofpoint-ORIG-GUID: bWjtCZCFE4ibfj1_ZLkFvsDhb_Tumx_M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_12,2022-09-22_01,2022-06-22_01
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/22/22 7:22 AM, Dave Marchevsky wrote:
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

Ack with a few nits below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
> v2->v3: lore.kernel.org/bpf/20220914123600.927632-2-davemarchevsky@fb.com
> 
> * Test that ring_buffer__poll returns -EDONE (Alexei)
> 
> v1->v2: lore.kernel.org/bpf/20220912101106.2765921-1-davemarchevsky@fb.com
> 
> * Actually run the program instead of just loading (Yonghong)
> * Add a bpf_map_update_elem call to the test (Yonghong)
> * Refactor runner such that existing test and newly-added test are
>    subtests of 'ringbuf' top-level test (Yonghong)
> * Remove unused globals in test prog (Yonghong)
> 
>   tools/testing/selftests/bpf/Makefile          |  8 ++-
>   .../selftests/bpf/prog_tests/ringbuf.c        | 65 ++++++++++++++++-
>   .../bpf/progs/test_ringbuf_map_key.c          | 70 +++++++++++++++++++
>   3 files changed, 139 insertions(+), 4 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 5898d3828b82..28bd482f34a1 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -358,9 +358,11 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
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
> +
>   # Generate both light skeleton and libbpf skeleton for these
>   LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
>   	kfunc_call_test_subprog.c
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> index 9a80fe8a6427..2d54ceac9417 100644
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
> @@ -58,6 +59,7 @@ static int process_sample(void *ctx, void *data, size_t len)
>   	}
>   }
>   
> +static struct test_ringbuf_map_key_lskel *skel_map_key;
>   static struct test_ringbuf_lskel *skel;
>   static struct ring_buffer *ringbuf;
>   
> @@ -81,7 +83,7 @@ static void *poll_thread(void *input)
>   	return (void *)(long)ring_buffer__poll(ringbuf, timeout);
>   }
>   
> -void test_ringbuf(void)
> +void ringbuf_subtest(void)

static?

>   {
>   	const size_t rec_sz = BPF_RINGBUF_HDR_SZ + sizeof(struct sample);
>   	pthread_t thread;
> @@ -297,3 +299,64 @@ void test_ringbuf(void)
>   	ring_buffer__free(ringbuf);
>   	test_ringbuf_lskel__destroy(skel);
>   }
> +
> +static int process_map_key_sample(void *ctx, void *data, size_t len)
> +{
> +	struct sample *s;
> +	int err, val;
> +
> +	s = data;
> +	switch (s->seq) {
> +	case 1:
> +		ASSERT_EQ(s->value, 42, "sample_value");
> +		err = bpf_map_lookup_elem(skel_map_key->maps.hash_map.map_fd,
> +					  s, &val);
> +		ASSERT_OK(err, "hash_map bpf_map_lookup_elem");
> +		ASSERT_EQ(val, 1, "hash_map val");
> +		return -EDONE;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +void ringbuf_map_key_subtest(void)

static?

> +{
> +	int err;
> +
> +	skel_map_key = test_ringbuf_map_key_lskel__open();
> +	if (!ASSERT_OK_PTR(skel_map_key, "test_ringbuf_map_key_lskel__open"))
> +		return;
> +
> +	skel_map_key->maps.ringbuf.max_entries = getpagesize();
> +	skel_map_key->bss->pid = getpid();
> +
> +	err = test_ringbuf_map_key_lskel__load(skel_map_key);
> +	if (!ASSERT_OK(err, "test_ringbuf_map_key_lskel__load"))
> +		goto cleanup;
> +
> +	ringbuf = ring_buffer__new(skel_map_key->maps.ringbuf.map_fd,
> +				   process_map_key_sample, NULL, NULL);
> +
> +	err = test_ringbuf_map_key_lskel__attach(skel_map_key);
> +	if (!ASSERT_OK(err, "test_ringbuf_map_key_lskel__attach"))
> +		goto cleanup_ringbuf;
> +
> +	syscall(__NR_getpgid);
> +	ASSERT_EQ(skel_map_key->bss->seq, 1, "skel_map_key->bss->seq");
> +	err = ring_buffer__poll(ringbuf, -1);
> +	if (!ASSERT_EQ(err, -EDONE, "ring_buffer__poll"))
> +		goto cleanup_ringbuf;

there is no need for 'goto' above.

> +
> +cleanup_ringbuf:
> +	ring_buffer__free(ringbuf);
> +cleanup:
> +	test_ringbuf_map_key_lskel__destroy(skel_map_key);
> +}
> +
> +void test_ringbuf(void)
> +{
> +	if (test__start_subtest("ringbuf"))
> +		ringbuf_subtest();
> +	if (test__start_subtest("ringbuf_map_key"))
> +		ringbuf_map_key_subtest();
> +}
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

could you add a keyword 'workaround' so it can be easily searchable if
we forgot to make this enhancement in the future?

> +	 *   verifier internal error: more than one arg with ref_obj_id R3
> +	 * when trying to do bpf_map_update_elem(&hash_map, sample, &sample->seq, BPF_ANY);
> +	 *
> +	 * Since bpf_map_lookup_elem above uses 'sample' as key, test using
> +	 * sample field as value below
> +	 */
> +	__builtin_memcpy(&sample_copy, sample, sizeof(struct sample));
> +	bpf_map_update_elem(&hash_map, &sample_copy, &sample->seq, BPF_ANY);
> +
> +	bpf_ringbuf_submit(sample, 0);
> +	return 0;
> +}
