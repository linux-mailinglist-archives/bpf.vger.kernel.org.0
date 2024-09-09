Return-Path: <bpf+bounces-39338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BBB9721E5
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 20:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795D91F241D4
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 18:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEE3188CDE;
	Mon,  9 Sep 2024 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PikwtJW2"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1056446
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725906902; cv=none; b=G/s946YFgrqZy0a/w83J2O36Njd+yYIkD5azXemUus39OhsYaR7VK/s8VKZdkUPAW6EmSbHS4DXM3oBm7YnQfA4Mk+XUP3HlCuQkyJG8Pqz0JsMogBAqMyex24oDWxe7lctFWJ9y1UFmhqF9EbR6cH9elrwPQpEPl8J3nwdui58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725906902; c=relaxed/simple;
	bh=Gj4bfxjnChu7LPauy6tK52dNHXNEhiNDpxXWpDU9OYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bO0wIMbAijQOUtMk0ni3LITArq3Ve4y1sViV4zW75uMoji/TCRMGQXxclkd3k+fEgjglbk/3Depg8XC6wc+3vL3LLpmxTUdFLJRtdUQujJgKOoqugl7aAr4269w65OW21PTd8FSYTdCoGqhY/78qfIU69DV0mCf/cXvjl2XOUqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PikwtJW2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725906899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u67DfEbyCrF6Qitp5l77mbP+q6a/yy862y2hfMz2Mjc=;
	b=PikwtJW28NXt8NleWuRu4MYFwSp4gWl5kb12eXiinKP9FNzLLX5cAHZaiHStcoqAYi6um/
	isVWG4EbKnHW5utb3tt/UQEhe1aPRO7qiaR/yIb6LeI1zCV0W9/kx2WzNA/f97G/bxSRIU
	pbPkXkYr69/NmvL7YybT6BImWSgjhIA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-beRijX9gM8mWd09wNxvYzA-1; Mon,
 09 Sep 2024 14:34:56 -0400
X-MC-Unique: beRijX9gM8mWd09wNxvYzA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F6571955EB5;
	Mon,  9 Sep 2024 18:34:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1136E1956048;
	Mon,  9 Sep 2024 18:34:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  9 Sep 2024 20:34:42 +0200 (CEST)
Date: Mon, 9 Sep 2024 20:34:36 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tianyi Liu <i.pear@outlook.com>, ajor@meta.com,
	albancrequy@linux.microsoft.com, andrii.nakryiko@gmail.com,
	bpf@vger.kernel.org, flaniel@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	rostedt@goodmis.org, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240909183436.GC14058@redhat.com>
References: <20240830101209.GA24733@redhat.com>
 <ME0P300MB0416522C59231B4127E23C6F9D912@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <Ztrc6eJ14M26xmvr@krava>
 <20240906191814.GB17874@redhat.com>
 <Zt7Q6GVKtGTIdO1g@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt7Q6GVKtGTIdO1g@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/09, Jiri Olsa wrote:
>
> On Fri, Sep 06, 2024 at 09:18:15PM +0200, Oleg Nesterov wrote:
> >
> > And btw... Can bpftrace attach to the uprobe tp?
> >
> > 	# perf probe -x ./test -a func
> > 	Added new event:
> > 	  probe_test:func      (on func in /root/TTT/test)
> >
> > 	You can now use it in all perf tools, such as:
> >
> > 		perf record -e probe_test:func -aR sleep 1
> >
> > 	# bpftrace -e 'tracepoint:probe_test:func { printf("%d\n", pid); }'
> > 	Attaching 1 probe...
> > 	ioctl(PERF_EVENT_IOC_SET_BPF): Invalid argument
> > 	ERROR: Error attaching probe: tracepoint:probe_test:func
>
> the problem here is that bpftrace assumes BPF_PROG_TYPE_TRACEPOINT type
> for bpf program, but that will fail in perf_event_set_bpf_prog where
> perf event will be identified as uprobe and demands bpf program type
> to be BPF_PROG_TYPE_KPROBE

Yes, thanks, I know,

> I don't think
> there's a way to find out the tracepoint subtype (kprobe/uprobe) from
> the tracefs record

Hmm, indeed. it seems that it is not possible to derive tp_event->flags
from tracefs...

Perhaps bpftrace could look for probe_test:func in [uk]probe_events?
Or simply retry ioctl(PERF_EVENT_IOC_SET_BPF) with BPF_PROG_TYPE_KPROBE
if BPF_PROG_TYPE_TRACEPOINT returns EINVAL? Ugly, yes.

Oleg.


