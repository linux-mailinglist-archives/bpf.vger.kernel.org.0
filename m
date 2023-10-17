Return-Path: <bpf+bounces-12448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DA17CC8B1
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FC51C20D2E
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C559CA5B;
	Tue, 17 Oct 2023 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g56KAa//"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370089CA52
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 16:23:18 +0000 (UTC)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC6DF7
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:23:16 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9a389db3c7so5040908276.1
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697559796; x=1698164596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxMqaT8h6QY3nPgn2rnbtpHscHvTCIxN/Kv68wogCGY=;
        b=g56KAa//XNUbXRkHQy6MoAQjOkIujGKoDPn9BQtKB4BFGsXWACMc24TmRXuc3rCKz3
         QFr0rFwf8NmRhSTg6hcubmKR0CubuvVLAd2boMmvuBc3Imx7Qm5mn67RLlftOxOzn8IP
         akj/KA87W/hacQs5rFtC8RLMC1wfXHHX53DDsBAYs/IeonOBH94A5eAEH0OzepvrHGOh
         2r1CJVUVuiYQIKUfEX6q2okoBQ0BjUFFkAPPHy8rgWLWHQkhjf5WFd3wtk4YJNIi2PAo
         GvM1B/7qWkgCmZUh1NMgUfMbEZTAw9AqVvVP7dO+O0lyKcA7SCs4GPWKwmB03p5yFghU
         WNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697559796; x=1698164596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxMqaT8h6QY3nPgn2rnbtpHscHvTCIxN/Kv68wogCGY=;
        b=EhQwHwlJ7I/QmZskZjHr+PiEM3gyRz3v3yfPIuaVGme88RFdc8skXnuZSBUM1JWayX
         Tc4SnVEdJlILqE8dqhq7FtsaDY8ZfgLJMKOlhzNYzV9fskFSKL9d+HhprFWqeq2JJppW
         KwTsHfXaTzGeJ+XrdCaAY7adIlMaDHLNRh7O6e2s6BhcI09mVZB6G6EsV/5cRcKYD2Lf
         /UUjtV2xc+8VSnlqHY+J+dOnawhrbUiTFoqwN+oOo8SUbfx1vba6V8XifnKXGmMTCSjF
         DpXj8hZ3ZdNCXIsH3XgbV1fuen0ZlIxxX5AfX/c/RjI5go1DcHz/tHHHTf0rLkld9838
         CHvg==
X-Gm-Message-State: AOJu0Yw+jgzGe4p18kDnOSQ+zxRV3+Kd0ZjsPNNskysZu5tYUPIRM9bY
	PrdgkzRecJy0uz8rMKsu1zX7q3b9Jgo=
X-Google-Smtp-Source: AGHT+IH0K8/pa575Zcv8DW2NzjjX/xqx2AyEJYFH+nEwWwhpVkyCyOmmu+OetyQGvgP+5Sf0TMFeJw==
X-Received: by 2002:a25:7704:0:b0:cb2:7e6:191c with SMTP id s4-20020a257704000000b00cb207e6191cmr2005992ybc.20.1697559795851;
        Tue, 17 Oct 2023 09:23:15 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ed01:b54a:4364:93cc])
        by smtp.gmail.com with ESMTPSA id r189-20020a2544c6000000b00d814d8dfd69sm623645yba.27.2023.10.17.09.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:23:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 5/9] bpf: pass attached BTF to the bpf_struct_ops subsystem
Date: Tue, 17 Oct 2023 09:23:02 -0700
Message-Id: <20231017162306.176586-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017162306.176586-1-thinker.li@gmail.com>
References: <20231017162306.176586-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Giving a BTF, the bpf_struct_ops knows the right place to look up type info
associated with a type ID. This enables a user space program to load a
struct_ops object linked to a struct_ops type defined by a module, by
providing the module BTF (fd).

