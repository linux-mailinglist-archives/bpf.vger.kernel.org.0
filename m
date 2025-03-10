Return-Path: <bpf+bounces-53740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516E7A59A61
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 16:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCD01889DED
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 15:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713D422DFA7;
	Mon, 10 Mar 2025 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="FQ45YXyB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fb9RZfIg"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24744221565;
	Mon, 10 Mar 2025 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621831; cv=none; b=UhdSCdTTej4KwZKS6S3WrDCBatLaevmmG40zC4SK+tEPDxDbZO32CtzhRFOLc7Ms3XgkCl2cm8FPsxdyVE5wrg0hSqDbOGN5wjlJ+SRGBFYFFmn2D2EKotkW06VdSrKdu0yeCmykUXXYs9AAuuNsAknW9PU9uKOXCKJNopiN8qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621831; c=relaxed/simple;
	bh=3RMn/6iOlwRXxTssXvsb75QH4GNnEkrS0DAIz9peytY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=PkcBqhsB0C6djnwHRNeM8thbR2UaAt9JQ0Ibqf01kRe97bXAJUWOFdsm6xwPxbLE28KNhZe5A9ROVHMMk5K2MOtDauNuLplsSBzOH1Cc/xvWJaB4tI+rfh3xSa8nbRsIZIaXjjABPMl9+So6tUj7rLBlH06OMo2eWeUJODwX0Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=FQ45YXyB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fb9RZfIg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1930011401F8;
	Mon, 10 Mar 2025 11:50:28 -0400 (EDT)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-02.internal (MEProxy); Mon, 10 Mar 2025 11:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741621828; x=1741708228; bh=dD/1Z87rJwmhvfSdQS8LnvOFsOnNAPdI
	rq7EtigB1lE=; b=FQ45YXyBWelAbtru7dpWjGlPP8+9AYlVWJyMYhKvOj1Yzkv2
	+4+HXrvLskTJmgzregw/r4zuicanDMcPMhEHcSnk7RMnk/PZ51aGMmnKMfaw/eU/
	jEvFkwwYQ389NWd18jIuRyoMrU3mKCntXBne9LBp0gD1m77zBNoYRa/XiD679C9b
	wGJR1bLTh54OI+N+CCm6feDIEpk5vO3V7LAKErmaDPn5Xxl3ktcHyIReTCduLqjQ
	8GkeZ0bMIvb9MBtZ6d/WiUWfkSaw5a1AhlSZXE+wzP4BtShcLyaJelA4WpNfVOde
	jpqTxWPzeR/0RgwqMFc0RvsJEg8qAEkVOGXIMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741621828; x=
	1741708228; bh=dD/1Z87rJwmhvfSdQS8LnvOFsOnNAPdIrq7EtigB1lE=; b=f
	b9RZfIgmbvmG20m5n3oIm/O6mbiB/6FFerBOPJp8tLeFVn9kvJi0jVLHA1zLPjKr
	MQouYVB5qfpsPKCtViTwPgqsLZXdoTDJJTDr/iDc/PZBFnbRCOWHmxp9TYndc3RP
	puAsF6uHrTHaDVc2xvNAdLJK1nkoiDx8mR+YqWFmbuMdSAwqC33LW16lUIDV+bGn
	BvO6cxhGqoIjrLGxuMCncQC475DR8eSUenXtDX6oSq197V/4BV04NAn68HXug5RF
	cgQL/+8R3sewWI6hK6cAFfeGTdM02KktkxIzr/2a20oDbUaRDAQzoc3gY3s5TJZk
	MmKzB+ybDDuU5v/un/b6Q==
X-ME-Sender: <xms:QwrPZ02T0iupCZJyOCMTLUPDanHifGCIYKl8tXnr82oPhw6hXj2uQw>
    <xme:QwrPZ_EB8rEC_W4bhankfH6h2gF2Yk3F6rJKLtzKZ_ojkb_2HafqggAlPKU-mJR2J
    -b8hap5JmGllLBLXgM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeljeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofgggfgtfffkhffvvefuofhfjgesthhqredt
    redtjeenucfhrhhomhepfdetrhhthhhurhcuhfgrsghrvgdfuceorghrthhhuhhrsegrrh
    hthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtthgvrhhnpeetuedtveetfeejffeg
    tddtgfekvdejgeevvdffuddvjefhhfefgfejhefhlefftdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgr
    sghrvgdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegrfhgrsghrvgestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohep
    jhgrkhhusgestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepjhgsrhgrnhguvg
    gsuhhrghestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohephigrnhestghlohhu
    ughflhgrrhgvrdgtohhmpdhrtghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhho
    rhgvnhiiohdrsghirghntghonhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehthh
    hoihhlrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QwrPZ86xVfFaqhZjyrEbEhW2Ld-7yfAiWAKK7ZiaC0UJ2Mnnc5BgzQ>
    <xmx:QwrPZ900B5Jdx4uZ_WKLHX2JnDkY1GVBDXj6f6I3Ashdq534WmT41w>
    <xmx:QwrPZ3HUj0SfqjIArYLud756OO-GgcThlHsCE2sAH2-3mYcYgh8r1Q>
    <xmx:QwrPZ2-WLcFHT_UXd72q6lOCz1eXuWmlVP4KL5IjvsRhgyCROAPMOQ>
    <xmx:RArPZ-BGdxOZXQHrXcEyVA8eIdERLNScjntTAOIKPjFBXWHRrJ_oEYyC>
