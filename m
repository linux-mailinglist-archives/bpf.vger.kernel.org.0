Return-Path: <bpf+bounces-34603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4262692F1CB
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 00:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48392835DF
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 22:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D63719FA62;
	Thu, 11 Jul 2024 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5d19EFO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E5F157489
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720736415; cv=none; b=HtRVLhoobR9cd7T3H/bi7uu/FT8OG5PzRGZsTTk6oEyELF3YszAOFvTG6rz8Uvck2JODSKuVFhoU38dawhxigQs3I78qjN8IZVpe0EIdIACZU5eQOc9xNUqGqQCwWUUeHC9aEiPvGmPo19tPfDamPz+vW4PhiDEDwLb6muRzTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720736415; c=relaxed/simple;
	bh=1wyeVO29KjHy8rfyUFnKL3P7RhjWtzml+CwAtqg7wa0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ubbH8VsbbyZTT3Vl/7Lg/7z7Qj9bwlC/AE8wMyjG2TIvxbXhLLAMO1UrzW0r8BA6V16v34BtG957/o/S2c3QWooV0J+4/TYU5TGmGo3QNEUX3oRmf+CIRQEMfVjAE+WGvhHk4qfIjCVByIB2G1mwXhF6GylEYOMpm95WMQZMc04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5d19EFO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb3b7d0d56so8719085ad.1
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 15:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720736413; x=1721341213; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1O6buAXniUWY4baMl8G3TXa0w1oDOQLWuHhMXYYrTYg=;
        b=W5d19EFOJ+E2ePVZz3PHArZeE2sTrIF6wF7PpNGXqmVLwhkipNkOGVY8MTIuH0kHAR
         3JcR8Pv0CwWG0D6HNkpZXcPtZNZNk0wrUP9TLRQ0NSMBK/oUxzal0mD1BSGhUi33otJ4
         Pkm9p4SWL3uOGL3rWdkasvRIaWHvZzBE8VU48gD2bm3VFDWwX3qPhgOtp4jo1zq/N4tm
         LtpNeWApbNGKJLagUhej50DyYKRdYyGfru+In8Vn/GOnKQSh31U7qLBGT00S+FX/zDrn
         UmX/HB7PkzTqljOiImMi2LN1FHGFv2IWzTvI4GDdq5rEqPgvQ3DAmzhRPmlAJ9j1ubuw
         ieiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720736413; x=1721341213;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1O6buAXniUWY4baMl8G3TXa0w1oDOQLWuHhMXYYrTYg=;
        b=ct+IHi1wArlmkARPMz+aABhSXBQ+G3b4cpxL+Tl54fxZQMXdwl+sIytar1UbC9Ed7H
         jbb3PVQjNxtIiRkTAkWje2Jf6ROFJAIVD7r1X9wri3aJ3oRJ1W3OYy04JMtkDeErw3tG
         FSkfZfLXryO4ij5xM3Z6qCrKiMZkwEW8GOgaEmrTMcp8zNYTj87eigpj+1L3ieJuFPuB
         2Mnn5/7LgeJPIUq7BLQj9wYLDo45cHN609Mw4vOJN/UdJuldNAwwOvULB0inl9OdaK1s
         Xlv5JP1hUS7jFqFc9MqzrL2S8W4vL8XCyxHColgsQC8hXRsxZIbYRf9qm7h7fkLBJDPZ
         bXfg==
X-Forwarded-Encrypted: i=1; AJvYcCVnkfWx/Ao/iAnE+UjH/GOo/wKNFYr0J/Zwn65gg+ylEbvvQDAr26/x8BmYnIKYfj7kfQs9pPuRXRVuIzLWOARKTigf
X-Gm-Message-State: AOJu0Yzlv/IXmmbgZHgKCyVCgSl3KAilQcDnv28Sas28/UCXVNg4PT37
	xiBXQgBjgvnlygvWpc1dimp3K1I4D5fusySWPc6SoEVgKgB2HyHN
X-Google-Smtp-Source: AGHT+IFQbLdrX4jf7Hu06rUH/wZKde3OUKVfAKzqcBTYa1ZEVovZ1Gv2iUjOSpxzYlG8ms/sJNHuWQ==
X-Received: by 2002:a17:902:f68b:b0:1fb:6473:e91f with SMTP id d9443c01a7336-1fbb6d5b551mr95368265ad.40.1720736413288;
        Thu, 11 Jul 2024 15:20:13 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2b2b0sm55364615ad.84.2024.07.11.15.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 15:20:12 -0700 (PDT)
Message-ID: <de03d550a466ef98d4adec4778cdfd12bb247ac3.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Get better reg range with ldsx and
 32bit compare
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Thu, 11 Jul 2024 15:20:07 -0700
In-Reply-To: <20240710042915.1211933-1-yonghong.song@linux.dev>
References: <20240710042915.1211933-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-09 at 21:29 -0700, Yonghong Song wrote:

[...]

>   14: (81) r1 =3D *(s32 *)(r0 +0)         ; R0=3Drdonly_mem(id=3D3,ref_ob=
j_id=3D2,sz=3D4) R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7fffffff)=
 refs=3D2
