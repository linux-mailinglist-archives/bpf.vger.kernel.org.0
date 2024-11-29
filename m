Return-Path: <bpf+bounces-45869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 789FE9DC33C
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 13:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF1F7B21B3A
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE87219B5A9;
	Fri, 29 Nov 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LIC54FVV"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D8F19CD0B;
	Fri, 29 Nov 2024 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732882196; cv=none; b=kAwG+rqz7p1d5XWvJV4+aykLFDyC3+scy6KQfK2Dr0cAi1KlIo02KFwVky+eKOFIsUjqPPtBLXg087Cfkg8OvQW9vRnpJ6E5bSfRAxMJTG2DY3JlQ8R/Kq/8d4z7xkl1331++x1DDwCgdndpu2tRD/1UKV9oXV407Mnw4bdqPQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732882196; c=relaxed/simple;
	bh=jAJdSp15+3ttSJ3dw0H0gS0lYJCcfjp4txGBVJvg2VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEm7619t9u4mvs9uQewQDP+lmpTghNUJeW/NfyhoOj1se+UNo8lLZxO68GGIu7yABdbCidkQxfH5wYD8whFkEOoqOqkyGedFP1mHeKuLsCViUFlSfU4ZY4K6gHrcwTcCSNaSHpS3y+ZMowMuCs4emai7l3AVMw7cppdWixnBkZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LIC54FVV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bcF2+uKv+THIH1HdaMT8XOaR+gAw7l3df+j7RVgj46g=; b=LIC54FVVsAQLuUlBTptoz80eFn
	MSRfSt+dFjzI6lE0IxP4+eO3AfNIPWaPx+KRxNT8QxQRrAANmNBj2pxnj3lVxl+Hg8Dr3tFldMqx2
	9j8BZBF5GI6L+9YcDR3YSJxRbPfyTzaIksLpIJ3b7TykGXFGuwaT6Cyo+8lMBhezwpj0E5htokGpA
	QtrEVISprtDXxdtjyG+h4BIoYdQv5mbPn0RqVVm1NdVIfOhJH+Nt9uL6McT3OIXeRjrkjndUappFX
	4NAC7yxUvnKePBDWqfOX/o6IAy+0So6n+Us+PCVkbbYU1hAvuhQ9jxZVXRHX5WsOZtNkLrg99Bypj
	RXXlSLPA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGzoa-00000001je5-2qlb;
	Fri, 29 Nov 2024 12:09:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DBAC830026A; Fri, 29 Nov 2024 13:09:39 +0100 (CET)
Date: Fri, 29 Nov 2024 13:09:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ruan Bonan <bonan.ruan@u.nus.edu>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"will@kernel.org" <will@kernel.org>,
	"longman@redhat.com" <longman@redhat.com>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>,
	"mattbobrowski@google.com" <mattbobrowski@google.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>,
	"song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Fu Yeqi <e1374359@u.nus.edu>, akinobu.mita@gmail.com, tytso@mit.edu,
	Jason@zx2c4.com
Subject: Re: [BUG] possible deadlock in __schedule (with reproducer available)
Message-ID: <20241129120939.GG35539@noisy.programming.kicks-ass.net>
References: <24481522-69BF-4CE7-A05D-1E7398400D80@u.nus.edu>
 <20241129173554.11e3b2b2f5126c2b72c6a78e@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129173554.11e3b2b2f5126c2b72c6a78e@kernel.org>

On Fri, Nov 29, 2024 at 05:35:54PM +0900, Masami Hiramatsu wrote:
> On Sat, 23 Nov 2024 03:39:45 +0000
> Ruan Bonan <bonan.ruan@u.nus.edu> wrote:
> 
> > 
> >        vprintk_emit+0x414/0xb90 kernel/printk/printk.c:2406
> >        _printk+0x7a/0xa0 kernel/printk/printk.c:2432
> >        fail_dump lib/fault-inject.c:46 [inline]
> >        should_fail_ex+0x3be/0x570 lib/fault-inject.c:154
> >        strncpy_from_user+0x36/0x230 lib/strncpy_from_user.c:118
> >        strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
> >        bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:215 [inline]
> >        ____bpf_probe_read_user_str kernel/trace/bpf_trace.c:224 [inline]
> 
> Hmm, this is a combination issue of BPF and fault injection.
> 
> static void fail_dump(struct fault_attr *attr)
> {
>         if (attr->verbose > 0 && __ratelimit(&attr->ratelimit_state)) {
>                 printk(KERN_NOTICE "FAULT_INJECTION: forcing a failure.\n"
>                        "name %pd, interval %lu, probability %lu, "
>                        "space %d, times %d\n", attr->dname,
>                        attr->interval, attr->probability,
>                        atomic_read(&attr->space),
>                        atomic_read(&attr->times));
> 
> This printk() acquires console lock under rq->lock has been acquired.
> 
> This can happen if we use fault injection and trace event too because
> the fault injection caused printk warning.

Ah indeed. Same difference though, if you don't know the context, most
things are unsafe to do.

> I think this should be a bug of the fault injection, not tracing/BPF.
> And to solve this issue, we may be able to check the context and if
> it is tracing/NMI etc, fault injection should NOT make it failure.

Well, it should be okay to cause the failure, but it must be very
careful how it goes about doing that. Tripping printk() definitely is
out.

But there's a much bigger problem there, get_random*() is not wait-free,
in fact it takes a spinlock_t which makes that it is unusable from most
context, and it's definitely out for tracing.

Notably, this spinlock_t makes that it is unsafe to use from anything
that holds a raw_spinlock_t or is from hardirq context, or has
preempt_disable() -- which is a TON of code.

On this alone I would currently label the whole of fault-injection
broken. The should_fail() call itself is unsafe where many of its
callsites are otherwise perfectly fine -- eg. usercopy per the above.

Perhaps it should use a simple PRNG, a simple LFSR should be plenty good
enough to provide failure conditions.

And yeah, I would just completely rip out the printk. Trying to figure
out where and when it's safe to call printk() is non-trivial and just
not worth the effort imo.

