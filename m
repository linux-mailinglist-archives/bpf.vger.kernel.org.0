Return-Path: <bpf+bounces-32976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29933915B11
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 02:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E45C1C2157C
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28524DDD9;
	Tue, 25 Jun 2024 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+H+4JXH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8817591;
	Tue, 25 Jun 2024 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719275992; cv=none; b=blcnU4Z9bu2fD/yvv3mFAgYly/cEO4Xqqzn5xeiit8vBznA4v8SgyvRzJ9YGaAEzaYUQAaSm83nl7CN2Y4KLXqoaD8AkbAW9YJkALO+YTeXuuYXUPBfAIHSVs9BJIC2/1n+3iA3YsO7G54W3PaQpTPQIuJYDG0hW8LqOw1ftDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719275992; c=relaxed/simple;
	bh=oFL9+b7Ab63zTrAXhoI15K6xtFTGBNznRanhql6FtP8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RMUFexcF5ihaqqeE4c5sxvn6QzYoLuAQIubD+21cQrCJgZHHQPjUyQ8C2IorgdhMlrE/AzVEhoNtNt1FQcBUvh9/PgNM/LsadCmsZHmoLk4AG6RG7DuXJ/ZiSkY+Oo0z9R1G7zqGfOrOyo+s4C/0oQmbZrbUoeRws+tRx7DpM3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+H+4JXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521A9C2BBFC;
	Tue, 25 Jun 2024 00:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719275992;
	bh=oFL9+b7Ab63zTrAXhoI15K6xtFTGBNznRanhql6FtP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o+H+4JXHFlcrfMoUhjstrg4jg9xw/+I1V87yOMlOw+yS2ONRQLNsfhpd4+iKz8piM
	 P+2exlngN1c4O+hyfVzWMNeUkVyfcty1Yb/+QzKma1RVSnMk8iJsFPKVhOXLDL+Blm
	 hZJBeVffrM6B3MrHjHO0wT8lblTiOenhnYUn0p9IWCwQPWdjL+EQD0ROsDcVUuX8Pb
	 vY8KAtSMr3vbXwqj4EeYhGVmnWpJBDdo5vUXXb3JZQRO80+QMyCKaFTX9Yq5RVy+kn
	 pX1Gh7hz07XMF7H3Dbe/mtgEGtw1UGZ3bqcXkL/xJDSLtV5TDziO9TTsxYJ/uD+hyR
	 MET8G78UynWKA==
Date: Tue, 25 Jun 2024 09:39:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, x86@kernel.org, peterz@infradead.org,
 mingo@redhat.com, tglx@linutronix.de, bpf@vger.kernel.org, rihams@fb.com,
 linux-perf-users@vger.kernel.org, Riham Selim <rihams@meta.com>
Subject: Re: [PATCH v2 2/4] perf,uprobes: fix user stack traces in the
 presence of pending uretprobes
Message-Id: <20240625093947.85401db681715219a7c8b8e3@kernel.org>
In-Reply-To: <CAEf4BzbWM0Jd59cadyfhpmV5DC+QAoLTwAfjzT9mt4HkoAeGpA@mail.gmail.com>
References: <20240522013845.1631305-1-andrii@kernel.org>
	<20240522013845.1631305-3-andrii@kernel.org>
	<20240604231314.e924c51f7b9a18428a8a7f0f@kernel.org>
	<CAEf4BzbneP7Zoo5q54eh4=DVgcwPSiZh3=bZk6T2to88613dnw@mail.gmail.com>
	<CAEf4BzY0VWXDo_PUUZmRwfGZc3YfNy4+DDLLPT3+b3m6T57f8w@mail.gmail.com>
	<CAEf4BzbWM0Jd59cadyfhpmV5DC+QAoLTwAfjzT9mt4HkoAeGpA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 24 Jun 2024 13:32:35 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Mon, Jun 17, 2024 at 3:37 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Jun 4, 2024 at 10:16 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Jun 4, 2024 at 7:13 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > On Tue, 21 May 2024 18:38:43 -0700
> > > > Andrii Nakryiko <andrii@kernel.org> wrote:
> > > >
> > > > > When kernel has pending uretprobes installed, it hijacks original user
> > > > > function return address on the stack with a uretprobe trampoline
> > > > > address. There could be multiple such pending uretprobes (either on
> > > > > different user functions or on the same recursive one) at any given
> > > > > time within the same task.
> > > > >
> > > > > This approach interferes with the user stack trace capture logic, which
> > > > > would report suprising addresses (like 0x7fffffffe000) that correspond
> > > > > to a special "[uprobes]" section that kernel installs in the target
> > > > > process address space for uretprobe trampoline code, while logically it
> > > > > should be an address somewhere within the calling function of another
> > > > > traced user function.
> > > > >
> > > > > This is easy to correct for, though. Uprobes subsystem keeps track of
> > > > > pending uretprobes and records original return addresses. This patch is
> > > > > using this to do a post-processing step and restore each trampoline
> > > > > address entries with correct original return address. This is done only
> > > > > if there are pending uretprobes for current task.
> > > > >
> > > > > This is a similar approach to what fprobe/kretprobe infrastructure is
> > > > > doing when capturing kernel stack traces in the presence of pending
> > > > > return probes.
> > > > >
> > > >
> > > > This looks good to me because this trampoline information is only
> > > > managed in uprobes. And it should be provided when unwinding user
> > > > stack.
> > > >
> > > > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > >
> > > > Thank you!
> > >
> > > Great, thanks for reviewing, Masami!
> > >
> > > Would you take this fix through your tree, or where should it be routed to?
> > >
> >
> > Ping! What would you like me to do with this patch set? Should I
> > resend it without patch 3 (the one that tries to guess whether we are
> > at the entry to the function?), or did I manage to convince you that
> > this heuristic is OK, given perf's stack trace capturing logic already
> > makes heavy assumption of rbp register being used for frame pointer?
> >
> > Please let me know your preference, I could drop patch 3 and send it
> > separately, if that helps move the main fix forward. Thanks!
> 
> Masami,
> 
> Another week went by with absolutely no action or reaction from you.
> Is there any way I can help improve the collaboration here?

OK, if there is no change without [3/4], let me pick the others on
probes/for-next directly. [3/4] I need other x86 maintainer's
comments. And it should be handled by PMU maintainers.

Thanks,


> 
> I'm preparing more patches for uprobes and about to submit them. If
> each reviewed and ready to be applied patch set has to sit idle for
> multiple weeks for no good reason, we all will soon be lost just plain
> forgetting the context in which the patch was prepared.
> 
> Please, prioritize handling patches that are meant to be routed
> through your tree in a more timely fashion. Or propose some
> alternative acceptable arrangement.
> 
> Thank you.
> 
> >
> > > >
> > > > > Reported-by: Riham Selim <rihams@meta.com>
> > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > ---
> > > > >  kernel/events/callchain.c | 43 ++++++++++++++++++++++++++++++++++++++-
> > > > >  kernel/events/uprobes.c   |  9 ++++++++
> > > > >  2 files changed, 51 insertions(+), 1 deletion(-)
> > > > >
> > >
> > > [...]


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

