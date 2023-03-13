Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FC66B8312
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 21:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCMUsm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 16:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCMUsf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 16:48:35 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070B216AC6;
        Mon, 13 Mar 2023 13:48:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i5so14389698pla.2;
        Mon, 13 Mar 2023 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678740513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RciDXnCG/KtX4Q4XcZ5CVs3Bi1XerIjeyGzrjFnWXYw=;
        b=Jvb5hDuwEF3uh8FaYe3r6f5k6p3w1TgfnX8JQkY1WSKdGPWVX1x258Y7IxdX/tPnVJ
         ej/XpP52Ra9JpL3PF2IlBQFexFLavSvD3Q7LBvmk9Mlr13uS6hZzvuXqXBbAR8MRZZ45
         BSlt6+Ph4p76rSxn3PzeKbzy7YZZ8VlKvq4omqujzgOGTZ1r8D8uMMPfm8/iaGlJdjr6
         pKIR/UcOLTi9+Z2HyZLHqDYLSaKoADacAhD4yyWcysd4O0IIIkNvCi6SHPFTVk1ejpNL
         kfU3JibXU58r5JkSD3CoQp5TGV+hKai7TdEDQBUiQ2C3yDTSfifUXz5MYisYYdNBGYNA
         L5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678740513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RciDXnCG/KtX4Q4XcZ5CVs3Bi1XerIjeyGzrjFnWXYw=;
        b=MCVIVLL/2ruv2mwdE+LB5BVamV0bSp9+4zl6GMVgp3enBkxlFPaV6mQT6yXShvhfyu
         +KBB+cOj5yLz2+fyx34f7UZGcV/ntT56nZ5CnjjjrtxfPvbuRJ1ZDJvACjm9gsNg3jte
         qAzRBA+2p1DrkLEczi17Ibo+j8dumg3dHccXSbUO9e4naPAk3hgrPOhmiiKF8fdz/nPF
         SJvcpQubdrRp7SfTe+I/tHIX+Bik+451jXO7CznSFkhgNMg6Q4hgMwzitq5iE8kHLZiG
         rRf3lVkNhJXSqlLw+0K6Sx7Azis0fkbZiert6FWnzbkNzFEClWuFx8hWRFRATBBFbvRi
         xHug==
X-Gm-Message-State: AO0yUKWu/BCy4InfXbglGiamMkb2inuQtLp5/FSW7xbjOEI7vD1pg3SA
        tSlQNn0uSG64EiU4VFvBtE25CGgOEJk=
X-Google-Smtp-Source: AK7set/IfmOLXf/3U5fu+rEDzar/pRMlA/1BLru0aWlZ07K66QKIFddPFsDRbgbAznYNaadOmdxVXQ==
X-Received: by 2002:a17:90b:3810:b0:237:62f7:3106 with SMTP id mq16-20020a17090b381000b0023762f73106mr37551968pjb.17.1678740513428;
        Mon, 13 Mar 2023 13:48:33 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:26de:6cd7:2c4f:96d5])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090aba0c00b0023af8a3cf6esm265026pjr.48.2023.03.13.13.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:48:33 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 4/4] perf lock contention: Show lock type with address
Date:   Mon, 13 Mar 2023 13:48:25 -0700
Message-Id: <20230313204825.2665483-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230313204825.2665483-1-namhyung@kernel.org>
References: <20230313204825.2665483-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Show lock type names after the symbol of locks if any.  This can be
useful especially when it doesn't show the lock symbols.

