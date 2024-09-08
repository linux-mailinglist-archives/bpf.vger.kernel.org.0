Return-Path: <bpf+bounces-39201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE099707BA
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 15:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6652821AE
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 13:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC0A165F00;
	Sun,  8 Sep 2024 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBNAZskn"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FA429CF7
	for <bpf@vger.kernel.org>; Sun,  8 Sep 2024 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725801346; cv=none; b=AzTscQ3XMHWt7E/gEcExzziQlR2+cq59DcL0IunYoKBC8P3Jb95cNQtc6XIkeC6Z2ODmly+0Ltz6Kw+0nvYakx9ECdVO1Rc3JcYlH8Me1oy5ijPdyqjkosaxvyLf27DVz5ptjLZAHNy7K6Qhd+r53VFb4DY+pSO1KRoTQcsxaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725801346; c=relaxed/simple;
	bh=flp398FQwtD1DXl5k5Df/Di+UWpPWTlqrKlw6S2PvK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAoPZOpQpXyT+A4q4KgJSZPrQKZ5fcF1LYtkZwhZFTWdQf+p/VfHkUOLgv43fzZ0GKN8jQG2DAUC5I9WVHMmgKQcUrUWGEbaynyzGhlC/51wFRu9t+tYhXllMYdWE64vMs7JSoUzCD1/kzSvhIoFHazDjTN24bpo5QyPKnhR7vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBNAZskn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725801343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlhyC8f8RgkRd2STTLE66pLfIsnslSspQq1pJPbLQzA=;
	b=EBNAZskn2P7dq+/Nh08K5AtwXbJeAffelDSgVqCfMoD6F2CoUJBfBrPcWs+JDVAYXWERSw
	mX8YyyUxtoPHVrEV1xgbFaL9+qkyh0YmhK7F50vCCcWQVbuEczm1S2tFTL/jjN3fYL6+yQ
	VWsthXgxsidA5JnWvra/7S3pv/bNM8w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-c-cTmO5cOI6TE0h7hkQw5A-1; Sun,
 08 Sep 2024 09:15:39 -0400
X-MC-Unique: c-cTmO5cOI6TE0h7hkQw5A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC01B19560BF;
	Sun,  8 Sep 2024 13:15:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 688C03000239;
	Sun,  8 Sep 2024 13:15:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  8 Sep 2024 15:15:25 +0200 (CEST)
Date: Sun, 8 Sep 2024 15:15:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tianyi Liu <i.pear@outlook.com>
Cc: olsajiri@gmail.com, ajor@meta.com, albancrequy@linux.microsoft.com,
	andrii.nakryiko@gmail.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240908131519.GA21236@redhat.com>
References: <Ztrc6eJ14M26xmvr@krava>
 <ME0P300MB0416A96545165A39507DF6429D9F2@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME0P300MB0416A96545165A39507DF6429D9F2@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/08, Tianyi Liu wrote:
>
> On Mon, Sep 06, 2024 at 18:43:00AM +0800, Jiri Olsa wrote:
>
> > would you consider sending another version addressing Oleg's points
> > for changelog above?
>
> My pleasure, I'll resend the updated patch in a new thread.
>
> Based on previous discussions, `uprobe_perf_filter` acts as a preliminary
> filter that removes breakpoints when they are no longer needed.

Well. Not only. See the usage of consumer_filter() and filter_chain() in
register_for_each_vma().

> More complex filtering mechanisms related to perf are implemented in
> perf-specific paths.

The perf paths in __uprobe_perf_func() do the filtering based on
perf_event->hw.target, that is all.

But uprobe_perf_filter() or any other consumer->filter() simply can't rely
on pid/task, it has to check ->mm.

> From my understanding, the original patch attempted to partially implement
> UPROBE_HANDLER_REMOVE (since it didn't actually remove the breakpoint but
> only prevented it from entering the BPF-related code).

Confused...

Your patch can help bpftrace although it (or any other change in
trace_uprobe.c) can't not actually fix all the problems with bpf/filtering
even if we forget about ret-probes.

And I don't understand how this relates to UPROBE_HANDLER_REMOVE...

> I'm trying to provide a complete implementation, i.e., removing the
> breakpoint when `uprobe_perf_filter` returns false, similar to how uprobe
> functions. However, this would require merging the following functions,
> because they will almost be the same:
>
> uprobe_perf_func / uretprobe_perf_func
> uprobe_dispatcher / uretprobe_dispatcher
> handler_chain / handle_uretprobe_chain

Sorry, I don't understand... Yes, uprobe_dispatcher and uretprobe_dispatcher
can share more code or even unified, but

> I suspect that uretprobe might have been implemented later than uprobe

Yes,

> and was only partially implemented.

what do you mean?

But whatever you meant, I agree that this code doesn't look pretty and can
be cleanuped.

> In your opinion, does uretprobe need UPROBE_HANDLER_REMOVE?

Probably. But this has absolutely nothing to do with the filtering problem?
Can we discuss this separately?

> I'm aware that using `uprobe_perf_filter` in `uretprobe_perf_func` is not
> the solution for BPF filtering. I'm just trying to alleviate the issue
> in some simple cases.

Agreed.

-------------------------------------------------------------------------------
To summarise.

This code is very old, and it was written for /usr/bin/perf which attaches
to the tracepoint. So multiple instances of perf-record will share the same
consumer/trace_event_call/filter. uretprobe_perf_func() doesn't call
uprobe_perf_filter() because (if /usr/bin/perf is the only user) in the likely
case it would burn CPU and return true. Quite possibly this design was not
optimal from the very beginning, I simply can't recall why the is_ret_probe()
consumer has ->handler != NULL, but it was not buggy.

Now we have bpf, create_local_trace_uprobe(), etc. So lets add another
uprobe_perf_filter() into uretprobe_perf_func() as your patch did.

Then we can probably change uprobe_handle_trampoline() to do
unapply_uprobe() if all the ret-handlers return UPROBE_HANDLER_REMOVE, like
handler_chain() does.

Then we can probably cleanup/simplify trace_uprobe.c, in partucular we can
change alloc_trace_uprobe()

-	tu->consumer.handler = uprobe_dispatcher;
-	if (is_ret)
-		tu->consumer.ret_handler = uretprobe_dispatcher;
+	if (is_ret)
+		tu->consumer.ret_handler = uretprobe_dispatcher;
+	else
+		tu->consumer.handler = uprobe_dispatcher;

and do more (including unrelated) cleanups.

But lets do this step-by-step.

And lets not mix the filtering issues with the UPROBE_HANDLER_REMOVE logic,
to me this adds the unnecessary confusion.

Oleg.


