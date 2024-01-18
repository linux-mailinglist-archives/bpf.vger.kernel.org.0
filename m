Return-Path: <bpf+bounces-19782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE8E831112
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48B41C20924
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EF07481;
	Thu, 18 Jan 2024 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAnJy+L4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E178BF6
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542602; cv=none; b=LaW1QhHxg//+Ugm/k5ynKikLB+APKW/Gvj5hjZ/rOYV46G/odBVdf6FOI33BfOa3HnIgBM7nwVj5GZLJ0g4UpMz+c8M4+0AWQSnBYjezAhg0jxORZqpWAz3RPHSgIeZmc6hQ9tCxTlHpInjZ9Sv5wUMtLGXKUHwXmE6+7Yw0VUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542602; c=relaxed/simple;
	bh=NooAWNO3LTebAmeOJ+n2t/0P2AmiQhkSeC0rq6h0eM0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=EhwaLEso4ATa8WYFZf8iOcSg/eQvxkOLoQGwsMAHmHhxQrdi+6PvNvqbXriNvWdNUoCYEcit8Vo8dzxp17GYeWxXEXppTegnbuo6OZhNaPBUI7FUEl6Ht4t09F+4RDv9fLB9CFkW+cIUNyX6nbIFCyolIatLHS2eFM04m0oufbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAnJy+L4; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ff6245c1deso17911607b3.1
        for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 17:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542599; x=1706147399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGt/aSa+2dNBp0tw2j5P8nfr1B8a4C0rQJteFRrhxiI=;
        b=lAnJy+L4Htpc++HltHjfvN5vUMdXnO0b0xp5wdomaRKr1XJ0Kyt6xVli10p6ham4R/
         MHrEgeR1yzgWIWBU8pz93btM9o945Z0csWhd3KuruaDLoIg0hBewXW12IM1ChsJuVvB6
         i8EDk8ffi7mHrNuzzRUTR0CPmX+1yNqDTM++ust13OWRWGQNylpOHBo4JAK48qpUa3Bv
         onFISjCelNCWwisb4x5z+IJMsv8Yc4sxBjYhNZd44/ks2Uda1J7UH5bG7Q+Dyh4lVYW5
         jdab8id6mPXAFokSi7YjpEuOvIxS4tBB1mOxviQiKxTGxss1ANGt4wbHbv6UkMhNiCGW
         SDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542599; x=1706147399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGt/aSa+2dNBp0tw2j5P8nfr1B8a4C0rQJteFRrhxiI=;
        b=ELLaDNCZVgjei023b4ykPGapbVQyrDtq0hNTQg96ihUh0AMO0ym/Qc5P2lJF8+sBeY
         AU0Ag/fDmF8TfD8GH6byYWe8AFOyIFjjhUK7BOM766FFHEeY637DcqpZlOlNjWhgMEc1
         TdPzdtXuYusGnVo2R4Q+NnvDzb87bVG67N5GDiSQUZoFLLKyzqIIn5Vp4PNtgMjzClvx
         yGxl/AqRoMvpIvnDtkwrEqZT/JVCn5gS+B6ar+1wVtVHCeba7eSh/vUGce41+1fSQjnA
         5AV2YUJqz7i2/d+WSZBImzoez512Pk0Y+aZj+daYJUSQqXYJMnfyKqJcE4iOyQHNtd52
         Kllw==
X-Gm-Message-State: AOJu0YwtBwRKRhSVS4v2AOzbfFwrun6cdjo/4YoAb5sv6fQKH4CAjUQI
	w6ruZCn6WTlelTN7aN5Q0FuXDfOPqq7u99So2TftOD8PqkcsyMRJ0GfkMjro
X-Google-Smtp-Source: AGHT+IFAX6XuoEvKDNOe2nfWxMiQkyiasbiYbPbXTW3yhw49aPH5AhIxEkOmmYmlI0iFLUotL7Rdmw==
X-Received: by 2002:a81:4891:0:b0:5ff:830e:70b with SMTP id v139-20020a814891000000b005ff830e070bmr127842ywa.33.1705542599680;
        Wed, 17 Jan 2024 17:49:59 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b90:cd6a:b588:8d99])
        by smtp.gmail.com with ESMTPSA id cb9-20020a05690c090900b005e5fff5c537sm6248606ywb.85.2024.01.17.17.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:49:59 -0800 (PST)
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
Subject: [PATCH bpf-next v16 09/14] bpf: hold module refcnt in bpf_struct_ops map creation and prog verification.
Date: Wed, 17 Jan 2024 17:49:25 -0800
Message-Id: <20240118014930.1992551-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118014930.1992551-1-thinker.li@gmail.com>
References: <20240118014930.1992551-1-thinker.li@gmail.com>
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
 kernel/bpf/bpf_struct_ops.c  | 31 +++++++++++++++++++++++++------
 kernel/bpf/verifier.c        | 10 ++++++++++
 4 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3d1c1014fdb2..a977ed75288c 100644
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
index 3b8d689ece5d..61486f6595ea 100644
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
@@ -695,11 +704,20 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 			btf_put(btf);
 			return ERR_PTR(-EINVAL);
 		}
+
+		mod = btf_try_get_module(btf);
+		if (!mod) {
+			btf_put(btf);
+			return ERR_PTR(-EINVAL);
+		}
+		/* mod holds a refcnt to btf. We don't need an extra refcnt
+		 * here.
+		 */
+		btf_put(btf);
 	} else {
 		btf = bpf_get_btf_vmlinux();
 		if (IS_ERR(btf))
 			return ERR_CAST(btf);
-		btf_get(btf);
 	}
 
 	st_ops_desc = bpf_struct_ops_find_value(btf, attr->btf_vmlinux_value_type_id);
@@ -746,8 +764,9 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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
@@ -763,7 +782,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 errout_free:
 	__bpf_struct_ops_map_free(map);
 errout:
-	btf_put(btf);
+	module_put(mod);
 
 	return ERR_PTR(ret);
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff41f7736618..60f08f468399 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20243,6 +20243,14 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	btf = prog->aux->attach_btf ?: bpf_get_btf_vmlinux();
+	if (btf_is_module(btf)) {
+		/* Make sure st_ops is valid through the lifetime of env */
+		env->attach_btf_mod = btf_try_get_module(btf);
+		if (!env->attach_btf_mod) {
+			verbose(env, "owner module of btf is not found\n");
+			return -ENOTSUPP;
+		}
+	}
 
 	btf_id = prog->aux->attach_btf_id;
 	st_ops_desc = bpf_struct_ops_find(btf, btf_id);
@@ -20968,6 +20976,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		env->prog->expected_attach_type = 0;
 
 	*prog = env->prog;
+
+	module_put(env->attach_btf_mod);
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
-- 
2.34.1


