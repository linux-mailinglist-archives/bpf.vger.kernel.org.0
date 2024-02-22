Return-Path: <bpf+bounces-22508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A1885FDDC
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 17:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC56BB2BA7E
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C253615098E;
	Thu, 22 Feb 2024 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hxD4qEft"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8396D14F9ED
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618375; cv=none; b=HOKece7QZW6EQrOXDWEQkIcV6HdmNBhzBVa/WMIyeIIK1bK/fjBuDVBKlOOGMoB4oPDV9cewXn5iHQQtloxWhAbeygSRdZaSiuxIYMNYPDuKD18MPsk9tGugw7dFFn/3ibdgiCgVdC6Za4oZVdLC/KGYA7Kx12VAuJbhQTEbeBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618375; c=relaxed/simple;
	bh=7adu2iHiZkBmGzFz8rIs3ssdYWS2RsUY64dlj3xv9k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUT/4WlLnaPXvk+q/I6eNG3NfdZ2UQ32ytVm0MR1O14ilpmQYuynZPzbRLDEHMZ8LPaHUWJ4jZ6pqsnKf5zZnSnTNbcKOAoYSrrfICG0XBzD2bRqf3TSt5v6GsJXsN3S9VtrbIxX0trFVeQ6AIV8o6LEt2rF2/PUvWAD7pxGyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hxD4qEft; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <03a6bced-b4fa-4ddd-bc84-e1325433911f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708618370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5NJGTTTy9qQTEfsf6bS1KKCK8j8PpseHxDaqOcqIw+Y=;
	b=hxD4qEftKelfuvIiWS5mJmtL/3TqhQgkaUhJVNN+t9wzFS9dXav9cpldVqyBqRyrZIVwRs
	8Jn4gP7cb9fY/L3YMHx3EeNJD9XFOVBP/5tLihag4tuwoVNjHUK5Ioou1WM2T27gJzc+Qv
	u8VwWinsfgn9pucbn1fnQgbcZiNsQFc=
Date: Thu, 22 Feb 2024 08:12:43 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 1/2] bpf: check bpf_func_state->callback_depth when
 pruning states
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, kuniyu@amazon.com
References: <20240222154121.6991-1-eddyz87@gmail.com>
 <20240222154121.6991-2-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240222154121.6991-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/22/24 7:41 AM, Eduard Zingerman wrote:
> When comparing current and cached states verifier should consider
> bpf_func_state->callback_depth. Current state cannot be pruned against
> cached state, when current states has more iterations left compared to
> cached state. Current state has more iterations left when it's
> callback_depth is smaller.
>
> Below is an example illustrating this bug, minimized from mailing list
> discussion [0] (assume that BPF_F_TEST_STATE_FREQ is set).
> The example is not a safe program: if loop_cb point (1) is followed by
> loop_cb point (2), then division by zero is possible at point (4).
>
>      struct ctx {
>      	__u64 a;
>      	__u64 b;
>      	__u64 c;
>      };
>
>      static void loop_cb(int i, struct ctx *ctx)
>      {
>      	/* assume that generated code is "fallthrough-first":
>      	 * if ... == 1 goto
>      	 * if ... == 2 goto
>      	 * <default>
>      	 */
>      	switch (bpf_get_prandom_u32()) {
>      	case 1:  /* 1 */ ctx->a = 42; return 0; break;
>      	case 2:  /* 2 */ ctx->b = 42; return 0; break;
>      	default: /* 3 */ ctx->c = 42; return 0; break;
>      	}
>      }
>
>      SEC("tc")
>      __failure
>      __flag(BPF_F_TEST_STATE_FREQ)
>      int test(struct __sk_buff *skb)
>      {
>      	struct ctx ctx = { 7, 7, 7 };
>
>      	bpf_loop(2, loop_cb, &ctx, 0);              /* 0 */
>      	/* assume generated checks are in-order: .a first */
>      	if (ctx.a == 42 && ctx.b == 42 && ctx.c == 7)
>      		asm volatile("r0 /= 0;":::"r0");    /* 4 */
>      	return 0;
>      }
>
> Prior to this commit verifier built the following checkpoint tree for
> this example:
>
>   .------------------------------------- Checkpoint / State name
>   |    .-------------------------------- Code point number
>   |    |   .---------------------------- Stack state {ctx.a,ctx.b,ctx.c}
>   |    |   |        .------------------- Callback depth in frame #0
>   v    v   v        v
>     - (0) {7P,7P,7},depth=0
>       - (3) {7P,7P,7},depth=1
>         - (0) {7P,7P,42},depth=1
>           - (3) {7P,7,42},depth=2
>             - (0) {7P,7,42},depth=2      loop terminates because of depth limit
>               - (4) {7P,7,42},depth=0    predicted false, ctx.a marked precise
>               - (6) exit
> (a)      - (2) {7P,7,42},depth=2
>             - (0) {7P,42,42},depth=2     loop terminates because of depth limit
>               - (4) {7P,42,42},depth=0   predicted false, ctx.a marked precise
>               - (6) exit
> (b)      - (1) {7P,7P,42},depth=2
>             - (0) {42P,7P,42},depth=2    loop terminates because of depth limit
>               - (4) {42P,7P,42},depth=0  predicted false, ctx.{a,b} marked precise
>               - (6) exit
>       - (2) {7P,7,7},depth=1             considered safe, pruned using checkpoint (a)
> (c)  - (1) {7P,7P,7},depth=1            considered safe, pruned using checkpoint (b)
>
> Here checkpoint (b) has callback_depth of 2, meaning that it would
> never reach state {42,42,7}.
> While checkpoint (c) has callback_depth of 1, and thus
> could yet explore the state {42,42,7} if not pruned prematurely.
> This commit makes forbids such premature pruning,
> allowing verifier to explore states sub-tree starting at (c):
>
> (c)  - (1) {7,7,7P},depth=1
>         - (0) {42P,7,7P},depth=1
>           ...
>           - (2) {42,7,7},depth=2
>             - (0) {42,42,7},depth=2      loop terminates because of depth limit
>               - (4) {42,42,7},depth=0    predicted true, ctx.{a,b,c} marked precise
>                 - (5) division by zero
>
> [0] https://lore.kernel.org/bpf/9b251840-7cb8-4d17-bd23-1fc8071d8eef@linux.dev/
>
> Fixes: bb124da69c47 ("bpf: keep track of max number of bpf_loop callback iterations")
> Suggested-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Thanks for updating commit messages. It looks correct to me.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


