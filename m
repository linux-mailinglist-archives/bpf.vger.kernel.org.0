Return-Path: <bpf+bounces-19929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6128330F4
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A712C1F22262
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE75C5914A;
	Fri, 19 Jan 2024 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcqIrqxw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B65B1F2
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704639; cv=none; b=mHSZjS1zP9mQlZBSZ1P4+sErsM+YMltTpywCnr207FCqKKSI+KAREctdfBYUlpZK7/ezAC12pQ6E0Uec4GxgOqx0Ky40kCR9RXaW2X16EGAvIg2/uuukm4+BtdAsJQ965N69MUJEOLEsROALXNjewTEoH1i9eg2iRrAEno9p+Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704639; c=relaxed/simple;
	bh=2VbvNGdgb+lR7OjCmn/VzX7OkxmU2mBRkM7Edlkrc+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vk6Q2ij/DQAMQ365L205Lz8s0uAZrpUSRYVgQdKz2A0fu7BERfjixoDQaxSPspQ0nav3KvwIMMr0dRPOfG78YYZTZ9dL56EdiU29n29K14VjckN+quj4GiT4iFMx4KuC/Wq3FIBYB6Kwklb5Awzd9YMIecYfjZPIq1IhVn3W3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcqIrqxw; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5edbcdc323dso13294797b3.3
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 14:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705704636; x=1706309436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07Grwq0Y1zOdE4zZBllzDtlvzn3m+hWHSjhxqHS0jrg=;
        b=CcqIrqxwH/vSKKiqBrCOPB86l7AU9iElCDEb8qv/en6hMwBWrRuwiWWSWko25SJ0q+
         ngL07JmQQBFJhe1/hyRTCcYI1d7eJ8+t9aXmBxApkSz5M90ojwIu++o0NzTcV49wk+ve
         hMkmdJu2SamwyCGaTcCrNjKMMNFyp+l1D4B+WFh8U9wxQL0vPdfuq5BV5xqQVUhEQCB/
         KyR/k7Q9R17JSCeHLhzwZIzB6gx+v2k8mXu4sXlnKvJJ6rfegQNicyvX6GADl0uQsg/Q
         zH3qo1antXuVt8r4aUZjjrWk8lxlQlgRQ4Y/Ew3A/PWpJvsbFvLYxViabmihFZ4/NQ8O
         3J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705704636; x=1706309436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07Grwq0Y1zOdE4zZBllzDtlvzn3m+hWHSjhxqHS0jrg=;
        b=c8sFLsuFQhvQR3/HRb/JNsBuDHGJ7d6BVBmpus9jiY0dySO+LFR8+ssltcA5w+F4Lb
         cbLqpsQiR7y4U4Ol/zjfZzZevsxNElDe+5mxEuuG3znvAf2ko5UnykbUlp6G/9UZevZs
         OINYeIeSMWI84jWt46/FIRj/ePZldPjswjtJykGoqjngN8fnzxne8/VqmwKgaTf6H1XF
         PcgOJ7uBfPeUMaXV2d6fdtyKAOEXCDmuNmO6q13fGDy1pmyO9phZBTzjXKZs0Xxy2V5x
         HBTdVDGWMsgN72BQ4zan2L72mWYyhMsdpHkvfxEw9XyxJDHuJHDAzARf070je67n68mx
         kJHQ==
X-Gm-Message-State: AOJu0YxDBi0fOzacoHzlHsZ+72cUvEon/zdWHIQxMymtsvW9OM+0Bc1u
	r1IcrjR5ksJ8BRVdAv+GNZq5xIoj1NDBu6EHoEyBfnGZwX2mPBGJfIOVv6WX
X-Google-Smtp-Source: AGHT+IGepbUH1doCxHM6oZ3ev9n1wTIYAbeeW21HIESf5TYV8+8pnu9KDrvtBQEHvr31m43DkiNecw==
X-Received: by 2002:a81:6084:0:b0:5ff:6514:d0d1 with SMTP id u126-20020a816084000000b005ff6514d0d1mr603630ywb.99.1705704636070;
        Fri, 19 Jan 2024 14:50:36 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b170:5bda:247f:8c47])
        by smtp.gmail.com with ESMTPSA id s184-20020a819bc1000000b005ffa70964f4sm411770ywg.115.2024.01.19.14.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 14:50:35 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v17 09/14] bpf: hold module refcnt in bpf_struct_ops map creation and prog verification.
Date: Fri, 19 Jan 2024 14:50:00 -0800
Message-Id: <20240119225005.668602-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119225005.668602-1-thinker.li@gmail.com>
References: <20240119225005.668602-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

To ensure that a module remains accessible whenever a struct_ops object of
a struct_ops type provided by the module is still in use.

struct bpf_struct_ops_map doesn't hold a refcnt to btf anymore since a
module will hold a refcnt to it's btf already. But, struct_ops programs are
different. They hold their associated btf, not the module since they need
only btf to assure their types (signatures).

However, verifier holds the refcnt of the associated module of a struct_ops
type temporarily when verify a struct_ops prog. Verifier needs the help
from the verifier operators (struct bpf_verifier_ops) provided by the owner
module to verify data access of a prog, provide information, and generate
code.

