Return-Path: <bpf+bounces-58030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13547AB3DDA
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 18:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A361884E71
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 16:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F60251782;
	Mon, 12 May 2025 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEliYjjv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D3246781
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068106; cv=none; b=eRV2JCPrezp5NX6yNRmnrxeclxt8O2gFsPBs50B/uc3EuLschQSwhMdFa2KBgg9GqV5X0EbqFPbPZg5Vmih0qoAcgjamTqdGWeQCZ1Imw4+/UYGNjTZOHt8UUs7PCWrtvKbR49gcbRysCEJ1xm9Xn6WB5VB28LS5sh9y1/UbbZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068106; c=relaxed/simple;
	bh=Ke9svJo1JUwx35PjMFO/vPgWlyBavkCjwqNpJwF3TMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROszHSdtwNrWSldNwh37ChNoN7t/MU1b8nCGJr8qORmTlwWmjkvlAB3FKW3kkw9xCXeEnlurTRwssXUmthGTRGHO7yurW2RlgTgNnaILWxmf9UepC+ka01SHrMqtmigGe71PpQdtsvu/pjIKGQlR+9AlXWcQBLA6XOY+tmJZE/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEliYjjv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a0b291093fso3592620f8f.0
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747068103; x=1747672903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSoEmYmQVVzxDszqZ2dPYweDQszXJMx/oUy6UD19jw0=;
        b=BEliYjjvXbxqflNDSSurjQ1cC6u65ZzBzbY5IO2T4BhBkT6zsw7zWte4jltC/zkV2F
         1nXzdpPREr+/NtzO6rHvacxEabIch2Qr84OnqxB1YALe5ZrIrC+GtSUfyNPzJ1OheZIJ
         UgqNJ2c73i3g7lzzABw57QdejAcgur6TwGdPVea+SC0kK93TX+MP41e3uRlmkmHV8CJi
         WT8DkKUcIp/Embc1pdKYfWm/uhdcY016Q2m0ZvLSlFgTLj52riSejmMiI6M1OmuMCKy9
         yn8qZCP55Iv994ahCWjnWXfSbtCqVjWjmcRad34A4ou2CROX/7kANQpCzzXMJBwYElJ0
         6u/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747068103; x=1747672903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSoEmYmQVVzxDszqZ2dPYweDQszXJMx/oUy6UD19jw0=;
        b=FmZK2LeQMkv4UTQGn+HZP3G+rVCAsNidAAxUG0Ae1MsomBwMS0qEZVpJsNwSJavDMf
         85CbUjFetVpn6sSUR7rPVwgfJOFnmsjrSrUNGE+Ppz8mqdoVNDigiVVlXFcl8NKiMp2e
         tOwCKWv0BlfJauwXq4QX752IVLhabmDKzCtSJtMTzOEVkOrE13w5eubgZ3L77JfnmFrR
         SN3KcSvZ1+Nw72D/K9T/ZWmoxg6MgnIx/0UOSD+8ykrlb7gYBQwpoWsa7EDMjs717Q8x
         hjcSQCLMsmGTZlWCjFoAcSfZdYU7Ij2UqnS7nWzfYKTu/JQZb1a7qZY79i3vNPyOryFd
         q6kw==
X-Forwarded-Encrypted: i=1; AJvYcCXC9LMx7N5Gx3h/unbrxWYWE8ubqUferm7MFI6HgKPiCuj8yo/GMsP5ILxJ2p78iES7iMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfxzmEvzN6jmROEu/DS9xcKRXJ4rNboF/A7AiYdU9Xsx11yq/a
	4S6Ojcz+D7XjzcZFL1rzX2gAgT7zo2q32kp+WuouRvmJEyN+xPf4760QFAkR7hOyb4DiCP7vv8U
	8dJuKPeBUQ+QdXUhgee2iTjQbWgg=
X-Gm-Gg: ASbGncumDqQcEJHjl9Q9euV3RUhglI4OY2nHsRGlXo3a3OSelCYNS44UDQ02s8Pu+mM
	fY1+cY9JOH55EH9nA30anuyr1iIR65MvJ5BP/Zeozul7cyhvWZbOEt14m/z/scPuqfgTNtLGdeM
	eVewaEk63iAYQNaaqQsWHHDCsc0piQhWPlQShVVe6Sor1Q8GtG
X-Google-Smtp-Source: AGHT+IG/oY4t6Jl01VR1F+w8qoFJ/DhIlM+SvhAEFS/jBMkGEu75zxf8Kdgtgn4jEN3IiysTnVkVceenSuMxwpA95gU=
X-Received: by 2002:a5d:47a7:0:b0:3a0:b1f7:c1e9 with SMTP id
 ffacd0b85a97d-3a340d15397mr192241f8f.1.1747068102794; Mon, 12 May 2025
 09:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508113804.304665-1-iii@linux.ibm.com> <CAADnVQ+kGcRrLOaA5ic6cYG+1vHJm0bBD1GRfUaYpaOGa3Vx0g@mail.gmail.com>
 <15bf9a71b8185006c8d19a3aefb331a2765629c5.camel@linux.ibm.com>
 <CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=BjBJWLAtpgOP9CKRw@mail.gmail.com> <7a242102eecdd17b4d35c1e4f7d01ea15cb8066a.camel@linux.ibm.com>
