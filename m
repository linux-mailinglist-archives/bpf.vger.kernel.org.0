Return-Path: <bpf+bounces-44278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 059719C0D47
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 18:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84DD284CFC
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719B215F58;
	Thu,  7 Nov 2024 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbyeI1KW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939E02170B6
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001880; cv=none; b=EhUD2Ran1LAFrLe6JO8vIGWy/ozRlATA+tVnsF13dIGtNyr/4RAAk2DuLr+7hPYwq9f/FcsOnV0lyU/xmvfMYBdEVuq+tl8aNdRtMozyCu5dopjXAFIvsh6dfJGnQn+4c+Qds3jVHcx0+4Yme8r26kaVqQk7uNrzJmrXicIP6BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001880; c=relaxed/simple;
	bh=zeu5CoeZ6YG19S6x/7xeMq/t6BpE4FA9A9EaXljstfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCyRbHJS8o8YcI6hKznonnqDC9uMzCsVBaBxfEU5U+lInPQJPnQSPgK/EZKXhihQUwPGm2bE57veMswA47b2XQXpKBWxxV7yw5y/QomoRooiDWjjtQrIgw95ZWSgQkt7Tcz/LqmvDrsv3jh/WXefDlOJsrIrFBlJVWC96SYSejM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbyeI1KW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-72041ff06a0so1030245b3a.2
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 09:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731001877; x=1731606677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fxJmOy6+0tWZzzcdyBVrKD6ZybF4WhAuAj/x9zlCLI=;
        b=hbyeI1KW35AOCitNLDefx+gbZlpxo9KQCOo3tGl/JNyeIFNkpAIPAllx8OX/jJrC8o
         rA/vKGpwxhdC19ntBQIfDxz7l1WxGjKeYnt7otchIGNiTV7fJg4yfdrDHYGzqcOWflku
         sOMh+VAcihdhXmRvHp+iq8y+OFRuopDVOfqkF5hrZ/H2SP2JyuMquJvxys+EdmroonRB
         NGAaf4ZPFBIDtVcG7tbe9I1470+pBXw+xtXuVhGeMNtlWUGPpDiyf6/vUe3PyX41jyOo
         s6ERG3xFYSIrppHkVKrmrMaHVkEVHIlOEtMBgz5YfqaohcHic+mAkTYvzbC0lU6iQ3oy
         1iMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731001877; x=1731606677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fxJmOy6+0tWZzzcdyBVrKD6ZybF4WhAuAj/x9zlCLI=;
        b=G8K9Mi3ETvfRwDB5TVxmX/oh2a663bHlGrSpASfxudgFx7QBm2hDnAIwC+/4T2MdqV
         ZHw8BBRNWe8VTrhXRlpJCm/40tV31/+haYmunSu0/6kLUrtbUu2tEw5oWRjHyKN+g3u0
         BCbuO4ziesen0BLEhNLZJ/y4iRLe8mc6allmm5sOBBHsBRpITlTLoCchQZfdS8TaLSRA
         MAldq0iWBqWKwQ6CLWjJHEHGciNucZ4MYSj687Vy31krmTOUMA2WtZIYwi61FXLZ2brK
         4rgLgqR382afbLxwV51Us16M0NlvOLt/bRMZXhHm77tquPqUmV0QfA/Nqq4TI35L3dhY
         rx7Q==
X-Gm-Message-State: AOJu0YzxMywL/kX1PWSLK2YWsHXRUA5wMKrD9/QsKHFdCtI4JIVP/dPC
	zMUr0tjoz94jbC6898ssTgpWKFKORMYcyKPAwJQprQqJPVJkguPoS7vgHIXP
X-Google-Smtp-Source: AGHT+IGv+kMB3Xar4bWNEdoU+zSfMLmEkXXOHh3LG+1Ts8cGiR0pVEcH+5sOAGMIXEAuxEMMiQ+r7w==
X-Received: by 2002:a05:6a20:4311:b0:1db:e96f:4472 with SMTP id adf61e73a8af0-1dc20626f0cmr568186637.31.1731001876730;
        Thu, 07 Nov 2024 09:51:16 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f52b32sm1730686a91.5.2024.11.07.09.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:51:16 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 04/11] bpf: allow specifying inlinable kfuncs in modules
