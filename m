Return-Path: <bpf+bounces-56540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 459E2A999C3
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 22:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63FB5A7C61
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 20:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38CF26FA72;
	Wed, 23 Apr 2025 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="dSDuoWP7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E5GcZm1F"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A072701BC;
	Wed, 23 Apr 2025 20:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441682; cv=none; b=PMh1/hl4kUcXMk8vdVIgihRlWiDV6egro3dJlbYxUvfLm28Ff0zsnNvN5t/2j3EGGD1l8C498piZKHen0QPiA8q7+4fb5JVs2reM59pXYohy61E2XU6nMBH8gAfTeUnpX7d+DOT6oC0i17zs9eg9ZIyFYBPfZRlxKeLMTPXAXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441682; c=relaxed/simple;
	bh=wp/tmVkOATVLugd1D0jouBtXDou1iJLlFR51aXGWQCg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OdBI+mBqw7jkCPfPVRpEhy4l+hEHz8zxuSmIZWikyKxq9cePElxhmMY14HtpSg6pCCWGXFGlzWKtYFSNDKVyg8GSLFBX/TERfc3NODoflWxGhDoBL9pJWjap4zxxqRwtYHCDOl6yMnD2gt/Nk7zvcFVebce3SAFZZOmP6/g45Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=dSDuoWP7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E5GcZm1F; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DBF6125401E4;
	Wed, 23 Apr 2025 16:54:37 -0400 (EDT)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-05.internal (MEProxy); Wed, 23 Apr 2025 16:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745441677; x=1745528077; bh=g2MVnbEaHajTV+ZwVS0fqv4DkHnJ+QiQ
	uueDHO49G3g=; b=dSDuoWP7oJGtq3cxmB6LLFAJA97FUvfszsYN0JNDZMM8v9Hw
	1ehgJ9p4oWrRJHN2NzrvIp2dgm2lTMY0139qTugrOZxupmL8DOa6SmfRieNga6dd
	xZHkU38Ayq1AwmfAZW0qg0/1GbFh3oMEknUaLo2wD5dHE0pwY3y6UQcPyi61pczx
	DNYDloleMvSBURilXgKPZn0x6jj4U2NhBu7gLsR64p/ifPej4vO7PdVUGwWAK3Gn
	BmI4PR6G3MPa/kZSNJlK5+GUkJOzfL0/A/vm7BxCNJLZkUfhgIy7i51/U6PXrDUb
	w6NWENjAkHOKcDQC364mgh6tVTu4QQSMOHKE+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745441677; x=
	1745528077; bh=g2MVnbEaHajTV+ZwVS0fqv4DkHnJ+QiQuueDHO49G3g=; b=E
	5GcZm1FWe/wxPNQfQ+uKqkJPH/ITsLVb1NBW4k9h7sFEAn7oevGo/Kx/aTkZG7e2
	wzxWQWa6MQOcLXpGt1heLaCPRWCYWAYCgLzzdcyuKyFzPxQM/eI9gLa0l9A2AKc0
	psWijl2dtDeD8zqoe2241NtYE8K1oCXdduyLeVTpRRMtU7fdJYTxSBhWQ70zNBPw
	19+T+g2BRMxlsE2s24zOvEUtpXK5Fgru/SVwjSfMez8h6668RyU+H8m3D56nZftH
	m2xDgJ4sauR9b/ATAGwr8sn5xVQU4rtv5kVMNvCPEWhzIbrWX/+biupvJ6oIX7Il
	gqhfSGFdZKmoR0+biRxvA==
X-ME-Sender: <xms:jVMJaGVUulHrVbnceCWHHVS7aXcdPU8UMNcmCMCn0R5O2c6fwTSU9A>
    <xme:jVMJaCnJOt91BN8sfveieTGNgpiAd1EGL6mitkcbCQXwzoaKH_AggQ9WbXeXXaRs6
    Yc4CaWnaiusHQwz5ro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofgggfgtfffkvefuhffvofhfjgesthhqredt
    redtjeenucfhrhhomhepfdetrhhthhhurhcuhfgrsghrvgdfuceorghrthhhuhhrsegrrh
    hthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtthgvrhhnpefhfeejgefhhffhveel
    teehhfffheffvdettdelgfeltefhteelveeuffetfffgjeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgr
    sghrvgdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehj
    sghrrghnuggvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopeihrg
    hnsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehsthhfohhmihgthhgvvhes
    ghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihk
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhgsihgrnhgtohhnsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:jVMJaKbU7tMLZm-lxp3Py8DYsYFxv0582GG0JIHMVdP3T80U_ZqUiA>
    <xmx:jVMJaNUaqRH3gu9dTi4V8DBrtD6TjP1k4nESttebhop8nbIXsQGjkw>
    <xmx:jVMJaAmPuyHoxHy0lGvXNo_Ld-yYINMfqHGKrE80AGPZhTpoGGnwJw>
    <xmx:jVMJaCeZkApXLzVxNUZ95cJ5DUL1D08EG2KclOhEcazcggODQs0d1Q>
    <xmx:jVMJaKTJx03Z6VAEW8_oDiNQ9_fyT_z-taAyzkQW0K5wZc74We8jrXhZ>
