Return-Path: <bpf+bounces-34868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26E6931E14
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 02:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02532B21E17
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 00:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D2E4A1C;
	Tue, 16 Jul 2024 00:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNAuNo05"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B95C1876
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721090705; cv=none; b=TOqEBglvFUVixGR45UHOIjWoqLlztcfmUXp8pk1GyRKS5Hiv9X+uZ+BaC/f/EDh2XMNkHchCACvvwqHPCuPpYXnYHtKG6IDLr0hS3klRhbbPdR73ONbBfu/8F35a+wHI47Nj4ncMh+mzQFkzS9rRygTE80eXqeSJ9olSINobDAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721090705; c=relaxed/simple;
	bh=MLQfeGRRG1UwM9+H4BaHjgZtApDhBqBEezIbZj08olA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FmeQYZ5batmDIxJdynFqmqx++guP481IqDNI48gR2G+gpe1MKc1oH1cn/536DVSXa72RHPLmQ1y2jfVlCX1RVgL6gnt6tKOdsMZyep9FlnU9kUT3v+U3PsInqEt8LxWUUlKlaRe/fV/kUE4WwxAenyh/+tn73JSFgY+gLBibeNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNAuNo05; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb64d627b0so25620035ad.0
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 17:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721090703; x=1721695503; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wLuKtng85Xl8wBMFNTjc3g1dFGch+TrI+9tA6zhouIw=;
        b=MNAuNo05Br9v0j/O24jCTkV6SXtEngkD3PnsN2rAmNj83OztuJwm7cavZSmOrw0Wuo
         wtFItxqdC0yo1UeFRgk7fry/Wr91pGL8o9NuvpLfuhh1+BIpyBEaMCa8JZQo+1IkXl3Q
         QE/ZKMyoNpEaDB4cIryXDXXys02/QDXG5cC8qdEzWtrA7ZApcQ625bf9rjzv8EDJNibe
         69wuPWmNXWL2ZlRREqxkmAj3VDg8Rue8otfFRYn0zKRX76VB1ViHRNQvEv4FUStmIzvK
         DVNAyqyMmCraF9atbUWahRZcyGk8BXmBzIpknABYmbBDkb2mIq6QbIhh49HLd16+q1jD
         V4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721090703; x=1721695503;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wLuKtng85Xl8wBMFNTjc3g1dFGch+TrI+9tA6zhouIw=;
        b=LHLGcVoM5Cj616jwI2ZSTEMG/ALKQADIOGAGwZtRMYlOWulk/CJJmTvnI8I2MkSPWO
         QMjUSqmnNeO3gMal7qWyoh95uGXt0xY6/hTbZKFCf3Gmmfiwx2LbrA5H8VF5lfRkrVZd
         +6twu8Q8Feao+kQipzg+2wZAybjjbDvoPApGTlGXzKLNSeIq4LQI6weZOsyJujg7xkKS
         VKmN4AwWB++IQUB7hI3yRfW8WxmGAssEkikiTrC+hj4CvytGclzJowUeT9vqUVWCMJ9u
         cBXm5QgGIneUe4iBVzMv3pH0oIU0y/0T6bATSQNgZDaE+OBlep+rDs503P1LS4r9cVcO
         8Bmw==
X-Forwarded-Encrypted: i=1; AJvYcCU5+t76FK8Ud16UBMZfi/rRT/vLjkJMcjQe89JBo4RbAaS0RSsG9yTpDp/1+RrkR3gJC9vDV8cZrjEue4iCs1Dq1pnt
X-Gm-Message-State: AOJu0YxqwF1C2Z7Xs6JAtbNGm4zSvVhJjvwtOim5rK3/WGOS6KljML5n
	pDPoMxnUatCaVAld5Gtp9LyqmqOe0xd3ezEINa83uG6XMP5MYjs0
X-Google-Smtp-Source: AGHT+IF1RE9LhJr6G9ACkm3tm7yfGSBDXJMwY6nKqMomZ0y+dBual84MvZtmduZZzc6pINPH1CO43A==
X-Received: by 2002:a17:902:ea0d:b0:1fc:327a:1f2f with SMTP id d9443c01a7336-1fc3d9ec621mr3674975ad.45.1721090703030;
        Mon, 15 Jul 2024 17:45:03 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6ffc8sm46734565ad.35.2024.07.15.17.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 17:45:02 -0700 (PDT)
