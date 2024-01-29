Return-Path: <bpf+bounces-20531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0134983FBC1
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 02:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A3EFB22F41
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 01:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D12F9D6;
	Mon, 29 Jan 2024 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="sgd/t7OW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PA/2+nPi"
X-Original-To: bpf@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76262E55F;
	Mon, 29 Jan 2024 01:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706491468; cv=none; b=S05uTPTofPeOWgn+rsh3EGfborZpRNRrhpUsR7YkjVgLqQdPUSVjaDAtrz6joDIjqyjQsbUj+MLBPy96FKEOEgNi8Wl+iwIB0SVznWZkYwc5Rnoqj4X/AotMLl2OoGL5ETvUQaiGpj8QfWt2PoK/iPCpBHF4+QcV0ajTur0iAew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706491468; c=relaxed/simple;
	bh=xu08oOgu2AJms3zybGKx7jyoSa03WTp6V9NSRZ9nLoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRVmH+QLgOYJNkLgWmQn2bg5x9h7H1ddJr4m12m2RVkaPlhEVC+1oBtf8Kv8E4wEbNcsLktoAQ4eYwlfEgMz0C6Rq1peQaxmDlHrRPG/vYrobgUvQCKuCeh5DX23l36yE1fXyXallA7p9WdcfwP/t7N4NIbpQOdDWgt80UQmMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=sgd/t7OW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PA/2+nPi; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id DEC9F3200A9C;
	Sun, 28 Jan 2024 20:24:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 28 Jan 2024 20:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1706491463; x=
	1706577863; bh=YykKmLIXmxhMLgQ+f77GEqZqd2U6B5FrHdnh5gln6Jo=; b=s
	gd/t7OWXBIGfT7HqLSeAH4847bD0qPwzvScZ6CDBqoIz2WVQjx1ArU6nyPmrtGLC
	IFw0TT5in/BIpRBiNUXP95KuXl/5bTpfQyvwOSDnDb2nlb81zXV6VIe5z//rryJh
	puikUYmtEpBsR96MHMcgm75E255n4bloOXEejPaRqusqP2XdANPw2esLU5dkVBAn
	nhmuqsAPRb5Rci1hKPAG5kqX3Aw6HxG4s+RqhFzCa1lk2mQ2mI/UydbC02HKnRUZ
	iEDm1ua/hNFwDgPFR9gaEc9C1YnCjExeGnXKgq78bSbMMLi6xFFJBO7De7ZYztjO
	e4JSUV+lD/fXDPK3JHliA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706491463; x=
	1706577863; bh=YykKmLIXmxhMLgQ+f77GEqZqd2U6B5FrHdnh5gln6Jo=; b=P
	A/2+nPiHDlQVmSm7V1kSuYaAu9EBsXiJHF/XJN+sAzlr7d+9IHiTjYDMDf1Lzqp2
	zgVh6RPFPgfD/j57WJY0ofW4Y2UbcSNbujsePfg6YjGN9+ZRYX+duxwHGUnWFoHR
	IBBtlOs+o83Sxa353AjHU+A4HzcNXF/6zAJryGQAHEOxSux0XyI/z5hkLD8I/8qF
	1R8R/BR8j/Yi7AXeDQQDOfk11K1ZwIsAX7IvIY+bZWGiqny+m5JamJdb//7NnWst
	ednsOVZ8nrvqY0ZyxHbjb5lOMqAZiA0X5nW5wdqkZZ4bAS51MYtUDeVue/zHIJTQ
	SXrZ9SKqKD09NZAbxhUUA==
X-ME-Sender: <xms:Rv62ZeBMrto5TL-UStJ3b2T1orrFQaonJCh27zF6oH5rotdK3uPfYg>
    <xme:Rv62ZYgXvhvJBmexyRX6uWa5KoIW-728YgjMfjufw3dR9CJ2v2Qh3KIqtpBQh0hRH
    SBhsbvS_TGwq7ec5g>
X-ME-Received: <xmr:Rv62ZRmN1DGqeaX0LXEToD1RVXgF7eWFj72KIXAkviPDdHPst1L0YqSJUQu7QEajQEVSSk4qVd3pRbZNKlOs8-k_8HZVrgDbNUVXs2YGyWjoZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtfedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:R_62Zcz1MzQtfdwSBtln-LlC34lP8qc_D9Ko5CH1fDczxURjLOWBoQ>
    <xmx:R_62ZTS0SKVBM3VIq1igWUj3sWVS2Gs-poRDv2fHtWTPPrqEzAK1Ug>
    <xmx:R_62ZXYOsmpZOyMC93OEXeAcVhMmsmNwX_SkZypDB_j_KUn4UNYyJA>
    <xmx:R_62ZRGAe_TCZLoQXPzAC5q_HmsNW2hifudYTZJIXLJTPO8H8pftwg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jan 2024 20:24:21 -0500 (EST)
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
Subject: [PATCH bpf-next v4 1/3] bpf: btf: Support flags for BTF_SET8 sets
Date: Sun, 28 Jan 2024 18:24:06 -0700
Message-ID: <7bb152ec76d6c2c930daec88e995bf18484a5ebb.1706491398.git.dxu@dxuuu.xyz>
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


