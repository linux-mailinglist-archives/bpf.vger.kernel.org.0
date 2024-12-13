Return-Path: <bpf+bounces-46963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E189F1B28
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 01:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4675188E289
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D841EF09C;
	Fri, 13 Dec 2024 23:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuLVRiHm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9806F1EE02F
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734134166; cv=none; b=TKMPTx5z2hnTcFdKtjC+FohyJKcGORg65SoZnkdroRv9Fk7WMbv79N+iZlFq8+TTrD7VS9jJex0KXHPsADjdWjgU5P5NsY40yCIgVSr+QEdyOg3cvDJNKja0tQgdrvZERNPY7fsvnWOqUt+1N43/72arRhWNd6BAms9CdgpB3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734134166; c=relaxed/simple;
	bh=4xx80uhQkTyl7hdwewDmYW9oEb5Rx3sPHR/h2syofwU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mZd1c3SHe7gH2Y5nqvrrC98LbRSs2In69alHlyjWDy23vWWpIdjz4YH25fJLeFbGvh96GP3X4TYSayUtqwdI5UZRtY7iLX/xy36toRSXE3/Gb+Jf3FZaYvDoGr5GJZg2mNDKMWWvOzZqV2QewCoNwDfVt6UxHYUeGXHKO8ba36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuLVRiHm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21670dce0a7so26261235ad.1
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 15:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734134164; x=1734738964; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lguBHkMuMw9PvWaUXbOhzfELrVI2XwTW80KxXDOS2D0=;
        b=GuLVRiHmmJ8jq5oaD8G2zT4T0m5EPGFNo3+8GD7gQAbDXxFWfqe3G1dm1k9NZC/AgC
         OmrTzKy7fSkhimFbkOXRXAYqnZM656zHKuJ9jRu5AbIU7lhJ+XFEJ7lFRCKbolCMVF2J
         3jOWeEEaDjFnWadca8hZ2JNd6FZ+RmSHzRY8NGkoxYWNGkVFChbXHQ++zVZ1jnsJlm2L
         wvgkzLsFBgGHRT8EgTC6ezYGgjb+Lh7Hkr2OEkO6BmwOq6gOnv6yRgstnNEDSCofaRvl
         y0Xtvxnio9+ulsxB/t+MVIM4S34M4bNgq+laPAwW9s4R0KevKTjg6VQoP0OWqcpCh9CF
         jSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734134164; x=1734738964;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lguBHkMuMw9PvWaUXbOhzfELrVI2XwTW80KxXDOS2D0=;
        b=Q0c/QEntlH3eCtUgDtFdRlnMr8PoMhNtGOyCNYNVSZUdm7+rDtx7u+8fE/4nDlopdI
         kS0MCjnUt5xXErHRiuhqGNghOFvOiVCNSpfSdxsclmhsN4C6+d2wLXt6FIq2x27HG7RZ
         y2M2EAp1NTFA1d0JAlU2JC5g26tFDqaklusQlsCMQz4lcpHg8aGaR2rjxaO8RQbAY958
         h1eQftorukgQe6Pt1L9XOmxpiiFpF5cndNttrghFJIVnQGaezSgmkTdVs31pUA1Eg+G9
         iTLLyjqCvk6tE06ZB38BFm9tGhQTn0AyYdZlH6vZH0w+DWeR/m4kjMvIARSqCt4il+j8
         qNOA==
X-Forwarded-Encrypted: i=1; AJvYcCWK9AvttJnW4VNwSpixy+XBNVT/65hPELfdLfbAg1mWYX4ZziVSRUj74HeaDyyXKat56AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyTNr9na5/ox5NgRAMjFADD+H0dZV2MYqqB31F1OTshieS51jq
	hbrcpzFmd765HG5GyYDeHmrNmuHFpG5IhW6NFAH3JRvsJKfQ7aFX
X-Gm-Gg: ASbGncsD8jwz3tzcyGTPtW/w+SZBpOGJAQnUjfcBe1u7qnOxGXDgc1LgsmhwKrr42ij
	K5BJlTjiUfejkzny8fq1eVrK5IiOJzhfbJBMrk7LiQ105tvBeeBlztUVvwRrdAXphuA9WkYthTc
	wwsJVo4ANevBrt9cvgDrgnq/R+5E1sA9ObhgaZ90RDT9fFZ4qWtt4Er7+Z6vsHWiI+MLf2psiiJ
	zCIrRdDqA/PBu+oBEPEY1WEFBgsxPCAyhJ5Bl1+Wx5Y2rGWsqhypQ==
X-Google-Smtp-Source: AGHT+IG2ovmJ3Jfam9URwXRppojeJdvMUvABoKMOZQ2+r80p9mBJf4Idg1J1M4TbF+V+1K9bSJJGwg==
X-Received: by 2002:a17:903:94f:b0:215:94b0:9df4 with SMTP id d9443c01a7336-21892a566f3mr63187165ad.54.1734134163914;
        Fri, 13 Dec 2024 15:56:03 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0fe68sm278403a12.62.2024.12.13.15.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:56:03 -0800 (PST)
Message-ID: <76401f4502366c2d9221758f9034aa7bb2d831a3.camel@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test r0 bounds after BPF to
 BPF call with abnormal return
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arthur Fabre <afabre@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team@cloudflare.com
Date: Fri, 13 Dec 2024 15:55:58 -0800
In-Reply-To: <20241213212717.1830565-3-afabre@cloudflare.com>
References: <20241213212717.1830565-1-afabre@cloudflare.com>
	 <20241213212717.1830565-3-afabre@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 22:27 +0100, Arthur Fabre wrote:
> Test the bounds of r0 aren't known by the verifier in all three cases
> where a callee can abnormally return.
>=20
> Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +++ b/tools/testing/selftests/bpf/progs/verifier_abnormal_ret.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "../../../include/linux/filter.h"
> +#include "bpf_misc.h"
> +
> +#define TEST(NAME, CALLEE) \
> +	SEC("socket")					\
> +	__description("abnormal_ret: " #NAME)		\
> +	__failure __msg("math between ctx pointer and register with unbounded m=
in value") \
> +	__naked void check_abnormal_ret_##NAME(void)	\
> +	{						\

Nit: this one and 'callee_tail_call' could be plain C.

> +		asm volatile("				\
> +		r6 =3D r1;				\
> +		call " #CALLEE ";			\
> +		r6 +=3D r0;				\
> +		r0 =3D 0;					\
> +		exit;					\
> +	"	:					\
> +		:					\
> +		: __clobber_all);			\
> +	}

[...]

> +static __naked __noinline __used
> +int callee_tail_call(void)
> +{
> +	asm volatile("					\
> +	r2 =3D %[map_prog] ll;				\
> +	r3 =3D 0;						\
> +	call %[bpf_tail_call];				\
> +	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_tail_call), __imm_addr(map_prog)
> +	: __clobber_all);
> +}
> +
> +char _license[] SEC("license") =3D "GPL";



