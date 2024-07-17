Return-Path: <bpf+bounces-34966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA32C9343A9
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 23:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 308E8B2206A
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 21:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3535184124;
	Wed, 17 Jul 2024 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NegKewE+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70A82262B;
	Wed, 17 Jul 2024 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250644; cv=none; b=ESXj8rcqRRysSTlM5miMCpo/NK0ch/CTP9bb+T74EAoJvIWDyVWnHPJ90V2QQcBIcBkyulAl/1B8zzyvmffOI3tUE8PEnNFY/f7QcpnwGG3xRaP7ExLu5zSW/j0xfn+BlwMdeVNnnOv2iqhI4RKDtDWplDoNsQV+qlE6z/GWfs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250644; c=relaxed/simple;
	bh=7tQLJ3SnvNr6fvJQrl9SraDKPihByP2d1Vz5fBfWkwQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lTHa6omMw7VgGGMH/XHAYaVu0W7K0ry3BRX5aqWNn1cGO86cxqkP6qnaA6VykbIFDD1wYVJUixHebhun4amZVTDnYYC+4GOscsKNRLD/WAervj+JZ1Ks4beQdT2efJeQUqOEHQeliqX44JF06ZDxfTErPebQvnY5AbMiRtsHm5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NegKewE+; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5c697fc4aa2so34875eaf.2;
        Wed, 17 Jul 2024 14:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721250642; x=1721855442; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3L6bVz8sLrVXeSGyDXS7cltHthZHygLETgH0CtOzY2M=;
        b=NegKewE+1vKkKeQbasDhV4nduDh/m+nMbmzYhgG/XWXjIAqZuu8xorTfPFLWt4AWzE
         D/fwV81ORoAK/X1MHpcqTtCup8hPbmYoR1QIpkEi7hOZMUulakKQws1MgnZ58mFt8CYg
         2toIbQUUvdBNhCi0UrkTkLEdYc1Yh4FwR5OMGRMsjEeKGKwkFXFuPfecva+N3BEMp1eK
         viLAIW9y1iIVZHokVV3Z6trsY/vhZ2FDbyzOX/dEPS6sB90RGAhipuIOzf2YPTMEWd6v
         jCpmvKIBjCdpbFpKCu7o8vYHykzw/volgbUO4ALvWkyo++2254Xa2somDvet1BrEt+Fz
         OS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250642; x=1721855442;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3L6bVz8sLrVXeSGyDXS7cltHthZHygLETgH0CtOzY2M=;
        b=o9MnzFhOAw5BRB6fjWSgA3yUML0E69rHdsc8a0YIawPehN5MtOy8EWVfw6Q301u3E2
         YWyt/VqBVrQWQdr8QVTbsj0TanoOR+wckGphNNvFzzF07UGiS7wdXV9B0ZzlHlJGvQCu
         jsIrTZ1B10ZtJ5Z2+UWt2I9yrTAnrSdBTzY8nFKh0OVMcAiQBBgOLOo06F7lGd+3S+8o
         rz1rXOdJpAqo5m0mdWw3DqmXWHvBE02lQaSrm/7iOx+5e3pIVYGgYNsvEcv/HVJWzajc
         WtospOiMX5n55K2gxdmj/URTGkt7tI3lnadD8YDGRWHXrCsq4Z/6vDTNNUysi2rJM2kV
         2gSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrguRx4mpkGSIzvDROLyUSJL2Of9j6xtZ6cnD3fVnBM8QUz9zXPgZ8jFAB4P5ycDpCpdFNsthKjD1Z5+TZDZ2NuVwDiFm4
X-Gm-Message-State: AOJu0Ywhok+2y+nLj9Dcy23e/yJpl1RJvwLATrktritFyN7qd/UJTSBR
	OIKG3vYmUriO/YdClaQwFsF6U8xM4E7CJeCUV08D2rMCOrnQ6c/W
X-Google-Smtp-Source: AGHT+IHn+fXfkwU9w6UQtC/X8ZGF1y/mCIg36J7iSyWQw6E/NtL72D5pq3zGZpOIoaPqV5DPQJ3KUg==
X-Received: by 2002:a05:6870:7b49:b0:25e:86b:59ec with SMTP id 586e51a60fabf-260ee123126mr763793fac.0.1721250641757;
        Wed, 17 Jul 2024 14:10:41 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7d963sm8577756b3a.130.2024.07.17.14.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:10:41 -0700 (PDT)
