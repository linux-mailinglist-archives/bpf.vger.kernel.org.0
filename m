Return-Path: <bpf+bounces-19791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BC28311D4
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 04:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECF61F22FAA
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 03:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549FF6138;
	Thu, 18 Jan 2024 03:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDAHEK+m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E723D9
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 03:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705548712; cv=none; b=iflzpRDiFH1nR2B8X72KPsGQC1ay28NYqMvuULtyxHqXFgSU+PabOscG9iGgNgsFjyEm03juuMFvAPKlr2hahibYMLJhImMaQYQa3L3Vao66RQao4oAHsOy21fJqfBXwrcc5ZFso7zB8PqrtRsFmjc4RQX15i/nDUxHE7rBANdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705548712; c=relaxed/simple;
	bh=3nywmZMRjUBXXGZwrog1A4iNlZe5AfGFE5M7bTzPOj8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=U2rPyMinM6MMpWKFQLcDDHC+XwTAnZdQlYDW8r3Ig1mrAk3Sa2w/nkHueEw4rU9735jEN+tF+qXPqfPJqIqlW12uhA4VX88Jd9agsXMDF/xVGQdf+llFve6nIyFiu+s4sGstiyNEQQzAFDuOj9Jo6tpANcaYE0j2xEKWNe17qZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDAHEK+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFF3C433F1;
	Thu, 18 Jan 2024 03:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705548712;
	bh=3nywmZMRjUBXXGZwrog1A4iNlZe5AfGFE5M7bTzPOj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FDAHEK+mHHY0MSZpV1xls7uJZvv/OviH8wHY9ekwhIH2czOGuVOVeYt9/NdyARhkf
	 cJi/RXTct1lf+zSdDo/h+rve623VShsEL20RfbdkvBhmcFSnvpQ6rJC1ZSC/QxxwH8
	 njJfKeFvEisSac+82mAVwf/7H87T04PiwRVCQxxf35uXALNmB37hUZD2l7GrKs8ko9
	 MH8hb+AYpypfgfG5xZ98i/0he3mD7OY/UWhLzAoAuXTDV8Oy3h4Ddunb+GK7nMkSH1
	 44N4qUMHoCxfGbL6+p9DuCoO/x9vLiezyrA/u79lsBpSRLJK1NwriHxQtuJevbN6Jp
	 s7V1tcC/fTM+g==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 bpf 2/5] bpf: extract bpf_ctx_convert_map logic and make it more reusable
Date: Wed, 17 Jan 2024 19:31:40 -0800
Message-Id: <20240118033143.3384355-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118033143.3384355-1-andrii@kernel.org>
References: <20240118033143.3384355-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor btf_get_prog_ctx_type() a bit to allow reuse of
bpf_ctx_convert_map logic in more than one places. Simplify interface by
returning btf_type instead of btf_member (field reference in BTF).

To do the above we need to touch and start untangling
btf_translate_to_vmlinux() implementation. We do the bare minimum to
not regress anything for btf_translate_to_vmlinux(), but its
implementation is very questionable for what it claims to be doing.
Mapping kfunc argument types to kernel corresponding types conceptually
is quite different from recognizing program context types. Fixing this
is out of scope for this change though.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/btf.h |  2 +-
 kernel/bpf/btf.c    | 71 ++++++++++++++++++++++++++++-----------------
 2 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 59d404e22814..cf5c6ff48981 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -512,7 +512,7 @@ s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
 				struct module *owner);
 struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id);
