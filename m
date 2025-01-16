Return-Path: <bpf+bounces-49117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C55A1440F
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 22:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB2916B5C4
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FA31DE88D;
	Thu, 16 Jan 2025 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OOD2S1pE"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE6B1862;
	Thu, 16 Jan 2025 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063501; cv=none; b=kzDIpUBs3UvSviVb0TN4gZceg4gi3DLsDwSvrOhFTi5k5BSwT9254p8Zrb/NgjuDuJV3J5vPHca3pcU4QNxDZPff44BIK6Q0a04BqlLkUhn7Hc0AE4cTE4o8XORbCfuJJUl0XmmswbISlzjaMl4l/9ZFwVCFpWXBoVU7cVodwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063501; c=relaxed/simple;
	bh=zgk9DRVPBdMbV1NlpPTG0nFxpD/SEFZUqzUWlgFLQGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfeFXwMaOUYGsj5JMwmJAAlkb/DjkwGiebunc7RjGBMgXkzrupUb3PwnQOlUSbHCBJpdUbhUl1jvlB/oAyRz0FYLEn5OXFlpHiZjxrj8GoeEDAJjr5fSYZFDxgUPg60MJ0ufn0S16pNdtA/uTceA0LS0APC00rMLnluUyR+kA5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OOD2S1pE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=E2YYLz/on8UkqxKNCOmfkESkbeHHVNi9Qiq47EiWsgk=; b=OOD2S1pE3lX8o+W7vxSJYds/cR
	U6MwX1Ncq59yecLIDgNS1jc+oBQADocQwC8XUs2XYOS+tFKbXNh+nBoiijg1KTGp+SAjVTuVg72MG
	NV7oNrZ+SWyvqBRzD4GQ+LUnw0hIRwLPiutR4942efskzBgfh/gMjtK7LurMDJGsw1vDDhgILufoY
	2K00K61y5IusTergXPXUqc2vEJYOBMRJIbGys/V8/tFpRKvg834DpwNtiA+VMyLTT7L3TMlndElRZ
	iXfrIl55Lz1CIQWrSnKV5lRjMoSgohj6dd8CI8Ir8QLEu2wbfNjG0SNFxskB9nye4yYpM0/onGiPm
	TJ5od8ZQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tYXZ0-00000002t7M-2PH2;
	Thu, 16 Jan 2025 21:38:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B18F5300777; Thu, 16 Jan 2025 22:38:05 +0100 (CET)
Date: Thu, 16 Jan 2025 22:38:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH rcu 13/17] srcu: Add SRCU-fast readers
Message-ID: <20250116213805.GC7232@noisy.programming.kicks-ass.net>
References: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
 <20250116202112.3783327-13-paulmck@kernel.org>
 <CAADnVQ+fz7DQ9O=4F-4NNo1J7=dkiDAfYa+Fc5WXBK0yH0f=TQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+fz7DQ9O=4F-4NNo1J7=dkiDAfYa+Fc5WXBK0yH0f=TQ@mail.gmail.com>

On Thu, Jan 16, 2025 at 01:00:24PM -0800, Alexei Starovoitov wrote:
> On Thu, Jan 16, 2025 at 12:21 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > +/*
> > + * Counts the new reader in the appropriate per-CPU element of the
> > + * srcu_struct.  Returns a pointer that must be passed to the matching
> > + * srcu_read_unlock_fast().
> > + *
> > + * Note that this_cpu_inc() is an RCU read-side critical section either
> > + * because it disables interrupts, because it is a single instruction,
> > + * or because it is a read-modify-write atomic operation, depending on
> > + * the whims of the architecture.
> > + */
> > +static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct *ssp)
> > +{
> > +       struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
> > +
> > +       RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
> > +       this_cpu_inc(scp->srcu_locks.counter); /* Y */
> > +       barrier(); /* Avoid leaking the critical section. */
> > +       return scp;
> > +}
> 
> This doesn't look fast.
> If I'm reading this correctly,
> even with debugs off RCU_LOCKDEP_WARN() will still call
> rcu_is_watching() and this doesn't look cheap or fast.

this is the while (0 && (c)), thing, right? can't the compiler throw
that out in DCE ?

