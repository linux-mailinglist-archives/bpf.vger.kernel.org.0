Return-Path: <bpf+bounces-46304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A26E9E7803
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC5018859B7
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D116202F71;
	Fri,  6 Dec 2024 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAZ+f0ai"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F7E1F3D46;
	Fri,  6 Dec 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509295; cv=none; b=d70TDIhIe6CLWmB9gXZEVKjntIof5hkgktpr2kF3zjv0UA9M9uwj5ZYjlEFvKh0YcOVMq3tGjewXwmfZ1nkMa0fTbHaH4PIgv2zjwXONKtBtpGx+lFrIgxMMP7Jc1q/Dn8Ed0N3wVnR02v7xexzveJAxaDGxGGwstC/NhycvpS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509295; c=relaxed/simple;
	bh=1piNB8xzR5KwmQoJEVJYrv7/HCwrqzlU5eo28NslhCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqZpeIvm4NFn4hOXqzDYsTTh8KiSbqLUwsW2jVKtjWeLpAgdWnE2vib8tfEuybXmNnfH4VGxCq0iiFati7KxHaZe/8I3OJTe5GMaYpi1VJCPEdNiITUM9MgehpBRqYM7BkD2YgW8dZ2tmC9d/FMoR46RvetgV3+mo5KFmlyOV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAZ+f0ai; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea8de14848so1901157a12.2;
        Fri, 06 Dec 2024 10:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733509292; x=1734114092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHAeacS/DwVgm6nHB9cC7jADdMn3yI2TM513voHuT1s=;
        b=hAZ+f0aieaJcXwNKhkehyEZ3VoKX+bEDyOsr5jpI/GaFtYrtIzUm/buacbZ3PG1SSK
         e2d/q6cIDkWVSktqMj8GQSUD9F+jyvFuAnWJXzAl6HX0wrkuHnnnKC+0kHMklmuAi8u6
         RQjQ6P2dC3CM6eYg7RLFub4imH4+tuKNP64nJ/pdcxGGxLwUPCS6fD5DBmWTSB7U+hXU
         lgQg7dFTDCRG0UQtyz5ivCEE1ugn6Eg5fkYUG+jrUomsQ90rhI+g1iTQkb9+aVciSjC3
         rIQIeqCN68DFNKJdoygUJkfPm52Xgax6kMSCYNUZvijXhk6V11uqNEBkv8hT5Vacw2qE
         CJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733509292; x=1734114092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHAeacS/DwVgm6nHB9cC7jADdMn3yI2TM513voHuT1s=;
        b=UDNeOddctLVGyzMHRpt8iXZTBxbLD7P1J1cPDbQjxgPtxNd6HJTK5M+PwMpZiyHCBj
         gWdFeVcMlSkXojgyldlbTWnWH8l//rqUr6zIQN0mK6of9h8NsE0GH9+wide14YbfhC3Y
         ydNBm0wSxKZmeodEAnodUGWv9ZPGExEJuiYpBQ9BJxZvFvgLQhT4xSiosuFlzghFF8Ux
         i5AThzIO/5Ip99ivXnzGhzCvolEno8mhzK/Jm/1vO+2h7KifJaR3PF+ZlhLVj3an5fcB
         DJc2iEuE0X2sqtN/ZrrUUkjSXkTyAsPbhHqlhNb9AyEQU1Sdr9BHUc/IWRH5bQL8/ci0
         kJkg==
X-Forwarded-Encrypted: i=1; AJvYcCUO67f5Oj8XDgezcVKyq28CiGfoLmHSk4WPhfsJHo8bQ1NV+1uRhbT3FmGrMmb9rOGSlH1mKFKNgH82hwGlPzVdIw==@vger.kernel.org, AJvYcCX0CSjhd/iES0Zk2Qy348zNiV5QDhymLjRudbtg2wzKsp527atWsRDE56XYaXf1CKMKsCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3dvLcyLQPAYyKfNN+Fc+ElKi6Tprq67s9JDVDXgA0cam1w7ql
	ZFBo7rrRQualoZqucJx9RMxSzR8DpSc9mYDJVm3VwXnOQmFwJZTp8hyy8yEtH14eZlxES1z/QjP
	zYAY3ISMw3E0F6tIisVpU4luNSyw=
X-Gm-Gg: ASbGncsFluu1lKyC0E/cafU0eR0QeG1zF6MEifr5eweMHr7+vmnbMwYDhoc+Bedbn33
	jk68MxeHS9mmZ2xJQGyVoRkYchimTK0jEwUTZa2TFd+va2Cs=
