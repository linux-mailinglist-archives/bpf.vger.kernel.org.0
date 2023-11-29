Return-Path: <bpf+bounces-16159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBB97FDD2B
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 17:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2E01C20D65
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 16:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC8D3B285;
	Wed, 29 Nov 2023 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI6fKFKY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9DF374CF;
	Wed, 29 Nov 2023 16:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DC2C433C7;
	Wed, 29 Nov 2023 16:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701275765;
	bh=f8jHdiXtK0L6HqAZSe4jGsEUD2I+G2hBQQOeTpUpJIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jI6fKFKYgwzcCQx2665BPIhcLP1s3fNPvATmDdh3hEjhzSYnERjqriRAevqnzF9S1
	 xDQdrf1yNNbPIzn02LIfhfyvKr84Ro1leWnM+LJAstkVCXguAMRFHKyx8P95JfMy4/
	 GLYVg46uVVHtXs8qA7f3H5LaA7wGVTW/ulADVuPl7zfoC2BLN3Y/EL2wWksxuY27S+
	 V5LxqeqsBs8im0EAAEA+gDJnwyId+fP+kM0zi+4gr10+tku2XKqJEm4MUbjwN/4WP/
	 o3++QrvovggeqMdYeckVquAfnfysFIPwGqVBTMyIYNbLOBWqpNL503v9yAhaMu/EZJ
	 oLGJqp4iB3fDQ==
Date: Wed, 29 Nov 2023 17:36:01 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	bpf@vger.kernel.org, hawk@kernel.org, toke@redhat.com
Subject: Re: [PATCH net-next] xdp: add multi-buff support for xdp running in
 generic mode
Message-ID: <ZWdocaE6A801wwpd@lore-desk>
References: <c928f7c698de070b33d38f230081fd4f993f2567.1701128026.git.lorenzo@kernel.org>
 <ZWYjcNlo7RAX8M0T@lore-desk>
 <20231128105145.7b39db7d@kernel.org>
 <ZWZpUaYbgMELGtL8@lore-desk>
 <20231128151028.168e7a13@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8Q0WNh2/oIryI2km"
Content-Disposition: inline
In-Reply-To: <20231128151028.168e7a13@kernel.org>


--8Q0WNh2/oIryI2km
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 28 Nov 2023 23:27:29 +0100 Lorenzo Bianconi wrote:
> > > Yes, don't we allow writes to fragments in XDP based on the assumption
> > > that it runs on Rx so that paged data must not be zero copy?
> > > bpf_xdp_store_bytes() doesn't seem to have any checks which would
> > > stop it from writing fragments, as far as I can see. =20
> >=20
> > do you mean in the skb use-case we could write to fragments (without co=
pying
> > them) if the skb is not cloned and the paged area is not 'zero-copied'?
>=20
> The zero-copy thing is a red herring. If application uses
> sendpage/sendfile/splice the frag may be a page cache page
> of a file. Or something completely read only.

ack, thx for pointing this out. It is clear now :)

>=20
> IIUC you're trying to avoid the copy if the prog is mbuf capable.
> So I was saying that can't work for forms of XDP which actually=20
> deal with skbs. But that wasn't really your question, sorry :)
>=20
> > With respect to this patch it would mean we can rely on pskb_expand_hea=
d() to
> > reallocate the skb and to covert it to a xdp_buff and we do not need to=
 explicitly
> > reallocate fragments as we currently do for veth in veth_convert_skb_to=
_xdp_buff() [0].
> > Is my understanding correct or am I missing something?
>=20
> The difference is that pskb_expand_head() will give you a linear skb,
> potentially triggering an order 5 allocation. Expensive and likely to
> fail under memory pressure.

ack

>=20
> veth_convert_skb_to_xdp_buff() tries to allocate pages, and keep
> the skb fragmented.

I will rework the patch using this approach.

Regards,
Lorenzo

--8Q0WNh2/oIryI2km
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZWdocQAKCRA6cBh0uS2t
rJbpAP9NAjCMUjE3ul7ctYWcJ8TfWWkyKiWJ2evilcmu8dHL5AEAnK+gZBK1MWJS
vrNrfS4qaf0g/Z8njp/YnL2B9OT37A4=
=zRnU
-----END PGP SIGNATURE-----

--8Q0WNh2/oIryI2km--

