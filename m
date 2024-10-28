Return-Path: <bpf+bounces-43267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888509B21F0
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 02:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2DD2811D0
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 01:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5E917B427;
	Mon, 28 Oct 2024 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCH6GoaG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0F515B54C;
	Mon, 28 Oct 2024 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730078597; cv=none; b=IEtuZxsLtTSuQEaAFv3xAR35h0RtOrzVqC/pFtoT2sFAsCPKA2y5U3iWpIwXKT9XYTKg4Sd+5jkImFcP22kkRY1weSEuCCjX2P4166+CEzeGZUzJOyuASv9h+OiL856WVLCI10Mhr+ij1JK9HUh6+KUKTItcW72reHKe66Yjmf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730078597; c=relaxed/simple;
	bh=X3EuTQofuz1Kxnka9/FKpWrAjVj8yOB+qFkui64TXOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtwoUeB2wno3ZLwHkx6embvZL3fKTYx8FB6gjBqhT1IjcyGRogHnO6RtBdDgPSJp2+aW+9pRknBezcDshciioQ2KCeWtgABt5Imr7lpQzxRCvuV4MzLOLBTMzVCnxOoXfS4YGgZIQUUBzJOJBZ8iFUC0mzsthTVl4/v4eG0hL64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCH6GoaG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7204dff188eso2289644b3a.1;
        Sun, 27 Oct 2024 18:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730078594; x=1730683394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pfcoM/US+S0lxcgB18NajQIE9x2OryfsBIrSKD3lDA=;
        b=fCH6GoaG7WBFo7GlSKehAB47RShPv4uuX3kJ2+Dvf/7MUdzt9A5BLnTfH7DB5eURL4
         6GvEyKQWHpuUo1AePVFDtoIhdE0B3tRMea5Iy7YiIY8V1dj99/QTBNHS8KrQjNAqDwp7
         h6ZnB+87Bj84jlayUq0YdeCvCE02YWt8fs1WWDMFimQqzBqN14DCjEP6j+SNBhr9Pyih
         OCyatrnDm+IU/Hfok8tn+NzRc/EQqpDS/NOvq9wAkUvcJa3ev0kPOkVfx1/m5diiUIy+
         mKa/k3btbf7YiDmifxlb4uplk/rjy6VrAdSuNSGOtDdYFyrjICqPG8ao/JzdoDKFvcwa
         n/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730078594; x=1730683394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pfcoM/US+S0lxcgB18NajQIE9x2OryfsBIrSKD3lDA=;
        b=VW+H7w+/N6M7oNFjsTdmfrgaWLcfB9nFld/556gMkbVAAvnDfCx5rFNb0pd0R6BNIG
         LMJubQMr0QXkJPMVZ6S08+bCUL+2j0EC8xlGyaNlhHxRlqtvFTEKrUO1rYbVO0F+mLmn
         uIAYKv1RqtGOHp5BItx8j2pOLEIlGIyPlwqJVnmeNEtls3XUzlWdv0t6tSbSlq+x0Oql
         mT2MqlOJGjZHiURJnEuijUZEvjhhicXydwzbi7lzHfv61Z+NH06XlsAwiz9VUJ0pOXce
         DpZgBhgUI+NrlT/Uws5fXR+m4S8ix2tgrksTQIYNmf9CCq3PiX3v4BkXdYdZ55d3E3k7
         BkYw==
X-Forwarded-Encrypted: i=1; AJvYcCU0347voD8Cb/1n3AAFiTbinTPKGcPg+j523q2daJmNHcqDqEJ2I4uoWvFNZRJbhA30i0s=@vger.kernel.org, AJvYcCWzcxLMd8sRgZXHBRMZ1CNYHk94Kuwzrl7/qv7+WF+Yq3JeZl0htcXuxfikTo4wskOCxMypCA+9/v7VDCKS@vger.kernel.org
X-Gm-Message-State: AOJu0YzfihF/x0EVyl4XX7MPKWQ9+fYuTSSgzCzRt/KHUQzAF1Ty5gy9
	B5FygebLobLUBxjBXXVanLfYKivfmGNnW1IV2g41sy90GkATNPxS67y8DUWRgD+kPdeftKIY1R7
	z4XQ6Las4ppOCE7C49ObuCw75Et4=
