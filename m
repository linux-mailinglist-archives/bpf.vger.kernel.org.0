Return-Path: <bpf+bounces-12969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122C77D2933
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 05:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D189F1C2099A
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 03:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AD31877;
	Mon, 23 Oct 2023 03:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="kpcKXe/Q"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B6EA4
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 03:57:10 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4135E9
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 20:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cL+DdYf9wOtpaR1kH5WjzScCylSH4HO7Ja1Pw+g1keKHajQwpw6BjxflEUGhpMrTSoPjhPSs7qghhC5sGGGeDm2PibBLq29fUmNVSwIWFjm0GX/9biQE6ehZTOPTcuFtna5De7xZCO4rGtqp/kwL20fCasyoidkKJwTPfUX7HSfjPzKIt5ubH1ZJQslQzDmHvJuDR3ums6cYZ1daU35TnvO9ryUYYujdWin2VM63V7nLSLj+UHPWzb5hoO3z6eHMDSU00x32FcO1Ej/4JZPtnXFRlMIsBsZJbrAfiLJcxrcvWOhgJGu1B4NStwE/C0n8853l0OGd4KBZcm6qu3RcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdTh80nFI1tPz/kve29gtqHZFxPJBWk5qlRE1xtRkMo=;
 b=OI9A/Dq5rc50HKgJH2WcV77eE8hswgqCc6/bq5VGGyMVl5Itl9+ZM2c3CWkMfMRm0tR1W2hKRdXGpLvvMikF4KegXjy4O+l505mgwHU7a5IYEniSaEmU/4ROIDUAUIObxcsfklVr/Ds0BPFaKTkH36D1qKJqzye0pk/OpYAQDJUxDQACtLllZXooNsoDPdkfK4M41UU/649Jbthy/XPnJ1TVqsEsgz0cEszMl+5L3IpfywklZpBe8BC33S/FNdPaxpqP1ABouck/qt8T23j+crzFG2kw3J0blZ5PZ4Vb4G1FJF2kr4OaBL4BU2bKzmZPZrBIVNrGkYvAIl84hAyo4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdTh80nFI1tPz/kve29gtqHZFxPJBWk5qlRE1xtRkMo=;
 b=kpcKXe/Qt13arBRXEbVD5xHcDZOKZk9LLCr5rVwI6fREXkPLwfyfmejP+UyqNAIBdsY0GLtTaZu6+A7pPmzVHtMzm6tbdpMQk9EGmJGAXhvH6oKJmifNLPQubOXcfkn1iNrPDcztlTldyeEaetntMBa/NTENf6yM/c79fPYEIFlfGnWW5nBcPGdcu8hZPPr2j0EVgmJssAkwI1DLpP8+4ie3ovxFx9tkhxZZMM0oskxrTGrwkMhhf0NtkcLzDz16KQB4WvHB2KBRUXM82c0kz/Oy2aFinXABdwAPraXnpCUPIhybH3vzJ3STb5MAgYC3i8HvWXJq0dfYpTIOoqzcCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS8PR04MB7590.eurprd04.prod.outlook.com (2603:10a6:20b:23d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 23 Oct
 2023 03:57:04 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 03:57:04 +0000
Date: Mon, 23 Oct 2023 11:56:50 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: enhance subregister bounds
 deduction logic
Message-ID: <ZTXvAmZmQzKxS2kj@u94a>
References: <20231022205743.72352-1-andrii@kernel.org>
 <20231022205743.72352-4-andrii@kernel.org>
 <ZTXmjp7AtrRpHZzR@u94a>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTXmjp7AtrRpHZzR@u94a>
X-ClientProxiedBy: TYCP286CA0038.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::9) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS8PR04MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 6698f50b-5a91-40bf-ba0d-08dbd37c1eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GdmGnXLU3aIxHzDzGMFVovV/1t3Ggr7APHrf37yIowJoEhhtPKZoIayCMUGSQHdJH6Wm7ZJWP1XZHHGFwlpzcsvwvBWE54thDUhsSGYYE+LgzhChD8AwCwlqV4QJGXVrze3OmAHV5TOVYw5lnF28kenU62qBlod8+Y5acp1UZhiJYBUb0N16vaYriw/b5siGEEQTQ+1GFM3Wocnofu9XXUSCwPrInT21r66rUxxR0k85rFwnB7Km93/H6rNWGCWvgdTXRghEJQiirB3WSpYPo+9sxxVFQwnsm6/kA0dlBiwnUWN5l3XaGHsoQQUgXBR4+IasNgwPGHw+RzbT3wLYWq9vDMIJ4Zlz/3Q5FDAXQX2Pw14VMqfDMckkwgxGiv5XIvpm0S0X11F4/Mofbc9YMzn67SRX0yRhyfS5nE5/4uP6DtFjCXsvIHniRDN+ND3K0JswqtebfIi3ZlVVdWmcEO5bV3BzT/XAOCCH3ziit/YJyiEdto/1OkWVeuXyI8U03kRLUCYgzrFpanm+zYkdy6XwYFYZTKfGkLJn1xzV2+2ZFxNK2zZej2lTfwt6ysIy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(5660300002)(38100700002)(4326008)(8676002)(8936002)(41300700001)(66946007)(66476007)(66556008)(316002)(33716001)(478600001)(6916009)(86362001)(6486002)(6506007)(6666004)(6512007)(9686003)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elFSbk00SGtOSmppMHFTbFJWUlU0S1B2dzlseG54YlZnMDFlTWdIdGIvZXpj?=
 =?utf-8?B?OG5lTnRZeXRxRFI4cVlvczdRS3pXcFJ0Q2dPczRDSTd1NWgxYkltVGpUQ1RV?=
 =?utf-8?B?aC90RzdJNzZEM2phNTB1VWpNSklpR2szOXNneVIxU2U4RnhxN29pTisxVExZ?=
 =?utf-8?B?SFhVZ3c3cktZeUU1M1pRNlFIU1JrOUpVWmRvNEduMVprckZSSmlUaTh0eWcw?=
 =?utf-8?B?cEd5TUF4UXJKbm1FbmJ6Y1dXczVyUERTSHVBWXVkM3ErQnkzQlhxOUpYM1Fu?=
 =?utf-8?B?WDIxelNINUprRHZHTS9qL3pwS25WK3BxcWhlRVJyNDltMVppOUpGOFBDWjgr?=
 =?utf-8?B?Z0hoMm1PenpzMUdrdVhDanJ0Mm9nalFlNE9TVnV0ekVkcFhCODY0WmJTTFFL?=
 =?utf-8?B?WHJ6aFVOYmdUL1ZVVjRTbHREa2w1TDhHc2RGTE5kYTBrV1JHbGR2R1A1ZEN6?=
 =?utf-8?B?M3VFNEN1cDFHbXdWeWVyOVdWMFBqYTNrcVYyUGRzalIzNE9keTVVV2IrMVFD?=
 =?utf-8?B?R2lGSFcwbG0rTGhBVVBMVDd0MFdUQUtjRWdFbWlhWU92ckhRY3ptSmdHdm5q?=
 =?utf-8?B?Y2N5dXBIK0JuY3NSaGpjUjdIVDB2bXhXa2VWMEdSazVZazRhWVFGTmorbUla?=
 =?utf-8?B?aklhQzJSUnZ5cm1qQkJEelpKb0pUWDdVQmFKL0gzK09POEVCWXdqN21nUHBY?=
 =?utf-8?B?UkxzSkRZY1M0cXR3NGZGOUNnZ21jR1FMWGpIbjBoUXVPQ202RytobHJoS05h?=
 =?utf-8?B?YjJycG10dXBhUi8xVUFsU00wVGdnemwvMmhtajVVeFlYUzJvVmlONFNDRE1n?=
 =?utf-8?B?emtNTWJ5N29OTTNhNDQ4bWJxeHArVmdHWUFqSW1ZeGVJL3hSak1jQ25rQW5p?=
 =?utf-8?B?VnNUcjFrOGFtdm96UVEvUFFGamJCcHA0ekYxc1lobGNDZE5Sb1ErTUtDMW5C?=
 =?utf-8?B?bzR6a2lIWVoxUUN4L1YyYjk2UTB3ZGFsdmcxeXI2VHJpRHhONWZPZjU5YmY2?=
 =?utf-8?B?TVhrcUU5eE1QWG5hZCtKc2g4aFdBbHlkTlphU3RkNGVKUERwcDFOT0VPYkRG?=
 =?utf-8?B?RlVuMnlpQ2JCYkhXY1NUUDBiSEIwNHdhemJwT0lNampXaDJHOGo5NVEyMlVX?=
 =?utf-8?B?VEttMVJud0FMdGxhOGN4SmFTRkF6K3hNcjdSL0FIeVJkdnB1MkQzQ2NqQWFF?=
 =?utf-8?B?WmlxM2syQkRrdFJzZG12SG5QWGdOUW50V1d6MUNIUGNtZk10N09hTFhnMmV6?=
 =?utf-8?B?RUJ0NFJ0NUp3RU1aNXdUUExRSitoM1RpdjJFWVpyM2ZMb21jM3Y3b29KZHVT?=
 =?utf-8?B?OHNDWHVqb0hyRVBQVmNFcUtKcngvMWVVLzd6MnVUaGZnTG9wU04yb0tCYVpt?=
 =?utf-8?B?ZGEwWHlhTm9JMEdmRVM4d3Q4Z28yMG1HZ0FPRmVHa3cwa3FFZkV3NWszak5N?=
 =?utf-8?B?OG1iVE54eWxBVU9HbkROaVk4ak1OYklhbnRCZFF2YjB5VEtuNzFuRmdOY0hy?=
 =?utf-8?B?d1JZa083a0JPbitkUjNpL2E2TWxNbEdROG9aWVB1eTk3R0I4bndXdU96RnRR?=
 =?utf-8?B?elpZbXJvcFRYN2VJL1ZvWDdiWVFHYmxDd1RLZkRvVlZyLy9MeVlvQ2h0aUc4?=
 =?utf-8?B?VDVneXloS3hXKzR2STRFN204dmtWMzdjTjNrVWxucmdEeEVqTVlIdVZBNkVj?=
 =?utf-8?B?ekNmQjFzWFJvaDlZZlRPUS9UYTh0SWtuaVZLcFRPRHJ1cUlvb1FaR1daWUNH?=
 =?utf-8?B?U1UxY2UzOGlBMmZpM2dwelBwQ3pPckdPMk5MTVo3ckpZTmRFVW9XSXFHVUZa?=
 =?utf-8?B?dWxzU1hSbGVpSHJERHFQd3pwdnA2SytBeWJld3VSajMxRnFkQkx6eXJmVVVN?=
 =?utf-8?B?NUpNdFltUUQxQ1RNVFpMRTl1aStjZ3F0dkxTWjJjeEs2NVNHclloRHJReUZq?=
 =?utf-8?B?dS9ndjg0OTE2ZXlYZzFybi92c21tZWd0K2o2cHRvYW55WXJGMWVDcU5jWWha?=
 =?utf-8?B?cGRveENCNEpOdS9oYkYxcGhiQ1hVbXlCczQ1dFkwZFRJU0Mxd0JDcVArd0FL?=
 =?utf-8?B?V2ZzS3FkVnpBZTRBSVVtaHRwUDQxaTgySWJrbnN6bmxFdjdxelhWMm83TTd6?=
 =?utf-8?Q?xnByJcn2xSh+ivssBxXDA+CNb?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6698f50b-5a91-40bf-ba0d-08dbd37c1eaa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 03:57:04.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJSS0FDyGrwEvNUtQgOjWI84Tly6MSB3en/Ss0u3XzdABahU8gM6/fiGh/dQQsqLWFk691wjwf4wTosyIP8vhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7590

