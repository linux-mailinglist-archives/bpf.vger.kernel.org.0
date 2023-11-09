Return-Path: <bpf+bounces-14567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC147E6620
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 10:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722351C209DB
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 09:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFFE10A19;
	Thu,  9 Nov 2023 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="v271ZLmn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D3C10A0A
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:03:12 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BD3EA
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 01:03:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6h/XG/t0ARq1LBwSk8gi3JDbpTQfVhwqHmQu4HHehirtUgYxXGN/qbgzkbY8QhJYqiOzUTIw3T3/nuEOoG/bhRt1kZ99Y1sLlxdQT5EEBd9uPJ1ZqH3jOQCRP28pLxKjiZBP/htJQqZvGRv1SLQ241fwqbzxKEI7Ax4UZQXkDjCTf9DzWPmF6fNhDznA1rqnQxXGexU3B66QWeINt2hpKixUHaBSnuNGqteNs2KKrIp4eqrSi7KcENrFGTPv9T72YwMVH16SM5YcCuqwUyc7iEnYO48UO44cQISXSmt+dFMA1V64vL0le3qHUqu3p3IXqoOqskpVT1vbAzrfXfTNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0S25FgVaKOqnyw/28cwfxIGg7oa9uf+9InlNL037q8=;
 b=nrOuTmgUyTC7RGlMtKKeaJd+w5SU2SrUacY6IcKtcwbtEIeX2arswDidg5C96wwLpDPM0r4F3dAP0gNx0vTEkGCDpt9b3TeE/l8zI5tVs9WqLG30TVt9/tI/tnNTRA7t/kQXFut/Wjaks18F4jo6cYE+xG9HBdFlb4ryR2IL6dC0TlmzBxWo5pZ2/xc3/Kk/KUKUeK8Dny4OpThQnZyy/GOtYqawr/4i/O9cuXrSldWXo/JETqwHukbOfKj6VgXZJxn74Mvs267hq0uJCX8ISPzROzroEtsJt3vvLTVbfSRJdXNEUVqbmFIK2hLhz0MesMi0CI17TA0vvMnKOI+Iqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0S25FgVaKOqnyw/28cwfxIGg7oa9uf+9InlNL037q8=;
 b=v271ZLmnrUtY7LixjQq9M/Ne6mdOX1kNR0hp4lr1esfBNyHqfMpBeUBpOMwGaGeJSoTWBRb2g16kkgpfXjr9c4Slyge2XVIlLshsUJp+0sFk6mY8JxWdG3LJVSsNkbv5QLWsaJoVsxcJ4qoAg/LLW8MC55TQOsUbfKchIUT3s88EZlYNT4V8oVlJH1zDiX8EwB6oKMUfxcXQxXIcNSQ1mRjzitfpQxt1SOCzgHVBefmqSPgWdJYAAg/igHd+nb6eluzi7JP1BLt5PuNYjO0alPAl6B43aYoLWESaNVxpkEw1HumyfJiRWxsLUTCpwx7reTB3gidd086UlD/SYGPVpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS5PR04MB9854.eurprd04.prod.outlook.com (2603:10a6:20b:673::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Thu, 9 Nov
 2023 09:03:09 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 09:03:08 +0000
Date: Thu, 9 Nov 2023 17:02:51 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 06/13] bpf: make __reg{32,64}_deduce_bounds
 logic more robust
Message-ID: <p4y43oldjeysg2wrhxbnniplzxzbqcxwu2cy5ljt4oilz6onm6@ocimc7kdi4an>
References: <20231103000822.2509815-1-andrii@kernel.org>
 <20231103000822.2509815-7-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103000822.2509815-7-andrii@kernel.org>
