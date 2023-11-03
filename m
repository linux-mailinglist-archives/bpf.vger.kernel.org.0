Return-Path: <bpf+bounces-14064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2397DFF7B
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 08:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDC21C21033
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 07:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9198579CD;
	Fri,  3 Nov 2023 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e5TzXrKZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570B748C
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 07:52:54 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705F71A6
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 00:52:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wy4rbM60BlZMH0IU3fNrENnZwfHcZ2ncifd1IT2hcAut29PSHDfjdyWNsnCRU3NAwYTe79woN6FKz/mzSjMZ4eAiZXFNA8j9s2SxuOJ9V1DSUExjVhUu48ydlJQrkFUiZ3avVfGDSAIaxiZK/Pmfo+G1MZx+CQxa9nI4JOEjj4ZUBuIXOzS6ePGVrmEfnH+QndSW19s4ioK1kpnijcu5bINHPjT7eaJgT3RVOQamVrvxSwD4z0SsEPltuZJFvdjywpk1VLwAAYQJxOecHK8mxFtqsEWxihx3vHuWqQkwEvDdh1g3h/Er5d22F13orsMG6HUrwi/pOu3KR/hG8WZRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoC1FTUF8b+Jdge9zWfy49AWMVzWJgy8W+XTtxSCVLI=;
 b=dzekW3EMKd9/zsRayNH2Snr4yn+/9mVFlMq5R6OeQZG0CYct6B4Zt8OCCPGa5UbX2urNRqOQFAUh22aTeQtNd35nrkz5noiM0ScAf76/p3v8oPsX+YaDxmcST4w77ML8pts0u27LIZPfwKkRhgKFvKg/Xs+O0QXa57mlYYd35C0gFg5+Y1H6uWdQQaElPe/68aUZrtWKIYfePNl20HI/bMALvZCDFybpBTRxMJgS2C9diYyovdQws54vDim7BJXCpbVVVqTMxSAtcDoacW73xtewZ7aVlAxTJ5gqsMI3mu+ansLPvvvwr4EC78PHs0cQKu63byKt431IBT9py85ELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoC1FTUF8b+Jdge9zWfy49AWMVzWJgy8W+XTtxSCVLI=;
 b=e5TzXrKZMrVSNV4nCpdzLS0UcYfgbc5u+8xHPfUVqN3NOLdzUOzWpgNGbWVuf1lgvLfTem2uIl/U5Kjcfwcopeaj1FXzBx84oDe6Q6ccVMIy4cy5ZAW6L4fE9Uu4xAjuWnovPkdrEBLTafwXS/k+ztlI8QA1Big0voHS+5mtRKApgERbKa2AUKCBy8Xwx3gbedLDVPgdzAZ5XzcNNqkaUqswcGpSSLmQBElaVkQj5t6AnZktWeauwSa66D+YzWxyDKOYZ46ZLRAQqfEgBJKs/C1L65gqKBRvObQx29poGyuMN9XEvro4xr0zcLAHmp2dQ2jkrBm9mLucnmy01a9K/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by GVXPR04MB9849.eurprd04.prod.outlook.com (2603:10a6:150:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 3 Nov
 2023 07:52:45 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.019; Fri, 3 Nov 2023
 07:52:45 +0000
Date: Fri, 3 Nov 2023 15:52:36 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 01/13] bpf: generalize reg_set_min_max() to
 handle non-const register comparisons
Message-ID: <ZUSmxI9EoWjUyO_t@u94a>
References: <20231103000822.2509815-1-andrii@kernel.org>
 <20231103000822.2509815-2-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231103000822.2509815-2-andrii@kernel.org>
