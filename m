Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7C162FD8C
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 20:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242876AbiKRTBY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 14:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241915AbiKRTBN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 14:01:13 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DF1218A5;
        Fri, 18 Nov 2022 11:01:12 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso5908211pjc.2;
        Fri, 18 Nov 2022 11:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PZG45DVCWzpKQix+00S+7v15lsLikdvOFa2L1rhz02E=;
        b=gu7/79lwAamCIznCAQOwdlvYS7qrs2p/YrBB243/Ap0J8W/HADwP6LTpsB8hFKoLh+
         ge7dnsjdlbJI0kdiTd20UCBBzR0rG/bmaGSwAhDqNgnPEf2BDcUn80RYU4yfwqjf6Lsn
         QVA4iU5mBQfR4caKjOteYZPm5WmSxTy3C1/Zmnrqb4UiWWk2TxyRq+Yo5QKn4YtHAwOe
         tXrU1RNPj9C2OcWynkhuiF1gQuMGasn26mZntKlbo2b+lPsMzuXgpCCkMQs72A1oFlNy
         QJiGeQZzKJt8OFNXdNVQWDi0CXXAGIKPNgLq/uRPs6OxeFWHN97tCwV2FvX4Aq4RZQ0B
         5ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZG45DVCWzpKQix+00S+7v15lsLikdvOFa2L1rhz02E=;
        b=kgX1RQme290bgJwA3iXrt89xS0/4Eh8Jp0whF/hDUWfHoU2RxDccn44pLS/Nxf1L5A
         1YYoWdG00wOI2YzvMuu0bsDq0aleWzc1+4s8Zkf3HIOKZuAxz8fblHki6Gub94cv8dh+
         QfQ8Ij+CuJ8aqGGsfgZxyu2sy6hmD+4s0hJo6FkyIDIYFYy+I+5DG5v9kgDxC5OW5ygj
         aGFFXB2Qk1bVHv30uErZIZELs2Hna+GwYDbufmj8pkryNjt6HJlObGzr7MqPmawubZDJ
         3dhcZR6z16abZQjrhOc0YEZthwzdALUQIXQnw5DHGxsrmNTcmOJ5DHatm4Sb2SRgtADu
         Rmxw==
X-Gm-Message-State: ANoB5pktsEx5oLU3WmCmEorKm4uROs3olmelCRJa6r63HrUE7vTNelRJ
        VCijOVkExvuzvZ0dfdvqY40=
X-Google-Smtp-Source: AA0mqf4Bztezj9f2y+2p36BvF+DYXQt+bd7bC5bjYeng8ebyzS+a7af+Bvpia1V807T5PIDNuhWpYg==
X-Received: by 2002:a17:903:2112:b0:188:7dca:6f41 with SMTP id o18-20020a170903211200b001887dca6f41mr838705ple.72.1668798071806;
        Fri, 18 Nov 2022 11:01:11 -0800 (PST)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:2f31:8015:7312:9278])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090a67cb00b0021282014066sm5750994pjm.9.2022.11.18.11.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:01:11 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org, Blake Jones <blakejones@google.com>,
        Chris Li <chriscli@google.com>
Subject: [PATCH] perf lock contention: Do not use BPF task local storage
Date:   Fri, 18 Nov 2022 11:01:09 -0800
Message-Id: <20221118190109.1512674-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It caused some troubles when a lock inside kmalloc is contended
because task local storage would allocate memory using kmalloc.
It'd create a recusion and even crash in my system.

There could be a couple of workarounds but I think the simplest
one is to use a pre-allocated hash map.  We could fix the task
local storage to use the safe BPF allocator, but it takes time
so let's change this until it happens actually.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_lock_contention.c         |  1 +
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 34 ++++++++++++-------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 0deec1178778..4db9ad3d50c4 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -39,6 +39,7 @@ int lock_contention_prepare(struct lock_contention *con)
 	bpf_map__set_value_size(skel->maps.stacks, con->max_stack * sizeof(u64));
 	bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_entries);
 	bpf_map__set_max_entries(skel->maps.lock_stat, con->map_nr_entries);
+	bpf_map__set_max_entries(skel->maps.tstamp, con->map_nr_entries);
 
 	if (target__has_cpu(target))
 		ncpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 1bb8628e7c9f..9681cb59b0df 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -40,10 +40,10 @@ struct {
 
 /* maintain timestamp at the beginning of contention */
 struct {
-	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
-	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(type, BPF_MAP_TYPE_HASH);
 	__type(key, int);
 	__type(value, struct tstamp_data);
+	__uint(max_entries, MAX_ENTRIES);
 } tstamp SEC(".maps");
 
 /* actual lock contention statistics */
@@ -103,18 +103,28 @@ static inline int can_record(void)
 SEC("tp_btf/contention_begin")
 int contention_begin(u64 *ctx)
 {
-	struct task_struct *curr;
+	__u32 pid;
 	struct tstamp_data *pelem;
 
 	if (!enabled || !can_record())
 		return 0;
 
-	curr = bpf_get_current_task_btf();
-	pelem = bpf_task_storage_get(&tstamp, curr, NULL,
-				     BPF_LOCAL_STORAGE_GET_F_CREATE);
-	if (!pelem || pelem->lock)
+	pid = bpf_get_current_pid_tgid();
+	pelem = bpf_map_lookup_elem(&tstamp, &pid);
+	if (pelem && pelem->lock)
 		return 0;
 
+	if (pelem == NULL) {
+		struct tstamp_data zero = {};
+
+		bpf_map_update_elem(&tstamp, &pid, &zero, BPF_ANY);
+		pelem = bpf_map_lookup_elem(&tstamp, &pid);
+		if (pelem == NULL) {
+			lost++;
+			return 0;
+		}
+	}
+
 	pelem->timestamp = bpf_ktime_get_ns();
 	pelem->lock = (__u64)ctx[0];
 	pelem->flags = (__u32)ctx[1];
@@ -128,7 +138,7 @@ int contention_begin(u64 *ctx)
 SEC("tp_btf/contention_end")
 int contention_end(u64 *ctx)
 {
-	struct task_struct *curr;
+	__u32 pid;
 	struct tstamp_data *pelem;
 	struct contention_key key;
 	struct contention_data *data;
@@ -137,8 +147,8 @@ int contention_end(u64 *ctx)
 	if (!enabled)
 		return 0;
 
-	curr = bpf_get_current_task_btf();
-	pelem = bpf_task_storage_get(&tstamp, curr, NULL, 0);
+	pid = bpf_get_current_pid_tgid();
+	pelem = bpf_map_lookup_elem(&tstamp, &pid);
 	if (!pelem || pelem->lock != ctx[0])
 		return 0;
 
@@ -156,7 +166,7 @@ int contention_end(u64 *ctx)
 		};
 
 		bpf_map_update_elem(&lock_stat, &key, &first, BPF_NOEXIST);
-		pelem->lock = 0;
+		bpf_map_delete_elem(&tstamp, &pid);
 		return 0;
 	}
 
@@ -169,7 +179,7 @@ int contention_end(u64 *ctx)
 	if (data->min_time > duration)
 		data->min_time = duration;
 
-	pelem->lock = 0;
+	bpf_map_delete_elem(&tstamp, &pid);
 	return 0;
 }
 
-- 
2.38.1.584.g0f3c55d4c2-goog