On Mon, Oct 23, 2023 at 11:20:46AM +0800, Shung-Hsi Yu wrote:
> On Sun, Oct 22, 2023 at 01:57:39PM -0700, Andrii Nakryiko wrote:
> > Add handling of a bunch of possible cases which allows deducing extra
> > information about subregister bounds, both u32 and s32, from full register
> > u64/s64 bounds.
> > 
> > Also add smin32/smax32 bounds derivation from corresponding umin32/umax32
> > bounds, similar to what we did with smin/smax from umin/umax derivation in
> > previous patch.
> > 
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > 
> > ---
> >  kernel/bpf/verifier.c | 52 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 885dd4a2ff3a..3fc9bd5e72b8 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2130,6 +2130,58 @@ static void __update_reg_bounds(struct bpf_reg_state *reg)
> >  /* Uses signed min/max values to inform unsigned, and vice-versa */
> >  static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
> >  {
> > +	/* if upper 32 bits of u64/s64 range don't change,
> > +	 * we can use lower 32 bits to improve our u32/s32 boundaries
> > +	 */
> > +	if ((reg->umin_value >> 32) == (reg->umax_value >> 32)) {
> > +		/* u64 to u32 casting preserves validity of low 32 bits as
> > +		 * a range, if upper 32 bits are the same
> > +		 */
> > +		reg->u32_min_value = max_t(u32, reg->u32_min_value, (u32)reg->umin_value);
> > +		reg->u32_max_value = min_t(u32, reg->u32_max_value, (u32)reg->umax_value);
> > +
> > +		if ((s32)reg->umin_value <= (s32)reg->umax_value) {
> > +			reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->umin_value);
> > +			reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->umax_value);
> > +		}
> > +	}
> > +	if ((reg->smin_value >> 32) == (reg->smax_value >> 32)) {
> > +		/* low 32 bits should form a proper u32 range */
> > +		if ((u32)reg->smin_value <= (u32)reg->smax_value) {
> > +			reg->u32_min_value = max_t(u32, reg->u32_min_value, (u32)reg->smin_value);
> > +			reg->u32_max_value = min_t(u32, reg->u32_max_value, (u32)reg->smax_value);
> > +		}
> > +		/* low 32 bits should form a proper s32 range */
> > +		if ((s32)reg->smin_value <= (s32)reg->smax_value) {
> > +			reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->smin_value);
> > +			reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->smax_value);
> > +		}
> > +	}
> > +	/* Special case where upper bits form a small sequence of two
> > +	 * sequential numbers (in 32-bit unsigned space, so 0xffffffff to
> > +	 * 0x00000000 is also valid), while lower bits form a proper s32 range
> > +	 * going from negative numbers to positive numbers.
> > +	 * E.g.: [0xfffffff0ffffff00; 0xfffffff100000010]. Iterating
> > +	 * over full 64-bit numbers range will form a proper [-16, 16]
> > +	 * ([0xffffff00; 0x00000010]) range in its lower 32 bits.
> > +	 */

