Return-Path: <bpf+bounces-48667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1EAA0AEBC
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 06:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249B118858B2
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 05:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952BF230D3F;
	Mon, 13 Jan 2025 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gcb10A2b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1700230D1E
	for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 05:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736745837; cv=none; b=rwfVwwPoqJE/sZDdgnrGnoq7h9e3chNClXayUZj/2VsE9Ngaoxi5FwbBVsOdFniQPqT2RJrtcccsm1zzrEB5rWluk1J6NV/ac8VEoO1ZfD1/7VhULCtdU5EmC2+QAnQtZPa6itW3eDJ1FfN+bynLLzns0f8Lnz7VGpGUXfjOLQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736745837; c=relaxed/simple;
	bh=03zst4yp3vVxlteaRKGEcsn5oX+laHuxdfF/IJtBYcM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ph+21NnQO4WLesO7cIg3HqovoMsy647SLu60BYqkvlRo//lNIRBiKxW2nvZgkSgsQascxLQ+4vJcLBWfpkUv/YRaXh8BVR7H0zkNNch/RE4tujeckygvMyO6YZsrUIyqp0RQry1zTxlKRcXBMP4JaareD4VeviH49wzqenkJRUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gcb10A2b; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2163d9a730aso72954945ad.1
        for <bpf@vger.kernel.org>; Sun, 12 Jan 2025 21:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736745835; x=1737350635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RChDgtCHJsZ+9exXiY5ah/G2LrjJgqqretYf70z53cE=;
        b=gcb10A2bFkaWPWANnQV1ERcPu6/6JvLsNc/y3tPIFazNasM85X2qeXZfocvxMyVVBD
         qG58CTygZYfw8Cwyy2wh79pX7m0k+kXAGwFn3VrKoCptFC1iWfrw2fG6WLgablII09NH
         WeNAyfKk66aw429W3LVb1ubU1MMQgnHPTF3ulinpe86DokMVwjSXMbKP45WrGYy6wT7X
         Y38meIZ0bDMpo2zQKj1Eqe7rKBa0k4QX1byfB6QsKr7KFJf850lmUp/EfSrCxt3WPdYr
         4rVjNOWJo8kgxNBIHcNeK3n8MRKyMEp5A4pKfVfkm5tpTugKX4dMLP1qao5jmOE/JbBg
         1k6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736745835; x=1737350635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RChDgtCHJsZ+9exXiY5ah/G2LrjJgqqretYf70z53cE=;
        b=rEsX/i6MTPYmlOlakK19++19Iw2C3Oa4RJKLapFsnvNgmjKlUEftJ2Mz1ZMkkSFZu6
         RPlPckzF960y+rpQpMANdCo7BvAZv97dnHYB+mLmf0XNcb662XEcQB0+MaGqzZX7LlyS
         q+nXEhMMT4/fB/7NIqG/gpQjehkpJ5g1wHF8zwujpf/kLj/WqYtY3CsXJjgVCmwQycrv
         xTQiIWEXJoQ+ccKlor2mUSKJyUx5bS+hPBmnPYaUcZNdnMKqH52sSkz91djl/uo8Kbtc
         BOTeD9MsxUSc6L7XVUEohZuTYfTcIfzpYUpz4I4yZW8x5w6p7dXdoM6XIcjR0X8xBt95
         Ojig==
X-Forwarded-Encrypted: i=1; AJvYcCVFqqhCjN9/iEIYzPP+drv076loJ8bCMu1jEVsmS7OqDjPKEcfb1hQ1mf4ggZU4LChDZbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFG4Ce6Dionk7W2la7bS3eLQrf9u7hT78CsKvwZNLcBhEUQgYQ
	NwYpwAvyGz7la0c7Sh2m9ZfqPXgIl1FzvLYxQqBbgapwmdIIVV7IrEfJo+Xc2Lq5xJi1wjdIdi+
	B7g==
X-Google-Smtp-Source: AGHT+IHe87MO8RdBUIZgJ1nejREfqTCdjCsLkwV3QgX98VRh5u0vSOR1/pY2hZ34l1o3zuzz9VxVXKLGz5E=
X-Received: from pgsb3.prod.google.com ([2002:a65:67c3:0:b0:7fd:460b:daa3])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c6:b0:216:1a59:5bbf
 with SMTP id d9443c01a7336-21a8d52fbd2mr235352605ad.0.1736745835018; Sun, 12
 Jan 2025 21:23:55 -0800 (PST)
Date: Sun, 12 Jan 2025 21:20:17 -0800
In-Reply-To: <20250113052220.2105645-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250113052220.2105645-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250113052220.2105645-5-ctshao@google.com>
Subject: [PATCH v2 4/4] perf lock: Report owner stack in usermode
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Parse `owner_lock_stat` into a rb tree, and report owner lock stats with
stack trace in order.

