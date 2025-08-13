Return-Path: <bpf+bounces-65532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C65B252C7
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 20:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26B734E153D
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 18:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9272BAF9;
	Wed, 13 Aug 2025 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt+Q7ZnA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B23242909
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108490; cv=none; b=BqlyTLhrc8Ch/tQAxyQfvZnJht3dXtGoF03KnqzVEjv6M2WW4ca8ts/XmI9JljE0N8/i3jt2N2QUt1+CLzrG/kYmrfAY7mRhXshHCQ9x/VL8FMU7/eIHYaxrcSeshCVT7chotwJgi6mdxba4HnSfN6JGD8VgosrhWKYIrJfrjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108490; c=relaxed/simple;
	bh=1J/dLj7n1DJApGikkN1a6j6APgTvZbqn723HBFzlXoA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NqhEgSuscYudmLjbeNAtXn7ZTSMmf+T5pB4oVm1/80aVUVgtpir2f3lsEH69C4AJsYc0lnEwRTHA9R2Ae2Fyo2uPI+sdLYFRr32ie9K2VC9dd77i8IO3M2HiqyO9Gnc86lCO0bGzqpYXYR6F7h4xKns8NrIXPmo5nFbxw6PQSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kt+Q7ZnA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24458194d83so332535ad.2
        for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755108488; x=1755713288; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IY3jdWMmEJP2fClmeXmsavRVE0Tv/gipQCiFQoR7NSk=;
        b=Kt+Q7ZnAI7vX/8cvOphvpA7UVdyK+Ea7KGAIZkHhi3FP7sUAXgYQM9fo0S9RJajGQn
         fq4SUqLV5py1QAnM8QtLHA+btTfqj7Ox8snegahs31MywY9A3ytgrslIaGtIkDo8RTYz
         sg02jKTEWEd5A6btb50TtC7WGZet765DjGGDA2yEBTqgDWsgHSIqhrfkFQYkd5T1MHac
         YXjRyAR0tzRO24VhRDnB+rhF6gEvvv7WcND8bteoFDZ646UIEbAaZzqRK8Mbe8i4H8yQ
         qtpE/6La3Nq47HUmMpaloKiNqPlsJe1ImWnxS2zk0SwlAxxNtWsuAVLcwQ+j8tKxSTOd
         EtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755108488; x=1755713288;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IY3jdWMmEJP2fClmeXmsavRVE0Tv/gipQCiFQoR7NSk=;
        b=u05Q2FiVQkbOwivjIqMgEemTjfSBuRQGArfiaTuexn2b/Zy96HvixiFTW/Rdve3n2f
         pZVmC4bYQRk4U+E1a+pVF1ROps6REer1uvvDltPXqF6QZkLjK78Q7QD4uVzURMBi4kBU
         LN+EjVUN5rEDOnfmmWGUZ66CJVV+cOYRdktHh01lvVBtmLRBRTqfHlmUWKNPRwnIRfe8
         YpEpVvTJn+EBnUHeVFhr1SjyH+NPBx4PKPnLdGEfAbtHQJbtw+s1JL8OvKKPaInRSuR5
         rgfueIBogarE5rHmTuCjOAZ6SenfMYlml5wF6twNVzd0ZLL+P057YAgRja6+ITXmUUzL
         kSpw==
X-Forwarded-Encrypted: i=1; AJvYcCXvRz2SulN5QMKilPxbZs6qzrjH5Rpm4f6gVz4s+ajqMwRFMeYH5980X2p4VHasJ6XwuHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzVeGdSCOpViIVwytPBXgWKNTrT8T4ISTOxIgMxILGD4gGqFrI
	cq149DF8F3bDnZGn1aGawCvEpkm+8ysFn+c5JABvIHz9mih2oQQ7wH6f
