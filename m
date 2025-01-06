Return-Path: <bpf+bounces-48000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C32B4A030C8
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 20:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA2A3A1179
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 19:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C661DFE3A;
	Mon,  6 Jan 2025 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="LH+75nj7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712D1DFE24
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192088; cv=none; b=Del+If8jDKQ2QKVox8ncTQ40khizFfaRfgyRqtw0thbvYg1UhR9f7A4l2ZIjQu5AcbKGOZJ2vYHna0mIMmVctZxZ/8A9DoG8aYqmAKnZ5335hyNheZ1jAOakGS8wN3C3GdSGW/8qUWfpbei7EGUhEh/KsP12fpozV7XV2cwUVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192088; c=relaxed/simple;
	bh=VPSBy0F0aXMR+9SNy3//E13NLlopb819I32QmKi2XeE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoXRUcSQRvzJS7Mfp5xqQWdbfILJuAAGQGzt4pLuutO0UTOVuAHXnYMED1P8VWbSCXl3vxtwYo68EDKJAtyat+5AzkHfWM1bgJQ2tyjJ/yvJ2Hv5E1GM11BfCLkN1dVrWHuMOGjFrDAbKljR0PvjCVb3HwgZ6zL+Xvzhem2ooqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=LH+75nj7; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736192078; x=1736451278;
	bh=VPSBy0F0aXMR+9SNy3//E13NLlopb819I32QmKi2XeE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=LH+75nj7Py7HwPEqQB4b0c0qP9VN27yZWqyLm3hZn1Tqrn7E3cV4VoiwPR7+LGXsY
	 5vAuJPgRO5ALiS6ldvqFEsAp19wsjeyjm1+iKdPKA0olMIl+TZH8tsJV808EfXhYEk
	 jaxKLxkrlMkNFCD5Ba2Ic0VRK/Z0ikJpXCANeiYPandftqibg7Ze+EtedIbeBVScGP
	 RV70gbA9by05RBxhBwIzWAiptng9KGJMd/TUN2dsYiLsDe5XAfXK/caVQLTe+rXTuG
	 5JK/HNoZSwYJ69yzTeulTsSLLFq0T71LIZad7OvMNfXoE0ulAtEJZRoBNK5LHhcQct
	 CZasIwJnmkUnw==
Date: Mon, 06 Jan 2025 19:34:33 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, jose.marchesi@oracle.com, andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com
Subject: Re: [PATCH v2] selftests/bpf: workarounds for GCC BPF build
Message-ID: <_iRPq_xemaHzEiT7RlozNHzK7cBYOQKS5PB7o6BPGPeMSp_YHLFxe6p6kx1iLtpVtP12MK63_ww8hdttWuszfjeZHXLAUvzRZiLlWPjt6aw=@pm.me>
In-Reply-To: <cDuMNyzpES4mR0L6PV40Mg32zr89vCZaKhawXaDo_rgN4cI8GsNiR1gf-eSFuiFgwMpl8ghk0k9U22b0lurlLyq6WWmNAhotqbSwse2KsWc=@pm.me>
References: <20250106185447.951609-1-ihor.solodrai@pm.me> <4b01f799f25062513fcdb5b64c5d791247b1ee48.camel@gmail.com> <cDuMNyzpES4mR0L6PV40Mg32zr89vCZaKhawXaDo_rgN4cI8GsNiR1gf-eSFuiFgwMpl8ghk0k9U22b0lurlLyq6WWmNAhotqbSwse2KsWc=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 9daa1976b4d52e06f7570e3e9baa3d6d176784e5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, January 6th, 2025 at 11:21 AM, Ihor Solodrai <ihor.solodrai@pm.m=
e> wrote:

>=20
> [...]
>=20
>=20
> I was wondering how clang handles this, and it turns out
> -fno-strict-aliasing is true by default in clang [1]:
>=20
> -fno-strict-aliasing Disable optimizations based on strict aliasing rules=
 (default)
>=20
> [1]: https://clang.llvm.org/docs/UsersManual.html

Whoops, that's about clang-cl, sorry.

Assuming clang does check for aliases, I guess it means clang just
doesn't detect these violations.

>=20
> > > # Some utility functions use LLVM libraries
> > > jit_disasm_helpers.c-CFLAGS =3D $(LLVM_CFLAGS)
> > >=20
> > > @@ -507,7 +511,7 @@ endef
> > > # Build BPF object using GCC
> > > define GCC_BPF_BUILD_RULE
> > > $(call msg,GCC-BPF,$4,$2)
> > > - $(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O=
2 -c $1 -o $2
> > > + $(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O=
2 -std=3Dgnu17 -c $1 -o $2
> > > endef
> > >=20
> > > SKEL_BLACKLIST :=3D btf__% test_pinning_invalid.c test_sk_assign.c

