Return-Path: <bpf+bounces-52414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C270FA42C05
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 19:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43A33A8F54
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85A7266B43;
	Mon, 24 Feb 2025 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QqF81R99"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF426139E
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423110; cv=none; b=sVWeUCZrV6s98ZKrywHZVV57SiOUO0NwwpvSg3r7cPKwLdCl4E2lH34yNQV043E19YFB7ZZ2+Xl0DeaLVaEyWxgylrbr1aJuFmu45n8SlcmgvNpXyG5H8wxRuZS+oEIqesKjAhrGUVrCqJcllyMNdrtEKBrpoccnjGff8ATXoWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423110; c=relaxed/simple;
	bh=TEMGIR10WYHrpkHHdWlP0Obhht+RBjq4ihNlCJ0KvdE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i6t1PRdkB7lpMEvcaVlJguhfaoOEWjOPFlwOXAL2DWLUAIQ3y8dhS6oli2gMWglambm2AGraUoEW5CX1xJNrCXogDo5wTqYMtB+uNV0OKF1+KCvRtQ+9r37smaNhVct5NiYmvccCgTNY0Iry8T+q83lXmg20D1DuxPfV/+h+Mj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QqF81R99; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220d1c24b25so91484785ad.0
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 10:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740423108; x=1741027908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qPrj4Gf1FvfcCgUu+hXAsKriyUrmM5yjH6bbIIdueC8=;
        b=QqF81R99yb5GYdf+dfzGgXhGd/87ifx22IqTPxoLvCmpKDz+JHfDqoW+a3kEhoKZYL
         9/bhrbT2gVvNoL4+Y1LsIEDjbI7ZWhrMFSYpw+s4sRapri1L4Hb2CScYSzITe6GmiJB3
         tTHlqgN/92hNXDo66AdRr3qymAjPDWzYDFSqAxLrmALuwD18yZ5P0xCVHen1SPn4imhJ
         kZpBUWWWWvDsrMA05xqM2o0+3WoT3zJT3Z6MDbjKfb94GJkjVLzK9+VOmKAc/UY3vezc
         PhB3tmbd8zdc06q8HPticyFYupLb58kMu3wsxAT1CKrp2DOLfeNQfyMZGBnIjlHvnxq/
         dYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740423108; x=1741027908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPrj4Gf1FvfcCgUu+hXAsKriyUrmM5yjH6bbIIdueC8=;
        b=AKvYhPvD6GjOkUo8rfyCL9IXFAo8WDEr0o+UXlizU+lBCiVsVqx9QC4/l2J9+I3yAC
         cvqgihWPo3Fky7YCcd6BS42v7uri+eQf14hnNqYs+aG+NvieLlHeFiSeDvVoigarLi5q
         /i/A0H56aLRLQUI33T3gQXQlEw0WccMUQp0oQnRzfrCNGBo9H/TeXQq7g1c21AwL5/L5
         0RERjQ/T5rmQyhe8SqwtJw8+KM5IjpfPzdIaoy5MPaDMqeWQDvgvSqelSpgyse89sQdY
         afSXfHFvrjdcgj0QMTPcjwvFtx2fArhgiaz5PiHIZjid71Z8DS07O4RfyIMyDpWz4M8B
         ZCMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzAaRtIjb7iNIBcjPjqFsK5mYfh0GA6ypi7zi9m8u+aFEO0AiTOaHTAH2G5h/qDIN8J/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqz4ei4xksPFaRjBA6nfL9jTKlvAEPEvsvbFr/O1LmeF6Gji/8
	aHhrehNr452jQvZejmQPsnXDbyyc7gPu8LpV6Dyjtg53JXgYRKeVShZ2afDBCAzVZc/J7KeJ82s
	otQ==
