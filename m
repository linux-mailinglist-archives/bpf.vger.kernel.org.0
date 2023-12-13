Return-Path: <bpf+bounces-17730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D168122D8
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A86D5B20B03
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 23:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D665E77B3F;
	Wed, 13 Dec 2023 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqwV6BP8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF5DA3;
	Wed, 13 Dec 2023 15:30:24 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1f33c13ff2so646913666b.3;
        Wed, 13 Dec 2023 15:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702510223; x=1703115023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ozznquyIJ/JaWIy+Ld4slYR/sYTFdj2kcAlWF/oGlQ=;
        b=XqwV6BP8EmnjF9ztA8NBWkhjXsQWnZOiqgjbIUJ77Cd89KgffHtwBWSeU7CgGVuOXg
         NNOIk+vxEpp7GYPhjsPbf2CY4ZCNPHmap9FHsmriqvYOjnwlz4pQV7A4bGwp5Rib847J
         /sxKyqc228w+gc0//weq4EVn4b/sec00VCe3ZAXMzTl0H9uJ4uNdafFYqhDuPJdPeedG
         i1qJLHyk7vakE0D1XwKky4763B4Ok8zEOpo+RRLWuHz3KY8UWKxdMeYx5hCfLDmo5JtE
         MXx3crfD59G42+kh6FOxKolN0tyc15gJTuJu8D2+awQLqCovkU8fT+gNcl6K75+qgd4v
         ozdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702510223; x=1703115023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ozznquyIJ/JaWIy+Ld4slYR/sYTFdj2kcAlWF/oGlQ=;
        b=kXRRYGDaDvjbU1RfMUJhA/OEAQGWWWo+4MklGkF2fR7qNgZBtKLzzRRjC4qCPPD9aT
         VJtF3C+wKkSfmQ+9LaSExBNf/GXTPmuPAWbS0fZb9PO8bRgUwchYK1iSkZoIm471gWrh
         dNidOSVrKqPwss4PcE0yzGXUdVPQEVzoZVG8ZQ8FOgv2nNIdT7cf7V4lryaG8ZDGy2Ax
         vfnuWKfuBG98rO12VkxFM/XJffoRnZNhOD8YwMPYBRJTBkM/5I6vRzZr2Tt/2FEI6p8i
         PNzu5mOXEJbPMj2w5zapPrfnZ5bTdOhPwzj3UFmsMXt/k6fUovopPuavEgalEaz/0Ebi
         SlgQ==
X-Gm-Message-State: AOJu0YzSCoS5c5cRq0VGdAAhLXhdTzrqvmW717IUd5+wM9ZnjBOf0Cd+
	wEBGUo/dR7o7Z5SA7Ez255OqrqWZIDy1bE9lsF0=
X-Google-Smtp-Source: AGHT+IEs5QBK/SIkCR664MlnJKuu0WkcaM0qQQdX+In7L+8Yv1gfd8UniSz6OXOyBkuxee/wUvlu+7mAqo60yclHxkw=
X-Received: by 2002:a17:906:cc96:b0:a1d:8259:98d2 with SMTP id
 oq22-20020a170906cc9600b00a1d825998d2mr4306898ejb.61.1702510222743; Wed, 13
 Dec 2023 15:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com> <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
In-Reply-To: <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 15:30:10 -0800
Message-ID: <CAEf4BzbGSrU4NgM1Ps0g_ch8G68CWEsP50Y+Wy8-SfYnpHwVGA@mail.gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
To: Hao Sun <sunhao.th@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 2:25=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrote=
:
>
> On Wed, Dec 13, 2023 at 1:51=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Dec 11, 2023 at 7:31=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> w=
rote:
> > >
> > > Hi,
> > >
> > > The verifier incorrectly prunes a path expected to be executed at
> > > runtime. In the following program, the execution path is:
> > >     from 6 to 8 (taken) -> from 11 to 15 (taken) -> from 18 to 22
> > > (taken) -> from 26 to 27 (fall-through) -> from 29 to 30
> > > (fall-through)
> > > The verifier prunes the checking path at #26, skipping the actual
> > > execution path.
> > >
> > >    0: (18) r2 =3D 0x1a000000be
> > >    2: (bf) r5 =3D r1
> > >    3: (bf) r8 =3D r2
> > >    4: (bc) w4 =3D w5
> > >    5: (85) call bpf_get_current_cgroup_id#680112
> > >    6: (36) if w8 >=3D 0x69 goto pc+1
> > >    7: (95) exit
> > >    8: (18) r4 =3D 0x52
> > >   10: (84) w4 =3D -w4
> > >   11: (45) if r0 & 0xfffffffe goto pc+3
> > >   12: (1f) r8 -=3D r4
> > >   13: (0f) r0 +=3D r0
> > >   14: (2f) r4 *=3D r4
> > >   15: (18) r3 =3D 0x1f00000034
> > >   17: (c4) w4 s>>=3D 29
> > >   18: (56) if w8 !=3D 0xf goto pc+3
> > >   19: r3 =3D bswap32 r3
> > >   20: (18) r2 =3D 0x1c
> > >   22: (67) r4 <<=3D 2
> > >   23: (bf) r5 =3D r8
> > >   24: (18) r2 =3D 0x4
> > >   26: (7e) if w8 s>=3D w0 goto pc+5
> > >   27: (4f) r8 |=3D r8
> > >   28: (0f) r8 +=3D r8
> > >   29: (d6) if w5 s<=3D 0x1d goto pc+2
> > >   30: (18) r0 =3D 0x4 ; incorrectly pruned here
> >
> >
> >
> > >   32: (95) exit
> > >

