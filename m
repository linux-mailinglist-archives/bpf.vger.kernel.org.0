Return-Path: <bpf+bounces-46003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3949E1E25
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 14:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD33C2828C8
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 13:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D308A1F130F;
	Tue,  3 Dec 2024 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Jcc3ck2N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7148D1B395E
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233725; cv=none; b=jiuLNntGlFvs00eCxjw+WfqDcd8HuRWPZW4NA4d3AOahcTXgk98TBfFwtKyyUNkqSsnsD6f4RDDsCr7lGK2OT6K8bp7LlxxJAEBfEoQLi3FjvwqAPW1GWYrXozOPV7VMhs1nNJOxLqftOBYS7TQYEpAyYEY6MHwTk4Pkq7D1Fn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233725; c=relaxed/simple;
	bh=VWu4dic2nk3/gIEivDHu5je8fzg/wD+ersXzZW3zf+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AeQtoyojMpjMQSlFVub9HA3F2zJDaSeBQbU27kraI/urafJA6yNo6poCWnB2P5sZuz7ZWKcEfyFuZ7pvYQ5C7ruNIEQV1Fh9PYeU0ljnvgGjm7sVMUN53ordcIPVG/NjH8ajXwtuY0Zj2FhWWJbkJsiUEA720b5IIK1zjKPXsFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Jcc3ck2N; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so5077638a12.1
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 05:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733233721; x=1733838521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3grXjTIulhHPoBe2I2jvwMWEQQrUnaOVbLjd5dIArQ=;
        b=Jcc3ck2N5qQjQQq5rF+QLAUv0lTljgV11lhGtuoCCbmArMyHBM28p0Hxl/+R+MDg+O
         U5zZe6tLwt8YYF94YUEluX3naX3lGk6nhZPFAnvmtxT2MDsZ9GeL8ujpwP5m6ViUdzU5
         J4BU7a9Qc1+MrPZ3iC85jIx2L6X1UWaNiZw1LIQVK6KjTq+QtwQISJgjh5m6rWPK2++t
         zDHEGrD9TyDSz46WsnrPmGZK5HIJUG5KkWUU6BAscuIJmAYPBjfa3X7Le+vCK1No3Vd2
         B3/JZzxVlgWkbnVMVVZJDVXC8U5Zl07Tf9g5HgJOdClCloP/p90OLDt8/QBoBzq4MhPc
         5roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233721; x=1733838521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3grXjTIulhHPoBe2I2jvwMWEQQrUnaOVbLjd5dIArQ=;
        b=ZCKpgUhZqSiQ7yQe9rToguopBtm0oK/cV/3X9x+ErsFlqG3UezcYmUgW+IW6tAWePx
         ry8L+cf3lbADmFTXXmszNOJTlL+uD+c4b68rJCWS15gko5yNMAB+3XEf3o8Ogv6vs6jz
         lsVJoo1Sce9peC9kY4uxSOkZQnhiwNCL3STFgBJ5vrzxWkOnLVFX9F0gUdDDNlW4YQ4r
         2cc9gZxT0yXrg/9V89CyhhaGjzVqitBUEIucptBSaczztHdbQ8thCUfOg9U3ktQYyX4J
         JApZVBn7tGQD5LYoJjSH/MhvORQuzgogRRFsuyqpoqdzFRnq2+/WW4IzHpEa6PmzyXlr
         IiTw==
X-Gm-Message-State: AOJu0YwciMf4w8iB0ATMZ0Vu25V7pgM2yi+ENBX+EmLuG8igBLuYvblO
	vA5FuexH2ELTS6mWtYpKI1/Gitib2T+HyvcgACMmEpOMsjW3jgz4RUIAbOkCc6VJj/DkInSilFo
	0
X-Gm-Gg: ASbGncszUKLj8ddNINA9UbKykUgH4/pk5eWii9FZByvNtnuGf15meGO8S7PXTAO+L74
	R8n+QXbhkzDjgji3NB3qhBxysnG9/JMUJyQ6KSuZ2IG9a03wx5DBIIuDZLIPxDczNjF2lxgNBtr
	2Fd0XvOqxi8ayk6JpBK29vuMjLOVQfwMtkZd7QUol4wtO+a/0IOLuu25Ba3aubtDYpAYRNjuKca
	29EauzZFGnf+w9tsJj1yCOu/E/gdask+ZYXUbHnGXJ/eziZfa5hKDevHwpH2K4=
