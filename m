Return-Path: <bpf+bounces-48474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA3EA0826C
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032491887C40
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF427204F76;
	Thu,  9 Jan 2025 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nV+XLQmm"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CB72046AD
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 21:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459296; cv=none; b=cBWSD9Rs3SumWxKEIQQVu/+ZGdyLU/HAdTBG+vFImp/8DcbFfX1EeebLAKsX+g7EVR1r/jLWBrzoopWxpHJVSaABMy7f1+rCvrYRHcq5B4wNVBlPieht4OHecMm8TOyqU1j+hBRawc0H/vPQ/vZ3ZjHocc+F1ydBg9rSP5VzqRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459296; c=relaxed/simple;
	bh=Gex09YNkY5U5oBIZXF1mubh1UqqAGNB6D4Hzq50BG1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcCZTIVVUEis2ib/uvETkZfMxMl7niSNzhG36ONqbfK7sLvIW0ycn2BR5aFmgWi78mC65GzNZTuU2OCRnhoBbWginrVBiYHt6lC1YBYqrwR3ty7+LmNLYsnoeiPS09TT+Od0+ZEov36XVJDzDWnT8dDbYxa/sNuQcNuxF6drw0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nV+XLQmm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id BF5DF203E39C;
	Thu,  9 Jan 2025 13:48:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF5DF203E39C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736459294;
	bh=dZ3OaO+4z+9ky0bp9FBfEwFBU9RDmIqhYzLMqaerSXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nV+XLQmmF/UiUI0cl6KViekkiLU1sZ0f/CQbXubfqDDzN7oAa8oNPL0z7rhMq+9Y1
	 UEYuwUwIsGKy5N3wDRr3a3Ulz6JyGUYRxOZwD0lD7icL+TdRWI2xVFIx/OUDg4Kbzj
	 o7gv77yMZZFx5Y+iBdh74O/Bv9+rE1pWSHXx5hxs=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: [PATCH 12/14] bpf: Resolve external relocations
Date: Thu,  9 Jan 2025 13:43:54 -0800
Message-ID: <20250109214617.485144-13-bboscaccy@linux.microsoft.com>
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

Here we attempt to assign addresses to relocations that target
external symbols. This code heavily borrows from
bpf_object__resolve_externs with a few key differences.

Since we are already in the kernel, for kallsyms based relocations, we
simply look them up. For btf based relocations, we consult the
kernel's btf information. There is a key difference in the handling
kconfig based relocations though. Here, we rely upon the userspace
kconfig map data and simply use the values that are passed in.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 kernel/bpf/syscall.c | 174 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9c3d037cd6b95..b766c790ae3f4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -7067,6 +7067,176 @@ static int collect_relos(struct bpf_obj *obj)
 	return 0;
 }
 