[...]

> > >
> > > Here is a reduced C repro, maybe someone else can shed some light on =
this.
> > > C repro: https://pastebin.com/raw/chrshhGQ
> >
> > So you claim is that
> >
> > 30: (18) r0 =3D 0x4 ; incorrectly pruned here
> >
> >
> > Can you please show a detailed code patch in which we do reach 30
> > actually? I might have missed it, but so far it look like verifier is
> > doing everything right.
> >
>
> I tried to convert the repro to a valid test case in inline asm, but seem=
s
> JSET (if r0 & 0xfffffffe goto pc+3) is currently not supported in clang-1=
7.
> Will try after clang-18 is released.

JSET has nothing to do with the issue, it's just a distraction, I'm
not sure why you bring JSET into the discussion at all.

Your repro can be actually much smaller, as it was really hard to
follow which parts are important and which weren't. If you can try to
minimize repros, it will definitely help with analysis for future
issues.

>
> #30 is expected to be executed, see below where everything after ";" is
> the runtime value:
>    ...
>    6: (36) if w8 >=3D 0x69 goto pc+1    ; w8 =3D 0xbe, always taken
>    ...
>   11: (45) if r0 & 0xfffffffe goto pc+3  ; r0 =3D 0x616, taken
>   ...
>   18: (56) if w8 !=3D 0xf goto pc+3     ; w8 not touched, taken
>   ...
>   23: (bf) r5 =3D r8     ; w5 =3D 0xbe
>   24: (18) r2 =3D 0x4
>   26: (7e) if w8 s>=3D w0 goto pc+5    ; non-taken
>   27: (4f) r8 |=3D r8
>   28: (0f) r8 +=3D r8
>   29: (d6) if w5 s<=3D 0x1d goto pc+2  ; non-taken
>   30: (18) r0 =3D 0x4      ; executed
>
> Since the verifier prunes at #26, #30 is dead and eliminated. So, #30
> is executed after manually commenting out the dead code rewrite pass.
>
> From my understanding, I think r0 should be marked as precise when
> first backtrack from #29, because r5 range at this point depends on w0
> as r8 and r5 share the same id at #26.

Yes, thanks, the execution trace above was helpful. Let's try to
minimize the example here, I'll keep original instruction indices,
though:

   23: (bf) r5 =3D r8                   ; here we link r5 and r8 together
   26: (7e) if w8 s>=3D w0 goto pc+5    ; here it's not always/never
taken, so w8 and w0 remain imprecise
   28: (0f) r8 +=3D r8                  ; here link between r8 and r5 is br=
oken
   29: (d6) if w5 s<=3D 0x1d goto pc+2  ; here we know value of w5 and
so it's always/never taken, r5 is marked precise

Now, if we look at r5's precision log at this instruction:

29: (d6) if w5 s<=3D 0x1d goto pc+2
mark_precise: frame0: last_idx 29 first_idx 26 subseq_idx -1
mark_precise: frame0: regs=3Dr5 stack=3D before 28: (0f) r8 +=3D r8
mark_precise: frame0: regs=3Dr5 stack=3D before 27: (4f) r8 |=3D r8
mark_precise: frame0: regs=3Dr5 stack=3D before 26: (7e) if w8 s>=3D w0 got=
o pc+5

Note how at this instruction r5 and r8 *WERE* linked together, but we
already lost this information for backtracking. So we don't mark w8 as
precise. That's one part of the problem.

The second part is that even if we knew that w8/r8 is precise, should
we mark w0/r0 as precise? I actually need to think about this some
more. Right now for conditional jumps we eagerly mark precision for
both registers only in always/never taken scenarios.

For now just narrowing down the issue, as I'm sure not many people
followed all the above stuff carefully.


P.S. For solving tracking of linked registers we can probably utilize
instruction history, though technically they can be spread across
multiple frames, between registers and stack slots, so that's a bit
tricky.

