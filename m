Return-Path: <bpf+bounces-27194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6628AA687
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 03:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26A81F224F1
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 01:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC60C110A;
	Fri, 19 Apr 2024 01:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="couqYnEY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361810E3
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 01:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713489890; cv=none; b=k8+aUCn/bUm3QNEK/gg9ZjtM87cxbdwDVYW/iH3DOuBAd3UiZradHRC5If1T9MjnA1AwD0j5PtBuIDsgigtGXx1uFzzoy8kJ2pCr7A1k4Y+KUd1NMQ/utcHe8XVumDd6qGUYAxNIlS7Lizqc5ZBJ6LMxyfFnqq75dDGPK5K6qx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713489890; c=relaxed/simple;
	bh=4+ARyZyYVG7qfXxxuZ+cWpUBtbJ0+jUsDACZct66nTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gBJi1HVYzhEEpga4k5+/a10emZ0cIU9nLSjtpz7mwGKsaOKo0EuB5mem0hVRAj5fonj2V/9+b8pnML69PbaqVfhhqNf8rRbEcm7rdmDcZGprnG1y1CHBu1YWPOndA3FP78j6XzGma68EonDfDD/tmW6mOp5X2UkpJXYSqXpWfL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=couqYnEY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e5715a9ebdso13096445ad.2
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 18:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713489888; x=1714094688; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hbr+BQwJjOz6HAMjikGn7yXIJamm091qkMQqHc3BRBs=;
        b=couqYnEYHvdsdgigjD6o8f3lCAG42VqOe1eStBpvwG9nffRAXjVlZj7i8knxD/15vx
         MzKmeANy4MqgGTjMk8Rjnurz1Fd2LAYT8BUSPAPsX9t16D9a3cddhSHGVdQ27sMkEqwb
         HJh+OKYG3/PSQIp6FpoS5rU3YXKGZnloX7YVOU0HTxieeG4CQZ+X1DTR7BoGTd/3p01E
         I+5+g3HvC9hIcIFlpRHdIkcfWIUCXrglLKtIMRgE4AIo9Tm39RiwZIpTWP2Ij/cYep5P
         KAxZxMNpQHF05u5lD+/bOpZzx9N87OJv6eM5TdJ/VbXFs/yyO2FKfuwLQfsyW6z8mZA6
         PxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713489888; x=1714094688;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hbr+BQwJjOz6HAMjikGn7yXIJamm091qkMQqHc3BRBs=;
        b=TjRFxWJX+4ZBerwA2koJKMdwYxtNVosAKcWQSlG9rJJEWYf10wnWK78u2app9++K67
         xooQOXXSiTJsHqk9RLQBgOQ+kxuMrx7HcmwAs9R0Wrc730pvqNnFPPb8a5FSzxBLxmwo
         UnnFiMtxGXi77dXnIk8LhsCRaDzX+BQAnJoB+civo7sqMMlPDlwT5iQFDlFN/OicQfk5
         9UCGdmLRyD7y83h72PdDXHVGbyBV5ay2bwAkHNKe6ztZVll8QpbrVeXUJ9hR0KbH4qcT
         WM7Ar4XhCkPh0AJFZlW6RfJ3sta/Of94Wv1JkXN/OszYA/51tBTJCPFoko+Mimy4kvN/
         voxw==
X-Forwarded-Encrypted: i=1; AJvYcCWAFjChJoIg6u+X8Ya10CVw0WqDZyU9uxLtG0DO97nW/KjXId5fcF75Vttm7HQtLxzJdFpGPjlkDW6yWoWQyc44akS5
X-Gm-Message-State: AOJu0YyHSUF3nbOEPjzlQiYXt27wEpvJv17IbLtQXSsy3m5jVGubJmZr
	kBA6hXOdoiWduBI0R+kJFY890tT8m+IF/f7xOhRBFGbtTxhOPXvUDYttlhxF
X-Google-Smtp-Source: AGHT+IHTA8P0htEQfCmre9B2Sz/GK/sr0J1fZ7a3kMbzEbYr2EuaXm9jQnV75/Qszs5GNbC/xF+IVA==
X-Received: by 2002:a17:903:32c5:b0:1df:f681:3cd8 with SMTP id i5-20020a17090332c500b001dff6813cd8mr968419plr.12.1713489888134;
        Thu, 18 Apr 2024 18:24:48 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:ad05:9ec6:fc65:cf63? ([2604:3d08:9880:5900:ad05:9ec6:fc65:cf63])
        by smtp.gmail.com with ESMTPSA id kj12-20020a17090306cc00b001e558d0f00esm2172196plb.82.2024.04.18.18.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 18:24:47 -0700 (PDT)
Message-ID: <8a4deb9d5bbdce4699d8891f205b5894a2cbe59b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] selftests/bpf: XOR and OR range
 computation tests.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, Elena
 Zannoni <elena.zannoni@oracle.com>
Date: Thu, 18 Apr 2024 18:24:46 -0700
In-Reply-To: <20240417122341.331524-4-cupertino.miranda@oracle.com>
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
	 <20240417122341.331524-4-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-17 at 13:23 +0100, Cupertino Miranda wrote:

[...]

> +SEC("socket")
> +__description("bounds check for reg32 <=3D 1, 0 xor (0,1)")
> +__success __failure_unpriv
> +__msg_unpriv("R0 min value is outside of the allowed memory range")
> +__retval(0)
> +__naked void t_0_xor_01(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];                    \
> +	r6 =3D r0;                                        \
> +	r1 =3D 0;						\
> +	*(u64*)(r10 - 8) =3D r1;				\
> +	r2 =3D r10;					\
> +	r2 +=3D -8;					\
> +	r1 =3D %[map_hash_8b] ll;				\
> +	call %[bpf_map_lookup_elem];			\
> +	if r0 !=3D 0 goto l0_%=3D;				\
> +	exit;						\
> +l0_%=3D:	w1 =3D 0;						\
> +	r6 >>=3D 63;					\
> +	w1 ^=3D w6;					\
> +	if w1 <=3D 1 goto l1_%=3D;				\
> +	r0 =3D *(u64*)(r0 + 8);				\
> +l1_%=3D:	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_map_lookup_elem),
> +	  __imm_addr(map_hash_8b),
> +	  __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +

I think that this test case (and one below) should be simplified,
e.g. as follows:

SEC("socket")
__success __log_level(2)
__msg("5: (af) r0 ^=3D r6                      ; R0_w=3Dscalar(smin=3Dsmin3=
2=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D(0x0; 0xff))")
__naked void non_const_xor_src_dst(void)
{
	asm volatile ("					\
	call %[bpf_get_prandom_u32];                    \
	r6 =3D r0;					\
	call %[bpf_get_prandom_u32];                    \
	r6 &=3D 0xff;					\
	r0 &=3D 0x0f;					\
	r0 ^=3D r6;					\
	exit;						\
"	:
	: __imm(bpf_map_lookup_elem),
	  __imm_addr(map_hash_8b),
	  __imm(bpf_get_prandom_u32)
	: __clobber_all);
}

Patch #2 allows verifier to compute dst range for xor operation with
non-constant src and dst registers, which is exactly what checked when
verifier log for instruction "r0 ^=3D r6" is verified.
Manipulations with maps, unpriv behavior and retval are just a distraction.

