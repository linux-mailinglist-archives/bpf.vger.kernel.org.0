Return-Path: <bpf+bounces-57598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1566FAAD25C
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 02:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D078F981E36
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 00:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22562AE84;
	Wed,  7 May 2025 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUExVpFj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38E156CA
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746578374; cv=none; b=m13YU5eYzOI2nspkUdjjGHh/mWHM3q6JDCDyG2y6WP14SyUoYggd+O4tjBnozcrTD3aQjmZtSha13ku91Z+/fCEHsdc49mYtiXp9nYtUymgMo4npTkwUKnralpRLg6QY+C82GAtsVzoUS6stVek03DjhIIVz24I41N8jN7yJoxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746578374; c=relaxed/simple;
	bh=xMA4MXJ0BHqwEkRPce+VMwnkq+CM97ZEBRPNeAUfJks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNnApgr29a8z2qXicFCdyTnl85/jDSuLcMyyUnDO1MeTpgPTWBvlFO14eH5y6sFPf21T8SfmcN5nCqvJ1IxVgqSvFJOWKXZW+SJvhSWVIfBQ7sonGQNyks+gUO1qi4RkIrgOKQmEFQ9aYZaQIvhLENVBO4MUP4Q7l9X3iT1SoW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUExVpFj; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso333275466b.0
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 17:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746578371; x=1747183171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrN8bOehGApITtpB5dTipy7j/7ERYUTK1JMMx+NXLC8=;
        b=GUExVpFjy+I40x9/qA8UQbYncHfkJeiaRlT7kWL2AZ03118QNh3pfuWa+HASiSQ0pP
         bhFKxDmqaXSxtBzMChqwi00/nNU6cARj99oIteQ2H8XSMqjK0ZmMcpYaDxN54pCwfWxF
         xSJiZW3TGaCuYnI1dXlvKUiaCEUIP4a98Fju5A8o0qIxjp4O3JWoW8yziqAYndsSy1xw
         wRRJ6wY5NJz2aKEc+r7x6jZwUy5+D72HKRa1xOxXitVvQNR9MXUaLd8otPyCqyNMa0qq
         0WnIOomSMj34N/csaFJtMCqUn2KErmb8Tvwh4GSDqsCDOn7uGpOwwBvHHaPSuPmQbH02
         aWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746578371; x=1747183171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrN8bOehGApITtpB5dTipy7j/7ERYUTK1JMMx+NXLC8=;
        b=cdmFZjX84QbDM28034khPrhn9UP4npcDRjn3G3W3KNkkUY+Ns0jBeXHF9k3rYhOxeP
         xK+mVd0ATu5WA4ND1XM/kaMuhASWbEalyGxkgS69aTw/o1R50NvNnSHJyiTR2j/r8VW8
         /xk6vB9Fbr+43TElBij9JjfUAfuOCFK9G+1lGyCLiaInpnPlLJsn8eJV0dgG81b3Z0mo
         hI9zZPiINs2wxl7AEo4FSveioQ9Z7QAW8SqzWyiWtpUWZzhTOF82xVzfkWBXYp5UH+du
         A/l4hlrv4LPqNUZcQuY29UPlTuw7aJjY67uODhMF9xJD+/dQdfipX81HG3C0tgWmlfEE
         dT6w==
X-Forwarded-Encrypted: i=1; AJvYcCWqS/C2m32sjaak+XleVCW/oSJurqWrUZTPoqVg8xooELRqG/MaKGZL57iiGY2YRTtOhe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIarzPapcOXJwrqokc7F/IdQ5wwbIHqe+j38gnNVsGm2sXGUBk
	HXcoXcbRWgffa0U41c0tkql/O9I5QhTbtDGZ6SkO8GbS5L4gtiw8yAO2BlhJnc3+EGVqqqRpXzB
	S38FhWAt0evWfKWt7WJ2ALpYyh88=
X-Gm-Gg: ASbGncsMBHWl1HTylDSYzmkmDM0I/HQacZtyKr8BcWmcpFCRgxU9X4orRQshwtYkEIM
	h/aoOHvDdASt6g5Nx214HTLyfM8hjYweH5sT9D7jUaRGGXbxD7I3p3xfgf41wbVvfKeIBcvZS75
	AfYdP+iw4hnLNmT19rPito0k9IETGhUuyyxK7qz18in5HIS+W0R8AP4+xh
X-Google-Smtp-Source: AGHT+IFn7EqzHqYiE4qdQ7caHqBy7W2nzapZJ9vs/TkMdF0F4tYVEIpEpgRW3InaxeqQEe/MtvnOO8zUUZOuXASesUU=
X-Received: by 2002:a17:907:970b:b0:aca:e2c0:ec3c with SMTP id
 a640c23a62f3a-ad1e8cd703cmr114131866b.45.1746578370434; Tue, 06 May 2025
 17:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <CAP01T75B87Vnq-kdq6gaNXj5xeOOiah-onm4weEZA=jm8W8JVQ@mail.gmail.com>
 <CAM6KYsuk060Fv43Djp4q57AwBcmmkHBitGgfSsCJZwbGqRmQEA@mail.gmail.com>
 <CAADnVQL_+5FiOwNEnaYZ-i52r4jDiStboWxA9VycARFboOjx6Q@mail.gmail.com>
 <CAP01T757KLkBx3FMAK8-7vYTO0v=RtWvkQpztS1Zugd8tHSnHA@mail.gmail.com> <CAADnVQKzgELtqZ_4pce7sOegE1i3azcija0w6Bn5OWH0LgpbQg@mail.gmail.com>
