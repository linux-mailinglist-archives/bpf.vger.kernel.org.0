Return-Path: <bpf+bounces-69522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1928B98F8E
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 10:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155373A8074
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CB42BFC9B;
	Wed, 24 Sep 2025 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z1GLPm6/"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00DA3FC2;
	Wed, 24 Sep 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703805; cv=none; b=OSSbigFISlwyPwDWpITpfbT+HhcefX1d24gMotkmM2arTS76S6tg+XDtyd/AnC30I87otlE6JDX2UYkSToHde5RTyruLJwd42RyCzSHQqsGkee2pwwCBKc1+oPT2/HPKUyVszwJlAgMMFqAzYVOzaG/u+RMF6xG4xNAGiEiNMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703805; c=relaxed/simple;
	bh=bsmLWcYiAHZSyPjSOOw20xT5FXztSFu/4czDjVsvnA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWFFnPcmSPlkKPzSyQ87itjNY5MbL14Ci2ZK0nimJkDtWaFaJaSaOtI/PQTT+vHQ3fFdCGCNnoG5R3FJtLg3ZYJsgieshJtjm0AVAyhvP0RjxGdj7/sHnnE4AWU41Fw5iPBp5Uk9hSSFV+bj6RRD2R8jCdkf2eUpYgilkIoKbDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z1GLPm6/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YS3z9Qyy+VZhDj43nkM+N+IZO/NYQl/mTzdy8B5TYcc=; b=Z1GLPm6/kKUoa5+mZe7N7JmnsK
	6YbQyPdGjfab1Ji6MNZJQyKARUHxHVNgIS7M40pg2PnGmA2lj1nCCTo+WeqbBXUl5qVpiBOapihWi
	TQ39gnRKqEfgdlqGSB0i5YKrOxMA8yGarbb7kh966GAezqUrbo3+9LYFLZTXqczqNmqxFCMZnBv9y
	yVzAklEAqWnYmu5uA2MlFrbMQsqtOTK7Vnm0y/sFEHYEJRCPy90qEL7w++s2mi8npBROjIN3ZBZQb
	u0lI+VWktW8+qGPuSVXVOOjGO+GWuPyDwTEddVb79dwNyaO68Wt/BTrvrgGwO873fqGe454H6+Uoz
	K5GDKzOg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1LCH-0000000CGzY-3vgC;
	Wed, 24 Sep 2025 08:49:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BD6EF30033D; Wed, 24 Sep 2025 10:49:56 +0200 (CEST)
Date: Wed, 24 Sep 2025 10:49:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCHv4 bpf-next 2/6] uprobe: Do not emulate/sstep original
 instruction when ip is changed
Message-ID: <20250924084956.GW3245006@noisy.programming.kicks-ass.net>
References: <20250916215301.664963-1-jolsa@kernel.org>
 <20250916215301.664963-3-jolsa@kernel.org>
 <CAEf4BzYTJcq=Kk6W9Gz90gM=mw2fS2T-QBurUhdjBNinReDSjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYTJcq=Kk6W9Gz90gM=mw2fS2T-QBurUhdjBNinReDSjQ@mail.gmail.com>

On Tue, Sep 16, 2025 at 03:28:52PM -0700, Andrii Nakryiko wrote:
> On Tue, Sep 16, 2025 at 2:53 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > If uprobe handler changes instruction pointer we still execute single
> > step) or emulate the original instruction and increment the (new) ip
> > with its length.
> >
> > This makes the new instruction pointer bogus and application will
> > likely crash on illegal instruction execution.
> >
> > If user decided to take execution elsewhere, it makes little sense
> > to execute the original instruction, so let's skip it.
> >
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/events/uprobes.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 7ca1940607bd..2b32c32bcb77 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2741,6 +2741,13 @@ static void handle_swbp(struct pt_regs *regs)
> >
> >         handler_chain(uprobe, regs);
> >
> > +       /*
> > +        * If user decided to take execution elsewhere, it makes little sense
> > +        * to execute the original instruction, so let's skip it.
> > +        */
> > +       if (instruction_pointer(regs) != bp_vaddr)
> > +               goto out;
> > +
> 
> Peter, Ingo,
> 
> Are you guys ok with us routing this through the bpf-next tree? We'll
> have a tiny conflict because in perf/core branch there is
> arch_uprobe_optimize() call added after handler_chain(), so git merge
> will be a bit confused, probably. But it should be trivially
> resolvable.

Nah, I suppose that'll be fine. Thanks!