X-ClientProxiedBy: PS2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::18) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS5PR04MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e78f51-2d44-4a9c-359c-08dbe102b15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FeMnOMzJUDcSDnf6yLdXYBZJ5UFLnExWl3Q3S2qqUC7ON3rZUNAh8bBNwK77cbVflX1TAo1NGUg66UppgkPzDnbfDvwxL9RyjKerys0TNs3fSEaWfNQuBZGTohiB89lH6Qh7bXpTvd9YY4e0tCnH9kgzntg6SJg1iiHYXje1JcrEFvEEbHMPda1h8DwoIEYwjbBx6v8v/CL5Cqq+n/p7FN+JKdInVG/XKvBrd9QLVIpSwvLn0Tqep7MU3Bu7EdcdMegZWlV95GiHCY5Ite0DvEDj2FSPYnQ5hMr83YomJ8FN1ILiokVaMg1J4KR38GLkxlvyRc0AWhZyri/7pHlLyd8somJu2eyFvaSowD1+8doyVnTYm+DQHq8cPFE/TdbNt13//rMw7mBLmOQ//x54tsVTUzUypLRhbatBMwWijo8hcFP5toMX4nBdau1h4Xjsz27gEhojZsicQofEfMF20oplkENM4RJX0mcwf9rr7KoRCSY04bUdF7Xe8J3dGuJ+ArFFgzz5Bo7Lqb0XkBuEiETX0/7ZTL8AV/zZHo2Mre17zsRMHMIN6Y1aAttBaaXG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(83380400001)(6512007)(9686003)(6666004)(6916009)(8936002)(316002)(4326008)(66556008)(66946007)(8676002)(2906002)(6506007)(41300700001)(5660300002)(86362001)(38100700002)(33716001)(66476007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hTVxEBE09FI92GdN7KCu2MSdUbhq3vP9cLQiGtm8Mnh1zYNOvPAOgvPIdUY0?=
 =?us-ascii?Q?Id3ErdwSUrLMqpZnQRK/wphG2zlw0XIQ7h9aF0l3pwLk+NVAS73z/6VRd79T?=
 =?us-ascii?Q?nylOkve0HWqWNgx8x0FexkSRguBAeJmbookFS10nfIy8/Dq5JP6sp5olOKvq?=
 =?us-ascii?Q?u9bL3GuSf3kLbQzuwmKQ5/HBgM36DhpckEzGIBnWk0rqXlZY5vzewqK1jaNN?=
 =?us-ascii?Q?/NaoZP91Ze2wI+zmULqO1eNVULGyKLL+n5kEtHEiLIzfDIk1h6FbEVS75bcZ?=
 =?us-ascii?Q?jVE0HbAvW9wr9mNKYyz8fwKBnzBQesYU7duJWG5jmCREK6K5l3+k84Sj9q4i?=
 =?us-ascii?Q?3mJgd7q7uEF1C3ZcFdPoD19yKBhaMNzL6Qsk2UgBJosxIfs26DH6v4sB+pcC?=
 =?us-ascii?Q?2KpSaGCjyYh2B0I0bi1AZ8A2kuSV4YpLxH+zG3PiprvJccNg/ti6+dkm338M?=
 =?us-ascii?Q?kTPWkxBDfxSc4T4jeK7MsufJB3OHg3Wk9GuONcNPEJrWxuU8ww7oks5w8DZ4?=
 =?us-ascii?Q?4a8HfqYnJHQ22tSzeRGMwHmPr95FlF8l8dJ9O/X1VBll5celifRm6QfQPVRR?=
 =?us-ascii?Q?fQgZCPAH7IVGCto9zOcjK2Y6+als79nncUyO8ne9/Rt5uXGFjK6h64XACPgV?=
 =?us-ascii?Q?ZT8ZKj3sQpfJs7UMMeNL3lJiUpXFdSYtqIC/HX3fJupgxTyhqor04fa/mpXv?=
 =?us-ascii?Q?UQR5ndbogK/7LM8diSUyGvy+zSf6eU2iEPUI1xygbCLTSblntgiNqhn4qJmF?=
 =?us-ascii?Q?QRluEJAQGMvdBAL3F0gn8OkF1MZMOBE32uiORkH9RXlA2lvaLWwZmfMI7cJc?=
 =?us-ascii?Q?AYqDs5mnlAEfwKCLy0ATHI7h/iK7DX0NLHPUcvlyi+VVeSRILO2vy0ypmCq/?=
 =?us-ascii?Q?4Gq9ZJUXZtOqkkYOtNLsgu467jbonfP4krQIAH+nD0peANNafhe8FIocsp+2?=
 =?us-ascii?Q?17ddlRxERFxLFll+6DWWH5HbmiSx1YE3jyUgBewRH8E7K8fwXrcPqbKC6uW1?=
 =?us-ascii?Q?rBFlX0+WOK+uLpiInhT9+++R8FUowaneQP4M9BB119hdUdhq9LbQVfrCZrlD?=
 =?us-ascii?Q?jmxAp7xmPImupnI1GPYgohQVpzs14U5B/32oy4FAxdVaxY0oeEY0zKZGetLN?=
 =?us-ascii?Q?Nc9a377kZSSm8mLWjvoNZWKi8jFlOSVLosdKxbPJLMCKKlWRYf5M9IAwNvaF?=
 =?us-ascii?Q?HDqPz9HdSZ60OdvOcwV24o4ToMZjfNeemggv9SS2M/E52f9UnPRQ9VfIebjy?=
 =?us-ascii?Q?YLGnWWhOVTOHirc8KnJZ3A/xaiWv2T2s1It4t2UNVSFh/Lgn49KAOaCHAV28?=
 =?us-ascii?Q?2VUx3ss/qJFQnJH/9/NHJyoepzigqC2yY1Trw8B4nxNF4S064rInsjZNXZSO?=
 =?us-ascii?Q?pjE3ZURb/v4vf1mcbpLtpGwpQq9JA3b/ANW1lffgUyGFaHZazrIYJnqQcV5g?=
 =?us-ascii?Q?+1gg3ob/pVfzcOJ3u6a968sPWl8DBKjgWBbjJLNmy4b4esSLPBgULy0xSWus?=
 =?us-ascii?Q?96mx9qOvJjga2NEyXHfPxGKhaqnTPPioYZO4xyOxMwbfvxWKVHXEKBi2GpHn?=
 =?us-ascii?Q?LgTR0dQoMHyUe7E6giDuA43SaB6i+fofIZAgWbqC2/O4lhklTHJuVxMgxqDf?=
 =?us-ascii?Q?BQ0C5U4gB5vbE8bBvlnlqUdyrVyoo51d4mb4VGp5NDyP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e78f51-2d44-4a9c-359c-08dbe102b15d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 09:03:08.8564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAIHl3pWSj7SOnaB9hT37S1QetqMEvsvw3HhiCXo53u69vF5XOKu9274YGkZIcJw7n8cml2/8/6mjMpUCNyuCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9854

