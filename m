Return-Path: <bpf+bounces-60083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0218AD25BF
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 20:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687191891671
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4795A21D3D6;
	Mon,  9 Jun 2025 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd72mHzE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F37C218EA7;
	Mon,  9 Jun 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494294; cv=none; b=l1v6WGnUJ3r8OkgmYufqtF2XpsRpQ4gkjpviZDjCZtIbw0SEUpTNecRc/A/rwTTVfnG4VKhjWdvC7FRq8tOfdrVaiCBuW8fINTPy2+KwkXPBpatQPxjVNMwDFmI/Nh9XSxPVesNuzXWN6Wd3OUYkdbMRDix2y9Fs1AUnwNI0MPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494294; c=relaxed/simple;
	bh=tuw5hfAO6pfAw54+AasME1BzZdzy9gMf5PS77lO5HjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZI9XNEfdmEO835szBu2oruHvCAFuOrkWlh/NIBcmyUSGhD10LdmmxL3Sq5Fpc+Q3eRYBkbFAHxpS3DgiSVKAAAD4fwrKsNVwIKIFfk3sdEdn6a+XOjsALB00J+N6i0o5gKst0uqQD0XYmcQkUVE+xV8IUCaY0uFjyB4dkbyQmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cd72mHzE; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70a57a8ffc3so45003607b3.0;
        Mon, 09 Jun 2025 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749494292; x=1750099092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qhp29CuIb7iGqIWK2izDqy/zUPnZPCcXPtGOH8g1wF4=;
        b=Cd72mHzEmVi7MIx1tsIQh5vGsSD6dRBSJCXkm23qmIDLJ44BhHjbdGOIplTtNKwlNr
         ZZfuwqc4QpUXGGM92013GQpmDBOLAMrMkc9y1TQzPARQczMjKdJSH00kq6lXs4eW8enL
         S8nbh6J9G4xtyJhZazeA2S0hqZGiz41oZBLa2YcSMw9Q25ICqdjsF8DWmPG3KnZQbZI8
         vdNP4ncJTZl+j69PUgEXJUkO8ZfumE8GuVL1enV8rD2PIU/uaj81OhzwqKUvQhW48R1O
         RzzRQXu52PK7YC9Gw+rB0PuShVeoTqe+t9OF6M6Z8FzJqretIlfIUEJvDCUTLxgo+UGv
         ewog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749494292; x=1750099092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qhp29CuIb7iGqIWK2izDqy/zUPnZPCcXPtGOH8g1wF4=;
        b=n5tbNy1MhiBLywuCDA7pUauj1NF9w+194t9s9pQ+UG/wTbRJwYbVSwggAB0gOf/3gV
         0RDUzR7kuk6Gyz7rWxJpNPgGH5PHvINcwSAUm561NyzGncp1NvFPMZl0LaBcv7JDdqva
         3rWM2oVFEMCDxKGSncQhfvDThNMwj1VYQgrSWM2BMFG7q0qN69ci73HZjj57Xh3Jpe5C
         qGG3j8yVheWx32PhP/afy8s7+KNjZ5TZcFqPJHy6g8CFmZFJ8tE7KT9UviOfixSBKDP8
         7veHrOswn8Od2gukdG9vrtoArMc7cPZIYKGYA9Z/qpP/JeEqyPV33AE+xXK5p3MX7SjA
         D54w==
