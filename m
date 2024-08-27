Return-Path: <bpf+bounces-38162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C16960C79
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 15:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E78B25A99
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DCD1C2DA1;
	Tue, 27 Aug 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EouHrS3Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A481BB6B7;
	Tue, 27 Aug 2024 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766349; cv=none; b=pWUxaoA/4tdppQUTYQGXcbkqhHdOcz7bItPyPFBX4BiuQi7K/d2f5VYyqfqCH95SXQ/pXKYVNVeN8jiFLg8C9pPGowvCh4VD9LJue6gI7iya3qC8SGD2XM9ipWEaYKRx6aguElavxFUV7TdDuIBrvCJwQVvy9MyiPSEZxA9GBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766349; c=relaxed/simple;
	bh=0PDt/VboeDuUQmvZQ4a+NTcaju3/OPSQtGXE7zRPqhQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0Cw6pohY2KzCIhtLhnhT5DAg8NDCsHDiiI9Ah0O95hHTHtf6UqK2Q35Z1M0Epy2Q1FGLx550e3hBVgslz0lT1N3S1QVFOfyAnMwwIm3uDDmfFVolveVcsPEbI0Vo6o9HTWMDuC0db2saFoQ7dS75VKQk2R1JVI4HzpmP7VNAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EouHrS3Y; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5334879ba28so6993428e87.3;
        Tue, 27 Aug 2024 06:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724766345; x=1725371145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5bnzhlJACifVhfWGB4ggwl2d+FwIGk44tWsKho3c1A=;
        b=EouHrS3YvuCIGK6hGEqE/ljLHfnh2ChBHhQwqMPG5ivlz5OYAvIcXIoU2sxS59xPgZ
         VZI1Bvez5uF7mEHlo/kH0L5PO7kLSdO5y2r02fB+SlBtthnV5+9N+zYfVJzNXvwqUUtw
         38i6iRGVY2wdHQscZyGpuXpVdzfqcJA/W/8v8Bpsn4HvdywHEP1SSUHTY0y68Me2kAGP
         1UpFxrVf1cU027i8NWW1DQnpfp+9IfjuHKu+BQ9i2N6HsJ0o0mkcec8Kz3TSU/hkLqzu
         MK5h8ijdP6y2BCxWKrhd98lH3VPNg2h6FMQj0Z1eYjhpxJk2cAkZjOoX7GX52brqNAEl
         MTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724766345; x=1725371145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5bnzhlJACifVhfWGB4ggwl2d+FwIGk44tWsKho3c1A=;
        b=Eyd0s9mf5+LwkzZG2w8tqyio3zJ1lwgGvCmkngxnFwza0UwdXyMka8bpw45urfgibr
         pf32aTsHjk06XC9NgjRI5ww5hfe0zcMXa/VH2u3RdltngTYChmDe91G/sr0oK9G3zApR
         rlv8n7/dFTVlxCchv4A8KvhuUYPDAfnntVPX+NWMHW85QOLIIWxse2Di1oiEaKO9lg88
         YD33+o6rW6nwqNsTuRuIXYuz3T5lD4T647aj0IQuAeEq9PNhsNJGycLUvxGm1DANl6hG
         1jpo6HyieZLebJdZjKcvD6S0k+RXyh/QwSdBq/7asPB3VADMim9ZnsWAW9avdfX9v2Oo
         rNOw==
X-Forwarded-Encrypted: i=1; AJvYcCWFMeluU4E4fm+P5PV8Olg0DxxlWtXWxssVvhxxY8quJTgdvimpq5ditpzHu5qtPn44b1Oppm5WBSplGs0RLTwgYo3F@vger.kernel.org, AJvYcCXIMKjQ8HRiBnbl+fOCMYhkkD/WeeMzNMYHJp0ZbefJ2JMWkCIPueJyIZII9TzrpT9d8G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYXqMPkh3orzMBnYshYdQnYDfEw5cZDRpsXbrTIMuH1WbvLiGK
	w/FEJoOhQUZ3V5fCYAD/ziKHW6NDxVaCBmz+GjKfyPF7VI0g0B9W
X-Google-Smtp-Source: AGHT+IEPahgXl/mr/ZloCxhv7bcGOHN1+0XPNZ3Oe9tOnhsSFBjLZHBD0NQ+pe+kkBw4InyQbeycmA==
X-Received: by 2002:a05:6512:2244:b0:533:4327:b4cc with SMTP id 2adb3069b0e04-534387c175cmr9378917e87.52.1724766344881;
        Tue, 27 Aug 2024 06:45:44 -0700 (PDT)
