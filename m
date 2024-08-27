Return-Path: <bpf+bounces-38157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADCA960B49
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 15:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F5D28418C
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A75B1B3F33;
	Tue, 27 Aug 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+Xj1gJW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F111A0718;
	Tue, 27 Aug 2024 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764027; cv=none; b=BNezy14U7peqkXgrqDHlOFoopq+ibM6/xcOwgVIV6C2Yw+8AJSfnkhNVl8bruJML1845+Ms763XOePn/cTVZIc0RtcmWTKlFYgP9/rPKcbztceULkXTDIFaNiH8/UBCbL0DT1/qrMu/+ALDoj18FBdpsU8LXK3bSW3pAj9S6hzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764027; c=relaxed/simple;
	bh=3VIS4SJgxY3BoOP3UvHSw5EpF3L3JBps1ygaqwI327I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDqZJyw/Yion346cbBLmfK/nq3jjTYknXRPjSSdTTiWyoJGRPRo2jJzWcCcnNyQczxC3GlXzGrAe0pONuedVxxNZkcNQkNz6E54Z4d7lBWxJU36lKQqOGw2xfI1gOUrVkcySMiPYDySysfQWmwVoa9iIy2H40DHygQvQOCOqW1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+Xj1gJW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-371b97cfd6fso3503906f8f.2;
        Tue, 27 Aug 2024 06:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724764024; x=1725368824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zo7bicwV9nvu4JJBYInHIIdmiKf1keGxoGxiAxt4Qmk=;
        b=X+Xj1gJW7R1wFrenBAy9g8pzJDntcbSBpYkZ11DXe74dqhZ01FM2LZEqCSbVsRT6EJ
         gmWqY9hr8mqolF722nDiqbb2Kkc3strr9Pm2M0e7anc0O5M6r7k4yx6DwbnJT9ROP0yk
         17QI4uEqn53iqla+BVppZz/ohw+hLEJGQRD82mP97OvZACvWqSMBmC79c7dlmo5zZ0w2
         2ADl7eeMxyVz3ftb8VXDBdZhOwMdrUbUgQnnfbPnXixNPgnQBQ2mnTDPcpW6QKHN4uke
         34/A+Jhu5ZyNoqCTYyMT8sJAwj9gNDyAjaf3IDZ23emPpjp2E3Fxo2wcRPWg8Z6JmG73
         ro+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724764024; x=1725368824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo7bicwV9nvu4JJBYInHIIdmiKf1keGxoGxiAxt4Qmk=;
        b=HYp2lsZjzPWp+h6T3RWGIM5BForvivqvUtrVlSK31+RcS05r8YKp5kvf/PknyboGhv
         BCvyIe5cKkD6ImJRRIF1vyDVOt9NkmTKde0xWNDPUk8UxQzN02NByxw3kpRThUUoHszE
         StgiYW8vvjYMeZfB3FZvTqS6iB+pMpZ3mNkl98af2ISyzZeSGRjC/O1mVVHC8Qqx2HDn
         3WLGROycxwmST2UCLgmMFIcvAkP1fKAfO+qdVdSg+0AzZG6CNRoNBqGiNUTZTdW0CKNA
         z/X3Bl49G0Q/TK0a//MVGIop0n+kDmWSpgsonzhOa+k/K9Ch2Ll6/aZtxOcHWUZeBYQG
         JvPA==
X-Forwarded-Encrypted: i=1; AJvYcCU+dMNvssrrNCB7FZL0U7bC546T034x7sK8enDhQyIkb0HP2nB66zewjTtGYZDjPoM8vWE=@vger.kernel.org, AJvYcCXhPICF8Y3SNoCG0yKy/sQRWvBt5IZMb+X5WOpzeHstMhxFe6dMIIU9rcAVqeAecqFTrt4fv6vU+RqWuyMbfSZKQC1r@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLPwPcV3YYc4L/yDIABSE2zIygHPTKNSDsWeQwdvVuzlEX4E0
	dZ6kzqFZ5e5I7SwZIhDubOUNC2JvqGVgYfPVsXzs1zbGjCJX6iox
X-Google-Smtp-Source: AGHT+IHmUGtEdtV+t4mgXvnlFQuCGiW+6t4b5tguTLvmHXgi+ftBc0AnGkgL7nOZq21p6rB3lGN1OA==
X-Received: by 2002:a5d:6303:0:b0:371:8ed7:49e9 with SMTP id ffacd0b85a97d-3748c7dbc92mr1941546f8f.26.1724764023987;
        Tue, 27 Aug 2024 06:07:03 -0700 (PDT)
