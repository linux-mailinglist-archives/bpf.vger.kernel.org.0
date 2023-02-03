Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D22688CF9
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 03:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjBCCNf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 21:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjBCCNd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 21:13:33 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D07F21290;
        Thu,  2 Feb 2023 18:13:32 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k13so3926812plg.0;
        Thu, 02 Feb 2023 18:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyJQOGiYU/hwXdfGS7h3Hw/9gX5jq5IXXOZzfWeyHFw=;
        b=T9Ux7T65//D97ke/jh5gsXIp89LPngqP8fNgMXuXaKcDf0gs+aeu59hnL+5fAGPGMh
         JFRHzNmtfdcJHgUvyozlDVX/wAaSP2TGk2/nA7XPR22LP7jywJ4WOtFW++8L8TiOqRT/
         HAxKyvr3YWjw1KKMvj1HgOGILH07uBbzkuKmeVySxEG2dIGLZ3KqSRPKaOIgB0TllkJF
         i1uFK1d9rQEDHhUD6dKMupWc07xkWWDExS9Z07P+ziCNa58cVupj8DVpZa9eh7GBsSz9
         kRGdTVcbdzLlIb6Mvp+kKhqXflB56LvbdxyTq/c7x0oToDuddzvKslVM0H+B7xxLhOhG
         6wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fyJQOGiYU/hwXdfGS7h3Hw/9gX5jq5IXXOZzfWeyHFw=;
        b=Y/XDuz9P01UeXFjTwc85tb1cakVLro7I78hxEWe/a+AQHzWlnKM1CWuAz8f6OjaUhU
         x4K9MU93uOklWoyQUjGDE9qEl21/ODwRFzfKLLmttD2fduWH4U0Of9mMw7wsVnb6QpJ3
         xdYnqLmfou+c16uqQHAqsgW3AYMVv5zOkfqEwDAuua5cfT/5iPUyDRpwCGjkRpyDc67H
         +GyRrLyiiY3yFBgitkwJ9TgTlsOq+ULANsV8XtTgC/iSR3BMPmI8lIyQRLLuSz2iYXuc
         AQOBwTzpUZFrDSZJjLikQiT4xV+3dXdrqD/JEqG7eqm6AznRnK3tairUO8gDcltdIEsy
         29mQ==
X-Gm-Message-State: AO0yUKVUsT3ghlsojzuJzrEZBq4Qa+0r9iWHDBXAHy7dvU4BZditX9Np
        p+kcLvHI1ei/hiwYMnZ7J5E=
X-Google-Smtp-Source: AK7set+oL8uXAtD4KMG3doQQfsqSBQ3gI5VSbuqsoWsmH0+fvVOM/pO/AzFjP2yH/aGZ4oLj/bNd2g==
X-Received: by 2002:a17:90b:3b87:b0:22b:afe2:2bb4 with SMTP id pc7-20020a17090b3b8700b0022bafe22bb4mr8865901pjb.8.1675390411555;
        Thu, 02 Feb 2023 18:13:31 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:6755:96ed:3f18:dac4])
        by smtp.gmail.com with ESMTPSA id fs23-20020a17090af29700b0022c942b8683sm497249pjb.56.2023.02.02.18.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 18:13:30 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, irogers@google.com,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, song@kernel.org,
        haoluo@google.com, bpf@vger.kernel.org, juri.lelli@redhat.com
Subject: [PATCH v2 2/3] perf lock contention: Use lock_stat_find{,new}
Date:   Thu,  2 Feb 2023 18:13:23 -0800
Message-Id: <20230203021324.143540-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230203021324.143540-1-namhyung@kernel.org>
References: <20230203021324.143540-1-namhyung@kernel.org>
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

This is a preparation work to support complex keys of BPF maps.  Now it
has single value key according to the aggregation mode like stack_id or
pid.  But we want to use a combination of those keys.

Then lock_contention_read() should still aggregate the result based on
the key that was requested by user.  The other key info will be used for
filtering.

