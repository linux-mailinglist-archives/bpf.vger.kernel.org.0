Return-Path: <bpf+bounces-57597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAE1AAD257
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 02:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F824A77BF
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 00:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB02B20330;
	Wed,  7 May 2025 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4zHO/iZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C4023DE
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746577985; cv=none; b=Qh5qj4BDmupMZ+aeAy0gef/Q+UQmyETWJRs8+FGmdndQRI7mCR8baDD5lI3IJ++swdNBkOpMSS7ZwDLJP85uXy8xXM6D2+EA43IsUmv1wLM3s+lMXVaH0R6ji3vdeb3b/XXTFHUTM5T9FaphsiJiqdEo/Tq2kMOIbotirJjGNU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746577985; c=relaxed/simple;
	bh=r1CcimApjHklPpOUBD/mqQ7m5aCg5NXeQ7eX2TyKqKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bh7XbWU/DdSwiR1J132xCeQ4fWs8JG1Y8lfZ78uPoebSbAUH3HFf4qs3NSBEQTEwuf7z9vPUJmjQDo2PTS/st7fS2M7MkfFF6s2R44NqPcQbQa8WB45QwvrmQIlLdbaSMkwKTWWYQtgcZpB/Xh4m4wm5kv7Irtmtet5gJoM60jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4zHO/iZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39ee682e0ddso4205789f8f.1
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 17:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746577982; x=1747182782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft9eLkXIZNxageG2eoP6bBDQLatTPbKPQ5iqNWTXTG4=;
        b=W4zHO/iZal8OUXogU3jo4g53kt5dEUT1n70Ab+XEZBu3b0j3cKSD5eMgoS9GqnKV6M
         wxymtDqeSPrLJzCiNccnUrJBtWpU0epm5HCg3qRfK/pV1C+veaPi0+SL7kWK9OEPXblL
         DzJz2XvRcFtZzRwjGGwylohEv3iJf/a/MuHt+xR9U7B5X1PKxvqT/xEegpIWxM2H5E8B
         SHZ/HknRLsCyWOm65INX3D6/JgsM276Y3OqzoqLxCkeywGN42QJPJgwjY+eCXyY3Er5q
         lzYTiJjjmv488hsDQ/gJ16GFgR3+bjzSIh2cI8jECfyqHBEMGgvnxlpSm/gLbHQWG5Rq
         Uh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746577982; x=1747182782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ft9eLkXIZNxageG2eoP6bBDQLatTPbKPQ5iqNWTXTG4=;
        b=Co+mz0GIte4fGu8UwyZCQpVkxjryWWzWM9WNiQpneUgcbnr9HoIH5jwK1OvBy2I3rd
         uowX6piL29dBEm4LPabgeYQHjZxjqTqYpVMpvPML4f2fb5gf3eWN6d8UL65jNp0tNGxQ
         XmJRpWTmbXF2Vwc08PDw3MiexWIQmoij1sy3qadV2nRFIEsJ0ltEE4WUGtCaTSklp9tL
         tXSgV/F7cYPe20IT7+kUzD2MlWhBZB/kF+QpT+maCWlPqumyFQBmpLn7e+Qf3gSncNWT
         zKeQE229h7HJp7nY06VaAsubT+kL/pBZKV4Ki9/kYcRtk054LfisZ/a2UlvSRlpINKne
         /D4A==
X-Forwarded-Encrypted: i=1; AJvYcCWcMHwaDmi/s8EOHOm93cBneitSysKGiSgubEfGlrhngLkD3zK5yG+EhQrsvLaQXmiQcCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj6KeLmpQxVnJDF/JJSdKqpw7gpkj5jAIsP1sALWg53Y3ymDg/
	yqXywXuRZQEjBWK4VjG5d2kRQwyHLIVKun3x/HtLVyoq9o5d2SpEx1SkBfUPl6KR01tlfbBx0fJ
	SVEPPWSz591u5YaXmB/bL9ELlvCk=
X-Gm-Gg: ASbGnctOUPrl85lWPw3Ecs/dKGhwYWjGl/RCxPMXAFLdweHb58ISX7k5u1R6WX2aTjM
	cUpzVuiDHvyi8wSVBmpvt4+pn7eVw8XZFcCysw3c/RWy8Mgih+1oNO5Zdv80fem/cMEBpTYAUUg
	WIbzXCiu0IeVzQMQUAGWKIh1AGJZgVqgna6PNPzHDeQm2c62LTYc+MSq9rLRcD