X-ClientProxiedBy: TYCP286CA0261.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::12) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|GVXPR04MB9849:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb0325b-8525-49ad-c8d9-08dbdc41dd3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FmQSFK+BtAidusRkJxlvERAcVLtXlnS6BJQ/VS+HwRmY3cG/bsy/TT1IQ/b67JWeAepOZTWbDm8xqoyIpx44mEyR4EdhmDzn7XQhPU54ST6wS7/ezHrPEl9adqFHK6JgFvq4qr9GEQbEHoq6B3Hp5Z7k8HrpPgIXjWDkkX1wiqoRdpCQebVuCzx7avb29vY0LT5acnBE9tAyQv4118nw0Z22L6UnmWdVq6PNxHu5Z7ZAp37xh2t1si/+A4409Zm+KZKbt0Qwn8ElbnCYHwXncBctop/XxClsRH1ifbh3Lyj2US7JWyQkmghen8lWSNl3Q9pAIsitlXe7AW5H7iq2I5VlxGAmTZoqk7MSx4lJZzrbdEFHDkauVGWrAXkMmY5E8iO2sEZstkxn1BvyiNz3P761ZN6AV8Y+iKr1QbZ8fbHgU8VJgRBLD19/xNEpPKYci6kOae/wiKRhk/LJiTXVQiKXP2EFL0I767LgH++k9fSR/2IO/5wmZAQOhp0XI0pfVmD2o8NEOPOF6PychAWq77x3tt2tuIycHCt+6GMC79nDKNkLU3Xi0dRtn4z27ebJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(316002)(66899024)(66556008)(66946007)(66476007)(26005)(9686003)(6506007)(6512007)(38100700002)(33716001)(83380400001)(6666004)(6916009)(86362001)(478600001)(6486002)(4326008)(5660300002)(8936002)(2906002)(8676002)(41300700001)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c21lbmxjNnlvUTVHZjY4dnZnZ1kzZm1CK2Jncko3dE9NbFc3Tkh6UnBUelpM?=
 =?utf-8?B?NjM1dVB0K1ZOZVlOTHZqZGRmOUY4QTl5UXh4MFpjbkMvK1gxSE1DOVB5bC9N?=
 =?utf-8?B?Nk5VYnlNNHBrakxIWkd2ODcrM3o3REdxYlpUd09XdzE3WnVEVmt2d1lkcE12?=
 =?utf-8?B?UDdzck1NR1c3aXFLUWpZT1dVdnB2dkx4OGFNK0lMQU9LcmdQVHdUUlhqbGJ6?=
 =?utf-8?B?TDhRMkRaUWVLNmg0VWVGRzNSUlNVNTIvVVRaUE1PZG5ZRzRQclNzbHozSFc4?=
 =?utf-8?B?SW1OZUhmYVlNSGhkNWIvNmM4Y1dJb1hTM04xdjJHd2JHTU50MkZrVkpIY1ZW?=
 =?utf-8?B?c2NvMU9nY1lGWmI1TTVYSyszVEFobjBsbWlCSDJqOUFnLzcxV0d0a21xS3NE?=
 =?utf-8?B?bVFjUTM4NC9xNXhma2YwakkzRmRuY0VmV0Q1RW85MUN0T21xeUJURkpZWGo2?=
 =?utf-8?B?M3JKWG9rZlp0dWluL3BlVU9FVVRGd09XTk5qbUZlaG5Oam9lTCt2LzlVYmlr?=
 =?utf-8?B?Um01WGdhbG5VSmZhV1BVb3lOT1JaVHFIWlB0aFJtQmQrWFJRbDU2eFBuNXZH?=
 =?utf-8?B?NnFyM1lqNWJ0S20wQTRvb0xJa3JHU1JxaUl2LzY1SGhNNldqK21XbnVTczhY?=
 =?utf-8?B?Z01wM3pLeDBJNEFXVDZSUWMyajUvZUZsOGN6U0hqR2RBVVJwOXhZd2ZhT2dz?=
 =?utf-8?B?UzJyaU5EbzdkWFQrcW83ZmpmQWpGNlNnbFcveTRwVjV2dFNGVkU2c3lJekFn?=
 =?utf-8?B?RlUvaDhkZzRKZGhDdGVybDVsYmErTit0bGlBemtMdUlMYmtrMmw5SW1vZ3Rq?=
 =?utf-8?B?UmNIVHpPb28wcm5aSmxMNlAzeWI0SlhzZWk3bjd2RzZtK2NkVHdrNVFSdGts?=
 =?utf-8?B?T3dLcmx0cHlER21wcVpZQTNOR0hFMm1nV1ptbDFRTFRSRDNNZHAxdjBWcnls?=
 =?utf-8?B?MmJaSDB3QmdjRTRqbjFMVnNhd290UVBVSlB1UEZJN3U5OGoza0poMGxmOEVT?=
 =?utf-8?B?cXFGNDY4cWdRN1J4NGtOdE9GTEgwQTJuN2toM0x4YkJPaHhybVpJRWVoWU5l?=
 =?utf-8?B?UVMzalZMODE2T1J3OEVVQXI0VnRiUnV3RFBTWmlHVnhCbFVnci82V1hVZzk0?=
 =?utf-8?B?K0ZNWVJibGhYUWZiOTlhVlJLUE1tUTMxcC84YUVIVU5RTjVCcitUKzJ3L3N6?=
 =?utf-8?B?dko3Z3lvMkNGV0d2S0xhcjFVYnlxcmRJdUZTalQwZDlIRGNtaFdyZlhpN2I0?=
 =?utf-8?B?RjVEVVBuRWRadVc3RGtzUnNBTzRhc1lXSnJWR0RsZG91RXNvYUU0a3RlUUhQ?=
 =?utf-8?B?Yi9TVy9XdVdpOHJQWkV6dzlGWUIvNjNPVEdEbEk3eW96OGZOZTY2cWJQUVRw?=
 =?utf-8?B?ay95aFlYUVBBK1ptazJBRGJSaW9uNXVOSVdlNVU2eU9SaGtEbzgzb0NrL3Jt?=
 =?utf-8?B?cDBJZ0l5aFExWUkycElzTXh5ZHRmWUtCQTN5cGJ2bEtGVXZYRm1HdFhwOWtk?=
 =?utf-8?B?SnE2bGpySExwbXBQTERORTUyNklHZ3hqWGZDcDQxMzl6a1dpT3N0UHlLWjJG?=
 =?utf-8?B?WFBSMzVvL3ZGdDFxWlhHL2x2YjhKa2FFaDhpcHRRM1RFTUR6L2JTUnBhWHNa?=
 =?utf-8?B?SHNkNnZIMnlxWjJpOFhzdldSTWR5WWhXQXZxVmtIMytXTW9ySUVKekpWSWZn?=
 =?utf-8?B?YXAvZUpjbmRKS3VBQzN4WVJBQTY2cCtTNWZYZGRMM0tQdWhpTmZadGRIR2lK?=
 =?utf-8?B?Tk1vbm5ZK0Y4cC91b0lWbnhlVzUxKzE1R2NhY3JVQXEwTit5eWxVNjZWZFlY?=
 =?utf-8?B?Uk1jdXJYS0pjdkdLV0hMei9DZ1JEYTZQTG4wejdWZjdxNnAySGVZRnU1a0x1?=
 =?utf-8?B?OEl3S2lteTUwY0xSTUVUb05xTlBSY2R2L2VnS3pSbU1KNHMwSkdWK3Zkakl0?=
 =?utf-8?B?OGd0Q2o4d0p2bGlvNldtTmhlamczMGRRbEpZVllXSFV5Zk9LUXpiUzBQTXB4?=
 =?utf-8?B?aXBHVUVpYmhUVGRBY1kzSThrMGxMekhFQTMzVk5tdG1tT1RlL3ducmhZZE02?=
 =?utf-8?B?MU1PUys0clhsM1crMFVjVHlzTkZZZDkyQktGWlhZTkxuTXE3R0tZZVoxenBH?=
 =?utf-8?B?ZktzbllUKzh5MTAxSWFNTGJVbjVWVk1wU2lwR2lQNy9LMTNQazA5Z0tXVUF5?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb0325b-8525-49ad-c8d9-08dbdc41dd3f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 07:52:44.9100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7WzrHoIlSrPVeqa/tBL5ePSHHoHLtZ1XgAcgd3dDnq7OFS8H/LMXr+ivEgpWG4jQkCWSMbVs4ChoGr7D2aOmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9849

