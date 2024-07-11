Return-Path: <bpf+bounces-34574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FECD92EB7D
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 17:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACDD61F24600
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 15:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285A216C6B1;
	Thu, 11 Jul 2024 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJSl9ozq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965602F46;
	Thu, 11 Jul 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711043; cv=none; b=spCUvtFnKJdzs3Xe2pOQ+qT07VEN9gBdeBRZPf8Ln6VaPhodj9TJ/tpk6FbrtkLFhlclKSu3wFCJ11gvztcvAfwKkqNidFG2BkAqTjgQEPl1CFmq1BQv7vPX6ZCiXPTPDuuH54TL689uTc+hv2nKM7FPoYGa+ic9Wfz7fcBauEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711043; c=relaxed/simple;
	bh=9tuPgrGaLzzwSIZwwsq7dFKr4uHlsHjiKC4b/mlictU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=onIe+5ChewYEyrkgj/BRu9AHa35BYMbnZNhIsFaIz8C/BheB0pLgV7DTmt2y9hH0YsSaoJFSVf4lpPjIkSQcKc28l664xgxuTbGZypZpFqw14c43llO9B+AoEiWJJlA9208/OJAdGqLgVXbTjOoTSzPtE6+4TDwFoxcD9lv3Xcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJSl9ozq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741D2C116B1;
	Thu, 11 Jul 2024 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720711043;
	bh=9tuPgrGaLzzwSIZwwsq7dFKr4uHlsHjiKC4b/mlictU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZJSl9ozq5pHkLQ3ukz6dMcWMLs1Mw/OM5QUY3tnRR3vwuHCRYbkdAy4uvo/9wHVsi
	 zzryHvN4xH3wzQwk8I0iZUSLWqsBDzmBhGJZ59xZV4gnxUfsO6H2ypCyTD+fZsYcpA
	 jvuegg0u2DHz32KzdNVmEkYUoIrW+rfsJulDRyTI0BhALeWZyMC7T6Mj3j6Hsf3vPT
	 LhezJBdFCsrcqEwBaWEjnKvTrKa+h6oyYcFKtVFLm/M9q+1OBfHdeHc0sO3TyadSjN
	 ikaFO3aeZ59rszmZQ1gEJwa7dNM9O0jnRbXyUsPeNlnFvyiY+7Jyg3i7ohyyOlqjDO
	 l/z15sDyqQH2A==
Date: Fri, 12 Jul 2024 00:17:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jiri Olsa <olsajiri@gmail.com>, mingo@kernel.org,
 andrii@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 oleg@redhat.com, clm@meta.com, paulmck@kernel.org, bpf
 <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-Id: <20240712001718.e00caa0a3cb410dc19f169c2@kernel.org>
In-Reply-To: <20240711085118.GH4587@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
	<20240709075651.122204f1358f9f78d1e64b62@kernel.org>
	<CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
	<20240709090304.GG27299@noisy.programming.kicks-ass.net>
	<Zo0KX1P8L3Yt4Z8j@krava>
	<20240709101634.GJ27299@noisy.programming.kicks-ass.net>
	<20240710071046.e032ee74903065bddba9a814@kernel.org>
	<20240710101003.GV27299@noisy.programming.kicks-ass.net>
	<20240710235616.5a9142faf152572db62d185c@kernel.org>
	<CAEf4BzZGHGxsqNWSBu3B79ZNEM6EruiqSD4vT-O=_RzsBeKP0w@mail.gmail.com>
	<20240711085118.GH4587@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 11 Jul 2024 10:51:18 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jul 10, 2024 at 11:40:17AM -0700, Andrii Nakryiko wrote:
