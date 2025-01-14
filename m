Return-Path: <bpf+bounces-48846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EDDA111F5
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 21:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECE4169CEB
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 20:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B224B20897A;
	Tue, 14 Jan 2025 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="F2iErM87";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dtGSZwuF"
X-Original-To: bpf@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9471720D50A;
	Tue, 14 Jan 2025 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886553; cv=none; b=pDOx0c8ZbQxKjuNEf9psexCd9ObgcvOMP5Mos0e6Xd4oIGaKOCN2Rz78cCYlC1vWUkPxxou4LLYQQ3egSXMxt0/sGBsVP6GASXSll79LGKDZDx12Y0OXPNQrbsu+2DlR7YaorgY4FXsRWDS/dEay3vUBlcur7fPeP4klHMiwbmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886553; c=relaxed/simple;
	bh=M3sPUnOlMOUEjIyxNXS7N0GciZ/ZSrap+cHlJvyandE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EC+sR3PMYALVCPVgcvSggPP4YeWhbOMw1M/pR9AaTr3Wpdy6sBvrAPy8Qou2B2y3w5JU+Dajo/3kSIerG0IMWfkMcDr3KPjwt05fSKg7oOsXTspNfxhDGLEEpCQXawsbcM5YEy2+0DBhEwp6TvN0AgM0BaKvDyFJwayszCQGYcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=F2iErM87; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dtGSZwuF; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id 285311D40AD4;
	Tue, 14 Jan 2025 15:29:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 14 Jan 2025 15:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1736886550; x=
	1736893750; bh=YxyPwDN5jF3WrYeLfnPg62rlODl4h0Cotdz5rtDrqTA=; b=F
	2iErM87+ojy4AaRSDXpLJeiS9EocxjEFjkBTqf5bRZSPZPXTtAL26KtZJl+OJDoD
	3w9ZgPNHfZhz/uzzUpK+oGN0Vof11egaXS8OEsvySdQtdygy4akfDTAAfhtKX93f
	QkKDjgKp8ZrJzkPnMEX85ITo4tVkEDUYyIULYOdUTSn5QksGKqTv+HbszjySiPFu
	WwEEXsw1MFCbJK+vMklqZkvO9FAqwY0wR2kNFetAhz0Py4WMvdHcxbVxGBH3Zv07
	ybTm0sSLj+snLN/XFXW8smw3dyizwr/wjxoSPFBUCEOy3m20bbtFGhDGfHrkOC/r
	js2EizrsMbcSoin69DFIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736886550; x=1736893750; bh=Y
	xyPwDN5jF3WrYeLfnPg62rlODl4h0Cotdz5rtDrqTA=; b=dtGSZwuFpXaRsDDbK
	CNksfSaz5FfyCg99LTf4LqnIJBAL1GFvW4gOXRqGAdetto09bDowKghV9X/TgZlh
	8xOc00LJ2dqHqZmvty9lZY56QID/+pDQ1ZrTjshU84M5kJPsAvJ8maHTVYs5iCO9
	SnoUCGxsWCELb784F+MPs2UtMh4L9nKdWjZBKIHCGFVHbVl4BGJ3BHKKxu7LLlWa
	EyxmLAvTBwglenh8MPPh/hw+wfO84OMAOvWl3lJgtWAKsr8r2k7ts1e6UzVbF4Yk
	A/ETcBZN+Zhl/mCjAiE9/YcPdaGAVWgtQaO36fT030tude12gCfVyaPjYAIXYAau
	yXr6A==
X-ME-Sender: <xms:FcmGZ3zSNt8-IRUzsZhzDgzbOmU5O4706V4NqFosCtJQVL7YoOmmbA>
    <xme:FcmGZ_QiuSUVSlBzfXyZv-4cMIy2a-cgtLmRg6drBUsZYCkrSoPWqTZ_ONCuUuw0a
    hNdBNmgpAYtDTedug>
X-ME-Received: <xmr:FcmGZxVyiy0wk0KHl_x5AwuoW5SBNC_nlogFVvMpnWVa_uVCtT6UePOzNLElP-vjs307wbP3X9QYm4-E153oOkBwrR9nLhL-Gu8VB9Z7_nTP7VeGWTWa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhephffvvefufffk
    ofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihuse
    gugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteff
    leeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgt
    phhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtth
    hopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtg
    hpthhtohepmhgvmhigohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrnhhivghl
    sehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:FcmGZxjdHVNpRR74YfMsPNvn86QcnnUAEbsQIKg2AE4ifPSdBVCUcA>
    <xmx:FcmGZ5B3vhZGB_WX5EzmDcxduhMjD1UGAREDRToHuFcE1W24xEkiiQ>
    <xmx:FcmGZ6LkKmigffSTzq-xAUih4-H1i_-m19MRWzlIvakxmaReGtrPgA>
    <xmx:FcmGZ4B2opdmX_5J9WgSXJtWAqNx5FaO3xjLD_vGG_GZlhgi60TA6g>
    <xmx:FcmGZ4UPJMZe3ZjIWR660X65DIfWK-SVnnXf3X_h92EqztsdLwq-b1A5>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 15:29:07 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: john.fastabend@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v7 2/5] bpf: tcp: Mark bpf_load_hdr_opt() arg2 as read-write
Date: Tue, 14 Jan 2025 13:28:43 -0700
Message-ID: <730e45f8c39be2a5f3d8c4406cceca9d574cbf14.1736886479.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736886479.git.dxu@dxuuu.xyz>
References: <cover.1736886479.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MEM_WRITE attribute is defined as: "Non-presence of MEM_WRITE means that
MEM is only being read". bpf_load_hdr_opt() both reads and writes from
its arg2 - void *search_res.

This matters a lot for the next commit where we more precisely track
stack accesses. Without this annotation, the verifier will make false
assumptions about the contents of memory written to by helpers and
possibly prune valid branches.

Fixes: 6fad274f06f0 ("bpf: Add MEM_WRITE attribute")
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 21131ec25f24..713d6f454df3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7643,7 +7643,7 @@ static const struct bpf_func_proto bpf_sock_ops_load_hdr_opt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
-- 
2.47.1