X-Google-Smtp-Source: AGHT+IEJ6bQaQoPxTxKw8PqbSaSbqMsxudnem4HHnDIPlnsSE6bpuWvyX6Rw0vEllCoBnm2mPN3kWMPmYxflYFGcN/I=
X-Received: by 2002:a05:6000:22c2:b0:3a0:b0e0:5649 with SMTP id
 ffacd0b85a97d-3a0b4a1c4e2mr1052497f8f.33.1746577981477; Tue, 06 May 2025
 17:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <CAP01T75B87Vnq-kdq6gaNXj5xeOOiah-onm4weEZA=jm8W8JVQ@mail.gmail.com>
 <CAM6KYsuk060Fv43Djp4q57AwBcmmkHBitGgfSsCJZwbGqRmQEA@mail.gmail.com>
 <CAADnVQL_+5FiOwNEnaYZ-i52r4jDiStboWxA9VycARFboOjx6Q@mail.gmail.com> <CAP01T757KLkBx3FMAK8-7vYTO0v=RtWvkQpztS1Zugd8tHSnHA@mail.gmail.com>
In-Reply-To: <CAP01T757KLkBx3FMAK8-7vYTO0v=RtWvkQpztS1Zugd8tHSnHA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 May 2025 17:32:50 -0700
X-Gm-Features: ATxdqUET9t-qyXc9Mc-NbAUQR6_cit3-PSClWkCySfCMrsKuLSowISlwCGqv54o
Message-ID: <CAADnVQKzgELtqZ_4pce7sOegE1i3azcija0w6Bn5OWH0LgpbQg@mail.gmail.com>
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

On Tue, May 6, 2025 at 4:00=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Wed, 7 May 2025 at 00:45, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, May 5, 2025 at 10:55=E2=80=AFPM Raj Sahu <rjsu26@gmail.com> wro=
te:
> > >
> > >       2. A BPF prog is attached to a function called by another BPF p=
rogram.
> > >              - This is the interesting case.
> > >
> > > > What do you do if e.g. I attach to some kfunc that you don't stub o=
ut?
> > > > E.g. you may stub out bpf_sk_lookup, but I can attach something to
> > > > bpf_get_prandom_u32 called after it in the stub which is not stubbe=
d
> > > > out and stall.
> > >
> > > We have thought of 2 components to deal with unintended nesting:
> > > 1. Have a per-CPU variable to indicate a termination is in-progress.
> > >     If this is set, any new nesting won't occur.
> > > 2. Stub the entire nesting chain:
> > >     For example,
> > >     prog1
> > >          -> prog2
> > >                 -> prog3
> > >
> > >    Say prog3 is long-running and violates the runtime policy of prog2=
.
> > >    The watchdog will be triggered for prog2, in that case we walk
> > > through the stack
> > >    and stub all BPF programs leading up to prog2 (In this case prog3
> > > and prog2 will
> > >    get stubbed).
> >
> > I feel that concerns about fentry/freplace consuming too much
> > while parent prog is fast-exiting are overblown.
> > If child prog is slow it will get flagged by the watchdog sooner or lat=
er.
>
> No, there's some difference:
> It becomes more common because we're continuing to execute the suffix
> of the program in the stub.
> Compared to stopping executing and returning control immediately.
>
> > But fentry and tailcall cases are good examples that highlight
> > that fast-execute is a better path forward.
> > Manual stack unwind through bpf trampoline and tail call logic
> > is going to be quite complex, error prone, architecture specific
> > and hard to keep consistent with changes.
> > We have complicated lifetime rules for bpf trampoline.
> > See comment in bpf_tramp_image_put().
> > Doing that manually in stack unwinder is not practical.
> > iirc bpf_throw() stops at the first non-bpf_prog frame including
> > bpf trampoline.
> > But if we want to, the fast execute approach can unwind through fentry.
> > Say hw watchdog tells us that CPU is stuck in:
> > bpf_prog_A
> >    bpf_subprog_1
> >      kfunc
> >        fentry
> >           bpf_prog_B
> >
> > since every bpf prog in the system will be cloned and prepared
> > for fast execute we can replace return addresses everywhere
> > in the above and fast execute will take us all the way to kernel proper=
.
>
> The same will be true for unwinding, we can just unwind all the way to
> the top of the stack trace in case of cancellation-triggered
> unwinding.
> If trampoline calls some program, it will see it as a return from the
> called BPF program just like stubs would return.
>
> You're essentially going to replace return addresses to jump control
> to stubs, we can do that same for jumping into some unwinding code
> that can continue the process.
> Be it unwinding or stubs, once control goes back to kernel and clean
> up must continue, we will have to pass control back to code for both.
>
> Conceptually, both approaches are going to do something to clean up resou=
rces,
> that can be executing stub code or calling release handlers for
> objects on stack.

I feel you're missing my point.
For unwinding to work through bpf trampoline the unwinder needs
to execute very specific trampoline _exit_ procedure that is arch
specific and hard coded during the generation of trampoline.
That's a ton of extra complexity in unwinder.
It's not just calling destructors for objects.
Depending on trampoline and the progs in there it's one or more
__bpf_prog_exit*, percpu_ref_put(),
and extra headache due to bpf_stats_enabled_key(),
and who knows what else that I'm forgetting.

So, no, unwind-it-all is not comparable to fast-execute
in terms of complexity. bpf_throw approach is a dead end.

