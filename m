Return-Path: <bpf+bounces-12201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F567C9062
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71108282227
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CB42C855;
	Fri, 13 Oct 2023 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRsS4KZn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0422C84B
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 22:43:16 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB95BF
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:43:15 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7af20c488so31257817b3.1
        for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697236994; x=1697841794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxMqaT8h6QY3nPgn2rnbtpHscHvTCIxN/Kv68wogCGY=;
        b=TRsS4KZn/2JSE3brtMgGC06nW1AD8Fp7Sp0y1iQT5Dn+xhSAHgeczaDjat9dhkWKVo
         OpfXQP8PrAWT2OpnglE0TysqSmc05kfw0JM7BesrF63/doxhbxgZEXaBRpeL/TD6CW+v
         lPymCchyh7BsXM7BezLoboaSJY/5lstwDMuqU9bZjd+3CUX/GM/ae8lsp6K48oyssEOw
         nH4cQ20RnyP+uEKPS11IqTdHaGuVJvP0bDxOpy/rzozvAjpkSMmoPm8dn3WoqfFGp7OX
         oaExBT46azWAA9SU21l78v8n3m5OjMxdMDHTdsdM3xhJnla3AAnglMCVGZBAfTBwmEuP
         9OSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697236994; x=1697841794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxMqaT8h6QY3nPgn2rnbtpHscHvTCIxN/Kv68wogCGY=;
        b=e0e//wW7KrJk228nK2mf4I8gLWvvmp0JgiP5VSK4fXVsjitVG8k68Qne7F6F1xWQjY
         b8Wive2mS4bH4JwkLGDkmi+TEe3vfFR279jdOKOJVD7we5sMORZF9LkwORlBh5Qe2GOZ
         EToQerQesmAC4SaDNcIRlsMB+EwsicS9WobXw1WxUQk6yxNGmM7eG3+UPEvw9QxT+Tae
         Xd5X0Sg5NQEUrzlhWTvfarl20CobKu1Bn6MLOHdhBPRKEDTr/cMmi+qEim5GolRAI986
         cgrGybDhChlIJRc0f1JSr1uPQurxlFZ95phti/AIRzXiZy+M14CiRRDjwZaatiE8psU0
         s9dg==
X-Gm-Message-State: AOJu0YyAEUKN/shLDj4wD2O0is5BzIybyk+j4DdVQNdYfSeB4ah03KBU
	+IpdDjCVWZ+QKodXAoFrwPQJ5uSzb+g=
X-Google-Smtp-Source: AGHT+IG4AflsvHX0VhPyt/4Z5Aw4wzwGKy7DpTqDFJ3+IYWAZWfI3WXQs7ylkBxtSslx7XM/qlzKqg==
X-Received: by 2002:a81:a083:0:b0:5a7:db09:5067 with SMTP id x125-20020a81a083000000b005a7db095067mr10590860ywg.20.1697236994529;
        Fri, 13 Oct 2023 15:43:14 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:df89:3514:fdf4:ee2])
        by smtp.gmail.com with ESMTPSA id g141-20020a0ddd93000000b00592548b2c47sm101989ywe.80.2023.10.13.15.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:43:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 5/9] bpf: pass attached BTF to the bpf_struct_ops subsystem
Date: Fri, 13 Oct 2023 15:43:00 -0700
Message-Id: <20231013224304.187218-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013224304.187218-1-thinker.li@gmail.com>
References: <20231013224304.187218-1-thinker.li@gmail.com>
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


