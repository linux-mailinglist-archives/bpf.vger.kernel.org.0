Return-Path: <bpf+bounces-54592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F85A6D3A2
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 05:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347F816E9B5
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 04:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA00E18B475;
	Mon, 24 Mar 2025 04:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J54RU1LL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27A7E110;
	Mon, 24 Mar 2025 04:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742791679; cv=none; b=fgQDIaSYa8Lj4fPzaqg6+9zBlZha2wxOBW6u93kOEWe66pIEEmTUcNBX/fA+adTlIbf+KZO0f0ZAQlqvxBaDgnYkUJhLxUI8DIoiMRlo1NcctJpSEf7RX9lZGFnpD/y3wPZ/DUyqFD5GLqQPhyFlWXyIy5SW+fz+fMpyfCu9OBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742791679; c=relaxed/simple;
	bh=oebWO/ZrGI6QIP5rK12oT36vAOsde3sQA+5FPtJA3g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ToLwriaGhGouq0+xCaf0QyQLG9cphsl9Oxm0TKBHFKV8OBshiP3clxSLXVZu98JdAPGhuaxkRx5+pxjLDR8okWhMHR1ofRZkft82wN4Lrvit34YWTpO7XlAyGzWDxQy0TJ7d4OUFaWSQrQcJNOatXj6+6vHM4QQEvDk4+V7wNj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J54RU1LL; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e64165ae78cso2840395276.0;
        Sun, 23 Mar 2025 21:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742791676; x=1743396476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irOA4kDWv4T7ma/36tjF6MRUdZOvW8mgL9gXhU3hjJY=;
        b=J54RU1LLMiE3J9MbJlM4ZYZdLFmfbeQz/URYpOpBKSPoscFGMh/3gXzcTZLfTiQ3JO
         KYIN4mHobU5fIS9LVN8k4Gq4gl3ODGuaXjASbJ9xo81F4SZH/Bbk4q0kvTNmNV6jt8no
         BV8bzOrAYTQ2ibpPh3hlYHBmVcWu8XCOOjk+k7yUuzyzXLbO0NPexYUWcOnnFNPWYbJ1
         ws0LcER3XWYU2/IkGsORf3C65q7G/awBYYmkUDLKn6FcL7vGF97+iFdW1FP+b/QmeO4c
         jTTMYDeKomUqQ2Pq0QnaxINBab64S7lFUYG4o8cLc1+d6m4hjXtE8Nxb58rQdMiWy/kJ
         WNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742791676; x=1743396476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irOA4kDWv4T7ma/36tjF6MRUdZOvW8mgL9gXhU3hjJY=;
        b=M8Pbb+AnB2Fw79Um762hSPaT4EdCrcWNrVMHwDVrnzugRLR2szrid6Zf3U6cmUEKim
         dG+SoCWo66KnNqg7B1r9QdRGFA1sed2rrK+mc3ztw7YLAMpsdYQGFuwhe37ilcpnyZ0r
         j+wXT+FlvK7tVSwUpXJoFnsFUnQMgzXJ8xoWPB5jbFUxdjKFVHy1DEGzY6MbHbBgpNMR
         tAbCEBd1s7LEhsHUM+Yg1rsItR4NccxDiO6U2+TTTeB6BquI7ExSAziznsROxDsCZD4V
         eiGa60YBAPm1Gh/Uj6ShIT6Pq/HEHqtt7RBBq19DSalGMfHGGkmVlcCcEj22jj1k52Oj
         Pp7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFNaTn3lHBvd7fg6cef0pnPIq4Iceso3eMF/MRTeDmY+0jnByS581lamV5PaCtaAA4/MLS096QmRdlHLBB@vger.kernel.org, AJvYcCUhbTbS1KJ/B17rkS44ljI63SG8HhRqrVv4vVPnkvSpGPuhV1zdRMzidEqnbMZGDx+dV60KbdKhJNS2BxHlNvtrKg==@vger.kernel.org, AJvYcCWlvt417cGVlc4pmhcKV1WPXDZM4Rx1NsliCIUfvdWpu39VNbq3jVSErLSFLEWoPMPH3oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2v9Aqgk3J4aJ9cXaHLc9DXkQFlM8HPh6Xlz6jbf9KsOaBbGQ1
	fjlYcWbZzMDOqgOuYf9wYJbU4UEQ11w9gAmPaiqqjW5D2OC5tWLqBdBpmlhHEFZqUfp006jxxnh
	ZHy+mabmGhGyCPs30LmwntkOo93I=
