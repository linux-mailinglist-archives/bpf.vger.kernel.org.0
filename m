Return-Path: <bpf+bounces-34399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA74692D4BB
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 17:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CBF1B22455
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 15:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13F6194157;
	Wed, 10 Jul 2024 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljyurjyK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C6193475;
	Wed, 10 Jul 2024 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624331; cv=none; b=lBlTJGXobaJP35NBrcAwMbKF6wxbm4TBq2/hJlNbrIaPOn1jJ/mcwqnjspzc2cFXFxDEom9vwbht55hXbARvAL7NjChK/fymVI6k9Kb1vfbHdjmBnTqjxcRU0z4rsKMsJzIfsLa81VgIBml31T1VBTBvauPztum5lmmVLfntcJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624331; c=relaxed/simple;
	bh=IRkwYGIebrL4uCE9WUVlg+KCCAuQscyRz2wbHAaJwXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LStCBvM9vD3B8CneotUEzGBnrsLeGb9ZoEYr1r8tQ2xyawgyd0Y9wq7i3O7Aat4Q1ABG1jxNTGMnzEMVwbmHwgfri7Yy1p/8Pa/tEoGZMn4SmWq7EOtw9ApLiYNKaIXq+6X+CikFMVqLdfBA8eTcaU2Hj7shvQqg9OENZXhtCgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljyurjyK; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c927152b4bso4424183a91.2;
        Wed, 10 Jul 2024 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720624329; x=1721229129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mdPAB+F0GTilFHNlRTGVUQWD6MC9KZDahVW6PLkB98=;
        b=ljyurjyKoM05qd/KwgKLs4lbBDpBPNa98RCgW0gV4SgbnqMZOJZgNZujEer+SiOEMx
         +1nBuL1BUBB458h6pt/Dd3IXklz5SKQf4zYvE4XlDhNbAwsaD/n3/m/jw87WkLvZT0He
         +7jZWBMYMEhzvA1WrmCeVclqyRdof2UIcYEDNUEopBCAsvOorsXXroPgSwVIG5pRFrBE
         2ReBel5xj2UsOYn0De4KkKvT/5nr/DvyCzchl3aZQFF8JaOxaw4qajBKcZRuO1vjnRON
         aI+h09QS5i5vrxPHH9zoOWitsACSipafevv6QXIZEVUqej9pEIrnocVqdura7Jvjit23
         oKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720624329; x=1721229129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mdPAB+F0GTilFHNlRTGVUQWD6MC9KZDahVW6PLkB98=;
        b=lkZOoZFylKO3lh0FLp34Idn75BGS3dvwS/f+ZZa0yS2/N/Cse/pKR6M28zJ/HP+2N9
         MJ+UTleJUvRORaAarheIbpRb/YUVdZTFv8hQ0fW7GVzx/K4a71ca98SEs7kLxLoR4K2x
         eBMuQF/f5QoLIJv2S1stLQGiCBtU8Wq/ZFlmaLjZPVN+Zn/SXzYivDG9TQI11DIyW+Dp
         7m7RyH6s8LVJwe/1SbZlxZJnlT+tJe4SVb/4z5r8Ltw7XuRDbNRcV5lFEI6ov2zNOy+1
         CrLhAyVWafXV+nsHsdYr/cun25gHNnoobqtFFv6D8+vnY+/2XcnNgjTPXRrM1jSpwEqw
         3j3g==
X-Forwarded-Encrypted: i=1; AJvYcCWRaUQNxFiRSRMQgs2hLbSKmApBGRGeHy57ROm7qT9Y38wTJaSvcrZF1GMuRfcw9ylh6LFBJZFwawlq95aAOIzmgLZm5x5PjGO577B0mAmzbuFHFWcyMldNru1cuZG/NsutX46jA04jQNexaWooYIhKWKnYRGLYO7Wnmb0tJVAG/QgTH7SmsBTO5e+O1w3zN707+06on6XAD+Wa/U+ehijRuDMF0hPIRA==
X-Gm-Message-State: AOJu0YwFV/enXWGSWquyv88H+vkdT1ooO7yISGGCfaRJ0Sz51MPkZ13z
	JMUqSzUd2t/Lk+Hxle3liGOcAY8paLNIiBOxX06vrJ27oPWtejwMFXmaz4vX9RAuH1UMJqisICL
	veP7Rte/f2LTW4fus3L1jS0AE0uk=
X-Google-Smtp-Source: AGHT+IEIKUVqZhStIhTidJELWOWiWfUpUOuUgGVr2vW/o8hcsf03CSaDSQyPKPZxlmCYPK2L7PU3oE2dXHWeEjxpKtE=
X-Received: by 2002:a17:90a:bd82:b0:2c4:aa78:b48b with SMTP id
 98e67ed59e1d1-2ca35d486cbmr4892000a91.38.1720624329066; Wed, 10 Jul 2024
 08:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708231127.1055083-1-andrii@kernel.org> <20240709101133.GI27299@noisy.programming.kicks-ass.net>
 <CAEf4Bza22X+vmirG=Xf4zPV0DTn9jVXi1SRTn9ff=LG=z2srNQ@mail.gmail.com> <20240710113855.GX27299@noisy.programming.kicks-ass.net>
