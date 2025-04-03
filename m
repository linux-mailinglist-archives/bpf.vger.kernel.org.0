Return-Path: <bpf+bounces-55221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD9AA7A28C
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 14:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E81171524
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF5A24C09A;
	Thu,  3 Apr 2025 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLmmH5cY"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1911F8720
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743682318; cv=none; b=CUUIqC99Y8r6Mw8o65nf7zzPjEQh0Y/dpnwrH72W3l5MBYAJktsqw1PdixxTz/RtDIn5TvbdDHezXzNuAcirtSeHkC/mKHUkH7jGe77w6zQ1XjX6l/jeWMfRl8696YsxNrLgN0Lt4xlGpZLxO3qSJNOzRo5Pg6azYoYG+JbVLL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743682318; c=relaxed/simple;
	bh=qrVfNh0Vqdd+bdD+aXgmU21PqVdhgJ/+f9D/uc9wIfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud9ifMAfXjfdlCWSElrSRBbJq2D4UJkOQtuo33tXOY7oiOspMEmKRlQJM4a2IyBKHAoQS2H05ACJUOcOkynTsDRg5oZgfXjFRb7PHaFqHVcJfx6EHLOi/YwuLS0TlWG0JGoIyfwp3r6TgkQc24xrMV9HwOFN2dmeGJ7XnrCO7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLmmH5cY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743682312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zmX6w5Ix4fYyhU741pjwWrsIs2mvR5Rct1Vyb9R9+8E=;
	b=ZLmmH5cYNcT9v8AgMy4Rqv4Ms1pVIwSZ5vYKN5zZkdF2i4C1sNj4iY82mJjc29soa+KLzw
	dG2oe+9te3Iwtal2rBv4W/K7zhXPIFkjzr0PnTH42hrbtq4SnBcadHMQck9fSLgJJ8Fz8P
	3RtjBJN/czeRul2d9gFlkBoqocYmbL4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-7Q5TL18jNVuUNJVa8Ui_Ug-1; Thu,
 03 Apr 2025 08:11:50 -0400
X-MC-Unique: 7Q5TL18jNVuUNJVa8Ui_Ug-1
X-Mimecast-MFC-AGG-ID: 7Q5TL18jNVuUNJVa8Ui_Ug_1743682308
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53A2B180AF55;
	Thu,  3 Apr 2025 12:11:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.20])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 163C01955BC2;
	Thu,  3 Apr 2025 12:11:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  3 Apr 2025 14:11:13 +0200 (CEST)
Date: Thu, 3 Apr 2025 14:11:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Peter Ziljstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250403121107.GA16254@redhat.com>
References: <20250402091044.GB22091@redhat.com>
 <20250402105444.tW8UU7vO@linutronix.de>
 <20250402112007.GE22091@redhat.com>
 <20250402113142.GG22091@redhat.com>
 <20250402120649._gQHEtYM@linutronix.de>
 <20250402121228.GH22091@redhat.com>
 <20250402121624.lRIPMa_h@linutronix.de>
 <20250402135641.GJ22091@redhat.com>
 <20250402142349.GL22091@redhat.com>
 <20250403090834.rp7Y4KRt@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403090834.rp7Y4KRt@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 04/03, Sebastian Sewior wrote:
>
> On 2025-04-02 16:23:50 [+0200], Oleg Nesterov wrote:
> > OK, it seems we can't understand each other. Probably my fault.
> >
> > So, it think that
> >
> > 	static inline bool __seqprop_preemptible(const seqcount_t *s)
> > 	{
> > 		return false;
> > 	}
> >
> > should return true. Well because it is preemptible just like
> > SEQCOUNT_LOCKNAME(mutex) or, if PREEMPT_RT=y, SEQCOUNT_LOCKNAME(spinlock).
> >
> > Am I wrong?
>
> A seqcount_t has no lock associated with so it is not preemptible.

Well, I still disagree...

> It
> always refers to the lock. This should come from extern so it not only
> disables preemption but also ensures that there can only be one writer.

Yes, but

> The "disabling preemption" is only there to ensure progress is made in
> reasonable time: You should not get preempted in your write section. If
> the writer gets preempted then nothing bad (as in *boom*) will happen
> because you ensured that you have only one writer can enter the section.
> In that scenario the reader will spin on the counter until the writer
> gets back on the CPU and completes the write section and while doing so
> wasting resources. No boom, just wasting resources.

This can lead to deadlock.

Suppose we have a seqcount_t SEQ, and we ensure that it has a single
writer. Say, this SEQ is protected by mutex.

The writer does write_seqcount_begin(&SEQ) on a UP machine, and it is
preeempted by a real-time process which does read_seqcount_begin(&SEQ).
The reader will spin "forever".

> If you make __seqprop_preemptible() return true then
> write_seqcount_begin() for seqcount_t will disable preemption on its
> own. You could now remove all preempt_disable() around its callers. So
> far so good as everyone should have one.

Yes,

> The problem here is that for !RT only seqcount_mutex_t gets preemption
> disabled.

Sure, for !RT spinlock/rwlock disable preemption,

> For RT none of the seqcount_t variants get preemption disabled
> but rely on lock+unlock mechanism to ensure that progress is made.

Yes I know, but seqcount_t doesn't have the associated lock.

> With this change it would also disable preemption for RT and I don't
> know if it is is always the smart thing to do.

I don't know either.

But the current logic doesn't look right to me.

From include/linux/seqlock.h

	SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    raw_spin)
	SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, spin)
	SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, read)
	SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)

so for these seqcount's seqprop_preemptible() returns false only if
the associated lock disables preemption. raw_spinlock always does this
spinlock/rwlock depend on PREEMPT_RT.

But seqcount_t doesn't have the associated lock, so I think that
seqprop_preemptible(seqcount_t) should return true.

But OK, I won't insist. At least it seems we more or less understand
each other ;)

Oleg.


