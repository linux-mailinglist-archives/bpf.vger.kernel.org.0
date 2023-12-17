Return-Path: <bpf+bounces-18122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48021815E0B
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 09:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00728283869
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 08:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505A020EB;
	Sun, 17 Dec 2023 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTvcbPhI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2E523B9
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbd029beef4so1196200276.0
        for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 00:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702800713; x=1703405513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sqj18b4C8e25fCNvpx+Gc1kGjx6EpPOq/9LNaG+RD0=;
        b=DTvcbPhI1BPVLRkUqQHJWzRgBTohH6f4QiKdzmh1JEWIH2MSAULTOz63/X94ZfcgJ9
         FvlRO8TgQFRAH65Mcb0pw1qrJpyYoUfXp59kx3GpVfwkO3qGnxIk+UsYCMFJkuAs1Nn8
         xSwx9mLkWUBMiepfvwHoRdGNArukf3Q+Shp0lAT3RRgYI8P3xr/0bgeYK3DEJscReUgA
         FDcdrTQi979pQK+5wMsGzaCI25blkmqmnvseVTPdMyPcTR0LCCNJ/smoei742lZMRldP
         YtewOA9aFZSBdLHsv1DKKxEVkoTu38OyFM9CPCy1sKHxtos6xKphSw2oxqcuXTC81aIS
         dROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702800713; x=1703405513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sqj18b4C8e25fCNvpx+Gc1kGjx6EpPOq/9LNaG+RD0=;
        b=IQwUWyz0fvBIumZMMYNeI3rKIT4HKnx+lyGJc1tRm71Zt0H+f3QPXzeyZV5zW/08jB
         hgLAmqEljzf5baRSaPC7lVPWNXkvbIS1pmYW4n4HKaodO8Up5I6R4Mzk7PJGBJ5CyDl/
         T5CEIb4VU1iiAnDWWDESTb8j5uzMk0fHkGj2l6c24vdYlyXjgezNceUdOFI6U6Au82FK
         XSXj1Z1tzX1D4ZbrAC1fpfSy0ox3EZIRZ4lLanEy6RpvUhjud3QMNCRnZOjv5D29DfKt
         Aai1c2tQN/Qeuxe+D6+G9+I4oyqMERRxO5NI0q2jQWi7UPncAZnHyeNFPLVhM7Ioc1DS
         4wzg==
X-Gm-Message-State: AOJu0YzZc4hrugZQfOfn6UfaUSWrGTylqIAuq6pPJGgKRrkBUh9iXMaR
	cu6wyja79MREpiiKlkn/WyK4gqq3XsQ=
X-Google-Smtp-Source: AGHT+IHr3Hs0QmRI7fdJCroCgbLEnMecN5f/XL0qTDT7kF28HAdAjbQQ1aVmNwnJDviQ4z3lHW/QEw==
X-Received: by 2002:a81:df03:0:b0:5cb:1b6e:da89 with SMTP id c3-20020a81df03000000b005cb1b6eda89mr11053915ywn.12.1702800712951;
        Sun, 17 Dec 2023 00:11:52 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf])
        by smtp.gmail.com with ESMTPSA id c85-20020a814e58000000b005e303826838sm3399415ywb.56.2023.12.17.00.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 00:11:52 -0800 (PST)
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
Subject: [PATCH bpf-next v14 09/14] bpf: hold module refcnt in bpf_struct_ops map creation and prog verification.
Date: Sun, 17 Dec 2023 00:11:26 -0800
Message-Id: <20231217081132.1025020-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217081132.1025020-1-thinker.li@gmail.com>
References: <20231217081132.1025020-1-thinker.li@gmail.com>
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

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/bpf_struct_ops.c  | 24 +++++++++++++++++++++---
 kernel/bpf/verifier.c        | 10 ++++++++++
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0163b46910b1..b60f09449c7f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1683,6 +1683,7 @@ struct bpf_struct_ops {
 	void (*unreg)(void *kdata);
 	int (*update)(void *kdata, void *old_kdata);
 	int (*validate)(void *kdata);
+	struct module *owner;
 	const char *name;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c2819a6579a5..14a0ffb9283a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -651,6 +651,7 @@ struct bpf_verifier_env {
 	u32 prev_insn_idx;
 	struct bpf_prog *prog;		/* eBPF program being verified */
 	const struct bpf_verifier_ops *ops;
+	struct module *attach_btf_mod;	/* The owner module of prog->aux->attach_btf */
 	struct bpf_verifier_stack_elem *head; /* stack of verifier states to be processed */
 	int stack_size;			/* number of states to be processed */
 	bool strict_alignment;		/* perform strict pointer alignment checks */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 381175f97b25..ac7fbcc66da9 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
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
@@ -681,6 +689,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	size_t st_map_size;
 	struct bpf_struct_ops_map *st_map;
 	const struct btf_type *t, *vt;
+	struct module *mod = NULL;
 	struct bpf_map *map;
 	struct btf *btf;
 	int ret;
@@ -694,11 +703,20 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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
@@ -762,7 +780,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 errout_free:
 	__bpf_struct_ops_map_free(map);
 errout:
-	btf_put(btf);
+	module_put(mod);
 
 	return ERR_PTR(ret);
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 970b601ac2ba..dfcd1b7463d9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20095,6 +20095,14 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
@@ -20808,6 +20816,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		env->prog->expected_attach_type = 0;
 
 	*prog = env->prog;
+
+	module_put(env->attach_btf_mod);
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
-- 
2.34.1


