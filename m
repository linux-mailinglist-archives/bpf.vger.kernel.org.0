Return-Path: <bpf+bounces-2295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B3472A8A2
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 05:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367FB1C2121B
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 03:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6B94C98;
	Sat, 10 Jun 2023 03:06:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9681FA9
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 03:06:10 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3DF35B8;
	Fri,  9 Jun 2023 20:06:07 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35A2Cao5025167;
	Fri, 9 Jun 2023 20:05:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=QQDiUtItY8WMLpa9vMhQ/0I+o6tvGQEuDAIeTet0wmw=;
 b=PrFkm2P2+5y8BKdoPCpyNVqQ6LjGLAe6INUuQn20oHBjUNtOtGLkFM5zmwznDispSBBS
 cIgZP71o+HWlBmmiqdNLZBTGhbDVG+X32/o0gq3r7auhEntg1XiWasma6xooO2r+Zc0l
 46VANDjAZe4ZIZUyoc0SYAWMcivMQEIB54/JBz4me2WAMZX1Y3DeyWpPfIPcUQQ1+Gdu
 +RABcjaKhuIRS634z8YDQmscTE696kokgSbktPQnlu6fwRyj+K7JNutANkNQ8R499st4
 tVjqxBpIFG3RaEzuA1UBSDR1gNfamSKuXUAezv+dH/WBqtalkkdW8EeEKwUtgaEEfzzc cw== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r3r3fhx76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jun 2023 20:05:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8J8+jpC2qZTdcQxQivDi/WPI2t8Wz9VH1t6QmgFL0nB69ifk8UQK5em67OJjEEm0smhv3+nYXdqgQ17SqmfEZU2mBWmpq/aYxeMwQMIdxMzzUBP5c2nHqKx2rjVy1n+cvkuLDjEsQ/8SO2n2LA++o+NSWjqznjwqXPqayx2y7ED22tPePf1Gx1fEFVHYl39V+7jvNsHa7k5+nJ1Wqq7vOovSQ40P1210SS6d+ZIF01ekQi85vf5P0dDx+RozQXGNvLG/4I1vP35BcPMJdkD0ty2bzg0j5tHwn1K9fq2oHFuD4un2WTdqZ1i1Z5/amTXRdsct1LyXgdVjNicq2K01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQDiUtItY8WMLpa9vMhQ/0I+o6tvGQEuDAIeTet0wmw=;
 b=AoHys9bgVUQIqmoVY6cbl+6nuAfWtdSFQmlFbqfryvLycY7d7eNGLUq2/i8PAA+rZraTJbRIpAB6C1BjzYemyljtWRpR8Z4/2MK+XI/ROXEWWLqbC8j0nsUegA9R8zDCjsPcZHqsSoasyGu4yUeUr64HfGyNulPgb/g5bRbdLwlIScgh2uDeJGmeRNNkwwzClEG+VMQDBa9CMHY3DkaOY5NtLzd/kHUVxQIKTVIYw2HDhuocUGLae4QAAqVIJ25onDGCQUap/W1J0+Zlh7/UwgiZrEspDkRjvgLuTSel9r5A+scAaZ3OLfPF3guHJDlG0SFVdODI1kklq0OX70Ef7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH3PR15MB5612.namprd15.prod.outlook.com (2603:10b6:610:150::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Sat, 10 Jun
 2023 03:05:15 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 03:05:15 +0000
Message-ID: <eaafd39e-9c45-98db-9bc7-15712276eec6@meta.com>
Date: Fri, 9 Jun 2023 20:05:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next v4 1/3] bpf, x86: allow function arguments up to
 12 for TRACING
Content-Language: en-US
To: menglong8.dong@gmail.com, andrii.nakryiko@gmail.com,
        alan.maguire@oracle.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