This patch also add a count of links (links_cnt) to bpf_struct_ops_map. It
avoids bpf_struct_ops_map_put_progs() from accessing btf after calling
module_put() in bpf_struct_ops_map_free().

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/bpf_struct_ops.c  | 29 +++++++++++++++++++++++------
 kernel/bpf/verifier.c        | 11 +++++++++++
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 51121dbf8e98..91714edd6193 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1674,6 +1674,7 @@ struct bpf_struct_ops {
 	int (*update)(void *kdata, void *old_kdata);
 	int (*validate)(void *kdata);
 	void *cfi_stubs;
+	struct module *owner;
 	const char *name;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d07d857ca67f..e6cf025c9446 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -662,6 +662,7 @@ struct bpf_verifier_env {
 	u32 prev_insn_idx;
 	struct bpf_prog *prog;		/* eBPF program being verified */
 	const struct bpf_verifier_ops *ops;
+	struct module *attach_btf_mod;	/* The owner module of prog->aux->attach_btf */
 	struct bpf_verifier_stack_elem *head; /* stack of verifier states to be processed */
 	int stack_size;			/* number of states to be processed */
 	bool strict_alignment;		/* perform strict pointer alignment checks */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 3b8d689ece5d..02216a8d9265 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -40,6 +40,7 @@ struct bpf_struct_ops_map {
 	 * (in kvalue.data).
 	 */
 	struct bpf_link **links;
+	u32 links_cnt;
 	/* image is a page that has all the trampolines
 	 * that stores the func args before calling the bpf_prog.
 	 * A PAGE_SIZE "image" is enough to store all trampoline for
@@ -306,10 +307,9 @@ static void *bpf_struct_ops_map_lookup_elem(struct bpf_map *map, void *key)
 
 static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
 {
-	const struct btf_type *t = st_map->st_ops_desc->type;
 	u32 i;
 
-	for (i = 0; i < btf_type_vlen(t); i++) {
+	for (i = 0; i < st_map->links_cnt; i++) {
 		if (st_map->links[i]) {
 			bpf_link_put(st_map->links[i]);
 			st_map->links[i] = NULL;
@@ -641,12 +641,20 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 		bpf_jit_uncharge_modmem(PAGE_SIZE);
 	}
 	bpf_map_area_free(st_map->uvalue);
-	btf_put(st_map->btf);
 	bpf_map_area_free(st_map);
 }
 
 static void bpf_struct_ops_map_free(struct bpf_map *map)
 {
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+
+	/* st_ops->owner was acquired during map_alloc to implicitly holds
+	 * the btf's refcnt. The acquire was only done when btf_is_module()
+	 * st_map->btf cannot be NULL here.
+	 */
+	if (btf_is_module(st_map->btf))
+		module_put(st_map->st_ops_desc->st_ops->owner);
+
 	/* The struct_ops's function may switch to another struct_ops.
 	 *
 	 * For example, bpf_tcp_cc_x->init() may switch to
@@ -682,6 +690,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	size_t st_map_size;
 	struct bpf_struct_ops_map *st_map;
 	const struct btf_type *t, *vt;
+	struct module *mod = NULL;
 	struct bpf_map *map;
 	struct btf *btf;
 	int ret;
@@ -695,11 +704,18 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 			btf_put(btf);
 			return ERR_PTR(-EINVAL);
 		}
+
+		mod = btf_try_get_module(btf);
+		/* mod holds a refcnt to btf. We don't need an extra refcnt
+		 * here.
+		 */
+		btf_put(btf);
+		if (!mod)
+			return ERR_PTR(-EINVAL);
 	} else {
 		btf = bpf_get_btf_vmlinux();
 		if (IS_ERR(btf))
 			return ERR_CAST(btf);
-		btf_get(btf);
 	}
 
 	st_ops_desc = bpf_struct_ops_find_value(btf, attr->btf_vmlinux_value_type_id);
@@ -746,8 +762,9 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		goto errout_free;
 	}
 	st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
+	st_map->links_cnt = btf_type_vlen(t);
 	st_map->links =
-		bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct bpf_links *),
+		bpf_map_area_alloc(st_map->links_cnt * sizeof(struct bpf_links *),
 				   NUMA_NO_NODE);
 	if (!st_map->uvalue || !st_map->links) {
 		ret = -ENOMEM;
@@ -763,7 +780,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 errout_free:
 	__bpf_struct_ops_map_free(map);
 errout:
-	btf_put(btf);
+	module_put(mod);
 
 	return ERR_PTR(ret);
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff41f7736618..0fc998f3ce86 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20243,6 +20243,15 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	btf = prog->aux->attach_btf ?: bpf_get_btf_vmlinux();
+	if (btf_is_module(btf)) {
+		/* Make sure st_ops is valid through the lifetime of env */
+		env->attach_btf_mod = btf_try_get_module(btf);
+		if (!env->attach_btf_mod) {
+			verbose(env, "struct_ops module %s is not found\n",
+				btf_get_name(btf));
+			return -ENOTSUPP;
+		}
+	}
 
 	btf_id = prog->aux->attach_btf_id;
 	st_ops_desc = bpf_struct_ops_find(btf, btf_id);
@@ -20968,6 +20977,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		env->prog->expected_attach_type = 0;
 
 	*prog = env->prog;
+
+	module_put(env->attach_btf_mod);
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
-- 
2.34.1


