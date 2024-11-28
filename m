Return-Path: <bpf+bounces-45789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76F49DB141
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6849C282647
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 01:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE1C38DFC;
	Thu, 28 Nov 2024 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezSaZGb0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD31DA23
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732758657; cv=none; b=pZSndDJzFXO0HPoqF8Mj+FNmRNltLJDFtCqNhEPrxr8KSoSSYG12OR+T/Z1h7fwxCLipwa8MdH/qwo7fZ3A6Rk5Tw78DY44layg7zMlvcj7lAEkqUSEnS4LO5mXKcYh3RO9YyTiFJ4rD9dztZrOBy3gY5mOG/HOTezRd0hREdP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732758657; c=relaxed/simple;
	bh=zaRHvRfgz/OMypexrAd21z1eueaXIfOV60XOnghTOsI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Frorpg1qOa+QPvani0Xd9UTjYPkDLnqTuqAMwXnKYE+KA3XCTKVoC/1RunkCZ0MeiJJy/aTDyLa3Ax0yVxlwanPrN8QtunISd8LcEIgKsdjuHB1B/FHs4VZWykYWiUllbqOAT/xXTrvmJeN33lWZSXHWhPKu90L8myaJg/CPe8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezSaZGb0; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f43259d220so185461a12.3
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 17:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732758655; x=1733363455; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4J/HTWJ8YpekbthN/ijIKs3Ge6f0iWfNZJ9lCjJC+i8=;
        b=ezSaZGb0JK998elUC+9Kzf0rWL1zCk8Myv0bAQsGLqn1KZZ2rw9X3Kb2EDtEd9NOeH
         yDUQdIPqbV6N77xQSOh5lVpWObOEyD6SchgWGP6XUHfdYMrDfIO4r9aGLN2xEneMMyLF
         H8ZO5PAlpIep/ecPMdyDHvx14kAvVq6GLpzRZJtlckIMv5xYBxRuo/RrnDaof40MxzIY
         ycH3D9eGu3uxGNqKMnJgMnpdg77vzLLM2GgqPkMv5wMzkoVN82/NOb9ZfiqSNyPkEnjO
         YtsP08saDvlPrTXoCokFl601r1cLK/jMTWybiv8jcg7z8L7LUVsY3CgYR3PZzPFEaz87
         Imng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732758655; x=1733363455;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4J/HTWJ8YpekbthN/ijIKs3Ge6f0iWfNZJ9lCjJC+i8=;
        b=DNla0vRhPzrK5i14hdRJP3Q19F9Cvwh/kPKVKWrpFdC+0T0ouXUU8TmzdrQe34yyML
         SLP+1Gya9lOWrLXsMUSe8WBMoQ8zLYDSJvRw/zfeBUl2ovPWGEYIEVgYhNvPzH5uHwAJ
         uoGey0OAOdm5Wc67OTr4bZH4FNJg31i0Vll56b+fXQxDJNR2BSVVkFW/79ZmFY7kJkjX
         xcPgTDS2b3kA4fZ04g+ZpGndGQIkcRKBS/E+V+LrG6ydQ8auxZ/FYs+dnb/6tBRj/08h
         snc83eg84FV9ER/TjWdBjhzibPEvU758qMuVoHVomhuhb1Y6XZXbHtAFvNeQSgyLH/7l
         jXmg==
X-Forwarded-Encrypted: i=1; AJvYcCXjsklMa8BJS1SB8wwb9BwkBir5EJiU78rtCcjryTWoxtBXViyFGRDlGywEx40D3mUixaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbYV+mzqMCYAO4IevVguNohQb5UA0L0uQ6lIUmDTjb/2PisHbn
	NEwk6BGLs+IRuTLnQPt97QcIVvil2701HnpTCH/Meayg0ygY8Uir
X-Gm-Gg: ASbGnctflZyTkCnn5xbY/6ggAQcchUdR/+UVnjQU2vG/JrQciuREIT2rhYk+2cTAv3R
	kbbGS8CfaOYUzbi9TdOlhQYJxKKtQ6v4s5xZGdmNuo6prpgLswIlyoum6thLVOs0QW2RjupKN1H
	vkl9AbQ/WEzWPtl/8NtPouQOjsivnToKkj9Q85rBbZokM/MoySIJpbtni4TbkaL6lx316nTTnvQ
	+BTAbRZccQa45xy6JRHKNZ8GDWhi9RcZodKxrrO1MXP6ZI=
