Return-Path: <bpf+bounces-46002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0BD9E1E24
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 14:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711CD162481
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 13:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940961DF736;
	Tue,  3 Dec 2024 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="TMCupvHW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383861E009F
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233724; cv=none; b=U0UM5WVThnfEj0ivy/V0OF7Q8f4mkqE2zLVZv6Hm2x00o3cqehxcmAht4s6M7a3u3nF29RgPpu1iW5zMYWyc6sBZMzrGpJ9vQfpbIYUoYub2bvK1yGiVGfXZhjfgIg4L4Eb4qkbte8HyKd0lWoRwOe7PT/XuQ/pv80ux6D41tQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233724; c=relaxed/simple;
	bh=RaCURLyhvuUv4IEXFUW5A6FO4E9KSRJiAy8ykc7vNQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GAPpY9D/9PPb77a1dDnlSTM68rS8104KIgo9m0jdrFpVl4YG12usyZX6XRB4TDs+OMIXt/rdD+J8UCRT6mwr20iplagBNn+i5rJp7uG3bjIR9Bpygl+TbyyJXM8Dq4cLX+PiJHgcFD1KJcbQFbXA9Pmpv+WMFlCjre8Gqmq5sZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=TMCupvHW; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d0d71d7f00so4884108a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 05:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733233720; x=1733838520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96O2iIJ6kHVU2T0b9pQtLYj8nAEcwSxIqjPYwkm5vuA=;
        b=TMCupvHWBbvAIqeJZ9ybc897dssslda3SGAI0HMleDtDsjoi1R3upSSdW4VqgIYQ3h
         04AXjIsPHNIdIdjsmT7GAEgINMIkJ5jS/S2z5Ej5IlpRTJmNmwWqjJKGnAA/gtMp+8wf
         2SCjRhPB5dpuHzaqYehe5Da+eQ1YAeoieayGIQy1IEtHY3t6Q8oLdqyg4CnWk6FloGQ9
         X4yH5hFpRhqpYXtZrzHkrxsLwjNT24FdefZ8J6SHPGSfx5dIwOzMJ0SB/e0ke6cJRT8+
         icFDuFfdqTv5ut+D6SWQQ7JEq3jhrsQdztVEsa7gsfNMnae92uvS0Dy7qUh4DhJHI7ua
         aPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233720; x=1733838520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96O2iIJ6kHVU2T0b9pQtLYj8nAEcwSxIqjPYwkm5vuA=;
        b=QPwDf4pEeHLnKXvSDNy1SrZt1QHh9ZxvuZ6hK5C+xe62NuzhI66iRNw5+/Fa8qo26+
         dhmU0F6u+rAXUemc6giRY8qB10ZHVUzpf2g8ZblFKB0ITWWxlqapaA2pn9pWNF6Dhada
         acyiO5fGCdM82jxB0NyXGFGYc+9aDQTbrjLgWznFpCu0OzgMYK3w5Xe/b3IU7k1zK6eu
         i7Z1jsCAjnnPwi+Eb6gL6+3fR08IUlka7We/K44Y/Oo+j5b6C0rLiGcLWBTTzpUV9u68
         ROIJx0XkKzRJ0aYRLUL/kVA2NZ3Ob3a2iZKxbincK1YhfOmyQnejx0GaofKwS9z1VUY2
         T8ZA==
X-Gm-Message-State: AOJu0YwkVt0EisAy0fwldXY3j+mSM7CiqbYoFLIrksABxH/oSuMJIEGe
	GBTHI3CHaIUOXGkYWrG8/HdVBCfZrGBwAm1ky6wIrK/7T39cdvK4ehf0LqX+i9ZiF1kpc8mo4HX
	i
X-Gm-Gg: ASbGncttGinPJyxuZASvqINm63hU+0pmm7wEP8uMcUwxErXJJrgDeM8M2zLmq/m6bD7
	paMfSaoVrLj05WXbwUY6sNDLh+8JzUYDVlMek5vtSzFOAOfIhGAnSKwWi7CkIipWPL6wuigziH4
	ScvQ5KNHhVung9wm+K+Bhk/EwKkfUYAVqGz4KNvvyB+6tocgbr21zsMP5aF5V43e4qfDBfvxc0H
	tYv+9Y+2FnpL0Sx8rndj4WiSSr0wRvp9s8qkG70F94iPCvrV+PoH17FcpZpKa8=
X-Google-Smtp-Source: AGHT+IEdTzUseREISoiPbLB5ECvyOtSjUvGQkX+iTwxQ0nqQT5C1z0sjOJ/FuJNKDIgEvDl/dI37wQ==
X-Received: by 2002:a05:6402:35d4:b0:5d0:bcdd:ff97 with SMTP id 4fb4d7f45d1cf-5d113ca96a4mr193607a12.5.1733233720262;
        Tue, 03 Dec 2024 05:48:40 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d098330dd2sm6243394a12.14.2024.12.03.05.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:48:39 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 bpf-next 2/7] bpf: move map/prog compatibility checks
Date: Tue,  3 Dec 2024 13:50:47 +0000
Message-Id: <20241203135052.3380721-3-aspsk@isovalent.com>
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

Move some inlined map/prog compatibility checks from the
resolve_pseudo_ldimm64() function to the dedicated
check_map_prog_compatibility() function. Call the latter function
from the add_used_map_from_fd() function directly.

This simplifies code and optimizes logic a bit, as before these
changes the check_map_prog_compatibility() function was executed on
every map usage, which doesn't make sense, as it doesn't include any
per-instruction checks, only map type vs. prog type.

(This patch also simplifies a consequent patch which will call the
add_used_map_from_fd() function from another code path.)

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 101 +++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 55 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c4ebb326785..8e034a22aa2a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19064,6 +19064,12 @@ static bool is_tracing_prog_type(enum bpf_prog_type type)
 	}
 }
 
