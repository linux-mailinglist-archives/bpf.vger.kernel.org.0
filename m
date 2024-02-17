Return-Path: <bpf+bounces-22219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF95859149
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 18:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C488B2106A
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 17:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A657D40A;
	Sat, 17 Feb 2024 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G44dgI+A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B57CF0D
	for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708190062; cv=none; b=SFAo0elEU2fSoV3hrqrrXVlb4ezamBREagdu8fNhi888rUcsmVhAvTfgD3vEEhd7sjjLsZ7sn1rA493+6Xq2tQwkewEiUc1ITJZ5Uw/2/xLDLpTeulJGPPjQRDqozCyiqVqvuGYbMpR/OmIhpYH0KBHjX4FqrxtpqORJU7jhsRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708190062; c=relaxed/simple;
	bh=E+3s/zHuHem2A9+Cl2adcXukc2aF5J2c/px2Qs7uT4c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eGhwQbZU6HuUxuRZotB5Jelg1THW2UkLlELVIwtFSJc25SBp8eGR6ObM/Fph+8XjmWADeT4WDN/3yczMZbqp1L3yQZHHJ3NTONZEm2RFiyYNvtNc+U4DMN4GHq87/iYiyHtqRUtRvMVIm1T5946W7bGB94bBFkk+xmgFZBI9bhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G44dgI+A; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so382942966b.0
        for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 09:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708190059; x=1708794859; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FeTdpIVpXum13UyaR+7W8C9Rhhj8/sabQao81ro69pY=;
        b=G44dgI+AufwBdYo/dwYXLYjhXcGHSNLcZThlOiY77KerG/6V/9/4UY/3uh1VfnfkgS
         25fTsPoRB4vuZxUlmDDcfK5NMso1qdVo3uxq0UTV5VVrsfnOFMgwocKMG9r8K8Ts91kP
         fnluZsSQGuE3Ave9SWE0EQIpuIzViXj5bOHqUhWJyBg7TUON8s7+FPMcqfROy6j9IFII
         rc1lRgyKOiR9z2rjrx7ZOdcNNNZ7jz08MHkh+3vqUMgLiq0lhxsXw2k2tdINzlTpBHZl
         9WTApqJ49fpmo2DbUlgzqAIWzF036IEyRbiU9xb2Qz5HbFHP21kwVW3mQnxslk+dEEzA
         ThRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708190059; x=1708794859;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeTdpIVpXum13UyaR+7W8C9Rhhj8/sabQao81ro69pY=;
        b=IGJYjQph9poibhW2A/m921Aehjc1PXcAUQxvPqPIbwjKHMbM3WQK8G4GuCR+hOROgT
         fCeF35JOP3FXNnh2eurmhTZ/MJcdLZS3DPDfhrbQoWavbZO++f50b09m+xc3nZmW9XG2
         Vid4+D8OcVpdW0FwGe8Sd7t3TGQYiVQTBYL8ftmi/uFHU+1Md4exdKfbzolt//k3N1iQ
         iK+Grlr9aU0PfGujfBI6cpTwbbcd0N09DcwxC29Z+17BS//VReCaeXnnfmCkMXALHc5z
         oJiSlCuWCsQ2J81aLbaKFD5LGGTKwweWTaPkH9U3uyGzm0sB0TfREoFEdSR1EjGsLnwZ
         GcBA==
X-Gm-Message-State: AOJu0YzKuE46DOj509HogsCjLeCQRVYN3HZCcbJyO8145UlPmnvS6cv5
	3EKAoVlOR9Jnpmm7gWZhlamHcgJyN0qRDdXH9zJa76IQ/Q/nTPpu
X-Google-Smtp-Source: AGHT+IGdBM1tNUBzqtzTZJeinFvmapMIpJrLPtlZT9etN1XVu0CLsdu6xiHgt/LhjyaLDm0XmEmCSg==
X-Received: by 2002:a17:907:119c:b0:a3d:4037:73e7 with SMTP id uz28-20020a170907119c00b00a3d403773e7mr5308914ejb.48.1708190058665;
        Sat, 17 Feb 2024 09:14:18 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id wb8-20020a170907d50800b00a3d9b0e41e6sm1127715ejc.205.2024.02.17.09.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 09:14:18 -0800 (PST)
