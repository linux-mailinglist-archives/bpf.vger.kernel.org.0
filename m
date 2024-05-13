Return-Path: <bpf+bounces-29658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82568C4702
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 20:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5E91F2202B
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B934B3D57E;
	Mon, 13 May 2024 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="dwiVjUOi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RZD3jzFe"
X-Original-To: bpf@vger.kernel.org
Received: from wflow7-smtp.messagingengine.com (wflow7-smtp.messagingengine.com [64.147.123.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24373C099;
	Mon, 13 May 2024 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625558; cv=none; b=EB4qCFESl7HMAYgQaNMn1qTQ6IL5bPAzlPoZrNGPWXavwY9H0XDIbePlNuiBpl5cpvK87Xp/bw8OPpM7w/GEldV1TEknyoe1TsB4/EMKHHwgj9mNgAduRpfySrkn4pCIDrd8LcbfkGxl7IKYLYVE0QSs2KLrDyziUhWsyvERa08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625558; c=relaxed/simple;
	bh=jPKiXJOmnQNOWhBvYnpso6oXP7ZkLGQqjW8y3RqzOPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcdGvWIv/6SVu6dbQMxQ9+ndTCj+YPyPcuCM44XvVJvQv9cl5ojJgZjEPnrcLiZJiXXR9VAu7d4c9Q8oXkanv6p1mlkrSfvm9OoZXiG6PlTaszrR1AdosqhOC0GWjpwsnVuOZVxwvW4ACaQBUJ634JBILyzAiIwa5It29PaWkq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=dwiVjUOi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RZD3jzFe; arc=none smtp.client-ip=64.147.123.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.west.internal (Postfix) with ESMTP id 1B58B2CC0328;
	Mon, 13 May 2024 14:39:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 13 May 2024 14:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1715625553; x=
	1715632753; bh=E8COH8IZC+TlbAgPPssdPSgDjYfCZqEAwY2cntHhuEA=; b=d
	wiVjUOi/+ghg09jSj01shwt8krvgo55aQzaPUc9fh32xOVtqZB6SzaJ7jwLxrnn6
	npU1RKvin/DnzpPXGrCVlsBCs+9aEnZ2LbnXeO7HboavfvdhYs63pteHquTIrEUG
	ups9zVYK4NrGp9K88HYWkPS6AWHpxK4NSTqw3mqdk+c4GeoYg8fp7MyhY1ntvT6M
	LS2X0MmRBhbWYsepQ8GHJPrSdoZdxIHiEdh1S5y9NzvMml9uRXUtzMOQUM4Z/moD
	XSPpbsPFidykiZk78dpgOUo0JO3hNfyIwZo9AY3ifY4Z8UaDWMtTOSdUhfOE7fWO
	OIQiavgRmqCVsBBb6PlCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715625553; x=
	1715632753; bh=E8COH8IZC+TlbAgPPssdPSgDjYfCZqEAwY2cntHhuEA=; b=R
	ZD3jzFeAjyI+thEnFw5uAI9Wk6Pq3nyO+ELKhud7H7uc3ce11BWVqrh0GkdVBr+B
	OON0Rsdo7NkZFwLedE7YZhKCo9PUi74N2WTK6ffNz7UiObuFVPstJxZOAigayl/a
	XuJtrd2oQeloLnpQlJHJVS+exRN2MIsEC54/Dab22Z3lhUF/+9eebyqUfHgkvhfq
	uF5qRqH7EA1QGavmMs8yLpDwP0oxmt/me7kAHgiPK1NyUU/JFDpI0IQtO0gwkwJA
	XfIuEFa08vc3zowevAQ+pENtKgPIl9DIhmhPpvDGxt2HhOKhN39rWyULs9UvDBvZ
	KnZ/ut/7Gpnva+mgj3NhQ==
X-ME-Sender: <xms:UF5CZjaEE2kFNAk_CLFk9Xs_3JwyyESqoXicyv2cgzKPgildK_WQrg>
    <xme:UF5CZibr1UM36S5cRjrl_n2Trkmo8xzwFKgPMZPg-XlSx0b1B6WD2-A6yAGoMuHwS
    faa5MVLvPi3dqUExA>
X-ME-Received: <xmr:UF5CZl-bwcWyT92_QkV5Rgo091Hoe_AOZb2T6WifJtyWUDkpGa7sf6CPtcj4-svZ4pxYuDDLF-XjLN55cxVqsclnbAXO4RRegpbpJ1Fy3yemNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeelieduhefhteffie
    dutdejgfdutdekudelueelveekjeeitdefueeutdelhedvfeenucffohhmrghinhepkhgv
    rhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:UF5CZprtfQdtd130oEEo-OzWMMqNmyULMSEmWMzshTCsiuMoVarYuw>
    <xmx:UF5CZupKUiZjobVlYSIkxJm2Xe7TrA6-evvb_hrY1wEe5T7s0I9heA>
    <xmx:UF5CZvS99ry05k7w305Ln38HU2f0tXLWDLhvR7_pAkINHdfN_MNc2w>
    <xmx:UF5CZmqqRUtZpMZAADdAYbCeyngd00GifPjt7b0luSpXT38If7T6lg>
    <xmx:UV5CZiqNMEyB9PEOTDlIxxn0fMD1R8DvLEVAUdYRNetnbcutp46By9AF>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 14:39:11 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	daniel@iogearbox.net,
	masahiroy@kernel.org,
	andrii@kernel.org,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: nathan@kernel.org,
	nicolas@fjasle.eu,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/2] kbuild: bpf: Tell pahole to DECL_TAG kfuncs
Date: Mon, 13 May 2024 12:38:58 -0600
Message-ID: <09085a7207265b153d0c81eee30906009c66cb82.1715625447.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715625447.git.dxu@dxuuu.xyz>
References: <cover.1715625447.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With [0], pahole can now discover kfuncs and inject DECL_TAG
into BTF. With this commit, we will start shipping said DECL_TAGs
to downstream consumers if pahole supports it.

This is useful for feature probing kfuncs as well as generating
compilable prototypes. This is particularly important as kfuncs
do not have stable ABI.

[0]: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=72e88f29c6f7e14201756e65bd66157427a61aaf

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 scripts/Makefile.btf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 2d6e5ed9081e..d9ec6c85ffa7 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -21,7 +21,7 @@ endif
 else
 
 # Switch to using --btf_features for v1.26 and later.
-pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
+pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
 
 endif
 
-- 
2.44.0


