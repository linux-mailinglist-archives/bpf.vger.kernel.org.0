Return-Path: <bpf+bounces-19055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404FB824891
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 20:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582C51C21696
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 19:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA9528E21;
	Thu,  4 Jan 2024 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQF2VtXu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33ED28E1F
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28cd136f03so97966866b.2
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 11:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704395109; x=1704999909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QmMpR0XqPFYGjNvFAoUCJxRUKXdQ5AMTfb38YDKlIc=;
        b=nQF2VtXuOcFAbJp85/l0obJaXLD9BXaRHfpEDqtbpQCLaz+ios3qZ45LbmYX5G5Sxm
         vllyyc6ReoT3yQExaVm9wYzA2h1sbhOTqK3XJTDBDXxKbYIWDK8k6b5PCa2VNB+NXX5K
         jL4GR5BWpIp1qSFfyYlZRWMjrcoAqK4WBieIvqcAeMHFq259foaJtmG2rvsroGLTLAJc
         P8W0aW9ss2z5rbOJoXiXR1g2KztexOjE/+AYLMAR38UNrx3r7fx8vZsI86D1OMHD83Xq
         ewh6qf+TfXNOZod1dgfSJiDeQDckK0cpFy+dRc0BTyKLzI5SL+TgqHauUusz1nameAUb
         Jl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395109; x=1704999909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QmMpR0XqPFYGjNvFAoUCJxRUKXdQ5AMTfb38YDKlIc=;
        b=Hnq1EDlKpZJqdbcSCBwNHuzhvLn6MtwtLGYNJTvS1f9Gn9yIBnjMG3xq66g3weMwCY
         eXrTm/dCdHIn9TzqTu3yL7acnUfP82TKnGzLKxYjjmnJKdORjsM1TrFB7LK7NcRbQ1nr
         Hh6opMA7Wr4YlkCgqk3RTX3uOGkLPEO3hwruCct35vj4XLqfG936tRN5ioi7x/sWe9hy
         06Z6824pXO95OwiATI6BlmPzfjHecrZSIXNnTpuUPkeOaRORtwNrc8rDcevZHUruO0N1
         golAdBo5lOCAcZ+HWsz/O8wkDZHIP85lsjGO3oJmWqTnQxto+oMPxCT/SGgpfqvm5ctt
         Q7cA==
X-Gm-Message-State: AOJu0Yznp0A2940msfZEoJui+yQY3DzfPCskwUH34IWWitVGpnFqxRTQ
	j2we4X0FrXclJaySKD36wPoRSjzYUdVYfZavs2k=
X-Google-Smtp-Source: AGHT+IGxzXP4V/t5fuCf8KFcuyHxAsChnzeZiIOL1ibtZX3iWvFRi+ROArtl5w+M5oOvODQvzxGWskJ90trjxtfwKlE=
X-Received: by 2002:a17:906:81d5:b0:a19:53d9:b365 with SMTP id
 e21-20020a17090681d500b00a1953d9b365mr591226ejx.57.1704395108679; Thu, 04 Jan
 2024 11:05:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
 <20231226191148.48536-3-alexei.starovoitov@gmail.com> <CAEf4BzYQxH7k22tY7ZFXLLmFS4xy4wNGAVVF2OJECv=1RajF4Q@mail.gmail.com>
 <CAADnVQKcPCoFyqebM6GU7Y8M-6di-Zww8zCjydDiOMjXt4VzAQ@mail.gmail.com>
In-Reply-To: <CAADnVQKcPCoFyqebM6GU7Y8M-6di-Zww8zCjydDiOMjXt4VzAQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Jan 2024 11:04:55 -0800
Message-ID: <CAEf4BzYfd4MR-4+bWq_fYv-5SEk1oWBDuM06vb2OtpDKTepDQw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/6] bpf: Introduce "volatile compare" macros
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 10:04=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jan 3, 2024 at 11:20=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > > +
> > > +/* C type conversions coupled with comparison operator are tricky.
> > > + * Make sure BPF program is compiled with -Wsign-compre then
> >
> > fixed typo while applying: compare
>
> ohh. I cannot even copy-paste properly.
>
> > > + * __lhs OP __rhs below will catch the mistake.
> > > + * Be aware that we check only __lhs to figure out the sign of compa=
re.
> > > + */
> > > +#define _bpf_cmp(LHS, OP, RHS, NOFLIP) \
> >
> > nit: NOFLIP name is absolutely confusing, tbh, it would be nice to
> > rename it to something more easily understood (DEFAULT is IMO better)
>
> I actually had it as DEFAULT, but it was less clear.
> NOFLIP means whether the condition should be flipped or not.
> DEFAULT is too ambiguous.

LIKELY (or UNLIKELY, whichever makes sense) might be another
suggestion. But it's minor, so feel free to ignore.

