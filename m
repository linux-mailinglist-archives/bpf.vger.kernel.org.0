Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C74B6DA467
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 23:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbjDFVGq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 17:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbjDFVGd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 17:06:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779E39753;
        Thu,  6 Apr 2023 14:06:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v9so2339243pjk.0;
        Thu, 06 Apr 2023 14:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815182; x=1683407182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7I+ZTLBAAWmNlN+JBk4TipMBC8vuk1wOji+jyAsKtTA=;
        b=g4JIygxRKGw+RQeL1AkR1lDj7TucctKNv+PWq71gm17icpuIeT3xmoTuugrHOLcNr0
         ORQKJuJ2IVmfYcVCXque1deeq+sB83xaNjsybbNsXrMaGS8MT5otHkBuREnwaW3Y2BPp
         IEYNGklF4PxLGGX26J+uBP+kmBL5dbuxPTudwSIDknQ0AFQrgzl9UKVP8+xdx23dCTo7
         2Z6etn1aXcN6VKa8s1Sw1XMy/aQZE6lp/tWtioVC3FOx5JoS+nhGVJZepj3hhskselX0
         Zs4WbVQz24EsYhJXDzcjngDMH3hqMGXGNwItuHOaVg6eTgkhu6zHcUleKquXWZ7+NOqJ
         vHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815182; x=1683407182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7I+ZTLBAAWmNlN+JBk4TipMBC8vuk1wOji+jyAsKtTA=;
        b=SPSjbwSpKUSkkAvJoCHSLmgCfV72gPBXWX8o1ZQUbscxf7LIp4MpPZZ0kr7aBZPUfu
         iFyDthWqyWYxwvpiWBV91c8S3hKHfQaxnTQnyi+JpXk7xYv/D/JpNJv0/mop9puF/x8+
         88OwTkXwZb67Aq4clgILA+Mz4gcC/XQ92ph/h5DtbGTQ1ZP9SPt9/+LguYOfvKd9MFTX
         qxX2WaXMDSDOguihiQBu/j9kl80WWBYGkAnC/W7iJVvCHwHN9DX+5KCtXaFrmpprYFF1
         +4Ktr5Kq5YtNJlbz8ntrjYoXQ0Xsp6pVeRNcIWvGz4Mn8bSe5Tv+nSzqy0/rSrpruZLo
         MW5A==
X-Gm-Message-State: AAQBX9c96CYVtNcIytT9ChVWetMs7Ph77rORX/160MMUQCljM64clDJ6
        DrBMjccMjvhXrYo7Mr6/Cug=
X-Google-Smtp-Source: AKy350b/GP3jdpKFEr7S9KLbbSe9aStLqLmug61iMLgZK620loW/KsTQWHA0VyNjlF5dIGCgY0lrDQ==
X-Received: by 2002:a17:903:64c:b0:1a4:fcc9:ec61 with SMTP id kh12-20020a170903064c00b001a4fcc9ec61mr479341plb.5.1680815182514;
        Thu, 06 Apr 2023 14:06:22 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:3301:38fe:e39e:3d51])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902868500b001a0667822c8sm1777837plo.94.2023.04.06.14.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:06:22 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 7/7] perf lock contention: Do not try to update if hash map is full
Date:   Thu,  6 Apr 2023 14:06:11 -0700
Message-Id: <20230406210611.1622492-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230406210611.1622492-1-namhyung@kernel.org>
References: <20230406210611.1622492-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It doesn't delete data in the task_data and lock_stat maps.  The data
is kept there until it's consumed by userspace at the end.  But it calls
bpf_map_update_elem() again and again, and the data will be discarded if
the map is full.  This is not good.

Worse, in the bpf_map_update_elem(), it keeps trying to get a new node
even if the map was full.  I guess it makes sense if it deletes some node
like in the tstamp map (that's why I didn't make the change there).

In a pre-allocated hash map, that means it'd iterate all CPU to check the
freelist.  And it has a bad performance impact on large machines.

