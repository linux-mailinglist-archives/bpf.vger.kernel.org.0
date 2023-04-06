Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65F36DA466
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 23:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbjDFVGo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 17:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbjDFVGb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 17:06:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353F7AD32;
        Thu,  6 Apr 2023 14:06:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so44074894pjb.4;
        Thu, 06 Apr 2023 14:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815181; x=1683407181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oGWEwUsmNiSPPHrbfPC0Zq8RGaKBQeVwXfJ92f5QoA=;
        b=Av3kyPRaWD7g+IfiQO95Qo5AbZAQDecvzwhdF2lP/wjwe36R+Fu0PjqnBf40rp6zjV
         pffgCHVFK5VsoTIIiqtgDmKHQmEZ/RkrY7Jt2mui4GVt6eNr64/Iad/64GhoZwBz9sZ5
         t3lIoFZW5J7Up7/makzmGQITsAO0VFZQOFYLUzlMGfkrLZt60K1k0EmXAtqOqSObIP+x
         rAlEwQhalQBVZCf/+OSkWh7ZjWhMUs5+pXg8jJbzl598mG5wrW61e/0K19TwyXN5dGi3
         d5obuR1PteRpbAvpFKhhvhMwROovzE6s1HlRTE4xpOOBm+gqOZ1rXp3kSqJgtwpjsv/t
         v65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815181; x=1683407181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+oGWEwUsmNiSPPHrbfPC0Zq8RGaKBQeVwXfJ92f5QoA=;
        b=uI/4MS4UWsSKQGKGGJwx9G8lK9z7anXSFC0CYeVgBP4sHqWfhDgelt9HdnC3xRCrPR
         fnOvgO3lZsvTTeKdkRghM+Nunsanos0OtnvHYY18RX4pnmy7jN73AYUOowos0LMv/8bG
         /yVVz3GoTXagdFtssObivIMtN09GExtsvK4mzkzIbe3wATQPOYUOMdD7ZO6nVNvqHKw5
         z21mbBf4LTEy65crkIRM6TqIoraEGSYjmcKuv96llDj36XJQoQuEYpPcpyBwqtzxY1Cp
         eQ9HLRu38lM0wywK4EYjtSM3omi68s7HuXVKceA1owt1omd9hmQ8qHPpxEjQ2XJsfimE
         lj5g==
X-Gm-Message-State: AAQBX9fh4GBm9X65citvR7p54NMuWw7FtztoX4xgnExMuFYpHsxPRhEC
        JDNGr706JvVvEYVI1xaWJFQ=
X-Google-Smtp-Source: AKy350ZB4HscvPM8esmdseMigs9caiqrUqjFaExGuvuITawy8IzOx2Foz8hF1bHFGpyHNLdFUwfgbg==
X-Received: by 2002:a17:902:c643:b0:1a2:57c4:2a7a with SMTP id s3-20020a170902c64300b001a257c42a7amr353257pls.29.1680815181405;
        Thu, 06 Apr 2023 14:06:21 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:3301:38fe:e39e:3d51])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902868500b001a0667822c8sm1777837plo.94.2023.04.06.14.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:06:21 -0700 (PDT)
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
Subject: [PATCH 6/7] perf lock contention: Revise needs_callstack() condition
Date:   Thu,  6 Apr 2023 14:06:10 -0700
Message-Id: <20230406210611.1622492-7-namhyung@kernel.org>
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

It needs callstacks for two reasons:

 * for stack aggregation mode, the map key is the stack id and it can
   also show the full stack traces when -v is used

 * for other aggregation modes, the stack filter can be used to limit
   lock contentions from known call paths

The -v option is meaningful (in terms of stack trace) only for stack
aggregation mode, so it should not set the save_callstack for other
mode like with -t or -l options.

I've noticed this with the following command line:

  $ sudo ./perf lock con -ablv -E 3 -M 16 -- ./perf bench sched messaging
  ...
   contended   total wait     max wait     avg wait            address   symbol

          88      4.59 ms    108.07 us     52.13 us   ffff935757f46ec0    (spinlock)
          33    905.22 us     73.67 us     27.43 us   ffff935757f41700    (spinlock)
          28    703.69 us     79.28 us     25.13 us   ffff938a3d9b0c80   rq_lock (spinlock)

  === output for debug ===

  bad: 12272, total: 12421
  bad rate: 98.80 %
  histogram of failure reasons
         task: 8285
        stack: 3987    <---------- here
         time: 0
         data: 0

It should not have any failure on stacks since it doesn't use it.
No functional change intended.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c             | 2 +-
 tools/perf/util/bpf_lock_contention.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 7742fa255c44..4e24351b18bd 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -77,7 +77,7 @@ static enum lock_aggr_mode aggr_mode = LOCK_AGGR_ADDR;
 
 static bool needs_callstack(void)
 {
-	return verbose > 0 || !list_empty(&callstack_filters);
+	return !list_empty(&callstack_filters);
 }
 
 static struct thread_stat *thread_stat_find(u32 tid)
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index ea4f697d2a9f..9e20fa8ade09 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -346,7 +346,7 @@ int lock_contention_read(struct lock_contention *con)
 		if (data.count)
 			st->avg_wait_time = data.total_time / data.count;
 
-		if (con->save_callstack) {
+		if (con->aggr_mode == LOCK_AGGR_CALLER && verbose > 0) {
 			st->callstack = memdup(stack_trace, stack_size);
 			if (st->callstack == NULL)
 				break;
-- 
2.40.0.577.gac1e443424-goog

