Return-Path: <bpf+bounces-38101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C8195FBA2
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 23:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24098B20FB3
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 21:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F16019A285;
	Mon, 26 Aug 2024 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6NEXiuY"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C6180034
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707577; cv=none; b=Wg15aEBK1o8jUt2Lh+lirjb3CYzgAoRd6V//fceHLi3rMazhMyF0htv80YtlG0IaxXzA5c+A1tF69jO4jM0WDkZRDofSm7gQF56Q7pEh+hpgDBfCNUXnQEy1Fu65HsMkQuu71QPz9Xuge9q8JMYSFmofbhCQJ0ALStk8yqKHMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707577; c=relaxed/simple;
	bh=0HdIrEdt6F7zMMrKlK1HeSmZZr7Z5zQHIi+8ZraZMj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+xZx/KkhyLAD9CdGwB+sdD05H4j320msvYa+kT63KLzA5Yl77z3VD2x9401JBVxXy3lcp8vUiMTqNZoA6DvjBh+vgNuq+KRpjlm5NVUQPDIvh9MLBeNgW/M3IXtFuz/6Yuj+Xb8Uu++0pUeLsUx9TcJJm0QVDAPPIOCDp8JSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6NEXiuY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724707574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mp+i6OnWqZmz73jqS30Ii67cSxKvB665uBBccc5w/Ls=;
	b=O6NEXiuYdzGv9skrWTXjIsRV7f7JCo/tRi/Q/X/el6b4rBgglM6m848FYSxse8T6KXcIhL
	ZhNHp3puGQ5OubMBP6jg5LsiKaAWvhLmfxnHmTv4Uh/fAXhUqGmNVSgCKCwiU4d/Zgq/Gh
	lFwC7yzAASZWEE/GK3TR3JwwVv7dHZY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-Ka24R244MTCeQkU1InhdSA-1; Mon,
 26 Aug 2024 17:26:07 -0400
X-MC-Unique: Ka24R244MTCeQkU1InhdSA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B9BA1955BF1;
	Mon, 26 Aug 2024 21:26:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id F32F319560AA;
	Mon, 26 Aug 2024 21:26:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 26 Aug 2024 23:25:58 +0200 (CEST)
Date: Mon, 26 Aug 2024 23:25:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tianyi Liu <i.pear@outlook.com>, andrii.nakryiko@gmail.com,
	mhiramat@kernel.org, ajor@meta.com, albancrequy@linux.microsoft.com,
	bpf@vger.kernel.org, flaniel@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240826212552.GB30765@redhat.com>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
 <ZsyHrhG9Q5BpZ1ae@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsyHrhG9Q5BpZ1ae@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This is offtopic, sorry for the spam, but...

On 08/26, Jiri Olsa wrote:
>
> On Mon, Aug 26, 2024 at 01:57:52PM +0200, Oleg Nesterov wrote:
> >
> > Does bpftrace use bpf_uprobe_multi_link_attach/etc ? I guess not...
> > Then which userspace tool uses this code? ;)
>
> yes, it will trigger if you attach to multiple uprobes, like with your
> test example with:
>
>   # bpftrace -p xxx -e 'uprobe:./ex:func* { printf("%d\n", pid); }'

Hmm. I reserved the testing machine with fedora 40 to play with bpftrace.

dummy.c:

	#include <unistd.h>

	void func1(void) {}
	void func2(void) {}

	int main(void) { for (;;) pause(); }

If I do

	# ./dummy &
	# bpftrace -p $! -e 'uprobe:./dummy:func* { printf("%d\n", pid); }'

and run

	# bpftrace -e 'kprobe:__uprobe_register { printf("%s\n", kstack); }'

on another console I get

	Attaching 1 probe...

        __uprobe_register+1
        probe_event_enable+399
        perf_trace_event_init+440
        perf_uprobe_init+152
        perf_uprobe_event_init+74
        perf_try_init_event+71
        perf_event_alloc+1681
        __do_sys_perf_event_open+447
        do_syscall_64+130
        entry_SYSCALL_64_after_hwframe+118

        __uprobe_register+1
        probe_event_enable+399
        perf_trace_event_init+440
        perf_uprobe_init+152
        perf_uprobe_event_init+74
        perf_try_init_event+71
        perf_event_alloc+1681
        __do_sys_perf_event_open+447
        do_syscall_64+130
        entry_SYSCALL_64_after_hwframe+118

so it seems that bpftrace doesn't use bpf_uprobe_multi_link_attach()
(called by sys_bpf(BPF_LINK_CREATE) ?) in this case.

But again, this is offtopic, please forget.

Oleg.


