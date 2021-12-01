Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B289E4654D0
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 19:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242617AbhLASOe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 13:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352169AbhLASO1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 13:14:27 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE6BC061574
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 10:11:06 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id b68so25340524pfg.11
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 10:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GiCRjm/pJ8Ja/A7zDPE+0BODLMV4x7Me8yMCdneF5Og=;
        b=bXkBseGR2kKgODQFg52ailcFOvcdRJd0fVxLaFBsExU5IKfEepVPkzYoOYUwo2PIUQ
         tdg9rJ/RbuV381svpOLOcKlEEY8C1M08UoIEhd1MGSG0YV0bafwkikexNluoW8JQ/J1y
         vwwBPYi2xYEkm54v1qacxYBvaYb62bdfXCYcX2zk4dSPWqUfBkd4l6YstitqVFFnhXzT
         PAlDTbW21iDuZ0zmvebEMgvmXGvubR0Zmw2jCt3zuXtrTqnc30kSOGUzNaSYf0bigX88
         AUBJb09oY6BBdJdYocBNIEgxjyd5kUFeyeo6MDIv60EG+myHWF2UKi0zr8NPS4bGvSbR
         NJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GiCRjm/pJ8Ja/A7zDPE+0BODLMV4x7Me8yMCdneF5Og=;
        b=UsF7LGXvRgXd2zU2oChmkJcsRB2yjL37FM8H+0eGIUrkwpM6FWekTRcfAKtaq9Fl1Z
         6ZcuWyJmC/dljBevrQBSEj6ZmiNLcLzi9U3wSfTkysziawlLjUL76PsBlZkz9PSSitk3
         P7Z8gfXQTKCAJaudjP1sqcaFdghcW+MjA1a6k5+8qizLykyGKMVbRG527WKjwGu+Gg1g
         LrLbHdZkGVPFc4+zAC9wbY1tKi+qt+ZJzOyZJ1xgq6hh8Rya5W+TyUqR8BLwQdPsMrSF
         jOYk8d2bjhOypMrbQttwWVEtxRI/Osw5ImY9bBF47Btuk+gmzfmwPYKwQfHkqkmikK3+
         8hoQ==
X-Gm-Message-State: AOAM532AfXT/xJYlrdH4XJQs+pE6SPP3L7IRP47+xetax65EoJcg6ETc
        /jw/URDebJuGVg6nMgyOEsLWeAYs7gk=
X-Google-Smtp-Source: ABdhPJxL4ModcRm2AAioC1G86nFYjoTJYjTU0iyLOO1A38jHHcCtzaYGuXanTMCCeghf+1/H+M5xSQ==
X-Received: by 2002:a05:6a00:cc9:b0:49f:b439:8930 with SMTP id b9-20020a056a000cc900b0049fb4398930mr7658964pfv.86.1638382265792;
        Wed, 01 Dec 2021 10:11:05 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:620c])
        by smtp.gmail.com with ESMTPSA id s19sm475924pfu.104.2021.12.01.10.11.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 10:11:04 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 bpf-next 08/17] bpf: Add bpf_core_add_cands() and wire it into bpf_core_apply_relo_insn().
Date:   Wed,  1 Dec 2021 10:10:31 -0800
Message-Id: <20211201181040.23337-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Given BPF program's BTF root type name perform the following steps:
. search in vmlinux candidate cache.
. if (present in cache and candidate list >= 1) return candidate list.
. do a linear search through kernel BTFs for possible candidates.
. regardless of number of candidates found populate vmlinux cache.
. if (candidate list >= 1) return candidate list.
. search in module candidate cache.
. if (present in cache) return candidate list (even if list is empty).
. do a linear search through BTFs of all kernel modules
  collecting candidates from all of them.
. regardless of number of candidates found populate module cache.
. return candidate list.
Then wire the result into bpf_core_apply_relo_insn().

When BPF program is trying to CO-RE relocate a type
that doesn't exist in either vmlinux BTF or in modules BTFs
these steps will perform 2 cache lookups when cache is hit.

Note the cache doesn't prevent the abuse by the program that might
have lots of relocations that cannot be resolved. Hence cond_resched().

CO-RE in the kernel requires CAP_BPF, since BTF loading requires it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 346 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 345 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index dbf1f389b1d3..ed4258cb0832 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -25,6 +25,7 @@
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
 #include <net/sock.h>
