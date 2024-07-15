Return-Path: <bpf+bounces-34809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E33931234
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A631F23833
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F4A187551;
	Mon, 15 Jul 2024 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHBMp4d+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051FF18755F;
	Mon, 15 Jul 2024 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039040; cv=none; b=Mn5gcos4juKxMdYsypFgpnJlrrUHf6SvCvBNJ2VzDwgHJ4bQfNNfWr7iS8x2IEhmOkoRH6jahf3QysXwA9n9Rxd66gsRL05NqMSi9lNbcmS42PfaL3NH1YElldHB1k+eZElO31FXyg9KA0tfgD1RhoGnFJJ/nMbq8hEDhZfdaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039040; c=relaxed/simple;
	bh=JpoFOV9IVxku3BZ+mB+xeBSued/Fed51Ga4SvNQzTgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pG8s38FZHJQo4xYmQ70wrfK0HO5uMFGlapXh+uR70MMeuVne15MCe0xWTUhrQqZCvbG0UXtguZwdZljBRVa4wI/vh4whs6XAdC35kPpBuiTesMCTHOnlqHf2hC6Xv1YX6p4PLUDdLAgLn/m/bzKh9PHalU9uGEo/YiTaSQf0y3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHBMp4d+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58bac81f419so4857364a12.0;
        Mon, 15 Jul 2024 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721039037; x=1721643837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B7u5+nXVgQnRj6vNkJ6h8YmeNOJV85sFm6LuPS8vl4Q=;
        b=KHBMp4d+mpWE1kB94NHGzE0sDVpJE4gVqLVVk94AINoEQyc64x8J+lIPVnI3RKviYi
         IdKS2FXArpsaXWretr2Tl+3uUqa0+XbxS/2PCGcEoeIEd1WNuE/UitK99/bIMx4UkaJK
         gdyy1yGRA+NJcXOXt6+u/f/UZt7XQVb7M6VrnW9bEYNCF2p+u8tzQ1k6vzicoh63+KMo
         Sw1h4PegFyTvuYPVvYReYxk9C0NPoXOlL/MW1PcdVg9CwsSawATAP+8dCF1R7jMrP+rT
         mwgGts4PzJLtY8/m2brG+L7YcsMdSM06Fs/eM68NywVkYy1xRLc/8uKIqXql5gJM4YLI
         //YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721039037; x=1721643837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7u5+nXVgQnRj6vNkJ6h8YmeNOJV85sFm6LuPS8vl4Q=;
        b=eBIiefKYZwn3KhvydMIKB3HLXAmjuzF8B40QUqgcYSVI5ciVImyvI/dDLgLUEcoZOg
         TSpgW5Mkfs2zggMy/5TPXwZY/niXW5Q2rcvjusCR4jhTopEjA3FLv2gpGrcPGAkMwUKQ
         n6dMRPiCrBk45ke5c0gFy+yR0oTunI2vjsPM8ee4X4JJjpxny2BMR1WT2qGAr12vHXXD
         dLOoEe+6Oro48XwRD/zeM26zdfPJzzz/iN3o9SM/kO1C4ODUG87IruV1J8SXoCe4OKN7
         V+jG0G2kFTNx+gBOL7LMu9cTQlKElPqZG4wn1n8xzSZjl6Hq93EZtJHf7gbJY3kXb8Hj
         rafQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLCTWi10pVNnjQ7gipODeyA7o97kL09uYA2OF3M1L3zM81qA9tQ5cFv9uE0wGb4qxVU9awMyXy53JRb0l1YzRWAk3Lyq1jeKJ5xmamSp+BWEaKQfxawZ/nM2KK0hp4nXwL2/xGUrEItkAaDaGKsxmlc/f9PqigmIdAtrlNwR2gIZhcxg==
X-Gm-Message-State: AOJu0YxnpwTwftut3CIArlH+UANTRFkpDGM00ofUFLMZ1AVMU+60+1Ea
	/T0LqI/D+BeJA3Lzm/PfwpT2ipC5toTkEERVWfd1rlFGNZrNe41FkeJnmA==
