Return-Path: <bpf+bounces-55501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D57A81B8D
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 05:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 725857B6678
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 03:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE3F1DC9B5;
	Wed,  9 Apr 2025 03:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="EWcfxSqj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kFkWkDyV"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32DE1D90A9;
	Wed,  9 Apr 2025 03:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169692; cv=none; b=JCdkiI/8952eKegbgvkd1MaG2+o6hwl8k2xIx6sK1iI0OBB821SN4M259l6gOq/nx8FPNFQGxt+QxoNdw/4gzZOty3OsRW3odW8QS/0HW7mcKkSwvgqo9fsUfTD3mnuYM5BltWpnTgHuNyYzziIFYsoDlHVzHq0iGOtb4NFNyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169692; c=relaxed/simple;
	bh=MTO8TYXrYkS5+gZ7YoJ1hGQfE1UmPeJYID4bLAzETg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCY48AlwQJfRTrp6oGNVrgFFKzXuswsf7PhzIKakOsdhAtnYN/ek/OwKDUPGvhXpzTplo7KxbUA5Js/fvOzqh2KE4VtMOMFo7WIYGVoGj8eBmMUpotjzplSkCgks36whjgyh/JPIKll3z5PI2FHe2QseV/9XoZglLSxStP2YcS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=EWcfxSqj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kFkWkDyV; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEE3411401AD;
	Tue,  8 Apr 2025 23:34:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 08 Apr 2025 23:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1744169689; x=
	1744256089; bh=tx9FCo6R6R8yUOFOL44YRwWM5fJLHw5Y6hkN8xcha+0=; b=E
	WcfxSqj9/NIN/ursnGNiRluwPCu+XJrry5MIedH3aGRUlu95rEqyD4KRz03U4BiJ
	wZ2gCD6v+lVqE/MzuOJBfSy7ajOyoQXinSyRP0wJ1C36/EgsVZCfFX2+mYspBTX3
	xch0qQeNr9zChp7LVBSt0UIsPqg7Qu1Mnd6icqhSoQiAbw6nAHH1gwav2SzxLVdZ
	OdzBQLUEv0CgQJEr2VGFXykNKd5Yi0ja3MN4hsGLEuzD8BHz15ILwKrDwVSPf+9Q
	nDfbFBjcgKenYufXPHocvjRjbG1KS806dxVEizMUIovvW+1GD2gQiExk7mrviLIJ
	wyZwWrmMAbihfuJhLOzHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744169689; x=1744256089; bh=t
	x9FCo6R6R8yUOFOL44YRwWM5fJLHw5Y6hkN8xcha+0=; b=kFkWkDyVJKNFWILQQ
	E+qRQRuEB3EWBG6yImQ5FqgtwPcb95auzy34Ynh3X3nMa9VfBbrAjhL2f+OPIg+Z
	VxTz3/pXHdnaWrtG86U3RypuVyuqGhi2xqJpKvCis0rSKmA/hiIix0fiKnfYa0FA
	lB1E2x0xIKaurDgFjUhUwvNOWCB4X4cSOCpN16KznaQ/nfk8oFVqTB3d0xQdudVS
	fCngNcoJo3ALefEPORd0aP46gWEOK6N9KAnREQ7LjR/smQ7wBLiBGqyHLC1N5w3E
	Ukyx4SX1hh6klNWWKIjetDkrkEhbzOnTAC/9Ekw8Va1x1kgjtQ9HA5N2UYMdgVyo
	ewHjg==
X-ME-Sender: <xms:2er1ZwUCX-LpDiVRU97Y_qLLwjxKpI729881lfagvfC8u8SG3v8cCg>
    <xme:2er1Z0l21jiSEuOhgaYeUZJR_UEzdtUsrb8G5PZtVA0K_ikELwkHPcVd_bAy80iUM
    28ihjWritTJo__qFg>
X-ME-Received: <xmr:2er1Z0ZLQjL2n9er4R2CntbrnkNBz5S3ekauXSXZexvHO8bZhgXKfBr3O8ovtdakXU_qzcvYLuDk7hLEyg44nwRMXz91QzQ5CjZEuGeeL9TAdfeaeLT9>
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
    ohigrdhnvghtpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpd
    hrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhn
    gheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslh
    hinhhugidruggvvhdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2er1Z_VcRlN6sMS8kE4extQJORPOyjaJzasnd3ZP3dtSHxYkatqVBg>
    <xmx:2er1Z6l2mRC59WYxnDR7EnzyiuURFCiag3a9mvEFFVjyP3E5bWDytg>
    <xmx:2er1Z0f4pWS5ePhkNY-MAAKAyBu_AJxOM7uD4G5Znd5P93Z7dBK_Hw>
    <xmx:2er1Z8ERzN3Q72UkWwtuhuQtCyflBqcffVr9EehEX53FDu_BoHU68g>
    <xmx:2er1Z3RmOuBtccuEL8h9v1XWcCiJGh9LGpt-So0ePsz_X4hM23EqmGDK>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 23:34:47 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC bpf-next 07/13] bpf: Make bpf_free_kfunc_btf_tab() static in core
Date: Tue,  8 Apr 2025 21:34:02 -0600
Message-ID: <8ec25079f9ee20495409e08b6a1e08a9076dcc29.1744169424.git.dxu@dxuuu.xyz>
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

This function is only used in one place in core. However, it was defined
in verifier.c b/c a bunch of struct definitions were hidden in
verifier.c. Now that those definitions are shared, we can move
bpf_free_kfunc_btf_tab() into core and mark it static.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/bpf_verifier.h |  2 --
 kernel/bpf/core.c            | 13 +++++++++++++
 kernel/bpf/verifier.c        | 12 ------------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f61f5429647a..f9a203e5f042 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -879,8 +879,6 @@ static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
 		*btf_id = key & 0x7FFFFFFF;
 }
 
-void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
-
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
 #define BPF_BASE_TYPE_MASK	GENMASK(BPF_BASE_TYPE_BITS - 1, 0)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 8cbfe7d33c0a..e892e469061e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3251,6 +3251,19 @@ static void bpf_free_used_btfs(struct bpf_prog_aux *aux)
 	kfree(aux->used_btfs);
 }
 
+static void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab)
+{
+	if (!tab)
+		return;
+
+	while (tab->nr_descs--) {
+		module_put(tab->descs[tab->nr_descs].module);
+		btf_put(tab->descs[tab->nr_descs].btf);
+	}
+	kfree(tab);
+}
+
+
 static void bpf_prog_free_deferred(struct work_struct *work)
 {
 	struct bpf_prog_aux *aux;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 161280f3371f..7e84df2abe41 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3029,18 +3029,6 @@ static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
 	return btf;
 }
 
-void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab)
-{
-	if (!tab)
-		return;
-
-	while (tab->nr_descs--) {
-		module_put(tab->descs[tab->nr_descs].module);
-		btf_put(tab->descs[tab->nr_descs].btf);
-	}
-	kfree(tab);
-}
-
 static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
 {
 	if (offset) {
-- 
2.47.1


