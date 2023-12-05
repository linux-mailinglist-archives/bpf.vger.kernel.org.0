Return-Path: <bpf+bounces-16701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97659804864
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 05:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEAED1C20E8D
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 04:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3EBCA57;
	Tue,  5 Dec 2023 04:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0+zuR9m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1818EC6;
	Mon,  4 Dec 2023 20:04:09 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54bf9a54fe3so6598862a12.3;
        Mon, 04 Dec 2023 20:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701749047; x=1702353847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFi1KzwR2YOrUv7jhd8tU8M3SbznND0IRUD4tj9oA8M=;
        b=P0+zuR9mhOIQhnB7yq+1BNIAdWArnUf7N2hGX6BAVSGHIAY0Znd+eNE/R0285ALnlm
         Du322hMnyD/Qqc8IjsLTGsEnwIXe+gR9aJGZ7cOrW3Rvr+bQEB6W2NNpMIp21VnhoS4K
         AsT3q7qLSjUlx46HAOZ7mY5iPuLewUoTKKW/iVNk7iSbzl2aEsPBhmM7y5tICx8gqVqN
         Hog4GKFunVNuExCqnOQpSmLUB5a7Flvrw+8WwQih2KLsJMxhV2gUTnsq8N1Bv0KZ04BM
         RmaTTKRbIt1xxm6J7IgYK/5ToKnILTxOsPHGw7ogxqz33svnQKTaaWYXMIhcG6yKssVO
         xRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701749047; x=1702353847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFi1KzwR2YOrUv7jhd8tU8M3SbznND0IRUD4tj9oA8M=;
        b=RO9YJwTKT0X9LMgggRwddgUv2DgEZz232yW/T5jSUyL9ExfkPLffEkQ5R+AADRjgSL
         NXE4VKb1Vo81/Iiu6fZ9pADpYgmPqlgyYOMX487rJczLwqh4ThTdVQrngBgiG9p801Aa
         AiF2RQEVEOcLabrKJjMD+SeuM+K/PJAax1VeZXeXF3xb6aKa7wjhjEkR8kQTtzyMLVg1
         iNkLLR5Ry/d9uocXa9HM/J1bgN/jNzZ9uBUDOre8M6jDgbnlhNlTNQ9hjH8ioVLs3hMM
         bmfehZUiSmO2TzFMo8udaiBgrGY9atmo33VLqlFC/ykmrL9/hL+cj1OvRCMVxsHLna6l
         HOPg==
X-Gm-Message-State: AOJu0YwAaq+BruUtqAgR6WmenRkeccKcYfIcpe0B1yf3+NqLMGPU58rm
	wBLjFEFfPBiOUbC+0mxPwQDZ70XrGLNRiYlF5P0=
X-Google-Smtp-Source: AGHT+IHlElgymjUGnl2Tt5Nltm4vXZSUCl9EGHfjGEDPwuNWjQ08MgP9Y1yXwxvvpigxSnBa8Ix9uShVCy+CgeBCf8U=
X-Received: by 2002:a17:906:f196:b0:a19:a1ba:8cf1 with SMTP id
 gs22-20020a170906f19600b00a19a1ba8cf1mr3189378ejb.143.1701749047390; Mon, 04
 Dec 2023 20:04:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701722991.git.dxu@dxuuu.xyz> <d213a6438f7f5db1014f6b41213b71851736d3bc.1701722991.git.dxu@dxuuu.xyz>
In-Reply-To: <d213a6438f7f5db1014f6b41213b71851736d3bc.1701722991.git.dxu@dxuuu.xyz>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 20:03:55 -0800
Message-ID: <CAEf4BzZphyxnjmz+9FdsKst3WuaN7w5bSvX6szXic4gy-wfR_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 04/10] libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: daniel@iogearbox.net, ast@kernel.org, nathan@kernel.org, andrii@kernel.org, 
	ndesaulniers@google.com, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, alexei.starovoitov@gmail.com, 
	yonghong.song@linux.dev, eddyz87@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, trix@redhat.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, devel@linux-ipsec.org, 
	netdev@vger.kernel.org, Jonathan Lemon <jlemon@aviatrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 12:57=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> =3D=3D=3D Motivation =3D=3D=3D
