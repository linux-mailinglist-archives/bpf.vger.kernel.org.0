Return-Path: <bpf+bounces-34244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F331E92BC89
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 16:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 906BEB260D2
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 14:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CB918F2CA;
	Tue,  9 Jul 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShyYfvpX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A3A15699E;
	Tue,  9 Jul 2024 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534284; cv=none; b=urinkBLDff3nFaSNJU/2M4Xe9loxo9fi5jpSxCpLyzNdwxtmltRl9cyp2/2ajQNlcQQ+wfgygO0jJKep7D5ZMeAcUif3XpgetfGr87LHwZpgfd3vT9LwgUfltNcQR26KC/56kQosHHP/JgTbn/iUhpz7bupFdHU4E7fhs5B2GnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534284; c=relaxed/simple;
	bh=PCnMnXirJqSJMZG4xB6vc8i/BajoHnEezI7p3NPAu7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ8k4MPs/a5gzRq81apIPsO3rxLnWT6/LwBMX3GA9zcWO5m79V7DkAnR96QWmaV/rnq5scCTJgEQ835FGCJ76sbnbdSxKtuo1qIgCB7dm8aja9gRYDAZZc84rsAHLmP9/TcBLMWf3LQ/nXT7pts/IqHOviv263VFQMFq7rxe/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShyYfvpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F8EC32782;
	Tue,  9 Jul 2024 14:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720534283;
	bh=PCnMnXirJqSJMZG4xB6vc8i/BajoHnEezI7p3NPAu7E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ShyYfvpXIFXG/TEJCH6AD5pggW+nn/4afDRuoxSwc0LNjxjA3yjDJKYDRt5BQjgpv
	 voVtz+ewLOwTsHPCGGpJVOQsBR8/GGncNHs4L29f6vFuUGdt3AiBdXNrtpQhFhuJcz
	 NeBTnIJTQyuLCBK1ey64t8hZQgYO1f2U6N7BS75hdLcvtI8zj+GauYowYV0ehAu6yM
	 JIKlK/w1m9/zeewqlun79JpSDFUUwLw+J1XfzCdi2Rc0vlU+wy/vMW/ank81bhnT4b
	 FnhxhqO7+EIi38rv4BYMqU2XHMpKesASUPbcVpv3rzaaF6o/xgEowwe7xCdp8e9YS/
	 JFiB56wdTFyIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 26FE3CE09F8; Tue,  9 Jul 2024 07:11:23 -0700 (PDT)
Date: Tue, 9 Jul 2024 07:11:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, bpf <bpf@vger.kernel.org>, willy@infradead.org
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090153.GF27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709090153.GF27299@noisy.programming.kicks-ass.net>

On Tue, Jul 09, 2024 at 11:01:53AM +0200, Peter Zijlstra wrote:
> On Mon, Jul 08, 2024 at 05:25:14PM -0700, Andrii Nakryiko wrote:
> 
> > Quick profiling for the 8-threaded benchmark shows that we spend >20%
> > in mmap_read_lock/mmap_read_unlock in find_active_uprobe. I think
> > that's what would prevent uprobes from scaling linearly. If you have
> > some good ideas on how to get rid of that, I think it would be
> > extremely beneficial. 
> 
> That's find_vma() and friends. I started RCU-ifying that a *long* time
> ago when I started the speculative page fault patches. I sorta lost
> track of that effort, Willy where are we with that?
> 
> Specifically, how feasible would it be to get a simple RCU based
> find_vma() version sorted these days?

Liam's and Willy's Maple Tree work, combined with Suren's per-VMA locking
combined with some of Vlastimil's slab work is pushing in that direction.
I believe that things are getting pretty close.

As with your work in 2010 and MIT guy's work in 2013, corner-case
correctness and corner-case performance regressions continue to provide
quite a bit of good clean fun.

							Thanx, Paul