Example output:
  $ sudo ~/linux/tools/perf/perf lock con -abvo -Y mutex-spin -E3 perf bench sched pipe
  ...
   contended   total wait     max wait     avg wait         type   caller

         171      1.55 ms     20.26 us      9.06 us        mutex   pipe_read+0x57
                          0xffffffffac6318e7  pipe_read+0x57
                          0xffffffffac623862  vfs_read+0x332
                          0xffffffffac62434b  ksys_read+0xbb
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
          36    193.71 us     15.27 us      5.38 us        mutex   pipe_write+0x50
                          0xffffffffac631ee0  pipe_write+0x50
                          0xffffffffac6241db  vfs_write+0x3bb
                          0xffffffffac6244ab  ksys_write+0xbb
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
           4     51.22 us     16.47 us     12.80 us        mutex   do_epoll_wait+0x24d
                          0xffffffffac691f0d  do_epoll_wait+0x24d
                          0xffffffffac69249b  do_epoll_pwait.part.0+0xb
                          0xffffffffac693ba5  __x64_sys_epoll_pwait+0x95
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76

  === owner stack trace ===

           3     31.24 us     15.27 us     10.41 us        mutex   pipe_read+0x348
                          0xffffffffac631bd8  pipe_read+0x348
                          0xffffffffac623862  vfs_read+0x332
                          0xffffffffac62434b  ksys_read+0xbb
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
  ...

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c             | 20 ++++++++++++-
 tools/perf/util/bpf_lock_contention.c | 41 +++++++++++++++++++++++++++
 tools/perf/util/lock-contention.h     |  2 ++
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index f9b7620444c0..0dfec175b25b 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -42,6 +42,7 @@
 #include <linux/zalloc.h>
 #include <linux/err.h>
 #include <linux/stringify.h>
+#include <linux/rbtree.h>
 
 static struct perf_session *session;
 static struct target target;
@@ -1926,6 +1927,23 @@ static void print_contention_result(struct lock_contention *con)
 			break;
 	}
 
+	if (con->owner && con->save_callstack) {
+		struct rb_root root = RB_ROOT;
+
+
+		if (symbol_conf.field_sep)
+			fprintf(lock_output, "# owner stack trace:\n");
+		else
+			fprintf(lock_output, "\n=== owner stack trace ===\n\n");
+		while ((st = pop_owner_stack_trace(con)))
+			insert_to(&root, st, compare);
+
+		while ((st = pop_from(&root))) {
+			print_lock_stat(con, st);
+			zfree(st);
+		}
+	}
+
 	if (print_nr_entries) {
 		/* update the total/bad stats */
 		while ((st = pop_from_result())) {
@@ -2071,7 +2089,7 @@ static int check_lock_contention_options(const struct option *options,
 		}
 	}
 
-	if (show_lock_owner)
+	if (show_lock_owner && !verbose)
 		show_thread_stats = true;
 
 	return 0;
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index c9c58f243ceb..a63d5ffac386 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -414,6 +414,47 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 	return name_buf;
 }
 
+struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
+{
+	int fd;
+	u64 *stack_trace;
+	struct contention_data data = {};
+	size_t stack_size = con->max_stack * sizeof(*stack_trace);
+	struct lock_stat *st;
+	char name[KSYM_NAME_LEN];
+
+	fd = bpf_map__fd(skel->maps.owner_lock_stat);
+
+	stack_trace = zalloc(stack_size);
+	if (stack_trace == NULL)
+		return NULL;
+
+	if (bpf_map_get_next_key(fd, NULL, stack_trace))
+		return NULL;
+
+	bpf_map_lookup_elem(fd, stack_trace, &data);
+	st = zalloc(sizeof(struct lock_stat));
+
+	strcpy(name, stack_trace[0] ? lock_contention_get_name(con, NULL,
+							       stack_trace, 0) :
+				      "unknown");
+
+	st->name = strdup(name);
+	st->flags = data.flags;
+	st->nr_contended = data.count;
+	st->wait_time_total = data.total_time;
+	st->wait_time_max = data.max_time;
+	st->wait_time_min = data.min_time;
+	st->callstack = memdup(stack_trace, stack_size);
+
+	if (data.count)
+		st->avg_wait_time = data.total_time / data.count;
+
+	bpf_map_delete_elem(fd, stack_trace);
+	free(stack_trace);
+
+	return st;
+}
 int lock_contention_read(struct lock_contention *con)
 {
 	int fd, stack, err = 0;
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 1a7248ff3889..83b400a36137 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -156,6 +156,8 @@ int lock_contention_stop(void);
 int lock_contention_read(struct lock_contention *con);
 int lock_contention_finish(struct lock_contention *con);
 
+struct lock_stat *pop_owner_stack_trace(struct lock_contention *con);
+
 #else  /* !HAVE_BPF_SKEL */
 
 static inline int lock_contention_prepare(struct lock_contention *con __maybe_unused)
-- 
2.47.1.688.g23fc6f90ad-goog


