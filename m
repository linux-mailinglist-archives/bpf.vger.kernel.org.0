Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA33A4CE731
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 22:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiCEVWA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Mar 2022 16:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiCEVV7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Mar 2022 16:21:59 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B900A4F479
        for <bpf@vger.kernel.org>; Sat,  5 Mar 2022 13:21:07 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 225AnCfI016039;
        Sat, 5 Mar 2022 13:20:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/ksXrycRlaHdqtgVCttVwVMBbeeaLIAX2EoBSIRfp2Y=;
 b=AyXxI9g7C3wHXc7LP7SUNKnm2aodlpGzeuxf2Bj8el5FhxG0e1vAXxf78z2wXdfANYjc
 dtt4EPphFNXm7xqvic9MDqp0XANHuHuBF523iREExp/215HuYUieNPfCLbcH77vuYnk2
 yWe5piIMMyHwYfIpX69kjbinr1rPbsoUUbM= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3em6es20xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Mar 2022 13:20:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AntGnbat8Dba/j7/zkkACJBEliQyrLORcVAXGllQ5Kbv0lvAdj9yTiqd8FNQ46bvfL+snXkpnwV3JEWkU310jXmFfe4lqpsTuqDuNARz8Bho/95NO2zyTRafgSixohVpxnbyTGzpPJGLKyHurvPyNdK19L65tES532pPotHjd6Ak0I+JUtrcx2bQVCPqrCj0Dq0/18EfFRSezwAULagR32jMSTaKexHeiL2lH6H/fdVynR3OTfb+bZ39Ac+pTi3/4hs8irUqwosbUs/oK6cyZTBfUC5iZ8gVkEtULc3VaJajuFwoofsGb3rNNRdar6h685y3Xb+o2Ljth2Lizk+JVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ksXrycRlaHdqtgVCttVwVMBbeeaLIAX2EoBSIRfp2Y=;
 b=JNtYR67p96JgpA6bT0QG/QTveUXNSp5UL6u9QjMyzQ1S5VdzeaMTPa2x7cfo/FyKuWjDgLQAsqVtZpNdtjpx412Hxir71crwNdfgnWBNJIECzQKpNd78idNpW4LUnxcZOl53uqdN9swguDl4/gg0QMQ7wo/rhDXURovYby5ywX3iGRruHB6nhAEkIfs453d1ooUYTYRhy9tDLFb2DefksyoGwcZCG9jyu16wGUDz8CPQV+LcWFf9Uj5bsnolIkrO8cb4Qw2Pmj6eqgiqzycalX4EmUcTmxQ4At682yOkIY1R+XrSoLvhQfoXIX9uKotiSznnObxDmUQmxPnHHbDnDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3546.namprd15.prod.outlook.com (2603:10b6:5:1f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.20; Sat, 5 Mar
 2022 21:20:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.029; Sat, 5 Mar 2022
 21:20:45 +0000
Message-ID: <b26d6c7d-cba1-8b54-2939-95f4232e3c4c@fb.com>
Date:   Sat, 5 Mar 2022 13:20:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next v1 4/4] selftests/bpf: Add a test for
 btf_type_tag "percpu"
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     acme@kernel.org, KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
References: <20220304191657.981240-1-haoluo@google.com>
 <20220304191657.981240-5-haoluo@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220304191657.981240-5-haoluo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:303:b4::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deec269d-232b-44b7-b2c4-08d9feee02ed
