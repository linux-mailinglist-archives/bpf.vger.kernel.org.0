Return-Path: <bpf+bounces-79228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 278DFD2EC04
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 10:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E5D9300E17A
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55BA350D4D;
	Fri, 16 Jan 2026 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UocNpL1M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A36834FF73
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555770; cv=none; b=VTAkjv4ZGSvEbgXsCsoSB/Z04KKh52vhUungBOUpqUrWehKOCFXg9fmnhN8ifaRwwlrk/spYkvg2sDRIxn2SVLTtqYKUQpg7ghzYXuvPRsjuxPaPvXRiykYBW5gLpzch5qw6YaKi+cvOV+wiVOxtX3oYR7KRb8HOL9tDplAlmJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555770; c=relaxed/simple;
	bh=mE9xjNvoz+1IMTysusBHF1ML5m3fOMvLEJBkotKcgdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J3lN/ZxKem/dyRnewbZ29k+scKrgQXP46Odb93p7ONOV6OdfzdUnqIxuaDnDXf4of9prq/sh5rdptTdamYMgpOUC0UwUyM/vQkDlJX8Kg5zF1waxrYJeRyhnFvucSoEd3WQHPPlvdmlV+euzKQnRxKi5NV0FQMsvUVtkcJOoayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UocNpL1M; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1232d9f25e9so3395960c88.0
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 01:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768555761; x=1769160561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5idxUqndBr36uoUMlgR0ZpyfBo6cXXyztiYxqo6MKRo=;
        b=UocNpL1MPuFnxjJVneku0CZ5L/Aqo3+X6T9CTJWIBZhbgvBxoeStueZOsj1GtFhhT+
         gOYG/857prCOSVU5RlbeOY7FUUS1TZsWwMTDLaIXzq84nLmiCC9fbDotdX2WsG+EH33q
         rwVluLplriG4VeJyPt6hacKMlY2sFYSkZsu6BWaZ8dww2vicbZFfOgHZfjvx9YJofwsI
         1tCt1XIYSC7ilnvYTfFsWMyo6P/hWgoH7TI+PVcZKTy2f3QI9a8gLC6BYSvrFaosBJCz
         YjZ0bPOnQ51FfG/Qpmg6MteHOYgo97CgFfu8pgnyG8l+kH1lxV1u2eaFCB96gf+LRMvD
         +Xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768555761; x=1769160561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5idxUqndBr36uoUMlgR0ZpyfBo6cXXyztiYxqo6MKRo=;
        b=bAT57aTu8MLUFTc+UQSiKedUE8YNzkfqbTYqkgJew1KED1MM+lOla6sft0BY5PEiYE
         /LuhuAfL7V2YjVnvHGknbhueBLWRv9ecHDZi/2YUeAt2BkPHB/B7jY0f3mnMLf9ApAB3
         qsSZumPLRGoQp2biuX37HcljiaQdX6ITnMrzWSIJRbIGWN5IMLvswHUxqxI6V8N57iQB
         PD7JKsJG3Seaopwc4TFZgDwiTEL4VJhgtVBi+3zEhydj6xtYb8zwie+LFq+C+1ZbNFcp
         kF2PkO2pOiNWp2oNIqmlZBymLvTO8isfw2FeuTXN/ZZqhy0igNOZKjHG1BTf/KB1TeId
         IniQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/5gCN9wVZak3NJS9as/DsTgggLJLXY7nB/6dCo04yV2x3UIzusyv+Jex+vrRR55CXpYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZIH//ouRUP2GRSy0zEb5ADpZRGw8JdvuYQyv6T3+jTSKnQoK
	IeXlSwCk2UzzqaMqZ9JjBkO1+5kC8jLsF24aptN7eSFgHniFoYmFuo68
