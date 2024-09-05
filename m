Return-Path: <bpf+bounces-38945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 100C396CC2B
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 03:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59170B2481C
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 01:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB1E946F;
	Thu,  5 Sep 2024 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfASKeVQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCD9454;
	Thu,  5 Sep 2024 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725499286; cv=none; b=rD+kYniFwKlZvwxIIswdo6rTtTl50+YPYN1gBfnODm3N52IQ+OdP6o6+m7sDF5fl4ViAwOGuZZPREsUQRkCWwhKQ14zlYhXyoV3dVx1/PAOOUoffv8dSob29WjGJu1EMqe0PVfsvVt70XSPs3U+ulXGnauJreLMVo/U1nufBBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725499286; c=relaxed/simple;
	bh=49UVHjoJaQIGa5rVtCdv30FshvYuYMu+h2DK4C4aZCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcqyBlesQ3afmsONWKMi9I5R9YGYXC5ilP9BmhAvYtVNc/HbSbBhFPZV6GIrzBi2DIcsps6kmdw40KXyPdl9Wi6yaJ8Eo9RkPYm0RLD/mzcyqfw0+KgNuwPjRWIv0MkHPFZ0sbF8xyx4+quru4pujQGDPahIhuTmc7WIO3QyGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfASKeVQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d8a54f1250so139979a91.0;
        Wed, 04 Sep 2024 18:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725499284; x=1726104084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwGYihXebPkRW5c2b8lN66ml9xZLWUdlEao1KjfVvG0=;
        b=YfASKeVQIrStULm/C73hAhb1e3J/49tstV3cnLYowNysiNMtFAw9rChsHtY+IWqJpY
         7lAlP0d7GtTkizzi358jkR8wi+f13yOLcgPKItciIX0i+mWVAkA/mFfA867TNXRv9hsW
         ZcoPDHPXKRKJwlLxACPLRHOUo7hrGZow1NnycXFgbi++ICfxZukq/iYdRLnJAdXq9cWj
         QVY1zt+OVkVnBlA2PT2dY37KlF0/ZJv7X/c2eZucBcPG+Td8Aqwtb0pcfKpzjHMo3TPH
         ZoLJLRKJEWxcmM9oikuCyx18F2yWOfE9LPPpRJ3oWFwKpCRZO5hKgv6LCbxdqgIR2Y31
         kivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725499284; x=1726104084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwGYihXebPkRW5c2b8lN66ml9xZLWUdlEao1KjfVvG0=;
        b=pT53ywZhfpe/2KCyrLtFgFjcf+OzJ4ViIMGH5XhVVwl0S4bkBTNKiAcEdAd754/SSB
         lAjQGOka5cF2W9dS7RUXQaXtmEzdLfr85Dg7gYiskvvvEw+cDC0Y7I1dWnktxifPUcWA
         cC7DXtTHY7iU0pUvvsQdqCYJOR115oLVu3Podw4T7Ai8BvL2ujS9NVKNvPWPq0QuNHyY
         Z+5sh7VXUzJgnzUo10jO+IkswBjCoiXeVdLnhDMX86q+pBBHuLtm+HkuaepJK4WQtS3u
         iCJx9fk7S4p4Osu6H1plZ6BmycyjKDV8UbcfIAoaybwwT+JBbo54g7ohggjqqzwU8FsR
         6DvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcVMbdGhprHsHSPfV8/nEM7jtz1TV7yuEQSq+X0MELTDhSJEt/DNBtT32rUhdJ3CfQEu8=@vger.kernel.org, AJvYcCV20DaFp7M99kA1PuJnhBdF7euWtjBPnHPnGH8inME3bJjidp8kZA5QtYfYiSTABDBnBfQoI/Ikrqf6A1oy@vger.kernel.org, AJvYcCVz8pNKDMKQcWKd5Xgx/XNL/E0zd5bov6v9PACa9oaEUQecWiTaKCEqodg30TgCTXhjnN8va7jfiX/PwQRNXzzdG+mu@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ+Cdn7NHSk4A48TGsrcW3Idfb9qLZ48cAtVH5FzFoT7aMlR91
	1Bx3A8ugkfF3L6WqDP/jcmo0ixKz6yoPdsUQbUm7enpXcyfVehuP6j/HX0SpyZTNMGK/gtPtZnR
	RHqqKKcuSefsmygzLHRi9jvnNpZQ=
X-Google-Smtp-Source: AGHT+IG1d4+0n9sb5KSnze10EvMjbuHrqpdqLNjKrE1o1s2cU/MidztS5TnM8R9BljaYfNhO3RX+v9umxGOGh0o/U+Y=
X-Received: by 2002:a17:90a:f006:b0:2d8:8f24:bd86 with SMTP id
 98e67ed59e1d1-2d8904c2fb8mr14600621a91.8.1725499283782; Wed, 04 Sep 2024
 18:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828144153.829582-1-mathieu.desnoyers@efficios.com> <20240828144153.829582-4-mathieu.desnoyers@efficios.com>
