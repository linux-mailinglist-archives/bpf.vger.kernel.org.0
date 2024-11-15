Return-Path: <bpf+bounces-44909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E3F9CD4BD
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 01:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CFE1F228CA
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5132C54765;
	Fri, 15 Nov 2024 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="NWU2du67"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420238396
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731631403; cv=none; b=ecVrKOlTq0LOc0EQ6O2puCk8JYlPLHo89xpuz2dGC+mnJbrpmhK66g8EYOM38pE/vKiNUQzQ3kVNqDfWuWGFm74etdM9pTFC7m1df7UqPB0QFmqhocx52/7wJMFpV3l+riuctFBmTKYAi6/wpy/WAUcSLO3BQ/N+0yerYNRrUUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731631403; c=relaxed/simple;
	bh=+6OLw5K8Bf4GKSjye7JUIAL1lRH7cPsOfdmllJEcBCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eRhlVXuZIiL/KVJSgm7jtKrVJAONw0ZMU+tQRdn+Txm3tvwIUc2q+Cxf4HOuY/jVGnYCRAguhIHxCngKyKEAoLuO1hJ+4I2OpFs6GC/bYrYbUrK5emN4FxyvF3S6N6oOItz7x8AGAddlmeIF8inP0JZiaC9sl4JpkeJeFu/cfog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=NWU2du67; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso10042835e9.1
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 16:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1731631399; x=1732236199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/X54+OTdQi66H+SUwmv0s93eKKGcMlzhNPqaaV/aQnM=;
        b=NWU2du67z9OecTYd4b/wKSQ+l6Ll+XuI5H7qCLJwtLwaOp7GcRGXgvWXToU5Kminb7
         mxDS+XDjhB408WYR67OW7cr1F28txXc7vQ3SI2/Z9o3Y5QUSfyRDvv4glRCCC2l8qZ0c
         ac6RiB0vBOEu124la7WpI5Vh1Lh4saw0UahWDS24wae6qRAJ4NadXOHhnhvCi3UR5sAH
         gGlOB7AHD1TApelL2wWpQEF243maXqG/ItfMi3EqfY1/UkE6JKdfzhL24qjL7nU83k/j
         AYMQ69WrVPk1FOU30UxrvGEXFWRkukhnkYonKpVanITJw0AY/5voLeFWjpqaRPDbGwhi
         9iGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731631399; x=1732236199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/X54+OTdQi66H+SUwmv0s93eKKGcMlzhNPqaaV/aQnM=;
        b=t1oRaA8XmmMeFLvP94Bqia3MU8ebeezgoFHervym0EzvX8/21CLQ/NfP36Oo8Kpso5
         tvTZo8OsdALzZR/JuXasZ9pR7qQ8rmPgPLxMl/swPJQt1izjy5/pF93nl0/d8bwC55aJ
         2xa75ZB3AfK+OHruQWzsDsj6Nc0qM/nT1hPhmj8QduOuMSO2ENIJneUTBNj7qDnpB0wR
         ZveQls2j+tIaOqtK1kxf+NtSdU3VocmL5pNh0msdKSHqfHCu9UfEhCTRvMlNKAElJ0WD
         FC/uJbK3M7GqvB1MIfBuvIxRVONeTTVk2pOF8dN+SMgzUDwpAs50ePO/p8dnogn3i+66
         FLvA==
X-Gm-Message-State: AOJu0Yw2RIeb+uFuaJKqQEjiQZqgCytA8FYnUX15uZIPUOUOwfNTJlkb
	esl8t3GU8n67U9G9yfN4zdMokfUHGShamgfg573l5sG/CHQxYnxFLyh1GR4ygM7d6x0OGsDCehk
	hY28=
X-Google-Smtp-Source: AGHT+IExa6JFHRZ5J5S+xZrzQfDhVy4bNu9HeVkUJLIpgMMvmyRroVB31C9Qyeu45y1MAThlxsruLw==
X-Received: by 2002:a05:600c:34d0:b0:42f:823d:dde9 with SMTP id 5b1f17b1804b1-432df77c758mr4327965e9.21.1731631399554;
        Thu, 14 Nov 2024 16:43:19 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab78783sm36781975e9.12.2024.11.14.16.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 16:43:18 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 3/5] bpf: add fd_array_cnt attribute for prog_load
Date: Fri, 15 Nov 2024 00:46:05 +0000
Message-Id: <20241115004607.3144806-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115004607.3144806-1-aspsk@isovalent.com>
References: <20241115004607.3144806-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fd_array attribute of the BPF_PROG_LOAD syscall may contain a set
of file descriptors: maps or btfs. This field was introduced as a
sparse array. Introduce a new attribute, fd_array_cnt, which, if
present, indicates that the fd_array is a continuous array of the
corresponding length.

