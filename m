Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39C16B830E
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 21:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCMUsc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 16:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCMUsb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 16:48:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DCCCA1D;
        Mon, 13 Mar 2023 13:48:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso12998108pjs.3;
        Mon, 13 Mar 2023 13:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678740510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKebWal3Uq3B/B29ONbk7l0nGGLiL0OrNfNz2Gv7aas=;
        b=Jerz2VowYpm604pCMi7BCgakKHVM/UQJ0tpx4zE/aJ7m2XKSvvZaeRYsOPHvU7pPau
         2UOTebugH2WetW+MZ2lIQOIr6x0SdEpNKXsdUipe1WOheIn4YqJhP7d87vBPOCwHlcYT
         NKNz8nmEtaQKTNh5XKYS/PEBuiuQVJaPvb6F8rqf+7ofkNyJxX5xbkaIGyAyEwUmMqSj
         iW4eNanNOOWaL00/ZPlq/DFfPs35n3ECcLyigxW/yUPjRUTOit8c3ahMwa1NnpbgLJRI
         fnSj/e7LJB8qYQ62w1bv47RVK1rhnx8n1f2iS5t+QRkukMmyKLiQhjnO9Cwm2sEG/kac
         Hu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678740510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EKebWal3Uq3B/B29ONbk7l0nGGLiL0OrNfNz2Gv7aas=;
        b=HYRirpcrXyPhyFodjzCVLxpOPlmyO8cPtfMQXpOUKbSfAhjXAPSR/++rvrpziWv2x7
         wse/3w/+jjwkpUMGMGiQV/noKjUBSfVupI3dWk5cDEbia4uGSYc5LK0e8ifVTCRDpMom
         j10sY7viaVTrpa4w7Jkoi/AtGMScYfFM+KSABcuuXxKRNAX4FbYyr4qnj5t2XobCTxHD
         fpayhZYLgXdWt7dZe4hqoS6jU7d/SCNti4VKRHtQtraAxttxBoHLZeKjntAITI8UvXRW
         LI1OuFveXmCpuEAjkui4Z5VbVK6HeWE7SiPOTmuVsSGkzKmxG6c6iOwN8tTXHinrdIO0
         xj0Q==
X-Gm-Message-State: AO0yUKV4uUV6Uxl7lClAG/MQYdqsy8RFLtU6GnQ/XjzsJd83lxfR7s5h
        i2WMPn87kr2vCTwVv/F7j8I=
X-Google-Smtp-Source: AK7set/NFHPJznZSDKK/RuZNVANqMGU8JhERNa1yuQ+9wRJB0ObpoorvWVvXjeiwbNUEnov1Km85zA==
X-Received: by 2002:a17:90b:383:b0:23b:513d:8ff6 with SMTP id ga3-20020a17090b038300b0023b513d8ff6mr6315041pjb.40.1678740509544;
        Mon, 13 Mar 2023 13:48:29 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:26de:6cd7:2c4f:96d5])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090aba0c00b0023af8a3cf6esm265026pjr.48.2023.03.13.13.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:48:29 -0700 (PDT)
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
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 1/4] perf lock contention: Track and show mmap_lock with address
Date:   Mon, 13 Mar 2023 13:48:22 -0700
Message-Id: <20230313204825.2665483-2-namhyung@kernel.org>
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

Sometimes there are severe contentions on the mmap_lock and we want
see it in the -l/--lock-addr output.  However it cannot symbolize
the mmap_lock because it's allocated dynamically without symbols.

