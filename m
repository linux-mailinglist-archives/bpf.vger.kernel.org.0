Return-Path: <bpf+bounces-56494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CB6A98E65
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 16:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F15617D130
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 14:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25294280A52;
	Wed, 23 Apr 2025 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drT6ZThe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40F27FD7D;
	Wed, 23 Apr 2025 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420051; cv=none; b=L7V7rv77uVN4VRJoYKpFKyVZGwj7TYCe0pxKav1xKObGUGPyhVtzqWV2dfK25M3l/d8RgznoUdDq/BU4mRVEOwNQTo7Qs0FVil3N8ezcd6rnzENNZ1vNUOsS7Qm2IzB1ZXak2u4wH+bhmTmz0D/eK/rJfpimwnjMXze+Zs49Iq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420051; c=relaxed/simple;
	bh=iRvzhTCY40eyUf30cBOphXvJH2USUk1ryr0GebDIlEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZFVCm/Rq7Dz1dNZPGNCQQcZhl9TzifzMWKF1SCq54SlhDlZ6WXpGjWbuUTmzZFJVqhOiZqynyx07ljbroyT70j4utdr+S3jGNaBO2h1jBxFPrTI+EGkpD1vVMhKQwgYpYqic/S8C2ceUCBB0xB/Uv0OEVLIAwAOtuw1THI/17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drT6ZThe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A4DC4CEE3;
	Wed, 23 Apr 2025 14:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745420051;
	bh=iRvzhTCY40eyUf30cBOphXvJH2USUk1ryr0GebDIlEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drT6ZThecwolHq2TVsRm6HR0I8j7Tl4uPnZMDUvzKX7epDpmruHLI4mOxGnn7kJPU
	 ru5xq558kNpnSEmz7EuQVbfdyFaszLRmbcbNS36M0SOppVqwfhWI3UKuveZ/HCVmu7
	 egfbdX04k+S/fvclL2He4alD1zXxXKNvp/Z4ohLqfZn73JbZjizLzATVQC6l504TQk
	 qXcOH2KVzyAkBZbHseWGrNcjcKBRO4lCpHgbgvg+YfC4X6zvjE8KxDjH096wi+9fVk
	 NFGmXdpib2KDSRjyZkj1rHv1AEUeTjdZXHJwDXHjKFMWBLX1SEvqxbLWIF0+BAv+S2
	 AV8AoSomFvuMQ==
Date: Wed, 23 Apr 2025 16:54:08 +0200
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
Message-ID: <aAj_ELYjc7cFDjSG@lore-desk>
References: <20250422-xdp-prog-bound-fix-v1-1-0b581fa186fe@kernel.org>
 <aAgdECkTiP-po7HP@mini-arch>
 <aAi80as6PpOeuWJU@lore-desk>
 <aAj6IBZ4hsUS12f4@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DVvT67f+LmJRu8M0"
Content-Disposition: inline
In-Reply-To: <aAj6IBZ4hsUS12f4@mini-arch>


