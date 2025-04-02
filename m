Return-Path: <bpf+bounces-55162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D987A790E5
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 16:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C7F17225B
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 14:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE76423A9BD;
	Wed,  2 Apr 2025 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5u31CVq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442523875A
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603213; cv=none; b=awBS9N9a2z6JIclAkyMXpE48xKokl+C6R6NO7fFfgp5mCDKQgOUjfUduf9WGdMwGP7a6om3zX3hQyf6BivZ/ae49UPqUdNvQXcfmE3a4PDymR65Y1BNtarXPoz9ZzkQk4fDPZADVPxEYWF21k34Yxy88B9e0vhofNTudkzI608w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603213; c=relaxed/simple;
	bh=Q4UCbuv+br4mds4Lq3J19ZZ2gTK1+FghExkwwrYhO54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RE3c+zKFYUrT1Idpdi7wzndUEN3v34Zs/Ht6xiV1DlW7nSy7X5SysvhmQ6W/h3/p6smMFJvc9y9UoGzs9qXalc3vCSYLdnDq1Wj1xK9P025EsRhO3vJ4bub1QZA15Y4Ptb0i2edBqA+Y5v73/jOZidvP0K9O3eim6lCq+dbDlgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5u31CVq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743603210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4UCbuv+br4mds4Lq3J19ZZ2gTK1+FghExkwwrYhO54=;
	b=R5u31CVqKQzCppellpVvO4a3Thixmm7S6bD55IsvG0R9DxpdEgTIaqIqAcCHwpaN2lIoeq
	tGmquf5XyVIqtyHGNqnnus+qZeKTYrHuK0jTEeJYIlni/oVH0+n1ZOZj0rc1thI9u3L9hZ
	31h3LqdVis19d+5zWYbQeHGOUkNjV6I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-LIwzc2z9OkypURv4CrwrrA-1; Wed,
 02 Apr 2025 10:13:27 -0400
X-MC-Unique: LIwzc2z9OkypURv4CrwrrA-1
X-Mimecast-MFC-AGG-ID: LIwzc2z9OkypURv4CrwrrA_1743603205
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 942C1180AB19;
	Wed,  2 Apr 2025 14:13:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.147])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 33786180A803;
	Wed,  2 Apr 2025 14:13:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  2 Apr 2025 16:12:50 +0200 (CEST)
Date: Wed, 2 Apr 2025 16:12:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Ziljstra <peterz@infradead.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250402141245.GK22091@redhat.com>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250401172225.06b01b22@gandalf.local.home>
 <CAEf4BzbVmUfDVEs1ndy5hr2YYA5xgt7NODjNhy4x+Syfbr1yaA@mail.gmail.com>
 <20250402103326.GD22091@redhat.com>
 <20250402105746.FMPvRBwL@linutronix.de>
 <20250402112308.GF22091@redhat.com>
 <20250402121315.UdZVK1JE@linutronix.de>
 <20250402121850.GI22091@redhat.com>
 <20250402122447.B3XIrQnG@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402122447.B3XIrQnG@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/02, Sebastian Sewior wrote:
>
> On 2025-04-02 14:18:51 [+0200], Oleg Nesterov wrote:
> > On 04/02, Sebastian Sewior wrote:
>
> I need to tell mutt to replace my name in case it is misspelled.

Hmm... have I misspelled your name somewhere?

If yes - my apologies.

> > > The preempted ri_timer() could stall a read_seqcount_begin().
> >
> > Again, nobody use read_seqcount_begin(utask->ri_seqcount).
> >
> > free_ret_instance() uses raw_seqcount_try_begin(utask->ri_seqcount),
> > which, since ri_seqcount is seqcount_t, is just smp_load_acquire().
> > This can't stall.
>
> Yes. This would work for here just to skip the check because of all
> details that are hard to express. Therefore I suggested to use
> raw_write_seqcount_begin() instead of write_seqcount_begin() in
> 20250402122158.j_8VoHQ-@linutronix.de. Would that work?

If this can work, then let me repeat: why can't we turn ->ri_seqcount
into a boolean?

That was my question. I don't understand the purpose of
"seqcount_t ri_seqcount" regardless of the reported problem.
This "WARNING: CPU: 0 PID: 16 at include/linux/seqlock.h:221" is another
issue.

Again, I must have missed something.

Oleg.


