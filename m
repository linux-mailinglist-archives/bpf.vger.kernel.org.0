Return-Path: <bpf+bounces-55223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7728DA7A312
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 14:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98379174447
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 12:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7740124CEF4;
	Thu,  3 Apr 2025 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ohkjuat/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A224C09A
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743684288; cv=none; b=Xq+TRabFYKM0rW52iEhERhQH2cFkOzKEIi+vLQWB0fQonieMECUUtvCPfJZiuyzukErh+hmfjC6Ssb70XQFUqxP2Orsf+FtMi/eM4wTjCI2W5Yg5Kj9vcQ0d4UTtTLB+gTbAxWY1vMh48U+wcAl7XvQ0Wr48p4suJN8AsKbmCGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743684288; c=relaxed/simple;
	bh=THsjslv0PclgQM1w5C5ZeQBaIcQM+ov2tnQiCR+JXQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ltv/JLIdag0gP/js+xfl+QUBoHT4No+3sm6xhRsfz0hj4+ZDzFQoBGtnO4t+fqyeWzZ1FJf6h40ppjkbeF02Q1pFAANfgI8vvfk03l7EijrmPWD1mZRIliNA9dYbZscsd9hH0snBZ6ucYbgFTu6dfQQQQffaTk/VoKDcjVjmaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ohkjuat/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743684285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k99cCVI4tAyR1lEvT/RV0Try5Bha7HjmpcxC+bC28K0=;
	b=Ohkjuat/Tn6Yerq5f+5hhfp1UcQbqfY0vkOP/g05F4OzIzzKkHG9BAeEIOo1FXFg+mRQKj
	2B47xkT+WmHNisNOhLoxJ5DvkZ8aIxDUk3m9RdLubUD5hurWHeBEoIG3xdZzWP/bbUwtCt
	+j3WSa65MaSwl0mVyYjDRE1NsJs6Rds=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-7sMHfITfOQ6QGpM9_9Xjjg-1; Thu,
 03 Apr 2025 08:44:40 -0400
X-MC-Unique: 7sMHfITfOQ6QGpM9_9Xjjg-1
X-Mimecast-MFC-AGG-ID: 7sMHfITfOQ6QGpM9_9Xjjg_1743684279
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53A1A1809CA6;
	Thu,  3 Apr 2025 12:44:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 08D643003770;
	Thu,  3 Apr 2025 12:44:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  3 Apr 2025 14:44:03 +0200 (CEST)
Date: Thu, 3 Apr 2025 14:43:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Peter Ziljstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250403124345.GC16254@redhat.com>
References: <20250402105444.tW8UU7vO@linutronix.de>
 <20250402112007.GE22091@redhat.com>
 <20250402113142.GG22091@redhat.com>
 <20250402120649._gQHEtYM@linutronix.de>
 <20250402121228.GH22091@redhat.com>
 <20250402121624.lRIPMa_h@linutronix.de>
 <20250402135641.GJ22091@redhat.com>
 <20250402142349.GL22091@redhat.com>
 <20250403090834.rp7Y4KRt@linutronix.de>
 <20250403121107.GA16254@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403121107.GA16254@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 04/03, Oleg Nesterov wrote:
>
> From include/linux/seqlock.h
>
> 	SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    raw_spin)
> 	SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, spin)
> 	SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, read)
> 	SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
>
> so for these seqcount's seqprop_preemptible() returns false only if
> the associated lock disables preemption. raw_spinlock always does this
> spinlock/rwlock depend on PREEMPT_RT.

Sorry, I wasn't clear... seqprop_preemptible() always returns false
on PREEMPT_RT, I meant the "preemptible" check in seqprop_sequence().

Oleg.


