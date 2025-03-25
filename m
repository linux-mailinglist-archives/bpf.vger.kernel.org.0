Return-Path: <bpf+bounces-54683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A65EA7023A
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 14:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575CB19A1B53
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC53D25D55A;
	Tue, 25 Mar 2025 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmLbCOHO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E1A18C930;
	Tue, 25 Mar 2025 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909328; cv=none; b=kr1AtUE1GOZnMltcjommCjq0j2WyanETPMckyUGZvlTdTkWyYsIWDfcAi+/Lz/7N7g/cwNDTaEn7+krM1QdRHkwyyN2LHrmCe8UtBnyFoFmySoypggywZiArBzz2PNPHae0DhGMyggqDJtsQN3YnOVFtMvdhzt1f8G8Dc/0aXW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909328; c=relaxed/simple;
	bh=dmvM6IN5Dthvxa5kh8GBs+FInlsd/ahwhF0FbdrWGqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1DRX/OBeDPRlH1deCn+7sMZLEmwuJMxPjz5roSXJSHJyFJtSvxXAHtztSXfrhwALammIegg6apOFVy9MrDPB8ogBZfIot580BiWZ2eDtbArX4965KPkBilgWHrURrEXsVHNJtBvalH4njtsiYoP73tFAWdZy218/WSmvz4hzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmLbCOHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117DCC4CEE4;
	Tue, 25 Mar 2025 13:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742909327;
	bh=dmvM6IN5Dthvxa5kh8GBs+FInlsd/ahwhF0FbdrWGqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EmLbCOHOih8hX0taTqKGfc5nAPd/Dpwg4C9VeIXPHSWWUjSbWi45uoM2BDlvUB+q0
	 HkzPlh/SjtVAf1CjUps8m/r9f5auBR7XTojLfrSfaROckQVfpVZFdka7Y9mXcbDU80
	 5ueJfukfGutY7ahZ6Gt1WaugQ3S8ITJiNT8M6PNHCepcqZQhi1AT0LFDo9HImWxW7p
	 /GtDVP6DT4UMw5tp9xX8pNSFJYMcvaqzDeh+MjuJj68HIAmIfq/OBkVw+J/FxmDS9/
	 k098C4S9DpBuIZKRDGBVSdBr7VcR9pMaa40u79KHwdi5vkmBjuIoJKJ7zvawCuApxq
	 TmXu7t6vo1wEQ==
Date: Tue, 25 Mar 2025 14:28:41 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-omap@vger.kernel.org, Michal Kubiak <michal.kubiak@intel.com>
Subject: Re: [PATCH net-next v2 4/7] net: octeontx2: Add metadata support for
 xdp mode
Message-ID: <Z-Kvia3EhrtAjKOG@lore-rh-laptop>
References: <20250318-mvneta-xdp-meta-v2-0-b6075778f61f@kernel.org>
 <20250318-mvneta-xdp-meta-v2-4-b6075778f61f@kernel.org>
 <20250325044126.1c0f9b83@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E4yhCdChUNhJbUGb"
Content-Disposition: inline
In-Reply-To: <20250325044126.1c0f9b83@kernel.org>


--E4yhCdChUNhJbUGb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 18 Mar 2025 12:46:08 +0100 Lorenzo Bianconi wrote:
> > @@ -1514,13 +1518,14 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx=
2_nic *pfvf,
> > =20
> >  	hard_start =3D (unsigned char *)phys_to_virt(pa);
> >  	xdp_prepare_buff(&xdp, hard_start, OTX2_HEAD_ROOM,
> > -			 cqe->sg.seg_size, false);
> > +			 cqe->sg.seg_size, true);
> > =20
> >  	act =3D bpf_prog_run_xdp(prog, &xdp);
> > =20
> >  handle_xdp_verdict:
> >  	switch (act) {
> >  	case XDP_PASS:
> > +		*metasize =3D xdp.data - xdp.data_meta;
> >  		break;
> >  	case XDP_TX:
> >  		qidx +=3D pfvf->hw.tx_queues;
>=20
> This one handles ABORT and invalid return codes as PASS not DROP.
> That should probably be fixed separately?

Yes, right. I will post a fix for it.

Regards,
Lorenzo

--E4yhCdChUNhJbUGb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ+KvhgAKCRA6cBh0uS2t
rJqvAP9OpMaZdQLvzyjRJ+yYPN1BtI+hjZJfXaRH2utWQHb7uwD+L6oltUUEGPYK
Pxr4Ki69CfDwCdxPyDpzyKCdOPyfDAk=
=cnQi
-----END PGP SIGNATURE-----

--E4yhCdChUNhJbUGb--

