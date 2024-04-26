Return-Path: <bpf+bounces-27876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98C78B2E0B
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 02:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F6628537D
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 00:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5641CA47;
	Fri, 26 Apr 2024 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="DRoBv/9m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gqhOxEMl"
X-Original-To: bpf@vger.kernel.org
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF68801
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091357; cv=none; b=ajT0DINjT1wOIaI9jzMif8acWYXvfwHwupd1uNT2xRVpiJYDWErGGmm6x/c7DmZXxrxRAodtAuWMI3nNKhCUyy9MP6q2AiCumQBmQu8eS8OyDu9jpfzzbr3VM9huMmXj6lhPo6NUuQ6wD+49wdN9s1PkNieIfNkFBVZXAKUAf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091357; c=relaxed/simple;
	bh=KZb3ylmHkZRjfNhPtnDMwCRusC/Necha6l3BTr6fzAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4CGOkxgW0jn4KjDc/91FN/dyK/RKRZHDjGJL/Ur2f2cWGheLFqEQYOX36R0EzgNzYUairpooEAL7VTLDsdl1Tbm31EKF4mMQPW14qWwLZ+KNDznDMB0DfjEmLRx1vYK7KkHmiiFhC7PJZT8vo2TGFU3NfE51LKkcq55VBypJY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=DRoBv/9m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gqhOxEMl; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 1536E1C00098;
	Thu, 25 Apr 2024 20:29:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 25 Apr 2024 20:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1714091354; x=
	1714177754; bh=vt11BUjZiHiL6ZazwmCpcxk1cFrD+6KlVBb6TnSg2uY=; b=D
	RoBv/9mqPAz/QHHE49UxWzTfEITNs3hWbXbMJ1kY242mWJvkdWrux3s2k8sBh4Pd
	FYPruEdExLWVlsfT80veslk6OoRsq9+gPkShdje7S0cu64vsm7kChFF4wtW3gTuX
	8wsXHiRvS3C7llZzZeqiLWIDqoGwjdy0Xzt8AJwk5kcqn+GHVR/g53yoITT7n31t
	7jbr2/bkcn/F9cea1jLhBNAe26yO9oW98lmdZSwPGRs6pmYj1ExXtrqf3nh1scT+
	eVigoPuMwTlhBz78VFZxZHvTv8ViL1hNhSJlQ9hiGklwZfx7LZxuz8Rnwuv8ir4G
	IOhwLNORRgDtYCxIupXow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714091354; x=
	1714177754; bh=vt11BUjZiHiL6ZazwmCpcxk1cFrD+6KlVBb6TnSg2uY=; b=g
	qhOxEMlhZOQu/0Bu3wTumkzdcgEawE/DgpfwZSGnSynzm+p70OoNaKCVyKXlTihy
	9RQgpng7hmL7hwS7hwMb712RVNxPf1cNZuNdBj4+065VJRfyoKIH5QmZbIqd8N6F
	LD3E4PT1vy+vz5htPZE6xnbUWlkyDext4w8vGXwGaJatzX0H8WALMbK0rJt8OvyE
	HdB6WcKrrIhAUWckjk6yO4ct1nxP/P3+NFuoC5O8VviO14h04fplghyLoLK1pDa7
	/AJ9y0AWbOQltg30fNlx9ui4P/15JqKUvSAjhz+tQfNg0uI1Qch5szkJxFEUCI2Q
	Io0MPk0T+MtvjDFT4HjIg==
X-ME-Sender: <xms:WvUqZsJWcQqcbfvIGS772YnzQeHGa1fRW86boU0oRhkmeVDK2EhNHg>
    <xme:WvUqZsJYAsVg7J2EIBk3yoAlJjr5L02_i14djMiNcsEAw2tFQiPIj8uE4hjhk6QUL
    YgUpgsZ3ZTibwHy8w>
X-ME-Received: <xmr:WvUqZstu9gMmBEpTF5UYMvO0LzyUxUggFVuujDQ_ZU_Vhu18_QCnolKGG32cB_s8bK5BMy4lUWMJ-rgfNefsY4kV7mjlErQBZggtFEof_Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelkedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:WvUqZpb6fonbXCik8djjYlpslV2Z3NLfA1c8aMA_OULlhkVWyo5Heg>
    <xmx:WvUqZjY6v_JfCJZAzMhQ5iyTNfsojJSvtwP7VVPu2rOTbQ9gy1vcwA>
    <xmx:WvUqZlDpZijWrEwgP52kO7VmFZe4OrU9_Tu2ewgyka8C-CiFIOy8uA>
    <xmx:WvUqZpbIzJEpXcTsGnxvkFVYhzy_jmaizotYPPLbd--Ff406jePpmQ>
    <xmx:WvUqZtnsP9DwDLL_tJRk648ANbsTnOeqWAEsEvdPQssEicTJeppu1WuM>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 20:29:13 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: acme@kernel.org,
	jolsa@kernel.org,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	eddyz87@gmail.com
Cc: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH dwarves v8 2/3] pahole: Add --btf_feature=decl_tag_kfuncs feature
Date: Thu, 25 Apr 2024 18:28:40 -0600
Message-ID: <6d69d6dce917475ffe9c1bd7bc53358904f60915.1714091281.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714091281.git.dxu@dxuuu.xyz>
References: <cover.1714091281.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a feature flag to guard tagging of kfuncs. The next commit will
implement the actual tagging.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 btf_encoder.c      | 2 ++
 dwarves.h          | 1 +
 man-pages/pahole.1 | 1 +
 pahole.c           | 1 +
 4 files changed, 5 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 5ffaf5d..f0ef20a 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -76,6 +76,7 @@ struct btf_encoder {
 			  verbose,
 			  force,
 			  gen_floats,
+			  tag_kfuncs,
 			  is_rel;
 	uint32_t	  array_index_id;
 	struct {
@@ -1661,6 +1662,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->force		 = conf_load->btf_encode_force;
 		encoder->gen_floats	 = conf_load->btf_gen_floats;
 		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
+		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
diff --git a/dwarves.h b/dwarves.h
index dd35a4e..7d566b6 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -94,6 +94,7 @@ struct conf_load {
 	bool			btf_gen_floats;
 	bool			btf_encode_force;
 	bool			reproducible_build;
+	bool			btf_decl_tag_kfuncs;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index e3c58e0..4769b58 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -308,6 +308,7 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
 	                   in some CUs and not others, or when the same
 	                   function name has inconsistent BTF descriptions
 	                   in different CUs.
+	decl_tag_kfuncs    Inject a BTF_KIND_DECL_TAG for each discovered kfunc.
 .fi
 
 Supported non-standard features (not enabled for 'default')
diff --git a/pahole.c b/pahole.c
index 750b847..954498d 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1289,6 +1289,7 @@ struct btf_feature {
 	BTF_DEFAULT_FEATURE(enum64, skip_encoding_btf_enum64, true),
 	BTF_DEFAULT_FEATURE(optimized_func, btf_gen_optimized, false),
 	BTF_DEFAULT_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
+	BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
 	BTF_NON_DEFAULT_FEATURE(reproducible_build, reproducible_build, false),
 };
 
-- 
2.44.0


