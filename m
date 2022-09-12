Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA5F5B53AD
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 07:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiILFxg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 01:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiILFxd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 01:53:33 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B3F25C7E;
        Sun, 11 Sep 2022 22:53:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g4so7319165pgc.0;
        Sun, 11 Sep 2022 22:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=QXK8+GKZ3TytRC3Hqogh+zmbF0yaHoccvvpMUvsgBwc=;
        b=eMLeTmnjpd8e7D8q7MDLRKyBXsvUzmIrLDKOzluyPNg5E5vF655TMrQX4dBWjTjybp
         eTN7qsPJtXTDWnNVm7J+XOEvONl0EXMibaytjlaSsiKDuZJVy91eRTUVt3a51GhCvdnR
         E2m6vRUQzlfbnyVKnUq+nfcc+0E3rYdWM3np6ad+hdRangS1vG7uXwM68eygAvWqL/RE
         6EZJJ6gTiyq+Rga/BxB0sFM+1YBrxBjoPwJpbzbB+jd63Qy/ektk9jh92SWDW2ZERA/O
         YC1vcGrboAvPsVywnE5ORLs54i2C55ilgc7+Z4dtFbZQ3p1F1UFO/pUt/WMUt3xyk/De
         mqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=QXK8+GKZ3TytRC3Hqogh+zmbF0yaHoccvvpMUvsgBwc=;
        b=w+wXaFWG9osxjn/7a5oK/khdsTtwRVgoG6m9AB/Y62/gRo4WRu74QbFbfWuI4w6icD
         Q80Qc82oPazN/Z+6WGQhiDhf9ODbujIaHDSahtBoOCPeEEct4gtnU4oQOEzxzFIH7PmV
         SSSJO0HqB4lnslGmazynqmqX2fS5eBS+O3I9t0EzvrHUsEyzuqWzXpKVFHmlnTEIQUMK
         ipSTiF6iT4uupgabVbz8eMSr//rPGt44MtVGfuem21M/FBcky0zvDRdY0p0W40jdekkP
         7dRIX7L9j7HNoYxEI9NBME3LEmoXbMoH8SO6FSdX5/5+zrn8z8lIry9c1/AQG7MdLFgF
         fksw==
X-Gm-Message-State: ACgBeo3kBgjaw7Ne9vlGfVV/Wb6XL/edKAJQnGvjD4DbwlK7XnP6hgpJ
        Y7oVT4N7SuvSTFmNFdNVO4E=
X-Google-Smtp-Source: AA6agR5aMSK+DRHNvz0nwKhF1ui/MciqWp5NZchJAEvR8TDO0LTU78+2e9hTgY+h4hTaVK9mvDLpAw==
X-Received: by 2002:a62:168a:0:b0:532:478f:535e with SMTP id 132-20020a62168a000000b00532478f535emr25981644pfw.75.1662962004932;
        Sun, 11 Sep 2022 22:53:24 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:cfe7:8794:a807:6746])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b00176b87a697fsm4882736pls.269.2022.09.11.22.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 22:53:24 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: [PATCH 4/4] perf lock contention: Skip stack trace from BPF
Date:   Sun, 11 Sep 2022 22:53:14 -0700
Message-Id: <20220912055314.744552-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220912055314.744552-1-namhyung@kernel.org>
References: <20220912055314.744552-1-namhyung@kernel.org>
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

     .---> +---+ <--.           .---> +---+ <--.
     |     |   |    |           |     |   |    |
     |     +---+  usable        |     +---+    |
    max    |   |    |          max    |   |    |
   stack   +---+ <--'         stack   +---+  usable
     |     | X |                |     |   |    |
     |     +---+   skip         |     +---+    |
     |     | X |                |     |   |    |
     `---> +---+                `---> +---+ <--'   <=== collection
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

