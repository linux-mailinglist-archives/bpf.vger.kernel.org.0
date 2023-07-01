Return-Path: <bpf+bounces-3835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4478F744628
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 05:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627B3281264
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 03:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2021844;
	Sat,  1 Jul 2023 03:11:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7465D;
	Sat,  1 Jul 2023 03:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0D5C433C9;
	Sat,  1 Jul 2023 03:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688181062;
	bh=KFkohFkvFbHLLBwnHmlfBxLR+78ltfSpH1Qop5HD2dQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q6IJ3MaABN+Ni0mPcl2k0KwvIFP+CVc+sM3t5E5YSdujLUe+5z4Ap6b+mJQTRFf6N
	 VewBaSeKOvSH8LU6WVZuKTu4Na8zm95W9kq/Gx4ur3Cg8kcx/pF82huI33U7djrza6
	 B2UJunjdwGO7AJmlg25wPB6k3FclLHBvJGDkM+ngG9AL66RsdwyCp3W/ECLJ569q9w
	 A1a/oHp3STHmwwcT9lBd5EKkQsEmX///pklBp7xltyvg/zY7LNpA2MXkvi6bjNPM2R
	 CH1blQ4inbLtqsyh/h7hpMH9oXh5eHfvhthJW5jyUZrS60aeOMt3yh0dZpMmoaHLMB
	 C2rCMBde8lU0g==
Date: Fri, 30 Jun 2023 20:11:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
 Stanislav Fomichev <sdf@google.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Donald Hunter <donald.hunter@gmail.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Network Development
 <netdev@vger.kernel.org>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp
 metadata
Message-ID: <20230630201100.0bb9b1f3@kernel.org>
In-Reply-To: <649f78b57358c_30943208c4@john.notmuch>
References: <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
	<CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
	<CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
	<CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
	<CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
	<m2bkh69fcp.fsf@gmail.com>
	<649637e91a709_7bea820894@john.notmuch>
	<CAADnVQKUVDEg12jOc=5iKmfN-aHvFEtvFKVEDBFsmZizwkXT4w@mail.gmail.com>
	<20230624143834.26c5b5e8@kernel.org>
	<ZJeUlv/omsyXdO/R@google.com>
	<ZJoExxIaa97JGPqM@google.com>
	<CAADnVQKePtxk6Nn=M6in6TTKaDNnMZm-g+iYzQ=mPoOh8peoZQ@mail.gmail.com>
	<CAKH8qBv-jU6TUcWrze5VeiVhiJ-HUcpHX7rMJzN5o2tXFkS8kA@mail.gmail.com>
	<649b581ded8c1_75d8a208c@john.notmuch>
	<20230628115204.595dea8c@kernel.org>
	<87y1k2fq9m.fsf@toke.dk>
	<649f78b57358c_30943208c4@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Jun 2023 17:52:05 -0700 John Fastabend wrote:
> Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Jakub Kicinski <kuba@kernel.org> writes:
> > > Sorry but this is not going to happen without my nack. DPDK was a much
> > > cleaner bifurcation point than trying to write datapath drivers in BP=
F.
> > > Users having to learn how to render descriptors for all the NICs
> > > and queue formats out there is not reasonable. Isovalent hired =20
>=20
> I would expect BPF/driver experts would write the libraries for the
> datapath API that the network/switch developer is going to use. I would
> even put the BPF programs in kernel and ship them with the release
> if that helps.
>=20
> We have different visions on who the BPF user is that writes XDP
> programs I think.

Yes, crucially. What I've seen talking to engineers working on TC/XDP
BPF at Meta (and I may not be dealing with experts, Martin would have
a broader view) is that they don't understand basics like s/g or
details of checksums.

I don't think it is reasonable to call you, Maxim, Nik and co. "users".
We're risking building system so complex normal people will _need_ an
overlay on top to make it work.

> > > a lot of former driver developers so you may feel like it's a good
> > > idea, as a middleware provider. But for the rest of us the matrix
> > > of HW x queue format x people writing BPF is too large. If we can =20
>=20
> Its nice though that we have good coverage for XDP so the matrix
> is big. Even with kfuncs though we need someone to write support.
> My thought is its just a question of if they write it in BPF
> or in C code as a reader kfunc. I suspect for these advanced features
> its only a subset at least upfront. Either way BPF or C you are
> stuck finding someone to write that code.

Right, but kernel is a central point where it can be written, reviewed,
cross-optimized and stored.

> > > write some poor man's DPDK / common BPF driver library to be selected
> > > at linking time - we can as well provide a generic interface in
> > > the kernel itself. Again, we never merged explicit DPDK support,=20
> > > your idea is strictly worse. =20
> >=20
> > I agree: we're writing an operating system kernel here. The *whole
> > point* of an operating system is to provide an abstraction over
> > different types of hardware and provide a common API so users don't have
> > to deal with the hardware details. =20
>=20
> And just to be clear what we sacrifice then is forwards/backwards
> portability.

Forward compatibility is also the favorite word of HW vendors when=20
they create proprietary interfaces. I think it's incorrect to call
cutting functionality out of a project forward compatibility.
If functionality is moved the surface of compatibility is different.

> If its a kernel kfunc we need to add a kfunc for
> every field we want to read and it will only be available then.
> Further, it will need some general agreement that its useful for
> it to be added. A hardware vendor wont be able to add some arbitrary
> field and get access to it. So we lose this by doing kfuncs.

We both know how easy it is to come up with useful HW, so I'm guessing
this is rhetorical.

> Its pushing complexity into the kernel that we maintain in kernel
> when we could push the complexity into BPF and maintain as user
> space code and BPF codes. Its a choice to make I think.

Right, and I believe having the code in the kernel, appropriately
integrated with the drivers is beneficial. The main argument against=20
it is that in certain environments kernels are old. But that's a very
destructive argument.