Message-ID: <d047300b335b962d660b809e18bac0b3213ce187.camel@gmail.com>
Subject: Re: [RFC PATCH v1 05/14] bpf: Implement BPF exception frame
 descriptor generation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, David Vernet
 <void@manifault.com>, Tejun Heo <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>,
 Dan Williams <djwillia@vt.edu>,  Rishabh Iyer <rishabh.iyer@epfl.ch>,
 Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Date: Sat, 17 Feb 2024 19:14:17 +0200
In-Reply-To: <CAP01T754eL=NRWDk-Q-YsV9uWa1pkYaeXvjzy1SWG+A1HjQDsA@mail.gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-6-memxor@gmail.com>
	 <ff88196b95f3f05e8fa2172c101cb29a55a9c3f2.camel@gmail.com>
	 <4ef073e2cf3f5b3c7094e81593001ff068ee9f64.camel@gmail.com>
	 <CAP01T754eL=NRWDk-Q-YsV9uWa1pkYaeXvjzy1SWG+A1HjQDsA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-16 at 23:06 +0100, Kumar Kartikeya Dwivedi wrote:
[...]

> I will add tests to exercise these cases, but the idea for STACK_ZERO
> was to treat it as if we had a NULL value in that stack slot, thus
> allowing merging with other resource pointers. Sometimes when NULL
> initializing something, it can be marked as STACK_ZERO in the verifier
> state. Therefore, we would prefer to treat it same as the case where a
> scalar reg known to be zero is spilled to the stack (that is what we
> do by using a fake struct bpf_reg_state).

Agree that it is useful to merge 0/NULL/STACK_ZERO with PTR_TO_SOMETHING.
What I meant is that merging with 0 is a noop and there is no need to
add a new fd entry. However, I missed the following check:

+ static int gen_exception_frame_desc_reg_entry(struct bpf_verifier_env *en=
v, struct bpf_reg_state *reg, int off, int frameno)
+ {
+ 	struct bpf_frame_desc_reg_entry fd =3D {};
+=20
+ 	if ((!reg->ref_obj_id && reg->type !=3D NOT_INIT) || reg->type =3D=3D SC=
ALAR_VALUE)
+ 		return 0;

So, the intent is to skip adding fd entry if register has scalar type, righ=
t?
I tried the following test case:

SEC("?tc")
__success
int test(struct __sk_buff *ctx)
{
    asm volatile (
       "r7 =3D *(u32 *)(r1 + 0);		\
	r1 =3D %[ringbuf] ll;		\
	r2 =3D 8;				\
	r3 =3D 0;				\
	r0 =3D 0;				\
	if r7 > 42 goto +1;		\
	call %[bpf_ringbuf_reserve];	\
	*(u64 *)(r10 - 8) =3D r0;		\
	r0 =3D 0;				\
	r1 =3D 0;				\
	call bpf_throw;			\
    "	:
	: __imm(bpf_ringbuf_reserve),
	  __imm_addr(ringbuf)
	: "memory");
    return 0;
}

And it adds fp[-8] entry for one branch and skips fp[-8] for the other.
However, the following test passes as well (note 'r0 =3D 7'):

SEC("?tc")
__success
int same_resource_many_regs(struct __sk_buff *ctx)
{
    asm volatile (
       "r7 =3D *(u32 *)(r1 + 0);		\
	r1 =3D %[ringbuf] ll;		\
	r2 =3D 8;				\
	r3 =3D 0;				\
	r0 =3D 7;	/* !!! */		\
	if r7 > 42 goto +1;		\
	call %[bpf_ringbuf_reserve];	\
	*(u64 *)(r10 - 8) =3D r0;		\
	r0 =3D 0;				\
	r1 =3D 0;				\
	call bpf_throw;			\
    "	:
	: __imm(bpf_ringbuf_reserve),
	  __imm_addr(ringbuf)
	: "memory");
    return 0;
}

Which is probably not correct, as scalar 7 would be used as a
parameter for ringbuf destructor, right?

