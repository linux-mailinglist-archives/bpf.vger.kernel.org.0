Return-Path: <bpf+bounces-32407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C28F90D600
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 16:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0B73B219CE
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 14:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA7915B97A;
	Tue, 18 Jun 2024 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQEEiN4F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7FF1514C5
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720414; cv=none; b=NW3DQ2w9iFi0BFSfbxrPPgHWC1DxFjCIWnikZ+QNjhMVD8MmK3s8v2FzXUi+LI1m1nM3SRfCgakcV6C5zC1VauLNmzpMwXvb90/G2BCfqlO9CY/Fot5d6uAQPGUMHJBgO3KN9UvNcvZIj+VEF9+QoYkE0iOQeAVEaluv0iXQZ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720414; c=relaxed/simple;
	bh=1lJPErEPGLBHnkbuEUF//U4Hv+/TjC+LlNBlcVadg9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HPBuQyPXRTJY/YiFUMOyBO8JEs2sEhzv5HTnY8LIpcwFJ1/3cdJqp/CuMCXT0tcgMdRMoorfRtQyV9XVfS07KaYd2Vyq/Xd6BmiQmEfOhU++MNEed49Z+hCi/LHnjJDkVL2Nj1t6rXFUcq/Put74dSHu8GcSn3a9xpgKu4WtLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQEEiN4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9A7C3277B;
	Tue, 18 Jun 2024 14:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718720414;
	bh=1lJPErEPGLBHnkbuEUF//U4Hv+/TjC+LlNBlcVadg9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KQEEiN4Fv3AWaE62UnKXPvLptVAzpQUzf6E3WM2irDnmfrypoIZE2V6P/WT4fYyLK
	 ypIK11ql9uKKxJLkFW4pnfTnmlOFlQIO8uITQJqd5ytNRCVXTm1GEXqEpaXCQTI4Dv
	 bvHsyynlcZ+bpU6xBuypxvmGSAGyx1ERJ595IHYt5q/FEJcGHpB9KXB5sXnrIalQAA
	 C0r68xuXzXfeReVD/DxJbaqMn4RjFkCl2BJA/oUVAuokJMG23c2RocsYk2XU/yYkkH
	 RLNHVfc+06nNCsjRWvDxPzSMxgJzy5B7v32nafu7rccEQ7XSOf0b9Y3nF2b11vH7CV
	 m50zdZc6g3Ceg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Rafael Passos <rafael@rcpassos.me>, andrii@kernel.org, ast@kernel.org,
 bjorn@kernel.org, bp@alien8.de, daniel@iogearbox.net, davem@davemloft.net,
 dsahern@kernel.org, mingo@redhat.com, tglx@linutronix.de, will@kernel.org,
 xi.wang@gmail.com
Cc: Rafael Passos <rafael@rcpassos.me>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next V2 0/3] Fix compiler warnings, looking for
 suggestions
In-Reply-To: <20240615022641.210320-1-rafael@rcpassos.me>
References: <20240615022641.210320-1-rafael@rcpassos.me>
Date: Tue, 18 Jun 2024 14:20:07 +0000
Message-ID: <mb61p34paz620.fsf@kernel.org>
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

Rafael Passos <rafael@rcpassos.me> writes:

> Hi,
> This patchset has a few fixes to compiler warnings.
> I am studying the BPF subsystem and wish to bring more tangible contribut=
ions.
> I would appreciate receiving suggestions on things to investigate.
> I also documented a bit in my blog. I could help with docs here, too.
> https://rcpassos.me/post/linux-ebpf-understanding-kernel-level-mechanics
> Thanks!
>
> Changelog V1 -> V2:
> - rebased all commits to updated for-next base
> - removes new cases of the extra parameter for bpf_jit_binary_pack_finali=
ze
> - built and tested for ARM64
> - sent the series for the test workflow:
>   https://github.com/kernel-patches/bpf/pull/7198
>
>
> Rafael Passos (3):
>   bpf: remove unused parameter in bpf_jit_binary_pack_finalize
>   bpf: remove unused parameter in __bpf_free_used_btfs
>   bpf: remove redeclaration of new_n in bpf_verifier_vlog
>
>  arch/arm64/net/bpf_jit_comp.c   | 3 +--
>  arch/powerpc/net/bpf_jit_comp.c | 4 ++--
>  arch/riscv/net/bpf_jit_core.c   | 5 ++---
>  arch/x86/net/bpf_jit_comp.c     | 4 ++--
>  include/linux/bpf.h             | 3 +--
>  include/linux/filter.h          | 3 +--
>  kernel/bpf/core.c               | 8 +++-----
>  kernel/bpf/log.c                | 2 +-
>  kernel/bpf/verifier.c           | 3 +--
>  9 files changed, 14 insertions(+), 21 deletions(-)
>
> --=20
> 2.45.2

Acked-by: Puranjay Mohan <puranjay@kernel.org>

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZnGXmBQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nTwYAQCS0qUmBvWnWUbSNODhEU6UmPKcW9WN
4WkMMtFfmSVRPgD/RgirQThJmPIeCHUOOSdpIJKgvqjJmKACAok+xE6SzgY=
=AvoZ
-----END PGP SIGNATURE-----
--=-=-=--

