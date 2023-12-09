Return-Path: <bpf+bounces-17286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FFB80B0F9
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88BB1C20BC2
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF9B17D0;
	Sat,  9 Dec 2023 00:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdB2v8xY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1BE173F
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 16:27:23 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5cbcfdeaff3so25937927b3.0
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 16:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702081642; x=1702686442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfhqBiCsXCASGYfkeUeDDTs+pOQh8dtlrhATgleG490=;
        b=gdB2v8xY/Rsfh65E75/1+btcjAf5/RV+MOiqmbGGp6GVdFNpDZjPc1DZhfIm7nElib
         4Pup4whHlQDiIxyuaknuGOqdFJuYNKaIAsNPO7+jxG705uN86yLq7ImOEpqaHaBXsT8j
         UuzO/vnkoLGeCV8Gunhsv1qHjp43gXfXaBFDtpXSuafeEm1L5ylKNHVwVlYTWh4k+dL+
         9iUAuzN57Y3a7DUuTgO/MRKs0lBZp1l54pg88WskKYtjB4RttgvEkUL7COrK03JNYcbV
         gjjM0m609n8USj5AHiZJE9bDU0yVG1Za6ui1Hx+J8FUlPGiAnBtSeYTQCtHA0qsw6gRZ
         n2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702081642; x=1702686442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfhqBiCsXCASGYfkeUeDDTs+pOQh8dtlrhATgleG490=;
        b=Mn7XcS1kfUpPtJBcqbd1B4MogVWOjQOdP73WxPUJw2dvdLJI+kfrzVS4CXR4GhzQGu
         SOt5MO4VckiGvyPDtFThlIIYqTR6r/T0OBHzpUutYywzhayLM8IMtk7RwxZjyi+B82rA
         mO220f1RdunCI9PxQaIc5l84LJXEgjjK66qFmkTTrJO81mAQYtgG/fcIEfXkQJ4baL2B
         SLk2NtBGBdnXklFN4oXmY2kL9GXgC/lmOdh3Xs8z44TeOuyJu+VJxB6ocFwnMU72VZis
         kmFZ2TY+5aeKjPccNIQVvZPLOINRIuFInY+gUEsU1lOMcONrTb9TSwPb9uSOzmLRzboO
         UmhA==
X-Gm-Message-State: AOJu0YxnhF1LG6yvg6uz9JoHn8PKrArxL4P0jiJ/2lGJFwlpmwvjP5Fc
	IS4j4ryHq1D+xQ/sdMXm1iOgCvv1wpBtdQ==
X-Google-Smtp-Source: AGHT+IEj6OxKPpgobk0bAXSmNHUBDJw6GIiKKL/jcW+B5tlcwBeM4tdEWYnBsVRWiYre1I0UVoFsWA==
X-Received: by 2002:a81:528f:0:b0:59b:dbb7:5c74 with SMTP id g137-20020a81528f000000b0059bdbb75c74mr856989ywb.32.1702081642287;
        Fri, 08 Dec 2023 16:27:22 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm1057450ywf.42.2023.12.08.16.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 16:27:22 -0800 (PST)
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
Subject: [PATCH bpf-next v13 08/14] bpf: hold module for bpf_struct_ops_map.
Date: Fri,  8 Dec 2023 16:27:03 -0800
Message-Id: <20231209002709.535966-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209002709.535966-1-thinker.li@gmail.com>
References: <20231209002709.535966-1-thinker.li@gmail.com>
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

struct bpf_strct_ops_map doesn't hold a refcnt to btf anymore sicne a
module will hold a refcnt to it's btf already. But, struct_ops programs are
different. They hold their associated btf, not the module since they need
only btf to assure their types (signatures).

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/bpf_struct_ops.c  | 28 +++++++++++++++++++++++-----
 kernel/bpf/verifier.c        | 10 ++++++++++
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 91bcd62d6fcf..c5c7cc4552f5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1681,6 +1681,7 @@ struct bpf_struct_ops {
 	void (*unreg)(void *kdata);
 	int (*update)(void *kdata, void *old_kdata);
 	int (*validate)(void *kdata);
+	struct module *owner;
 	const char *name;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 314b679fb494..01113bcdd479 100644
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
index f943f8378e76..a838f7c7d583 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -641,12 +641,15 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
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
+	module_put(st_map->st_ops_desc->st_ops->owner);
+
 	/* The struct_ops's function may switch to another struct_ops.
 	 *
 	 * For example, bpf_tcp_cc_x->init() may switch to
@@ -681,6 +684,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	size_t st_map_size;
 	struct bpf_struct_ops_map *st_map;
 	const struct btf_type *t, *vt;
+	struct module *mod = NULL;
 	struct bpf_map *map;
 	struct btf *btf;
 	int ret;
@@ -690,10 +694,20 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
 		if (IS_ERR(btf))
 			return ERR_PTR(PTR_ERR(btf));
-	} else {
+
+		if (btf != btf_vmlinux) {
+			mod = btf_try_get_module(btf);
+			if (!mod) {
+				btf_put(btf);
+				return ERR_PTR(-EINVAL);
+			}
+		}
+		/* mod (NULL for btf_vmlinux) holds a refcnt to btf. We
+		 * don't need an extra refcnt here.
+		 */
+		btf_put(btf);
+	} else
 		btf = btf_vmlinux;
-		btf_get(btf);
-	}
 
 	st_ops_desc = bpf_struct_ops_find_value(btf, attr->btf_vmlinux_value_type_id);
 	if (!st_ops_desc) {
@@ -756,7 +770,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 errout_free:
 	__bpf_struct_ops_map_free(map);
 errout:
-	btf_put(btf);
+	module_put(mod);
 
 	return ERR_PTR(ret);
 }
@@ -886,6 +900,10 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 	if (!bpf_struct_ops_valid_to_reg(new_map))
 		return -EINVAL;
 
+	/* The old map is holding the refcount for the owner module.  The
+	 * ownership of the owner module refcount is going to be
+	 * transferred from the old map to the new map.
+	 */
 	if (!st_map->st_ops_desc->st_ops->update)
 		return -EOPNOTSUPP;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 795c16f9cf57..c303cf2fb5ff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20079,6 +20079,14 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	btf = prog->aux->attach_btf;
+	if (btf != btf_vmlinux) {
+		/* Make sure st_ops is valid through the lifetime of env */
+		env->attach_btf_mod = btf_try_get_module(btf);
+		if (!env->attach_btf_mod) {
+			verbose(env, "owner module of btf is not found\n");
+			return -ENOTSUPP;
+		}
+	}
 
 	btf_id = prog->aux->attach_btf_id;
 	st_ops_desc = bpf_struct_ops_find(btf, btf_id);
@@ -20792,6 +20800,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		env->prog->expected_attach_type = 0;
 
 	*prog = env->prog;
+
+	module_put(env->attach_btf_mod);
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
-- 
2.34.1


