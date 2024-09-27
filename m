Return-Path: <bpf+bounces-40423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395479887EA
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 17:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33502811DA
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21D91C1724;
	Fri, 27 Sep 2024 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfVSQgHf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37072142621;
	Fri, 27 Sep 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449619; cv=none; b=SAfJ7GAozKd6FG4BI+DhyDdh8CL1yJarebvoOSJZGaYTyUK6+SRBtOJkZKohyE6ufO8Au8k6Dhxy4N1FJMRcFRj6sxqXF4UiVa3XYSfto5GrHcWn1CUzBl8s8ImbwK36wdoNsQL1dutIJPME/m6bB/Cw7y0hnO9yt066L6R0epc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449619; c=relaxed/simple;
	bh=MyFqb+wY84HD5T6WosrUNw3USR4E0d33ftvlJocCEQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScZ8y6J1kzw6L5+pWUM5pkMm7gKsDXW02ZR4HA9l1kAdgKGpYwGZpVUAzRSiFM8/5vUeJ1NJNJxXTD13kGaQWqVUgEYMiuMqA3ElqMBNZBnAfohuLFEKU56PZZp780pS8vFzv0J30pZnHJ7nF+gFsuHFzNTKaQahkpeKYHQGkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfVSQgHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1010C4CEC4;
	Fri, 27 Sep 2024 15:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727449618;
	bh=MyFqb+wY84HD5T6WosrUNw3USR4E0d33ftvlJocCEQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfVSQgHfGmeSMNrmQoolcxikQ0ogy6NTCoTpYNpXh6GSZPVUWyWRmlWVlr8Kxyn6O
	 dm0I+ivnMdahpDJGpOwJL5MxtF0uSWacZEDrH2LZKQLHftKIBUXtH0KJovZGNjlRCv
	 zIAWsTqQA5/5zygFRsnOwgbAt1WcCBrCuLfxiDjEfDDRnGxoSxyyajE/ar5ejYYoRe
	 C2xBIxTZbLoeAAkSd9KXVEW8P4t/AXHrnHRwL2wWINIwg+zU6s8dN7kR4Ow+gMrDER
	 P8056GaHrnLkfbH6k5PjlZPcIdSx/onmhJVTCI/LWR/S9iWLwY1U8C9KLTBQ0o9NpL
	 KS/rMBiXXKe7g==
Date: Fri, 27 Sep 2024 17:06:53 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Arthur Fabre <afabre@cloudflare.com>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
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
Message-ID: <ZvbKDT-2xqx2unrx@lore-rh-laptop>
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
 <Zu_gvkXe4RYjJXtq@lore-desk>
 <87ldzkndqk.fsf@toke.dk>
 <CAOn4ftshf3pyAst27C2haaSj4eR2n34_pcwWBc5o3zHBkwRb3g@mail.gmail.com>
 <87wmiysi37.fsf@toke.dk>
 <D4GBY7CHJNJ6.3O18I5W1FTPKR@bobby>
 <87ldzds8bp.fsf@toke.dk>
 <D4H5CAN4O95E.3KF8LAH75FYD4@bobby>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="48nyGz3vm9X8yMny"
Content-Disposition: inline
In-Reply-To: <D4H5CAN4O95E.3KF8LAH75FYD4@bobby>


--48nyGz3vm9X8yMny
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 27, Arthur Fabre wrote:
> On Fri Sep 27, 2024 at 12:24 PM CEST, Toke H=F8iland-J=F8rgensen wrote:
> > "Arthur Fabre" <afabre@cloudflare.com> writes:
> >
> > >> >> The nice thing about an API like this, though, is that it's exten=
sible,
> > >> >> and the kernel itself can be just another consumer of it for the
> > >> >> metadata fields Lorenzo is adding in this series. I.e., we could =
just
> > >> >> pre-define some IDs for metadata vlan, timestamp etc, and use the=
 same
