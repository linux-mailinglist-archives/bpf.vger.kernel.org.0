Return-Path: <bpf+bounces-19087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9129A824C0E
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 01:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F10ECB21BD9
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 00:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6130D386;
	Fri,  5 Jan 2024 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLbl6ihU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F41FAD
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 00:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C79C433C7;
	Fri,  5 Jan 2024 00:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704413364;
	bh=1AR3hgcJQGlnyqu5zNrIvgwAWVzLPVVbCrxAK82ulfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uLbl6ihURNOPmq0g6I2FfZ96WcRWOHYHqBFez6XbkH9rX2ROTgR70IKPavgyajbIK
	 i41QzRbTIUVunCtS5hwzmZNNe+01s5WLKoSR/wwOe5Q0Jj0xxZ/YYeFWmraiprxkQz
	 pjU7BTJkdReqz7iO/V+yOEaUKeKiTS1FSb2P5I8weD3st6XKOauPnZGZY62UMeQal1
	 0mJhOd4rxUlkePQny85s7D1UyONrMW8IW0Bf68BK/Yf/JOIPPwx1KqxxygLeSn9ZXn
	 a6a/4oPihYFka7PJxgs10EF7JBLKONWxA/I8iMH+UWPMvJwOBkcTnT9MOjcAkG7dAM
	 xVuDOC12kIwvg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next 4/8] bpf: support multiple tags per argument
Date: Thu,  4 Jan 2024 16:09:05 -0800
Message-Id: <20240105000909.2818934-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105000909.2818934-1-andrii@kernel.org>
References: <20240105000909.2818934-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ability to iterate multiple decl_tag types pointed to the same
function argument. Use this to support multiple __arg_xxx tags per
global subprog argument.

We leave btf_find_decl_tag_value() intact, but change its implementation
to use a new btf_find_next_decl_tag() which can be straightforwardly
used to find next BTF type ID of a matching btf_decl_tag type.
btf_prepare_func_args() is switched from btf_find_decl_tag_value() to
btf_find_next_decl_tag() to gain multiple tags per argument support.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h |  2 ++
 kernel/bpf/btf.c    | 64 +++++++++++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7671530d6e4e..7ab4a290418a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2471,6 +2471,8 @@ int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *pr
 			 struct btf *btf, const struct btf_type *t);
 const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type *pt,
 				    int comp_idx, const char *tag_key);
+int btf_find_next_decl_tag(const struct btf *btf, const struct btf_type *pt,
+			   int comp_idx, const char *tag_key, int last_id);
 
 struct bpf_prog *bpf_prog_by_id(u32 id);
 struct bpf_link *bpf_link_by_id(u32 id);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ccaf57e755fc..368d8fe19d35 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3310,30 +3310,48 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 	return BTF_FIELD_FOUND;
 }
 
-const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type *pt,
-				    int comp_idx, const char *tag_key)
+int btf_find_next_decl_tag(const struct btf *btf, const struct btf_type *pt,
+			   int comp_idx, const char *tag_key, int last_id)
 {
-	const char *value = NULL;
-	int i;
+	int len = strlen(tag_key);
+	int i, n;
 
-	for (i = 1; i < btf_nr_types(btf); i++) {
+	for (i = last_id + 1, n = btf_nr_types(btf); i < n; i++) {
 		const struct btf_type *t = btf_type_by_id(btf, i);
-		int len = strlen(tag_key);
 
 		if (!btf_type_is_decl_tag(t))
 			continue;
-		if (pt != btf_type_by_id(btf, t->type) ||
-		    btf_type_decl_tag(t)->component_idx != comp_idx)
+		if (pt != btf_type_by_id(btf, t->type))
+			continue;
+		if (btf_type_decl_tag(t)->component_idx != comp_idx)
 			continue;
 		if (strncmp(__btf_name_by_offset(btf, t->name_off), tag_key, len))
 			continue;
-		/* Prevent duplicate entries for same type */
-		if (value)
-			return ERR_PTR(-EEXIST);
-		value = __btf_name_by_offset(btf, t->name_off) + len;
+		return i;
 	}
-	if (!value)
-		return ERR_PTR(-ENOENT);
+	return -ENOENT;
+}
+
+const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type *pt,
+				    int comp_idx, const char *tag_key)
+{
+	const char *value = NULL;
+	const struct btf_type *t;
+	int len, id;
+
+	id = btf_find_next_decl_tag(btf, pt, comp_idx, tag_key, 0);
+	if (id < 0)
+		return ERR_PTR(id);
+
+	t = btf_type_by_id(btf, id);
+	len = strlen(tag_key);
+	value = __btf_name_by_offset(btf, t->name_off) + len;
+
+	/* Prevent duplicate entries for same type */
+	id = btf_find_next_decl_tag(btf, pt, comp_idx, tag_key, id);
+	if (id >= 0)
+		return ERR_PTR(-EEXIST);
+
 	return value;
 }
 
@@ -6870,20 +6888,16 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	 * Only PTR_TO_CTX and SCALAR are supported atm.
 	 */
 	for (i = 0; i < nargs; i++) {
-		const char *tag;
 		u32 tags = 0;
+		int id = 0;
 
-		tag = btf_find_decl_tag_value(btf, fn_t, i, "arg:");
-		if (IS_ERR(tag) && PTR_ERR(tag) == -ENOENT) {
-			tag = NULL;
-		} else if (IS_ERR(tag)) {
-			bpf_log(log, "arg#%d type's tag fetching failure: %ld\n", i, PTR_ERR(tag));
-			return PTR_ERR(tag);
-		}
 		/* 'arg:<tag>' decl_tag takes precedence over derivation of
 		 * register type from BTF type itself
 		 */
-		if (tag) {
+		while ((id = btf_find_next_decl_tag(btf, fn_t, i, "arg:", id)) > 0) {
+			const struct btf_type *tag_t = btf_type_by_id(btf, id);
+			const char *tag = __btf_name_by_offset(btf, tag_t->name_off) + 4;
+
 			/* disallow arg tags in static subprogs */
 			if (!is_global) {
 				bpf_log(log, "arg#%d type tag is not supported in static functions\n", i);
@@ -6899,6 +6913,10 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 				return -EOPNOTSUPP;
 			}
 		}
+		if (id != -ENOENT) {
+			bpf_log(log, "arg#%d type tag fetching failure: %d\n", i, id);
+			return id;
+		}
 
 		t = btf_type_by_id(btf, args[i].type);
 		while (btf_type_is_modifier(t))
-- 
2.34.1


