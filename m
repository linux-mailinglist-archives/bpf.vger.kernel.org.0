Return-Path: <bpf+bounces-35843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1005A93E9F9
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 00:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B87B2107A
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 22:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D832178C7E;
	Sun, 28 Jul 2024 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPFdxEF/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2E03EA9B;
	Sun, 28 Jul 2024 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722206334; cv=none; b=ZXIDmneAW4H2pCwlfgP81DTtBWYIdh+Kjhxz8EOVVdUTTRg8/VkwnYCpLoYw7K0EJuaHLEwVRZP/6X8ajD04gr4ZyM55bU0/kjQmjI138/yjcVYLCvLmZctyOxbZWT09M+yCnnEPcecMfLof9pFvIbKhkINs7spAP1lqsDUmhtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722206334; c=relaxed/simple;
	bh=csElnASaF8hHOwznfzqGNKeBBmOTBBo4DfRsSBbGbP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CK2Ha8WS1ejOXPi5zucV3fhOYFsM1jHJTzGGXm5WRAa09I8TjVYm/01r9sMqm1tSDAJnmvezLCxJpkJUUHYIaM48lXFbgVrdDOTVdOTBmXRcr4CodMHV4c0JZPeTUFEzcFpIG36jBbO92EUwDR5H9Qrx95sPVbYqagpzHxbBUn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPFdxEF/; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-81ff6a80cb2so518510241.3;
        Sun, 28 Jul 2024 15:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722206331; x=1722811131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dFl7H0JVrAtWh38PKa1GAtZupIgVsrX5EqCXtFy28I=;
        b=mPFdxEF/ouSA2ty6kXQViZID77XngWwFPpofT0V/oRzakIu/CylYK7iOWWnbxDaiQa
         wv5tMez2FHm1WMIxv+ZYUWP7y6LPbEZHrHqh3z2jY4A+6vJlUtbx71K2x7sawcQncQg9
         Puq9SiVQTJ+28REJ6OLDYs41kZAR9BwScg2CwYDPLv1JAk/SEx0TtaO4r9G2dfBShuta
         BgkStBxtx1S/EA7VsNBXuFZMi05pgAGSpFeBvfmtg30d9cRUvUDSqrpD9LCf/T9CmXbP
         9aB3w2T42rKz/YwBZQgoi3C+5TBoYRsd0QcprmivAYHIvkKW+8eRSOvS0a3xNlR/r6eC
         CmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722206331; x=1722811131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dFl7H0JVrAtWh38PKa1GAtZupIgVsrX5EqCXtFy28I=;
        b=B3lZC5E2rHbxbfBDmnZT6wA6+n6Crop9QRcVMvi1IWD9wAFeu1R1FCY01QKQlZcWJg
         LC7ZPbC6ttfbUW9ZVhHdawMxFmpipEVm4GTV41LYbDlSb+2HpI33rUMZj3sDVccF6kbQ
         FZGOz+sBcXHUC3fPkfsnr8cw82t5pBVZRgtrCZnAG+dVesbbCOC3voDYU+OWJ+J11han
         wa/TAXWRnvSCa65VAv1nzuekBCoRPpyP1Glj5/D2n/nFUxbRiBRJt7ukywt6vhvlXkzh
         PvWVFv9Il1fNToAqlLiarIsZGCgs+gKXrcx3p0KhGlu6QRNgXip+hSZDc/2hE/zB4Jrk
         +EXw==
X-Forwarded-Encrypted: i=1; AJvYcCUGmYWHC0C0WXhhNR5022Zzy5ZgpW/C/ci90Srx44RJcssemVUJToC3t600fzuKIdWMKTRQb2No0S2aUU9kAG7aV/wB76yn0GANSLIRSPyETyr3E1JyeuEqNH9k
X-Gm-Message-State: AOJu0Yw5fcu6Jf/89b6qEO4e2pF6UCV5XfjH5NcVlExuUp9h8Cs2S3ZI
	B+lJHSe3Z+aFvosDTv2bemESeDuMsXalI9rX8rUKhSlCFo1tCcV6BNQvXp4EBuuY6mQ1cEkSr1n
	iva8q32VjLUQF435JOvdu1RoOiVA=
