Return-Path: <bpf+bounces-62135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C11B4AF5D88
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334141C255FE
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9EA2E7BCC;
	Wed,  2 Jul 2025 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A3O9Dpuo"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9600A2E7BB6
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470885; cv=none; b=lA+wCY4NuNM9bDGbAyroqkzrK/2iHGNTGOPFf3k4tF/EYLuPZwlBbltHbzLf3O8GSCzI8/JWUmnlggeUk/wdNsKP9WSwnSACjZJK/uxMqyBAwlopFmdRfiVRqBnqIL/pqU4esXB1a9nfuKmmRS6+zfgRw0e35ZwuU09tra0QDIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470885; c=relaxed/simple;
	bh=ZAQsrXPOl2O9Lj2rA112EgpzrmhpxRn37XfAnFKIexM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3ofJ/qD3SJINJGpMOpgbuYI7IHeQn73jKry3K1pi/tTxkmoXluhZRnDdhBBhFGTtPVymKbWODLlP3qShSwUM//dHgXabuT28GnlIInZ6xM4M6nWXgj5KwvtCa/B71yEtVPM9rFNGkBmahburR8Q2zYLmSzs+LA+/wDzSMvaGcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A3O9Dpuo; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751470881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmPSSyi2TevtL7Ci/GfXvARkxAO7xrZZ+pyYoPwMNTU=;
	b=A3O9Dpuo5fJ9xidlpxWIZ4bem5KJiO/g2pOw7nuWKSoTsmPxApfl5C3LsbjijHnx0yot9z
	9w8qNs2e/3lAoTy6bfJp/I+RUikFQWwasuytKWbBeQ3PBtpFJ6DOGlGXu0VlqA0L54dCLr
	tHYCkw3SEl6lNkIx9EUoQ8Tw+wn7hh8=
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
Subject: [PATCH bpf-next v7 2/3] bpf: Add show_fdinfo for uprobe_multi
Date: Wed,  2 Jul 2025 23:39:57 +0800
Message-ID: <20250702153958.639852-2-chen.dylane@linux.dev>
In-Reply-To: <20250702153958.639852-1-chen.dylane@linux.dev>
References: <20250702153958.639852-1-chen.dylane@linux.dev>
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
prog_id:	39
uprobe_cnt:	3
pid:	0
path:	/home/dylane/bpf/tools/testing/selftests/bpf/test_progs
cookie	 offset	 ref_ctr_offset
3	 0xa69f13	 0x0
1	 0xa69f1e	 0x0
2	 0xa69f29	 0x0

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 85f07f662fe..9161a1b3418 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3155,10 +3155,54 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
 	return err;
 }
 
+#ifdef CONFIG_PROC_FS
+static void bpf_uprobe_multi_show_fdinfo(const struct bpf_link *link,
+					 struct seq_file *seq)
+{
+	struct bpf_uprobe_multi_link *umulti_link;
+	char *p, *buf;
+	pid_t pid;
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
+	pid = umulti_link->task ?
+	      task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current)) : 0;
+	seq_printf(seq,
+		   "uprobe_cnt:\t%u\n"
+		   "pid:\t%u\n"
+		   "path:\t%s\n",
+		   umulti_link->cnt, pid, p);
+
+	seq_printf(seq, "%s\t %s\t %s\n", "cookie", "offset", "ref_ctr_offset");
+	for (int i = 0; i < umulti_link->cnt; i++) {
+		seq_printf(seq,
+			   "%llu\t %#llx\t %#lx\n",
+			   umulti_link->uprobes[i].cookie,
+			   umulti_link->uprobes[i].offset,
+			   umulti_link->uprobes[i].ref_ctr_offset);
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


