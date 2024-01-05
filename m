Return-Path: <bpf+bounces-19104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1894824D2B
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 03:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D6F2871DF
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 02:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28065228;
	Fri,  5 Jan 2024 02:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="EIE6ATEG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kaxu/wsO"
X-Original-To: bpf@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A9253BF;
	Fri,  5 Jan 2024 02:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id D38333200A95;
	Thu,  4 Jan 2024 21:46:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Jan 2024 21:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1704422763; x=
	1704509163; bh=YykKmLIXmxhMLgQ+f77GEqZqd2U6B5FrHdnh5gln6Jo=; b=E
	IE6ATEGmyTBXZrR63xfrAAqeI8pw+kajZc8gzv2+9B2OucizK+i/tyMMieZ8/+3k
	dgV5GFvx1bVhBuajnW6/ZSpzSHes/q6SDhP6LpthpXiW3c+IRUz/fElngp86/0dl
	LSztHp/v5wXFMYI40Si6FslMS78krPjWgR3HzGG6vB0YRgI1eCXy2fFa/yXlTT8L
	NX6ftJeNxZkOMm0/bhwaj2QKGTuAf9XoDhotG5MouSYwqvDYaaLu9iJNCaAsRd2G
	u0VfmuGZJYFxW8FPIu6+KSr8lWYnLPRyUe3tptxRJKnXCWBgSDWesY61PpvmNP/X
	LfMAhaG8nhQQs3CdD5xig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704422763; x=
	1704509163; bh=YykKmLIXmxhMLgQ+f77GEqZqd2U6B5FrHdnh5gln6Jo=; b=K
	axu/wsO//7RwXaakowSQvDQC/RD7jM8bWNvLfsR/wLX7hitfEqM9ivE4LlbRQVCU
	gfQptD/lm8S8onc6UT7qoXqitb/isJwEc8y8dhAiZzZxRNhXFGzr4QiEFWGq8OPr
	otCc7C46BmU9TgX8lIbwIMM+7qElnDc1NawEyQtcWhGjIfN0vm2sDsAjKSLEp/RT
	irfB07iuCUzQNR4dnrJ5OdoaSv/xMdHtugkf+UaqFlOXAuGIcqeM32IoO7FEHJBf
	ruaRmxbLW7A6LwQBUqVpw+5NeJUkzy6xEtk+SOSBn/HfAU3nxRMkWvHpt1rtcNhc
	zqn1bnVTyoFFtNr+r3ROQ==
X-ME-Sender: <xms:a22XZR63QZ8DoQ-c7Xik13auhvLtaCMbZ4K-LPCa5335EgCUrSpgjg>
    <xme:a22XZe4HHvUc6ZItrOjy7W_1_uL1Nf-qgHORByDGEz_U507ofYtOMea5hF5V_UxZh
    rskirjT4-VSGr_CVA>
X-ME-Received: <xmr:a22XZYeMsQPLjVEi3BslrPOsdnrQVZFZt0jWMgNh0IV4jw9gXrKcGbiG9m3EKQVkwwG7anBBFkQxJshazuYIa2vBnkwLJO2PVd02n1XeDSXt4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegkedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:a22XZaKLMfr391ioOI9-SV4p5FFzWVWghXesDaSnISUVJ2SNuiZzlg>
    <xmx:a22XZVLEJ3xYgMOGfJ98iwzwFFVjQzvnjFjhYfBlJ1STWRo65yOlqg>
    <xmx:a22XZTzfzi9sbs6u1t4Rp5Ac2PIph-VGBQimAJZ0kTpG9wTptm0Z_Q>
    <xmx:a22XZe45C_xBEqISRE7kUEODu2glnurGQHPeAVcrrxr0vWkSrjMpBQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 21:46:01 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: martin.lau@linux.dev,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
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
Subject: [PATCH bpf-next v2 1/3] bpf: btf: Support flags for BTF_SET8 sets
Date: Thu,  4 Jan 2024 19:45:47 -0700
Message-ID: <2204908a80467a4ff624fa250fbdb853dd829145.1704422454.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1704422454.git.dxu@dxuuu.xyz>
References: <cover.1704422454.git.dxu@dxuuu.xyz>
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


