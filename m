Return-Path: <bpf+bounces-39113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B356496F1CE
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 12:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A3B283A16
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 10:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A251C9EDE;
	Fri,  6 Sep 2024 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUIzAHHV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49CE1CA681;
	Fri,  6 Sep 2024 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619440; cv=none; b=isQSCYbI5lQ7aSCjZgH6/NYm5Ezw+p4HHDOapzceVZFK4fFshXo9aBQw0dL11M5xGttS45/RgLfGd6cP3h6Ib7jUna9FYgjRFv2/YO1Gh55ACIbRjKTydSpJDLE0S6bnT7OAHVVdxm0M2eILICJTFZ1Zhik6LLCJATSjtTluPQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619440; c=relaxed/simple;
	bh=13npiUXkwzfOJhB2JYCOAs1r7RUHLxbpwFYaaeb2vzk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMjzkhPMrpVl5aJ2AhZPXGNhLJGoOjGn6Uls7AGsKJFSdAB9CSHGGJTTQUtd8XQjS55HxoVl9pHHZVHDGYRiDvDdvZO+Jyu/RX/SYgzVwp3ohq545T+pVjfjeiZQk4KzQ344YRGw9py6M1zs/EEzHiHceJaPkxYgz/K07ksA9h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUIzAHHV; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so241989066b.2;
        Fri, 06 Sep 2024 03:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725619437; x=1726224237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=spvOS79qgV8mwzDrAPlFYte3fxVRs14tTqtz5RwNSig=;
        b=nUIzAHHVmqFQMidY/AG/XrhnbPkqPxoa7VaU+FZUliXYp41ju8CwRvesy8JCWQ1fu5
         B8rmFBaQoS1wMPDxdDzVMV2a88SZR0jHDQ71SBPW3d4UmcOux6flOKOYgUBpc+xWVq1y
         v+yIkEKAWHv3yH5++sxiWPHjj22rz6xzt/ZK7LWQ9LYmaiPG33grwOzJGqmx5552CzF+
         WHZqTGf5mlmsMRynVFyp2e0hMZCnF0ZTY/RsabQJZTGstKH+GnvSK556zYiIchrRu4vA
         AlwBaiQzuPpnZGFTQJRHCXFxeCGKDbhw6As2z0qS6AzKDKy2Qxr5QqC5QPEy3hkxMlAp
         q1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725619437; x=1726224237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spvOS79qgV8mwzDrAPlFYte3fxVRs14tTqtz5RwNSig=;
        b=bwiD/o/k+r+2bgUBsqpOv64zmvyAd4THCRyUFGVA1FRsMKXz79QMct4Z+AjaU3JAWB
         Sqnf6XAQNPZs2zGcRwWQC8WGhaRKIlgWjl1CaM5/YiB+RJbm7P4YBjc9eCzyw38e0i4D
         8bbfdHug51oZJZYEeMluqhidQj1r670ii+gssb9YchCeKVf9O1BvaWm4vCS+KnoWUYKD
         SbzWGjXfX6Im0hsltmKV8ngAaHMDLDCyRNLASLheCrhmnXb9QGAJdFIl7A//03k0wLr3
         8vlpkq+N5V/Ym4MmsCvG3LZp3dsab8ymj09EN6kVAdck23WA4Gpj1yYTurJEiymdOKNU
         EMqw==
X-Forwarded-Encrypted: i=1; AJvYcCW61lFfuIDeYqBSx11Bb0gO72jIvYitfxQNQGdlnh8IMXuomH7xJRidPryiQZlpca5ebvs=@vger.kernel.org, AJvYcCWqyAV5Dkc9rdF78gwDZ5qd6xac1NjqouxLP6/Cjx6yixOVhBtJsYDJ1H36O0pmgZW4HBbswa5koU9Hwakn4EG/Ikw9@vger.kernel.org
X-Gm-Message-State: AOJu0YweKJABcDOZus7vDpb52kFidyz30CXa8J4F24NPhApTRe7cpsr0
	RfCSv0ukGf0Ys2OHy+RHBer2klCNgzYSwoymz4dJkopOZkxshNVW
X-Google-Smtp-Source: AGHT+IGF0IUxNM3e70nukpQtSAEDAp1EvV2pfVwvWH4IZNbBvSWHu/Eh41pR4qmGQemTIMq/mmuz9g==
X-Received: by 2002:a17:906:d54e:b0:a86:b6ee:8747 with SMTP id a640c23a62f3a-a8a888722a4mr162280066b.43.1725619436544;
        Fri, 06 Sep 2024 03:43:56 -0700 (PDT)
