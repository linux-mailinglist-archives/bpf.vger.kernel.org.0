Return-Path: <bpf+bounces-55496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542DFA81B7F
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 05:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154DE1B6332E
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 03:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9783B1CCEE0;
	Wed,  9 Apr 2025 03:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="hZTONJY2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vh+FLYGp"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098C01C3BEB;
	Wed,  9 Apr 2025 03:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169683; cv=none; b=RDZvx8ZP5VQHY0k/LZnH8k24ZhfUK60CoZD0RIZqDiMcEMvxKrV7q7cXaEmi8jP5ufUvfvpBDWTEP6VuMpkE0JYVIAJhH/UyMLSKpPgk6C21QGo3OZv0wAjTwTmx2bOhreIWpX59b+uwgZ3o5Gjv4Tol3XIDyBe93+Bp5HKJnMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169683; c=relaxed/simple;
	bh=wY817n5DAPTA69dGxk/O2TEaMD8JtgdlVKaGyQPbU+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELSqY7P85J4EsS1fRr4LUBjBLHQWexcREdVEG5XHPBr981RJy/mafSZS8yET7xqv0QKWIFvjNhaYDvj8bFfT8Eafx0wBHeK4Yd1r51dxuCTS+r0CjL9X6SfZH5Gmmepi6ZDeavtMRRCHSK2bF7YtmMjVxvtqkjhOellE09h6Q40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=hZTONJY2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vh+FLYGp; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F34F213800F9;
	Tue,  8 Apr 2025 23:34:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 08 Apr 2025 23:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1744169679; x=
	1744256079; bh=E8nk+vsjkr6nE/4WKh08oD2AN8Uktz4WeTY/DkruzE0=; b=h
	ZTONJY2BEeWCrlPb/I7nLUKo3oaJbbFczCqj2aWHbdHvOY8JzcmQFQzhPY/n8zVF
	r8etSeKUdACOs3qaTm9Asv+fjvqOA3bgsjlHdzJVtdeSQfCSN9b1Oru/KWA0Bzrp
	6fi7jv0XIeExX4a0v6b/+vzjOIrUCBFi4hbedb2E58Wt0rdiI+oU1ft/XdpHikF7
	xk796hwZ6wV3zAk5UXHOF8kesSyI9J8r7p9/bJfYfKhfsdnI3Iheocb26vJTgBjl
	qKc0KVw72A+hDEwC/xex0dA7LErLzyRxoPA7HQ+Vy+VnlhXLlGax+KwbjMBbnx1I
	zqGRt+Pan77nGC78ulJaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744169679; x=1744256079; bh=E
	8nk+vsjkr6nE/4WKh08oD2AN8Uktz4WeTY/DkruzE0=; b=Vh+FLYGpN7KNdc3nS
	aD5dqwbvYIoSzOjhuHQrx/gR824hBL81JpxipWvrHpLU5YGqaPeWyyHR/FMl/13R
	mqPN5/lks3jVghUnA0ETsZUW6q45eNcWS+VQxTgKMCgUzlzlpE+IL+qo38ZfZneF
	nZizYhL1gRKaPb/Sn1V4Ue4lKPYfJ2T1a4URwBJBebRvU+9/AnZbH4T96Ig5corJ
	wSqNqyRxoBt7iKcRtKSbMHFuB1kMd+Rb6CyTUrf8pzntOSz8PxVEmB1eq5fevBkz
	Sc1qm1kpdbtnPslW2V/183zMsOAjKV/WyW36nLIfS4yj3n7Gw9V2gj3VQa3J3/Jo
	VY4TQ==
X-ME-Sender: <xms:z-r1Zx1qdLEsD2Wyzum_F-wUBCZK3ikwWvJ9mdpaz1eBRjvdP83ycw>
    <xme:z-r1Z4FYmWZdpZFvNr-ZQA_NtmuhXDpF9zdq3O_1jJkJ28Ps6lMneQ38BwKjYQ6nw
    w3A0CDgh49q-xcl3w>
X-ME-Received: <xmr:z-r1Zx7tGuFHpEPwqUBoK8PFqImDd97b9WKH0_bD6wI2SFUo2rgVlQY7uipxYS54rLpyLJalTGCArO97fM26tjaTrzh84yglkqTbwujZkowdl4b7bd5D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffuc
    dljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhm
    peffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvg
    hrnhepgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguh
    esugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhn
    uhigrdguvghvpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpd
    hrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhn
    gheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslh
    hinhhugidruggvvhdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:z-r1Z-1VC-qdysUeNH7-uHtYgmDGJNMf9ks_h6HOPSXJd45vesOYpQ>
    <xmx:z-r1Z0FIxs6cXpskdoz_dRTqduhZj0DWX4xUfm8CgscsjVMdXfZE0A>
    <xmx:z-r1Z__FKapyr1bqSrh2VGOZ_x_hm7jL50Zs4l5-Q4k25F9jPu3ytQ>
    <xmx:z-r1Zxn5XRf0Gvwsbg7iPj4HHmavYF-a6uG0Zdj78j61rgMfkh2khw>
    <xmx:z-r1Z8x9Con8jmWtrQ6-3uuvfFmFgE_RxWoGE54jhgr68-indeOs9lam>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 23:34:37 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	daniel@iogearbox.net
