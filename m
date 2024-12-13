Return-Path: <bpf+bounces-46842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206309F0CFB
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D070B28326F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BD21E04B3;
	Fri, 13 Dec 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="N+clUjaq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA41DFDB5
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095275; cv=none; b=usU3cKSpeqGEpQhfFVV2/DD67GLc/JPJulMqZXRZPu/UiGLqN6Dp5yUsIcd0Lmr6aRdt+XRy8k4sna3cpLSxbcTDGvHO3Kf24OMvQL341I3aOq3bzro/c5n216N8O1Co/QF7OYNKh/vQtqkgWG/K3dvyRLjkAV5y6RoCL3CfWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095275; c=relaxed/simple;
	bh=245rLmVeUzgo8M8PKT/a63fX947S18yvLoszfNAkjkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iPtek935qMVZiO51w86fOYcYiSGF9FZvOOxwPN8XmkCu8seQIfjsiutwidYnQ88X5lQsumuPdWu4uT402gkoUG+HK5ii+VkFMEuf5DFlZlzpARs28rLe2acJtdQevmD+zeu0ZU/VTebV4C89Wqagsy71r1pIyAN9KTq6YxQT2r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=N+clUjaq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso277869066b.1
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 05:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1734095271; x=1734700071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2XTHRtl5gUjhA1WA9gq+EZYJIfIZzbzcnxszdlEeLQ=;
        b=N+clUjaqwO6PduiF2rCd4SOjbrLI4kP6s5+MdHdQmxN+AOeqLv80jo/V3c1qBVyXLk
         1ewsvknQFRM0/bmI3d/IB2YiQ5yITHh43VPEWGXezdQLFbIKdVTFw0/f2aOlwnTy7vOh
         OydDwok5DFWn0CwcH3aqOg60CzknYJZGlglxcegMdvBcjzpv9ZkNg3XP6/5rjzmO1H+c
         a1MXtn5/1kpTxNFLI4uetDlUJaG8GXEzV85H9+nTqz9ZYxjbR0tAlwCpNI9pSR5NtSuO
         8++XOrxxMdqdht8SraLhv9Qj0S6gITxbCCjj0iqhiBxQJD2uWm7SH+uch7qehN9vL05M
         f8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095271; x=1734700071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2XTHRtl5gUjhA1WA9gq+EZYJIfIZzbzcnxszdlEeLQ=;
        b=qhuezRGGkmPKxKGFdqway6Txf2O1kWIQqtdXmtB163iH+sUxt2CUTtXmXXzkS2trN/
         9gJtXRkYk0wAQbi57pNMSDRYX5AcF0Cmt5Ljzy/Cn8FqPszNMnpNP/gHiz10NoTlWfQo
         TWncDysMnqx16sDHOpHBAat1DMm7nn8dnIQrPjYxyzHC7a24sUcStUBlkfaIFNIPyi2b
         f25LDL1J2PPFL0oz86aJ8rFmMCIMnju4CT8+hbGF0F8iefeEQQXJB/KXhZ9ITYIoPuFf
         t/EeXHMzKS5suZQcd5XJv7E/J/OajcBNNVmfomPwvEhhlx16AcUj1BQnqz2vzisUcLfS
         L1CQ==
X-Gm-Message-State: AOJu0YzKPbdA+U6AcknrpN2yzbi/6Evr+3iT55nKYDfJ96cseImxiBt2
	WHqXnoadarHWXlyqAwlCoJa0D2z3d/DeMNWO2tzw4FUsM0edO/++UHKPidEK/OUhqQP/DYe8rwl
	7
X-Gm-Gg: ASbGnctiqGr+vDtV+VPcCxyJi/OivWD1nZN/8nd+NMYsOlYeoTaJ5im8inar6dUMRdG
	2oSUpteQuu7KAKDEbAKFQZ76uENfGi65JpucQ76hqhDW1/bss4cKCuvDLv3lAxExplgsLyrBMOg
	/nDNekjL85yE0G1X5a8qKdLexgyDoNvGfafMNGCBy+FJEqfZtefn3mIKWy3gh2Pq94iAjeKKUvt
	zeAYxZsQbmDDcRKrE6T1aJPO/ejY17X9JNTHETO9Ww1X+yT6CL4cynGgXqNrQedn0/GdA==
X-Google-Smtp-Source: AGHT+IFVc07ekxAzMjMvVvn5x8uEGpbysfTukh/KF1vJIss3I+v6yFP4McuV4HmhyJMJigt0UaWvAQ==
X-Received: by 2002:a17:907:6eab:b0:aa6:8d51:8fe2 with SMTP id a640c23a62f3a-aab77e9f793mr247730066b.42.1734095271318;
        Fri, 13 Dec 2024 05:07:51 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa657abb2fbsm931248666b.128.2024.12.13.05.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:07:50 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v5 bpf-next 4/7] bpf: add fd_array_cnt attribute for prog_load
Date: Fri, 13 Dec 2024 13:09:31 +0000
Message-Id: <20241213130934.1087929-5-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213130934.1087929-1-aspsk@isovalent.com>
References: <20241213130934.1087929-1-aspsk@isovalent.com>
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
 include/uapi/linux/bpf.h       |  10 ++++
 kernel/bpf/syscall.c           |   2 +-
 kernel/bpf/verifier.c          | 106 ++++++++++++++++++++++++++++-----
 tools/include/uapi/linux/bpf.h |  10 ++++
 4 files changed, 112 insertions(+), 16 deletions(-)

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
index 296765ffbdc5..555604d5e303 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19505,22 +19505,10 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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
@@ -19551,6 +19539,24 @@ static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd)
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
@@ -19642,7 +19648,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				break;
 			}
 
-			map_idx = add_used_map_from_fd(env, fd);
+			map_idx = add_used_map(env, fd);
 			if (map_idx < 0)
 				return map_idx;
 			map = env->used_maps[map_idx];
@@ -22850,6 +22856,73 @@ struct btf *bpf_get_btf_vmlinux(void)
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
+	struct btf *btf;
+	CLASS(fd, f)(fd);
+	int err;
+
+	map = __bpf_map_get(f);
+	if (!IS_ERR(map)) {
+		err = __add_used_map(env, map);
+		if (err < 0)
+			return err;
+		return 0;
+	}
+
+	btf = __btf_get_by_fd(f);
+	if (!IS_ERR(btf)) {
+		err = __add_used_btf(env, btf);
+		if (err < 0)
+			return err;
+		return 0;
+	}
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
+	/* Check for integer overflow */
+	if (attr->fd_array_cnt >= (U32_MAX / size)) {
+		verbose(env, "fd_array_cnt is too big (%u)\n", attr->fd_array_cnt);
+		return -EINVAL;
+	}
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
@@ -22881,7 +22954,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		env->insn_aux_data[i].orig_idx = i;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
-	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
 
 	env->allow_ptr_leaks = bpf_allow_ptr_leaks(env->prog->aux->token);
 	env->allow_uninit_stack = bpf_allow_uninit_stack(env->prog->aux->token);
@@ -22904,6 +22976,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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