In-Reply-To: <20240828144153.829582-4-mathieu.desnoyers@efficios.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Sep 2024 18:21:11 -0700
Message-ID: <CAEf4BzZERq7qwf0TWYFaXzE6d+L+Y6UY+ahteikro_eugJGxWw@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] tracing/bpf-trace: Add support for faultable tracepoints
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	linux-trace-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 7:42=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> In preparation for converting system call enter/exit instrumentation
> into faultable tracepoints, make sure that bpf can handle registering to
> such tracepoints by explicitly disabling preemption within the bpf
> tracepoint probes to respect the current expectations within bpf tracing
> code.
>
> This change does not yet allow bpf to take page faults per se within its
> probe, but allows its existing probes to connect to faultable
> tracepoints.
>
> Link: https://lore.kernel.org/lkml/20231002202531.3160-1-mathieu.desnoyer=
s@efficios.com/
> Co-developed-by: Michael Jeanson <mjeanson@efficios.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: bpf@vger.kernel.org
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
> Changes since v4:
> - Use DEFINE_INACTIVE_GUARD.
> - Add brackets to multiline 'if' statements.
> Changes since v5:
> - Rebased on v6.11-rc5.
> - Pass the TRACEPOINT_MAY_FAULT flag directly to tracepoint_probe_registe=
r_prio_flags.
> ---
>  include/trace/bpf_probe.h | 21 ++++++++++++++++-----
>  kernel/trace/bpf_trace.c  |  2 +-
>  2 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index a2ea11cc912e..cc96dd1e7c3d 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -42,16 +42,27 @@
>  /* tracepoints with more than 12 arguments will hit build error */
>  #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__=
VA_ARGS__)
>
> -#define __BPF_DECLARE_TRACE(call, proto, args)                         \
> +#define __BPF_DECLARE_TRACE(call, proto, args, tp_flags)               \
>  static notrace void                                                    \
>  __bpf_trace_##call(void *__data, proto)                                 =
       \
>  {                                                                      \
> -       CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(=
args));        \
> +       DEFINE_INACTIVE_GUARD(preempt_notrace, bpf_trace_guard);        \
> +                                                                       \
> +       if ((tp_flags) & TRACEPOINT_MAY_FAULT) {                        \
> +               might_fault();                                          \
> +               activate_guard(preempt_notrace, bpf_trace_guard)();     \
> +       }                                                               \
> +                                                                       \
> +       CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(=
args)); \
>  }
>
>  #undef DECLARE_EVENT_CLASS
>  #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
> -       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
> +       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0)
> +
> +#undef DECLARE_EVENT_CLASS_MAY_FAULT
> +#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign=
, print) \
> +       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), TRACEPOINT=
_MAY_FAULT)
>
>  /*
>   * This part is compiled out, it is only here as a build time check
> @@ -105,13 +116,13 @@ static inline void bpf_test_buffer_##call(void)    =
                       \
>
>  #undef DECLARE_TRACE
>  #define DECLARE_TRACE(call, proto, args)                               \
> -       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))          \
> +       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0)       \
>         __DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), 0)
>
>  #undef DECLARE_TRACE_WRITABLE
>  #define DECLARE_TRACE_WRITABLE(call, proto, args, size) \
>         __CHECK_WRITABLE_BUF_SIZE(call, PARAMS(proto), PARAMS(args), size=
) \
> -       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args)) \
> +       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0) \
>         __DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), size)
>
>  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index c77eb80cbd7f..ed07283d505b 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2473,7 +2473,7 @@ int bpf_probe_register(struct bpf_raw_event_map *bt=
p, struct bpf_raw_tp_link *li
>
>         return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_=
func,
>                                                     link, TRACEPOINT_DEFA=
ULT_PRIO,
> -                                                   TRACEPOINT_MAY_EXIST)=
;
> +                                                   TRACEPOINT_MAY_EXIST =
| (tp->flags & TRACEPOINT_MAY_FAULT));
>  }
>
>  int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_raw_t=
p_link *link)
> --
> 2.39.2
>
>

I wonder if it would be better to just do this, instead of that
preempt guard. I think we don't strictly need preemption to be
disabled, we just need to stay on the same CPU, just like we do that
for many other program types.

We'll need some more BPF-specific plumbing to fully support faultable
(sleepable) tracepoints, but this should unblock your work, unless I'm
missing something. And we can take it from there, once your patches
land, to take advantage of faultable tracepoints in the BPF ecosystem.

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b69a39316c0c..415639b7c7a4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2302,7 +2302,8 @@ void __bpf_trace_run(struct bpf_raw_tp_link
*link, u64 *args)
        struct bpf_run_ctx *old_run_ctx;
        struct bpf_trace_run_ctx run_ctx;

-       cant_sleep();
+       migrate_disable();
+
        if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
                bpf_prog_inc_misses_counter(prog);
                goto out;
@@ -2318,6 +2319,8 @@ void __bpf_trace_run(struct bpf_raw_tp_link
*link, u64 *args)
        bpf_reset_run_ctx(old_run_ctx);
 out:
        this_cpu_dec(*(prog->active));
+
+       migrate_enable();
 }

