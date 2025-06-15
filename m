Return-Path: <bpf+bounces-60684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85065ADA239
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 17:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C313AEAA2
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 15:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332A725FA31;
	Sun, 15 Jun 2025 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bKvtJ6u9"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4151525F996
	for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749999946; cv=none; b=dfTxvH9K5RZjQVXa/amQOQ6QRmMI18WAJBs9YS9i0Mdj2dOFLT09NgpzZ+/N/0XCjw6G3Zk8YTua8RMj8FVWxQl/KeOnm4NjsypfehpVYhIDraysB4s1sFvYtF5Rpj3igWjDyIgb67fTLniHQ+8Aoluu8aEZMtHFRl9Fabd/04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749999946; c=relaxed/simple;
	bh=9x5d0MuH0alaGnZtLVJbiwg3/L6hyK1sziXN8OX+yS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eFarJGL7e9YBgu/TgHzYZvj2rqHO1hNxPODLZQIJurbZ5OqoU6LkdJ51MKQaUbHYY/cntsiPRiHPyMP/+ZyNCcuejAY90ut2JvcvbgSoKp1wVnOjir27zdNsFpai2YOlM8N1qcXfu+Dstuw6RSoLT96qh55ghzFNUKGL6XZX/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bKvtJ6u9; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749999942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xi5PEas38TLaRRKxnR4rXfoajkd7D2bySyWzaXWpC2A=;
	b=bKvtJ6u9UmcUuUnsvV7wKQo4hMfeR3bPLWoEOVDvhy6/SkgL5L6diqee9HBwXsRnIOBGcW
	PM1bVPb/zfkfKHa/luoQ9n24nVe3XpxcciJEeMETl12LaD5HreCUvHfnJGLRgBY86pA569
	B0ml9SI4x9degePeM/O3+9ohHsPTKcs=
From: Tao Chen <chen.dylane@linux.dev>
To: song@kernel.org,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	haoluo@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v2 1/2] bpf: Add show_fdinfo for uprobe_multi
Date: Sun, 15 Jun 2025 23:05:13 +0800
Message-ID: <20250615150514.418581-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Show uprobe_multi link info with fdinfo, the info as follows:

link_type:	uprobe_multi
link_id:	9
prog_tag:	e729f789e34a8eca
prog_id:	58
type:	uprobe_multi
uprobe_cnt:	3
pid:	0
path:	/home/dylane/bpf/tools/testing/selftests/bpf/test_progs
offset:	0xa69ed7
ref_ctr_offset:	0x0
cookie:	3
offset:	0xa69ee2
ref_ctr_offset:	0x0
cookie:	1
offset:	0xa69eed
ref_ctr_offset:	0x0
cookie:	2

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

Change list:
  v1 -> v2:
    - replace 'func_cnt' with 'uprobe_cnt'.(Andrii)
    - print func name is more readable and security for kprobe_multi.(Alexei)
  v1:
  https://lore.kernel.org/bpf/20250612115556.295103-1-chen.dylane@linux.dev

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 24b94870b50..9a8ca8a8e2b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3157,10 +3157,58 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
 	return err;
 }
 
+#ifdef CONFIG_PROC_FS
+static void bpf_uprobe_multi_show_fdinfo(const struct bpf_link *link,
+					 struct seq_file *seq)
+{
+	struct bpf_uprobe_multi_link *umulti_link;
+	char *p, *buf;
+
+	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
+
+	buf = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	p = d_path(&umulti_link->path, buf, PATH_MAX);
+	if (IS_ERR(p)) {
+		kfree(buf);
+		return;
+	}
+
+	seq_printf(seq,
+		   "type:\t%s\n"
+		   "uprobe_cnt:\t%u\n"
+		   "pid:\t%u\n"
+		   "path:\t%s\n",
+		   umulti_link->flags == BPF_F_UPROBE_MULTI_RETURN ?
+					 "uretprobe_multi" : "uprobe_multi",
+		   umulti_link->cnt,
+		   umulti_link->task ? task_pid_nr_ns(umulti_link->task,
+			   task_active_pid_ns(current)) : 0,
+		   p);
+
+	for (int i = 0; i < umulti_link->cnt; i++) {
+		seq_printf(seq,
+			   "offset:\t%#llx\n"
+			   "ref_ctr_offset:\t%#lx\n"
+			   "cookie:\t%llu\n",
+			   umulti_link->uprobes[i].offset,
+			   umulti_link->uprobes[i].ref_ctr_offset,
+			   umulti_link->uprobes[i].cookie);
+	}
+
+	kfree(buf);
+}
+#endif
+
 static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
 	.release = bpf_uprobe_multi_link_release,
 	.dealloc_deferred = bpf_uprobe_multi_link_dealloc,
 	.fill_link_info = bpf_uprobe_multi_link_fill_link_info,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo = bpf_uprobe_multi_show_fdinfo,
+#endif
 };
 
 static int uprobe_prog_run(struct bpf_uprobe *uprobe,
-- 
2.48.1