In-Reply-To: <7a242102eecdd17b4d35c1e4f7d01ea15cb8066a.camel@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 May 2025 09:41:31 -0700
X-Gm-Features: AX0GCFv4G5SD_qBzBHioShso1cZ9DanUsOuyzK37gTW-YpuF9z-YxRJB26ryboQ
Message-ID: <CAADnVQ+5h9UESAgNA58HEQ-0zwxn=c0+ibH++NF9farR5-JB8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix "expression result unused" warnings
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 5:22=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On Fri, 2025-05-09 at 09:51 -0700, Alexei Starovoitov wrote:
> > On Thu, May 8, 2025 at 12:21=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm=
.com>
> > wrote:
> > >
> > > On Thu, 2025-05-08 at 11:38 -0700, Alexei Starovoitov wrote:
> > > > On Thu, May 8, 2025 at 4:38=E2=80=AFAM Ilya Leoshkevich
> > > > <iii@linux.ibm.com>
> > > > wrote:
> > > > >
> > > > > clang-21 complains about unused expressions in a few progs.
> > > > > Fix by explicitly casting the respective expressions to void.
> > > >
> > > > ...
> > > > >         if (val & _Q_LOCKED_MASK)
> > > > > -               smp_cond_load_acquire_label(&lock->locked,
> > > > > !VAL,
> > > > > release_err);
> > > > > +               (void)smp_cond_load_acquire_label(&lock-
> > > > > >locked,
> > > > > !VAL, release_err);
> > > >
> > > > Hmm. I'm on clang-21 too and I don't see them.
> > > > What warnings do you see ?
> > >
> > > In file included from progs/arena_spin_lock.c:7:
> > > progs/bpf_arena_spin_lock.h:305:1756: error: expression result
> > > unused
> > > [-Werror,-Wunused-value]
> > >   305 |   ({ typeof(_Generic((*&lock->locked), char: (char)0,
> > > unsigned
> > > char : (unsigned char)0, signed char : (signed char)0, unsigned
> > > short :
> > > (unsigned short)0, signed short : (signed short)0, unsigned int :
> > > (unsigned int)0, signed int : (signed int)0, unsigned long :
> > > (unsigned
> > > long)0, signed long : (signed long)0, unsigned long long :
> > > (unsigned
> > > long long)0, signed long long : (signed long long)0, default:
> > > (typeof(*&lock->locked))0)) __val =3D ({ typeof(&lock->locked) __ptr
> > > =3D
> > > (&lock->locked); typeof(_Generic((*(&lock->locked)), char: (char)0,
> > > unsigned char : (unsigned char)0, signed char : (signed char)0,
> > > unsigned short : (unsigned short)0, signed short : (signed short)0,
> > > unsigned int : (unsigned int)0, signed int : (signed int)0,
> > > unsigned
> > > long : (unsigned long)0, signed long : (signed long)0, unsigned
> > > long
> > > long : (unsigned long long)0, signed long long : (signed long
> > > long)0,
> > > default: (typeof(*(&lock->locked)))0)) VAL; for (;;) { VAL =3D
> > > (typeof(_Generic((*(&lock->locked)), char: (char)0, unsigned char :
> > > (unsigned char)0, signed char : (signed char)0, unsigned short :
> > > (unsigned short)0, signed short : (signed short)0, unsigned int :
> > > (unsigned int)0, signed int : (signed int)0, unsigned long :
> > > (unsigned
> > > long)0, signed long : (signed long)0, unsigned long long :
> > > (unsigned
> > > long long)0, signed long long : (signed long long)0, default:
> > > (typeof(*(&lock->locked)))0)))(*(volatile typeof(*__ptr)
> > > *)&(*__ptr));
> > > if (!VAL) break; ({ __label__ l_break, l_continue; asm volatile
> > > goto("may_goto %l[l_break]" :::: l_break); goto l_continue;
> > > l_break:
> > > goto release_err; l_continue:; }); ({}); } (typeof(*(&lock-
> > > > locked)))VAL; }); ({ ({ if (!CONFIG_X86_64) ({ unsigned long
> > > > __val;
> > > __sync_fetch_and_add(&__val, 0); }); else asm volatile("" :::
> > > "memory"); }); }); (typeof(*(&lock->locked)))__val; });
> > >       |
> > > ^                         ~~~~~
> > > 1 error generated.
> >
> > hmm. The error is impossible to read.
> >
> > Kumar,
> >
> > Do you see a way to silence it differently ?
> >
> > Without adding (void)...
> >
> > Things like:
> > -       bpf_obj_new(..
> > +       (void)bpf_obj_new(..
> >
> > are good to fix, and if we could annotate
> > bpf_obj_new_impl kfunc with __must_check we would have done it,
> >
> > but
> > -               arch_mcs_spin_lock...
> > +               (void)arch_mcs_spin_lock...
> >
> > is odd.
>
> What do you think about moving (void) to the definition of
> arch_mcs_spin_lock_contended_label()? I can send a v2 if this is
> better.

Kumar,

thoughts?

