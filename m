Return-Path: <bpf+bounces-57599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41979AAD28A
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA22983A5A
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 01:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BFE78F3A;
	Wed,  7 May 2025 01:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wifdi2vt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07328F5E
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746580527; cv=none; b=T3hOApPQByNfO2wDCw1nQBLNCg3NvonQa1WgQfxrDGkqVyhuO4NLuxd2k9uFJ82hjnA3Tny+TQh4d+L01kvIpdd0KwHfxsSRqkCmtlQGLWIAs5XnOKztlLtzHbQ43vDOE2KBiYzHi1zGOwr4IrGRylQIaxHHBzi7RFTaF0Jom0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746580527; c=relaxed/simple;
	bh=jb3VKBeevjhqI3Xh+0fxysqkqj5AQpslCS67+9qs6qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSeV9660ukKx9NjEYpgv05KkI8sOmSobQYRM7tsFVv3cJwIyduvqlVtU0ENBANR4QFkkf8Xf3RltG0KshNOk8g3T7UL3HYJWTvMYY4N+PlAE0MhwA24aD9fVfqnMwm6+m/fxvVpNVRPUOlNWfCwHK0uWjQy9qHKkoS2ah8bdYJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wifdi2vt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso2249655e9.1
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 18:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746580524; x=1747185324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oWcgAVxcGB2zyvnKRgkhJDcwpCqaqMn3wuwHBaY4Kw=;
        b=Wifdi2vtAhRP+b37lAsY1h23QW7JHceQlkBpJeTYk4fE9rwJHLJy0UOquyNkiT3TCu
         dfRZvZeu0diGAc90AcVmIovNIKYoy3reMqqseuY/QnWmLGTvTVmwzJFj+9cq1qs3+FGQ
         m9G4hoKpTDUez8XYv8V7mpM1QNPVa+mHDM+WS49xpjO2MAC7GxWsH1onbp0XuxD8TzMY
         2g1w0gGdAaZiuFtDHjLC1s7DyQeSNGUSxxVTfd70eRh+fmf9sHN9IHs2Y15fztw6+USa
         sBl4PcUr04qfl9nXPUxrQ7StNAvu/nvNjZauyvlujAH5hIcIeFo+OermQ7I60om/z8ax
         WPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746580524; x=1747185324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oWcgAVxcGB2zyvnKRgkhJDcwpCqaqMn3wuwHBaY4Kw=;
        b=BX0RVHP3+a9iFjqti2ugtGhG0ZUauDHSduhRFSawVnFtSCrIqNIOpx31MwPKobLcnY
         sy0KaYj9miZ/EIQa+5QiJR72JssPj5m8somgt1Sti7LoQU7pB3GLGRf8ARkaM2QiRxX7
         uCZ5d9sx4EMPeu+27Nwaq+KM8CsTNqnheS3qB51wlHg6cx1y6I81U065NNamEzLY6ffF
         9rUhyoJmBND8DJwRt84X2LMK2B7hhS+vbELNgcjSG/IbncpTo6DAl/ecs4NZNmwlyw/M
         4ic15UYU0tlJagcLR7a+B97GWsMSM4Z4BWQT4rFmEL0qRbvWVZYlWdvMFw26UN886NzW
         vftg==
X-Forwarded-Encrypted: i=1; AJvYcCUc6z4qse+ilDk+lNIHQELgV8txYi2hhm2s0521b+SVBnAmNTgs5FJXbR57qLAmAO7A0e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSjTZcUGN6t40oCMl0tD9I313go7MPgeyCkKYXidITlouCDzZ4
	+tK3S9Kt/qcbmr2zq4bhzWj4NmfQvaZUtP8YfVINPIdMiXyLF7urV/EL0z9aKyXoyImrZtr34bX
	lTI1jdIVguf6N0y+qAJo2WbIwRFE=