Date: Thu,  7 Nov 2024 09:50:33 -0800
Message-ID: <20241107175040.1659341-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107175040.1659341-1-eddyz87@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of keeping inlinable kfuncs in a single table,
track them as a list of tables, one table per each module providing
such kfuncs. Protect the list with an rwlock to safely deal with
modules load/unload.

Provide two interface functions for use in modules:
- int bpf_register_inlinable_kfuncs(void *elf_bin, u32 size,
                                    struct module *module);
- void bpf_unregister_inlinable_kfuncs(struct module *module);

With an assumption that each module providing inlinable kfuncs would
include BPF elf in the same way verifier.c does, with
bpf_register_inlinable_kfuncs() called at load.
The bpf_unregister_inlinable_kfuncs() is supposed to be called before
module unload.

Each table holds a reference to btf, the refcount of the btf object is
not hold by the table. For lifetime management of module's btf object
relies on:
- correct usage of bpf_register_inlinable_kfuncs /
  bpf_unregister_inlinable_kfuncs to insert/remove tables to the list,
  so that tables are members of the list only when module is loaded;
- add_kfunc_call(), so that kfuncs referenced from inlined bodies are
  not unloaded when inlinable kfunc is inlined.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h   |   3 +
 include/linux/btf.h   |   7 +++
 kernel/bpf/btf.c      |   2 +-
 kernel/bpf/verifier.c | 129 +++++++++++++++++++++++++++++++++++-------
 4 files changed, 119 insertions(+), 22 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1b84613b10ac..2bcc9161687b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3501,4 +3501,7 @@ static inline bool bpf_prog_is_raw_tp(const struct bpf_prog *prog)
 	       prog->expected_attach_type == BPF_TRACE_RAW_TP;
 }
 
+void bpf_unregister_inlinable_kfuncs(struct module *module);
+int bpf_register_inlinable_kfuncs(void *elf_bin, u32 size, struct module *module);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 4214e76c9168..9e8b27493139 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -582,6 +582,7 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
 bool btf_types_are_same(const struct btf *btf1, u32 id1,
 			const struct btf *btf2, u32 id2);
 int btf_check_iter_arg(struct btf *btf, const struct btf_type *func, int arg_idx);