X-Gm-Gg: ASbGncsDg+gghoOfxaW8uuZ43uvLnjCy3b6k/9teMFQ19wzo2XONpS5nRtyiKPTMI1d
	eUY7BdtCJth6nUdkH7+yloOTKJdUY8LcthL9FN4wll8I9RUedCgDzhK8lBIi4w31RLNks2ikkXw
	IGvN5uS84zHqOQUxg/M4AGJoc1
X-Google-Smtp-Source: AGHT+IG0Q3vCe9YM49MiXZIdS6r7vCU8YR/bYrCYkh14g7ZyUIxlwy86RnParcxNaxtT4W6k7/Gx84f/1Tcc90+kssE=
X-Received: by 2002:a05:6902:2e0e:b0:e5a:e39d:c2ad with SMTP id
 3f1490d57ef6-e66a4ab615fmr13672444276.0.1742791676384; Sun, 23 Mar 2025
 21:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321184255.2809370-1-namhyung@kernel.org> <Z-C6CdVXohPJSjzu@gmail.com>
In-Reply-To: <Z-C6CdVXohPJSjzu@gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Sun, 23 Mar 2025 21:47:45 -0700
X-Gm-Features: AQ5f1JrRvD_8pxSfdLWXEHG4xGXMpSiVYWEb2Kfava-aAZ_cOZ5-0-xGinxFRSI
Message-ID: <CAH0uvogCka=hXsyPXboZS7znOgFHYhaMQ0H0VGMEM_z_AdBZYw@mail.gmail.com>
Subject: Re: [PATCH v3] perf trace: Implement syscall summary in BPF
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Mar 23, 2025 at 6:49=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hello Namhyung,
>
> On Fri, Mar 21, 2025 at 11:42:55AM -0700, Namhyung Kim wrote:
> > When -s/--summary option is used, it doesn't need (augmented) arguments
> > of syscalls.  Let's skip the augmentation and load another small BPF
> > program to collect the statistics in the kernel instead of copying the
> > data to the ring-buffer to calculate the stats in userspace.  This will
> > be much more light-weight than the existing approach and remove any los=
t
> > events.
> >
> > Let's add a new option --bpf-summary to control this behavior.  I canno=
t
> > make it default because there's no way to get e_machine in the BPF whic=
h
> > is needed for detecting different ABIs like 32-bit compat mode.
> >
> > No functional changes intended except for no more LOST events. :)  But
> > it only works with -a/--all-cpus for now.
> >
> >   $ sudo ./perf trace -as --summary-mode=3Dtotal --bpf-summary sleep 1
> >
> >    Summary of events:
> >
> >    total, 6194 events
> >
> >      syscall            calls  errors  total       min       avg       =
max       stddev
> >                                        (msec)    (msec)    (msec)    (m=
sec)        (%)
> >      --------------- --------  ------ -------- --------- --------- ----=
-----     ------
> >      epoll_wait           561      0  4530.843     0.000     8.076   52=
0.941     18.75%
> >      futex                693     45  4317.231     0.000     6.230   50=
0.077     21.98%
> >      poll                 300      0  1040.109     0.000     3.467   12=
0.928     17.02%
> >      clock_nanosleep        1      0  1000.172  1000.172  1000.172  100=
0.172      0.00%
> >      ppoll                360      0   872.386     0.001     2.423   25=
3.275     41.91%
> >      epoll_pwait           14      0   384.349     0.001    27.453   38=
0.002     98.79%
> >      pselect6              14      0   108.130     7.198     7.724     =
8.206      0.85%
> >      nanosleep             39      0    43.378     0.069     1.112    1=
0.084     44.23%
> >      ...
> >
> > Cc: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > v3)
> >  * support -S/--with-summary option too  (Howard)
>
> It gave me segfault somehow.
>
> (gdb) bt
> #0  sighandler_dump_stack (sig=3D32767) at util/debug.c:322
> #1  <signal handler called>
> #2  0x00005555556d2383 in hashmap_find ()
> #3  0x000055555567474a in thread__update_stats (thread=3D0x5555564acc60, =
ttrace=3D0x5555564ad7a0, id=3D0, sample=3D0x7fffffff8f10, err=3D1,
>     trace=3D0x7fffffffb1a0) at builtin-trace.c:2616
> #4  0x00005555556757cb in trace__sys_exit (trace=3D0x7fffffffb1a0, evsel=
=3D0x5555561879d0, event=3D0x7fffed980000, sample=3D0x7fffffff8f10)
>     at builtin-trace.c:2924
> #5  0x0000555555677e1b in trace__handle_event (trace=3D0x7fffffffb1a0, ev=
ent=3D0x7fffed980000, sample=3D0x7fffffff8f10) at builtin-trace.c:3619
> #6  0x00005555556796fb in __trace__deliver_event (trace=3D0x7fffffffb1a0,=
 event=3D0x7fffed980000) at builtin-trace.c:4173
