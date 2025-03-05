Return-Path: <bpf+bounces-53335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3691A50235
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21993B30CC
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF942512F6;
	Wed,  5 Mar 2025 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="jOoZ5ByZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hPfZRctx"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CE524E4BD;
	Wed,  5 Mar 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185226; cv=none; b=qdhPm8QJ/fEYa21dBdCz8LUdIWUuVmQt+a7dcJ7VA8c6CMpjZXd1fpgwj4SIiOFS/6DnCga8Pe8Aj07KGeYhrhO6zu1W8SbQtt2DOCTP8xxtUpL6u4c1Co0wKQIw/H+He51I4Pl5cCHImbtlmF+eBwx3pVM4pj0ag53HDqueK+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185226; c=relaxed/simple;
	bh=opUvoUUN/i+dA0gP6MLpRSGC8WGZHIofqJRtStODJ4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eWpWmFqOk1lBTLyAr+uWR8y9jZ1c9qADjGt+kiZ/BDskzGFhRfFTUs6SGcQh6erJ5Z+21bKN6OFGkGW1r9Idg+K4PClwmzf8Efiu8OX7ouIU6e/rRq6vrElMtq3CtZpyFbvY1551zR8Cxxytrh2LuqoN0bvCfnu4NUQmnfVXQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=jOoZ5ByZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hPfZRctx; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C60A9114020B;
	Wed,  5 Mar 2025 09:33:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 05 Mar 2025 09:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185223; x=1741271623; bh=mxfNcIt84UiMaaAtDgllbXKyl8R/X/9y
	mdJeTAyEdEo=; b=jOoZ5ByZ+uopIJRSW0mU3lYLAS5Zz/cukTjPrC6tZGRELHvT
	11NOrp9766ESIx48OP31VIqTeP0mempanDggU8hWI8+CgajhFZYp03nuSf2pHswr
	j+5O7bKjb3noTLHzPQhg6rK3XllOIezueUTO/e2heCE4T77GElpdQ8nivu+jFdwH
	M+WerUGP7AgnSZIUuOy9STvVJFBUAyS8zwWUG/cNnvrrlO1IOP8V0JnaNwr3CvwZ
	NaBTYZHl5IPMu1jL+5/cl9EiwaEkLtsOZUdiTzv3RPEL2kcNGiPdZSvzj6nZTB0l
	eIyCtRUepq6D8qYIRnHZ6RbZCAmaYBQLish2sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185223; x=
	1741271623; bh=mxfNcIt84UiMaaAtDgllbXKyl8R/X/9ymdJeTAyEdEo=; b=h
	PfZRctxP6eRJABjT0Gl+0fVvfs+/vh0e9KQ9CuBL2osVyDr/hvzYtqYZhKEPZYNL
	cx7TDaz0N8OgDLoz0xwKJ+61tXkBRzzXPiBj8vDo4PBUUvCImsp95FrgAyL28A/C
	tZGNIy+r0bbi5CTvCeh4VifiaShsFRVqmw1Su/DZzj8eXXoiYepKcI+66kvyqbBJ
	Jv0VPr7nQN+EuRnOdsrcW0eYdi9AipDsyTYJmsu+j+oqxuCZMUfBiP9/gqlcxy1a
	4OnH49HuRI5qPVEh/pWw6efTfbuMX+nVyo2Wm5C9kBF87q/kJ0H2W+8MePa4vBUA
	uAfrjuEG6rmwIbCtFCfYg==
X-ME-Sender: <xms:x2DIZ8_1nCtpHOs3hsZnC5finKRDTDmVweiIUgWq0hXCdQuob00k4g>
    <xme:x2DIZ0u_dvsT6qb6QWHEWMgwER7bhF9zjv84oiIbptwyXqMlXL8zD9HyCGI19sDXb
    kW_8OtuRj46GUne-e0>
X-ME-Received: <xmr:x2DIZyAt8Rtg2lgX0nFpDa2HD9smpDWiT_VTiaUB3onVmimIUVo9crbIfvJChb4jiSKmoQYphmofCw-GoCM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhenucggtf
    frrghtthgvrhhnpeffueehtddtkeetgfelteejledvjeekgeduleffjeetfeekveeggffh
    fefhvdegffenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhh
    grthdrtghomhdprhgtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghfrggsrhgvsegtlhhouhgufhhl
    rghrvgdrtghomhdprhgtphhtthhopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomh
    dprhgtphhtthhopeihrghnsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsghrrghnug
    gvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomh
X-ME-Proxy: <xmx:x2DIZ8dinjKvDgFRnN8WEVISETEPO--QZ43o8G-ipwqUnbSM0CH3YA>
    <xmx:x2DIZxOd5rf3EzqIz2OgePPvRLhtN5um8uyX6S7WRH-l3PybValXkQ>
    <xmx:x2DIZ2mPukYcjkwSeoI4wN4R2tpjK-JFIHw_GHNLqmuG3AUNhZmSVg>
    <xmx:x2DIZzv3sG-jdpXaf5GHAopAhAKNC3_LzYHtH0MNsinwaxwiriFH-A>
    <xmx:x2DIZ0rDPZZosopZES1bPtXnLU_Pv8yg3Pc_DrYidn3ZNxgcs5TXab0L>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:42 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:12 +0100
Subject: [PATCH RFC bpf-next 15/20] xdp generic: Propagate trait presence
 to skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-15-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

Call the common xdp_buff_update_skb() / xdp_frame_update_skb() helpers.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1b252e9459fdbde42f6fb71dc146692c7f7ec17a..ecf994374b5a8721c1aacc6e4267a91775be3a25 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5247,6 +5247,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 		metalen = xdp->data - xdp->data_meta;
 		if (metalen)
 			skb_metadata_set(skb, metalen);
+		xdp_buff_update_skb(xdp, skb);
 		break;
 	}
 

-- 
2.43.0