>
> > > +       ({ \
> > > +               typeof(LHS) __lhs =3D (LHS); \
> > > +               typeof(RHS) __rhs =3D (RHS); \
> > > +               bool ret; \
> > > +               _Static_assert(sizeof(&(LHS)), "1st argument must be =
an lvalue expression"); \
> > > +               (void)(__lhs OP __rhs); \
> >
> > what is this part for? Is this what "__lhs OP __rhs below will catch
> > the mistake" in the comment refers to?
>
> Yes. This one will give proper error either on GCC -Wall
> or with clang -Wall -Wsign-compare.
>
> >
> > BTW, I think we hit this one when invalid OP is specified, before we
> > get to (void)"bug" (see below). So maybe it would be better to push it
> > deeper into __bpf_cmp itself?
> >
> > > +               if (__cmp_cannot_be_signed(OP) || !__is_signed_type(t=
ypeof(__lhs))) {\
> > > +                       if (sizeof(__rhs) =3D=3D 8) \
> > > +                               ret =3D __bpf_cmp(__lhs, OP, "", "r",=
 __rhs, NOFLIP); \
> > > +                       else \
> > > +                               ret =3D __bpf_cmp(__lhs, OP, "", "i",=
 __rhs, NOFLIP); \
> >
> > tbh, I'm also not 100% sure why this sizeof() =3D=3D 8 and correspondin=
g r
> > vs i change? Can you please elaborate (and add a comment in a follow
> > up, perhaps?)
>
> That was in the commit log:
> "
> Note that the macros has to be careful with RHS assembly predicate.
> Since:
> u64 __rhs =3D 1ull << 42;
> asm goto("if r0 < %[rhs] goto +1" :: [rhs] "ri" (__rhs));
> LLVM will silently truncate 64-bit constant into s32 imm.
> "
>
> I will add a comment to the code as well.

ah, ok, it didn't click for me, thanks for adding a comment

while on the topic, is there a problem specifying "ri" for sizeof() <
8 case? At least for alu32 cases, shouldn't we allow w1 < w2 kind of
situations?

>
> >
> > > +               } else { \
> > > +                       if (sizeof(__rhs) =3D=3D 8) \
> > > +                               ret =3D __bpf_cmp(__lhs, OP, "s", "r"=
, __rhs, NOFLIP); \
> > > +                       else \
> > > +                               ret =3D __bpf_cmp(__lhs, OP, "s", "i"=
, __rhs, NOFLIP); \
> >
> > one simplification that would reduce number of arguments to __bpf_cmp:
> >
> > in __bpf_cmp (drop # before OP):
> >
> > asm volatile goto("if %[lhs] " OP " %[rhs] goto %l[l_true]"
> >
> >
> > And here you just stringify operator, appending "s" if necessary:
> >
> > ret =3D __bpf_cmp(__lhs, #OP, "i", __rhs, NOFLIP);
> >
> > or
> >
> > ret =3D __bpf_cmp(__lhs, "s"#OP, "r", __rhs, NOFLIP);
> >
> > Consider for a follow up, if you agree it is a simplification.
>
> Just to reduce the number of arguments? I will give it a try.

yeah, pretty much just for that

>
> > I actually like a more verbose but also more explicit way of likely
> > implementation, listing explicitly supported operators.  It will also
> > be easier for users to check what they are supposed to pass. So that's
> > another thing to maybe do in the follow up?
>
> I thought about making unlikely explicit, but it looked weird and noisy:
>                 if (__builtin_strcmp(#OP, "=3D=3D") =3D=3D 0 ||
>                     __builtin_strcmp(#OP, "!=3D") =3D=3D 0 ||
>                     __builtin_strcmp(#OP, "<") =3D=3D 0  ||
> ...
> and all the noise just to make unlikely match likely.
>
> I felt it's not worth it and the error in the current form as you noticed=
:
>
> > progs/iters_task_vma.c:31:7: error: invalid operand for instruction
> >    31 |                 if (bpf_cmp_unlikely(seen, <<, 1000))
> > <inline asm>:1:8: note: instantiated into assembly here
> >    1 |         if r6 << 1000 goto LBB0_6
>
> is much cleaner instead of (void) return.

Right, I only played with unlikely last time. Trying the same with
likely right now, it's not that great:

In file included from progs/profiler2.c:6:
progs/profiler.inc.h:225:7: error: variable 'ret' is uninitialized
when used here [-Werror,-Wuninitialized]
  225 |                 if (bpf_cmp_likely(filepart_length, <=3D=3D, MAX_PA=
TH)) {
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/data/users/andriin/linux/tools/testing/selftests/bpf/bpf_experimental.h:32=
2:3:
note: expanded from macro 'bpf_cmp_likely'
  322 |                 ret;
                                 \
      |                 ^~~
progs/profiler.inc.h:225:7: note: variable 'ret' is declared here
/data/users/andriin/linux/tools/testing/selftests/bpf/bpf_experimental.h:30=
7:3:
note: expanded from macro 'bpf_cmp_likely'
  307 |                 bool ret;
                                 \
      |                 ^

I tried adding _Static_assert, and it is triggered for all valid cases
as well, so it seems like the compiler doesn't detect this last branch
as dead code, unfortunately.

>
> I've tried many different ways to have a helper macro
> #define flip_cmp_opcode(OP)
> and use it inside the bpf_cmp, but couldn't make it work.
> This is the shortest version of macros I came up with.

