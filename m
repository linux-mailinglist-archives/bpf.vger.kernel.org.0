Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED6C45B41F
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 07:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbhKXGFn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 01:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbhKXGFl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 01:05:41 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A574C061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:32 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso1637137pjb.2
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pQiEpPyUxWvAvdgFcjV7smO1Qx5bKjPnN6iMSyMXcEQ=;
        b=a3AAufnRTyTkQXo8HY6CMCjDOJsduS68MCeqfoJHAAUxSnS99VvE9ysQ7TGiRXvDLu
         09BUyRk2ejxrNOilfFVf8Tb2OUhYi99ZM+4M3bGXK3r/dYLZGXX1u01vtRDhixiP013x
         FuodSXp8OTTyLBKAaP/SN94FHjeiMU5ae7K6oDez0CHhGbNKv2Y3pljwyQbxiQTgmn9/
         f2ZT1EEn79Z22qqUQo2dvfmFru+uhasSRHn1avdpLx4SveKHroPkEbyPRLCyVJr8BDgX
         5llvCv1/g4Vk2kMKivpJbniFliLnJOgiOm8M3C0CkdrL/K32QYYHEMQOHRqJHgSRBHNI
         5Lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pQiEpPyUxWvAvdgFcjV7smO1Qx5bKjPnN6iMSyMXcEQ=;
        b=CXU0QW2tEQjZN5s9v09g6TOj5Y3+ztwu8Gc6uqc5ShyOz9p+uqAu7QZk+REIKAD++V
         Mja7LKck7+nrviM3fJUnwRDRFBgKnZMAwKov7vySh6aGILS6BFO4I30T2zTdeHTh8NFC
         1ZisxmiSn7C1xf41uYJrqDUotj4r/aBUmajqnGiFzXn1dVpZOAjj34SyqQ2vBULnyvwY
         19/dr7SHU5iWZJVUa7EKCE1qYzxIY/sE4muKeQIxilIvLht/epqfzm7ZjtYUAsARk3S7
         Tq4HjEXBijgK6bNLDNPIzElLchrIk5JDFHEfRYwmOoT43lUYCtVM0pJXrc9WVKHYD2dC
         M/Lg==
X-Gm-Message-State: AOAM53368HsZ6uz8ghlO+XVEW4IqZv9F1wRtDpHMJnvaLynnf5MiYzgv
        TwuQElBf7U4ZOiJmqEpv1N4=
X-Google-Smtp-Source: ABdhPJytyYngW1x12lYhH6HtG30aXR7ZYtShXWCH2PTamBfRjPl+ZQBJ2BK0V7C42cRsvfqbcV1MHw==
X-Received: by 2002:a17:90b:4c4d:: with SMTP id np13mr5183884pjb.233.1637733751694;
        Tue, 23 Nov 2021 22:02:31 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:8fd1])
        by smtp.gmail.com with ESMTPSA id y190sm14898999pfg.153.2021.11.23.22.02.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 22:02:31 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 07/16] bpf: Add bpf_core_add_cands() and wire it into bpf_core_apply_relo_insn().
Date:   Tue, 23 Nov 2021 22:02:00 -0800
Message-Id: <20211124060209.493-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211124060209.493-1-alexei.starovoitov@gmail.com>
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
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
 kernel/bpf/btf.c          | 250 +++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/relo_core.h |   2 +
 2 files changed, 251 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index dbf1f389b1d3..cf971b8a0769 100644
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
@@ -6245,6 +6248,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			list_del(&btf_mod->list);
 			if (btf_mod->sysfs_attr)
 				sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
+			purge_cand_cache(btf_mod->btf);
 			btf_put(btf_mod->btf);
 			kfree(btf_mod->sysfs_attr);
 			kfree(btf_mod);
