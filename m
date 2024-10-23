Return-Path: <bpf+bounces-42886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663969AC752
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 12:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F404AB24BCD
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AAA19E961;
	Wed, 23 Oct 2024 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t/S2/GVl"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCCB19D081;
	Wed, 23 Oct 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677913; cv=none; b=sVVmC76ucEpBmoFBkOcsBVV3ALENfFSPJfMFzCgbGub/pPDjAVwOsLGYtCZX1KP5TbsoboXE/vlLyQz5d7Zyj+cawdRNTdjDHT8EZPNaGax3fgYMStVdO/uvxOat8ssQgLfKCM3e36gMw0OPfHX5s7Jiprfx6lDncnNPjIIuz6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677913; c=relaxed/simple;
	bh=2YrWzXSdePuA5kxw1g5TA+WMQFKlr/SK+XqvsKef4HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kit98XjwD9/ANSBSTlTW7tLsCAnlem9DsZ1t9VLAddQLWwSeNCOntxZJ427hlccI6pM2Q3sXwDts/B9GVuL63CFtRtn936Lzi7mueQ1Ef4MIcIiwWTauxl24Uj6IXgJsO4ncr8se9ftNHQ9DCZ8zkFLP6t9bQi8z/vx6+P2Oimc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t/S2/GVl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+jbl+fz17Sss2E4jsI1mUGPzCQvC+EZsCD0MBXkPEYA=; b=t/S2/GVlSh5ncvmh/1wnyNPlrY
	nAYNSFiCTWovpOMYFIgJUuP933XYFDOHS6GOePaQSOZc/WGQxK9RBJDUeYR+Lvls/Bdnnir9pioP6
	MbzXJfLTe/bo/IwuG6EtCLQgxONXSYyKFDyQaydEwSNi1uOe6GdtxhPbPx7Xi2Q7r3ZC365F9u8+2
	YPSgimfhy7JjMPp4ONZqdc+g2uTNNBO2KOm93Uc5jQkY+hWhdo5Y8Wmm7ZuUg/PAIp7wQE+GFVyO+
	zrxu0ur5Obnx7yG0G2/0M5va9aqcJgSUxGJGAnfcKm1uq3FHu5/MnPqj1Wf/mpds1hqGIJtM0AUmP
	+hfQqVgg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3YEj-00000002jyG-0H3c;
	Wed, 23 Oct 2024 10:05:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 523F030073F; Wed, 23 Oct 2024 12:05:05 +0200 (CEST)
Date: Wed, 23 Oct 2024 12:05:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Sean Young <sean@mess.org>,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf,perf: Fix perf_event_detach_bpf_prog error
 handling
Message-ID: <20241023100505.GG16066@noisy.programming.kicks-ass.net>
References: <20241023100131.3400274-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023100131.3400274-1-jolsa@kernel.org>

On Wed, Oct 23, 2024 at 12:01:31PM +0200, Jiri Olsa wrote:
> Peter reported that perf_event_detach_bpf_prog might skip to release
> the bpf program for -ENOENT error from bpf_prog_array_copy.
> 
> This can't happen because bpf program is stored in perf event and is
> detached and released only when perf event is freed.
> 
> Let's make it obvious and add WARN_ON_ONCE on the -ENOENT check and
> make sure the bpf program is released in any case.
> 
> Cc: Sean Young <sean@mess.org>
> Fixes: 170a7e3ea070 ("bpf: bpf_prog_array_copy() should return -ENOENT if exclude_prog not found")
> Closes: https://lore.kernel.org/lkml/20241022111638.GC16066@noisy.programming.kicks-ass.net/
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thanks Jiri!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/trace/bpf_trace.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 95b6b3b16bac..2c064ba7b0bd 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2216,8 +2216,8 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>  
>  	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
>  	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
> -	if (ret == -ENOENT)
> -		goto unlock;
> +	if (WARN_ON_ONCE(ret == -ENOENT))
> +		goto put;
>  	if (ret < 0) {
>  		bpf_prog_array_delete_safe(old_array, event->prog);
>  	} else {
> @@ -2225,6 +2225,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>  		bpf_prog_array_free_sleepable(old_array);
>  	}
>  
> +put:
>  	bpf_prog_put(event->prog);
>  	event->prog = NULL;
>  
> -- 
> 2.46.2
> 

