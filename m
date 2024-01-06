Return-Path: <bpf+bounces-19166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA56582610F
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 19:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2861F21D8D
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 18:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF7BDF4A;
	Sat,  6 Jan 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="YeV3Et35";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7PBUg0pB"
X-Original-To: bpf@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4220C8EA;
	Sat,  6 Jan 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 998425C0200;
	Sat,  6 Jan 2024 13:24:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 06 Jan 2024 13:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1704565491; x=
	1704651891; bh=YykKmLIXmxhMLgQ+f77GEqZqd2U6B5FrHdnh5gln6Jo=; b=Y
	eV3Et35OesYXbw0w7RlWp3SriEYbHjidZotJhukH9d9W0AYnQY/YQ5KZk0dT4LOr
	cdMJGI3+7joYiyG/9Nq6eWZB9KHZR+Bi/6rfjLMs6rcl/U5I2GaKWdHGpkj+XxqI
	v0DaslPanzpS/EYI62sy/uqwtX499IFvXQA/KImtms/cn62kuMPHyHuBktEMJWNq
	tyYgt7ZxvJ1FldeFTwfLUcBD2f6FpikfdzdAi0Q/ISBpWxbnNGBioTvISbNuEbO1
	gx+UJi01UFFdDJnXQaEI0pVyE9jXs+vqYYo+k/L1/RO2ZB84ZV0V4+Hj/+JSi103
	l0+r+ZKfY6O1XZqhvzYBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704565491; x=
	1704651891; bh=YykKmLIXmxhMLgQ+f77GEqZqd2U6B5FrHdnh5gln6Jo=; b=7
	PBUg0pBGhefK2MM2HY8PCDppQm8l3AZh4oRTr1IX6zmhAeG2aJlMk1t5RV12r4gX
	yrFDdBSfN0OqrwH67+ZJtxD6y1hBfYxYS364FNGfZE13AMyOOCj9cvNznjkGv3bl
	CE9ns2OlbaxeO2yTiaytfNjpMWmwCmwU+izpYZppN4usd3ZTTwi/4YG00cT0vvnW
	s4Y/Mrv/Pv7Vx/IizVT0maNeIudn03kRbH2nLKyoaNT8KzmpJotOo5fGt+xxTs/6
	iukZpsahTKXdxWZ5ANoqrXhRn/DnvmjVetKV+bGOyFBgfdNNeZvg/imrhmZZIArL
	fkgL2hboMKsPuCjGYhj2A==
X-ME-Sender: <xms:85qZZQMX98pr4UaGX64gjfr2MtHMKSnSUG22aQmfzKhiZGOQFSX0SQ>
    <xme:85qZZW-am4Jbm09J_kNGbbKBelysJsCmptMqfZBq9SArYkgYyVinH1BgctQm2BtCb
    6L5IL1Ase7g4T90DQ>
X-ME-Received: <xmr:85qZZXTTtACdNfnCQlQ6SZiK_TopkouF4VAJWxPn6IgFdJ7TOG4CXunYYrw8D7xZWE_qy2Aw_4vuCGE_541DZFGLxf3ke2pcjjUzEyMlvS_aWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:85qZZYusy44evlMbvZ0UiKJkJ6_NkM5aZzg3p1p6MH6L5kenUZfGDQ>
    <xmx:85qZZYcdJaChwLDfVToPqusHKMJpPzQZhvbLtBuJlZOyDJ-A7VYelA>
    <xmx:85qZZc14r1MgYu_9rEELWMq55MxeMNSGnBxNOP5vVJ-7phclkVrdLQ>
    <xmx:85qZZbuO7oRuXMYVGEQ7OPd5Su25IbPe57-9UWocxcXpnVBwTG2FEA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jan 2024 13:24:49 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	alexei.starovoitov@gmail.com,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	memxor@gmail.com
Cc: song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/3] bpf: btf: Support flags for BTF_SET8 sets
Date: Sat,  6 Jan 2024 11:24:08 -0700
Message-ID: <739b320eb08b15044a1f9e8675d6a22227f6af22.1704565248.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1704565248.git.dxu@dxuuu.xyz>
References: <cover.1704565248.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds support for flags on BTF_SET8s. struct btf_id_set8
already supported 32 bits worth of flags, but was only used for
alignment purposes before.

We now use these bits to encode flags. The first use case is tagging
kfunc sets with a flag so that pahole can recognize which
BTF_ID_FLAGS(func, ..) are actual kfuncs.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/btf_ids.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index a9cb10b0e2e9..dca09b7f21dc 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -21,6 +21,7 @@ struct btf_id_set8 {
 
 #include <linux/compiler.h> /* for __PASTE */
 #include <linux/compiler_attributes.h> /* for __maybe_unused */
+#include <linux/stringify.h>
 
 /*
  * Following macros help to define lists of BTF IDs placed
@@ -183,17 +184,18 @@ extern struct btf_id_set name;
  * .word (1 << 3) | (1 << 1) | (1 << 2)
  *
  */
-#define __BTF_SET8_START(name, scope)			\
+#define __BTF_SET8_START(name, scope, flags)		\
+__BTF_ID_LIST(name, local)				\
 asm(							\
 ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
 "." #scope " __BTF_ID__set8__" #name ";        \n"	\
 "__BTF_ID__set8__" #name ":;                   \n"	\
-".zero 8                                       \n"	\
+".zero 4                                       \n"	\
+".long " __stringify(flags)                   "\n"	\
 ".popsection;                                  \n");
 
 #define BTF_SET8_START(name)				\
-__BTF_ID_LIST(name, local)				\
-__BTF_SET8_START(name, local)
+__BTF_SET8_START(name, local, 0)
 
 #define BTF_SET8_END(name)				\
 asm(							\
-- 
2.42.1


