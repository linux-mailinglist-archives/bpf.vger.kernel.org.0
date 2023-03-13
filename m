Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900BF6B8311
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 21:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjCMUsf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 16:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjCMUse (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 16:48:34 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDB5CA1D;
        Mon, 13 Mar 2023 13:48:32 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nn12so13274042pjb.5;
        Mon, 13 Mar 2023 13:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678740512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGQXTm4YA7W1aKAqyz9fcRI2/M5CKVX/Au3o+59MBZU=;
        b=EYNTUanzwMq5jtd+howQwwD8q32ETnE986COzYzDye4kpCtH3kmyngoU5sOScQUnHc
         C9oGUoY2YESCNEGMSCyJ0fuywNpJVn+hx+i19msZuio543r2ALqKmMVn9Oa/jLO7fFx9
         OBQOJstde6bEM3igY6EjVSjxhpipjPWOCSmP1ebivcApdSXOR364OdrFoUdDuGauS417
         A9JuABChw34rl+5sg1hYz1HbpsJ6PX/A6TGWPhB0tjrWrPN3zGHdEvXNCF/Ya3Yd5G4F
         QaB4GoWRS7GuWVqiGfIVyqvj64fJ9WQNC8qgvM56SOQ/Jnt3srEPZW6iIMvRG8CZjT7/
         hCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678740512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OGQXTm4YA7W1aKAqyz9fcRI2/M5CKVX/Au3o+59MBZU=;
        b=18LJep9h87mN0z/hGQr/F81feNWtWl4vb1wXaTvQ9RSJW5nhxz+01oY2Ix3mZaVK5w
         vxHeq8dAwn4iJfhk/qCwHfRN95U7smRLPDrGB2dghtOyC3V9p4lpeVthgTVIdv08Bsgz
         E/9Zn6982o9HNuJRJwYee4YbD1NPrbC62V7Ib9syf3nmUrQrhBaqNoMr48GCz5EQv0gZ
         8tRNpjigSyH58We7UmwB4yiJzrRFbUEszRiuavozuvHo9+cWoGt4aAOkO4rP1U6BgHO5
         nyfnDtOmZ3DtRnEuvyVIwpA/J4LVKTyV9UebxU1bJtXjPrf36O2f5ISZBucAzEOBwybw
         VtHQ==
X-Gm-Message-State: AO0yUKWcsXQJYQo3te+nF3PJHoWnCVBUqVU+vrzZJ9hGAR/kwYbXn6/Z
        eC7ljpQvvUf/Kd1NlhrPNdI=
X-Google-Smtp-Source: AK7set8Jp2lFGsXpM2X15mHoW8ZLK/qkAhkJg8TvjWpRqQiXKWg3sEi5CBatLGSrJw0eyTCcJ52mTA==
X-Received: by 2002:a17:90a:1a0b:b0:234:190d:e636 with SMTP id 11-20020a17090a1a0b00b00234190de636mr37597100pjk.8.1678740512140;
        Mon, 13 Mar 2023 13:48:32 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:26de:6cd7:2c4f:96d5])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090aba0c00b0023af8a3cf6esm265026pjr.48.2023.03.13.13.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:48:31 -0700 (PDT)
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
Subject: [PATCH 3/4] perf lock contention: Show per-cpu rq_lock with address
Date:   Mon, 13 Mar 2023 13:48:24 -0700
Message-Id: <20230313204825.2665483-4-namhyung@kernel.org>
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

Using the BPF_PROG_RUN mechanism, we can run a raw_tp BPF program to
collect some semi-global locks like per-cpu locks.  Let's add runqueue
locks using bpf_per_cpu_ptr() helper.

  $ sudo ./perf lock con -abl -- sleep 1
   contended   total wait     max wait     avg wait            address   symbol

         248      3.25 ms     32.23 us     13.10 us   ffff8cc75cfd2940   siglock
          60    217.91 us      9.69 us      3.63 us   ffff8cc700061c00
           8     70.23 us     13.86 us      8.78 us   ffff8cc703629484
           4     56.32 us     35.81 us     14.08 us   ffff8cc78b66f778   mmap_lock
           4     16.70 us      5.18 us      4.18 us   ffff8cc7036a0684
           3      4.99 us      2.65 us      1.66 us   ffff8d053da30c80   rq_lock
           2      3.44 us      2.28 us      1.72 us   ffff8d053dcf0c80   rq_lock
           9      2.51 us       371 ns       278 ns   ffff8ccb92479440
           2      2.11 us      1.24 us      1.06 us   ffff8d053db30c80   rq_lock
           2      2.06 us      1.69 us      1.03 us   ffff8d053d970c80   rq_lock

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_lock_contention.c         | 27 ++++++++++++++--
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 31 +++++++++++++++++++
 tools/perf/util/bpf_skel/lock_data.h          |  5 +++
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 51631af3b4d6..235fc7150545 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -151,6 +151,8 @@ int lock_contention_prepare(struct lock_contention *con)
 	skel->bss->needs_callstack = con->save_callstack;
 	skel->bss->lock_owner = con->owner;
 