X-MS-TrafficTypeDiagnostic: DM6PR15MB3546:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB3546A8598C99CECF14989376D3069@DM6PR15MB3546.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSZz48Yl1wwxN7PNs7w/ub1SARE/I3GAg0vSeS16dxpjZ1UwhATBuqQ86RDA9CefsK8KiD23tsvphYMY/2sdIitH+iT+05G9fffiV503VJb5sSvVWpQb1KpUglK702oMAHGPaE4Bh/H47L9ThBla11OE/SxzIao+7NMVN5sP4l7HLrwyB0wdqJnY0B9mS0kjaDjcSpSo2sGtt40jyGoQWZqO0IuUdfX2lmDUTRH5Z0PDBH4T+HF7DxuYOwkSVRY+/f5bo7F5ILt08ZKtxCN6dXQ8gPk0aOybowAU42ntEucfMU7sIVUX3bfwHXOtL4hKZCL6wpY8klmSnQmS8kzqDoPm3uJvOh+nh8y9eMpyN9Xpgx0gnPMj60pLS2jQUuyLTyxD/xHc4+EWxgbm+WEulmnsRbi3Fea6MHZcRqn+ov6lGAkWNxOj8sJh3E5MlTmTSXxHZemiuqboqUo8rb+nkzPQM5uY5pXf78zdJsA5UK1rEw27aIiol7kX3anP5qGxXdwjVwXhM5b7MyHqVumu5MSXreY6c6WJooGEJTjxg1FQuQzf3g3MGPlIYoxHcyuoueQ+DuW1ysbgBahr4FgreiDhc1R/qD26a4o2Q+xY4+DEdlNMrbC04LOO9lHMAIff5VH3nUviTyjTBOmdI9h0ieXId4DxTQIpoTyl3BQX3m0QbrM8LNNk+tIF46hPQrpY0yl3tEXhPDzuHaUG8/DmXsj93I7OxeOJ0tRNHLqfV+8irCLA7C4app/LaiB6ai2P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(6512007)(2616005)(38100700002)(36756003)(316002)(110136005)(31696002)(66556008)(83380400001)(2906002)(6486002)(52116002)(66946007)(66476007)(4326008)(8676002)(86362001)(508600001)(53546011)(5660300002)(8936002)(6506007)(6666004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blFHZldDQXQzZS9FalJUODVhWDhlemprcWlyZjFiNXhhUGJ0ZCtWWHBLR2kw?=
 =?utf-8?B?Lzd6L2NtZE50akNVRFU3b2lZM1ZvYzdnUkhkSVdRZTFRa0cwY3MvenlGM0dt?=
 =?utf-8?B?T1NYS1ZYOUFZV2JBSUR1b2hJeGRnTmVQbGpHVXpuTFNIV2xuNzlzWkFZTTR1?=
 =?utf-8?B?bWszWnVJbUY5dzhWM3o1WWJhcnlRejAwWmd0eFZKdWxtS2U0NjlpSWpaMHUz?=
 =?utf-8?B?RDQ3bWg2OXZUOXlMbXVnazJpeTMwSzdKKzFYUytTaXIvYlRWak5PTmRIRXh2?=
 =?utf-8?B?SkdqMGNxVTdGSWgzWlJGR3Z4czhVaG1oZmdIS3JOaG1Vb3JIbzdHVTZkVXBN?=
 =?utf-8?B?Nzdlcm13cTZPSVZadDJkQzFwWEQ0L0E0SG0rb1p3eWliN292SVhaVXc0VW5W?=
 =?utf-8?B?S0IwbFUzYU5RRDJmRkk3eHNsRlF0WlI2MlhyUGtpZkhEZzBjT3FaWC9Ha2tr?=
 =?utf-8?B?cngrTUNBelR2RHdEZnhneEFQdjhkRC8rTkE5M01yOElFN0dGWVpscC9COW90?=
 =?utf-8?B?OWJsSnEyS2toajFIRG0yWW5IUUk5RmJQVzZkZVg4SVMzaTRVN0JjK0J3ZElz?=
 =?utf-8?B?Y1BlZk5IQ2lQNkJTaS9PRkR5Qkc0eEdYTUxFL1ZJMUxXNlFmTU9iMUtHeE1O?=
 =?utf-8?B?SWtLdkRUNGNrdkx3UzJ5aGlHYnNIbHI1aFBRTXJQYXMzYVhOS3hxbTJzc2Ix?=
 =?utf-8?B?Q0xsTG14ayswTE5COU84cGV6ZEh6bW1CK3VuUnJZbWdSMkVEOGZ3VGNOOUpJ?=
 =?utf-8?B?YW5zQnFSNE9ONGVhVWs0SHFJcGkvMXdyanRGWThRMGptZHBESjV3UFRxZW5E?=
 =?utf-8?B?ZXpUSjd3cnkrcW5yaDhqWDJ0R3VvTHJDNVpzVkN3UTBQQnVvTzhhME16NXdx?=
 =?utf-8?B?UkFPMitWb0ZQU2ZPbnRpdS9ZbXZBWE56UndEMEh3MUNpUGN4dnNKTzQxVSt5?=
 =?utf-8?B?bG45U21teDBDK0VJZmJudHl0eE95ZkdSaksxNzdXcm1ubXlRc0oyNVc4bjRJ?=
 =?utf-8?B?R205NlFqMmhNSHlkaEFIVGM1UHBDQ1B1YzYvSlF2TTF5MmxZaGpKMDgvZnNt?=
 =?utf-8?B?OUorZ3MyMlY5Z1AxZitybTNCSXFmTkdrcHZ3N3ROU0tNOTY5dVdUbi9sbDVj?=
 =?utf-8?B?K1NWTzI1ZWt2M0pGL3ZMSjZBZGszWnJiVW5RRUYxVjNQYWtYNkE5Ri84U0cz?=
 =?utf-8?B?TFdvRFNJcEdMeUpQRUt5Rnl5bDhmeG1ta1cvZ3dkbXE2cGpLUDFLNWRhWUpM?=
 =?utf-8?B?MU8xOHpVSHNLMHVEbEFwWGI2aURNZFc5bUgzRllrSzEvTnd4WE5HcGVRc0ZS?=
 =?utf-8?B?a0FrMEhiWDN1blZUL3NvWThwL0NXbFFod3FyeFNnN21ERVViekN6clkwY3R3?=
 =?utf-8?B?UEFkQUNmWFlwWmtxUjRXQzQvSVRJZzMxaUtMKytXbEs3YmprZSs1dlhpUjMw?=
 =?utf-8?B?RUozTXV3anpvbnFuSFVON0dCemlham5Vc2pJUklBMVRyYkI3Q0x3SE5MUm45?=
 =?utf-8?B?T3F6WGtTRURMcFV4UHZsa3dUczRXNGxDVE1td2VWZEsvUHpQVk1oOHRQdkYy?=
 =?utf-8?B?dVlzUzRBT0gvMnF2TTI2TlZLOEF3NDhNQ3k0TU13NTg1WUFkeHBDb2lFQnB3?=
 =?utf-8?B?bTFmWHg3TFVtQ2ZHVHJsVDdKWlIyUzQzZjBZUzRrTGNWU1dnTEowWXhYU2NY?=
 =?utf-8?B?SmpWV3hpUWJuZVJBOWRsNjBJb3dHRkVEQ0dZQTVLQWRVemgvT3ByN3pQenE2?=
 =?utf-8?B?dUZNbkx5Nzk2cEZ3aVNNbWd5SzZJWVh4enVWeWNRc2FRaWVkeGh6MjBTYm5I?=
 =?utf-8?B?LzRaa0dsTjg4amFscldqZkFUbVZKMTJUQWs2ZmwxeXZhdXd3YzU0QUlQcWZy?=
 =?utf-8?B?YktaWmlhbWRLbzhXNkZuSmJWRitkczVVSXZOYzRNOUE5K3VUZmxVYjV2L2x6?=
 =?utf-8?B?bEF1WXlzQkRvbEQ1cDdIdlIycHFBenRKSGlGT1ZFK1lzU1YrWlFzVmZ6WHVl?=
 =?utf-8?B?MHdpbldELy9LWUQraHRNRllDVjdjK01neVBacDBVbzRWcklSampkVVJQdUZH?=
 =?utf-8?B?TTlNTlJMTUc5ZXFQTFVBeWdTazBYemQwaUI4aUlmMWpENXJqUE55M1UzQkZa?=
 =?utf-8?B?UDlMUkk4eFBlRFlGekpvZXRDMHByRFFvZFpFVXM3ekF1ZHhJTHovUTBGTUJx?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deec269d-232b-44b7-b2c4-08d9feee02ed
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2022 21:20:45.5377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rQoDyLG/dyoEiv8nSQP9kw2G2ZQo6TeZ2fMvSi/hgYzKP0B5E65z6G9JuOTH4xx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3546
X-Proofpoint-ORIG-GUID: K3NO52l1kPIrH_e9H4_gB8IIqTvB349a
X-Proofpoint-GUID: K3NO52l1kPIrH_e9H4_gB8IIqTvB349a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-05_08,2022-03-04_01,2022-02-23_01
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


On 3/4/22 11:16 AM, Hao Luo wrote:
> Add test for percpu btf_type_tag. Similar to the "user" tag, we test
> the following cases:
> 
>   1. __percpu struct field.
>   2. __percpu as function parameter.
>   3. per_cpu_ptr() accepts dynamically allocated __percpu memory.
> 
> Because the test for "user" and the test for "percpu" are very similar,
> a little bit of refactoring has been done in btf_tag.c. Basically, both
> tests share the same function for loading vmlinux and module btf.
> 
> Example output from log:
> 
>   > ./test_progs -v -t btf_tag
> 
>   libbpf: prog 'test_percpu1': BPF program load failed: Permission denied
>   libbpf: prog 'test_percpu1': -- BEGIN PROG LOAD LOG --
>   ...
>   ; g = arg->a;
>   1: (61) r1 = *(u32 *)(r1 +0)
>   R1 is ptr_bpf_testmod_btf_type_tag_1 access percpu memory: off=0
>   ...
>   test_btf_type_tag_mod_percpu:PASS:btf_type_tag_percpu 0 nsec
>   #26/6 btf_tag/btf_type_tag_percpu_mod1:OK
> 
>   libbpf: prog 'test_percpu2': BPF program load failed: Permission denied
>   libbpf: prog 'test_percpu2': -- BEGIN PROG LOAD LOG --
>   ...
>   ; g = arg->p->a;
>   2: (61) r1 = *(u32 *)(r1 +0)
>   R1 is ptr_bpf_testmod_btf_type_tag_1 access percpu memory: off=0
>   ...
>   test_btf_type_tag_mod_percpu:PASS:btf_type_tag_percpu 0 nsec
>   #26/7 btf_tag/btf_type_tag_percpu_mod2:OK
> 
>   libbpf: prog 'test_percpu_load': BPF program load failed: Permission denied
>   libbpf: prog 'test_percpu_load': -- BEGIN PROG LOAD LOG --
>   ...
>   ; g = (__u64)cgrp->rstat_cpu->updated_children;
>   2: (79) r1 = *(u64 *)(r1 +48)
>   R1 is ptr_cgroup_rstat_cpu access percpu memory: off=48
>   ...
>   test_btf_type_tag_vmlinux_percpu:PASS:btf_type_tag_percpu_load 0 nsec
>   #26/8 btf_tag/btf_type_tag_percpu_vmlinux_load:OK
> 
>   load_btfs:PASS:could not load vmlinux BTF 0 nsec
>   test_btf_type_tag_vmlinux_percpu:PASS:btf_type_tag_percpu 0 nsec
>   test_btf_type_tag_vmlinux_percpu:PASS:btf_type_tag_percpu_helper 0 nsec
>   #26/9 btf_tag/btf_type_tag_percpu_vmlinux_helper:OK
> 
> Signed-off-by: Hao Luo <haoluo@google.com>

With one nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  17 ++
>   .../selftests/bpf/prog_tests/btf_tag.c        | 164 ++++++++++++++----
>   .../selftests/bpf/progs/btf_type_tag_percpu.c |  66 +++++++
>   3 files changed, 218 insertions(+), 29 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 27d63be47b95..17c211f3b924 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -33,6 +33,10 @@ struct bpf_testmod_btf_type_tag_2 {
>   	struct bpf_testmod_btf_type_tag_1 __user *p;
>   };
>   
> +struct bpf_testmod_btf_type_tag_3 {
> +	struct bpf_testmod_btf_type_tag_1 __percpu *p;
> +};
> +
>   noinline int
>   bpf_testmod_test_btf_type_tag_user_1(struct bpf_testmod_btf_type_tag_1 __user *arg) {
>   	BTF_TYPE_EMIT(func_proto_typedef);
> @@ -46,6 +50,19 @@ bpf_testmod_test_btf_type_tag_user_2(struct bpf_testmod_btf_type_tag_2 *arg) {
>   	return arg->p->a;
>   }
>   
> +noinline int
> +bpf_testmod_test_btf_type_tag_percpu_1(struct bpf_testmod_btf_type_tag_1 __percpu *arg) {
> +	BTF_TYPE_EMIT(func_proto_typedef);
> +	BTF_TYPE_EMIT(func_proto_typedef_nested1);
> +	BTF_TYPE_EMIT(func_proto_typedef_nested2);

Are these necessary? They have been defined in
bpf_testmod_test_btf_type_tag_user_1().

> +	return arg->a;
> +}
> +
[...]