> > >> >> functions as above from within the kernel to set and get those va=
lues;
> > >> >> using the registry, there could even be an option to turn those o=
ff if
> > >> >> an application wants more space for its own usage. Or, alternativ=
ely, we
> > >> >> could keep the kernel-internal IDs hardcoded and always allocated=
, and
> > >> >> just use the getter/setter functions as the BPF API for accessing=
 them.
> > >> >
> > >> > That's exactly what I'm thinking of too, a simple API like:
> > >> >
> > >> > get(u8 key, u8 len, void *val);
> > >> > set(u8 key, u8 len, void *val);
> > >> >
> > >> > With "well-known" keys like METADATA_ID_HW_HASH for hardware metad=
ata.
> > >> >
> > >> > If a NIC doesn't support a certain well-known metadata, the key
> > >> > wouldn't be set, and get() would return ENOENT.
> > >> >
> > >> > I think this also lets us avoid having to "register" keys or bits =
of
> > >> > metadata with the kernel.
> > >> > We'd reserve some number of keys for hardware metadata.
> > >>
> > >> Right, but how do you allocate space/offset for each key without an
> > >> explicit allocation step? You'd basically have to encode the list of=
 IDs
> > >> in the metadata area itself, which implies a TLV format that you hav=
e to
> > >> walk on every access? The registry idea in my example above was
> > >> basically to avoid that...
> > >
> > > I've been playing around with having a small fixed header at the front
> > > of the metadata itself, that lets you access values without walking t=
hem
> > > all.
> > >
> > > Still WIP, and maybe this is too restrictive, but it lets you encode =
64
> > > 2, 4, or 8 byte KVs with a single 16 byte header:
> >
> > Ohh, that's clever, I like it! :)
> >
> > It's also extensible in the sense that the internal representation can
> > change without impacting the API, so if we end up needing more bits we
> > can always add those.
> >
> > Maybe it would be a good idea to make the 'key' parameter a larger
> > integer type (function parameters are always 64-bit anyway, so might as
> > well go all the way up to u64)? That way we can use higher values for
> > the kernel-reserved types instead of reserving part of the already-small
> > key space for applications (assuming the kernel-internal data is stored
> > somewhere else, like in a static struct as in Lorenzo's patch)?
>=20
> Good idea! That makes it more extensible too if we ever support more
> keys or bigger lengths.
>=20
> I'm not sure where the kernel-reserved types should live. Putting them
> in here uses up some the of KV IDs, but it uses less head room space than=
=20
> always reserving a static struct for them.
> Maybe it doesn't matter much, as long as we use the same API to access
> them, we could internally switch between one and the other.
>=20
> >
> > [...]
> >
> > >> > The remaining keys would be up to users. They'd have to allocate k=
eys
> > >> > to services, and configure services to use those keys.
> > >> > This is similar to the way listening on a certain port works: only=
 one
> > >> > service can use port 80 or 443, and that can typically beconfigure=
d in
> > >> > a service's config file.
> > >>
> > >> Right, well, port numbers *do* actually have an out of band service
> > >> registry (IANA), which I thought was what we wanted to avoid? ;)
> > >
> > > Depends how you think about it ;)
> > >
> > > I think we should avoid a global registry. But having a registry per
> > > deployment / server doesn't seem awful. Services that want to use a
> > > field would have a config file setting to set which index it correspo=
nds
> > > to.
> > > Admins would just have to pick a free one on their system, and set it=
 in
