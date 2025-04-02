Return-Path: <bpf+bounces-55140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6741FA78CFA
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 13:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2F518905AE
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 11:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074FC238159;
	Wed,  2 Apr 2025 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3c2jDgm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CCD238149
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592856; cv=none; b=bnAm7/VKCOgcdUuwTfMk/OYsbveZUi70PxTiI3/0f3GmhOXdEeT0nlLNY7nlz0jwGf48NKu51ZPiy6UyZglpW/YuYcrbimOwIqbczAGMmo+DBzlEnURTHtkuYz0+AUlhJOR0vVKT3Ii56kRRQr5sMN9leS5OF6uDW1xl+2BH/CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592856; c=relaxed/simple;
	bh=V/YTv1LrEDJt9Qc5FmXgPMHnsXS0LqtIguChw7m7jPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2GS/Se/S7bUe80Gp4rAVEFlTKALaOWFAAKhOefdUmvlgjQ63cGRIAPvYx3FRo+1DZvht1Jc0s/kbsLYl5mkTd1CAdnXIL27wAL1wFUoCZqmwHSwVnro5UYOY29Dp0iu4KBpu4jzRilYSlxY2JJiDVbX/Pe3F4xoADYXs6nki3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3c2jDgm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743592853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3gh3qc3mCI6REs+l4y8fDZe09szrk57uTA/tlkvkAr0=;
	b=R3c2jDgmLlL1RTFX4Evpzr13Y/H14Wgoa0//z+aleyI13qKBkFQ+EpxisCQ8N+NS65nnby
	HZ/T8p0j3AuF8eMZUw7iAlIDxbsa08Xw4KBDcwT8F0L/E7wcMzEUH+tB+N1SqHp/zUY+8U
	DIcZMpjxDmiwGVJTxE5veJO3PHaU2Gs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-3_J5tzInOPmgbdEKMHE27Q-1; Wed,
 02 Apr 2025 07:20:49 -0400
X-MC-Unique: 3_J5tzInOPmgbdEKMHE27Q-1
X-Mimecast-MFC-AGG-ID: 3_J5tzInOPmgbdEKMHE27Q_1743592848
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EA3219560BC;
	Wed,  2 Apr 2025 11:20:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.147])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6A7B31955DCE;
	Wed,  2 Apr 2025 11:20:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  2 Apr 2025 13:20:12 +0200 (CEST)
Date: Wed, 2 Apr 2025 13:20:08 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Peter Ziljstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250402112007.GE22091@redhat.com>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250402091044.GB22091@redhat.com>
 <20250402105444.tW8UU7vO@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402105444.tW8UU7vO@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 04/02, Sebastian Sewior wrote:
>
> On 2025-04-02 11:10:45 [+0200], Oleg Nesterov wrote:
> > Add Peter.
> >
> > I never understood why __seqprop_preemptible() returns false.
> > Stupid question, perhaps
> >
> > 	--- x/include/linux/seqlock.h
> > 	+++ x/include/linux/seqlock.h
> > 	@@ -213,12 +213,11 @@ static inline unsigned __seqprop_sequenc
> >
> > 	 static inline bool __seqprop_preemptible(const seqcount_t *s)
> > 	 {
> > 	-	return false;
> > 	+	return true;
> > 	 }
> >
> > 	 static inline void __seqprop_assert(const seqcount_t *s)
> > 	 {
> > 	-	lockdep_assert_preemption_disabled();
> > 	 }
> >
> > 	 #define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
> >
> > makes more sense?
> >
> > Then we can remove the no longer necessary preempt_disable()'s
> > before write_seqcount_begin() in other users of seqcount_t.
>
> This depends on locktype that is coupled with the seqcount.

Yes.

But seqcount_t doesn't have the "internal" lock. Unlike other
seqcount's defined by SEQCOUNT_LOCKNAME().

> If the lock disables preemption and relies on it then it must be somehow
> enforced on PREEMPT_RT or rely on the lock+unlock mechnanism to avoid
> deadlocks. Also it needs to be ensured that you don't have two writer
> since preemption is allowed.

Sorry, I don't understand.

Again, seqcount_t differs, it can't do lock+unlock like (say)
seqcount_spinlock_t.

Oleg.


