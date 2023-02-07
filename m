Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC4E68CB17
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 01:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjBGAY2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 19:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjBGAYV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 19:24:21 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327C330E95;
        Mon,  6 Feb 2023 16:24:12 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d6-20020a17090ae28600b00230aa72904fso4962692pjz.5;
        Mon, 06 Feb 2023 16:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0Snqb6CMiuetiO6S5s5rorG7sEC2nCZI7mBQw8ulK8=;
        b=jSEVYwkQBzQaYKCLjFi2jxJc8xvzQiOP2buZt/7haPKVMnJsT4GKq0rvX+np26uIp9
         VRXjrnHuDVX/JFgreGZ8mPIeGahkLYpJ94A4vm2zBPvxVCeO5LUEtKq87gWschHbVMBs
         1vmLQjDWKT5rTNV2IxZHe35GTPXuQjNDb75R+g7TbkIgtsFemSnW5a1oCLM4+t3so/R3
         PppYSnVR7/TQIqYn25nEIgNtULtK/f0dYKNlYEyWvfsk0L5+TaKMRXcUGn7WWJPlJjoj
         JTgODwguyhloF0FJuFNuAgzkeVC/cTz3lgun7E1lenxfc9vHg/fKhUnYb5qNKN7Dls5s
         /jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T0Snqb6CMiuetiO6S5s5rorG7sEC2nCZI7mBQw8ulK8=;
        b=XL8Spp4NqaCeKIyQa7LhwQxeelfH3uQU3PNRfoKfIFKmW138qLICX1H/HToLPl1fEn
         mokGQcWw/xclklYXlAcgUjWbmTGH+vWN6vs0G3gNux0ionjK80zuN/ls00oICDADTow+
         PTMAXo1bjoqOAJVOcvc/hsZdUqcPeC1czKm21i+TqPRjzqZ2LhRqkT9vSZyU21FMTP9P
         iCb9M7unQPfYMGXkSyc6hj9FLkQJm6WFBd5eHQGqNDgiKa/6oZiy/8BnDLy3Ikk50fzw
         /1rkqBBGIrQsZj2wkTx49uftZCiQfwqfSzSFsU6n0KgxMxoWznSUGPQaasK3Y05Vu+zI
         FsPw==
X-Gm-Message-State: AO0yUKVZiUMCQr4XlB6r2ET7a/F7JLlnapBzPV/30kcpYnoi2bwtI18C
        FjZEALpivAsxZ5pjWQzYZ4o=
X-Google-Smtp-Source: AK7set9v+xJwMgkwEuTHHr+iz8lydYgm0cVWDe/9aHJE7T5msUW+90/Y1WDCxmyMz4+h9KsNxt+GEA==
X-Received: by 2002:a17:903:182:b0:199:14a5:405b with SMTP id z2-20020a170903018200b0019914a5405bmr1070603plg.44.1675729451569;
        Mon, 06 Feb 2023 16:24:11 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:47cc:64dd:1572:cf18])
        by smtp.gmail.com with ESMTPSA id y1-20020a1709029b8100b00189b2b8dbedsm3544080plp.228.2023.02.06.16.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 16:24:11 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        bpf@vger.kernel.org
Subject: [PATCH 3/3] perf lock contention: Support old rw_semaphore type
Date:   Mon,  6 Feb 2023 16:24:03 -0800
Message-Id: <20230207002403.63590-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230207002403.63590-1-namhyung@kernel.org>
References: <20230207002403.63590-1-namhyung@kernel.org>
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

The old kernel has a different type of the owner field in rwsem.
We can check it using bpf_core_type_matches() builtin in clang but
it also needs its own version check since it's available on recent
versions.

Cc: Hao Luo <haoluo@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 57 ++++++++++++++-----
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index c5556606134e..e6007eaeda1a 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -84,6 +84,14 @@ struct {
 	__uint(max_entries, 1);
 } addr_filter SEC(".maps");
 
+struct rw_semaphore___old {
+	struct task_struct *owner;
+} __attribute__((preserve_access_index));
+
+struct rw_semaphore___new {
+	atomic_long_t owner;
+} __attribute__((preserve_access_index));
+
 /* control flags */
 int enabled;
 int has_cpu;
@@ -161,6 +169,41 @@ static inline int update_task_data(struct task_struct *task)
 	return 0;
 }
 
+#ifndef __has_builtin
+# define __has_builtin(x) 0
+#endif
+
+static inline struct task_struct *get_lock_owner(__u64 lock, __u32 flags)
+{
+	struct task_struct *task;
+	__u64 owner = 0;
+
+	if (flags & LCB_F_MUTEX) {
+		struct mutex *mutex = (void *)lock;
+		owner = BPF_CORE_READ(mutex, owner.counter);
+	} else if (flags == LCB_F_READ || flags == LCB_F_WRITE) {
+#if __has_builtin(bpf_core_type_matches)
+		if (bpf_core_type_matches(struct rw_semaphore___old)) {
+			struct rw_semaphore___old *rwsem = (void *)lock;
+			owner = (unsigned long)BPF_CORE_READ(rwsem, owner);
+		} else if (bpf_core_type_matches(struct rw_semaphore___new)) {
+			struct rw_semaphore___new *rwsem = (void *)lock;
+			owner = BPF_CORE_READ(rwsem, owner.counter);
+		}
+#else
+		/* assume new struct */
+		struct rw_semaphore *rwsem = (void *)lock;
+		owner = BPF_CORE_READ(rwsem, owner.counter);
+#endif
+	}
+
+	if (!owner)
+		return NULL;
+
+	task = (void *)(owner & ~7UL);
+	return task;
+}
+
 SEC("tp_btf/contention_begin")
 int contention_begin(u64 *ctx)
 {
@@ -199,19 +242,7 @@ int contention_begin(u64 *ctx)
 		struct task_struct *task;
 
 		if (lock_owner) {
-			if (pelem->flags & LCB_F_MUTEX) {
-				struct mutex *lock = (void *)pelem->lock;
-				unsigned long owner = BPF_CORE_READ(lock, owner.counter);
-
-				task = (void *)(owner & ~7UL);
-			} else if (pelem->flags == LCB_F_READ || pelem->flags == LCB_F_WRITE) {
-				struct rw_semaphore *lock = (void *)pelem->lock;
-				unsigned long owner = BPF_CORE_READ(lock, owner.counter);
-
-				task = (void *)(owner & ~7UL);
-			} else {
-				task = NULL;
-			}
+			task = get_lock_owner(pelem->lock, pelem->flags);
 
 			/* The flags is not used anymore.  Pass the owner pid. */
 			if (task)
-- 
2.39.1.519.gcb327c4b5f-goog