X-Forwarded-Encrypted: i=1; AJvYcCVrGpcAlg5UROaoFbygRpXpNbKWwJc0UrxKzymlZ1Fv6fv8SJt8S+uAjP484x+x0PjXoZk3C2z1TVFHtfhVwmhc8g==@vger.kernel.org, AJvYcCWO2MKBhBqifOoGjHfsnckqX6LWZlalHqwNKqJ/MiaYTBwf4v3TKUhBSB8ZSRho0dJI6Fg=@vger.kernel.org, AJvYcCXrdCf92pN6U06LbOcVByh3jJNkR1kyW6Zv2ci8xEdgTETATmpf/o/4hAgoQCZPU6/mJKUoV4PAWOnr65Qx@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpmm17pRU9wvmQsn1cr4Q6upBZxstQQTkBDHvbKQgkMEGsQ9tA
	cYu6JNuYE5BX3/+N0hZHqXaSSYsZBJHaNxDRZQhkyu1scWf6upJjVRcIRMnbJOCHNxwG81CsTEg
	NTZPGFy+xoU/3nTJ+GGB/VFIoOOBNnmI=
X-Gm-Gg: ASbGncsK2b6dnw5Bygsg5PSrKWGQzx4B5DjHwpf3JtS1cXHVogqMMA61rX+H9kcrK/o
	m20TpYa31/R4JnKvW0ksLMVBujG6SaH25w27lggqbzK8tkuiRXLwiov028iHlMd8YLOjETcZEu9
	JIjURJq1SX2E0r53zZvFHJd7pjSrMBp25lzMxhkJKPyA==
X-Google-Smtp-Source: AGHT+IEA0OiVnuSQGUrHzwOA9PG1/Ehf5LU2jf1N8aiKnF5p6Xlm7aeavf+MEx+4ct/p8cyUhmjffyP1BWPj61x75X4=
X-Received: by 2002:a05:690c:6f0d:b0:70d:ed5d:b4bf with SMTP id
 00721157ae682-710f7710633mr191012327b3.24.1749494291936; Mon, 09 Jun 2025
 11:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529065537.529937-1-howardchu95@gmail.com>
 <aDpBTLoeOJ3NAw_-@google.com> <CAH0uvojGoLX6mpK9wA1cw-EO-y_fUmdndAU8eZ1pa70Lc_rvvw@mail.gmail.com>
 <20250602181743.1c3dabea@gandalf.local.home> <aEAfHYLEyc7xGy7E@krava>