>   15: (ae) if w1 < w6 goto pc+4 20: R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2=
,sz=3D4) R1=3Dscalar(smin=3D0xffffffff80000000,smax=3Dsmax32=3Dumax32=3D31,=
umax=3D0xffffffff0000001f,smin32=3D0,var_off=3D(0x0; 0xffffffff0000001f)) R=
6=3Dscalar(id=3D1,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=3Dumax=3Dsmax32=3D=
umax32=3D32,var_off=3D(0x0; 0x3f)) R7=3D0 R8=3Dfp-8 R10=3Dfp0 fp-8=3Diter_n=
um(ref_id=3D2,state=3Dactive,depth=3D1) refs=3D2

[...]

> The insn #14 is a sign-extenstion load which is related to 'int i'.
> The insn #15 did a subreg comparision. Note that smin=3D0xffffffff8000000=
0 and this caused later
> insn #23 failed verification due to unbounded min value.
>=20
> Actually insn #15 R1 smin range can be better. Before insn #15, we have
>   R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7fffffff)
> With the above range, we know for R1, upper 32bit can only be 0xffffffff =
or 0.
> Otherwise, the value range for R1 could be beyond [smin=3D0xffffffff80000=
000,smax=3D0x7fffffff].
>=20
> After insn #15, for the true patch, we know smin32=3D0 and smax32=3D32. W=
ith the upper 32bit 0xffffffff,
> then the corresponding value is [0xffffffff00000000, 0xffffffff00000020].=
 The range is
> obviously beyond the original range [smin=3D0xffffffff80000000,smax=3D0x7=
fffffff] and the
> range is not possible. So the upper 32bit must be 0, which implies smin =
=3D smin32 and
> smax =3D smax32.
>=20
> This patch fixed the issue by adding additional register deduction after =
32-bit compare
> insn such that if the signed 32-bit register range is non-negative and 64=
-bit smin is
> {S32/S16/S8}_MIN and 64-bit max is no greater than {U32/U16/U8}_MAX.
> Here, we check smin with {S32/S16/S8}_MIN since this is the most common r=
esult related to
> signed extension load.

[...]

> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/verifier.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c0263fb5ca4b..3fc557f99b24 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2182,6 +2182,21 @@ static void __reg_deduce_mixed_bounds(struct bpf_r=
eg_state *reg)
>  		reg->smin_value =3D max_t(s64, reg->smin_value, new_smin);
>  		reg->smax_value =3D min_t(s64, reg->smax_value, new_smax);
>  	}
> +
> +	/* if s32 range is non-negative and s64 range is in [S32/S16/S8_MIN, <=
=3D S32/S16/S8_MAX],
> +	 * the s64/u64 range can be refined.
> +	 */

Hi Yonghong,

Sorry for delayed response, nice patch, it finally clicked for me.
I'd suggest a slightly different comment, maybe it's just me being
slow, but it took a while to understand why is this correct.
How about a text like below:

  Here we would like to handle a special case after sign extending load,
  when upper bits for a 64-bit range are all 1s or all 0s.

  Upper bits are all 1s when register is in a rage:
    [0xffff_ffff_0000_0000, 0xffff_ffff_ffff_ffff]
  Upper bits are all 0s when register is in a range:
    [0x0000_0000_0000_0000, 0x0000_0000_ffff_ffff]
  Together this forms are continuous range:
    [0xffff_ffff_0000_0000, 0x0000_0000_ffff_ffff]

  Now, suppose that register range is in fact tighter:
    [0xffff_ffff_8000_0000, 0x0000_0000_ffff_ffff] (R)
  Also suppose that it's 32-bit range is positive,
  meaning that lower 32-bits of the full 64-bit register
  are in the range:
    [0x0000_0000, 0x7fff_ffff] (W)

  It so happens, that any value in a range:
    [0xffff_ffff_0000_0000, 0xffff_ffff_7fff_ffff]
  is smaller than a lowest bound of the range (R):
     0xffff_ffff_8000_0000
  which means that upper bits of the full 64-bit register
  can't be all 1s, when lower bits are in range (W).

  Note that:
  - 0xffff_ffff_8000_0000 =3D=3D (s64)S32_MIN
  - 0x0000_0000_ffff_ffff =3D=3D (s64)S32_MAX
  These relations are used in the conditions below.

> +	if (reg->s32_min_value >=3D 0) {
> +		if ((reg->smin_value =3D=3D S32_MIN && reg->smax_value <=3D S32_MAX) |=
|
> +		    (reg->smin_value =3D=3D S16_MIN && reg->smax_value <=3D S16_MAX) |=
|
> +		    (reg->smin_value =3D=3D S8_MIN && reg->smax_value <=3D S8_MAX)) {

The explanation above also lands a question, would it be correct to
replace the checks above by a single one?

  reg->smin_value >=3D S32_MIN && reg->smax_value <=3D S32_MAX

> +			reg->smin_value =3D reg->umin_value =3D reg->s32_min_value;
> +			reg->smax_value =3D reg->umax_value =3D reg->s32_max_value;
> +			reg->var_off =3D tnum_intersect(reg->var_off,
> +						      tnum_range(reg->smin_value,
> +								 reg->smax_value));
> +		}
> +	}
>  }
> =20
>  static void __reg_deduce_bounds(struct bpf_reg_state *reg)