Message-ID: <5ce8b885e35e780d3ec6e730d9be2b45be3fea05.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add ldsx selftests for
 ldsx and subreg compare
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Mon, 15 Jul 2024 17:44:57 -0700
In-Reply-To: <20240712234404.288115-1-yonghong.song@linux.dev>
References: <20240712234359.287698-1-yonghong.song@linux.dev>
	 <20240712234404.288115-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-12 at 16:44 -0700, Yonghong Song wrote:

Note: it feels like these test cases should be a part of the
      reg_bounds.c:test_reg_bounds_crafted(), e.g.:

  diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
  index eb74363f9f70..4918414f8e36 100644
  --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
  +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
  @@ -2108,6 +2108,7 @@ static struct subtest_case crafted_cases[] =3D {
          {S32, U32, {(u32)S32_MIN, 0}, {0, 0}},
          {S32, U32, {(u32)S32_MIN, 0}, {(u32)S32_MIN, (u32)S32_MIN}},
          {S32, U32, {(u32)S32_MIN, S32_MAX}, {S32_MAX, S32_MAX}},
  +       {S64, U32, {0x0, 0x1f}, {0xffffffff80000000ULL, 0x00000000fffffff=
fULL}},
   };
  =20
   /* Go over crafted hard-coded cases. This is fast, so we do it as part o=
f

Which produces the following log:

  VERIFIER LOG:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  ...
  21: (ae) if w6 < w7 goto pc+3         ; R6=3Dscalar(id=3D1,smin=3D0xfffff=
fff80000000,smax=3D0xffffffff)
                                          R7=3Dscalar(id=3D2,smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D31,var_off=3D(0x0; 0x1f))
  ... =20
  from 21 to 25: ... R6=3Dscalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsma=
x32=3Dumax32=3D30,var_off=3D(0x0; 0x1f))
                     R7=3Dscalar(id=3D2,smin=3Dumin=3Dsmin32=3Dumin32=3D1,s=
max=3Dumax=3Dsmax32=3Dumax32=3D31,var_off=3D(0x0; 0x1f)
  25: ... R6=3Dscalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax3=
2=3D30,var_off=3D(0x0; 0x1f))
          R7=3Dscalar(id=3D2,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=3Dumax=
=3Dsmax32=3Dumax32=3D31,var_off=3D(0x0; 0x1f))
  ...

However, this would require adjustments to reg_bounds.c logic to
include this new range rule.

[...]

> +SEC("socket")
> +__description("LDSX, S8, subreg compare")
                     ^^^ ^^^

Nit: test_progs parsing logic for -t option is too simplistic to
     understand comas inside description, for example here is happens
     after the command below:

       # ./test_progs-cpuv4 -t "verifier_ldsx/LDSX, S8, subreg compare"
       #455/1   verifier_ldsx/LDSX, S8:OK
       #455/2   verifier_ldsx/LDSX, S8 @unpriv:OK
       #455/3   verifier_ldsx/LDSX, S16:OK
       #455/4   verifier_ldsx/LDSX, S16 @unpriv:OK
       #455/5   verifier_ldsx/LDSX, S32:OK
       ...

     As far as I understand, this happens because test_progs tries to
     match words LDSX, S8 and "subreg compare" separately.

     This does not happen when comas are not used in the description
     (or if description is omitted in favor of the C function name of the t=
est
      (it is not possible to do -t verifier_ldsx/ldsx_s8_subreg_compare
       if __description is provided)).

> +__success __success_unpriv
> +__naked void ldsx_s8_subreg_compare(void)
> +{
> +	asm volatile (
> +	"call %[bpf_get_prandom_u32];"
> +	"*(u64 *)(r10 - 8) =3D r0;"
> +	"w6 =3D w0;"
> +	"if w6 > 0x1f goto l0_%=3D;"
> +	"r7 =3D *(s8 *)(r10 - 8);"
> +	"if w7 > w6 goto l0_%=3D;"
> +	"r1 =3D 0;"
> +	"*(u64 *)(r10 - 8) =3D r1;"
> +	"r2 =3D r10;"
> +	"r2 +=3D -8;"
> +	"r1 =3D %[map_hash_48b] ll;"
> +	"call %[bpf_map_lookup_elem];"
> +	"if r0 =3D=3D 0 goto l0_%=3D;"
> +	"r0 +=3D r7;"
> +	"*(u64 *)(r0 + 0) =3D 1;"
> +"l0_%=3D:"
> +	"r0 =3D 0;"
> +	"exit;"
> +	:
> +	: __imm(bpf_get_prandom_u32),
> +	  __imm_addr(map_hash_48b),
> +	  __imm(bpf_map_lookup_elem)
> +	: __clobber_all);
> +}

[...]