X-Gm-Gg: ASbGnct6W3HIHBtlHwDo9HpEWn9Vg259eKlb2q3HhtG/LQmDm5yjLLAoiwFJxQ6aapk
	zDCwGxBs1YURB5Kdrh6dwRCh4CGpNG00K6Eiim+KT1NXD0imZhh3bLjHG9mDq4gYYLzvxEkJK1U
	OrHl5JEZ5j7mGTlJ6FtZCUGe/96vuTPwCGiWuDsnQQ36YlWP2Yiw==
X-Google-Smtp-Source: AGHT+IGkUWRBZdLoGPC4PL80rAevTqmrmLPcv3fj5ZvIqWAhZ6vtz3dvTqbfSARqPIpzf9ReYypijfiR8giMZQq7Y9A=
X-Received: by 2002:a05:600c:8509:b0:43d:224:86b5 with SMTP id
 5b1f17b1804b1-441d44bc62emr9063055e9.4.1746580523740; Tue, 06 May 2025
 18:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <CAP01T75B87Vnq-kdq6gaNXj5xeOOiah-onm4weEZA=jm8W8JVQ@mail.gmail.com>
 <CAM6KYsuk060Fv43Djp4q57AwBcmmkHBitGgfSsCJZwbGqRmQEA@mail.gmail.com>
 <CAADnVQL_+5FiOwNEnaYZ-i52r4jDiStboWxA9VycARFboOjx6Q@mail.gmail.com>
 <CAP01T757KLkBx3FMAK8-7vYTO0v=RtWvkQpztS1Zugd8tHSnHA@mail.gmail.com>
 <CAADnVQKzgELtqZ_4pce7sOegE1i3azcija0w6Bn5OWH0LgpbQg@mail.gmail.com> <CAP01T75O90bgYeb1q1ot+=D9MxN3UXyji5T6mA+UsnPwQUF52g@mail.gmail.com>
In-Reply-To: <CAP01T75O90bgYeb1q1ot+=D9MxN3UXyji5T6mA+UsnPwQUF52g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 May 2025 18:15:11 -0700
X-Gm-Features: ATxdqUERyq3_2Gr11xWTjS4xb9lkseOMr41Sk3NEGoyZdVVvCWWuvcSO4bPx9eY
Message-ID: <CAADnVQKsjGFhqsZ6s8SRNbv=Fr3oU=o3GquvOwqg27S9m8B02w@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/4] bpf: Fast-Path approach for BPF program Termination
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Raj Sahu <rjsu26@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, 
	doniaghazy@vt.edu, quanzhif@vt.edu, Jinghao Jia <jinghao7@illinois.edu>, 
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:39=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Wed, 7 May 2025 at 02:33, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, May 6, 2025 at 4:00=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@=
gmail.com> wrote:
> > >
> > > On Wed, 7 May 2025 at 00:45, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, May 5, 2025 at 10:55=E2=80=AFPM Raj Sahu <rjsu26@gmail.com>=
 wrote:
> > > > >
> > > > >       2. A BPF prog is attached to a function called by another B=
PF program.
> > > > >              - This is the interesting case.
> > > > >
> > > > > > What do you do if e.g. I attach to some kfunc that you don't st=
ub out?
> > > > > > E.g. you may stub out bpf_sk_lookup, but I can attach something=
 to
> > > > > > bpf_get_prandom_u32 called after it in the stub which is not st=
ubbed
> > > > > > out and stall.
> > > > >
> > > > > We have thought of 2 components to deal with unintended nesting:
> > > > > 1. Have a per-CPU variable to indicate a termination is in-progre=
ss.
> > > > >     If this is set, any new nesting won't occur.
> > > > > 2. Stub the entire nesting chain:
> > > > >     For example,
> > > > >     prog1
> > > > >          -> prog2
> > > > >                 -> prog3
> > > > >
> > > > >    Say prog3 is long-running and violates the runtime policy of p=
rog2.
> > > > >    The watchdog will be triggered for prog2, in that case we walk
> > > > > through the stack
> > > > >    and stub all BPF programs leading up to prog2 (In this case pr=
og3
> > > > > and prog2 will
> > > > >    get stubbed).
> > > >
> > > > I feel that concerns about fentry/freplace consuming too much
> > > > while parent prog is fast-exiting are overblown.
> > > > If child prog is slow it will get flagged by the watchdog sooner or=
 later.
