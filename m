Return-Path: <bpf+bounces-12627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A444B7CEC7C
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 02:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A40B20F4F
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 00:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D721391;
	Thu, 19 Oct 2023 00:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqqKTGGg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A49442
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 00:00:34 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42168115
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 17:00:29 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53e16f076b3so495591a12.0
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 17:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697673627; x=1698278427; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c08Scj2xXGChcdKkX8dYJ98/oNBmdDjcnPAtJLMx7mU=;
        b=HqqKTGGg8fORdHAMoNpmEpVN5fz7jPTvzozlDGNG2Uyuyov/RDajDwTVzqiFENtrlI
         s6LwvgR0fHgBLQvwXksDPwpmMtAAotyd+O0iC2Ue386aEJk1SUtvFC5AShN57BQc/E86
         RTQV5Al49dOq/27FnHZSoOUP3CZGV0AWNFPfPIlEs17/5YWcssXYmBfL5TeLyBcCYqhZ
         r3ACc3Y5WQkIN4Rq1eLtwqnnvFmUcpFMus1T1e0NukDHyaissGbbYil7hvTVkKzOsG8A
         P/qcBh1P1+ByGpPBJq8IK4zNwN1zX3D3ONLggStZhe/K3DHriK89J3k6XKdIjoBrAZd7
         v/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697673627; x=1698278427;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c08Scj2xXGChcdKkX8dYJ98/oNBmdDjcnPAtJLMx7mU=;
        b=rxnRoVgqfcM/KxxInPCOttHustZDPzp2Tndt9b5PvtzOdshOtJ3/uu6HYLOrv5S7DT
         ReEzK46Ad4MT27DMFhkKiNkY32Kqg3lUAAvctlwWnD4kbhfDp0yOn5mCEl/deqX03KoV
         jZNz37XUMS7wzb0y4pDbUV2YZ/qEt0R0oREFlUq7ctTGAAhabPFfHUOnMRGLjMBT64IG
         Sn6D78aom2/4aUDH1GljRnbKCaQSG006MfcTmyFpLQxnTdIsq76kUjQwU9+6nWDdGLl0
         O+t9zIOWZUNsPxCfAAIX3kFJTFkKSd+M7HIThu5I5x/GEc0zcSO8dXyeGM4bcH4uZR2+
         EqnQ==
X-Gm-Message-State: AOJu0YwjLdqK8aYr6tXlaXmMKZriOvqZssurnrfMEF6KvNWVsJ7S4/il
	T0ptxa0AJOZbYFVUqjP74dI=
X-Google-Smtp-Source: AGHT+IHvWtBH8BCkj5CtwGPMJvS2IY6R5NhZh5FeNQLJdo4RIEOB8iRbG+tOlJKAOsX48cbzzwfSLQ==
X-Received: by 2002:aa7:c589:0:b0:530:cc8c:9e41 with SMTP id g9-20020aa7c589000000b00530cc8c9e41mr279045edq.19.1697673627348;
        Wed, 18 Oct 2023 17:00:27 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a93-20020a509ee6000000b00536159c6c45sm3524198edf.15.2023.10.18.17.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 17:00:26 -0700 (PDT)
Message-ID: <e51603c98e2abe061b75fe8ac9854b1678a64aef.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf, docs: Define signed modulo as using
 truncated division
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Dave Thaler
	 <dthaler1968@googlemail.com>, bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Date: Thu, 19 Oct 2023 03:00:26 +0300
In-Reply-To: <e2943b75-e47a-01f2-6b3f-a3ce666008cd@iogearbox.net>
References: <20231017203020.1500-1-dthaler1968@googlemail.com>
	 <d1a0907588e9d809aebba260377b6188897bd383.camel@gmail.com>
	 <e2943b75-e47a-01f2-6b3f-a3ce666008cd@iogearbox.net>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-10-19 at 01:40 +0200, Daniel Borkmann wrote:
> On 10/19/23 12:34 AM, Eduard Zingerman wrote:
> > On Tue, 2023-10-17 at 20:30 +0000, Dave Thaler wrote:
> > > From: Dave Thaler <dthaler@microsoft.com>
> > >=20
> > > There's different mathematical definitions (truncated, floored,
> > > rounded, etc.) and different languages have chosen different
> > > definitions [0][1].  E.g., languages/libraries that follow Knuth
> > > use a different mathematical definition than C uses.  This
> > > patch specifies which definition BPF uses, as verified by
> > > Eduard [2] and others.
> > >=20
> > > [0]: https://en.wikipedia.org/wiki/Modulo#Variants_of_the_definition
> > > [1]: https://torstencurdt.com/tech/posts/modulo-of-negative-numbers/
> > > [2]: https://lore.kernel.org/bpf/57e6fefadaf3b2995bb259fa8e711c7220ce=
5290.camel@gmail.com/
> > >=20
> > > Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> > > ---
> > >   Documentation/bpf/standardization/instruction-set.rst | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > >=20
> > > diff --git a/Documentation/bpf/standardization/instruction-set.rst b/=
Documentation/bpf/standardization/instruction-set.rst
> > > index c5d53a6e8c7..245b6defc29 100644
> > > --- a/Documentation/bpf/standardization/instruction-set.rst
> > > +++ b/Documentation/bpf/standardization/instruction-set.rst
> > > @@ -283,6 +283,14 @@ For signed operations (``BPF_SDIV`` and ``BPF_SM=
OD``), for ``BPF_ALU``,
> > >   is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and=
 then
> > >   interpreted as a 64-bit signed value.
> > >  =20
> > > +Note that there are varying definitions of the signed modulo operati=
on
> > > +when the dividend or divisor are negative, where implementations oft=
en
> > > +vary by language such that Python, Ruby, etc.  differ from C, Go, Ja=
va,
> > > +etc. This specification requires that signed modulo use truncated di=
vision
> > > +(where -13 % 3 =3D=3D -1) as implemented in C, Go, etc.:
> > > +
> > > +   a % n =3D a - n * trunc(a / n)
> > > +
> > >   The ``BPF_MOVSX`` instruction does a move operation with sign exten=
sion.
> > >   ``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and=
 16-bit operands into 32
> > >   bit operands, and zeroes the remaining upper 32 bits.
> >=20
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> Eduard, do we have some test cases in BPF CI around this specifically (e.=
g. via test_verifier)?
> Might be worth adding if not.

We do, e.g. see tools/testing/selftests/bpf/progs/verifier_sdiv.c:

  SEC("socket")
  __description("SMOD32, non-zero imm divisor, check 1")
  __success __success_unpriv __retval(-1)
  __naked void smod32_non_zero_imm_1(void)
  {
  	asm volatile ("					\
  	w0 =3D -41;					\
  	w0 s%%=3D 2;					\
  	exit;						\
  "	::: __clobber_all);
  }
 =20
And I'm still surprised that this produces different results in C and
in Python :)

  $ python3
  Python 3.11.5 (main, Aug 31 2023, 07:57:41) [GCC] on linux
  Type "help", "copyright", "credits" or "license" for more information.
  >>> -41 % 2
  1
  $ clang-repl
  clang-repl> #include <stdio.h>
  clang-repl> printf("%d\n", -41 % 2);
  -1

There are several such tests with different combination of signs,
both 32-bit and 64-bit.

