Return-Path: <bpf+bounces-45159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB219D2324
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D24628168F
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9652F1C2317;
	Tue, 19 Nov 2024 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="W16Ih5g8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4289019D06E
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011196; cv=none; b=HnEnZWB56mfN7efNZ5mxvTF5aNr4YMKQRGwCEOzdSfVLuYh04iTp7FKZbzWf8W3TL1ZZEqu26hJ5iQe161vw9e3A8kbUrlDuNhSj2HgLfvnKxFs5lsQH+scYXQgFQMOn2/k9cJamwvldjNF3n1q1XqoaIQBGyUAZM4pjnfLncQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011196; c=relaxed/simple;
	bh=OpOIqZtqfIYvIxbJ+K68wcnxSuyMbBUxcy0WZzOU8NY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nE/J9o+bBetv5ezmMKeJ/QLAhKJRWEZm6+DUe8BxQyXvAC+LzwBCbtML+rIOrd/2tddVuaw8FYI/mDp9udVVyExn2EHmj13mGOjE5HyXr3RzcssZic5mwcVgE52uoKhWzdoLnZtIXlDh2etQ1YVY+dNpK/dZob2JxAy45dYvEbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=W16Ih5g8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9ec267b879so680612266b.2
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 02:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732011192; x=1732615992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGLT+E5YHsywRgyQbGHDFcLaKg16gZ+0JL0g/cmKloE=;
        b=W16Ih5g8PACTX+uKyhGgPFQvZYKXxxiKJr0x8xH0ZQoAgFHJOo65OvUBAFcxgid/xe
         8q3adi2JSn4ePh10fg2hYvjkP2qmaqZTN7NFC5/X/HlyByfWNjmwDMaMPGLJ/Vw9f6Ki
         09OUHMpSrPc+fq0fa6h72kr1PLsEJ6NGKwdUrsh35ijz2e1Vk+e7d65vZjqVoC1f3A2v
         fTX/DGMY7rGJ4WMa9HNidaIoVRS7KmlblDGgqAG/Pv8hnVepT9itRUTe9IBCDawtU5/9
         loCzR5V0z6LBfIZIsjXCa3EyT5CB1Xxjh5InulGzwCgHCur7sVbqhrmfy8tdIX5SGebG
         k0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011192; x=1732615992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGLT+E5YHsywRgyQbGHDFcLaKg16gZ+0JL0g/cmKloE=;
        b=KDUNBuR5cYZmjzgt3eTkUMfkyeg+J+XQmMuoxRFTRifybzFaDWucxfFx4ZLj5Sb3BZ
         y/8eyXQOEr0dsONTC3PjmJ0kdzsT2iz6no8pkgD9MP7mSNAhY+FY0lHNfp/xo8zaWI7o
         vSG3C+u+s6V3K/oh9VQPv1owBol9qNYoUs6s6NPnm/kdE2uHvfhSbDU8+nxar0e+pdlP
         9UoexQXYkLDZXMDDhoz4pIpsvcIqkdfwxyGPmHwi26SRaVw3RSkZ2oXZAA7AhEhdFZbD
         yPuXofV3FO7FG2OMrNs8b4S9ta16vvCmvYgHRW17G4d/5oorYc0SO1ntRsFEo/iWCT8L
         Us8w==
X-Gm-Message-State: AOJu0Yzx1kM+83nrq4Q/quuZul+scNTKZsvOgVmTedNaDGvLFzheFSSV
	PEtJ/2SBITolFhQaqly2Qc6XSuFs2f5nBg+VuQA7oxuHfKESZTmErcziiu9cfQLqR+j7K2dzhBG
	v
X-Google-Smtp-Source: AGHT+IGyCu6TbuJ2iR8mob0xun0GfS6bK7GZqbL4TyHbt9WDc9wmIlHRh0qVdh39djlH7nYkoZyFVA==
X-Received: by 2002:a17:907:9624:b0:a9a:80bd:2920 with SMTP id a640c23a62f3a-aa48354b9ecmr1308083866b.53.1732011192280;
        Tue, 19 Nov 2024 02:13:12 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df7eee4sm629003066b.87.2024.11.19.02.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:13:11 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v2 bpf-next 2/6] bpf: move map/prog compatibility checks
Date: Tue, 19 Nov 2024 10:15:48 +0000
Message-Id: <20241119101552.505650-3-aspsk@isovalent.com>
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


