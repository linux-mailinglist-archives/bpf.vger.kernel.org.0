Return-Path: <bpf+bounces-32135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0BD907E9C
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 00:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE13D281596
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 22:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB60E14B950;
	Thu, 13 Jun 2024 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+i6xGKj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56218139597;
	Thu, 13 Jun 2024 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718316704; cv=none; b=MdsFUO10BCbkkfFKBub8RifOfgxWSS1Re7XstsUIoMmqhpB9EJSGN98tIMCKD9SkiKqxhODvL1Ew6PHMVysrqn34v45TIMwuuCG9J8sbOSXon4F2c1nHHnp+jxRQmyHi1AUAK90+BQ9iTP2d5g3UxyjSAmo33bFCx+5bH13T4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718316704; c=relaxed/simple;
	bh=PDAe0eHMrigvaxGFz0WA9zV7oj1TDoDdwzyIbeMeRo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jg9YNNgS6qagekZI02xA6mWEQ19aFPbpLfDbT882tGAm9okyt3i37UQLMdwvhrhyEuEufa3Z945qSYYYQKgv5rVTThIQkZUP/BBP/yRF/emaVBGuI+igOL3/zrEyePyxvOy4M0SR96uXcKix5osZlNodE4waawHcBgvXQPiXAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+i6xGKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C961C2BBFC;
	Thu, 13 Jun 2024 22:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718316703;
	bh=PDAe0eHMrigvaxGFz0WA9zV7oj1TDoDdwzyIbeMeRo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+i6xGKj2cUJRLKWZKs60IOOuTnZ6ncsLzWMJ4WWS8Qs2kcWpNtUkO6HNJ00LXL+d
	 4UwyGTjhRraOF4QboXaLBBNOKIMVyYMkpb6sMxGbopTAQZa2z9IEt+VRsnT/b+wiYr
	 YMDhHbGR7smePlaseAOd/BpWa1/KGqV/smcmG+rZb/5JdVnujnA2kepljqFoHaTMyO
	 dOn3B0XBRMWnvOomUOSY+t+iaJDpu5etQUOdg/AXQ4td/sxNwHiwaSProKKELXppht
	 a4wuUbjrUYsdVw8Ku5DxilLZuwsx1/x9KHm6wMrYdWYiOmfjVx0DJt4NJhfSEYRhrW
	 /3kAJDIQ9Fxpg==
Date: Fri, 14 Jun 2024 00:11:40 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, lorenzo.bianconi@redhat.com, toke@redhat.com,
	fw@strlen.de, hawk@kernel.org, horms@kernel.org,
	donhunte@redhat.com, memxor@gmail.com
Subject: Re: [PATCH v4 bpf-next 3/3] selftests/bpf: Add selftest for
 bpf_xdp_flow_lookup kfunc
Message-ID: <ZmtunAIfGA2QkkD6@lore-desk>
References: <cover.1716987534.git.lorenzo@kernel.org>
 <21f41edcad0897e3a849b17392796b32215ae8ca.1716987535.git.lorenzo@kernel.org>
 <95f8897c-a20b-fa5f-84ab-8204e2654a9e@iogearbox.net>
 <hwdaubyz7kjei5pmp72c4opxz3pk3syso22kafm2j7m3t3ffgl@g6ncqcqfe6bi>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9nQoencT8o8b9hj5"
Content-Disposition: inline
In-Reply-To: <hwdaubyz7kjei5pmp72c4opxz3pk3syso22kafm2j7m3t3ffgl@g6ncqcqfe6bi>


--9nQoencT8o8b9hj5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Jun 13, 2024 at 06:06:29PM GMT, Daniel Borkmann wrote:
> > On 5/29/24 3:04 PM, Lorenzo Bianconi wrote:
> > > Introduce e2e selftest for bpf_xdp_flow_lookup kfunc through
> > > xdp_flowtable utility.
> > >=20
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > [...]
> > > +struct flow_offload_tuple_rhash *
> > > +bpf_xdp_flow_lookup(struct xdp_md *, struct bpf_fib_lookup *,
> > > +		    struct bpf_flowtable_opts___local *, u32) __ksym;
> >=20
> > Btw, this fails CI build :
> >=20
> > https://github.com/kernel-patches/bpf/actions/runs/9499749947/job/26190=
382116
> >=20
> >   [...]
> >   progs/xdp_flowtable.c:20:1: error: conflicting types for 'bpf_xdp_flo=
w_lookup'
> >      20 | bpf_xdp_flow_lookup(struct xdp_md *, struct bpf_fib_lookup *,
> >         | ^
> >   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h=
:106755:41: note: previous declaration is here
> >    106755 | extern struct flow_offload_tuple_rhash *bpf_xdp_flow_lookup=
(struct xdp_md *ctx, struct bpf_fib_lookup *fib_tuple, struct bpf_flowtable=
_opts *opts, u32 opts_len) __weak __ksym;
> >           |                                         ^
> >   progs/xdp_flowtable.c:134:47: error: incompatible pointer types passi=
ng 'struct bpf_flowtable_opts___local *' to parameter of type 'struct bpf_f=
lowtable_opts *' [-Werror,-Wincompatible-pointer-types]
> >     134 |         tuplehash =3D bpf_xdp_flow_lookup(ctx, &tuple, &opts,=
 sizeof(opts));
> >         |                                                      ^~~~~
> >   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h=
:106755:142: note: passing argument to parameter 'opts' here
> >    106755 | extern struct flow_offload_tuple_rhash *bpf_xdp_flow_lookup=
(struct xdp_md *ctx, struct bpf_fib_lookup *fib_tuple, struct bpf_flowtable=
_opts *opts, u32 opts_len) __weak __ksym;
> >           |                                                            =
                                                                           =
       ^
> >   2 errors generated.
> >     CLNG-BPF [test_maps] kprobe_multi_override.bpf.o
> >     CLNG-BPF [test_maps] tailcall_bpf2bpf1.bpf.o
> >   make: *** [Makefile:654: /tmp/work/bpf/bpf/tools/testing/selftests/bp=
f/xdp_flowtable.bpf.o] Error 1
> >   make: *** Waiting for unfinished jobs....
> >   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bp=
f'
> >   Error: Process completed with exit code 2.
> >=20
>=20
> We'll probably want to do the same thing as in f709124dd72f ("bpf:
> selftests: nf: Opt out of using generated kfunc prototypes").

ack, I added BPF_NO_KFUNC_PROTOTYPES to selftest patch. CI seems fine now:
https://github.com/kernel-patches/bpf/pull/7202

Regards,
Lorenzo

>=20
> Daniel

--9nQoencT8o8b9hj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZmtunAAKCRA6cBh0uS2t
rEK3AQDi8LZNVHmP1FbUyPoZF05f8soKBQ08mnZC/AaTTa34lQD/Q9AD1+JFRTo1
jb933N+Mp7kW647nT5+YUWTCXM/pugo=
=10wo
-----END PGP SIGNATURE-----

--9nQoencT8o8b9hj5--