X-Google-Smtp-Source: AGHT+IFmI51q+curoO9sESfuD3FdMG3xomI5/3q6ImU1u6/guUyld/KIFlV2AL53Wp7FaLlGWGQXlV0FCVTTqbJzZP8=
X-Received: by 2002:a05:6a21:6816:b0:1d9:911:af03 with SMTP id
 adf61e73a8af0-1d9a85600femr8290690637.49.1730078594385; Sun, 27 Oct 2024
 18:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026154629.593041-1-mathieu.desnoyers@efficios.com>
 <20241026154629.593041-2-mathieu.desnoyers@efficios.com> <20241026200840.17171eb2@rorschach.local.home>
 <20241027231930.941d6c1f21e2b4668af44df8@kernel.org>
In-Reply-To: <20241027231930.941d6c1f21e2b4668af44df8@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sun, 27 Oct 2024 18:23:02 -0700
Message-ID: <CAEf4BzbeE6n7E6K8_dhZ26ZHoVsz8V9mUSxm3CYzz2npmdpbiQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/3] tracing: Introduce tracepoint_is_syscall()
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 7:19=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Sat, 26 Oct 2024 20:08:40 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Sat, 26 Oct 2024 11:46:28 -0400
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >
> > > Introduce a "syscall" flag within the extended structure to know whet=
her
> > > a tracepoint needs rcu tasks trace grace period before reclaim.
> > > This can be queried using tracepoint_is_syscall().
> > >
> > > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: Michael Jeanson <mjeanson@efficios.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Yonghong Song <yhs@fb.com>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Cc: bpf@vger.kernel.org
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > Cc: Jordan Rife <jrife@google.com>
> > > ---
> > >  include/linux/tracepoint-defs.h |  2 ++
> > >  include/linux/tracepoint.h      | 24 ++++++++++++++++++++++++
> > >  include/trace/define_trace.h    |  2 +-
> > >  3 files changed, 27 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoi=
nt-defs.h
> > > index 967c08d9da84..53119e074c87 100644
> > > --- a/include/linux/tracepoint-defs.h
> > > +++ b/include/linux/tracepoint-defs.h
> > > @@ -32,6 +32,8 @@ struct tracepoint_func {
> > >  struct tracepoint_ext {
> > >     int (*regfunc)(void);
> > >     void (*unregfunc)(void);
> > > +   /* Flags. */
> > > +   unsigned int syscall:1;
> >
> > I wonder if we should call it "sleepable" instead? For this patch set
> > do we really care if it's a system call or not? It's really if the
> > tracepoint is sleepable or not that's the issue. System calls are just
> > one user of it, there may be more in the future, and the changes to BPF
> > will still be needed.
>
> I agree with this. Even if currently we restrict only syscall events
> can be sleep, "tracepoint_is_syscall()" requires to add comment to
> explain why on all call sites e.g.
>

+1 to naming this "sleepable" (or at least "faultable"). BPF world
uses "sleepable BPF" terminology for BPF programs and attachment hooks
that can take page fault (and wait/sleep waiting for those to be
handled), so this would be consistent with that. Also, from BPF
standpoint this will be advertised as attaching to sleepable
tracepoints regardless, so "syscall" terminology is too specific and
misleading, because while current set of tracepoints are
syscall-specific, the important part is taking page fault, no tracing
syscalls.


>  /*
>   * The syscall event is only sleepable event, so we ensure it is
>   * syscall event for checking sleepable or not.
>   */
>
> If it called tracepoint_is_sleepable(), we don't need such comment.
>
> Thank you,
>
> >
> > Other than that, I think this could work.
> >
> > -- Steve
> >
> >
> > >  };
> > >
> > >  struct tracepoint {
> > > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > > index 83dc24ee8b13..93e70bc64533 100644
> > > --- a/include/linux/tracepoint.h
> > > +++ b/include/linux/tracepoint.h
> > > @@ -104,6 +104,12 @@ void for_each_tracepoint_in_module(struct module=
 *mod,
> > >   * tracepoint_synchronize_unregister must be called between the last=
 tracepoint
> > >   * probe unregistration and the end of module exit to make sure ther=
e is no
> > >   * caller executing a probe when it is freed.
> > > + *
> > > + * An alternative is to use the following for batch reclaim associat=
ed
> > > + * with a given tracepoint:
> > > + *
> > > + * - tracepoint_is_syscall() =3D=3D false: call_rcu()
> > > + * - tracepoint_is_syscall() =3D=3D true:  call_rcu_tasks_trace()
> > >   */
> > >  #ifdef CONFIG_TRACEPOINTS
> > >  static inline void tracepoint_synchronize_unregister(void)
> > > @@ -111,9 +117,17 @@ static inline void tracepoint_synchronize_unregi=
ster(void)
> > >     synchronize_rcu_tasks_trace();
> > >     synchronize_rcu();
> > >  }
> > > +static inline bool tracepoint_is_syscall(struct tracepoint *tp)
> > > +{
> > > +   return tp->ext && tp->ext->syscall;
> > > +}
> > >  #else
> > >  static inline void tracepoint_synchronize_unregister(void)
> > >  { }
> > > +static inline bool tracepoint_is_syscall(struct tracepoint *tp)
> > > +{
> > > +   return false;
> > > +}
> > >  #endif
> > >
> > >  #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
> > > @@ -345,6 +359,15 @@ static inline struct tracepoint *tracepoint_ptr_=
deref(tracepoint_ptr_t *p)
> > >     struct tracepoint_ext __tracepoint_ext_##_name =3D {             =
 \
> > >             .regfunc =3D _reg,                                       =
 \
> > >             .unregfunc =3D _unreg,                                   =
 \
> > > +           .syscall =3D false,                                      =
 \
> > > +   };                                                              \
> > > +   __DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_prot=
o), PARAMS(_args));
> > > +
> > > +#define DEFINE_TRACE_SYSCALL(_name, _reg, _unreg, _proto, _args)   \
> > > +   struct tracepoint_ext __tracepoint_ext_##_name =3D {             =
 \
