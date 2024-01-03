Return-Path: <bpf+bounces-18965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 591B4823936
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 00:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DAB283F97
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 23:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3900D200DB;
	Wed,  3 Jan 2024 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="l+slDank";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Die2gcWQ"
X-Original-To: bpf@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B8200BD;
	Wed,  3 Jan 2024 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id D9E903200A0C;
	Wed,  3 Jan 2024 18:32:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 03 Jan 2024 18:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1704324733; x=
	1704411133; bh=i0jWCLIezpev9R+cDRwirQ8/iwCGPwmflSvPoBzieNo=; b=l
	+slDankOsknDwjTs4ZjNniNwpGQB7FN37BL73TBSudXF8QIiYJwvXd4k1hmznStP
	RoXAwFM7tYYYRNeLLIhS5+OBCT/S6mMkRIl6nDldSrn+E/Qq6NEsGbk+AAzradmq
	5iux/6PgupCScZULex5/CUH3a+3gewgp4SvB72nKC2gUsGQYWEXCD2R8t4+w5g3S
	jF/JMZKnThiXfI4VItb9Nzb9kziKIMAVVmu1EpBXdB3d5XiEXjd56l8crJtkwltO
	05P6km6h2PrYM8YKW4CbS80hvKHeHr/9empTiQr+5xpCGPBoIYAScnjr6AQhux2G
	S4iw4mFV2Bm2KmsQ4DtOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704324733; x=
	1704411133; bh=i0jWCLIezpev9R+cDRwirQ8/iwCGPwmflSvPoBzieNo=; b=D
	ie2gcWQDDYLw7t/kG/AhIFmM8EotrufLzeIefRYJfL21ikSo5A5Nt5hsBU1KuyFX
	WOw/3gDoxde/TDkzKKwwHniLk/xOa09BSsCXbUrvhG6U/xsLPYBtgxpWFGEYnFN4
	kEAac6RSD9S+KhHxfX9aIunUwk5QmtUacZ+6sl1Dj78UDwmwgk1ZRVW6f5+fy7oj
	mh2a0LMcwUSmdf4mhDGhab3vX2eqpmpxdAxNIoHZAOAfLAS/gddpTuKZ6EHpG5+I
	Xhs0Pt2zmJv964QUWwdqM+iZpmFYKI9BL/Mlm4MqQLtIxEAC7iOs1qiunt34JLmd
	hfp+0audtJ5FLKNujJKSA==
X-ME-Sender: <xms:fe6VZdsfmDXawjhr8b-zoJYFMST7do1cBXOhwEvXr3DWLkz15CpPjw>
    <xme:fe6VZWduPg7107HB_tLfm3pQEmZskesYibV0fPpLoyxVRybzLC2XYq4FlOhlIZDhP
    NNRfTP2GhPwi_hP-Q>
X-ME-Received: <xmr:fe6VZQzkGTifSCHGWC-v99H6fRHzf3JoUfZGxumV5nrXSKxqGgUlBtsCSeyhLAeAO2rD5BZTAub5rSzEphD9Ef8t_aQeAgXVMzkHjGml607aLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegiedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:fe6VZUNN3A1HYPKYy7xYE-cYxGSyilMueJXsRnmpKZfIZH3IJC5_pg>
    <xmx:fe6VZd_bPmT6HHajaPISRc9Kebq2ZFYyWAQ2pdt5R77yOSN3yDfKQA>
    <xmx:fe6VZUWUyLyaz17eAA3Qe4_JQwHoU7Arcr4fchO2JWGg5rkm4edIkA>
    <xmx:fe6VZVMwlust9SLlLk5cIIEEjgj81d9SG-bUfCSp4Gvhr4RTXjRnhw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 18:32:11 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: martin.lau@linux.dev,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
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
Subject: [PATCH bpf-next 1/2] bpf: btf: Support optional flags for BTF_SET8 sets
Date: Wed,  3 Jan 2024 16:31:55 -0700
Message-ID: <29644dc7906c7c0e6843d8acf92c3e29089845d0.1704324602.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1704324602.git.dxu@dxuuu.xyz>
References: <cover.1704324602.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds support for optional flags on BTF_SET8s.
struct btf_id_set8 already supported 32 bits worth of flags, but was
only used for alignment purposes before.

We now use these bits to encode flags. The next commit will tag all
kfunc sets with a flag so that pahole can recognize which
BTF_ID_FLAGS(func, ..) are actual kfuncs.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/btf_ids.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index a9cb10b0e2e9..88f914579fa1 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -183,17 +183,21 @@ extern struct btf_id_set name;
  * .word (1 << 3) | (1 << 1) | (1 << 2)
  *
  */
-#define __BTF_SET8_START(name, scope)			\
+#define ___BTF_SET8_START(name, scope, flags)		\
 asm(							\
 ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
 "." #scope " __BTF_ID__set8__" #name ";        \n"	\
 "__BTF_ID__set8__" #name ":;                   \n"	\
-".zero 8                                       \n"	\
+".zero 4                                       \n"	\
+".long " #flags                               "\n"	\
 ".popsection;                                  \n");
 
-#define BTF_SET8_START(name)				\
+#define __BTF_SET8_START(name, scope, flags, ...)	\
+___BTF_SET8_START(name, scope, flags)
+
+#define BTF_SET8_START(name, ...)			\
 __BTF_ID_LIST(name, local)				\
-__BTF_SET8_START(name, local)
+__BTF_SET8_START(name, local, ##__VA_ARGS__, 0)
 
 #define BTF_SET8_END(name)				\
 asm(							\
@@ -214,7 +218,7 @@ extern struct btf_id_set8 name;
 #define BTF_SET_START(name) static struct btf_id_set __maybe_unused name = { 0 };
 #define BTF_SET_START_GLOBAL(name) static struct btf_id_set __maybe_unused name = { 0 };
 #define BTF_SET_END(name)
-#define BTF_SET8_START(name) static struct btf_id_set8 __maybe_unused name = { 0 };
+#define BTF_SET8_START(name, ...) static struct btf_id_set8 __maybe_unused name = { 0 };
 #define BTF_SET8_END(name)
 
 #endif /* CONFIG_DEBUG_INFO_BTF */
-- 
2.42.1