X-Google-Smtp-Source: AGHT+IEOFS2gz0CnllvecPHS7E605ruesT+8fD8TVnOdRNJcsLVfWyi50ETC9KRKFDom3yFF99bSuw==
X-Received: by 2002:a05:6402:5106:b0:5d0:ccec:8500 with SMTP id 4fb4d7f45d1cf-5d10cb99da0mr2541351a12.33.1733233721171;
        Tue, 03 Dec 2024 05:48:41 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d098330dd2sm6243394a12.14.2024.12.03.05.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:48:40 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v4 bpf-next 3/7] bpf: add fd_array_cnt attribute for prog_load
Date: Tue,  3 Dec 2024 13:50:48 +0000
Message-Id: <20241203135052.3380721-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203135052.3380721-1-aspsk@isovalent.com>
References: <20241203135052.3380721-1-aspsk@isovalent.com>
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
 include/uapi/linux/bpf.h       | 10 ++++
 kernel/bpf/syscall.c           |  2 +-
 kernel/bpf/verifier.c          | 98 ++++++++++++++++++++++++++++------
 tools/include/uapi/linux/bpf.h | 10 ++++
 4 files changed, 104 insertions(+), 16 deletions(-)

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
index 5684e8ce132d..4e88797fdbeb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2730,7 +2730,7 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define BPF_PROG_LOAD_LAST_FIELD prog_token_fd
+#define BPF_PROG_LOAD_LAST_FIELD fd_array_cnt
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8e034a22aa2a..cda02153d90e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19181,22 +19181,10 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	return 0;
 }
 
-/* Add map behind fd to used maps list, if it's not already there, and return
- * its index.
- * Returns <0 on error, or >= 0 index, on success.
- */
-static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd)
+static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
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
@@ -19227,6 +19215,24 @@ static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd)
 	return env->used_map_cnt - 1;
 }
 
+/* Add map behind fd to used maps list, if it's not already there, and return
+ * its index.
+ * Returns <0 on error, or >= 0 index, on success.
+ */
+static int add_used_map(struct bpf_verifier_env *env, int fd)
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
+	return __add_used_map(env, map);
+}
+
 /* find and rewrite pseudo imm in ld_imm64 instructions:
  *
  * 1. if it accesses map FD, replace it with actual map pointer.
@@ -19318,7 +19324,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				break;
 			}
 
-			map_idx = add_used_map_from_fd(env, fd);
+			map_idx = add_used_map(env, fd);
 			if (map_idx < 0)
 				return map_idx;
 			map = env->used_maps[map_idx];
@@ -22526,6 +22532,65 @@ struct btf *bpf_get_btf_vmlinux(void)
 	return btf_vmlinux;
 }
 
+/*
+ * The add_fd_from_fd_array() is executed only if fd_array_cnt is non-zero. In
+ * this case expect that every file descriptor in the array is either a map or
+ * a BTF. Everything else is considered to be trash.
+ */
+static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
+{
+	struct bpf_map *map;
+	CLASS(fd, f)(fd);
+	int ret;
+
+	map = __bpf_map_get(f);
+	if (!IS_ERR(map)) {
+		ret = __add_used_map(env, map);
+		if (ret < 0)
+			return ret;
+		return 0;
+	}
+
+	/*
+	 * Unlike "unused" maps which do not appear in the BPF program,
+	 * BTFs are visible, so no reason to refcnt them now
+	 */
+	if (!IS_ERR(__btf_get_by_fd(f)))
+		return 0;
+
+	verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
+	return PTR_ERR(map);
+}
+
+static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr, bpfptr_t uattr)
+{
+	size_t size = sizeof(int);
+	int ret;
+	int fd;
+	u32 i;
+
+	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
+
+	/*
+	 * The only difference between old (no fd_array_cnt is given) and new
+	 * APIs is that in the latter case the fd_array is expected to be
+	 * continuous and is scanned for map fds right away
+	 */
+	if (!attr->fd_array_cnt)
+		return 0;
+
+	for (i = 0; i < attr->fd_array_cnt; i++) {
+		if (copy_from_bpfptr_offset(&fd, env->fd_array, i * size, size))
+			return -EFAULT;
+
+		ret = add_fd_from_fd_array(env, fd);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
 	u64 start_time = ktime_get_ns();
@@ -22557,7 +22622,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		env->insn_aux_data[i].orig_idx = i;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
-	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
 
 	env->allow_ptr_leaks = bpf_allow_ptr_leaks(env->prog->aux->token);
 	env->allow_uninit_stack = bpf_allow_uninit_stack(env->prog->aux->token);
@@ -22580,6 +22644,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret)
 		goto err_unlock;
 
+	ret = process_fd_array(env, attr, uattr);
+	if (ret)
+		goto err_release_maps;
+
 	mark_verifier_state_clean(env);
 
 	if (IS_ERR(btf_vmlinux)) {
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


