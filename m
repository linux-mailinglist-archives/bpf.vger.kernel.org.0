Return-Path: <bpf+bounces-13952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7F27DF539
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 15:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0471C20F3F
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 14:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335767486;
	Thu,  2 Nov 2023 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bKRcX8zm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE45227
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 14:40:07 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D272F13A
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 07:39:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zki+VYzI8Lp6S4VVPCApXWeGA3Yb8SO9LHCsOWvgjkYttHXxyYF/ehe7TkVil6Ln2Rbp89Px7OnsyXMQYc3vXOFOtBWak+vt/5YXiFoptlHfQjFnPQo86wZ/VaklB0oFmye2UM+skFvhMsSgx8yuScslRsA1O0YrwnxMi8cIGoE00rD3tJie11GpyfmvFGRuBEp6C/1srn3f0SvbU6p76mMvtag74cmcBZ6D5iznEBbRZKsk0zI6TDytEhDW8w7/lb4tudJKpue58it/mJsAGzazGPrLx8ImPC63cDi9Z3mJsDjiHpW2sH3nnFsOdrq9CDcF5bEZchVS45VAhM5lPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kh3wnylTszV6tOgc0iljGK7bfDqCja8y6k/4wuV6b/g=;
 b=Iv4DLBYaU9jJheTEv/LjH8anvIpC9ZRQp/RX3gXg9EteVGLoh8I1mmu1SIFuMyLLFN6yV83J/UDnXtU6i83Aq2oa9iMqcMUheiMhf02NZc5bgvG7w9G0V/aC003EKoqgFjb16cOKTmKAzxzlhwivrwUiqC3w8JiYgnqkVYu0sK9FkuzemnszG6ui01Xw8DMRmy3kk1mUXcreXIKfIZatcNxvWULcL3u/j/6sSk/TlpnPG2AoGWjXnQC+wL+QQ3j8iRP7Fc3rKocGFbOGFIbBfYTITNxT/sLepOMeIk6VYaPirg8JuGknqYCeP6KGWTn1OtZaqV+C02iIbyj+4RPHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh3wnylTszV6tOgc0iljGK7bfDqCja8y6k/4wuV6b/g=;
 b=bKRcX8zmntXSW4lzcWpVM0fr2hjVouzu1gQn1/3jf+zflMFakp0BQ0dQt4b98o5gKCwVBnNhE/P9lXTmiGTIANfi7GsqkrzCYV2jWK2B4ExW3YxT6ddr3DZ7nHSbhMAlFhONQzjhfRQLwGCOPyfp6BGQhPbSKX82vJEITKo7ir9WVaBBKdyjHC/BIlsSi4EMvEPHYiZOwMP7Ggelz4LwCXsuQ8qpQxK0JoCuqjabHwOpIwZzDLaqoYvLTZIGoQvyp5kteGm2cIb7PtAeG2OxNB51mqqCr6H91D32O6os6131aol+4g4srrZWOSHzFbFWB8quJYd/VgIdwhmwW3VDwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS5PR04MB9972.eurprd04.prod.outlook.com (2603:10a6:20b:682::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 2 Nov
 2023 14:39:57 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 14:39:57 +0000
Date: Thu, 2 Nov 2023 22:39:43 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v6 bpf-next 07/17] bpf: improve deduction of 64-bit
 bounds from 32-bit bounds
Message-ID: <ZUO0rzR3O0Ib5hwR@u94a>
References: <20231102033759.2541186-1-andrii@kernel.org>
 <20231102033759.2541186-8-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231102033759.2541186-8-andrii@kernel.org>
