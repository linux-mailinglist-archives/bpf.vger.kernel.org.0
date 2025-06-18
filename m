Return-Path: <bpf+bounces-60998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAEBADF818
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 22:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCBE17E2C6
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 20:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1262621D3DC;
	Wed, 18 Jun 2025 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC9OSZ/k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CEB1B78F3;
	Wed, 18 Jun 2025 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280041; cv=none; b=XHsC+ag/OziD7T8axSBdBpA0DRLfkLSgo+oHzJBJXpmIyfDr3d3wXKU5b3LMIngnQ7/XZoSVlGG6shX6m3Hpzm/WF4Pv9qa5wCNbSo9RO4W61OIMqpFovPNe/PH9LCb3dt5j3eEnprpB+h+BcyTx6Lkhq9CtVZUMutxh1QK2O2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280041; c=relaxed/simple;
	bh=gOBEu0owOjNUHUDsjIYfOnYi7HEIw5Ru6SOhY+uVNR4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M28iZvm5pvgt0ChsMm+0bHTZCdW5h8BN1bKJGTw7qYXiwtEybqy+TLQGlR23GlM0vBRQ5SFj2DdVrFG5zC5fomVBaAhDFH4K4cG1NgW0j45b9h+Qr8TTzErqycwmHpTo9vwYvNhNBVkEokZexf8/8G744eACAhzRfFC1/t0Q4u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mC9OSZ/k; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234bfe37cccso2347845ad.0;
        Wed, 18 Jun 2025 13:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750280039; x=1750884839; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yneCXip3zq3daJc5WpbKw9LJ/ijlzmPle+nf8zBnMkw=;
        b=mC9OSZ/krh+pN0HK2VaLwizc3w/G+M/UHPapV7MU5PRBGHyZP7Y58unpE2feBJWGZT
         uNNdvoMpdOm7qNhjvE2XfbR1bV3SlW4KwvKLleSPafqbZtzIZnDYKLN3ylCskewfjl4F
         EDnF4wTLxy8TgEkcaqMyhsiG2tKrpaSWsFeFopOKTcgmy1BgrxzjMTaTK3d1G2gZnxy7
         qeFylZf8/SjYeqyM67AZY51LPY2hA0+78EF6085QEoGSD9o2phBmidiT7Y1CYe2hHXwX
         BKZzFKXgIfNq+8W6/Y4KQr/gF3cUF4Oy3ncwGrv+DryDDSd/gNYyKGMfVBc5ZjJesNlP
         9Eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750280039; x=1750884839;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yneCXip3zq3daJc5WpbKw9LJ/ijlzmPle+nf8zBnMkw=;
        b=VnIbnegovVrF63ZE0IuyVtoymcZ2irSdRt115nPBEykrHXXLCRkdqbNxZLFPkC2UpU
         w7eT1yWWUVf9w4jFOlzO3m62P0/KTDxpf0rpwCItIskNjfEBX8mktYY6CXjZSE1b9+e6
         PYwP77Sts2is22UoMbJY0l26yx4FHagks92bgzD9dxLMHTXE5SS+dXDsIO7njgCQ1jFH
         CzdQiHvPJalFE8u7ZlK6kJSQIlV0srn6NKDkA2uQgNguJPtnz814NQATEu/w0aqgAjjF
         uZbNIZKo832PgTdz6ZbasegLZ2pZhD9JcuxkW5YsmXDR/8XMwNhbF9Hv3yPOl30BlRv3
         9jew==
X-Forwarded-Encrypted: i=1; AJvYcCU7L5JkNnS7AFE23mnfKwpZYU9W0MSLlg6fuGU2Faj+DcbcW2k78djDS9hhKHK4Tm97iqs=@vger.kernel.org, AJvYcCVg1cb99qHk2d1KnbLVSla+gUzttu2bsZZGCHBlDUuM3GEZpZlFrpBNP78mId5AK7bUUETrjNpnBGVdnbvN@vger.kernel.org
X-Gm-Message-State: AOJu0YyxbOVbDek2hFbyvW/ECYgtWvir96joROzsLowEiLhOAnIi5S1V
	5zE2HUBfI29epyEXYvgcN3rQ+ioof6UDABOU6Ri+t8mpcZaI5U1rV3/H
