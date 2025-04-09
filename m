Return-Path: <bpf+bounces-55500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF42AA81B8C
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 05:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A208A0A67
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 03:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1BF1DA0E0;
	Wed,  9 Apr 2025 03:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="KER+Jljr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IrmAc828"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77281D63F2;
	Wed,  9 Apr 2025 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169690; cv=none; b=jbs0qxjIWjnZxmrjr8/NQgQ+b2AAL3EKpaj9wNFTbmAiJ0EAiiFh7SLE/dyCSB09/KqAQLqN/exFRUP2LVKGvmEJb5nE/EKfgto+7GD4MUA5a3jsN2brtJImC35UAdWLYOa325WkLIFYTd7yQ2qnRRBUzp3FqeoWR38zRgz9Haw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169690; c=relaxed/simple;
	bh=oUssefEXTuCqXSOQfsTj9BCaoDU+LXcHBhU7+1208uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=remZLcRF6DPh7m0CVlc1Ec+C25qhWd93aOKK6Ad7lGj7CuR6TQMTLyncRYlbxua4y+Fa60OCabmlsJMbicm6NS7d4dd6blaDE6x6aB5LQSgnDc5zqaBr0DINPlTOyFE5mTd5I+lutCCmieB06AeLLsFP0EKeuYSbc5mtSL/oC8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=KER+Jljr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IrmAc828; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id BF21413801E2;
	Tue,  8 Apr 2025 23:34:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 08 Apr 2025 23:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1744169687; x=
	1744256087; bh=5Fe1HL5mwA1ivcge9OaRh17cxWT60SpWc9Ewccp5/cQ=; b=K
	ER+Jljr7gGhoiLJkfXv65HeZ/plhwqSFos4cGKAjM55F3SfiVBOUI/BOWJ5R5HVk
	orpo6N5F6x2jlyC2yA/DSYx+JdZgdWMR3wlxTXRauiJ0IA2dzJJUroXJ9/wAp2D8
	VI8SItTvweSsidBCjYV6A74CIxvmoI53s9mwDB6UeacvuwolkFeIgbmer6uq8rfa
	9i9eRhDHDuSBgWu5GzhjrZgiLQwZrUK9HXnoVRsvw6uwKimcIQLYAZAAkFcP1zZp
	SKEGfHNtgP+3v3V9Z/E60jw8TBVDiIiTbeCrGsPlbVAJ1m5i/zj9/yu1JAO0LStZ
	6FIGMTv1zj4Hcbox3UnOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744169687; x=1744256087; bh=5
	Fe1HL5mwA1ivcge9OaRh17cxWT60SpWc9Ewccp5/cQ=; b=IrmAc828o/PGi/FVx
	ofe4gh0d2om6XxN898ALe/Ea9Cz+HnuR5XlO+bCouTaoXONsOKK6EMhsfgBSZy4V
	WkEP3AtVO+PBWMa2F+Yqx74A+a/RpsZGeRaQ0I2zTPjZj0IYwRXftJscZcryXfz2
	a8Btto7hCxPhA+wTC1dOTfgStAndZHwo6aJD12begS+/jV7WtoKAwAqEFs4FZA1N
	bsJ3E9jvhPrAHeQ0V/aPFogW9Cg+cHsqOsKylhXdaZWtqPi+qQ8faD5IWG8W6nCw
	ib34vonCT/WV9ScYQpE6gBU0Jh90WLxB4jwvGIaO/w4g0FXVbDEr9vs5mdm5SoMD
	a91qQ==
X-ME-Sender: <xms:1-r1Z2Qct7WFq24G9DKwjHQzcsB_hdSa1TFESpEHdEBLJA4f3XQlzA>
    <xme:1-r1Z7wKnw5kT6lrgxnzDI1rpMfoerX-76xpKUGbzlKBLMB6uPbpNkpyGmmkZPUkp
    yfQL6LUuwfBxLPYxQ>
X-ME-Received: <xmr:1-r1Zz3SDAIEdoWyF9roeRtCIeRXRPLOB2GEYR37t-_L-Na0L2f-s1JJRhaY-HtEkJHT7q4RasGHHzKHTTpjwrfBN662MEp8QovnJbAKP6xeVKTelld->
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
X-ME-Proxy: <xmx:1-r1ZyC-d186nLOmNPerTt749RyYZaVycp0dgJEv5VjNjCq_0R4fqQ>
    <xmx:1-r1Z_h3kHxfeLPLwbnbY6CQ7E1qIbEruWMXUOqZkZS_df9-OaUO4A>
    <xmx:1-r1Z-qA0v5lzaKZTzY4j4HFsi51n_iS5_pma7qvRch-XgM9W3ZQ0g>
    <xmx:1-r1ZyixyNWIRPvAiwJx7toRC1zBXOZ5GDmxllvAnHfKYNUKahC-hw>
    <xmx:1-r1Z9uDNIv-AKrfYfC0m4KNqMB-Zr-tBVEFEwKnn9phmk4GH9W7dmr5>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 23:34:46 -0400 (EDT)
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
Subject: [RFC bpf-next 06/13] bpf: Move kfunc definitions out of verifier.c
Date: Tue,  8 Apr 2025 21:34:01 -0600
Message-ID: <c73f939de0f6af022e009dda057b6f941c6fce59.1744169424.git.dxu@dxuuu.xyz>
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

Multiple files reference bpf_get_kfunc_addr(). But in order to move the
definition out into core, we need to drag along the various struct
definitions.

