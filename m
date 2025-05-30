Return-Path: <bpf+bounces-59355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8E9AC933D
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 18:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3545A211B3
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 16:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8DC1A3BD7;
	Fri, 30 May 2025 16:15:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC215DBB3;
	Fri, 30 May 2025 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621736; cv=none; b=ADKhzBrrGhg2/+0DjuCrL+dIABUZOr9F0pKBN3g1Bwwvc5D7PMv9T5QGKnO8UDCCCG9E/lOVhxphvQiembFA+QyV0IGpiPGvZJdJ/FWN9DkfNzkKcicp5wzVK1K1w1oVjP/Gv6gCagNVDOTNurDvPd3I8eA55z5oVlaHGJJlH4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621736; c=relaxed/simple;
	bh=Y4x6fYGEYAzeTlrb0R6vK1rGm7UNFgAxajOHrxpHWjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEgPDLFChXg6Mhbqxu21yuOOxMSZKtHEBiTdR9q1cFiHBC56LIHkSX5KqZ12C2uvDq1K4OjLooFuNeNQHml39CazVEDb6iq81Vq+692u1E6s9Tgx3sZcoQdLdEAbFf2Oj3doZu23xfpxXPlxgieZWWk4QHr/P3cgxlMRVb+Dw94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EE7C4CEE9;
	Fri, 30 May 2025 16:15:34 +0000 (UTC)
Date: Fri, 30 May 2025 12:16:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 bpf@vger.kernel.org, Jonathan Lemon <jonathan.lemon@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] xdp: Remove unused mem_return_failed event
Message-ID: <20250530121638.35106c15@gandalf.local.home>
In-Reply-To: <696364e6-5eb1-4543-b9f4-60fba10623fc@kernel.org>
References: <20250529160550.1f888b15@gandalf.local.home>
	<696364e6-5eb1-4543-b9f4-60fba10623fc@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 May 2025 08:51:12 +0200
Jesper Dangaard Brouer <hawk@kernel.org> wrote:

> > The change to allow page_poll to handle its own page destruction instead  
>                             ^^^^
> You miss-spelled page_pool as "page_poll"

Oops!

> 
> > of relying on XDP removed the trace_mem_return_failed() tracepoint caller,
> > but did not remove the mem_return_failed trace event. As trace events take
> > up memory when they are created regardless of if they are used or not,
> > having this unused event around wastes around 5K of memory.
> > 
> > Remove the unused event.
> > 
> > Link: https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.home/
> > 
> > Fixes: c3f812cea0d7 ("page_pool: do not release pool until inflight == 0.")
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >   include/trace/events/xdp.h | 26 --------------------------
> >   1 file changed, 26 deletions(-)  
> 
> With above spelling fixed:
> 
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

Thanks. Will this go through the networking tree or should I just take it?

-- Steve

