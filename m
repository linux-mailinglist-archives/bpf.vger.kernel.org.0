Return-Path: <bpf+bounces-37637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8825A958AB5
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 17:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB6C1F24D42
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 15:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C05B190052;
	Tue, 20 Aug 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDyRTWvH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16312745C
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166365; cv=none; b=Zn7MUOCS8fIEsuKC+YGzUlbbeFsAZiPDPEtHtw28UuZ4dG6nMiKn67e4mA7tRIkukeXtmqo8bA0emyC6X0hu/87YdhCjQud5XYAASc43qAO33UNdHy2l/hB96RMqC9xTMgXXm8Uoj3R+Bi8NEHKTeyzGlNTaKWSTIHw1mM4nLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166365; c=relaxed/simple;
	bh=qr+I97ck5Y63Un9yc5ip16ztJJZUGIoQd2Up04LB0Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8YzkYOd2W27UPvSA2lf+JYi+4DaWsmtAAJaqoKSlc1cq0i5N5QaPTTohT9QYI7ZhX15ssIQQ18h0JhnJ5SeLzezhoDkpF9mZ48c3RqifOlmjWw390iq2bN8iscgnL9w2U8RcZbSRpZ1D1G7RVBS40pH+ZLR360r2ci9S+0Kp54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDyRTWvH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724166360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKJEG4GEz/CaDYhNF4/J/0WOtN5X3sVlUXkziObLcNo=;
	b=SDyRTWvHv8K/zs6xBLXT8OLS0+CDEKTg1t3X5fS0NuLW4JWJYDIpynDZXzLH2NUpiHvfOA
	2jEVZp/6Qr45d2p56uB1fRJGrS00T3ohTdNOBqH8XmZSljmLwhAngiMFMhY9OqCz51lw5H
	hvDE9Y26cFFkc5pYnSgKUER3lXLZyeg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-tuU3hisOMxSoYEVqU5q5Rg-1; Tue,
 20 Aug 2024 11:05:55 -0400
X-MC-Unique: tuU3hisOMxSoYEVqU5q5Rg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E9801955BE4;
	Tue, 20 Aug 2024 15:05:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.99])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A883619560AD;
	Tue, 20 Aug 2024 15:05:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 20 Aug 2024 17:05:46 +0200 (CEST)
Date: Tue, 20 Aug 2024 17:05:34 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org, willy@infradead.org, surenb@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC v3 09/13] uprobes: SRCU-protect uretprobe lifetime
 (with timeout)
Message-ID: <20240820150534.GD12400@redhat.com>
References: <20240813042917.506057-1-andrii@kernel.org>
 <20240813042917.506057-10-andrii@kernel.org>
 <20240819134107.GB3515@redhat.com>
 <CAEf4BzYFXmCU83mr9YHy2JtF35WmYBvKpyrmBV4QxFuqubk_6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYFXmCU83mr9YHy2JtF35WmYBvKpyrmBV4QxFuqubk_6A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/19, Andrii Nakryiko wrote:
>
> On Mon, Aug 19, 2024 at 6:41 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 08/12, Andrii Nakryiko wrote:
> > >
> > > Avoid taking refcount on uprobe in prepare_uretprobe(), instead take
> > > uretprobe-specific SRCU lock and keep it active as kernel transfers
> > > control back to user space.
> > ...
> > >  include/linux/uprobes.h |  49 ++++++-
> > >  kernel/events/uprobes.c | 294 ++++++++++++++++++++++++++++++++++------
> > >  2 files changed, 301 insertions(+), 42 deletions(-)
> >
> > Oh. To be honest I don't like this patch.
> >
> > I would like to know what other reviewers think, but to me it adds too many
> > complications that I can't even fully understand...
>
> Which parts? The atomic xchg() and cmpxchg() parts? What exactly do
> you feel like you don't fully understand?

Heh, everything looks too complex for me ;)

Say, hprobe_expire(). It is also called by ri_timer() in softirq context,
right? And it does

	/* We lost the race, undo our refcount bump. It can drop to zero. */
	put_uprobe(uprobe);

How so? If the refcount goes to zero, put_uprobe() does mutex_lock(),
but it must not sleep in softirq context.


Or, prepare_uretprobe() which does

	rcu_assign_pointer(utask->return_instances, ri);

	if (!timer_pending(&utask->ri_timer))
		mod_timer(&utask->ri_timer, ...);

Suppose that the timer was pending and it was fired right before
rcu_assign_pointer(). What guarantees that prepare_uretprobe() will see
timer_pending() == false?

rcu_assign_pointer()->smp_store_release() is a one-way barrier. This
timer_pending() check may appear to happen before rcu_assign_pointer()
completes.

In this (yes, theoretical) case ri_timer() can miss the new return_instance,
while prepare_uretprobe() can miss the necessary mod_timer(). I think this
needs another mb() in between.


And I can't convince myself hprobe_expire() is correct... OK, I don't
fully understand the logic, but why data_race(READ_ONCE(hprobe->leased)) ?
READ_ONCE() should be enough in this case?


> > As I have already mentioned in the previous discussions, we can simply kill
> > utask->active_uprobe. And utask->auprobe.
>
> I don't have anything against that, in principle, but let's benchmark
> and test that thoroughly. I'm a bit uneasy about the possibility that
> some arch-specific code will do container_of() on this arch_uprobe in
> order to get to uprobe,

Well, struct uprobe is not "exported", the arch-specific code can't do this.

Oleg.


