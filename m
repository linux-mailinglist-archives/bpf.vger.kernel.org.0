Return-Path: <bpf+bounces-12968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8098A7D28FC
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 05:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF2BB20D4B
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 03:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B85F1841;
	Mon, 23 Oct 2023 03:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aNnTKMlk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720C371
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 03:20:59 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2080.outbound.protection.outlook.com [40.107.249.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB985B0
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 20:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaulqchB1z4ES8hwQ2+I2N0XNMaC90fWh6cm+GT35pvRyx/vdnVc/sFoiuYbWGRmAOYtIGkp0ISdpBDuc4hYVXlapFR/zowfyVyNXuyR5xpL8sB+GIVhHC1LpS24npu3Ohq6eAByBwJEZJNvqb+6KDUZZLxMqz55mnofKQZTvnpHBvHm+fPpDLFuc+m08ogCW58GIMeaAHOwVqq/9Zu3yfYm77Wr2l13yVz/9fFy6U8w5x9Ply7uFb+GpCwTyXOCEDcouFVBEbF5hywx5trHbjLg7X9X1s6wl9rbbgByOZIJflDfct3Uv763UJXdFmFxm3TzeeyqT74qutidalbGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y55L69xiTKkxkd6i6fdCNVO0R1MAtgOx44W9XIHIhkM=;
 b=c5vGli3p6NNvHP6uqKwkoD4Fu27VFKcbt0VenXe9pHtS0CN6cr/iHZWTEgw3p6QgiFMAm6YZLJcQNbVt3BjsmGxUW/KMKIQPhsOZNYBYhIFDeS2fHzryn7h4qnxHNl41mNorIESAHCZy8QP4fKc1MSnziMDobbVK0BKdsT39OxHn7spJyp8C+Fx93U+woK0DwHc9tK5A31PMnroqAiAqdZrGMxgNNLmtoxvAss+Y2WvoU4cLnpLYFhq2DdLM2RFBW9j1LoqOAA02qIikKYlfUu0I51JLKHMYWgaIvWDU1TniwvKQtjY5w6C8KJViuUJq2xTlAO/axmFJS+ExQ9nctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y55L69xiTKkxkd6i6fdCNVO0R1MAtgOx44W9XIHIhkM=;
 b=aNnTKMlkvROY1h7miIf7N076BqJkbeduy4bN0SzVRBgy6G9e80IUfNW9KQ7tHKSnQnKVf5eKkATCJqUXz0zeI5+g4yaYeXAqcNzd4APR79jVl+AvMt3nfoELdY2jOjb7yerN1WvCkOCaJcI9W5wufJgOvyAg+N3BZa8n0ilObdOxXewVrJsb2SDVxk3y+iWeRtcJTdtCqAoZj8NT0emOJb/KBZXv/4GJ1gvqy0S02zaq28qcleyXG9KvUjpaZnnxGZy/su2kEHgOgB8Z7u0jCIVLd9ZfJ4CnB0VUOgdVGFkWUm75I8j/YQ/xpT/ncwHpUYs7uvZ8NACrGLjnh4Y53g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DU0PR04MB9324.eurprd04.prod.outlook.com (2603:10a6:10:357::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 23 Oct
 2023 03:20:54 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 03:20:54 +0000
Date: Mon, 23 Oct 2023 11:20:46 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: enhance subregister bounds
 deduction logic
Message-ID: <ZTXmjp7AtrRpHZzR@u94a>
References: <20231022205743.72352-1-andrii@kernel.org>
 <20231022205743.72352-4-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231022205743.72352-4-andrii@kernel.org>
X-ClientProxiedBy: FR4P281CA0406.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::11) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DU0PR04MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 71edc678-9151-430f-4236-08dbd37710de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CC1xpE7AXllErRUPV6w0rcaWDeHVy3LlUTES5G2wy2lmqBv8IfHddcE8RwXC4iVfdKVJzhiUOrHN8vC5/Ja3VMEGQxdV08Aa+v0C815U8EZ0VEHI8GOGDAjDyMqFwljsohQQUG+R02547k9YFqOq8J4JknDUPRihH9YBFQIoXZmJ4XMcLjocSfq+jg7x70cEks8PFAdMz1G9Md5fuXNDcpKlAK3fjx34UNn+oyM1KXY3bHPtwrRbkCbRxx+Sx9xY/qGKkYz3IBZ3it2lIHDWjniRizs6geUqIBCTRRRS2Ii0VS1J734itWkvJ/RK8A3NApbUfHszFCba0GT4uS9UGh95puJ+RSfUIjhacNpuHDfBWfO4Cvv7sPE2sPKGy1OJhZq6uUzXgCyjfwrV6LyqIYCqhu4aivkKKC6vD9W9SQsx2F4oP53LN11I0fHjIRCAeGH5Y/GZv/k7RfTYiQ8Ga2dEL7oflljtwsLThvuuaVves7Cdij6n3sKyGSEVCe+CFiMcKr/CkNMusQarhDrth0DRYofnKHlX99xl3iyQYZobYIzMFgHo+udrxUdb8U7n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66476007)(66946007)(6916009)(316002)(66556008)(38100700002)(86362001)(26005)(83380400001)(6512007)(9686003)(6666004)(6506007)(8936002)(2906002)(6486002)(478600001)(33716001)(41300700001)(5660300002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnRQRUtLWmpVZi9pR2RlTHUrNUQ3eHNUOXplb29HaHRRelhCVnZ2c003M3F4?=
 =?utf-8?B?VzFLMk4rR2JQall0UG8xMUpENUxURWFEM3I5bW93K2lTMFA4b3VsWElsckxa?=
 =?utf-8?B?cThvaXhpMjFhWk1jTnFrZC9zajZiQ0IzRHRrNnVEV1l0ME1ZUnJEZnR2OWpG?=
 =?utf-8?B?OGlUK3N5amEyNlNMQTM1ZUMxazJSR0c2ZVJVODVZUUVCeEliZzVtSTJWK1dR?=
 =?utf-8?B?TW5lSTU1dVN2WWdsdmFoVTB0SWhZcldsdG0wT2FMeEM5cy9tWTNKdXVib2xH?=
 =?utf-8?B?TFZHbmYrbFp6K1Qya1I1b1FmdFhxMExzNFZFTVFMU1UraTdRVFdWaXJTdlFl?=
 =?utf-8?B?V3RybUtBYVRxMDRyaTk1RGdRRkZMem5BWVBmQnJQYmV0YUhKYWgxU29ZMHVH?=
 =?utf-8?B?bWMxeitIKytPN3c1c3VoOUwzTWJ5RGFVSDdKYW1pRVRSb1JiWWRaZ1FRck1k?=
 =?utf-8?B?S2VMMldRekRRNVphS1AvRU16c0x4cnpOOFU0QWhYbkFtZ2dwV2RIUTlzTUNw?=
 =?utf-8?B?ZUJ4VlR4NEhJZmRXckFwcFhVMHJOOStHc3ZjeS9abCt6RGU2REJxdTdxRGtv?=
 =?utf-8?B?b29HWVB1TWJkQkludWJ3MUtDOU1oVm91c1ZJMjByMW5BUGdEcUxWTnNxQVdV?=
 =?utf-8?B?Y01xd1dxR3Y2Z2JOYlRLWUJkK1dFa2ppeU1wSnc0eExLNlJNWmNZWTFPNWlp?=
 =?utf-8?B?S0pMVnhkb2VMOGlybE55TmhiNWNBK2c1dDcxRDBFekhzaUp1b095bStNSHZI?=
 =?utf-8?B?eGYwcEtvR1htdFpCaEdUYTlZRnlFTitIZkNINFdodzhaWExFc2pGSXlEcDhk?=
 =?utf-8?B?WlpoRTYvdzNzZ0tSZ0xoSUZVb1MzRC9qTWVSQ05UVlFnRmZ4bUVZZ0FWT1A4?=
 =?utf-8?B?ME54eUNBTlhTalRXMDFtbVlmU3NQVzdZM29MWHpuRHRaZHdoQTJ1OTJLa3Uv?=
 =?utf-8?B?YU1xZE5RMDRMSTM0c3RXUitmVTQ2QWEwVGlIRkRrYmNFL3ZzTC84M3JDcXlu?=
 =?utf-8?B?YkpVYkw0a1hDWmdLWFdjdVJremVNdm9mVEhxeVpueE1Rb1NPRWI2YUE2WXBD?=
 =?utf-8?B?Yi9pV3RzeWlwWmR5UTMvWTVuRjR3MUhUWTI1aTIySVdWQUVBbkRWempudEp0?=
 =?utf-8?B?UFFRVVQvQnRoZEpWaThaZ1FxSHNpMENIY0VlQzAvSmliWDVVK0g4YmM3UWIy?=
 =?utf-8?B?dTU2blRQRnJQMnhGYWtMdEhHOU5tRHhwYWQwcGlobVF2d0d4NHJ0UVZEQnR6?=
 =?utf-8?B?UyttTTdabkJuQWRSamFxcFRZMW5VZHhIMWVDK291OEcra0daSlZENkJDQVFy?=
 =?utf-8?B?TlNrODhMMXVKMEhQU3BUcTZVaEtXa2VOY092Rm04Y0d0UWNuaTFxUXRIam8v?=
 =?utf-8?B?dFE2Wk9NV3E4TXllNzNiR2VzM0tocmpuMTZ4N0ROUDA1T2RWa0NTbFF3QlRk?=
 =?utf-8?B?U0RWaEtBWnZoTEVPL3ZUdkFuWUZzU0NRZ24yQkhsMCtlZSthNzhlL29jVU5h?=
 =?utf-8?B?KzVPQTFSOEQwSktLblp0d1UzQ0lNTGp0eTBlZmF3N3pvOVFSNmhEVlM3M1B0?=
 =?utf-8?B?cjRFU1MxbGNieU13Smg0aXloMHhJdlQvS1NDR2ROazI3aEV0aXdsODNWSGls?=
 =?utf-8?B?UG9WMkRYRno5N3JxVWp2V3RLWC96Nkd6M1F0Ly82bmhnRndIYndCYnRZcHkv?=
 =?utf-8?B?SFk3NUNYeGpnYXRQV0lMY1dxdi94QSs1N0hDelpMc2Fnc2V6UDlremtaRCt3?=
 =?utf-8?B?MU16OWZsY3JGdnZmUVdMSTdxY0pxczJGc2FxekEzcWNWNTBEU2NBQnhHeWNr?=
 =?utf-8?B?TkpnZktCQWtLUWc1VFFKSDJTMml0SXhOVjR1QS8wY0RzTHFGN1R1cnZVaWdZ?=
 =?utf-8?B?NDZhNXF0R0pLR3d1empSTGFkYW5Qd3NzdnBtdm5SN2ptTXZoYTBYblZOcFFX?=
 =?utf-8?B?Q3lPeDNvSXV2R2U4VVpuSnZ1aGV6MUl3K3RJVklYTWMrZ2NwakprRUFHVU9C?=
 =?utf-8?B?UWVkUkJKVVJqcDk4ODFUNS9ZeVhpWGJBZFBjKzh3Nm96dHVZY2V2SUVNc2FO?=
 =?utf-8?B?VXFCR1lkU1VpYUd2c0swajhPbTdKcXI1eTNIYndvZXRDa1ZlYnlTb1pYS3pQ?=
 =?utf-8?Q?AHSjMtsec1FUE/moquf1I1GuI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71edc678-9151-430f-4236-08dbd37710de
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 03:20:54.3982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyHA9wm1NrjME0ondfF0ZiESWhO3K632R/C6ALzZyeFIXr1NUcxSAtREUUA+/F9aRHBnXfBiwGtrWZXL5G/g5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9324

On Sun, Oct 22, 2023 at 01:57:39PM -0700, Andrii Nakryiko wrote:
> Add handling of a bunch of possible cases which allows deducing extra
> information about subregister bounds, both u32 and s32, from full register
> u64/s64 bounds.
> 
> Also add smin32/smax32 bounds derivation from corresponding umin32/umax32
> bounds, similar to what we did with smin/smax from umin/umax derivation in
> previous patch.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> ---
>  kernel/bpf/verifier.c | 52 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 885dd4a2ff3a..3fc9bd5e72b8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2130,6 +2130,58 @@ static void __update_reg_bounds(struct bpf_reg_state *reg)
>  /* Uses signed min/max values to inform unsigned, and vice-versa */
>  static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
>  {
> +	/* if upper 32 bits of u64/s64 range don't change,
> +	 * we can use lower 32 bits to improve our u32/s32 boundaries
> +	 */
> +	if ((reg->umin_value >> 32) == (reg->umax_value >> 32)) {
> +		/* u64 to u32 casting preserves validity of low 32 bits as
> +		 * a range, if upper 32 bits are the same
> +		 */
> +		reg->u32_min_value = max_t(u32, reg->u32_min_value, (u32)reg->umin_value);
> +		reg->u32_max_value = min_t(u32, reg->u32_max_value, (u32)reg->umax_value);
> +
> +		if ((s32)reg->umin_value <= (s32)reg->umax_value) {
> +			reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->umin_value);
> +			reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->umax_value);
> +		}
> +	}
> +	if ((reg->smin_value >> 32) == (reg->smax_value >> 32)) {
> +		/* low 32 bits should form a proper u32 range */
> +		if ((u32)reg->smin_value <= (u32)reg->smax_value) {
> +			reg->u32_min_value = max_t(u32, reg->u32_min_value, (u32)reg->smin_value);
> +			reg->u32_max_value = min_t(u32, reg->u32_max_value, (u32)reg->smax_value);
> +		}
> +		/* low 32 bits should form a proper s32 range */
> +		if ((s32)reg->smin_value <= (s32)reg->smax_value) {
> +			reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->smin_value);
> +			reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->smax_value);
> +		}
> +	}
> +	/* Special case where upper bits form a small sequence of two
> +	 * sequential numbers (in 32-bit unsigned space, so 0xffffffff to
> +	 * 0x00000000 is also valid), while lower bits form a proper s32 range
> +	 * going from negative numbers to positive numbers.
> +	 * E.g.: [0xfffffff0ffffff00; 0xfffffff100000010]. Iterating
> +	 * over full 64-bit numbers range will form a proper [-16, 16]
> +	 * ([0xffffff00; 0x00000010]) range in its lower 32 bits.
> +	 */

