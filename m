Return-Path: <bpf+bounces-19011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0048823C01
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 07:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AE4286F87
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 06:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185E618C31;
	Thu,  4 Jan 2024 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ2HI8Ls"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2102218EBD
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d4a222818so6662835e9.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 22:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704348242; x=1704953042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ybCF+Hxy0ygDy/j2/K+Ki2UTLHEtTEJ3IYaizFfCBs=;
        b=FJ2HI8LsEnBSs+xSEw7qUVPmgMpTXt1ozxtxvJqTUay1PTtQeNNuSW//PBjf7EdqQt
         TA0R6OELn0D1gSiMOiwMjgvYUn4BWKTlizEDXK7nbjN4/m/F3gW1ZxMCG7NXq9kK+t4V
         /U3CJtpygBFh83Z8tR0Gs+/3UlapJfqOrK6wEH/vwEthIcpcAGevKpJQva5IcOErzSPC
         adW4oFPGvgrKfI9OegfrYLTabzZNFr1L8Gi9y37OwBnI94yHoIjd/YxGnyhyFSiVQ8aG
         KCSjzwwn128BuR+3DbXtoMoU1QjZd3NCebUtJmtl/Dj9d0kN7SQAXXCErRLej4HhjMGW
         sK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704348242; x=1704953042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ybCF+Hxy0ygDy/j2/K+Ki2UTLHEtTEJ3IYaizFfCBs=;
        b=a65hGmsAzsz2LVp0iFxT3HiF3NcyBOpbeoyYouHIM0/SfszT6g4G0VFpdyRS05+qw1
         wxMKxUNz4G5Kjv5hmOdp4wF04HcTk+bOuW8d8IV65a1mo6CwBYApJRFt3Tc/tPgtyajG
         O5D7RgSZrfD89u3byxoIGC7uCeGxk4RzzvFt3plC8/18HEd5buZYY9PWRu1WHIN4U3FC
         46pPI6Tawln6euI+QrvD81rWgyZe1tTQc86LBk9X1iMqeyPLdrn0HimYxUTmdPgBte97
         M9xRTtg9SvBfkXuTrUoYIn8gyU5agwoXzYWKlhzfq52jIdypxh3GXcGezrwp5wdMNtNN
         /SXQ==
X-Gm-Message-State: AOJu0YyI86E+2SyiccJvse20+uQAIBRnVgYtx5yuNNmBBGZN4S+5wDSL
	Ds+j0iuUEYlI2vhCWfx5lfsVPK1F75gAeQw8llY=
X-Google-Smtp-Source: AGHT+IG0T9lVTeenI+6vdQ6XTBX0W9r9t26z+BIYLglioK+F2gK0ydtqNNWLZTXFMn5++8zPczpfQsHunG+AZKeIpwQ=
X-Received: by 2002:a05:600c:518b:b0:40d:51c5:665d with SMTP id
 fa11-20020a05600c518b00b0040d51c5665dmr36117wmb.0.1704348242087; Wed, 03 Jan
 2024 22:04:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
 <20231226191148.48536-3-alexei.starovoitov@gmail.com> <CAEf4BzYQxH7k22tY7ZFXLLmFS4xy4wNGAVVF2OJECv=1RajF4Q@mail.gmail.com>
In-Reply-To: <CAEf4BzYQxH7k22tY7ZFXLLmFS4xy4wNGAVVF2OJECv=1RajF4Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Jan 2024 22:03:50 -0800
Message-ID: <CAADnVQKcPCoFyqebM6GU7Y8M-6di-Zww8zCjydDiOMjXt4VzAQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/6] bpf: Introduce "volatile compare" macros
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 11:20=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > +
> > +/* C type conversions coupled with comparison operator are tricky.
> > + * Make sure BPF program is compiled with -Wsign-compre then
>
> fixed typo while applying: compare

ohh. I cannot even copy-paste properly.

> > + * __lhs OP __rhs below will catch the mistake.
> > + * Be aware that we check only __lhs to figure out the sign of compare=
.
> > + */
> > +#define _bpf_cmp(LHS, OP, RHS, NOFLIP) \
>
> nit: NOFLIP name is absolutely confusing, tbh, it would be nice to
> rename it to something more easily understood (DEFAULT is IMO better)

