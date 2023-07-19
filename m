Return-Path: <bpf+bounces-5230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B811F758ACE
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 03:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D431C20B5F
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 01:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CD417D0;
	Wed, 19 Jul 2023 01:23:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091EECA
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 01:23:15 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2C812F
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 18:23:14 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36INPmxm014413;
	Tue, 18 Jul 2023 18:22:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=muilMJNNuGCQxMX5J1y6L9xDIKv6OW3fejDYHqBE5rI=;
 b=eAyUTqEL8YxL8y8mrDK22rTFlSo9VAut4wsyOKaNoobUwlZzf9YGpiZECB2QTwBY4nm6
 viU9LI7bA6I/ydLMCz+RGT9nka0mKWdczGuxOZNHPZKPDMyRTWzjcMR/3Ze85wMIwUQ0
 PArC1x20HbCYNgCjOYNtCF4VZVGP0gzhdIlP0wafeek7daSIl0DXKcFTTjU2z8F/Tie5
 jkvAVJQVJNzvut8CV7TyeEautCtJnj34XhroTY6uz1C8Oy1zlmb8wmR1hLztyveWLNgC
 lE6cIfFd+wKa2+a9ND76ruUqclDD5Vpo2I6lWCqdEDJM0+wJ+0Wy28jYlDH2QrDf0wYI zQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rx4cygry0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jul 2023 18:22:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQLctjf5cxenT6VzewTPs2QIBWFE9dnyEYpUvGlhTT4DJAOw6tQED3Md2yS28PUCUDgNkBTXgR91g0yks3Lmakq7LTB2zlyuXD3Ep+6056W89+kTytkZjZDrjr7jTVdTOkmFCH/ykj5lPwvHnvhzcGYO53zvpvXVopv3Xjv/tlU+6lhNeN5ufzEDmodvX9YTmziCXYnLR0aycAv5QEjeFgjZvq9ScucMJ8Vd9zQ/8Lq6GDN+UxsgQb6IDXk3XsFI5mvWFn/IUd3xxhEJJs/WyuKNddN3D5ty+2Cl9rLia4gLu0zEhXq0sO5Ym+AyIVA4GRedXPz+Km3LrzJrTAWOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muilMJNNuGCQxMX5J1y6L9xDIKv6OW3fejDYHqBE5rI=;
 b=c7TS1f7ZoGUf7xQX29x/3eUZceRJaLXDKFR0Sjq9QSNf9x7+/nQiKplMALCXVxLIWT1HfHIqsNB+ZQgaRDglszruj0a2ScjVK/LH312qRuTKNympjcA7WypwVr+t7hP7Ua+K88WQxzUHvgUmmU6Apt/6kxiz10P3oyURe0Qwqm4gZIMTs/asqCZboXgxWcppLWYvpy2QymIX69PbXJCaU3BjskJ7klwjNYa/DgQRajDeraUOr+wDM0Bvwq9eDiy7R2K0HPT2adPnHR7XXN+mLl3HujvuOynrlDeilJFjbC+yN2CbNCBaOidcCJ7vKxHkgR9P+1rkK82s8yz1ya0TIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 01:22:56 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 01:22:55 +0000