The bpf_prog includes attach_btf in aux which is passed along with the
bpf_attr when loading the program. The purpose of attach_btf is to
determine the btf type of attach_btf_id. The attach_btf_id is then used to
identify the traced function for a trace program. In the case of struct_ops
programs, it is used to identify the struct_ops type of the struct_ops
object that a program is attached to.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/bpf/bpf_struct_ops.c    | 34 +++++++++++++++++++++++++++-------
 kernel/bpf/syscall.c           |  2 +-
 kernel/bpf/verifier.c          |  4 +++-
 tools/include/uapi/linux/bpf.h |  5 +++++
 5 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 73b155e52204..b5ef22f65f35 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1390,6 +1390,11 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+
+		__u32   value_type_btf_obj_fd;	/* fd pointing to a BTF
+						 * type data for
+						 * btf_vmlinux_value_type_id.
+						 */
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 69703584fa4a..60445ff32275 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -677,6 +677,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 		bpf_jit_uncharge_modmem(PAGE_SIZE);
 	}
 	bpf_map_area_free(st_map->uvalue);
+	btf_put(st_map->st_ops->btf);
 	module_put(st_map->st_ops->owner);
 	bpf_map_area_free(st_map);
 }
@@ -718,23 +719,36 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	struct bpf_struct_ops_map *st_map;
 	const struct btf_type *t, *vt;
 	struct bpf_map *map;
+	struct btf *btf;
 	int ret;
 
-	st_ops = bpf_struct_ops_find_value(btf_vmlinux, attr->btf_vmlinux_value_type_id);
-	if (!st_ops)
+	if (attr->value_type_btf_obj_fd) {
+		btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
+		if (IS_ERR(btf))
+			return ERR_PTR(PTR_ERR(btf));
+	} else {
+		btf = btf_vmlinux;
+		btf_get(btf);
+	}
+	st_ops = bpf_struct_ops_find_value(btf, attr->btf_vmlinux_value_type_id);
+	if (!st_ops) {
+		btf_put(btf);
 		return ERR_PTR(-ENOTSUPP);
+	}
 
 	/* If st_ops->owner is NULL, it means the struct_ops is
 	 * statically defined in the kernel.  We don't need to
 	 * take a refcount on it.
 	 */
-	if (st_ops->owner && !btf_try_get_module(st_ops->btf))
+	if (st_ops->owner && !btf_try_get_module(st_ops->btf)) {
+		btf_put(btf);
 		return ERR_PTR(-EINVAL);
+	}
 
 	vt = st_ops->value_type;
 	if (attr->value_size != vt->size) {
-		module_put(st_ops->owner);
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto errout;
 	}
 
 	t = st_ops->type;
@@ -747,8 +761,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 
 	st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
 	if (!st_map) {
-		module_put(st_ops->owner);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto errout;
 	}
 
 	st_map->st_ops = st_ops;
@@ -784,6 +798,12 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	bpf_map_init_from_attr(map, attr);
 
 	return map;
+
+errout:
+	btf_put(btf);
+	module_put(st_ops->owner);
+
+	return ERR_PTR(ret);
 }
 
 static u64 bpf_struct_ops_map_mem_usage(const struct bpf_map *map)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 85c1d908f70f..5daf8a2c2bba 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1097,7 +1097,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	return ret;
 }
 
-#define BPF_MAP_CREATE_LAST_FIELD map_extra
+#define BPF_MAP_CREATE_LAST_FIELD value_type_btf_obj_fd
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6564a03c425d..ce4df24eb03b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19623,6 +19623,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
 	u32 btf_id, member_idx;
+	struct btf *btf;
 	const char *mname;
 
 	if (!prog->gpl_compatible) {
@@ -19630,8 +19631,9 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
+	btf = prog->aux->attach_btf;
 	btf_id = prog->aux->attach_btf_id;
-	st_ops = bpf_struct_ops_find(btf_vmlinux, btf_id);
+	st_ops = bpf_struct_ops_find(btf, btf_id);
 	if (!st_ops) {
 		verbose(env, "attach_btf_id %u is not a supported struct\n",
 			btf_id);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 73b155e52204..b5ef22f65f35 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1390,6 +1390,11 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+
+		__u32   value_type_btf_obj_fd;	/* fd pointing to a BTF
+						 * type data for
+						 * btf_vmlinux_value_type_id.
+						 */
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
-- 
2.34.1


