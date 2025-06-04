Return-Path: <bpf+bounces-59645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5255AACE24D
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 18:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD091897E37
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DAD1E32A2;
	Wed,  4 Jun 2025 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aMePBzl/"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A57B1F416B
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749055077; cv=none; b=riJh+ylzKQ/hSo+qesCvrlauCa6MC16p57R59FI31WhCDcoRAJGusL6CAnmVW3cG/qWS7qFpVTzBTWTp/+SeDUph31myya5h/vEr0EB8xuQ52x/MnyoDvWqa819QVsY6ttqw+o5/gIAZU+cz57ehFw1YGoN8YwG6MnHz3rkh79o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749055077; c=relaxed/simple;
	bh=k1VAhtvWn1mdnc82A42urCXNfSl687+frp/shs2RzIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pGJ7HxCrTkTl5f5kLuJnDrTlwNGnnj0aVEAE4X/wHmdl0rUP8VEOcHpiJ5rFW8oF13UMNHvXfIwvSe+dS/xwN96Qzg/Z2jQUyKaIuNRhFdu7ycBZ4B7FdX1bNGatF4cG8prUp3jFJjzkOgcyvIFhtSTutyi6hPI2mw6O7HJRq1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aMePBzl/; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749055062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LpQJtvbQ0WTNzxLrRi6c5eMnvReMC88RFvMxCl1x3Ss=;
	b=aMePBzl/Kpp/mc2Qthi84fsO91CCWhQU6s10DjhzRzngNpjRGDzyOpYaS/Vd78OtVKBHmU
	B6XxJLcdvcmWF8gxU20PBS6FgsEhyiBp81BcOpkjUcwC6EOgZK7h6DExgVCL/pUBulrwJn
	cTL90JD5YNNQiu0R0zBQlYz7tjIvNXg=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next] bpf: Add show_fdinfo for perf_event
Date: Thu,  5 Jun 2025 00:37:22 +0800
Message-Id: <20250604163723.3175258-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

After commit 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event") add
perf_event info, we can also show the info with the method of cat /proc/[fd]/fdinfo.

kprobe fdinfo:
link_type:	perf
link_id:	2
prog_tag:	bcf7977d3b93787c
prog_id:	18
name:	bpf_fentry_test1
offset:	0
missed:	0
addr:	ffffffffaea8d134
event_type:	3
cookie:	3735928559

uprobe fdinfo:
link_type:	perf
link_id:	6
prog_tag:	bcf7977d3b93787c
prog_id:	7
name:	/proc/self/exe
offset:	6507541
event_type:	1
cookie:	3735928559

tracepoint fdinfo:
link_type:	perf
link_id:	4
prog_tag:	bcf7977d3b93787c
prog_id:	8
tp_name:	sched_switch
event_type:	5
cookie:	3735928559

perf_event fdinfo:
link_type:	perf
link_id:	5
prog_tag:	bcf7977d3b93787c
prog_id:	9
type:	1
config:	2
event_type:	6
cookie:	3735928559

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/syscall.c | 126 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9794446bc8..9af54852eb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3793,6 +3793,35 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 	info->perf_event.kprobe.cookie = event->bpf_cookie;
 	return 0;
 }
+
+static void bpf_perf_link_fdinfo_kprobe(const struct perf_event *event,
+					struct seq_file *seq)
+{
+	const char *name;
+	int err;
+	u32 prog_id, type;
+	u64 offset, addr;
+	unsigned long missed;
+
+	err = bpf_get_perf_event_info(event, &prog_id, &type, &name,
+				      &offset, &addr, &missed);
+	if (err)
+		return;
+
+	if (type == BPF_FD_TYPE_KRETPROBE)
+		type = BPF_PERF_EVENT_KRETPROBE;
+	else
+		type = BPF_PERF_EVENT_KPROBE;
+
+	seq_printf(seq,
+		   "name:\t%s\n"
+		   "offset:\t%llu\n"
+		   "missed:\t%lu\n"
+		   "addr:\t%llx\n"
+		   "event_type:\t%u\n"
+		   "cookie:\t%llu\n",
+		   name, offset, missed, addr, type, event->bpf_cookie);
+}
 #endif
 
 #ifdef CONFIG_UPROBE_EVENTS