+static bool bpf_map_is_cgroup_storage(struct bpf_map *map)
+{
+	return (map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE ||
+		map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+}
+
 static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 					struct bpf_map *map,
 					struct bpf_prog *prog)
@@ -19142,25 +19148,48 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 			return -EINVAL;
 		}
 
-	return 0;
-}
+	if (bpf_map_is_cgroup_storage(map) &&
+	    bpf_cgroup_storage_assign(env->prog->aux, map)) {
+		verbose(env, "only one cgroup storage of each type is allowed\n");
+		return -EBUSY;
+	}
 
-static bool bpf_map_is_cgroup_storage(struct bpf_map *map)
-{
-	return (map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE ||
-		map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+	if (map->map_type == BPF_MAP_TYPE_ARENA) {
+		if (env->prog->aux->arena) {
+			verbose(env, "Only one arena per program\n");
+			return -EBUSY;
+		}
+		if (!env->allow_ptr_leaks || !env->bpf_capable) {
+			verbose(env, "CAP_BPF and CAP_PERFMON are required to use arena\n");
+			return -EPERM;
+		}
+		if (!env->prog->jit_requested) {
+			verbose(env, "JIT is required to use arena\n");
+			return -EOPNOTSUPP;
+		}
+		if (!bpf_jit_supports_arena()) {
+			verbose(env, "JIT doesn't support arena\n");
+			return -EOPNOTSUPP;
+		}
+		env->prog->aux->arena = (void *)map;
+		if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
+			verbose(env, "arena's user address must be set via map_extra or mmap()\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
 }
 
 /* Add map behind fd to used maps list, if it's not already there, and return
- * its index. Also set *reused to true if this map was already in the list of
- * used maps.
+ * its index.
  * Returns <0 on error, or >= 0 index, on success.
  */
-static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd, bool *reused)
+static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd)
 {
 	CLASS(fd, f)(fd);
 	struct bpf_map *map;
-	int i;
+	int i, err;
 
 	map = __bpf_map_get(f);
 	if (IS_ERR(map)) {
@@ -19169,12 +19198,9 @@ static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd, bool *reus
 	}
 
 	/* check whether we recorded this map already */
-	for (i = 0; i < env->used_map_cnt; i++) {
-		if (env->used_maps[i] == map) {
-			*reused = true;
+	for (i = 0; i < env->used_map_cnt; i++)
+		if (env->used_maps[i] == map)
 			return i;
-		}
-	}
 
 	if (env->used_map_cnt >= MAX_USED_MAPS) {
 		verbose(env, "The total number of maps per program has reached the limit of %u\n",
@@ -19182,6 +19208,10 @@ static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd, bool *reus
 		return -E2BIG;
 	}
 
+	err = check_map_prog_compatibility(env, map, env->prog);
+	if (err)
+		return err;
+
 	if (env->prog->sleepable)
 		atomic64_inc(&map->sleepable_refcnt);
 
@@ -19192,7 +19222,6 @@ static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd, bool *reus
 	 */
 	bpf_map_inc(map);
 
-	*reused = false;
 	env->used_maps[env->used_map_cnt++] = map;
 
 	return env->used_map_cnt - 1;
@@ -19229,7 +19258,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			int map_idx;
 			u64 addr;
 			u32 fd;
-			bool reused;
 
 			if (i == insn_cnt - 1 || insn[1].code != 0 ||
 			    insn[1].dst_reg != 0 || insn[1].src_reg != 0 ||
@@ -19290,7 +19318,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				break;
 			}
 
-			map_idx = add_used_map_from_fd(env, fd, &reused);
+			map_idx = add_used_map_from_fd(env, fd);
 			if (map_idx < 0)
 				return map_idx;
 			map = env->used_maps[map_idx];
@@ -19298,10 +19326,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			aux = &env->insn_aux_data[i];
 			aux->map_index = map_idx;
 
-			err = check_map_prog_compatibility(env, map, env->prog);
-			if (err)
-				return err;
-
 			if (insn[0].src_reg == BPF_PSEUDO_MAP_FD ||
 			    insn[0].src_reg == BPF_PSEUDO_MAP_IDX) {
 				addr = (unsigned long)map;
@@ -19332,39 +19356,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			insn[0].imm = (u32)addr;
 			insn[1].imm = addr >> 32;
 
-			/* proceed with extra checks only if its newly added used map */
-			if (reused)
-				goto next_insn;
-
-			if (bpf_map_is_cgroup_storage(map) &&
-			    bpf_cgroup_storage_assign(env->prog->aux, map)) {
-				verbose(env, "only one cgroup storage of each type is allowed\n");
-				return -EBUSY;
-			}
-			if (map->map_type == BPF_MAP_TYPE_ARENA) {
-				if (env->prog->aux->arena) {
-					verbose(env, "Only one arena per program\n");
-					return -EBUSY;
-				}
-				if (!env->allow_ptr_leaks || !env->bpf_capable) {
-					verbose(env, "CAP_BPF and CAP_PERFMON are required to use arena\n");
-					return -EPERM;
-				}
-				if (!env->prog->jit_requested) {
-					verbose(env, "JIT is required to use arena\n");
-					return -EOPNOTSUPP;
-				}
-				if (!bpf_jit_supports_arena()) {
-					verbose(env, "JIT doesn't support arena\n");
-					return -EOPNOTSUPP;
-				}
-				env->prog->aux->arena = (void *)map;
-				if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
-					verbose(env, "arena's user address must be set via map_extra or mmap()\n");
-					return -EINVAL;
-				}
-			}
-
 next_insn:
 			insn++;
 			i++;
-- 
2.34.1


