Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AB14C9D23
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 06:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237942AbiCBFY4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 00:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbiCBFYz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 00:24:55 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3781F5F4D7
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 21:24:12 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2222MvP3028755;
        Tue, 1 Mar 2022 21:23:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=kM0ZPBmSmBgx/vEHX3R8deSlylLTchyfHns6deRFOrQ=;
 b=lvsctsCFiM712hd0B9oHivo6bhgYr8Pvs7mLkmesCYM7FmkrqUQexIuEWpDci/QkbjgE
 ojv2nIeLtnTxSeIK8qwUPZPhUG2054HjZsG/5j/eKf3qI2ioatjsUFNCZg6s7yNcynSu
 j17sH4ZzqlGwuRWnfwYX8depiDY5cRIqzmE= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ehyr6gxsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 21:23:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5H9u+4FVZurLWnsG5YviD5FmLT8bxlxF1tduymgRFDTW6QM3rIkbPGwFj5qYRlQjpmfkVayEybBzMNv/bCrOHjCntbYrS5ruRY5sphwRcxgnYJ8AQQ7CMirIIwfS8lVqfusyqPjhSskEEGs32+1qhMUDkWdfqd49fGrjHs9o+HUtcp2oIppjh8AgAMf/r3knqApWY5DVEJXKJ1I6UQW/5LYlUI/fQRW55E9k60lA3l+XW0IXy13f1HQos6nQ9GE4yUvlLm90C/M9D4XmKcIuADnXe3havBU6O2QKEpPpA49u8M//2p26vaFn7kAUW4yufvdhnWGShoFZHbn3zeQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kM0ZPBmSmBgx/vEHX3R8deSlylLTchyfHns6deRFOrQ=;
 b=OvbIeLq9X2A9h1du5c0ZFI+J8jk0gmQookeCx8JKu/SnKQDAiC4uawlAALpoy6rfJwpCY9NBXTpjWU7weSU4/igJg4B0zL4g9p++S/BYEIYrgMQBMOzQCdGENxmSU8dWo+GtWYS3eYpv1q3AMimcg3BBboqt+LE03vL/HX9xLwMejiVpELd1hnoNQ1Y3F6NjeWmopPeySjKUpFM47e4zQcg+xlNnaKVLedeFHYVB4bEIaz72Dbhgir8G10eFWuJZgXOtR16b9V4peznUXpJZqgEUhhtQWSy56b+Lh1oKo0+fcU3N1eaCd2RAjoQ87Kwdt1TIxgvF8C2dmKRn9RGEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN6PR15MB1394.namprd15.prod.outlook.com (2603:10b6:404:c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 05:23:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 05:23:52 +0000
Message-ID: <145b59c3-27d4-fc4c-82aa-e7294ace896c@fb.com>
Date:   Tue, 1 Mar 2022 21:23:48 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Content-Language: en-US
To:     Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20220301033907.902728-1-mykolal@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220301033907.902728-1-mykolal@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0070.namprd22.prod.outlook.com
 (2603:10b6:300:12a::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87259cb6-47f9-4c21-aea4-08d9fc0cd684
X-MS-TrafficTypeDiagnostic: BN6PR15MB1394:EE_
X-Microsoft-Antispam-PRVS: <BN6PR15MB1394F0A4B7F69D2D483FCFD1D3039@BN6PR15MB1394.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dionljw2pD7E4WHUke2AdTLC7PHF7oRA1IGGOYjxpp0bDFper6m09dtY8DL5cwVW4V0oysS9JczjL0xDgI33S9UZoMJsBSQKsPloA3UliXF8SCr6G8BxSFS1DH5VGadxFvhrBB0+C4Wgtni/R92cxuM7AQ/DIocH4zTRed1c1n7vNMDeb1CtpMRvgIJGeP2AXI68+5+rP2VkM/pjjamRDzC8BE4tMaJAgdzYifjLxSG4QxqZlq0GfapzIo2KZVnNCkBksLDFbspuvVlbOWsE7/NhysyCqyvP/n92HF1TBJ6Dd+m9SoOXmPaYPXLkmONUukFl+mieNnEHFgUxIB9Ls4cV5wEP2gm484snDjDGgPV4T5fb2zH0cKzmPv0OKFzrmTwyDwAm93CHMlqmERnNJVeFpLpWa9hnp3T0ssNGHqvLcgxB5ynyYNuCMybPeq39Mz+nkLuICSA2T8Lvbv/oAePgP8yLrq9GNAU1cHZO39Pc07oxo/z7X246OxfhBq+2bYU8VHgQjwS4WfIOnletUejk7WGdE+XS4G+L1oeygEgAopNG6SOuxT0eQ9Rb3MqZo6OD2LX8b4xRfWWumH29yE2DdMspiVdTxCnnRXr7YJf2MWqtdJE+BTp2oE8GZYPI60Jqn47mMgVSOgKvqpFHwGkTMYugkgmXtdG18IilDgV2o2tQ/5Ad/a9Yz1r1UCWYyczu6PpbnoJ68A5o1XsXRU157XUidJM6ua9cywnkHI5QOa6EDn8awK0LEvToZI52
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(6506007)(53546011)(52116002)(6666004)(6512007)(66946007)(66556008)(66476007)(8676002)(4326008)(86362001)(31696002)(316002)(83380400001)(2616005)(186003)(38100700002)(36756003)(31686004)(2906002)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDdFS0VaNW91amN6UjhoQzZveml0VjBiRmJWbkxOMlFhZVJlZkx1V0ltK09K?=
 =?utf-8?B?YUtFcjFwWDZOZVZMQ293M0VZeUlWdUY1NCtOSkFteFlTOGdUMzBLcDU5Y1JZ?=
 =?utf-8?B?NWwxNnA2ZlZGQ3FJNzJycVk0cU1DK284RElUOVVjdEhXUGdZMUdROWlPaDVM?=
 =?utf-8?B?YVoxeDlkVUNhK0hFa2tMdDVNS2VLYWhmVVRSeHM0S1FjaUpRQ3llY3dhekV2?=
 =?utf-8?B?d2gvTjlXRUplK1pmaUFDKzVsa05ueW1oSUJxUHJ3SG9VeEx5VUMwc01pOGpt?=
 =?utf-8?B?aEd1Y28yTnJXb0FtenhJWXgranVpUnBTb3dQUjVsaU5BbkRKTnkvRkdaL0Jq?=
 =?utf-8?B?Wm12R2p0RTh4RGRFQ2xkZE9SUnVwNGsvTFpJQ0pRNU5zMmh2S2x4OWJwU3Vq?=
 =?utf-8?B?ZjR5bkd4aEJPdVQzQmNGdE5pNmgzUnJyK3JxSDJsS2VIS3BLcDZiaFBTZDhX?=
 =?utf-8?B?YndRZzJxK3JLcS9pWkVOMzFQbmpxeVFLWUxFRjEzdUhJZVNQTmRpKzloWE1N?=
 =?utf-8?B?OGdjVWZsaGkydDloS0M0aE9zTnIrSlBkOGdVakE1QlBVaEJkbW5QbUNXTUZF?=
 =?utf-8?B?NElEeHM3MTRBL0R5SGpzU0hDTjBTQnBtRXVZYWkyMHpmcDZkRitKL0lwY00w?=
 =?utf-8?B?ODc5c2t6YW5qeFZDVng0T2lwSHB1cTBnQVlEMTY0d2NYYlNLOWhGS2hhcUQz?=
 =?utf-8?B?L0N1eFQ4VFpIL1FSMUJWd2tsQ21hWG12WE1DSEN5Zi9LZTJZempYa0wvdi9Y?=
 =?utf-8?B?UTdjQ1VtdTg4Z0tSclQ5SzVLNEFxc1NucnBiSU1CeVlOK01qSWJrMkZtZWFF?=
 =?utf-8?B?THhnZXVaK0ZyTnhoZGxJZGpycGpNZDR4LytVTGl0emE4OFY2NnhFT0YvNXN6?=
 =?utf-8?B?Sy92MnJzVWRBZlhQYm9qOVZMQW9JcURWTjFweElENFRtbkxISDNGZEQ4NFBY?=
 =?utf-8?B?aUVjWHV3SHpsUys4VmVEb0xkaG4rQWRnM2Zic2JCWDFLQ0hNTlhxUlZKbjFa?=
 =?utf-8?B?b0FlNkp4ZjZtZ0Z1U09FbzRORXNoVkVrRkpQR2JackFCQWRLaUJER015dmhl?=
 =?utf-8?B?Rlh0Y3NBeDdhNUtuRWw1ZE9jdi9pMndRMlU3amp0RDhSQ2hYbFlrVU8vdUZs?=
 =?utf-8?B?cFkyY1hGR3ZndlJYTW1UYUtJZGpCMnM5YjFkaUF4Mld2aXBnMlRRbkhKdy9N?=
 =?utf-8?B?L3NpeGxiWWVLS0JQSTBBT1h6MmlBczV4clY1UndsTEZjb1M4MFJoR25GQy83?=
 =?utf-8?B?OG1EUnlGVGlSVVZ0ODZzSVdzUWxReGpBOVJTNjQvQjhJNTVkd1V3THJFWEtS?=
 =?utf-8?B?Yk1zbDh1bWErTU8rT3JTR1owUUlpQTR5TUkrMVUySHl5eUkwZDBqN2FCYVJO?=
 =?utf-8?B?RnFFalNHRnBpNm1UOFhmYXlSbkZwa0xxaHBBWEFVbFhVWko0K0ZqMXJEM2lz?=
 =?utf-8?B?MXRUOWZ6dzRHSTB1bmJGcTBmZVFVd2RPcGhESVZPRjEweVhpeWpLUXdwZFZq?=
 =?utf-8?B?TlQwRHhHSS92TkNOK0xTWUhVRVRCQkNKd0szR3RGT3I4Zm9NMy9USUZtSVRR?=
 =?utf-8?B?b2ljVHZjSW1FMWlFL2RtMFVqNmlGdm12ai9qdGhRWk9ScCs5UXJVVmZ4QlJS?=
 =?utf-8?B?VmhwYXdxWXh1S2hrS09DaEVlU3d2R1l5ZExGN1NkVlVSc1hESDlrWWx4dUh2?=
 =?utf-8?B?RWRxenB3R01kWlFFRmNvYVZZOUNQZHdKbC9hUE9uTkdsam1TRUtPcHc5dzFH?=
 =?utf-8?B?OGN2WDA2c3hPMHRNSndFTkM0S3o1V0lvdDRXYldEUDFqMFVqcXgwWjFZYnVm?=
 =?utf-8?B?S0RSSkZMUndORytobFRTR25tTnhoQkJtVXorV0M4Y0E3WHNSclZxRmxMbUpq?=
 =?utf-8?B?QU5udFNnNnlrSHcxS2x0UGdXSTYzc2JJMVJ2dU9OVVg5QWd6bm0xRTVGbVdw?=
 =?utf-8?B?YjYvRzhHRnpERFFvdWFzbGZ1VnNzZ0tZMzYwS0ErS2RpQjhNZ3czRnlrM2Zj?=
 =?utf-8?B?dDIvcDY1N1c0WWtibkY5YU4vZVBmS3F6NUFmSkxETE9lNFhuaVUwQWVtSWhx?=
 =?utf-8?B?RlUyZ1QzQnRNRWZnTysycDhkS0NjMHY5RWl0RC9TMlo4NEFDQW9zcnVuSmZ1?=
 =?utf-8?B?aVIrTGNPQmdGR3lzVlFrakMvZE1idEswa00vWWszZzNhUWhxTU5xMURFWUhh?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87259cb6-47f9-4c21-aea4-08d9fc0cd684
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 05:23:51.9556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0ktB/QmtokPGEqOn8UaRe0Ds/deM/iUu7X3M5bt7rOcI2CbDYNXshO/MnZdRN8O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1394
X-Proofpoint-GUID: V6g_BWue1115pVz7069k6azO4hnXLWvH
X-Proofpoint-ORIG-GUID: V6g_BWue1115pVz7069k6azO4hnXLWvH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_01,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020024
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/28/22 7:39 PM, Mykola Lysenko wrote:
> In send_signal, replace sleep with dummy cpu intensive computation
> to increase probability of child process being scheduled. Add few
> more asserts.
> 
> In find_vma, reduce sample_freq as higher values may be rejected in
> some qemu setups, remove usleep and increase length of cpu intensive
> computation.
> 
> In bpf_cookie, perf_link and perf_branches, reduce sample_freq as
> higher values may be rejected in some qemu setups
> 
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>

LGTM with a few nits below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   .../selftests/bpf/prog_tests/bpf_cookie.c       |  2 +-
>   .../testing/selftests/bpf/prog_tests/find_vma.c | 13 ++++++++++---
>   .../selftests/bpf/prog_tests/perf_branches.c    |  4 ++--
>   .../selftests/bpf/prog_tests/perf_link.c        |  2 +-
>   .../selftests/bpf/prog_tests/send_signal.c      | 17 ++++++++++-------
>   .../selftests/bpf/progs/test_send_signal_kern.c |  2 +-
>   6 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> index cd10df6cd0fc..0612e79a9281 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -199,7 +199,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>   	attr.type = PERF_TYPE_SOFTWARE;
>   	attr.config = PERF_COUNT_SW_CPU_CLOCK;
>   	attr.freq = 1;
> -	attr.sample_freq = 4000;
> +	attr.sample_freq = 1000;
>   	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>   	if (!ASSERT_GE(pfd, 0, "perf_fd"))
>   		goto cleanup;
> diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/testing/selftests/bpf/prog_tests/find_vma.c
> index b74b3c0c555a..a0b68381cd79 100644
> --- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
> +++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
> @@ -30,12 +30,20 @@ static int open_pe(void)
>   	attr.type = PERF_TYPE_HARDWARE;
>   	attr.config = PERF_COUNT_HW_CPU_CYCLES;
>   	attr.freq = 1;
> -	attr.sample_freq = 4000;
> +	attr.sample_freq = 1000;
>   	pfd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
>   
>   	return pfd >= 0 ? pfd : -errno;
>   }
>   
> +static bool find_vma_pe_condition(struct find_vma *skel)
> +{
> +	return skel->bss->found_vm_exec != 1 ||

In test_and_reset_skel(), we have following codes for reset/default values:
         skel->bss->found_vm_exec = 0;
         skel->data->find_addr_ret = -1;
         skel->data->find_zero_ret = -1;
         skel->bss->d_iname[0] = 0;

I think we should stick to them, so it would be good
to change
	skel->bss->found_vm_exec != 1
to
	skel->bss->found_vm_exec == 0

> +		skel->data->find_addr_ret == -1 ||
> +		skel->data->find_zero_ret != 0 ||

Change
	skel->data->find_zero_ret != 0
to
	skel->data->find_zero_ret == -1

The bpf program may set skel->data->find_zero_ret to
-ENOENT (-2)  or -EBUSY (-16) in which case we should
stop the iteration.

> +		skel->bss->d_iname[0] == 0;
> +}
> +
>   static void test_find_vma_pe(struct find_vma *skel)
>   {
>   	struct bpf_link *link = NULL;
> @@ -57,7 +65,7 @@ static void test_find_vma_pe(struct find_vma *skel)
>   	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
>   		goto cleanup;
>   
> -	for (i = 0; i < 1000000; ++i)
> +	for (i = 0; i < 1000000000 && find_vma_pe_condition(skel); ++i)
>   		++j;
>   
>   	test_and_reset_skel(skel, -EBUSY /* in nmi, irq_work is busy */);
> @@ -108,7 +116,6 @@ void serial_test_find_vma(void)
>   	skel->bss->addr = (__u64)(uintptr_t)test_find_vma_pe;
>   
>   	test_find_vma_pe(skel);
> -	usleep(100000); /* allow the irq_work to finish */
>   	test_find_vma_kprobe(skel);
>   
>   	find_vma__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> index 12c4f45cee1a..bc24f83339d6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> @@ -110,7 +110,7 @@ static void test_perf_branches_hw(void)
>   	attr.type = PERF_TYPE_HARDWARE;
>   	attr.config = PERF_COUNT_HW_CPU_CYCLES;
>   	attr.freq = 1;
> -	attr.sample_freq = 4000;
> +	attr.sample_freq = 1000;
>   	attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
>   	attr.branch_sample_type = PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRANCH_ANY;
>   	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
> @@ -151,7 +151,7 @@ static void test_perf_branches_no_hw(void)
>   	attr.type = PERF_TYPE_SOFTWARE;
>   	attr.config = PERF_COUNT_SW_CPU_CLOCK;
>   	attr.freq = 1;
> -	attr.sample_freq = 4000;
> +	attr.sample_freq = 1000;
>   	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>   	if (CHECK(pfd < 0, "perf_event_open", "err %d\n", pfd))
>   		return;
> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/testing/selftests/bpf/prog_tests/perf_link.c
> index ede07344f264..224eba6fef2e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
> @@ -39,7 +39,7 @@ void serial_test_perf_link(void)
>   	attr.type = PERF_TYPE_SOFTWARE;
>   	attr.config = PERF_COUNT_SW_CPU_CLOCK;
>   	attr.freq = 1;
> -	attr.sample_freq = 4000;
> +	attr.sample_freq = 1000;
>   	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>   	if (!ASSERT_GE(pfd, 0, "perf_fd"))
>   		goto cleanup;
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> index 776916b61c40..b1b574c7016a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -4,11 +4,11 @@
>   #include <sys/resource.h>
>   #include "test_send_signal_kern.skel.h"
>   
> -int sigusr1_received = 0;
> +static int sigusr1_received;
>   
>   static void sigusr1_handler(int signum)
>   {
> -	sigusr1_received++;
> +	sigusr1_received = 1;
>   }
>   
>   static void test_send_signal_common(struct perf_event_attr *attr,
> @@ -40,9 +40,10 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>   
>   	if (pid == 0) {
>   		int old_prio;
> +		volatile int volatile_variable = 0;

I think it is okay to use variable 'j' to be consistent with other
similar codes in selftests.

>   
>   		/* install signal handler and notify parent */
> -		signal(SIGUSR1, sigusr1_handler);
> +		ASSERT_NEQ(signal(SIGUSR1, sigusr1_handler), SIG_ERR, "signal");
>   
>   		close(pipe_c2p[0]); /* close read */
>   		close(pipe_p2c[1]); /* close write */
> @@ -63,9 +64,11 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>   		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
>   
>   		/* wait a little for signal handler */
> -		sleep(1);
> +		for (int i = 0; i < 100000000 && !sigusr1_received; i++)
> +			volatile_variable /= i + 1;
>   
>   		buf[0] = sigusr1_received ? '2' : '0';
> +		ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
>   		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
>   
>   		/* wait for parent notification and exit */
[...]
