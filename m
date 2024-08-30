Return-Path: <bpf+bounces-38544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 470FE965E8B
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 12:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0330A28B0DE
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 10:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E452F18FDB9;
	Fri, 30 Aug 2024 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WirC4MtX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC018FDB3
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012753; cv=none; b=r2O+x7fJrvLDjMtDLBPgIY8BwKrdV4YoJ9ueEz3yv3BPEmvGLWWZ7pXexLabRRZevtsqyO4GeRPV7Ck4PYN++XPedHPDEDdxNJuSAG1RyzhJrdPpdRjAxsqfzrQ6Q0/PJsRDuvyS1kYK5/SLiI/8CCnZkwoGAV8y0x9uX0PjZp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012753; c=relaxed/simple;
	bh=dnlDuPMu/3R9NUf2DOiGAPAk43O4O+wFrNwiEjWCL00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOqCOw5/vY7jxnAIPFeQt7xISG9E0e0wotRInLSPSHPxYpHrynZi2W+BjJv7/SyBrWa9ctrYy0qX1B6tQVr59Lr++DXJQAIUBiPwWXFz495dPoe0IuBYKLz70T/UXGfdivf1yHN6IIhxz4IN5R5q0AKhcWMZ5kx9W6pLYzdyT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WirC4MtX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725012751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QFMP8JcwnKATVGaY7wHY5aCEq2u8HtpG8d/mb9gZgoY=;
	b=WirC4MtX4v9Wn2pcZdhLmfH3KC+I/TFUkvWDUGYU+Z6k0sv7rpCcnxse81jtbPZ5Sswkz5
	NhY4nVyMlPJ/IUWaU11tsdJHhQU5msSXrB2D7Kj3UuLxoufYxE6xEN1o/YOzHdNdMcnjDA
	PK6A+LinoghvN4v1EIMRjxQA3BqOp+E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-VtHD0L82PpaZyhQEU9iAjw-1; Fri,
 30 Aug 2024 06:12:25 -0400
X-MC-Unique: VtHD0L82PpaZyhQEU9iAjw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 595C01955BFC;
	Fri, 30 Aug 2024 10:12:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.148])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DDC76300019C;
	Fri, 30 Aug 2024 10:12:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 30 Aug 2024 12:12:14 +0200 (CEST)
Date: Fri, 30 Aug 2024 12:12:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tianyi Liu <i.pear@outlook.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Jordan Rome <linux@jordanrome.com>,
	ajor@meta.com
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, flaniel@linux.microsoft.com,
	albancrequy@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240830101209.GA24733@redhat.com>
References: <ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The whole discussion was very confusing (yes, I too contributed to the
confusion ;), let me try to summarise.

> U(ret)probes are designed to be filterable using the PID, which is the
> second parameter in the perf_event_open syscall. Currently, uprobe works
> well with the filtering, but uretprobe is not affected by it.

And this is correct. But the CONFIG_BPF_EVENTS code in __uprobe_perf_func()
misunderstands the purpose of uprobe_perf_filter().

Lets forget about BPF for the moment. It is not that uprobe_perf_filter()
does the filtering by the PID, it doesn't. We can simply kill this function
and perf will work correctly. The perf layer in __uprobe_perf_func() does
the filtering when perf_event->hw.target != NULL.

So why does uprobe_perf_filter() call uprobe_perf_filter()? Not to avoid
the __uprobe_perf_func() call (as the BPF code assumes), but to trigger
unapply_uprobe() in handler_chain().

Suppose you do, say,

	$ perf probe -x /path/to/libc some_hot_function
or
	$ perf probe -x /path/to/libc some_hot_function%return
then
	$perf record -e ... -p 1

to trace the usage of some_hot_function() in the init process. Everything
will work just fine if we kill uprobe_perf_filter()->uprobe_perf_filter().

But. If INIT forks a child C, dup_mm() will copy int3 installed by perf.
So the child C will hit this breakpoint and cal handle_swbp/etc for no
reason every time it calls some_hot_function(), not good.

That is why uprobe_perf_func() calls uprobe_perf_filter() which returns
UPROBE_HANDLER_REMOVE when C hits the breakpoint. handler_chain() will
call unapply_uprobe() which will remove this breakpoint from C->mm.

> We found that the filter function was not invoked when uretprobe was
> initially implemented, and this has been existing for ten years.

See above, this is correct.

Note also that if you only use perf-probe + perf-record, no matter how
many instances, you can even add BUG_ON(!uprobe_perf_filter(...)) into
uretprobe_perf_func(). IIRC, perf doesn't use create_local_trace_uprobe().

---------------------------------------------------------------------------
Now lets return to BPF and this particular problem. I won't really argue
with this patch, but

	- Please change the subject and update the changelog,
	  "Fixes: c1ae5c75e103" and the whole reasoning is misleading
	  and wrong, IMO.

	- This patch won't fix all problems because uprobe_perf_filter()
	  filters by mm, not by pid. The changelog/patch assumes that it
	  is a "PID filter", but it is not.

	  See https://lore.kernel.org/linux-trace-kernel/20240825224018.GD3906@redhat.com/
	  If the traced process does clone(CLONE_VM), bpftrace will hit the
	  similar problem, with uprobe or uretprobe.

	- So I still think that the "right" fix should change the
	  bpf_prog_run_array_uprobe() paths somehow, but I know nothing
	  about bpf.

Oleg.


