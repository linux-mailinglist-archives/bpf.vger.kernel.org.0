Return-Path: <bpf+bounces-56404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC8FA96C9B
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B05188047C
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91F28A401;
	Tue, 22 Apr 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="LUdvd5Er";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vn218qhe"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D2928A3F2;
	Tue, 22 Apr 2025 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328264; cv=none; b=Z/XQpSgNfI78o35f8Nh6NWw7/s/wyNb6/aiTYnFW7OSobA+VUfq8RyzGIq59og4dbTXU4rIb9HxbsJ1hKbwTe0a71y+t+yRgGM9XGkQGCQXZ/TgQTS7I0GP904+D94FnaG1fiT9+r9ielWIVmhN3v9FZn24fOhU3CXNnXVcdRJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328264; c=relaxed/simple;
	bh=VYl+mgsH8AbFAL9YQ8fGujAVtuPWPeKY2yG7V7Mjsbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=si6bTHyAlmxkKfwFUCU2Hs0qHnxtDFqBFjNYpG3fsXJ1QQjZw3l17HClCagyAhjrK+iao+9cb4eaOVThimxErtpBJ+N3+he5zpFJcl2GcwTRCZnGpwEMg2+LQaO1wpoIQApoiSX8Klbc55Hlwy1LrHnYCRuN45/0MojMmuOX650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=LUdvd5Er; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vn218qhe; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A664D11401B2;
	Tue, 22 Apr 2025 09:24:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 09:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328261; x=1745414661; bh=rbk6t+Go/2tKzNcY9KPcY3SySRqrsIsP
	Vj3JFcPsPdE=; b=LUdvd5ErkuEeT/zWMMxNN7mYl+Gj3YDEdo8cnPswcXqDM89D
	tqPLBvEvz98XM+77U53QgaN8OS7OgfSaWRomPaFkuZwCwFSbvSl9lJPtyzzu3isP
	4Nxe4lFcL3y+2Ja1isEkOGugY6d7kL6wUgFHV4byOMhpAMZWc5PeJkLsxIh7ob59
	kRl9E1Z6cUrANvUjHn/sftSWoDdHFnZyrgy/3TUgB8mkbi6SyABVcet8S2//uwHM
	+yzMs3bQedTTyxdZzJRk2klyigbyZcwFEpqyyYc50s4ZDJ8CpZY7fgMLXq8ljE07
	58kOxe63lJFKOqJl+atKkJJn8/TlNZXx/jFO2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328261; x=
	1745414661; bh=rbk6t+Go/2tKzNcY9KPcY3SySRqrsIsPVj3JFcPsPdE=; b=v
	n218qhe/0BWYf74A78WJK6aT60+GqogpAVP4DcL5noFbofhxZfRWLhelLswiUcjU
	B8A2ISVvAmcsNVtUd8KIU1iykLB24taYoAOkoSyPScKLbAJ6xOoy28GS8TWay+K0
	vZngnRGQpKSXl5nM12gNnUulmkwawX3KM2aHqVfwRI3MDDhBLAGuQfOf7teP2bBs
	K9dO41safYz6k8zUpdEqZQLseGyLw/25RAuN9EEkQAa5J+BLdd2wRLhdOIwtSH6E
	d3aQ/BmLHxgndvQgpe/oTNeFCdd5IlfJa7futr3aubD2nCqH361gXA5nRHLu//tq
	UjtayD4FWr6ldYzBWSztA==
X-ME-Sender: <xms:hZgHaOhy4vXY7jZ1gVfXharxveG9EXEI2nm9ROBoMyKf56bInmpP9Q>
    <xme:hZgHaPB4fYq9WHydzPagXMXkgvjB-49KjYh1O2FgzmJSlMBABn8CeXKmj2tBXTghT
    NlwB8II0sy-lK6S54c>
X-ME-Received: <xmr:hZgHaGF2tEb-rCFM4tVUICL_R7juL8TPBHDCmmkic6pXjQy2bxDHlPTnblhUW53ZUBAtaS_q9m4O3gTdvg4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehrthhhuhhrucfhrggs
    rhgvuceorghrthhhuhhrsegrrhhthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejkeehffejvdefhedtleetgfeivdetgfefffetkeelieefvdefhfeuveevhffh
    ueenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohepuddvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephigrnhestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hjsghrrghnuggvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopegs
    phhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:hZgHaHT5gMFRL8d4r4RwH3deYqbMxbjucN70rOk35LuQRysaKlOc7Q>
    <xmx:hZgHaLwyPA-fWIcHWp9KnUnCL0Z2C9uLtaxJw8i1D1aqZ6ogBD_Idw>
    <xmx:hZgHaF4ebeANcFVskEIbPSKlgHGbOo_el1IUvcqqBbJWvRMML0HwIQ>
    <xmx:hZgHaIzzA43zsaOJqnJyol2J_i4UxNk4l-LLzEFhzjXPjoS_uJQoxA>
    <xmx:hZgHaLqmWRcWoSSreQfZNRs1YAytru4FvjiUIpHtR8wseM4igzZF1azn>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:24:19 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:42 +0200
Subject: [PATCH RFC bpf-next v2 13/17] virtio_net: Propagate trait presence
 to skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-13-92bcc6b146c9@arthurfabre.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 ast@kernel.org, kuba@kernel.org, edumazet@google.com, 
 Arthur Fabre <arthur@arthurfabre.com>
X-Mailer: b4 0.14.2

Call the common xdp_buff_update_skb() / xdp_frame_update_skb() helpers.

Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
---
 drivers/net/virtio_net.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7e4617216a4bd5bd52557109e252e2e00268062b..a709587382e97b8f1518b58301807dbbb00f1a0f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1186,6 +1186,7 @@ static struct sk_buff *virtnet_receive_xsk_small(struct net_device *dev, struct
 						 struct virtnet_rq_stats *stats)
 {
 	struct bpf_prog *prog;
+	struct sk_buff *skb;
 	u32 ret;
 
 	ret = XDP_PASS;
@@ -1197,7 +1198,9 @@ static struct sk_buff *virtnet_receive_xsk_small(struct net_device *dev, struct
 
 	switch (ret) {
 	case XDP_PASS:
-		return xsk_construct_skb(rq, xdp);
+		skb = xsk_construct_skb(rq, xdp);
+		xdp_buff_update_skb(xdp, skb);
+		return skb;
 
 	case XDP_TX:
 	case XDP_REDIRECT:
@@ -1319,6 +1322,7 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
 		skb = xsk_construct_skb(rq, xdp);
 		if (!skb)
 			goto drop_bufs;
+		xdp_buff_update_skb(xdp, skb);
 
 		if (xsk_append_merge_buffer(vi, rq, skb, num_buf, hdr, stats)) {
 			dev_kfree_skb(skb);
@@ -1952,6 +1956,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
 	if (unlikely(!skb))
 		goto err;
+	xdp_buff_update_skb(&xdp, skb);
 
 	if (metasize)
 		skb_metadata_set(skb, metasize);
@@ -2320,6 +2325,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
 		if (unlikely(!head_skb))
 			break;
+		xdp_buff_update_skb(&xdp, head_skb);
 		return head_skb;
 
 	case XDP_TX:

-- 
2.43.0


