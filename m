Return-Path: <bpf+bounces-33903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A46927C2E
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 19:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7549AB2444E
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 17:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7204E3BB23;
	Thu,  4 Jul 2024 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAHOjI0m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3963B782
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720113904; cv=none; b=Y/4jPHq5jZDsOjq+2/+BYTm1R1xWIGBC+Ck51XXYTxuXRsDj8zUC8dpc7Bh5t3897nRuATmYCruXTtZVdEUQSj2mTe4MGcHNG76Mtk89POkK/F6M2HJmoY0hL0My9qv9i9fxLFdHnyQjXG7Y4UrEgGqf/0EDnOisLji2OYEeJGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720113904; c=relaxed/simple;
	bh=+8jnL8MZgxd1mSGdEOgF7vJ164BFkqv3utIEl4GQoBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OqyQOeEbTWkMLxp6dKOzwD/dPcuBSOwtLXANO0t9tX0gFRHnuTZpSAantEkj4XFpRqmg9hPg3yQ4CSegug8OgcTp/CvZAqJNCf2KwTeoFRsRLnyypk1Lsj0+28RIbUwQx/sGAFWSY9NEjYn/e5My38NaeDLi1rB4pkxSUnLVs3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAHOjI0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE8DC3277B;
	Thu,  4 Jul 2024 17:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720113903;
	bh=+8jnL8MZgxd1mSGdEOgF7vJ164BFkqv3utIEl4GQoBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OAHOjI0mK8kD7q9/Sb4Bfet4Ok8/dHfuYvrVBa717ye96S2aQZvbjCWL3wlXtiL8k
	 Vahx7KiJr9IjUbBdUp6xbGLLRG8EQYF/VvsE4HBtwwkccbKZ01JGVjSzOTDCrtvjCA
	 ApKRSO76bQ516JKvApqcMe5Ve+CtHUorQgHRPNxLC65WFgnOFh1JCokccMrX1IUjc7
	 U7DX3FCbgN+WdGKKXJWSaLskEybxdIv8Qr0aOIjTk2YONbkr9K/naIjOU+epiLl4Nn
	 GCT/7Nx7w8dgx915QdsyQ/vfsd+Z5RNzWJky+iBOu4YkxAUGnGDU9zvn4zcVIeSBfT
	 v0YuW+LqYZkgg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, jose.marchesi@oracle.com
Subject: Re: [RFC bpf-next v1 3/8] bpf, x86: no_caller_saved_registers for
 bpf_get_smp_processor_id()
In-Reply-To: <133f0ecd9ecd92268169034d329e87d22118588e.camel@gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
 <20240629094733.3863850-4-eddyz87@gmail.com>
 <CAEf4BzangPmSY3thz6MW5rMzcA+eOgjD4QNfg2b594u8Qx-45A@mail.gmail.com>
 <ab7694e6802ddab1ea49994663ca787e98aa25a1.camel@gmail.com>
 <CAEf4Bza7nmnFDvuPLU2xRQ-mZifUKLSiq3ZuE91MCaPoTqtBXw@mail.gmail.com>
 <mb61ped8ak95g.fsf@kernel.org>
 <133f0ecd9ecd92268169034d329e87d22118588e.camel@gmail.com>
Date: Thu, 04 Jul 2024 17:24:41 +0000
Message-ID: <mb61pr0c9ax46.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Wed, 2024-07-03 at 11:27 +0000, Puranjay Mohan wrote:
>
> [...]
>
>> The correct way to do this would be to change call_csr_mask() to have:
>>=20
>> verifier_inlines_helper_call(env, insn->imm) || bpf_jit_inlines_helper_c=
all(insn->imm)
>
> Hi Puranjay,
>
> I've added bpf_jit_inlines_helper_call() logic in RFC v2 [1].
> If you have a riscv setup at hand, would it be possible to ask you to
> run test case 'verifier_nocsr/canary_arm64_riscv64' on it?
> I verified that it works for arm64 in [2,3] but it would be nice to
> have it checked on riscv, which is currently not a part of the CI.

Hi Eduard,

I have qemu setup for risc-v. I will test this and let you know the
results.

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIkEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZoba2xQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nSvJAPjvsp5Q+lF9G5VsA8EIs+Z/sP5qRleo
QIeLHWnXJt4NAPwMv8rXw2sIExWdavHcEyyY0SH5CiJx3RCtolRh17KUDQ==
=pax4
-----END PGP SIGNATURE-----
--=-=-=--

