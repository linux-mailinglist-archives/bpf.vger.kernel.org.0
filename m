Return-Path: <bpf+bounces-27397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A90F8ACA82
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283351C20E44
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 10:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B856513FD74;
	Mon, 22 Apr 2024 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtOTQ4X1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D47C502B4;
	Mon, 22 Apr 2024 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781393; cv=none; b=ALMW5MdE6V19A6BXC0gQ+ndVh26Gq3z8H/Exme6q5UhkiEUL5npz/AbtAUNGilJmPQb/Z4wd3M+/iJAbVU/RhyRxyVdJlsNTzIdnr6F9cRGi8Lj9qeNwPx/Hnvx4TcdnkJC4fzRSJaXgENFonCee5PQ5teOAszpysBeBXP0M5+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781393; c=relaxed/simple;
	bh=QACik+ECjepFvlXsO5FWqcRtqhT4t/QMq9LNj2MY5lU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QvPCkv0BncL10Z5JIlFyiz9GrgFGJHohtxJOzfneGP4ePmuMKsKqpmHjDVJs6LUt9hsIRh34ZP7x8eOeaz60DDakDis3EG69OP6ED9FF0kWKz6KJprjRMgkq9S8RKtrpJ4lSTjFbteQ2f6Sg+BVUbqhMWXJGBbUdAr0s65WDb1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtOTQ4X1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so8406672a12.0;
        Mon, 22 Apr 2024 03:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713781389; x=1714386189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+TuEnSNBvG4LALxdWczKP5/WDkU6BbBaAYrjVgiYqpE=;
        b=JtOTQ4X1xBnCU7oL4BvI80XZa0dXGgVzEeP80BDCejlmCVpg6SdOB7+oowgA9TswOU
         2T9dOLQhu9sw0E63kUvn2i3T22v/uN2nFtvaSIVwEsipY2gzuyzCYOiVey8el8QKBhBd
         b1NDut8bQtL/36LqogrOzfD6okZjIZOO45//gnvWOj4VHht2+pVkHEZ8o0c76kNpNSx1
         GCEavhBdUfxlMbI0PPjGEh2PqPdGRnWuXGcpylwe0/HYgU4j7mhZf3WDROAB+5ItisRN
         OtmBkrty93LVbXs/UmyKdafZ7p3QclzpGWgaUnJcE6LWAjVCWhhbJxxP/sQByxOzch0G
         gjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713781389; x=1714386189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TuEnSNBvG4LALxdWczKP5/WDkU6BbBaAYrjVgiYqpE=;
        b=l8JwsmBMvGGZQVxQLFKEqg/xyc9CAIwE/onOALJGk03Se414bpoCh4R8/xovsjhZHJ
         8+kEmNT2ehiqnQIeEcXTSl7xDYibH3rRubgrKqLs4JgR8eS/CQpLxpE8XhwzxCczGM9K
         /Hdpfq6YU0n5Fwo8KIAOzrvbxqnwsXzCKJXz5TcdmDLFzJgyx25nPXTfCOfVrflzUgb5
         16ZmwAIhI02LCssk9s9DjUbxOxRnYDWrgfZ1LWUgUYVW/y7BjBeAxwwEIpqWil+0+qaN
         iGpePsR8J/PJkPDVkCPTSHIQg4WBahK6IlvwIFzBkCj5Z3m4sLwkJvJqT0MBRHyFJLgT
         N3/g==
X-Forwarded-Encrypted: i=1; AJvYcCWVqhXzhxz1SjG1oecXO7JNJ39NtrkveodYNT2j82wApaziWGdHAFmptzMT262slSVB0xkXsCnYA6e7eEb4Xqp4oq4/fWIOyujnhDkYInqjKtCRRTjT9y2UEWZlzhXIPi+VSDZVogNtb0KfSTCe0nc9Q22ZNVr5TdObTpCj48/+Tm7k4w==
X-Gm-Message-State: AOJu0YzycUoD1YZtZiHkHFfcRgiVvBXTjh6tW7/uw4JHKFghLe+BiuSP
	Xro8WbX9bUy2rCYMLdvnZmOHXcq1elEvME0EQYYKdgfo4YWjX3mZzN9EUC/z
