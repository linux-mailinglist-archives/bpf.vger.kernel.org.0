Return-Path: <bpf+bounces-53327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E5CA50227
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020B11896FBB
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FA524FC1E;
	Wed,  5 Mar 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="WYshwkPb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ILHHS5Yb"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42E24F594;
	Wed,  5 Mar 2025 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185212; cv=none; b=IRLvRmqXm0xAt4EjaW7HOWdlj74ejRnc2+yCuCwSmNm9YKfy0gyfaILFj1+tTNlJqQlYIYtEXSwlzR3vEW0TS1DjEdpj3t6U+dSn29qh7bzc2Z2fXEv21fw8DdbG4U18l2H/Rg2j/0HPSGKIas4eH2umrGCvpfxmETSBsc9KINQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185212; c=relaxed/simple;
	bh=jmCFStIua7DVXWNMLIbQuvMCokmSZJGjNJ0nWEu4LRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nvHFT6lYkCvPsMeYyk+aWy9fy1DbMKYJW46VdyCUlnhHqlFsQhweAYp21LWox+SGIyNQp5Q2qAENlrHeVhimtuWCoIhbSfFKh3OKPOx1EjM04n2cRN8kSXMoizDFJGEh1LeiVyzR5WGpdw9I1Vyo6cIFirkW+OKK4lvUxw3Y600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=WYshwkPb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ILHHS5Yb; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D904E11401C7;
	Wed,  5 Mar 2025 09:33:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 05 Mar 2025 09:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185209; x=1741271609; bh=89iuU0MvqzP2Mt3xe3b+4GMNgzhWxZUG
	Ue/kBsSAJEg=; b=WYshwkPbwkYDBAzOHyuVeoctcXj9JH18gxFIBW1CpXdSVmSg
	1fD7U98zTNT65qNdHwmyIm8X9it8UKt0IM7RbbH6ZKas9foW0vx9KNXjayd0dtNG
	vLYPbHaAILWqN6G3O/SFjS4h64elwEt+eW0rMtc9sfS+dhQSQzIbvC4zqzGYCQ4Q
	jPtgT3D4RtxKPSbimeTcg6l9featacQIqR43kiaFL93/+7Kh4OG2whCyJZlxAnAQ
	ie/p5MAKharK1RgxqWiuHmkHaufIRie8/NcTdvDkB0yJ+c27XRZwODAoYNMz05sm
	U/+WaxkMSBsMlhMB5kBzjNqSt92EHOHoE8pIWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185209; x=
	1741271609; bh=89iuU0MvqzP2Mt3xe3b+4GMNgzhWxZUGUe/kBsSAJEg=; b=I
	LHHS5YbM9lH8/JrLqdfIvnFDpjtLW0cbHbX9KXvqEpuaYIfr2Iy3UvEA9K1fphXE
	w42Dd72ZLMklZ9PLcZUXr3YM7UME00IHAB47NGOzR2W07WWCJPDBLNWc+blKqBux
	74/bpsnYdmKdp7hYwwF/Ckv8E8Vp/FdkIEFmx3Y9jXbOKPokbpimdpAqqIJ1wQM4
	zIjXqyRu7b1167LAdFD0Nw8q/Zs3mOXwjkkAgeMEFq1qkIGwyUWehZk6YMFxq6h8
	icQSSv7b/cVPNwk6Jle+9hgM+LiQOPWm4LrvYEFe4kx8Yn8XkPsqsti5Lih6xgko
	mT4Ss0zpn8IZZ/F8vfVbw==
X-ME-Sender: <xms:uWDIZ96HewM-_PRfF-0JWsLhMmvgDSuPME0H1mwuX8YMwpUhaUdpoQ>
    <xme:uWDIZ65pSIRj0TNAOosFEW-FfJ7N6mfWlFViMQg5NKBlzUNEAiYVIYSuDykSFToqd
    a-ctZO9ono8b41iKNg>
X-ME-Received: <xmr:uWDIZ0erj6kOUNMquj7e36FE2ruZ510tgJo_aHLwJghvhpAjSyrB6V6l3QpLuo5TMlp2XlVDWpdX3f0kmbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:uWDIZ2IjZQIXSKpDsbD8qL6u9XeYQXL8W3zWrkP2RdIPMEJDFvD8DA>
    <xmx:uWDIZxLhdbkNPtv47XsFBWeU0RisGLUqzjaBrS4gJwe2P01W7xRgTA>
    <xmx:uWDIZ_yc5XhCQCXr11nxWXvZD8TIoJ2D1Fea8HmlpVYzrGUTz6PTkg>
    <xmx:uWDIZ9LQu3cISwwoWyVMZK8QbUC7QvEBuWGU4pBvBFI2nqWn8T9ldg>
    <xmx:uWDIZ6XgcUvhffdVgy2l6tGyoI2SbA8oc2tXCe36FbH9uBMVVuIBSOYm>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:28 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:04 +0100
Subject: [PATCH RFC bpf-next 07/20] xdp: Track if metadata is supported in
 xdp_frame <> xdp_buff conversions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-7-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

xdp_buff stores whether metadata is supported by a NIC by setting
data_meta to be greater than data.

But xdp_frame only stores the metadata size (as metasize), so converting
between xdp_frame and xdp_buff is lossy.

Steal an unused bit in xdp_frame to track whether metadata is supported
or not.

This will lets us have "generic" functions for setting skb fields from
either xdp_frame or xdp_buff from drivers.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 include/net/xdp.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 58019fa299b56dbd45c104fdfa807f73af6e4fa4..84afe07d09efdb2ab0cb78b904f02cb74f9a56b6 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -116,6 +116,9 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
 	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
 }
 
+static bool xdp_data_meta_unsupported(const struct xdp_buff *xdp);
+static void xdp_set_data_meta_invalid(struct xdp_buff *xdp);
+
 static __always_inline void *xdp_buff_traits(const struct xdp_buff *xdp)
 {
 	return xdp->data_hard_start + _XDP_FRAME_SIZE;
@@ -270,7 +273,9 @@ struct xdp_frame {
 	void *data;
 	u32 len;
 	u32 headroom;
-	u32 metasize; /* uses lower 8-bits */
+	u32	:23, /* unused */
+		meta_unsupported:1,
+		metasize:8;
 	/* Lifetime of xdp_rxq_info is limited to NAPI/enqueue time,
 	 * while mem_type is valid on remote CPU.
 	 */
@@ -369,6 +374,8 @@ void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
 	xdp->data = frame->data;
 	xdp->data_end = frame->data + frame->len;
 	xdp->data_meta = frame->data - frame->metasize;
+	if (frame->meta_unsupported)
+		xdp_set_data_meta_invalid(xdp);
 	xdp->frame_sz = frame->frame_sz;
 	xdp->flags = frame->flags;
 }
@@ -396,6 +403,7 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
 	xdp_frame->len  = xdp->data_end - xdp->data;
 	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
 	xdp_frame->metasize = metasize;
+	xdp_frame->meta_unsupported = xdp_data_meta_unsupported(xdp);
 	xdp_frame->frame_sz = xdp->frame_sz;
 	xdp_frame->flags = xdp->flags;
 

-- 
2.43.0


