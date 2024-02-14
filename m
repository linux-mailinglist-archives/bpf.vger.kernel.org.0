Return-Path: <bpf+bounces-22042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10389855780
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 00:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17AC41C21C94
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 23:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB6A1420CB;
	Wed, 14 Feb 2024 23:52:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F014198B;
	Wed, 14 Feb 2024 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954757; cv=none; b=gBFdz7X34TvYIn984oNkKQgdchNQTviHKKKZ9eRnPvEtmuQwXdgbAPvUIv8f7lJwYYpzXTyyAe1AOvg5Ttk2RY5lNgGDL/PjQ/GaBjG6e7nDifUj+x4kstPs3GinY5LXYyR0AMC8Pwrzviz6FLSUGObQguhoIPXzK0M88AnO2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954757; c=relaxed/simple;
	bh=se9iJglQFcY5m50dOQjnyAPWzoyiPZ756eq3L6hkD1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnNSw84g8CFHA0cdAWeUmcD33fzAWtu2LPtypmuceXnX8ZYWVWK0FgklrybneGbrqbUfsqU+R2lMNmgEwDgB/EtqjILDDB7hGJfsf2xFycEiFMeOWZAUjt69uYTvcFYq6nSD2cGhUK40AeObHNq8vPXSjyr50MfObtxgv/lkGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3A0C433C7;
	Wed, 14 Feb 2024 23:52:35 +0000 (UTC)
Date: Wed, 14 Feb 2024 18:54:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v7 19/36] function_graph: Implement
 fgraph_reserve_data() and fgraph_retrieve_data()
Message-ID: <20240214185407.767243b4@gandalf.local.home>
In-Reply-To: <20240215084552.b72d6d22ce1b93bb8e04b70a@kernel.org>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723226123.502590.4924916690354403889.stgit@devnote2>
	<20240214135958.23ed55e1@gandalf.local.home>
	<20240215084552.b72d6d22ce1b93bb8e04b70a@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 08:45:52 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Hmm, the above is a fast path. I wonder if we should add a patch to make that into:
> > 
> > 	if (unlikely(size_bytes & (sizeof(long) - 1)))
> > 		data_size = DIV_ROUND_UP(size_bytes, sizeof(long));
> > 	else
> > 		data_size = size_bytes >> (sizeof(long) == 4 ? 2 : 3);
> > 
> > to keep from doing the division.  
> 
> OK, I thought DIV_ROUND_UP was not much cost. Since sizeof(long) is
> fixed 4 or 8, so 
> 
> data_size = (size_bytes + sizeof(long) - 1) >> BITS_PER_LONG;
> 
> will this work?

No, because BITS_PER_LONG is 32 or 64 ;-)

But this should;

	data_size = (size_bytes + sizeof(long) - 1) >> (sizeof(long) == 4 ? 2 : 3);

As sizeof(long) is a constant, that conditional expression will be hard
coded into either 2 or 3 by the compiler.

-- Steve

