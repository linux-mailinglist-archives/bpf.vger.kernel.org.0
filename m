Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347DD6874E5
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 06:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjBBFFF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 00:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjBBFFE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 00:05:04 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D5B1C58E;
        Wed,  1 Feb 2023 21:05:02 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cq16-20020a17090af99000b0022c9791ac39so4455608pjb.4;
        Wed, 01 Feb 2023 21:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEIr+OoIpQkzb209AcBpca6C2Jr4FCiGLC2+Zeyv8Bw=;
        b=gAc/tKg3eLTGHm2VPNaDwZzhE7xqzIKrnrxrhgU7cQdglEXBy3rEkSLvc2RfgKdWjl
         sCNcCDPekxC7g7gu+3QJYOMTwEf/PA2oCJAUNbsM/HoUw2teHZxSi6UdDTn+fmJgb1zJ
         9MamybUMyys/O2W6GdoG8A2Uo3xb6hjfcL0X4db4B6VRTXS7C48v7rtsR0+heFeu9R9O
         BU2qHTvQkcrzJUkkPLpr4obHkpA1CNlAymqgDMntPwjx6Wvx+7zZclmwSolaZSFAlh5L
         sg/sVqcsWEafjGOh6tdYRykpLEULvNoHasdme15YOW+bhx5gURGoSt/Yf8v6xzDbDDMl
         pclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fEIr+OoIpQkzb209AcBpca6C2Jr4FCiGLC2+Zeyv8Bw=;
        b=DqgSLHvCKkbekdSzI6gn2uCDT3KOd3svZfYx9YYrjSWINp0QpD1nG9zYvPDdSjLX+I
         0E/2PMwaftzyvHuw/c04g+G+tr3y8jnf0ORdhqJeAZVRZiaBW/8p9Zyo096Hey4M6HMf
         Rxadg/GJvOtnghRUAEfNlUpxoaVdawAfJWjDnz4XJcXo0+nRqDxVsX2MnmYbXbFEvqNC
         6KyrBhHQFOKkD3RRcYREoqIvB9IFU43aUcyN1zccALeO0vRmg8RMDL1vK8JdhFuw/Tmo
         QfOxGX9AY48faY9/c3HTLAuMlMx/R10Fu2OB2sxWdn6ekEdH6KOSbahhm69xm+OXgLUi
         ouLw==
X-Gm-Message-State: AO0yUKVptoZZAR9lTX8MJFvt++EWhGK50BnZTlZzKjQtaN+Fg3GRM1is
        ioLHYp4PdpqBr3BascUCXFM=
X-Google-Smtp-Source: AK7set+Fn3MqFDqqKNFcsiHY1iAmK0ZnMlbiPau3t3iskHWJOc1XGg8+lIgmgXhDhIgn5r6Zp/Y8fA==
X-Received: by 2002:a17:90b:1bd0:b0:22c:2a36:db3b with SMTP id oa16-20020a17090b1bd000b0022c2a36db3bmr5003499pjb.31.1675314301930;
        Wed, 01 Feb 2023 21:05:01 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:8899:7288:e54d:8b87])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090aba8300b0022bb3ee9b68sm2238374pjr.13.2023.02.01.21.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 21:05:01 -0800 (PST)
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
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: [PATCH 2/4] perf lock contention: Use lock_stat_find{,new}
Date:   Wed,  1 Feb 2023 21:04:53 -0800
Message-Id: <20230202050455.2187592-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230202050455.2187592-1-namhyung@kernel.org>
References: <20230202050455.2187592-1-namhyung@kernel.org>
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
 tools/perf/util/bpf_lock_contention.c | 41 ++++++++++++++++-----------
 tools/perf/util/lock-contention.h     |  3 ++
 3 files changed, 30 insertions(+), 18 deletions(-)

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
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 967ce168f163..c6f2db603d5a 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -254,12 +254,34 @@ int lock_contention_read(struct lock_contention *con)
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
 
@@ -272,14 +294,6 @@ int lock_contention_read(struct lock_contention *con)
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
@@ -287,19 +301,14 @@ int lock_contention_read(struct lock_contention *con)
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
2.39.1.456.gfc5497dd1b-goog

