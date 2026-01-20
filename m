Return-Path: <bpf+bounces-79535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2876D3BD4B
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09311302E333
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA50025C80D;
	Tue, 20 Jan 2026 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrNj5upo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0A81DE8AD
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874189; cv=none; b=uX93kPpvumFFdLA0UCHHU1G6u2QyjO72JL/WJKTBEoLw2JHk/UG9kyaKX+B+Rds9CGex+Kv9ZfaKKULletYmKVazoYXMfOJLXLoWs6F0eW+jtX/vwj7YL+Fr296zZgecGGG4jX/0pLPOJ0JUKr+U8uuokIhplPYLyRK1y5FQDWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874189; c=relaxed/simple;
	bh=GLQecKHexuR0LR9N3OvtSmstyAexwGd77tPt8q7U3UQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZHFr6PtAc5rHmOHfVQfmmWLS+QCWrY+0IAuXcpVzkBOpFSnHDPyA0c3DH4+Fu6ltKv08KvleppUBayoAKz0p9Harf3jzV6d2VSBb2AEPOHg53QEoPZRI7H1IkMXlNJn2P6VPdXj2+wZHMAd8+QsxXslqsSgOWG5D1QkfK/MDXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrNj5upo; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-11f36012fb2so6941840c88.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 17:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768874187; x=1769478987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCCqZQlRXuTOCucNloGfjcUe3if2CIntAVLWdDySPgw=;
        b=BrNj5upob5iDbPZslaYkle2t2GBPyQOg0n2zaJINuqdjyldK/fi5lPRiooMtE++Yvp
         1No9qhamRIkdFvue0VkgJBpeZHwjp6DB1mpbtpCbAlsNXiv7nW17uJfoa7MzwFXrgYi6
         f/6+G8w5TiLjAs8CzNCwzOrcowsS793P8BEmTOhBQ2bE0YcFdeKMrI0smuntRuuwFTfB
         muvzb5Og/1H8e/lAp5zV4e45Zf/ZT7z8t1lY1UmH4eo733MfqrG1KbGks5YUUa8cbuyI
         uZaUm38b+EveHGuGVyfXBELdBpsE4ZtfY7xyHNWbollPxUkcOQIyV2gma56bc5qZt2Ws
         BztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874187; x=1769478987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DCCqZQlRXuTOCucNloGfjcUe3if2CIntAVLWdDySPgw=;
        b=bftilTkiATH4gbZ4W5Q2zqGr0W0+YKKStRN9FVMlC4ZnePsEL+GamozxDxXePkZ+5e
         cV+WPyYVJdYE0csRP/Bfw6Yb5hWdbIvxZ9e45sUesTfxC4YyUzZdm79eGRwU2QU71InZ
         X73931PsGky4pks/t1728tP1Fk0vD7krBzCm2oYnG+TS0xzBm6hqmMSjap4o0nhMKrjr
         ENBnCcrlFEG2cPok1bSfScTuxAH5ce60MptckSqIyla+6mlrGCO+ncRZhCsfYvDEbnGl
         aKRNuGhUFAcHu2Yg5QYr7O6dosSEMCeJJbLCJQz7Cdo7rQcVGbpkrDzoO37cMDQdBdeQ
         DW5A==
X-Forwarded-Encrypted: i=1; AJvYcCXnqGyKnNP59a0wIehh3a3aT5bOx2Iix+yD+NdFTOc6KOiSTNnQVxKCvKfQHbHnAeTTuAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxExjfm/UxvTox/yEs3y0b/WRQBNTkwqdwItMfUn08I8BNOJT1O
	Fom69QDAj8KwEkqsJztoppVE7vVtBiZqvBZpTM3folGu1eQku2ZayQsj
X-Gm-Gg: AY/fxX52hjhtGpr1vdQhoUoEuN/SWIW9SOrUFvgZCUgSUwc8OjWFZZDqq8cLl7JKte1
	1+7KUGZg0RAiMsOg9/ra/q8W7bJKT9Z39NTVal8cakwWuauy2Aga1RA7wJEMSaTNzftbiIj1zQX
	qbpms6g+ZVQeojQu5zrTR9iauT0pp2m8r5G2ZuyP9SnNIX88rIA12ae5WA05vSFrmgwsjqocMNs
	G6bFTkkQlZ9Gog3mH09/J8LOfNTXz9N9IFb/Anam1fF2858t1Th1SXpot9Yx9YOrwyUd700noLX
	A66JmHU1E/+Khy2JzCDeW6Xpx4ULk6G0utwwMMCPtCurlz8zxDpKiGu/ZNpK1qGVFe+noCWSdmx
	LrR8zog0HfuEVh7/dUnCeEiXAFr7v5Y661152KZ8LxtmyyaDRTJZ036GXF6wvTIxm5nY5MBlRK0
	QeUBuJZ0sdufhvQl0dBqxlXlo=
X-Received: by 2002:a05:7022:928:b0:119:e56b:91e6 with SMTP id a92af1059eb24-1244b35f47amr8360625c88.23.1768874187084;
        Mon, 19 Jan 2026 17:56:27 -0800 (PST)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm18395141c88.7.2026.01.19.17.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:56:26 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: eddyz87@gmail.com
Cc: andrii.nakryiko@gmail.com,
	andrii@kernel.org,
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
Subject: [PATCH v3] bpf/verifier: optimize ID mapping reset in states_equal
Date: Tue, 20 Jan 2026 09:56:16 +0800
Message-Id: <20260120015616.69224-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <f43e25d4f86cf567e06141f0408b0c4c169bd7ed.camel@gmail.com>
References: <f43e25d4f86cf567e06141f0408b0c4c169bd7ed.camel@gmail.com>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
v3:
 - Remove Suggested-by tags per Eduard's feedback.
 - Add Eduard's Acked-by.
 - Credit Andrii Nakryiko for the further optimization suggestion.
 - Mention the limitation of system-wide profiling in commit message.
v2:
 - Further optimize ID mapping reset (suggested by Andrii Nakryiko) by
   using a simple counter reset and bounding the search loop.
v1:
 - Initial version using a watermark-based partial memset to optimize the
   ID mapping reset overhead.
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


