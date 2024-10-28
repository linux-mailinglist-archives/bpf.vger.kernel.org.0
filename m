Return-Path: <bpf+bounces-43266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611AD9B21EE
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 02:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2922228116C
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 01:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FBB156F5D;
	Mon, 28 Oct 2024 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVttFJcj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF1C1537D7;
	Mon, 28 Oct 2024 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730078594; cv=none; b=ob9KgduOmglIgd2UbaVacYb81brWnMgq4kSIAXM1w90LoeiUpNGLVYaGY4ge9MBjB+Ext0my78PQMaOBlkzKF9NFqVnHjSI1j0IJ1pTYbFZnyfVaWHp6AviKGwIgsPJ98H+8DXtUUQVlY8Ppsme4pqtXWkhMwJmuV1Xk4BjuXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730078594; c=relaxed/simple;
	bh=39fULJnNEm7aZzHWNkhIZ5fJHrYDAdwwQhjRxisRnn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxbvR5uYNtagDvmfWRQkxDAWd0DBUoBfh/wHtxHOUhq6cuc0wiwy8ctu7FEeqZVTxADlEBALHUDK6n7H96M7pIB6bh8T/bGszk6D0HbRbkk3Da/aPwhYPLFhYr1AHEeiFMwnqZ9KVXfQQvJRtuAvZM0bHgIQ+4iuTOCr+IrRQ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVttFJcj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7206304f93aso1343290b3a.0;
        Sun, 27 Oct 2024 18:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730078591; x=1730683391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UJJDZ4qotThgP1RegwiVaz3h1AqFuEXo6agXP7ewNY=;
        b=aVttFJcjaOfs8g96q8LShqsQDXV9MkF1KOGSB6AdryOIWBGknTqYVP+LY7ooZYCiej
         Pz+98a0T5I6HS69sZ8RMrMZ9QRO9ijqJWRvzSzr9apc5786Eq8IJW7+1jneaPROEGTa4
         Vf9mPTNZxAsQcV0kVNowQHwOE2afaA6uKLa6diD+a19Ux0Y4G+GZFvnVyKVvhR0hTSyE
         Zg+Ix+KT8tKSsI/QYmdmcmnNvgZ5Y37rxzO94vkR0JYRMjRM2ymqFrurpCAU7SK4EPuY
         GRzuPzQzIOpbApMEtNVFcVHu+XyRY81gIaUn9zXuNikuAR0arCXDYIG5yBqR4PbOHVs1
         qPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730078591; x=1730683391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UJJDZ4qotThgP1RegwiVaz3h1AqFuEXo6agXP7ewNY=;
        b=NRLtHw8u7RNyWN0slgGvLKwwx5x8jaWsBJQWiCCrCRjEETqgiwBpu6m9niNi0L6TTH
         Wp8V1zUwmJQQ/8N1GtiNeIOzQGnFUPVCpspHbHqjRflm6UwJ3i6C6AKcUACOnZ9CDpSX
         39FKjrETpXiqpPctUSZZvi7Y5LxxjZyGJZoH5smvQdesQmZ1bvrYBSj3bBJdBhLOYliI
         PLrp84CQy91+QKmbXMwIQqLDEXVfQl7zfZtx1gJqN/tv/jhoT2sxN9soSmmS7BBX1K1k
         jahANZg1F4M38UU3DPLqUPTkRt3RF77iEvfz21a66jFBp7f5/SntVx+uzTNdib2asSnN
         Mu+w==
X-Forwarded-Encrypted: i=1; AJvYcCU/tVREGjZfNE4tTzPzBdcLAM07VaP0vRFjhoeBGgDMCxh6c2RhbX5sgoukASaKh1rQVvP1qT4aoCHW77bm@vger.kernel.org, AJvYcCUDAtLJ+lyYzrDpFki8lMNqvpUMeJXQhQUSQ1xCtBs2Rn8AV52pvaCQZyc4dnSyGf5t2a0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw155LJ+h4cUfAONgnq0XPOle851Bc1xP1jP3QUoLl4Bos3PfaG
	w6A7wkwh+W2WGDbPwQSP2GIZG52JCnxcO5fHQvMKz026Orx4iWXFLEFVbcYQRnuwRpu3ajjOd9a
	0fVo6NurcoDY1vGPKhoIFbEINUY4=
X-Google-Smtp-Source: AGHT+IG99cyjRdOjLXjy+iDTFvOWrBlmG6lRafy1Dfvrz8LYRnJXXr2FbE+mXZwexEBNNRjnqJz0wILl4t86pwBG5+8=
X-Received: by 2002:a05:6a20:c998:b0:1d8:a3ab:720d with SMTP id
 adf61e73a8af0-1d9a81c64abmr10286442637.0.1730078591387; Sun, 27 Oct 2024
 18:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026154629.593041-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20241026154629.593041-1-mathieu.desnoyers@efficios.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sun, 27 Oct 2024 18:22:58 -0700
