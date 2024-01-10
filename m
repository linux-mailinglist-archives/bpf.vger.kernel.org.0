Return-Path: <bpf+bounces-19299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E08829191
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 01:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D9E1C25362
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 00:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5C2595;
	Wed, 10 Jan 2024 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4+ucrYB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA3B23B1;
	Wed, 10 Jan 2024 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e54f233abso4155125e9.0;
        Tue, 09 Jan 2024 16:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704847374; x=1705452174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpXFLoXQYi2E5X0fFdaKS875hFkfPN+jWP9OARQtqOg=;
        b=N4+ucrYBC0G5mez3DMnj4La+KjruYX7QGnJnND+YGKH+BHeyPURe68h5VWXAPtkKHJ
         prnHkakmLwscNs32XJ0VbXAyDKFXJhnPl8sSlI9nbiPTraN7i8Md7N8Ij8aL/r5sxmIM
         nQ5LiQHTDPKZ0HSGjVVVe0Vtj+3UI/e/fg9vPbWUDAs+vTAhzib8ohND7NHAIOUbmjw7
         7yRgibw6MNZTJv1e/lhilwBrKzP+ekYvHef9ChAm8sUTTKWEODSTDhr00WUA/cQ7ZcgP
         a+Xxji+691Rv5fDChNiIIkxuI2ZsKYPRHeS0q9v+2G+7bXM/0DqSklyjbaWzAGOsNqDC
         6nGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704847374; x=1705452174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpXFLoXQYi2E5X0fFdaKS875hFkfPN+jWP9OARQtqOg=;
        b=n6N1VLBQ+cktasUg27B3GEjK9YtXzxQ6K46r8W9E/G4MfTZqWXUn2j6REaBaXsDlxf
         2uuKaWywSffsX6D39bZEDAOU9AyTcp8VHv/PoplSKEb+Vo33Df+8nB9/LOMhxElEuKSA
         creNtOgBJC6J5IASRl8Y50N1mjIswccxc/T3Qo9a/Hs4hlkNEnhG3lQpAijQGQqAxmXA
         AM0I9AZ9pxhiusYglEB8l89Cdb4OwxVKqa/l1q8HdABvZe3r3z5jf7cX6xE6c+4JVJHE
         9cJf9t51wRIU3NFnDM1eE33TKZzDLCQfdWWDminEJFXKd6sy5OzPoq82MdAPiyk6l4QS
         Ee0g==
X-Gm-Message-State: AOJu0Yybc0xXu5nY/QtlSL6B9ylDmTpDhR0qOcadgDP/7ERFpjvZHwiF
	RH0Ya+FHYnPZcYPfI/dfIvxO5c35hfYryrztlp0=
X-Google-Smtp-Source: AGHT+IFIIQq1eCPExKNyna8q1ShGM+3BjLm/OurhrerEtZw3fd9fO7rJQm2C086fXBO8ZyhqyhNHmgm9z/a4zU+KWhI=
X-Received: by 2002:a05:600c:540a:b0:40e:550e:410c with SMTP id
 he10-20020a05600c540a00b0040e550e410cmr79985wmb.36.1704847374309; Tue, 09 Jan
 2024 16:42:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103185403.610641-1-brho@google.com> <20240103185403.610641-3-brho@google.com>
 <ZZa1668ft4Npd1DA@krava> <f3dd9d80-3fab-4676-b589-1d4667431287@linux.dev> <e5e52e0a-7494-47bb-8a6a-9819b0c93bd8@google.com>
In-Reply-To: <e5e52e0a-7494-47bb-8a6a-9819b0c93bd8@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Jan 2024 16:42:43 -0800
Message-ID: <CAADnVQ+oY9cdNKyby0sYDAHdFC-LeSmF3idKJeVzmQGXqCQocQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add inline assembly
 helpers to access array elements
To: Barret Rhoden <brho@google.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <olsajiri@gmail.com>, 
	Eddy Z <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 1:30=E2=80=AFPM Barret Rhoden <brho@google.com> wrot=