Message-ID: <be239a5581e5b7d5c6f310c2a4c11282aa5896b5.camel@gmail.com>
Subject: Re: [RFC bpf-next] bpf, verifier: improve signed ranges inference
 for BPF_AND
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Xu Kuohai
 <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Roberto Sassu <roberto.sassu@huawei.com>, Edward Cree
 <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Harishankar Vishwanathan
 <harishankar.vishwanathan@gmail.com>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>,  Srinivas Narayana
 <srinivas.narayana@rutgers.edu>, Matan Shachnai <m.shachnai@rutgers.edu>
Date: Wed, 17 Jul 2024 14:10:35 -0700
In-Reply-To: <ykuhustu7vt2ilwhl32kj655xfdgdlm2xkl5rff6tw2ycksovp@ss2n4gpjysnw>
References: <20240711113828.3818398-1-xukuohai@huaweicloud.com>
	 <20240711113828.3818398-4-xukuohai@huaweicloud.com>
	 <phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bqw6cjk2x7rt5@m2hl6enudv7d>
	 <4ff2c89e-0afc-4b17-a86b-7e4971e7df5b@huaweicloud.com>
	 <ykuhustu7vt2ilwhl32kj655xfdgdlm2xkl5rff6tw2ycksovp@ss2n4gpjysnw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-16 at 22:52 +0800, Shung-Hsi Yu wrote:

[...]

> To allow verification of such instruction pattern, update
> scalar*_min_max_and() to infer signed ranges directly from signed ranges
> of the operands. With BPF_AND, the resulting value always gains more
> unset '0' bit, thus it only move towards 0x0000000000000000. The
> difficulty lies with how to deal with signs. While non-negative
> (positive and zero) value simply grows smaller, a negative number can
> grows smaller, but may also underflow and become a larger value.
>=20
> To better address this situation we split the signed ranges into
> negative range and non-negative range cases, ignoring the mixed sign
> cases for now; and only consider how to calculate smax_value.
>=20
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
>=20
> Listing out the above reasoning as a table (dst_reg abbreviated as dst,
> src_reg abbreviated as src, smax_value abbrivated as smax) we get:
>=20
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
>=20
> However this is quite complicated, luckily it can be simplified given
> the following observations
>=20
>     max(dst_reg->smax_value, src_reg->smax_value) >=3D src_reg->smax_valu=
e
>     max(dst_reg->smax_value, src_reg->smax_value) >=3D dst_reg->smax_valu=
e
>     max(dst_reg->smax_value, src_reg->smax_value) >=3D min(dst_reg->smax_=
value, src_reg->smax_value)
>=20
> So we could substitute the cells in the table above all with max(...),
> and arrive at:
>=20
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
>=20
> Meaning that simply using
>=20
>   max(dst_reg->smax_value, src_reg->smax_value)
>=20
> to calculate the resulting smax_value would work across all sign combinat=
ions.
>=20
>=20
> For smin_value, we know that both non-negative range & non-negative
> range and negative range & non-negative range both result in a
> non-negative value, so an easy guess is to use the minimum non-negative
> value, thus 0.
>=20
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
>=20
> This leave the negative range & negative range case to be considered. We
> know that negative range & negative range always yield a negative value,
> so a preliminary guess would be S64_MIN. However, that guess is too
> imprecise to help with the r0 <<=3D 62, r0 s>>=3D 63, r0 &=3D -13 pattern
> we're trying to deal with here.
>=20
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
>=20
>     negative_bit_floor(0xffff000000000003) =3D=3D 0xffff000000000000
>     negative_bit_floor(0xf0ff0000ffff0000) =3D=3D 0xf000000000000000
>     negative_bit_floor(0xfffffb0000000000) =3D=3D 0xfffff80000000000
>=20
> With negative range & negative range solve, we now have:
>=20
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
>=20
> This can be further simplied since min(dst->smin, src->smin) < 0 when bot=
h
> dst_reg and src_reg have a negative range. Which means using
>=20
>     negative_bit_floor(min(dst_reg->smin_value, src_reg->smin_value)
>=20
> to calculate the resulting smin_value would work across all sign combinat=
ions.
>=20
> Together these allows us to infer the signed range of the result of BPF_A=
ND
> operation using the signed range from its operands.


Hi Shung-Hsi,

This seems quite elegant.
As an additional check, I did a simple brute-force for all possible
ranges of 6-bit integers and bounds are computed safely.

[...]

