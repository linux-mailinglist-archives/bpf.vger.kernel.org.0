Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406C26B8316
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 21:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjCMUsq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 16:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjCMUsf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 16:48:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7965B6187;
        Mon, 13 Mar 2023 13:48:31 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id y2so13279204pjg.3;
        Mon, 13 Mar 2023 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678740511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMkL+RuV2gz/hzkO+iEW9HUlD0V+BM8BplklCfPzrkE=;
        b=TrDJUwoqnKQ/G6hrEF9tBK6uK6Tt8itetLQoIX1DE61g0mlVnfnAfJv/wzZ3vVxClO
         u4Y/mYRnrYHipfL5j3C4tCWfMwR5slRbu0Cu5Mzl4uMbRICLMSho1vor6UQeXVo4RgEM
         7GTkSFyG0FHYaZ7kO4zzBDROeJwi1g2+bt4/Yx8/xG4kCZbUxeG/t2MaZMuyCeyREnoW
         m8VFroBuCZVS3HYr/2HxBd5qka5SZnxcpyeMEs3Ee5JAweEb7oW1wbCi4OSb07sXrX+U
         qz3tJQYV91qFkOZIV81kHgNuAP0F1XcggZcDk8PsfBK3LmFTtjaYwaVpsVYL2RqXqcnq
         zL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678740511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JMkL+RuV2gz/hzkO+iEW9HUlD0V+BM8BplklCfPzrkE=;
        b=bXr6GXM22MdomqzTuvVdpMY3weDG8xvXrAVEFqPmeZ/DoyWnCLb89/gzhfF3DHEyQ/
         ABVGTFRDFNgLS2A4z1tsXdJjMY0Cu/uP0GH6EHSwZEGtdEdYl3oy/wBPRhtTKX/Tsqt3
         Qo2W2d3mB/+e8f9VXcH1r8UYqXKThubxogOfudPPFlxZFoXmIQ1+SuT6qpJoSty/LIDC
         Hl4Jx1zw1lVxZv4aaGwWLotjVxVh5OEkR5/INHyhKXTAOgE9sHGzsJ1zGuFl7p1FelBv
         mftdGE7QBmhBOpCxp+2eqOeIEYWsuCiE+5QZOEHyTpj6rAZA/4EdNHrctQeDbGW6f9kd
         q85w==
X-Gm-Message-State: AO0yUKVWdpVL5Qf8WT1a1J9JTj2tDPhowx4kgP4AI9nrg0qD4guxYkoX
        LRULImRrbgtokG4EFbx+3Ps=
X-Google-Smtp-Source: AK7set/ksRuDZOws2N7QlY5ec1AmU0FdbxEc5J5WSEFPJ+yfMpOuGnjCn8xJG9MnXMNhCSB2lB1nPA==
X-Received: by 2002:a17:90b:1b08:b0:23b:308e:b0ab with SMTP id nu8-20020a17090b1b0800b0023b308eb0abmr9028191pjb.34.1678740510896;
        Mon, 13 Mar 2023 13:48:30 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:26de:6cd7:2c4f:96d5])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090aba0c00b0023af8a3cf6esm265026pjr.48.2023.03.13.13.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:48:30 -0700 (PDT)
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
Subject: [PATCH 2/4] perf lock contention: Track and show siglock with address
Date:   Mon, 13 Mar 2023 13:48:23 -0700
Message-Id: <20230313204825.2665483-3-namhyung@kernel.org>
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

Likewise, we can display siglock by following the pointer like
current->sighand->siglock.

  $ sudo ./perf lock con -abl -- sleep 1
   contended   total wait     max wait     avg wait            address   symbol

          16      2.18 ms    305.35 us    136.34 us   ffffffff92e06080   tasklist_lock
          28    521.78 us     31.16 us     18.63 us   ffff8cc703783ec4
           7    119.03 us     23.55 us     17.00 us   ffff8ccb92479440
          15     88.29 us     10.06 us      5.89 us   ffff8cd560b5f380   siglock
           7     37.67 us      9.16 us      5.38 us   ffff8d053daf0c80
           5      8.81 us      4.92 us      1.76 us   ffff8d053d6b0c80

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c                      | 3 +--
 tools/perf/util/bpf_lock_contention.c          | 8 ++++++--
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 5 +++++
 tools/perf/util/bpf_skel/lock_data.h           | 3 ++-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index c62f4d9363a6..c710a5d46638 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1662,8 +1662,7 @@ static void print_contention_result(struct lock_contention *con)
 				pid, pid == -1 ? "Unknown" : thread__comm_str(t));
 			break;
 		case LOCK_AGGR_ADDR:
-			pr_info("  %016llx   %s\n", (unsigned long long)st->addr,
-				(st->flags & LCD_F_MMAP_LOCK) ? "mmap_lock" : st->name);
+			pr_info("  %016llx   %s\n", (unsigned long long)st->addr, st->name);
 			break;
 		default:
 			break;
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index fadcacb9d501..51631af3b4d6 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -169,7 +169,7 @@ int lock_contention_stop(void)
 
 static const char *lock_contention_get_name(struct lock_contention *con,
 					    struct contention_key *key,
-					    u64 *stack_trace)
+					    u64 *stack_trace, u32 flags)
 {
 	int idx = 0;
 	u64 addr;
@@ -198,6 +198,10 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 	}
 
 	if (con->aggr_mode == LOCK_AGGR_ADDR) {
+		if (flags & LCD_F_MMAP_LOCK)
+			return "mmap_lock";
+		if (flags & LCD_F_SIGHAND_LOCK)
+			return "siglock";
 		sym = machine__find_kernel_symbol(machine, key->lock_addr, &kmap);
 		if (sym)
 			name = sym->name;
@@ -301,7 +305,7 @@ int lock_contention_read(struct lock_contention *con)
 			goto next;
 		}
 
-		name = lock_contention_get_name(con, &key, stack_trace);
+		name = lock_contention_get_name(con, &key, stack_trace, data.flags);
 		st = lock_stat_findnew(ls_key, name, data.flags);
 		if (st == NULL)
 			break;
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index f092a78ae2b5..4ba34caf84eb 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -236,6 +236,11 @@ static inline __u32 check_lock_type(__u64 lock, __u32 flags)
 				return LCD_F_MMAP_LOCK;
 		}
 		break;
+	case LCB_F_SPIN:  /* spinlock */
+		curr = bpf_get_current_task_btf();
+		if (&curr->sighand->siglock == (void *)lock)
+			return LCD_F_SIGHAND_LOCK;
+		break;
 	default:
 		break;
 	}
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index 789f20833798..5ed1a0955015 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -19,7 +19,8 @@ struct contention_task_data {
  * Upper bits of the flags in the contention_data are used to identify
  * some well-known locks which do not have symbols (non-global locks).
  */
-#define LCD_F_MMAP_LOCK  (1U << 31)
+#define LCD_F_MMAP_LOCK		(1U << 31)
+#define LCD_F_SIGHAND_LOCK	(1U << 30)
 
 struct contention_data {
 	u64 total_time;
-- 
2.40.0.rc1.284.g88254d51c5-goog

