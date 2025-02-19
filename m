Return-Path: <bpf+bounces-51997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE34A3CBC2
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 22:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E04417B0F4
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 21:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91537257ACE;
	Wed, 19 Feb 2025 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1eWa90s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD11A841F
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001620; cv=none; b=kQdp2LK9cyn/MEhzPaIOokOtwAboIMMEzB5DW+VquXwZ38lJYF8BWcRGitMzrprtFcO8Y6NR9V2qlbxfEooh16B6ExjcXQP8RwXW5R/2deL4UwirHK2r5J8wo/lJ4B1EkYJIZVRhz+mssm4wPEKEJoCPJkqjl9/1jF55YeUS+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001620; c=relaxed/simple;
	bh=spD2IPWHJbNfrqj6V6dM25YSx0bpjkKaL8KOXqwmYUg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TctdveGO+0R3MaiL1FaNC24Co9kU6KSTWp9vDiQxGVUQVhTttOMysdRLwEfFWIj8vh2+IPodaNl0uEMkSFfRb8gqHScm4JD43ULxFrDCUXTqVuetkZBNZ/MoT7mcizhKh0wKT9N+yZ6shPxotUonLLpxaJhgAiXeHzpcnHO6qfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c1eWa90s; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fbfa786aa4so626024a91.0
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 13:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740001618; x=1740606418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OkPOCIzCxbN6rf/sOEoHDE1WwJEvz8ihPapEp19yOIo=;
        b=c1eWa90s9ERsbaiZYM38IPbBNQIPqdj3ImaIOqntQI5ADcOBq7CUDSRbhKZ60PdtAJ
         aB+mhMNTwlieI7YaAPGrRhM1NSaSoiD4yRnNwDK6UBs2oSP0jO9YBSEiF4hz2Z/9CkdB
         BvpQPwGDE/HUWo8jYvHhtNHJntOP+hMfq8jA8B2eKwh17yr9nw1z1I16z6gTNqPwECUU
         D5LIxsvFlu/4aFp16SeGqJjxzW5eL8l0P5A52cB4DffTN0JVRcb1ZvHdEP/759VEimxO
         cbpNSBhQck6wF93zk1IXiXlyaxmipxDtnXDGMNTyWtenMGCWQcDSGBNyP84JB3Y2wHmp
         qYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740001618; x=1740606418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OkPOCIzCxbN6rf/sOEoHDE1WwJEvz8ihPapEp19yOIo=;
        b=Yl8YlK9dy+bTaTPcXvlG8rAnEOBdP2oG/X0MypwPEEQwI0iYyaxvoF9KyksiI4Pbsq
         Gh6iBYz551K9TBuZq5F7pHffAlsr0VS7dlPsOzAk/9+Tvyx6M7bEB7fvt3Z5nvEJu620
         dbR75KZHg06F7n9zxWid3YaRtRvNKZF+nyZNb8QOCD9eCXVo9egtZHcijjCduLQUNc97
         llRufXHUR9IPiJqg4VaRogiN5q+YzzZnRGLJlm1lruj8NGoFWg+8FJ/XMLsRWEaFGq7B
         4V8HE1bGoCaLX+elzXs22kJ/r2C0Krq13wt0tKcetTYrlJntlLMwfylv+fEyvcPpBHme
         jMXA==
X-Forwarded-Encrypted: i=1; AJvYcCXSlSRKqr7FVMEkN3QGYY3tRfykoKrOW9TIQBu/u5pV/hwRrd7vPZ2DrnP2X7iDDbLx/fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5YL5ix/V5l8nbErFyvhSIsHXy/5b2eIhrBWjd3zE624HNW+5
	CIuGvzPTOqkozdXmhKwnTpyRXzV5h3HXiM78KpQrHBdPQpNqb02i83fjMQBIejhjdtxcHyZQG+a
	niQ==
X-Google-Smtp-Source: AGHT+IFGsQ/ogkH6Qc8tr0rSOEGSPQyrMKMzjcxJTwdValwJTShzBiJFZhHTH8RKTn3adEgMSV+4z8lxcII=
X-Received: from pjtd4.prod.google.com ([2002:a17:90b:44:b0:2fb:fa62:d40])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d498:b0:2fa:9c9:20a3
 with SMTP id 98e67ed59e1d1-2fccbfd9f9amr1540053a91.0.1740001617948; Wed, 19
 Feb 2025 13:46:57 -0800 (PST)
Date: Wed, 19 Feb 2025 13:40:03 -0800
In-Reply-To: <20250219214400.3317548-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219214400.3317548-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219214400.3317548-5-ctshao@google.com>
Subject: [PATCH v6 4/4] perf lock: Report owner stack in usermode
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
 tools/perf/Documentation/perf-lock.txt |  6 +--
 tools/perf/builtin-lock.c              | 22 +++++++++-
 tools/perf/util/bpf_lock_contention.c  | 58 ++++++++++++++++++++++++++
 tools/perf/util/lock-contention.h      |  7 ++++
 4 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index d3793054f7d3..255e4f3e9d2b 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -140,7 +140,6 @@ CONTENTION OPTIONS
 --use-bpf::
 	Use BPF program to collect lock contention stats instead of
 	using the input data.
-
 -a::
 --all-cpus::
         System-wide collection from all CPUs.
@@ -179,8 +178,9 @@ CONTENTION OPTIONS
 
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
index 9bebc186286f..34cffa3c7cad 100644
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
+			zfree(st);
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
index 76542b86e83f..226ec7a06ab1 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -549,6 +549,64 @@ static const char *lock_contention_get_name(struct lock_contention *con,
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
+	if (stack_trace)
+		free(stack_trace);
+	if (st)
+		free(st);
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
2.48.1.601.g30ceb7b040-goog


