Return-Path: <bpf+bounces-34576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1212092EB8F
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 17:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FEB1B216E7
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4226716B739;
	Thu, 11 Jul 2024 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LzvxL+oJ"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5621642B;
	Thu, 11 Jul 2024 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711368; cv=none; b=GzAizbClTl5dPod/znRLZ9dIfGO9WVxUCFvPxv2esNSbbtXp479Wm1VCyiV66JIHi0M7A258Tvf373S486EbvqKZlhjv71jCKOWY9QDKIOaANfEzh6s9vArxgM4TbA5Ohrdm+qi30XNR1H2p1ZGXJtvNpJx+xdK2PXqE4XzS3zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711368; c=relaxed/simple;
	bh=+UWnsWVMdvca6g6oeX3Dfksfrism7A0B9YrqtABwQig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ab8WG2bILi7V0DE8sTU+DSdgH/cX9BnJZkjCpdx9qW9bIYPsr1TDl8BdZCb5O5PqhdypwLulSXJNEPJcwCjBsptb7ZlsZ00ftmCr3hAI/Vd3D0fwFf2BfzZnP3UXddR0YHk321BCEN2hmd+aIHR5bY3tOMC2eRdv/PZ4Gn/ysVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LzvxL+oJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZSAN8Frn8wQki6uXAENE6UG5BBN7qPxdEWLY87nt5nA=; b=LzvxL+oJ+FlY7E/sbmp1/DeVbB
	LMU3TBxN5G8iAxpSPessAOx0tafI9BG94ltQ86hVjVMcGqIA7jDeHn8aqiBVs1bf7N2EvGHe2zNkQ
	Ns5W2YcbnVnvoW5ubuMku9Q6ujx8jI9QCSRc3OLY1dCbvL/JEip7lkIDuYIEC2LuAfirm9aCXNR4u
	afoWlJPgLv1mhBD+YIN5DVKDLoG14t6sqK4KQkQ7iH8QyL4L4BkcWyLxHcEQYooxDTK6ilOpj2Fmy
	u9Go2tZTKe4IXtjvvIvVKNUx+U/XSPJO9/XXxko2pbKXVKIpobrEv44d8L0giqFWKDzfL4Pnisgsx
	knAGBiZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRvd0-0000000BHKt-4C5q;
	Thu, 11 Jul 2024 15:22:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3F38830050D; Thu, 11 Jul 2024 17:22:38 +0200 (CEST)
Date: Thu, 11 Jul 2024 17:22:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, mingo@kernel.org, andrii@kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, oleg@redhat.com,
	clm@meta.com, paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <20240711152238.GB3285@noisy.programming.kicks-ass.net>
References: <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090304.GG27299@noisy.programming.kicks-ass.net>
 <Zo0KX1P8L3Yt4Z8j@krava>
 <20240709101634.GJ27299@noisy.programming.kicks-ass.net>
 <20240710071046.e032ee74903065bddba9a814@kernel.org>
 <20240710101003.GV27299@noisy.programming.kicks-ass.net>
 <20240710235616.5a9142faf152572db62d185c@kernel.org>
 <CAEf4BzZGHGxsqNWSBu3B79ZNEM6EruiqSD4vT-O=_RzsBeKP0w@mail.gmail.com>
 <20240711085118.GH4587@noisy.programming.kicks-ass.net>
 <20240712001718.e00caa0a3cb410dc19f169c2@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712001718.e00caa0a3cb410dc19f169c2@kernel.org>

On Fri, Jul 12, 2024 at 12:17:18AM +0900, Masami Hiramatsu wrote:
> From 87dfb9c0e7660e83debd69a0c7e28bc61d214fa8 Mon Sep 17 00:00:00 2001
> From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Date: Fri, 12 Jul 2024 00:08:30 +0900
> Subject: [PATCH] MAINTAINERS: Add uprobes entry
> 
> Add uprobes entry to MAINTAINERS and move its maintenance on the linux-trace
> tree as same as other probes.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index da5352dbd4f3..7f6285d98b39 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23105,6 +23105,18 @@ F:	drivers/mtd/ubi/
>  F:	include/linux/mtd/ubi.h
>  F:	include/uapi/mtd/ubi-user.h
>  
> +UPROBES
> +M:	Masami Hiramatsu <mhiramat@kernel.org>
> +M:	Oleg Nesterov <oleg@redhat.com>
> +M:	Peter Zijlstra <peterz@infradead.org>
> +L:	linux-kernel@vger.kernel.org
> +L:	linux-trace-kernel@vger.kernel.org
> +S:	Maintained
> +Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> +F:	include/linux/uprobes.h
> +F:	kernel/events/uprobes.c

Maybe no Q/T. Neither Oleg nor me have write access to that git tree.

Also, I think you want:

F: arch/*/kernel/uprobes.c 
F: arch/*/kernel/probes/uprobes.c 
F: arch/*/include/asm/uprobes.h


This is just to ensure get_maintainers.sh gets our email addresses for
all uprobes stuff.