-const struct btf_member *
+const struct btf_type *
 btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 		      const struct btf_type *t, enum bpf_prog_type prog_type,
 		      int arg);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 51e8b4bee0c8..10ac9efc662d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5615,21 +5615,46 @@ static u8 bpf_ctx_convert_map[] = {
 #undef BPF_MAP_TYPE
 #undef BPF_LINK_TYPE
 
-const struct btf_member *
-btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
-		      const struct btf_type *t, enum bpf_prog_type prog_type,
-		      int arg)
+static const struct btf_type *find_canonical_prog_ctx_type(enum bpf_prog_type prog_type)
 {
 	const struct btf_type *conv_struct;
-	const struct btf_type *ctx_struct;
 	const struct btf_member *ctx_type;
-	const char *tname, *ctx_tname;
 
 	conv_struct = bpf_ctx_convert.t;
-	if (!conv_struct) {
-		bpf_log(log, "btf_vmlinux is malformed\n");
+	if (!conv_struct)
 		return NULL;
-	}
+	/* prog_type is valid bpf program type. No need for bounds check. */
+	ctx_type = btf_type_member(conv_struct) + bpf_ctx_convert_map[prog_type] * 2;
+	/* ctx_type is a pointer to prog_ctx_type in vmlinux.
+	 * Like 'struct __sk_buff'
+	 */
+	return btf_type_by_id(btf_vmlinux, ctx_type->type);
+}
+
+static int find_kern_ctx_type_id(enum bpf_prog_type prog_type)
+{
+	const struct btf_type *conv_struct;
+	const struct btf_member *ctx_type;
+
+	conv_struct = bpf_ctx_convert.t;
+	if (!conv_struct)
+		return -EFAULT;
+	/* prog_type is valid bpf program type. No need for bounds check. */
+	ctx_type = btf_type_member(conv_struct) + bpf_ctx_convert_map[prog_type] * 2 + 1;
+	/* ctx_type is a pointer to prog_ctx_type in vmlinux.
+	 * Like 'struct sk_buff'
+	 */
+	return ctx_type->type;
+}
+
+const struct btf_type *
+btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
+		      const struct btf_type *t, enum bpf_prog_type prog_type,
+		      int arg)
+{
+	const struct btf_type *ctx_type;
+	const char *tname, *ctx_tname;
+
 	t = btf_type_by_id(btf, t->type);
 	while (btf_type_is_modifier(t))
 		t = btf_type_by_id(btf, t->type);
@@ -5646,17 +5671,15 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 		bpf_log(log, "arg#%d struct doesn't have a name\n", arg);
 		return NULL;
 	}
-	/* prog_type is valid bpf program type. No need for bounds check. */
-	ctx_type = btf_type_member(conv_struct) + bpf_ctx_convert_map[prog_type] * 2;
-	/* ctx_struct is a pointer to prog_ctx_type in vmlinux.
-	 * Like 'struct __sk_buff'
-	 */
-	ctx_struct = btf_type_by_id(btf_vmlinux, ctx_type->type);
-	if (!ctx_struct)
+
+	ctx_type = find_canonical_prog_ctx_type(prog_type);
+	if (!ctx_type) {
+		bpf_log(log, "btf_vmlinux is malformed\n");
 		/* should not happen */
 		return NULL;
+	}
 again:
-	ctx_tname = btf_name_by_offset(btf_vmlinux, ctx_struct->name_off);
+	ctx_tname = btf_name_by_offset(btf_vmlinux, ctx_type->name_off);
 	if (!ctx_tname) {
 		/* should not happen */
 		bpf_log(log, "Please fix kernel include/linux/bpf_types.h\n");
@@ -5677,10 +5700,10 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 		/* bpf_user_pt_regs_t is a typedef, so resolve it to
 		 * underlying struct and check name again
 		 */
-		if (!btf_type_is_modifier(ctx_struct))
+		if (!btf_type_is_modifier(ctx_type))
 			return NULL;
-		while (btf_type_is_modifier(ctx_struct))
-			ctx_struct = btf_type_by_id(btf_vmlinux, ctx_struct->type);
+		while (btf_type_is_modifier(ctx_type))
+			ctx_type = btf_type_by_id(btf_vmlinux, ctx_type->type);
 		goto again;
 	}
 	return ctx_type;
@@ -5692,13 +5715,9 @@ static int btf_translate_to_vmlinux(struct bpf_verifier_log *log,
 				     enum bpf_prog_type prog_type,
 				     int arg)
 {
-	const struct btf_member *prog_ctx_type, *kern_ctx_type;
-
-	prog_ctx_type = btf_get_prog_ctx_type(log, btf, t, prog_type, arg);
-	if (!prog_ctx_type)
+	if (!btf_get_prog_ctx_type(log, btf, t, prog_type, arg))
 		return -ENOENT;
-	kern_ctx_type = prog_ctx_type + 1;
-	return kern_ctx_type->type;
+	return find_kern_ctx_type_id(prog_type);
 }
 
 int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type)
-- 
2.34.1


