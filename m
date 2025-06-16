Return-Path: <bpf+bounces-60711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1859ADB0FF
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 15:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEE7B7A2742
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FC8285C91;
	Mon, 16 Jun 2025 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rOoehX0s"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12E2CCDE
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079001; cv=none; b=ikO8wXBcD9pgcS+qPL50nkcakxkqgvykLchL8ENJZqvvS8S3KjuUYTiJHMepQSjP83uxktm0UyQOKGIGHXeJCYcpHiuKlSKlJ/PYNJWOWmcSaTLtbGFGT9lohhF2MDo77V1aJune3hpxRBb+y1dy7TeUCiqVoHnPfDlADkwgE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079001; c=relaxed/simple;
	bh=YDdt2a9xy/4INarcQaMrArBFeqy3/Ue9LuaTqFLYAK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bp1sIxdah0pWvCXgcCtRmk/fITPorsvIkJ66y03JdqwoEhUnEsB3J1Pxndp4eeil1N5Es1pcgdX0HLQEudWw4NtxamU134ua4glAIzPILFzsRbRA/TCxbqfnkBZzxalUYehi/g7s4epUIgfjoNlEgce5Sp5HCsJtdEpLG7AHoXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rOoehX0s; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750078978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Eubdnz44eJHj7tXfj3/2tAprEgJBgR4lupu93+abiDA=;
	b=rOoehX0sU7Frhgcz8UBT13xk6wjZchspa3Ko8wehdCZ0ZwM8CN2OxOiqzVlJ003ytlkgYU
	Z5jEbgg0ZxSKzHq58K7mBMLPBMzYX6S9Jx1u1CeV0W4K/0wwHxx1t/O6zE/FWYcy4FStLe
	dKipLGWX4vngnzt5EGgsCumYTfyhvOU=
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
Subject: [PATCH bpf-next v3 1/2] bpf: Add show_fdinfo for uprobe_multi
Date: Mon, 16 Jun 2025 21:02:32 +0800
Message-ID: <20250616130233.451439-1-chen.dylane@linux.dev>
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
type:	uprobe_multi
uprobe_cnt:	3
pid:	0
path:	/home/dylane/bpf/tools/testing/selftests/bpf/test_progs
offset           ref_ctr_offset   cookie
0xa69f13         0x0              3
0xa69f1e         0x0              1
0xa69f29         0x0              2

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

Change list:
  v2 -> v3:
    - show info in one line for multi events.(Jiri)
  v2:
  https://lore.kernel.org/bpf/20250615150514.418581-1-chen.dylane@linux.dev 

  v1 -> v2:
    - replace 'func_cnt' with 'uprobe_cnt'.(Andrii)
    - print func name is more readable and security for kprobe_multi.(Alexei)
  v1:
  https://lore.kernel.org/bpf/20250612115556.295103-1-chen.dylane@linux.dev

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 24b94870b50..2d422f897ac 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3157,10 +3157,57 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
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
+	seq_printf(seq, "%-16s %-16s %-16s\n", "offset", "ref_ctr_offset", "cookie");
+	for (int i = 0; i < umulti_link->cnt; i++) {
+		seq_printf(seq,
+			   "%#-16llx %#-16lx %-16llu\n",
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