+static int find_ksym_btf_id(struct bpf_obj *obj, const char *ksym_name, u16 kind,
+			    struct btf **res_btf,
+			    struct bpf_module_btf **res_mod_btf)
+{
+	struct bpf_module_btf *mod_btf;
+	struct btf *btf;
+	int i, id;
+
+	btf = obj->btf_vmlinux;
+	mod_btf = NULL;
+	id = btf_find_by_name_kind(btf, ksym_name, kind);
+	if (id == -ENOENT) {
+		for (i = 0; i < obj->btf_modules_cnt; i++) {
+			/*  we assume module_btf's BTF FD is always >0 */
+			mod_btf = &obj->btf_modules[i];
+			btf = mod_btf->btf;
+			id = btf_find_by_name_kind(btf, ksym_name, kind);
+			if (id != -ENOENT)
+				break;
+		}
+	}
+	if (id <= 0)
+		return -ESRCH;
+
+	*res_btf = btf;
+	*res_mod_btf = mod_btf;
+	return id;
+}
+
+static int resolve_ksym_var_btf_id(struct bpf_obj *obj, struct bpf_extern_desc *ext)
+{
+	const struct btf_type *targ_var, *targ_type;
+	u32 targ_type_id, local_type_id;
+	struct bpf_module_btf *mod_btf = NULL;
+	const char *targ_var_name;
+	struct btf *btf = NULL;
+	int id, err;
+
+	id = find_ksym_btf_id(obj, ext->name, BTF_KIND_VAR, &btf, &mod_btf);
+	if (id < 0) {
+		if (id == -ESRCH && ext->is_weak)
+			return 0;
+		pr_warn("extern (var ksym) '%s': not found in kernel BTF\n",
+			ext->name);
+		return id;
+	}
+
+	/* find local type_id */
+	local_type_id = ext->ksym.type_id;
+
+	/* find target type_id */
+	targ_var = btf_type_by_id(btf, id);
+	targ_var_name = btf_str_by_offset(btf, targ_var->name_off);
+	targ_type = skip_mods_and_typedefs(btf, targ_var->type, &targ_type_id);
+
+	err = bpf_core_types_are_compat(obj->btf, local_type_id,
+					btf, targ_type_id);
+	if (err <= 0) {
+		pr_warn("extern (var ksym) '%s': incompatible types\n", ext->name);
+		return -EINVAL;
+	}
+
+	ext->is_set = true;
+	ext->ksym.kernel_btf_obj_fd = mod_btf ? mod_btf->fd : 0;
+	ext->ksym.kernel_btf_id = id;
+
+	return 0;
+}
+
+static int resolve_ksym_func_btf_id(struct bpf_obj *obj, struct bpf_extern_desc *ext)
+{
+	int local_func_proto_id, kfunc_proto_id, kfunc_id;
+	struct bpf_module_btf *mod_btf = NULL;
+	const struct btf_type *kern_func;
+	struct btf *kern_btf = NULL;
+	int ret;
+
+	local_func_proto_id = ext->ksym.type_id;
+
+	kfunc_id = find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
+				    &mod_btf);
+	if (kfunc_id < 0) {
+		if (kfunc_id == -ESRCH && ext->is_weak)
+			return 0;
+		pr_warn("extern (func ksym) '%s': not found in kernel or module BTFs\n",
+			ext->name);
+		return kfunc_id;
+	}
+
+	kern_func = btf_type_by_id(kern_btf, kfunc_id);
+	kfunc_proto_id = kern_func->type;
+
+	ret = bpf_core_types_are_compat(obj->btf, local_func_proto_id,
+					kern_btf, kfunc_proto_id);
+	if (ret <= 0) {
+		if (ext->is_weak)
+			return 0;
+
+		pr_warn("extern (func ksym) '%s': func_proto [%d] incompatible with [%d]\n",
+			ext->name, local_func_proto_id,
+			kfunc_proto_id);
+		return -EINVAL;
+	}
+
+	ext->is_set = true;
+	ext->ksym.kernel_btf_id = kfunc_id;
+	ext->ksym.btf_fd_idx = mod_btf ? mod_btf->fd_array_idx : 0;
+
+	/* Also set kernel_btf_obj_fd to make sure that bpf_object__relocate_data()
+	 * populates FD into ld_imm64 insn when it's used to point to kfunc.
+	 * {kernel_btf_id, btf_fd_idx} -> fixup bpf_call.
+	 * {kernel_btf_id, kernel_btf_obj_fd} -> fixup ld_imm64.
+	 */
+	ext->ksym.kernel_btf_obj_fd = mod_btf ? mod_btf->fd : 0;
+
+	return 0;
+}
+
+static int resolve_externs(struct bpf_obj *obj)
+{
+	struct bpf_extern_desc *ext;
+	int err, i;
+	const struct btf_type *t;
+	unsigned long addr;
+
+	for (i = 0; i < obj->nr_extern; i++) {
+		ext = &obj->externs[i];
+
+		if (ext->type == EXT_KSYM) {
+			if (ext->ksym.type_id) {
+				t = btf_type_by_id(obj->btf, ext->btf_id);
+				if (btf_kind(t) == BTF_KIND_VAR)
+					err = resolve_ksym_var_btf_id(obj, ext);
+				else
+					err = resolve_ksym_func_btf_id(obj, ext);
+				if (err)
+					return err;
+			} else {
+				addr = kallsyms_lookup_name(ext->name);
+				if (addr > 0) {
+					ext->is_set = true;
+					ext->ksym.addr = addr;
+				}
+			}
+		} else if (ext->type == EXT_KCFG) {
+			pr_debug("extern (kcfg) '%s': loading from offset %d\n",
+				 ext->name, ext->kcfg.data_off);
+			ext->is_set = true;
+		} else {
+			pr_warn("extern '%s': unrecognized extern kind\n", ext->name);
+			return -EINVAL;
+		}
+	}
+
+	for (i = 0; i < obj->nr_extern; i++) {
+		ext = &obj->externs[i];
+
+		if (!ext->is_set && !ext->is_weak) {
+			pr_warn("extern '%s' (strong): not resolved\n", ext->name);
+			return -ESRCH;
+		} else if (!ext->is_set) {
+			pr_debug("extern '%s' (weak): not resolved, defaulting to zero\n",
+				 ext->name);
+		}
+	}
+
+
+	return 0;
+}
+
 static void free_bpf_obj(struct bpf_obj *obj)
 {
 	int i;
@@ -7314,6 +7484,10 @@ static int load_fd(union bpf_attr *attr)
 	if (err < 0)
 		goto free;
 
+	err = resolve_externs(obj);
+	if (err < 0)
+		goto free;
+
 	return obj_f;
 free:
 	free_bpf_obj(obj);
-- 
2.47.1


