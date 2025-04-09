Return-Path: <bpf+bounces-55499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 238E9A81B89
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 05:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75FB8A0497
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 03:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E33B1D7984;
	Wed,  9 Apr 2025 03:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="M5QaLNvZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ljteCJ2o"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F841D5CFE;
	Wed,  9 Apr 2025 03:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169688; cv=none; b=UyRsoqjiDF++8a1aBhyIbHLkz3o9/ZGFmMpmdc8Ni47JRRSvDFCJClrJdGmz6XX50CX25pkuq6b505wgXQ+hgGj/+LTPZ1BI+SxkBUpv5OVL5IuRwYPcdSGxKFIi6qfIR//BMyNciH0fOZ3co6Q3dc7g53P+uqX2g76RAM6Ev6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169688; c=relaxed/simple;
	bh=RIZppefsU+3autn4NmcSi1RoSkrIV7WO4c4Uuqi9okg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoXK2XK9UUygDNWZ1hKZiyPSkg07/CLYcfynj7y5yQ6SjXiZooA1zaxFrqmy4DAjtV7vzq6+o13L0/FhlDtsAETk1QnaByxKCcdcy82Knd6e9p44kOz0iCX5xRShvAlZ7aGJ2YcbCJ9745y+EFWmQ1s7r7MH0jI6fEFSxB2funE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=M5QaLNvZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ljteCJ2o; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E845A1140255;
	Tue,  8 Apr 2025 23:34:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 08 Apr 2025 23:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1744169685; x=
	1744256085; bh=PveBnY5/PTuYnXShL2+88mWJUuaL+VGQS4W+0t445Kc=; b=M
	5QaLNvZAM7C8IHrA4QhTpe+73lSPTrfmzYYHIiMuSPefmQharaAXlTKd1OQUHPi/
	GRznDJfaWrTZXPHcm8Dp96Gx56oen3Q+YVasekLv9dmOF0pbf+0g9Rg2WgHb6Tzr
	wieozc9DtdA9a3rBil0PG5d7I02keFTn6GRXQg2wx90OriRSZx4BRFE42f5l4Og6
	x+aRsh00KlbkwBb9u0uwodOAphopH/LPW8eVCsEkksfWFmdDvT4qmJLIY7Hld/f+
	n0UooSpR/72RHAVEj988cF3VkmEl9pVJgtfKu8K7O1F0K3JwmgTTiqQW9AbSGWWD
	DFiK6/1NogzitEisqTOZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744169685; x=1744256085; bh=P
	veBnY5/PTuYnXShL2+88mWJUuaL+VGQS4W+0t445Kc=; b=ljteCJ2oIWGqZqEQF
	HslpAjejrnlDOxexj1LPXE2gmcnQKP+iqfawNSwoAud5cQH4iLVjSBYDqpjBcgXu
	mAFRFvdNJVJUmF/zR/rjilI5mVBMFfj62S9pBJdLYQaoVCufugFaXEoTuhEPbAKD
	D9+O1msNT/L9sM3/K/tGNTlHZ/rILYc6k7+JMg7H/rTTTGqGQO5RioJ0vrpFAzrT
	cFXN2jO7HL541dwqpgVAkhbeCMWn5lwHWXRSIPjlCxBhOVagQTkCYWPAdmlHWFLO
	aNsTDe6N/xt6ebCrUw4GVFxdDkJzGEVMtYiKhZuNBwFcYuwOpYQzn2hPFglCXc4H
	6e0aw==
X-ME-Sender: <xms:1er1Z6UAedeTrlAbNvieiYHSpXyiV5ozTPUHy6301GbgGm-ftz2yrw>
    <xme:1er1Z2mgK2uPe60vcuUIa3vXH5s9dS3lJfNSRa9l2N1FlCeKOBh_Bf0a95mTh95Qm
    P8YfOIZL19Tfxu6bw>