@@ -3820,6 +3849,34 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 	info->perf_event.uprobe.cookie = event->bpf_cookie;
 	return 0;
 }
+
+static void bpf_perf_link_fdinfo_uprobe(const struct perf_event *event,
+					struct seq_file *seq)
+{
+	const char *name;
+	int err;
+	u32 prog_id, type;
+	u64 offset, addr;
+	unsigned long missed;
+
+	err = bpf_get_perf_event_info(event, &prog_id, &type, &name,
+				      &offset, &addr, &missed);
+	if (err)
+		return;
+
+	if (type == BPF_FD_TYPE_URETPROBE)
+		type = BPF_PERF_EVENT_URETPROBE;
+	else
+		type = BPF_PERF_EVENT_UPROBE;
+
+	seq_printf(seq,
+		   "name:\t%s\n"
+		   "offset:\t%llu\n"
+		   "event_type:\t%u\n"
+		   "cookie:\t%llu\n",
+		   name, offset, type, event->bpf_cookie);
+
+}
 #endif
 
 static int bpf_perf_link_fill_probe(const struct perf_event *event,
@@ -3888,10 +3945,79 @@ static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
 	}
 }
 
+static void bpf_perf_event_link_show_fdinfo(const struct perf_event *event,
+					    struct seq_file *seq)
+{
+	seq_printf(seq,
+		   "type:\t%u\n"
+		   "config:\t%llu\n"
+		   "event_type:\t%u\n"
+		   "cookie:\t%llu\n",
+		   event->attr.type, event->attr.config,
+		   BPF_PERF_EVENT_EVENT, event->bpf_cookie);
+}
+
+static void bpf_tracepoint_link_show_fdinfo(const struct perf_event *event,
+					    struct seq_file *seq)
+{
+	int err;
+	const char *name;
+	u32 prog_id;
+
+	err = bpf_get_perf_event_info(event, &prog_id, NULL, &name, NULL,
+				      NULL, NULL);
+	if (err)
+		return;
+
+	seq_printf(seq,
+		   "tp_name:\t%s\n"
+		   "event_type:\t%u\n"
+		   "cookie:\t%llu\n",
+		   name, BPF_PERF_EVENT_TRACEPOINT, event->bpf_cookie);
+}
+
+static void bpf_probe_link_show_fdinfo(const struct perf_event *event,
+				       struct seq_file *seq)
+{
+#ifdef CONFIG_KPROBE_EVENTS
+	if (event->tp_event->flags & TRACE_EVENT_FL_KPROBE)
+		return bpf_perf_link_fdinfo_kprobe(event, seq);
+#endif
+
+#ifdef CONFIG_UPROBE_EVENTS
+	if (event->tp_event->flags & TRACE_EVENT_FL_UPROBE)
+		return bpf_perf_link_fdinfo_uprobe(event, seq);
+#endif
+}
+
+static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
+				      struct seq_file *seq)
+{
+	struct bpf_perf_link *perf_link;
+	const struct perf_event *event;
+
+	perf_link = container_of(link, struct bpf_perf_link, link);
+	event = perf_get_event(perf_link->perf_file);
+	if (IS_ERR(event))
+		return;
+
+	switch (event->prog->type) {
+	case BPF_PROG_TYPE_PERF_EVENT:
+		return bpf_perf_event_link_show_fdinfo(event, seq);
+	case BPF_PROG_TYPE_TRACEPOINT:
+		return bpf_tracepoint_link_show_fdinfo(event, seq);
+	case BPF_PROG_TYPE_KPROBE:
+		return bpf_probe_link_show_fdinfo(event, seq);
+	default:
+		return;
+	}
+}
+
 static const struct bpf_link_ops bpf_perf_link_lops = {
 	.release = bpf_perf_link_release,
 	.dealloc = bpf_perf_link_dealloc,
 	.fill_link_info = bpf_perf_link_fill_link_info,
+	.show_fdinfo = bpf_perf_link_show_fdinfo,
 };
 
 static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
-- 
2.43.0