X-Google-Smtp-Source: AGHT+IGTMd6bAgNXLd74gpaeokUpgxFSeeZ8xc9pgVboYp82LKv1y/IdlXsoFOjtvepXtQHEKX/5VzkKJ77dP7SBkTk=
X-Received: by 2002:a17:90b:4c48:b0:2ee:aed2:c15c with SMTP id
 98e67ed59e1d1-2ef6ab093e9mr5768058a91.28.1733509292195; Fri, 06 Dec 2024
 10:21:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023100131.3400274-1-jolsa@kernel.org> <CAEf4BzbZdaPaspRAVP7=UcfpFzR4qhksJTRiEwiZ9RDQtdg0bQ@mail.gmail.com>
 <Z1Mv3wjtonrX_ptM@krava>
In-Reply-To: <Z1Mv3wjtonrX_ptM@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Dec 2024 10:21:18 -0800
Message-ID: <CAEf4BzZ4nzqWcn9iNPhRY4dfhNWrMp+D8Gxs7eTBqie=g55o5Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf,perf: Fix perf_event_detach_bpf_prog error handling
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Sean Young <sean@mess.org>, Peter Zijlstra <peterz@infradead.org>, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 9:09=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Wed, Oct 23, 2024 at 09:01:02AM -0700, Andrii Nakryiko wrote:
> > On Wed, Oct 23, 2024 at 3:01=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Peter reported that perf_event_detach_bpf_prog might skip to release
> > > the bpf program for -ENOENT error from bpf_prog_array_copy.
> > >
> > > This can't happen because bpf program is stored in perf event and is
> > > detached and released only when perf event is freed.
> > >
> > > Let's make it obvious and add WARN_ON_ONCE on the -ENOENT check and
> > > make sure the bpf program is released in any case.
> > >
> > > Cc: Sean Young <sean@mess.org>
> > > Fixes: 170a7e3ea070 ("bpf: bpf_prog_array_copy() should return -ENOEN=
T if exclude_prog not found")
> > > Closes: https://lore.kernel.org/lkml/20241022111638.GC16066@noisy.pro=
gramming.kicks-ass.net/
> > > Reported-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  kernel/trace/bpf_trace.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 95b6b3b16bac..2c064ba7b0bd 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -2216,8 +2216,8 @@ void perf_event_detach_bpf_prog(struct perf_eve=
nt *event)
> > >
> > >         old_array =3D bpf_event_rcu_dereference(event->tp_event->prog=
_array);
> > >         ret =3D bpf_prog_array_copy(old_array, event->prog, NULL, 0, =
&new_array);
> > > -       if (ret =3D=3D -ENOENT)
> > > -               goto unlock;
> > > +       if (WARN_ON_ONCE(ret =3D=3D -ENOENT))
> > > +               goto put;
> > >         if (ret < 0) {
> > >                 bpf_prog_array_delete_safe(old_array, event->prog);
> >
> > seeing
> >
> > if (ret < 0)
> >     bpf_prog_array_delete_safe(old_array, event->prog);
> >
> > I think neither ret =3D=3D -ENOENT nor WARN_ON_ONCE is necessary,  tbh.=
 So
> > now I feel like just dropping WARN_ON_ONCE() is better.
>
> hi,
> there's syzbot report [1] where we could end up with following
>
>   - create perf event and set bpf program to it
>   - clone process -> create inherited event
>   - exit -> release both events
>   - first perf_event_detach_bpf_prog call will release tp_event->prog_arr=
ay
>     and second perf_event_detach_bpf_prog will crash because
>     tp_event->prog_array is NULL
>
> we can fix that quicly with change below, I guess we could add refcount
> to bpf_prog_array_item and allow one of the parent/inherited events to
> work while the other is gone.. but that might be too much, will check
>
> jirka
>
>
> [1] https://lore.kernel.org/bpf/Z1MR6dCIKajNS6nU@krava/T/#m91dbf0688221ec=
7a7fc95e896a7ef9ff93b0b8ad
> ---
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index fe57dfbf2a86..d4b45543ebc2 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2251,6 +2251,8 @@ void perf_event_detach_bpf_prog(struct perf_event *=
event)
>                 goto unlock;
>
>         old_array =3D bpf_event_rcu_dereference(event->tp_event->prog_arr=
ay);
> +       if (!old_array)
> +               goto put;

How does this inherited event stuff work? You can have two separate
events sharing the same prog_array? What if we attach different
programs to each of those events, will both of them be called for
either of two events? That sounds broken, if that's true.

>         ret =3D bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new=
_array);
>         if (ret < 0) {
>                 bpf_prog_array_delete_safe(old_array, event->prog);
> @@ -2259,6 +2261,7 @@ void perf_event_detach_bpf_prog(struct perf_event *=
event)
>                 bpf_prog_array_free_sleepable(old_array);
>         }
>
> +put:
>         bpf_prog_put(event->prog);
>         event->prog =3D NULL;
>

