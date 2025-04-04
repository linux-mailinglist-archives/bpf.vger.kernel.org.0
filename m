Return-Path: <bpf+bounces-55315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BFAA7B8FB
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 10:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C148C3B6310
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 08:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37990199FB0;
	Fri,  4 Apr 2025 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtofxsJ5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF70B17A305;
	Fri,  4 Apr 2025 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755804; cv=none; b=hEIr8L6GHusA3hQuXAUNRSWBc4+PzZF0e9u0E9Y0xehRlw0GLu3OrINszleUOiX00cezb5Hpke3EkllSuZTGfCnroqGR0jnJFTKgYCWd6WmSCzDq3Ua442VFqG4wTFSkX9cV8EAttsnbmOlDtjt0NDC7DZGhlpwYFwn5jTbY4bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755804; c=relaxed/simple;
	bh=VTfhpIHcF6m/bQCKrSzeEFziB0k07MobSdEDyrf259k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYcEX5EHdHPEltNE7VXbhq8spDHIqZcyXlIG/dbYHhk/psygx8m55Ce4v12XuehaJjvPC6Nk832i19akPZgFL99B0AsPD2CfFtjficyNeY5QfMKlYMyeIrvKoTNOOx7+0vGCBb9yrm2xtDtlu2rmWuG10E1R6ZNO2bHVTmhCf0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtofxsJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B854C4CEDD;
	Fri,  4 Apr 2025 08:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743755804;
	bh=VTfhpIHcF6m/bQCKrSzeEFziB0k07MobSdEDyrf259k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AtofxsJ5r9dHvM9LnkHomR8DcDOnHrvmFU/KtG1qZ7eA5mr8+Cwjpxf5rb8l5aTxM
	 yYQAgTL4f5nrx717/m+TLJLqPnQ5CgH6kxpvVl4ktt1EG62BupzReXdKnXOaKnXjT8
	 OPQ2uI8p+OZ/xWpumu4eFv6BIac6/lRikcAPlkhUWhVzRiEqQoeEjxLD4yY1KLoSna
	 /MXtIAdO72kitl5g6AKpNfkmFkzbFoXBsiOpzQzhXGhoBT9O7LPFLbR6bFVpc7DHoY
	 PGCz+3yaAyK9r0kBCDbIqOWt/CVlhpeDe/c9AVqj9WwgrXt6E4WUQ9QVWQsACKTwf8
	 b0IK8VBZxrVuQ==
Date: Fri, 4 Apr 2025 10:36:38 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org, oleg@redhat.com,
	mhiramat@kernel.org, ast@kernel.org
Subject: Re: [PATCH tip/perf] uprobes: avoid false lockdep splat in uprobe
 timer callback
Message-ID: <Z--aFoGN4Pm9cx8J@gmail.com>
References: <20250403171831.3803479-1-andrii@kernel.org>
 <20250403174917.OLHfwBp-@linutronix.de>
 <CAEf4BzasxUn+Ywi-=TtP+S+i4VBLnKvYCkxPCz63o4zEXT9QZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzasxUn+Ywi-=TtP+S+i4VBLnKvYCkxPCz63o4zEXT9QZw@mail.gmail.com>


* Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Thu, Apr 3, 2025 at 10:49 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2025-04-03 10:18:31 [-0700], Andrii Nakryiko wrote:
> > > Avoid a false-positive lockdep warning in PREEMPT_RT configuration when
> > > using write_seqcount_begin() in uprobe timer callback by using
> > > raw_write_* APIs. Uprobe's use of timer callback is guaranteed to not
> > > race with itself, and as such seqcount's insistence on having hardirqs
> > preemption, not hardirqs
> >
> > > disabled on the writer side is irrelevant. So switch to raw_ variants of
> > > seqcount API instead of disabling hardirqs unnecessarily.
> > >
> > > Also, point out in the comments more explicitly why we use seqcount
> > > despite our reader side being rather simple and never retrying. We favor
> > > well-maintained kernel primitive in favor of open-coding our own memory
> > > barriers.
> >
> > Thank you.
> >
> > > Link: https://lore.kernel.org/bpf/CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com/
> > > Reported-by: Alexei Starovoitov <ast@kernel.org>
> > > Suggested-by: Sebastian Sewior <bigeasy@linutronix.de>
> > > Fixes: 8622e45b5da1 ("uprobes: Reuse return_instances between multiple uretprobes within task")
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/events/uprobes.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 70c84b9d7be3..6d7e7da0fbbc 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -1944,6 +1944,9 @@ static void free_ret_instance(struct uprobe_task *utask,
> > >        * to-be-reused return instances for future uretprobes. If ri_timer()
> > >        * happens to be running right now, though, we fallback to safety and
> > >        * just perform RCU-delated freeing of ri.
> > > +      * Admittedly, this is a rather simple use of seqcount, but it nicely
> > > +      * abstracts away all the necessary memory barriers, so we use
> > > +      * a well-supported kernel primitive here.
> > >        */
> > >       if (raw_seqcount_try_begin(&utask->ri_seqcount, seq)) {
> > >               /* immediate reuse of ri without RCU GP is OK */
> > > @@ -2004,12 +2007,18 @@ static void ri_timer(struct timer_list *timer)
> > >       /* RCU protects return_instance from freeing. */
> > >       guard(rcu)();
> > >
> > > -     write_seqcount_begin(&utask->ri_seqcount);
> >
> > > +     /* See free_ret_instance() for notes on seqcount use.
> >
> > This is not a proper multi line comment.
> 
> yep, will fix; no, uprobe is not networking, this style is just
> ingrained in my brain from working in BPF code base for a while

... and this example underlines why we've been asking the networking 
folks for years to use the standard Linux kernel coding style for 
comments, instead of creating this pointless noise & inconsistency.

Thanks,

	Ingo

