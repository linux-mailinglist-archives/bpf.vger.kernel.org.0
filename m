Return-Path: <bpf+bounces-48466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF288A08264
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B28168869
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19F0204096;
	Thu,  9 Jan 2025 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AK7gPJJM"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB62A23C9
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459256; cv=none; b=gV4yit2SZlDari3R0yJ1LErHLCm9uP61lNxef21u5yRIWlAYI216ig2L849E/auzfFhPqMvUf96lPKeQ5JkmWZBOkN3bGvdK0jcyOe50Pg7zYaCOic9y4fb4SNkpYdWFmEijzzACOZLo+zlIksIiQvGxhgwmL3QhYRvr/h1pIkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459256; c=relaxed/simple;
	bh=+Obkot8+97xlOpoi9+7GyrkIxchK77DW2TihQJWXP/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8lXYdSloWLqOSOIvWNwW8ggG5xcjdO7Nh9Lfi8feQ4UcMzckt8aKz3SU4WIlD8rq9k9quGR8JGo9MkYQf9wAnFZA3eFoYp9tH/frIdjJtqb6cmJ7mVqN75Rzfg7yD0Tl7yALs8wxQ4RrOYhasEowYmB5bcg26fG1zFEFpfMYHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AK7gPJJM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 390FF203E3BC;
	Thu,  9 Jan 2025 13:47:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 390FF203E3BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736459254;
	bh=70ZYBobnu0du7dPIOSt/5/LRBEnfGbPCbwEb1SLcBsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AK7gPJJMIQ84ZymaNJD6/woaCfxopwpLMqp/GQVopQUjPkXmlnQ2V8yxSInLcoP4R
	 5cjpmaQUsyCC8jmdqlSl2nDv9L0ZZJSJAYEwx7aXcSUUgHecol9fiAUtKLPEi67/Ho
	 F92OVu5Vc6VrP6HmfWUr+KqOaiSGED88hQGtabqs=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: [PATCH 04/14] bpf: Port elf and btf utility helper functions from userspace
Date: Thu,  9 Jan 2025 13:43:46 -0800
Message-ID: <20250109214617.485144-5-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This code is heavily borrowed from libbpf and is used in the
subsequent commits porting relocation functions from libbbf.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 kernel/bpf/syscall.c | 110 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 907cc0b34f822..dc763772b55e5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5964,6 +5964,116 @@ static struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
 	return btf_ext;
 }
 
+static int elf_sec_idx_by_name(struct bpf_obj *obj, const char *name)
+{
+	int i;
+	Elf_Shdr *shdr;
+
+	for (i = 1; i < obj->hdr->e_shnum; i++) {
+		shdr = &obj->sechdrs[i];
+		if (strcmp(name, obj->secstrings + shdr->sh_name) == 0)
+			return i;
+	}
+	return -ENOENT;
+}
+
+static const struct btf_var *btf_type_var(const struct btf_type *t)
+{
+	return (const struct btf_var *)(t + 1);
+}
+
+static int find_extern_btf_id(const struct btf *btf, const char *ext_name)
+{
+	const struct btf_type *t;
+	const char *tname;
+	int i, n;
+
+	if (!btf)
+		return -ESRCH;
+
+	n = btf_type_cnt(btf);
+
+	for (i = 1; i < n; i++) {
+		t = btf_type_by_id(btf, i);
+
+		if (!btf_type_is_var(t) && !btf_type_is_func(t))
+			continue;
+
+		tname = btf_str_by_offset(btf, t->name_off);
+		if (strcmp(tname, ext_name))
+			continue;
+
+		if (btf_type_is_var(t) &&
+		    btf_type_var(t)->linkage != BTF_VAR_GLOBAL_EXTERN)
+			return -EINVAL;
+
+		if (btf_type_is_func(t) && btf_func_linkage(t) != BTF_FUNC_EXTERN)
+			return -EINVAL;
+
+		return i;
+	}
+
+	return -ENOENT;
+}
+
+static inline struct btf_var_secinfo *
+btf_var_secinfos(const struct btf_type *t)
+{
+	return (struct btf_var_secinfo *)(t + 1);
+}
+
+static int find_extern_sec_btf_id(struct btf *btf, int ext_btf_id)
+{
+	const struct btf_var_secinfo *vs;
+	const struct btf_type *t;
+	int i, j, n;
+
+	if (!btf)
+		return -ESRCH;
+
+	n = btf_type_cnt(btf);
+	for (i = 1; i < n; i++) {
+		t = btf_type_by_id(btf, i);
+
+		if (!btf_type_is_datasec(t))
+			continue;
+
+		vs = btf_var_secinfos(t);
+		for (j = 0; j < btf_vlen(t); j++, vs++) {
+			if (vs->type == ext_btf_id)
+				return i;
+		}
+	}
+
+	return -ENOENT;
+}
+
+static bool sym_is_extern(const Elf64_Sym *sym)
+{
+	int bind = ELF64_ST_BIND(sym->st_info);
+	/* externs are symbols w/ type=NOTYPE, bind=GLOBAL|WEAK, section=UND */
+	return sym->st_shndx == SHN_UNDEF &&
+	       (bind == STB_GLOBAL || bind == STB_WEAK) &&
+	       ELF64_ST_TYPE(sym->st_info) == STT_NOTYPE;
+}
+
+static const struct btf_type *
+skip_mods_and_typedefs(const struct btf *btf, u32 id, u32 *res_id)
+{
+	const struct btf_type *t = btf_type_by_id(btf, id);
+
+	if (res_id)
+		*res_id = id;
+
+	while (btf_type_is_mod(t) || btf_type_is_typedef(t)) {
+		if (res_id)
+			*res_id = t->type;
+		t = btf_type_by_id(btf, t->type);
+	}
+
+	return t;
+}
+
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
-- 
2.47.1


