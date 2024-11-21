Return-Path: <bpf+bounces-45390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E329D50C7
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 17:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41007B268A4
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 16:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08A19F11E;
	Thu, 21 Nov 2024 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G9ZhCyxt"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A990487A7;
	Thu, 21 Nov 2024 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206900; cv=none; b=GedPvzlad8/S8N7s48rsxxZz71Eyriz66D5TiLiGs65RsfIJdt4W84BBsnPntSjesiCmcBiaiSac64x8nxTRX0V96/gsFy9kpJyxOvwsw4bl0IS1ecW/bCkiKiET/EpCk37gjGMMuJe9SPE+Ze9CSlUmSrWddU56F5pYLnf8zWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206900; c=relaxed/simple;
	bh=UCOCpuDtGiAEoDpRAQ4MiCxmyCkKJJWoXhkjNR9iSxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ao7IXLbyROj1Sj1FiZRvXrD9I/h5Hom0CYdMDdndWqqF2mcJMd3yifXjqsyc30wKj+WH3CB4JbQVSPL13W6D08b0Fwc1VeLFHIVh0sA55G8XEvHJys+xkP6Nz9ldUSJKzgLPJdzR9MZ9jXpD9jSQPFqHRJG6F3wGW8QKqyvDIfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G9ZhCyxt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Zn6glNQ9LqdNXzaYMvjZZWLeqs4VnleVv7K8w5ByJZk=; b=G9ZhCyxtW2R/eG6hqwC636fYs2
	iMdk+VVjGlVqsCydFZSz5iEmRFufGCLSpzSl+JGbwp1sO9c+oQtkOW061NUUZS/CeoG+nT2XgRkU8
	pnj/LThaekMcXCtH2KuVidU5ouOAVytIR8MCoZsXNOM9Jq6MFiMs8uvDRRGCM5w3U4HB3gEO2pENR
	fEV6S6tKr3UwQ2K5/oFOG0gb5Gb+7NlnhWEQcVjoehRYjks4BKRdwemSFm5cx2ZBPERRFjA7KUixu
	RuT5rQleR9WhQRZMlOzYDBcP4bHRk+P6PS/LLtr5TE1sC07t4aYAQhvEGlnYL7LizyTXxBXX7AFlI
	9SN509bw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEA8p-00000000bEy-0hpH;
	Thu, 21 Nov 2024 16:34:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4D12730068B; Thu, 21 Nov 2024 17:34:50 +0100 (CET)
Date: Thu, 21 Nov 2024 17:34:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe
 trampolines
Message-ID: <20241121163450.GN24774@noisy.programming.kicks-ass.net>
References: <20241105133405.2703607-6-jolsa@kernel.org>
 <20241105142327.GF10375@noisy.programming.kicks-ass.net>
 <ZypI3n-2wbS3_w5p@krava>
 <CAEf4BzZ4XgSOHz0T5nXPyd+keo=rQvH5jc0Jghw1db0a7qR9GQ@mail.gmail.com>
 <ZzkSKQSrbffwOFvd@krava>
 <CAEf4BzbSrtJWUZUcq-RouwwRxK1GOAwO++aSgjbyQf26cQMfow@mail.gmail.com>
 <20241119091348.GE11903@noisy.programming.kicks-ass.net>
 <CAEf4BzbhDE2B41pULQuTfx0f_-1fn5ugJEdPpweKWZVJetCxrQ@mail.gmail.com>
 <20241121115353.GJ24774@noisy.programming.kicks-ass.net>
 <CAADnVQJJ0WS=Y1EudjiFD8fn4zHCz6x1auaEEHaYHsP15Vks2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJJ0WS=Y1EudjiFD8fn4zHCz6x1auaEEHaYHsP15Vks2Q@mail.gmail.com>

On Thu, Nov 21, 2024 at 08:02:12AM -0800, Alexei Starovoitov wrote:
> On Thu, Nov 21, 2024 at 4:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Nov 20, 2024 at 04:07:38PM -0800, Andrii Nakryiko wrote:
> >
> > > USDTs are meant to be "transparent" to the surrounding code and they
> > > don't mark any clobbered registers. Technically it could be added, but
> > > I'm not a fan of this.
> >
> > Sure. Anyway, another thing to consider is FRED, will all of this still
> > matter once that lands? If FRED gets us INT3 performance close to what
> > SYSCALL has, then all this work will go unused.
> 
> afaik not a single cpu in the datacenter supports FRED while
> uprobe overhead is real.
> imo it's worth improving performance today for existing cpus.

I understand, but OTOH adding a syscall now, that we'll have to maintain
for years and years, even through we know it'll not be used much is a
bit annoying.

> I suspect arm64 might benefit too. Even if arm hw does the same
> amount of work for trap vs syscall the sw overhead of handling
> trap is different.

Well, the RISC CPUs have a much harder time using this, their immediate
range is typically puny and they end up needing multiple instructions
and some register in order to set up a call.

Elsewhere in the thread Mark Rutland already noted that arm64 really
doesn't need or want this.