Doing this also makes moving bpf_free_kfunc_btf_tab() in the next commit
simpler as well.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/bpf.h   | 42 ++++++++++++++++++++++++++
 kernel/bpf/core.c     | 29 ++++++++++++++++++
 kernel/bpf/verifier.c | 68 -------------------------------------------
 3 files changed, 71 insertions(+), 68 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1785901330b2..44133727820d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1470,6 +1470,38 @@ static inline bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 }
 #endif
 
+#define MAX_KFUNC_DESCS 256
+#define MAX_KFUNC_BTFS	256
+
+struct bpf_kfunc_desc {
+	struct btf_func_model func_model;
+	u32 func_id;
+	s32 imm;
+	u16 offset;
+	unsigned long addr;
+};
+
+struct bpf_kfunc_btf {
+	struct btf *btf;
+	struct module *module;
+	u16 offset;
+};
+
+struct bpf_kfunc_desc_tab {
+	/* Sorted by func_id (BTF ID) and offset (fd_array offset) during
+	 * verification. JITs do lookups by bpf_insn, where func_id may not be
+	 * available, therefore at the end of verification do_misc_fixups()
+	 * sorts this by imm and offset.
+	 */
+	struct bpf_kfunc_desc descs[MAX_KFUNC_DESCS];
+	u32 nr_descs;
+};
+
+struct bpf_kfunc_btf_tab {
+	struct bpf_kfunc_btf descs[MAX_KFUNC_BTFS];
+	u32 nr_descs;
+};
+
 struct bpf_func_info_aux {
 	u16 linkage;
 	bool unreliable;
@@ -2755,6 +2787,16 @@ bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
 const struct btf_func_model *
 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 			 const struct bpf_insn *insn);
+static inline int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
+{
+	const struct bpf_kfunc_desc *d0 = a;
+	const struct bpf_kfunc_desc *d1 = b;
+
+	/* func_id is not greater than BTF_MAX_TYPE */
+	return d0->func_id - d1->func_id ?: d0->offset - d1->offset;
+}
+const struct bpf_kfunc_desc *
+find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset);
 int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
 		       u16 btf_fd_idx, u8 **func_addr);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index aaf0841140c0..8cbfe7d33c0a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1624,6 +1624,35 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
 	bpf_prog_unlock_free(fp);
 }
 
+const struct bpf_kfunc_desc *
+find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
+{
+	struct bpf_kfunc_desc desc = {
+		.func_id = func_id,
+		.offset = offset,
+	};
+	struct bpf_kfunc_desc_tab *tab;
+
+	tab = prog->aux->kfunc_tab;
+	return bsearch(&desc, tab->descs, tab->nr_descs,
+		       sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
+}
+EXPORT_SYMBOL_GPL(find_kfunc_desc);
+
+int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
+		       u16 btf_fd_idx, u8 **func_addr)
+{
+	const struct bpf_kfunc_desc *desc;
+
+	desc = find_kfunc_desc(prog, func_id, btf_fd_idx);
+	if (!desc)
+		return -EFAULT;
+
+	*func_addr = (u8 *)desc->addr;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bpf_get_kfunc_addr);
+
 int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 			  const struct bpf_insn *insn, bool extra_pass,
 			  u64 *func_addr, bool *func_addr_fixed)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d3bb65f721c9..161280f3371f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2957,47 +2957,6 @@ static int bpf_find_exception_callback_insn_off(struct bpf_verifier_env *env)
 	return ret;
 }
 
-#define MAX_KFUNC_DESCS 256
-#define MAX_KFUNC_BTFS	256
-
-struct bpf_kfunc_desc {
-	struct btf_func_model func_model;
-	u32 func_id;
-	s32 imm;
-	u16 offset;
-	unsigned long addr;
-};
-
-struct bpf_kfunc_btf {
-	struct btf *btf;
-	struct module *module;
-	u16 offset;
-};
-
-struct bpf_kfunc_desc_tab {
-	/* Sorted by func_id (BTF ID) and offset (fd_array offset) during
-	 * verification. JITs do lookups by bpf_insn, where func_id may not be
-	 * available, therefore at the end of verification do_misc_fixups()
-	 * sorts this by imm and offset.
-	 */
-	struct bpf_kfunc_desc descs[MAX_KFUNC_DESCS];
-	u32 nr_descs;
-};
-
-struct bpf_kfunc_btf_tab {
-	struct bpf_kfunc_btf descs[MAX_KFUNC_BTFS];
-	u32 nr_descs;
-};
-
-static int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
-{
-	const struct bpf_kfunc_desc *d0 = a;
-	const struct bpf_kfunc_desc *d1 = b;
-
-	/* func_id is not greater than BTF_MAX_TYPE */
-	return d0->func_id - d1->func_id ?: d0->offset - d1->offset;
-}
-
 static int kfunc_btf_cmp_by_off(const void *a, const void *b)
 {
 	const struct bpf_kfunc_btf *d0 = a;
@@ -3006,33 +2965,6 @@ static int kfunc_btf_cmp_by_off(const void *a, const void *b)
 	return d0->offset - d1->offset;
 }
 
-static const struct bpf_kfunc_desc *
-find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
-{
-	struct bpf_kfunc_desc desc = {
-		.func_id = func_id,
-		.offset = offset,
-	};
-	struct bpf_kfunc_desc_tab *tab;
-
-	tab = prog->aux->kfunc_tab;
-	return bsearch(&desc, tab->descs, tab->nr_descs,
-		       sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
-}
-
-int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
-		       u16 btf_fd_idx, u8 **func_addr)
-{
-	const struct bpf_kfunc_desc *desc;
-
-	desc = find_kfunc_desc(prog, func_id, btf_fd_idx);
-	if (!desc)
-		return -EFAULT;
-
-	*func_addr = (u8 *)desc->addr;
-	return 0;
-}
-
 static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
 					 s16 offset)
 {
-- 
2.47.1


