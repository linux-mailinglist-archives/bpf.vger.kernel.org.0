Return-Path: <bpf+bounces-36625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BDF94B24C
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 23:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F5C1C20B7F
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 21:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A95154C19;
	Wed,  7 Aug 2024 21:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVKkwnSq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C77153BE4;
	Wed,  7 Aug 2024 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067039; cv=none; b=IGApIfhIh7APBBRFuR+BgMUs49OH3HxIfwXdG0OYOcGpzUtJ6mNFNcHkKFnFEBQkGOeyeupBhARw3sNf/lW/KLjxmLg7eEEDuCbyFi4fhpNCMv7wzoV3OgzChAxtGst2+hvnTXamjAA5hRRPKX1xcN3iYDUi++A0S3+Iozwt7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067039; c=relaxed/simple;
	bh=6RYRCXp3tJXW+jHyCgJ5i8XLYq6reLmVdAIigIAsnpQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JFRgg8JNFGB3dKZ7Qdbt8KrdCnhvwHFWv/9bLaE+tiL4E8ENdm5L574YbNYGTS2fGELQR680L94RzRrj2WuMHUt85pLY6NA6rtnKz5hSQvCNFm3Iqt9Js0/5y77Q6WDVRWWYQqFwgJF3OnE7WxQPHMkpbHq1XeVeWHcQSP4wN7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVKkwnSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C697EC32781;
	Wed,  7 Aug 2024 21:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723067038;
	bh=6RYRCXp3tJXW+jHyCgJ5i8XLYq6reLmVdAIigIAsnpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TVKkwnSqhiL/ZC4W7Lv5btmc7UDVlTEAJn+PaJOB+eJiGPyhploOr4XVUKcblWpQP
	 DEG+OuIw39QXYKCLrls/pCuCytSOGdgl5/Jwhn504mOhYWI+R418MtbTrwgx3RZ0UM
	 bS04EGHhNXOZl6tByOnbkhBvk7p54E8bAuHbXq0GHBGHFJyGS1eB39+mzvoQhZGb6Q
	 EX7rT/EXbuxGdE0Iq9AQ1aEOyaCdiUpOtsZEW7FBm+k8XjP9WgMtAAriDm5ef+rqDh
	 AxQLjV9ak817yT4rxPjXPM74l5orkBRohNE84CipC5ZlzmtLMgPqCU5IBe+C3Tzzbg
	 nnv+iL3LAt73g==
Date: Thu, 8 Aug 2024 06:43:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, peterz@infradead.org, oleg@redhat.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: get rid of bogus trace_uprobe hit counter
Message-Id: <20240808064353.7470f6bfab89bd28dbcdebe0@kernel.org>
In-Reply-To: <CAEf4Bzaq86fPVGWtXqvxLtbsk06coGBebnAO5YiuvuUF2v7++w@mail.gmail.com>
References: <20240805202803.1813090-1-andrii@kernel.org>
	<ZrHSts7eySxHs4wh@krava>
	<CAEf4Bzaq86fPVGWtXqvxLtbsk06coGBebnAO5YiuvuUF2v7++w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 6 Aug 2024 10:26:25 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Tue, Aug 6, 2024 at 12:37 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Aug 05, 2024 at 01:28:03PM -0700, Andrii Nakryiko wrote:
> > > trace_uprobe->nhit counter is not incremented atomically, so its value
> > > is bogus in practice. On the other hand, it's actually a pretty big
> > > uprobe scalability problem due to heavy cache line bouncing between CPUs
> > > triggering the same uprobe.
> >
> > so you're seeing that in the benchmark, right? I'm curious how bad
> > the numbers are
> >
> 
> Yes. So, once we get rid of all the uprobe/uretprobe/mm locks (ongoing
> work), this one was the last limiter to linear scalability.
> 
> With this counter, I was topping out at about 12 mln/s uprobe
> triggering (I think it was 32 CPUs, but I don't remember exactly now).
> About 30% of CPU cycles were spent in this increment.
> 
> But those 30% don't paint the full picture. Once the counter is
> removed, the same uprobe throughput jumps to 62 mln/s or so. So we
> definitely have to do something about it.
> 
> > >
> > > Drop it and emit obviously unrealistic value in its stead in
> > > uporbe_profiler seq file.
> > >
> > > The alternative would be allocating per-CPU counter, but I'm not sure
> > > it's justified.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/trace/trace_uprobe.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > > index 52e76a73fa7c..5d38207db479 100644
> > > --- a/kernel/trace/trace_uprobe.c
> > > +++ b/kernel/trace/trace_uprobe.c
> > > @@ -62,7 +62,6 @@ struct trace_uprobe {
> > >       struct uprobe                   *uprobe;
> > >       unsigned long                   offset;
> > >       unsigned long                   ref_ctr_offset;
> > > -     unsigned long                   nhit;
> > >       struct trace_probe              tp;
> > >  };
> > >
> > > @@ -821,7 +820,7 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
> > >
> > >       tu = to_trace_uprobe(ev);
> > >       seq_printf(m, "  %s %-44s %15lu\n", tu->filename,
> > > -                     trace_probe_name(&tu->tp), tu->nhit);
> > > +                trace_probe_name(&tu->tp), ULONG_MAX);
> >
> > seems harsh.. would it be that bad to create per cpu counter for that?
> 
> Well, consider this patch a conversation starter. There are two
> reasons why I'm removing the counter instead of doing per-CPU one:
> 
>   - it's less work to send out a patch pointing out the problem (but
> the solution might change)
>   - this counter was never correct in the presence of multiple
> threads, so I'm not sure how useful it is.
> 
> Yes, I think we can do per-CPU counters, but do we want to pay the
> memory price? That's what I want to get from Masami, Steven, or Peter
> (whoever cares enough).

I would like to make it per-cpu counter *and* make it kconfig optional.
Or just remove with the file (but it changes the user interface without
option).

For the kprobes, the profile file is useful because it shows "missed"
counter. This tells user whether your trace data drops some events or not.
But if uprobes profile only shows the number of hit, we can use the
histogram trigger if needed.

Thank you,

> 
> >
> > jirka
> >
> > >       return 0;
> > >  }
> > >
> > > @@ -1507,7 +1506,6 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
> > >       int ret = 0;
> > >
> > >       tu = container_of(con, struct trace_uprobe, consumer);
> > > -     tu->nhit++;
> > >
> > >       udd.tu = tu;
> > >       udd.bp_addr = instruction_pointer(regs);
> > > --
> > > 2.43.5
> > >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

