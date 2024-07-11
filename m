Return-Path: <bpf+bounces-34586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905A992EE02
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 19:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19F01C21CE7
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB03B16D9D4;
	Thu, 11 Jul 2024 17:45:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D09F288A4;
	Thu, 11 Jul 2024 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719943; cv=none; b=Yjihusxg0Zsg0IDAvA2CgXHpSfkON96erpZI5Fxew9/MAn7yiP/W+GqdhK2KbF8ZrYqpr90i2w4Rt9Vw8dTHd85QySC1lnTdIdVCzwQdJGL7qfb82C19PSKuuDZRaC5HqNrj5JuHWP0zOQn5m5xy1nWaJIDFdoDfxsBy7jlTAU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719943; c=relaxed/simple;
	bh=HMHhXtHErUM41FQcbLQbteqc0M4Q2bcSNoyiQKozxx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NdaW7/qmkkaTYdzmvEpavOzQilqtZMoLeQaJWRLyi6geftRYPM5T48LT/kpqiSmUNfLLHcRx8j38TK+fVvsz2p23rQlEs/b/+MHESqfxeAXLC4pHFDHEpOI2qNEAbbnGeRDtC2EF1lC1FKNPNpz4SV4W0fpPfBy2fYlmvMKPhcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79339C116B1;
	Thu, 11 Jul 2024 17:45:41 +0000 (UTC)
Date: Thu, 11 Jul 2024 13:47:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jiri Olsa <olsajiri@gmail.com>,
 mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
 oleg@redhat.com, clm@meta.com, paulmck@kernel.org, bpf
 <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <20240711134703.715e6361@gandalf.local.home>
In-Reply-To: <20240711152238.GB3285@noisy.programming.kicks-ass.net>
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
	<20240711152238.GB3285@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 17:22:38 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > +UPROBES
> > +M:	Masami Hiramatsu <mhiramat@kernel.org>
> > +M:	Oleg Nesterov <oleg@redhat.com>
> > +M:	Peter Zijlstra <peterz@infradead.org>
> > +L:	linux-kernel@vger.kernel.org
> > +L:	linux-trace-kernel@vger.kernel.org
> > +S:	Maintained
> > +Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> > +F:	include/linux/uprobes.h
> > +F:	kernel/events/uprobes.c  
> 
> Maybe no Q/T. Neither Oleg nor me have write access to that git tree.
> 
> Also, I think you want:
> 
> F: arch/*/kernel/uprobes.c 
> F: arch/*/kernel/probes/uprobes.c 
> F: arch/*/include/asm/uprobes.h
> 
> 
> This is just to ensure get_maintainers.sh gets our email addresses for
> all uprobes stuff.

Agreed. As those files can go through other trees, it's best not to add
linux-trace.git nor patchwork to MAINTAINERS file. It's just there to make
sure the proper people are Cc'd.

-- Steve

