Return-Path: <bpf+bounces-39627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3DD97571E
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C9D1F2735A
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 15:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF2C1AC448;
	Wed, 11 Sep 2024 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH/lpTL4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166621ABED4;
	Wed, 11 Sep 2024 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068414; cv=none; b=M5lzoNpiZkpuW/s/1A95dF0D7ckQjX3Dp/jEFjbd6VHA18zWQHoZBj0K1oMFvvU7Pu1itct5qcYAnm4HufTIrIWi1UocoBdEVE4iYWTx8Tt8ST6BHwgC+ljqdYEy0IEPF5HDjsCQCh1q5kDmRQjnTOVnmh/mgfgBd9UMkaF05Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068414; c=relaxed/simple;
	bh=nWw70s9b8dLXHpDd6L75h9zUNbMoClpUtYocpuRezvQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PMfAZuRHiO59L84PmxzEoIiOhtBXRpad9e+HJfvy3DmiiAwAaO3wZfP88Rp+xiS47xY51iOs6qpBzB8CGL2ILvlFl/S4gEUeA7yJCL7jgSYLuuZSx9ZXc3suaslz47AAhOszeOIKteIw3pVhXOceI45QA/vrlaSitHQS5VXnrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH/lpTL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42E0C4CEC0;
	Wed, 11 Sep 2024 15:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726068413;
	bh=nWw70s9b8dLXHpDd6L75h9zUNbMoClpUtYocpuRezvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PH/lpTL4rYomKndUbcXQlU4ryesQnDRiSTJL48fsMQVh9NjtY6LCUkoK8E8VfYG/p
	 WTEDCDHQeuifmgkhZMqpr6iNJEW181PBPZEaD3QaPTIxizPUvJbyxZ5sePWR/njth2
	 v+yJ12t0YPTpPifKm3uDHVOiq4HxGMTGQL+dtr+/UxxbLBZAphcB5MJZvTZpVZ3ZlY
	 JQErYWPRdWXFYrcktUiys56QMJA8RP23A/JVxdCH/6lMr6eBD+sB8Kt6Q0/2/wxN7f
	 8TnCAV7yloEp9U+uLMjTLoZXP/5G+yyJ4mt9MCLYr3xzRe+RDUcBh79qP3v+pVPn4Y
	 CDniW4lhboT6g==
Date: Thu, 12 Sep 2024 00:26:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, Linux
 trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh
 <kpsingh@chromium.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Florent Revest
 <revest@chromium.org>, Puranjay Mohan <puranjay@kernel.org>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
Message-Id: <20240912002647.1000516bf87198b343bafcf7@kernel.org>
In-Reply-To: <CAEf4BzY2_HN36Lvy9p2s57tGet3ft_1oT6d690vwu4JMgOd9XA@mail.gmail.com>
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
	<CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
	<20240910145431.20e9d2e5@gandalf.local.home>
	<CAEf4BzZRV6h5nitTyQ_zah6wWMBZD6QQBbTCWyPVzkPpS42sgg@mail.gmail.com>
	<20240911093949.40e65804d0e517a1fa1cba11@kernel.org>
	<CAEf4BzY2_HN36Lvy9p2s57tGet3ft_1oT6d690vwu4JMgOd9XA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 10 Sep 2024 17:44:11 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Tue, Sep 10, 2024 at 5:39 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Tue, 10 Sep 2024 13:29:57 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > > You are probably talking about [0]. But I was asking about [1], i.e.,
> > > adding HAVE_RETHOOK support to ARM64. Despite all your emotions above,
> > > can I still get a meaningful answer as for why that wasn't landed and
> > > what prevents it from landing right now before Masami's 20-patch
> > > series lands?
> >
> > As I replied to your last email, Mark discovered that [1] is incorrect.
> >  From the bpf perspective, it may be fine that struct pt_regs is missing
> >  some architecture-specific registers, but from an API perspective,
> >  it is a problem.
> >
> > Actually kretprobes on arm64 still does not do it correctly, but I also
> > know most of users does not care. So currently I keep it as it is. But
> > after fixing this issue on fprobe. I would like to update kretprobe so
> > that it will use sw-breakpoint to handle it. It will increase the overhead
> > of kretprobe, but it should be replaced by fprobe at that moment.
> 
> Ok, given kretprobes already have this issue, can we add this support
> for BPF multi-kprobe/kretprobe only? We can have an extra Kconfig
> option or whatever necessary. It's sad that we don't have entire
> feature just because a few registers can't be set (and I bet no BPF
> users ever reads those registers from pt_regs). It's not the first,
> nor last case where pt_regs isn't complete (e.g., tracepoints set only
> a few fields in pt_regs, the rest are zero; and that's fine).

pt_regs things are asked by PeterZ. It is not recommended to use pt_regs
if it is not actual pt_regs because user expects it works as full pt_regs.
So I and Steve decided to use ftrace_regs for this faked registers.
(I think tracepoint should also use ftrace_regs or another one.)

Anyway, we're almost at a goal we can all agree on. I think we would better
push fprobe on fgraph series instead of such ad-hoc change.

Thank you,

> 
> >
> > Thank you,
> >
> > >
> > >   [0] https://lore.kernel.org/linux-trace-kernel/172398527264.293426.2050093948411376857.stgit@devnote2/
> > >   [1] https://lore.kernel.org/bpf/164338038439.2429999.17564843625400931820.stgit@devnote2/
> > >
> > > >
> > > > Again, just letting you know.
> > > >
> > > > -- Steve
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