X-Google-Smtp-Source: AGHT+IHh+EMF9y7gXwySrlxbqxi6V92Ym3q9OkKNjxd1B8rBgnJiHG/M6k6M/4MxSvuIvKQxJN5Zmg==
X-Received: by 2002:a05:6402:3196:b0:58b:9561:650b with SMTP id 4fb4d7f45d1cf-594bb580796mr10811317a12.25.1721039036996;
        Mon, 15 Jul 2024 03:23:56 -0700 (PDT)
Received: from LPPLJK6X5M3.. (178-37-38-123.dynamic.inetia.pl. [178.37.38.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24a77114sm3257158a12.6.2024.07.15.03.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 03:23:56 -0700 (PDT)
From: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>,
	syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
Subject: [PATCH] perf callchain: Fix suspicious RCU usage in get_callchain_entry()
Date: Mon, 15 Jul 2024 12:23:27 +0200
Message-ID: <20240715102326.1910790-2-radoslaw.zielonek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_dereference() is using rcu_read_lock_held() as a checker, but
BPF in bpf_prog_test_run_syscall() is using rcu_read_lock_trace() locker.
To fix this issue the proper checker has been used
(rcu_read_lock_trace_held() || rcu_read_lock_held())

syzbot reported:

=============================
WARNING: suspicious RCU usage
6.9.0-rc5-syzkaller-00159-gc942a0cd3603 #0 Not tainted
-----------------------------
kernel/events/callchain.c:161 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor305/5180:

stack backtrace:
CPU: 3 PID: 5180 Comm: syz-executor305 Not tainted 6.9.0-rc5-syzkaller-00159-gc942a0cd3603 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:114
lockdep_rcu_suspicious+0x20b/0x3b0 kernel/locking/lockdep.c:6712
get_callchain_entry+0x274/0x3f0 kernel/events/callchain.c:161
get_perf_callchain+0xdc/0x5a0 kernel/events/callchain.c:187
__bpf_get_stack+0x4d9/0x700 kernel/bpf/stackmap.c:435
____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1985 [inline]
bpf_get_stack_raw_tp+0x124/0x160 kernel/trace/bpf_trace.c:1975
___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
__bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
__bpf_prog_run include/linux/filter.h:657 [inline]
bpf_prog_run include/linux/filter.h:664 [inline]
bpf_prog_run_pin_on_cpu include/linux/filter.h:681 [inline]
bpf_prog_test_run_syscall+0x3ae/0x770 net/bpf/test_run.c:1509
bpf_prog_test_run kernel/bpf/syscall.c:4269 [inline]
__sys_bpf+0xd56/0x4b40 kernel/bpf/syscall.c:5678
__do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
__se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
__x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f54610dc669
</TASK>

Reported-by: syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=72a43cdb78469f7fbad1

Signed-off-by: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
---
 kernel/events/callchain.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1273be84392c..a8af7cd50626 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -11,6 +11,7 @@
 #include <linux/perf_event.h>
 #include <linux/slab.h>
 #include <linux/sched/task_stack.h>
+#include <linux/rcupdate_trace.h>
 
 #include "internal.h"
 
@@ -32,7 +33,7 @@ static inline size_t perf_callchain_entry__sizeof(void)
 static DEFINE_PER_CPU(int, callchain_recursion[PERF_NR_CONTEXTS]);
 static atomic_t nr_callchain_events;
 static DEFINE_MUTEX(callchain_mutex);
-static struct callchain_cpus_entries *callchain_cpus_entries;
+static struct callchain_cpus_entries __rcu *callchain_cpus_entries;
 
 
 __weak void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
@@ -158,7 +159,13 @@ struct perf_callchain_entry *get_callchain_entry(int *rctx)
 	if (*rctx == -1)
 		return NULL;
 
-	entries = rcu_dereference(callchain_cpus_entries);
+	/*
+	 * BPF locked rcu using rcu_read_lock_trace() in
+	 * bpf_prog_test_run_syscall()
+	 */
+	entries = rcu_dereference_check(callchain_cpus_entries,
+					rcu_read_lock_trace_held() ||
+					rcu_read_lock_held());
 	if (!entries) {
 		put_recursion_context(this_cpu_ptr(callchain_recursion), *rctx);
 		return NULL;
-- 
2.43.0