In-Reply-To: <aEAfHYLEyc7xGy7E@krava>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 9 Jun 2025 11:38:00 -0700
X-Gm-Features: AX0GCFuPGtDfipaA_75L7T4H9ErlTIAUaONsbR5a8kUDQD8o6sw_DY1_XDDZsA0
Message-ID: <CAH0uvogvkRoHc6jWYSJHLenaRMru23YaGfA1i_vWZ6eF9LwVzw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf trace: Mitigate failures in parallel perf
 trace instances
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, acme@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Wed, Jun 4, 2025 at 3:25=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Mon, Jun 02, 2025 at 06:17:43PM -0400, Steven Rostedt wrote:
> > On Fri, 30 May 2025 17:00:38 -0700
> > Howard Chu <howardchu95@gmail.com> wrote:
> >
> > > Hello Namhyung,
> > >
> > > On Fri, May 30, 2025 at 4:37=E2=80=AFPM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > (Adding tracing folks)
> > >
> > > (That's so convenient wow)
> >
> > Shouldn't the BPF folks be more relevant. I don't see any of the tracin=
g
> > code involved here.
> >
> > >
> > > >
> > > > On Wed, May 28, 2025 at 11:55:36PM -0700, Howard Chu wrote:
> > > > > perf trace utilizes the tracepoint utility, the only filter in pe=
rf
> > > > > trace is a filter on syscall type. For example, if perf traces on=
ly
> > > > > openat, then it filters all the other syscalls, such as readlinka=
t,
> > > > > readv, etc.
> > > > >
> > > > > This filtering is flawed. Consider this case: two perf trace
> > > > > instances are running at the same time, trace instance A tracing
> > > > > readlinkat, trace instance B tracing openat. When an openat sysca=
ll
> > > > > enters, it triggers both BPF programs (sys_enter) in both perf tr=
ace
> > > > > instances, these kernel functions will be executed:
> > > > >
> > > > > perf_syscall_enter
> > > > >   perf_call_bpf_enter
> > > > >     trace_call_bpf
> >
> > This is in bpf_trace.c (BPF related, not tracing related).
> >
> > -- Steve
> >
> >
> > > > >       bpf_prog_run_array
> > > > >
> > > > > In bpf_prog_run_array:
> > > > > ~~~
> > > > > while ((prog =3D READ_ONCE(item->prog))) {
> > > > >       run_ctx.bpf_cookie =3D item->bpf_cookie;
> > > > >       ret &=3D run_prog(prog, ctx);
> > > > >       item++;
> > > > > }
> > > > > ~~~
> > > > >
> > > > > I'm not a BPF expert, but by tinkering I found that if one of the=
 BPF
> > > > > programs returns 0, there will be no tracepoint sample. That is,
> > > > >
> > > > > (Is there a sample?) =3D ProgRetA & ProgRetB & ProgRetC
> > > > >
> > > > > Where ProgRetA is the return value of one of the BPF programs in =
the BPF
> > > > > program array.
> > > > >
> > > > > Go back to the case, when two perf trace instances are tracing tw=
o
> > > > > different syscalls, again, A is tracing readlinkat, B is tracing =
openat,
> > > > > when an openat syscall enters, it triggers the sys_enter program =
in
> > > > > instance A, call it ProgA, and the sys_enter program in instance =
B,
> > > > > ProgB, now ProgA will return 0 because ProgA cares about readlink=
at only,
> > > > > even though ProgB returns 1; (Is there a sample?) =3D ProgRetA (0=
) &
> > > > > ProgRetB (1) =3D 0. So there won't be a tracepoint sample in B's =
output,
> > > > > when there really should be one.
> > > >
> > > > Sounds like a bug.  I think it should run bpf programs attached to =
the
> > > > current perf_event only.  Isn't it the case for tracepoint + perf +=
 bpf?
> > >
> > > I really can't answer that question.
>
> bpf programs for tracepoint are executed before the perf event specific
> check/trigger in perf_trace_run_bpf_submit
>
> bpf programs array is part of struct trace_event_call so it's global per
> tracepoint, not per perf event
>
> IIRC perf trace needs the perf event sample and the bpf program is there
> to do the filter and some other related stuff?

Actually perf trace relies on BPF programs to produce samples and do
filtering, but it can also turn BPF off and use tracepoints only.

>
> if that's the case I wonder we could switch bpf_prog_run_array logic
> to be permissive like below, and perhaps make that as tracepoint specific
> change, because bpf_prog_run_array is used in other place

Thanks but as Alexei said this may break those who depend on it.

>
> or make it somehow configurable.. otherwise I fear that might break exist=
ing
> use cases.. FWIW bpf ci tests [1] survived the change below
>
> jirka
>
>
> [1] https://github.com/kernel-patches/bpf/pull/9044
>
> ---
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5b25d278409b..4ca8afe0217c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2218,12 +2218,12 @@ bpf_prog_run_array(const struct bpf_prog_array *a=
rray,
>         const struct bpf_prog *prog;
>         struct bpf_run_ctx *old_run_ctx;
>         struct bpf_trace_run_ctx run_ctx;
> -       u32 ret =3D 1;
> +       u32 ret =3D 0;
>
>         RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");
>
>         if (unlikely(!array))
> -               return ret;
> +               return 1;
>
>         run_ctx.is_uprobe =3D false;
>
> @@ -2232,7 +2232,7 @@ bpf_prog_run_array(const struct bpf_prog_array *arr=
ay,
>         item =3D &array->items[0];
>         while ((prog =3D READ_ONCE(item->prog))) {
>                 run_ctx.bpf_cookie =3D item->bpf_cookie;
> -               ret &=3D run_prog(prog, ctx);
> +               ret |=3D run_prog(prog, ctx);
>                 item++;
>         }
>         bpf_reset_run_ctx(old_run_ctx);

Thank you so much for looking into this.

Thanks,
Howard