Message-ID: <130320e5-3ee9-0148-3f12-58a3a1cf2123@meta.com>
Date: Tue, 18 Jul 2023 18:22:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 04/15] bpf: Support new unconditional bswap
 instruction
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com
References: <20230713060718.388258-1-yhs@fb.com>
 <20230713060739.390659-1-yhs@fb.com>
 <cb9ba725b54fb02a5a552d46043a8e90c6f7b85a.camel@gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <cb9ba725b54fb02a5a552d46043a8e90c6f7b85a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BLAPR15MB3889:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a6d570-5d28-46f1-16fe-08db87f6ade7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Xa5w8dNv4h8QGSF1yxpMRNxiyiCpRIEu4xXIJfM3JJLSrsRnWwaSOgtbOB7tgI7yrhIMAN1vrWA843JDfkQne18Rv4HiW7TDe8Aldtc8IRIOWjcy2/uB6vug4Be1nisCykUtd/lKdJbPm2kLr8bfSs2p0lsVY65l6yjs6jFj71/TVuagyb1WJV9qAiLzSsuO20i07gu0de2EyFrCYE9Vwd0c6SbvK9awjxNZaOhAOCpG85eUs/8DM1hKzq0j9P9d+OcP3Z5stVWsYj1vz1dcdnxu+DczyGQwDxBQi/RyeASo5b8eZuUx9UwiVRK7kAtuiHVfZGHpaDoVpu9xYJq5Oa7pOO0q6zqoxp9Nhrz1FVH39EGDYu+WvoC334ADUmlKYQ2C4mhXW0zlkpgWlx8S1Smh1QY6xjec7qiqa/+1q3Ab4QjtRCvfCGQFrO1EbKFwlbOp1QpZiMqUwQl54X/3v9D13PGJZevrbOGoflPHQkxzaXB0+lrbBC3KDEWeHE02jEcZa342TsS7EPsmrHI+iCxwCj+nkZp8I5kLfXZ8eKE22Q9BnnTNVlaggpO0jkM/5Ln+mlzxga2/csicIc4/hwNuiMCU7286GAqmgSUz46R/8Egl6rCSPi/ePD71ndDgUSdty3NceDecX3ScgKb+yg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(31686004)(2906002)(8936002)(8676002)(66556008)(66476007)(4326008)(66946007)(316002)(41300700001)(5660300002)(53546011)(6506007)(6512007)(36756003)(6486002)(186003)(478600001)(6666004)(110136005)(54906003)(83380400001)(2616005)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WXBCczBBbzJvRFBQMHo3Vmk1aHZCVVRwL0VycHJMQW1NeEoxZFlsV0R0dGZy?=
 =?utf-8?B?UDU2bnh3K1V0bERrL1UyOTA5QkNiSGhNQ090UmhVOERLWmJCSGFjSzkyNHEy?=
 =?utf-8?B?MDZQSUZqbm04Q29OMVo0aFNNRXlIcnFLS2l1QkUydEdpeDBiT29uS2xQVEtC?=
 =?utf-8?B?dEpoNFlYZktjZmp6dTUzd05LSEFjaXU2SWJLT0ljcFArZEQ4S3JOS1dVWFMz?=
 =?utf-8?B?bE4ra1ZvOEt6d2dOa2xOKzJjMHNGWWgyUkdUVHpPaFlDMWNGNDhzVThLY2ho?=
 =?utf-8?B?TWJlWTYvU3F2emk2amtoNGVwbHpxUllsQUdJSW1qckovaXpFZkRCU1Z3Smp5?=
 =?utf-8?B?V0JBT1ZNV0t1OVM4VkZwNnFTVzZvSTJzbmR0eHpkdWtPL2k3Zk1ZWjN0SmN3?=
 =?utf-8?B?bHNRTndhMHZDT0xUbzFET2lFMUhjbFIzcVdoUjV3aEFMOFl2MGljek1XQzdk?=
 =?utf-8?B?RlNiMmswRldIeUF1bk5FRkhJblk0eFkvVFpCdnkxdTEyMkJyYkNuTndZd3h4?=
 =?utf-8?B?QUdSaVZKcUNxVkRIT1BIOUwvVnNpNXYrN2NSR2dacVBEa1RGOERrQXlDWEtN?=
 =?utf-8?B?NzFFZEhYeXhNZGxwZ3ZyaUtybkF3NHhEdmdEdGg0SUdNdFcwQ2ZlSzNkby9Y?=
 =?utf-8?B?VlNvalp3RW1Vc00zdUNsd1FXVEl3c0Qzb00rUUdTQ1BwOCtYWlM5M3c3SjU5?=
 =?utf-8?B?cmh6c1VjYXY4NVRNTm1oVTBsYmsxVGN2TmxXaEkvM3lzclBVRndFbFZiZE1y?=
 =?utf-8?B?SDRRbDAyKytINjdnME50dldNcTN2elpkbXNJZy9udzUwdHRZditIMFJjd0k2?=
 =?utf-8?B?SHpvUmRvUGdZRkplVXdSVFdnbTZnR0s5Qmd0M1p5QkJDME5EUWlZNzZNMTh6?=
 =?utf-8?B?dXNXZFFCdDVGS29EWFVYTEl1YmlEZ0Z1WGs5R3hsR1REREFBeHpMVWRDSUF3?=
 =?utf-8?B?SWhZdWJyRi91cGd5azhzdW5jaDhFS1JVcDVTZ25TZ05Wa29uTkUrejNBMktp?=
 =?utf-8?B?UDJHUHJOdW5mNktERWgvQjhLVnR1WGd1NkNaNGlIMDRoRXd2U0Z4T29xV1lL?=
 =?utf-8?B?Nk84cmNvQnlkZXRmRmRkNWZaNlArVjZlanZBbEpxNVhtSkdpcGw1dDhrZkw2?=
 =?utf-8?B?K2xKYzd6WG01QVJFV2RDYUR1dk9jaEZwcTVHVDZnMmJWYi9GVTR4MEliYzBX?=
 =?utf-8?B?UWFNSldzOU9aN1h4aGsvck1SaE1kRzI3K2NOTU9YRjdReTJ3cCtwU0NBalpB?=
 =?utf-8?B?cDRtNzhkYnZ4RlJoTEVvajJUdXRRU0tJYUVZMUsvaHlsbVQwbHVGLzNrWlVD?=
 =?utf-8?B?T3VnRXVhd2J4bkIyZmRBdkFjMWVaZDVFeHhyZDkwMDMxRFhtcUlySGFkUm1z?=
 =?utf-8?B?NENyZVpxWG5QekIwbldVYy8zbHhZUitFdzhyNVQ3eXQ3bGdlSmJWN1ZEU2R2?=
 =?utf-8?B?bVl0SUlBR3lRZFBqcGF6VGttelBGdUh4RG9tVVNzYkNlMnprRUw0MFhrZkQw?=
 =?utf-8?B?L2ZXeDZmZ3dwOHNVejNvRDRMVC84SWV3MDVaWnZIM1dadG52eDhoVjFpY2Fy?=
 =?utf-8?B?Vm9rWWdvcmdMUzQvZjZoWmFxR3M3Wm1hbVJIRFJISDgrKy9VQklua01DSFh5?=
 =?utf-8?B?VWp0Z2hlVXhQV2t1aTViTDc3YkduYlg0aXo3T2ZXQ0lyVUdTbXJ5V28wQy82?=
 =?utf-8?B?b3NGWDRqNmZOSTZCNkc0NkFLWVd4aEo2RHEwd1RuTXN2bmkxb2hqMHEwUjV4?=
 =?utf-8?B?OU13S3pENjEzMURFNkZ0R2t4cEV3b0VJbXFkWGdVOEJsV3dLNEwyQWhndVNH?=
 =?utf-8?B?RWV4ZTluTk1MRVRYbFZidzI5ajJpeXdQTWxJZ3JOMGN4bmNjOHIwSWZWOTZP?=
 =?utf-8?B?UUdnOU55SWsraDQwRVZZUEs1cTRxZWQyVGxodXVQZSs1WWVWMW8xemJDRjRx?=
 =?utf-8?B?YmJuOHpIU0djeFZCdkJHLzA4ZG8wQlJzNFIzOUNnRDZ5NlhsdHZuZGlSblhD?=
 =?utf-8?B?clFyT3dmVlRUNU9uMTAzaXZwN0tNMTRqOTdkRC8wdXVoNlE3aHRFS3F6S0lU?=
 =?utf-8?B?SENhOW50Zjc4S0gzVnJRM2ltYjJhRU1DTmNodEFNdkUxblFXZDJSZ0FpRVRv?=
 =?utf-8?B?N3hYY2g2Y1A2RjQxU0xNNXlWMmIwa2tSWHZaOFV2NzAyNXRqUldHVXEybGcz?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a6d570-5d28-46f1-16fe-08db87f6ade7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 01:22:55.3655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCBZsrxLh7h/uxHNtMR5skmsfY+0MJCJ9YsLDMtx2tZpwi5oyKLcfgnDycdTsJiE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3889