X-Gm-Gg: AY/fxX6922ZT1n/XmeXSNjsmvELNCMjkOO4YCiTuXlccBk3tUPVQV4VAGRjTy6TvaMZ
	joM0O2RnOESscKOHAagnGmFs5kQllA/+X+AOiT0hxCfkFk9lu4J7dVqaPVvVm7MtIgcDMHuDP5o
	R3b0YGFISGXrCz/Xzg+g/OjpYxC/eGTBFEZ3HaGh80zwD4pxT1PaTAz7G+IM1POIjKreFkj+1ZE
	osKup6I6fmJl/Q2mGfzQrbaJGMBnV7gCuZn/yVpGMtk3EKpNORxCpso1yy68wFVQv6Z8M6tVT9N
	fpd8rPnBGJkcyBIDioKr0qnE6hgs6YLRTjugiE4K3nAQuyT21C/mqdB8+Rscl9N1Fnv6e5+H+7U
	KeUt0FK5bVBTJwENyiwaelENGpp+wnGLPCps5EpibtOY/pNplpuXUJE8qe/f5yI/La2I5d9sRWt
	/WNBuiN+HbPLMhvXiTm8eET70=
X-Received: by 2002:a05:7022:6291:b0:119:e56b:958a with SMTP id a92af1059eb24-1244a72ae2bmr2006030c88.15.1768555760531;
        Fri, 16 Jan 2026 01:29:20 -0800 (PST)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244a8938ddsm1567600c88.0.2026.01.16.01.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:29:20 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	realwujing@gmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev,
	yuanql9@chinatelecom.cn
Subject: [PATCH v2] bpf/verifier: optimize ID mapping reset in states_equal
Date: Fri, 16 Jan 2026 17:29:08 +0800
Message-Id: <20260116092908.32252-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAEf4Bzb79hesJiPWK3hoNb8LrpmWv+OmqSCE284cXMHHQUWJew@mail.gmail.com>
References: <CAEf4Bzb79hesJiPWK3hoNb8LrpmWv+OmqSCE284cXMHHQUWJew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier uses an ID mapping table (struct bpf_idmap) during state
equivalence checks. Currently, reset_idmap_scratch performs a full memset
on the entire map (~4.7KB) in every call to states_equal.

Following suggestions from Eduard Zingerman and Andrii Nakryiko, this
patch optimizes the reset logic to avoid unnecessary memory operations:

1. Rename 'map_cnt' to 'cnt' for brevity.
2. Replace the O(N) memset() in reset_idmap_scratch() with a simple
   O(1) counter reset (idmap->cnt = 0).
3. Update check_ids() to search only up to 'idmap->cnt' entries. If no
   mapping is found, append the new mapping and increment 'cnt'.

This ensures that reset overhead is minimal and the search loop is
bounded by the number of IDs actually encountered in the current
equivalence check.

Benchmark results (system-wide 'perf stat' during high-concurrency 'veristat'
stress test, 60s):

The following results, captured using perf while running veristat in parallel
across all CPU cores, show a significant reduction in instruction overhead
(~9.3%) and branch executions (~11%), confirming that the O(1) reset logic
significantly reduces the verifier's workload during state equivalence
checks.

Metric          | Baseline      | Patched       | Delta
----------------|---------------|---------------|----------
Iterations      | 5710          | 5731          | +0.37%
Instructions    | 1.714 T       | 1.555 T       | -9.28%
Inst/Iter       | 300.2 M       | 271.3 M       | -9.63%
Cycles          | 1.436 T       | 1.335 T       | -7.03%
Branches        | 350.4 B       | 311.9 B       | -10.99%
Migrations      | 25,977        | 23,524        | -9.44%

Test Command:
  seq 1 2000000 | sudo perf stat -a -- \
    timeout 60s xargs -P $(nproc) -I {} ./veristat access_map_in_map.bpf.o

Detailed Performance Stats:

