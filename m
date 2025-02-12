Return-Path: <bpf+bounces-51318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4ADA332A6
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 23:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E75167627
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 22:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED05B2036F4;
	Wed, 12 Feb 2025 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/fjPlef"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038AA20408D
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399484; cv=none; b=mc808l1g22AnTTIGW3WohJ9baimTIbWbxTinlmlh7rlYgPv9/tiiRk7A/gRVNl6jsV4PMd/eF1JJJeYmnbjutKB2jtyT5g5GnlIjHk8gIfnYLj3x0uaqjjRdq5l6AOR57Xun4YwxnHRCst1P7GcMOjc7QVx8t4mOuZ/WTcR8NZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399484; c=relaxed/simple;
	bh=+oY4H/9/iKeBTJJnO2W7fp5SJV9ZRax204HZtg1Ok1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YxV4ZzwhDZmNZfzoiM1rfHwSpqFti7F4uYXgQMiZttJGFEA8nyMfCh51RUzaEUQzJrqgfTH4dwYZ9Hq2b+sZ9Q9TFeXYoqCKkJfrauT23KvlqJvpeCPdkFCH/RJS2QZ9JOl9Pziyh3YWq0oOfde/UfduoC7I8/J9PDyP70+UYDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/fjPlef; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f9da17946fso924325a91.3
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 14:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739399482; x=1740004282; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNqZSc1JLn0dwuRoJKceisL6qvWdg1Q9d+T90xi+KO0=;
        b=L/fjPlef3CulS5bESkypXCe1VAnl8MAYAYhJRkZghnARlIhDQgvyXliErIA8yh83CK
         hbA2BHomxq18undsEtWP6HMBB7q2m7OU9UKHe6nxXEkIju0ewfmZ+CMvp+NkTF+gIOye
         HAZRuj5+oycFZhsQTKMH8flpN3oeawg3NI69IXIXxmd9WLs84gtUNtOjilHAfEaStUMW
         43oKzBk4akeF5R1/WqCARM9kT4pFd5LKr4tbcfJ/8dyMfKCWEjDbwrbXVSCJ/t79vpDy
         u/XAi1APxjbDeITtioD830vNMJbygZSaXI6LSWOtfNdipT/tCoQXIoxsGycVFhzy033G
         Uxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399482; x=1740004282;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNqZSc1JLn0dwuRoJKceisL6qvWdg1Q9d+T90xi+KO0=;
        b=nEyHgrTvIrHoVYhYHqt+TtER6F1E7jhk+euk7XXvD6l9syHT8IPDH+7Nsk67g7+w6z
         UTgWSgE6mEgB9idHLpt2AXhYwlqKg7005qk7bN9ub4sdJqgtf307cBK5CO24jxLZpPyS
         3JLrGRykvdt1X+xxJYWZtjooIDnN53e26Q5vMfJ1/do03sTTwjLHWqo8vnqQ9lgRRBK6
         FPgJE3kauNzLAOP7dKOH8J5ul2KnpNdUvglZB0TCH0il7/SPqgwvGMJfg4d8DAyG5G15
         BYS2L+nJ8y8xnnJCWj8FsB6rWW7w9BFOlOHWylH1KF9FPuDDj36V3+NWV0sBpjUUMf2m
         z6Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUgqkRHqI3D2atttdYhG8xw90k3t6cBW6QEM+Nr+e1aD/TvkUeY1DEfBPbTBqO+UU8WDZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH6peDRLtVleiaPkF21b2ROrqUqNc1i1mPrBDzoSVAGEd/vYPc
	Q443/V1tUiXaL1vWQ7m1emiNgY4Tv5M+W4Y1JcVGDsR1b3+FOzKrsASHuesL3f/jXZqSAAXqhLt
	1fA==
X-Google-Smtp-Source: AGHT+IHpscGhRRSM86wF3Vg9mBVITGPBSWOzu8ifxEDnBRXopIq1MT6mUs+2OPyt7cpCD2ZCuLBegQyMQXs=
X-Received: from pjyf13.prod.google.com ([2002:a17:90a:ec8d:b0:2ef:78ff:bc3b])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f06:b0:2ee:53b3:3f1c
 with SMTP id 98e67ed59e1d1-2fbf5bc1a9dmr7256534a91.5.1739399482247; Wed, 12
 Feb 2025 14:31:22 -0800 (PST)