X-Google-Smtp-Source: AGHT+IF7rbqhx80I4EcakWBm7ROU4Kg4/+HimK9++ICv5C+Ejf5itzhFGpIaBsywmcfeJlXae9yA8g==
X-Received: by 2002:a17:907:7d9f:b0:a55:b2c1:7eba with SMTP id oz31-20020a1709077d9f00b00a55b2c17ebamr3054896ejc.18.1713781389250;
        Mon, 22 Apr 2024 03:23:09 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id v16-20020a170906b01000b00a522c69f28asm5575548ejy.216.2024.04.22.03.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:23:08 -0700 (PDT)
From: Jonathan Haslam <jonathan.haslam@gmail.com>
To: linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org
Cc: jonathan.haslam@gmail.com,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	rostedt@goodmis.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] uprobes: reduce contention on uprobes_tree access
Date: Mon, 22 Apr 2024 03:23:05 -0700
Message-ID: <20240422102306.6026-1-jonathan.haslam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Active uprobes are stored in an RB tree and accesses to this tree are
dominated by read operations. Currently these accesses are serialized by
a spinlock but this leads to enormous contention when large numbers of
threads are executing active probes.

This patch converts the spinlock used to serialize access to the
uprobes_tree RB tree into a reader-writer spinlock. This lock type
aligns naturally with the overwhelmingly read-only nature of the tree
usage here. Although the addition of reader-writer spinlocks are
discouraged [0], this fix is proposed as an interim solution while an
RCU based approach is implemented (that work is in a nascent form). This
fix also has the benefit of being trivial, self contained and therefore
simple to backport.