> #7  0x0000555555679859 in trace__deliver_event (trace=3D0x7fffffffb1a0, e=
vent=3D0x7fffed980000) at builtin-trace.c:4201
> #8  0x000055555567abed in trace__run (trace=3D0x7fffffffb1a0, argc=3D2, a=
rgv=3D0x7fffffffeb30) at builtin-trace.c:4590
> #9  0x000055555567f102 in cmd_trace (argc=3D2, argv=3D0x7fffffffeb30) at =
builtin-trace.c:5803
> #10 0x0000555555685252 in run_builtin (p=3D0x5555560eaf28 <commands+648>,=
 argc=3D7, argv=3D0x7fffffffeb30) at perf.c:351
> #11 0x00005555556854fd in handle_internal_command (argc=3D7, argv=3D0x7ff=
fffffeb30) at perf.c:404
> #12 0x000055555568565e in run_argv (argcp=3D0x7fffffffe91c, argv=3D0x7fff=
ffffe910) at perf.c:448
> #13 0x00005555556859af in main (argc=3D7, argv=3D0x7fffffffeb30) at perf.=
c:556

the command I used is:

perf $ sudo ./perf trace -aS --summary-mode=3Dtotal --bpf-summary -- sleep =
1
[sudo] password for howard:
perf: Segmentation fault
Obtained 14 stack frames.
./perf(dump_stack+0x35) [0x591e26c8a735]
./perf(sighandler_dump_stack+0x2d) [0x591e26c8a7dd]
/lib/x86_64-linux-gnu/libc.so.6(+0x45250) [0x737072045250]
./perf(+0x1543ed) [0x591e26ba43ed]
./perf(+0xff616) [0x591e26b4f616]
./perf(+0xfc3f4) [0x591e26b4c3f4]
./perf(+0x10193b) [0x591e26b5193b]
./perf(cmd_trace+0x205e) [0x591e26b56a9e]
./perf(+0x10b0e0) [0x591e26b5b0e0]
./perf(+0x10b3fb) [0x591e26b5b3fb]
./perf(main+0x2fb) [0x591e26ad63eb]
/lib/x86_64-linux-gnu/libc.so.6(+0x2a3b8) [0x73707202a3b8]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x8b) [0x73707202a47b]
./perf(_start+0x25) [0x591e26ad6a35]
Segmentation fault

Thanks,
Howard

