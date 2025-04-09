Return-Path: <bpf+bounces-55497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD74A81B81
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 05:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7478A4A67E8
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 03:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3F084A3E;
	Wed,  9 Apr 2025 03:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="kfqzsDZs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qer5rAQL"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0F1C8FB5;
	Wed,  9 Apr 2025 03:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169684; cv=none; b=Er5rw0QsIm+hskrhOlfezL6CZLC0hTWAbk0t2jueGBBxfYQDftI5vuok+/2UYGjg0YH/8ScPPkh0EfOZsA6EbNx2haH77ai+tNGZXTvFbeLWssHTnfCMCzMWHKrEhVgt+6+PhePQJP3ubajphrk0tGihCLpbQWaOH8nFCvzWaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169684; c=relaxed/simple;
	bh=WwB/iLj+kr+uR4r3HljA27uS98rQcwljoakqTDQY3QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joY1VLrtRObPU/wAL1OjtyMzDf4eN9Xih0u5AtII3kBKVxs8Miw+bDFRtWUuLT/spK5+GWJq2xlFD5XZ5iRErG/wLXKzKKD1V/aHx5+FU18/agUN6B5snmt3uHNMzBnWs+ZmIgvBlC2qxh8Ey4tnGiYDraEZWKYXPZ7ZgvoL4NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=kfqzsDZs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qer5rAQL; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 102CB1140252;
	Tue,  8 Apr 2025 23:34:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 08 Apr 2025 23:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1744169682; x=
	1744256082; bh=2PzkHPaQng3j4OQOLko7zULD6UngdArPhuztPcHfJP0=; b=k
	fqzsDZsKIyr6TLxTmQHKMcqFskvC/rv1W3PVYYwjAQe+inFhezSAfnZ8vydOlqxH
	KGPOePD+By4SHRR2J8l/uSjwJmRG5bm/QSQI1/xsXBnEgDRmfeqv4Mxty2gFWBLc
	ZYmG+DrokwY2GEkZmcdLw8yCGFkcL5qnWjU9nV87jfgS+HhAAxhEXaIqJcvq2EcH
	O0AwdYB+xHP+uYLpEXDq2dRd3US4zquSfacFFqX93pYa30j5I/5SVAnA1MLscXWw
	sKQa2z5QpvNmvIWb+qE8q2IDjz/STxSR5c9iCbXHWsbtiw/p1jvId+11X/9eiolI
	DBWrupm4he+ZxCvogTLjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744169682; x=1744256082; bh=2
	PzkHPaQng3j4OQOLko7zULD6UngdArPhuztPcHfJP0=; b=Qer5rAQLrg4GVv9hY
	UOryhemJ+pAsPGWNpq6ur3hRiKmpfCrXPIM1clcCj0XC8yKEXj47uld8RN9E1ws3
	xM9+ObFGvCl3g+K1SU4CuDNdqZgIz7C9DQOJybL5nHw7FFPSW7+rwSZviYKVPS8a
	5Ltdxh7x2pe/xnzsGO4OF/ki23/KQ3BfI6iPNAYEsA9CMOatmO+/muK4xMvj52Q2
	xlZACcWF36UG5nuxr33LhQxJj1rCDGWv9yY7cAhwBuR+84qvXAANGgsXkBcAt8Av
	fiUYtGsYPwLsWd58zCUsxbfdGGLSk//V0WXY3BhZ7npXGhwA+htrK9a9D/6oM9pB
	MpcEA==
X-ME-Sender: <xms:0er1Z7QDsbbnosZTODv0e4Hnd1OEvQafYX8XH3ObquyWueC_GTN5Aw>
    <xme:0er1Z8xnmJx7LHTRx9KaMaDf260ZxdHVG4h7z5caYlIZinWYsb2v_IRpyYMq5g6ef
    FYHAnmTEPHsNatBXA>
X-ME-Received: <xmr:0er1Zw3SlSno0BEW1bYx66NPvxeSCoTW8IFNKdJmj6XCLddLeSw3eayHuzHteT4N99kMv7DpS9WrVKa4L_LdEtlVmEi7Pbl4m63rtCeYAFIlgABKB8bf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffuc
    dljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhm
    peffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvg
    hrnhepgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguh
    esugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgs
    ohigrdhnvghtpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghp
    thhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhu
    gidruggvvhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0er1Z7CJYX5_-cRmB8r4-DaAuPv4Kwn2WV1fV7Jk42Oa2Iern6YhXA>
    <xmx:0er1Z0iEvzu4RotEbXmi42lM2pm-GzS18LWmJC7_nRs0sP7jvwJpHA>
    <xmx:0er1Z_qeqmR9kxdVBpOLJP47WM_VimtIIjqLN4E8uLs3NRvuv9clOw>
    <xmx:0er1Z_jdj_Twr7qlDH4IZucb2PF5BC-G7gop_2-xLglgADddzQihfw>
    <xmx:0ur1Z6tQTlN_UjDdS92k3rteJvty1n9t5lFUftBP4VYedFAklGLalw1a>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 23:34:40 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC bpf-next 03/13] bpf: Move percpu memory allocator definition into core
Date: Tue,  8 Apr 2025 21:33:58 -0600
Message-ID: <20016bd97ab4aa47c4c49f9e46bf6ac0b4c4a124.1744169424.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1744169424.git.dxu@dxuuu.xyz>
References: <cover.1744169424.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF percpu memory allocator is used from multiple places. So move it
into the core and have verifier.c simply consume it.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/bpf.h   | 2 +-
 kernel/bpf/core.c     | 6 ++++++
 kernel/bpf/verifier.c | 3 ---
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f1c5356dc099..8e26141f3e7e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -64,7 +64,7 @@ extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
 extern struct kobject *btf_kobj;
 extern struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
-extern bool bpf_global_ma_set;
+extern bool bpf_global_ma_set, bpf_global_percpu_ma_set;
 
 typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
 typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ba6b6118cf50..80ba83cb6350 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -68,6 +68,12 @@
 struct bpf_mem_alloc bpf_global_ma;
 bool bpf_global_ma_set;
 
+struct bpf_mem_alloc bpf_global_percpu_ma;
+EXPORT_SYMBOL_GPL(bpf_global_percpu_ma);
+
+bool bpf_global_percpu_ma_set;
+EXPORT_SYMBOL_GPL(bpf_global_percpu_ma_set);
+
 /* No hurry in this branch
  *
  * Exported for the bpf jit load helper.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6ed302dab08b..322c1674b626 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -44,9 +44,6 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
 #undef BPF_LINK_TYPE
 };
 
-struct bpf_mem_alloc bpf_global_percpu_ma;
-static bool bpf_global_percpu_ma_set;
-
 /* bpf_check() is a static code analyzer that walks eBPF program
  * instruction by instruction and updates register/stack state.
  * All paths of conditional branches are analyzed until 'bpf_exit' insn.
-- 
2.47.1


