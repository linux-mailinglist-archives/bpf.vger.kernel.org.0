Return-Path: <bpf+bounces-27710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C9B8B111B
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 19:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268FB1F27B09
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9176F16D30C;
	Wed, 24 Apr 2024 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Hyi2rurW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ww0b3IA3"
X-Original-To: bpf@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E0816D4EA
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980091; cv=none; b=BMc63/Wbv6HH83+KQo7yG4Su7IPRbw0+3NHqkNNDeSkGMhQame7SWfYEVUKabmm0RaQ5KFJxyG/9gyquPlOm0PVJoI08egHJyZiQWX8oBq+4I2ylGLpmMjyIDM1Orld1ZHvL0u9uZeporew3S4Hck3aNew+p/iBfYTBUI5TyWAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980091; c=relaxed/simple;
	bh=OeTzJc/rJm2+zpjTAfpxfGCZx6CcxtheneLb9Vq1XiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFDG4HDq/IfqzoEdYo4avrMSQWwvmcVMpQOdd+28/1yNp52wZJF85jzCNycMgestQf5DsAslTBnuL2Rfq3OqKw6/BerqJ9zlghct5bjPbw4aLJ5bTbHdavG3KQfigh+EB5+Jxi59c35vVC81uNhH2AG8PErf0IXOl5fCW85fT4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Hyi2rurW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ww0b3IA3; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 75D8B13800C1;
	Wed, 24 Apr 2024 13:34:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 24 Apr 2024 13:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1713980088; x=
	1714066488; bh=UHwCOHna8W+SdfFT4lRnd/mxAMoWvjxXDe+jDGUuZY8=; b=H
	yi2rurWXw1qTzGPwag9W2zEBT9DtaxroBFBUTjadCG2q/uXHSdJLEZsPiDDEIO+4
	NAfXqJxOJfCKP/f1FWvt4V9MXluxOaC0i4eXrZzY5H4kvM038vYCQHkrFc5czKuu
	9ZmqJI3SlqnWnkyAXWh5py5yyZpIYbCBRyLWoT/bpOM5p4SJO6PcDgS8Tz6dhHNn
	CzPLN78WiasOjcJLdd4smpz3CaKiZbUE3ZteNwjPkICLDk8o6j72LtC/RHk65CNx
	2uUTNnAlGGGmiG63miQWXYPTABZUpmfnO2lRqs1o5lIb1XX7dH0kKbpv0fEggPTI
	MibhbaJ8QjXWfalRqATsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713980088; x=
	1714066488; bh=UHwCOHna8W+SdfFT4lRnd/mxAMoWvjxXDe+jDGUuZY8=; b=W
	w0b3IA3UR+FCOsICwxaiyia2hMJQcdeLNtd0N8HzCkQLBKY8a6w+PMkfigMsdbV5
	Qug8RkZuGEOs0L9HP8FxpaRcmzmQQ7J2jl7vYjJ/kcnpzG701IgU71SKnoNkLWIC
	wD3QEfSxtlYCZusLT3GIPOcyYpIrne6ZT819yW4rvX6Pmk9B+lo4NLRI+tRU6RaY
	/VqUrseZEOD/ibXx+nkfxUpLVj6kC992DEejiQ3ATcOH2HZ3Dqpz42Xxj5H9L4ai
	IaidgUx6O0htBcrp9/09tfjy9sTX1OSIUl7jKJJ4oHFvAC9bRHDCevNNmn8XEhO8
	U3XveuQAI/NpqSJjzEmaQ==
X-ME-Sender: <xms:uEIpZrK0FQAmkQ0lya40JKXhZvmWbIULnhMaQKmpPQIb4GcX26An2A>
    <xme:uEIpZvL3o8H-IrbT5TV8UjXBZ6JxYFOi-FdalyNO4Y-I-CwNT7xVund1Q7SLoP4g_
    Ce0gbOQOWrLwn6Rpg>
X-ME-Received: <xmr:uEIpZjtWDCqQ9my6EtLRqeHxuuaWpgCsYzxvNpDbsrt1yw1a_hH3g5D0jzF9daHnLve0R26CsgItmO2tZ7ndd3xmRdlPFGeU79pw5-fFWyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelhedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:uEIpZkYlAerBL9jLVyZPyCaXksB_6l-PpRm-W4N-DpA-dipUhoQ5gQ>
    <xmx:uEIpZiaHxfa4yjBgKhZfNaAsPnvJf3u59kaQt7u6RtcIt8Y7oYb_qA>
    <xmx:uEIpZoBLdZU7zs3m54wTXyiCIv_13zqG65a9p7KxGuBZ7OkhsEEAZw>
    <xmx:uEIpZga3YxFTbNgQ5hajwSnPSkpAmmKiNKVayur8gYDRJNcHAJNlog>
    <xmx:uEIpZokjYq1yAnhoHhunfZHVLTWGx1WPbSzMFdZi6sD1ZmvzGCEFicbh>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Apr 2024 13:34:47 -0400 (EDT)
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
Subject: [PATCH dwarves v7 1/2] pahole: Add --btf_feature=decl_tag_kfuncs feature
Date: Wed, 24 Apr 2024 11:33:51 -0600
Message-ID: <2a1e69c33d77b1887f72f9226f40bf484b13cf55.1713980005.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713980005.git.dxu@dxuuu.xyz>
References: <cover.1713980005.git.dxu@dxuuu.xyz>
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
index e1e3529..850e36f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -75,6 +75,7 @@ struct btf_encoder {
 			  verbose,
 			  force,
 			  gen_floats,
+			  tag_kfuncs,
 			  is_rel;
 	uint32_t	  array_index_id;
 	struct {
@@ -1659,6 +1660,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
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


