Return-Path: <bpf+bounces-39155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE01B96FC0C
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D361C21001
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 19:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7E31CE6F8;
	Fri,  6 Sep 2024 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKst2KhO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A88D13B584
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725650320; cv=none; b=Tl4d94Bn85EbnroUJajQgS5TWAzJkMHUUQTPA4wfRQ/chX7usMulb5lRWV+YAv+zNrqGkuTVHV1pmKe1PxHtmNSh/Qo/ITN/VHmyAcwblSs9YEQ1ZxoDeldGYJ+lLFHwtbeu7WGFQnNSNccRMpBO7tRtciZcxsfUt1lwu6Jp1W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725650320; c=relaxed/simple;
	bh=kso3KE7BAZgGTVzjhjR9Ru5FXk6aNB3R22lYAIoJ/0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGiy9ewAslxT6larYCNaFXMVXuazKQ/3Gd8SERJDtUpjx0XazU5gy0mk2hNJzip3pBwSn16q3v/kM7LYCkDksu1dxtFbADtagFg2lQLyErDXp6knSIaUTmhKuyQzKVf8LpnNfbN8DKQddhT5WEHEPGXGC3uRWjBXZHj7UFMd1mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKst2KhO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725650316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5d7QmBZWv1tq28MouZGS3appaR9B3dDPjBODFjCk0jU=;
	b=fKst2KhO/vqfMyj/QQ3jzJSN8BwS5ScE8XH/w79Z+tj9wbn4P6APL4gQOFfLyq92o9GIwG
	1/v3PEPLbS/7kU/FJ11CUTwuynxF/LUoVo22vq8DJ1x6LijQaksHEfQis/mtTG62QcS/xG
	/03SSZJ+XO5LGnaI6uc6Z9iWbWhYywQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-j62DGxljP9emUYDuWbWDoA-1; Fri,
 06 Sep 2024 15:18:35 -0400
X-MC-Unique: j62DGxljP9emUYDuWbWDoA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A57119560B2;
	Fri,  6 Sep 2024 19:18:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.54])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CC55E1955F45;
	Fri,  6 Sep 2024 19:18:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  6 Sep 2024 21:18:20 +0200 (CEST)
Date: Fri, 6 Sep 2024 21:18:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tianyi Liu <i.pear@outlook.com>, ajor@meta.com,
	albancrequy@linux.microsoft.com, andrii.nakryiko@gmail.com,
	bpf@vger.kernel.org, flaniel@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240906191814.GB17874@redhat.com>
References: <20240830101209.GA24733@redhat.com>
 <ME0P300MB0416522C59231B4127E23C6F9D912@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <Ztrc6eJ14M26xmvr@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztrc6eJ14M26xmvr@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 09/06, Jiri Olsa wrote:
>
> On Mon, Sep 02, 2024 at 03:22:25AM +0800, Tianyi Liu wrote:
> >
> > For now, please forget the original patch as we need a new solution ;)
>
> hi,
> any chance we could go with your fix until we find better solution?

Well, as I said from the very beginning I won't really argue even if
I obviously don't like this change very much. As long as the changelog /
comments clearly explain this change. I understand that sometimes an
ugly/incomplete/whatever workaround is better than nothing.

> it's simple and it fixes most of the cases for return uprobe pid filter
> for events with bpf programs..

But to remind it doesn't even fixes all the filtering problems with uprobes,
not uretprobes,

> I know during the discussion we found
> that standard perf record path won't work if there's bpf program
> attached on the same event,

Ah. Yes, this is another problem I tried to point out. But if we discuss
the filtering we can forget about /usr/bin/perf.

Again, again, again, I know nothing about bpf. But it seems to me that
perf_event_attach_bpf_prog() allows to attach up to BPF_TRACE_MAX_PROGS
progs to event->tp_event->prog_array, and then bpf_prog_run_array_uprobe()
should run them all. Right?

So I think that if you run 2 instances of run_prog from my last test-case
with $PID1 and $PID2, the filtering will be broken again. Both instances
will share the same trace_event_call and the same trace_uprobe_filter.

> and also it's not a common use case

OK.

And btw... Can bpftrace attach to the uprobe tp?

	# perf probe -x ./test -a func
	Added new event:
	  probe_test:func      (on func in /root/TTT/test)

	You can now use it in all perf tools, such as:

		perf record -e probe_test:func -aR sleep 1

	# bpftrace -e 'tracepoint:probe_test:func { printf("%d\n", pid); }'
	Attaching 1 probe...
	ioctl(PERF_EVENT_IOC_SET_BPF): Invalid argument
	ERROR: Error attaching probe: tracepoint:probe_test:func

Oleg.


