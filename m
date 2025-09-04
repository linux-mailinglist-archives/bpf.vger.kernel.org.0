Return-Path: <bpf+bounces-67503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFCBB447C1
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB945A1F8C
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 20:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77272882A1;
	Thu,  4 Sep 2025 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H3Xl6pC/"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED92286433;
	Thu,  4 Sep 2025 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757019153; cv=none; b=Rn8ciQi/KXikAD/OmQUnYKKT1Q3FFn32ic4tocf0O1seGVlG/Ces7/SF5fl4hceb4ZpabhwiVwUXwfCrgeYUbnbjKvy/wpmCuJ3xzyOBQ5rGBBIhM3oRRW7c6NBe5TD4Q5JTGufGQtTFrCeZt14xOQ+LdXn449OSqNdAKmCpeFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757019153; c=relaxed/simple;
	bh=3lUVBgg/kWwURX6v3PMIdV7uR18An5Ib4m2797p+Uf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSjNS0J/GX9qGVf9VsVX4QA5UuREYgLGEJ878y1bbU1jmDIXoH39f62HFZLwyj8XWzXP+fW5UWvEr9FgWl7BxktVT1FuNdQZYbmSFVrB+hFqvSXATHRL8+UzFINa20zhZKuHUwS6KYdIWINbrMybOiqVJ0Ixais6PjTtNQSsFm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H3Xl6pC/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Zzsg6pYUBT0eIBQxzcjd+VfUK6eOdYXPPnSdRguLLFY=; b=H3Xl6pC/jn93I6QVoggXqeoTnx
	iPy077+s088Q/PXPpkwQ82G28q1gHFnPhQCh0mdySjwLEiN/AlndgVLShmTGOfdrP3y42X3rDEtfX
	cXWx78rkYJNW6CbaOAC5MFfsoWyHoxa5FdUkRF074QacKHnGDf6pCPHb4l9jJ+PeN14A7JLifnAso
	wwXu0WUYX4RPm6B0hs7g3p34OpDfRrOKWlkXhlapMy0DfIGBEMb1+vgYarz0br7iQrIN6Dld82+7G
	TP5twayBZO5iKO+8P2C5NlGYkOKt4As1kggJR5R5gMpyll0a3Ln9JZk9gic+hQjjN7fNpfE1b2ulM
	SSeBjWNQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuGwE-00000004Puf-3FUv;
	Thu, 04 Sep 2025 20:52:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4D77D300220; Thu, 04 Sep 2025 22:52:10 +0200 (CEST)
Date: Thu, 4 Sep 2025 22:52:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	X86 ML <x86@kernel.org>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: nop5-optimized USDTs WAS: Re: [PATCHv6 perf/core 09/22]
 uprobes/x86: Add uprobe syscall to speed up uprobe
Message-ID: <20250904205210.GQ3245006@noisy.programming.kicks-ass.net>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLlKJWRs5etuvFuK@krava>
 <CAEf4BzYUyOP_ziQjXshVeKmiocLjtWH+8LVHSaFNN1p=sp2rNg@mail.gmail.com>
 <20250904203511.GB4067720@noisy.programming.kicks-ass.net>
 <CAEf4BzZ6xSc7cFy7rF=G2+gPAfK+5cvZ0eDhnd5eP5m1t9EK-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ6xSc7cFy7rF=G2+gPAfK+5cvZ0eDhnd5eP5m1t9EK-A@mail.gmail.com>

On Thu, Sep 04, 2025 at 01:49:49PM -0700, Andrii Nakryiko wrote:
> On Thu, Sep 4, 2025 at 1:35 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Sep 04, 2025 at 11:27:45AM -0700, Andrii Nakryiko wrote:
> >
> > > > > So I've been thinking what's the simplest and most reliable way to
> > > > > feature-detect support for this sys_uprobe (e.g., for libbpf to know
> > > > > whether we should attach at nop5 vs nop1), and clearly that would be
> > > >
> > > > wrt nop5/nop1.. so the idea is to have USDT macro emit both nop1,nop5
> > > > and store some info about that in the usdt's elf note, right?
> >
> > Wait, what? You're doing to emit 6 bytes and two nops? Why? Surely the
> > old kernel can INT3 on top of a NOP5?
> >
> 
> Yes it can, but it's 2x slower in terms of uprobe triggering compared
> to nop1. 

Why? That doesn't really make sense.

I realize its probably to late to fix the old kernel not to be stupid --
this must be something stupid, right? But now I need to know.

