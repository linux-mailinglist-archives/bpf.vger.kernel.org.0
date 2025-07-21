Return-Path: <bpf+bounces-63960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92949B0CC9C
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4291E1AA14CD
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 21:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B3023B633;
	Mon, 21 Jul 2025 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOEXDby/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396F2241670
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133413; cv=none; b=QHn0rcaSXVN1haqpU9S8eTzY/+GXW3oO1Q+dGrgZHce5/ZBlS1uG2fM4z6Xqm0hEvEs+gAeuhFHchhw5UDIBTVcLtnVGmGozegjUQO+zIDpC5xaoCCWvMBZ/1O8JkZQ6sMZNsJl2XKurCmDpAM1QPj+Dw5/FemX5WaGW+FOZt38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133413; c=relaxed/simple;
	bh=Pum3EBwUV4mVo43us2yeCNQcXN+MXI3gkxAPgfEREmY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nBKEalPRJjFYKdV3JXOkOeggckEJjbZ1GPwH/vuB7XKqnJRteJMBFYdxULAlIEKETMYdoivF6YgUJiz7+IJVtIEU8g7iy7KfmA7m7eGt6CsYhuB9YUah9zqYRS2ajnPL22AIkCM1AWa98tckXdzg6S9548ETQCe6M+/dFnwSWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOEXDby/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-747c2cc3419so3743739b3a.2
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753133409; x=1753738209; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DJoR36ZD2tDfrL/S/PnM8fZeEPthky4EwfLUSsnbGos=;
        b=bOEXDby/Iv17JC26nJoRmBgYFO5bl38PH3O9GX8w6DVR0ahOcAtEOr8DK1Iwl0vg9K
         RQ2VdtmRG3v/OMJWJV8j6rs8AFwhgMk7H0tgfdBT9a46xpTAT5xUKywxhfGE1oiURbe/
         KwOkJVEnO1ryl9R0gRtZ9G37IEO600FfKF1kcfjMUQjT24Bbvepqm4xEEFvFP0yBq6up
         /4wslcszfLSLCuWhhw4HqZloHvDvXZGlwDe8Yn+Njf/j3ssF0BP2xxP4nuEZhg3rWn8k
         zKHRs/7KsjPmnC3rDMyMlrngbRGJth1QYjjbmfpUjWdGBdQTPsjVfBpXyFrJ48gp5zBd
         jy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753133409; x=1753738209;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJoR36ZD2tDfrL/S/PnM8fZeEPthky4EwfLUSsnbGos=;
        b=vr/ylXxQJLBJEcwsbx1k2I8NANshxoHMyva8wD3oNwba8S83F2bUInOmIHOaR3ATe8
         YUFVAoIydHabc5jwFeSBHgOrGyFaEUimr1COeEr48YPRrgImr6hLg6Hi52O7OAFzXa6X
         ccTOGUfUFHe1VBpEEWjT5uJFfZCwfMhkqBzWZ6h4gI9dHpZk859N1sWRqQZRWUeOsHhU
         7wKGRF/IAYMA298pBPCwLl4JXG+SFRf10LxA2Mn+Gkj7yMznADdhqxaUAC9gUV+8JYUL
         imjqbUqvwskKeh+zeieP7b6FRuDHtkzphYry/botdIJC2FIHGqHcHY6yDzKE+MVOubRA
         +IKg==
X-Forwarded-Encrypted: i=1; AJvYcCVlZ8mevemckmgkWaaqaszgNjQYlHyJYE9ds/8MZC/5BbR6CCZm5d+zgmLFTrBNOP/FGKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk/wWS+S4KAoLQpnfU2cKyBL8YRm2v1eA7V4oRKyDaMjSalvk5
	REKZcVbyJll0Bq1BZcNbn9HEYlMJEvyCxnFyaPb4Js9WXbYhCWMSrhFY
