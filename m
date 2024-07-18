Return-Path: <bpf+bounces-35006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C649934F63
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 16:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD0A281F69
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FCE142E7C;
	Thu, 18 Jul 2024 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6hpRYqk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AF52AF18;
	Thu, 18 Jul 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314270; cv=none; b=sZSQei/q3uMiInqiYe9sNnR8m3DQQ8AXFIUg3XLX6CcjUbEaqhFoE94p11x0ZQKlzBVm89aJLhH9Ojvn77HVcZtxgFO/hZEYuPNdqf74uts7iEEgZA9HqJBB09YAXMKwc9Lx32SorODCzozbh2RaVetsnRwsNDXyZnGdZPVcHBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314270; c=relaxed/simple;
	bh=lLBG3A1QuOEbS0jmUEWN4SjO5R2yH+XRUdwyFnHY1qU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NoazD/vbWVUbxwFk306XEXdTEQ7bETos6CfmgZZ9mlGxN6a3a157iAYQJeenY8LylbvkfAYZAshcb8Y/YyKKcLWyLW7sWKXkgPavzZ+f7xX4wlUkfdWx4V3kR8WftDtpe6sChNqB4EIJhLM8ktXGbJYdRuKpt8lt3ofkwFTYQKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6hpRYqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8457DC116B1;
	Thu, 18 Jul 2024 14:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721314269;
	bh=lLBG3A1QuOEbS0jmUEWN4SjO5R2yH+XRUdwyFnHY1qU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f6hpRYqkaaewQJStygACAYoldouFs7I231Gg+5oUu15FgmBN0lVBo1hXEls/B823y
	 Kq2KB9UBKiAsddZ9fRE8Tt+N/D4xfeSmW2Os6VhdsD9qE9FmTDWdF2S6xUxqxhM9tk
	 ZZ7U35JoVN6COrHu6uvWS1Yf40KdjN5+XVbc+0UwFLHpC7AoPZCfrl9ufsN6FlkS6/
	 ATMb64sFRQLeVCiugl8PrIAmGC89VH/qHQSg5Vaz0OcICBBMXAbjw5PrnWJuwUmAU7
	 K+c42KIn3jRjxITzKi/I0ELkWKvmu7rvqOAAygYYmJZV6M/HMINCm+GGjUoZ1IM6rS
	 R+OViLyoPEq5A==
Date: Thu, 18 Jul 2024 23:51:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Menglong Dong
 <dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next] bpf: kprobe: remove unused declaring of
 bpf_kprobe_override
Message-Id: <20240718235105.9e132fe9ff5ac147e3c8e3c9@kernel.org>
In-Reply-To: <CADxym3aE3YpbMMYnKBh5voy0YuEjjvafFALGdGMd4-_6ADMKhA@mail.gmail.com>
References: <20240710085939.11520-1-dongml2@chinatelecom.cn>
	<Zo6I47BQlLnNN3R-@krava>
	<20240710231805.868703dc681815bb2257b0ac@kernel.org>
	<CADxym3aE3YpbMMYnKBh5voy0YuEjjvafFALGdGMd4-_6ADMKhA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On Thu, 18 Jul 2024 09:32:13 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> On Wed, Jul 10, 2024 at 10:18 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Wed, 10 Jul 2024 15:13:07 +0200
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > > On Wed, Jul 10, 2024 at 04:59:39PM +0800, Menglong Dong wrote:
> > > > After the commit 66665ad2f102 ("tracing/kprobe: bpf: Compare instruction
> > >
> > > should be in Fixes: tag probably ?
> >
> > Yes, I'll add a Fixed tag.
> >
> 
> Hello!
> 
> Should I send a v2 with the "Fixes" tag? It seems that this commit has
> been pending for a while.

No problem, but wait a bit. I need to send this to 6.11-rc1.

Thank you,


> 
> Thanks!
> Menglong Dong
> 
> > >
> > > > pointer with original one"), "bpf_kprobe_override" is not used anywhere
> > > > anymore, and we can remove it now.
> > > >
> > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > >
> > > lgtm, cc-ing Masami
> > >
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> > Thanks!
> >
> > >
> > > jirka
> > >
> > > > ---
> > > >  include/linux/trace_events.h | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > > > index 9df3e2973626..9435185c10ef 100644
> > > > --- a/include/linux/trace_events.h
> > > > +++ b/include/linux/trace_events.h
> > > > @@ -880,7 +880,6 @@ do {                                                                    \
> > > >  struct perf_event;
> > > >
> > > >  DECLARE_PER_CPU(struct pt_regs, perf_trace_regs);
> > > > -DECLARE_PER_CPU(int, bpf_kprobe_override);
> > > >
> > > >  extern int  perf_trace_init(struct perf_event *event);
> > > >  extern void perf_trace_destroy(struct perf_event *event);
> > > > --
> > > > 2.39.2
> > > >
> > > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