X-Google-Smtp-Source: AGHT+IEWIfVKVjzx5FeuvwVoXI6nrOx+HwUn9LBeZdP29jlOE6Qy5XtsULV48UA+xF/qJf1msm5mIFwAcYc=
X-Received: from pfgu32.prod.google.com ([2002:a05:6a00:9a0:b0:730:50c0:136d])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a8f:b0:730:794e:7aca
 with SMTP id d2e1a72fcca58-7347918d073mr467287b3a.16.1740423108186; Mon, 24
 Feb 2025 10:51:48 -0800 (PST)
Date: Mon, 24 Feb 2025 10:42:51 -0800
In-Reply-To: <20250224184742.4144931-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224184742.4144931-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250224184742.4144931-5-ctshao@google.com>
Subject: [PATCH v7 4/4] perf lock: Report owner stack in usermode
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch parses `owner_lock_stat` into a RB tree, enabling ordered
reporting of owner lock statistics with stack traces. It also updates
the documentation for the `-o` option in contention mode, decouples `-o`
from `-t`, and issues a warning to inform users about the new behavior
of `-ov`.

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
 tools/perf/Documentation/perf-lock.txt |  5 ++-
 tools/perf/builtin-lock.c              | 22 +++++++++-
 tools/perf/util/bpf_lock_contention.c  | 57 ++++++++++++++++++++++++++
 tools/perf/util/lock-contention.h      |  7 ++++
 4 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index d3793054f7d3..859dc11a7372 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -179,8 +179,9 @@ CONTENTION OPTIONS
 
 -o::
 --lock-owner::
-	Show lock contention stat by owners.  Implies --threads and
-	requires --use-bpf.
+	Show lock contention stat by owners. This option can be combined with -t,
+	which shows owner's per thread lock stats, or -v, which shows owner's
+	stacktrace. Requires --use-bpf.
 
 -Y::
 --type-filter=<value>::
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 9bebc186286f..05e7bc30488a 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1817,6 +1817,22 @@ static void print_contention_result(struct lock_contention *con)
 			break;
 	}
 
+	if (con->owner && con->save_callstack && verbose > 0) {
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
+			free(st);
+		}
+	}
+
 	if (print_nr_entries) {
 		/* update the total/bad stats */
 		while ((st = pop_from_result())) {
@@ -1962,8 +1978,10 @@ static int check_lock_contention_options(const struct option *options,
 		}
 	}
 
-	if (show_lock_owner)
-		show_thread_stats = true;
+	if (show_lock_owner && !show_thread_stats) {
+		pr_warning("Now -o try to show owner's callstack instead of pid and comm.\n");
+		pr_warning("Please use -t option too to keep the old behavior.\n");
+	}
 
 	return 0;
 }
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 76542b86e83f..16f4deba69ec 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -549,6 +549,63 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 	return name_buf;
 }
 
+struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
+{
+	int stacks_fd, stat_fd;
+	u64 *stack_trace = NULL;
+	s32 stack_id;
+	struct contention_key ckey = {};
+	struct contention_data cdata = {};
+	size_t stack_size = con->max_stack * sizeof(*stack_trace);
+	struct lock_stat *st = NULL;
+
+	stacks_fd = bpf_map__fd(skel->maps.owner_stacks);
+	stat_fd = bpf_map__fd(skel->maps.owner_stat);
+	if (!stacks_fd || !stat_fd)
+		goto out_err;
+
+	stack_trace = zalloc(stack_size);
+	if (stack_trace == NULL)
+		goto out_err;
+
+	if (bpf_map_get_next_key(stacks_fd, NULL, stack_trace))
+		goto out_err;
+
+	bpf_map_lookup_elem(stacks_fd, stack_trace, &stack_id);
+	ckey.stack_id = stack_id;
+	bpf_map_lookup_elem(stat_fd, &ckey, &cdata);
+
+	st = zalloc(sizeof(struct lock_stat));
+	if (!st)
+		goto out_err;
+
+	st->name = strdup(stack_trace[0] ? lock_contention_get_name(con, NULL, stack_trace, 0) :
+					   "unknown");
+	if (!st->name)
+		goto out_err;
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
+
+out_err:
+	free(stack_trace);
+	free(st);
+
+	return NULL;
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
2.48.1.658.g4767266eb4-goog