X-Proofpoint-GUID: dcJDJflHcVYDIP_YToCJzsD-U5VF0gnG
X-Proofpoint-ORIG-GUID: dcJDJflHcVYDIP_YToCJzsD-U5VF0gnG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_19,2023-07-18_01,2023-05-22_02
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/16/23 6:42 PM, Eduard Zingerman wrote:
> On Wed, 2023-07-12 at 23:07 -0700, Yonghong Song wrote:
>>> The existing 'be' and 'le' insns will do conditional bswap
>>> depends on host endianness. This patch implements
>>> unconditional bswap insns.
>>>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
> 
> Note sure if this is important, but here is an observation:
> function is_reg64() has the following code:
> 
>   ...
>   if (class == BPF_ALU64 || class == BPF_JMP ||
>   /* BPF_END always use BPF_ALU class. */
>   (class == BPF_ALU && op == BPF_END && insn->imm == 64))
>   return true;
>   ...
> 
> It probably has to be updated but I'm not sure how:
> - either check insn->imm == 64 for ALU64 as well;
> - or just update the comment, given that instruction always sets all 64-bits.

I think we can remove insn->imm == 64 from condition.
But I need to double check.

> 
>>> ---
>>>   arch/x86/net/bpf_jit_comp.c |  1 +
>>>   kernel/bpf/core.c           | 14 ++++++++++++++
>>>   kernel/bpf/verifier.c       |  2 +-
>>>   3 files changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>> index a740a1a6e71d..adda5e7626b4 100644
>>> --- a/arch/x86/net/bpf_jit_comp.c
>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>> @@ -1322,6 +1322,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>>   			break;
>>>   
>>>   		case BPF_ALU | BPF_END | BPF_FROM_BE:
>>> +		case BPF_ALU64 | BPF_END | BPF_FROM_LE:
>>>   			switch (imm32) {
>>>   			case 16:
>>>   				/* Emit 'ror %ax, 8' to swap lower 2 bytes */
>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>> index fe648a158c9e..86bb412fee39 100644
>>> --- a/kernel/bpf/core.c
>>> +++ b/kernel/bpf/core.c
>>> @@ -1524,6 +1524,7 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
>>>   	INSN_3(ALU64, DIV,  X),			\
>>>   	INSN_3(ALU64, MOD,  X),			\
>>>   	INSN_2(ALU64, NEG),			\
>>> +	INSN_3(ALU64, END, TO_LE),		\
>>>   	/*   Immediate based. */		\
>>>   	INSN_3(ALU64, ADD,  K),			\
>>>   	INSN_3(ALU64, SUB,  K),			\
>>> @@ -1845,6 +1846,19 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>>>   			break;
>>>   		}
>>>   		CONT;
>>> +	ALU64_END_TO_LE:
>>> +		switch (IMM) {
>>> +		case 16:
>>> +			DST = (__force u16) __swab16(DST);
>>> +			break;
>>> +		case 32:
>>> +			DST = (__force u32) __swab32(DST);
>>> +			break;
>>> +		case 64:
>>> +			DST = (__force u64) __swab64(DST);
>>> +			break;
>>> +		}
>>> +		CONT;
>>>   
>>>   	/* CALL */
>>>   	JMP_CALL:
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 5fee9f24cb5e..22ba0744547b 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -13036,7 +13036,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>>   		} else {
>>>   			if (insn->src_reg != BPF_REG_0 || insn->off != 0 ||
>>>   			    (insn->imm != 16 && insn->imm != 32 && insn->imm != 64) ||
>>> -			    BPF_CLASS(insn->code) == BPF_ALU64) {
>>> +			    (BPF_CLASS(insn->code) == BPF_ALU64 && BPF_SRC(insn->code) != BPF_K)) {
>>>   				verbose(env, "BPF_END uses reserved fields\n");
>>>   				return -EINVAL;
>>>   			}
> 