X-Gm-Gg: ASbGncvuIxstHEwRkmAa9baWqqLDJ/XW+2sX2CPPmS7PlrcaBdNiSd6aOZ91PJySYTy
	Vbotq2QLZn2FhGGx3czSS1U+er/OuitxPatBGPSAFZTU8pUyY/uT7OEuQmPokLKaP11pkeCABll
	mWk64Kbsq8YPvLY1TGPaGEQuOAM4ni4Q91dAjLIojCsTmH39Vyx4jWiMc+q6NxYe2AnBu665CRl
	o1j2+C82EFDwr+/AFv21AYjvVvPylQ/poMJCEmADsqwX/ilydApfv3QCTsGlThk9Dvjeg9Zn1ds
	AQiRtD/DwvQL2RH4qqxptequpjyHkJ/TVdDmVZbzpV6/dD/FKhU6rulW7dBe8zMB67az
X-Google-Smtp-Source: AGHT+IE0BKqOcD1U+E6xed/AmC3x8XuRzt9YWTPtRevws0xEiGoGykgp2QHUI2aE8ULg7Wd9Gc7TiQ==
X-Received: by 2002:a17:903:1ac8:b0:234:8f5d:e3c0 with SMTP id d9443c01a7336-2366affc3f0mr222417685ad.6.1750280039081;
        Wed, 18 Jun 2025 13:53:59 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de782d3sm105599005ad.115.2025.06.18.13.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 13:53:58 -0700 (PDT)
Message-ID: <25d3c6762681b583165b1afe6b1837b22d20b818.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] bpf, verifier: Improve precision for BPF_ADD and
 BPF_SUB
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	ast@kernel.org
Cc: m.shachnai@rutgers.edu, srinivas.narayana@rutgers.edu, 
	santosh.nagarakatte@rutgers.edu, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 	bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 18 Jun 2025 13:53:56 -0700
In-Reply-To: <20250617231733.181797-2-harishankar.vishwanathan@gmail.com>
References: <20250617231733.181797-1-harishankar.vishwanathan@gmail.com>
	 <20250617231733.181797-2-harishankar.vishwanathan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-17 at 19:17 -0400, Harishankar Vishwanathan wrote:
