Return-Path: <bpf+bounces-43333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20249B3B3A
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 21:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55EF1C21FFB
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971EC1E04B3;
	Mon, 28 Oct 2024 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uv6v0KOx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4131E009C;
	Mon, 28 Oct 2024 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146763; cv=none; b=f8YKaDf8ldNPiB/UGpO4TRo2T4TtDnDfu5aQ9OYzVHTma5Mlq/ML9YMo0f49if3HtIT5Cvp3ENK6wEkTAVAqMPA0pJ7LKwMO5D/zEo7V7wTcPbZ1CcI+xoXEv5h2MymNrELWi9DUiZ6mNUC71mUpNhKkHoXQ1cEs4yPZzX0KnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146763; c=relaxed/simple;
	bh=NRWtSOC+lEz9k6UbmC+lnZcOEDLhy8WSHnCrE9fqZ4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkGJQwyg1e0mCgJmeJJRZmABDPxiGFQ7wRTr1j/EORKumVfUZdCtyYUERkG7JWycuwDtGvUisU31DLUFmTxFxDmgO4el9RsEQCmrzXZSAlp9/vABrkCG9vXkIp4bqLMsU3cXYyAIc23TirHePYGgEP3mgYDvzHvWpfNdUphd/cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uv6v0KOx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso3819060b3a.2;
        Mon, 28 Oct 2024 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730146760; x=1730751560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13Qc9db0gISrV8wY86ltcLxpy9cIe+7+41QoOq6EjMk=;
        b=Uv6v0KOxz8r4QafUYXHakzII14fZy/583BLlAWD243fBMmT0IHn0D2fX+G8wl+gg+g
         3xJ4ym7jgc5p8tAy25wAQzsj3b3N71DRbZmqpzx57cqMKAev+8oNeDfSnmacnyZhP3Vq
         eRCSoumSWufN9THMZvqtSGtci+CT4iMpAAxIf4fFGhV8dQaToyIzWo1tAWMlGu6UztYk
         BHWr0f69pUX7LRUrT0lFRSuXscMoL8P7zJ3FYzI09AvoJ6D/AacYkfgWjNUZoDdbtI6x
         cLmGtjTsK2wqDhIod70oNDySD11yC0k3SzpUTtlHH6mZQtlPfCVda27ehelAPRZqkeSv
         i2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730146760; x=1730751560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13Qc9db0gISrV8wY86ltcLxpy9cIe+7+41QoOq6EjMk=;
        b=FR4ebIl3sRGnzGzR7j3NxNRgn50WwiKdkjkCZ3SlprHgP0CbNrOti0cqvhqm+50ZTx
         AwS8jAymc8cKodpXh8UBRRqtt1qFajHMdqI+qjYmi1lu9qCxCxv/EqSNtYkjveXJunAc
         ijuOnhPvXFE9P7JgXX6BySCAEDypJg6BDGejY2OiwB22NziZzFO2BCrF9ZSpWZNlCjCu
         yY5ud6dZQ6Eo0ACaNb1ORsB1FxwL1ArFOCnv+zDWlucv1LvNuPHdm8Plh6tKbm3nnS7a
         387iYWPeJLzWDXkJBmU1GRfZmLeUexSw8lfmTLhgDO9vXsgDiNDptv8vjt2gFODKofHl
         MAFg==
X-Forwarded-Encrypted: i=1; AJvYcCV41hzuBTKRBJAiNjZmgTZgxVRl6VmubEp7D8O4eT0sF4fxyRdxVAskMKtkQPH2eTU5iyU=@vger.kernel.org, AJvYcCWq2431FRrJqVpfDgCwSlUlzWSxK5F5RdFecKSHXignjb3ynCFENk5i3vjo3Jagmmya4JXVI1PmFrhmfKBY@vger.kernel.org
X-Gm-Message-State: AOJu0YxysOKT93SmJzX2IaNvvdY24ZHvvxzAH+jVYga8QOZPv7Nt0Jl5
	DA4zs9bKb2PE6XC9vxMKa6li3DZe6iByLyjbpgtz6egPYM711kYE7biyXwRvOHoXHToDz/UBWTC
	EnsZIaH5WAISR8XQ9euUUPbdMDTI=
X-Google-Smtp-Source: AGHT+IFmSOsqbPR2jqw2E0aLoR61UwDL+koBCcmMDB4ZgcEOBaplBk6EHfZ0V0lRMU2djXuvDpacp/suUkdcV81hrRE=
X-Received: by 2002:a05:6a00:1910:b0:71e:5e04:be9b with SMTP id
 d2e1a72fcca58-72062fb21f2mr16001814b3a.12.1730146760304; Mon, 28 Oct 2024
 13:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028190927.648953-1-mathieu.desnoyers@efficios.com> <20241028190927.648953-3-mathieu.desnoyers@efficios.com>
