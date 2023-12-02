Return-Path: <bpf+bounces-16485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6BD801911
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 01:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E7E281E00
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 00:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7547E1C26;
	Sat,  2 Dec 2023 00:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKPafFjO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508CA196;
	Fri,  1 Dec 2023 16:41:08 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-332c7d4a6a7so1885959f8f.2;
        Fri, 01 Dec 2023 16:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701477667; x=1702082467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8GczNxJkUFx7ARxScvIumK7S61VTNrxCYttpBXDXk4=;
        b=HKPafFjOg3YTiY1ep7qC/xJRODT59zmTCFUY8Z/npul3XMp/IE8N2yv2KEHt40xykB
         4C4UaKNxv7IRrS+QM/fDmbjBQpW+NvbKFoJsAdUwDvou5zz+6/02wRDGajMpCvGNujWp
         ZkQUAgOHKfBlnheHtrDcA4+sS8X5PuUwRocSqycjb/ycfdIFTiABSu9z4p3zRvfdzGi3
         WNHQhqWl4aKgcVnXd/PZpbB6/SQNdXrz/ggK0Rfse0WDfN/+x/50xzpNRdksozMgwcDz
         Wuu+r0brZO6ytPb4FZo5A/uvFoxZJWX9nbCD1RUHbtZKpFRyfnC3fAyWEdF2iwS93jHu
         7cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701477667; x=1702082467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8GczNxJkUFx7ARxScvIumK7S61VTNrxCYttpBXDXk4=;
        b=OYP6Pc65nzDn/h6CGRdF1dPcJXOqa/NpZP8Sb0fhh6ehhke40++JEwgszU29VAZ7VQ
         YQo1kedYcAhjZtl/4vAcPOUIoCw4+al9T6Cqc1sqEopvNdWVZgRcJ0iN25fpUpkz8xBM
         +bVJPPOTEwfFlQkerjGgEFjVFq+x+hDYglV+JlEpBzyVUIc1Ikl2B7qHnIeUaGYFUQrE
         HdbE53RdhO4yAtJMrMBh/1R1K7u9/353IpLUVFj75fDmeIAZaPUTIIvzjT2NwSmtWTY0
         EoWfzIcddOtpE6LKvh6HC3YVLt9P4KW6QUYI7p2Di5oN9JN6QlZn8hC2aNIzBJlpqNQi
         lkcw==
X-Gm-Message-State: AOJu0YwZnnERz+JG2Y0S3+6A0XOD4kPf+0r1AC5vlSF/KvsKQwBBl4Kz
	hzrpmf1JxkuGoRT9d6WpenUSvsZImwokmOaz19E=
X-Google-Smtp-Source: AGHT+IFtJtSdTVweRGnD4ywWRyMK5UEuGC3x3jALEY3azwXt1aca34TsY6D2B8PdwGdn/ZWa4duZSkTwBPH7Yjr6OeM=
X-Received: by 2002:a5d:4bd1:0:b0:332:e68b:416c with SMTP id
 l17-20020a5d4bd1000000b00332e68b416cmr900318wrt.26.1701477666559; Fri, 01 Dec
 2023 16:41:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701462010.git.dxu@dxuuu.xyz> <adea997dff6d07332d294ad9cd233f3b71494a81.1701462010.git.dxu@dxuuu.xyz>
 <CAEf4BzaSDHuqfhGJgh6gvu5t8Vg-q72bp99hfFa0PCQhapJPZQ@mail.gmail.com> <n64nphqug6spftbr36tgf32qv5lipvugevyabcvrnefgarut4s@uymc5hm5jsq2>
In-Reply-To: <n64nphqug6spftbr36tgf32qv5lipvugevyabcvrnefgarut4s@uymc5hm5jsq2>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Dec 2023 16:40:54 -0800
Message-ID: <CAEf4BzYizrsOTSvrY2sL3RPaUgRxC51_nnVfoLBRbgEGrU6Q9w@mail.gmail.com>
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

