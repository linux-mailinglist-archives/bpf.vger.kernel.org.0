Return-Path: <bpf+bounces-57582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2812FAAD14E
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 01:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9C2521A68
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 23:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2A621D00D;
	Tue,  6 May 2025 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLxeHdvb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F16221C9E9
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746572408; cv=none; b=Rdwlf3n/a2qjXZErSHEKvMGmfiFNMC4HszOJ11UsWOtvX20la5qf/COKR4ilsGD7/Lhj1ACQU3dCBeQ6Ktn7xguWnSObEbp3dQJPQeV/DK568TpPrLD9L9tYnpjHmsCirINMsW1dBC3/CMkVdhelRm9Jra8Hc5Ef5e4UT12/e9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746572408; c=relaxed/simple;
	bh=ZUwhmbJ6phG+ANT85vyKTTCPqiSVyxHSHM3DOnRggmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXQ0owJA+Ka2mnbBUwZU29j020s1XPUB9/Vzntqlko/MMgeBPKXMHgHE5zDcIs/iMaGaMPe16DIdfcJp1t9fLNNEPiP9yPK8g4l5xEYAJYPXqO9TD9PdDwCbujQjBqApzFrl9N7L2Oku601Li8rrDkYfXKSp2nXYNcuk3b7zx1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLxeHdvb; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ac345bd8e13so1028835566b.0
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 16:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746572404; x=1747177204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtfXuOinI4GK9JxeoxVXPl9qR60uOTbGzJth6TUFQZ4=;
        b=KLxeHdvbPIe7LgXgmaWvvqXITBalurnhQwSj9aqsNbmuJVffUnYsdX84DNZconFxnL
         BJ4xxKvAiT3snb/xhoqRGkQkC9AJVbKni27876I2gYgmMlDreUVUyR7kmzS/goamqG8Q
         b1L7fgSCPkSAo9EAOTi7NwuqC3U3wM6D7amhl8JI/sagfOBdrKyS8/CZ4aHAwMXrsIkQ
         sR6PzsZRinUhLJMJthmoTbz4u/xic4+omSWYzWS1nftRwBh7Z0Vidqpff7psI38YjXz+
         Ub2ePOJAMit9kYbxb8TWJxelEDfwrx+blFPoNz+Cy3xNQ9jO8x+4epMJq5i19qogwwiM
         o6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746572404; x=1747177204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtfXuOinI4GK9JxeoxVXPl9qR60uOTbGzJth6TUFQZ4=;
        b=TrPZalTFn/sshqI6eTAnApWsZTsfBXJQ5/3I9PnR+KTjAnCHW08rmK0eaeGZVerJ+M
         71TgFJW8MnZoSZxCcTDRnKRrD6jc6jcs3sL6ErkxWlJErnhBJGyZ6/FppC3FMlc5+G0n
         x8uyTrC08i2KiGkmFSgrAvkMyMHX1BV6IxhwDjIxCFs433TdXby8WKFMqYsa1qTlrq9S
         gZWpnKQX95sm3zLRHHDYOMSqX7ZQQjyjLf/wtgcVE6qg75Gw6TcGmAqWiDBsxxMifFmU
         sQ0AN1W2VxDzGOTrcVdbV1PgW0BgB+3gpldDKo8nmxq/2SRYpsC9wr6nravd0vUPoA3W
         cprA==
X-Forwarded-Encrypted: i=1; AJvYcCWWcvLib2mRxxYBOQQR/xWhUrogwRSKWoG8MMTtNSEFFCzu/wvzlN4pQSfFM984lL33wu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY69RTSaotS7wgzY6ngxEPSx/iXftXGG9Mi/uD05h1cObbyLp/
	tDzqpeEr50MhzotjYgfB8gbqx6h3Un4aa/xd11Udiye3v0N3tVMDwIrjPmhyiZx1ibmaXLMoWAd
	TUKG+vSgQhNe2r9P0ouUngEDmO8tsq9pz
X-Gm-Gg: ASbGncv7ZHeuRuHSQhwuCKpf5NMljr/n0i7PsBRtx/0yQXrURxOtymJtZEMr06Bj/ga
	NEGePPCxHy5i37ZYDAN1+MNH3pm6hJvSSlFS7zWDBiz9tEPUmWub3ilDl9H0qfnr1fKyVB+6Nlz
	L6B+OVahWt/AchPnYp8NhsFyJ2Linwqe6XXDXWhXIMDxr379Ezx+15hr7L
