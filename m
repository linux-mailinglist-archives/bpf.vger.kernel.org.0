Return-Path: <bpf+bounces-14562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB59B7E6554
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 09:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1DCCB20D47
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 08:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B3110973;
	Thu,  9 Nov 2023 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aBTHo6ZU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A908E10A07
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 08:30:44 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D6A273E
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 00:30:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKT/+Jkeyb/uDbCga/S6qMs4/J7oCAPW5PLkYdyTW1yXI2Ys62JT6merBYUWVQOaMOl4Qyz8ni65AqF3V4P5El6bvIZJbmjoq/KuTPXMZkBuUvyvcubKMrr23bBAU7a8YFOVSqJLrLFdqnC2Gd8WFo0fM8NN0AubJFx1jv8Lnwl7c3DtMgSPs7K8BKXYAYO8TQP1xAhyb19mbdxzuO0elY+vXFqaSsHaExdB1V0nJRZEz8avAeeNUCTat8tj1in7XobMmhYgGfTywm9BCsZbETawjMnl85u08HKR29x+b9ojprUx/k5NIsGyQl3PcnSKXS/1U3Iw1ziyXgc6bgxunA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myXl+wk8zF/26ZNwcqURhp4wSUB9Y6PiwX68M8YkQtE=;
 b=EloSCtzYy+PzZFWCN+eSXsI6G9hbQcQGYecV91X9bQU+uJGwzCIGnIw+tlQGGav4uGGqOf6JPC+9cp83AA6+I42+gAsGVpZLv19r0CNYmaw6AAOjfSrGyunKDn8adLJ4+z6AQ55ASN36FdMyO93nS/puMXU+JCnBMSD6uK9iHoXp66YIjf9nG8V+bc3jWAVFb8cMzL2DuJPgTVEfXE+L5clwo+lrZPrwASmqyQ0yZExG86plQLq1BbwbTeCiiKvOyNS8AXE1TtRjYCBzyTz6wY9BaeP79U59RnhEZiklMJKaBkjNrqM2UNiSKUMb4/Yt7dbEZLEquGIdO6NAZlidmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myXl+wk8zF/26ZNwcqURhp4wSUB9Y6PiwX68M8YkQtE=;
 b=aBTHo6ZUU7ZH+SUlYT3btaS5cgFKi5EV1o5VyzkawcNQE7jijwNc7W22HjCNVUi2kClBxkkCrWb9BvVxMDMSOeggq/8gPjKZVhlLMCr5QgOH6mhpaBaH0k/TqaR7K18zfewOMtfn3AK9c7SYcwNVkobSpAENy/4DEzIMTAXdZWvA0MCVzjSPNExmuoDqAN4Ig7MzTwitvcy4QlgVQ2L7O7eU+i32J3sqBKoEkAj40113uoV3oAcK05N6mgyRe1KkpctfYSC4feGXH2FV72af2Nac9dTQ3zv+RmCl7K4eh8E3cVnS44GL9Mos1MfYMw3VBf8C1o274Ssp7W6ugC4LwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DU2PR04MB9068.eurprd04.prod.outlook.com (2603:10a6:10:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 08:30:40 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 08:30:40 +0000
Date: Thu, 9 Nov 2023 16:30:28 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 04/13] bpf: add register bounds sanity checks
 and sanitization
Message-ID: <jxiuenecpsb6uydkskpmt55nwe4wx2vgmbdmtrl4exm7urtvts@vxci7pn6v57t>
References: <20231103000822.2509815-1-andrii@kernel.org>
 <20231103000822.2509815-5-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103000822.2509815-5-andrii@kernel.org>