X-ME-Received: <xmr:1er1Z-b63blm4Qj9Hu_-L6ZyW2vUvBs79Whe4RCkqW0fTyab7pwjNtupSjofg331Jbju96ucOtYIq8S4P9ceEodqyqeCF1WiV4wQpE_5da-f6fWJwY2l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffuc
    dljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhm
    peffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvg
    hrnhepgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguh
    esugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgs
    ohigrdhnvghtpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghp
    thhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhu
    gidruggvvhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1er1ZxXk2ZdiDNHZ_DWb-I0P1c9BW-P8DT5CcaynAVKnatnqYa3kpA>
    <xmx:1er1Z0m_UCAX_OZCy5xlXtyRKos2eXWmN_xdYWwFwBOSyw1mXeLtHA>
    <xmx:1er1Z2ekb3R_fXUy8oXmyecwnpPMnSyW5-5-knyIA_tTHa-pZtQf-w>
    <xmx:1er1Z2EbzzS-e4_7w0ppijYfpyVkvoVeVM8e2PZ8zppv0JLuJrfuIA>
    <xmx:1er1ZxSwQjKpgyfbZhSsC0711LqQQDs1i2mqTASoj2e2kTFIAxnlBb9A>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 23:34:44 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC bpf-next 05/13] bpf: Remove map_set_for_each_callback_args callback for maps
Date: Tue,  8 Apr 2025 21:34:00 -0600
Message-ID: <21ca9709216aac7b7ab47e650f3491b8801613dd.1744169424.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1744169424.git.dxu@dxuuu.xyz>
References: <cover.1744169424.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently all iteratable maps (maps that define map_for_each_callback)
use the default callback. In an effort to reduce the number of incoming
references to verifier.c, just remove this level of indirection, as it's
unused.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/bpf.h   | 3 ---
 kernel/bpf/arraymap.c | 2 --
 kernel/bpf/hashtab.c  | 4 ----
 kernel/bpf/verifier.c | 5 ++---
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e0bd78ff1540..1785901330b2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -169,9 +169,6 @@ struct bpf_map_ops {
 			       const struct bpf_map *meta1);
 
 
-	int (*map_set_for_each_callback_args)(struct bpf_verifier_env *env,
-					      struct bpf_func_state *caller,
-					      struct bpf_func_state *callee);
 	long (*map_for_each_callback)(struct bpf_map *map,
 				     bpf_callback_t callback_fn,
 				     void *callback_ctx, u64 flags);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index eb28c0f219ee..e12224d479d0 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -800,7 +800,6 @@ const struct bpf_map_ops array_map_ops = {
 	.map_check_btf = array_map_check_btf,
 	.map_lookup_batch = generic_map_lookup_batch,
 	.map_update_batch = generic_map_update_batch,
-	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_array_elem,
 	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
@@ -822,7 +821,6 @@ const struct bpf_map_ops percpu_array_map_ops = {
 	.map_check_btf = array_map_check_btf,
 	.map_lookup_batch = generic_map_lookup_batch,
 	.map_update_batch = generic_map_update_batch,
-	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_array_elem,
 	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5a5adc66b8e2..a91f08306682 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2265,7 +2265,6 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_delete_elem = htab_map_delete_elem,
 	.map_gen_lookup = htab_map_gen_lookup,
 	.map_seq_show_elem = htab_map_seq_show_elem,
-	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
 	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab),
@@ -2287,7 +2286,6 @@ const struct bpf_map_ops htab_lru_map_ops = {
 	.map_delete_elem = htab_lru_map_delete_elem,
 	.map_gen_lookup = htab_lru_map_gen_lookup,
 	.map_seq_show_elem = htab_map_seq_show_elem,
-	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
 	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab_lru),
@@ -2460,7 +2458,6 @@ const struct bpf_map_ops htab_percpu_map_ops = {
 	.map_delete_elem = htab_map_delete_elem,
 	.map_lookup_percpu_elem = htab_percpu_map_lookup_percpu_elem,
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
-	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
 	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab_percpu),
@@ -2480,7 +2477,6 @@ const struct bpf_map_ops htab_lru_percpu_map_ops = {
 	.map_delete_elem = htab_lru_map_delete_elem,
 	.map_lookup_percpu_elem = htab_lru_percpu_map_lookup_percpu_elem,
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
-	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
 	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab_lru_percpu),
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2b5e29ee8310..d3bb65f721c9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10638,13 +10638,12 @@ static int set_map_elem_callback_state(struct bpf_verifier_env *env,
 
 	/* valid map_ptr and poison value does not matter */
 	map = insn_aux->map_ptr_state.map_ptr;
-	if (!map->ops->map_set_for_each_callback_args ||
-	    !map->ops->map_for_each_callback) {
+	if (!map->ops->map_for_each_callback) {
 		verbose(env, "callback function not allowed for map\n");
 		return -ENOTSUPP;
 	}
 
-	err = map->ops->map_set_for_each_callback_args(env, caller, callee);
+	err = map_set_for_each_callback_args(env, caller, callee);
 	if (err)
 		return err;
 
-- 
2.47.1


