Return-Path: <bpf+bounces-10358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459EA7A5B5A
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 09:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3497281F84
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 07:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF17A38BC8;
	Tue, 19 Sep 2023 07:39:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8D953BF;
	Tue, 19 Sep 2023 07:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B066C433C7;
	Tue, 19 Sep 2023 07:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695109140;
	bh=tqhb6QuF9hoxfX+sFDBQeHAQY+NCiWISygxA74bHCkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qljvadyU8i1dKNJYd5S2NBbgyPTxwRVodAIwSYx0jnK/YMp916+44PyJ/qv9ul5d/
	 LOg8Tyk7Gb42tu0mMJL8nUrhrxNgEyTVxuXpreFGSUZ/MpOpxHyWcFLFjb4Kv6iODJ
	 GYA38agpajhieXpTYCBFMdLL2/QE3BbcNzZmrWUSY/8Kv2b13FGnzBWOgiF9rRZUeb
	 cP+1m8SlXpvB4bJ8coXf/NfR4t4j4mH5vKB6iE2NEHDPqxpYMYaxzGuYgg7dG+Qxax
	 Gr5hejjnI0q2Vx0hIZGrhHZfqRp8PwNy+M4YbJX/MkskXeRXXTssJIL+IaOxNP4/iV
	 ECjO83WhEOl5g==
Date: Tue, 19 Sep 2023 08:38:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Luke Nelson <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next v2 4/6] riscv, bpf: Add necessary Zbb
 instructions
Message-ID: <20230919-a19c47b423c995826615a89e@fedora>
References: <20230919035839.3297328-1-pulehui@huaweicloud.com>
 <20230919035839.3297328-5-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HjsL0/k0GTfRnZzz"
Content-Disposition: inline
In-Reply-To: <20230919035839.3297328-5-pulehui@huaweicloud.com>


--HjsL0/k0GTfRnZzz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 11:58:37AM +0800, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>=20
> Add necessary Zbb instructions introduced by [0] to reduce code size and
> improve performance of RV64 JIT. Meanwhile, a runtime deteted helper is
> added to check whether the CPU supports Zbb instructions.
>=20
> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bit=
manip-1.0.0-38-g865e7a7.pdf [0]
> Suggested-by: Conor Dooley <conor@kernel.org>

Nah, you can drop this. It was just a review comment :)

> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index 8e0ef4d08..4e24fb2bd 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
>  	return IS_ENABLED(CONFIG_RISCV_ISA_C);
>  }
> =20
> +static inline bool rvzbb_enabled(void)
> +{
> +	return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && riscv_has_extension_likely(R=
ISCV_ISA_EXT_ZBB);

This looks like it should work, thanks for changing it.

Cheers,
Conor.

--HjsL0/k0GTfRnZzz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQlQCgAKCRB4tDGHoIJi
0lAsAQDKMczQeQ/9Tni+mAdtBKZ4QBYclutkynXdaOtsX2NFfQEAzlo6khw9xQPQ
X8o8jzqe3bZK760pii4CZijKVT/WQQo=
=Pjuk
-----END PGP SIGNATURE-----

--HjsL0/k0GTfRnZzz--

