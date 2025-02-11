Return-Path: <bpf+bounces-51073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EABA2FED3
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E6C166B5C
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4164928EA;
	Tue, 11 Feb 2025 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQfjM9D7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B58B3C0B;
	Tue, 11 Feb 2025 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232532; cv=none; b=nJInPRN+/Ill7243mXWnCF8kwsppcd9SA+7vuCB/GPF36ST7r9VFgOmcR0umttGyHP5KFb00MsoslbUB2rQ1IFKHlxglRWNwz+DtAKuAuPsq3syWCudo+10I9aPTu+gyf90D1KuANp3cIom0evWxm/Wkm86Uhd0x7eLKUfe5dbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232532; c=relaxed/simple;
	bh=h25Y+GJslj1osPPwzBp6g5ITvcIe6KA9nGKAC1tMkHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l+2820iY/5XLX9H0t8sv1YLHSbC9OI0ThwO547S1Vrbp8ntovGSyZo84TJ+WIpi2lSE6jIhecyTZlosdsJ+CwD3Hcc9w+B9G3+j3++Ht0DxZeDCaC8XxlCYWK3QsB4why2aij6XBrRVXECg63s7j1MpS4Hs23alcfp2awkC8Zi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQfjM9D7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f50895565so53148035ad.2;
        Mon, 10 Feb 2025 16:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739232530; x=1739837330; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uQyUJBqo+jTXiMiWvhStxEYM9tCoQv2ZIzt9rc3LsXM=;
        b=VQfjM9D7aRGlyOO59wRRmbawBXD8uy05WwvyMR4YHkzLZRyJcv2LWlmKYT6eDv780W
         wqviwHDYrrvDExxqgsAXyq7faMpOEmRFjJ19o42p9QIGLWTNrLCecBJormuqrM80cH3f
         UMCiKC/pV7Ch1PeGaJwxHev27s2tZd/AbplUWOx9y9dYg9FTDTwZNhNg20EYJqgzCS11
         VhT24iznSuQPlBE8YvSCgFr3LMcHHoZD5kbdevBYbXJcTdHe/vH5sqoK8yiF1Wc0uXLS
         ukSQ+PE2xarxsqizedsVr7nuvylToLSjcY+eZVy1+EL5H3tde/L6tCEICEaAkQ3CZ4tf
         +Vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739232530; x=1739837330;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQyUJBqo+jTXiMiWvhStxEYM9tCoQv2ZIzt9rc3LsXM=;
        b=uEiyqfbkmR+nPUXZYlTIMStVYmamYCqBJ4AYKEza6jP2IVxhWajDvL4aohUQ4ZHBEs
         u7V3mYfmhi3E50JqAT79729bfkA9z58r3L/or9YGfr9PhcAkkKceTRG0CSjqXyQsxnbX
         3dfhrrUpIeAUrwkCeO4ET0rano1Qx3x0j49hAdEb0bsQhaB2aGwyMCIICgbteYuKMq0H
         F150CAwzndn2OlXlkTBllPuKrVQjFleTpbJY7dwJnhen6RfKzBQ25IY3QmfE6+1wSI+k
         I9IHpL1k8Oli6vHdBBfToDgon+hvojt4oZufxE3Jt0it4050bAkZoD8jdabuIrEU9ems
         wcLw==
X-Forwarded-Encrypted: i=1; AJvYcCUmhg4BnbCnCTtfXSX8i+rG53v5y/KaFiIcjcFAnFzeAUyyxDwWISJMOxD2rbbTNS9Xxlc=@vger.kernel.org, AJvYcCVLUFZs4FJrCA9JKFC1S4ku51GCGAM9RRYRn1ygG+YXh0+JU/bcVxo8RS2TJw54Q7vHwFJoqkgoLwVaY+Ne@vger.kernel.org
X-Gm-Message-State: AOJu0YyrOsgXULS64AyKcKFODJnlRNUc/ml1mpkyp/Sl5avxnHRTbdDk
	KDDXKs5V25/UWUqGXVDtavdiAVQOwp3az29/0uOuAFcazN38KSKJ
