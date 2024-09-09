Return-Path: <bpf+bounces-39306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C32497158A
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 12:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4532D2830DC
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 10:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607DF1B3735;
	Mon,  9 Sep 2024 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVqSm8C6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E112B17C;
	Mon,  9 Sep 2024 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878510; cv=none; b=ATHkaZLiaYUvg8cgD+/UjNG1MODzPMfLqqGFtpETGCUlV0EmtuD4G1tNv8Sc93nxAMnDF9Og+1SUGzT6ndOgOd02+iEcP6k2eB7LvCQH0SBh+yusdxN3pJLWlSQjeAB481UnKBoI19wfnLVIuJNqSCDnLJw8UZN8ID7o1mU2aMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878510; c=relaxed/simple;
	bh=4F2K3PJb/sTiiCziNyfybzvUGtifg0l9CX0rODG2ays=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuYX75H37fviCO0UbdI+H7ZpB46rwI3hNZgMpXeDfzBOAHDwd8mTeXfvFXzdqxHg82aakSL556niiAsXlRDY3/O0Rx/f5F7KM8wYDupuY/wIThw/EA05wMCyx01jOJuvtzfZ8lN6G3uqmIpIA9AP854PJSTAcJgvfH+uQhAvSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVqSm8C6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3780c8d689aso2552820f8f.0;
        Mon, 09 Sep 2024 03:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725878507; x=1726483307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LqD7fhWktGrQAwEw33LCjGbevAX8S0JvzTZFi6oUaDg=;
        b=UVqSm8C67xB4G/tPAyKiWmRrlwPKF0V6eFYmAmWTylpzBouuE/W9Ut4DEiGvrxr6I9
         +fRFs/MhACrslbUfuzG/bKiqaQqQ/5EXWen4bcUG4dOPpCtMrbDHAs1ISovzmApq6gV5
         9obyXCskDdfJGMN1mFvWBWeOP0j499D8TeFCZ9TFaahr7mOCMOZtZq6FuVMhe4zOBnt1
         aMZ/QF4aPTwByplBMmKNIwV5OcTPaAtS1/egtH/Aol/bJSFkSMQxQDxDPHk4qaf64jmi
         jf12kkg8MvlFI27m6+jSLEHQ3iBvISJs3o8gbyEeB9haau6Vytqp1HvUrn1ZPaqFWII+
         bwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725878507; x=1726483307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqD7fhWktGrQAwEw33LCjGbevAX8S0JvzTZFi6oUaDg=;
        b=HMChvv2ySTs52jMt69N4cV7zxVdanaHHqvrdl05WXlHxX258RDxFX+yNNwJnSf9EdE
         luIFCpcrervsfF7TXrydp6MEYqzEFRJDgWYWzAPjkTfg19pNQmq3mH73u8W/CAYLEJaJ
         1u24M2DEaRId43iKn+yI8CxsbRZBXYrORZpT5ZJKdfkQ/BAgLDIR+f1c+h7lpBm9oKPo
         wDF3qr+Et0mEr+WI04KNo7+boh2+VeASE6Yz5CoK+M8vxPnWEFvZ1oqtuChJcBvEDy9d
         6MKNab3NgpwJDabFVGinrmVg8l51zH14uPx3EAilfLUdCQTd9hRitm9Q2TbgLadqjkkN
         +UUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb6k+BlrBgCqOvg6UGBznQGbvnuDM7GslFcFavpnPQbhAc50t/uo+0kc0ODEZ5Lpr/hRc8suAkJsBrVreUYFu0bBIt@vger.kernel.org, AJvYcCXcxVVIw+aN/8cJ0kNz4f+1S1dXuwsKhm0K4KgDtjdtUZXnsQxz0s9DI+5Hu3F22cpSzTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVxhcxrYVZRpEpj/Mf6QxAX1FbDyFWmL0GxPg0A/O/8JJ5xV8C
	lmP/UPgFU4cOg+nmYKahPnnQMndCFardQ0fYnm61fSDe19tgRudt
