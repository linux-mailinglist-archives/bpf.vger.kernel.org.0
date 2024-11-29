Return-Path: <bpf+bounces-45874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 271C29DE778
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 14:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20BD281A22
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 13:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BAC19F128;
	Fri, 29 Nov 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="gI6Wqzwf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122919C566
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886760; cv=none; b=s4f0f7g9sscbmVQABS+pbFjirfh0+IbYOWV5WAdY9ApS1LDIr/ie6H70eZiIH+Njh/CcqtpK6bBlhfP/JZNbK8xWfAJzA0bMjf25DZ0M9nfxtJfMJx2+hioOkpJxxltq+WEO+REz7da1MabH5rp/RDQFYPMhgI29ZrATL/iF180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886760; c=relaxed/simple;
	bh=1SWL9EbzbarFkG0HIuke17Dv7jdx7Fix+DDWSFg7uxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OeOtffC6rFy765PBhDkFfJsyriXEIHiWAok1gZqI4HbIYh9f9Hg/xXU4tejhSvtBPbA0QoOLBsl3/dWr2K+//8qyrwDkyWW9zkFMl8SmChhoonOcfUKrI92JyxdBzg7fcBE9lLdzDbIkC3AaeyEX7CFQcgmqn24r8/YCk0OJ3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=gI6Wqzwf; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso247341366b.2
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 05:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732886756; x=1733491556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XpeRWJwzZZZHEPTFcKVXIIr71udHMEOsTLECK9dRZQ=;
        b=gI6WqzwfIFOXb/5Yk06aYp9d6C4ffca6ff+OuWfRIjlH3cq9vEh2D+/snGStEmMpPi
         eW0Mje59p3twH8bGXXmvWUju6PnQ4CVackJb6jDJj0aES9W4hp2z4AV1h3UlgMM9/fck
         F+RrngNEjJ06pkeAkRs4e25B38DsA93+FCFPPPfLThIZo8l9tw7LBeg4W0iOwMnO+ZJx
         hi3OviV73MjoYIIV5HNVrwxkgm3FIxXi/k1L6X+Wgrhe1uu61Ya/kIax3TZcXXSEVCsC
         4IOl1qDBY33Bj5CESZxR0Ro9qgT+qnjEmJ3yi2HQhmpQlkl7/zl8sl/GQ+ocOPtsPHMz
         G/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732886756; x=1733491556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XpeRWJwzZZZHEPTFcKVXIIr71udHMEOsTLECK9dRZQ=;
        b=rBNkemTxVC7Nq4sHDaknPhUdfNH/ZSNHCUbbKwXoROGYkQLm0ilPfwVgAbTixT+OWP
         b0NTgwjRymmAFJd+bmZ3wn4jvhaOtqWjGNlfizHzORlKToINHiChmHggWtCqTjr7AxTL
         PoXFrQ1yyH6MNBL08P47NPafXHCrHbLuyP6VoZ3JvfQsMLuWCV25YcpUq4+ZAQAJ9RIl
         y7k7PD5LoAryiOeFYwaAoccsikgqwz0u4vBfdnXcSfeTDcY7jaKJWQ2lUkOOo+oSP4RQ
         N84dUj5P/0JFbGlS0K2FrY2nGEMcccy74Diil81tCNkyUOTq1/wkrZUt5fVqu1Yr32Pt
         TeHA==
X-Gm-Message-State: AOJu0YwePbQa1TY7gA5G+2B/aA3U321fpQUDleEiwljA4Q+KGpscsd13
	sPGtUDrh58gkGMC7Brop95aBg5hxVeMDm13B2MrjXhMl/S+cVqRDp7woc8RAFDvi1pXfFeO7y1q
	K
X-Gm-Gg: ASbGncv1houe9qjsy4iOfbSmiJWqIFG8H4EpCMwemOkv299gebqLkAMRVeu5jZLAjCk
	IP4vtuNJ9fxNsZAkTAJUyeF48JksJx8TejedIrQVolutPOnBXrq2fvYMzma/iKSQFFeEixSLNMR
	P6BaRc5QoSBp/AjvTGFs/HMqrmEk7SXCGf12amIhAp5vXudYzH/+bVm1xkZc3N2zRKJAuEJvvz4
	EAnb/tllvLHKnVHvSE0dKuRg3wreoUxGb4lL+s0lqfk3JaXLigr8UJ6BQIq9fM=
X-Google-Smtp-Source: AGHT+IFDsJKEETI7PkYNIu83wbSymXr/9GPnJnkYJXAL21+sgF4knyvEQKappJH22Y6OJqAZOnfFlQ==
X-Received: by 2002:a17:906:cc9:b0:a99:8a5c:a357 with SMTP id a640c23a62f3a-aa58106387bmr812652166b.58.1732886756117;
        Fri, 29 Nov 2024 05:25:56 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599904f33sm173295066b.135.2024.11.29.05.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 05:25:55 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v3 bpf-next 3/7] bpf: add fd_array_cnt attribute for prog_load
Date: Fri, 29 Nov 2024 13:28:09 +0000
Message-Id: <20241129132813.1452294-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129132813.1452294-1-aspsk@isovalent.com>
References: <20241129132813.1452294-1-aspsk@isovalent.com>
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
 kernel/bpf/verifier.c          | 94 ++++++++++++++++++++++++++++------
 tools/include/uapi/linux/bpf.h | 10 ++++
 4 files changed, 100 insertions(+), 16 deletions(-)

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
index 8e034a22aa2a..d172f6974fd7 100644
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
@@ -22526,6 +22532,61 @@ struct btf *bpf_get_btf_vmlinux(void)
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
+		ret = __add_used_map(env, map);
+		if (ret < 0)
+			return ret;
+		return 0;
+	}
+
+	if (!IS_ERR(__btf_get_by_fd(f)))
+		return 0;
+
+	verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
+	return PTR_ERR(map);
+}
+
+static int init_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr, bpfptr_t uattr)
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
@@ -22557,7 +22618,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		env->insn_aux_data[i].orig_idx = i;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
-	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
+	ret = init_fd_array(env, attr, uattr);
+	if (ret)
+		goto err_free_aux_data;
 
 	env->allow_ptr_leaks = bpf_allow_ptr_leaks(env->prog->aux->token);
 	env->allow_uninit_stack = bpf_allow_uninit_stack(env->prog->aux->token);
@@ -22775,6 +22838,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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