Cc: eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC bpf-next 02/13] bpf: Move BTF related globals out of verifier.c
Date: Tue,  8 Apr 2025 21:33:57 -0600
Message-ID: <eb5315b4b05c881f82c91c071215f6edc3a4744f.1744169424.git.dxu@dxuuu.xyz>
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

Continuing with the effort to make verifier.c a leaf node, this commit
moves out bpf_verifier_lock, btf_vmlinux, and bpf_get_btf_vmlinux().
These can be owned by btf.c (perhaps rightly so).

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/btf.h   |  4 ++++
 kernel/bpf/btf.c      | 21 +++++++++++++++++++--
 kernel/bpf/verifier.c | 20 +++-----------------
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index ebc0c0c9b944..c51032659c58 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -8,6 +8,7 @@
 #include <linux/bpfptr.h>
 #include <linux/bsearch.h>
 #include <linux/btf_ids.h>
+#include <linux/mutex.h>
 #include <uapi/linux/btf.h>
 #include <uapi/linux/bpf.h>
 
@@ -141,6 +142,9 @@ struct btf_struct_metas {
 
 extern const struct file_operations btf_fops;
 
+extern struct mutex btf_mutex;
+extern struct btf *btf_vmlinux;
+
 const char *btf_get_name(const struct btf *btf);
 void btf_get(struct btf *btf);
 void btf_put(struct btf *btf);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 16ba36f34dfa..5b38c90e1184 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -563,6 +563,18 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 	return -ENOENT;
 }
 
+struct btf *bpf_get_btf_vmlinux(void)
+{
+	if (!btf_vmlinux && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
+		mutex_lock(&btf_mutex);
+		if (!btf_vmlinux)
+			btf_vmlinux = btf_parse_vmlinux();
+		mutex_unlock(&btf_mutex);
+	}
+	return btf_vmlinux;
+}
+EXPORT_SYMBOL_GPL(bpf_get_btf_vmlinux);
+
 s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
 {
 	struct btf *btf;
@@ -5857,7 +5869,12 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 
 extern char __start_BTF[];
 extern char __stop_BTF[];
-extern struct btf *btf_vmlinux;
+
+DEFINE_MUTEX(btf_mutex);
+EXPORT_SYMBOL_GPL(btf_mutex);
+
+struct btf *btf_vmlinux;
+EXPORT_SYMBOL_GPL(btf_vmlinux);
 
 #define BPF_MAP_TYPE(_id, _ops)
 #define BPF_LINK_TYPE(_id, _name)
@@ -6252,7 +6269,7 @@ struct btf *btf_parse_vmlinux(void)
 	if (IS_ERR(btf))
 		goto err_out;
 
-	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
+	/* btf_parse_vmlinux() runs under btf_mutex */
 	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
 	err = btf_alloc_id(btf);
 	if (err) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4a60e2d7c10f..6ed302dab08b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -345,14 +345,11 @@ struct bpf_kfunc_call_arg_meta {
 	u64 mem_size;
 };
 
-struct btf *btf_vmlinux;
-
 static const char *btf_type_name(const struct btf *btf, u32 id)
 {
 	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
 }
 
-static DEFINE_MUTEX(bpf_verifier_lock);
 static DEFINE_MUTEX(bpf_percpu_ma_lock);
 
 __printf(2, 3) static void verbose(void *private_data, const char *fmt, ...)
@@ -23518,17 +23515,6 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	return 0;
 }
 
-struct btf *bpf_get_btf_vmlinux(void)
-{
-	if (!btf_vmlinux && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
-		mutex_lock(&bpf_verifier_lock);
-		if (!btf_vmlinux)
-			btf_vmlinux = btf_parse_vmlinux();
-		mutex_unlock(&bpf_verifier_lock);
-	}
-	return btf_vmlinux;
-}
-
 /*
  * The add_fd_from_fd_array() is executed only if fd_array_cnt is non-zero. In
  * this case expect that every file descriptor in the array is either a map or
@@ -23932,9 +23918,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 
 	bpf_get_btf_vmlinux();
 
-	/* grab the mutex to protect few globals used by verifier */
+	/* grab the mutex to protect BTF globals used by verifier */
 	if (!is_priv)
-		mutex_lock(&bpf_verifier_lock);
+		mutex_lock(&btf_mutex);
 
 	/* user could have requested verbose verifier output
 	 * and supplied buffer to store the verification trace
@@ -24151,7 +24137,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	module_put(env->attach_btf_mod);
 err_unlock:
 	if (!is_priv)
-		mutex_unlock(&bpf_verifier_lock);
+		mutex_unlock(&btf_mutex);
 	vfree(env->insn_aux_data);
 	kvfree(env->insn_hist);
 err_free_env:
-- 
2.47.1