On Thu, Nov 02, 2023 at 05:08:10PM -0700, Andrii Nakryiko wrote:
> Generalize bounds adjustment logic of reg_set_min_max() to handle not
> just register vs constant case, but in general any register vs any
> register cases. For most of the operations it's trivial extension based
> on range vs range comparison logic, we just need to properly pick
> min/max of a range to compare against min/max of the other range.
> 
> For BPF_JSET we keep the original capabilities, just make sure JSET is
> integrated in the common framework. This is manifested in the
> internal-only BPF_KSET + BPF_X "opcode" to allow for simpler and more
                    ^ typo?

Two more comments below

> uniform rev_opcode() handling. See the code for details. This allows to
> reuse the same code exactly both for TRUE and FALSE branches without
> explicitly handling both conditions with custom code.
> 
> Note also that now we don't need a special handling of BPF_JEQ/BPF_JNE
> case none of the registers are constants. This is now just a normal
> generic case handled by reg_set_min_max().
> 
> To make tnum handling cleaner, tnum_with_subreg() helper is added, as
> that's a common operator when dealing with 32-bit subregister bounds.
> This keeps the overall logic much less noisy when it comes to tnums.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/tnum.h  |   4 +
>  kernel/bpf/tnum.c     |   7 +-
>  kernel/bpf/verifier.c | 327 ++++++++++++++++++++----------------------
>  3 files changed, 165 insertions(+), 173 deletions(-)
> 
> diff --git a/include/linux/tnum.h b/include/linux/tnum.h
> index 1c3948a1d6ad..3c13240077b8 100644
> --- a/include/linux/tnum.h
> +++ b/include/linux/tnum.h
> @@ -106,6 +106,10 @@ int tnum_sbin(char *str, size_t size, struct tnum a);
>  struct tnum tnum_subreg(struct tnum a);
>  /* Returns the tnum with the lower 32-bit subreg cleared */
>  struct tnum tnum_clear_subreg(struct tnum a);
> +/* Returns the tnum with the lower 32-bit subreg in *reg* set to the lower
> + * 32-bit subreg in *subreg*
> + */
> +struct tnum tnum_with_subreg(struct tnum reg, struct tnum subreg);
>  /* Returns the tnum with the lower 32-bit subreg set to value */
>  struct tnum tnum_const_subreg(struct tnum a, u32 value);
>  /* Returns true if 32-bit subreg @a is a known constant*/
> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index 3d7127f439a1..f4c91c9b27d7 100644
> --- a/kernel/bpf/tnum.c
> +++ b/kernel/bpf/tnum.c
> @@ -208,7 +208,12 @@ struct tnum tnum_clear_subreg(struct tnum a)
>  	return tnum_lshift(tnum_rshift(a, 32), 32);
>  }
>  
> +struct tnum tnum_with_subreg(struct tnum reg, struct tnum subreg)
> +{
> +	return tnum_or(tnum_clear_subreg(reg), tnum_subreg(subreg));
> +}
> +
>  struct tnum tnum_const_subreg(struct tnum a, u32 value)
>  {
> -	return tnum_or(tnum_clear_subreg(a), tnum_const(value));
> +	return tnum_with_subreg(a, tnum_const(value));
>  }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2197385d91dc..52934080042c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14379,218 +14379,211 @@ static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_state *reg
>  	return is_scalar_branch_taken(reg1, reg2, opcode, is_jmp32);
>  }
>  
> -/* Adjusts the register min/max values in the case that the dst_reg and
> - * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF_K
> - * check, in which case we havea fake SCALAR_VALUE representing insn->imm).
> - * Technically we can do similar adjustments for pointers to the same object,
> - * but we don't support that right now.
> +/* Opcode that corresponds to a *false* branch condition.
> + * E.g., if r1 < r2, then reverse (false) condition is r1 >= r2
>   */
> -static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> -			    struct bpf_reg_state *true_reg2,
> -			    struct bpf_reg_state *false_reg1,
> -			    struct bpf_reg_state *false_reg2,
> -			    u8 opcode, bool is_jmp32)
> +static u8 rev_opcode(u8 opcode)