I've checked it on my 64 CPU machine with this.

  $ perf bench sched messaging -g 1000
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 1000 groups == 40000 processes run

       Total time: 2.825 [sec]

And I used the task mode, so that it can guarantee the map is full.
The default map entry size is 16K and this workload has 40K tasks.

Before:
  $ sudo ./perf lock con -abt -E3 -- perf bench sched messaging -g 1000
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 1000 groups == 40000 processes run

       Total time: 11.299 [sec]
   contended   total wait     max wait     avg wait          pid   comm

       19284      3.51 s       3.70 ms    181.91 us      1305863   sched-messaging
         243     84.09 ms    466.67 us    346.04 us      1336608   sched-messaging
         177     66.35 ms     12.08 ms    374.88 us      1220416   node

For some reason, it didn't report the data failures.  But you can see the
total time in the workload is increased a lot (2.8 -> 11.3).  If it fails
early when the map is full, it goes back to normal.

After:
  $ sudo ./perf lock con -abt -E3 -- perf bench sched messaging -g 1000
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 1000 groups == 40000 processes run

       Total time: 3.044 [sec]
   contended   total wait     max wait     avg wait          pid   comm

       18743    591.92 ms    442.96 us     31.58 us      1431454   sched-messaging
          51    210.64 ms    207.45 ms      4.13 ms      1468724   sched-messaging
          81     68.61 ms     65.79 ms    847.07 us      1463183   sched-messaging

  === output for debug ===

  bad: 1164137, total: 2253341
  bad rate: 51.66 %
  histogram of failure reasons
         task: 0
        stack: 0
         time: 0
         data: 1164137

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index cb87c98e5340..23f6e63544ed 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
+#include <asm-generic/errno-base.h>
 
 #include "lock_data.h"
 
@@ -126,6 +127,9 @@ int stack_fail;
 int time_fail;
 int data_fail;
 
+int task_map_full;
+int data_map_full;
+
 static inline int can_record(u64 *ctx)
 {
 	if (has_cpu) {
@@ -177,11 +181,12 @@ static inline int update_task_data(struct task_struct *task)
 		return -1;
 
 	p = bpf_map_lookup_elem(&task_data, &pid);
-	if (p == NULL) {
+	if (p == NULL && !task_map_full) {
 		struct contention_task_data data = {};
 
 		BPF_CORE_READ_STR_INTO(&data.comm, task, comm);
-		bpf_map_update_elem(&task_data, &pid, &data, BPF_NOEXIST);
+		if (bpf_map_update_elem(&task_data, &pid, &data, BPF_NOEXIST) == -E2BIG)
+			task_map_full = 1;
 	}
 
 	return 0;
@@ -370,6 +375,12 @@ int contention_end(u64 *ctx)
 
 	data = bpf_map_lookup_elem(&lock_stat, &key);
 	if (!data) {
+		if (data_map_full) {
+			bpf_map_delete_elem(&tstamp, &pid);
+			__sync_fetch_and_add(&data_fail, 1);
+			return 0;
+		}
+
 		struct contention_data first = {
 			.total_time = duration,
 			.max_time = duration,
@@ -377,12 +388,17 @@ int contention_end(u64 *ctx)
 			.count = 1,
 			.flags = pelem->flags,
 		};
+		int err;
 
 		if (aggr_mode == LOCK_AGGR_ADDR)
 			first.flags |= check_lock_type(pelem->lock, pelem->flags);
 
-		if (bpf_map_update_elem(&lock_stat, &key, &first, BPF_NOEXIST) < 0)
+		err = bpf_map_update_elem(&lock_stat, &key, &first, BPF_NOEXIST);
+		if (err < 0) {
+			if (err == -E2BIG)
+				data_map_full = 1;
 			__sync_fetch_and_add(&data_fail, 1);
+		}
 		bpf_map_delete_elem(&tstamp, &pid);
 		return 0;
 	}
-- 
2.40.0.577.gac1e443424-goog