If fd_array_cnt is non-zero, then every map in the fd_array will be
bound to the program, as if it was used by the program. This
functionality is similar to the BPF_PROG_BIND_MAP syscall, but such
maps can be used by the verifier during the program load.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/uapi/linux/bpf.h       |  10 +++
 kernel/bpf/syscall.c           |   2 +-
 kernel/bpf/verifier.c          | 107 ++++++++++++++++++++++++++++-----
 tools/include/uapi/linux/bpf.h |  10 +++
 4 files changed, 114 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4162afc6b5d0..2acf9b336371 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1573,6 +1573,16 @@ union bpf_attr {
 		 * If provided, prog_flags should have BPF_F_TOKEN_FD flag set.
 		 */
 		__s32		prog_token_fd;
+		/* The fd_array_cnt can be used to pass the length of the
+		 * fd_array array. In this case all the [map] file descriptors
+		 * passed in this array will be bound to the program, even if
+		 * the maps are not referenced directly. The functionality is
+		 * similar to the BPF_PROG_BIND_MAP syscall, but maps can be
+		 * used by the verifier during the program load. If provided,
+		 * then the fd_array[0,...,fd_array_cnt-1] is expected to be
+		 * continuous.
+		 */
+		__u32		fd_array_cnt;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 58190ca724a2..7e3fbc23c742 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2729,7 +2729,7 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define BPF_PROG_LOAD_LAST_FIELD prog_token_fd
+#define BPF_PROG_LOAD_LAST_FIELD fd_array_cnt
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 45c11d9cee60..2e262f6516b3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19192,22 +19192,10 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	return 0;
 }
 
-/* Add map behind fd to used maps list, if it's not already there, and return
- * its index.
- * Returns <0 on error, or >= 0 index, on success.
- */
-static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd)
+static int add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 {
-	CLASS(fd, f)(fd);
-	struct bpf_map *map;
 	int i, err;
 
-	map = __bpf_map_get(f);
-	if (IS_ERR(map)) {
-		verbose(env, "fd %d is not pointing to valid bpf_map\n", fd);
-		return PTR_ERR(map);
-	}
-
 	/* check whether we recorded this map already */
 	for (i = 0; i < env->used_map_cnt; i++)
 		if (env->used_maps[i] == map)
@@ -19238,6 +19226,24 @@ static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd)
 	return env->used_map_cnt - 1;
 }
 
+/* Add map behind fd to used maps list, if it's not already there, and return
+ * its index.
+ * Returns <0 on error, or >= 0 index, on success.
+ */
+static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd)
+{
+	struct bpf_map *map;
+	CLASS(fd, f)(fd);
+
+	map = __bpf_map_get(f);
+	if (IS_ERR(map)) {
+		verbose(env, "fd %d is not pointing to valid bpf_map\n", fd);
+		return PTR_ERR(map);
+	}
+
+	return add_used_map(env, map);
+}
+
 /* find and rewrite pseudo imm in ld_imm64 instructions:
  *
  * 1. if it accesses map FD, replace it with actual map pointer.
@@ -22537,6 +22543,76 @@ struct btf *bpf_get_btf_vmlinux(void)
 	return btf_vmlinux;
 }
 
+/*
+ * The add_fd_from_fd_array() is executed only if fd_array_cnt is given.  In
+ * this case expect that every file descriptor in the array is either a map or
+ * a BTF, or a hole (0). Everything else is considered to be trash.
+ */
+static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
+{
+	struct bpf_map *map;
+	CLASS(fd, f)(fd);
+	int ret;
+
+	map = __bpf_map_get(f);
+	if (IS_ERR(map)) {
+		if (!IS_ERR(__btf_get_by_fd(f)))
+			return 0;
+
+		/* allow holes */
+		if (!fd)
+			return 0;
+
+		verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
+		return PTR_ERR(map);
+	}
+
+	ret = add_used_map(env, map);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int env_init_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr, bpfptr_t uattr)
+{
+	int size = sizeof(int) * attr->fd_array_cnt;
+	int *copy;
+	int ret;
+	int i;
+
+	if (attr->fd_array_cnt >= MAX_USED_MAPS)
+		return -E2BIG;
+
+	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
+
+	/*
+	 * The only difference between old (no fd_array_cnt is given) and new
+	 * APIs is that in the latter case the fd_array is expected to be
+	 * continuous and is scanned for map fds right away
+	 */
+	if (!size)
+		return 0;
+
+	copy = kzalloc(size, GFP_KERNEL);
+	if (!copy)
+		return -ENOMEM;
+
+	if (copy_from_bpfptr_offset(copy, env->fd_array, 0, size)) {
+		ret = -EFAULT;
+		goto free_copy;
+	}
+
+	for (i = 0; i < attr->fd_array_cnt; i++) {
+		ret = add_fd_from_fd_array(env, copy[i]);
+		if (ret)
+			goto free_copy;
+	}
+
+free_copy:
+	kfree(copy);
+	return ret;
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
 	u64 start_time = ktime_get_ns();
@@ -22568,7 +22644,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		env->insn_aux_data[i].orig_idx = i;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
-	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
+	ret = env_init_fd_array(env, attr, uattr);
+	if (ret)
+		goto err_free_aux_data;
 
 	env->allow_ptr_leaks = bpf_allow_ptr_leaks(env->prog->aux->token);
 	env->allow_uninit_stack = bpf_allow_uninit_stack(env->prog->aux->token);
@@ -22786,6 +22864,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
+err_free_aux_data:
 	vfree(env->insn_aux_data);
 err_free_env:
 	kvfree(env);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4162afc6b5d0..2acf9b336371 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1573,6 +1573,16 @@ union bpf_attr {
 		 * If provided, prog_flags should have BPF_F_TOKEN_FD flag set.
 		 */
 		__s32		prog_token_fd;
+		/* The fd_array_cnt can be used to pass the length of the
+		 * fd_array array. In this case all the [map] file descriptors
+		 * passed in this array will be bound to the program, even if
+		 * the maps are not referenced directly. The functionality is
+		 * similar to the BPF_PROG_BIND_MAP syscall, but maps can be
+		 * used by the verifier during the program load. If provided,
+		 * then the fd_array[0,...,fd_array_cnt-1] is expected to be
+		 * continuous.
+		 */
+		__u32		fd_array_cnt;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
-- 
2.34.1