>
> Similar to reading from CO-RE bitfields, we need a CO-RE aware bitfield
> writing wrapper to make the verifier happy.
>
> Two alternatives to this approach are:
>
> 1. Use the upcoming `preserve_static_offset` [0] attribute to disable
>    CO-RE on specific structs.
> 2. Use broader byte-sized writes to write to bitfields.
>
> (1) is a bit hard to use. It requires specific and not-very-obvious
> annotations to bpftool generated vmlinux.h. It's also not generally
> available in released LLVM versions yet.
>
> (2) makes the code quite hard to read and write. And especially if
> BPF_CORE_READ_BITFIELD() is already being used, it makes more sense to
> to have an inverse helper for writing.
>
> =3D=3D=3D Implementation details =3D=3D=3D
>
> Since the logic is a bit non-obvious, I thought it would be helpful
> to explain exactly what's going on.
>
> To start, it helps by explaining what LSHIFT_U64 (lshift) and RSHIFT_U64
> (rshift) is designed to mean. Consider the core of the
> BPF_CORE_READ_BITFIELD() algorithm:
>
>         val <<=3D __CORE_RELO(s, field, LSHIFT_U64);
>         val =3D val >> __CORE_RELO(s, field, RSHIFT_U64);
>
> Basically what happens is we lshift to clear the non-relevant (blank)
> higher order bits. Then we rshift to bring the relevant bits (bitfield)
> down to LSB position (while also clearing blank lower order bits). To
> illustrate:
>
>         Start:    ........XXX......
>         Lshift:   XXX......00000000
>         Rshift:   00000000000000XXX
>
> where `.` means blank bit, `0` means 0 bit, and `X` means bitfield bit.
>
> After the two operations, the bitfield is ready to be interpreted as a
> regular integer.
>
> Next, we want to build an alternative (but more helpful) mental model
> on lshift and rshift. That is, to consider:
>
> * rshift as the total number of blank bits in the u64
> * lshift as number of blank bits left of the bitfield in the u64
>
> Take a moment to consider why that is true by consulting the above
> diagram.
>
> With this insight, we can now define the following relationship:
>
>               bitfield
>                  _
>                 | |
>         0.....00XXX0...00
>         |      |   |    |
>         |______|   |    |
>          lshift    |    |
>                    |____|
>               (rshift - lshift)
>
> That is, we know the number of higher order blank bits is just lshift.
> And the number of lower order blank bits is (rshift - lshift).
>
> Finally, we can examine the core of the write side algorithm:
>
>         mask =3D (~0ULL << rshift) >> lshift;              // 1
>         val =3D (val & ~mask) | ((nval << rpad) & mask);   // 2
>
> 1. Compute a mask where the set bits are the bitfield bits. The first
>    left shift zeros out exactly the number of blank bits, leaving a
>    bitfield sized set of 1s. The subsequent right shift inserts the
>    correct amount of higher order blank bits.
>
> 2. On the left of the `|`, mask out the bitfield bits. This creates
>    0s where the new bitfield bits will go. On the right of the `|`,
>    bring nval into the correct bit position and mask out any bits
>    that fall outside of the bitfield. Finally, by bor'ing the two
>    halves, we get the final set of bits to write back.
>
> [0]: https://reviews.llvm.org/D133361
> Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> Co-developed-by: Jonathan Lemon <jlemon@aviatrix.com>
> Signed-off-by: Jonathan Lemon <jlemon@aviatrix.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/lib/bpf/bpf_core_read.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.=
h
> index 1ac57bb7ac55..7325a12692a3 100644
> --- a/tools/lib/bpf/bpf_core_read.h
> +++ b/tools/lib/bpf/bpf_core_read.h
> @@ -111,6 +111,38 @@ enum bpf_enum_value_kind {
>         val;                                                             =
     \
>  })
>
> +/*
> + * Write to a bitfield, identified by s->field.
> + * This is the inverse of BPF_CORE_WRITE_BITFIELD().
> + */
> +#define BPF_CORE_WRITE_BITFIELD(s, field, new_val) ({                  \
> +       void *p =3D (void *)s + __CORE_RELO(s, field, BYTE_OFFSET);      =
 \
> +       unsigned int byte_size =3D __CORE_RELO(s, field, BYTE_SIZE);     =
 \
> +       unsigned int lshift =3D __CORE_RELO(s, field, LSHIFT_U64);       =
 \
> +       unsigned int rshift =3D __CORE_RELO(s, field, RSHIFT_U64);       =
 \
> +       unsigned long long mask, val, nval =3D new_val;                  =
 \
> +       unsigned int rpad =3D rshift - lshift;                           =
 \
> +                                                                       \
> +       asm volatile("" : "+r"(p));                                     \
> +                                                                       \
> +       switch (byte_size) {                                            \
> +       case 1: val =3D *(unsigned char *)p; break;                      =
 \
> +       case 2: val =3D *(unsigned short *)p; break;                     =
 \
> +       case 4: val =3D *(unsigned int *)p; break;                       =
 \
> +       case 8: val =3D *(unsigned long long *)p; break;                 =
 \
> +       }                                                               \
> +                                                                       \
> +       mask =3D (~0ULL << rshift) >> lshift;                            =
 \
> +       val =3D (val & ~mask) | ((nval << rpad) & mask);                 =
 \
> +                                                                       \
> +       switch (byte_size) {                                            \
> +       case 1: *(unsigned char *)p      =3D val; break;                 =
 \
> +       case 2: *(unsigned short *)p     =3D val; break;                 =
 \
> +       case 4: *(unsigned int *)p       =3D val; break;                 =
 \
> +       case 8: *(unsigned long long *)p =3D val; break;                 =
 \
> +       }                                                               \
> +})
> +
>  #define ___bpf_field_ref1(field)       (field)
>  #define ___bpf_field_ref2(type, field) (((typeof(type) *)0)->field)
>  #define ___bpf_field_ref(args...)                                       =
   \
> --
> 2.42.1
>

