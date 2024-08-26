Return-Path: <bpf+bounces-38073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF34C95F040
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 13:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8649F1F22BF7
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 11:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946EF15B0EE;
	Mon, 26 Aug 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Do1eKYrO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D0B14D2BD
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673493; cv=none; b=YoxZw9iA4eDHniKBqrnbC8UVe4PMJESGDQHfispCyegdrxTR1AhAQanEZ+KMCZP3INER8dymTZpSoUra8v0zhfxQwq1N53lg7OnEPtuh9jYbTnIjGRkYJitvjR8TDy17kmUSTaF5rtuncbf3O++T31EZRCB/PdaH7n9zQKvfnuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673493; c=relaxed/simple;
	bh=VM8yYSFM+3GJYTnPs9F5OhGnfypf43YvecMZdPnDG4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fbuz8paDIYoXriG+GGwOwDEXxofxZz049FzSDDWplXiAHcFBtk08ZWnLPKWjIqxg602YOLoLZrCwd43q1IKlFSKjvjhefRW9Qi74pwrPrikCt5OOwiFZjxrrx4BcFW0jnlNddU7Kkvj3xlJwBZldQIRsV7wP2Z/SO1G7Wb6PJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Do1eKYrO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724673490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kHDLrebuPvSrdFeWg07DDDEBQywHQBfHx09u2gZhk6M=;
	b=Do1eKYrOIACCVzyhUwuDPmjFWCOziWbgu3FVyEQTcg3VyfmMNVu4V0P4906Y5PjuMs2z0D
	oOUdYka6xOl1uoCj1omRLzzNS5/S4L83UgEUcct7XFigxDGweLE468t338oMnrLFubptH8
	wG66dE36LO4knEL15Bd+CgeTU09Ln3w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-Buu-lX5VM_e-SoMwIjIIVQ-1; Mon,
 26 Aug 2024 07:58:07 -0400
X-MC-Unique: Buu-lX5VM_e-SoMwIjIIVQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1873E1955BF8;
	Mon, 26 Aug 2024 11:58:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 797191955F45;
	Mon, 26 Aug 2024 11:58:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 26 Aug 2024 13:57:57 +0200 (CEST)
Date: Mon, 26 Aug 2024 13:57:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tianyi Liu <i.pear@outlook.com>, andrii.nakryiko@gmail.com,
	mhiramat@kernel.org, ajor@meta.com, albancrequy@linux.microsoft.com,
	bpf@vger.kernel.org, flaniel@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240826115752.GA21268@redhat.com>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsxTckUnlU_HWDMJ@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/26, Jiri Olsa wrote:
>
> On Mon, Aug 26, 2024 at 12:40:18AM +0200, Oleg Nesterov wrote:
> > 	$ ./test &
> > 	$ bpftrace -p $! -e 'uprobe:./test:func { printf("%d\n", pid); }'
> >
> > I hope that the syntax of the 2nd command is correct...
> >
> > I _think_ that it will print 2 pids too.
>
> yes.. but with CLONE_VM both processes share 'mm'

Yes sure,

> so they are threads,

Well this depends on definition ;) but the CLONE_VM child is not a sub-thread,
it has another TGID. See below.

> and at least uprobe_multi filters by process [1] now.. ;-)

OK, if you say that this behaviour is fine I won't argue, I simply do not know.
But see below.

> > But "perf-record -p" works as expected.
>
> I wonder it's because there's the perf layer that schedules each
> uprobe event only when its process (PID1/2) is scheduled in and will
> receive events only from that cpu while the process is running on it

Not sure I understand... The task which hits the breakpoint is always
current, it is always scheduled in.

The main purpose of uprobe_perf_func()->uprobe_perf_filter() is NOT that
we want to avoid __uprobe_perf_func() although this makes sense.

The main purpose is that we want to remove the breakpoints in current->mm
when uprobe_perf_filter() returns false, that is why UPROBE_HANDLER_REMOVE.
IOW, the main purpose is not penalise user-space unnecessarily.

IIUC (but I am not sure), perf-record -p will work "correctly" even if we
remove uprobe_perf_filter() altogether. IIRC the perf layer does its own
filtering but I forgot everything.

And this makes me think that perhaps BPF can't rely on uprobe_perf_filter()
either, even we forget about ret-probes.

> [1] 46ba0e49b642 bpf: fix multi-uprobe PID filtering logic

Looks obviously wrong... get_pid_task(PIDTYPE_TGID) can return a zombie
leader with ->mm == NULL while other threads and thus the whole process
is still alive.

And again, the changelog says "the intent for PID filtering it to filter by
*process*", but clone(CLONE_VM) creates another process, not a thread.

So perhaps we need

	-	if (link->task && current->mm != link->task->mm)
	+	if (link->task && !same_thread_group(current, link->task))

in uprobe_prog_run() to make "filter by *process*" true, but this won't
fix the problem with link->task->mm == NULL in uprobe_multi_link_filter().


Does bpftrace use bpf_uprobe_multi_link_attach/etc ? I guess not...
Then which userspace tool uses this code? ;)

Oleg.


