Return-Path: <bpf+bounces-10369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642FD7A5F01
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 12:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8790E1C20984
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7742E63E;
	Tue, 19 Sep 2023 10:05:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B258B110B;
	Tue, 19 Sep 2023 10:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64294C433C7;
	Tue, 19 Sep 2023 10:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695117900;
	bh=UWm/jZ0BpAK791nEkanovA5cdga8NxQpAaGrGnuJ0tE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YwgAzIpwo9U7itbW+rxsSq6V6Qx5nb30gUuDuFgF+TQSRy9mFzkDDBG/ni+kt9HtR
	 XbapZhf4IS4n05WwagOY1/jPCaDPhix5Y8MsGfYCnBDPG1bBFj0S+IhS2OHVXx9Rvn
	 v7Gdf1qdNk+HAR/g4sEmBBAXG1gCDBqo00rPRCXRL7hOhXXv0tTUK2as/lWdXmrE6C
	 Fvxcfk3ApBKKhWdNOLtpgj9uuyfBmgfcKvpuo9yzX8DvcieMZXKcZdm+R3h6NVIX24
	 hjPlouJKkO6+oUB7FIS9gOJ/KKy57/BVGNzBcib8POQOl9VB36614l3nB2EBPZxv+4
	 7brJJWtXYaNNg==
Date: Tue, 19 Sep 2023 11:04:53 +0100
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
Message-ID: <20230919-4734211982e4e411a93650a7@fedora>
References: <20230919035711.3297256-1-pulehui@huaweicloud.com>
 <20230919035711.3297256-5-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ATOEW6o/+/ySUOUC"
Content-Disposition: inline
In-Reply-To: <20230919035711.3297256-5-pulehui@huaweicloud.com>


--ATOEW6o/+/ySUOUC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 11:57:11AM +0800, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>=20
> In the current RV64 JIT, if we just don't initialize the TCC in subprog,
> the TCC can be propagated from the parent process to the subprocess, but
> the TCC of the parent process cannot be restored when the subprocess
> exits. Since the RV64 TCC is initialized before saving the callee saved
> registers into the stack, we cannot use the callee saved register to
> pass the TCC, otherwise the original value of the callee saved register
> will be destroyed. So we implemented mixing bpf2bpf and tailcalls
> similar to x86_64, i.e. using a non-callee saved register to transfer
> the TCC between functions, and saving that register to the stack to
> protect the TCC value. At the same time, we also consider the scenario
> of mixing trampoline.
>=20
> Tests test_bpf.ko and test_verifier have passed, as well as the relative
> testcases of test_progs*.
>=20
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Breaks the build:
=2E./arch/riscv/net/bpf_jit_comp64.c:846:14: error: use of undeclared ident=
ifier 'BPF_TRAMP_F_TAIL_CALL_CTX'

Thanks,
Conor.

--ATOEW6o/+/ySUOUC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQlyOAAKCRB4tDGHoIJi
0r/rAP0RRG8B+qpWNcU7qcE9Ft11M7jGHMnDR1qMquQuiP7XvgEA+UKszKDvr0or
aj3aTNgx/eXSCPPE7ouXf4b6WzNODwI=
=jgUK
-----END PGP SIGNATURE-----

--ATOEW6o/+/ySUOUC--

