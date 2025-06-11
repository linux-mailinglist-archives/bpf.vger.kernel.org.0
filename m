Return-Path: <bpf+bounces-60361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D94AD5DE2
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 20:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DA01E2528
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 18:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A0B262FD8;
	Wed, 11 Jun 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF5Gid47"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5400C8FE;
	Wed, 11 Jun 2025 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749665493; cv=none; b=EISor/rgLUhnHzlNpZZHCUvUPmyuI4QR1QK9198BwsPbFSeRMhEPcTll4oWCikqvSNddIZwIu2YRi4Bfe+eWYd0a8soDDwBWfi39+1FkSEyacm/ZVvJA6ONb17rlEkmh7+JUWAnfifTdwp+jC+o8kuU+gu19W5huXDQWVwIbc6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749665493; c=relaxed/simple;
	bh=q0lsnchDljt8gnXfY6Q0eKP8Hkd+BZvrb4UfpWQHz5g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VPQTnNMw9wHcSSRIMnXjty1+snWbdvb1XBgJ4EVD6pcnxyPSHV/IhUgXznO36VzQ9oxYji1TMmSbmecN9eufKwUXLiVdkzfe4U0JR6ooUrPQZlSaPe7BTlU+JTMXZ2+A7tNuLyBikkro/RDr5NA7iHCff8dfdhQ9rmfdtpGrero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PF5Gid47; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73c17c770a7so242654b3a.2;
        Wed, 11 Jun 2025 11:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749665491; x=1750270291; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZPOZ6sJ2JCvmZJVnpnH5NP8n+2Ze7Gt4TkB1oDTQYj0=;
        b=PF5Gid47ffMIq3paguM4inecW9KOTggvPLwm5Yyrs0Ui3Qk9z6aJdI9gcDFTO1MFuZ
         yJq/oRif3zPtdO/z/67ydPIDfYjb740kvyS2JAbB0y644wHBYsBGGjDRZo3ZyV44y3fa
         QPHemcPobWaeSXkLO2jqAl6qrEE4w3u9ZVU749A2lQgo4Wvw0PMb+goA6321uiw3IvNW
         bsmlxnq+IpJxJ7Mcqv/fyQo3KARgVS22gAwBYCY+Bh7u7RQ/4ZXza98ytrt4oFF237Vt
         HKuvN8KyV1AJd5CeJe/azybeRX0+mwi0tEvRlLC1NOP6qRTWwD5ENgc9jOpTplji8Jbn
         Lazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749665491; x=1750270291;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPOZ6sJ2JCvmZJVnpnH5NP8n+2Ze7Gt4TkB1oDTQYj0=;
        b=JpKa2ZYCu7rONJGbfszhFt+yHjoJLYv04VHNsujwVMTN1OGLh47/OZW140kyx7P1gD
         BrsWJW8tAFSb/PW8BC4PrIXovKDB/I4Nr6/+1NoxNhbrzsPQEfcujB5fGeqze/+Qw5GB
         8JslpmKxBgxaaXMZN2d8Jb3DR6m9WdkrNAmOC/WxH5mOIQ5XGnMGuHdv1yy5l684WVd8
         gnQu1W2zVAoNMZT4Az6e+16HtM0uE/odCNMxHNrD4Phvm2AYRAA2cM7aCwYV9qhhYW8P
         tjxpPaosC8zMGTug9g/jVxce2jOCgkaeS7oRauJ/VbjGGfmnoGGbxOQFDHFLqmzoMVKN
         CDAw==
X-Forwarded-Encrypted: i=1; AJvYcCWR/EmQ41C8RcfzC8BkixX89v+phJsp4g+MoCsZmOFgYfMIArtXwPpU5pZuTNyeqWZUErc=@vger.kernel.org, AJvYcCXMtZtm4qAE4RzRrIgT4UdS+nbgJ0mjmc2bPht4jmtiTM2ohalw84c5bwD32Vfbkw8ThiL+nIQu2Oy2KXBF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ZPylLHW1rCyPiNxGq0JNElB1E7Pf3dfC6CytoPP6NnHSv5Od
	qR/CRvn9AHxHfTGU+3AIU+FxpDPIpEH512Mif0gYAbch0e457b4Wanca
