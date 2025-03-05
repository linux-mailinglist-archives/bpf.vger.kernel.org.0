Return-Path: <bpf+bounces-53372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEA6A505E1
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 18:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2081D3AA0F9
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603C624A05F;
	Wed,  5 Mar 2025 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="JPw8WTR9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SfllN+YQ"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CB1ACEC6;
	Wed,  5 Mar 2025 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194131; cv=none; b=pKH7hhmLvKiBJ26nGmusB1MDR6Rt/hIzfUyFTpZsa+pw/zpAISB7tUKx3QJMt47BAGx8EHebvhT59SIn53ZhJMw7S8c981GQ8FFWj6KdW+M6Yy1rJTM47aD3a41F6SGRLVgr81uQRFl1E1gsLL81mpKtxkS167Zp035RCLjh4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194131; c=relaxed/simple;
	bh=xxTUT3hdMOyAGgiz5DA93BGgJAJirNzILMlaS1W1R3U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PL6N3LyHlcGB5VMDq8+EjYWKbGYMIciQHa34yWCUx3cCK5e+Rw8iQpadxGwcNUfT8pJtD4rnA0rcQ9Ir8NiOlUJ5hXrvb3sJfjFzMPT3sJNoIn8X0BQEYvDwDACnUVHe/r7yjYioKDPC1Xl5QlKO61XEWIFCGDT4MzbaHwzD1o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=JPw8WTR9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SfllN+YQ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5B4E11401D9;
	Wed,  5 Mar 2025 12:02:07 -0500 (EST)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-09.internal (MEProxy); Wed, 05 Mar 2025 12:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741194127; x=1741280527; bh=g8axi8rrbBC3EqxPS9kqsfgotXviAvz6
	BbePmttxIBQ=; b=JPw8WTR94I3C1QaZHJL4bH4ZhJQrgtznvILvT9t+WwWwxwFh
	fM7d5GdKCtT5+K2kGzQK9MPHjAz+qLU7bBqvMTMx6dB2rnU1Ep5JlScN9QNrwyzn
	bxdEBRix+tXGSHeQPwQ/f2XceK1UtN7ykIhsi2csW4TdmPnxDp24W4b/Ey65oNh8
	d+aPSCqyLbCLyaikrANComgIJX7ZiNROwxqLQbQyPvrvZMJEMF5T9I+L+2vytoXa
	8OZY8M8tUIT7slXfpPQAtoh86K/Ne1sT2vWkraeX2VkAOP1hKIea+eyD6+enNdal
	fVLKQgsQplZeW8kG7J9n2smYeDYvwv3FAeJEvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741194127; x=
	1741280527; bh=g8axi8rrbBC3EqxPS9kqsfgotXviAvz6BbePmttxIBQ=; b=S
	fllN+YQ7ADeVZBHBXAF6tALWxeromUav8EiXdn5pMWET8VdDVDWYrfw6awF8eO/F
	+w+XnrfbOdgY2YJgemhXLWeU34esc1jj4tIATi7lk7AAVfmqJhLSkTYVMoPjyg1Q
	uWLzvXeq+pGCYgQpKbIoOP+scwWfM4sCS8nOR/ZvQ2LsDQV+3mVFHK0n88xsaI61
	VvH7shHLPnf+wR/YgCc1OY9cWhhDoIcixW9qLjKsWJBj426Y2SI44djCU4g6cFLo
	BUle2sDQLRusoiKggnZlXocblPWU+CogxU/oGF5j0Z6c0MlwBRoiI6cWjSy/bZ8N
	DlGufTYJANoxGfYUJKAjg==
X-ME-Sender: <xms:j4PIZ5wHKTFPhT04kagaxSpnbSfgaWg8V2_ZKlYakCIETePFgdVdHg>
    <xme:j4PIZ5SBFF-dFTUUPaBZrAEZr37ctDAT0vxgM7sH4BjYYcZ-teXX0WU6BIJKev-9C
    M7v9bALaXOlgAGUtlk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofgggfgtfffkvefuhffvofhfjgesthhqredt
    redtjeenucfhrhhomhepfdetrhhthhhurhcuhfgrsghrvgdfuceorghrthhhuhhrsegrrh
    hthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtthgvrhhnpefhfeejgefhhffhveel
    teehhfffheffvdettdelgfeltefhteelveeuffetfffgjeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgr
    sghrvgdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegrfhgrsghrvgestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohep
    jhgrkhhusgestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepjhgsrhgrnhguvg
    gsuhhrghestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohephigrnhestghlohhu
    ughflhgrrhgvrdgtohhmpdhrtghpthhtoheprghlvghkshgrnhguvghrrdhlohgsrghkih
    hnsehinhhtvghlrdgtohhmpdhrtghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepth
    hhohhilhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopegsphhfsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:j4PIZzV89qtzO87Bz9enGTCvmjFG1aic1mMl705fiJp15DPTTpPqJA>
    <xmx:j4PIZ7jsSWckxGOPvbtxPbBE2psqHbFhB1SA2lRprCxG4rgRp0EkKA>
    <xmx:j4PIZ7DeCmvrEdPvZXOk9JimkUnxW63U1dlz3bBwjweClklC2K3jYQ>
    <xmx:j4PIZ0KN2cL3gMqKKenFSP6hCcX6gP7_nh4eOkPnNILvESok4UJbDg>
    <xmx:j4PIZ3urEy5ldaKfhmlcEL2uwTA3ZSIdEevHAtZrU31isxFmkwZ0FI7Q>