The indentation before the lock type parenthesis is to recognize lock
symbols more easily.

  $ sudo ./perf lock con -abl -- sleep 1
   contended   total wait     max wait     avg wait            address   symbol

          44      6.13 ms    284.49 us    139.28 us   ffffffff92e06080   tasklist_lock (rwlock)
         159    983.38 us     12.38 us      6.18 us   ffff8cc717c90000   siglock (spinlock)
          10    679.90 us    153.35 us     67.99 us   ffff8cdc2872aaf8   mmap_lock (rwsem)
           9    558.11 us    180.67 us     62.01 us   ffff8cd647914038   mmap_lock (rwsem)
          78    228.56 us      7.82 us      2.93 us   ffff8cc700061c00    (spinlock)
           5     41.60 us     16.93 us      8.32 us   ffffd853acb41468    (spinlock)
          10     37.24 us      5.87 us      3.72 us   ffff8cd560b5c200   siglock (spinlock)
           4     11.17 us      3.97 us      2.79 us   ffff8d053ddf0c80   rq_lock (spinlock)
           1      7.86 us      7.86 us      7.86 us   ffff8cd64791404c    (spinlock)
           1      4.13 us      4.13 us      4.13 us   ffff8d053d930c80   rq_lock (spinlock)
           7      3.98 us      1.67 us       568 ns   ffff8ccb92479440    (mutex)
           2      2.62 us      2.33 us      1.31 us   ffff8cc702e6ede0    (rwlock)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c            | 45 ++++++++++++++++++----------
 tools/perf/util/bpf_skel/lock_data.h |  2 ++
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index c710a5d46638..a845c0ce5dc8 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1548,27 +1548,41 @@ static void sort_result(void)
 
 static const struct {
 	unsigned int flags;
+	const char *str;
 	const char *name;
 } lock_type_table[] = {
-	{ 0,				"semaphore" },
-	{ LCB_F_SPIN,			"spinlock" },
-	{ LCB_F_SPIN | LCB_F_READ,	"rwlock:R" },
-	{ LCB_F_SPIN | LCB_F_WRITE,	"rwlock:W"},
-	{ LCB_F_READ,			"rwsem:R" },
-	{ LCB_F_WRITE,			"rwsem:W" },
-	{ LCB_F_RT,			"rtmutex" },
-	{ LCB_F_RT | LCB_F_READ,	"rwlock-rt:R" },
-	{ LCB_F_RT | LCB_F_WRITE,	"rwlock-rt:W"},
-	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R" },
-	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W" },
-	{ LCB_F_MUTEX,			"mutex" },
-	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex" },
+	{ 0,				"semaphore",	"semaphore" },
+	{ LCB_F_SPIN,			"spinlock",	"spinlock" },
+	{ LCB_F_SPIN | LCB_F_READ,	"rwlock:R",	"rwlock" },
+	{ LCB_F_SPIN | LCB_F_WRITE,	"rwlock:W",	"rwlock" },
+	{ LCB_F_READ,			"rwsem:R",	"rwsem" },
+	{ LCB_F_WRITE,			"rwsem:W",	"rwsem" },
+	{ LCB_F_RT,			"rt=mutex",	"rt-mutex" },
+	{ LCB_F_RT | LCB_F_READ,	"rwlock-rt:R",	"rwlock-rt" },
+	{ LCB_F_RT | LCB_F_WRITE,	"rwlock-rt:W",	"rwlock-rt" },
+	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R",	"percpu-rwsem" },
+	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem" },
+	{ LCB_F_MUTEX,			"mutex",	"mutex" },
+	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
 	/* alias for get_type_flag() */
-	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin" },
+	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin",	"mutex" },
 };
 
 static const char *get_type_str(unsigned int flags)
 {
+	flags &= LCB_F_MAX_FLAGS - 1;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+		if (lock_type_table[i].flags == flags)
+			return lock_type_table[i].str;
+	}
+	return "unknown";
+}
+
+static const char *get_type_name(unsigned int flags)
+{
+	flags &= LCB_F_MAX_FLAGS - 1;
+
 	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 		if (lock_type_table[i].flags == flags)
 			return lock_type_table[i].name;
@@ -1662,7 +1676,8 @@ static void print_contention_result(struct lock_contention *con)
 				pid, pid == -1 ? "Unknown" : thread__comm_str(t));
 			break;
 		case LOCK_AGGR_ADDR:
-			pr_info("  %016llx   %s\n", (unsigned long long)st->addr, st->name);
+			pr_info("  %016llx   %s (%s)\n", (unsigned long long)st->addr,
+				st->name, get_type_name(st->flags));
 			break;
 		default:
 			break;
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index e59366f2dba3..1ba61cb4d480 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -22,6 +22,8 @@ struct contention_task_data {
 #define LCD_F_MMAP_LOCK		(1U << 31)
 #define LCD_F_SIGHAND_LOCK	(1U << 30)
 
+#define LCB_F_MAX_FLAGS		(1U << 7)
+
 struct contention_data {
 	u64 total_time;
 	u64 min_time;
-- 
2.40.0.rc1.284.g88254d51c5-goog

