Return-Path: <bpf+bounces-38181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7050496148F
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 18:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C951285E1C
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 16:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1889A1D174E;
	Tue, 27 Aug 2024 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxpGxBJ/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2331A1CE717
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777166; cv=none; b=LOKKYjQXL+jk6LNVpwXqxBVqYYWQoGlf6KJMl2TaQ6RepnTShIhlRvqvmHPjiVOk5SHonKMZdZs1d+Ot8hMm+RGo15e9o9YnjQvIyl05jD6mb8zAFTovJzLOPf0x0oASHwdbqLH/DOTYlzk6UQ9Zu6PKW59oPAS/SabYd1xjTAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777166; c=relaxed/simple;
	bh=d9Fr3NcwL3t4o7X3APqAvaGwag60bZC6xiNydmzZlo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqGLGamRfogUt2UE6udkQ1CXOvEk+Xv81lMpMNAJhxItJbpcqFCsgT+yCadpbPyIkZBw1rLoq6ZW8PkoKMVI/YVE47RhKDJmnS+eSWxvGG/oFb1Y45A+hq2XOL+jnivFvUHOOO1wfxrqzqv850LEHnxBetpR7BNHstejZJfm/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YxpGxBJ/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724777162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHmgL5Ri1428SeB/3V7FF9Ht7PO33EShpSKr8jku7Xs=;
	b=YxpGxBJ/CdPqtaKBs5mtHfOyK8RJ3oc8aSrYZOIdfBxD6KQ4amZcTd4o66zwpHy73FbK1n
	LFYPuVNRlxGfH/jbsjax+hsMtD9jb4wGlhTtUtY8a/MRrxUoj7eqtNt2rYCzcIxRqjp9Wi
	kwN7d0poZl/U/x1tn31m4Yi8efqyzmM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-RHXOpT3_N_mW-7cjBc_1GA-1; Tue,
 27 Aug 2024 12:46:00 -0400
X-MC-Unique: RHXOpT3_N_mW-7cjBc_1GA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7A061955BF4;
	Tue, 27 Aug 2024 16:45:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B18C91956052;
	Tue, 27 Aug 2024 16:45:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 27 Aug 2024 18:45:51 +0200 (CEST)
Date: Tue, 27 Aug 2024 18:45:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tianyi Liu <i.pear@outlook.com>, andrii.nakryiko@gmail.com,
	mhiramat@kernel.org, ajor@meta.com, albancrequy@linux.microsoft.com,
	bpf@vger.kernel.org, flaniel@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240827164545.GG30765@redhat.com>
References: <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
 <ZsyHrhG9Q5BpZ1ae@krava>
 <20240826212552.GB30765@redhat.com>
 <Zsz7SPp71jPlH4MS@krava>
 <20240826222938.GC30765@redhat.com>
 <Zs3PdV6nqed1jWC2@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs3PdV6nqed1jWC2@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/27, Jiri Olsa wrote:
>
> On Tue, Aug 27, 2024 at 12:29:38AM +0200, Oleg Nesterov wrote:
> >
> > So, can you reproduce the problem reported by Tianyi on your setup?
>
> yes, I can repduce the issue with uretprobe on top of perf event uprobe

...

>    ->     uretprobe-hit
>             handle_swbp
>               uprobe_handle_trampoline
>                 handle_uretprobe_chain
>                 {
>
>                   for_each_uprobe_consumer {
>
>                     // consumer for task 1019
>                     uretprobe_dispatcher
>                       uretprobe_perf_func
>                         -> runs bpf program
>
>                     // consumer for task 1018
>                     uretprobe_dispatcher
>                       uretprobe_perf_func
>                         -> runs bpf program

Confused...

I naively thought that if bpftrace uses bpf_uprobe_multi_link_attach() then
it won't use perf/trace_uprobe, and uretprobe-hit will result in

	// current->pid == 1018

	for_each_uprobe_consumer {
		// consumer for task 1019
		uprobe_multi_link_ret_handler
		    uprobe_prog_run
		       -> current->mm != link->task->mm, return

		// consumer for task 1018
		uprobe_multi_link_ret_handler
		    uprobe_prog_run
		       -> current->mm == link->task->mm, run bpf
	}

> I think the uretprobe_dispatcher could call filter as suggested in the original
> patch..

OK, agreed.

> but I'm not sure we need to remove the uprobe from handle_uretprobe_chain
> like we do in handler_chain..

Me too. In any case this is another issue.

Oleg.