X-Google-Smtp-Source: AGHT+IHRLYFk6WKGMUGFdRLWCDPlF0uDv1KuXLuA9IOGHI3/eMtB1HfikEv38UOm5MtUeLpxK2RCcw==
X-Received: by 2002:a05:6a20:7491:b0:1d8:fdf8:973c with SMTP id adf61e73a8af0-1e0e0b535e5mr8229365637.29.1732758654537;
        Wed, 27 Nov 2024 17:50:54 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541814657sm257544b3a.156.2024.11.27.17.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 17:50:53 -0800 (PST)
Message-ID: <f0fbf1268f34b3eb7b74359dc11ec4299f5d77ad.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Add test for reading
 from STACK_INVALID slots
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>,  Mathias Payer
 <mathias.payer@nebelwelt.net>, Meng Xu <meng.xu.cs@uwaterloo.ca>, Sanidhya
 Kashyap	 <sanidhya.kashyap@epfl.ch>
Date: Wed, 27 Nov 2024 17:50:48 -0800
In-Reply-To: <20241127212026.3580542-4-memxor@gmail.com>
References: <20241127212026.3580542-1-memxor@gmail.com>
	 <20241127212026.3580542-4-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-27 at 13:20 -0800, Kumar Kartikeya Dwivedi wrote:
> Ensure that when CAP_PERFMON is dropped, and the verifier sees
> allow_ptr_leaks as false, we are not permitted to read from a
> STACK_INVALID slot. Without the fix, the test will report unexpected
> success in loading.
>=20
> Since we need to control the capabilities when loading this test to only
> retain CAP_BPF, refactor support added to do the same for
> test_verifier_mtu and reuse it for this selftest to avoid copy-paste.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       | 41 ++++++++++++++++---
>  .../bpf/progs/verifier_stack_noperfmon.c      | 21 ++++++++++
>  2 files changed, 56 insertions(+), 6 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_nope=
rfmon.c
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index d9f65adb456b..aaf4324e8ef0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -63,6 +63,7 @@
>  #include "verifier_prevent_map_lookup.skel.h"
>  #include "verifier_private_stack.skel.h"
>  #include "verifier_raw_stack.skel.h"
> +#include "verifier_stack_noperfmon.skel.h"
>  #include "verifier_raw_tp_writable.skel.h"
>  #include "verifier_reg_equal.skel.h"
>  #include "verifier_ref_tracking.skel.h"
> @@ -226,22 +227,50 @@ void test_verifier_xdp_direct_packet_access(void) {=
 RUN(verifier_xdp_direct_pack
>  void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
>  void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
> =20
> -void test_verifier_mtu(void)
> +static int test_verifier_disable_caps(__u64 *caps)

The original thread [0] discusses __caps_unpriv macro.
I'd prefer such macro over these changes to prog_tests/verifier.c,
were there any technical problems with code suggested in [0]?

[0] https://lore.kernel.org/bpf/a1e48f5d9ae133e19adc6adf27e19d585e06bab4.ca=
mel@gmail.com/#t

>  {
> -	__u64 caps =3D 0;
>  	int ret;
> =20
>  	/* In case CAP_BPF and CAP_PERFMON is not set */
> -	ret =3D cap_enable_effective(1ULL << CAP_BPF | 1ULL << CAP_NET_ADMIN, &=
caps);
> +	ret =3D cap_enable_effective(1ULL << CAP_BPF | 1ULL << CAP_NET_ADMIN, c=
aps);
>  	if (!ASSERT_OK(ret, "set_cap_bpf_cap_net_admin"))
> -		return;
> +		return -EINVAL;
>  	ret =3D cap_disable_effective(1ULL << CAP_SYS_ADMIN | 1ULL << CAP_PERFM=
ON, NULL);
>  	if (!ASSERT_OK(ret, "disable_cap_sys_admin"))
> +		return -EINVAL;
> +	return 0;
> +}

[...]


