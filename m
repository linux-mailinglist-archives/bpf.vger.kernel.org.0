Return-Path: <bpf+bounces-40353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B707E98761A
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 16:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254BE289A97
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2207F14F9F4;
	Thu, 26 Sep 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwnD5Wyz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7D214BFBF;
	Thu, 26 Sep 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362653; cv=none; b=fit4IQG0dfDjvaIuKB2YS+62RWq6fQQkhd6SiZPT/IHuw3kjNATkOg/dLx18Po2oTO/SiOKPpXt5R/NmDTWVeXL/C28dgzXqKL/bHFyt7rW1+nWOoPuKjNrftQEPOVfBX+e5PUKYeyMefiDnmGvyAVJqwpJZJ3wHBfetEDvj0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362653; c=relaxed/simple;
	bh=4ZGxuM2gdOgaQUTxnoqPu90dT3FeX/dRZmua+ueQAE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRCqkbk6hPRh4zOJDpEeOLL6yFtYNWPjHs0skBFYWpMA0ubdxlbo9x3KT0qYCVVMHcLcztbWFbK3C/EwBITFo5MZwadBPGcqcE1rGKsUGi9HJcowljEpg1T20o+jrEMRA45lVeJqDQCp4fTEfK2DDms/QxSrdzDPAYZafm5gihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwnD5Wyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB6DC4CEC6;
	Thu, 26 Sep 2024 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727362653;
	bh=4ZGxuM2gdOgaQUTxnoqPu90dT3FeX/dRZmua+ueQAE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwnD5WyzztQGgQwWsq5xsAdz59AeF0vhzrK73U7lZaQSF8dy0+k2uDdATt8IkJadT
	 qNCm23fmba+4rrqJgbssKWqLDdpKlvLyOLEYFg/8H0Y56vBb8Dt5PBQID8HsqItibE
	 gwhy5PN/rHESvBYjh2U6yy/3pLXU/+pWxtUtgSF0yLipRCvxPjhrRz9N9IRDhNWrRj
	 MKe6mzZyvepVU9TgApGffNwYd4kyU8/aewLYl+otOv7s5/BCwPY9Rfm0r0/vfVT65z
	 EInv2tIaS6MBan2tp09IvJzSOJ4UuhTt0kqO4Ay/Q2SyvtpcbYrtpjgc+nI3SyxFRs
	 rnWU/HSP6ouLA==
Date: Thu, 26 Sep 2024 16:57:28 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Arthur Fabre <afabre@cloudflare.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
	john.fastabend@gmail.com, edumazet@google.com, pabeni@redhat.com,
	sdf@fomichev.me, tariqt@nvidia.com, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org, mst@redhat.com,
	jasowang@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	kernel-team <kernel-team@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
Message-ID: <ZvV2WLUa1KB8qu3L@lore-rh-laptop>
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
 <Zu_gvkXe4RYjJXtq@lore-desk>
 <87ldzkndqk.fsf@toke.dk>
 <ZvA6hIl6XWJ4UEJW@lore-desk>
 <874j62u1lb.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ye/IXUGKfZM9t2/H"
Content-Disposition: inline
In-Reply-To: <874j62u1lb.fsf@toke.dk>


--Ye/IXUGKfZM9t2/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
>=20
> >> I'm hinting at some complications here (with the EFAULT return) that
> >> needs to be resolved: there is no guarantee that a given packet will be
> >> in sync with the current status of the registered metadata, so we need
> >> explicit checks for this. If metadata entries are de-registered again
> >> this also means dealing with holes and/or reshuffling the metadata
> >> layout to reuse the released space (incidentally, this is the one place
> >> where a TLV format would have advantages).
> >
> > I like this approach but it seems to me more suitable for 'sw' metadata
> > (this is main Arthur and Jakub use case iiuc) where the userspace would
> > enable/disable these functionalities system-wide.
> > Regarding device hw metadata (e.g. checksum offload) I can see some iss=
ues
> > since on a system we can have multiple NICs with different capabilities.
> > If we consider current codebase, stmmac driver supports only rx timesta=
mp,
> > while mlx5 supports all of them. In a theoretical system with these two
> > NICs, since pkt_metadata_registry is global system-wide, we will end-up
> > with quite a lot of holes for the stmmac, right? (I am not sure if this
> > case is relevant or not). In other words, we will end-up with a fixed
> > struct for device rx hw metadata (like xdp_rx_meta). So I am wondering
> > if we really need all this complexity for xdp rx hw metadata?
>=20
> Well, the "holes" will be there anyway (in your static struct approach).
> They would just correspond to parts of the "struct xdp_rx_meta" being
> unset.

