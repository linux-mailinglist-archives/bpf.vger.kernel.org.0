Return-Path: <bpf+bounces-38097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C89395F947
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 20:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE941C220C8
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 18:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2EA198A17;
	Mon, 26 Aug 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJgRDtYW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7BB8248C
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724698588; cv=none; b=P3awCMkRDQkhbRCqln/IR5BX0jbqoKDl6TG4CnP/AkzCmkhm5d0zQWLkmZb+GmKLNN8IDdSixw2wYK0hA6HxpEHMsoPvwGfLZW12c0fYVnd+wr8B6I/kcfdrbarkhfv1nNb4Jud8+mNybEmy1F8RVjhcNtfNVFh3W8aJ9U28A9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724698588; c=relaxed/simple;
	bh=uTx3FtJp3TN7FEQU2MiCr3rrG5nAir3/iTkGRBvvzMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQTmIjJe4Z1SusIN7Fecc7x2RYOfrvWVCzLFJ2S0l8W9x2StT5KnN0aJfpvZTvgdUXQTINlZNDHkcd50FFZZsFE7ACKJzafUSfNGwNe+IPNv27xSp7HhuQ4CG4tqr7EvuxUjfy4PtekLrKIdFNFne35gycrBNLXhmPt4UhwSzZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJgRDtYW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724698583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ElsBu4kEMzW/PcKFqW1p4cszS0HL64jlWRpoVtBDhPs=;
	b=jJgRDtYW8RD4QDlXdwFdK66wqsiPG0MOIaSz4t2aBP6qVgaAsKMxkdzUsvWBcpgCF6Gw/Z
	f+X1AlnT2X2C/MQ/c9ZZW08kGuzcq4myl7hC3EyumAKzxxZ63rzldMvjmGHSqAMI9e9JcO
	FeXIcGfVl4mVZ5rZO74YQufZpn5DXGw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-VAvVz0ZuPT-YFf2F-75zdw-1; Mon,
 26 Aug 2024 14:56:19 -0400
X-MC-Unique: VAvVz0ZuPT-YFf2F-75zdw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EC641955D55;
	Mon, 26 Aug 2024 18:56:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4AB2F19560A3;
	Mon, 26 Aug 2024 18:56:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 26 Aug 2024 20:56:10 +0200 (CEST)
Date: Mon, 26 Aug 2024 20:56:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tianyi Liu <i.pear@outlook.com>, andrii.nakryiko@gmail.com,
	mhiramat@kernel.org, ajor@meta.com, albancrequy@linux.microsoft.com,
	bpf@vger.kernel.org, flaniel@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240826185604.GA30765@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/26, Jiri Olsa wrote:
>
> On Mon, Aug 26, 2024 at 01:57:52PM +0200, Oleg Nesterov wrote:
> > On 08/26, Jiri Olsa wrote:
> > >
> > > > But "perf-record -p" works as expected.
> > >
> > > I wonder it's because there's the perf layer that schedules each
> > > uprobe event only when its process (PID1/2) is scheduled in and will
> > > receive events only from that cpu while the process is running on it
> >
> > Not sure I understand... The task which hits the breakpoint is always
> > current, it is always scheduled in.
>
> hum, I might be missing something, but ;-)

No it is me ;) at least I certainly misunderstood your "scheduled in".

> assuming we have 2 tasks, each with perf uprobe event assigned
>
> in perf path there's uprobe_perf_func which calls the uprobe_perf_filter
> and if it returns true it then goes:
>
>   uprobe_perf_func
>     __uprobe_perf_func
>       perf_trace_buf_submit
>         perf_tp_event
>         {
>
>            hlist_for_each_entry_rcu(event, head, hlist_entry) {
>              if (perf_tp_event_match(event, &data, regs)) {
>                 perf_swevent_event(event, count, &data, regs);

Aha. So, in this particular case, when the CLONE_VM child hits the bp
and calls uprobe_perf_func(), even perf_tp_event_match() won't be called,
head is hlist_empty(), right?

Thanks!

> in comparison with uprobe_multi path, where uprobe_multi_link_filter

Yeah, this is clear.

> > IIUC (but I am not sure), perf-record -p will work "correctly" even if we
> > remove uprobe_perf_filter() altogether. IIRC the perf layer does its own
> > filtering but I forgot everything.
>
> I think that's what I tried to describe above

Yes, thanks.

Oleg.