Message-ID: <CAEf4BzacJd=hMGOGstf3HYc4BbK1Vt9rDkqptcCeE5=R-EqZ5A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/3] tracing: Introduce tracepoint extended structure
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 8:48=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Shrink the struct tracepoint size from 80 bytes to 72 bytes on x86-64 by
> moving the (typically NULL) regfunc/unregfunc pointers to an extended
> structure.
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
>  include/linux/tracepoint-defs.h |  8 ++++++--
>  include/linux/tracepoint.h      | 19 +++++++++++++------
>  kernel/tracepoint.c             |  9 ++++-----
>  3 files changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-d=
efs.h
> index 60a6e8314d4c..967c08d9da84 100644
> --- a/include/linux/tracepoint-defs.h
> +++ b/include/linux/tracepoint-defs.h
> @@ -29,6 +29,11 @@ struct tracepoint_func {
>         int prio;
>  };
>
> +struct tracepoint_ext {
> +       int (*regfunc)(void);
> +       void (*unregfunc)(void);
> +};
> +
>  struct tracepoint {
>         const char *name;               /* Tracepoint name */
>         struct static_key_false key;
> @@ -36,9 +41,8 @@ struct tracepoint {
>         void *static_call_tramp;
>         void *iterator;
>         void *probestub;
> -       int (*regfunc)(void);
> -       void (*unregfunc)(void);
>         struct tracepoint_func __rcu *funcs;
> +       struct tracepoint_ext *ext;
>  };
>
>  #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 0dc67fad706c..83dc24ee8b13 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -302,7 +302,7 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
>   * structures, so we create an array of pointers that will be used for i=
teration
>   * on the tracepoints.
>   */
> -#define DEFINE_TRACE_FN(_name, _reg, _unreg, proto, args)              \
> +#define __DEFINE_TRACE_EXT(_name, _ext, proto, args)                   \
>         static const char __tpstrtab_##_name[]                          \
>         __section("__tracepoints_strings") =3D #_name;                   =
 \
>         extern struct static_call_key STATIC_CALL_KEY(tp_func_##_name); \
> @@ -316,9 +316,9 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
>                 .static_call_tramp =3D STATIC_CALL_TRAMP_ADDR(tp_func_##_=
name), \
>                 .iterator =3D &__traceiter_##_name,                      =
 \
>                 .probestub =3D &__probestub_##_name,                     =
 \
> -               .regfunc =3D _reg,                                       =
 \
> -               .unregfunc =3D _unreg,                                   =
 \
> -               .funcs =3D NULL };                                       =
 \
> +               .funcs =3D NULL,                                         =
 \
> +               .ext =3D _ext,                                           =
 \
> +       };                                                              \
>         __TRACEPOINT_ENTRY(_name);                                      \
>         int __traceiter_##_name(void *__data, proto)                    \
>         {                                                               \
> @@ -341,8 +341,15 @@ static inline struct tracepoint *tracepoint_ptr_dere=
f(tracepoint_ptr_t *p)
>         }                                                               \
>         DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
>
> -#define DEFINE_TRACE(name, proto, args)                \
> -       DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
> +#define DEFINE_TRACE_FN(_name, _reg, _unreg, _proto, _args)            \
> +       struct tracepoint_ext __tracepoint_ext_##_name =3D {             =
 \

can be static, no?


> +               .regfunc =3D _reg,                                       =
 \
> +               .unregfunc =3D _unreg,                                   =
 \
> +       };                                                              \
> +       __DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_prot=
o), PARAMS(_args));
> +
> +#define DEFINE_TRACE(_name, _proto, _args)                             \
> +       __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
>
>  #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)                             \
>         EXPORT_SYMBOL_GPL(__tracepoint_##name);                         \
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 6474e2cf22c9..5658dc92f5b5 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -278,8 +278,8 @@ static int tracepoint_add_func(struct tracepoint *tp,
>         struct tracepoint_func *old, *tp_funcs;
>         int ret;
>
> -       if (tp->regfunc && !static_key_enabled(&tp->key)) {
> -               ret =3D tp->regfunc();
> +       if (tp->ext && tp->ext->regfunc && !static_key_enabled(&tp->key))=
 {
> +               ret =3D tp->ext->regfunc();
>                 if (ret < 0)
>                         return ret;
>         }
> @@ -362,9 +362,8 @@ static int tracepoint_remove_func(struct tracepoint *=
tp,
>         switch (nr_func_state(tp_funcs)) {
>         case TP_FUNC_0:         /* 1->0 */
>                 /* Removed last function */
> -               if (tp->unregfunc && static_key_enabled(&tp->key))
> -                       tp->unregfunc();
> -
> +               if (tp->ext && tp->ext->unregfunc && static_key_enabled(&=
tp->key))
> +                       tp->ext->unregfunc();
>                 static_branch_disable(&tp->key);
>                 /* Set iterator static call */
>                 tracepoint_update_call(tp, tp_funcs);
> --
> 2.39.5
>