Received: from krava ([87.202.122.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a7dc91806sm144302066b.42.2024.09.06.03.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:43:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Sep 2024 13:43:53 +0300
To: Tianyi Liu <i.pear@outlook.com>
Cc: oleg@redhat.com, ajor@meta.com, albancrequy@linux.microsoft.com,
	andrii.nakryiko@gmail.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <Ztrc6eJ14M26xmvr@krava>
References: <20240830101209.GA24733@redhat.com>
 <ME0P300MB0416522C59231B4127E23C6F9D912@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME0P300MB0416522C59231B4127E23C6F9D912@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>

On Mon, Sep 02, 2024 at 03:22:25AM +0800, Tianyi Liu wrote:
> On Fri, Aug 30, 2024 at 18:12:41PM +0800, Oleg Nesterov wrote:
> > The whole discussion was very confusing (yes, I too contributed to the
> > confusion ;), let me try to summarise.
> > 
> > > U(ret)probes are designed to be filterable using the PID, which is the
> > > second parameter in the perf_event_open syscall. Currently, uprobe works
> > > well with the filtering, but uretprobe is not affected by it.
> > 
> > And this is correct. But the CONFIG_BPF_EVENTS code in __uprobe_perf_func()
> > misunderstands the purpose of uprobe_perf_filter().
> > 
> > Lets forget about BPF for the moment. It is not that uprobe_perf_filter()
> > does the filtering by the PID, it doesn't. We can simply kill this function
> > and perf will work correctly. The perf layer in __uprobe_perf_func() does
> > the filtering when perf_event->hw.target != NULL.
> > 
> > So why does uprobe_perf_filter() call uprobe_perf_filter()? Not to avoid
> > the __uprobe_perf_func() call (as the BPF code assumes), but to trigger
> > unapply_uprobe() in handler_chain().
> > 
> > Suppose you do, say,
> > 
> > 	$ perf probe -x /path/to/libc some_hot_function
> > or
> > 	$ perf probe -x /path/to/libc some_hot_function%return
> > then
> > 	$perf record -e ... -p 1
> > 
> > to trace the usage of some_hot_function() in the init process. Everything
> > will work just fine if we kill uprobe_perf_filter()->uprobe_perf_filter().
> > 
> > But. If INIT forks a child C, dup_mm() will copy int3 installed by perf.
> > So the child C will hit this breakpoint and cal handle_swbp/etc for no
> > reason every time it calls some_hot_function(), not good.
> > 
> > That is why uprobe_perf_func() calls uprobe_perf_filter() which returns
> > UPROBE_HANDLER_REMOVE when C hits the breakpoint. handler_chain() will
> > call unapply_uprobe() which will remove this breakpoint from C->mm.
> > 
> > > We found that the filter function was not invoked when uretprobe was
> > > initially implemented, and this has been existing for ten years.
> > 
> > See above, this is correct.
> > 
> > Note also that if you only use perf-probe + perf-record, no matter how
> > many instances, you can even add BUG_ON(!uprobe_perf_filter(...)) into
> > uretprobe_perf_func(). IIRC, perf doesn't use create_local_trace_uprobe().
> > 
> 
> Thanks for the detailed explanation above, I can understand the code now. 
> Yes, I completely misunderstood the purpose of uprobe_perf_filter, 
> sorry for the confusion.
> 
> > ---------------------------------------------------------------------------
> > Now lets return to BPF and this particular problem. I won't really argue
> > with this patch, but
> > 
> > 	- Please change the subject and update the changelog,
> > 	  "Fixes: c1ae5c75e103" and the whole reasoning is misleading
> > 	  and wrong, IMO.
> > 
> > 	- This patch won't fix all problems because uprobe_perf_filter()
> > 	  filters by mm, not by pid. The changelog/patch assumes that it
> > 	  is a "PID filter", but it is not.
> > 
> > 	  See https://lore.kernel.org/linux-trace-kernel/20240825224018.GD3906@redhat.com/
> > 	  If the traced process does clone(CLONE_VM), bpftrace will hit the
> > 	  similar problem, with uprobe or uretprobe.
> > 
> > 	- So I still think that the "right" fix should change the
> > 	  bpf_prog_run_array_uprobe() paths somehow, but I know nothing
> > 	  about bpf.
> 
> I agree that this patch does not address the issue correctly. 
> The PID filter should be implemented within bpf_prog_run_array_uprobe, 
> or alternatively, bpf_prog_run_array_uprobe should be called after 
> perf_tp_event_match to reuse the filtering mechanism provided by perf.
> 
> Also, uretprobe may need UPROBE_HANDLER_REMOVE, similar to uprobe.
> 
> For now, please forget the original patch as we need a new solution ;)

hi,
any chance we could go with your fix until we find better solution?

it's simple and it fixes most of the cases for return uprobe pid filter
for events with bpf programs.. I know during the discussion we found
that standard perf record path won't work if there's bpf program
attached on the same event, but I think that likely it needs more
changes and also it's not a common use case

would you consider sending another version addressing Oleg's points
for changelog above?

thanks,
jirka