Baseline:
 Performance counter stats for 'system wide':

         6,735,538      context-switches                 #   3505.5 cs/sec  cs_per_second
      1,921,431.27 msec cpu-clock                        #     32.0 CPUs  CPUs_utilized
            25,977      cpu-migrations                   #     13.5 migrations/sec  migrations_per_second
         7,268,841      page-faults                      #   3783.0 faults/sec  page_fault_per_second
    18,662,357,052      branch-misses                    #      3.9 %  branch_miss_rate         (50.14%)
   350,411,558,023      branches                         #    182.4 M/sec  branch_frequency     (66.85%)
 1,435,774,261,319      cpu-cycles                       #      0.7 GHz  cycles_frequency       (66.95%)
 1,714,154,229,503      instructions                     #      1.2 instructions  insn_per_cycle  (66.86%)
   429,445,480,497      stalled-cycles-frontend          #     0.30 frontend_cycles_idle        (66.36%)

      60.035899231 seconds time elapsed

Patched:
 Performance counter stats for 'system wide':

         6,662,371      context-switches                 #   3467.3 cs/sec  cs_per_second
      1,921,497.78 msec cpu-clock                        #     32.0 CPUs  CPUs_utilized
            23,524      cpu-migrations                   #     12.2 migrations/sec  migrations_per_second
         7,783,064      page-faults                      #   4050.5 faults/sec  page_faults_per_second
    18,181,655,163      branch-misses                    #      4.3 %  branch_miss_rate         (50.15%)
   311,865,239,743      branches                         #    162.3 M/sec  branch_frequency     (66.86%)
 1,334,859,779,821      cpu-cycles                       #      0.7 GHz  cycles_frequency       (66.96%)
 1,555,086,465,845      instructions                     #      1.2 instructions  insn_per_cycle  (66.87%)
   407,666,712,045      stalled-cycles-frontend          #     0.31 frontend_cycles_idle        (66.35%)

      60.034702643 seconds time elapsed

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
Hi Eduard and Andrii,

Thank you for the feedback on v1. I've optimized the ID mapping reset
logic to O(1) and updated the benchmark results as suggested.

v1 -> v2:
- Rename map_cnt to cnt (Andrii Nakryiko)
- Eliminate memset() by using cnt to bound search loop (Andrii Nakryiko)
- Remove unnecessary if() check in reset_idmap_scratch() (Eduard Zingerman)
- Use full name in Signed-off-by (Eduard Zingerman)

 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 23 ++++++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 130bcbd66f60..8355b585cd18 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -692,6 +692,7 @@ struct bpf_id_pair {
 
 struct bpf_idmap {
 	u32 tmp_id_gen;
+	u32 cnt;
 	struct bpf_id_pair map[BPF_ID_MAP_SIZE];
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3135643d5695..6ec6d70e5ce7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18948,18 +18948,21 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 	if (old_id == 0) /* cur_id == 0 as well */
 		return true;
 
-	for (i = 0; i < BPF_ID_MAP_SIZE; i++) {
-		if (!map[i].old) {
-			/* Reached an empty slot; haven't seen this id before */
-			map[i].old = old_id;
-			map[i].cur = cur_id;
-			return true;
-		}
+	for (i = 0; i < idmap->cnt; i++) {
 		if (map[i].old == old_id)
 			return map[i].cur == cur_id;
 		if (map[i].cur == cur_id)
 			return false;
 	}
+
+	/* Reached the end of known mappings; haven't seen this id before */
+	if (idmap->cnt < BPF_ID_MAP_SIZE) {
+		map[idmap->cnt].old = old_id;
+		map[idmap->cnt].cur = cur_id;
+		idmap->cnt++;
+		return true;
+	}
+
 	/* We ran out of idmap slots, which should be impossible */
 	WARN_ON_ONCE(1);
 	return false;
@@ -19470,8 +19473,10 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 
 static void reset_idmap_scratch(struct bpf_verifier_env *env)
 {
-	env->idmap_scratch.tmp_id_gen = env->id_gen;
-	memset(&env->idmap_scratch.map, 0, sizeof(env->idmap_scratch.map));
+	struct bpf_idmap *idmap = &env->idmap_scratch;
+
+	idmap->tmp_id_gen = env->id_gen;
+	idmap->cnt = 0;
 }
 
 static bool states_equal(struct bpf_verifier_env *env,
-- 
2.39.5


