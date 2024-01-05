Return-Path: <bpf+bounces-19105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A096E824D2F
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 03:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AD61F21946
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 02:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD527BA4D;
	Fri,  5 Jan 2024 02:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="d8GMEAWz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2Djwj+md"
X-Original-To: bpf@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142836134;
	Fri,  5 Jan 2024 02:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id A37173200A90;
	Thu,  4 Jan 2024 21:46:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Jan 2024 21:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1704422767; x=
	1704509167; bh=yfhXIxG8TA40O/qvhvNFsNuSdtfXRKkNfeMaQtlqMLY=; b=d
	8GMEAWzt1FCvG3X19BObWyZ5JVnkQJATxEyCw0CV8wmAI5KLC2/6PCuqgy0PH2ns
	hrZfYi7w9A/XBy87Bd1vBrPDpnMj7NNugAfbloY3v6aRB0XUw/pWUdh7G/ccu9II
	E5sgMGHKNOMLyjGeARKWnyq5OV9sMJ/6jroDHva86VVLLRAE9SK/o/EJFp6ogdNp
	buH+xHAl8wFmIQcB7jVrbKVSFUiIkxmWtRztSATsFVbhMcso9KY6XaNWPhqX/CMj
	ZQ1DGBo5B18ru0sEyCM5o9wc6+8o0lJ2NYtA9wRbP9MwiZo2ahd6aXhGvSLYJuT8
	5WQCcpf222JT0xqA01vow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704422767; x=
	1704509167; bh=yfhXIxG8TA40O/qvhvNFsNuSdtfXRKkNfeMaQtlqMLY=; b=2
	Djwj+md6fzMpiiQdR/8zUvjOY6CMvYVzQGUAqG0XeMc+PBNhr0FQ/LG+6U796srd
	Eoq0r1+BZz5iCO3NqBzOy6W32IJlmb6zofOKTXbQdwOOS4SeWDc6wI2DizRMr9GS
	nPm5ZqJOPPq/lJC3BV536Z3BYImGO6zi8QrwZqF87VPwdUj8N5AmweArsdJoiTUl
	uZihxNHl3g7xJ1fiBt3F5tvwU4oIpMaE+bbG8O6qwtt8qoGT7wXM+qnrxDt0wyou
	s3ibyr5G+3E/5lTQKX7cEAEuV/LisY4LwERwRb4CxaJCQOl2ggKSvnG5VDmBlzll
	n+qmvTLYki7p84rLoEoUw==
X-ME-Sender: <xms:b22XZd5pUdtiKIc9CS7Nl3xS7SuLqx6rLcsB-a4xJUTlJRdGlGwssQ>
    <xme:b22XZa6jZeshhC1qUuFlrXFiop2MM0AtWnqQis14mYx2kdyTUzZJKswHAUz88cdsn
    iitNibUGuZCpJAF7A>
X-ME-Received: <xmr:b22XZUddHUtYDTf-ProTk13qDdiP47k8NwdCZtJMFfz7jJv8rewBFlgGfB_8gkYprHAXysRV4EFfEBZxSQTMvhsig8O202jslr15PuM1v9_nkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegkedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:b22XZWLtpTF0sHegvVoEke_yCIux8bAcA4c4a3MJQT-T-QhCNx2whw>
    <xmx:b22XZRLjh0W2HPPFRSr2Seffw7ps3o5Mnepkf8lFDzx23dkr_asT_g>
    <xmx:b22XZfx2XCIZIauxlUgvzGkfe5DUAf1hcmQoqgnA9zQIA8TrAQDrrA>
    <xmx:b22XZa4S9HczvX-OJ_drKkuWFiuD2Tx4caO_77bk4WVkE2XyJSC4mQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 21:46:05 -0500 (EST)
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
Subject: [PATCH bpf-next v2 2/3] bpf: btf: Add BTF_KFUNCS_START/END macro pair
Date: Thu,  4 Jan 2024 19:45:48 -0700
Message-ID: <4b40c9ebeeed8638150259090b3ce15f5aae6597.1704422454.git.dxu@dxuuu.xyz>
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