We have used a uprobe benchmark from the BPF selftests [1] to estimate
the improvements. Each block of results below show 1 line per execution
of the benchmark ("the "Summary" line) and each line is a run with one
more thread added - a thread is a "producer". The lines are edited to
remove extraneous output.

The tests were executed with this driver script:

for num_threads in {1..20}
do
  sudo ./bench -a -p $num_threads trig-uprobe-nop | grep Summary
done

SPINLOCK (BEFORE)
==================
Summary: hits    1.396 ± 0.007M/s (  1.396M/prod)
Summary: hits    1.656 ± 0.016M/s (  0.828M/prod)
Summary: hits    2.246 ± 0.008M/s (  0.749M/prod)
Summary: hits    2.114 ± 0.010M/s (  0.529M/prod)
Summary: hits    2.013 ± 0.009M/s (  0.403M/prod)
Summary: hits    1.753 ± 0.008M/s (  0.292M/prod)
Summary: hits    1.847 ± 0.001M/s (  0.264M/prod)
Summary: hits    1.889 ± 0.001M/s (  0.236M/prod)
Summary: hits    1.833 ± 0.006M/s (  0.204M/prod)
Summary: hits    1.900 ± 0.003M/s (  0.190M/prod)
Summary: hits    1.918 ± 0.006M/s (  0.174M/prod)
Summary: hits    1.925 ± 0.002M/s (  0.160M/prod)
Summary: hits    1.837 ± 0.001M/s (  0.141M/prod)
Summary: hits    1.898 ± 0.001M/s (  0.136M/prod)
Summary: hits    1.799 ± 0.016M/s (  0.120M/prod)
Summary: hits    1.850 ± 0.005M/s (  0.109M/prod)
Summary: hits    1.816 ± 0.002M/s (  0.101M/prod)
Summary: hits    1.787 ± 0.001M/s (  0.094M/prod)
Summary: hits    1.764 ± 0.002M/s (  0.088M/prod)

RW SPINLOCK (AFTER)
===================
Summary: hits    1.444 ± 0.020M/s (  1.444M/prod)
Summary: hits    2.279 ± 0.011M/s (  1.139M/prod)
Summary: hits    3.422 ± 0.014M/s (  1.141M/prod)
Summary: hits    3.565 ± 0.017M/s (  0.891M/prod)
Summary: hits    2.671 ± 0.013M/s (  0.534M/prod)
Summary: hits    2.409 ± 0.005M/s (  0.401M/prod)
Summary: hits    2.485 ± 0.008M/s (  0.355M/prod)
Summary: hits    2.496 ± 0.003M/s (  0.312M/prod)
Summary: hits    2.585 ± 0.002M/s (  0.287M/prod)
Summary: hits    2.908 ± 0.011M/s (  0.291M/prod)
Summary: hits    2.346 ± 0.016M/s (  0.213M/prod)
Summary: hits    2.804 ± 0.004M/s (  0.234M/prod)
Summary: hits    2.556 ± 0.001M/s (  0.197M/prod)
Summary: hits    2.754 ± 0.004M/s (  0.197M/prod)
Summary: hits    2.482 ± 0.002M/s (  0.165M/prod)
Summary: hits    2.412 ± 0.005M/s (  0.151M/prod)
Summary: hits    2.710 ± 0.003M/s (  0.159M/prod)
Summary: hits    2.826 ± 0.005M/s (  0.157M/prod)
Summary: hits    2.718 ± 0.001M/s (  0.143M/prod)
Summary: hits    2.844 ± 0.006M/s (  0.142M/prod)

The numbers in parenthesis give averaged throughput per thread which is
of greatest interest here as a measure of scalability. Improvements are
in the order of 22 - 68% with this particular benchmark (mean = 43%).

V2:
 - Updated commit message to include benchmark results.

[0] https://docs.kernel.org/locking/spinlocks.html
[1] https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/benchs/bench_trigger.c

Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
---
 kernel/events/uprobes.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index e4834d23e1d1..8ae0eefc3a34 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -39,7 +39,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
  */
 #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
 
-static DEFINE_SPINLOCK(uprobes_treelock);	/* serialize rbtree access */
+static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
 
 #define UPROBES_HASH_SZ	13
 /* serialize uprobe->pending_list */
@@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
 {
 	struct uprobe *uprobe;
 
-	spin_lock(&uprobes_treelock);
+	read_lock(&uprobes_treelock);
 	uprobe = __find_uprobe(inode, offset);
-	spin_unlock(&uprobes_treelock);
+	read_unlock(&uprobes_treelock);
 
 	return uprobe;
 }
@@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
 {
 	struct uprobe *u;
 
-	spin_lock(&uprobes_treelock);
+	write_lock(&uprobes_treelock);
 	u = __insert_uprobe(uprobe);
-	spin_unlock(&uprobes_treelock);
+	write_unlock(&uprobes_treelock);
 
 	return u;
 }
@@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *uprobe)
 	if (WARN_ON(!uprobe_is_active(uprobe)))
 		return;
 
-	spin_lock(&uprobes_treelock);
+	write_lock(&uprobes_treelock);
 	rb_erase(&uprobe->rb_node, &uprobes_tree);
-	spin_unlock(&uprobes_treelock);
+	write_unlock(&uprobes_treelock);
 	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
 	put_uprobe(uprobe);
 }
@@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode *inode,
 	min = vaddr_to_offset(vma, start);
 	max = min + (end - start) - 1;
 
-	spin_lock(&uprobes_treelock);
+	read_lock(&uprobes_treelock);
 	n = find_node_in_range(inode, min, max);
 	if (n) {
 		for (t = n; t; t = rb_prev(t)) {
@@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode *inode,
 			get_uprobe(u);
 		}
 	}
-	spin_unlock(&uprobes_treelock);
+	read_unlock(&uprobes_treelock);
 }
 
 /* @vma contains reference counter, not the probed instruction. */
@@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
 	min = vaddr_to_offset(vma, start);
 	max = min + (end - start) - 1;
 
-	spin_lock(&uprobes_treelock);
+	read_lock(&uprobes_treelock);
 	n = find_node_in_range(inode, min, max);
-	spin_unlock(&uprobes_treelock);
+	read_unlock(&uprobes_treelock);
 
 	return !!n;
 }
-- 
2.43.0


