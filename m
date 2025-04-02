Return-Path: <bpf+bounces-55164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D48A7912E
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 16:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1EC3B22EF
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C707723AE7E;
	Wed,  2 Apr 2025 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMoC9Hjj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CD223771C
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603877; cv=none; b=OlQEVM0HoCGGnnIWqT3yZUnV55frrnWURRASRdSOyxw5ivdLFgZWsrQdQaMt39C/nWSOKfgaTDKLaJbEfwDgtuf+ImyE4xQffpSkxlzhtk+eMlDatu0vY4oGbn1YSvxDajTdZMdJ0Z2YOj3cJm4Qxh5ZF+DqET38/7HfbXgbSpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603877; c=relaxed/simple;
	bh=cIESZGO1yOm3bcPxiahz/Ei+s29elQBF5gQOz309HzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSRtjimOE+Qe4yEZ7aAKjxWVCTW4lbmp5HJNXmVMme8EwLph1vzT6VcXeU1CVdZVxkK8cwzcvfJFPRDpAC8YayuY63immsX+OJXXRLa6CQaLGe67wWdb431VSqlfMR9Xxhipucr5OT5Vaqm8yt9fYVbL1uPQUhFsTtRQA2c+Yu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMoC9Hjj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743603874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9+xVLgIT99SYfe3h2WMAMH/Ehp+cGQXcaVDliw5WbQo=;
	b=bMoC9HjjZpc5Qe4RzikV8qCBH05rmx23QS/nmxSxN5B1D5ubKckjUH13R+FzOSfq9nlfav
	jGvOV5JIbBAsdang4GF45+Id92wmNOatWhn4zaN9yKDhkVDx2pJ7RVXr6YxWbTjEYHD9Ig
	nk9UF49Mh4fD+5LK4wbsQUnERA27QTY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-UbgNTZ14PJyA6IUZakaYKw-1; Wed,
 02 Apr 2025 10:24:31 -0400
X-MC-Unique: UbgNTZ14PJyA6IUZakaYKw-1
X-Mimecast-MFC-AGG-ID: UbgNTZ14PJyA6IUZakaYKw_1743603870
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E51D180034D;
	Wed,  2 Apr 2025 14:24:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.147])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 60646195609D;
	Wed,  2 Apr 2025 14:24:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  2 Apr 2025 16:23:54 +0200 (CEST)
Date: Wed, 2 Apr 2025 16:23:50 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Peter Ziljstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250402142349.GL22091@redhat.com>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250402091044.GB22091@redhat.com>
 <20250402105444.tW8UU7vO@linutronix.de>
 <20250402112007.GE22091@redhat.com>
 <20250402113142.GG22091@redhat.com>
 <20250402120649._gQHEtYM@linutronix.de>
 <20250402121228.GH22091@redhat.com>
 <20250402121624.lRIPMa_h@linutronix.de>
 <20250402135641.GJ22091@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402135641.GJ22091@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

OK, it seems we can't understand each other. Probably my fault.

So, it think that

	static inline bool __seqprop_preemptible(const seqcount_t *s)
	{
		return false;
	}

should return true. Well because it is preemptible just like
SEQCOUNT_LOCKNAME(mutex) or, if PREEMPT_RT=y, SEQCOUNT_LOCKNAME(spinlock).

Am I wrong?

Oleg.

On 04/02, Oleg Nesterov wrote:
>
> On 04/02, Sebastian Sewior wrote:
> >
> > On 2025-04-02 14:12:28 [+0200], Oleg Nesterov wrote:
> > > On 04/02, Sebastian Sewior wrote:
> > > >
> > > > On 2025-04-02 13:31:43 [+0200], Oleg Nesterov wrote:
> > > > >
> > > > > IOW.
> > > > >
> > > > > I understand that seqcount_t is not RT-friendly, but why exactly do
> > > > > you think the patch above can make the things worse?
> > > >
> > > > We wouldn't notice such a case.
> > >
> > > Sebastian, could you spell please?
> > >
> > > What case we wouldn't notice?
> >
> > I'm sorry. It wouldn't notice that preemption isn't disabled and yell.
> >
> > > With this patch write_seqcount_begin(seqcount_t) will notice that
> > > seqprop_preemptible() is true and do preempt_disable() itself.
> >
> > Yes, but that we don't want. This would disable preemption for the whole
> > section and not allow anything on PREEMPT_RT what would be possible
> > otherwise. Like acquire a spinlock_t or so.
>
> Still can't understand...
>
> Currently __seqprop_assert() does lockdep_assert_preemption_disabled().
> This means that at least with PREEMPT_RT=y preemption must be disabled
> even before write_seqcount_begin(seqcount_t).
>
> That is why (I guess) for example i_size_write() does
> preempt_disable() before write_seqcount_begin(&inode->i_size_seqcount).
>
> > Yes, none of this would affect hprobe_expire().
>
> Yes.
>
> Oleg.