yes, what I wanted to say is I have the feeling we will end up 90% of the
times in the same fields architecture and the cases where we can save some
space seem very limited. Anyway, I am fine to discuss about a common
architecture.

>=20
> What the "userspace can turn off the fields system wide" would
> accomplish is to *avoid* the holes if you know that you will never need
> them. E.g., say a system administrator know that they have no networks
> that use (offloaded) VLANs. They could then disable the vlan offload
> field system-wide, and thus reclaim the four bytes taken up by the
> "vlan" member of struct xdp_rx_meta, freeing that up for use by
> application metadata.

Even if I like the idea of having a common approach for this kernel feature,
hw metadata seems to me quite a corner case with respect of 'user-defined
metadata', since:
- I do not think it is a common scenario to disable hw offload capabilities
  (e.g checksum offload in production)
- I guess it is not just enough to disable them via bpf, but the user/sysad=
min
  will need even to configure the NIC via ethtool (so a 2-steps process).

I think we should pay attention to not overcomplicate something that is 99%
enabled and just need to be fast. E.g I can see an issue of putting the hw =
rx
metadata in metadata field since metadata grows backward and we will probab=
ly
end up putting them in a different cacheline with respect to xdp_frame
(xdp_headroom is usually 256B).

>=20
> However, it may well be that the complexity of allowing fields to be
> turned off is not worth the gains. At least as long as there are only
> the couple of HW metadata fields that we have currently. Having the
> flexibility to change our minds later would be good, though, which is
> mostly a matter of making the API exposed to BPF and/or userspace
> flexible enough to allow us to move things around in memory in the
> future. Which was basically my thought with the API I sketched out in
> the previous email. I.e., you could go:
>=20
> ret =3D bpf_get_packet_metadata_field(pkt, METADATA_ID_HW_HASH,
>                                     &my_hash_vlaue, sizeof(u32))

yes, my plan is to add dedicated bpf kfuncs to store hw metadata in
xdp_frame/xdp_buff

>=20
>=20
> ...and the METADATA_ID_HW_HASH would be a constant defined by the
> kernel, for which the bpf_get_packet_metadata_field() kfunc just has a
> hardcoded lookup into struct xdp_rx_meta. And then, if we decide to move
> the field in the future, we just change the kfunc implementation, with
> no impact to the BPF programs calling it.
>=20

maybe we can use what we Stanislav have already added (maybe removing xdp
prefix):

enum xdp_rx_metadata {
	XDP_METADATA_KFUNC_RX_TIMESTAMP,
	XDP_METADATA_KFUNC_RX_HASH,
	XDP_METADATA_KFUNC_RX_VLAN_TAG
};


> > Maybe we can start with a simple approach for xdp rx hw metadata
> > putting the struct in xdp_frame as suggested by Jesper and covering
> > the most common use-cases. We can then integrate this approach with
> > Arthur/Jakub's solution without introducing any backward compatibility
> > issue since these field are not visible to userspace.
>=20
> Yes, this is basically the gist of my suggestion (as I hopefully managed
> to clarify above): Expose the fields via an API that is flexible enough
> that we can move things around should the need arise, *and* which can
> co-exist with the user-defined application metadata.

ack

Regards,
Lorenzo

>=20
> -Toke
>=20

--Ye/IXUGKfZM9t2/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZvV2VgAKCRA6cBh0uS2t
rG2DAP4vr17UaschZGwn9hvl6sZvGyw84ELpQebLqdV2Y1HGDAD/U0tzBa1q3Dsi
eBtfJQ/0whO20lu0vKIwenL5eQYxCwM=
=NPbX
-----END PGP SIGNATURE-----

--Ye/IXUGKfZM9t2/H--

