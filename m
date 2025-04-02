Return-Path: <bpf+bounces-55135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B757A78C76
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 12:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CEF77A5CC3
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 10:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEA9235C04;
	Wed,  2 Apr 2025 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipB1oWSY"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4E2AE77
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743590085; cv=none; b=nl/nXg57voKyM56UDwPaYZj3ea1A/l4FdcmY3ZaLzxNot/O7f+BvMs60utn+suDiXmtnt5H0ECjurnMxekPvadOp/yzvXcbfosd0H9+7/6PLWsucnrCkFssiYv7ErhVO6bx5FTciNyrtuwbHDrqYGYN/mM5vL10G8KY0dk2tyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743590085; c=relaxed/simple;
	bh=daVnqPpArimRKKZ20AVYyBPsMmgeR5GdT06LsOmsUFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHwySiE1iH76CNqCUC2jXdS+T5vOu/kk95Pd4n8BrLnZAR9m/ebYumRV+5SWEbHTNkKjb37gr5M2f2zi9pAm+pWJnomYlDz6DOCD1bTDkITI0a8gzzV5qmgZxbspqkeoI+aD8H0q4a8wi6VOruMQK/Jf18P408nNXV8mqf86b7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipB1oWSY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743590082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Zms8GGyTVYjMo927fDVKNpIk6Ff/1Jjr2+K3E7+l7c=;
	b=ipB1oWSYRdzhkydOUl/v+25GsCagESomHNiMU0yVT9xcXGgrQ+7+2ZtEEhlhF6O5YYTztq
	KJ7F33ZibmMDbAekVHg0Smcr8JHjv7J+ZjBFNgDmKMb1MqMejmM2opP8vrGYIqyIMShShG
	0PHd9E9lxkNee+gOH6uwiiz3o0rHpLI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-AKWXddzEOw-oMUCkR6Ym-w-1; Wed,
 02 Apr 2025 06:34:37 -0400
X-MC-Unique: AKWXddzEOw-oMUCkR6Ym-w-1
X-Mimecast-MFC-AGG-ID: AKWXddzEOw-oMUCkR6Ym-w_1743590076
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDB8B1956055;
	Wed,  2 Apr 2025 10:34:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.147])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 99DA8300376F;
	Wed,  2 Apr 2025 10:34:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  2 Apr 2025 12:34:00 +0200 (CEST)
Date: Wed, 2 Apr 2025 12:33:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Ziljstra <peterz@infradead.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250402103326.GD22091@redhat.com>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250401172225.06b01b22@gandalf.local.home>
 <CAEf4BzbVmUfDVEs1ndy5hr2YYA5xgt7NODjNhy4x+Syfbr1yaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbVmUfDVEs1ndy5hr2YYA5xgt7NODjNhy4x+Syfbr1yaA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 04/01, Andrii Nakryiko wrote:
>
> On Tue, Apr 1, 2025 at 2:21 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Hmm,
> >
> >         write_seqcount_begin(&utask->ri_seqcount);
> >
> >         for_each_ret_instance_rcu(ri, utask->return_instances)
> >                 hprobe_expire(&ri->hprobe, false);
> >
> >         write_seqcount_end(&utask->ri_seqcount);
> >
> > How big can that loop be?
> >
> > Of course, we could just say not to use uprobes on PREEMPT_RT kernels?
> > Otherwise, they could cause an unspecified latency.
>
> There can't be more than 64 nested uretprobes, so it will be (in a
> very-very unlikely event) at most 64 items. And that hprobe_expire()
> operation is very fast. So I don't think latency is a big concert
> here.

I still didn't read this code, but after the quick glance I don't
understand why do we actually need utask->ri_seqcount.

The "writer" ri_timer() can't race with itself, right?

The "reader" free_ret_instance() uses raw_seqcount_try_begin() without
the "retry" logic.

I have no idea if this logic is correct or not, but it seems that (apart
from the necessary barriers) we could use the utask->ri_timer_is_running
boolean instead with the same effect? Set/cleared in ri_timer(), checked
in free_ret_instance().

I must have missed something...

Oleg.


