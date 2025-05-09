Return-Path: <bpf+bounces-57907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133CAB1C49
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 20:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA75540354
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7552E23E33D;
	Fri,  9 May 2025 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/z5BQVk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685361E9B2A;
	Fri,  9 May 2025 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746815257; cv=none; b=UBLkHghxVP0JfYlVJLwSLhf6nPhdVhd+1HU2K+Yy8v9VxC6P/9zWYDU/ZSPsAdbWo2R1AJav8TvD+a5vXEJ5Zu2mGekFiq1TWdMl5yhTM2epwssWK+I1p/dwpGNOYfPYlKzG7xyRgR7WGwDW6p4HcZbW8q0rrTRgiDnWi8fNKqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746815257; c=relaxed/simple;
	bh=K9g7TigVuzspGyA7njHo7MVw+kOhUjyydephxiuMjpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmMKN5ijiM5PT/Mb0PJns2+l5nFDt0TJbg4S0fxcMf5b0GXcePRRnUBAYiK197xv+pHK52dfQubqJNeMjePkjBKHZHSHnFkHzPf0KmSNnuywKTmZ5xx9nnXImeYHgZ6DsETeAhOrr4y3xiXVhXMP6DO06Ob8JZ/fkO1tPZLpubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/z5BQVk; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso3510894b3a.2;
        Fri, 09 May 2025 11:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746815255; x=1747420055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuasJRiIFQRFCj0M2Lo6rLXvCLu4MvCIZVJ/a1SYzAg=;
        b=F/z5BQVkKAv+En5mP91pgh+Q65kyDA8ifVq2TGtiiK+oelem15QCEJmWt9DAASWr3x
         OzmNecIQIf6p/c7jDhGIUUqowcNQV3Oe16tOElNV5WQv48IZ1C0wqd/gS1hkhL/lUFXN
         t6pt11SNRAUFbuR0abNVARBY4gcjie7mAK9gJpTSWHBQgvRlpEbVLeZbw1xTBUeB9QBF
         Wa+1EL41grsVGFKjvsdBPnNI0uLRTAP8ahovodCOZb2QzTwhnpNZJD+EGYAusKXb/T8l
         B2IoDd9NjbXb6Sub5RezQy67IiVAaVP3oR04pTnB6db3u3li3h6Gkskx4aPxoDlraXB2
         Efhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746815255; x=1747420055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuasJRiIFQRFCj0M2Lo6rLXvCLu4MvCIZVJ/a1SYzAg=;
        b=ae2g7UiUk4ulJXIaM4TqXWTC7At9jOYTon1XzQIDQx2Rq95nPn0/gG1JhyUT6XTxSy
         WjkXD6Scf5xqpT9DR8RM1Zz0GW6feGR6yvRIBuZaGoKieINMTHR18eLiK2Zt9MB/zxD2
         ydKFL+sS/hytmb6SbdvwKZrrXY0CO8V8QNCJU/zUWifz+ZMw2bD/LOK2d47yccWGc19c
         V1SAnGULnRXxAzqUeAnspWmoCKDd9t8bh+5bVultpeQRj+Lf51qv1mhfe8alL8FLtpFy
         IOhnB6lm2pu50K4IDadBi3n+s1vWMdqduQKhRySIxYAqA8Z4103nQJiAvY9e2RajEwwr
         me0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUF9DPDWYgELC5EtKfW00CYn2LN3+Bi3TRHCp64l3p6237hWV9NmxoYX/y1ojx2eGByAPT0vylb@vger.kernel.org, AJvYcCXYq80kb07/Bsto17XS/fcjA8tzkVTPISLArTKsxO5pXQCqUvstSQGRStW50XEnsFrqRCc=@vger.kernel.org, AJvYcCXkUJoYdCBOP92o8DtNq27uwBl3KguwDExQoO+2+1tLm1HGY6FLMxoC2LkCormj+Nx4+hycTqHU43356SR4YfB6ndnF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4D9kb3hSof3dz/TazMsF/VyBL3bk3+AHU1OEDjHy90e1NvnTE
	uKwHpEybcKpYydKHdVC6Be77naZZVexhFob69xGhWSEuv5/8WCw/vOHM9J7mDG19VQME0LDibJD
	qVh15NcqAwjQmpGfIaWMIkVAbMIuVVrIq4Iw=
X-Gm-Gg: ASbGncuShnIBh8ZLYxZNjzXqHD1/9SOMnPpRmWACBayAoYC0+b6jkoG60YXF5Z+yem3
	Y1QWMQ40Fw8WEsC0WnZODdiWDUOMI46j6JK1twQTaI32g5aTzaawYS/xwn0UVKYI3BWuaCtv6eE
	QXIsJjI5T2VO4Up/iCAWxOywb6h1v7db8+sAwr9P4UGZ6GZvTq
X-Google-Smtp-Source: AGHT+IFCtiq6P9+wncMYkaQT7FhZg5O66TnmAqalhQ2e9aag5TAQtyw/5bSEF5DOEJpkc4Fj+oPdmuUNKTPdmi7t2D4=
X-Received: by 2002:a05:6a21:3182:b0:1f5:8a1d:3904 with SMTP id
 adf61e73a8af0-215abace343mr7259066637.7.1746815254542; Fri, 09 May 2025
 11:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507162049.30a3ccae@gandalf.local.home>