Nit: rev_opcode and flip_opcode seems like a possible source of confusing
down the line. Flip and reverse are often interchangable, i.e. "flip the
order" and "reverse the order" is the same thing.

Maybe "neg_opcode" or "neg_cond_opcode"?

Or do it the otherway around, keep rev_opcode but rename flip_opcode.

One more comment about BPF_JSET below

>  {
> -	struct tnum false_32off, false_64off;
> -	struct tnum true_32off, true_64off;
> -	u64 uval;
> -	u32 uval32;
> -	s64 sval;
> -	s32 sval32;
> -
> -	/* If either register is a pointer, we can't learn anything about its
> -	 * variable offset from the compare (unless they were a pointer into
> -	 * the same object, but we don't bother with that).
> +	switch (opcode) {
> +	case BPF_JEQ:		return BPF_JNE;
> +	case BPF_JNE:		return BPF_JEQ;
> +	/* JSET doesn't have it's reverse opcode in BPF, so add
> +	 * BPF_X flag to denote the reverse of that operation
>  	 */
> -	if (false_reg1->type != SCALAR_VALUE || false_reg2->type != SCALAR_VALUE)
> -		return;
> -
> -	/* we expect right-hand registers (src ones) to be constants, for now */
> -	if (!is_reg_const(false_reg2, is_jmp32)) {
> -		opcode = flip_opcode(opcode);
> -		swap(true_reg1, true_reg2);
> -		swap(false_reg1, false_reg2);
> +	case BPF_JSET:		return BPF_JSET | BPF_X;
> +	case BPF_JSET | BPF_X:	return BPF_JSET;
> +	case BPF_JGE:		return BPF_JLT;
> +	case BPF_JGT:		return BPF_JLE;
> +	case BPF_JLE:		return BPF_JGT;
> +	case BPF_JLT:		return BPF_JGE;
> +	case BPF_JSGE:		return BPF_JSLT;
> +	case BPF_JSGT:		return BPF_JSLE;
> +	case BPF_JSLE:		return BPF_JSGT;
> +	case BPF_JSLT:		return BPF_JSGE;
> +	default:		return 0;
>  	}
> -	if (!is_reg_const(false_reg2, is_jmp32))
> -		return;
> +}
>  
> -	false_32off = tnum_subreg(false_reg1->var_off);
> -	false_64off = false_reg1->var_off;
> -	true_32off = tnum_subreg(true_reg1->var_off);
> -	true_64off = true_reg1->var_off;
> -	uval = false_reg2->var_off.value;
> -	uval32 = (u32)tnum_subreg(false_reg2->var_off).value;
> -	sval = (s64)uval;
> -	sval32 = (s32)uval32;
> +/* Refine range knowledge for <reg1> <op> <reg>2 conditional operation. */
> +static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
> +				u8 opcode, bool is_jmp32)
> +{
> +	struct tnum t;
>  
>  	switch (opcode) {
> -	/* JEQ/JNE comparison doesn't change the register equivalence.
> -	 *
> -	 * r1 = r2;
> -	 * if (r1 == 42) goto label;
> -	 * ...
> -	 * label: // here both r1 and r2 are known to be 42.
> -	 *
> -	 * Hence when marking register as known preserve it's ID.
> -	 */
>  	case BPF_JEQ:
>  		if (is_jmp32) {
> -			__mark_reg32_known(true_reg1, uval32);
> -			true_32off = tnum_subreg(true_reg1->var_off);
> +			reg1->u32_min_value = max(reg1->u32_min_value, reg2->u32_min_value);
> +			reg1->u32_max_value = min(reg1->u32_max_value, reg2->u32_max_value);
> +			reg1->s32_min_value = max(reg1->s32_min_value, reg2->s32_min_value);
> +			reg1->s32_max_value = min(reg1->s32_max_value, reg2->s32_max_value);
> +			reg2->u32_min_value = reg1->u32_min_value;
> +			reg2->u32_max_value = reg1->u32_max_value;
> +			reg2->s32_min_value = reg1->s32_min_value;
> +			reg2->s32_max_value = reg1->s32_max_value;
> +
> +			t = tnum_intersect(tnum_subreg(reg1->var_off), tnum_subreg(reg2->var_off));
> +			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
> +			reg2->var_off = tnum_with_subreg(reg2->var_off, t);
>  		} else {
> -			___mark_reg_known(true_reg1, uval);
> -			true_64off = true_reg1->var_off;
> +			reg1->umin_value = max(reg1->umin_value, reg2->umin_value);
> +			reg1->umax_value = min(reg1->umax_value, reg2->umax_value);
> +			reg1->smin_value = max(reg1->smin_value, reg2->smin_value);
> +			reg1->smax_value = min(reg1->smax_value, reg2->smax_value);
> +			reg2->umin_value = reg1->umin_value;
> +			reg2->umax_value = reg1->umax_value;
> +			reg2->smin_value = reg1->smin_value;
> +			reg2->smax_value = reg1->smax_value;
> +
> +			reg1->var_off = tnum_intersect(reg1->var_off, reg2->var_off);
> +			reg2->var_off = reg1->var_off;
>  		}
>  		break;
>  	case BPF_JNE:
> +		/* we don't derive any new information for inequality yet */
> +		break;
> +	case BPF_JSET:
> +	case BPF_JSET | BPF_X: { /* BPF_JSET and its reverse, see rev_opcode() */
> +		u64 val;
> +
> +		if (!is_reg_const(reg2, is_jmp32))
> +			swap(reg1, reg2);
> +		if (!is_reg_const(reg2, is_jmp32))
> +			break;
> +
> +		val = reg_const_value(reg2, is_jmp32);
> +		/* BPF_JSET (i.e., TRUE branch, *not* BPF_JSET | BPF_X)
> +		 * requires single bit to learn something useful. E.g., if we
> +		 * know that `r1 & 0x3` is true, then which bits (0, 1, or both)
> +		 * are actually set? We can learn something definite only if
> +		 * it's a single-bit value to begin with.
> +		 *
> +		 * BPF_JSET | BPF_X (i.e., negation of BPF_JSET) doesn't have
> +		 * this restriction. I.e., !(r1 & 0x3) means neither bit 0 nor
> +		 * bit 1 is set, which we can readily use in adjustments.
> +		 */
> +		if (!(opcode & BPF_X) && !is_power_of_2(val))
> +			break;
> +
>  		if (is_jmp32) {
> -			__mark_reg32_known(false_reg1, uval32);
> -			false_32off = tnum_subreg(false_reg1->var_off);
> +			if (opcode & BPF_X)
> +				t = tnum_and(tnum_subreg(reg1->var_off), tnum_const(~val));
> +			else
> +				t = tnum_or(tnum_subreg(reg1->var_off), tnum_const(val));
> +			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
>  		} else {
> -			___mark_reg_known(false_reg1, uval);
> -			false_64off = false_reg1->var_off;
> +			if (opcode & BPF_X)
> +				reg1->var_off = tnum_and(reg1->var_off, tnum_const(~val));
> +			else
> +				reg1->var_off = tnum_or(reg1->var_off, tnum_const(val));
>  		}
>  		break;

Since you're already adding a tnum helper, I think we can add one more
for BPF_JSET here

	struct tnum tnum_neg(struct tnum a)
	{
		return TNUM(~a.value, a.mask);
	}

So instead of getting a value out of tnum then putting the value back
into tnum again

    u64 val;
    val = reg_const_value(reg2, is_jmp32);
    tnum_ops(..., tnum_const(val or ~val);

Keep the value in tnum and process it as-is if possible

    tnum_ops(..., reg2->var_off or tnum_neg(reg2->var_off));

And with that hopefully make this fragment short enough that we don't
mind duplicate a bit of code to seperate the BPF_JSET case from the
BPF_JSET | BPF_X case. IMO a conditional is_power_of_2 check followed by
two level of branching is a bit too much to follow, it is better to have
them seperated just like how you're doing it for the others already.

I.e. something like the follow

	case BPF_JSET: {
		if (!is_reg_const(reg2, is_jmp32))
			swap(reg1, reg2);
		if (!is_reg_const(reg2, is_jmp32))
			break;
		/* comment */
		if (!is_power_of_2(reg_const_value(reg2, is_jmp32))
			break;

		if (is_jmp32) {
			t = tnum_or(tnum_subreg(reg1->var_off), tnum_subreg(reg2->var_off));
			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
		} else {
			reg1->var_off = tnum_or(reg1->var_off, reg2->var_off);
		}
		break;
	}
	case BPF_JSET | BPF_X: {
		if (!is_reg_const(reg2, is_jmp32))
			swap(reg1, reg2);
		if (!is_reg_const(reg2, is_jmp32))
			break;

		if (is_jmp32) {
			/* a slightly long line ... */
			t = tnum_and(tnum_subreg(reg1->var_off), tnum_neg(tnum_subreg(reg2->var_off)));
			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
		} else {
			reg1->var_off = tnum_and(reg1->var_off, tnum_neg(reg2->var_off));
		}
		break;
	}

> ...

