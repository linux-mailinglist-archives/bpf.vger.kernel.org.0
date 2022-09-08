Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A105B14CA
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 08:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiIHGiI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 02:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIHGiF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 02:38:05 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530FAC58EB;
        Wed,  7 Sep 2022 23:38:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c198so7069066pfc.13;
        Wed, 07 Sep 2022 23:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=XrKerZgfr8OsAjyFj/pfcukHC6xfGt6r5ZUbVw1UMjA=;
        b=oOdlYalln0v3/1vyUGIKPtIcrNI+M5Q3tPPtiaFjUtIQwIdFPvQHolv1ZZff2MKD0K
         5Z7+1eocGHNmvFLqu1gK9bD5qKRVVfxwD6MDAmngWQQtWzArLLCTMbOWSGVyDmlqkmau
         Neaifc+kN8U2q2v7EPjbq34WPdHXtumPbLkDNcjdllxbyUUeLdKBcZxg+3c3PEZBqJqV
         cbDoGoLHAeKbgN60n3JMHsN7dySDoP8UPsQqO8smJni3T6uTtNStCeJAlRQd3bBKhhcm
         8NyRla0UmgTwdq9+zrHRXk2sgxJ8cu7KyqKCOQ9m1+D7S9/yLh8J0oE8NyP3Tomp/XC1
         ZRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=XrKerZgfr8OsAjyFj/pfcukHC6xfGt6r5ZUbVw1UMjA=;
        b=BMvFBeZqksgIaBHAYGZBX7jnyDNfA/4KU0izfm+kNeysT8Z4y77v0y9LRtfrIoE8+d
         D/xpMhW8xDe6mk9S7BPEznWIo9om7AyocAyHH6YI7LpYcnvpfkcyAVFcethObFNwHCdj
         JB/QW1mxGYGHi2WPrylxCiCrUSTaVxId1shmadt3SOYPEwZl6Msdk30akGdXYeMBevoO
         tAxvwsBMyrnUbUFT+tLQAvtBJYxgUtDY9J5INSHCm1fyFf3M6Tq/I4L6LfDudgw8LpOr
         TZLsuJoSSrnotrHe8meZlKuOgGow45YQGR6AmD8s2ycMw9RKXS1BJkdHPEasRTzIVPQB
         WV6A==
X-Gm-Message-State: ACgBeo3mq0JsTpp6+vEiRdZfuspoIkCLcw9yO3YE85QQS9+/+jXqaTMQ
        g2EvYpGsySVVjlpmEU4/640=
X-Google-Smtp-Source: AA6agR6Wl3fV/Z9sVDie6QCrAqMZ49pcxWl4rCafzAzHBFQFVXu+/mGB+oPJ0jddzwvRiMsZ1KnAXQ==
X-Received: by 2002:a63:e317:0:b0:432:38c0:bde3 with SMTP id f23-20020a63e317000000b0043238c0bde3mr6352573pgh.567.1662619084779;
        Wed, 07 Sep 2022 23:38:04 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:7f21:d032:3f14:a4e6])
        by smtp.gmail.com with ESMTPSA id o33-20020a17090a0a2400b001fb0fc33d72sm890716pjo.47.2022.09.07.23.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 23:38:04 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: [PATCH 4/4] perf lock contention: Skip stack trace from BPF
Date:   Wed,  7 Sep 2022 23:37:54 -0700
Message-Id: <20220908063754.1369709-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220908063754.1369709-1-namhyung@kernel.org>
References: <20220908063754.1369709-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently it collects stack traces to max size then skip entries.
Because we don't have control how to skip perf callchains.  But BPF can
do it with bpf_get_stackid() with a flag.

Say we have max-stack=4 and stack-skip=2, we get these stack traces.

Before:                    After:

      ---> +---+ <--             ---> +---+ <--
     /     |   |    \           /     |   |    \
     |     +---+  usable        |     +---+    |
    max    |   |    /          max    |   |    |
   stack   +---+ <--          stack   +---+  usable
     |     | X |                |     |   |    |
     |     +---+   skip         |     +---+    |
     \     | X |                \     |   |    /
      ---> +---+                 ---> +---+ <--    <=== collection
                                      | X |
                                      +---+   skip
                                      | X |
                                      +---+

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_lock_contention.c          | 7 ++++---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index ef5323c78ffc..efe5b9968e77 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -93,6 +93,8 @@ int lock_contention_prepare(struct lock_contention *con)
 		bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
 	}
 
+	skel->bss->stack_skip = con->stack_skip;
+
 	lock_contention_bpf__attach(skel);
 	return 0;
 }
@@ -127,7 +129,7 @@ int lock_contention_read(struct lock_contention *con)
 	while (!bpf_map_get_next_key(fd, &prev_key, &key)) {
 		struct map *kmap;
 		struct symbol *sym;
-		int idx;
+		int idx = 0;
 
 		bpf_map_lookup_elem(fd, &key, &data);
 		st = zalloc(sizeof(*st));
@@ -146,8 +148,7 @@ int lock_contention_read(struct lock_contention *con)
 
 		bpf_map_lookup_elem(stack, &key, stack_trace);
 
-		/* skip BPF + lock internal functions */
-		idx = con->stack_skip;
+		/* skip lock internal functions */
 		while (is_lock_function(machine, stack_trace[idx]) &&
 		       idx < con->max_stack - 1)
 			idx++;
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 9e8b94eb6320..e107d71f0f1a 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -72,6 +72,7 @@ struct {
 int enabled;
 int has_cpu;
 int has_task;
+int stack_skip;
 
 /* error stat */
 unsigned long lost;
@@ -117,7 +118,7 @@ int contention_begin(u64 *ctx)
 	pelem->timestamp = bpf_ktime_get_ns();
 	pelem->lock = (__u64)ctx[0];
 	pelem->flags = (__u32)ctx[1];
-	pelem->stack_id = bpf_get_stackid(ctx, &stacks, BPF_F_FAST_STACK_CMP);
+	pelem->stack_id = bpf_get_stackid(ctx, &stacks, BPF_F_FAST_STACK_CMP | stack_skip);
 
 	if (pelem->stack_id < 0)
 		lost++;
-- 
2.37.2.789.g6183377224-goog

