Return-Path: <bpf+bounces-62134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFA0AF5D6A
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA67A4E7989
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 15:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099B33196A6;
	Wed,  2 Jul 2025 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q6Z/91YG"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9C3196A9
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470871; cv=none; b=an5arDQtHNvJnpvH9dQwcUnTyPTjEuodwOC+r0hnk8jV0y2tzAsyVN+XtR2kJsj+I51+g1QBDvCNN6Qdo4uMnjkfElzKKDV/em0ZxM00fQf5h3X7e3Qxy/rI/f7sTzB/lWijAOweUYXjdSyGTjJHoCKyCbSJUfJcjRIf976kMf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470871; c=relaxed/simple;
	bh=u4W2Z/TU+YB4Ijy/Gte4BRSlL9Zv3XISeoAVt1fLVSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DqmrZH/3MibANC2Z9bRmB8wjqx90ppuiQLFQ0Shc+2QtArzIixH2I3ACi9sEwCEW6F2/dESL9VW2tSSANSdqY58XdB5/It/jRwM9/G4N6vsRlOxfTkN1oEOxBLYZQh9aDi9D+uLDZZ/P7GcAxHm2VNJPnNBDO/WC2nYPY0GYzbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q6Z/91YG; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751470865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JHo1YDWLvWpOCNgZLEBk5Fsdvw+OSzNkQJKF7Fq1xL0=;
	b=q6Z/91YGqqvFC8+PcQcYDCLQhvBn6l9NfGd3SsCn3XS3bv4ph2LB3XGTRfCQH+H6vx5h0R
	kljQwPEOkKcGCUJ5TytMB/KpBofGgj8SWViAP04b3LXktOkCno90hWGUh9Mf6ydMFFZ9/m
	YPav8McZt6rpWOr260wF5n6LbZxnfEQ=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v7 1/3] bpf: Show precise link_type for {uprobe,kprobe}_multi fdinfo
Date: Wed,  2 Jul 2025 23:39:56 +0800
Message-ID: <20250702153958.639852-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Alexei suggested, 'link_type' can be more precise and differentiate
for human in fdinfo. In fact BPF_LINK_TYPE_KPROBE_MULTI includes
kretprobe_multi type, the same as BPF_LINK_TYPE_UPROBE_MULTI, so we
can show it more concretely.

link_type:	kprobe_multi
link_id:	1
prog_tag:	d2b307e915f0dd37
...
link_type:	kretprobe_multi
link_id:	2
prog_tag:	ab9ea0545870781d
...
link_type:	uprobe_multi
link_id:	9
prog_tag:	e729f789e34a8eca
...
link_type:	uretprobe_multi
link_id:	10
prog_tag:	7db356c03e61a4d4

Co-developed-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/bpf.h      |  1 +
 kernel/bpf/syscall.c     |  9 ++++++++-
 kernel/trace/bpf_trace.c | 10 ++++------
 3 files changed, 13 insertions(+), 7 deletions(-)

Change list:
  v6 -> v7:
    - Show the same order cookie for kprobe/uprobe.(Andrii)
    - Use tab format to show multi events for kprobe/uprobe.(Andrii)
    - Use u32 flags in bpf_link.(Alexei)
  v6:
  https://lore.kernel.org/bpf/20250627082252.431209-1-chen.dylane@linux.dev

  v5 -> v6:
    - Move flags into bpf_link to get retprobe info
      directly.(Alexei, Jiri)
  v5:
  https://lore.kernel.org/bpf/20250623134342.227347-1-chen.dylane@linux.dev

  v4 -> v5:
    - Add patch1 to show precise link_type for
      {uprobe,kprobe}_multi.(Alexei)
    - patch2,3 just remove type field, which will be showed in
      link_type
  v4:
  https://lore.kernel.org/bpf/20250619034257.70520-1-chen.dylane@linux.dev

  v3 -> v4:
    - use %pS to print func info.(Alexei)
  v3:
  https://lore.kernel.org/bpf/20250616130233.451439-1-chen.dylane@linux.dev

  v2 -> v3:
    - show info in one line for multi events.(Jiri)
  v2:
  https://lore.kernel.org/bpf/20250615150514.418581-1-chen.dylane@linux.dev

  v1 -> v2:
    - replace 'func_cnt' with 'uprobe_cnt'.(Andrii)
    - print func name is more readable and security for kprobe_multi.(Alexei)
  v1:
  https://lore.kernel.org/bpf/20250612115556.295103-1-chen.dylane@linux.dev

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b25d278409..751ea3f5480 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1702,6 +1702,7 @@ struct bpf_link {
 	 * link's semantics is determined by target attach hook
 	 */
 	bool sleepable;
+	u32 flags;
 	/* rcu is used before freeing, work can be used to schedule that
 	 * RCU-based freeing before that, so they never overlap
 	 */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 51ba1a7aa43..e6eea594f1c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3228,7 +3228,14 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
 
 	if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) {
-		seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
+		if (link->type == BPF_LINK_TYPE_KPROBE_MULTI)
+			seq_printf(m, "link_type:\t%s\n", link->flags == BPF_F_KPROBE_MULTI_RETURN ?
+				   "kretprobe_multi" : "kprobe_multi");
+		else if (link->type == BPF_LINK_TYPE_UPROBE_MULTI)
+			seq_printf(m, "link_type:\t%s\n", link->flags == BPF_F_UPROBE_MULTI_RETURN ?
+				   "uretprobe_multi" : "uprobe_multi");
+		else
+			seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
 	} else {
 		WARN_ONCE(1, "missing BPF_LINK_TYPE(...) for link type %u\n", type);
 		seq_printf(m, "link_type:\t<%u>\n", type);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 24b94870b50..85f07f662fe 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2469,7 +2469,6 @@ struct bpf_kprobe_multi_link {
 	u32 cnt;
 	u32 mods_cnt;
 	struct module **mods;
-	u32 flags;
 };
 
 struct bpf_kprobe_multi_run_ctx {
@@ -2589,7 +2588,7 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
 
 	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
 	info->kprobe_multi.count = kmulti_link->cnt;
-	info->kprobe_multi.flags = kmulti_link->flags;
+	info->kprobe_multi.flags = kmulti_link->link.flags;
 	info->kprobe_multi.missed = kmulti_link->fp.nmissed;
 
 	if (!uaddrs)
@@ -2979,7 +2978,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	link->addrs = addrs;
 	link->cookies = cookies;
 	link->cnt = cnt;
-	link->flags = flags;
+	link->link.flags = flags;
 
 	if (cookies) {
 		/*
@@ -3048,7 +3047,6 @@ struct bpf_uprobe_multi_link {
 	struct path path;
 	struct bpf_link link;
 	u32 cnt;
-	u32 flags;
 	struct bpf_uprobe *uprobes;
 	struct task_struct *task;
 };
@@ -3112,7 +3110,7 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
 
 	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
 	info->uprobe_multi.count = umulti_link->cnt;
-	info->uprobe_multi.flags = umulti_link->flags;
+	info->uprobe_multi.flags = umulti_link->link.flags;
 	info->uprobe_multi.pid = umulti_link->task ?
 				 task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current)) : 0;
 
@@ -3372,7 +3370,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	link->uprobes = uprobes;
 	link->path = path;
 	link->task = task;
-	link->flags = flags;
+	link->link.flags = flags;
 
 	bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
 		      &bpf_uprobe_multi_link_lops, prog);
-- 
2.48.1