On Fri, Dec 1, 2023 at 4:13=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Fri, Dec 01, 2023 at 03:49:30PM -0800, Andrii Nakryiko wrote:
> > On Fri, Dec 1, 2023 at 12:24=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote=
:
> > >
> > > =3D=3D=3D Motivation =3D=3D=3D
> > >
> > > Similar to reading from CO-RE bitfields, we need a CO-RE aware bitfie=
ld
> > > writing wrapper to make the verifier happy.
> > >
> > > Two alternatives to this approach are:
> > >
> > > 1. Use the upcoming `preserve_static_offset` [0] attribute to disable
> > >    CO-RE on specific structs.
> > > 2. Use broader byte-sized writes to write to bitfields.
> > >
> > > (1) is a bit hard to use. It requires specific and not-very-obvious
> > > annotations to bpftool generated vmlinux.h. It's also not generally
> > > available in released LLVM versions yet.
> > >
> > > (2) makes the code quite hard to read and write. And especially if
> > > BPF_CORE_READ_BITFIELD() is already being used, it makes more sense t=
o
> > > to have an inverse helper for writing.
> > >
> > > =3D=3D=3D Implementation details =3D=3D=3D
> > >
> > > Since the logic is a bit non-obvious, I thought it would be helpful
> > > to explain exactly what's going on.
> > >
> > > To start, it helps by explaining what LSHIFT_U64 (lshift) and RSHIFT_=
U64
> > > (rshift) is designed to mean. Consider the core of the
> > > BPF_CORE_READ_BITFIELD() algorithm:
> > >
> > >         val <<=3D __CORE_RELO(s, field, LSHIFT_U64);
> > >                 val =3D val >> __CORE_RELO(s, field, RSHIFT_U64);
> >
> > nit: indentation is off?
>
> Oops, it's cuz I only deleted the SIGNED check. Will fix.
> >
> > >
> > > Basically what happens is we lshift to clear the non-relevant (blank)
> > > higher order bits. Then we rshift to bring the relevant bits (bitfiel=
d)
> > > down to LSB position (while also clearing blank lower order bits). To
> > > illustrate:
> > >
> > >         Start:    ........XXX......
> > >         Lshift:   XXX......00000000
> > >         Rshift:   00000000000000XXX
> > >
> > > where `.` means blank bit, `0` means 0 bit, and `X` means bitfield bi=
t.
> > >
> > > After the two operations, the bitfield is ready to be interpreted as =
a
> > > regular integer.
> > >
> > > Next, we want to build an alternative (but more helpful) mental model
> > > on lshift and rshift. That is, to consider:
> > >
> > > * rshift as the total number of blank bits in the u64
> > > * lshift as number of blank bits left of the bitfield in the u64
> > >
> > > Take a moment to consider why that is true by consulting the above
> > > diagram.
> > >
> > > With this insight, we can how define the following relationship:
> > >
> > >               bitfield
> > >                  _
> > >                 | |
> > >         0.....00XXX0...00
> > >         |      |   |    |
> > >         |______|   |    |
> > >          lshift    |    |
> > >                    |____|
> > >               (rshift - lshift)
> > >
> > > That is, we know the number of higher order blank bits is just lshift=
.
> > > And the number of lower order blank bits is (rshift - lshift).
> > >
> >
> > Nice diagrams and description, thanks!
>
> Thanks!
>
> >
> > > Finally, we can examine the core of the write side algorithm:
> > >
> > >         mask =3D (~0ULL << rshift) >> lshift;   // 1
> > >         nval =3D new_val;                       // 2
> > >         nval =3D (nval << rpad) & mask;         // 3
> > >         val =3D (val & ~mask) | nval;           // 4
> > >
> > > (1): Compute a mask where the set bits are the bitfield bits. The fir=
st
> > >      left shift zeros out exactly the number of blank bits, leaving a
> > >      bitfield sized set of 1s. The subsequent right shift inserts the
> > >      correct amount of higher order blank bits.
> > > (2): Place the new value into a word sized container, nval.
> > > (3): Place nval at the correct bit position and mask out blank bits.
> > > (4): Mix the bitfield in with original surrounding blank bits.
> > >
> > > [0]: https://reviews.llvm.org/D133361
> > > Co-authored-by: Eduard Zingerman <eddyz87@gmail.com>
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > Co-authored-by: Jonathan Lemon <jlemon@aviatrix.com>
> > > Signed-off-by: Jonathan Lemon <jlemon@aviatrix.com>
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > ---
> > >  tools/lib/bpf/bpf_core_read.h | 34 +++++++++++++++++++++++++++++++++=
+
> > >  1 file changed, 34 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_r=
ead.h
> > > index 1ac57bb7ac55..a7ffb80e3539 100644
> > > --- a/tools/lib/bpf/bpf_core_read.h
> > > +++ b/tools/lib/bpf/bpf_core_read.h
> > > @@ -111,6 +111,40 @@ enum bpf_enum_value_kind {
> > >         val;                                                         =
         \
> > >  })
> > >
> > > +/*
> > > + * Write to a bitfield, identified by s->field.
> > > + * This is the inverse of BPF_CORE_WRITE_BITFIELD().
> > > + */
> > > +#define BPF_CORE_WRITE_BITFIELD(s, field, new_val) ({               =
   \