In-Reply-To: <CAADnVQKzgELtqZ_4pce7sOegE1i3azcija0w6Bn5OWH0LgpbQg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 7 May 2025 02:38:54 +0200
X-Gm-Features: ATxdqUHlT95G5cowyRqzxVkcm8XDFrN8Dh0Kk1WNhC7YZrZ6pjkzdJxq4Rpw_Uo
Message-ID: <CAP01T75O90bgYeb1q1ot+=D9MxN3UXyji5T6mA+UsnPwQUF52g@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/4] bpf: Fast-Path approach for BPF program Termination
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Wed, 7 May 2025 at 02:33, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 6, 2025 at 4:00=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > On Wed, 7 May 2025 at 00:45, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, May 5, 2025 at 10:55=E2=80=AFPM Raj Sahu <rjsu26@gmail.com> w=
rote:
> > > >
> > > >       2. A BPF prog is attached to a function called by another BPF=
 program.
> > > >              - This is the interesting case.
> > > >
> > > > > What do you do if e.g. I attach to some kfunc that you don't stub=
 out?
> > > > > E.g. you may stub out bpf_sk_lookup, but I can attach something t=
o
> > > > > bpf_get_prandom_u32 called after it in the stub which is not stub=
bed
> > > > > out and stall.
> > > >
> > > > We have thought of 2 components to deal with unintended nesting:
> > > > 1. Have a per-CPU variable to indicate a termination is in-progress=
.
> > > >     If this is set, any new nesting won't occur.
> > > > 2. Stub the entire nesting chain:
> > > >     For example,
> > > >     prog1
> > > >          -> prog2
> > > >                 -> prog3
> > > >
> > > >    Say prog3 is long-running and violates the runtime policy of pro=
g2.
> > > >    The watchdog will be triggered for prog2, in that case we walk
> > > > through the stack
> > > >    and stub all BPF programs leading up to prog2 (In this case prog=
3
> > > > and prog2 will
> > > >    get stubbed).
> > >
> > > I feel that concerns about fentry/freplace consuming too much
> > > while parent prog is fast-exiting are overblown.
> > > If child prog is slow it will get flagged by the watchdog sooner or l=
ater.
> >
> > No, there's some difference:
> > It becomes more common because we're continuing to execute the suffix
> > of the program in the stub.
> > Compared to stopping executing and returning control immediately.
> >
> > > But fentry and tailcall cases are good examples that highlight
> > > that fast-execute is a better path forward.
> > > Manual stack unwind through bpf trampoline and tail call logic
> > > is going to be quite complex, error prone, architecture specific
> > > and hard to keep consistent with changes.
> > > We have complicated lifetime rules for bpf trampoline.
> > > See comment in bpf_tramp_image_put().
> > > Doing that manually in stack unwinder is not practical.
> > > iirc bpf_throw() stops at the first non-bpf_prog frame including
> > > bpf trampoline.
> > > But if we want to, the fast execute approach can unwind through fentr=
y.
> > > Say hw watchdog tells us that CPU is stuck in:
> > > bpf_prog_A
> > >    bpf_subprog_1
> > >      kfunc
> > >        fentry
> > >           bpf_prog_B
> > >
> > > since every bpf prog in the system will be cloned and prepared
> > > for fast execute we can replace return addresses everywhere
> > > in the above and fast execute will take us all the way to kernel prop=
er.
> >
> > The same will be true for unwinding, we can just unwind all the way to
> > the top of the stack trace in case of cancellation-triggered
> > unwinding.
> > If trampoline calls some program, it will see it as a return from the
> > called BPF program just like stubs would return.
> >
> > You're essentially going to replace return addresses to jump control
> > to stubs, we can do that same for jumping into some unwinding code
> > that can continue the process.
> > Be it unwinding or stubs, once control goes back to kernel and clean
> > up must continue, we will have to pass control back to code for both.
> >
> > Conceptually, both approaches are going to do something to clean up res=
ources,
> > that can be executing stub code or calling release handlers for
> > objects on stack.
>
> I feel you're missing my point.
> For unwinding to work through bpf trampoline the unwinder needs
> to execute very specific trampoline _exit_ procedure that is arch
> specific and hard coded during the generation of trampoline.
> That's a ton of extra complexity in unwinder.
> It's not just calling destructors for objects.
> Depending on trampoline and the progs in there it's one or more
> __bpf_prog_exit*, percpu_ref_put(),
> and extra headache due to bpf_stats_enabled_key(),
> and who knows what else that I'm forgetting.

What I'm saying is that we don't have to do all that.
It's just overcomplication for the sake of it.

The trampoline works by invoking a BPF program.
From it's perspective, it will just get back a return from the call
and continue doing its stuff.
The unwinding happens on BPF frames and then returns control to the trampol=
ine.
No unwinding needs to happen on it.
It will be no different from setting return address to stub and
letting the program execute rest of the logic.

trampoline -> call bpf_prog -> hit cancellation -> (either unwind all
BPF frames, or execute stub program that does the same by following
execution) -> return to trampoline.

If we want to continue it for programs calling into trampoline, we'll
do something similar for both cases, modify return addresses that
either continue executing stub or unwinding BPF frames, then return to
the kernel context calling them.

Hence failing to see what is difference.
Only difference to me is executing BPF code cloned from the program vs
some kernel function that walks the program stack and calls kfuncs.

>
> [...]

