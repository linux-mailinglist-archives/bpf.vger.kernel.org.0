Return-Path: <bpf+bounces-55495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DF8A81B80
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 05:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B816C7B61CD
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 03:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681B91C5D7D;
	Wed,  9 Apr 2025 03:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="OssQNtC8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D8zA4v0j"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF9B84A3E;
	Wed,  9 Apr 2025 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169680; cv=none; b=lFz/6aUtCk8ZbiPsmfXieBvDPnc7s15ZEnCv/BciSAOLhCuvgfZzHGETm6yYmvPvZqPAVy3LlUWbsRer9/QWPGhfbah9gvGj/v6ZsPmkJbwbIYaGx4S94BtQz/F1cDnYpZhwbOmoT6dbsEhzr/DmN2ruCOYlbqFhy+pyugf0gmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169680; c=relaxed/simple;
	bh=4TX1Gm2KMzuVI9BFHu78MaAH9o4SLUiECfLlAoBMoJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qkl8jp45KcmKv7W7LhMqUxnL0hiRKblpLVqtVICTZao5AS5hiQTPyh8gaogxNI5WA6doAHPX+aewNadof6qLgMLLg5CqVAPcq/kDOl2d3IIqrFYmkveBaElIheabNWKw+ajPgJdIG6bu+KkMAt83PB1tit5mpts6RqhiUOt2TnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=OssQNtC8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D8zA4v0j; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A46AC11401AD;
	Tue,  8 Apr 2025 23:34:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 08 Apr 2025 23:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1744169677; x=
	1744256077; bh=z4h/zfcRJIGxDV1TqbTR2lnwjK3qEaoTFOcSOKpDBY4=; b=O
	ssQNtC82y5PzSh7NKQ9Pc+9v2HVa5oQr7n+yNvUThBV5VS3M9B8drw/FDWBA2gj8
	GQm3TlZU0kUu3SUXlUBm6NmOGNVvxZ2xQCaJn3ynq5xzPxstBClaYTXyz5of7VP6
	+ZILQojFSJfrl0qCZ3POO3lYPLw9NeePs/M/wQsxbypbKIEHsnOixeotvxwnUv4y
	MyWbDPtLikj2j6dFv3/VShAmIiULF+0BrS15WInFYnYAMCA/qtWsH3+v74LT72D9
	UHCHxk4fV4KCU2kDQ2Ue1+sCZT3N4lq1tp4FPPgCJEYCtR+3GZ6nOHPF4sJqmcJY
	CxZ4dh7KdKbcsOBR37gkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744169677; x=1744256077; bh=z
	4h/zfcRJIGxDV1TqbTR2lnwjK3qEaoTFOcSOKpDBY4=; b=D8zA4v0jcvqaKdj4g
	/ceyIstwHniBlhbsuI7t+ELstio25QW9jn3vF3HRpTxzEAdrg3XABDBfcTxLS+fY
	Lfx9hZ6Yt3biIYrZXSQNwRK/gsTwzvE0DWkk8LVRP/qG/FAGfPD6pCg/f2v37qkg
	bjEvDrwrN6jYLRwPLCOjyHxdsTl3qSStOz5Oz3D5i6aednEufZO1Jc34OJArsE5p
	v1BFC4tUBNbGHohaNganGtsugCEAXX1ZgA8zrli8S+QPWWgDBnIOOiWAlf7UPhe2
	8GKiK8rdUpkrJtQrxB59vHR1YAKLCMlw2rSm42FgIx0pwXHuS/xhJrVB3Yx2UERR
	/Sn8g==
X-ME-Sender: <xms:zOr1Z4hq91HOcor3k-rjNf9wBVDCRXrFBV3Go3QbqfsAl79KuU7hew>
    <xme:zOr1ZxCoZJ1huGi72KPvSeWzRErQRiRnsda-O2QJukVYwRJCT5YxyvN5uBkt-IhzU
    V8v2W5gxJLQnZ2JxA>
X-ME-Received: <xmr:zOr1ZwFH-jhjVXGxHSAPwYNFUGCbJF7R-1SRmb_f2jasrLLXwgKY8-dVdSUkBR0jX9NGR9fH3yWGsinm8R3PvQT7Q8LPiCrPmb4wAR9-0KufcUrI79qb>
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
X-ME-Proxy: <xmx:zer1Z5SNKrZzqYKICeRBbtbLj-YYgh9AochdcKsNMBH0siGivegwsA>
    <xmx:zer1Z1wEBeRRAO4JpyowIYRPSVOmyYUgZPH10_6ssd02ZwJ-JBanUw>
    <xmx:zer1Z34fxOU8XbC-j4tfEL2FShSa5hg4fu2ZR_imdqxOf90XW5Mjzg>
    <xmx:zer1ZywuksdOg_jHnIBamQiN6sB3hfavaUDiH4Iz0CLg2aQ3A0J_2A>
    <xmx:zer1Z99Iv55fHqlSw5BLpvFN5lYEqhswA6RoChizxVZj7p91PqTySkFS>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 23:34:35 -0400 (EDT)
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
Subject: [RFC bpf-next 01/13] bpf: Move bpf_prog_ctx_arg_info_init() body into header
Date: Tue,  8 Apr 2025 21:33:56 -0600
Message-ID: <25332b926db78702c59e6907462fed547360e6d3.1744169424.git.dxu@dxuuu.xyz>
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

In an effort to reduce the amount of external references into
verifier.c, move the body of this function into the header, as it's
quite small.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/bpf.h   | 12 ++++++++++--
 kernel/bpf/verifier.c |  9 ---------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3f0cc89c0622..f1c5356dc099 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -28,6 +28,7 @@
 #include <linux/btf.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/static_call.h>
+#include <linux/string.h>
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
 #include <asm/rqspinlock.h>
@@ -1976,8 +1977,15 @@ static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_op
 
 #endif
 
-int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
-			       const struct bpf_ctx_arg_aux *info, u32 cnt);
+static inline int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
+					     const struct bpf_ctx_arg_aux *info,
+					     u32 cnt)
+{
+	prog->aux->ctx_arg_info = kmemdup_array(info, cnt, sizeof(*info), GFP_KERNEL);
+	prog->aux->ctx_arg_info_size = cnt;
+
+	return prog->aux->ctx_arg_info ? 0 : -ENOMEM;
+}
 
 #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
 int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54c6953a8b84..4a60e2d7c10f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22895,15 +22895,6 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 		env->peak_states, env->longest_mark_read_walk);
 }
 
-int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
-			       const struct bpf_ctx_arg_aux *info, u32 cnt)
-{
-	prog->aux->ctx_arg_info = kmemdup_array(info, cnt, sizeof(*info), GFP_KERNEL);
-	prog->aux->ctx_arg_info_size = cnt;
-
-	return prog->aux->ctx_arg_info ? 0 : -ENOMEM;
-}
-
 static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 {
 	const struct btf_type *t, *func_proto;
-- 
2.47.1


