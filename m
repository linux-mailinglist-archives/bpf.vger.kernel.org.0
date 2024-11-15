Return-Path: <bpf+bounces-44908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5319CD4BC
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 01:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712142826E1
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B89142A8C;
	Fri, 15 Nov 2024 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="KfGiLjLn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933EB1E517
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731631402; cv=none; b=sfU7R6ASBJ0475rn2V7jpIGJZJXEA4juRbJKavkJPh38fQtxWt3VLUmuU/5Vi4owV9ZKNeapOi7vzG7CHmg5tW1Y2x2JumWprxA+/ttuwPocEsh9SrrciXhhTXkT3ZNJubd3dvhxFLNrStHjW0xQUj0NTd3tYeGSW/KS17Uv8qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731631402; c=relaxed/simple;
	bh=VPzxKVFgPVPNxgNE+A/5EyvwReLr+YyIuKkIQH9akm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qryiQY87fAMheCw4E2+nrqhg57ia23l8ksDFM3UMoT9X7Ou0RzWCcx8/qK1+ItlLw5tg2xdLbzrVhLlw4g2k9wYDrjfkxerXKSUO9Khl35GNrJoZZhVR7sZzNVBd55TM2E7JcV+ezi5gyofyv53FU+n9R4RYY45Wgc8f+VyPAZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=KfGiLjLn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43152b79d25so1352695e9.1
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 16:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1731631398; x=1732236198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twsYQYJUhS5jQIpb92rTVnGqOSwWYxFzpMN8AsEtZVw=;
        b=KfGiLjLn3mmGNhXAJiUZv33DO9MCU0QYzCWMSq8QLwitmCoZlCB1YZTaAmiXgj/Hfa
         VD3MiR074UjYGAZmpgNbuiUpl+yur0/n9a3PuejbRiSfqQkMcdhPuO1q7yYj1kB4X50E
         5jyFK3NgB6NoVx+nuriamr1qNWgv1AXJJypDbdkjO6clIvX503QHBvy5X0qcO5+73Pvw
         RTr/VaoaSwB2E5mck6SYrtD8v2/yDd8OuzyIyqx9BVoUwwxGUGZlc44rHRyHIefBqv6m
         3xIDrRgqAFMVulrvA3eypR7Rt0g5EnYHsFRg7pSBSf4VFjtNxIOceJJ/uxYOa9DgkYbN
         L/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731631398; x=1732236198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twsYQYJUhS5jQIpb92rTVnGqOSwWYxFzpMN8AsEtZVw=;
        b=P5Yqqed4NGC55e3GGyo/IVBvc1BMPcjM8ig1Bw6rnlwW1pUjn60Kn36ZSQQ0SC3jGY
         joQYuM+4ef4HeGDtZKEudAUe/x0AD1U4EU6qtCegPTDweCtpGcq+9xWOQqpQ/Bv6r9Rb
         YJV9wgkA2SkBFqmV7mzjVoGYvQHogti3D1W2TOurEy6Rar8iCMVDh3c9d7fDaKNY9qUI
         1WijmcpZwARk/uYbejU9r549wYKyMKcBPSn1hzWb3PlgjR+D6mYw2xyKmbANRW+ZNqbe
         NAyMcquPJTsWCCYe9vUDpquw3uUt301gLDJA/9mPHdQlSdnfEWYJUiFqHnPPjVBtoWud
         7plQ==
X-Gm-Message-State: AOJu0YyCiDx9hjQV+GWCcqcUFLM59DbA8DN8RzxtxicYqqYZtqiHGj83
	U7B1eVTkDECU6U1aJ0ylw0dpdcCI9LPaxML3Bl7IcaaRWj0duRtseI6pDz9TIjn2xOpDmUaLtv/
	G6tw=
X-Google-Smtp-Source: AGHT+IFvXADUxQfWNszd8tmz8c54z10bvWZA4+Zv0rgekK7K5Kr2Cub6+RK6uaOyTfr+QF1P62pvtQ==
X-Received: by 2002:a05:600c:510b:b0:431:58b3:affa with SMTP id 5b1f17b1804b1-432df72c886mr5329725e9.9.1731631398224;
        Thu, 14 Nov 2024 16:43:18 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab78783sm36781975e9.12.2024.11.14.16.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 16:43:17 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 2/5] bpf: move map/prog compatibility checks
Date: Fri, 15 Nov 2024 00:46:04 +0000
Message-Id: <20241115004607.3144806-3-aspsk@isovalent.com>
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
index f4c39bb50511..45c11d9cee60 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19075,6 +19075,12 @@ static bool is_tracing_prog_type(enum bpf_prog_type type)
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
@@ -19153,25 +19159,48 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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
@@ -19180,12 +19209,9 @@ static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd, bool *reus
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
@@ -19193,6 +19219,10 @@ static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd, bool *reus
 		return -E2BIG;
 	}
 
+	err = check_map_prog_compatibility(env, map, env->prog);
+	if (err)
+		return err;
+
 	if (env->prog->sleepable)
 		atomic64_inc(&map->sleepable_refcnt);
 
@@ -19203,7 +19233,6 @@ static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd, bool *reus
 	 */
 	bpf_map_inc(map);
 
-	*reused = false;
 	env->used_maps[env->used_map_cnt++] = map;
 
 	return env->used_map_cnt - 1;
@@ -19240,7 +19269,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			int map_idx;
 			u64 addr;
 			u32 fd;
-			bool reused;
 
 			if (i == insn_cnt - 1 || insn[1].code != 0 ||
 			    insn[1].dst_reg != 0 || insn[1].src_reg != 0 ||
@@ -19301,7 +19329,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				break;
 			}
 
-			map_idx = add_used_map_from_fd(env, fd, &reused);
+			map_idx = add_used_map_from_fd(env, fd);
 			if (map_idx < 0)
 				return map_idx;
 			map = env->used_maps[map_idx];
@@ -19309,10 +19337,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			aux = &env->insn_aux_data[i];
 			aux->map_index = map_idx;
 
-			err = check_map_prog_compatibility(env, map, env->prog);
-			if (err)
-				return err;
-
 			if (insn[0].src_reg == BPF_PSEUDO_MAP_FD ||
 			    insn[0].src_reg == BPF_PSEUDO_MAP_IDX) {
 				addr = (unsigned long)map;
@@ -19343,39 +19367,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
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