On Thu, Nov 02, 2023 at 05:08:15PM -0700, Andrii Nakryiko wrote:
> This change doesn't seem to have any effect on selftests and production
> BPF object files, but we preemptively try to make it more robust.
> 
> First, "learn sign from signed bounds" comment is misleading, as we are
> learning not just sign, but also values.
> 
> Second, we simplify the check for determining whether entire range is
> positive or negative similarly to other checks added earlier, using
> appropriate u32/u64 cast and single comparisons. As explain in comments
> in __reg64_deduce_bounds(), the checks are equivalent.
> 
> Last but not least, smin/smax and s32_min/s32_max reassignment based on
> min/max of both umin/umax and smin/smax (and 32-bit equivalents) is hard
> to explain and justify. We are updating unsigned bounds from signed
> bounds, why would we update signed bounds at the same time? This might
> be correct, but it's far from obvious why and the code or comments don't
> try to justify this. Given we've added a separate deduction of signed
> bounds from unsigned bounds earlier, this seems at least redundant, if
> not just wrong.
> 
> In short, we remove doubtful pieces, and streamline the rest to follow
> the logic and approach of the rest of reg_bounds_sync() checks.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e7b2fe78a07f..91271961c9c2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2399,17 +2399,13 @@ static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
>  		reg->s32_min_value = max_t(s32, reg->s32_min_value, reg->u32_min_value);
>  		reg->s32_max_value = min_t(s32, reg->s32_max_value, reg->u32_max_value);
>  	}
> -	/* Learn sign from signed bounds.
> -	 * If we cannot cross the sign boundary, then signed and unsigned bounds
> +	/* If we cannot cross the sign boundary, then signed and unsigned bounds
>  	 * are the same, so combine.  This works even in the negative case, e.g.
>  	 * -3 s<= x s<= -1 implies 0xf...fd u<= x u<= 0xf...ff.
>  	 */
> -	if (reg->s32_min_value >= 0 || reg->s32_max_value < 0) {
> -		reg->s32_min_value = reg->u32_min_value =
> -			max_t(u32, reg->s32_min_value, reg->u32_min_value);
> -		reg->s32_max_value = reg->u32_max_value =
> -			min_t(u32, reg->s32_max_value, reg->u32_max_value);
> -		return;

I'd guess updating signed bounds here is sort of a shortcut to reach the
tighest bound possible without going having to go through
__reg32_deduce_bounds() twice, maybe.

Agree that the changes below is more straight forward, same goes for
__reg64_deduce_bounds().

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

> +	if ((u32)reg->s32_min_value <= (u32)reg->s32_max_value) {
> +		reg->u32_min_value = max_t(u32, reg->s32_min_value, reg->u32_min_value);
> +		reg->u32_max_value = min_t(u32, reg->s32_max_value, reg->u32_max_value);
>  	}
>  }
>  
> @@ -2486,17 +2482,13 @@ static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
>  		reg->smin_value = max_t(s64, reg->smin_value, reg->umin_value);
>  		reg->smax_value = min_t(s64, reg->smax_value, reg->umax_value);
>  	}
> -	/* Learn sign from signed bounds.
> -	 * If we cannot cross the sign boundary, then signed and unsigned bounds
> +	/* If we cannot cross the sign boundary, then signed and unsigned bounds
>  	 * are the same, so combine.  This works even in the negative case, e.g.
>  	 * -3 s<= x s<= -1 implies 0xf...fd u<= x u<= 0xf...ff.
>  	 */
> -	if (reg->smin_value >= 0 || reg->smax_value < 0) {
> -		reg->smin_value = reg->umin_value = max_t(u64, reg->smin_value,
> -							  reg->umin_value);
> -		reg->smax_value = reg->umax_value = min_t(u64, reg->smax_value,
> -							  reg->umax_value);
> -		return;
> +	if ((u64)reg->smin_value <= (u64)reg->smax_value) {
> +		reg->umin_value = max_t(u64, reg->smin_value, reg->umin_value);
> +		reg->umax_value = min_t(u64, reg->smax_value, reg->umax_value);

