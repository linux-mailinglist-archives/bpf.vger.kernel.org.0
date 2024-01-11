Return-Path: <bpf+bounces-19356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FF482A625
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 03:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78A31F239F5
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 02:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F98EA3;
	Thu, 11 Jan 2024 02:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARFIKYHi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C0A3C
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 02:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3376ead25e1so3176273f8f.3
        for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 18:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704941200; x=1705546000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hV4JJ0s1Z1D0ty0PXPzEDItIhdbKBZjWyN2KlLOpdTw=;
        b=ARFIKYHiG4r9hzkZQNIiGXBrsyM6+cAQfAHXrE26HN4mJgxmOh9voBn3gdBOmuvDww
         d2YmJUDVq7M+1CbMeIXrFOqqxwycsW/48PWwbiXHYrV+l5LaC69Za2n11HOucSkxsU5M
         4i24mHgGGGf69k0AFjx9umvnZhFbTOGExaJXECZgROMo916sMgLQPRiy2fdnYCvNuOAm
         U6man1y3Bm3cvD9iZRro0MmEaNNBBZLELdLbFw3Fdl1UTPk0DwU6cYq/LupKr2Igd8Bv
         2rCAgM/dtBB5yY8Nkf/QFVEw8+zGZbRWwDEx6zuyC21cZetz33Dz80HutnpLONhfITSn
         +MSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704941200; x=1705546000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hV4JJ0s1Z1D0ty0PXPzEDItIhdbKBZjWyN2KlLOpdTw=;
        b=hfFrmQMs4yxELOmXOZj/urAZlW1IUFrFiGTrmaKT1j0QVnmZYxdY3LE1tILE3DhF/D
         T1AHFMJqmNzblzZofb14TqDbYIDPMXf1NY+s7CgJdyzHlr3OyRc6oYZRsrG2Wl9dmAnu
         aDn4Z0K0NkZF7iyGtGrSGDv1ZjILzpJICrDqL6mru8yE1YZYXWJLROQUs+cfI5+oosEJ
         YqpLP+pjkXkAQaFswT+xi56zDuQbsHsJ0t9BqldD4MCg2/VtB80ynztcEtRBGhZnc9V5
         Ip6LfkSFt0ueKmjPIGBGKru8ofMwJnt6lq17qaIXmyJJ4bjQFKa+Wj/RC0Zy6m5+ULup
         pfBg==
X-Gm-Message-State: AOJu0YwvK//iFpRsdN+Pofcg/iiYJ1gN8h21nxz5MkTWJdCcxsxxy1E/
	zrMLYM05Cg5obEhcee/J3hk3mtjaXIaRBPZA6IBWrNhqpmc=
X-Google-Smtp-Source: AGHT+IH2kVUuB3jEtObjCIV67b83a2mdWp3hvFF/mAtTfhm6eX41+59r5j7mSkEuf/2if28DmskmSXfVnCSAyCtIZPo=
X-Received: by 2002:a5d:66cb:0:b0:336:783f:ca2e with SMTP id
 k11-20020a5d66cb000000b00336783fca2emr248986wrw.18.1704941200145; Wed, 10 Jan
 2024 18:46:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
 <20231221033854.38397-3-alexei.starovoitov@gmail.com> <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
 <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
 <44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
 <CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com> <87h6jm6atm.fsf@oracle.com>
In-Reply-To: <87h6jm6atm.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jan 2024 18:46:29 -0800
Message-ID: <CAADnVQK54oAjfKtciJ5Z4fwChUDUC_1HYkodzwDzJR42GSun1w@mail.gmail.com>
Subject: Re: asm register constraint. Was: [PATCH v2 bpf-next 2/5] bpf:
 Introduce "volatile compare" macro
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 3:00=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
> >
> > Also need to align with GCC. (Jose cc-ed)
>
> GCC doesn't have an integrated assembler, so using -masm=3Dpseudoc it jus=
t
> compiles the program above to:
>
>   foo:
>         call bar
>         r0 +=3D 1
>         exit
>
> Also, at the moment we don't support a "w" constraint, because the
> assembly-like assembly syntax we started with implies different
> instructions that interpret the values stored in the BPF 64-bit
> registers as 32-bit or 64-bit values, i.e.
>
>   mov %r1, 1
>   mov32 %r1, 1

Heh. gcc tried to invent a traditional looking asm for bpf and instead
invented the above :)
x86 and arm64 use single 'mov' and encode sub-registers as rax/eax or x0/w0=
.

imo support of gcc-only asm style is an obstacle in gcc-bpf adoption.
It's not too far to reconsider supporting this. You can easily
remove the support and it will reduce your maintenance/support work.
It's a bit of a distraction in this thread too.

> But then the pseudo-c assembly syntax (that we also support) translates
> some of the semantics of the instructions to the register names,
> creating the notion that BPF actually has both 32-bit registers and
> 64-bit registers, i.e.
>
>   r1 +=3D 1
>   w1 +=3D 1
>
> In GCC we support both assembly syntaxes and currently we lack the
> ability to emit 32-bit variants in templates like "%[reg] +=3D 1", so I
> suppose we can introduce a "w" constraint to:
>
> 2. When pseudo-c assembly syntax is used, expect a 32-bit mode to match
>    the operand and warn about operand size overflow whenever necessary,
>    and then emit "w" instead of "r" as the register name.

clang supports "w" constraint with -mcpu=3Dv3,v4 and emits 'w'
as register name.

> > And, the most importantly, we need a way to go back to old behavior,
> > since u32 var; asm("...":: "r"(var)); will now
> > allocate "w" register or warn.
>
> Is it really necessary to change the meaning of "r"?  You can write
> templates like the one triggering this problem like:
>
>   asm volatile ("%[reg] +=3D 1"::[reg]"w"((unsigned)bar()));
>
> Then the checks above will be performed, driven by the particular
> constraint explicitly specified by the user, not driven by the type of
> the value passed as the operand.

That's a good question.
For x86 "r" constraint means 8, 16, 32, or 64 bit integer.
For arm64 "r" constraint means 32 or 64 bit integer.

and this is traditional behavior of "r" in other asms too:
AMDGPU - 32 or 64
Hexagon - 32 or 64
powerpc - 32 or 64
risc-v - 32 or 64

imo it makes sense for bpf asm to align with the rest so that:

asm volatile ("%[reg] +=3D 1"::[reg]"r"((unsigned)bar())); would generate
w0 +=3D 1, NO warn (with -mcpu=3Dv3,v4; and a warn with -mcpu=3Dv1,v2)

asm volatile ("%[reg] +=3D 1"::[reg]"r"((unsigned long)bar()));
r0 +=3D 1, NO warn

asm volatile ("%[reg] +=3D 1"::[reg]"w"((unsigned)bar()));
w0 +=3D 1, NO warn

asm volatile ("%[reg] +=3D 1"::[reg]"w"((unsigned long)bar()));
w0 +=3D 1 and a warn (currently there is none in clang)

I think we can add "R" constraint to mean 64-bit register only:

asm volatile ("%[reg] +=3D 1"::[reg]"R"((unsigned)bar()));
r0 +=3D 1 and a warn

asm volatile ("%[reg] +=3D 1"::[reg]"R"((unsigned long)bar()));
r0 +=3D 1, NO warn