X-Gm-Gg: ASbGncvyZeE9e5MJYPWRN2cW9HmYIkerkAxCNNFv3ffK9uKFwmqtcwj/h3bRB6AXbBt
	dfOo+UJMpt1tPtLNr1A56QD71KqR51yG9Nm6QSOYTBPKG3fzo5c5+6TYK5/o0hAaxprWp4R9nXR
	rFfy8JvClqcdvJecYF1ggmYzoMnunXbCEKAxcBUiLLP+RYkmj+1VYhvNiKs0z3sVKTqCB2FTzDU
	o1jhvLeCndpYzKWVA2EYVH5zOgExPqJLjGluIprtmDgWr4qzv8I0f4v7cC+7F6fK6yztRbsZBt9
	tNLaojW/6wfYziUfLO9tQoJ5xqXqp3GGUy99K9QzcvLW79P1kV/iIM9ASEJE4ASFfy4xDCG2WOR
	hChmtyNHCi+zU/yNwppJ3
X-Google-Smtp-Source: AGHT+IH3k5dvrTUz2/ALnQwF8EtBJmtajrGWHaF4qawZUYqpcqKqamU1sQf963afTQFW+2W9fsJKgA==
X-Received: by 2002:a05:6a00:ac4:b0:737:678d:fb66 with SMTP id d2e1a72fcca58-7487e082857mr34077b3a.5.1749665491129;
        Wed, 11 Jun 2025 11:11:31 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b1d2:545:de25:d977? ([2620:10d:c090:500::7:d234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af7ab1fsm9801917b3a.54.2025.06.11.11.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 11:11:30 -0700 (PDT)
Message-ID: <a39e1ed2db4121b690796c347f1259da09e23e13.camel@gmail.com>
Subject: Re: [PATCH] bpf, verifier: Improve precision for BPF_ADD and BPF_SUB
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	ast@kernel.org
Cc: Matan Shachnai <m.shachnai@rutgers.edu>, Srinivas Narayana	
 <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte	
 <santosh.nagarakatte@rutgers.edu>, Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 	bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 11 Jun 2025 11:11:28 -0700
In-Reply-To: <20250610221356.2663491-1-harishankar.vishwanathan@gmail.com>
References: <20250610221356.2663491-1-harishankar.vishwanathan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-10 at 18:13 -0400, Harishankar Vishwanathan wrote:
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
> verifier. Before instruction 6, register r3 has bounds
> [0x8000000000000000, U64_MAX].
>=20
> The current implementation sets r3's bounds to [0, U64_MAX] after
> instruction r3 +=3D r3, due to conservative overflow handling.
>=20
> 0: R1=3Dctx() R10=3Dfp0
> 0: (18) r3 =3D 0x8000000000000000       ; R3_w=3D0x8000000000000000
> 2: (18) r4 =3D 0x0                      ; R4_w=3D0
> 4: (87) r4 =3D -r4                      ; R4_w=3Dscalar()
> 5: (4f) r3 |=3D r4                      ; R3_w=3Dscalar(smax=3D-1,umin=3D=
0x8000000000000000,var_off=3D(0x8000000000000000; 0x7fffffffffffffff)) R4_w=
=3Dscalar()
> 6: (0f) r3 +=3D r3                      ; R3_w=3Dscalar()
> 7: (b7) r0 =3D 1                        ; R0_w=3D1
> 8: (95) exit
>=20
> With our patch, r3's bounds after instruction 6 are set to a more precise
> [0, 0xfffffffffffffffe].
>=20
> ...
> 6: (0f) r3 +=3D r3                      ; R3_w=3Dscalar(umax=3D0xffffffff=
fffffffe)
> 7: (b7) r0 =3D 1                        ; R0_w=3D1
> 8: (95) exit
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

Is this patch dictated by mere possibility of improvement or you
observed some C programs that can benefit from the change?

Could you please add selftests covering each overflow / underflow
combination?
Please use same framework as tools/testing/selftests/bpf/progs/verifier_and=
.c.

[...]