X-ClientProxiedBy: KL1PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::17) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS5PR04MB9972:EE_
X-MS-Office365-Filtering-Correlation-Id: c365d5b6-b252-42e3-ea96-08dbdbb195ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YY2PlUUZxMXbOA5o/WgP1bydTPAusTXtpR7srO/RrVoKXqPGLQWicS3REv/YUI+JkZiLCni9YMUt8wni9cfZ0f/iCAWjdSiBHsUGFzjuf3Wt1AyXq6zG5vnk7/CC+2Udp/C7qq5lv8deXg+O6lDpDwzjAvASvu0pRcoZdt5AeJc+BgE2bP6GGaSVjrHqANe7CGijaxbIZvKGawQhrZRBJwCl0lOKXj3Ae2bHJdLBg2z41pU0RfrI55i1FUKAqa7xrUndz5tCWSA+Lf1JJyP9UVQspTf8t3W7PTgcMpanDmRWvlTGsfdIJQt7ZGGQSjwStf56Azf8EIk8WSw9n0lf1uHvSvDA4E8xm6cPTy/NN4LSqoEfL28dRtrMdCWSp0Cb4IzCKd5kWyqSfFL7EWn3ZBo5s82i99akLrE3kuwx5iTUeol9v1hLBONWOe8UjyJakhla9+WIh1l0jNVAWX37uvrRe5SaURtiiwV76PDy9mBBqrgHgQplOn58cSmigF06SjsY5CBqICfH4rcpF25TUdGIXkwbIWMx1BYlxVMtIAIRyyxSvO1oYrZLr61rb2jl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(39860400002)(366004)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(26005)(6506007)(6512007)(6486002)(9686003)(478600001)(316002)(86362001)(38100700002)(66476007)(6666004)(2906002)(8936002)(33716001)(66556008)(66946007)(5660300002)(8676002)(41300700001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEhGZ2N5d2xiWWZnZFVnT3JPUDh3d1J4N2ZYWXBaT0liOXpDdExJdlpvSWgx?=
 =?utf-8?B?M2xSSnJrQTA3TWE4L2k2ZzcxcFJjWTRnaFFjcGY0NWMxc0F5THRVNU52OEVK?=
 =?utf-8?B?am1kWXF1R1V1NWp5Wkc5UHR1THR3WFpNcFFSZlNqSW9NY2J4R2N2L1poNDRw?=
 =?utf-8?B?OEZxdmtwNzFxdDNka2w4OEo2UE15blBJN3NLZ25uaTVuWHdzZHJxdWszZi9j?=
 =?utf-8?B?Mms0YWxvay81eExzNUp3bURLblpJM09VSW1UZ01GQjhBT1BROG5MQ2RPNjhp?=
 =?utf-8?B?NVp3U3YxMkdHL1RmUFNuTzdMSTI0aDFjS1crNi80N2RoNmJ2MUVhMk5hSW5Y?=
 =?utf-8?B?dTZaZDczT0Z0dm5FbzBwVVloZzEweUphNnhxT2NQWmZuaW9HTmc4K3J2NUZV?=
 =?utf-8?B?Si9vaFNoOWZxd04zVStKd1JGZjFZc1pBazFVK2NjcEdsemwyRHZXSjk4WXk4?=
 =?utf-8?B?M3UzMG5TOWx2eFNOZ2cwNE1OT01Yckg3aU9tQTNzSnhqM1Z1NWtpN0hySStP?=
 =?utf-8?B?ZkhaNEQwNmFLU3hOZDNvbklWZFZhLzhRVWJEU1I0ZzZxSUI4WmhLR3pXenJQ?=
 =?utf-8?B?SUtIdFVyOVRjbWZWdFZYQThRTG1ybGNPeFAwMitockVnWWp3a2FVZHcvajBn?=
 =?utf-8?B?UG9Oc3VTWldNZk9BamEzRVhYSHdwancyN0dqTFpGemVBYVhDUXYzZ0VXc2Rt?=
 =?utf-8?B?ZEFtODFTYndGS1FTZkpYNllheWtwdmJmR2pqd21HS2ZuRTR4RDBSYXQ2NlBT?=
 =?utf-8?B?eUxqMHNReUxkTWFmUDcrWkxyVGNYakhtVUxmMjdXNXYyYUxjTkQybmZvS2tt?=
 =?utf-8?B?Vkxra0F5YmE5NW5meHNiNFZPTkp3a2w2UzYzTXMzOEdqa2E0UERmZXVxalFl?=
 =?utf-8?B?dTA4MURialJCVlpjYkhvMkk2QjNJN3lpS1QwMTBOVG9wT2ZEMHEzUjhFaTJl?=
 =?utf-8?B?bFpOTnQ0VmY0eVNmQzR4VHhldlhmR242N251cGtjcVcwYUNreGEweWxCbGox?=
 =?utf-8?B?YUNtTkEzV1ZZMTgxZ3M2aDJaaGNqZkNFS3ZGOGhvQU12UTBsZVFGK3VEV1hR?=
 =?utf-8?B?ODRRZ1FrQ3ZYNnZwYU1lMnpYVVczZmFrM1NWZjBHQmUrbG5WYlhrZUxFQ3My?=
 =?utf-8?B?ZVE2Vy9nZHlVaHVZQlFEU24xOTRZaVFiQ1hicHpIZzhmb2VheG9iazdCUlg1?=
 =?utf-8?B?ZDVxbGRZbnliQkFWUHIxYlVXazVmWnFKV2VYTHlIZHNkSGxtdEpPWHZPZXVk?=
 =?utf-8?B?cGt1dmhBQjNjbmZaRGxlWThaU1hPdHR3QWI1eDdSdVdibG16V0E1T2VGMGJH?=
 =?utf-8?B?bXJqRFlGdVAxbndKY2M4RWRtN3pzR25jbDFlZmM5cnFrRis3aUNVQytFL1JF?=
 =?utf-8?B?Y1NmOExIaTZPenNPWVB6Rm5qOEF4TU5OVGhLYjlWK3Q3TFhWUk16a0FhK25P?=
 =?utf-8?B?Uk0wNStPNkJsYXo0ZVJWRzFKQ0RYWjBFQmplcjFuSGg2SDhjTWZ3TFp5UVdw?=
 =?utf-8?B?S2lzd1gyTnZXcTQ2eFRIbW95MGZidEdjZjFEYTVHL25KeVMxQXJkK3JONHNX?=
 =?utf-8?B?RmsxRC9yLzBhYnIyRisrblhNUytaZmJsSVVjT1ArU3c0KzNPZmZSNzVqOFpX?=
 =?utf-8?B?dzRkWjJoeDZObG5Qd2puWkhKdWxNRDZMZEU2TVpnQ2xRVjdpL1VPaGJVVEJi?=
 =?utf-8?B?ODBsOXJPM2krQXVUUHZ0QUN0djRNSWZSTGF2N1lYTCtzOWFZa2FSZHVVMVVk?=
 =?utf-8?B?ck9vNmRhaHRhbVQyL3Zrc3p3b3RsMGNnM2VHRGV2VG14Z0R3UVJuQ1JRQWRT?=
 =?utf-8?B?V0xkMjRFSEttcjREZFErRU1RNldreStYVy9GZy9DR1lIVlk1S3JlQWFNWkEv?=
 =?utf-8?B?M0VsVHY3aW1STHNzS2thQUJqMzVrUWY0WWVNWnFENWZ2SC85MXc1enFRVGJw?=
 =?utf-8?B?MTVlQjVSblZKSDBFYWY5SUs5V3RRSzBmNXRDUXNjYnhZazhzRi8rU3RRZlNK?=
 =?utf-8?B?aEVoNk1tbXdwOUJsVFRJbEk0MmdSY3lvMFV2TkJ6cmJ2YmM0L210Z3ZXNWNQ?=
 =?utf-8?B?aW9PWTU4Q0xSU2NnenEybUFMazc0NWQ4K2lRZmEzZ2d6ZjZHZUdibG9BamFU?=
 =?utf-8?Q?Fzc2CHe1HMkcYzToZakQjmwri?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c365d5b6-b252-42e3-ea96-08dbdbb195ae
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 14:39:57.0987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IT+34DVYcp6crPm64lPJax0ssfT6qgVhXcnhXpc5MURE+ppX23arGngK9/gf7bJSLLOW0FrqnQ42oE9bBJcWJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9972

On Wed, Nov 01, 2023 at 08:37:49PM -0700, Andrii Nakryiko wrote:
> Add a few interesting cases in which we can tighten 64-bit bounds based
> on newly learnt information about 32-bit bounds. E.g., when full u64/s64
> registers are used in BPF program, and then eventually compared as
> u32/s32. The latter comparison doesn't change the value of full
> register, but it does impose new restrictions on possible lower 32 bits
> of such full registers. And we can use that to derive additional full
> register bounds information.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

One question below

> ---
>  kernel/bpf/verifier.c | 44 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 08888784cbc8..d0d0a1a1b662 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2536,10 +2536,54 @@ static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
>  	}
>  }
>  
> +static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
> +{
> +	/* Try to tighten 64-bit bounds from 32-bit knowledge, using 32-bit
> +	 * values on both sides of 64-bit range in hope to have tigher range.
> +	 * E.g., if r1 is [0x1'00000000, 0x3'80000000], and we learn from
> +	 * 32-bit signed > 0 operation that s32 bounds are now [1; 0x7fffffff].
> +	 * With this, we can substitute 1 as low 32-bits of _low_ 64-bit bound
> +	 * (0x100000000 -> 0x100000001) and 0x7fffffff as low 32-bits of
> +	 * _high_ 64-bit bound (0x380000000 -> 0x37fffffff) and arrive at a
> +	 * better overall bounds for r1 as [0x1'000000001; 0x3'7fffffff].
> +	 * We just need to make sure that derived bounds we are intersecting
> +	 * with are well-formed ranges in respecitve s64 or u64 domain, just
> +	 * like we do with similar kinds of 32-to-64 or 64-to-32 adjustments.
> +	 */
> +	__u64 new_umin, new_umax;
> +	__s64 new_smin, new_smax;
> +
> +	/* u32 -> u64 tightening, it's always well-formed */
> +	new_umin = (reg->umin_value & ~0xffffffffULL) | reg->u32_min_value;
> +	new_umax = (reg->umax_value & ~0xffffffffULL) | reg->u32_max_value;
> +	reg->umin_value = max_t(u64, reg->umin_value, new_umin);
> +	reg->umax_value = min_t(u64, reg->umax_value, new_umax);
> +	/* u32 -> s64 tightening, u32 range embedded into s64 preserves range validity */
> +	new_smin = (reg->smin_value & ~0xffffffffULL) | reg->u32_min_value;
> +	new_smax = (reg->smax_value & ~0xffffffffULL) | reg->u32_max_value;
> +	reg->smin_value = max_t(s64, reg->smin_value, new_smin);
> +	reg->smax_value = min_t(s64, reg->smax_value, new_smax);
> +
> +	/* if s32 can be treated as valid u32 range, we can use it as well */
> +	if ((u32)reg->s32_min_value <= (u32)reg->s32_max_value) {
> +		/* s32 -> u64 tightening */
> +		new_umin = (reg->umin_value & ~0xffffffffULL) | (u32)reg->s32_min_value;
> +		new_umax = (reg->umax_value & ~0xffffffffULL) | (u32)reg->s32_max_value;
> +		reg->umin_value = max_t(u64, reg->umin_value, new_umin);
> +		reg->umax_value = min_t(u64, reg->umax_value, new_umax);
> +		/* s32 -> s64 tightening */
> +		new_smin = (reg->smin_value & ~0xffffffffULL) | (u32)reg->s32_min_value;
> +		new_smax = (reg->smax_value & ~0xffffffffULL) | (u32)reg->s32_max_value;
> +		reg->smin_value = max_t(s64, reg->smin_value, new_smin);
> +		reg->smax_value = min_t(s64, reg->smax_value, new_smax);
> +	}
> +}
> +

Guess this might be something you've considered already, but I think it
won't hurt to ask:

All verifier.c patches up to till this point all use a lot of

	reg->min_value = max_t(typeof(reg->min_value), reg->min_value, new_min);
	reg->max_value = min_t(typeof(reg->max_value), reg->max_value, new_max);

where min_value/max_value is one of umin, smin, u32, or s32. Could we
refactor those out with some form of

	reg_bounds_intersect(reg, new_min, new_max)

The point of this is not really about reducing the line of code, but to
reduce the cognitive load of juggling all the min_t and max_t. With
something reg_bounds_intersect() we only need to check that
new_min/new_max pair is valid and trust the macro/function itself to
handle the rest correctly.

>  static void __reg_deduce_bounds(struct bpf_reg_state *reg)
>  {
>  	__reg32_deduce_bounds(reg);
>  	__reg64_deduce_bounds(reg);
> +	__reg_deduce_mixed_bounds(reg);
>  }
>  
>  /* Attempts to improve var_off based on unsigned min/max information */
> -- 
> 2.34.1
> 

