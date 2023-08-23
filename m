Return-Path: <bpf+bounces-8341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25B4785009
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 07:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284DB2812DD
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 05:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DEB1FCE;
	Wed, 23 Aug 2023 05:44:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD8A20F16
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 05:44:42 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31378CEC;
	Tue, 22 Aug 2023 22:44:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id D0A9F320034E;
	Wed, 23 Aug 2023 01:44:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 23 Aug 2023 01:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1692769476; x=1692855876; bh=kTagU20BDa
	tLoGV7FZLLaKa0n82rBotBuZHl4PWOz10=; b=c43bGGhIRZyUgGlrRyz2z+CEfg
	tbuzCkINjWyWzKNjYOyV8ePJojHHo8+mJZH3jP2r8/k7Esg/xkd0Yb8G+wpKVAfk
	8sBXL06nHMYUW6SINDEW/d0qh7eQb1UM63Uf1oXDNo40BglbX/c36gMwqPyu4TJt
	g5r6N2gt5Nisk+miXGAlqc3lw/mkhNWnlCDVt/twL/Nyi9O/W5yGexRBXGJHU4mF
	dP8cDDFSGh/3tk+aYP3tq3TAptgX6tQFwxeCm8QTOmfy7dtDy4vZYczDZABz+QVD
	nWjSVPVvCnQmG9t5QK255XFcYbAr29TkSvPVZgWpnIaOHmpPVtPq6G0q6Kig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1692769476; x=1692855876; bh=kTagU20BDatLo
	GV7FZLLaKa0n82rBotBuZHl4PWOz10=; b=SHb5nhwJp8ce72wiHhQdG3AYO/scN
	7/JYFrXWBnfG2e0z75FqqFJVWZlENIVaWz1ACeACHLQhS2B2L+6Qdp4oVvVyNjOA
	rgJAKjrnKCOCAxZJX3x8gU4dkduEbgKRiOjVklnff4d0K5bsowg9hVkW+pG8aboB
	U6nYvsGXYpbb1mOurYL8pETeuqZzqLBmmOeB1wAhgXiipdL17080W8jlbdtXNpam
	q8sc6pDZtEQB5oWdW8gvA8/hn9pwukURHxIDz/35806Q9lYdqHn1c8+xz74osk0p
	F3EK2b904fNthHNMNOkKnO0Pen6Ph2yjVeR7RaCFJ4ikz5neGgh17U88w==
X-ME-Sender: <xms:xJzlZGY6ZMwqjtMBB2HakaLPyRH8tKHMVN_67CFU827IiT-V6MlGXQ>
    <xme:xJzlZJadIqXVROOfSRS4VtF--I3lu9Lv9ssGs8c3bpP-vdPgVu7VQzW3Trl_tBkf2
    nO7Z5Yu9NVkAIOaxg>
X-ME-Received: <xmr:xJzlZA81-rps3HZYNCNd73foNzkRZySplsxwLrlUrl-vpxuNTqElv9PN87hBL3gjOh0YzdM35Ki_nomcLBB6R3BgE-ZQUCl4XJrDmzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvvddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdeggfetgfelhefhueefke
    duvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:xJzlZIp965iXdP8GCmfl4PRhwrwiT8xmqgXaZt83EYHkQhl3MKnRRw>
    <xmx:xJzlZBo0ilIZSFMrvAQpuLjbwea3mL-LDvzLDMMtkCvrKGh1ManN9A>
    <xmx:xJzlZGQnhmQTBO-NqS-uX5gNsNSmf4hF0nGOLKA5cExxSOHN3VrWqQ>
    <xmx:xJzlZCTbRCqgffMDi5I7qNA_Tk1voy3m_naoRR8e6BQ8eMiaBTXoTg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 01:44:35 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: Add bpf_object__unpin()
Date: Tue, 22 Aug 2023 23:44:25 -0600
Message-ID: <aeb83832ae61bbf463e1b2e39c1e30c3b227f5a5.1692769396.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For bpf_object__pin_programs() there is bpf_object__unpin_programs().
Likewise bpf_object__unpin_maps() for bpf_object__pin_maps().

But no bpf_object__unpin() for bpf_object__pin(). Adding the former adds
symmetry to the API.

It's also convenient for cleanup in application code. It's an API I
would've used if it was available for a repro I was writing earlier.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/lib/bpf/libbpf.c   | 15 +++++++++++++++
 tools/lib/bpf/libbpf.h   |  1 +
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 17 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4c3967d94b6d..96ff1aa4bf6a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8376,6 +8376,21 @@ int bpf_object__pin(struct bpf_object *obj, const char *path)
 	return 0;
 }
 
+int bpf_object__unpin(struct bpf_object *obj, const char *path)
+{
+	int err;
+
+	err = bpf_object__unpin_programs(obj, path);
+	if (err)
+		return libbpf_err(err);
+
+	err = bpf_object__unpin_maps(obj, path);
+	if (err)
+		return libbpf_err(err);
+
+	return 0;
+}
+
 static void bpf_map__destroy(struct bpf_map *map)
 {
 	if (map->inner_map) {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2e3eb3614c40..0e52621cba43 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -266,6 +266,7 @@ LIBBPF_API int bpf_object__pin_programs(struct bpf_object *obj,
 LIBBPF_API int bpf_object__unpin_programs(struct bpf_object *obj,
 					  const char *path);
 LIBBPF_API int bpf_object__pin(struct bpf_object *object, const char *path);
+LIBBPF_API int bpf_object__unpin(struct bpf_object *object, const char *path);
 
 LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
 LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 841a2f9c6fef..abf8fea3988e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -399,4 +399,5 @@ LIBBPF_1.3.0 {
 		bpf_program__attach_netfilter;
 		bpf_program__attach_tcx;
 		bpf_program__attach_uprobe_multi;
+		bpf_object__unpin;
 } LIBBPF_1.2.0;
-- 
2.41.0