In-Reply-To: <20241028190927.648953-3-mathieu.desnoyers@efficios.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 28 Oct 2024 13:19:08 -0700
Message-ID: <CAEf4BzZA30dEOxqtwWcMsGLLU0na77rmRANMMYQaNJ8D8o5-bQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/4] tracing: Introduce tracepoint_is_faultable()
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Michael Jeanson <mjeanson@efficios.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 12:11=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Introduce a "faultable" flag within the extended structure to know
> whether a tracepoint needs rcu tasks trace grace period before reclaim.
> This can be queried using tracepoint_is_faultable().
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Michael Jeanson <mjeanson@efficios.com>
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
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: bpf@vger.kernel.org
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Jordan Rife <jrife@google.com>
> ---
>  include/linux/tracepoint-defs.h |  2 ++
>  include/linux/tracepoint.h      | 24 ++++++++++++++++++++++++
>  include/trace/define_trace.h    |  2 +-
>  3 files changed, 27 insertions(+), 1 deletion(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-d=
efs.h
> index 967c08d9da84..aebf0571c736 100644
> --- a/include/linux/tracepoint-defs.h
> +++ b/include/linux/tracepoint-defs.h
> @@ -32,6 +32,8 @@ struct tracepoint_func {
>  struct tracepoint_ext {
>         int (*regfunc)(void);
>         void (*unregfunc)(void);
> +       /* Flags. */
> +       unsigned int faultable:1;
>  };
>
>  struct tracepoint {
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 83dc24ee8b13..259f0ab4ece6 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -104,6 +104,12 @@ void for_each_tracepoint_in_module(struct module *mo=
d,
>   * tracepoint_synchronize_unregister must be called between the last tra=
cepoint
>   * probe unregistration and the end of module exit to make sure there is=
 no
>   * caller executing a probe when it is freed.
> + *
> + * An alternative is to use the following for batch reclaim associated
> + * with a given tracepoint:
> + *
> + * - tracepoint_is_faultable() =3D=3D false: call_rcu()
> + * - tracepoint_is_faultable() =3D=3D true:  call_rcu_tasks_trace()
>   */
>  #ifdef CONFIG_TRACEPOINTS
>  static inline void tracepoint_synchronize_unregister(void)
> @@ -111,9 +117,17 @@ static inline void tracepoint_synchronize_unregister=
(void)
>         synchronize_rcu_tasks_trace();
>         synchronize_rcu();
>  }
> +static inline bool tracepoint_is_faultable(struct tracepoint *tp)
> +{
> +       return tp->ext && tp->ext->faultable;
> +}
>  #else
>  static inline void tracepoint_synchronize_unregister(void)
>  { }
> +static inline bool tracepoint_is_faultable(struct tracepoint *tp)
> +{
> +       return false;
> +}
>  #endif
>
>  #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
> @@ -345,6 +359,15 @@ static inline struct tracepoint *tracepoint_ptr_dere=
f(tracepoint_ptr_t *p)
>         struct tracepoint_ext __tracepoint_ext_##_name =3D {             =
 \
>                 .regfunc =3D _reg,                                       =
 \
>                 .unregfunc =3D _unreg,                                   =
 \
> +               .faultable =3D false,                                    =
 \
> +       };                                                              \
> +       __DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_prot=
o), PARAMS(_args));
> +
> +#define DEFINE_TRACE_SYSCALL(_name, _reg, _unreg, _proto, _args)       \
> +       struct tracepoint_ext __tracepoint_ext_##_name =3D {             =
 \
> +               .regfunc =3D _reg,                                       =
 \
> +               .unregfunc =3D _unreg,                                   =
 \
> +               .faultable =3D true,                                     =
 \
>         };                                                              \
>         __DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_prot=
o), PARAMS(_args));
>
> @@ -389,6 +412,7 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
>  #define __DECLARE_TRACE_SYSCALL        __DECLARE_TRACE
>
>  #define DEFINE_TRACE_FN(name, reg, unreg, proto, args)
> +#define DEFINE_TRACE_SYSCALL(name, reg, unreg, proto, args)
>  #define DEFINE_TRACE(name, proto, args)
>  #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)
>  #define EXPORT_TRACEPOINT_SYMBOL(name)
> diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
> index ff5fa17a6259..63fea2218afa 100644
> --- a/include/trace/define_trace.h
> +++ b/include/trace/define_trace.h
> @@ -48,7 +48,7 @@
>
>  #undef TRACE_EVENT_SYSCALL
>  #define TRACE_EVENT_SYSCALL(name, proto, args, struct, assign, print, re=
g, unreg) \
> -       DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
> +       DEFINE_TRACE_SYSCALL(name, reg, unreg, PARAMS(proto), PARAMS(args=
))
>
>  #undef TRACE_EVENT_NOP
>  #define TRACE_EVENT_NOP(name, proto, args, struct, assign, print)
> --
> 2.39.5
>