X-Gm-Gg: ASbGnctuf8sXwknS5DeS+TxGNNRxkpjk1R7XNyobw0Iumwj0Z8nguhBtYmjm4qYv1Mr
	yH7T7RxMK2v0zXWZtudWUp43pWTRYksJZUocMUjs0KL0DoO5o+fB03TPuHyxYLHCdR21A1dfTXT
	EB+oJqy9hLj6f8fmSom7e6xKtiQdbHEeahz0TAU6PluYr0Gea0SjpUbebVZCciHX8UGSCUeBaNx
	NdWL0DtnqUyj+lb0/GEk7PEjPR6ELUNOXjpXpOMC3tha8Hxv4WSGlngiUFKJQf6W8y/h6gZt3T2
	FWH4DF03KO3crAjtTVHWp7/mMKX9Dz9SK1MrIyw7Ufjw+U997iXtHLBrR/HH+7RSS32uiVtkz2J
	fDtizjgKDGIV399CUSkj71k/WRoJ84b6h8Pr7Alc=
X-Google-Smtp-Source: AGHT+IEyX1cIoCYub1+/jIxYWYkL418CXzmZEe27qtnfDBL0lXoC4JEFAW8Mo22hSWfo8rveK6uCfA==
X-Received: by 2002:a17:902:ce12:b0:240:c9b6:f8ee with SMTP id d9443c01a7336-244586f2aadmr127115ad.50.1755108488315;
        Wed, 13 Aug 2025 11:08:08 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::e47? ([2620:10d:c090:600::1:68a4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef5934sm330339465ad.21.2025.08.13.11.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 11:08:07 -0700 (PDT)
Message-ID: <814ea1fd4f2186b62a03d5ce195a97ee1446771d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Use tnums for JEQ/JNE is_branch_taken
 logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Wed, 13 Aug 2025 11:08:05 -0700
In-Reply-To: <ba9baf9f73d51d9bce9ef13778bd39408d67db79.1755098817.git.paul.chaignon@gmail.com>
References: 
	<ba9baf9f73d51d9bce9ef13778bd39408d67db79.1755098817.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-13 at 17:34 +0200, Paul Chaignon wrote:
> In the following toy program (reg states minimized for readability), R0
> and R1 always have different values at instruction 6. This is obvious
> when reading the program but cannot be guessed from ranges alone as
> they overlap (R0 in [0; 0xc0000000], R1 in [1024; 0xc0000400]).
>=20
>   0: call bpf_get_prandom_u32#7  ; R0_w=3Dscalar()
>   1: w0 =3D w0                     ; R0_w=3Dscalar(var_off=3D(0x0; 0xffff=
ffff))
>   2: r0 >>=3D 30                   ; R0_w=3Dscalar(var_off=3D(0x0; 0x3))
>   3: r0 <<=3D 30                   ; R0_w=3Dscalar(var_off=3D(0x0; 0xc000=
0000))
>   4: r1 =3D r0                     ; R1_w=3Dscalar(var_off=3D(0x0; 0xc000=
0000))
>   5: r1 +=3D 1024                  ; R1_w=3Dscalar(var_off=3D(0x400; 0xc0=
000000))
>   6: if r1 !=3D r0 goto pc+1
>=20
> Looking at tnums however, we can deduce that R1 is always different from
> R0 because their tnums don't agree on known bits. This patch uses this
> logic to improve is_scalar_branch_taken in case of BPF_JEQ and BPF_JNE.
>=20
> This change has a tiny impact on complexity, which was measured with
> the Cilium complexity CI test. That test covers 72 programs with
> various build and load time configurations for a total of 970 test
> cases. For 80% of test cases, the patch has no impact. On the other
> test cases, the patch decreases complexity by only 0.08% on average. In
> the best case, the verifier needs to walk 3% less instructions and, in
> the worst case, 1.5% more. Overall, the patch has a small positive
> impact, especially for our largest programs.
>=20
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Note: CI reports verifier performance differences for Meta internal program=
s:
      https://github.com/kernel-patches/bpf/actions/runs/16942287206
      But I can't confirm the difference after running veristat for these p=
rograms,
      looks like a CI glitch.

[...]