References: <20230609095653.1406173-1-imagedong@tencent.com>
 <20230609095653.1406173-2-imagedong@tencent.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230609095653.1406173-2-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CH3PR15MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1a2e75-9651-48ee-b00b-08db695f834f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WHZsYuAGVZlvMdKy+gvZbYFl2ZA2ZgUIC3exifdKqHr9szFbw1cgA843LEBjRxJSC/nZKPIpyo++5g0nES3HD4DQ9jJ083IzuiLYCw8hZnbZ43JGJCHgTuiGYbcoSXPqjjYXctJWMuaNPlRNg6UqdGitbWPTLrk4DbC4muvkb3DecqzOXtPvv8hhsPIgs9vO4rOVKXACldHkeuenVoLEZXc24Bt0f60cEbvLsWL/6teaxPSz2NeZYsHs/6sHDHB9JZlsEwcNHKqNLGR6U/i1hbjfBv215Ov6w9c2xVjTuNjKC76a5oHHbTvun9WMGEUHpWz5clrKhV+R+fJgWWrihURgSU1uWWE1fjfs2lThn7/Sd9U8qFqUO1wu+cLH9Gwl+h+zp3hrqApvaOspU046wlrdTropGD73NOlhO6YsEmZIIh9SFNckamRDUBT3LIo286uZdnuahJDYFz6NXju50WllD/u67AAP1bTsuaD04E2qMZaHgeC9YPzuqTVJsHZETPoEGCAWjoLl1jpz/ZfY7IHPL+2Nz0C8dWGi1phfHhUEsrkjzJNZcmBvEZe/Naaz07aZA530dC+/Zl4fFA/OPNf60p2xK+BADf5zWf7i4eyiZJzwUZmIU4MzHxtgRK3nNpelL+KuXk70S6yaqv6u2g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(6506007)(83380400001)(36756003)(6512007)(53546011)(2616005)(186003)(6486002)(6666004)(66946007)(66476007)(66556008)(2906002)(30864003)(478600001)(41300700001)(31686004)(316002)(38100700002)(7416002)(8936002)(8676002)(4326008)(5660300002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUwyL1pPcXAvLzlyUUJzNExPQ1pvQ0NPQkJPTGpMYXdORnV5Nm01WjIrVWpK?=
 =?utf-8?B?dGNkdDBqb1RCbTRlWHRmc0pNcmQ5R2luazVEWDJaMFZKTFlqdEhvVlZWZTZh?=
 =?utf-8?B?QTlSekpzL2UzcXAzOU1Gb3c3eFFtZDhDbFFuUEljYVA5bFFSekI3U1FxeDFT?=
 =?utf-8?B?UGY1ekR3N3ZlSis0S1pXalU1Z1JZU0RMRHRUMVVwQ3VvU3JuNUMwSTdkTUtM?=
 =?utf-8?B?WW1uMmQ5cG9VbEllNGpxa2tjVGo3RUZrUytaenBqYWVaeWVSMWtKc0dwaDky?=
 =?utf-8?B?RitpcVl3eDJTUXk5NmFEMXRPeXFuckwyVmZtWXFKU3JENFNmaWFCNjdJQjly?=
 =?utf-8?B?UVhYeEtCTEtFcVNSeGIvcG1pSmtkNEtMenZPcEptRkt6UUJwNjd4WFlBa3hk?=
 =?utf-8?B?QjFMZzZZS05WSy9ycjVhU2dIRFhXMzhKM3hmVXNDLzZiV2piSm1CNUc4SGZD?=
 =?utf-8?B?TXBIQnNiL2ROaUU2ajZqTzkvcW83TXhYaU5TY3JoUkpjSjdYbFpTL3YreGx6?=
 =?utf-8?B?eW1kcnBHcGpCOFBsdWtkSlYrSmtHdW4xRHVqRXphZCtnUnVjcWdtdXlmeWpM?=
 =?utf-8?B?dUhsd3VoMXNqMWYrc2EvV3RxRjRndm1sWEN1bmYyS2lYQklhZ3ZOV3pzZGJS?=
 =?utf-8?B?V3dWcWxEZXdheUh2S2l6cjEwUUxSQlllZEdwanl4OEVnb0JWN2E4ZXk3MzRT?=
 =?utf-8?B?M3hkclNzTDJsUWFIV3hqOVh2dDhSOXhXbHkzVEdJNXpLZFhROGxHK1lodnk5?=
 =?utf-8?B?UW1jaEsxUVlmK1B6cjNEenp1U2hVWTRBVnYwcHg4VS9Ua2FNTlpxeTQ2ZHNR?=
 =?utf-8?B?TEw5dzdpZ010cEFSRkNKT25ja3p2dXd2L1luR3ZEa0VZOVhFSmF1WE55cWhJ?=
 =?utf-8?B?Qk4vZStocTMyMUZ6ZjN4MGZSa0ZpWUxiNDNmOXZyTVZBUGJFRzNvZUc3dW1w?=
 =?utf-8?B?eUxEZzdiTXZXWlhlSWVSRFhQeUxNS1R0cE5WNUJYWml6YzJieW1LS2gyZGQ5?=
 =?utf-8?B?UGFIUFlMZnhNWm43ME5sOHM0ZVZOMXJRVkVSOHFYam92WVJvM29oeXFzM3l1?=
 =?utf-8?B?Wm9GUVh0cnFhc20vWlI3cC84SEtWWTRzc2VqSFJ5WlFGajBjQVJwQmlzaVBV?=
 =?utf-8?B?QTB6L3Z1b3pBdVhDMTZsRll6SUx4bGpxdXVOeVJ0OEk3RHRKZEY3VGpOOXlG?=
 =?utf-8?B?ZHdNZ0h5ZzVwZ1pkcWZHN2xaQlFneG8ydHQvc0xGZjJNd1JFcXZpODE0RFg1?=
 =?utf-8?B?TmpnczU2dW03dzdTRWRwNjdpMzFmcjRvNjI5WGlCL3JxY0JMbTIzelBJTkRp?=
 =?utf-8?B?S2FLckYrMzI1VXU5aXVRLzdhOVlFa1k4SHUyblRIZ0RpamNoYytFaXdYWm5w?=
 =?utf-8?B?RTYyMUZQYVFVSG5uQ3dSYzBOeENKUTlRWUt1VndSeXhNNTBaMWEwM0lON3NO?=
 =?utf-8?B?SFM5MlpGeWRpMXVObGk4c0dCcEs3TUNoa09nUDR5RVFQN0t0Vmlsbk1tdC9U?=
 =?utf-8?B?MFBzTTRrdEwvelFucGFnMXFMaGpJMlJsRlc1Z0hGSkJERWFtNWRIelozQ3ZB?=
 =?utf-8?B?VFlXOXZkUVcrK2RJMHAvTmY3NWdDNnVDTmV6MFdWeXgzamdXYlBrMnIwSFdD?=
 =?utf-8?B?UldhY0xYanJmQWczL2RXUzRnQzFIZElwWkk1ekVOM0phNWFRZHVTeGZoV2Ri?=
 =?utf-8?B?cHV3RmRQdjl5UlAzSng3V3FlSnJMOVhWeEhEY1J0RVQ0NG1oSmp6cHlUWERk?=
 =?utf-8?B?Sm4rTG5NcXJWTTM2UmN5ZHpkM2g4ZFRqT2hueHdrTTF5Q0tKcG1aN1QrQWhQ?=
 =?utf-8?B?VGg0TUV6SWxGdDVBMDNsNXhqYXNsVVJDYmt4SnNXaW0xY2xxL0lYZEEwc3JC?=
 =?utf-8?B?RTFTUmNkcCs3RjlSRU1qV0c0UWVGZ2tvcDlnTEhCdDhpUUtpTGJsOThIcWdD?=
 =?utf-8?B?SmlEY2pLVXlOUUtwdXRZV3BvT0xmaDRaNjQvTTU5NzQwazlmSGdzU043QTNQ?=
 =?utf-8?B?YkNBWU5ZUk1Ua2NVTUxyVmR4U2FtdUovVVFLTXJiaEc5dXI4NkRZeThhZk5o?=
 =?utf-8?B?ME1xZmtoTkVIR3JPcTNuclJVMlVsNTJsWktRVTVRNUJIUndvL0RRcysySkp4?=
 =?utf-8?B?eHN1enBTNk5jNHNsWGcyVWhqZkxyVDV4KzgvN0krVnN0TjJpOHU0MUNMMDhy?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1a2e75-9651-48ee-b00b-08db695f834f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 03:05:15.1780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wirzAdTq6RTcJDKkgkcZHI9iLFQoyeHbX3DQ/S46B+B/FhBTr6VnY7uIzZm8WJoy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5612
X-Proofpoint-GUID: F9TX7owb8jpGwoV_xkdV7md61ls3lVMi
X-Proofpoint-ORIG-GUID: F9TX7owb8jpGwoV_xkdV7md61ls3lVMi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_18,2023-06-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/9/23 2:56 AM, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> For now, the BPF program of type BPF_PROG_TYPE_TRACING can only be used
> on the kernel functions whose arguments count less than 6. This is not
> friendly at all, as too many functions have arguments count more than 6.
> 
> According to the current kernel version, below is a statistics of the
> function arguments count:
> 
> argument count | function count
> 7              | 704
> 8              | 270
> 9              | 84
> 10             | 47
> 11             | 47
> 12             | 27
> 13             | 22
> 14             | 5
> 15             | 0
> 16             | 1
> 
> Therefore, let's enhance it by increasing the function arguments count
> allowed in arch_prepare_bpf_trampoline(), for now, only x86_64.
> 
> For the case that we don't need to call origin function, which means
> without BPF_TRAMP_F_CALL_ORIG, we need only copy the function arguments
> that stored in the frame of the caller to current frame. The arguments
> of arg6-argN are stored in "$rbp + 0x18", we need copy them to
> "$rbp - regs_off + (6 * 8)".
> 
> For the case with BPF_TRAMP_F_CALL_ORIG, we need prepare the arguments
> in stack before call origin function, which means we need alloc extra
> "8 * (arg_count - 6)" memory in the top of the stack. Note, there should
> not be any data be pushed to the stack before call the origin function.
> Then, we have to store rbx with 'mov' instead of 'push'.
> 
> We use EMIT3_off32() or EMIT4() for "lea" and "sub". The range of the
> imm in "lea" and "sub" is [-128, 127] if EMIT4() is used. Therefore,
> we use EMIT3_off32() instead if the imm out of the range.
> 
> It works well for the FENTRY/FEXIT/MODIFY_RETURN, I'm not sure if there
> are other complicated cases.

Just remove 'I'm not sure if there are other complicated cases'.
Since MODIFY_RETURN is mentioned. It would be great if you can add
a test for MODIFY_RETURN.

> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
> v4:
> - make the stack 16-byte aligned if passing args on-stack is needed
> - add the function arguments statistics to the commit log
> v3:
> - use EMIT3_off32() for "lea" and "sub" only on necessary
> - make 12 as the maximum arguments count
> v2:
> - instead EMIT4 with EMIT3_off32 for "lea" to prevent overflow
> - make MAX_BPF_FUNC_ARGS as the maximum argument count
> ---
>   arch/x86/net/bpf_jit_comp.c | 125 ++++++++++++++++++++++++++++++++----
>   1 file changed, 111 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 1056bbf55b17..a767e13c8c85 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1868,7 +1868,7 @@ static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
>   	 * mov QWORD PTR [rbp-0x10],rdi
>   	 * mov QWORD PTR [rbp-0x8],rsi
>   	 */
> -	for (i = 0, j = 0; i < min(nr_regs, 6); i++) {
> +	for (i = 0, j = 0; i < min(nr_regs, MAX_BPF_FUNC_ARGS); i++) {
>   		/* The arg_size is at most 16 bytes, enforced by the verifier. */
>   		arg_size = m->arg_size[j];
>   		if (arg_size > 8) {
> @@ -1876,10 +1876,31 @@ static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
>   			next_same_struct = !next_same_struct;
>   		}
>   
> -		emit_stx(prog, bytes_to_bpf_size(arg_size),
> -			 BPF_REG_FP,
> -			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
> -			 -(stack_size - i * 8));
> +		if (i <= 5) {
> +			/* copy function arguments from regs into stack */
> +			emit_stx(prog, bytes_to_bpf_size(arg_size),
> +				 BPF_REG_FP,
> +				 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
> +				 -(stack_size - i * 8));
> +		} else {
> +			/* copy function arguments from origin stack frame
> +			 * into current stack frame.
> +			 *
> +			 * The starting address of the arguments on-stack
> +			 * is:
> +			 *   rbp + 8(push rbp) +
> +			 *   8(return addr of origin call) +
> +			 *   8(return addr of the caller)
> +			 * which means: rbp + 24
> +			 */
> +			emit_ldx(prog, bytes_to_bpf_size(arg_size),
> +				 BPF_REG_0, BPF_REG_FP,
> +				 (i - 6) * 8 + 0x18);
> +			emit_stx(prog, bytes_to_bpf_size(arg_size),
> +				 BPF_REG_FP,
> +				 BPF_REG_0,
> +				 -(stack_size - i * 8));
> +		}

I think we have a corner case which does not work for the above.

$ cat t.c
struct t {
   long a, b;
};

void foo2(int a, int b, int c, int d, int e, struct t);
void bar(struct t arg) {
   foo2(1, 2, 3, 4, 5, arg);
}
$ cat run.sh
clang -O2 -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -c t.c
$ ./run.sh
$ llvm-objdump -d t.o

t.o:    file format elf64-x86-64

Disassembly of section .text:

0000000000000000 <bar>:
        0: 48 83 ec 18                   subq    $0x18, %rsp
        4: 48 89 f0                      movq    %rsi, %rax
        7: 49 89 f9                      movq    %rdi, %r9
        a: 48 89 7c 24 08                movq    %rdi, 0x8(%rsp)
        f: 48 89 74 24 10                movq    %rsi, 0x10(%rsp)
       14: bf 01 00 00 00                movl    $0x1, %edi
       19: be 02 00 00 00                movl    $0x2, %esi
       1e: ba 03 00 00 00                movl    $0x3, %edx
       23: b9 04 00 00 00                movl    $0x4, %ecx
       28: 41 b8 05 00 00 00             movl    $0x5, %r8d
       2e: 50                            pushq   %rax
       2f: 41 51                         pushq   %r9
       31: e8 00 00 00 00                callq   0x36 <bar+0x36>
       36: 48 83 c4 28                   addq    $0x28, %rsp
       3a: c3                            retq
$

In this particular case, there is a struct argument (16-bytes).
Only 5 registers are used to pass arguments instead of normal 6.
The struct parameter is put on the stack. Basically struct
members should be all in register or all on the stack.

Not sure whether the kernel code contains similar instances
or not (not fully using 6 registers while some parameters on stack).
If not, I guess we do not need to support the above pattern.

>   
>   		j = next_same_struct ? j : j + 1;
>   	}
> @@ -1913,6 +1934,41 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
>   	}
>   }
>   
> +static void prepare_origin_stack(const struct btf_func_model *m, u8 **prog,
> +				 int nr_regs, int stack_size)
> +{
> +	int i, j, arg_size;
> +	bool next_same_struct = false;
> +
> +	if (nr_regs <= 6)
> +		return;
> +
> +	/* Prepare the function arguments in stack before call origin
> +	 * function. These arguments must be stored in the top of the
> +	 * stack.
> +	 */
> +	for (i = 0, j = 0; i < min(nr_regs, MAX_BPF_FUNC_ARGS); i++) {
> +		/* The arg_size is at most 16 bytes, enforced by the verifier. */
> +		arg_size = m->arg_size[j];
> +		if (arg_size > 8) {
> +			arg_size = 8;
> +			next_same_struct = !next_same_struct;
> +		}
> +
> +		if (i > 5) {
> +			emit_ldx(prog, bytes_to_bpf_size(arg_size),
> +				 BPF_REG_0, BPF_REG_FP,
> +				 (i - 6) * 8 + 0x18);
> +			emit_stx(prog, bytes_to_bpf_size(arg_size),
> +				 BPF_REG_FP,
> +				 BPF_REG_0,
> +				 -(stack_size - (i - 6) * 8));
> +		}
> +
> +		j = next_same_struct ? j : j + 1;
> +	}
> +}
> +
>   static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>   			   struct bpf_tramp_link *l, int stack_size,
>   			   int run_ctx_off, bool save_ret)
> @@ -1938,7 +1994,10 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>   	/* arg1: mov rdi, progs[i] */
>   	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
>   	/* arg2: lea rsi, [rbp - ctx_cookie_off] */
> -	EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
> +	if (!is_imm8(-run_ctx_off))
> +		EMIT3_off32(0x48, 0x8D, 0xB5, -run_ctx_off);
> +	else
> +		EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
>   
>   	if (emit_rsb_call(&prog, bpf_trampoline_enter(p), prog))
>   		return -EINVAL;
> @@ -1954,7 +2013,10 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>   	emit_nops(&prog, 2);
>   
>   	/* arg1: lea rdi, [rbp - stack_size] */
> -	EMIT4(0x48, 0x8D, 0x7D, -stack_size);
> +	if (!is_imm8(-stack_size))
> +		EMIT3_off32(0x48, 0x8D, 0xBD, -stack_size);
> +	else
> +		EMIT4(0x48, 0x8D, 0x7D, -stack_size);
>   	/* arg2: progs[i]->insnsi for interpreter */
>   	if (!p->jited)
>   		emit_mov_imm64(&prog, BPF_REG_2,
> @@ -1984,7 +2046,10 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>   	/* arg2: mov rsi, rbx <- start time in nsec */
>   	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
>   	/* arg3: lea rdx, [rbp - run_ctx_off] */
> -	EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
> +	if (!is_imm8(-run_ctx_off))
> +		EMIT3_off32(0x48, 0x8D, 0x95, -run_ctx_off);
> +	else
> +		EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
>   	if (emit_rsb_call(&prog, bpf_trampoline_exit(p), prog))
>   		return -EINVAL;
>   
> @@ -2136,7 +2201,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   				void *func_addr)
>   {
>   	int i, ret, nr_regs = m->nr_args, stack_size = 0;
> -	int regs_off, nregs_off, ip_off, run_ctx_off;
> +	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
>   	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>   	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>   	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
> @@ -2150,8 +2215,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
>   			nr_regs += (m->arg_size[i] + 7) / 8 - 1;
>   
> -	/* x86-64 supports up to 6 arguments. 7+ can be added in the future */
> -	if (nr_regs > 6)
> +	/* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
> +	 * are passed through regs, the remains are through stack.
> +	 */
> +	if (nr_regs > MAX_BPF_FUNC_ARGS)
>   		return -ENOTSUPP;
>   
>   	/* Generated trampoline stack layout:
> @@ -2170,7 +2237,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   	 *
>   	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
>   	 *
> +	 * RBP - rbx_off   [ rbx value       ]  always
> +	 *
>   	 * RBP - run_ctx_off [ bpf_tramp_run_ctx ]
> +	 *
> +	 *                     [ stack_argN ]  BPF_TRAMP_F_CALL_ORIG
> +	 *                     [ ...        ]
> +	 *                     [ stack_arg2 ]
> +	 * RBP - arg_stack_off [ stack_arg1 ]
>   	 */
>   
>   	/* room for return value of orig_call or fentry prog */
> @@ -2190,9 +2264,25 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   
>   	ip_off = stack_size;
>   
> +	stack_size += 8;
> +	rbx_off = stack_size;
> +
>   	stack_size += (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
>   	run_ctx_off = stack_size;
>   
> +	if (nr_regs > 6 && (flags & BPF_TRAMP_F_CALL_ORIG)) {
> +		stack_size += (nr_regs - 6) * 8;
> +		/* make sure the stack pointer is 16-byte aligned if we
> +		 * need pass arguments on stack, which means
> +		 *  [stack_size + 8(rbp) + 8(rip) + 8(origin rip)]
> +		 * should be 16-byte aligned. Following code depend on
> +		 * that stack_size is already 8-byte aligned.
> +		 */
> +		stack_size += (stack_size % 16) ? 0 : 8;

I think this is correct.

> +	}
> +
> +	arg_stack_off = stack_size;
> +
[...]

