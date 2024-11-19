Return-Path: <bpf+bounces-45160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 787479D2325
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39978281069
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 10:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440151C2420;
	Tue, 19 Nov 2024 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="WjPVmjnN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2771C1F38
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011197; cv=none; b=jRRIsU6iUmPOyyZ7MZo4jwCCkZa1rSCLwc2wRxNAVWaD9/3jkYvNGBUGL+yrFHWt/liXQp7oSNvdqXunsoCBmC00bQCaMCmzUnqergBE3XJK9ReLgxYFrsvMnbSMkhfyEYIlTbYJiQXKF8eDX855WSjvCv7aZjwbt2xrutotS8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011197; c=relaxed/simple;
	bh=zirssA0mziNJPfvWC+9B0HakpIZiUXZ2ANQBpkBEC24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n0p9M94Ab2JEMO0S6IEoCQ1G7OS2VMQkxBSwtfsaSAPVP3OWwei9XjFC3VWRhVvDe2Lrg2ZfTvrEDR7MsVwrJhvzqdzpfxQQB5bWtKnXVelqR4oXPICml5hnbKMJEVqLW3S7f50gzQRU2leo/HvuGlalih3li3eHROTh8oh6E7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=WjPVmjnN; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so5820380a12.0
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 02:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732011193; x=1732615993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdC16YtzB4SHW0EHay1CU6uRUHGObQ2ODK6yTvLhCUU=;
        b=WjPVmjnN20be4M51qDtJ+U/wEZBZcV4IjmVRl1SxVDQUzerZXdvTBfqUyKrsuqvDhl
         N4y6P8SXu3ENetBpnPKl8Dz25HkSkblK5Zu7ZdpM0zQjxO29EAr3ikyBcJWCGQnGaUEl
         Qek/aJRzmHHG3PF/OnXGn3ozENpA8XpDDGHERiuik9Di0Cd7CouXaZkJBJL3wgk6mIbM
         4qJxoE7z2y3HLB4yRXGHit8FLlKLJNl3kM5IND5AeuXIWNsl35AZ3iZeMpmJOf+M83bX
         ZMsnL450pKjb02i0u8Shs5C+NHO0w/7bQJ2QbriRYlEcyUlkxUOk1iPcV51KQkgp6xkx
         sQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011193; x=1732615993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdC16YtzB4SHW0EHay1CU6uRUHGObQ2ODK6yTvLhCUU=;
        b=sRqWR245syfym7m2ob1SWw4SSdlUfMRO78sGiFr1B39Lp9jyPZIgtsvIPPXC/vcVRa
         Cj2cd/cXSS8l1X2MqSlPcbjyXhiBMb8AaCwtEGrrwYhEYk1OLVFJCiRSSMUavQfhHvFh
         rE5CcmBh7nyvzvAeQY1krMa6d2VL1BfOQ5XlaXxSG8pUrYvVtVLi4+jTlnTnTghP0OGx
         JUEhBWnmuFBE4DhP6vo683MqmH5x23owBxO87h5VBLUNm0Q3xRULeITR53FVFNGjshj0
         VQ4IQwwE/h0KwdG/rAtlD0ENOUnIk4pdPipCG2KLKDnUBfjqcXnOPL2akukKfra6Amv1
         DCUA==
X-Gm-Message-State: AOJu0YxO1V9g9U+6AMpP/pcSR6CAtDHX7JPliv9azZi2kzIq3lsAVVK7
	mLIEONXioM0riQVjoQKl+3ai48dXDjcUR1dlW001DK5JNcJgYUgTCTYTE4cSA1L+08+vrmOV+ZF
	Y
X-Google-Smtp-Source: AGHT+IEIv4tUHxGo8DtPH2uvr6wpsz1YGqwqf672C+GM6B3Uc+EJaZXJ/gQG1HMSgMVRGFdejd01Jw==
X-Received: by 2002:a17:907:d29:b0:a99:fb56:39cc with SMTP id a640c23a62f3a-aa48350996emr1246365466b.38.1732011193354;
        Tue, 19 Nov 2024 02:13:13 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df7eee4sm629003066b.87.2024.11.19.02.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:13:12 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v2 bpf-next 3/6] bpf: add fd_array_cnt attribute for prog_load
Date: Tue, 19 Nov 2024 10:15:49 +0000
Message-Id: <20241119101552.505650-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119101552.505650-1-aspsk@isovalent.com>
References: <20241119101552.505650-1-aspsk@isovalent.com>
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
 4 files changed, 113 insertions(+), 15 deletions(-)

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
index 8e034a22aa2a..a84ba93c0036 100644
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
@@ -19227,6 +19215,24 @@ static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd)
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
@@ -22526,6 +22532,75 @@ struct btf *bpf_get_btf_vmlinux(void)
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
+	if (!IS_ERR(map)) {
+		ret = add_used_map(env, map);
+		if (ret < 0)
+			return ret;
+		return 0;
+	}
+
+	if (!IS_ERR(__btf_get_by_fd(f)))
+		return 0;
+
+	if (!fd)
+		return 0;
+
+	verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
+	return PTR_ERR(map);
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
@@ -22557,7 +22632,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		env->insn_aux_data[i].orig_idx = i;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
-	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
+	ret = env_init_fd_array(env, attr, uattr);
+	if (ret)
+		goto err_free_aux_data;
 
 	env->allow_ptr_leaks = bpf_allow_ptr_leaks(env->prog->aux->token);
 	env->allow_uninit_stack = bpf_allow_uninit_stack(env->prog->aux->token);
@@ -22775,6 +22852,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
+err_free_aux_data:
 	vfree(env->insn_aux_data);
 	kvfree(env->insn_hist);
 err_free_env:
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


