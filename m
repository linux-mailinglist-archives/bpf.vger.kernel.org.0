Return-Path: <bpf+bounces-16472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1DE801810
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 00:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5673E28132F
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 23:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B216B4D12F;
	Fri,  1 Dec 2023 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvSrdFwv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA361B4;
	Fri,  1 Dec 2023 15:49:44 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a196f84d217so228506366b.3;
        Fri, 01 Dec 2023 15:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701474583; x=1702079383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vv48LOC3e09LzBvcT71ztOIfWllD91HEPBwZOsmIU1E=;
        b=YvSrdFwvxoKxpAL+MxrLtX8J6TkR7KrH/dj81YXnhDmDJnyA1DPb9hkalFlDMgVawG
         hggePwDXRnUkK8aLdkRrR4GmNzZvLPBIr/yHMOt6v6N6fP+eOWPof2wqsfGgAeoJuBts
         Nv9vVKo7a6FakZczz229FxKGHL47ZPViztUg+59s/pTAPG7IvSDjjW9CjNgYN7qEvmkP
         6/pLkht3KzQIvNUqfT/135IY1lsyY9+bpikpk8xP5wuUBf87g43sCB4k+Y0aMt3E6Aph
         yAfkxq+zbwyiZdz78vT6PpE6FmTy/iFOJJz1tzvKZzpdafq7e1KUqBttpn/NJSibdsu4
         srvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474583; x=1702079383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vv48LOC3e09LzBvcT71ztOIfWllD91HEPBwZOsmIU1E=;
        b=E5OggjkToeH78it4hyMOHDzyDJXvCshCfAENvK/TLL7WAk2XSGoJFGeflSm/W3ScOy
         B7EoCnYiUefq4F28SZMsrbPwcw/PPNjkzbUWp2sYCc9KoPxAHudwL7Uv+DJCLWy69Ul2
         cN8k20eneEdTFYL5rIYx2wzSHOdha4oYhBLmG1hSUKuk8FBKl6my6PpFQHeHJFHk9HrG
         4q4FLsvjzAekvt+wp7NlAY81a+YH9NMcxSt3vRMLdcBHJJ43GA3XjEHBBHGaF0jf9Apf
         FE/huZl1IQQHCLb+xF0o0t1DdUieXP/TCAIbYrwRwqroEC4MNPos4P0WY47g/OlFjdaI
         zv7g==
X-Gm-Message-State: AOJu0Yxu/O+9qDao23efdvmNnBd61h8P6IukNk+Yzj7n8RiCOwhz4JBR
	SpDBNVLgEgfK4w0rzhOmV5Gax8WLh9pRgSs9mqY=
X-Google-Smtp-Source: AGHT+IFeOeKN+GaFhGPrPoEPYpWXSzh6d+a1CmqErQInDltIIQ9VOBe4wSvDG31NlZW9hNJ8fvUhLV449qeBn8y6BRI=
X-Received: by 2002:a17:906:d0d7:b0:a19:a1ba:8cfd with SMTP id
 bq23-20020a170906d0d700b00a19a1ba8cfdmr1374871ejb.155.1701474582630; Fri, 01
 Dec 2023 15:49:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701462010.git.dxu@dxuuu.xyz> <adea997dff6d07332d294ad9cd233f3b71494a81.1701462010.git.dxu@dxuuu.xyz>
In-Reply-To: <adea997dff6d07332d294ad9cd233f3b71494a81.1701462010.git.dxu@dxuuu.xyz>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Dec 2023 15:49:30 -0800
Message-ID: <CAEf4BzaSDHuqfhGJgh6gvu5t8Vg-q72bp99hfFa0PCQhapJPZQ@mail.gmail.com>
Subject: Re: [PATCH ipsec-next v3 3/9] libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ndesaulniers@google.com, daniel@iogearbox.net, nathan@kernel.org, 
	ast@kernel.org, andrii@kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, alexei.starovoitov@gmail.com, 
	yonghong.song@linux.dev, eddyz87@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, trix@redhat.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, devel@linux-ipsec.org, 
	netdev@vger.kernel.org, Jonathan Lemon <jlemon@aviatrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 12:24=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
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
>                 val =3D val >> __CORE_RELO(s, field, RSHIFT_U64);

nit: indentation is off?

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
> With this insight, we can how define the following relationship:
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

Nice diagrams and description, thanks!

> Finally, we can examine the core of the write side algorithm:
>
>         mask =3D (~0ULL << rshift) >> lshift;   // 1
>         nval =3D new_val;                       // 2
>         nval =3D (nval << rpad) & mask;         // 3
>         val =3D (val & ~mask) | nval;           // 4
>
> (1): Compute a mask where the set bits are the bitfield bits. The first
>      left shift zeros out exactly the number of blank bits, leaving a
>      bitfield sized set of 1s. The subsequent right shift inserts the
>      correct amount of higher order blank bits.
> (2): Place the new value into a word sized container, nval.
> (3): Place nval at the correct bit position and mask out blank bits.
> (4): Mix the bitfield in with original surrounding blank bits.
>
> [0]: https://reviews.llvm.org/D133361
> Co-authored-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> Co-authored-by: Jonathan Lemon <jlemon@aviatrix.com>
> Signed-off-by: Jonathan Lemon <jlemon@aviatrix.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/lib/bpf/bpf_core_read.h | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.=
h
> index 1ac57bb7ac55..a7ffb80e3539 100644
> --- a/tools/lib/bpf/bpf_core_read.h
> +++ b/tools/lib/bpf/bpf_core_read.h
> @@ -111,6 +111,40 @@ enum bpf_enum_value_kind {
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
> +       unsigned int rpad =3D rshift - lshift;                           =
 \
> +       unsigned long long nval, mask, val;                             \
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
> +       nval =3D new_val;                                                =
 \
> +       nval =3D (nval << rpad) & mask;                                  =
 \
> +       val =3D (val & ~mask) | nval;                                    =
 \

I'd simplify it to not need nval at all

val =3D (val & ~mask) | ((new_val << rpad) & mask);

I actually find it easier to follow and make sure we are not doing
anything unexpected. First part before |, we take old value and clear
bits we are about to set, second part after |, we take bitfield value,
shift it in position, and just in case mask it out if it's too big to
fit. Combine, done.

Other than that, it looks good.

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