Feedback-ID: i9179493c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 598A01F00072; Wed, 23 Apr 2025 16:54:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Apr 2025 22:54:36 +0200
Message-Id: <D9EBFOPVB4WH.1MCWD4B4VGXGO@arthurfabre.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <jakub@cloudflare.com>,
 <hawk@kernel.org>, <yan@cloudflare.com>, <jbrandeburg@cloudflare.com>,
 <thoiland@redhat.com>, <lbiancon@redhat.com>, <ast@kernel.org>,
 <kuba@kernel.org>, <edumazet@google.com>
Subject: Re: [PATCH RFC bpf-next v2 10/17] bnxt: Propagate trait presence to
 skb
From: "Arthur Fabre" <arthur@arthurfabre.com>
To: "Stanislav Fomichev" <stfomichev@gmail.com>
X-Mailer: aerc 0.17.0
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com> <20250422-afabre-traits-010-rfc2-v2-10-92bcc6b146c9@arthurfabre.com> <aAkW--LAm5L2oNNn@mini-arch>
In-Reply-To: <aAkW--LAm5L2oNNn@mini-arch>

On Wed Apr 23, 2025 at 6:36 PM CEST, Stanislav Fomichev wrote:
> On 04/22, Arthur Fabre wrote:
> > Call the common xdp_buff_update_skb() helper.
> >=20
> > Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index c8e3468eee612ad622bfbecfd7cc1ae3396061fd..0eba3e307a3edbc5fe1abf2=
fa45e6256d98574c2 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -2297,6 +2297,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct b=
nxt_cp_ring_info *cpr,
> >  			}
> >  		}
> >  	}
> > +
> > +	if (xdp_active)
> > +		xdp_buff_update_skb(&xdp, skb);
>
> For me, the preference for reusing existing metadata area was
> because of the patches 10-16: we now need to care about two types of
> metadata explicitly.

Having to update all the drivers is definitely not ideal. Motivation is:

1. Avoid trait_set() and xdp_adjust_meta() from corrupting each other's
   data.=20
   But that's not a problem if we disallow trait_set() and
   xdp_adjust_meta() to be used at the same time, so maybe not a good
   reason anymore (except for maybe 3.)

2. Not have the traits at the "end" of the headroom (ie right next to
   actual packet data).
   If it's at the "end", we need to move all of it to make room for
   every xdp_adjust_head() call.
   It seems more intrusive to the current SKB API: several funcs assume
   that there is headroom directly before the packet.

3. I'm not sure how this should be exposed with AF_XDP yet. Either:
   * Expose raw trait storage, and having it at the "end" of the
     headroom is nice. But userspace would need to know how to parse the
	 header.
   * Require the XDP program to copy the traits it wants into the XDP
     metadata area, which is already exposed to userspace. That would
	 need traits and XDP metadata to coexist.

>
> If you insist on placing it into the headroom, can we at least have some
> common helper to finish xdp->skb conversion? It can call skb_ext_from_hea=
droom
> and/or skb_metadata_set:
>
> xdp_buff_done(*xdp, *skb) {
> 	if (have traits) {
> 		skb_ext_from_headroom
> 		return
> 	}
>
> 	metasize =3D xdp->data - xdp->data_meta;
> 	if (metasize)
> 		skb_metadata_set
> }
>
> And then we'll have some common rules for the drivers: call xdp_buff_done
> when you're done with the xdp_buff to take care of metadata/traits. And
> it might be easier to review: you're gonna (mostly) change existing
> calls to skb_metadata_set to your new helper. Maybe we can even
> eventually fold all xdp_update_skb_shared_info stuff into that as
> well...

Yes! This is what I was going for with xdp_buff_update_skb() - it would be
nice for it handle all the SKB updating, including skb_metadata_set().

Should I do that first, and submit it as separate series()?

