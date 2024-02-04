Return-Path: <bpf+bounces-21162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4528A848FF5
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 19:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0174828389C
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED3424A0E;
	Sun,  4 Feb 2024 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="AIoGnLPY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L4uAbhV3"
X-Original-To: bpf@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56B024A1D
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707072055; cv=none; b=n8GnNJB5Yc7lYsr3Wax4tzIj1/9BMzSM+FZ3cRS+c3oOiIyWw1bKHds0LBEiIKUAP6Iam6sdHZ1Nm68wGO6f6+CrAO245STQzOH9S6ISz5sh7T8OeSJCeB6JnkxBwoibHWpJbqqrYIVhPSAOWBe3Ltf1fhltvWuI2abFq/X5mvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707072055; c=relaxed/simple;
	bh=ONOVjC9cN9sNUeGQQwr6hAtR8aPM69rHNS62TMTw+UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIgBgoGVFzi4QqH5gIHTm2oP9o6n010kRY8vYEQxFJnQGb6zEMEXh9EQRQDAhU+5596iWb7LK85h2/czBH+O48dQ30NL1Wt4HsGpxR8yANubpAB7M/cAxQHLnv0XMXQDzOyOZzzDtLrjGzdnSmlEGBIG3IL6VLe3Mwntm7iDi00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=AIoGnLPY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L4uAbhV3; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 5B4FF3200A91;
	Sun,  4 Feb 2024 13:40:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 04 Feb 2024 13:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707072051; x=
	1707158451; bh=oGDV/J5YdWU46SY8eL2NAYWV7DFLszhU9c+vVYuPyKo=; b=A
	IoGnLPYCO/6z2xCceeqvWGEk/keenBuiO91yv2R8BSRux36kxEN5vWkrqrgBjXwC
	uwv05mwVpRfUNWkJb4Z73Vit1xoQ6+ijpHxhiVkQV4+4OS5PbdgMbAJjDrmTPXLc
	6oNNJPUEu2nBTyOtP3pdi+rP4oQ4fsQkxwCmh31Cbm06h2+KYfHoAweJTB9rK+3x
	XOblRclpzKzp2okTQDyj5Y+nccbMgut2BevyzWGitefVfpZ/YtUYiHBdpuMbOXsC
	mRe9Gx80XYULiAWrPs2fMtxgf6Xi7eKbOZUTUrDdW3X271btmh+zkyN5dDs3f9XO
	swaZRb+q++zIUW+VN65EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707072051; x=
	1707158451; bh=oGDV/J5YdWU46SY8eL2NAYWV7DFLszhU9c+vVYuPyKo=; b=L
	4uAbhV3q4HqK+9cVT6Tzs0Xw0Cmq5SZpItMRKOwW9pBFRjMd4ICbkJo3embVnkmD
	OJRfD+vJuDuPQGXh/OJ1LPQBM6fbIQrC/lCrfNCEZ+D3tQpmN4FHnx7qS4EF4zSv
	RyMNL85qM/PyMZPUwqivHP1auqxuQp5GfXJRlaT0/DKNJ2TAxoj9CdnZC/LJii9U
	00yE0GdB9Rx7nHoAwaGotL+OYcJhW+ph+hUu4AJSKI76hgc7/ugLFGndvKmgS+ck
	sV8HP4Vi/PSrozBOa+YJOQvQPACMNXK1m2NKifiOillF6bXnGXdbfqldyVHyKNvE
	7y27OehLDYcRIWmi2PqBw==
X-ME-Sender: <xms:M9q_ZYhnXBjgeB0sJGixrP6jYGrpPiSu4m9_QmhI3PrtamdThIAB0Q>
    <xme:M9q_ZRBhsg1i4JhJTcBcttwGNYSoCT0_az--MiNE8yVv4tE6wOXsib_ulRL6lU52c
    TnDSsAKQeAHWzjrlQ>
X-ME-Received: <xmr:M9q_ZQEMSGqJqMTgEj-QtVSv75zHaOew8FvMV3-wUXdW22l1BvWGqO7z3myNKFXcJAYsDYdvos_wvuR7kXDfdr1gBdFp4utjyHlUKcKLioQ7YA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedukedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:M9q_ZZRuRS_MbPttQqeGL4gIIS4hGEnmrgvqdhLgg6XGUs6dhnsT2g>
    <xmx:M9q_ZVzRnAbKzzTgDynszrFZ51yGHViaFwOM6B1F12bsLAJ80_ecUg>
    <xmx:M9q_ZX5olP78gOCWEYh3TacbViWM8ez4klWqShY0YiO5zxXuZbHvYQ>
    <xmx:M9q_Zcm-Un2ctfAaVSo1mWGA3g_FhvZDGyE2fmCcwL9eWNWualuvMA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Feb 2024 13:40:50 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: acme@kernel.org,
	jolsa@kernel.org,
	quentin@isovalent.com,
	alan.maguire@oracle.com
Cc: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH dwarves v4 1/2] pahole: Add --btf_feature=decl_tag_kfuncs feature
Date: Sun,  4 Feb 2024 11:40:37 -0700
Message-ID: <bd8f705a5c11b14571563a63045416233f9d06f1.1707071969.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1707071969.git.dxu@dxuuu.xyz>
References: <cover.1707071969.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a feature flag to guard tagging of kfuncs. The next commit will
implement the actual tagging.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 btf_encoder.c | 2 ++
 dwarves.h     | 1 +
 pahole.c      | 1 +
 3 files changed, 4 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index fd04008..e325f66 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -77,6 +77,7 @@ struct btf_encoder {
 			  verbose,
 			  force,
 			  gen_floats,
+			  tag_kfuncs,
 			  is_rel;
 	uint32_t	  array_index_id;
 	struct {
@@ -1642,6 +1643,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->force		 = conf_load->btf_encode_force;
 		encoder->gen_floats	 = conf_load->btf_gen_floats;
 		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
+		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
diff --git a/dwarves.h b/dwarves.h
index 857b37c..996eb70 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -87,6 +87,7 @@ struct conf_load {
 	bool			skip_encoding_btf_vars;
 	bool			btf_gen_floats;
 	bool			btf_encode_force;
+	bool			btf_decl_tag_kfuncs;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/pahole.c b/pahole.c
index 768a2fe..48c19b7 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1278,6 +1278,7 @@ struct btf_feature {
 	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
 	BTF_FEATURE(optimized_func, btf_gen_optimized, false),
 	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
+	BTF_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
-- 
2.42.1