Feedback-ID: i9179493c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 34AB61F00083; Wed,  5 Mar 2025 12:02:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Mar 2025 18:02:06 +0100
Message-Id: <D88HSZ3GZZNN.160YSWHX1HIO2@arthurfabre.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <jakub@cloudflare.com>,
 <hawk@kernel.org>, <yan@cloudflare.com>, <jbrandeburg@cloudflare.com>,
 <thoiland@redhat.com>, <lbiancon@redhat.com>, "Arthur Fabre"
 <afabre@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 07/20] xdp: Track if metadata is supported
 in xdp_frame <> xdp_buff conversions
From: "Arthur Fabre" <arthur@arthurfabre.com>
To: "Alexander Lobakin" <aleksander.lobakin@intel.com>
X-Mailer: aerc 0.17.0
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com> <20250305-afabre-traits-010-rfc2-v1-7-d0ecfb869797@cloudflare.com> <bc356c91-5bff-454a-8f87-7415cb7e82b4@intel.com>
In-Reply-To: <bc356c91-5bff-454a-8f87-7415cb7e82b4@intel.com>

On Wed Mar 5, 2025 at 4:24 PM CET, Alexander Lobakin wrote:
> From: Arthur <arthur@arthurfabre.com>
> Date: Wed, 05 Mar 2025 15:32:04 +0100
>
> > From: Arthur Fabre <afabre@cloudflare.com>
> >=20
> > xdp_buff stores whether metadata is supported by a NIC by setting
> > data_meta to be greater than data.
> >=20
> > But xdp_frame only stores the metadata size (as metasize), so convertin=
g
> > between xdp_frame and xdp_buff is lossy.
> >=20
> > Steal an unused bit in xdp_frame to track whether metadata is supported
> > or not.
> >=20
> > This will lets us have "generic" functions for setting skb fields from
> > either xdp_frame or xdp_buff from drivers.
> >=20
> > Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> > ---
> >  include/net/xdp.h | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index 58019fa299b56dbd45c104fdfa807f73af6e4fa4..84afe07d09efdb2ab0cb78b=
904f02cb74f9a56b6 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -116,6 +116,9 @@ static __always_inline void xdp_buff_set_frag_pfmem=
alloc(struct xdp_buff *xdp)
> >  	xdp->flags |=3D XDP_FLAGS_FRAGS_PF_MEMALLOC;
> >  }
> > =20
> > +static bool xdp_data_meta_unsupported(const struct xdp_buff *xdp);
> > +static void xdp_set_data_meta_invalid(struct xdp_buff *xdp);
> > +
> >  static __always_inline void *xdp_buff_traits(const struct xdp_buff *xd=
p)
> >  {
> >  	return xdp->data_hard_start + _XDP_FRAME_SIZE;
> > @@ -270,7 +273,9 @@ struct xdp_frame {
> >  	void *data;
> >  	u32 len;
> >  	u32 headroom;
> > -	u32 metasize; /* uses lower 8-bits */
> > +	u32	:23, /* unused */
> > +		meta_unsupported:1,
> > +		metasize:8;
>
> See the history of this structure how we got rid of using bitfields here
> and why.
>
> ...because of performance.
>
> Even though metasize uses only 8 bits, 1-byte access is slower than
> 32-byte access.

Interesting, thanks!

> I was going to write "you can use the fact that metasize is always a
> multiple of 4 or that it's never > 252, for example, you could reuse LSB
> as a flag indicating that meta is not supported", but first of all
>
> Do we still have drivers which don't support metadata?
> Why don't they do that? It's not HW-specific or even driver-specific.
> They don't reserve headroom? Then they're invalid, at least XDP_REDIRECT
> won't work.
>
> So maybe we need to fix those drivers first, if there are any.

Most drivers don't support metadata unfortunately:

> rg -U "xdp_prepare_buff\([^)]*false\);" drivers/net/
drivers/net/tun.c
1712:		xdp_prepare_buff(&xdp, buf, pad, len, false);

drivers/net/ethernet/microsoft/mana/mana_bpf.c
94:	xdp_prepare_buff(xdp, buf_va, XDP_PACKET_HEADROOM, pkt_len, false);

drivers/net/ethernet/marvell/mvneta.c
2344:	xdp_prepare_buff(xdp, data, pp->rx_offset_correction + MVNETA_MH_SIZE=
,
2345:			 data_len, false);

drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
1436:	xdp_prepare_buff(&xdp, hard_start, OTX2_HEAD_ROOM,
1437:			 cqe->sg.seg_size, false);

drivers/net/ethernet/socionext/netsec.c
1021:		xdp_prepare_buff(&xdp, desc->addr, NETSEC_RXBUF_HEADROOM,
1022:				 pkt_len, false);

drivers/net/ethernet/google/gve/gve_rx.c
740:	xdp_prepare_buff(&new, frame, headroom, len, false);
859:		xdp_prepare_buff(&xdp, page_info->page_address +
860:				 page_info->page_offset, GVE_RX_PAD,
861:				 len, false);

drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
3984:			xdp_prepare_buff(&xdp, data,
3985:					 MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM,
3986:					 rx_bytes, false);

drivers/net/ethernet/aquantia/atlantic/aq_ring.c
794:		xdp_prepare_buff(&xdp, hard_start, rx_ring->page_offset,
795:				 buff->len, false);

drivers/net/ethernet/cavium/thunder/nicvf_main.c
554:	xdp_prepare_buff(&xdp, hard_start, data - hard_start, len, false);

drivers/net/ethernet/ti/cpsw_new.c
348:		xdp_prepare_buff(&xdp, pa, headroom, size, false);

drivers/net/ethernet/freescale/enetc/enetc.c
1710:	xdp_prepare_buff(xdp_buff, hard_start - rx_ring->buffer_offset,
1711:			 rx_ring->buffer_offset, size, false);

drivers/net/ethernet/ti/am65-cpsw-nuss.c
1335:		xdp_prepare_buff(&xdp, page_addr, AM65_CPSW_HEADROOM,
1336:				 pkt_len, false);

drivers/net/ethernet/ti/cpsw.c
403:		xdp_prepare_buff(&xdp, pa, headroom, size, false);

drivers/net/ethernet/sfc/rx.c
289:	xdp_prepare_buff(&xdp, *ehp - EFX_XDP_HEADROOM, EFX_XDP_HEADROOM,
290:			 rx_buf->len, false);

drivers/net/ethernet/mediatek/mtk_eth_soc.c
2097:			xdp_prepare_buff(&xdp, data, MTK_PP_HEADROOM, pktlen,
2098:					 false);

drivers/net/ethernet/sfc/siena/rx.c
291:	xdp_prepare_buff(&xdp, *ehp - EFX_XDP_HEADROOM, EFX_XDP_HEADROOM,
292:			 rx_buf->len, false)

I don't know if it's just because no one has added calls to
skb_metadata_set() in yet, or if there's a more fundamental reason.

I think they all reserve some amount of headroom, but not always the
full XDP_PACKET_HEADROOM. Eg sfc:

drivers/net/ethernet/sfc/net_driver.h:
/* Non-standard XDP_PACKET_HEADROOM and tailroom to satisfy XDP_REDIRECT an=
d
 * still fit two standard MTU size packets into a single 4K page.
 */
#define EFX_XDP_HEADROOM	128

If it's just because skb_metadata_set() is missing, I can take the
patches from this series that adds a "generic" XDP -> skb hook ("trait:
Propagate presence of traits to sk_buff"), have it call
skb_metadata_set(), and try to add it to all the drivers in a separate
series.

> >  	/* Lifetime of xdp_rxq_info is limited to NAPI/enqueue time,
> >  	 * while mem_type is valid on remote CPU.
> >  	 */
> > @@ -369,6 +374,8 @@ void xdp_convert_frame_to_buff(const struct xdp_fra=
me *frame,
> >  	xdp->data =3D frame->data;
> >  	xdp->data_end =3D frame->data + frame->len;
> >  	xdp->data_meta =3D frame->data - frame->metasize;
> > +	if (frame->meta_unsupported)
> > +		xdp_set_data_meta_invalid(xdp);
> >  	xdp->frame_sz =3D frame->frame_sz;
> >  	xdp->flags =3D frame->flags;
> >  }
> > @@ -396,6 +403,7 @@ int xdp_update_frame_from_buff(const struct xdp_buf=
f *xdp,
> >  	xdp_frame->len  =3D xdp->data_end - xdp->data;
> >  	xdp_frame->headroom =3D headroom - sizeof(*xdp_frame);
> >  	xdp_frame->metasize =3D metasize;
> > +	xdp_frame->meta_unsupported =3D xdp_data_meta_unsupported(xdp);
> >  	xdp_frame->frame_sz =3D xdp->frame_sz;
> >  	xdp_frame->flags =3D xdp->flags;
>
> Thanks,
> Olek

