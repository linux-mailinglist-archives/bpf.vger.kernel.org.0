Return-Path: <bpf+bounces-55149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E2FA78E1A
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 14:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 570B97A1FC5
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 12:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073EE2356BE;
	Wed,  2 Apr 2025 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEet+oY7"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E720E01D
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596380; cv=none; b=KDDXqdxh/ywTje+U3vg1ifgZKDPhmJOR13bBIjTb+/wta2vsoNF3mYWPdq9SRE2KxF4N2cIhIXWu0wvigtNN3y48+eo/PIvWNhVsv9XJIscrPAWZ1IxosPbPpFR+NiwPpr2R/fBXEwgkXfxqKQuv4SDtn15U3mA3VDmj8+rBik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596380; c=relaxed/simple;
	bh=XtCe6/pJl49N3vA5641GdIESPgY7lwedMFvkvsjkzPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ve8w9TWgTvkuGzKN9lLhvJ/yjJ0lfH2vUYJpIh8f1ysOTmKBUTiMTDTSc3X6+iazB04yyDUoJiIDTQuFS8Rd9GCZDFUhIMWUkPQtua/bMCxLY8R6gPGxQ/GpszHIA31ixfGggPbblv2ipLl+dw5vDZ1zd11jrp5bey/0SXZ/yL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEet+oY7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743596377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XtCe6/pJl49N3vA5641GdIESPgY7lwedMFvkvsjkzPo=;
	b=BEet+oY77hepp+zxnitVOOwpKqAi8AyPWx8JEgsvTYokYNce9OuiuG161zFN4QRHotq6j1
	2dlk8DkHDvjbwSxQPLvK/sZEOSyRBH0s1J0Tk3jVL+VpxjK+su/4QStFXcwlfQSDiD6NC3
	iT78SJLODTeJjAXriDdSacHGNmhXh/A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-4MC75lGqOuGjetIDs4MQsA-1; Wed,
 02 Apr 2025 08:19:34 -0400
X-MC-Unique: 4MC75lGqOuGjetIDs4MQsA-1
X-Mimecast-MFC-AGG-ID: 4MC75lGqOuGjetIDs4MQsA_1743596373
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC16D1809CA5;
	Wed,  2 Apr 2025 12:19:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.147])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6B4D51828AAA;
	Wed,  2 Apr 2025 12:19:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  2 Apr 2025 14:18:58 +0200 (CEST)
Date: Wed, 2 Apr 2025 14:18:51 +0200
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
Message-ID: <20250402121850.GI22091@redhat.com>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250401172225.06b01b22@gandalf.local.home>
 <CAEf4BzbVmUfDVEs1ndy5hr2YYA5xgt7NODjNhy4x+Syfbr1yaA@mail.gmail.com>
 <20250402103326.GD22091@redhat.com>
 <20250402105746.FMPvRBwL@linutronix.de>
 <20250402112308.GF22091@redhat.com>
 <20250402121315.UdZVK1JE@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402121315.UdZVK1JE@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/02, Sebastian Sewior wrote:
>
> On 2025-04-02 13:23:09 [+0200], Oleg Nesterov wrote:
> > On 04/02, Sebastian Sewior wrote:
> > >
> > > On 2025-04-02 12:33:55 [+0200], Oleg Nesterov wrote:
> > > >
> > > > The "writer" ri_timer() can't race with itself, right?
> > >
> > > On PREEMPT_RT the timer could be preempted by a task with higher
> > > priority and invoke hprobe_expire() somewhere else.
> >
> > This is clear, but ri_timer() still can not race with itself, no?
>
> No, ri_timer() can not race against itself.

Okay,

> The preempted ri_timer() could stall a read_seqcount_begin().

Again, nobody use read_seqcount_begin(utask->ri_seqcount).

free_ret_instance() uses raw_seqcount_try_begin(utask->ri_seqcount),
which, since ri_seqcount is seqcount_t, is just smp_load_acquire().
This can't stall.

Oleg.


