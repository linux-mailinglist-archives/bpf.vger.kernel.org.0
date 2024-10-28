Return-Path: <bpf+bounces-43335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B629B3B41
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 21:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A67B21C20
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0301E0080;
	Mon, 28 Oct 2024 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXW/sLw7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC91DEFCF;
	Mon, 28 Oct 2024 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146836; cv=none; b=NFnVNS9I+8RWBNakM7AJ9BpJFhkwSQFR/PsWcjx0ys8CdJZxHM2csO93Tor4EMPj9EgmgHXMjgGAr0NSUChWl9SjBQvEK7H2Jue7R7nHok4/lX3XHKEHspqNGdXC0dkmM7yxSrISoxkJJmN6bZ0ODQvBQlBLNyCb3jr8KFvP3hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146836; c=relaxed/simple;
	bh=0HL6kLF/gzDz7sdeNRmS+11JF0FHu6qxfsEFuSFVluc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZ8vECtg5HWBe361njFBjlRmURwgkF6SNYSbkClNekcSVZc82D/90FJWJgSHc665hcCCHWcg6FoD5yuuwPF9MykOn2G8UX2OGjlIWOdLcLgj6McKsIw8cp3UnwmZu2V7KH69L3p5iFB7zh31Jj8m/52I7uB/99E0vQs0ru1R8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXW/sLw7; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so3693705a12.1;
        Mon, 28 Oct 2024 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730146833; x=1730751633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjlVVe6Yv0Ro5Z11PVXue85V5xi9jQLi+/C1SPZMj5o=;
        b=ZXW/sLw7LU5ItfuIlJzIBH6DncUWLqIghs9urP4d2UkI0KIQSMzig99/DoRJQK/g5G
         qm9yExAa++UDIXkj3I2mEimCSC+0kKHl3p8oaz/Txv/yvppgMNihdVsySqt3vs4RYWgo
         vird8uTF4RwWGJp6xY3yuGxQy5uDTHdf4DC6NZRyNsbMO6fBV9TmcplwthPSHAaNO5zf
         K8SiDNUCjApnXAJuOvzKokLgyMY0oDQYNEAXuaTFRNVd20kJ0yVhksZmr1VTrRhc8Yyz
         UxM9uyZix8zE5wLdP8JPwuqGiA4E95gUewjMnBHRRshimnCNdeabVJoMqkOs9nP0WNRY
         N2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730146833; x=1730751633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjlVVe6Yv0Ro5Z11PVXue85V5xi9jQLi+/C1SPZMj5o=;
        b=jjMu54i9T/G0qg2sAWz2PMi1zQB9Gx0ezuamuNm0Eq7SKdZEANy6hVPOcuOnpQzJr8
         V5HPyFMNJ2ntwJw2eme9974b88MPbRBde/dBXBIqnyGzifyV3QB6m+v4pzz6nPooLpFS
         zYSboLS4v3szewsiV/VP9jWXC2MsN3KKXAyWMJv3P6zvdh9vrruCRbPugAWhs+/YMexI
         zX+LZcRO4Pmuj1L64JFm4spHwIcEdaa6lXyuNxwk3hpukNBDWJjiKKfC0WuZrLnt1Uzo
         5CKzfa6TbaUTf7lLHFyoNeouSw2/vZqry3hMmMulU16pgp6PrkvwrySDKwlGm2RxCbIj
         1Q+A==
X-Forwarded-Encrypted: i=1; AJvYcCVQs1nUslLWRLFuCIe2bWU3A1PQ+MdaSUZDW6OxvEgT8tEtoR44fMMzU1SCG5Lw7KbKav2BVh5C7OsQJKdM@vger.kernel.org, AJvYcCXrj8231F3sJAQ7YEV4sun/P8LpdjgBlI/th0rxiivYcUnY+acTMLQZU2ZWd13KdT4rLPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm3szK53+bi5ExWTge72tolJiKSbj12soUAv24/pxjSc33M7TK
	R4Y8Y01jWplr5SpXXA9x+HKrmSQ55UWWNHJFeqfT0cPfM3rzd4SUQ2uJPLls+KWuO77YgnDg8zS
	2Y7qNA5JO2mfLBva/1U4ahnf/jzU=
X-Google-Smtp-Source: AGHT+IG8ApNlFpqt1g+orMMDpMDTlQ5x4TKUBOkDcKTBGlsXZ2VXy5RBEgkZCQGaN4WR78VVXypPJt6bhG7Wfay2u1s=
X-Received: by 2002:a05:6a21:58d:b0:1d9:ea5:19df with SMTP id
 adf61e73a8af0-1d9a85067femr12549002637.43.1730146833561; Mon, 28 Oct 2024
 13:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028190927.648953-1-mathieu.desnoyers@efficios.com>
 <20241028190927.648953-5-mathieu.desnoyers@efficios.com> <e18e953b-9030-487c-bb8a-125521568e9e@efficios.com>
In-Reply-To: <e18e953b-9030-487c-bb8a-125521568e9e@efficios.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 28 Oct 2024 13:20:21 -0700
Message-ID: <CAEf4BzZgSPXyvtBZuB+W3fp=C8QYSHsd0TduxWE3Le+9e80-UA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/4] tracing: Add might_fault() check in
 __DO_TRACE() for syscall
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

On Mon, Oct 28, 2024 at 12:59=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-10-28 15:09, Mathieu Desnoyers wrote:
> > Catch incorrect use of syscall tracepoints even if no probes are
> > registered by adding a might_fault() check in __DO_TRACE() when
> > syscall=3D1.
> >
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Michael Jeanson <mjeanson@efficios.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: bpf@vger.kernel.org
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Jordan Rife <jrife@google.com>
> > ---
> >   include/linux/tracepoint.h | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index 259f0ab4ece6..7bed499b7055 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -226,10 +226,12 @@ static inline struct tracepoint *tracepoint_ptr_d=
eref(tracepoint_ptr_t *p)
> >               if (!(cond))                                            \
> >                       return;                                         \
> >                                                                       \
> > -             if (syscall)                                            \
> > +             if (syscall) {                                          \
> >                       rcu_read_lock_trace();                          \
> > -             else                                                    \
> > +                     might_fault();                                  \
>
> Actually, __DO_TRACE() is not the best place to put this, because it's
> only executed when the tracepoint is enabled.
>
> I'll move this to __DECLARE_TRACE_SYSCALL()
>
> #define __DECLARE_TRACE_SYSCALL(name, proto, args, cond, data_proto)    \
>          __DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, =
PARAMS(data_proto)) \
>          static inline void trace_##name(proto)                          =
\
>          {                                                               =
\
>                  might_fault();                                          =
\
>                  if (static_branch_unlikely(&__tracepoint_##name.key))   =
\
>                          __DO_TRACE(name,                                =
\
>                                  TP_ARGS(args),                          =
\
>                                  TP_CONDITION(cond), 1);                 =
\
> [...]
>
> instead in v5.

please drop the RFC tag while at it

>
> Thanks,
>
> Mathieu
>
> > +             } else {                                                \
> >                       preempt_disable_notrace();                      \
> > +             }                                                       \
> >                                                                       \
> >               __DO_TRACE_CALL(name, TP_ARGS(args));                   \
> >                                                                       \
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>

