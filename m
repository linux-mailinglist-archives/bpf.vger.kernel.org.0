Return-Path: <bpf+bounces-53332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B01FA5022D
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E773B0FB9
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADEC250BF2;
	Wed,  5 Mar 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="JHTxCAjR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7T6TH9ZM"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B3C2505DB;
	Wed,  5 Mar 2025 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185220; cv=none; b=rJcNa5a+X0aXauuMVWSYYMhxliDGaB434pfgJ/vi+utb/s2pB1JC0w+4AfyQeQtfLpLPq4e6X3WYlkGaoR9Ml49qF6HsavwEfjG6xUQVnuDVbK1EnSejdqij4SkTfV3JMzAvil4b+q/Z+9VaFhwi0Ipauah5zxQx6UyVFRKknCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185220; c=relaxed/simple;
	bh=AI1Oa6AqU8eYEoTFzUFnBnF62DR+wac6Et9+mHw/w+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jI82kPiCVXcFlOGbFFH/8Dg/NiBm7UVT5Bai9/Qws94yvEyr80b925wvTZT85pxiQlOukbiRAHiSybMtcbiGH5ENSblSmN47Kl0Y6u/iH1tMj7HSZobnp44Xt7lCJCLr6bKoAXXW3zEAYh5HidVqXe9f5R3hbJQNRuFdmsqV4po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=JHTxCAjR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=7T6TH9ZM; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 8001613814DA;
	Wed,  5 Mar 2025 09:33:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 05 Mar 2025 09:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185218; x=1741271618; bh=LivPnBBVA3IvtDu0uUqXT//4QAqc88XT
	GfchXNR1bbQ=; b=JHTxCAjRUnuQk9OjYuNhd+VIT9JUFNwAOLs29vufn+HIunRC
	gSL9LMmV1gSb/ebrJIZbnWZeG3kcOu37/INYsibB/DnlkZlA9RPFDS1kg6sAkGoD
	zFuYkrRC2b1zJAAR5LEnznphxPJ3erbthS9cpT/it1rqZkMUneAmA6mC5oRwkf7H
	jH5lA2wiwAhjQLuywXw5zrQeXb4CgoPZ4pxLOBgiMOI0Rtkb3/pTmNVNBrMvUBD1
	xnPTIWi68nI/AQlL/rb+EgwyYrGPTLyDHa4lJvYPalzqglreGVDvMWIzciKloOAc
	6wghS2GakWAzDwNNfG9X9OCW5ScGTOGmT605AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185218; x=
	1741271618; bh=LivPnBBVA3IvtDu0uUqXT//4QAqc88XTGfchXNR1bbQ=; b=7
	T6TH9ZM1qRvmSS86hHZctkTVC9sKK/+uGA6oJHEwLj/XdRpu6FJ3eKMgxcdVPOB8
	BsEH2OH9TtzCy0bwNph48KyqcojWSxBcME6Hokg/YtPDMiI+w33S1YGdQaNlujJo
	QssxFNpxoFt+L2J7NaQOfl0ViZ0KFZzuuZ1a73dxGTv+gWmCDN9DZvGBywivv2H5
	DEE7cLans8cV3hmBhJr2xDqhbPnYLf9mS4GmhXYtvd7VV6hfxWe/y8mkFAUrcvgX
	Cf7b/G0QZBZEVn7HB7vO5HNrQwtbR+Hi/y8m1Z0mWycPxe00lcnbo3zeiWdFYA+l
	Prh4+ic2Xa0EW3UATQz3A==
X-ME-Sender: <xms:wmDIZwJewF1JoTymz0nD0t3FHkNLX9h80i6ojrxtI1UBT2MrvLJXcg>
    <xme:wmDIZwLvK23VjRpxWVTfj0C8en8Bnr-HG2MYt-v3zaSlrmEGKyzCg3QtX9tsUWqT_
    nEPpL6TNqT9EagtjAg>
X-ME-Received: <xmr:wmDIZwvoqP3MabeTblyqWTu4hMk73rGutatMsrPD1TAAFoe9brVbGu_GXUP0WTmDgGQW7Sj7xa4e_XQpEls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhenucggtf
    frrghtthgvrhhnpeffueehtddtkeetgfelteejledvjeekgeduleffjeetfeekveeggffh
    fefhvdegffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhh
    grthdrtghomhdprhgtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghfrggsrhgvsegtlhhouhgufhhl
    rghrvgdrtghomhdprhgtphhtthhopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomh
    dprhgtphhtthhopeihrghnsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsghrrghnug
    gvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomh
X-ME-Proxy: <xmx:wmDIZ9YabHpPqqrO3cpj7CA-IKMAYATbYbL0PjSraAwmpL_kvT0vBg>
    <xmx:wmDIZ3Z1r8153dtXhd_ucueUi0093aw3V6rL0_XJG6ngkMkblKcL3Q>
    <xmx:wmDIZ5Cj61TNbetmfU3n5CNqJQGSf3IWh594MCwHWfaN15JvoC_QEA>
    <xmx:wmDIZ9aVpfiB37iqd9WIsCnBCQIiaZfu1N5vkzsL85Wc65X2IJ5XLQ>
    <xmx:wmDIZxmdtXPZ1BTMnERn_u_6haYfd8fphJBbPQiV38PqDZcGgC-wR3L0>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:36 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:09 +0100
Subject: [PATCH RFC bpf-next 12/20] virtio_net: Propagate trait presence to
 skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-12-d0ecfb869797@cloudflare.com>
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
 drivers/net/virtio_net.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7646ddd9bef70cf2a0833c7db7c0491884fb7ab5..85798c2bc3446c47deaef66dbb96270e51c9076c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1190,6 +1190,7 @@ static struct sk_buff *virtnet_receive_xsk_small(struct net_device *dev, struct
 						 struct virtnet_rq_stats *stats)
 {
 	struct bpf_prog *prog;
+	struct sk_buff *skb;
 	u32 ret;
 
 	ret = XDP_PASS;
@@ -1201,7 +1202,9 @@ static struct sk_buff *virtnet_receive_xsk_small(struct net_device *dev, struct
 
 	switch (ret) {
 	case XDP_PASS:
-		return xsk_construct_skb(rq, xdp);
+		skb = xsk_construct_skb(rq, xdp);
+		xdp_buff_update_skb(xdp, skb);
+		return skb;
 
 	case XDP_TX:
 	case XDP_REDIRECT:
@@ -1323,6 +1326,7 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
 		skb = xsk_construct_skb(rq, xdp);
 		if (!skb)
 			goto drop_bufs;
+		xdp_buff_update_skb(xdp, skb);
 
 		if (xsk_append_merge_buffer(vi, rq, skb, num_buf, hdr, stats)) {
 			dev_kfree_skb(skb);
@@ -1956,6 +1960,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
 	if (unlikely(!skb))
 		goto err;
+	xdp_buff_update_skb(&xdp, skb);
 
 	if (metasize)
 		skb_metadata_set(skb, metasize);
@@ -2324,6 +2329,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
 		if (unlikely(!head_skb))
 			break;
+		xdp_buff_update_skb(&xdp, head_skb);
 		return head_skb;
 
 	case XDP_TX:

-- 
2.43.0


