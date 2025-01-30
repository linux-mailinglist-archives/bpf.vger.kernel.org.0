Return-Path: <bpf+bounces-50106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E1DA2288D
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 06:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38AC188620D
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 05:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D77217BB21;
	Thu, 30 Jan 2025 05:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjgnTggM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB981494D8
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 05:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738214912; cv=none; b=WXK+4ysaaNuLmVTQz96qVjh06q7nh/OUae+hRRF2IywANJ91Fh7iQrvdarx/z5Cdh2rTdwJ0Z1YjM3B1giVlMr8m4BKtYwalHbVfJIIgWlm3S18kUsEgn+hbYxgX+3SX7T7ktl3Rc3+igBg1UOba1cMRJ79WKXgbTYZhn+WuV78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738214912; c=relaxed/simple;
	bh=NH6skItZvtRN3wH8ru69yeLyhrXA6+M2n5XBGwhpNnQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YZwt4MtAe04KSgpdy07c9hk2IJN4SblXI0yDdPdkYxqa44qs+rMm+Wl/OgKC3XVrklENkxuk/tMVPq3wcX50mO8RV1Vq10aZjyAI+mLgZGH37FWo9AqdWeRwBLXezSLizyMZLVaUpuQQom7mcpedMFafkA6leRKU/lNBuRTjj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RjgnTggM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so867802a91.2
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 21:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738214910; x=1738819710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AOkrsQudmNHuJicI5VzkKDKtJxBuPweX3eG0BmVtZ1U=;
        b=RjgnTggMhxNQ4xxaC08f3LsOl554mRvuob/pjsExI2v+vQKF4JvKQIMZEtpspiQ7Jk
         dHh/cJkYNiVPnDlMTG8FQDt6/e3aYchaGIU4K86mQNi14jjpOJJU0+1dhQwESs+r/Ni/
         Qq2PShpk64DVQ5T/jvhtMw53n1Xf0BMNLIE3tyZUnH0L9zC6MuWEmx+xI/02LdlzOoti
         zG55Y44m8Gq1KsCMVx1LRZTAN8braPVb7rjXZ7Mo0Urk3P38wzmLfm95975Mz0K9KdNZ
         wxDA0rtKwpXJn03+HUuVTdgSo8uaU6CTqJ0cDEIXzjPpbCIhOhGFmhryIGqzRcJHirgl
         DA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738214910; x=1738819710;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOkrsQudmNHuJicI5VzkKDKtJxBuPweX3eG0BmVtZ1U=;
        b=Se9U4Co8vywAYLgJ4wsd78vRnojbg7ZmMqUoUL2I/aAMNsRFxny4rWg7rFr71kSPK5
         3/NHj2/tOkt6zpRhbOzl/VyTfnqX5b7c9QnwUGwcgZtQWtl2hE0ySk2hi+OqtEYrcpgF
         5eB6f4RUxfK8dVnvv4d5uOoejjkKcrsJBvjzCwP6DMwdg+IottXZjBN/K6y5jH8IwLy6
         oJqvXWueM7G/YKT6XX9t/s/YS0bgHQscs6gESZ5Jq1Xrtq9GaEOL11F1bEVCZZPQZjTi
         EZ6DujHxarF1IHvBQKg5G5cjx+IdZaqSiuNDBX3PkfVOxG5373qNE1hoIGilehAK3geP
         /xXg==
X-Forwarded-Encrypted: i=1; AJvYcCVEaVB9XsyVG+GX9bxXkHgf4S/rCxqbPBKsTsbRuCFRX0nkn+GwkDfSTwjMvy9b92H5BYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwtGkLFvM/i0e94XeLsvfkTIrtE2MLMRlZbynZOdnVkPEM8v68
	y4mDE4iJL466JrasMpjt/CiZ2aLLZiSfJlBbzaWvALIPw7qt+VjLRWEXVJH3dkyihFzVwb0eAjG
	rMA==
X-Google-Smtp-Source: AGHT+IGjL+7WMzTrhfufcEmRgWouNlOrrvV6Wm7UCA6RKy8zDkkuZV2wYzUIhagUPOo40tkAdIlTVHToXPI=
X-Received: from pjbtb14.prod.google.com ([2002:a17:90b:53ce:b0:2e0:aba3:662a])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc47:b0:2ee:863e:9ff6
 with SMTP id 98e67ed59e1d1-2f83ac0920bmr9546052a91.16.1738214910213; Wed, 29
 Jan 2025 21:28:30 -0800 (PST)
Date: Wed, 29 Jan 2025 21:21:38 -0800
In-Reply-To: <20250130052510.860318-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250130052510.860318-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250130052510.860318-5-ctshao@google.com>
Subject: [PATCH v4 4/5] perf lock: Report owner stack in usermode
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
2.48.1.362.g079036d154-goog


