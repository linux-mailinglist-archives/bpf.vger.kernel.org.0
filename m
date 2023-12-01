Return-Path: <bpf+bounces-16450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFBE801375
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 20:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAC31C20C79
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942214F205;
	Fri,  1 Dec 2023 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4OgT3GJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8958E;
	Fri,  1 Dec 2023 11:13:27 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a195e0145acso226486966b.2;
        Fri, 01 Dec 2023 11:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701458005; x=1702062805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2Lbiqp5ZRvN1hAivWbYt8v17Pu/BS70LAaQOJ42RIQ=;
        b=S4OgT3GJnn1F1kv+0iYK2iLNzjM17wuRavrToI8BhQactkOMdPhWgHrhIS+GJmnFi/
         qQ2HkOj1l3ll/Jxb01jUa8uzuTo1+keEjqeVIcTf+yKhjNa5ITbCQPmzQ7ecNpg5S3KA
         vYsZsUV5BkIubLflJUgBkQfCiG/lHpkfGKtXTWjognbrK4U0yd5yye8jx8GhCrT2UabT
         MnztDRnsiyms1Ziv81d1iNTmmfkEwLlNGtFEBQ0u1dJvcBrYTlwa/2FTjQPP+6AO6QHv
         8yy5aycpSNb6uGCETFeB05tybdu3cyPGaT56E63GduL+1CbXVaW6v+WGIs8k1ewSoCo/
         67tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701458005; x=1702062805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2Lbiqp5ZRvN1hAivWbYt8v17Pu/BS70LAaQOJ42RIQ=;
        b=kG8hu9yqAdc8Ot6CgVBnZH+iVUOEz7/lANBQnBKGr/Xv6p4TMRX6VOS8xrTBnfs6RQ
         TOVGMfkc8ZV+cwvk+wwlxQk1LTnHRjFlU701+sTOWa5eUBug1cibH5rJji1P4w8T8c2J
         QBbN41jhhakj50nG5H0vtMai/S7uuzmSwUDzO17vQiP9+1aLJ2ZdoDyMQHpmF7tVS68J
         TQHoVrHNXKKqLCU2WbPX87YVeS3eoQWAwOfYAF6imxW1AFqTiFv9HTe5qUwDRRDm6cje
         67b7tE0DKD8w/aU2oLNUdBh11p7yM6H8XX7pF/5frL3VmUK+ZmAed21lxca4XMscyuAs
         X1Gg==
X-Gm-Message-State: AOJu0YzWUsj3oaWbSpiXbB8iHMBwJvQlPIcX+TixOjO3L4edCTfTcP7V
	Ch/6dU2jLsR/7j9bSlA2CKiiyBNYOQ+yJjFjKFo=
X-Google-Smtp-Source: AGHT+IFO8HmN8cKisorXKlaxjvn65SXi9n3tkqpo3QVDmcxZEvOsV6J5UEz2W3qvKXgG+8ThW59v/XdJZwOzkviuwP4=
X-Received: by 2002:a17:906:f2c4:b0:a04:7e8a:dc2f with SMTP id
 gz4-20020a170906f2c400b00a047e8adc2fmr738405ejb.70.1701458005495; Fri, 01 Dec
 2023 11:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701193577.git.dxu@dxuuu.xyz> <ed7920365daf5eff1c82892b57e918d3db786ac7.1701193577.git.dxu@dxuuu.xyz>
 <20c593b6f31720a3d24d75e5e5cc3245b67249d1.camel@gmail.com>
 <ib27gbqj6c6ilblugm5kalwyfty6h4zujhvykw4a562uorqzjn@6wxeino6q7vk> <CAEf4BzbO80kFyFBCUixJ_NGqjJv79i+6oQXz+-jzRE+MaoRYZA@mail.gmail.com>
In-Reply-To: <CAEf4BzbO80kFyFBCUixJ_NGqjJv79i+6oQXz+-jzRE+MaoRYZA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Dec 2023 11:13:13 -0800
Message-ID: <CAEf4BzYGLVXVUptLym8p4dw4X=XxRErPLuPi=msHrwvXgDbCbQ@mail.gmail.com>
Subject: Re: [PATCH ipsec-next v2 3/6] libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Eduard Zingerman <eddyz87@gmail.com>, ndesaulniers@google.com, andrii@kernel.org, 
	nathan@kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	steffen.klassert@secunet.com, antony.antony@secunet.com, 
	alexei.starovoitov@gmail.com, yonghong.song@linux.dev, martin.lau@linux.dev, 
	song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, trix@redhat.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, devel@linux-ipsec.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 11:11=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 30, 2023 at 5:33=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > On Tue, Nov 28, 2023 at 07:59:01PM +0200, Eduard Zingerman wrote:
> > > On Tue, 2023-11-28 at 10:54 -0700, Daniel Xu wrote:
> > > > Similar to reading from CO-RE bitfields, we need a CO-RE aware bitf=
ield
> > > > writing wrapper to make the verifier happy.
> > > >
> > > > Two alternatives to this approach are:
> > > >
> > > > 1. Use the upcoming `preserve_static_offset` [0] attribute to disab=
le
> > > >    CO-RE on specific structs.
> > > > 2. Use broader byte-sized writes to write to bitfields.
> > > >
> > > > (1) is a bit a bit hard to use. It requires specific and
> > > > not-very-obvious annotations to bpftool generated vmlinux.h. It's a=
lso
> > > > not generally available in released LLVM versions yet.
> > > >
> > > > (2) makes the code quite hard to read and write. And especially if
> > > > BPF_CORE_READ_BITFIELD() is already being used, it makes more sense=
 to
> > > > to have an inverse helper for writing.
> > > >
> > > > [0]: https://reviews.llvm.org/D133361
> > > > From: Eduard Zingerman <eddyz87@gmail.com>
> > > >
> > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > ---
> > >
> > > Could you please also add a selftest (or several) using __retval()
> > > annotation for this macro?
> >
> > Good call about adding tests -- I found a few bugs with the code from
> > the other thread. But boy did they take a lot of brain cells to figure
> > out.
> >
> > There was some 6th grade algebra involved too -- I'll do my best to
> > explain it in the commit msg for v3.
> >
> >
> > Here are the fixes in case you are curious:
> >
> > diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_rea=
d.h
> > index 7a764f65d299..8f02c558c0ff 100644
> > --- a/tools/lib/bpf/bpf_core_read.h
> > +++ b/tools/lib/bpf/bpf_core_read.h
> > @@ -120,7 +120,9 @@ enum bpf_enum_value_kind {
> >         unsigned int byte_size =3D __CORE_RELO(s, field, BYTE_SIZE);   =
   \
> >         unsigned int lshift =3D __CORE_RELO(s, field, LSHIFT_U64);     =
   \
> >         unsigned int rshift =3D __CORE_RELO(s, field, RSHIFT_U64);     =
   \
> > -       unsigned int bit_size =3D (rshift - lshift);                   =
   \
> > +       unsigned int bit_size =3D (64 - rshift);                       =
   \
> > +       unsigned int hi_size =3D lshift;                               =
   \
> > +       unsigned int lo_size =3D (rshift - lshift);                    =
   \
>
> nit: let's drop unnecessary ()
>
> >         unsigned long long nval, val, hi, lo;                          =
 \
> >                                                                        =
 \
> >         asm volatile("" : "+r"(p));                                    =
 \
> > @@ -131,13 +133,13 @@ enum bpf_enum_value_kind {
> >         case 4: val =3D *(unsigned int *)p; break;                     =
   \
> >         case 8: val =3D *(unsigned long long *)p; break;               =
   \
> >         }                                                              =
 \
> > -       hi =3D val >> (bit_size + rshift);                             =
   \
> > -       hi <<=3D bit_size + rshift;                                    =
   \
> > -       lo =3D val << (bit_size + lshift);                             =
   \
> > -       lo >>=3D bit_size + lshift;                                    =
   \
> > +       hi =3D val >> (64 - hi_size);                                  =
   \
> > +       hi <<=3D 64 - hi_size;                                         =
   \
> > +       lo =3D val << (64 - lo_size);                                  =
   \
> > +       lo >>=3D 64 - lo_size;                                         =
   \
> >         nval =3D new_val;                                              =
   \
> > -       nval <<=3D lshift;                                             =
   \
> > -       nval >>=3D rshift;                                             =
   \
> > +       nval <<=3D (64 - bit_size);                                    =
   \
> > +       nval >>=3D (64 - bit_size - lo_size);                          =
   \
> >         val =3D hi | nval | lo;                                        =
   \
>
> this looks.. unusual. I'd imagine we calculate a mask, mask out bits
> we are replacing, and then OR with new values, roughly (assuming all
> the right left/right shift values and stuff)
>
> /* clear bits */
> val &=3D ~(bitfield_mask << shift);

we can also calculate shifted mask with just

bitfield_mask =3D (-1ULL) << some_left_shift >> some_right_shift;
val &=3D ~bitfield_mask;

> /* set bits */
> val |=3D (nval & bitfield_mask) << shift;
>
> ?
>
> >         switch (byte_size) {                                           =
 \
> >         case 1: *(unsigned char *)p      =3D val; break;               =
   \
> >
> >
> > Thanks,
> > Daniel