+	bpf_program__set_autoload(skel->progs.collect_lock_syms, false);
+
 	lock_contention_bpf__attach(skel);
 	return 0;
 }
@@ -198,14 +200,26 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 	}
 
 	if (con->aggr_mode == LOCK_AGGR_ADDR) {
+		int lock_fd = bpf_map__fd(skel->maps.lock_syms);
+
+		/* per-process locks set upper bits of the flags */
 		if (flags & LCD_F_MMAP_LOCK)
 			return "mmap_lock";
 		if (flags & LCD_F_SIGHAND_LOCK)
 			return "siglock";
+
+		/* global locks with symbols */
 		sym = machine__find_kernel_symbol(machine, key->lock_addr, &kmap);
 		if (sym)
-			name = sym->name;
-		return name;
+			return sym->name;
+
+		/* try semi-global locks collected separately */
+		if (!bpf_map_lookup_elem(lock_fd, &key->lock_addr, &flags)) {
+			if (flags == LOCK_CLASS_RQLOCK)
+				return "rq_lock";
+		}
+
+		return "";
 	}
 
 	/* LOCK_AGGR_CALLER: skip lock internal functions */
@@ -258,6 +272,15 @@ int lock_contention_read(struct lock_contention *con)
 		thread__set_comm(idle, "swapper", /*timestamp=*/0);
 	}
 
+	if (con->aggr_mode == LOCK_AGGR_ADDR) {
+		DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			.flags = BPF_F_TEST_RUN_ON_CPU,
+		);
+		int prog_fd = bpf_program__fd(skel->progs.collect_lock_syms);
+
+		bpf_prog_test_run_opts(prog_fd, &opts);
+	}
+
 	/* make sure it loads the kernel map */
 	map__load(maps__first(machine->kmaps));
 
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 4ba34caf84eb..2d50c4395733 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -10,6 +10,9 @@
 /* default buffer size */
 #define MAX_ENTRIES  10240
 
+/* for collect_lock_syms().  4096 was rejected by the verifier */
+#define MAX_CPUS  1024
+
 /* lock contention flags from include/trace/events/lock.h */
 #define LCB_F_SPIN	(1U << 0)
 #define LCB_F_READ	(1U << 1)
@@ -56,6 +59,13 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } task_data SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, 16384);
+} lock_syms SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(key_size, sizeof(__u32));
@@ -378,4 +388,25 @@ int contention_end(u64 *ctx)
 	return 0;
 }
 
+extern struct rq runqueues __ksym;
+
+SEC("raw_tp/bpf_test_finish")
+int BPF_PROG(collect_lock_syms)
+{
+	__u64 lock_addr;
+	__u32 lock_flag;
+
+	for (int i = 0; i < MAX_CPUS; i++) {
+		struct rq *rq = bpf_per_cpu_ptr(&runqueues, i);
+
+		if (rq == NULL)
+			break;
+
+		lock_addr = (__u64)&rq->__lock;
+		lock_flag = LOCK_CLASS_RQLOCK;
+		bpf_map_update_elem(&lock_syms, &lock_addr, &lock_flag, BPF_ANY);
+	}
+	return 0;
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index 5ed1a0955015..e59366f2dba3 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -36,4 +36,9 @@ enum lock_aggr_mode {
 	LOCK_AGGR_CALLER,
 };
 
+enum lock_class_sym {
+	LOCK_CLASS_NONE,
+	LOCK_CLASS_RQLOCK,
+};
+
 #endif /* UTIL_BPF_SKEL_LOCK_DATA_H */
-- 
2.40.0.rc1.284.g88254d51c5-goog

