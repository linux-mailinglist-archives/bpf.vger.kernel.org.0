Return-Path: <bpf+bounces-34814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A3D931303
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 13:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D8B1C215C8
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 11:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E28E1891AE;
	Mon, 15 Jul 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pkDMsIrS"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5230218732B;
	Mon, 15 Jul 2024 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042710; cv=none; b=rNDHl6hsTubtKgS5bzWs+KTpvIe1b+EN8+RvniEXHmZiWSmx8eIiiLHiZUTCH7EciAPhbL8THNER+mFxvzxTWwddHy4jbLVQC0almV+b8Bo7Dx+wy1JzYbO0KJt1ZtK6w8jP2KWPms9hw3qWzFmkr6Xavm7kQXmdCtox/kPXuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042710; c=relaxed/simple;
	bh=PU6heb083DO9pyHUxuV6z2+EoTfM9IExe2kcCIHR/yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5WxoS/dHGetSlWL8XZ8IZhyWXoV8lKW0dtoLUTajhIr4l738FC2ua0ImfRwcv0hRg2IzDc/CYK8lvJV320jVW3KURFMmNhmeMjbm7GNESQZOXFlS8koPwp8t1l3d3ifcMom4FHudRyt52XBr/ZA6b36v2bBgGFD8N/8BqUw+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pkDMsIrS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=w8PXDLltAFjw5n3aoL+clMKuIuqFeLfWcdi6geM4hp0=; b=pkDMsIrS5KJZN65XUaAW8DE0aS
	u+YFD0M12x9ASk62JkDdGAtKBUcEaCCtbWAiLrn+ljHUQMm5jM6ZhZWDa4HI3O1N/Hu9NZ1rmjXe7
	ssm5zVKgF8OK+qzqEWYBB4QfXDzq2hQ2uJA/qtsjgsGBpdXdHolEv2C3UQ5wPXDvaubpfb6kXFFD5
	Xz+SZNSBBelhkvR/BfE0z1+ZSKdsw4wskOKiOqQuyjteC7sFH/Q/Yr4bUxFc4ih6+3YbC3u6VZMdM
	OHjhVBPMkCGPaRDvHMRJVTabdSBCM1NQ/rqyk+0Yj98piwHp0nQfxNi4NWE7pmxpIvdW6lR1PqRLV
	9M7jqpzQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTJpI-00000001mRi-30pu;
	Mon, 15 Jul 2024 11:25:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5BC3C3003FF; Mon, 15 Jul 2024 13:25:04 +0200 (CEST)
Date: Mon, 15 Jul 2024 13:25:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: mingo@kernel.org, andrii@kernel.org, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 06/11] perf/uprobe: SRCU-ify uprobe->consumer list
Message-ID: <20240715112504.GD14400@noisy.programming.kicks-ass.net>
References: <20240711110235.098009979@infradead.org>
 <20240711110400.880800153@infradead.org>
 <CAEf4BzZUVe-dQNcb1VQbEcN4kBFOYrFOB537q4Vhtpm_ebL9aQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZUVe-dQNcb1VQbEcN4kBFOYrFOB537q4Vhtpm_ebL9aQ@mail.gmail.com>

On Fri, Jul 12, 2024 at 02:06:08PM -0700, Andrii Nakryiko wrote:
> + bpf@vger, please cc bpf ML for the next revision, these changes are
> very relevant there as well, thanks
> 
> On Thu, Jul 11, 2024 at 4:07 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > With handle_swbp() hitting concurrently on (all) CPUs the
> > uprobe->register_rwsem can get very contended. Add an SRCU instance to
> > cover the consumer list and consumer lifetime.
> >
> > Since the consumer are externally embedded structures, unregister will
> > have to suffer a synchronize_srcu().
> >
> > A notably complication is the UPROBE_HANDLER_REMOVE logic which can
> > race against uprobe_register() such that it might want to remove a
> > freshly installer handler that didn't get called. In order to close
> > this hole, a seqcount is added. With that, the removal path can tell
> > if anything changed and bail out of the removal.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/events/uprobes.c |   60 ++++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 50 insertions(+), 10 deletions(-)
> >
> 
> [...]
> 
> > @@ -800,7 +808,7 @@ static bool consumer_del(struct uprobe *
> >         down_write(&uprobe->consumer_rwsem);
> >         for (con = &uprobe->consumers; *con; con = &(*con)->next) {
> >                 if (*con == uc) {
> > -                       *con = uc->next;
> > +                       WRITE_ONCE(*con, uc->next);
> 
> I have a dumb and mechanical question.
> 
> Above in consumer_add() you are doing WRITE_ONCE() for uc->next
> assignment, but rcu_assign_pointer() for uprobe->consumers. Here, you
> are doing WRITE_ONCE() for the same operation, if it so happens that
> uc == *con == uprobe->consumers. So is rcu_assign_pointer() necessary
> in consumer_addr()? If yes, we should have it here as well, no? And if
> not, why bother with it in consumer_add()?

add is a publish and needs to ensure all stores to the object are
ordered before the object is linked in. Note that rcu_assign_pointer()
is basically a fancy way of writing smp_store_release().

del otoh does not publish, it removes and doesn't need ordering.

It does however need to ensure the pointer write itself isn't torn. That
is, without the WRITE_ONCE() the compiler is free to do byte stores in
order to update the 8 byte pointer value (assuming 64bit). This is
pretty dumb, but very much permitted by C and also utterly fatal in the
case where an RCU iteration comes by and reads a half-half pointer
value.

> >                         ret = true;
> >                         break;
> >                 }
> > @@ -1139,9 +1147,13 @@ void uprobe_unregister(struct inode *ino
> >                 return;
> >
> >         down_write(&uprobe->register_rwsem);
> > +       raw_write_seqcount_begin(&uprobe->register_seq);
> >         __uprobe_unregister(uprobe, uc);
> > +       raw_write_seqcount_end(&uprobe->register_seq);
> >         up_write(&uprobe->register_rwsem);
> >         put_uprobe(uprobe);
> > +
> > +       synchronize_srcu(&uprobes_srcu);
> >  }
> >  EXPORT_SYMBOL_GPL(uprobe_unregister);
> 
> [...]

