Return-Path: <bpf+bounces-46840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FE89F0CFC
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1EC188B95F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 13:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045441E04A0;
	Fri, 13 Dec 2024 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="D6oDt1Ok"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2A1E009C
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095273; cv=none; b=s+L6zmUZ11daSk3h2ya2odwgkeClTn+kjcE6gRqUxbbW5mY1R4LH0ppdfpTqqzxfWCprUKdguI6jkod8Id5BpDbuncR3VeTsRnb7bcsCgfG/vysm5MA4Kr5TWc/43ccdZYlyqp0lPO0LEK1IwSnfl19Qr71U2+HTQk0zKudxlc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095273; c=relaxed/simple;
	bh=ZtxENa+jqn4jXVPlt1jlI+aHUW7sbDXsNZ4nBO4MuIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ikfpg1TpFBcEaCA9pGvicbaHaSUEUDJaw/LFFxdLQnFogtx6O8B9vIlF2dDfIPLnJt2apMpBCNJ5Fq+bK2qdESWml5LThqsapA/6ohCrbtV6sX5mfJj8oKe32VSfMGAywGGUofcWWeXoNvKt5k23vjFKpCfavK9sm8W2aa8SqMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=D6oDt1Ok; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9ec267b879so243804266b.2
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 05:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1734095269; x=1734700069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+9c3vZcvupIwn4d9UrEODkeoUs40+vowIf8iBRNNi4=;
        b=D6oDt1OkezCuXJxapuF58bF806tJu0BReWc169/UeTj9531Z+WKWPJz834Lzzm+vm+
         U0is/n+jAacecB0SdQ9xPcpC3rWW99nxjIMZ1WxMlQsuJYIKA9EMXnWJhpZ83jdvSsOw
         ggxgZl2K/TjP1HkJ3lICP7mQdlTsc7a80qOSGWiYS6PHIMoI8zH11BAZQjGKcIXlOAXp
         pKRXcGyIAYdOzwZoJ/fuRe2q+M8pKexslepUWfY3GRQ+xr0RdsgZHxnvWb5j9G1G3kxe
         nNYCao7VhiuYlZRJco2A8FrntxIuQFsAfRTTwd+WhVgtA/gJ1BZPrnVrK76Q7M3LKuzd
         63gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095269; x=1734700069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+9c3vZcvupIwn4d9UrEODkeoUs40+vowIf8iBRNNi4=;
        b=irEAseAjmI+F/b2mV5LIbSUK38HX7hsBgqOCdxPUfMg908xXVAA7nCvGXgs4xDCdDO
         aT/OmCifEdSm10cUb+vrBBkhrQigIUB4enazeoH8hHcPEWL6d/nJoe/KcfZrYAUf2TFf
         WfPFrSBeMd1yLnSa+ZZ/wVqIcCdJgY6RXbNM5zny5EhTThexB4KG98rNYinxHoV4/4ZQ
         1+UEJevbHWP8dDOxDCS5NuCkxVWF1EX86/FL8Ump9qagWo5PZ2+bIQuvHKcaBFtTQ8QQ
         tex85b0x+C6itipO88Xu7mtL1EX3asBZMWZFpdpQfyqU+87iNpJpLiT4wTKNR7j90bQK
         eBNg==
X-Gm-Message-State: AOJu0Yyhhci9MfIL2djzfdvl9HxJrT9ftJp0Omdjeg+7iCXzJc57lg+E
	JTNiI4xYBhZqW+IHEpOBuIVnaAzhq0nAvkXZLxc5+eNbZE2JHGiTsE3WwfW9v0EFcGlwyf7kD/a
	g
X-Gm-Gg: ASbGnctr+8GDLD/Duj9eO0+819rWMKEwHmNmy2+r6og69cunbYV8spE4ARFOi6wxOhT
	iEaiJTpAXnx1doGHjloMBJDet9f6lWQBkRDRRhU11U8GfrRuq9PTKHgHT6gkgH8OKECtWKDd3H9
	76IBsiU1+BonPtTqkVCPJEJM80mcAzV3RCvorf8fqxTkOXCMzt7Ww3Gwfefv1jdSYeKt+ozgD0T
	c0XpPE20hhkhDdj0kurTBuVQNzinBZKJI3uKdK7XdCreboIznbQRlZFhStn72PApWG5Vg==
X-Google-Smtp-Source: AGHT+IFfhNwEqEnNYjo9jgv7hhaxUycj6PvFEfUhPplku3aXtkYCpy5CjXd/881p+T+5+TAuiZWKgg==
X-Received: by 2002:a17:907:9409:b0:aa6:83cc:7996 with SMTP id a640c23a62f3a-aab77e7b533mr260518166b.42.1734095269085;
        Fri, 13 Dec 2024 05:07:49 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa657abb2fbsm931248666b.128.2024.12.13.05.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:07:48 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v5 bpf-next 2/7] bpf: move map/prog compatibility checks
Date: Fri, 13 Dec 2024 13:09:29 +0000
Message-Id: <20241213130934.1087929-3-aspsk@isovalent.com>
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
index c855e7905c35..89bba0de853f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19368,6 +19368,12 @@ static bool is_tracing_prog_type(enum bpf_prog_type type)
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
@@ -19446,25 +19452,48 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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
@@ -19473,12 +19502,9 @@ static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd, bool *reus
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
@@ -19486,6 +19512,10 @@ static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd, bool *reus
 		return -E2BIG;
 	}
 
+	err = check_map_prog_compatibility(env, map, env->prog);
+	if (err)
+		return err;
+
 	if (env->prog->sleepable)
 		atomic64_inc(&map->sleepable_refcnt);
 
@@ -19496,7 +19526,6 @@ static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd, bool *reus
 	 */
 	bpf_map_inc(map);
 
-	*reused = false;
 	env->used_maps[env->used_map_cnt++] = map;
 
 	return env->used_map_cnt - 1;
@@ -19533,7 +19562,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			int map_idx;
 			u64 addr;
 			u32 fd;
-			bool reused;
 
 			if (i == insn_cnt - 1 || insn[1].code != 0 ||
 			    insn[1].dst_reg != 0 || insn[1].src_reg != 0 ||
@@ -19594,7 +19622,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				break;
 			}
 
-			map_idx = add_used_map_from_fd(env, fd, &reused);
+			map_idx = add_used_map_from_fd(env, fd);
 			if (map_idx < 0)
 				return map_idx;
 			map = env->used_maps[map_idx];
@@ -19602,10 +19630,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			aux = &env->insn_aux_data[i];
 			aux->map_index = map_idx;
 
-			err = check_map_prog_compatibility(env, map, env->prog);
-			if (err)
-				return err;
-
 			if (insn[0].src_reg == BPF_PSEUDO_MAP_FD ||
 			    insn[0].src_reg == BPF_PSEUDO_MAP_IDX) {
 				addr = (unsigned long)map;
@@ -19636,39 +19660,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
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