Stephane and Hao gave me an idea separately to display mmap_lock by
following the current->mm pointer.  I added a flag to mark mmap_lock
after comparing the lock address so that it can show them differently.
With this change it can show mmap_lock like below:

  $ sudo ./perf lock con -abl -- sleep 10
   contended   total wait     max wait     avg wait            address   symbol
   ...
       16344    312.30 ms      2.22 ms     19.11 us   ffff8cc702595640
       17686    310.08 ms      1.49 ms     17.53 us   ffff8cc7025952c0
           3     84.14 ms     45.79 ms     28.05 ms   ffff8cc78114c478   mmap_lock
        3557     76.80 ms     68.75 us     21.59 us   ffff8cc77ca3af58
           1     68.27 ms     68.27 ms     68.27 ms   ffff8cda745dfd70
           9     54.53 ms      7.96 ms      6.06 ms   ffff8cc7642a48b8   mmap_lock
       14629     44.01 ms     60.00 us      3.01 us   ffff8cc7625f9ca0
        3481     42.63 ms    140.71 us     12.24 us   ffffffff937906ac   vmap_area_lock
       16194     38.73 ms     42.15 us      2.39 us   ffff8cd397cbc560
          11     38.44 ms     10.39 ms      3.49 ms   ffff8ccd6d12fbb8   mmap_lock
           1      5.43 ms      5.43 ms      5.43 ms   ffff8cd70018f0d8
        1674      5.38 ms    422.93 us      3.21 us   ffffffff92e06080   tasklist_lock
         581      4.51 ms    130.68 us      7.75 us   ffff8cc9b1259058
           5      3.52 ms      1.27 ms    703.23 us   ffff8cc754510070
         112      3.47 ms     56.47 us     31.02 us   ffff8ccee38b3120
         381      3.31 ms     73.44 us      8.69 us   ffffffff93790690   purge_vmap_area_lock
         255      3.19 ms     36.35 us     12.49 us   ffff8d053ce30c80

Note that mmap_lock was renamed some time ago and it needs to support
old kernels with a different name 'mmap_sem'.

Suggested-by: Stephane Eranian <eranian@google.com>
Suggested-by: Hao Luo <haoluo@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c                     |  2 +-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 41 +++++++++++++++++++
 tools/perf/util/bpf_skel/lock_data.h          |  6 +++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 054997edd98b..c62f4d9363a6 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1663,7 +1663,7 @@ static void print_contention_result(struct lock_contention *con)
 			break;
 		case LOCK_AGGR_ADDR:
 			pr_info("  %016llx   %s\n", (unsigned long long)st->addr,
-				st->name ? : "");
+				(st->flags & LCD_F_MMAP_LOCK) ? "mmap_lock" : st->name);
 			break;
 		default:
 			break;
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index e6007eaeda1a..f092a78ae2b5 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -92,6 +92,14 @@ struct rw_semaphore___new {
 	atomic_long_t owner;
 } __attribute__((preserve_access_index));
 
+struct mm_struct___old {
+	struct rw_semaphore mmap_sem;
+} __attribute__((preserve_access_index));
+
+struct mm_struct___new {
+	struct rw_semaphore mmap_lock;
+} __attribute__((preserve_access_index));
+
 /* control flags */
 int enabled;
 int has_cpu;
@@ -204,6 +212,36 @@ static inline struct task_struct *get_lock_owner(__u64 lock, __u32 flags)
 	return task;
 }
 
+static inline __u32 check_lock_type(__u64 lock, __u32 flags)
+{
+	struct task_struct *curr;
+	struct mm_struct___old *mm_old;
+	struct mm_struct___new *mm_new;
+
+	switch (flags) {
+	case LCB_F_READ:  /* rwsem */
+	case LCB_F_WRITE:
+		curr = bpf_get_current_task_btf();
+		if (curr->mm == NULL)
+			break;
+		mm_new = (void *)curr->mm;
+		if (bpf_core_field_exists(mm_new->mmap_lock)) {
+			if (&mm_new->mmap_lock == (void *)lock)
+				return LCD_F_MMAP_LOCK;
+			break;
+		}
+		mm_old = (void *)curr->mm;
+		if (bpf_core_field_exists(mm_old->mmap_sem)) {
+			if (&mm_old->mmap_sem == (void *)lock)
+				return LCD_F_MMAP_LOCK;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
 SEC("tp_btf/contention_begin")
 int contention_begin(u64 *ctx)
 {
@@ -314,6 +352,9 @@ int contention_end(u64 *ctx)
 			.flags = pelem->flags,
 		};
 
+		if (aggr_mode == LOCK_AGGR_ADDR)
+			first.flags |= check_lock_type(pelem->lock, pelem->flags);
+
 		bpf_map_update_elem(&lock_stat, &key, &first, BPF_NOEXIST);
 		bpf_map_delete_elem(&tstamp, &pid);
 		return 0;
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index 3d35fd4407ac..789f20833798 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -15,6 +15,12 @@ struct contention_task_data {
 	char comm[TASK_COMM_LEN];
 };
 
+/*
+ * Upper bits of the flags in the contention_data are used to identify
+ * some well-known locks which do not have symbols (non-global locks).
+ */
+#define LCD_F_MMAP_LOCK  (1U << 31)
+
 struct contention_data {
 	u64 total_time;
 	u64 min_time;
-- 
2.40.0.rc1.284.g88254d51c5-goog

