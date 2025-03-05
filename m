Return-Path: <bpf+bounces-53330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72F9A50233
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAED91897C8B
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FB42505CD;
	Wed,  5 Mar 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="wfXRA0O9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fY8qQSo8"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FAC2505B2;
	Wed,  5 Mar 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185217; cv=none; b=JZQ/srAE1NfvboMugoMCJh0qirdrAqSbvhFi5EtQnKsad8oEaxwmC3SAUtAJsk7wcu9Ef4Bk13YvyKakSWSSewQAQGRxjfzUP3kV2mQ7I8JLlu76pAbayghZQM5hqm0C7zPGtrJ9Co+Juzr44vNnx7g6pD2kTdIekWuxvn7b1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185217; c=relaxed/simple;
	bh=IrVawBUn1RmxC0Wuya9HD1bemcOwOHctPP/GE0nmpgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XE9Pu9oDZotSW8T+6vOUkf6IIacA2o/vbGAgqjC4+Z7DlGYT2vvxtwUSI8I7OJZzSo5M1yzebeOtJzI7klGHQZoM2LiLF4beEVyP0alaDygmcVGOjJTR4oGGrIjqghjqu/2ofkvtiL31az0K8QC7dmcriLOeY9z/pBlSegLQgik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=wfXRA0O9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fY8qQSo8; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A1121140156;
	Wed,  5 Mar 2025 09:33:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 05 Mar 2025 09:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185215; x=1741271615; bh=qru1O9zdUmjKZ1p2yUXAEyuttmotw+de
	6bIlQUpfaCs=; b=wfXRA0O9omTwhjqjVCD5BIlQ5XH1sy4OyW/BuS0fI3asS5g5
	FtW+izSKj4LAFpjnDTZHdI0v57QboOIQHo4Uq6PGdWiMScUJe/JUG+0zZFTUPPZY
	UIV8NGawtnV4JqduR6JiT/z9qW53YX23wDL8oqNmvKjtuEXdA222MU70Vjtu2U/H
	z/RSvxZFv3PTGEtvyvbSm6dDZwssYTLkBpsg5LhXsUcvqdxfVwrVcMIoj1PflENU
	KWN13QcTk1iYFuormX/HhfBLA3F9Art5Y6AONUshy+oMvpNnVqxOKzQWECMX2nfe
	1P7ll78UpONr1k1JnwDPlu/35pIxLCLvYrpHWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185215; x=
	1741271615; bh=qru1O9zdUmjKZ1p2yUXAEyuttmotw+de6bIlQUpfaCs=; b=f
	Y8qQSo8qUBI9Klltrj8vuDWQ6yXtQk5XNGLTZDQdyenWuyuSQo+zOcXLHL1ANW8m
	9mBhHZ07fIsmqRGHupz4G8yIM2MyraZIA5VeiBxhl3CF0aqIesCz8azdpbQTwdiJ
	TZKSBKRbuaaldeEeBGAj1t+rOh4AYTt8wTxUeaK67FqrxCb9A7FU9pB2ZE3jki7H
	SxZhbSVGMNMWuy/CWOsV9MjbUwagTId31bHJ8q9JbDHAYMlU6ld1MFQX+KIX+8hU
	y3Q4s8h/gk+X2Xu4MFP4xzxNQBQj88YykGSwpXSng+rD/lpJNc74Z8BNucGOk1rH
	SObJsWikVnGZxhhRL4ELw==
X-ME-Sender: <xms:vmDIZ9oAmYsdny5x92xj1u6j1aXKysRN_b91waASrTPhwMl2ElNcWg>
    <xme:vmDIZ_pU1wPRSPXgTQeu4IEw6FwcRKDSPnJ-Zt6VUJ9mt8N6Yl9eFKpFoIek0H_sb
    I7aEjMBEg8tT_3WyB8>
X-ME-Received: <xmr:vmDIZ6Mi4DLUdp-1exC2nBezGH9_GqSL1p0L9ujEe-ttAJz0M5UpgpZZETacekZC158YMtFurmBToPCnkh0>
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
X-ME-Proxy: <xmx:vmDIZ46dtJXFITefQHikubDXGsLsHYY99tR-vOAWPkIc535We0VXEQ>
    <xmx:vmDIZ85toKLIOh2NFp6kSQIIK9jr0c8PEbXUSJgvzgYIf8I8q-EMTA>
    <xmx:vmDIZwhxxL-f-4eytRHUerOPCpEphE1fAvVPvm7ZF6w1AZV0y_NSKA>
    <xmx:vmDIZ-7hLrrsobHC7h5ARfe9DPp1btCVfDhSXDGM5vGE3Pv5RkOmOw>
    <xmx:v2DIZ9E9hC1cIyfcP-aIgIh1t7XdmlUzfcM9Vn-0u5pO9BAFt5vTVexT>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:33 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:07 +0100
Subject: [PATCH RFC bpf-next 10/20] ice: Propagate trait presence to skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-10-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

Call the common xdp_buff_update_skb() helper.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 4 ++++
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 9c9ea4c1b93b7fb5ac9bd5599ac91cf326fb2527..70101fc365b17a13f06ff7c46610d11fbf81313a 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1011,6 +1011,8 @@ ice_build_skb(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
 					   nr_frags * xdp->frame_sz,
 					   xdp_buff_is_frag_pfmemalloc(xdp));
 
+	xdp_buff_update_skb(xdp, skb);
+
 	return skb;
 }
 
@@ -1092,6 +1094,8 @@ ice_construct_skb(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
 					   xdp_buff_is_frag_pfmemalloc(xdp));
 	}
 
+	xdp_buff_update_skb(xdp, skb);
+
 	return skb;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 8975d2971bc3778aad8898e334ce1d759618fd32..a34c7a69c58677958974b84b7fb6e5643c5e29b2 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -572,6 +572,8 @@ ice_construct_skb_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
 		__skb_pull(skb, metasize);
 	}
 
+	xdp_buff_update_skb(xdp, skb);
+
 	if (likely(!xdp_buff_has_frags(xdp)))
 		goto out;
 

-- 
2.43.0


