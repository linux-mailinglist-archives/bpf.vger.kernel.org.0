Return-Path: <bpf+bounces-28201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6DC8B65E5
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 00:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6931C2124A
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32E129421;
	Mon, 29 Apr 2024 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="1qylGMZN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AsnX6Z9X"
X-Original-To: bpf@vger.kernel.org
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A9335A5
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430786; cv=none; b=p7f9tbIKgnYxac56k6x8C1C8zQ6u2e96BCBVw3Vvfxx1+J+HwLfHQzaCpJS9pkLzpU3xSQwxF6AuVdpZwXXRxqj3qtabzOmim7MMtqjTxOg5vSryGNB9j83VUH9ff6wvWMzhkoL+C6KMIDEBACJ9Kb8GEcIk2e7epO+JALSQTrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430786; c=relaxed/simple;
	bh=KZb3ylmHkZRjfNhPtnDMwCRusC/Necha6l3BTr6fzAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9F4lEZCIXA4BX5PlEjGn+nO2k0YXDOtC2FOSqAUDs1SLznZ2qzGHBcRq2Z0G5j5r+f3WmIblQHGYa25XwiurCsoMWD7uTWcPEdHnYOatQ5aFKWe9kyZPemWEpuZLpn8HRFiyOb3fVIfbCZpJMov1cD0WYXycdEsnyK8YENGn/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=1qylGMZN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AsnX6Z9X; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id D523E1C0017A;
	Mon, 29 Apr 2024 18:46:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Apr 2024 18:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1714430783; x=
	1714517183; bh=vt11BUjZiHiL6ZazwmCpcxk1cFrD+6KlVBb6TnSg2uY=; b=1
	qylGMZNP0QRJ3QRgquCsJLiFMw+6cpX0lQaSwoDInUwM0buJTfgqJGm5rvKpax5u
	5nMPODUIGmTOSCaZ9NE7/3AznUUu7e17/Nqlv8O5l/cWSPGrmBAPJOwAk7eRPVrR
	kpc5JEiaVT26qLtybLA8zwiFIP+ym+bfhzFCCdoRNCzqwuP1toz+lZNrBjhf0FGD
	7OGDrW4NSuHU5VuhooqTBEGIJC0AxU5vytFXMOpgwwZm69bDb1pp5E64ppGveIAP
	agGBu+Amd2TPvB4nwk2Z26XUTrycZhOAVTJGAZbMSWk/MYh4WVwA76M0uw+k6coc
	4Cs1E+3otQ6rgwShSa1Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714430783; x=
	1714517183; bh=vt11BUjZiHiL6ZazwmCpcxk1cFrD+6KlVBb6TnSg2uY=; b=A
	snX6Z9Xe1/uHV1fQrUjm3s8J24wsmt+VO8pm7YflNBHSnys6dE/br1Skp8MpizwY
	hEdIZsEK4eUEUyBJtVEYth3xiO0uKj4FEH6tbINXnpM4YtoI/ClkLtOP+zwhRzHQ
	Wq0dFP62t9UMRL4jewOmBwqGXIV+56NcJ43/Xx6e11QqIQl3mJB9cK/YZBRWN5x0
	w3zPdYI23dZqBa4Hg0w/f00NlHcokP8gXPi/wEEk607uhH6ig14DitTx87vjaF5E
	tTgSPXH1SbRi2gY0ZAEn+nPxkJbzAwvDwPPOC/gKf8NTmBi/6+65530YAYP+ZdOT
	rQ9yD9dt6Xj2WlEyUCSug==
X-ME-Sender: <xms:PyMwZlUeFAQ2prOkN8JprIZMgUZ_1bVzB2cQc0jiSy8Es_qVONQZ6Q>
    <xme:PyMwZllkI8QGOwYqPmZaYn4WdII_B69VltK6-pnQF9tWw0NSx_NT5_4l72YVs0sUn
    gaZMIEZjXqZ1aqHew>
X-ME-Received: <xmr:PyMwZhYIpvaJKataohrs-V7MCBTNhGpGMlaZTmdJ_qSLolWA3Rms9-RDUjylVc_LfMgfO8Z8J5K5gFLL0JlTNtF8QypSWeBHmPKENGq5kww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:PyMwZoWhIP1jGrIaz6SE-rW9jHROfRftf5VrbYDG897Uz34Zgm1NHQ>
    <xmx:PyMwZvkH4pCwloIHmJITMQS6D2dN6S6jwVc-u3k09WF6PDKRynJNGA>
    <xmx:PyMwZle32YuW-my0k1hVezM2Ht8TwlWphEoT_NwgwXtVemM2Bc3kRw>
    <xmx:PyMwZpHLPA9TY7_FpmOfNvn9HPc8TXtLMazxizJA1USuAK_sEW3--A>
    <xmx:PyMwZogt5bNkR3nW5JoGaBCO7iKYZwVLQYlDUUDAUwiPjqBh91BMdfwJ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 18:46:22 -0400 (EDT)
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
Subject: [PATCH dwarves v9 2/3] pahole: Add --btf_feature=decl_tag_kfuncs feature
Date: Mon, 29 Apr 2024 16:45:59 -0600
Message-ID: <6d69d6dce917475ffe9c1bd7bc53358904f60915.1714430735.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714430735.git.dxu@dxuuu.xyz>
References: <cover.1714430735.git.dxu@dxuuu.xyz>
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


