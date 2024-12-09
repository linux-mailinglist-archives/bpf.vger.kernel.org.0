Return-Path: <bpf+bounces-46435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1317E9EA315
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 00:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39511886E5F
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 23:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74650227599;
	Mon,  9 Dec 2024 23:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="j/oKdFil";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1rCAd2Kj"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D3A227566;
	Mon,  9 Dec 2024 23:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787913; cv=none; b=FY0zee8Z9DSSyptivyyM9Gkf0oI4cPjH+YMd1MXc7CNmbINvutCWUxRPVUhJwTKfi+JRa49KJsIz1m8xo4ndr+WBdEPN05IslwCAA46BIt7hoM5j6ANn5RRb+y8cKYBz7HXbPnrZwt3zmcGeYQFA2NQJm25bzy0EwgMcU8Iq72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787913; c=relaxed/simple;
	bh=tIaQGA6ru209wj2zRo7/LOYxSSw8NE0ffGbyi5wMNY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzFZ+sRTh+jBuRgVJ91SPyBqJv6I5rjvYZMSxe25YVSOktHFcZFJA+oq03eYku9vUYao4mN9phO0LOCTH2dHsI0Jt4u+54Db1Lbw8TBZyuURsxGA8UTUWVzt064GO30JB4pw83jkezrbhOJoI3QYpnBvS4ocTs4fvEnb4p43Q+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=j/oKdFil; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1rCAd2Kj; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F211A254013E;
	Mon,  9 Dec 2024 18:45:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 09 Dec 2024 18:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1733787910; x=
	1733874310; bh=xpRdN0TuD11EDsUB/g43WYAhnnZK310+Kd5LiZ2xWXA=; b=j
	/oKdFilbnw9IRuoZeN2lOu4k5bgZ38ziZ2vQjBCDmAVTGU5XnPUYeF4QYTki4pGH
	5X3RwpMmt/UxEIF/b3lZmQX2srndJNZJPMpJdkChlY1HuWUdTPRE7cV7SW9/Dr4g
	yf929HxaDZCpDvD4LnVLrWMXGKNz9z4YM7oY9GyygF3g2lBJZsGEKJFnaShCCJkS
	04u9M0CfrYx2H0w16oDBd6fLk19ewNze7nFt2qPvpu+CzwwjRBjJVp2hOiiGJyMM
	+DQ7DwA9j7lP2NXuh0p4LEmUIIxlZEw+530sbMVni1RnFIadhEqDItLExHdUDjr+
	hVr4JiKJ51MW+ZVH4Pkig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1733787910; x=1733874310; bh=x
	pRdN0TuD11EDsUB/g43WYAhnnZK310+Kd5LiZ2xWXA=; b=1rCAd2KjuXVVz9+wN
	RVq8Hme6sTL1l5rwOfCLOQxFc90qZJqdnFOeJvh51xtsa31T7MyquZyzo9DPCzyI
	D1prgzNLKqTCX85N7p5n0sfRwKefGWUeDlfZzbnKbIjFir4ACcbpKueHgYhrqSWe
	PHmWK+caoHfsxoh0RqtXp0ABOoeTPkggk045qjnFGHGkMG97podoFThmqZB/y6wn
	FhLa4EpC05/h1h9S6ibGbRlHr2/d1qjRVc9UEiGI1i8fRV2Ak/ZjV/O0A7SvSC7K
	Rkf1XqmUAncSsicBLw+yCcc8T+K+toHGRz0FpPNuSn/dmmBmg+3FSlZ0sOBEIASQ
	749Ow==
X-ME-Sender: <xms:BoFXZ4lJzSKyR73vVKevReHMbSOqNzsH29trocQmaQnuK35OYmd5xA>
    <xme:BoFXZ32BuyEE9mVGWuSNOfDt5whK3Zn1RBUYvPFGmvryE3JrDpAt4sik6dEwYEBFl
    Nx7269R8Uy3QgdmxQ>
X-ME-Received: <xmr:BoFXZ2rIyI-JBVAdmqYjlx7D4tzKHgXk2lw_l6IYq50l3oeuxsBwpXJxVMfFbxql6p1KUw9X5PYMmkENO0D_kTFO1cFTmjhVks_XF7EYcQn5ETUMEB8e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    fgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepqhhmoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvght
    pdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrg
    hrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopegvugguhiiikeejsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghvpdhrtghpthhtohep
    jhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:BoFXZ0n9J4_gcCJ0gCRRNdskHtEkK4YDKe4VejjjjhxWypYufcV_7g>
    <xmx:BoFXZ20yJuu7Li8dZ6IMM8EHIkFeWJyYB1eQFjoDd-hgH_gg5l-ueA>
    <xmx:BoFXZ7sC9PPtppkFcSGQAdM6wMQmLeMRu2ol8xbUOovYdpHVSBO71w>
    <xmx:BoFXZyW9WjrUAqTgL2W0X-z0tqNxrmSFxRe_gm7qSv8vIsfImunAlA>
    <xmx:BoFXZ27bJpDhvLbRPjrfbswRlp5iy_vofbPsgz3BiMeI4KHzA4Du-RLz>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 18:45:08 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	antony@phenome.org,
	toke@kernel.org
Subject: [PATCH bpf-next v3 2/4] bpftool: btf: Validate root_type_ids early
Date: Mon,  9 Dec 2024 16:44:33 -0700
Message-ID: <35e0299a1c511f3710a522bc79401debf6cf5983.1733787798.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1733787798.git.dxu@dxuuu.xyz>
References: <cover.1733787798.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle invalid root_type_ids early, as an invalid ID will cause dumpers
to half-emit valid boilerplate and then bail with an unclean exit. This
is ugly and possibly confusing for users, so preemptively handle the
common error case before any dumping begins.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/bpf/bpftool/btf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index d005e4fd6128..3e995faf9efa 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -886,6 +886,7 @@ static int do_dump(int argc, char **argv)
 	const char *src;
 	int fd = -1;
 	int err = 0;
+	int i;
 
 	if (!REQ_ARGS(2)) {
 		usage();
@@ -1017,6 +1018,17 @@ static int do_dump(int argc, char **argv)
 		}
 	}
 
+	/* Invalid root IDs causes half emitted boilerplate and then unclean
+	 * exit. It's an ugly user experience, so handle common error here.
+	 */
+	for (i = 0; i < root_type_cnt; i++) {
+		if (root_type_ids[i] >= btf__type_cnt(btf)) {
+			err = -EINVAL;
+			p_err("invalid root ID: %u", root_type_ids[i]);
+			goto done;
+		}
+	}
+
 	if (dump_c) {
 		if (json_output) {
 			p_err("JSON output for C-syntax dump is not supported");
-- 
2.46.0