> > >
> > > No, there's some difference:
> > > It becomes more common because we're continuing to execute the suffix
> > > of the program in the stub.
> > > Compared to stopping executing and returning control immediately.
> > >
> > > > But fentry and tailcall cases are good examples that highlight
> > > > that fast-execute is a better path forward.
> > > > Manual stack unwind through bpf trampoline and tail call logic
> > > > is going to be quite complex, error prone, architecture specific
> > > > and hard to keep consistent with changes.
> > > > We have complicated lifetime rules for bpf trampoline.
> > > > See comment in bpf_tramp_image_put().
> > > > Doing that manually in stack unwinder is not practical.
> > > > iirc bpf_throw() stops at the first non-bpf_prog frame including
> > > > bpf trampoline.
> > > > But if we want to, the fast execute approach can unwind through fen=
try.
> > > > Say hw watchdog tells us that CPU is stuck in:
> > > > bpf_prog_A
> > > >    bpf_subprog_1
> > > >      kfunc
> > > >        fentry
> > > >           bpf_prog_B
> > > >
> > > > since every bpf prog in the system will be cloned and prepared
> > > > for fast execute we can replace return addresses everywhere
> > > > in the above and fast execute will take us all the way to kernel pr=
oper.
> > >
> > > The same will be true for unwinding, we can just unwind all the way t=
o
> > > the top of the stack trace in case of cancellation-triggered
> > > unwinding.
> > > If trampoline calls some program, it will see it as a return from the
> > > called BPF program just like stubs would return.
> > >
> > > You're essentially going to replace return addresses to jump control
> > > to stubs, we can do that same for jumping into some unwinding code
> > > that can continue the process.
> > > Be it unwinding or stubs, once control goes back to kernel and clean
> > > up must continue, we will have to pass control back to code for both.
> > >
> > > Conceptually, both approaches are going to do something to clean up r=
esources,
> > > that can be executing stub code or calling release handlers for
> > > objects on stack.
> >
> > I feel you're missing my point.
> > For unwinding to work through bpf trampoline the unwinder needs
> > to execute very specific trampoline _exit_ procedure that is arch
> > specific and hard coded during the generation of trampoline.
> > That's a ton of extra complexity in unwinder.
> > It's not just calling destructors for objects.
> > Depending on trampoline and the progs in there it's one or more
> > __bpf_prog_exit*, percpu_ref_put(),
> > and extra headache due to bpf_stats_enabled_key(),
> > and who knows what else that I'm forgetting.
>
> What I'm saying is that we don't have to do all that.
> It's just overcomplication for the sake of it.

So you discarded this use case because the unwind approach
cannot deal with it?
And then claim that within this limited scope they're equivalent?
:)
prog -> trampoline -> prog was just one example.
unwinder is helpless when there is any kernel code between progs.
sched-ext will have hierarchical scheds eventually.
prog->kfunc->prog
Unwinding inner prog only is imo broken, since we need to abort
the whole thing.
Even simpler case:
prog->for_each->subprog_callback.
That callback is likely tiny and unwinding into for_each kfunc
doesn't really abort the prog.
Unwind approach works in higher level languages because the compiler
sees the whole control flow from main entry till the leaf.
The verifier is blind to kernel code, so unwind is limited
to progs only and doing it poorly. We still don't have support
for bpf_throw with object cleanup and at this point we should
align all efforts into fast execute, since it's clearly the winner.
bpf_throw may stay as a kfunc with fast execute underneath or
we may remove it, since it has no users anyway.

