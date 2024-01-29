Return-Path: <bpf+bounces-20532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C1E83FBC2
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 02:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740821F21F68
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 01:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EB4D512;
	Mon, 29 Jan 2024 01:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="OL/HvgVB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iNXaRCkY"
X-Original-To: bpf@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9041EFC0C;
	Mon, 29 Jan 2024 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706491472; cv=none; b=M2+N93mkqyQhdS6hc2Oo9/4jdGcRVpeR1VvaXmCpZv96Qa91++euekJQUFMB8kYZK//NxLhx4W99LcARn0qHqsvlfluic3YeEsmnpkVhVKAFApargMK+nD0zMDnYbsalUWpHPaTwQmvejlBnDvhKOTrbm7pQKNJvvEawpBqFdT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706491472; c=relaxed/simple;
	bh=eZmdvGLDwRn8AEVQgBK3rzf62fvb2RcRdsGD4nCCV1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CM6PznOcQohgjZBALwSzZwAFLojKbQ463Sm5tsKcDzQPGtMYAmvdy5ePGvJy4NTzs5mc8iK90bd5j3jp1MFANmSCUuBz8GlCNHCjXAfn6phhc9x/hqaD3FgATiFXo+m0sQi4zlmLZpCSOIOERh/SPewSYBix5RM58Fy4WRu1DnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=OL/HvgVB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iNXaRCkY; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 187853200ACB;
	Sun, 28 Jan 2024 20:24:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 28 Jan 2024 20:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1706491467; x=
	1706577867; bh=yfhXIxG8TA40O/qvhvNFsNuSdtfXRKkNfeMaQtlqMLY=; b=O
	L/HvgVBr3iXcXrYv2Y+H5eP97MtTu/nia4rkHpYDn8IFbL5vhTQrzs6hT0BdtwFb
	2STdXQ0/FKpBztlmujq0vGFVPbg0KerlR+CwsUYtSUgGJLAZQz1QxTi/Kw7cd4v6
	qHsUl5ZwmJkPM3ApPVsWrlswa7YmOC5mbvsWVBLTFVhgiv6HpoyK9AgYh3MBPw59
	z+Lj6yJdQgcXIBFmAy+3K6jcgfEFUa9fbV2HmNgIYlwsKvKbVGA6ttlhD876M9aT
	BW8WPKzFgo0l5mr+IoFVy9AC/e7XI0p4OepqtxeKl1nozB3BpTMEQWfuR1mS183g
	auCLl5PXRTEyNrkGz7HYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706491467; x=
	1706577867; bh=yfhXIxG8TA40O/qvhvNFsNuSdtfXRKkNfeMaQtlqMLY=; b=i
	NXaRCkYuadNKuJEEhClo6TM1Z2qyxoscpX1EvXu38mam12vyNfcdP6dUfBt159T3
	Y00DwLmE84GoqoXua+wQnSpDw69gUtOsRKqLsn51H8hXJHKl3qwCyzSI1Ki/h7CJ
	2DAAyUVQfVIsPHP9kPze6XTaRs8PNaM0uRPwuIcOOv/X/yncPOV+3BnfCem4abyI
	h4xWXnF+w0MVrW1OKDZQIIZhqlmeMkExYaB5q7QsBSdIbK0MItIYMxVfQtPyNp+c
	UqqPnbI3HNez1t8Pqd7QoxT1Og1b1uRRwZ8bcoMpgLsWAXolGJuk11h1xfbUQ5+V
	4vrecXO5Fl49zWGNZpC8w==
X-ME-Sender: <xms:S_62ZWjGI4skB2NYO4mqkVssXwG7ubQQuVFXB2d_OMgkNRg4RXJ5UQ>
    <xme:S_62ZXAGU8Lnuly0YfjiNjUx3KmzbU01gfw8_HtbyZlv1qru07N8ACOysS39YAzVR
    hI1RsU099hnc-jfaw>
X-ME-Received: <xmr:S_62ZeG1wlulwMgjgzcObCyBCTrvbOJdQMBqornfoxJwTHs4m8vf6hjNzjD2ZWAWh1WHYsg_Tmfdi1vTdRHmZueIc10AG4WW3GGXdR30aDEIVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtfedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:S_62ZfQCnw-5mWuwEi_IwaLwMQuS8G638WFc6wvHulvK1TBmD6iQ7w>
    <xmx:S_62ZTw-jxA3Q-qsTdUp8E-yamx3gzktUn_niHVGYZwbGriwM3IK8g>
    <xmx:S_62Zd4DHqc5nYSpZe0zkqjY_HFVeM93ZPqQtxysyRH5KutCrwDcPQ>
    <xmx:S_62ZTnkksSiSQ8Dplzpaff6ri22vaFGPxfc2isWbgRJq1AviWw00A>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jan 2024 20:24:25 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	memxor@gmail.com
Cc: eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 2/3] bpf: btf: Add BTF_KFUNCS_START/END macro pair
Date: Sun, 28 Jan 2024 18:24:07 -0700
Message-ID: <d536c57c7c2af428686853cc7396b7a44faa53b7.1706491398.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1706491398.git.dxu@dxuuu.xyz>
References: <cover.1706491398.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This macro pair is functionally equivalent to BTF_SET8_START/END, except
with BTF_SET8_KFUNCS flag set in the btf_id_set8 flags field. The next
commit will codemod all kfunc set8s to this new variant such that all
kfuncs are tagged as such in .BTF_ids section.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/btf_ids.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index dca09b7f21dc..0fe4f1cd1918 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -8,6 +8,9 @@ struct btf_id_set {
 	u32 ids[];
 };
 
+/* This flag implies BTF_SET8 holds kfunc(s) */
+#define BTF_SET8_KFUNCS		(1 << 0)
+
 struct btf_id_set8 {
 	u32 cnt;
 	u32 flags;
@@ -204,6 +207,12 @@ asm(							\
 ".popsection;                                 \n");	\
 extern struct btf_id_set8 name;
 
+#define BTF_KFUNCS_START(name)				\
+__BTF_SET8_START(name, local, BTF_SET8_KFUNCS)
+
+#define BTF_KFUNCS_END(name)				\
+BTF_SET8_END(name)
+
 #else
 
 #define BTF_ID_LIST(name) static u32 __maybe_unused name[64];
@@ -218,6 +227,8 @@ extern struct btf_id_set8 name;
 #define BTF_SET_END(name)
 #define BTF_SET8_START(name) static struct btf_id_set8 __maybe_unused name = { 0 };
 #define BTF_SET8_END(name)
+#define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { 0 };
+#define BTF_KFUNCS_END(name)
 
 #endif /* CONFIG_DEBUG_INFO_BTF */
 
-- 
2.42.1


