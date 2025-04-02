Return-Path: <bpf+bounces-55142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4DCA78D2F
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 13:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557CC3B4102
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 11:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F57023A9A5;
	Wed,  2 Apr 2025 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8dyEFPy"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327923A588
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743593547; cv=none; b=aTd0yTsswR3erNSoYZn5X+KZ5U8ktF7sUPnwVomoJAJREgokysZ//8AkAKhBq4CuJ+4a5YxIluzfljlzveG4DXr+Je/EStZ9S1CteO+x+h7nlEgOTtoMkZtsSPmu8R5HpHOBPu3htaRgqf5kGHxysmtSGN0ibpWMUarUMG4TtF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743593547; c=relaxed/simple;
	bh=bRV4UHy2F6ef8/4ZNY0Wu5AYTeuYrZIcYnjGtSZpy4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnylGWKMzgayIURtVyBn/Ec1XXNn4wqGeAl7rup49oWwuyZmxaUaQfsx6ZPC7Vuc57h5KS7BKuALgzum0hrnHBj7s49mbihcsMAT7ndEn7H8a2/PF68wyLgwn7pfcmc0rk58h8hYNw4C8Ur7Glo2nB0yoadqaFXy+ZsdTfXLa+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8dyEFPy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743593545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wdByO5R0/ErGYhfvcMEXpkc8t2nqpZCDj6Q6VKEgXns=;
	b=a8dyEFPyM/OBmh5HVZibjYKjBxWjSCbVMONq+ujbkS9cqiYFzPAc04dq1aysCUBK60e/1m
	ZbZo9bGdNYJ06c9aI/3D0SLmHiDhxED3urdto+0rjkRp822XUmH1/peehcxf2+FAgb31al
	gEEr2W3e2NR9h9TP3HL3eoUDXzMbeMs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-7FlkxVldN0mJZ4aPvVVTfA-1; Wed,
 02 Apr 2025 07:32:23 -0400
X-MC-Unique: 7FlkxVldN0mJZ4aPvVVTfA-1
X-Mimecast-MFC-AGG-ID: 7FlkxVldN0mJZ4aPvVVTfA_1743593542
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E87218001E3;
	Wed,  2 Apr 2025 11:32:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.147])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2FC261801747;
	Wed,  2 Apr 2025 11:32:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  2 Apr 2025 13:31:47 +0200 (CEST)
Date: Wed, 2 Apr 2025 13:31:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Peter Ziljstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250402113142.GG22091@redhat.com>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250402091044.GB22091@redhat.com>
 <20250402105444.tW8UU7vO@linutronix.de>
 <20250402112007.GE22091@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402112007.GE22091@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 04/02, Oleg Nesterov wrote:
>
> On 04/02, Sebastian Sewior wrote:
> >
> > On 2025-04-02 11:10:45 [+0200], Oleg Nesterov wrote:
> > > Add Peter.
> > >
> > > I never understood why __seqprop_preemptible() returns false.
> > > Stupid question, perhaps
> > >
> > > 	--- x/include/linux/seqlock.h
> > > 	+++ x/include/linux/seqlock.h
> > > 	@@ -213,12 +213,11 @@ static inline unsigned __seqprop_sequenc
> > >
> > > 	 static inline bool __seqprop_preemptible(const seqcount_t *s)
> > > 	 {
> > > 	-	return false;
> > > 	+	return true;
> > > 	 }
> > >
> > > 	 static inline void __seqprop_assert(const seqcount_t *s)
> > > 	 {
> > > 	-	lockdep_assert_preemption_disabled();
> > > 	 }
> > >
> > > 	 #define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
> > >
> > > makes more sense?
> > >
> > > Then we can remove the no longer necessary preempt_disable()'s
> > > before write_seqcount_begin() in other users of seqcount_t.
> >
> > This depends on locktype that is coupled with the seqcount.
>
> Yes.
>
> But seqcount_t doesn't have the "internal" lock. Unlike other
> seqcount's defined by SEQCOUNT_LOCKNAME().
>
> > If the lock disables preemption and relies on it then it must be somehow
> > enforced on PREEMPT_RT or rely on the lock+unlock mechnanism to avoid
> > deadlocks. Also it needs to be ensured that you don't have two writer
> > since preemption is allowed.
>
> Sorry, I don't understand.
>
> Again, seqcount_t differs, it can't do lock+unlock like (say)
> seqcount_spinlock_t.

IOW.

I understand that seqcount_t is not RT-friendly, but why exactly do
you think the patch above can make the things worse?

Oleg.


