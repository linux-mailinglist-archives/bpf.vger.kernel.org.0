Return-Path: <bpf+bounces-45873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C68A9DE777
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 14:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7333D1626F7
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 13:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5171619F104;
	Fri, 29 Nov 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="UTpOyDEA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEF719E806
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886759; cv=none; b=eLyBtpmGg75J3ZMYVdwFPJ1guFFA2t67k7SaTW33aKXiO7zuVN+X4SneoLsxct3+MLxNwxnihsxPPaOpiTMpL1iQKIF3lrYUQH7ticjea9ei3axOgAkQX81p38dqN+tOM/m0VjdccaI2iByrdcALYSS7nVmahX+RTDioJZuQjks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886759; c=relaxed/simple;
	bh=RaCURLyhvuUv4IEXFUW5A6FO4E9KSRJiAy8ykc7vNQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aVhMZRoZzMsezUmv5ot8eIJoDJtCOB42QG0kUc+D0W/POv2ffxvox8m4IcXjxIwHcUotTIetg1BexoldE4BZQYmQInqO7W61Wsw1LmU8qQVUG5Mh7W3ZAuH72uVDwxNUZWXmyAxE3KfBGfzJK4LUsOGHFBfr8p7O1EWHiKSDaH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=UTpOyDEA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffdbc0c103so30244831fa.3
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 05:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732886755; x=1733491555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96O2iIJ6kHVU2T0b9pQtLYj8nAEcwSxIqjPYwkm5vuA=;
        b=UTpOyDEAeS+/u0ok2jOjAZLZOFh4opjoclSeL6YG5Ej3WK6HVgKC+uY+Cf8mMn4z3P
         XEEXM1XbiYE+a0LE/4puRBCtMZR+AnN9U1/oq63V+Bh4BcO+Smh4+IJTtXVseAhMZENc
         +EaGwFGQDQjYQvbUOYZ1vMOZlaPCQ4sjnNUTprZf7ghe13Rm7vL3XbJaG078czJfVXZ0
         jHb3P3RypcsfrOHf0Aen4c6pnLB3kqOGCyzT0ZTCrY022cN/9qdKZu6b4hq+lcK1v/ls
         xM+oOVY6QN78eiW6B+d9rhrVNYIUA4bG2U5kmoXzLKfDo702qrJVCY6jhaX36Gd5tJu/
         L09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732886755; x=1733491555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96O2iIJ6kHVU2T0b9pQtLYj8nAEcwSxIqjPYwkm5vuA=;
        b=inxYqa3dqMP8GSxpC7EEoG68zOuRk/8RdC8LTsKPUPMqXgzkvxGoR13jFhxe4vCEkG
         FOFUYCzhgODmnr+OyIGU1S90V64dzmcUs8ABhjMHnKvxsjbMOGWwtgFoyRJKdYESGDru
         Kla9/sddE7C+QEzyozXsAfyrAN4ALVpIADvlNgcBLaVgxgSu3YRnHYM9QHKt6ZTfixJO
         hbDVN7X2mqL4XPYGXOC9LhgqDfdFAtP1ip06ksSDwXT4icKPFhvFpSv7zwoIOKxh+ok9
         jTN7ly4QSioE/ZzjvK4FJ32iR7JZaRaB7IMdYCKAV5fN9qU/zLE+vqtdsZZC663BFfco
         Fy6w==
X-Gm-Message-State: AOJu0YyjUlc903xLu+jqJODaDDc7SsWIYteGFrG3L6nCxi/4lgdnrxZh
	jrp6nX6ykJJH04cIuXD3rFsu18nkG/4ai8mdo+SGjTZmlCSL+4uLlm9XPD9rEL4eZQTZWyAxwyV
	D
X-Gm-Gg: ASbGncvOPsdNRWvYQauTgqN159YaWtHHw3RQCCLUzrZ6eSGxN10/6LKH4uRHwidRi0m
	gudklibJ/HNt9//VNh8EGkqP7RJ/ph68IZEuWBv/lL5CZb+M+GkDzHt2ZnA0FFfhlDJPqcRzrlQ
	rkguh9g0R3tGQ/OpF54xt05rBO++84GK/Q3pZk7tNgfSIdN7icptnjOuzPaBPC+CXpEObs4Fwfc
	Ty4yvLO8y8cE034PzTvGzI86pIsU7iMnjuGz7yGalwMU4MUDP3AGq5wLvL57aQ=
X-Google-Smtp-Source: AGHT+IHsc4sWzMYjsyeeP/NEOO/1Lm2q/czoCzOdPH/XUCNxNRfmjamwhNonmu+HooA0algDMHQ1/g==
X-Received: by 2002:a2e:ab0a:0:b0:2fb:3df8:6a8c with SMTP id 38308e7fff4ca-2ffd604aa06mr94236891fa.23.1732886755355;
        Fri, 29 Nov 2024 05:25:55 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599904f33sm173295066b.135.2024.11.29.05.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 05:25:54 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 bpf-next 2/7] bpf: move map/prog compatibility checks
Date: Fri, 29 Nov 2024 13:28:08 +0000
Message-Id: <20241129132813.1452294-3-aspsk@isovalent.com>
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