> > > the config file of the service.
> > >
> > > This is similar to what we do for non-IANA registered ports internall=
y.
> > > For example each service needs a port on an internal interface to exp=
ose
> > > metrics, and we just track which ports are taken in our config
> > > management.
> >
> > Right, this would work, but it assumes that applications are
> > well-behaved and do this correctly. Which they probably do in a
> > centrally-managed system like yours, but for random applications shipped
> > by distros, I'm not sure if it's going to work.
> >
> > In fact, it's more or less the situation we have with skb->mark today,
> > isn't it? I.e., applications can co-exist as long as they don't use the
> > same bits, so they have to coordinate on which bits to use. Sure, with
> > this scheme there will be more total bits to use, which can lessen the
> > pressure somewhat, but the basic problem remains. In other words, I
> > worry that in practice we will end up with another github repository
> > serving as a registry for metadata keys...
>=20
> That's true. If applications hardcode keys, we'll be back to having
> conflicts. If someone creates a registry on github I'll be very sad.
>=20
> (Maybe we can make the verifier enforce that the key passed to get() and
> set() isn't a constant? - only joking)
>=20
> Applications don't tend to do this for ports though, I think most can be
> configured to listen on any port. Is that just because it's been
> instilled as "good practice" over time? Could we try to do the same with
> some very stern documentation and examples?
>=20
> Thinking about it more, my only relectance for a registration API is how
> to communicate the ID back to other consumers (our discussion below).
>=20
> >
> > > Dynamically registering fields means you have to share the returned ID
> > > with whoever is interested, which sounds tricky.
> > > If an XDP program sets a field like packet_id, every tracing
> > > program that looks at it, and userspace service, would need to know w=
hat
> > > the ID of that field is.
> > > Is there a way to easily share that ID with all of them?
> >
> > Right, so I'll admit this was one of the handwavy bits of my original
> > proposal, but I don't think it's unsolvable. You could do something like
> > (once, on application initialisation):
> >
> > __u64 my_key =3D bpf_register_metadata_field(my_size); /* maybe add a n=
ame for introspection? */
> > bpf_map_update(&shared_application_config, &my_key_index, &my_key);
> >
> > and then just get the key out of that map from all programs that want to
> > use it?
>=20
> Passing it out of band works (whether it's via a pinned map like you
> described, or through other means like a unix socket or some other
> API), it's just more complicated.
>=20
> Every consumer also needs to know about that API. That won't work with
> standard tools. For example if we set a PACKET_ID KV, maybe we could
> give it to pwru so it could track packets using it?
> Without registering keys, we could pass it as a cli flag. With
> registration, we'd have to have some helper to get the KV ID.
>=20
> It also introduces ordering dependencies between the services on
> startup, eg packet tracing hooks could only be attached once our XDP
> service has registered a PACKET_ID KV, and they could query it's API.
>=20
> >
> > We could combine such a registration API with your header format, so
> > that the registration just becomes a way of allocating one of the keys
> > from 0-63 (and the registry just becomes a global copy of the header).
> > This would basically amount to moving the "service config file" into the
> > kernel, since that seems to be the only common denominator we can rely
> > on between BPF applications (as all attempts to write a common daemon
> > for BPF management have shown).
>=20
> That sounds reasonable. And I guess we'd have set() check the global
> registry to enforce that the key has been registered beforehand?
>=20
> >
> > -Toke
>=20
> Thanks for all the feedback!

I like this 'fast' KV approach but I guess we should really evaluate its
impact on performances (especially for xdp) since, based on the kfunc calls
order in the ebpf program, we can have one or multiple memmove/memcpy for
each packet, right?

Moreover, I still think the metadata area in the xdp_frame/xdp_buff is not
so suitable for nic hw metadata since:
- it grows backward=20
- it is probably in a different cacheline with respect to xdp_frame
- nic hw metadata will not start at fixed and immutable address, but it dep=
ends
  on the running ebpf program

What about having something like:
- fixed hw nic metadata: just after xdp_frame struct (or if you want at the=
 end
  of the metadata area :)). Here he can reuse the same KV approach if it is=
 fast
- user defined metadata: in the metadata area of the xdp_frame/xdp_buff

Regards,
Lorenzo

--48nyGz3vm9X8yMny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZvbKCwAKCRA6cBh0uS2t
rF5lAQDTdLyjQu9LBlYXr/x+szI6oCwR7y7mQizpEprqoM5cZAEAnFSLkOtb3uYb
tK14RGKLKIvhpK4/Q4SfAnUM/napRAM=
=3nAl
-----END PGP SIGNATURE-----

--48nyGz3vm9X8yMny--