Feedback-ID: i9179493c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D96581F00077; Mon, 10 Mar 2025 11:50:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 16:50:26 +0100
Message-Id: <D8CPETTWTCDX.23AMDJAQOJX8I@arthurfabre.com>
From: "Arthur Fabre" <arthur@arthurfabre.com>
To: "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <jakub@cloudflare.com>,
 <hawk@kernel.org>, <yan@cloudflare.com>, <jbrandeburg@cloudflare.com>,
 <thoiland@redhat.com>, <lbiancon@redhat.com>, "Arthur Fabre"
 <afabre@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 02/20] trait: XDP support
X-Mailer: aerc 0.17.0
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com> <20250305-afabre-traits-010-rfc2-v1-2-d0ecfb869797@cloudflare.com> <Z8tFdSbT7Gg4iO5z@lore-desk>
In-Reply-To: <Z8tFdSbT7Gg4iO5z@lore-desk>

On Fri Mar 7, 2025 at 8:14 PM CET, Lorenzo Bianconi wrote:
> On Mar 05, arthur@arthurfabre.com wrote:
> > From: Arthur Fabre <afabre@cloudflare.com>
> >=20
>
> [...]
>
> > +static __always_inline void *xdp_buff_traits(const struct xdp_buff *xd=
p)
> > +{
> > +	return xdp->data_hard_start + _XDP_FRAME_SIZE;
> > +}
> > +
> >  static __always_inline void
> >  xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info =
*rxq)
> >  {
> > @@ -133,6 +139,13 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned ch=
ar *hard_start,
> >  	xdp->data =3D data;
> >  	xdp->data_end =3D data + data_len;
> >  	xdp->data_meta =3D meta_valid ? data : data + 1;
> > +
> > +	if (meta_valid) {
>
> can we relax this constraint and use xdp->data as end boundary here?

The problem isn't having a boundary, it's patching all the drivers to
propagate that traits are present to the skb layer. See patch 8 "trait:
Propagate presence of traits to sk_buff", and patches 9-15 for driver
changes.

There's some discussion around updating all the remaining drivers to
support XDP metadata, if instead of making them call skb_metadata_set()
we use a more "generic" hook like "xdp_buff_update_skb()" from this
series, we can use it for traits later.

>
> > +		/* We assume drivers reserve enough headroom to store xdp_frame
> > +		 * and the traits header.
> > +		 */
> > +		traits_init(xdp_buff_traits(xdp), xdp->data_meta);
> > +	}
> >  }
> > =20
> >  /* Reserve memory area at end-of data area.
> > @@ -267,6 +280,8 @@ struct xdp_frame {
> >  	u32 flags; /* supported values defined in xdp_buff_flags */
> >  };
> > =20
> > +static_assert(sizeof(struct xdp_frame) =3D=3D _XDP_FRAME_SIZE);
> > +
> >  static __always_inline bool xdp_frame_has_frags(const struct xdp_frame=
 *frame)
> >  {
> >  	return !!(frame->flags & XDP_FLAGS_HAS_FRAGS);
> > @@ -517,6 +532,11 @@ static inline bool xdp_metalen_invalid(unsigned lo=
ng metalen)
> >  	return !IS_ALIGNED(metalen, sizeof(u32)) || metalen > meta_max;
> >  }
> > =20
> > +static __always_inline void *xdp_meta_hard_start(const struct xdp_buff=
 *xdp)
> > +{
> > +	return xdp_buff_traits(xdp) + traits_size(xdp_buff_traits(xdp));
>
> here we are always consuming sizeof(struct __trait_hdr)), right? We can d=
o
> somehing smarter and check if traits are really used? (e.g. adding in the=
 flags
> in xdp_buff)?

Yes, we're always taking space from the headroom for struct __trait_hdr.

I think it's impossible to tell if traits are used or not early enough:
users could be setting a trait for the first time in iptables or TC. But
we don't know that in XDP.

>
> > +}
> > +
> >  struct xdp_attachment_info {
> >  	struct bpf_prog *prog;
> >  	u32 flags;
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index dcc53ac5c5458f67a422453134665d43d466a02e..79b78e7cd57fd78c6cc8443=
da54ae96408c496b0 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -85,6 +85,7 @@
> >  #include <linux/un.h>
> >  #include <net/xdp_sock_drv.h>
> >  #include <net/inet_dscp.h>
> > +#include <net/trait.h>
> > =20
> >  #include "dev.h"
> > =20
> > @@ -3935,9 +3936,8 @@ static unsigned long xdp_get_metalen(const struct=
 xdp_buff *xdp)
> > =20
> >  BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buff *, xdp, int, offset)
> >  {
> > -	void *xdp_frame_end =3D xdp->data_hard_start + sizeof(struct xdp_fram=
e);
> >  	unsigned long metalen =3D xdp_get_metalen(xdp);
> > -	void *data_start =3D xdp_frame_end + metalen;
> > +	void *data_start =3D xdp_meta_hard_start(xdp) + metalen;
>
> We could waste 16byte here, right?

If traits aren't being used?

[...]