X-Google-Smtp-Source: AGHT+IHWOMLNOUA8AanWJfjAfDQt6qlw7krWJJ6W4rxpNoODB4o9cgMu7ECH6ct6l21UwTMxU2xUmw==
X-Received: by 2002:a5d:4011:0:b0:371:8a91:9e72 with SMTP id ffacd0b85a97d-378895de6c8mr6407999f8f.30.1725878507162;
        Mon, 09 Sep 2024 03:41:47 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895676117sm5688691f8f.60.2024.09.09.03.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 03:41:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 9 Sep 2024 12:41:44 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tianyi Liu <i.pear@outlook.com>,
	ajor@meta.com, albancrequy@linux.microsoft.com,
	andrii.nakryiko@gmail.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, rostedt@goodmis.org,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <Zt7Q6GVKtGTIdO1g@krava>
References: <20240830101209.GA24733@redhat.com>
 <ME0P300MB0416522C59231B4127E23C6F9D912@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <Ztrc6eJ14M26xmvr@krava>
 <20240906191814.GB17874@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906191814.GB17874@redhat.com>

On Fri, Sep 06, 2024 at 09:18:15PM +0200, Oleg Nesterov wrote:
> On 09/06, Jiri Olsa wrote:
> >
> > On Mon, Sep 02, 2024 at 03:22:25AM +0800, Tianyi Liu wrote:
> > >
> > > For now, please forget the original patch as we need a new solution ;)
> >
> > hi,
> > any chance we could go with your fix until we find better solution?
> 
> Well, as I said from the very beginning I won't really argue even if
> I obviously don't like this change very much. As long as the changelog /
> comments clearly explain this change. I understand that sometimes an
> ugly/incomplete/whatever workaround is better than nothing.
> 
> > it's simple and it fixes most of the cases for return uprobe pid filter
> > for events with bpf programs..
> 
> But to remind it doesn't even fixes all the filtering problems with uprobes,
> not uretprobes,
> 
> > I know during the discussion we found
> > that standard perf record path won't work if there's bpf program
> > attached on the same event,
> 
> Ah. Yes, this is another problem I tried to point out. But if we discuss
> the filtering we can forget about /usr/bin/perf.
> 
> Again, again, again, I know nothing about bpf. But it seems to me that
> perf_event_attach_bpf_prog() allows to attach up to BPF_TRACE_MAX_PROGS
> progs to event->tp_event->prog_array, and then bpf_prog_run_array_uprobe()
> should run them all. Right?
> 
> So I think that if you run 2 instances of run_prog from my last test-case
> with $PID1 and $PID2, the filtering will be broken again. Both instances
> will share the same trace_event_call and the same trace_uprobe_filter.
> 
> > and also it's not a common use case
> 
> OK.
> 
> And btw... Can bpftrace attach to the uprobe tp?
> 
> 	# perf probe -x ./test -a func
> 	Added new event:
> 	  probe_test:func      (on func in /root/TTT/test)
> 
> 	You can now use it in all perf tools, such as:
> 
> 		perf record -e probe_test:func -aR sleep 1
> 
> 	# bpftrace -e 'tracepoint:probe_test:func { printf("%d\n", pid); }'
> 	Attaching 1 probe...
> 	ioctl(PERF_EVENT_IOC_SET_BPF): Invalid argument
> 	ERROR: Error attaching probe: tracepoint:probe_test:func

the problem here is that bpftrace assumes BPF_PROG_TYPE_TRACEPOINT type
for bpf program, but that will fail in perf_event_set_bpf_prog where
perf event will be identified as uprobe and demands bpf program type
to be BPF_PROG_TYPE_KPROBE

there's same issue with kprobe as well:

	# perf probe -a ksys_read
	Added new event:
	  probe:ksys_read      (on ksys_read)

	You can now use it in all perf tools, such as:

		perf record -e probe:ksys_read -aR sleep 1


	# bpftrace -e 'tracepoint:probe:ksys_read { printf("%d\n", pid); }'
	Attaching 1 probe...
	ioctl(PERF_EVENT_IOC_SET_BPF): Invalid argument
	ERROR: Error attaching probe: tracepoint:probe:ksys_read

I'm not sure there's an easy way to filter these events from bpftrce -l
output (or change the program type accordingly), because I don't think
there's a way to find out the tracepoint subtype (kprobe/uprobe) from
the tracefs record

jirka

