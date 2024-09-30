Return-Path: <bpf+bounces-40555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 600A198A118
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 13:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92ECB1C20C9E
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 11:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684B518DF76;
	Mon, 30 Sep 2024 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWN0ibqQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8DF1E87B;
	Mon, 30 Sep 2024 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727696957; cv=none; b=Z0Q1wpsr1UbSCDWZy4y73VlcIdyK/D4ytbbqZCGtknVhwe5KXuNA6yyiJaRKdbQithcZt7QvhIkNJfAoABe0XPpc+8TCoJazqy9IU6L5C/dUiRUTCscemtfIHfAxf7MediMJQ6Rki//CyDOGDnxRleqNB3tTPt1a4qkcz4puH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727696957; c=relaxed/simple;
	bh=LdMjeWOvWQmXsFOhFljZfMzxfLvHYOZPCl97KMG/8oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foCIv8w5Cq8Cf7SWR4ThUzNOaQyqL/91jRAJsz/4TAuhDx/WQ3+AggpMrF8qY+HatppdLl7XSy7tAi770QD/tsmRwkRZgArzPfPFc1KMbSGCYaPwPUrdIiOY2lL1GehXgGQw2LqNMgCKZkbWhcKj3+d3obKiNrgtGEjpuXRkoTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWN0ibqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EFDC4CEC7;
	Mon, 30 Sep 2024 11:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727696956;
	bh=LdMjeWOvWQmXsFOhFljZfMzxfLvHYOZPCl97KMG/8oU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZWN0ibqQxBa9ir+uHeF6E3sKHf5StyJomm75FIZRoE3KpNG2zjD+YJafRUJzZbNVY
	 oZBfEhrlIM0WQuFp4iVP8NQpkDkJrN9rV2qljAmzjI5a2jq8MuhYcN+Hfdf8BVjjXK
	 gHeSJwU7foyOmKlq/3KznzjFgQ4WgqtVXe21J/4/iLBAEMZVcDoACTBTvhgKGmG6G2
	 i3umOgeNLlVliUZMCgktr/OrYjH3Q1m0cM5bZlCIpbEXaSJDhWueSmNLRDifpZBQ81
	 N1TPpS82JemMksVtMVFaxoLBO/OOun+GZCrwO4jFnXnanlGB+Os5kFCdNjejm6t4IQ
	 ci0tpg/YFGeZQ==
Date: Mon, 30 Sep 2024 13:49:14 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Arthur Fabre <afabre@cloudflare.com>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
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
Message-ID: <ZvqQOpqnK9hBmXNn@lore-desk>
References: <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
 <Zu_gvkXe4RYjJXtq@lore-desk>
 <87ldzkndqk.fsf@toke.dk>
 <CAOn4ftshf3pyAst27C2haaSj4eR2n34_pcwWBc5o3zHBkwRb3g@mail.gmail.com>
 <87wmiysi37.fsf@toke.dk>
 <D4GBY7CHJNJ6.3O18I5W1FTPKR@bobby>
 <87ldzds8bp.fsf@toke.dk>
 <D4H5CAN4O95E.3KF8LAH75FYD4@bobby>
 <ZvbKDT-2xqx2unrx@lore-rh-laptop>
 <871q11s91e.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GQ4+YiJqd2ay7ThK"
Content-Disposition: inline
In-Reply-To: <871q11s91e.fsf@toke.dk>


--GQ4+YiJqd2ay7ThK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> >> > We could combine such a registration API with your header format, so
> >> > that the registration just becomes a way of allocating one of the ke=
ys
> >> > from 0-63 (and the registry just becomes a global copy of the header=
).
> >> > This would basically amount to moving the "service config file" into=
 the
> >> > kernel, since that seems to be the only common denominator we can re=
ly
> >> > on between BPF applications (as all attempts to write a common daemon
> >> > for BPF management have shown).
> >>=20
> >> That sounds reasonable. And I guess we'd have set() check the global
> >> registry to enforce that the key has been registered beforehand?
> >>=20
> >> >
> >> > -Toke
> >>=20
> >> Thanks for all the feedback!
> >
> > I like this 'fast' KV approach but I guess we should really evaluate its
> > impact on performances (especially for xdp) since, based on the kfunc c=
alls
> > order in the ebpf program, we can have one or multiple memmove/memcpy f=
or
> > each packet, right?
>=20
> Yes, with Arthur's scheme, performance will be ordering dependent. Using
> a global registry for offsets would sidestep this, but have the
> synchronisation issues we discussed up-thread. So on balance, I think
> the memmove() suggestion will probably lead to the least pain.
>=20
> For the HW metadata we could sidestep this by always having a fixed
> struct for it (but using the same set/get() API with reserved keys). The
> only drawback of doing that is that we statically reserve a bit of
> space, but I'm not sure that is such a big issue in practice (at least
> not until this becomes to popular that the space starts to be contended;
> but surely 256 bytes ought to be enough for everybody, right? :)).

I am fine with the proposed approach, but I think we need to verify what is=
 the
impact on performances (in the worst case??)

>=20
> > Moreover, I still think the metadata area in the xdp_frame/xdp_buff is =
not
> > so suitable for nic hw metadata since:
> > - it grows backward=20
> > - it is probably in a different cacheline with respect to xdp_frame
> > - nic hw metadata will not start at fixed and immutable address, but it=
 depends
> >   on the running ebpf program
> >
> > What about having something like:
> > - fixed hw nic metadata: just after xdp_frame struct (or if you want at=
 the end
> >   of the metadata area :)). Here he can reuse the same KV approach if i=
t is fast
> > - user defined metadata: in the metadata area of the xdp_frame/xdp_buff
>=20
> AFAIU, none of this will live in the (current) XDP metadata area. It
> will all live just after the xdp_frame struct (so sharing the space with
> the metadata area in the sense that adding more metadata kv fields will
> decrease the amount of space that is usable by the current XDP metadata
> APIs).
>=20
> -Toke
>=20

ah, ok. I was thinking the proposed approach was to put them in the current
metadata field.

Regards,
Lorenzo

--GQ4+YiJqd2ay7ThK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZvqQOgAKCRA6cBh0uS2t
rGkuAQCmulofR6KOgXgxkWcGibFa1jwuC0775cIm7T7UJF/UGgD+LckA1Ajz0mTw
JthRYUOaufHS5mqZINS8eYzxUnCRwgo=
=HK1x
-----END PGP SIGNATURE-----

--GQ4+YiJqd2ay7ThK--

