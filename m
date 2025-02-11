Return-Path: <bpf+bounces-51078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 958CEA2FEFB
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D13166EA8
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC7614A82;
	Tue, 11 Feb 2025 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8kOLr1V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE4C1CD15;
	Tue, 11 Feb 2025 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233226; cv=none; b=cxesTJgo18h35JOQ3fpZbno9f31dywRi9pwziLNtM6ZMWStMQfLvzN+oNy4bEqpcn9ckBPuNZ1qi8Vygr1MyFgHemETNGQEoCYapn0EhqVKGxwsz1d0S9iFh2m+8vPv19imSVTfv+tKh0d64fgziOfDzKS9Fjs2+WfCPxN8aFc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233226; c=relaxed/simple;
	bh=IqnrH6YQqD8O4JxcdVlrdq7qgShIkTw3deISxez7Pog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VYlhMHjlTURo99qE9aiT0ikI61rw1qAaQVYBuHGHGZO5nmqQrsXpeaNTZCQYl8fbTwdNmf2P4ymigpcq52e0BLYHPBB60H0C7pRESHoCbiqMFku8DDkz3PgvDUcsJnPbscoeAIgcGtwcu31LGVX8b3mVmZZplmew8fpP2Fsxc+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8kOLr1V; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21c2f1b610dso121392115ad.0;
        Mon, 10 Feb 2025 16:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739233224; x=1739838024; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1LObash4SiJzQzSayaQdpqyI0vrFPh91JJNVHX4SZoI=;
        b=S8kOLr1VqCHd/vstNL3FMQs8bt0Q/zsFDuY3Zwkpn4vb0YXHVnAp4/hXUbmaWeLe/f
         CIX6VgL/xyd134APR/NVsdIRxCL90wD+xj29wxa+8z5YRCdWF/gdyZTvEKUYP9oLuMVQ
         cfTMpOE0ZHEaeqAM8BEHrmWCa711yQJnxAhHwzj+aBHb3Fto7xFk0seYj0IQC+pehohN
         k1E1qVCyn/7wWazjOA+tnRfTa+6F3eewSR8Yo/grrLrG3AVDqiQHSBylIhGMxNekGFQL
         je1N73TJ995hy3fwgbAkfRJA+ETT75obsLIHHMI+a3KInlnS34RmHVdv+pV5wRLexgsv
         gsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739233224; x=1739838024;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1LObash4SiJzQzSayaQdpqyI0vrFPh91JJNVHX4SZoI=;
        b=e90pCBjHtPZEKWZAQNNPqONn3toZHm9Xg1e6SoPRLHcObXES0nMz5pO/q7Wsm7P816
         ieXmKlEEeCE6dYeBP2KhOmSOjQQqjvMYsdK0JxMHWJdKYUgFwC7FyURowa+D32QETiCa
         +5X/RtaMU3f2RRkuZjPZATNQGoo6wp4b56878VPonAdoZN5cpRGv4sv4fc5HfSTqQ7BC
         vEgYclotQkNNTxWEEa6kqAT8qXRbWgPzPeNL4hj1qUW1dkD2K+aauinG4KHUrleJPdax
         67daqoQqcDcfw+vaFk0RrzzbJKCbQ0NR+IVkweQLShdpM5sfejIzqIPwkON/nfxHsTLY
         BB2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVe2RCsZtjGBnjPmNdbCL/MNq8qkVelxI6idyC1FfiHDWyeRv1S09aNEF3j/V+xC2T0a2A=@vger.kernel.org, AJvYcCWyXSqbUQTo72wtF3lqh6mL6TLmtsnKRu+95PyK75kdhZ07q8Ze87GGTz9vyUHD/vCTWDm+FWzao0v/UIfy@vger.kernel.org
X-Gm-Message-State: AOJu0YxKSTBbReciRR0J42EKPefl2fNy6H5/Td6jDd7WuHpTNMf+zCzg
	8Gzhhu/rwa21QPM5fvvEUyfA/5ShqKPQh3qalaLai+z6tNbNvFBG
X-Gm-Gg: ASbGncu/UICNNGs6T74P09YJf2MIkIGyAom8Zmkn+v6V7bGqUgmJclFzgII7HTt9Ddk
	4v2QCPNzJIKCcnngxL4AGtsZDKtnLNEZXAZPndp/2llnEN7xaIyUae/utYP2SWtxxvj9sHOnMnb
	lMc+UZIqvpVrHh1YqGwrDQsHecho/CxW3XuJkzmyHEGn3GryhUjGcHqgaDS2fRoLZ+cxlgnB5Ou
	nBqD7tYHQAeq21TYzfeWTTJy8j/aG79w7Q53kgOMbMSzjRCTyNQzwdMZ9esuoihY2au0f6CLOP7
	XNUc5zGDbjYa
X-Google-Smtp-Source: AGHT+IGfT4HyRk97hCaleORdR2AUGluiKet1yAikZSTi1M9AHOfW+rliwbIgZiso8b7B35AaCA7dbQ==
X-Received: by 2002:a17:903:2451:b0:21f:6c81:f77 with SMTP id d9443c01a7336-21f6c81116cmr175450705ad.23.1739233223933;
        Mon, 10 Feb 2025 16:20:23 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c555sm85174035ad.182.2025.02.10.16.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:20:23 -0800 (PST)
Message-ID: <6a87b140203461f9d56874b9e4a778febdcd47a6.camel@gmail.com>
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
Date: Mon, 10 Feb 2025 16:20:18 -0800
In-Reply-To: <Z6a_UILNqVGBqnvY@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
	 <3ac854ac5cc62e78fadd2a7f1af9087ec3fc7a9c.1738888641.git.yepeilin@google.com>
	 <Z6ajasn2k559SGNN@google.com> <Z6a_UILNqVGBqnvY@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-02-08 at 02:20 +0000, Peilin Ye wrote:

[...]

> Sorry, that wasn't very accurate - we need to make sure there are no
> "holes" in the .addr_space.1 ELF section, e.g.:
>=20
>   /* 8-byte-aligned */
>   __u8 __arena_global load_acquire8_value =3D 0x12;
>   /* 1-byte hole, causing clang-17 to crash */
>   __u16 __arena_global load_acquire16_value =3D 0x1234;
>=20
> LLVM commit f27c4903c43b ("MC: Add .data. and .rodata. prefixes to
> MCContext section classification") fixed this issue.

This is a bit strange, from commit log it looks like LLVM-17 should
include this commit. But in any case, targeting LLVM >=3D 18 seems
reasonable to me, the main goal is to have these tests run by CI for
some compiler version.

> - - -
> For now, I think I should:
>=20
>   1. change existing #if guards to
>      "#if defined(__TARGET_ARCH_arm64) && __clang_major__ >=3D 18"
>=20
>   2. additionally, guard "__arena_global" variable definitions behind
>      "#if __clang_major >=3D 18" so that clang-17 doesn't try to compile
>      that part (then crash)
>=20
> Will fix in v3.
>=20
> Thanks,
> Peilin Ye
>=20