Not sure if we want ascii art here but though it'd be useful to share. It
took a while to wrap my head around this concept until I look at this as
number lines.

Say we've got umin, umax tracked like so (asterisk * marks the sequence of
numbers we believe is possible to occur).

              u64            
  |--------***--------------|
   {  32-bits }{  32-bits  }

And s32_min, s32_max tracked liked so.

                           s32
                     |***---------|

The above u64 range can be mapped into two possible s32 range when we've
removed the upper 32-bits.

              u64               same u64 wrapped
  |--------***--------------|-----...
           |||
        |--***-------|------------|
              s32          s32
 
Since both s32 range are possible, we take the union between then, and the
s32 range we're already tracking

        |------------|
        |--***-------|
        |***---------|

And arrives at the final s32 range.

        |*****-------|

Taking this (wrapped) number line view and operates them with set operations
(latter is similar to what tnum does) is quite useful and I think hints that
we may be able to unify signed and unsigned range tracking. I'll look into
this a bit more and send a follow up.

> +	if ((u32)(reg->umin_value >> 32) + 1 == (u32)(reg->umax_value >> 32) &&
> +	    (s32)reg->umin_value < 0 && (s32)reg->umax_value >= 0) {
> +		reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->umin_value);
> +		reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->umax_value);
> +	}
> +	if ((u32)(reg->smin_value >> 32) + 1 == (u32)(reg->smax_value >> 32) &&
> +	    (s32)reg->smin_value < 0 && (s32)reg->smax_value >= 0) {
> +		reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->smin_value);
> +		reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->smax_value);
> +	}
> +	/* if u32 range forms a valid s32 range (due to matching sign bit),
> +	 * try to learn from that
> +	 */
> +	if ((s32)reg->u32_min_value <= (s32)reg->u32_max_value) {
> +		reg->s32_min_value = max_t(s32, reg->s32_min_value, reg->u32_min_value);
> +		reg->s32_max_value = min_t(s32, reg->s32_max_value, reg->u32_max_value);
> +	}
>  	/* Learn sign from signed bounds.
>  	 * If we cannot cross the sign boundary, then signed and unsigned bounds
>  	 * are the same, so combine.  This works even in the negative case, e.g.
> -- 
> 2.34.1
> 