+#include "../tools/lib/bpf/relo_core.h"
 
 /* BTF (BPF Type Format) is the meta data format which describes
  * the data types of BPF program/map.  Hence, it basically focus
@@ -6169,6 +6170,8 @@ btf_module_read(struct file *file, struct kobject *kobj,
 	return len;
 }
 
+static void purge_cand_cache(struct btf *btf);
+
 static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			     void *module)
 {
@@ -6203,6 +6206,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			goto out;
 		}
 
+		purge_cand_cache(NULL);
 		mutex_lock(&btf_module_mutex);
 		btf_mod->module = module;
 		btf_mod->btf = btf;
@@ -6245,6 +6249,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			list_del(&btf_mod->list);
 			if (btf_mod->sysfs_attr)
 				sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
+			purge_cand_cache(btf_mod->btf);
 			btf_put(btf_mod->btf);
 			kfree(btf_mod->sysfs_attr);
 			kfree(btf_mod);
@@ -6440,8 +6445,347 @@ size_t bpf_core_essential_name_len(const char *name)
 	return n;
 }
 
+struct bpf_cand_cache {
+	const char *name;
+	u32 name_len;
+	u16 kind;
+	u16 cnt;
+	struct {
+		const struct btf *btf;
+		u32 id;
+	} cands[];
+};
+
+static void bpf_free_cands(struct bpf_cand_cache *cands)
+{
+	if (!cands->cnt)
+		/* empty candidate array was allocated on stack */
+		return;
+	kfree(cands);
+}
+
+static void bpf_free_cands_from_cache(struct bpf_cand_cache *cands)
+{
+	kfree(cands->name);
+	kfree(cands);
+}
+
+#define VMLINUX_CAND_CACHE_SIZE 31
+static struct bpf_cand_cache *vmlinux_cand_cache[VMLINUX_CAND_CACHE_SIZE];
+
+#define MODULE_CAND_CACHE_SIZE 31
+static struct bpf_cand_cache *module_cand_cache[MODULE_CAND_CACHE_SIZE];
+
+static DEFINE_MUTEX(cand_cache_mutex);
+
+static void __print_cand_cache(struct bpf_verifier_log *log,
+			       struct bpf_cand_cache **cache,
+			       int cache_size)
+{
+	struct bpf_cand_cache *cc;
+	int i, j;
+
+	for (i = 0; i < cache_size; i++) {
+		cc = cache[i];
+		if (!cc)
+			continue;
+		bpf_log(log, "[%d]%s(", i, cc->name);
+		for (j = 0; j < cc->cnt; j++) {
+			bpf_log(log, "%d", cc->cands[j].id);
+			if (j < cc->cnt - 1)
+				bpf_log(log, " ");
+		}
+		bpf_log(log, "), ");
+	}
+}
+
+static void print_cand_cache(struct bpf_verifier_log *log)
+{
+	mutex_lock(&cand_cache_mutex);
+	bpf_log(log, "vmlinux_cand_cache:");
+	__print_cand_cache(log, vmlinux_cand_cache, VMLINUX_CAND_CACHE_SIZE);
+	bpf_log(log, "\nmodule_cand_cache:");
+	__print_cand_cache(log, module_cand_cache, MODULE_CAND_CACHE_SIZE);
+	bpf_log(log, "\n");
+	mutex_unlock(&cand_cache_mutex);
+}
+
+static u32 hash_cands(struct bpf_cand_cache *cands)
+{
+	return jhash(cands->name, cands->name_len, 0);
+}
+
+static struct bpf_cand_cache *check_cand_cache(struct bpf_cand_cache *cands,
+					       struct bpf_cand_cache **cache,
+					       int cache_size)
+{
+	struct bpf_cand_cache *cc = cache[hash_cands(cands) % cache_size];
+
+	if (cc && cc->name_len == cands->name_len &&
+	    !strncmp(cc->name, cands->name, cands->name_len))
+		return cc;
+	return NULL;
+}
+
+static size_t sizeof_cands(int cnt)
+{
+	return offsetof(struct bpf_cand_cache, cands[cnt]);
+}
+
+static struct bpf_cand_cache *populate_cand_cache(struct bpf_cand_cache *cands,
+						  struct bpf_cand_cache **cache,
+						  int cache_size)
+{
+	struct bpf_cand_cache **cc = &cache[hash_cands(cands) % cache_size], *new_cands;
+
+	if (*cc) {
+		bpf_free_cands_from_cache(*cc);
+		*cc = NULL;
+	}
+	new_cands = kmalloc(sizeof_cands(cands->cnt), GFP_KERNEL);
+	if (!new_cands) {
+		bpf_free_cands(cands);
+		return ERR_PTR(-ENOMEM);
+	}
+	memcpy(new_cands, cands, sizeof_cands(cands->cnt));
+	/* strdup the name, since it will stay in cache.
+	 * the cands->name points to strings in prog's BTF and the prog can be unloaded.
+	 */
+	new_cands->name = kmemdup_nul(cands->name, cands->name_len, GFP_KERNEL);
+	bpf_free_cands(cands);
+	if (!new_cands->name) {
+		kfree(new_cands);
+		return ERR_PTR(-ENOMEM);
+	}
+	*cc = new_cands;
+	return new_cands;
+}
+
+static void __purge_cand_cache(struct btf *btf, struct bpf_cand_cache **cache,
+			       int cache_size)
+{
+	struct bpf_cand_cache *cc;
+	int i, j;
+
+	for (i = 0; i < cache_size; i++) {
+		cc = cache[i];
+		if (!cc)
+			continue;
+		if (!btf) {
+			/* when new module is loaded purge all of module_cand_cache,
+			 * since new module might have candidates with the name
+			 * that matches cached cands.
+			 */
+			bpf_free_cands_from_cache(cc);
+			cache[i] = NULL;
+			continue;
+		}
+		/* when module is unloaded purge cache entries
+		 * that match module's btf
+		 */
+		for (j = 0; j < cc->cnt; j++)
+			if (cc->cands[j].btf == btf) {
+				bpf_free_cands_from_cache(cc);
+				cache[i] = NULL;
+				break;
+			}
+	}
+
+}
+
+static void purge_cand_cache(struct btf *btf)
+{
+	mutex_lock(&cand_cache_mutex);
+	__purge_cand_cache(btf, module_cand_cache, MODULE_CAND_CACHE_SIZE);
+	mutex_unlock(&cand_cache_mutex);
+}
+
+static struct bpf_cand_cache *
+bpf_core_add_cands(struct bpf_cand_cache *cands, const struct btf *targ_btf,
+		   int targ_start_id)
+{
+	struct bpf_cand_cache *new_cands;
+	const struct btf_type *t;
+	const char *targ_name;
+	size_t targ_essent_len;
+	int n, i;
+
+	n = btf_nr_types(targ_btf);
+	for (i = targ_start_id; i < n; i++) {
+		t = btf_type_by_id(targ_btf, i);
+		if (btf_kind(t) != cands->kind)
+			continue;
+
+		targ_name = btf_name_by_offset(targ_btf, t->name_off);
+		if (!targ_name)
+			continue;
+
+		/* the resched point is before strncmp to make sure that search
+		 * for non-existing name will have a chance to schedule().
+		 */
+		cond_resched();
+
+		if (strncmp(cands->name, targ_name, cands->name_len) != 0)
+			continue;
+
+		targ_essent_len = bpf_core_essential_name_len(targ_name);
+		if (targ_essent_len != cands->name_len)
+			continue;
+
+		/* most of the time there is only one candidate for a given kind+name pair */
+		new_cands = kmalloc(sizeof_cands(cands->cnt + 1), GFP_KERNEL);
+		if (!new_cands) {
+			bpf_free_cands(cands);
+			return ERR_PTR(-ENOMEM);
+		}
+
+		memcpy(new_cands, cands, sizeof_cands(cands->cnt));
+		bpf_free_cands(cands);
+		cands = new_cands;
+		cands->cands[cands->cnt].btf = targ_btf;
+		cands->cands[cands->cnt].id = i;
+		cands->cnt++;
+	}
+	return cands;
+}
+
+static struct bpf_cand_cache *
+bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
+{
+	struct bpf_cand_cache *cands, *cc, local_cand = {};
+	const struct btf *local_btf = ctx->btf;
+	const struct btf_type *local_type;
+	const struct btf *main_btf;
+	size_t local_essent_len;
+	struct btf *mod_btf;
+	const char *name;
+	int id;
+
+	main_btf = bpf_get_btf_vmlinux();
+	if (IS_ERR(main_btf))
+		return (void *)main_btf;
+
+	local_type = btf_type_by_id(local_btf, local_type_id);
+	if (!local_type)
+		return ERR_PTR(-EINVAL);
+
+	name = btf_name_by_offset(local_btf, local_type->name_off);
+	if (str_is_empty(name))
+		return ERR_PTR(-EINVAL);
+	local_essent_len = bpf_core_essential_name_len(name);
+
+	cands = &local_cand;
+	cands->name = name;
+	cands->kind = btf_kind(local_type);
+	cands->name_len = local_essent_len;
+
+	cc = check_cand_cache(cands, vmlinux_cand_cache, VMLINUX_CAND_CACHE_SIZE);
+	/* cands is a pointer to stack here */
+	if (cc) {
+		if (cc->cnt)
+			return cc;
+		goto check_modules;
+	}
+
+	/* Attempt to find target candidates in vmlinux BTF first */
+	cands = bpf_core_add_cands(cands, main_btf, 1);
+	if (IS_ERR(cands))
+		return cands;
+
+	/* cands is a pointer to kmalloced memory here if cands->cnt > 0 */
+
+	/* populate cache even when cands->cnt == 0 */
+	cc = populate_cand_cache(cands, vmlinux_cand_cache, VMLINUX_CAND_CACHE_SIZE);
+	if (IS_ERR(cc))
+		return cc;
+
+	/* if vmlinux BTF has any candidate, don't go for module BTFs */
+	if (cc->cnt)
+		return cc;
+
+check_modules:
+	/* cands is a pointer to stack here and cands->cnt == 0 */
+	cc = check_cand_cache(cands, module_cand_cache, MODULE_CAND_CACHE_SIZE);
+	if (cc)
+		/* if cache has it return it even if cc->cnt == 0 */
+		return cc;
+
+	/* If candidate is not found in vmlinux's BTF then search in module's BTFs */
+	spin_lock_bh(&btf_idr_lock);
+	idr_for_each_entry(&btf_idr, mod_btf, id) {
+		if (!btf_is_module(mod_btf))
+			continue;
+		/* linear search could be slow hence unlock/lock
+		 * the IDR to avoiding holding it for too long
+		 */
+		btf_get(mod_btf);
+		spin_unlock_bh(&btf_idr_lock);
+		cands = bpf_core_add_cands(cands, mod_btf, btf_nr_types(main_btf));
+		if (IS_ERR(cands)) {
+			btf_put(mod_btf);
+			return cands;
+		}
+		spin_lock_bh(&btf_idr_lock);
+		btf_put(mod_btf);
+	}
+	spin_unlock_bh(&btf_idr_lock);
+	/* cands is a pointer to kmalloced memory here if cands->cnt > 0
+	 * or pointer to stack if cands->cnd == 0.
+	 * Copy it into the cache even when cands->cnt == 0 and
+	 * return the result.
+	 */
+	return populate_cand_cache(cands, module_cand_cache, MODULE_CAND_CACHE_SIZE);
+}
+
 int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 		   int relo_idx, void *insn)
 {
-	return -EOPNOTSUPP;
+	bool need_cands = relo->kind != BPF_CORE_TYPE_ID_LOCAL;
+	struct bpf_core_cand_list cands = {};
+	int err;
+
+	if (need_cands) {
+		struct bpf_cand_cache *cc;
+		int i;
+
+		mutex_lock(&cand_cache_mutex);
+		cc = bpf_core_find_cands(ctx, relo->type_id);
+		if (IS_ERR(cc)) {
+			bpf_log(ctx->log, "target candidate search failed for %d\n",
+				relo->type_id);
+			err = PTR_ERR(cc);
+			goto out;
+		}
+		if (cc->cnt) {
+			cands.cands = kcalloc(cc->cnt, sizeof(*cands.cands), GFP_KERNEL);
+			if (!cands.cands) {
+				err = -ENOMEM;
+				goto out;
+			}
+		}
+		for (i = 0; i < cc->cnt; i++) {
+			bpf_log(ctx->log,
+				"CO-RE relocating %s %s: found target candidate [%d]\n",
+				btf_kind_str[cc->kind], cc->name, cc->cands[i].id);
+			cands.cands[i].btf = cc->cands[i].btf;
+			cands.cands[i].id = cc->cands[i].id;
+		}
+		cands.len = cc->cnt;
+		/* cand_cache_mutex needs to span the cache lookup and
+		 * copy of btf pointer into bpf_core_cand_list,
+		 * since module can be unloaded while bpf_core_apply_relo_insn
+		 * is working with module's btf.
+		 */
+	}
+
+	err = bpf_core_apply_relo_insn((void *)ctx->log, insn, relo->insn_off / 8,
+				       relo, relo_idx, ctx->btf, &cands);
+out:
+	if (need_cands) {
+		kfree(cands.cands);
+		mutex_unlock(&cand_cache_mutex);
+		if (ctx->log->level & BPF_LOG_LEVEL2)
+			print_cand_cache(ctx->log);
+	}
+	return err;
 }
-- 
2.30.2