In-Reply-To: <20250507162049.30a3ccae@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 May 2025 11:27:22 -0700
X-Gm-Features: ATxdqUH7ItGyaI6RVaVXNJ9WCohurdooHxxLI8i7dM6A_DUp3qEibUlStjjpFCQ
Message-ID: <CAEf4BzZxDPpsTnger+UXL9wbrpK5gf_9YD2fD0VNA1nC7bcwUg@mail.gmail.com>
Subject: Re: [PATCH v2] tracepoint: Have tracepoints created with
 DECLARE_TRACE() have _tp suffix
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, 
	netdev <netdev@vger.kernel.org>, Jiri Olsa <olsajiri@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, David Ahern <dsahern@kernel.org>, 
	Juri Lelli <juri.lelli@gmail.com>, Breno Leitao <leitao@debian.org>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Gabriele Monaco <gmonaco@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 1:20=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> Most tracepoints in the kernel are created with TRACE_EVENT(). The
> TRACE_EVENT() macro (and DECLARE_EVENT_CLASS() and DEFINE_EVENT() where i=
n
> reality, TRACE_EVENT() is just a helper macro that calls those other two
> macros), will create not only a tracepoint (the function trace_<event>()
> used in the kernel), it also exposes the tracepoint to user space along
> with defining what fields will be saved by that tracepoint.
>
> There are a few places that tracepoints are created in the kernel that ar=
e
> not exposed to userspace via tracefs. They can only be accessed from code
> within the kernel. These tracepoints are created with DEFINE_TRACE()
>
> Most of these tracepoints end with "_tp". This is useful as when the
> developer sees that, they know that the tracepoint is for in-kernel only
> (meaning it can only be accessed inside the kernel, either directly by th=
e
> kernel or indirectly via modules and BPF programs) and is not exposed to
> user space.
>
> Instead of making this only a process to add "_tp", enforce it by making
> the DECLARE_TRACE() append the "_tp" suffix to the tracepoint. This
> requires adding DECLARE_TRACE_EVENT() macros for the TRACE_EVENT() macro
> to use that keeps the original name.
>
> Link: https://lore.kernel.org/all/20250418083351.20a60e64@gandalf.local.h=
ome/
>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Juri Lelli <juri.lelli@gmail.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Gabriele Monaco <gmonaco@redhat.com>
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since RFC/v1: https://lore.kernel.org/20250418110104.12af6883@gan=
dalf.local.home
>
> - Folded in Jiri Olsa's update to DECLARE_TRACE_WRITABLE()
>   https://lore.kernel.org/linux-trace-kernel/aAY9pcvYHkYKFwZ5@krava/
>
> - Updated change log to be more specific about "kernel only"
>   (Andrii Nakryiko)
>
> - Updated Documentation to ref
>
>  Documentation/trace/tracepoints.rst           | 17 ++++++---
>  include/linux/tracepoint.h                    | 38 +++++++++++++------
>  include/trace/bpf_probe.h                     |  8 ++--
>  include/trace/define_trace.h                  | 17 ++++++++-
>  include/trace/events/sched.h                  | 30 +++++++--------
>  include/trace/events/tcp.h                    |  2 +-
>  .../bpf/test_kmods/bpf_testmod-events.h       |  2 +-
>  .../selftests/bpf/test_kmods/bpf_testmod.c    |  8 ++--
>  8 files changed, 78 insertions(+), 44 deletions(-)
>

[...]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h =
b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
> index aeef86b3da74..2bac14ef507f 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
> @@ -42,7 +42,7 @@ DECLARE_TRACE(bpf_testmod_test_nullable_bare,
>
>  struct sk_buff;
>
> -DECLARE_TRACE(bpf_testmod_test_raw_tp_null,
> +DECLARE_TRACE(bpf_testmod_test_raw_null,

here "raw_tp" is actually part of the name (we are testing raw
tracepoints with NULL argument), so I'd suggest to not change it here,
we'll just have trace_bpf_testmod_test_raw_tp_null_tp() below, however
odd it might be looking :)

>         TP_PROTO(struct sk_buff *skb),
>         TP_ARGS(skb)
>  );
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 3220f1d28697..fd40c1180b09 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -413,7 +413,7 @@ bpf_testmod_test_read(struct file *file, struct kobje=
ct *kobj,
>
>         (void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
>
> -       (void)trace_bpf_testmod_test_raw_tp_null(NULL);
> +       (void)trace_bpf_testmod_test_raw_null_tp(NULL);
>
>         bpf_testmod_test_struct_ops3();
>
> @@ -431,14 +431,14 @@ bpf_testmod_test_read(struct file *file, struct kob=
ject *kobj,
>         if (bpf_testmod_loop_test(101) > 100)
>                 trace_bpf_testmod_test_read(current, &ctx);
>
> -       trace_bpf_testmod_test_nullable_bare(NULL);
> +       trace_bpf_testmod_test_nullable_bare_tp(NULL);
>
>         /* Magic number to enable writable tp */
>         if (len =3D=3D 64) {
>                 struct bpf_testmod_test_writable_ctx writable =3D {
>                         .val =3D 1024,
>                 };
> -               trace_bpf_testmod_test_writable_bare(&writable);
> +               trace_bpf_testmod_test_writable_bare_tp(&writable);
>                 if (writable.early_ret)
>                         return snprintf(buf, len, "%d\n", writable.val);
>         }
> @@ -470,7 +470,7 @@ bpf_testmod_test_write(struct file *file, struct kobj=
ect *kobj,
>                 .len =3D len,
>         };
>
> -       trace_bpf_testmod_test_write_bare(current, &ctx);
> +       trace_bpf_testmod_test_write_bare_tp(current, &ctx);
>

please update the following three lines in selftests to match new names:

progs/test_module_attach.c
22:SEC("raw_tp/bpf_testmod_test_write_bare")

progs/test_tp_btf_nullable.c
9:SEC("tp_btf/bpf_testmod_test_nullable_bare")
16:SEC("tp_btf/bpf_testmod_test_nullable_bare")


just add that "_tp" suffix everywhere and CI should be happy

>         return -EIO; /* always fail */
>  }
> --
> 2.47.2
>