@@ -6440,8 +6444,252 @@ size_t bpf_core_essential_name_len(const char *name)
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
+static struct bpf_cand_cache *check_cand_cache(struct bpf_cand_cache *cands,
+					       struct bpf_cand_cache **cache,
+					       int cache_size)
+{
+	u32 hash = jhash_2words(cands->name_len,
+				(((u32) cands->name[0]) << 8) | cands->name[1], 0);
+	struct bpf_cand_cache *cc = cache[hash % cache_size];
+
+	if (cc && cc->name_len == cands->name_len &&
+	    !strncmp(cc->name, cands->name, cands->name_len))
+		return cc;
+	return NULL;
+}
+
+static void populate_cand_cache(struct bpf_cand_cache *cands,
+				struct bpf_cand_cache **cache,
+				int cache_size)
+{
+	u32 hash = jhash_2words(cands->name_len,
+				(((u32) cands->name[0]) << 8) | cands->name[1], 0);
+	struct bpf_cand_cache *cc = cache[hash % cache_size];
+
+	if (cc)
+		bpf_free_cands(cc);
+	cache[hash % cache_size] = cands;
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
+		for (j = 0; j < cc->cnt; j++)
+			if (cc->cands[j].btf == btf) {
+				bpf_free_cands(cc);
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
+	__purge_cand_cache(btf, vmlinux_cand_cache, VMLINUX_CAND_CACHE_SIZE);
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
+		cond_resched();
+
+		if (strncmp(cands->name, targ_name, cands->name_len) != 0)
+			continue;
+
+		targ_essent_len = bpf_core_essential_name_len(targ_name);
+		if (targ_essent_len != cands->name_len)
+			continue;
+
+		new_cands = krealloc(cands,
+				     offsetof(struct bpf_cand_cache, cands[cands->cnt + 1]),
+				     GFP_KERNEL);
+		if (!new_cands) {
+			bpf_free_cands(cands);
+			return ERR_PTR(-ENOMEM);
+		}
+
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
+	const struct btf *local_btf = ctx->btf;
+	const struct btf_type *local_type;
+	const struct btf *main_btf;
+	size_t local_essent_len;
+	struct bpf_cand_cache *cands, *cc;
+	struct btf *mod_btf;
+	const char *name;
+	int id;
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
+	cands = kcalloc(1, sizeof(*cands), GFP_KERNEL);
+	if (!cands)
+		return ERR_PTR(-ENOMEM);
+	cands->name = kmemdup_nul(name, local_essent_len, GFP_KERNEL);
+	if (!cands->name) {
+		kfree(cands);
+		return ERR_PTR(-ENOMEM);
+	}
+	cands->kind = btf_kind(local_type);
+	cands->name_len = local_essent_len;
+
+	cc = check_cand_cache(cands, vmlinux_cand_cache, VMLINUX_CAND_CACHE_SIZE);
+	if (cc) {
+		if (cc->cnt) {
+			bpf_free_cands(cands);
+			return cc;
+		}
+		goto check_modules;
+	}
+
+	/* Attempt to find target candidates in vmlinux BTF first */
+	main_btf = bpf_get_btf_vmlinux();
+	cands = bpf_core_add_cands(cands, main_btf, 1);
+	if (IS_ERR(cands))
+		return cands;
+
+	/* populate cache even when cands->cnt == 0 */
+	populate_cand_cache(cands, vmlinux_cand_cache, VMLINUX_CAND_CACHE_SIZE);
+
+	/* if vmlinux BTF has any candidate, don't go for module BTFs */
+	if (cands->cnt)
+		return cands;
+
+check_modules:
+	cc = check_cand_cache(cands, module_cand_cache, MODULE_CAND_CACHE_SIZE);
+	if (cc) {
+		bpf_free_cands(cands);
+		/* if cache has it return it even if cc->cnt == 0 */
+		return cc;
+	}
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
+	/* populate cache even when cands->cnt == 0 */
+	populate_cand_cache(cands, module_cand_cache, MODULE_CAND_CACHE_SIZE);
+	return cands;
+}
+
 int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 		   int relo_idx, void *insn)
 {
-	return -EOPNOTSUPP;
+	struct bpf_core_cand_list cands = {};
+	int err;
+
+	if (relo->kind != BPF_CORE_TYPE_ID_LOCAL) {
+		struct bpf_cand_cache *cc;
+		int i;
+
+		mutex_lock(&cand_cache_mutex);
+		cc = bpf_core_find_cands(ctx, relo->type_id);
+		if (IS_ERR(cc)) {
+			bpf_log(ctx->log, "target candidate search failed for %d\n",
+				relo->type_id);
+			return PTR_ERR(cc);
+		}
+		if (cc->cnt) {
+			cands.cands = kcalloc(cc->cnt, sizeof(*cands.cands), GFP_KERNEL);
+			if (!cands.cands)
+				return -ENOMEM;
+		}
+		for (i = 0; i < cc->cnt; i++) {
+			bpf_log(ctx->log,
+				"CO-RE relocating %s %s: found target candidate [%d]\n",
+				btf_kind_str[cc->kind], cc->name, cc->cands[i].id);
+			cands.cands[i].btf = cc->cands[i].btf;
+			cands.cands[i].id = cc->cands[i].id;
+		}
+		cands.len = cc->cnt;
+		mutex_unlock(&cand_cache_mutex);
+	}
+
+	err = bpf_core_apply_relo_insn((void *)ctx->log, insn, relo->insn_off / 8,
+				       relo, relo_idx, ctx->btf, &cands);
+	kfree(cands.cands);
+	return err;
 }
diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
index f410691cc4e5..f7b0d698978c 100644
--- a/tools/lib/bpf/relo_core.h
+++ b/tools/lib/bpf/relo_core.h
@@ -8,8 +8,10 @@
 
 struct bpf_core_cand {
 	const struct btf *btf;
+#ifndef __KERNEL__
 	const struct btf_type *t;
 	const char *name;
+#endif
 	__u32 id;
 };
 
-- 
2.30.2