e:
>
> On 1/4/24 12:31, Yonghong Song wrote:
> [snip]
>
> >>> +/*
> >>> + * Access an array element within a bound, such that the verifier
> >>> knows the
> >>> + * access is safe.
> >>> + *
> >>> + * This macro asm is the equivalent of:
> >>> + *
> >>> + *    if (!arr)
> >>> + *        return NULL;
> >>> + *    if (idx >=3D arr_sz)
> >>> + *        return NULL;
> >>> + *    return &arr[idx];
> >>> + *
> >>> + * The index (___idx below) needs to be a u64, at least for certain
> >>> versions of
> >>> + * the BPF ISA, since there aren't u32 conditional jumps.
> >>> + */
> >>> +#define bpf_array_elem(arr, arr_sz, idx) ({                \
> >>> +    typeof(&(arr)[0]) ___arr =3D arr;                    \
> >>> +    __u64 ___idx =3D idx;                        \
> >>> +    if (___arr) {                            \
> >>> +        asm volatile("if %[__idx] >=3D %[__bound] goto 1f;    \
> >>> +                  %[__idx] *=3D %[__size];        \
> >>> +                  %[__arr] +=3D %[__idx];        \
> >>> +                  goto 2f;                \
> >>> +                  1:;                \
> >>> +                  %[__arr] =3D 0;            \
> >>> +                  2:                \
> >>> +                  "                        \
> >>> +                 : [__arr]"+r"(___arr), [__idx]"+r"(___idx)    \
> >>> +                 : [__bound]"r"((arr_sz)),                \
> >>> +                   [__size]"i"(sizeof(typeof((arr)[0])))    \
> >>> +                 : "cc");                    \
> >>> +    }                                \
> >>> +    ___arr;                                \
> >>> +})
> >
> > The LLVM bpf backend has made some improvement to handle the case like
> >    r1 =3D ...
> >    r2 =3D r1 + 1
> >    if (r2 < num) ...
> >    using r1
> > by preventing generating the above code pattern.
> >
> > The implementation is a pattern matching style so surely it won't be
> > able to cover all cases.
> >
> > Do you have specific examples which has verification failure due to
> > false array out of bound access?
>
> Not in a small example.  =3D(
>
> This bug has an example, but it was part of a larger program:
> https://github.com/google/ghost-userspace/issues/31
>
> The rough progression was:
> - sometimes the compiler optimizes out the checks.  So we added a macro
> to make the compiler not know the value of the variable anymore.
> - then, the compiler would occasionally do the check on a copy of the
> register, so we did the comparison and index operation all in assembly.
>
>
> I tried using bpf_cmp_likely() in my actual program (not just a one-off
> test), and still had a verifier issue.  It's a large and convoluted
> program, so it might be hard to get a small reproducer.  But it a
> different compiler issue than the one you mentioned.
>
> Specifically, I swapped out my array-access-macro for this one, using
> bpf_cmp_likely():
>
> #define bpf_array_elem(arr, arr_sz, idx) ({ \
>          typeof(&(arr)[0]) ___arr =3D arr;        \
>          typeof(&(arr)[0]) ___ret =3D 0;          \
>          u64 ___idx =3D idx;                      \
>          if (___arr && bpf_cmp_likely(___idx, <, arr_sz))   \
>                  ___ret =3D &___arr[___idx];\
>          ___ret;                          \
> })
>
> which should be the same logic as before:
>
>   *      if (!arr)
>   *              return NULL;
>   *      if (idx >=3D arr_sz)
>   *              return NULL;
>   *      return &arr[idx];
>
> The issue I run into is different than the one you had.  The compiler
> did the bounds check, but then for some reason recreated the index.  The
> index is coming from another map.
>
> Arguably, the verifier is doing its job - that value could have changed.
>   I just don't want the compiler to do the reread or any other
> shenanigans in between the bounds check and the usage.
>
> The guts of the error:
> - r0 is the map (L127)
> - r1 is the index, read from another map (L128)
> - r1 gets verified to be less than 0x200 (L129)
> - some other stuff happens
> - r1 gets read again, and is no longer bound (L132)
> - r1 gets scaled up by 896.
>    (896*0x200 =3D 0x70000, would be the real bound, but r1 lost the 0x200
> bound)
> - r0 indexed by the bad r1 (L134)
> - blow up (L143)
>
> 127: (15) if r0 =3D=3D 0x0 goto pc+1218   ;
> R0=3Dmap_value(off=3D0,ks=3D4,vs=3D458752,imm=3D0)
>
> 128: (79) r1 =3D *(u64 *)(r10 -40)      ;
> R1_w=3DPscalar(umax=3D4294967295,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0
>
> 129: (35) if r1 >=3D 0x200 goto pc+1216         ;
> R1_w=3DPscalar(umax=3D511,var_off=3D(0x0; 0x1ff))
>
> 130: (79) r4 =3D *(u64 *)(r10 -56)      ; R4_w=3DPscalar() R10=3Dfp0;
>
> 131: (37) r4 /=3D 1000                  ; R4_w=3DPscalar()
>
> 132: (79) r1 =3D *(u64 *)(r10 -40)      ;
> R1_w=3DPscalar(umax=3D4294967295,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0;
>
> 133: (27) r1 *=3D 896                   ;
> R1_w=3DPscalar(umax=3D3848290696320,var_off=3D(0x0;
> 0x3ffffffff80),s32_max=3D2147483520,u32_max=3D-128)
>
> 134: (0f) r0 +=3D r1                    ;
> R0_w=3Dmap_value(off=3D0,ks=3D4,vs=3D458752,umax=3D3848290696320,var_off=
=3D(0x0;
> 0x3ffffffff80),s32_max=3D2147483520,u32_max=3D-128)
> R1_w=3DPscalar(umax=3D3848290696320,var_off=3D(0x0;
> 0x3ffffffff80),s32_max=3D2147483520,u32_max=3D-128)
>
> 135: (79) r3 =3D *(u64 *)(r10 -48)      ;
> R3_w=3Dmap_value(off=3D0,ks=3D4,vs=3D15728640,imm=3D0) R10=3Dfp0;
>
> 136: (0f) r3 +=3D r8                    ;
> R3_w=3Dmap_value(off=3D0,ks=3D4,vs=3D15728640,umax=3D15728400,var_off=3D(=
0x0;
> 0xfffff0),s32_max=3D16777200,u32_max=3D16777200)
> R8=3DPscalar(umax=3D15728400,var_off=3D(0x0; 0xfffff0))
>
> 137: (61) r1 =3D *(u32 *)(r7 +16)       ;
> R1_w=3DPscalar(umax=3D4294967295,var_off=3D(0x0; 0xffffffff))
> R7=3Dmap_value(id=3D18779,off=3D0,ks=3D4,vs=3D224,imm=3D0)
>
> 138: (79) r2 =3D *(u64 *)(r3 +88)       ; R2=3DPscalar()
> R3=3Dmap_value(off=3D0,ks=3D4,vs=3D15728640,umax=3D15728400,var_off=3D(0x=
0;
> 0xfffff0),s32_max=3D16777200,u32_max=3D16777200)
>
> 139: (a5) if r1 < 0x9 goto pc+1       ;
> R1=3DPscalar(umin=3D9,umax=3D4294967295,var_off=3D(0x0; 0xffffffff))
>
> 140: (b7) r1 =3D 0                      ; R1_w=3DP0
>
> 141: (27) r1 *=3D 72                    ; R1_w=3DP0
>
> 142: (0f) r0 +=3D r1                    ;
> R0_w=3Dmap_value(off=3D0,ks=3D4,vs=3D458752,umax=3D3848290696320,var_off=
=3D(0x0;
> 0x3ffffffff80),s32_max=3D2147483520,u32_max=3D-128) R1_w=3DP0
>
> 143: (7b) *(u64 *)(r0 +152) =3D r2
>
>
> if i put in a little ASM magic to tell the compiler to not recreate the
> index, it works, like so:
>
> #define BPF_MUST_CHECK(x) ({ asm volatile ("" : "+r"(x)); x; })
>
> #define bpf_array_elem(arr, arr_sz, idx) ({ \
>          typeof(&(arr)[0]) ___arr =3D arr;        \
>          typeof(&(arr)[0]) ___ret =3D 0;          \
>          u64 ___idx =3D idx;                      \
>          BPF_MUST_CHECK(___idx);                \
>         if (___arr && bpf_cmp_likely(___idx, <, arr_sz))   \
>                  ___ret =3D &___arr[___idx];\
>          ___ret;                          \
> })
>
> though anecdotally, that only stops the "reread the index from its map"
> problem, similar to a READ_ONCE.  the compiler is still free to just use
> another register for the check.
>
> The bit of ASM i had from a while back that did that was:
>
>   *      r2 =3D r8
>   *      r2 <<=3D 32
>
>   *      r2 >>=3D 32
>   *      if r2 > 0x3ff goto pc+29
>
>   *      r8 <<=3D 32
>
>   *      r8 >>=3D 32
>
>   *      r8 <<=3D 6
>
>   *      r0 +=3D r8
>   *      *(u64 *)(r0 +48) =3D r3
>
>
> where r2 was bounds checked, but r8 was used instead.
>
> I'll play around and see if I can come up with a selftest that can run
> into any of these "you did the check, but threw the check away" scenarios=
.

Before we add full asm bpf_array_elem() macros let's fully
understand the issue first. Maybe it's a llvm deficiency
or verifier miss that can be addressed.
asm everywhere isn't a viable approach long term.

First start with:
asm volatile ("" : "+r"((short)x));

It will avoid unnecessary <<=3D32, >>=3D32 in -mcpu=3Dv3,v4.

Then do:
if (likely(___arr) && bpf_cmp_likely(___idx, <, arr_sz))
    ^^^
just to have the expected basic block layout,
because that's what your asm does.

And, of course, a selftest is necessary to debug this further.

