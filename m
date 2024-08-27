Return-Path: <bpf+bounces-38136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FC49607A1
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 12:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B3C1F23206
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 10:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E62819DF86;
	Tue, 27 Aug 2024 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0JvXc/m"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDB9199E98
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755272; cv=none; b=eAS6YriRzi9Q7gTHQkvMnSCUXaNOIsNK2pV5Dlh9f8qZYCS/ON0YqYBcHjLmQQSeRwgMMb2dE0rxyuiJL2JslKtRkjZhoeDzQq3Rj/0TjRpop3kAL8wbeOG97in/c338JxbMZ9FffWYSL7BI1Y0nu5Es336iqJExAGByCEnZOiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755272; c=relaxed/simple;
	bh=Qz1a8CSDv1yDuZmmN9x8YOW7RMcmZ1PT9u2pTyYf5wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seGhyQ6AQ9zumuoPi5ZJxtcA74qcDzIM/dCIYTDW5C2VtPyLG/9gmP0ypbs2knOIjx5f70uH+bo0auf1u46euauRCbM53V40/scu6xRE1DyHJ7DDWAIw6LfFuDKe05kCyooLHYgiL20Mv45bz8KLm2MndQoEmiYAtRO7+eRq4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0JvXc/m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724755270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+W/iRPFMkEKzQkZrGaweHud29e2ZZ1m/nHKhDZapCE=;
	b=R0JvXc/mgVmxfTz1UGr0KNeFR2UxofVZATK2rRoUBOnCgeKnEvO/b8v16M9yBAFyK/OfnM
	N2igkC5yZjahzf0fdnDoM5Ln1w8SLX2vOiHO2fg+KAweKBMpFQVoGYv0RqCMsp9zxJjE+3
	VRYbHpF7fCOFBtj6FoVugBset24/6Tg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-7sNbfee2NBmmq7o-qJ9JNQ-1; Tue,
 27 Aug 2024 06:41:06 -0400
X-MC-Unique: 7sNbfee2NBmmq7o-qJ9JNQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71A0C1955D53;
	Tue, 27 Aug 2024 10:41:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5B7AE1955DC8;
	Tue, 27 Aug 2024 10:41:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 27 Aug 2024 12:40:57 +0200 (CEST)
Date: Tue, 27 Aug 2024 12:40:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tianyi Liu <i.pear@outlook.com>, andrii.nakryiko@gmail.com,
	mhiramat@kernel.org, ajor@meta.com, albancrequy@linux.microsoft.com,
	bpf@vger.kernel.org, flaniel@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240827104052.GD30765@redhat.com>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
 <Zs2lpd0Ni0aJoHwI@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs2lpd0Ni0aJoHwI@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/27, Jiri Olsa wrote:
>
> On Mon, Aug 26, 2024 at 01:57:52PM +0200, Oleg Nesterov wrote:
> >
> > So perhaps we need
> >
> > 	-	if (link->task && current->mm != link->task->mm)
> > 	+	if (link->task && !same_thread_group(current, link->task))
> >
> > in uprobe_prog_run() to make "filter by *process*" true, but this won't
> > fix the problem with link->task->mm == NULL in uprobe_multi_link_filter().
>
> would the same_thread_group(current, link->task) work in such case?
> (zombie leader with other alive threads)

Why not? task_struct->signal is stable, it can't be changed.

But again, uprobe_multi_link_filter() won't work if the leader,
uprobe->link->task, exits or it has already exited.

Perhaps something like the additional change below...

Oleg.

--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3322,13 +3322,28 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	return err;
 }
 
+
 static bool
 uprobe_multi_link_filter(struct uprobe_consumer *con, struct mm_struct *mm)
 {
 	struct bpf_uprobe *uprobe;
+	struct task_struct *task, *t;
+	bool ret = false;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	return uprobe->link->task->mm == mm;
+	task = uprobe->link->task;
+
+	rcu_read_lock();
+	for_each_thread(task, t) {
+		struct mm_struct *mm = READ_ONCE(t->mm);
+		if (mm) {
+			ret = t->mm == mm;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
 }
 
 static int


