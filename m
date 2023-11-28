Return-Path: <bpf+bounces-16079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B417FC978
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 23:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A901F20FA4
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 22:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A578250251;
	Tue, 28 Nov 2023 22:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYLYNHOv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9D944366;
	Tue, 28 Nov 2023 22:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0214DC433C8;
	Tue, 28 Nov 2023 22:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701210453;
	bh=04F+iXERWAsV/8CXaqHzZVtjCJOAl9lktzBIuH5wpew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYLYNHOvqJjPjPw5gEEuQhmsWNWUj3HdNCUeFsLj7C6iusDNGH6Rr/cHSPzSW2ml3
	 M3Vfk/OQDOXeHb0N/nQ5u3OhmX7khQEUW6jyk1OFS/uNsrzFtizAvSr58+fYwQt2xe
	 EJU6zH0+ZbhOogRQuNq1IZ7RO7mLJiuVdQ17L9Q/PkmrXCtaWvPr2h/dmEi/1xDcDB
	 Cm2PNm2R6mR/lj3atgT9DAwoQcMZQJjascfwJLJBWN/mQjAmrLPfA0SnV0OuiWiObV
	 oyhY38GgjMqr8cya4hTGiCsHn3neUgLyYSdIC1kDE5Y8XCjNkn3Sj6JYxiBptnnZxY
	 Pmlvk3W7W+zQg==
Date: Tue, 28 Nov 2023 23:27:29 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	bpf@vger.kernel.org, hawk@kernel.org, toke@redhat.com
Subject: Re: [PATCH net-next] xdp: add multi-buff support for xdp running in
 generic mode
Message-ID: <ZWZpUaYbgMELGtL8@lore-desk>
References: <c928f7c698de070b33d38f230081fd4f993f2567.1701128026.git.lorenzo@kernel.org>
 <ZWYjcNlo7RAX8M0T@lore-desk>
 <20231128105145.7b39db7d@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gC/3SwtxUEU238us"
Content-Disposition: inline
In-Reply-To: <20231128105145.7b39db7d@kernel.org>


--gC/3SwtxUEU238us
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 28 Nov 2023 18:29:20 +0100 Lorenzo Bianconi wrote:
> > @Jakub: iirc we were discussing something similar for veth [0].
> > Here pskb_expand_head() reallocates skb paged data (skb_shinfo()->frags=
[])
> > just if the skb is cloned and if it is zero-copied [1] while in skb_cow=
_data()
> > we always reallocate the paged area if skb_shinfo()->nr_frags is set [2=
].
> > Since the eBPF program can theoretically modify paged data, I would say=
 we
> > should do the same we did for veth even here, right?
>=20
> Yes, don't we allow writes to fragments in XDP based on the assumption
> that it runs on Rx so that paged data must not be zero copy?
> bpf_xdp_store_bytes() doesn't seem to have any checks which would
> stop it from writing fragments, as far as I can see.

do you mean in the skb use-case we could write to fragments (without copying
them) if the skb is not cloned and the paged area is not 'zero-copied'?
With respect to this patch it would mean we can rely on pskb_expand_head() =
to
reallocate the skb and to covert it to a xdp_buff and we do not need to exp=
licitly
reallocate fragments as we currently do for veth in veth_convert_skb_to_xdp=
_buff() [0].
Is my understanding correct or am I missing something?

Regards,
Lorenzo

[0] https://elixir.bootlin.com/linux/v6.6.2/source/drivers/net/veth.c#L738

>=20
> I don't see how we can ever correctly support this form of mbuf for veth
> or generic XDP :(

--gC/3SwtxUEU238us
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZWZpUQAKCRA6cBh0uS2t
rK6QAP93RX92PWmxSQBfGtoUI6EiMJChVdJXQfd350Lsoyg9RwEAhimuSCxvoqyC
vETLuN+LxSBTVctwTh0KCONqKRaG0Aw=
=Cxz3
-----END PGP SIGNATURE-----

--gC/3SwtxUEU238us--