X-Google-Smtp-Source: AGHT+IFhLiK3X0a3yL5OOWhAyRj8u8tg4f3vATvtHGYUpZg6l+/KlSGINK05rnC6fUCg/DSoXtqhbyRfGX4U3KeUr5Q=
X-Received: by 2002:a05:6102:3713:b0:493:df26:f9c5 with SMTP id
 ada2fe7eead31-493faa0ebcemr3040968137.11.1722206331132; Sun, 28 Jul 2024
 15:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711113828.3818398-1-xukuohai@huaweicloud.com>
 <20240711113828.3818398-4-xukuohai@huaweicloud.com> <phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bqw6cjk2x7rt5@m2hl6enudv7d>
 <4ff2c89e-0afc-4b17-a86b-7e4971e7df5b@huaweicloud.com> <ykuhustu7vt2ilwhl32kj655xfdgdlm2xkl5rff6tw2ycksovp@ss2n4gpjysnw>
In-Reply-To: <ykuhustu7vt2ilwhl32kj655xfdgdlm2xkl5rff6tw2ycksovp@ss2n4gpjysnw>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Sun, 28 Jul 2024 18:38:40 -0400
Message-ID: <CAM=Ch06Hps=xv4RmHdWESOjN1pSW2Eo8Xn=qQV+0T9TeNzuPHw@mail.gmail.com>
Subject: Re: [RFC bpf-next] bpf, verifier: improve signed ranges inference for BPF_AND
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, Matan Shachnai <m.shachnai@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 10:52=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> This commit teach the BPF verifier how to infer signed ranges directly
> from signed ranges of the operands to prevent verifier rejection, which
> is needed for the following BPF program's no-alu32 version, as shown by
> Xu Kuohai:
>
>     SEC("lsm/bpf_map")
>     int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
>     {
>          if (map !=3D (struct bpf_map *)&data_input)
>             return 0;
>
>          if (fmode & FMODE_WRITE)
>             return -EACCES;
>
>          return 0;
>     }
>
> Where the relevant verifer log upon rejection are:
>
>     ...
>     5: (79) r0 =3D *(u64 *)(r1 +8)          ; R0_w=3Dscalar() R1=3Dctx()
>     ; if (fmode & FMODE_WRITE) @ test_libbpf_get_fd_by_id_opts.c:32
>     6: (67) r0 <<=3D 62                     ; R0_w=3Dscalar(smax=3D0x4000=
000000000000,umax=3D0xc000000000000000,smin32=3D0,smax32=3Dumax32=3D0,var_o=
ff=3D(0x0; 0xc000000000000000))
>     7: (c7) r0 s>>=3D 63                    ; R0_w=3Dscalar(smin=3Dsmin32=
=3D-1,smax=3Dsmax32=3D0)
>     ;  @ test_libbpf_get_fd_by_id_opts.c:0
>     8: (57) r0 &=3D -13                     ; R0_w=3Dscalar(smax=3D0x7fff=
fffffffffff3,umax=3D0xfffffffffffffff3,smax32=3D0x7ffffff3,umax32=3D0xfffff=
ff3,var_off=3D(0x0; 0xfffffffffffffff3))
>     9: (95) exit
>
> This sequence of instructions comes from Clang's transformation located
> in DAGCombiner::SimplifySelectCC() method, which combined the "fmode &
> FMODE_WRITE" check with the return statement without needing BPF_JMP at
> all. See Eduard's comment for more detail of this transformation[0].
>
> While the verifier can correctly infer that the value of r0 is in a
> tight [-1, 0] range after instruction "r0 s>>=3D 63", is was not able to
> come up with a tight range for "r0 &=3D -13" (which would be [-13, 0]),
> and instead inferred a very loose range:
>
>     r0 s>>=3D 63; R0_w=3Dscalar(smin=3Dsmin32=3D-1,smax=3Dsmax32=3D0)
>     r0 &=3D -13 ; R0_w=3Dscalar(smax=3D0x7ffffffffffffff3,umax=3D0xffffff=
fffffffff3,smax32=3D0x7ffffff3,umax32=3D0xfffffff3,var_off=3D(0x0; 0xffffff=
fffffffff3))
>
> The reason is that scalar*_min_max_add() mainly relies on tnum for
> interring value in register after BPF_AND, however [-1, 0] cannot be
> tracked precisely with tnum, and effectively turns into [0, -1] (i.e.
> tnum_unknown). So upon BPF_AND the resulting tnum is equivalent to
>
>     dst_reg->var_off =3D tnum_and(tnum_unknown, tnum_const(-13))
>
> And from there the BPF verifier was only able to infer smin=3DS64_MIN,
> smax=3D0x7ffffffffffffff3, which is outside of the expected [-4095, 0]
> range for return values, and thus the program was rejected.
>
> To allow verification of such instruction pattern, update
> scalar*_min_max_and() to infer signed ranges directly from signed ranges
> of the operands. With BPF_AND, the resulting value always gains more
> unset '0' bit, thus it only move towards 0x0000000000000000. The
> difficulty lies with how to deal with signs. While non-negative
> (positive and zero) value simply grows smaller, a negative number can
> grows smaller, but may also underflow and become a larger value.
>
> To better address this situation we split the signed ranges into
> negative range and non-negative range cases, ignoring the mixed sign
> cases for now; and only consider how to calculate smax_value.
>
> Since negative range & negative range preserve the sign bit, so we know
> the result is still a negative value, thus it only move towards S64_MIN,
> but never underflow, thus a save bet is to use a value in ranges that is
> closet to 0, thus "max(dst_reg->smax_value, src->smax_value)". For
> negative range & positive range the sign bit is always cleared, thus we
> know the resulting is a non-negative, and only moves towards 0, so a
> safe bet is to use smax_value of the non-negative range. Last but not
> least, non-negative range & non-negative range is still a non-negative
> value, and only moves towards 0; however same as the unsigned range
> case, the maximum is actually capped by the lesser of the two, and thus
> min(dst_reg->smax_value, src_reg->smax_value);
>
> Listing out the above reasoning as a table (dst_reg abbreviated as dst,
> src_reg abbreviated as src, smax_value abbrivated as smax) we get:
>
>                         |                         src_reg
>        smax =3D ?         +---------------------------+------------------=
---------
>                         |        negative           |       non-negative
> ---------+--------------+---------------------------+--------------------=
-------
>          | negative     | max(dst->smax, src->smax) |         src->smax
> dst_reg  +--------------+---------------------------+--------------------=
-------
>          | non-negative |         dst->smax         | min(dst->smax, src-=
>smax)
>
> However this is quite complicated, luckily it can be simplified given
> the following observations
>
>     max(dst_reg->smax_value, src_reg->smax_value) >=3D src_reg->smax_valu=
e
>     max(dst_reg->smax_value, src_reg->smax_value) >=3D dst_reg->smax_valu=
e
>     max(dst_reg->smax_value, src_reg->smax_value) >=3D min(dst_reg->smax_=
value, src_reg->smax_value)
>
> So we could substitute the cells in the table above all with max(...),
> and arrive at:
>
>                         |                         src_reg
>       smax' =3D ?         +---------------------------+------------------=
---------
>                         |        negative           |       non-negative
> ---------+--------------+---------------------------+--------------------=
-------
>          | negative     | max(dst->smax, src->smax) | max(dst->smax, src-=
>smax)
> dst_reg  +--------------+---------------------------+--------------------=
-------
>          | non-negative | max(dst->smax, src->smax) | max(dst->smax, src-=
>smax)
>
> Meaning that simply using
>
>   max(dst_reg->smax_value, src_reg->smax_value)
>
> to calculate the resulting smax_value would work across all sign combinat=
ions.
>
>
> For smin_value, we know that both non-negative range & non-negative
> range and negative range & non-negative range both result in a
> non-negative value, so an easy guess is to use the minimum non-negative
> value, thus 0.
>
>                         |                         src_reg
>        smin =3D ?         +----------------------------+-----------------=
----------
>                         |          negative          |       non-negative
> ---------+--------------+----------------------------+-------------------=
--------
>          | negative     |             ?              |             0
> dst_reg  +--------------+----------------------------+-------------------=
--------
>          | non-negative |             0              |             0
>
> This leave the negative range & negative range case to be considered. We
> know that negative range & negative range always yield a negative value,
> so a preliminary guess would be S64_MIN. However, that guess is too
> imprecise to help with the r0 <<=3D 62, r0 s>>=3D 63, r0 &=3D -13 pattern
> we're trying to deal with here.
>
> This can be further improve with the observation that for negative range
> & negative range, the smallest possible value must be one that has
> longest _common_ most-significant set '1' bits sequence, thus we can use
> min(dst_reg->smin_value, src->smin_value) as the starting point, as the
> smaller value will be the one with the shorter most-significant set '1'
> bits sequence. But that alone is not enough, as we do not know whether
> rest of the bits would be set, so the safest guess would be one that
> clear alls bits after the most-significant set '1' bits sequence,
> something akin to bit_floor(), but for rounding to a negative power-of-2
> instead.
>
>     negative_bit_floor(0xffff000000000003) =3D=3D 0xffff000000000000
>     negative_bit_floor(0xf0ff0000ffff0000) =3D=3D 0xf000000000000000
>     negative_bit_floor(0xfffffb0000000000) =3D=3D 0xfffff80000000000
>
> With negative range & negative range solve, we now have:
>
>                         |                         src_reg
>        smin =3D ?         +----------------------------+-----------------=
----------
>                         |        negative            |       non-negative
> ---------+--------------+----------------------------+-------------------=
--------
>          |   negative   |negative_bit_floor(         |             0
>          |              |  min(dst->smin, src->smin))|
> dst_reg  +--------------+----------------------------+-------------------=
--------
>          | non-negative |           0                |             0
>
> This can be further simplied since min(dst->smin, src->smin) < 0 when bot=
h
> dst_reg and src_reg have a negative range. Which means using
>
>     negative_bit_floor(min(dst_reg->smin_value, src_reg->smin_value)
>
> to calculate the resulting smin_value would work across all sign combinat=
ions.
>
> Together these allows us to infer the signed range of the result of BPF_A=
ND
> operation using the signed range from its operands.
>
> [0] https://lore.kernel.org/bpf/e62e2971301ca7f2e9eb74fc500c520285cad8f5.=
camel@gmail.com/
>
> Link: https://lore.kernel.org/bpf/phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bq=
w6cjk2x7rt5@m2hl6enudv7d/
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>  kernel/bpf/verifier.c | 62 +++++++++++++++++++++++++++++--------------
>  1 file changed, 42 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8da132a1ef28..6d4cdf30cd76 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13466,6 +13466,39 @@ static void scalar_min_max_mul(struct bpf_reg_st=
ate *dst_reg,
>         }
>  }
>
> +/* Clears all trailing bits after the most significant unset bit.
> + *
> + * Used for estimating the minimum possible value after BPF_AND. This
> + * effectively rounds a negative value down to a negative power-of-2 val=
ue
> + * (except for -1, which just return -1) and returning 0 for non-negativ=
e
> + * values. E.g. masked32_negative(0xff0ff0ff) =3D=3D 0xff000000.
> + */
> +static inline s32 negative32_bit_floor(s32 v)
> +{
> +       /* XXX: per C standard section 6.5.7 right shift of signed negati=
ve
> +        * value is implementation-defined. Should unsigned type be used =
here
> +        * instead?
> +        */
> +       v &=3D v >> 1;
> +       v &=3D v >> 2;
> +       v &=3D v >> 4;
> +       v &=3D v >> 8;
> +       v &=3D v >> 16;
> +       return v;
> +}
> +
> +/* Same as negative32_bit_floor() above, but for 64-bit signed value */
> +static inline s64 negative_bit_floor(s64 v)
> +{
> +       v &=3D v >> 1;
> +       v &=3D v >> 2;
> +       v &=3D v >> 4;
> +       v &=3D v >> 8;
> +       v &=3D v >> 16;
> +       v &=3D v >> 32;
> +       return v;
> +}
> +
>  static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
>                                  struct bpf_reg_state *src_reg)
>  {
> @@ -13485,16 +13518,10 @@ static void scalar32_min_max_and(struct bpf_reg=
_state *dst_reg,
>         dst_reg->u32_min_value =3D var32_off.value;
>         dst_reg->u32_max_value =3D min(dst_reg->u32_max_value, umax_val);
>
> -       /* Safe to set s32 bounds by casting u32 result into s32 when u32
> -        * doesn't cross sign boundary. Otherwise set s32 bounds to unbou=
nded.
> -        */
> -       if ((s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_max_value)=
 {
> -               dst_reg->s32_min_value =3D dst_reg->u32_min_value;
> -               dst_reg->s32_max_value =3D dst_reg->u32_max_value;
> -       } else {
> -               dst_reg->s32_min_value =3D S32_MIN;
> -               dst_reg->s32_max_value =3D S32_MAX;
> -       }
> +       /* Rough estimate tuned for [-1, 0] & -CONSTANT cases. */
> +       dst_reg->s32_min_value =3D negative32_bit_floor(min(dst_reg->s32_=
min_value,
> +                                                         src_reg->s32_mi=
n_value));
> +       dst_reg->s32_max_value =3D max(dst_reg->s32_max_value, src_reg->s=
32_max_value);
>  }
>
>  static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
> @@ -13515,16 +13542,11 @@ static void scalar_min_max_and(struct bpf_reg_s=
tate *dst_reg,
>         dst_reg->umin_value =3D dst_reg->var_off.value;
>         dst_reg->umax_value =3D min(dst_reg->umax_value, umax_val);
>
> -       /* Safe to set s64 bounds by casting u64 result into s64 when u64
> -        * doesn't cross sign boundary. Otherwise set s64 bounds to unbou=
nded.
> -        */
> -       if ((s64)dst_reg->umin_value <=3D (s64)dst_reg->umax_value) {
> -               dst_reg->smin_value =3D dst_reg->umin_value;
> -               dst_reg->smax_value =3D dst_reg->umax_value;
> -       } else {
> -               dst_reg->smin_value =3D S64_MIN;
> -               dst_reg->smax_value =3D S64_MAX;
> -       }
> +       /* Rough estimate tuned for [-1, 0] & -CONSTANT cases. */
> +       dst_reg->smin_value =3D negative_bit_floor(min(dst_reg->smin_valu=
e,
> +                                                    src_reg->smin_value)=
);
> +       dst_reg->smax_value =3D max(dst_reg->smax_value, src_reg->smax_va=
lue);
> +
>         /* We may learn something more from the var_off */
>         __update_reg_bounds(dst_reg);
>  }
> --
> 2.45.2
>

Apologies for the late response and thank you for CCing us Shung-Hsi.

The patch itself seems well thought out and looks correct. Great work!

We quickly checked your patch using Agni [1], and were not able to find any
violations. That is, given well-formed register state inputs to
adjust_scalar_min_max_vals, the new algorithm always produces sound outputs
for the BPF_AND (both 32/64) instruction.

It looks like you already performed tests with Z3, and Eduard performed a
brute force testing using 6-bit integers. Agni's result stands as an
additional stronger guarantee because Agni generates SMT formulas directly
from the C source code of the verifier and checks the correctness in Z3
without any external library functions, it uses full 64-bit size bitvectors
in the formulas generated and considers the correctness for 64-bit integer
inputs, and finally it considers the correctness of the *final* output
abstract values generated after running update_reg_bounds() and
reg_bounds_sync().

Using Agni's encodings we were also quickly able to check the precision of
the new algorithm. An algorithm is more precise if it produces tighter
range bounds, while being correct. We are happy to note that the new
algorithm produces outputs that are at least as precise or more precise
than the old algorithm, for all well-formed register state inputs.

Best,
Hari

[1] https://github.com/bpfverif/agni