So instead of creating a lock_stat entry always, Check if it's already
there using lock_stat_find() first.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c             |  4 +--
 tools/perf/util/Build                 |  5 +++-
 tools/perf/util/bpf_lock_contention.c | 41 ++++++++++++++++-----------
 tools/perf/util/lock-contention.h     |  3 ++
 4 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 216a9a252bf4..0593c6e636c6 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -465,7 +465,7 @@ static struct lock_stat *pop_from_result(void)
 	return container_of(node, struct lock_stat, rb);
 }
 
-static struct lock_stat *lock_stat_find(u64 addr)
+struct lock_stat *lock_stat_find(u64 addr)
 {
 	struct hlist_head *entry = lockhashentry(addr);
 	struct lock_stat *ret;
@@ -477,7 +477,7 @@ static struct lock_stat *lock_stat_find(u64 addr)
 	return NULL;
 }
 
-static struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags)
+struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags)
 {
 	struct hlist_head *entry = lockhashentry(addr);
 	struct lock_stat *ret, *new;
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 79b9498886a2..918b501f9bd8 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -154,7 +154,10 @@ perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_ftrace.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_off_cpu.o
-perf-$(CONFIG_PERF_BPF_SKEL) += bpf_lock_contention.o
+
+ifeq ($(CONFIG_LIBTRACEEVENT),y)
+  perf-$(CONFIG_PERF_BPF_SKEL) += bpf_lock_contention.o
+endif
 
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
   perf-$(CONFIG_PERF_BPF_SKEL) += bpf_kwork.o
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 286e52ba9f91..ead2898ba377 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -256,12 +256,34 @@ int lock_contention_read(struct lock_contention *con)
 	prev_key = NULL;
 	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
 		s32 stack_id;
+		const char *name;
 
 		/* to handle errors in the loop body */
 		err = -1;
 
 		bpf_map_lookup_elem(fd, &key, &data);
-		st = zalloc(sizeof(*st));
+
+		if (con->save_callstack) {
+			stack_id = key.aggr_key;
+			bpf_map_lookup_elem(stack, &stack_id, stack_trace);
+		}
+
+		st = lock_stat_find(key.aggr_key);
+		if (st != NULL) {
+			st->wait_time_total += data.total_time;
+			if (st->wait_time_max < data.max_time)
+				st->wait_time_max = data.max_time;
+			if (st->wait_time_min > data.min_time)
+				st->wait_time_min = data.min_time;
+
+			st->nr_contended += data.count;
+			if (st->nr_contended)
+				st->avg_wait_time = st->wait_time_total / st->nr_contended;
+			goto next;
+		}
+
+		name = lock_contention_get_name(con, &key, stack_trace);
+		st = lock_stat_findnew(key.aggr_key, name, data.flags);
 		if (st == NULL)
 			break;
 
@@ -274,14 +296,6 @@ int lock_contention_read(struct lock_contention *con)
 			st->avg_wait_time = data.total_time / data.count;
 
 		st->flags = data.flags;
-		st->addr = key.aggr_key;
-
-		stack_id = key.aggr_key;
-		bpf_map_lookup_elem(stack, &stack_id, stack_trace);
-
-		st->name = strdup(lock_contention_get_name(con, &key, stack_trace));
-		if (st->name == NULL)
-			break;
 
 		if (con->save_callstack) {
 			st->callstack = memdup(stack_trace, stack_size);
@@ -289,19 +303,14 @@ int lock_contention_read(struct lock_contention *con)
 				break;
 		}
 
-		hlist_add_head(&st->hash_entry, con->result);
+next:
 		prev_key = &key;
 
-		/* we're fine now, reset the values */
-		st = NULL;
+		/* we're fine now, reset the error */
 		err = 0;
 	}
 
 	free(stack_trace);
-	if (st) {
-		free(st->name);
-		free(st);
-	}
 
 	return err;
 }
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 17e594d57a61..39d5bfc77f4e 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -65,6 +65,9 @@ struct lock_stat {
  */
 #define MAX_LOCK_DEPTH 48
 
+struct lock_stat *lock_stat_find(u64 addr);
+struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags);
+
 /*
  * struct lock_seq_stat:
  * Place to put on state of one lock sequence
-- 
2.39.1.519.gcb327c4b5f-goog

