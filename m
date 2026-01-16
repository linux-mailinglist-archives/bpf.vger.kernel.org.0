Return-Path: <bpf+bounces-79226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D01D2E80B
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 10:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FABE302BF79
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 09:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1025E31327B;
	Fri, 16 Jan 2026 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ8UnA+l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93943164D3
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554520; cv=none; b=Oz2cxlEcx4W5+bhU6lKUq064/0CpTUVvGOqrWimwHY4FIt18mXeUF0CgoKBZQht1GCV1E2tCBmIm30RroBoaX0+II/WMdpMDTBxMjJfhT6picvjxo7CA8xm+LvgqbfonVpO+HCsESkQyq/GgpliehhWC9gemrKZE/IG94wwDXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554520; c=relaxed/simple;
	bh=o4lWNk+ZMPcaU9h9ZlO7K6J7v7mhjkHGlTUcDvdru94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O1x+5+bHCnyWRP47ewE/veeU+vqT6HfCGpW7GDPJJ2apIhlz1OoKT/IXleQJv4STXCuSENjCYtGWs746S69bluDbUXwas2p0IHmXz+RRRhUU2QqYtqpuB4+5F+hp6UaKWP8us1x6s2teZBQgmTIT5OflcePdcUk0yTsXUdO1eWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ8UnA+l; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12336c0a8b6so3651943c88.1
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 01:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768554516; x=1769159316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fifXQLQN4gWGPVQytfiaXlhkJ+uL7Zz/OfkNW/kNrss=;
        b=DZ8UnA+lhBjg9k0HMGlxzDw4FGZmqJIeGC6SBkbVe9gL6prCzXkH4auAN8S3b5u7gg
         5tQPfdNdScrgczkrJbngT4cqK/Kjijh2I8lQXTrS2SURz7H77dIKEeoUDlNYaQHHUW9S
         Djoq2s2qoza23aUT8e9cw2AHjbEX2MrndHWPvlyI7/tlOLCtxG/jk11GUq2EY7q6sCJ2
         HkENi68WYLJojm/DOTBgPn6r1nSUeVZ/LoEKtwK6BgLr/lJ2kuy7DGZXIAkzIqza1dEj
         jINXRLUvnKY3PcB9vGlv/lvgSqmmFRM0K4SZ82AKGhqoiVlSicDL0qBXtooFCDLU2xiu
         p8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768554516; x=1769159316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fifXQLQN4gWGPVQytfiaXlhkJ+uL7Zz/OfkNW/kNrss=;
        b=hxR3DeFA4Uc8Fuj3/o94sG1U99j7fT2F6o+yo3iauAZKslJ3W/2YR+o2SBPzyAF/Dy
         dfW7ODmHLxONFFzyojm1f28GDlL3KtysC12FScmzTvcD3wLRiLDOnnpb482m27Ex3UIS
         W7NSm1VkhddH/q53uHuD2zuYLan1aD/GHC1q9PwXWmSn3q1h/7dtX/0oHywjqByry+Hw
         mAjaxRvok9IwWnMLhEq06XNfhJ6XofT1rBebdkxNGisXDV9QtwclPDLPtBdXfXYFqsux
         lBE5MWDJlI6f14AfyWI4960Mxerw8d4U/0Q9CJbtJ11q9s8vEnzg3yqlzrfpJl5bBF8N
         CHwg==
X-Forwarded-Encrypted: i=1; AJvYcCUg3CgINt0g8bL9LE4dHSmFUuoSdj5Tvrcv5POY3e78lHlhono5k5np0xKjCWDiCZC4Ag4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/CnSf/f3OZuxWlfaYq2m1MZKtIklE/K9T2suGS4y3PdiJwPEI
	lGSczmfCZ5DzuzGoHFCKu7n81dkvWrgmN0wGBWZqh6Eocj289AtcbfTT
X-Gm-Gg: AY/fxX6M4AjqP6HdIQr1/KOJkD6nW1+4i76bhRB3d/+XgSoscZ8WUlxcxdQhEKiEtrZ
	X+AcC+Atp/oCliP3AQf4h2knSAnm1JUPnIYApXx6gAH9ACJ1i+hEeDkFAr3I5S4WXP1OiwDwj/4
	V9dvUHfMyH86YaqgwWx7GZZoh941qSQoqMNzXfgMJ6fSGmHqynJ6smbwQGmozvew0gfTxCVqiUm
	rBQ1zktnm67629ERR3MZ+QY+b5fMQGgk+T5Hzl09kpiJMAle5TPreQshR7FHzvMph32QGWQJsXf
	Ua5LbbyRMYjFIMOcb5Ozee2p4lgku0FPzWL4g9Vm0xf3mPO/JRc5LblDWAIBWD8UexWN7pBegbW
	qqSqshy8VRLtAdbgafHABsx4j+7eqHeouoZ1Wv9r567hMezzxmKOQijilbjvlI42/4vNUVR0OX2
	b65TCN3j8ish36ccqf3F6MpIw=
X-Received: by 2002:a05:7022:222:b0:11b:ade6:45bd with SMTP id a92af1059eb24-1244a6fa90amr2245378c88.8.1768554516053;
        Fri, 16 Jan 2026 01:08:36 -0800 (PST)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefab3fsm1479733c88.12.2026.01.16.01.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:08:35 -0800 (PST)
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
Date: Fri, 16 Jan 2026 17:08:09 +0800
Message-Id: <20260116090809.25290-1-realwujing@gmail.com>
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

 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/verifier.c        | 23 +++++++++++------------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 562f7e63be29..8355b585cd18 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -692,7 +692,7 @@ struct bpf_id_pair {
 
 struct bpf_idmap {
 	u32 tmp_id_gen;
-	u32 map_cnt;
+	u32 cnt;
 	struct bpf_id_pair map[BPF_ID_MAP_SIZE];
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6220dde41107..c0e8604618de 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18949,19 +18949,21 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 	if (old_id == 0) /* cur_id == 0 as well */
 		return true;
 
-	for (i = 0; i < BPF_ID_MAP_SIZE; i++) {
-		if (!map[i].old) {
-			/* Reached an empty slot; haven't seen this id before */
-			map[i].old = old_id;
-			map[i].cur = cur_id;
-			idmap->map_cnt = i + 1;
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
@@ -19475,10 +19477,7 @@ static void reset_idmap_scratch(struct bpf_verifier_env *env)
 	struct bpf_idmap *idmap = &env->idmap_scratch;
 
 	idmap->tmp_id_gen = env->id_gen;
-	if (idmap->map_cnt) {
-		memset(idmap->map, 0, idmap->map_cnt * sizeof(struct bpf_id_pair));
-		idmap->map_cnt = 0;
-	}
+	idmap->cnt = 0;
 }
 
 static bool states_equal(struct bpf_verifier_env *env,
-- 
2.39.5