Date: Wed, 12 Feb 2025 14:24:55 -0800
In-Reply-To: <20250212222859.2086080-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212222859.2086080-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212222859.2086080-5-ctshao@google.com>
Subject: [PATCH v5 4/5] perf lock: Report owner stack in usermode
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
 tools/perf/builtin-lock.c             | 19 ++++++++--
 tools/perf/util/bpf_lock_contention.c | 54 +++++++++++++++++++++++++++
 tools/perf/util/lock-contention.h     |  7 ++++
 3 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 9bebc186286f..3dc100cf30ef 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1817,6 +1817,22 @@ static void print_contention_result(struct lock_contention *con)
 			break;
 	}
 
+	if (con->owner && con->save_callstack) {
+		struct rb_root root = RB_ROOT;
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
@@ -1962,9 +1978,6 @@ static int check_lock_contention_options(const struct option *options,
 		}
 	}
 
-	if (show_lock_owner)
-		show_thread_stats = true;
-
 	return 0;
 }
 
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 76542b86e83f..dc83b02c9724 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -549,6 +549,60 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 	return name_buf;
 }
 
+struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
+{
+	int stacks_fd, stat_fd;
+	u64 *stack_trace;
+	s32 stack_id;
+	struct contention_key ckey = {};
+	struct contention_data cdata = {};
+	size_t stack_size = con->max_stack * sizeof(*stack_trace);
+	struct lock_stat *st;
+	char name[KSYM_NAME_LEN];
+
+	stacks_fd = bpf_map__fd(skel->maps.owner_stacks);
+	stat_fd = bpf_map__fd(skel->maps.owner_stat);
+	if (!stacks_fd || !stat_fd)
+		return NULL;
+
+	stack_trace = zalloc(stack_size);
+	if (stack_trace == NULL)
+		return NULL;
+
+	if (bpf_map_get_next_key(stacks_fd, NULL, stack_trace))
+		return NULL;
+
+	bpf_map_lookup_elem(stacks_fd, stack_trace, &stack_id);
+	ckey.stack_id = stack_id;
+	bpf_map_lookup_elem(stat_fd, &ckey, &cdata);
+
+	st = zalloc(sizeof(struct lock_stat));
+	if (!st)
+		return NULL;
+
+	strcpy(name,
+	       stack_trace[0] ? lock_contention_get_name(con, NULL, stack_trace, 0) : "unknown");
+
+	st->name = strdup(name);
+	if (!st->name)
+		return NULL;
+
+	st->flags = cdata.flags;
+	st->nr_contended = cdata.count;
+	st->wait_time_total = cdata.total_time;
+	st->wait_time_max = cdata.max_time;
+	st->wait_time_min = cdata.min_time;
+	st->callstack = stack_trace;
+
+	if (cdata.count)
+		st->avg_wait_time = cdata.total_time / cdata.count;
+
+	bpf_map_delete_elem(stacks_fd, stack_trace);
+	bpf_map_delete_elem(stat_fd, &ckey);
+
+	return st;
+}
+
 int lock_contention_read(struct lock_contention *con)
 {
 	int fd, stack, err = 0;
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index a09f7fe877df..97fd33c57f17 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -168,6 +168,8 @@ int lock_contention_stop(void);
 int lock_contention_read(struct lock_contention *con);
 int lock_contention_finish(struct lock_contention *con);
 
+struct lock_stat *pop_owner_stack_trace(struct lock_contention *con);
+
 #else  /* !HAVE_BPF_SKEL */
 
 static inline int lock_contention_prepare(struct lock_contention *con __maybe_unused)
@@ -187,6 +189,11 @@ static inline int lock_contention_read(struct lock_contention *con __maybe_unuse
 	return 0;
 }
 
+struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
+{
+	return NULL;
+}
+
 #endif  /* HAVE_BPF_SKEL */
 
 #endif  /* PERF_LOCK_CONTENTION_H */
-- 
2.48.1.502.g6dc24dfdaf-goog


