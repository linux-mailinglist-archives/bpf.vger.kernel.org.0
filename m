Return-Path: <bpf+bounces-22133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63518576E2
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 08:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E442B1C21719
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 07:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C681757E;
	Fri, 16 Feb 2024 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHyoB/Zm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1B14F64;
	Fri, 16 Feb 2024 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069214; cv=none; b=cXndlbxHPuiRxs/vf0PrrUJpiuJLBiVgPT1Lhc5UcXSSKffS9A+3Q8wf4Xiz2azE2UkDK1wP17q69fGdS2ajs+BEgzanCHSj6dauIbYg2uBgrGgXYWPEK0xIC+mvtHqzx7vL2n/ZKbnwhxypw2gR14p/C86NrCOUipKIFD6H9Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069214; c=relaxed/simple;
	bh=icz55HJQfZZHEN/btHPRBr3cpgSXuR4YteZ6R/WPaGA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LWV7mBLpwmVf2kLccfwyD1TjWVEgJNod7rYabSS7MIPWnAbIuWonw+DiBdeG494vi0GCCFqsSZfuiY3i8+rXaefJ49GkD8eeWb5jrUaWUY0V7QHSNkzMEe7fryi6bYz7/P+CQxdgu1Vgn7nY4Stfp3YCpN4IeVEHCkbAarye9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHyoB/Zm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F255C433C7;
	Fri, 16 Feb 2024 07:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708069214;
	bh=icz55HJQfZZHEN/btHPRBr3cpgSXuR4YteZ6R/WPaGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RHyoB/Zm+aeCpXvsdcAkjZ/8IP0JIcV9o5cVs3hvqpviLm+GagX2Su7pi1IzmbFTI
	 egsQDa7ec2GbV/tx00to1LvWI7cUqCtFZbVRCA+hJ6tEaXpXf2SXZaWIRZf9hW3P3V
	 14k+yC+cS4EZoFOf1pkEXd7JEIlN1616BOSHmiot2zsknR6TT/hB3pcHYGCYALkUgq
	 3/MpJEb5Qu0tMkq7dlDZKPDAoDxDeZCr3R26s2hBY9Z/0qPKuuYKzoFX4LlPpaNpZn
	 GHCAEPY6d6nFk7ERFwPg2osOonvSBgwtQb0+uPgrFpnv9+JFklxoEmklr63HlMMVYR
	 8BGq/CQgSk+6g==
Date: Fri, 16 Feb 2024 16:40:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
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
Message-Id: <20240216164007.2de685ce5c78cee69e168601@kernel.org>
In-Reply-To: <20240214185407.767243b4@gandalf.local.home>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723226123.502590.4924916690354403889.stgit@devnote2>
	<20240214135958.23ed55e1@gandalf.local.home>
	<20240215084552.b72d6d22ce1b93bb8e04b70a@kernel.org>
	<20240214185407.767243b4@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 18:54:07 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 15 Feb 2024 08:45:52 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > Hmm, the above is a fast path. I wonder if we should add a patch to make that into:
> > > 
> > > 	if (unlikely(size_bytes & (sizeof(long) - 1)))
> > > 		data_size = DIV_ROUND_UP(size_bytes, sizeof(long));
> > > 	else
> > > 		data_size = size_bytes >> (sizeof(long) == 4 ? 2 : 3);
> > > 
> > > to keep from doing the division.  
> > 
> > OK, I thought DIV_ROUND_UP was not much cost. Since sizeof(long) is
> > fixed 4 or 8, so 
> > 
> > data_size = (size_bytes + sizeof(long) - 1) >> BITS_PER_LONG;
> > 
> > will this work?
> 
> No, because BITS_PER_LONG is 32 or 64 ;-)

Oops indeed.

> 
> But this should;
> 
> 	data_size = (size_bytes + sizeof(long) - 1) >> (sizeof(long) == 4 ? 2 : 3);
> 
> As sizeof(long) is a constant, that conditional expression will be hard
> coded into either 2 or 3 by the compiler.

Yeah. OK, let me update it.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

