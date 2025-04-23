Return-Path: <bpf+bounces-56484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0E9A986D5
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 12:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5487443774
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 10:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D539726C380;
	Wed, 23 Apr 2025 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/NsPiYH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D1026A1B9;
	Wed, 23 Apr 2025 10:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403092; cv=none; b=D/aThDGJ/6/wgb4FMCVJP6kASqF5u67HhoW6m3G8uuJe7WHIZSo3CsSnjIj66VQ2j8LIXJu0FOK+ACHvrGGdOjpvRa+nehSd3QjiFmdy4jlMBA0+CEl660ubduan36Z+AFXNuxYlkNL+Cg5wyeRF0IIRcsrv4J4Noq/OFIAyl90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403092; c=relaxed/simple;
	bh=8MEBVIkWewXw+lwjigr+xfdfHVKvIb/W0Jna6yh7/ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSumJkGQoX/IjMwBYMSHsENRcgw6Cd/onTS51o7ix/cNl7EL/lf+Kv1IQuC/hgxnC/r1XYECxOg+mGPNjuizcLqFOERAlvpxwDwdygY7Z+8Db7ZheMYRFul8FjodjvH2TTJD/jaxp9it0Kd2b7m5pKmuJELaC6Mo+RoCURyf//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/NsPiYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480D7C4CEE2;
	Wed, 23 Apr 2025 10:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745403091;
	bh=8MEBVIkWewXw+lwjigr+xfdfHVKvIb/W0Jna6yh7/ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/NsPiYHvoo1IAMVXrqu7tPfgq4gfAZQBbvRfGFCvX72stFxw1bu2WrFfVUthrGPR
	 gc9nfln249KILmPG27ULPg+iSZOfb/xZHvFwsaMANEhM/VPZU/5o5KbZQXTZEKBmmh
	 vJsgTGO15AV/GVB4z+czE9HUGVfNpeVIuYN+fgF8NAE/rd4r3FsmZu/Snv/meEzt6p
	 VQvCw4+gFmiNDoX6LCUgbLgV9d/BA5eSo6xc2Xi+rXrJIhhnXAvuobJDWL+00TQQzI
	 JF+h9cAfXTzjaS/TtXKOgsdyggHDz6+BTTROTRAhiUDXN0K2oEOxRZfG3nlt+gTrZu
	 N+vu1ZqcH9Rpw==
Date: Wed, 23 Apr 2025 12:11:29 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Allow XDP dev bounded program to perform
 XDP_REDIRECT into maps
Message-ID: <aAi80as6PpOeuWJU@lore-desk>
References: <20250422-xdp-prog-bound-fix-v1-1-0b581fa186fe@kernel.org>
 <aAgdECkTiP-po7HP@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zXe39Favfr3JW6LW"
Content-Disposition: inline
In-Reply-To: <aAgdECkTiP-po7HP@mini-arch>


--zXe39Favfr3JW6LW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 22, Stanislav Fomichev wrote:
> On 04/22, Lorenzo Bianconi wrote:
> > In the current implementation if the program is bounded to a specific
> > device, it will not be possible to perform XDP_REDIRECT into a DEVMAP
> > or CPUMAP even if the program is not attached to the map entry. This
> > seems in contrast with the explanation available in
> > bpf_prog_map_compatible routine. Fix the issue taking into account
> > even the attach program type and allow XDP dev bounded program to
> > perform XDP_REDIRECT into maps if the attach type is not BPF_XDP_DEVMAP
> > or BPF_XDP_CPUMAP.
> >=20
> > Fixes: 3d76a4d3d4e59 ("bpf: XDP metadata RX kfuncs")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  kernel/bpf/core.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index ba6b6118cf504041278d05417c4212d57be6fca0..a33175efffc377edbfe2813=
97017eb467bfbcce9 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -2358,6 +2358,26 @@ static unsigned int __bpf_prog_ret0_warn(const v=
oid *ctx,
> >  	return 0;
> >  }
> > =20
> > +static bool bpf_prog_dev_bound_map_compatible(struct bpf_map *map,
> > +					      const struct bpf_prog *prog)
> > +{
> > +	if (!bpf_prog_is_dev_bound(prog->aux))
> > +		return true;
> > +
> > +	if (map->map_type =3D=3D BPF_MAP_TYPE_PROG_ARRAY)
> > +		return false;
>=20
> [..]
>=20
> > +	if (map->map_type =3D=3D BPF_MAP_TYPE_DEVMAP &&
> > +	    prog->expected_attach_type !=3D BPF_XDP_DEVMAP)
> > +		return true;
> > +
> > +	if (map->map_type =3D=3D BPF_MAP_TYPE_CPUMAP &&
> > +	    prog->expected_attach_type !=3D BPF_XDP_CPUMAP)
> > +		return true;
>=20
> Not sure I understand, what does it mean exactly? That it's ok to add
> a dev-bound program to the dev/cpumap if the program itself is gonna
> be attached only to the real device? Can you expand more on the specific
> use-case?
>=20
> The existing check makes sure that the dev-bound programs run only in the
> contexts that have hw descriptors. devmap and cpumap don't satisfy
> this constraint afaiu.

My use-case is to use a hw-metadata kfunc like bpf_xdp_metadata_rx_timestam=
p()
to read hw timestamp from the NIC and then redirect the xdp_buff into a DEV=
MP
(please note there are no programs attached to any DEVMAP entries):

extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
					 __u64 *timestamp) __ksym;

struct {
	__uint(type, BPF_MAP_TYPE_DEVMAP);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(struct bpf_devmap_val));
	__uint(max_entries, 1);
} dev_map SEC(".maps");

SEC("xdp")
int xdp_meta_redirect(struct xdp_md *ctx)
{
	__u64 timestamp;

	...
	bpf_xdp_metadata_rx_timestamp(ctx, &timestamp);
	...

	return bpf_redirect_map(&dev_map, ctx->rx_queue_index, XDP_PASS);
}

According to my understanding this is feasible just if the "xdp_meta_redire=
ct"
program is bounded to a device otherwise the program is reject with the fol=
lowing
error at load time:

libbpf: prog 'xdp_meta_redirect': BPF program load failed: -EINVAL
libbpf: prog 'xdp_meta_redirect': -- BEGIN PROG LOAD LOG --
metadata kfuncs require device-bound program
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0
-- END PROG LOAD LOG --

in order to fix it:

	...
	index =3D if_nametoindex(DEV);=20
	bpf_program__set_ifindex(prog, index);
	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
	...

Doing so the program load still fails for the check in bpf_prog_map_compati=
ble():

	bool bpf_prog_map_compatible()
	{
		...
		if (bpf_prog_is_dev_bound(aux))
			return false;
		...

In other words, a dev-bound XDP program can't interact with a DEVMAP (or
CPUMAP) even if it is not attached to a map entry.
I think if the XDP program is just running in the driver NAPI context
it should be doable to use a hw-metada kfunc and perform a redirect into
a DEVMAP or CPUMAP, right? Am I missing something?

Regards,
Lorenzo

--zXe39Favfr3JW6LW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaAi80AAKCRA6cBh0uS2t
rMmeAQDEEI0jNhsWJFxXoXuacSfeLdOstC7c5vhwS84h2I81bQEAsJztBvMtypYW
Fu+dhnwtdTOcNlgEIFmwew9LwbBtEwM=
=CWgW
-----END PGP SIGNATURE-----

--zXe39Favfr3JW6LW--

