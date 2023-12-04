Return-Path: <bpf+bounces-16632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 000DA80407C
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 21:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726B91F212C9
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 20:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6F935F10;
	Mon,  4 Dec 2023 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="r4oVnJbK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0epMzhcX"
X-Original-To: bpf@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B965C109;
	Mon,  4 Dec 2023 12:56:55 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id DB9615C022F;
	Mon,  4 Dec 2023 15:56:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 04 Dec 2023 15:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1701723414; x=
	1701809814; bh=ODyk+ttANQamRuubWNRCDO8I/D2JxBDiCAh0nttU7d0=; b=r
	4oVnJbKuvQFHQYEX8R56ZVtXrlkgzIKKVAXWi8AlDWZHZKFL8p/mnFE5y5wV+eK+
	9lOOSI2esM4aFE0BbGS+7tnSOFL+m4vzr8yDkEMwTSD2pPfCEVIpYPlT9ziUuffn
	AHS8Ww/tjVQFKDK7/+WCPd9NT/sVUjbECVwj6yFz5F7+DDNVHBK0ozgNQ1b8UXD7
	HfqcPnc7d0/60iP1zeAHUz15pZSzCg0qDt6ChLSwMzsWqsWLQbafj5MZi/4d+U9M
	QRPeT4rc6NUiahJWVStSkybkfJTxRFH8iu27phHt1pKSxOr3z9YqslbyUFFZ2jjT
	Fprwp2xUClTWgZg2SqHvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701723414; x=
	1701809814; bh=ODyk+ttANQamRuubWNRCDO8I/D2JxBDiCAh0nttU7d0=; b=0
	epMzhcXlEAJh9hIhfZQNfzrbBwP6o7+vnL+hC48PCUaQtGZI2fOrXx/8caIwa5wq
	htQ/sixbVUcrurbCJzWkg9TxH7N/3+9CQ0eK3LIDRTlO4CdjM9kQDTzzNgULXWwx
	M/DiIVflIr3aKq2z8cQzheaYTDb9wVzOKr9qWw5VdbGItrnQnekMKpMbOqOUtpk5
	ueNwd33L0Fwj40BKvK6X5TT2/uw07ldQO2fs86DAt9mavAqB0CAeoPPnGcQUPGTe
	5vL4nb14Kp7jOvdr0dcwiIRMxmjO4u0asiV0FyIxCAGO0Z5rfl91H/fXU9U3Ie38
	VZSe4IM+U6iZECSED1QdQ==
X-ME-Sender: <xms:FT1uZRmFk5B_-6blBuW9JcVdLIq8XmRLcw6V3Rg2lPrzTNax_Ai9pQ>
    <xme:FT1uZc09ZsFU5GUVqW6mK_orRNU-BMv1_lqXpIHHg3Gpw6Vm81hGadGz8ZwZmAy9T
    1FMndxdltTBJ6oGkw>
X-ME-Received: <xmr:FT1uZXrWauoh36rU3tamwMHV3YT5QYEvTbjh4NnMa0JW4ftpPhB3iPXNCfQXOSl4MaWYlB1b3INAIXdBXnT2RlHBfwW6cjsRl_ctKfZLCtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleej
    jeekgfffgefhtddtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:FT1uZRlaipXpxgAYy4sxV6iFgFIHubndPMFFGkWzeLuRME2ENniPWw>
    <xmx:FT1uZf2WKvIicPL7J-isFRQDLKO8Cq3lOhitUBfSlf3cLqVUFx0-4g>
    <xmx:FT1uZQs07Hc5LWSsvbjf6US2JhIpxBTz-1igiXT7CG3vdNpEOiyWiw>
    <xmx:Fj1uZdMTZfylQc_6n1nOzXW922s0XkyGWdO3fEjktn8chQ9z3j_lPg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 15:56:52 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: davem@davemloft.net,
	Herbert Xu <herbert@gondor.apana.org.au>,
	steffen.klassert@secunet.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [PATCH bpf-next v4 01/10] xfrm: bpf: Move xfrm_interface_bpf.c to xfrm_bpf.c
Date: Mon,  4 Dec 2023 13:56:21 -0700
Message-ID: <a385991bb4f36133e15d6eacb72ed22a3c02da16.1701722991.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701722991.git.dxu@dxuuu.xyz>
References: <cover.1701722991.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit moves the contents of xfrm_interface_bpf.c into a new file,
xfrm_bpf.c This is in preparation for adding more xfrm kfuncs. We'd like
to keep all the bpf integrations in a single file.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 net/xfrm/Makefile                             |  7 +------
 net/xfrm/{xfrm_interface_bpf.c => xfrm_bpf.c} | 12 ++++++++----
 2 files changed, 9 insertions(+), 10 deletions(-)
 rename net/xfrm/{xfrm_interface_bpf.c => xfrm_bpf.c} (88%)

diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
index cd47f88921f5..29fff452280d 100644
--- a/net/xfrm/Makefile
+++ b/net/xfrm/Makefile
@@ -5,12 +5,6 @@
 
 xfrm_interface-$(CONFIG_XFRM_INTERFACE) += xfrm_interface_core.o
 
-ifeq ($(CONFIG_XFRM_INTERFACE),m)
-xfrm_interface-$(CONFIG_DEBUG_INFO_BTF_MODULES) += xfrm_interface_bpf.o
-else ifeq ($(CONFIG_XFRM_INTERFACE),y)
-xfrm_interface-$(CONFIG_DEBUG_INFO_BTF) += xfrm_interface_bpf.o
-endif
-
 obj-$(CONFIG_XFRM) := xfrm_policy.o xfrm_state.o xfrm_hash.o \
 		      xfrm_input.o xfrm_output.o \
 		      xfrm_sysctl.o xfrm_replay.o xfrm_device.o
@@ -21,3 +15,4 @@ obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
 obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
 obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
 obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
+obj-$(CONFIG_DEBUG_INFO_BTF) += xfrm_bpf.o
diff --git a/net/xfrm/xfrm_interface_bpf.c b/net/xfrm/xfrm_bpf.c
similarity index 88%
rename from net/xfrm/xfrm_interface_bpf.c
rename to net/xfrm/xfrm_bpf.c
index 7d5e920141e9..3d3018b87f96 100644
--- a/net/xfrm/xfrm_interface_bpf.c
+++ b/net/xfrm/xfrm_bpf.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Unstable XFRM Helpers for TC-BPF hook
+/* Unstable XFRM BPF helpers.
  *
- * These are called from SCHED_CLS BPF programs. Note that it is
- * allowed to break compatibility for these functions since the interface they
- * are exposed through to BPF programs is explicitly unstable.
+ * Note that it is allowed to break compatibility for these functions since the
+ * interface they are exposed through to BPF programs is explicitly unstable.
  */
 
 #include <linux/bpf.h>
@@ -12,6 +11,9 @@
 #include <net/dst_metadata.h>
 #include <net/xfrm.h>
 
+#if IS_BUILTIN(CONFIG_XFRM_INTERFACE) || \
+    (IS_MODULE(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
+
 /* bpf_xfrm_info - XFRM metadata information
  *
  * Members:
@@ -108,3 +110,5 @@ int __init register_xfrm_interface_bpf(void)
 	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
 					 &xfrm_interface_kfunc_set);
 }
+
+#endif /* xfrm interface */
-- 
2.42.1


