Return-Path: <bpf+bounces-50004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E633BA215A0
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 01:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7D21888647
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 00:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A67316F0E8;
	Wed, 29 Jan 2025 00:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lUKCHnN/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE0155C8C
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738110427; cv=none; b=PEmkqEi9cRifFRio3sInTgdRGpyamFz+XpjZoI0oS+tPwW+OjhQMaKv43NXZrOQaQWoRw5A7ES5x1RS0fDUrWVG0Hpv/58O8m3gI71D9fdBX5XxR+i+Cvx+NV7JjXkm+0sH4xwGNDC9exwLiPp0wNr/KEZEjr1NMMzklykvUDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738110427; c=relaxed/simple;
	bh=8Sgp5yu8OBVqSwtXE0quymzsxKTHzx8BbCOes46TEKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hCTh2sc7O96qvWi7g3oXsl1v721mx3t3P1vKiYGMfl0gkoWZGZnae8SCGwpqgODVdm776rPqpQprCAkWJoYHrJdUDsB/rAXC8NLeNXb7BZbX7IoYseahWUumKHR0nQVczz5XrJG0Eyvsbes3AdPKOX3/+JisC7/5I4HN82nKzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lUKCHnN/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-218cf85639eso186538645ad.3
        for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 16:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738110425; x=1738715225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sBEvePub/SR9/IDN5Bs+wN21Z641MzpSYW1O9rZmtN0=;
        b=lUKCHnN/EKzsGdHBnOen1OcljRUlEcBpZBTRlzMHmGg8qeMQSZldnVyyqYcZ/j0/K1
         nWDB1mtJU6abQLgmB36NgX0XeMAewS+xsbtc6BEcoPjZlBIvgtp+jMTPRLijA2ndkcLz
         R9cJMfeNRjPTVNOnWPYY+c3LKKNYDjZb0V2Iy1M8cOqDzrOnyE+FQPO540NY33OCH06w
         Bw4KuHiSRsMuSCJkpfMy/Laj0tVOQ+d69uiqQ7XbluPUsM4UGgKNOP7Vzub+RAsErZsh
         B4V+1ectM2mfy4aCZhA9GB+yOjLhKCc83PjkERmNbDj55JRimUVwAujJinluEawGtPRS
         TrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738110425; x=1738715225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBEvePub/SR9/IDN5Bs+wN21Z641MzpSYW1O9rZmtN0=;
        b=J0+7IA1KwJCBvkQMgLJbr1g4VQ+nMu15WYcje7IIMNSKL0PzhaeVZzaeataqhg19/2
         AAColtNW6hfwMcpztjBmg2GK70Ghz/7IEcKQOmHuX1f/V5ceZCkFdHMbNjHf9M1mnBLf
         q+wQI+klhvh4etZAd2Z/xT1e55B9OgBOR/T371NBNzsuBe1JXm+cau4FQ2UbTYIaiaoS
         eSsa2fipiEf9q1S7lkfsVQoRyHyL9z7gXtXPCj02u/hFnz0zScCfExAKpnSkZFyLX4Hl
         6qhrvMcu33YXjMGYlxtOtfJSJy4WPJPpdvahRmx9rzK3P1kpiTPs8vI9ccKCAuNFTrwr
         n/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2QlAkJqS6w/vYkGh95IaCl/cgco8uQeHQvX+B8MHZVtUsBDsn5uU4STN57cpB5LLVVeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTNHu50zTtgQ3MXlqSbdWlZYdXcmnaCyUbT0ISSgD05M0iiJZ
	RzIkdPoI9Dx/TWS29QxWqXZlfmyjfJ+/TmwUBEpvcfc8jN38nXzALvj+I2HBC59PCLdabhaDdBm
	L+Q==
X-Google-Smtp-Source: AGHT+IGLXoWuDc+BL3s0utjGdQvHw6YCJ9vbchFUR1aiImf8YniBCyB4qvpzZenwbn+L4cac0UqIBCcC0M0=
X-Received: from pjc3.prod.google.com ([2002:a17:90b:2f43:b0:2ef:7352:9e97])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2446:b0:215:603e:2141
 with SMTP id d9443c01a7336-21dd7c625cemr15041855ad.19.1738110424789; Tue, 28
 Jan 2025 16:27:04 -0800 (PST)
Date: Tue, 28 Jan 2025 16:15:00 -0800
In-Reply-To: <20250129001905.619859-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250129001905.619859-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250129001905.619859-5-ctshao@google.com>
Subject: [PATCH v3 4/5] perf lock: Report owner stack in usermode
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
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
 tools/perf/builtin-lock.c             | 20 ++++++++--
 tools/perf/util/bpf_lock_contention.c | 54 +++++++++++++++++++++++++++
 tools/perf/util/lock-contention.h     |  7 ++++
 3 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 9bebc186286f..d9b0d7472aea 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -42,6 +42,7 @@
 #include <linux/zalloc.h>
 #include <linux/err.h>
 #include <linux/stringify.h>
+#include <linux/rbtree.h>
 
 static struct perf_session *session;
 static struct target target;
@@ -1817,6 +1818,22 @@ static void print_contention_result(struct lock_contention *con)
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
@@ -1962,9 +1979,6 @@ static int check_lock_contention_options(const struct option *options,
 		}
 	}
 
-	if (show_lock_owner)
-		show_thread_stats = true;
-
 	return 0;
 }
 
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 795e2374facc..cf3267e46589 100644
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
2.48.1.262.g85cc9f2d1e-goog


