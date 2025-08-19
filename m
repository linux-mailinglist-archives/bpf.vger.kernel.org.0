Return-Path: <bpf+bounces-66017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD957B2C7A8
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 16:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE4F172E39
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA71527E1DC;
	Tue, 19 Aug 2025 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YiILW7sO"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D3827B35C;
	Tue, 19 Aug 2025 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615238; cv=none; b=lMsS0ItVv1L8MjHiWWS6GIqAAc4WUrn6REcPp3kDBaXiG50MoPNDs7m3GYZvNnktDAFg5IAWcT6xZBwSZdhSlg+MD3W7APGnjb2tSH8snZY2BQ+yR0x8Gxe8lFbUzBsFTg4vv+wWedDRLEt4fOTJ+mzKgNRXRMStqnm49PezN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615238; c=relaxed/simple;
	bh=mjYhOn9CDT21rsExSAogz1W/kh3mYEzshT4unY/C9Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etrpRMjjrfZBMS4nDP88Z+Tnz3DqlCHV+8sthTupzakw/ZvKZjaMR55LyyhUui5Yn22esSSz5vIG/eNVPSRrRtLfC/Uyx3qQXEs3RHQZfqYVDjeRHGdSPODyBvlnUH1xcL/h8O2nZbdPCUAmVet/YrJmCEBkHGaDa8K4cRLqNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YiILW7sO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PzTXBaKR1DruroEf+Ojx/krKYrEzoXf3BdA5AnMmkbA=; b=YiILW7sOX0yrn5DgDIlE40Anlz
	Pt39WoBQGpoUBfrZu4rMhDqiNXW1LOFokHf0IrdrEJUFDXaEr61xlxfwaL5OKRfPfcXo9+yu1m+bf
	oetZoMhWqERJ+1DXYQ8ZSxFIpaHvpF4hRlEF/CZBsGe9QeJAQbcUoG+a+EiWKHGp8XKobsq3bSbHH
	u1MgLoV+R8rEBvi+jFiTBBnsY+opQvg5Hy+D+kahovADSCOXv1UuEC82trkE93dlm454Wxd81zBol
	mfimjZUmWCZDgMXnL+ZVK8NXuw/3yeD4f7JdbiHsyyPqis++sL2yptC16H13eQDwV256Epmy0w0V6
	0PObTXiw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoNic-000000077NJ-0HL1;
	Tue, 19 Aug 2025 14:53:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CDB6630036F; Tue, 19 Aug 2025 16:53:45 +0200 (CEST)
Date: Tue, 19 Aug 2025 16:53:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv6 perf/core 08/22] uprobes/x86: Add mapping for optimized
 uprobe trampolines
Message-ID: <20250819145345.GL3289052@noisy.programming.kicks-ass.net>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-9-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720112133.244369-9-jolsa@kernel.org>

On Sun, Jul 20, 2025 at 01:21:18PM +0200, Jiri Olsa wrote:
> +static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
> +{
> +	/*
> +	 * We do not unmap and release uprobe trampoline page itself,
> +	 * because there's no easy way to make sure none of the threads
> +	 * is still inside the trampoline.
> +	 */
> +	hlist_del(&tramp->node);
> +	kfree(tramp);
> +}

I am somewhat confused; isn't this called from
__mmput()->uprobe_clear_state()->arch_uprobe_clear_state ?

At that time we don't have threads anymore and mm is about to be
destroyed anyway.