Received: from krava ([173.38.220.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e594a5d9sm110349666b.214.2024.08.27.06.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 06:45:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 27 Aug 2024 15:45:43 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Tianyi Liu <i.pear@outlook.com>,
	andrii.nakryiko@gmail.com, mhiramat@kernel.org, ajor@meta.com,
	albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <Zs3Yh1z0CtTDfw3O@krava>
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

On Tue, Aug 27, 2024 at 03:07:01PM +0200, Jiri Olsa wrote:
> On Tue, Aug 27, 2024 at 12:29:38AM +0200, Oleg Nesterov wrote:
> > On 08/27, Jiri Olsa wrote:
> > >
> > > did you just bpftrace-ed bpftrace? ;-) on my setup I'm getting:
> > >
> > > [root@qemu ex]# ../bpftrace/build/src/bpftrace -e 'kprobe:uprobe_register { printf("%s\n", kstack); }'
> > > Attaching 1 probe...
> > >
> > >         uprobe_register+1
> > 
> > so I guess you are on tip/perf/core which killed uprobe_register_refctr()
> > and changed bpf_uprobe_multi_link_attach() to use uprobe_register
> > 
> > >         bpf_uprobe_multi_link_attach+685
> > >         __sys_bpf+9395
> > >         __x64_sys_bpf+26
> > >         do_syscall_64+128
> > >         entry_SYSCALL_64_after_hwframe+118
> > >
> > >
> > > I'm not sure what's bpftrace version in fedora 40, I'm using upstream build:
> > 
> > bpftrace v0.20.1
> > 
> > > [root@qemu ex]# ../bpftrace/build/src/bpftrace --info 2>&1 | grep uprobe_multi
> > >   uprobe_multi: yes
> > 
> > Aha, I get
> > 
> > 	uprobe_multi: no
> > 
> > OK. So, on your setup bpftrace uses bpf_uprobe_multi_link_attach()
> > and this implies ->ret_handler = uprobe_multi_link_ret_handler()
> > which calls uprobe_prog_run() which does
> > 
> > 	if (link->task && current->mm != link->task->mm)
> > 		return 0;
> > 
> > So, can you reproduce the problem reported by Tianyi on your setup?
> 
> yes, I can repduce the issue with uretprobe on top of perf event uprobe
> 
> running 2 tasks of the test code:
> 
> 	int func() {
> 		return 0;
> 	}
> 
> 	int main() {
> 	    printf("pid: %d\n", getpid());
> 	    while (1) {
> 		sleep(2);
> 		func();
> 	    }
> 	}
> 
> and running 2 instances of bpftrace (each with separate pid):
> 
> 	[root@qemu ex]# ../bpftrace/build/src/bpftrace -p 1018 -e 'uretprobe:./test:func { printf("%d\n", pid); }'
> 	Attaching 1 probe...
> 	1018
> 	1017
> 	1018
> 	1017
> 
> 	[root@qemu ex]# ../bpftrace/build/src/bpftrace -p 1017 -e 'uretprobe:./test:func { printf("%d\n", pid); }'
> 	Attaching 1 probe...
> 	1017
> 	1018
> 	1017
> 	1018
> 
> will execute bpf program twice for each bpftrace instance, like:
> 
>           sched-in 1018 
>             perf_trace_add
> 
>    ->     uprobe-hit
>             handle_swbp
>               handler_chain
>               {
>                 for_each_uprobe_consumer {
> 
>                   // consumer for task 1019
>                   uprobe_dispatcher
>                     uprobe_perf_func
>                       uprobe_perf_filter return false
> 
>                   // consumer for task 1018
>                   uprobe_dispatcher
>                     uprobe_perf_func
>                       uprobe_perf_filter return true
>                        -> could run bpf program, but none is configured
>                 }
> 
>                 prepare_uretprobe
>               }
> 
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
> 
>                   }
>                 }
> 
>           sched-out 1019

ugh... should be 'sched-out 1018'

jirka

>             perf_trace_del
> 
> 
> and I think the same will happen for perf record in this case where instead of
> running the program we will execute perf_tp_event
> 
> I think the uretprobe_dispatcher could call filter as suggested in the original
> patch.. but I'm not sure we need to remove the uprobe from handle_uretprobe_chain
> like we do in handler_chain.. maybe just to save the next uprobe hit which would
> remove the uprobe?
> 
> jirka

