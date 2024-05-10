Return-Path: <bpf+bounces-29541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC60A8C2B58
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 22:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781C02831AB
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 20:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CE213B584;
	Fri, 10 May 2024 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcX1OJQm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA44913AD29;
	Fri, 10 May 2024 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715374575; cv=none; b=CiGLdS7Mf6iVaOVG/t/5Xx+YcDi1UHwNrln6VsR6iGNzvDbeLHKTEW1XNpGJ0uqdiYlJIxtUiTEaejPIrY+R3ObrhOj30X5upKhpNZhCL7yVxUNRnesjIqTavGu/CoaM7L+aJfoW9yCzhStXRt2+ZWHQncrQzp5bQNXgpUKIvlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715374575; c=relaxed/simple;
	bh=cByeZ/lC6AB3uZmC/kZETxlLuSZiIR/cTU3FsQbCfIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZ329cx4jtynigcSS+hN/+8tHmq5HHniSP2l4sPSEaPQhnxwSrsyJLHOeI/zYBvOrMi3yEqFn/2BSE4957bESFDv+5iohMYednhmkFYg2ibfd5LMzjUStAOf1tVy06wesfHpxqyQdqD8B8nQkxChQviO5F6PAaAd04XzdjNydmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcX1OJQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF9BC113CC;
	Fri, 10 May 2024 20:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715374574;
	bh=cByeZ/lC6AB3uZmC/kZETxlLuSZiIR/cTU3FsQbCfIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcX1OJQmLlYLWY4DVkqGz99mxPY7Md3b6PeC4zeEj3znodufL9/snjgAXDo74z6Nh
	 QBcLqcOUTIjNUn03dWuJtdPlU6Edy7WtXcaDdiJFAjyO8PubOS/n4GKlkLRY/GomP2
	 E401y5gPBQ5wM0cY4NVwWYsZW/tqifWQVavW7TRLvxdq5KK0rQ0nFsFszL/Hpv85Zi
	 UrNGc5lHz/7erFAkz6nSz/HH1vWWpwgM+q/73U8kdiSIHG7n5CyXcrm6SLpOxt3KTW
	 AENf5HG+0MeICek8ytlk1KaL+0pOiYikl1bfs//wxis1KVvwKijPTwvanB8hkfY255
	 ekmW3goYlpWiw==
Date: Fri, 10 May 2024 21:56:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Xiao Wang <xiao.w.wang@intel.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	luke.r.nels@gmail.com, xi.wang@gmail.com, bjorn@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	pulehui@huawei.com, haicheng.li@intel.com
Subject: Re: [PATCH] riscv, bpf: Optimize zextw insn with Zba extension
Message-ID: <20240510-essay-subwoofer-e055375ff1cb@spud>
References: <20240507104528.435980-1-xiao.w.wang@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jtU1AroXrzjM0WOG"
Content-Disposition: inline
In-Reply-To: <20240507104528.435980-1-xiao.w.wang@intel.com>


--jtU1AroXrzjM0WOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 06:45:28PM +0800, Xiao Wang wrote:
> The Zba extension provides add.uw insn which can be used to implement
> zext.w with rs2 set as ZERO.
>=20
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>  arch/riscv/Kconfig       | 19 +++++++++++++++++++
>  arch/riscv/net/bpf_jit.h | 18 ++++++++++++++++++
>  2 files changed, 37 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6bec1bce6586..0679127cc0ea 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -586,6 +586,14 @@ config RISCV_ISA_V_PREEMPTIVE
>  	  preemption. Enabling this config will result in higher memory
>  	  consumption due to the allocation of per-task's kernel Vector context.
> =20
> +config TOOLCHAIN_HAS_ZBA
> +	bool
> +	default y
> +	depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zba)
> +	depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Drv32ima_zba)
> +	depends on LLD_VERSION >=3D 150000 || LD_VERSION >=3D 23900
> +	depends on AS_HAS_OPTION_ARCH
> +
>  config TOOLCHAIN_HAS_ZBB
>  	bool
>  	default y
> @@ -601,6 +609,17 @@ config TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	def_bool $(as-instr, .option arch$(comma) +v$(comma) +zvkb)
>  	depends on AS_HAS_OPTION_ARCH
> =20
> +config RISCV_ISA_ZBA
> +	bool "Zba extension support for bit manipulation instructions"
> +	depends on TOOLCHAIN_HAS_ZBA
> +	depends on RISCV_ALTERNATIVE
> +	default y
> +	help
> +	   Adds support to dynamically detect the presence of the ZBA
> +	   extension (address generation acceleration) and enable its usage.

Recently I sent some patches to reword other extensions' help text,
because the "add support to dynamically detect" had confused people a
bit. Dynamic detection is done regardless of config options for Zba.
The wording I went with in my patch for Zbb was:
	   Add support for enabling optimisations in the kernel when the
	   Zbb extension is detected at boot.
Could you use something similar here in the opening sentence please?

Thanks,
Conor.

--jtU1AroXrzjM0WOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj6J5wAKCRB4tDGHoIJi
0hI6AQCwdFRVZ6kbYjLkxwS53moo/SJNNSnkuYEOouupqPCGPwD/XT7r7ko4jzGW
TgQCNlEOK7C1NRhLOBJ754MCcA84/wM=
=wgKo
-----END PGP SIGNATURE-----

--jtU1AroXrzjM0WOG--

