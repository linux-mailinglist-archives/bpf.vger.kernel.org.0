Return-Path: <bpf+bounces-10383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431FD7A604A
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 12:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F34281172
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 10:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D4735894;
	Tue, 19 Sep 2023 10:55:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2358339AD;
	Tue, 19 Sep 2023 10:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D83C433C7;
	Tue, 19 Sep 2023 10:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695120906;
	bh=V3ZHghel975D5l0+VfRYVx+f9dKKd19GO7h1PnigH6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXyoWMRVMEaVJVETE7W9BtZHmxSBU4M0Fl6qfLNyihi2C/VFYAjyQx5NceCCbCNN/
	 eBEqNgprqxmdVALpr6EjUZNFB6Zwyg85yajFpbQDayd7CBg94T/Y3kRhzTWYLTfn+1
	 /30oOyFnh3/uNFxSs4JU190BE0+LIRYrw3xFIY6zazxG/b/9tp5TKFEOWLsvjvBEbl
	 uA7KwVB++mPWrz2h7G8MY9dVGTuj/HSiUMZqF1ylR7ogbcf/jY7ytOfXBnlILvVPlX
	 M1yOYpCnmgBi4uTgBjmbiLUGrvxan8PUyPD/rlen3aHYqR883iAb/kEJXHhpWV01Cw
	 /K5w/BB8qWHew==
Date: Tue, 19 Sep 2023 11:54:59 +0100
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
Subject: Re: [PATCH bpf-next 4/4] riscv, bpf: Mixing bpf2bpf and tailcalls
Message-ID: <20230919-aefdbac65c773c6f02aedc76@fedora>
References: <20230919035711.3297256-1-pulehui@huaweicloud.com>
 <20230919035711.3297256-5-pulehui@huaweicloud.com>
 <20230919-4734211982e4e411a93650a7@fedora>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E3FHUvLAOD3DVxgx"
Content-Disposition: inline
In-Reply-To: <20230919-4734211982e4e411a93650a7@fedora>


--E3FHUvLAOD3DVxgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 11:04:53AM +0100, Conor Dooley wrote:
> On Tue, Sep 19, 2023 at 11:57:11AM +0800, Pu Lehui wrote:
> > From: Pu Lehui <pulehui@huawei.com>
> >=20
> > In the current RV64 JIT, if we just don't initialize the TCC in subprog,
> > the TCC can be propagated from the parent process to the subprocess, but
> > the TCC of the parent process cannot be restored when the subprocess
> > exits. Since the RV64 TCC is initialized before saving the callee saved
> > registers into the stack, we cannot use the callee saved register to
> > pass the TCC, otherwise the original value of the callee saved register
> > will be destroyed. So we implemented mixing bpf2bpf and tailcalls
> > similar to x86_64, i.e. using a non-callee saved register to transfer
> > the TCC between functions, and saving that register to the stack to
> > protect the TCC value. At the same time, we also consider the scenario
> > of mixing trampoline.
> >=20
> > Tests test_bpf.ko and test_verifier have passed, as well as the relative
> > testcases of test_progs*.
> >=20
> > Signed-off-by: Pu Lehui <pulehui@huawei.com>
>=20
> Breaks the build:
> ../arch/riscv/net/bpf_jit_comp64.c:846:14: error: use of undeclared ident=
ifier 'BPF_TRAMP_F_TAIL_CALL_CTX'

Probably should have specified, happens with allmodconfig, but not a
defconfig build.

--E3FHUvLAOD3DVxgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQl9/wAKCRB4tDGHoIJi
0tdsAQDPI/EQR5MQMfoAj8x2c5mqHyZNWDP7jqGMh6TxQBL/hgEAqYPb11jtbyAE
ky8ikWGnxSfocMvRAPm7BMuQUAlvKQo=
=iBFw
-----END PGP SIGNATURE-----

--E3FHUvLAOD3DVxgx--