X-Google-Smtp-Source: AGHT+IFDgmKo60MfcipYbH0et449RQ7hw1Fdt/zI3NZ+QC5h4xZNXQMWy8VtLod8oLg8dbr8qHUlhgMDo+S4WPYAvn8=
X-Received: by 2002:a17:907:c28e:b0:acb:5f17:624d with SMTP id
 a640c23a62f3a-ad1e8d2ce68mr110137366b.57.1746572404275; Tue, 06 May 2025
 16:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <CAP01T75B87Vnq-kdq6gaNXj5xeOOiah-onm4weEZA=jm8W8JVQ@mail.gmail.com>
 <CAM6KYsuk060Fv43Djp4q57AwBcmmkHBitGgfSsCJZwbGqRmQEA@mail.gmail.com> <CAADnVQL_+5FiOwNEnaYZ-i52r4jDiStboWxA9VycARFboOjx6Q@mail.gmail.com>
In-Reply-To: <CAADnVQL_+5FiOwNEnaYZ-i52r4jDiStboWxA9VycARFboOjx6Q@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 7 May 2025 00:59:27 +0200
X-Gm-Features: ATxdqUFTy_ygQmwq2s7mP0BIswF6khvvf9kf5X-XZuvS7kApLYRxfs3RUaDxTaM
Message-ID: <CAP01T757KLkBx3FMAK8-7vYTO0v=RtWvkQpztS1Zugd8tHSnHA@mail.gmail.com>
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

On Wed, 7 May 2025 at 00:45, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 5, 2025 at 10:55=E2=80=AFPM Raj Sahu <rjsu26@gmail.com> wrote=
:
> >
> >       2. A BPF prog is attached to a function called by another BPF pro=
gram.
> >              - This is the interesting case.
> >
> > > What do you do if e.g. I attach to some kfunc that you don't stub out=
?
> > > E.g. you may stub out bpf_sk_lookup, but I can attach something to
> > > bpf_get_prandom_u32 called after it in the stub which is not stubbed
> > > out and stall.
> >
> > We have thought of 2 components to deal with unintended nesting:
> > 1. Have a per-CPU variable to indicate a termination is in-progress.
> >     If this is set, any new nesting won't occur.
> > 2. Stub the entire nesting chain:
> >     For example,
> >     prog1
> >          -> prog2
> >                 -> prog3
> >
> >    Say prog3 is long-running and violates the runtime policy of prog2.
> >    The watchdog will be triggered for prog2, in that case we walk
> > through the stack
> >    and stub all BPF programs leading up to prog2 (In this case prog3
> > and prog2 will
> >    get stubbed).
>
> I feel that concerns about fentry/freplace consuming too much
> while parent prog is fast-exiting are overblown.
> If child prog is slow it will get flagged by the watchdog sooner or later=
.

No, there's some difference:
It becomes more common because we're continuing to execute the suffix
of the program in the stub.
Compared to stopping executing and returning control immediately.

> But fentry and tailcall cases are good examples that highlight
> that fast-execute is a better path forward.
> Manual stack unwind through bpf trampoline and tail call logic
> is going to be quite complex, error prone, architecture specific
> and hard to keep consistent with changes.
> We have complicated lifetime rules for bpf trampoline.
> See comment in bpf_tramp_image_put().
> Doing that manually in stack unwinder is not practical.
> iirc bpf_throw() stops at the first non-bpf_prog frame including
> bpf trampoline.
> But if we want to, the fast execute approach can unwind through fentry.
> Say hw watchdog tells us that CPU is stuck in:
> bpf_prog_A
>    bpf_subprog_1
>      kfunc
>        fentry
>           bpf_prog_B
>
> since every bpf prog in the system will be cloned and prepared
> for fast execute we can replace return addresses everywhere
> in the above and fast execute will take us all the way to kernel proper.

The same will be true for unwinding, we can just unwind all the way to
the top of the stack trace in case of cancellation-triggered
unwinding.
If trampoline calls some program, it will see it as a return from the
called BPF program just like stubs would return.

You're essentially going to replace return addresses to jump control
to stubs, we can do that same for jumping into some unwinding code
that can continue the process.
Be it unwinding or stubs, once control goes back to kernel and clean
up must continue, we will have to pass control back to code for both.

Conceptually, both approaches are going to do something to clean up resourc=
es,
that can be executing stub code or calling release handlers for
objects on stack.

In the end, it's invoking some kernel code which will act upon the
program stack, then return control back to the kernel.
All lifetime related concerns for objects on stack and trampolines
will be the same for both approaches.

The stub lifetime will be the same as whatever table is built for
releasing resources.

The boundary is checked for bpf_throw(), ofcourse, because there, the
program is asserting some condition and requesting to be cleaned up.
There, we really shouldn't keep unwinding across program boundaries.

There is nothing architecture specific about the rest, it is an if
(cond) check in the arch_bpf_stack_walk callback.

>
> [...]

