Return-Path: <bpf+bounces-38109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAF495FCC9
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 00:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51DF9B2214C
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 22:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AD419D886;
	Mon, 26 Aug 2024 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pdt5xlTJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E566519D075
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711400; cv=none; b=U3qmIgadhMCvVpDhJOH1w8vt7EdOLYOknEvo8YDGD8+qG95ltdguGBk5s/on2IuLBC40u2/YT3/g1CoEY7wst//BzzmGiYczgS4oKMScyKyPHeZL5iMBoWUZDmDXsXGr+/36OBX/ajg+NqUtRDYkHX4/AVDYFp25fVXmEOS7MyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711400; c=relaxed/simple;
	bh=HHniaaAUEh5qGDsKVQdFWKGpTLx/jtr723PMPK9bfAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD2kHIOdwipTqufy7FTmKEZKJg8C8m5BrtNSnLyGJZa8uanTzngizNu8YD7sSUFZKmaUucfofLm95VwDwFG1qYZzjmqTAUxGD1aoKgzyiVfpWmDZdF2ZhXi/WZ5JmjWeUviBeEh+1IvGScv9JsQ/9Bn/yBPsYKgMs5uWXboWhGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pdt5xlTJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724711397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k8lSeaX0Pdb7iUyeqcM9bZY3oSQ8CGTkXO2gXKHf45Q=;
	b=Pdt5xlTJhyvAVZnOQSzdYPm1ZmZBUbvBg72OTW1bICmNAOqJAyKHT4YSJXVmGIIaqSHpFX
	cchdiYp9qkqJHropp9iTgZthGhNN4/kGOSMRV3Qu9WuWcyvnI0bsJSatiCbUJR/uZR5UqG
	WzBhiqOJjfysiwQDmWZlCeMKJ2mwqfM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-NbuyYXxMNqmLR9TCMx9Rwg-1; Mon,
 26 Aug 2024 18:29:52 -0400
X-MC-Unique: NbuyYXxMNqmLR9TCMx9Rwg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C21519560A6;
	Mon, 26 Aug 2024 22:29:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5741219560A3;
	Mon, 26 Aug 2024 22:29:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 27 Aug 2024 00:29:43 +0200 (CEST)
Date: Tue, 27 Aug 2024 00:29:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tianyi Liu <i.pear@outlook.com>, andrii.nakryiko@gmail.com,
	mhiramat@kernel.org, ajor@meta.com, albancrequy@linux.microsoft.com,
	bpf@vger.kernel.org, flaniel@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240826222938.GC30765@redhat.com>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
 <ZsyHrhG9Q5BpZ1ae@krava>
 <20240826212552.GB30765@redhat.com>
 <Zsz7SPp71jPlH4MS@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsz7SPp71jPlH4MS@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/27, Jiri Olsa wrote:
>
> did you just bpftrace-ed bpftrace? ;-) on my setup I'm getting:
>
> [root@qemu ex]# ../bpftrace/build/src/bpftrace -e 'kprobe:uprobe_register { printf("%s\n", kstack); }'
> Attaching 1 probe...
>
>         uprobe_register+1

so I guess you are on tip/perf/core which killed uprobe_register_refctr()
and changed bpf_uprobe_multi_link_attach() to use uprobe_register

>         bpf_uprobe_multi_link_attach+685
>         __sys_bpf+9395
>         __x64_sys_bpf+26
>         do_syscall_64+128
>         entry_SYSCALL_64_after_hwframe+118
>
>
> I'm not sure what's bpftrace version in fedora 40, I'm using upstream build:

bpftrace v0.20.1

> [root@qemu ex]# ../bpftrace/build/src/bpftrace --info 2>&1 | grep uprobe_multi
>   uprobe_multi: yes

Aha, I get

	uprobe_multi: no

OK. So, on your setup bpftrace uses bpf_uprobe_multi_link_attach()
and this implies ->ret_handler = uprobe_multi_link_ret_handler()
which calls uprobe_prog_run() which does

	if (link->task && current->mm != link->task->mm)
		return 0;

So, can you reproduce the problem reported by Tianyi on your setup?

Oleg.