Oops, scratch that, these below is not entirely incorrect.

> Not sure if we want ascii art here but though it'd be useful to share. It
> took a while to wrap my head around this concept until I look at this as
> number lines.
> 
> Say we've got umin, umax tracked like so (asterisk * marks the sequence of
> numbers we believe is possible to occur).
> 
>               u64            
>   |--------***--------------|
>    {  32-bits }{  32-bits  }
> 
> And s32_min, s32_max tracked liked so.
> 
>                            s32
>                      |***---------|
> 
> The above u64 range can be mapped into two possible s32 range when we've
> removed the upper 32-bits.

The u64 range can be mapped into 2^32 possible s32 ranges. So the s32 ranges
view has been enlarged 2^32 here.

And I'm also missing the condition that it crosses U32_MAX in u32 range.

I will redo the graphs.

>               u64               same u64 wrapped
>   |--------***--------------|-----...
>            |||
>         |--***-------|------------|
>               s32          s32
>  
> Since both s32 range are possible, we take the union between then, and the
> s32 range we're already tracking
> 
>         |------------|
>         |--***-------|
>         |***---------|
> 
> And arrives at the final s32 range.
> 
>         |*****-------|
> 
> Taking this (wrapped) number line view and operates them with set operations
> (latter is similar to what tnum does) is quite useful and I think hints that
> we may be able to unify signed and unsigned range tracking. I'll look into
> this a bit more and send a follow up.
> 
> > +	if ((u32)(reg->umin_value >> 32) + 1 == (u32)(reg->umax_value >> 32) &&
> > +	    (s32)reg->umin_value < 0 && (s32)reg->umax_value >= 0) {
> > +		reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->umin_value);
> > +		reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->umax_value);
> > +	}
> > +	if ((u32)(reg->smin_value >> 32) + 1 == (u32)(reg->smax_value >> 32) &&
> > +	    (s32)reg->smin_value < 0 && (s32)reg->smax_value >= 0) {
> > +		reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->smin_value);
> > +		reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->smax_value);
> > +	}
> > +	/* if u32 range forms a valid s32 range (due to matching sign bit),
> > +	 * try to learn from that
> > +	 */
> > +	if ((s32)reg->u32_min_value <= (s32)reg->u32_max_value) {
> > +		reg->s32_min_value = max_t(s32, reg->s32_min_value, reg->u32_min_value);
> > +		reg->s32_max_value = min_t(s32, reg->s32_max_value, reg->u32_max_value);
> > +	}
> >  	/* Learn sign from signed bounds.
> >  	 * If we cannot cross the sign boundary, then signed and unsigned bounds
> >  	 * are the same, so combine.  This works even in the negative case, e.g.
> > -- 
> > 2.34.1
> > 