> > On Wed, Jul 10, 2024 at 7:56 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > On Wed, 10 Jul 2024 12:10:03 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > > On Wed, Jul 10, 2024 at 07:10:46AM +0900, Masami Hiramatsu wrote:
> > > >
> > > > > > FFS :-/ That touches all sorts and doesn't have any perf ack on. Masami
> > > > > > what gives?
> > > > >
> > > > > This is managing *probes and related dynamic trace-events. Those has been
> > > > > moved from tip. Could you also add linux-trace-kernel@vger ML to CC?
> > > >
> > > > ./scripts/get_maintainer.pl -f kernel/events/uprobes.c
> > > >
> > > > disagrees with that, also things like:
> > > >
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/commit/?h=probes/for-next&id=4a365eb8a6d9940e838739935f1ce21f1ec8e33f
> > > >
> > > > touch common perf stuff, and very much would require at least an ack
> > > > from the perf folks.
> > >
> > > Hmm, indeed. I'm OK to pass those patches (except for trace_uprobe things)
> > > to -tip if you can.
> > >
> > > >
> > > > Not cool.
> > >
> > 
> > You were aware of this patch and cc'ed personally (just like
> > linux-perf-users@vger.kernel.org) on all revisions of it. I addressed
> > your concerns in [0], you went silent after that and patches were
> > sitting idle for more than a month.
> 
> Yeah, I remember seeing it. But I was surprised it got applied. If I'm
> tardy -- this can happen, more so of late since I'm still recovering
> from injury and I get far more email than I could hope to process in a
> work day -- please ping.

I also forgot to ping you. I'll ask you next time.

> 
> (also, being 'forced' into using a split keyboard means I'm also
> re-learning how to type, further slowing me down -- training muscle
> memory takes a while)
> 
> Taking patches that touch other trees is fairly common, but in all those
> cases an ACK is 'required'.

OK, should I wait for your Ack for other patches on probes/for-next?

> 
> (also also, I'm not the only maintainer there)
> 
> > But regardless, if you'd like me to do any adjustments, please let me know.
> > 
> >   [0] https://lore.kernel.org/all/CAEf4Bzazi7YMz9n0V46BU7xthQjNdQL_zma5vzgCm_7C-_CvmQ@mail.gmail.com/
> > 
> 
> I'll check, it might be fine, its just the surprise of having it show up
> in some random tree that set me off.
> 
> > > Yeah, the probe things are boundary.
> > > BTW, IMHO, there could be dependency issues on *probes. Those are usually used
> > > by ftrace/perf/bpf, which are managed by different trees. This means a series
> > > can span multiple trees. Mutually reviewing is the solution?
> > >
> > 
> > I agree, there is no one best tree for stuff like this. So as long as
> > relevant people and mailing lists are CC'ed we hopefully should be
> > fine?
> 
> Typically, yeah, that should work just fine.
> 
> But if Masami wants to do uprobes, then it might be prudent to add a
> MAINTAINERS entry for it. 
> 
> A solution might be to add a UPROBES entry and add masami, oleg (if he
> wants) and myself as maintainers -- did I forget anyone? Git seems to
> suggest it's mostly been Oleg carrying this thing.

That sounds good for me. Like this?

From 87dfb9c0e7660e83debd69a0c7e28bc61d214fa8 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Fri, 12 Jul 2024 00:08:30 +0900
Subject: [PATCH] MAINTAINERS: Add uprobes entry

Add uprobes entry to MAINTAINERS and move its maintenance on the linux-trace
tree as same as other probes.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index da5352dbd4f3..7f6285d98b39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23105,6 +23105,18 @@ F:	drivers/mtd/ubi/
 F:	include/linux/mtd/ubi.h
 F:	include/uapi/mtd/ubi-user.h
 
+UPROBES
+M:	Masami Hiramatsu <mhiramat@kernel.org>
+M:	Oleg Nesterov <oleg@redhat.com>
+M:	Peter Zijlstra <peterz@infradead.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-trace-kernel@vger.kernel.org
+S:	Maintained
+Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
+F:	include/linux/uprobes.h
+F:	kernel/events/uprobes.c
+
 USB "USBNET" DRIVER FRAMEWORK
 M:	Oliver Neukum <oneukum@suse.com>
 L:	netdev@vger.kernel.org
-- 
2.34.1


Thanks,
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