Received: from krava ([173.38.220.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abef81a5esm221344595e9.28.2024.08.27.06.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 06:07:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 27 Aug 2024 15:07:01 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tianyi Liu <i.pear@outlook.com>,
	andrii.nakryiko@gmail.com, mhiramat@kernel.org, ajor@meta.com,
	albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <Zs3PdV6nqed1jWC2@krava>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
 <ZsyHrhG9Q5BpZ1ae@krava>
 <20240826212552.GB30765@redhat.com>
 <Zsz7SPp71jPlH4MS@krava>
 <20240826222938.GC30765@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826222938.GC30765@redhat.com>

On Tue, Aug 27, 2024 at 12:29:38AM +0200, Oleg Nesterov wrote:
> On 08/27, Jiri Olsa wrote:
> >
> > did you just bpftrace-ed bpftrace? ;-) on my setup I'm getting:
> >
> > [root@qemu ex]# ../bpftrace/build/src/bpftrace -e 'kprobe:uprobe_register { printf("%s\n", kstack); }'
> > Attaching 1 probe...
> >
> >         uprobe_register+1
> 
> so I guess you are on tip/perf/core which killed uprobe_register_refctr()
> and changed bpf_uprobe_multi_link_attach() to use uprobe_register
> 
> >         bpf_uprobe_multi_link_attach+685
> >         __sys_bpf+9395
> >         __x64_sys_bpf+26
> >         do_syscall_64+128
> >         entry_SYSCALL_64_after_hwframe+118
> >
> >
> > I'm not sure what's bpftrace version in fedora 40, I'm using upstream build:
> 
> bpftrace v0.20.1
> 
> > [root@qemu ex]# ../bpftrace/build/src/bpftrace --info 2>&1 | grep uprobe_multi
> >   uprobe_multi: yes
> 
> Aha, I get
> 
> 	uprobe_multi: no
> 
> OK. So, on your setup bpftrace uses bpf_uprobe_multi_link_attach()
> and this implies ->ret_handler = uprobe_multi_link_ret_handler()
> which calls uprobe_prog_run() which does
> 
> 	if (link->task && current->mm != link->task->mm)
> 		return 0;
> 
> So, can you reproduce the problem reported by Tianyi on your setup?

yes, I can repduce the issue with uretprobe on top of perf event uprobe

running 2 tasks of the test code:

	int func() {
		return 0;
	}

	int main() {
	    printf("pid: %d\n", getpid());
	    while (1) {
		sleep(2);
		func();
	    }
	}

and running 2 instances of bpftrace (each with separate pid):

	[root@qemu ex]# ../bpftrace/build/src/bpftrace -p 1018 -e 'uretprobe:./test:func { printf("%d\n", pid); }'
	Attaching 1 probe...
	1018
	1017
	1018
	1017

	[root@qemu ex]# ../bpftrace/build/src/bpftrace -p 1017 -e 'uretprobe:./test:func { printf("%d\n", pid); }'
	Attaching 1 probe...
	1017
	1018
	1017
	1018

will execute bpf program twice for each bpftrace instance, like:

          sched-in 1018 
            perf_trace_add

   ->     uprobe-hit
            handle_swbp
              handler_chain
              {
                for_each_uprobe_consumer {

                  // consumer for task 1019
                  uprobe_dispatcher
                    uprobe_perf_func
                      uprobe_perf_filter return false

                  // consumer for task 1018
                  uprobe_dispatcher
                    uprobe_perf_func
                      uprobe_perf_filter return true
                       -> could run bpf program, but none is configured
                }

                prepare_uretprobe
              }

   ->     uretprobe-hit
            handle_swbp
              uprobe_handle_trampoline
                handle_uretprobe_chain
                {

                  for_each_uprobe_consumer {
                    
                    // consumer for task 1019
                    uretprobe_dispatcher
                      uretprobe_perf_func
                        -> runs bpf program

                    // consumer for task 1018
                    uretprobe_dispatcher
                      uretprobe_perf_func
                        -> runs bpf program

                  }
                }

          sched-out 1019
            perf_trace_del


and I think the same will happen for perf record in this case where instead of
running the program we will execute perf_tp_event

I think the uretprobe_dispatcher could call filter as suggested in the original
patch.. but I'm not sure we need to remove the uprobe from handle_uretprobe_chain
like we do in handler_chain.. maybe just to save the next uprobe hit which would
remove the uprobe?

jirka