+struct btf *btf_get_module_btf(const struct module *module);
 
 static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
 {
@@ -670,5 +671,11 @@ static inline int btf_check_iter_arg(struct btf *btf, const struct btf_type *fun
 {
 	return -EOPNOTSUPP;
 }
+struct btf *btf_get_module_btf(const struct module *module)
+{
+	return NULL;
+}
+
 #endif
+
 #endif
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e7a59e6462a9..49b25882fa58 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8033,7 +8033,7 @@ struct module *btf_try_get_module(const struct btf *btf)
 /* Returns struct btf corresponding to the struct module.
  * This function can return NULL or ERR_PTR.
  */
-static struct btf *btf_get_module_btf(const struct module *module)
+struct btf *btf_get_module_btf(const struct module *module)
 {
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	struct btf_module *btf_mod, *tmp;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fbf51147f319..b86308896358 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20534,7 +20534,20 @@ struct inlinable_kfunc {
 	u32 btf_id;
 };
 
-static struct inlinable_kfunc inlinable_kfuncs[16];
+/* Represents inlinable kfuncs provided by a module */
+struct inlinable_kfuncs_block {
+	struct list_head list;
+	/* Module or kernel BTF, refcount not taken. Relies on correct
+         * calls to bpf_[un]register_inlinable_kfuncs to guarantee BTF
+         * object lifetime.
+	 */
+	const struct btf *btf;
+	struct inlinable_kfunc funcs[16];
+};
+
+/* List of inlinable_kfuncs_block objects. */
+static struct list_head inlinable_kfuncs = LIST_HEAD_INIT(inlinable_kfuncs);
+static DEFINE_RWLOCK(inlinable_kfuncs_lock);
 
 static void *check_inlinable_kfuncs_ptr(struct blob *blob,
 				      void *ptr, u64 size, const char *context)
@@ -20710,8 +20723,10 @@ static int inlinable_kfuncs_parse_sections(struct blob *blob, struct sh_elf_sect
 			if (strcmp(name, ".text") == 0) {
 				text = shdr;
 				text_idx = i;
-			} else if (strcmp(name, ".BTF") == 0 || strcmp(name, ".BTF.ext") == 0) {
-				/* ignore BTF for now */
+			} else if (strcmp(name, ".BTF") == 0 ||
+				   strcmp(name, ".BTF.ext") == 0 ||
+				   strcmp(name, ".modinfo") == 0) {
+				/* ignore */
 				break;
 			} else {
 				printk("malformed inlinable kfuncs data: unexpected section #%u name ('%s')\n",
@@ -20841,27 +20856,35 @@ static int inlinable_kfuncs_apply_relocs(struct sh_elf_sections *s, struct btf *
  * Do some sanity checks for ELF data structures,
  * (but refrain from being overly paranoid, as this ELF is a part of kernel build).
  */
-static int bpf_register_inlinable_kfuncs(void *elf_bin, u32 size)
+int bpf_register_inlinable_kfuncs(void *elf_bin, u32 size, struct module *module)
 {
 	struct blob blob = { .mem = elf_bin, .size = size };
+	struct inlinable_kfuncs_block *block = NULL;
 	struct sh_elf_sections s;
 	struct btf *btf;
 	Elf_Sym *sym;
 	u32 i, idx;
 	int err;
 
-	btf = bpf_get_btf_vmlinux();
+	btf = btf_get_module_btf(module);
 	if (!btf)
 		return -EINVAL;
 
 	err = inlinable_kfuncs_parse_sections(&blob, &s);
 	if (err < 0)
-		return err;
+		goto err_out;
 
 	err = inlinable_kfuncs_apply_relocs(&s, btf);
 	if (err < 0)
-		return err;
+		goto err_out;
+
+	block = kvmalloc(sizeof(*block), GFP_KERNEL | __GFP_ZERO);
+	if (!block) {
+		err = -ENOMEM;
+		goto err_out;
+	}
 
+	block->btf = btf;
 	idx = 0;
 	for (sym = s.sym, i = 0; i < s.sym_cnt; i++, sym++) {
 		struct inlinable_kfunc *sh;
@@ -20879,11 +20902,13 @@ static int bpf_register_inlinable_kfuncs(void *elf_bin, u32 size)
 		    sym->st_value % sizeof(struct bpf_insn) != 0 ||
 		    sym->st_name >= s.strings_sz) {
 			printk("malformed inlinable kfuncs data: bad symbol #%u\n", i);
-			return -EINVAL;
+			err = -EINVAL;
+			goto err_out;
 		}
-		if (idx == ARRAY_SIZE(inlinable_kfuncs) - 1) {
+		if (idx == ARRAY_SIZE(block->funcs) - 1) {
 			printk("malformed inlinable kfuncs data: too many helper functions\n");
-			return -EINVAL;
+			err = -EINVAL;
+			goto err_out;
 		}
 		insn_num = sym->st_size / sizeof(struct bpf_insn);
 		insns = s.text + sym->st_value;
@@ -20891,9 +20916,10 @@ static int bpf_register_inlinable_kfuncs(void *elf_bin, u32 size)
 		id = btf_find_by_name_kind(btf, name, BTF_KIND_FUNC);
 		if (id < 0) {
 			printk("can't add inlinable kfunc '%s': no btf_id\n", name);
-			return -EINVAL;
+			err = -EINVAL;
+			goto err_out;
 		}
-		sh = &inlinable_kfuncs[idx++];
+		sh = &block->funcs[idx++];
 		sh->insn_num = insn_num;
 		sh->insns = insns;
 		sh->name = name;
@@ -20902,25 +20928,86 @@ static int bpf_register_inlinable_kfuncs(void *elf_bin, u32 size)
 		       sh->name, sym->st_value, sh->insn_num, sh->btf_id);
 	}
 
+	write_lock(&inlinable_kfuncs_lock);
+	list_add(&block->list, &inlinable_kfuncs);
+	write_unlock(&inlinable_kfuncs_lock);
+	if (module)
+		btf_put(btf);
 	return 0;
+
+err_out:
+	kvfree(block);
+	if (module)
+		btf_put(btf);
+	return err;
+}
+EXPORT_SYMBOL_GPL(bpf_register_inlinable_kfuncs);
+
+void bpf_unregister_inlinable_kfuncs(struct module *module)
+{
+	struct inlinable_kfuncs_block *block;
+	struct list_head *pos;
+	struct btf *btf;
+
+	btf = btf_get_module_btf(module);
+	if (!btf)
+		return;
+
+	write_lock(&inlinable_kfuncs_lock);
+	list_for_each(pos, &inlinable_kfuncs) {
+		if (pos == &inlinable_kfuncs)
+			continue;
+		block = container_of(pos, typeof(*block), list);
+		if (block->btf != btf)
+			continue;
+		list_del(&block->list);
+		kvfree(block);
+		break;
+	}
+	write_unlock(&inlinable_kfuncs_lock);
+	btf_put(btf);
 }
+EXPORT_SYMBOL_GPL(bpf_unregister_inlinable_kfuncs);
 
 static int __init inlinable_kfuncs_init(void)
 {
 	return bpf_register_inlinable_kfuncs(&inlinable_kfuncs_data,
-					   &inlinable_kfuncs_data_end - &inlinable_kfuncs_data);
+					     &inlinable_kfuncs_data_end - &inlinable_kfuncs_data,
+					     NULL);
 }
 
 late_initcall(inlinable_kfuncs_init);
 
-static struct inlinable_kfunc *find_inlinable_kfunc(u32 btf_id)
+/* If a program refers to a kfunc from some module, this module is guaranteed
+ * to not be unloaded for the duration of program verification.
+ * Hence there is no need to protect returned 'inlinable_kfunc' instance,
+ * as long as find_inlinable_kfunc() is called during program verification.
+ * However, read_lock(&inlinable_kfuncs_lock) for the duration of this
+ * function is necessary in case some unrelated modules are loaded/unloaded
+ * concurrently to find_inlinable_kfunc() call.
+ */
+static struct inlinable_kfunc *find_inlinable_kfunc(struct btf *btf, u32 btf_id)
 {
-	struct inlinable_kfunc *sh = inlinable_kfuncs;
+	struct inlinable_kfuncs_block *block;
+	struct inlinable_kfunc *sh;
+	struct list_head *pos;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(inlinable_kfuncs); ++i, ++sh)
-		if (sh->btf_id == btf_id)
+	read_lock(&inlinable_kfuncs_lock);
+	list_for_each(pos, &inlinable_kfuncs) {
+		block = container_of(pos, typeof(*block), list);
+		if (block->btf != btf)
+			continue;
+		sh = block->funcs;
+		for (i = 0; i < ARRAY_SIZE(block->funcs); ++i, ++sh) {
+			if (sh->btf_id != btf_id)
+				continue;
+			read_unlock(&inlinable_kfuncs_lock);
 			return sh;
+		}
+		break;
+	}
+	read_unlock(&inlinable_kfuncs_lock);
 	return NULL;
 }
 
@@ -20933,7 +21020,7 @@ static struct bpf_prog *inline_kfunc_call(struct bpf_verifier_env *env, struct b
 					  int insn_idx, int *cnt, s32 stack_base, u16 *stack_depth_extra)
 {
 	struct inlinable_kfunc_regs_usage regs_usage;
-	const struct bpf_kfunc_desc *desc;
+	struct bpf_kfunc_call_arg_meta meta;
 	struct bpf_prog *new_prog;
 	struct bpf_insn *insn_buf;
 	struct inlinable_kfunc *sh;
@@ -20943,10 +21030,10 @@ static struct bpf_prog *inline_kfunc_call(struct bpf_verifier_env *env, struct b
 	s16 stack_off;
 	u32 insn_num;
 
-	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
-	if (!desc || IS_ERR(desc))
+	err = fetch_kfunc_meta(env, insn, &meta, NULL);
+	if (err < 0)
 		return ERR_PTR(-EFAULT);
-	sh = find_inlinable_kfunc(desc->func_id);
+	sh = find_inlinable_kfunc(meta.btf, meta.func_id);
 	if (!sh)
 		return NULL;
 
-- 
2.47.0


