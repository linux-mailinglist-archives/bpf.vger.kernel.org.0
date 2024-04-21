Return-Path: <bpf+bounces-27321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92B58ABE6B
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 04:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66A91C20A1C
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 02:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482274431;
	Sun, 21 Apr 2024 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObFqBZr1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24536C;
	Sun, 21 Apr 2024 02:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713667261; cv=none; b=lFjItgsmk3kFaU6wZaM2m4F4tZgajnj6JZ4Gl/6eEIXdqalocOXCdXFKM5wNxKVN2Mx4txdBpiNwkd0R2gWLFVsJ8FGOMYqGIrJyDwF3ZJCPpPSGi8C/VI6doo8SZBvH2nxRkcNLhX2B0324iYc4GHGZHQHpB4Utjo32dTxyAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713667261; c=relaxed/simple;
	bh=eKFTXERSllwBgJNh3yoEBQ9eO+rzF2j9SfTsRgXU5Fs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aKB1nUc2isMOON0D+XEh8zKXLw+x/43Ob4badio7ydgwsYysNxRPGEErSQlxnUnZdlA0suSSQWBAy3izf5OIMYnUvTTV1kv7kzwJ7Tgxm4fXCMXcc5X3d3DcP5tG1yedsX69EtAxMozGhSCowOVju+oo5BAU63fxIJhQt2l8Y1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObFqBZr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3500DC072AA;
	Sun, 21 Apr 2024 02:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713667261;
	bh=eKFTXERSllwBgJNh3yoEBQ9eO+rzF2j9SfTsRgXU5Fs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ObFqBZr1KZxHJO1L4w7pVipOJOZcnEf7FvQuzq5h5E+IrB4WDkpMD6hh3floo5NwV
	 PMVOneVPs7X2GVbKt7anSU6ZE30SRhx7Yky3+cZK6OvjH/1OTbvC8tpD1gfxpr4xT1
	 ZSYT/QCIrYBbm2zivr+xqbRwD9gttU+TAMlN8EWs2syAfCJthmhlt6HjS9DnTMiGO7
	 4QsGKnGkhS30KxbpchKu6V20NjMjiA8KBo+GhopHauj2nRNcq9GbyP0Q64NGSDzWVr
	 fS0pDKlKfThF8AgSUVqF4sRPbuaibFGDEa53/mInaXpud38Nzzt/fr32i5JJAwzOiC
	 qT+VoEI21yv+w==
Date: Sun, 21 Apr 2024 11:40:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, bpf@vger.kernel.org, jolsa@kernel.org,
 "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 2/2] rethook: honor
 CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING in rethook_try_get()
Message-Id: <20240421114056.a5150b8c9736b390367b38b8@kernel.org>
In-Reply-To: <CAEf4BzbpgaL771QC+uz22R5vpLSO+qeQ7RQbdZzLu7aNn22aug@mail.gmail.com>
References: <20240418190909.704286-1-andrii@kernel.org>
	<20240418190909.704286-2-andrii@kernel.org>
	<20240419100041.87152aa873cbf25e52b8bd4f@kernel.org>
	<CAEf4BzbpgaL771QC+uz22R5vpLSO+qeQ7RQbdZzLu7aNn22aug@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 19 Apr 2024 10:59:09 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Thu, Apr 18, 2024 at 6:00 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Thu, 18 Apr 2024 12:09:09 -0700
> > Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > > Take into account CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING when validating
> > > that RCU is watching when trying to setup rethooko on a function entry.
> > >
> > > One notable exception when we force rcu_is_watching() check is
> > > CONFIG_KPROBE_EVENTS_ON_NOTRACE=y case, in which case kretprobes will use
> > > old-style int3-based workflow instead of relying on ftrace, making RCU
> > > watching check important to validate.
> > >
> > > This further (in addition to improvements in the previous patch)
> > > improves BPF multi-kretprobe (which rely on rethook) runtime throughput
> > > by 2.3%, according to BPF benchmarks ([0]).
> > >
> > >   [0] https://lore.kernel.org/bpf/CAEf4BzauQ2WKMjZdc9s0rBWa01BYbgwHN6aNDXQSHYia47pQ-w@mail.gmail.com/
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> >
> > Thanks for update! This looks good to me.
> 
> Thanks, Masami! Will you take it through your tree, or you'd like to
> route it through bpf-next?

OK, let me take it through linux-trace tree.

Thank you!

> 
> >
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Thanks,
> >
> > > ---
> > >  kernel/trace/rethook.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> > > index fa03094e9e69..a974605ad7a5 100644
> > > --- a/kernel/trace/rethook.c
> > > +++ b/kernel/trace/rethook.c
> > > @@ -166,6 +166,7 @@ struct rethook_node *rethook_try_get(struct rethook *rh)
> > >       if (unlikely(!handler))
> > >               return NULL;
> > >
> > > +#if defined(CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING) || defined(CONFIG_KPROBE_EVENTS_ON_NOTRACE)
> > >       /*
> > >        * This expects the caller will set up a rethook on a function entry.
> > >        * When the function returns, the rethook will eventually be reclaimed
> > > @@ -174,6 +175,7 @@ struct rethook_node *rethook_try_get(struct rethook *rh)
> > >        */
> > >       if (unlikely(!rcu_is_watching()))
> > >               return NULL;
> > > +#endif
> > >
> > >       return (struct rethook_node *)objpool_pop(&rh->pool);
> > >  }
> > > --
> > > 2.43.0
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