X-Gm-Gg: ASbGncuYsdr5PC4RjsVx+E55cjMZ1eSgX1v4s7FD4nbrM2gpgfEyqZI6q+EDWlL6+B3
	Kg2SgWdpUEN5HyIJTy7XjkzwYi3KUxzdN3zPbLyb5cljfv7mF37m8fb6EcR+c5yJBI1ThcmVdZP
	mPL11Y80wjb3Gi6X3IjUn/lhx1bsPj+XZdal0Mhyn5xwkf9qxhb9ct0vwlFuyu8zVeDtNxEzmXs
	AHAayTGCjyewHZhL7NfaFDXMK7YbJB4z9moVac+hpSqfIkAzDaj7Cfh5PAMbnnNl2HbCwGLQbEt
	tJI6blNUkfdk
X-Google-Smtp-Source: AGHT+IGDiHUAa707fZSIiz13RbPklkC1h9XML1rywNVdLJb0wY4Mp/STxHikL/FhaHi8cHMzHDo6oA==
X-Received: by 2002:a17:903:2bcb:b0:216:4a06:e87a with SMTP id d9443c01a7336-21fb64a5fe6mr23698975ad.40.1739232530464;
        Mon, 10 Feb 2025 16:08:50 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368afde8sm84249775ad.223.2025.02.10.16.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:08:49 -0800 (PST)
Message-ID: <6976077bc2d417169a437bc582a72defd1dec3d4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 8/9] selftests/bpf: Add selftests for
 load-acquire and store-release instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Peilin Ye <yepeilin@google.com>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Cc: bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, David Vernet	
 <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet	
 <corbet@lwn.net>, "Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan	
 <puranjay@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens
	 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Catalin Marinas	
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Quentin Monnet	
 <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>,  Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long
 <longyingchi24s@ict.ac.cn>, Josh Don <joshdon@google.com>,  Barret Rhoden
 <brho@google.com>, Neel Natu <neelnatu@google.com>, Benjamin Segall
 <bsegall@google.com>, 	linux-kernel@vger.kernel.org
Date: Mon, 10 Feb 2025 16:08:44 -0800
In-Reply-To: <3ac854ac5cc62e78fadd2a7f1af9087ec3fc7a9c.1738888641.git.yepeilin@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
	 <3ac854ac5cc62e78fadd2a7f1af9087ec3fc7a9c.1738888641.git.yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-07 at 02:06 +0000, Peilin Ye wrote:
> Add several ./test_progs tests:
>=20
>   - arena_atomics/load_acquire
>   - arena_atomics/store_release
>   - verifier_load_acquire/*
>   - verifier_store_release/*
>   - verifier_precision/bpf_load_acquire
>   - verifier_precision/bpf_store_release
>=20
> The last two tests are added to check if backtrack_insn() handles the
> new instructions correctly.
>=20
> Additionally, the last test also makes sure that the verifier
> "remembers" the value (in src_reg) we store-release into e.g. a stack
> slot.  For example, if we take a look at the test program:
>=20
>     #0:  r1 =3D 8;
>       /* store_release((u64 *)(r10 - 8), r1); */
>     #1:  .8byte %[store_release];
>     #2:  r1 =3D *(u64 *)(r10 - 8);
>     #3:  r2 =3D r10;
>     #4:  r2 +=3D r1;
>     #5:  r0 =3D 0;
>     #6:  exit;
>=20
> At #1, if the verifier doesn't remember that we wrote 8 to the stack,
> then later at #4 we would be adding an unbounded scalar value to the
> stack pointer, which would cause the program to be rejected:
>=20
>   VERIFIER LOG:
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ...
>   math between fp pointer and register with unbounded min value is not al=
lowed
>=20
> All new tests depend on #ifdef ENABLE_ATOMICS_TESTS.  Currently they
> only run for arm64.
>=20
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +++ b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "../../../include/linux/filter.h"
> +#include "bpf_misc.h"
> +
> +#if defined(ENABLE_ATOMICS_TESTS) && defined(__TARGET_ARCH_arm64)

[...]

> +#else
> +
> +SEC("socket")
> +__description("load-acquire is not supported by compiler or jit, use a d=
ummy test")
> +__success
> +int dummy_test(void)
> +{
> +	return 0;
> +}

Nit: why is dummy_test() necessary?

> +
> +#endif
> +
> +char _license[] SEC("license") =3D "GPL";

[...]