> > > +           .regfunc =3D _reg,                                       =
 \
> > > +           .unregfunc =3D _unreg,                                   =
 \
> > > +           .syscall =3D true,                                       =
 \
> > >     };                                                              \
> > >     __DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_prot=
o), PARAMS(_args));
> > >
> > > @@ -389,6 +412,7 @@ static inline struct tracepoint *tracepoint_ptr_d=
eref(tracepoint_ptr_t *p)
> > >  #define __DECLARE_TRACE_SYSCALL    __DECLARE_TRACE
> > >
> > >  #define DEFINE_TRACE_FN(name, reg, unreg, proto, args)
> > > +#define DEFINE_TRACE_SYSCALL(name, reg, unreg, proto, args)
> > >  #define DEFINE_TRACE(name, proto, args)
> > >  #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)
> > >  #define EXPORT_TRACEPOINT_SYMBOL(name)
> > > diff --git a/include/trace/define_trace.h b/include/trace/define_trac=
e.h
> > > index ff5fa17a6259..63fea2218afa 100644
> > > --- a/include/trace/define_trace.h
> > > +++ b/include/trace/define_trace.h
> > > @@ -48,7 +48,7 @@
> > >
> > >  #undef TRACE_EVENT_SYSCALL
> > >  #define TRACE_EVENT_SYSCALL(name, proto, args, struct, assign, print=
, reg, unreg) \
> > > -   DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
> > > +   DEFINE_TRACE_SYSCALL(name, reg, unreg, PARAMS(proto), PARAMS(args=
))
> > >
> > >  #undef TRACE_EVENT_NOP
> > >  #define TRACE_EVENT_NOP(name, proto, args, struct, assign, print)
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

