Return-Path: <bpf+bounces-10386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730987A61B5
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 13:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7F91C20CA5
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 11:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6D5450C6;
	Tue, 19 Sep 2023 11:50:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D432847F;
	Tue, 19 Sep 2023 11:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDE5C433C8;
	Tue, 19 Sep 2023 11:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695124249;
	bh=9DucqhPLC8iD8mKt/UY5nRsFVFCE4cN3x0qFqAkFRdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0iuhkrNQTG8uLwqcqT0nDVxAg2xxiPBXj2MBJQ8uykOEz7d2GqljLc5NeiQCWpOk
	 iMU4dedJY5/1aJPwIP8xbCZwl+lfuRGbcqdMEQp2rkqs3cA+1KPHdebD5llnHxhj/H
	 5PipQbUhbWIPYEq1mVsITRvPNQMQ4eH0phahrl5on/8VKFLjKEc6+k07Bc0bAyt6kb
	 XyHXlKde1ZkBflGzOi5VCSK2p2s3lPo27BIzhzOPe4x16v4KnRjtYkRjE3lQe023U5
	 FGBHfq79gc/sP9M2TVYkaNBT21gHnmI3DMNVQ7PEnoGee1OUsES+uzhfrkMVk7s/gz
	 Hz8fH/TfC/YLg==
Date: Tue, 19 Sep 2023 12:50:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Pu Lehui <pulehui@huawei.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
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
	Luke Nelson <luke.r.nels@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] riscv, bpf: Mixing bpf2bpf and tailcalls
Message-ID: <20230919-5f1894d892685612395aabaf@fedora>
References: <20230919035711.3297256-1-pulehui@huaweicloud.com>
 <20230919035711.3297256-5-pulehui@huaweicloud.com>
 <20230919-4734211982e4e411a93650a7@fedora>
 <8ebbd85d-857a-432b-be56-1f8f425b979d@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7aGyZq91J3TAjZi+"
Content-Disposition: inline
In-Reply-To: <8ebbd85d-857a-432b-be56-1f8f425b979d@huawei.com>


--7aGyZq91J3TAjZi+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 07:23:07PM +0800, Pu Lehui wrote:
>=20
>=20
> On 2023/9/19 18:04, Conor Dooley wrote:
> > On Tue, Sep 19, 2023 at 11:57:11AM +0800, Pu Lehui wrote:
> > > From: Pu Lehui <pulehui@huawei.com>
> > >=20
> > > In the current RV64 JIT, if we just don't initialize the TCC in subpr=
og,
> > > the TCC can be propagated from the parent process to the subprocess, =
but
> > > the TCC of the parent process cannot be restored when the subprocess
> > > exits. Since the RV64 TCC is initialized before saving the callee sav=
ed
> > > registers into the stack, we cannot use the callee saved register to
> > > pass the TCC, otherwise the original value of the callee saved regist=
er
> > > will be destroyed. So we implemented mixing bpf2bpf and tailcalls
> > > similar to x86_64, i.e. using a non-callee saved register to transfer
> > > the TCC between functions, and saving that register to the stack to
> > > protect the TCC value. At the same time, we also consider the scenario
> > > of mixing trampoline.
> > >=20
> > > Tests test_bpf.ko and test_verifier have passed, as well as the relat=
ive
> > > testcases of test_progs*.
> > >=20
> > > Signed-off-by: Pu Lehui <pulehui@huawei.com>
> >=20
> > Breaks the build:
> > ../arch/riscv/net/bpf_jit_comp64.c:846:14: error: use of undeclared ide=
ntifier 'BPF_TRAMP_F_TAIL_CALL_CTX'
> >=20
>=20
> Hi Conor,
>=20
> BPF_TRAMP_F_TAIL_CALL_CTX rely on commit [0], and it has been merged into
> bpf-next tree.

I see. I did check the cover to see if there was anything relevant
there, like a link or base commit, but since there were neither I opted
to pass on the warning from the patchwork automation we have :)

Thanks & sorry for the noise on this one.

Thanks,
Conor.

--7aGyZq91J3TAjZi+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQmLAgAKCRB4tDGHoIJi
0lhqAQCq1PZp2coB5qmzqa14vKJ4qyIbOxQvaXzCKk9mHyZECwD9E0i6/Nqg+6SZ
3xhMyPJa3N1LGnQPDMrfPnKQErAgoAk=
=w3wa
-----END PGP SIGNATURE-----

--7aGyZq91J3TAjZi+--