In-Reply-To: <20240710113855.GX27299@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 08:11:57 -0700
Message-ID: <CAEf4BzZFU6CEK-=eTo_LTScYCVoBCYXeH_O_AoZd8rBYiwWzdg@mail.gmail.com>
Subject: Re: [PATCH v4] perf,x86: avoid missing caller address in stack traces
 captured in uprobe
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, x86@kernel.org, mingo@redhat.com, 
	tglx@linutronix.de, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, rihams@fb.com, linux-perf-users@vger.kernel.org, 
	rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:39=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Jul 09, 2024 at 10:50:00AM -0700, Andrii Nakryiko wrote:
> > On Tue, Jul 9, 2024 at 3:11=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Mon, Jul 08, 2024 at 04:11:27PM -0700, Andrii Nakryiko wrote:
> > > > +#ifdef CONFIG_UPROBES
> > > > +/*
> > > > + * Heuristic-based check if uprobe is installed at the function en=
try.
> > > > + *
> > > > + * Under assumption of user code being compiled with frame pointer=
s,
> > > > + * `push %rbp/%ebp` is a good indicator that we indeed are.
> > > > + *
> > > > + * Similarly, `endbr64` (assuming 64-bit mode) is also a common pa=
ttern.
> > > > + * If we get this wrong, captured stack trace might have one extra=
 bogus
> > > > + * entry, but the rest of stack trace will still be meaningful.
> > > > + */
> > > > +static bool is_uprobe_at_func_entry(struct pt_regs *regs)
> > > > +{
> > > > +     struct arch_uprobe *auprobe;
> > > > +
> > > > +     if (!current->utask)
> > > > +             return false;
> > > > +
> > > > +     auprobe =3D current->utask->auprobe;
> > > > +     if (!auprobe)
> > > > +             return false;
> > > > +
> > > > +     /* push %rbp/%ebp */
> > > > +     if (auprobe->insn[0] =3D=3D 0x55)
> > > > +             return true;
> > > > +
> > > > +     /* endbr64 (64-bit only) */
> > > > +     if (user_64bit_mode(regs) && *(u32 *)auprobe->insn =3D=3D 0xf=
a1e0ff3)
> > > > +             return true;
> > >
> > > I meant to reply to Josh suggesting this, but... how can this be? If =
you
> > > scribble the ENDBR with an INT3 things will #CP and we'll never get t=
o
> > > the #BP.
> >
> > Well, it seems like it works in practice, I just tried. Here's the
> > disassembly of the function:
> >
> > 00000000000019d0 <urandlib_api_v1>:
> >     19d0: f3 0f 1e fa                   endbr64
> >     19d4: 55                            pushq   %rbp
> >     19d5: 48 89 e5                      movq    %rsp, %rbp
> >     19d8: 48 83 ec 10                   subq    $0x10, %rsp
> >     19dc: 48 8d 3d fe ed ff ff          leaq    -0x1202(%rip), %rdi
> >  # 0x7e1 <__isoc99_scanf+0x7e1>
> >     19e3: 48 8d 75 fc                   leaq    -0x4(%rbp), %rsi
> >     19e7: b0 00                         movb    $0x0, %al
> >     19e9: e8 f2 00 00 00                callq   0x1ae0 <__isoc99_scanf+=
0x1ae0>
> >     19ee: b8 01 00 00 00                movl    $0x1, %eax
> >     19f3: 48 83 c4 10                   addq    $0x10, %rsp
> >     19f7: 5d                            popq    %rbp
> >     19f8: c3                            retq
> >     19f9: 0f 1f 80 00 00 00 00          nopl    (%rax)
> >
> > And here's the state when uprobe is attached:
> >
> > (gdb) disass/r urandlib_api_v1
> > Dump of assembler code for function urandlib_api_v1:
> >    0x00007ffb734e39d0 <+0>:     cc                      int3
> >    0x00007ffb734e39d1 <+1>:     0f 1e fa                nop    %edx
> >    0x00007ffb734e39d4 <+4>:     55                      push   %rbp
> >    0x00007ffb734e39d5 <+5>:     48 89 e5                mov    %rsp,%rb=
p
> >    0x00007ffb734e39d8 <+8>:     48 83 ec 10             sub    $0x10,%r=
sp
> >    0x00007ffb734e39dc <+12>:    48 8d 3d fe ed ff ff    lea
> > -0x1202(%rip),%rdi        # 0x7ffb734e27e1
> >    0x00007ffb734e39e3 <+19>:    48 8d 75 fc             lea    -0x4(%rb=
p),%rsi
> > =3D> 0x00007ffb734e39e7 <+23>:    b0 00                   mov    $0x0,%=
al
> >    0x00007ffb734e39e9 <+25>:    e8 f2 00 00 00          call
> > 0x7ffb734e3ae0 <__isoc99_scanf@plt>
> >    0x00007ffb734e39ee <+30>:    b8 01 00 00 00          mov    $0x1,%ea=
x
> >    0x00007ffb734e39f3 <+35>:    48 83 c4 10             add    $0x10,%r=
sp
> >    0x00007ffb734e39f7 <+39>:    5d                      pop    %rbp
> >    0x00007ffb734e39f8 <+40>:    c3                      ret
> >
> >
> > You can see it replaced the first byte, the following 3 bytes are
> > remnants of endb64 (gdb says it's a nop? :)), and then we proceeded,
> > you can see I stepped through a few more instructions.
> >
> > Works by accident?
>
> Yeah, we don't actually have Userspace IBT enabled yet, even on hardware
> that supports it.

OK, I don't know what the implications are, but it's a good accident :)

Anyways, what should I do for v4? Drop is_endbr6() check or keep it?