> > > +       void *p =3D (void *)s + __CORE_RELO(s, field, BYTE_OFFSET);  =
     \
> > > +       unsigned int byte_size =3D __CORE_RELO(s, field, BYTE_SIZE); =
     \
> > > +       unsigned int lshift =3D __CORE_RELO(s, field, LSHIFT_U64);   =
     \
> > > +       unsigned int rshift =3D __CORE_RELO(s, field, RSHIFT_U64);   =
     \
> > > +       unsigned int rpad =3D rshift - lshift;                       =
     \
> > > +       unsigned long long nval, mask, val;                          =
   \
> > > +                                                                    =
   \
> > > +       asm volatile("" : "+r"(p));                                  =
   \
> > > +                                                                    =
   \
> > > +       switch (byte_size) {                                         =
   \
> > > +       case 1: val =3D *(unsigned char *)p; break;                  =
     \
> > > +       case 2: val =3D *(unsigned short *)p; break;                 =
     \
> > > +       case 4: val =3D *(unsigned int *)p; break;                   =
     \
> > > +       case 8: val =3D *(unsigned long long *)p; break;             =
     \
> > > +       }                                                            =
   \
> > > +                                                                    =
   \
> > > +       mask =3D (~0ULL << rshift) >> lshift;                        =
     \
> > > +       nval =3D new_val;                                            =
     \
> > > +       nval =3D (nval << rpad) & mask;                              =
     \
> > > +       val =3D (val & ~mask) | nval;                                =
     \
> >
> > I'd simplify it to not need nval at all
> >
> > val =3D (val & ~mask) | ((new_val << rpad) & mask);
> >
> > I actually find it easier to follow and make sure we are not doing
> > anything unexpected. First part before |, we take old value and clear
> > bits we are about to set, second part after |, we take bitfield value,
> > shift it in position, and just in case mask it out if it's too big to
> > fit. Combine, done.
> >
> > Other than that, it looks good.
>
> I mostly left it there for the cast. Cuz injecting the `unsigned long
> long` cast made the line really long. How about this instead?
>
> diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.=
h
> index a7ffb80e3539..7325a12692a3 100644
> --- a/tools/lib/bpf/bpf_core_read.h
> +++ b/tools/lib/bpf/bpf_core_read.h
> @@ -120,8 +120,8 @@ enum bpf_enum_value_kind {
>         unsigned int byte_size =3D __CORE_RELO(s, field, BYTE_SIZE);     =
 \
>         unsigned int lshift =3D __CORE_RELO(s, field, LSHIFT_U64);       =
 \
>         unsigned int rshift =3D __CORE_RELO(s, field, RSHIFT_U64);       =
 \
> +       unsigned long long mask, val, nval =3D new_val;                  =
 \
>         unsigned int rpad =3D rshift - lshift;                           =
 \
> -       unsigned long long nval, mask, val;                             \
>                                                                         \
>         asm volatile("" : "+r"(p));                                     \
>                                                                         \
> @@ -133,9 +133,7 @@ enum bpf_enum_value_kind {
>         }                                                               \
>                                                                         \
>         mask =3D (~0ULL << rshift) >> lshift;                            =
 \
> -       nval =3D new_val;                                                =
 \
> -       nval =3D (nval << rpad) & mask;                                  =
 \
> -       val =3D (val & ~mask) | nval;                                    =
 \
> +       val =3D (val & ~mask) | ((nval << rpad) & mask);                 =
 \

sgtm

>                                                                         \
>         switch (byte_size) {                                            \
>         case 1: *(unsigned char *)p      =3D val; break;                 =
 \
>
>
> Thanks,
> Daniel

