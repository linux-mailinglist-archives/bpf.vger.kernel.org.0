Return-Path: <bpf+bounces-19167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC46826111
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 19:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7838A1C20FC8
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 18:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF764F9F6;
	Sat,  6 Jan 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="PMr0g2QQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YEHFRnLf"
X-Original-To: bpf@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0B0F4E9;
	Sat,  6 Jan 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 2BA315C01F1;
	Sat,  6 Jan 2024 13:24:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 06 Jan 2024 13:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1704565493; x=
	1704651893; bh=yfhXIxG8TA40O/qvhvNFsNuSdtfXRKkNfeMaQtlqMLY=; b=P
	Mr0g2QQnTCnVlanyOnSiUaRQhqoq6LF0h/nlKzKMF3TlVYQoU2knajCdNcDJGHWV
	pUecyRf+x229sY0qW1KKGi1pTfH2kdLO0GL9HeG+pwZHr4lWc9vxsjYj/kT+NmHr
	PmFfCLIE017pkXJwiazCNZ7rpQUiBx9KV/tXNAtLedK8982qW4WqMjZezkRN1daA
	6vNenza2eckuHgaPPK71fNWLEVcFDM+JA5LiHefwhtz1q7ixo8Bh7FoUYFfbHYI6
	bSmsDfPfCgog55JV5ETAbREmeP63ZNk83c6dUWKKI0JrHS8bHfGtDraUNpCnlHUY
	L8InWceaUzgFCacYpndJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704565493; x=
	1704651893; bh=yfhXIxG8TA40O/qvhvNFsNuSdtfXRKkNfeMaQtlqMLY=; b=Y
	EHFRnLf7H8WMQgUhXkR5cQGJVlbRTDusYtAPSTEb3ZDbHHwR6gJIiUA8XOVlBnlN
	REj6EjfQ3t7jk6oBBzNN26aFFcb+TN8Y9bFVa9ajl+2jGIZJ8rxK5K1jeVVYJvTL
	Rqjuiy5E60Eg74WN5Nd5MzIIeyhuKeIANxjnIP2xi7i58jz/hUbNx2JBB1AtNxJ2
	LGKmoJ+Ll3bi0eBtXHMB0PwFcO0oeX82aQHCF305I6SQbnuTLWJcm0WDaQNDTK2M
	UJCog9funGnkKdWTSQ/RYpvOXt8OMZ4qOZmpxjWDwMruAnGSFkWPEOLwlbS8jfbc
	SpMl0vFWhtSyuSxsHbiBA==
X-ME-Sender: <xms:9JqZZSEdNaGhrv-QxJrORc2WhdRXOIbDSpAU4P7YuWFvCGaN7HiIhg>
    <xme:9JqZZTUpKxzUptHTOkv3eCnUD8TkctKrlWL2E04OWAz04XmKWfGvI_kKOfC61gmxc
    fa1XkN8rf5fxk9bHQ>
X-ME-Received: <xmr:9JqZZcKBoq8UDdLEFtGjZRboPuf816gmivAYjjs8WyVmOfTIUVw7I9N8OYaQeWEAalJvJK9Za5Cttgo8T7KXl6t_KM0ztv4WutNYKTuNrtG8JA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:9JqZZcH3gOhrr-AQy2Iv8smQIb16qyDrOfhz8X5ZrAl7iRISRMTyEQ>
    <xmx:9JqZZYWnsN23jBCjCEkXAdFrEIuejuAbDoM76DLbvl3_TRQqT4hX6g>
    <xmx:9JqZZfNtO2AWPFeuqmTzU8RFtfuc3y2gveJieUDAXSWFviHOTtUKYA>
    <xmx:9ZqZZUkYQcXkagRgtRjKW8B43Ys0vQLAWQIb3ExR4LgudEHa0hGZnw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jan 2024 13:24:51 -0500 (EST)
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
Subject: [PATCH bpf-next v3 2/3] bpf: btf: Add BTF_KFUNCS_START/END macro pair
Date: Sat,  6 Jan 2024 11:24:09 -0700
Message-ID: <ae0a144d9ade8bf096317cc86367ed1f5468af25.1704565248.git.dxu@dxuuu.xyz>
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