I actually had it as DEFAULT, but it was less clear.
NOFLIP means whether the condition should be flipped or not.
DEFAULT is too ambiguous.

> > +       ({ \
> > +               typeof(LHS) __lhs =3D (LHS); \
> > +               typeof(RHS) __rhs =3D (RHS); \
> > +               bool ret; \
> > +               _Static_assert(sizeof(&(LHS)), "1st argument must be an=
 lvalue expression"); \
> > +               (void)(__lhs OP __rhs); \
>
> what is this part for? Is this what "__lhs OP __rhs below will catch
> the mistake" in the comment refers to?

Yes. This one will give proper error either on GCC -Wall
or with clang -Wall -Wsign-compare.

>
> BTW, I think we hit this one when invalid OP is specified, before we
> get to (void)"bug" (see below). So maybe it would be better to push it
> deeper into __bpf_cmp itself?
>
> > +               if (__cmp_cannot_be_signed(OP) || !__is_signed_type(typ=
eof(__lhs))) {\
> > +                       if (sizeof(__rhs) =3D=3D 8) \
> > +                               ret =3D __bpf_cmp(__lhs, OP, "", "r", _=
_rhs, NOFLIP); \
> > +                       else \
> > +                               ret =3D __bpf_cmp(__lhs, OP, "", "i", _=
_rhs, NOFLIP); \
>
> tbh, I'm also not 100% sure why this sizeof() =3D=3D 8 and corresponding =
r
> vs i change? Can you please elaborate (and add a comment in a follow
> up, perhaps?)

That was in the commit log:
"
Note that the macros has to be careful with RHS assembly predicate.
Since:
u64 __rhs =3D 1ull << 42;
asm goto("if r0 < %[rhs] goto +1" :: [rhs] "ri" (__rhs));
LLVM will silently truncate 64-bit constant into s32 imm.
"

I will add a comment to the code as well.

>
> > +               } else { \
> > +                       if (sizeof(__rhs) =3D=3D 8) \
> > +                               ret =3D __bpf_cmp(__lhs, OP, "s", "r", =
__rhs, NOFLIP); \
> > +                       else \
> > +                               ret =3D __bpf_cmp(__lhs, OP, "s", "i", =
__rhs, NOFLIP); \
>
> one simplification that would reduce number of arguments to __bpf_cmp:
>
> in __bpf_cmp (drop # before OP):
>
> asm volatile goto("if %[lhs] " OP " %[rhs] goto %l[l_true]"
>
>
> And here you just stringify operator, appending "s" if necessary:
>
> ret =3D __bpf_cmp(__lhs, #OP, "i", __rhs, NOFLIP);
>
> or
>
> ret =3D __bpf_cmp(__lhs, "s"#OP, "r", __rhs, NOFLIP);
>
> Consider for a follow up, if you agree it is a simplification.

Just to reduce the number of arguments? I will give it a try.

> I actually like a more verbose but also more explicit way of likely
> implementation, listing explicitly supported operators.  It will also
> be easier for users to check what they are supposed to pass. So that's
> another thing to maybe do in the follow up?

I thought about making unlikely explicit, but it looked weird and noisy:
                if (__builtin_strcmp(#OP, "=3D=3D") =3D=3D 0 ||
                    __builtin_strcmp(#OP, "!=3D") =3D=3D 0 ||
                    __builtin_strcmp(#OP, "<") =3D=3D 0  ||
...
and all the noise just to make unlikely match likely.

I felt it's not worth it and the error in the current form as you noticed:

> progs/iters_task_vma.c:31:7: error: invalid operand for instruction
>    31 |                 if (bpf_cmp_unlikely(seen, <<, 1000))
> <inline asm>:1:8: note: instantiated into assembly here
>    1 |         if r6 << 1000 goto LBB0_6

is much cleaner instead of (void) return.

I've tried many different ways to have a helper macro
#define flip_cmp_opcode(OP)
and use it inside the bpf_cmp, but couldn't make it work.
This is the shortest version of macros I came up with.