X-ClientProxiedBy: PS2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::34) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DU2PR04MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: 0889de42-65d6-49db-6ac8-08dbe0fe27ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dzuppGS/5lFbWSX+AVNa6rkPv5RUymnTwwJCJC56Dt192OCx4Sxb9my3FO1O11Df7/rQ6+H2t0bv2PHd5mijFEEM3J3ZYFj96+dlg3/93d5pxTNprpOK4ZwCuLkY0HoLFngpzquRHVqwUmSxCCEyDmviuw+cLVHX4KkFSGsPxu3qPEATAUWYp33sAzYkEqH6WXGq9yAgJXRqJ3w21xWOzlOxs7dNQIZtIgwT11TfMWQRsXQwgxCFHHYr9h948SvYGTx2KmUU3DoihubqrPia1OsUbXhyL3dz2BsleiIv/wLKFVG1+EnwzeB2w4TUbDjnmvdUVB7V0i6+SDTKu53uU92LfDxj1XRxFCAMduAwbpOepKvdydWszKhBhwmVQHMADiTZmjf96UXXmd3Qr5QzidgVRkFSMBdDpssuX8gNWmUmnLjj9XeDT04N47gjFTXekkCj7LEgG/GFd3oSFTj+Q6vaIEWHpdFHsqd5/1ZSJ2zOcLgMu+4JksFUn0FpQdjClBtbzJ3DyLpkPblqH1D9sJb2pIAtEs5zazr/XfP+btm/amP0mA23GGrk2dbF2Vhz20XBeHe7YdVhnKB3Lsk+00iraGmbxNHOwGY4z54UNoFUADnI/SQDKiVP0uZJ8RSYTyxlhPt8JkDcRadUfpwW7XSOGord+vq/HjqR+QI2AZI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(366004)(376002)(346002)(396003)(230922051799003)(230173577357003)(230273577357003)(1800799009)(186009)(451199024)(64100799003)(33716001)(4326008)(8676002)(8936002)(83380400001)(66556008)(66946007)(66476007)(6666004)(6916009)(316002)(5660300002)(9686003)(478600001)(6486002)(6512007)(6506007)(2906002)(86362001)(38100700002)(41300700001)(461764006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WbqnsRZHM5vAfFPqObQeF4Pa86cJJjAKsSGYx+Szsey2WI2p3wA2FW/+9+ED?=
 =?us-ascii?Q?eMyF6JcNBRHlcMEK1gxl06UfchSoVwVM0BJO6BO8NDlg3GJIPq+E9EfnThz0?=
 =?us-ascii?Q?Jtk8ljVF5txkKMt08Cw8L69chtdxAFK0r7zt9j+QKp8Nm4wR0rWteG2lSx4O?=
 =?us-ascii?Q?39ekz4ILxBwWAv6lbvUuK+TcNBtK0UtxFU8O9j8joxKjRohV61ec0EqPqp4V?=
 =?us-ascii?Q?tIJvJsggXvRL8k31K/sqnC1/qcuDzq20w6wK8qSWobckhImPCKkHL1Ay3aGr?=
 =?us-ascii?Q?Xa7fd+5VUOVKkqrWAqKffRJtbIXlTAnGVtAVIkf0a97dGinkyIDSrcU/KTjn?=
 =?us-ascii?Q?JPUaayevqQeQH/lShRFF6pfibSiwHcdJH1XSvEm8ZrlRuN+n3xrXvP3ei5Zx?=
 =?us-ascii?Q?9LdQdLr+S5PJ3t5lUykI+ej/aQyfjHXIea2zpqUHu2IxbSMROHuV9ojUdqVR?=
 =?us-ascii?Q?gMBAvHYwdejkcQMeTTAdVYnYb+czCWXdoKXh7diRatFgNu9tmZ9MtCTNTdfu?=
 =?us-ascii?Q?WkY/opGsXdCFrJAWVVEy8CF9NKdqvQqie3JqkykbgMr+PnE/KgZ6EownKAV6?=
 =?us-ascii?Q?P5YEWmJaMCnvN//xFxA9y2avMmf5rLOFAEge9mWsM+NQjXh8FshZWXPGSbwh?=
 =?us-ascii?Q?zvU7EwzGM/K+WeybOWm2xTmV0ThjizEfhhvPG57L/5GFO9NalLnEPxa6sXMY?=
 =?us-ascii?Q?Ry7jwWk/lf3rXVuOWiH9v+qVHRCStRaDYVoamMvewpmbxJndPKf/ppmlOEWH?=
 =?us-ascii?Q?UybhhDohqxnRD4yZIdix0uNutGnOsihHKL+W1vWt8oaq2kzakUR6Z6zHppDn?=
 =?us-ascii?Q?JBD33oosgkZAK4mXRcpVweEFds80xm0j3IHmYeAE60Z32uJwN+oiQOv1WTOi?=
 =?us-ascii?Q?h57NAhuaVavCbdZtiPqEYnLzdtIPKd1roLe5fHRCyYiPo7ijRusiQFMQ2j6x?=
 =?us-ascii?Q?I63d0hSFk5+Ijmxl5sapGQkRU+z57Fwzj9Xq0lUxoJT3YwmjYVRJ3javJaXg?=
 =?us-ascii?Q?2IydZa0mTtLOKUYu1e+541yeU5ry2Ot8caELQRPSqN4zmhIM5xfQwG8uKLBE?=
 =?us-ascii?Q?1HbUK4MIC9/mw5/gZDTFpgo+6roXVTiEmNhq/yrBzmuYunoehEbPKg4K/R24?=
 =?us-ascii?Q?z1LDqhLn+c8TIk8BVe0dyuqVevzjSp0qIC0Ns2TII4jirGsP8wkwYDMe+alO?=
 =?us-ascii?Q?+vArS7WFU6ZZoOoAy6U5JuqzO41/6v+8sZpRTOeWBJRHRNBvKQPUXN2Xvda8?=
 =?us-ascii?Q?rMGKUiIXp/FuiY6CYlx21uPcI4G23cP5WjkCjgmPBITjwLsMzf1mWN5aRIxJ?=
 =?us-ascii?Q?kx1mKXmxxn2794Q4MCu2S6EnfAOkBYi6SGrCksQWKQkbg2PUBAC4NDulWgJm?=
 =?us-ascii?Q?B8ty1LyUzk7rIF3TQckwZsP6/MQ9yfcfDinCreGIAREe7x3Cp8fPiZgN+vrG?=
 =?us-ascii?Q?hcmuQRSepIDw3zbPHcDHLgozVD83CMRTKg4K7K5hQvBosUVupVXKLZdgg/6h?=
 =?us-ascii?Q?PT1Y3vS7qtNMcPUrtYyNM1PR02Mer+HuwrqH1i6e/JHVC4dm0O7ST9DhVUEW?=
 =?us-ascii?Q?3VGQXw9H561r4a8rxv2uSh5FmobARdjDecVtd4Li8+W57I/TSt3TuhVYKbqG?=
 =?us-ascii?Q?UUO9vMEvqVoy0J+pkQdhMu/w5Vh/hcVQ4iIsQCfpiKtN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0889de42-65d6-49db-6ac8-08dbe0fe27ea
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 08:30:40.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrcQNdEPPo1LHWPFRzrewBJvDd479zg+gwypZeZmZnnG76spfUApbe9TFfyydd189eywza3fDFZYUMPyV9yxJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9068

On Thu, Nov 02, 2023 at 05:08:13PM -0700, Andrii Nakryiko wrote:
> Add simple sanity checks that validate well-formed ranges (min <= max)
> across u64, s64, u32, and s32 ranges. Also for cases when the value is
> constant (either 64-bit or 32-bit), we validate that ranges and tnums
> are in agreement.
> 
> These bounds checks are performed at the end of BPF_ALU/BPF_ALU64
> operations, on conditional jumps, and for LDX instructions (where subreg
> zero/sign extension is probably the most important to check). This
> covers most of the interesting cases.
> 
> Also, we validate the sanity of the return register when manually
> adjusting it for some special helpers.
> 
> By default, sanity violation will trigger a warning in verifier log and
> resetting register bounds to "unbounded" ones. But to aid development
> and debugging, BPF_F_TEST_SANITY_STRICT flag is added, which will
> trigger hard failure of verification with -EFAULT on register bounds
> violations. This allows selftests to catch such issues. veristat will
> also gain a CLI option to enable this behavior.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf_verifier.h   |   1 +
>  include/uapi/linux/bpf.h       |   3 +
>  kernel/bpf/syscall.c           |   3 +-
>  kernel/bpf/verifier.c          | 117 ++++++++++++++++++++++++++-------
>  tools/include/uapi/linux/bpf.h |   3 +
>  5 files changed, 101 insertions(+), 26 deletions(-)

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8691cacd3ad3..af4e2fecbef2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2615,6 +2615,56 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
>  	__update_reg_bounds(reg);
>  }
>  
> +static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
> +				   struct bpf_reg_state *reg, const char *ctx)
> +{
> +	const char *msg;
> +
> +	if (reg->umin_value > reg->umax_value ||
> +	    reg->smin_value > reg->smax_value ||
> +	    reg->u32_min_value > reg->u32_max_value ||
> +	    reg->s32_min_value > reg->s32_max_value) {
> +		    msg = "range bounds violation";
> +		    goto out;
> +	}

Maybe Check tnum validity before comparing it with min/max? The mask bit
and value bit at the same position can not both be set.

	if (reg->var_off.mask & reg->var_off.value) {
		msg = "tnum invalid";
	    goto out;
	}

Unfortunately doing tnum_intersect() on two non-overlapping tnum still
gives a valid tnum; so we can't readily detect such cases like how we do
for ranges above.

> +	if (tnum_is_const(reg->var_off)) {
> +		u64 uval = reg->var_off.value;
> +		s64 sval = (s64)uval;
> +
> +		if (reg->umin_value != uval || reg->umax_value != uval ||
> +		    reg->smin_value != sval || reg->smax_value != sval) {
> +			msg = "const tnum out of sync with range bounds";
> +			goto out;
> +		}
> +	}
> +
> +	if (tnum_subreg_is_const(reg->var_off)) {
> +		u32 uval32 = tnum_subreg(reg->var_off).value;
> +		s32 sval32 = (s32)uval32;
> +
> +		if (reg->u32_min_value != uval32 || reg->u32_max_value != uval32 ||
> +		    reg->s32_min_value != sval32 || reg->s32_max_value != sval32) {
> +			msg = "const subreg tnum out of sync with range bounds";
> +			goto out;
> +		}
> +	}
> +
> +	return 0;
> +out:
> +	verbose(env, "REG SANITY VIOLATION (%s): %s u64=[%#llx, %#llx] "
> +		"s64=[%#llx, %#llx] u32=[%#x, %#x] s32=[%#x, %#x] var_off=(%#llx, %#llx)\n",
> +		ctx, msg, reg->umin_value, reg->umax_value,
> +		reg->smin_value, reg->smax_value,
> +		reg->u32_min_value, reg->u32_max_value,
> +		reg->s32_min_value, reg->s32_max_value,
> +		reg->var_off.value, reg->var_off.mask);
> +	if (env->test_sanity_strict)
> +		return -EFAULT;
> +	__mark_reg_unbounded(reg);
> +	return 0;
> +}

[...]