> This patch improves the precison of the scalar(32)_min_max_add and
> scalar(32)_min_max_sub functions, which update the u(32)min/u(32)_max
> ranges for the BPF_ADD and BPF_SUB instructions. We discovered this more
> precise operator using a technique we are developing for automatically
> synthesizing functions for updating tnums and ranges.
>=20
> According to the BPF ISA [1], "Underflow and overflow are allowed during
> arithmetic operations, meaning the 64-bit or 32-bit value will wrap".
> Our patch leverages the wrap-around semantics of unsigned overflow and
> underflow to improve precision.
>=20
> Below is an example of our patch for scalar_min_max_add; the idea is
> analogous for all four functions.
>=20
> There are three cases to consider when adding two u64 ranges [dst_umin,
> dst_umax] and [src_umin, src_umax]. Consider a value x in the range
> [dst_umin, dst_umax] and another value y in the range [src_umin,
> src_umax].
>=20
> (a) No overflow: No addition x + y overflows. This occurs when even the
> largest possible sum, i.e., dst_umax + src_umax <=3D U64_MAX.
>=20
> (b) Partial overflow: Some additions x + y overflow. This occurs when
> the largest possible sum overflows (dst_umax + src_umax > U64_MAX), but
> the smallest possible sum does not overflow (dst_umin + src_umin <=3D
> U64_MAX).
>=20
> (c) Full overflow: All additions x + y overflow. This occurs when both
> the smallest possible sum and the largest possible sum overflow, i.e.,
> both (dst_umin + src_umin) and (dst_umax + src_umax) are > U64_MAX.
>=20
> The current implementation conservatively sets the output bounds to
> unbounded, i.e, [umin=3D0, umax=3DU64_MAX], whenever there is *any*
> possibility of overflow, i.e, in cases (b) and (c). Otherwise it
> computes tight bounds as [dst_umin + src_umin, dst_umax + src_umax]:
>=20
> if (check_add_overflow(*dst_umin, src_reg->umin_value, dst_umin) ||
>     check_add_overflow(*dst_umax, src_reg->umax_value, dst_umax)) {
> 	*dst_umin =3D 0;
> 	*dst_umax =3D U64_MAX;
> }
>=20
> Our synthesis-based technique discovered a more precise operator.
> Particularly, in case (c), all possible additions x + y overflow and
> wrap around according to eBPF semantics, and the computation of the
> output range as [dst_umin + src_umin, dst_umax + src_umax] continues to
> work. Only in case (b), do we need to set the output bounds to
> unbounded, i.e., [0, U64_MAX].
>=20
> Case (b) can be checked by seeing if the minimum possible sum does *not*
> overflow and the maximum possible sum *does* overflow, and when that
> happens, we set the output to unbounded:
>=20
> min_overflow =3D check_add_overflow(*dst_umin, src_reg->umin_value, dst_u=
min);
> max_overflow =3D check_add_overflow(*dst_umax, src_reg->umax_value, dst_u=
max);
>=20
> if (!min_overflow && max_overflow) {
> 	*dst_umin =3D 0;
> 	*dst_umax =3D U64_MAX;
> }
>=20
> Below is an example eBPF program and the corresponding log from the
> verifier. At instruction 7: (0f) r5 +=3D r3, due to conservative overflow
> handling, the current implementation of scalar_min_max_add() sets r5's
> bounds to [0, U64_MAX], which is then updated by reg_bounds_sync() to
> [0x3d67e960f7d, U64_MAX].
>=20
> 0: R1=3Dctx() R10=3Dfp0
> 0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
> 1: (bf) r3 =3D r0                       ; R0_w=3Dscalar(id=3D1) R3_w=3Dsc=
alar(id=3D1)
> 2: (18) r4 =3D 0x950a43d67e960f7d       ; R4_w=3D0x950a43d67e960f7d
> 4: (4f) r3 |=3D r4                      ; R3_w=3Dscalar(smin=3D0x950a43d6=
7e960f7d,smax=3D-1,umin=3D0x950a43d67e960f7d,smin32=3D0xfe960f7d,umin32=3D0=
x7e960f7d,var_off=3D(0x950a43d67e960f7d; 0x6af5bc298169f082)) R4_w=3D0x950a=
43d67e960f7d
> 5: (18) r5 =3D 0xc014a00000000000       ; R5_w=3D0xc014a00000000000
> 7: (0f) r5 +=3D r3                      ; R3_w=3Dscalar(smin=3D0x950a43d6=
7e960f7d,smax=3D-1,umin=3D0x950a43d67e960f7d,smin32=3D0xfe960f7d,umin32=3D0=
x7e960f7d,var_off=3D(0x950a43d67e960f7d; 0x6af5bc298169f082)) R5_w=3Dscalar=
(smin=3D0x800003d67e960f7d,umin=3D0x3d67e960f7d,smin32=3D0xfe960f7d,umin32=
=3D0x7e960f7d,var_off=3D(0x3d67e960f7d; 0xfffffc298169f082))
> 8: (b7) r0 =3D 0                        ; R0_w=3D0
> 9: (95) exit
>=20
> With our patch, r5's bounds after instruction 7 are set to a much more
> precise [0x551ee3d67e960f7d, 0xc0149fffffffffff] by
> scalar_min_max_add().
>=20
> ...
> 7: (0f) r5 +=3D r3                      ; R3_w=3Dscalar(smin=3D0x950a43d6=
7e960f7d,smax=3D-1,umin=3D0x950a43d67e960f7d,smin32=3D0xfe960f7d,umin32=3D0=
x7e960f7d,var_off=3D(0x950a43d67e960f7d; 0x6af5bc298169f082)) R5_w=3Dscalar=
(smin=3D0x800003d67e960f7d,umin=3D0x551ee3d67e960f7d,umax=3D0xc0149ffffffff=
fff,smin32=3D0xfe960f7d,umin32=3D0x7e960f7d,var_off=3D(0x3d67e960f7d; 0xfff=
ffc298169f082))
> 8: (b7) r0 =3D 0                        ; R0_w=3D0
> 9: (95) exit
>=20
> The logic for scalar32_min_max_add is analogous. For the
> scalar(32)_min_max_sub functions, the reasoning is similar but applied
> to detecting underflow instead of overflow.
>=20
> We verified the correctness of the new implementations using Agni [3,4].
>=20
> We since also discovered that a similar technique has been used to
> calculate output ranges for unsigned interval addition and subtraction
> in Hacker's Delight [2].
>=20
> [1] https://docs.kernel.org/bpf/standardization/instruction-set.html
> [2] Hacker's Delight Ch.4-2, Propagating Bounds through Add=E2=80=99s and=
 Subtract=E2=80=99s
> [3] https://github.com/bpfverif/agni
> [4] https://people.cs.rutgers.edu/~sn349/papers/sas24-preprint.pdf
>=20
> Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
> Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
> Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.c=
om>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