X-Gm-Gg: ASbGncuRA1CvlkTW/JPTd80U09/l6jUre5RM8iwly28eYwbvIlJ2x4dhMz6Nqugd28w
	HaxLC89XVHIStG4STT4jPXGOIMQswVXa1zTcBEBUM5NZQy8aluyAaicYeTs6GeMDaBEB1JcDFL8
	9Rnn4B2l/TbmU7p//in+GlUTI0KoCC+586n3Jt2GpA/lOpDAvLH4QsH/UVYBznaw4s14niMHwXf
	xm+uN7NpSHfNrtxhSgqdU78K0izQvxlMXVjuK2bPnJilAIjfGSYv32SsTcfXZbuwRheL11iq86M
	Yn8t5bCnl/AX5rRggaM5jvQZp+xIczEcUiGI5AG6DhnhzD1t4KAoiNfxzj73tGxDB4q4xU6PbBK
	Y/H/utuB95n0W9ROEONrPbrbBOvBCWePn6gNwfh4=
X-Google-Smtp-Source: AGHT+IH4y/6Iq0zfW9g6AJSLX1LxBFAo7VAly5ZDAmUbEoguqqY3ndb1ho4prbEHlBlTfKJpdqtN0A==
X-Received: by 2002:a05:6a21:6d9d:b0:21f:39c9:2122 with SMTP id adf61e73a8af0-2391c92c275mr21531648637.2.1753133409435;
        Mon, 21 Jul 2025 14:30:09 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:7203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb155e0fsm6161227b3a.71.2025.07.21.14.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 14:30:09 -0700 (PDT)
Message-ID: <755dfeb5b02a1d3b5dd8b87a5aeb822628a93996.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Test cross-sign 64bits
 range refinement
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>
Date: Mon, 21 Jul 2025 14:30:07 -0700
In-Reply-To: <7cf24829f55fac6eee2b43e09e78fc03f443c8e5.1752934170.git.paul.chaignon@gmail.com>
References: <cover.1752934170.git.paul.chaignon@gmail.com>
		 <7cf24829f55fac6eee2b43e09e78fc03f443c8e5.1752934170.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-07-19 at 16:23 +0200, Paul Chaignon wrote:

[...]

> The first patch in this series ("bpf: Improve bounds when s64 crosses
> sign boundary") fixes this by refining ranges before we reach the
> condition, such that the verifier can detect the jump is always taken.
> Indeed, at instruction 7, the ranges look as follows:
>=20
>     0          umin=3D0xfffffcf1                 umax=3D0xff..ff6e  U64_M=
AX
>     |                [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]        |
>     |----------------------------|------------------------------|
>     |xxxxxxxxxx]                                   [xxxxxxxxxxxx|
>     0    smax=3D0xeffffeee                       smin=3D-655        -1

I'd move this diagram to the selftest itself.

>=20
> The updated __reg64_deduce_bounds can therefore improve the ranges to
> s64=3D[-655; -146] (and the u64 equivalent). With this new range, it's
> clear that the condition at instruction 8 is always true: R3's umax is
> 0xffffffff and R0's umin is 0xfffffffffffffd71 ((u64)-655). We avoid the
> dead branch and don't end up with an invariant violation.
>=20
> Link: https://syzkaller.appspot.com/bug?extid=3Dc711ce17dd78e5d4fdcf [1]
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>  .../selftests/bpf/progs/verifier_bounds.c     | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index 63b533ca4933..d104d43ff911 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -1550,4 +1550,27 @@ l0_%=3D:	r0 =3D 0;				\
>  	: __clobber_all);
>  }
> =20
> +SEC("socket")
> +__description("bounds deduction sync cross sign boundary")
> +__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
> +__retval(0)
> +__naked void test_invariants(void)

Could you please check deduced range with __msg?

> +{
> +	asm volatile("			\
> +	call %[bpf_get_prandom_u32];	\
> +	w3 =3D w0;			\
> +	w6 =3D (s8)w0;			\
> +	r0 =3D (s8)r0;			\
> +	if w6 >=3D 0xf0000000 goto l0_%=3D;	\
> +	r0 +=3D r6;			\
> +	r6 +=3D 400;			\
> +	r0 -=3D r6;			\
> +	if r3 < r0 goto l0_%=3D;		\
> +l0_%=3D:	r0 =3D 0;				\
> +	exit;				\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

I think two more test cases are needed:
- when intersection is on the other side of the interval;
- when signed and unsigned intervals overlap in two places.