--DVvT67f+LmJRu8M0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 04/23, Lorenzo Bianconi wrote:
> > On Apr 22, Stanislav Fomichev wrote:
> > > On 04/22, Lorenzo Bianconi wrote:
> > > > In the current implementation if the program is bounded to a specif=
ic
> > > > device, it will not be possible to perform XDP_REDIRECT into a DEVM=
AP
> > > > or CPUMAP even if the program is not attached to the map entry. This
> > > > seems in contrast with the explanation available in
> > > > bpf_prog_map_compatible routine. Fix the issue taking into account
> > > > even the attach program type and allow XDP dev bounded program to
> > > > perform XDP_REDIRECT into maps if the attach type is not BPF_XDP_DE=
VMAP
> > > > or BPF_XDP_CPUMAP.
> > > >=20
> > > > Fixes: 3d76a4d3d4e59 ("bpf: XDP metadata RX kfuncs")
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  kernel/bpf/core.c | 22 +++++++++++++++++++++-
> > > >  1 file changed, 21 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > > index ba6b6118cf504041278d05417c4212d57be6fca0..a33175efffc377edbfe=
281397017eb467bfbcce9 100644
> > > > --- a/kernel/bpf/core.c
> > > > +++ b/kernel/bpf/core.c
> > > > @@ -2358,6 +2358,26 @@ static unsigned int __bpf_prog_ret0_warn(con=
st void *ctx,
> > > >  	return 0;
> > > >  }
> > > > =20
> > > > +static bool bpf_prog_dev_bound_map_compatible(struct bpf_map *map,
> > > > +					      const struct bpf_prog *prog)
> > > > +{
> > > > +	if (!bpf_prog_is_dev_bound(prog->aux))
> > > > +		return true;
> > > > +
> > > > +	if (map->map_type =3D=3D BPF_MAP_TYPE_PROG_ARRAY)
> > > > +		return false;
> > >=20
> > > [..]
> > >=20
> > > > +	if (map->map_type =3D=3D BPF_MAP_TYPE_DEVMAP &&
> > > > +	    prog->expected_attach_type !=3D BPF_XDP_DEVMAP)
> > > > +		return true;
> > > > +
> > > > +	if (map->map_type =3D=3D BPF_MAP_TYPE_CPUMAP &&
> > > > +	    prog->expected_attach_type !=3D BPF_XDP_CPUMAP)
> > > > +		return true;
> > >=20
> > > Not sure I understand, what does it mean exactly? That it's ok to add
> > > a dev-bound program to the dev/cpumap if the program itself is gonna
> > > be attached only to the real device? Can you expand more on the speci=
fic
> > > use-case?
> > >=20
> > > The existing check makes sure that the dev-bound programs run only in=
 the
> > > contexts that have hw descriptors. devmap and cpumap don't satisfy
> > > this constraint afaiu.
> >=20
> > My use-case is to use a hw-metadata kfunc like bpf_xdp_metadata_rx_time=
stamp()
> > to read hw timestamp from the NIC and then redirect the xdp_buff into a=
 DEVMP
> > (please note there are no programs attached to any DEVMAP entries):
> >=20
> > extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
> > 					 __u64 *timestamp) __ksym;
> >=20
> > struct {
> > 	__uint(type, BPF_MAP_TYPE_DEVMAP);
> > 	__uint(key_size, sizeof(__u32));
> > 	__uint(value_size, sizeof(struct bpf_devmap_val));
> > 	__uint(max_entries, 1);
> > } dev_map SEC(".maps");
> >=20
> > SEC("xdp")
> > int xdp_meta_redirect(struct xdp_md *ctx)
> > {
> > 	__u64 timestamp;
> >=20
> > 	...
> > 	bpf_xdp_metadata_rx_timestamp(ctx, &timestamp);
> > 	...
> >=20
> > 	return bpf_redirect_map(&dev_map, ctx->rx_queue_index, XDP_PASS);
> > }
> >=20
> > According to my understanding this is feasible just if the "xdp_meta_re=
direct"
> > program is bounded to a device otherwise the program is reject with the=
 following
> > error at load time:
> >=20
> > libbpf: prog 'xdp_meta_redirect': BPF program load failed: -EINVAL
> > libbpf: prog 'xdp_meta_redirect': -- BEGIN PROG LOAD LOG --
> > metadata kfuncs require device-bound program
> > processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > peak_states 0 mark_read 0
> > -- END PROG LOAD LOG --
> >=20
> > in order to fix it:
> >=20
> > 	...
> > 	index =3D if_nametoindex(DEV);=20
> > 	bpf_program__set_ifindex(prog, index);
> > 	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
> > 	...
> >=20
> > Doing so the program load still fails for the check in bpf_prog_map_com=
patible():
> >=20
> > 	bool bpf_prog_map_compatible()
> > 	{
> > 		...
> > 		if (bpf_prog_is_dev_bound(aux))
> > 			return false;
> > 		...
>=20
> [..]
> =20
> > In other words, a dev-bound XDP program can't interact with a DEVMAP (or
> > CPUMAP) even if it is not attached to a map entry.
> > I think if the XDP program is just running in the driver NAPI context
> > it should be doable to use a hw-metada kfunc and perform a redirect into
> > a DEVMAP or CPUMAP, right? Am I missing something?
>=20
> Thanks for the info! Yes, that should work. I wonder if you hit
> bpf_prog_select_runtime->bpf_check_tail_call->bpf_prog_map_compatible
> path? Looks like we should not do bpf_prog_is_dev_bound in that case (the=
 rest
> of the bpf_prog_map_compatible callers should).

yes, the issue occurs at the program load time when we run
bpf_prog_map_compatible() following the call path you pointed out:

bpf_prog_select_runtime() -> bpf_check_tail_call() -> bpf_prog_map_compatib=
le()

Do you mean we should get rid of the bpf_prog_is_dev_bound() check in
bpf_prog_map_compatible() and move it in the bpf_prog_map_compatible() call=
ers
instead? In particular:

 - __cpu_map_load_bpf_program()
 - __dev_map_alloc_node()
 - prog_fd_array_get_ptr()

>=20
> When doing a follow up, can you also extend tools/testing/selftests/bpf/p=
rog_tests/xdp_metadata.c
> to cover these conditions? (redirect to empty map -> nop, adding
> dev-bound program to devmap is einval).

ack, I will do it in v2.

Regards,
Lorenzo

--DVvT67f+LmJRu8M0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaAj/EAAKCRA6cBh0uS2t
rOMoAP9dBdpg5Yah4sc0bnU8REim94G00sbkU32Jo1xybmPB5QD/d13V3jUYQeuj
ylMGn28jbNj0sGMS1uQwt2aSfGthiws=
=6vQ1
-----END PGP SIGNATURE-----

--DVvT67f+LmJRu8M0--

