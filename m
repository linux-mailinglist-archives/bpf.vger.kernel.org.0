Return-Path: <bpf+bounces-30115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4161E8CAF4F
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 15:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729801C21966
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 13:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0F8770FF;
	Tue, 21 May 2024 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wcos3SJS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B617219EA;
	Tue, 21 May 2024 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297719; cv=none; b=NCbsVgt2RA4dpxKPovqqK3oSHTJR9Jg/jk9rJBBM3c9ttSzUSKvQ1ZmW1kHraHtfh8Vh9HGCFXQn4SbDnWVCb9XKEnVgXT2rar+RMa5L+XwG3uQ8dzqjANuUFaZpQslNIAmAVPFdV5AQkoJH15szKl3DqTQGkGi0nP5W8cwfaUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297719; c=relaxed/simple;
	bh=0wG1udqEQNqr6KzpJKxfIni8SGXpPlxbIKY+RZRKKQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZGip9/Vh008kPSHler8wqtitz5a/3aHpFTbptqrFE7ZkFClcUgZGPXqmipcQ3I0UNAFV3C49Ouam3ziIqArYXt43Emfecem1jUJUjNSCZn8J4+Xva5jR2MVSHl/nNMVi1hKZ+mC0iDs0DQhwYWnjkNiibPRdgyk5op1MYu9BBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wcos3SJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D428C2BD11;
	Tue, 21 May 2024 13:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716297718;
	bh=0wG1udqEQNqr6KzpJKxfIni8SGXpPlxbIKY+RZRKKQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wcos3SJSdvWxZKow+LiqhVc1o6wDOiaFG/jfKxv7qQJ8pRHovxeyuGDisWTKygW7s
	 HDmeYceKJPqM0qb0Nx93Mg1a1fqsOyyEskzQrbOh08vdTk6cLxOiuuz8S803jWY1lP
	 rUCew21qN621jgw+gbSPOGeIbgIxuA68QN2QPVK2cur1al6TUeeZ5M/wSDr8Z5h1Nz
	 MZTuhbeF4Vgn4MF2RMdTA2ZUiWi9edHE85jjGPqgYIOT9Ks8Nj78BUj1niAkBygpuK
	 mWuv6bxP1Dph+li08NFSrGETR1F4XPTwkGOqpdeXno2666HtJI+0rlt4YH1tLxu1H5
	 v6b9aR+9iN7tg==
Date: Tue, 21 May 2024 15:21:54 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel <netfilter-devel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Simon Horman <horms@kernel.org>, donhunte@redhat.com,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] netfilter: add
 bpf_xdp_flow_offload_lookup kfunc
Message-ID: <Zkyf8mj9G8I0Pr1R@lore-rh-laptop>
References: <cover.1716026761.git.lorenzo@kernel.org>
 <0ddc5e4fcc6a38c74c185063e73ef4c496eaa7ca.1716026761.git.lorenzo@kernel.org>
 <CAADnVQLaM1eTH75-PQQA--uYbYaEwBzbJJ-KjgeqGb3i0QyM=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2FMRN5GJ+J7Ubfdq"
Content-Disposition: inline
In-Reply-To: <CAADnVQLaM1eTH75-PQQA--uYbYaEwBzbJJ-KjgeqGb3i0QyM=g@mail.gmail.com>


--2FMRN5GJ+J7Ubfdq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, May 18, 2024 at 3:13=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.=
org> wrote:

[...]
>=20
> I think it needs to be KF_RET_NULL.
> And most likely KF_TRUSTED_ARGS as well.

ack, I will fix it in v2.

>=20
> Also the "offload" doesn't fit in the name.
> The existing code calls it "offload", because it's actually
> pushing the rules to HW (if I understand the code),
> but here it's just a lookup from xdp.
> So call it
> bpf_xdp_flow_lookup() ?

ack fine, I do not have a strong opinion on it. I will fix it in v2.

>=20
> Though "flow" is a bit too generic here.
> nf_flow maybe?

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> > +BTF_KFUNCS_END(nf_ft_kfunc_set)
> > +
> > +static const struct btf_kfunc_id_set nf_flow_offload_kfunc_set =3D {
> > +       .owner =3D THIS_MODULE,
> > +       .set   =3D &nf_ft_kfunc_set,
> > +};
> > +
> > +int nf_flow_offload_register_bpf(void)
> > +{
> > +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
> > +                                        &nf_flow_offload_kfunc_set);
> > +}
> > +EXPORT_SYMBOL_GPL(nf_flow_offload_register_bpf);
> > diff --git a/net/netfilter/nf_flow_table_inet.c b/net/netfilter/nf_flow=
_table_inet.c
> > index 6eef15648b7b0..6175f7556919d 100644
> > --- a/net/netfilter/nf_flow_table_inet.c
> > +++ b/net/netfilter/nf_flow_table_inet.c
> > @@ -98,7 +98,7 @@ static int __init nf_flow_inet_module_init(void)
> >         nft_register_flowtable_type(&flowtable_ipv6);
> >         nft_register_flowtable_type(&flowtable_inet);
> >
> > -       return 0;
> > +       return nf_flow_offload_register_bpf();
> >  }
> >
> >  static void __exit nf_flow_inet_module_exit(void)
> > --
> > 2.45.1
> >

--2FMRN5GJ+J7Ubfdq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZkyf7wAKCRA6cBh0uS2t
rHcwAP4i1YL9ydDyCeFaN9CiByTUMLVBw+6Sfn70BANpG3gWcwD+KOv5o2rdtf0B
q6DT7wUICMMSfrnYthQfpkOOS2OM7A8=
=Jm+l
-----END PGP SIGNATURE-----

--2FMRN5GJ+J7Ubfdq--

