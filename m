Return-Path: <bpf+bounces-63353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1E3B065A7
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 20:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808114E4F7B
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D4729B764;
	Tue, 15 Jul 2025 18:07:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6D425A331;
	Tue, 15 Jul 2025 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752602823; cv=none; b=lp5L34yygScK4hW/44zMzStjXVIhAApLoNipepi0DoHP/Ct61Sx8KCAqeiDyaz1N10BqmIt3dBMETEo4wLMQKipwpoYg5CMhr+L0d7Jtdmn621ZuqLyOPj3YGF/phrewGd5M3S9nBgkW3j6HP9Qx4xABnWoqRN1bCnRcEgMhluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752602823; c=relaxed/simple;
	bh=5Nd/BZjFC2Li564hn2OZyTZ5TLustGBfrx2/SDyIb5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hm2b1L1tajBAVkPAMNqUzcPxOIOyU8vUP3m0MkyD6aY1QfodxIU5ZPu2x1SqT/sRM5urCDD4sU6RAI5u42GYD2Uj42Lr7WXVKBsxsRgRqeHADbWPJuBDq3i14KLN1zOU5R0X2aT/mjeBe1uZ7HA5A6pIVcUC6W2a9qvwvz4iOWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 549D4B60D2;
	Tue, 15 Jul 2025 18:06:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 55F4220030;
	Tue, 15 Jul 2025 18:06:52 +0000 (UTC)
Date: Tue, 15 Jul 2025 14:06:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam
 James <sam@gentoo.org>
Subject: Re: [PATCH v13 10/14] unwind: Clear unwind_mask on exit back to
 user space
Message-ID: <20250715140650.19c0a8ed@batman.local.home>
In-Reply-To: <20250715084932.0563f532@gandalf.local.home>
References: <20250708012239.268642741@kernel.org>
	<20250708012359.345060579@kernel.org>
	<20250715102912.GQ1613200@noisy.programming.kicks-ass.net>
	<20250715084932.0563f532@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tkw4thd6wuqydschzsujxhjydio78djq
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 55F4220030
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+W22gpd5liH0WsFEJMJwLC7+tb+Ymqe0w=
X-HE-Tag: 1752602812-255877
X-HE-Meta: U2FsdGVkX1/wF8yPlKZSr579tDZa3nqKDPA7K+1Dtll+HkqVXeP5n/qP+yvOtBCglUx09YWrk+3CIl/KcSqV2JatAVgBIw0pnQDWXvByfPDfdYLGNU1JXKuQsF8KL3aYl+nn9LuSGxNCl4DXLyQQynfFWhuprEcDZHst2exZ/JR1tshGO+bRKymhmE8EhAfZoXf32IY+RdLzmL+sHIDUfIqbgWanrDoCYwXPoXQoEkYOev81nm5tsKCULJaItOX7QeRtYWRBmZM5fQaa3gYqz85hf+rhFVKtMXJD6bidj2DM0sfQuOIQM12vxAkZ84Z9lmePM1G82TakYsgzm41UUpKBkclzjc8BsZ2ao1gJu+S93BkQaV8OK00X1wNJam8ArMDmMnKggp0L/LaFet3xdQ==

On Tue, 15 Jul 2025 08:49:32 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > >   *
> > > - * Return: 1 if the the callback was already queued.
> > > - *         0 if the callback successfully was queued.
> > > + * Return: 0 if the callback successfully was queued.
> > > + *         UNWIND_ALREADY_PENDING if the the callback was already queued.
> > > + *         UNWIND_ALREADY_EXECUTED if the callback was already called
> > > + *                (and will not be called again)
> > >   *         Negative if there's an error.
> > >   *         @cookie holds the cookie of the first request by any user
> > >   */    
> > 
> > Lots of babbling in the Changelog, but no real elucidation as to why you
> > need this second return value.
> > 
> > AFAICT it serves no real purpose; the users of this function should not
> > care. The only difference is that the unwind reference (your cookie)
> > becomes a backward reference instead of a forward reference. But why
> > would anybody care?  
> 
> Older versions of the code required it. I think I can remove it now.

Ah it is still used in the perf code:

perf_callchain() has:

        if (defer_user) {
                int ret = deferred_request(event);
                if (!ret)
                        local_inc(&event->ctx->nr_no_switch_fast);
                else if (ret < 0)
                        defer_user = false;
        }

Where deferred_requests() is as static function that returns the result
of the unwind request. If it is zero, it means the callback will be
called, if it is greater than zero it means it has already been called,
and negative is an error (and use the old method).

It looks like when the callback is called it expects nr_no_switch_fast
to be incremented and it will decrement it. This is directly from
Josh's patch and I don't know perf well enough to know if that update
to nr_no_switch_fast is needed.

If it's not needed, we can just return 0 on success and negative on
failure. What do you think?

Here's the original patch:

  https://lore.kernel.org/all/20250708020050.928524258@kernel.org/

-- Steve

