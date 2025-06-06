Return-Path: <bpf+bounces-59869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBC1AD04B6
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114101650FB
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A075E28A719;
	Fri,  6 Jun 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u7ARvbu/"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F7C28C5A9
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222217; cv=none; b=hbYR+ZP39tFXmmBiPzBJSHQVhHfojUgvzXzZ+c8yBwn5X/n1Jl6IxQ+znWw368e5NRJ/W6dKWMpobJLTOs61FtLIJASFbJ09Kp1A2SvMv+ygaf0SIvtN696C5EoJGymRmhSz8Stqr1e5ILzgBj+EMour189u0WyZjKtzQ7I0hBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222217; c=relaxed/simple;
	bh=DRVrh8AqSjSv5TXQJ3G55uv/2k+YOtrWpqdhnHMfGCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BX5kpvd8wDsLugOCbicOxCr0EJdoN/3XJe24GrLatg4XpsrCGeWMk0paUh1rjG9gNPPeb56GTCoyrBVgtN6AGUpR80bkgS462/upPkh17KQmBo1J24UuGBXyfQ7yqjZBFvw5hFpp+fmuEIlUPKLKBQGQxnFPNVzWE3wI8Jy5zQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u7ARvbu/; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749222210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qAtVAk3ktG/11zUq9KHayxDPp/WA9lPsPFV1ZKBYtiA=;
	b=u7ARvbu/JzSUVWLY8cd49nFOwDoNbZbc7BxwPr0P/Vu7xmxtyo3bV4YHLYBk01rRT1P7Mz
	TSW/8A5IJKY0e2c/LtfR8RouSikixGy0ffXl0bAbgpNMCHWfarhMNWdSkzlTrUI/x4//r5
	xaN896qIkM5mY1zgBKi7zbiLiofnWHs=
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
Subject: [PATCH bpf-next v2] bpf: Add show_fdinfo for perf_event
Date: Fri,  6 Jun 2025 23:02:58 +0800
Message-Id: <20250606150258.3385166-1-chen.dylane@linux.dev>
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
link_id:	10
prog_tag:	bcf7977d3b93787c
prog_id:	20
name:	bpf_fentry_test1
offset:	0
missed:	0
addr:	ffffffffa28a2904
event_type:	kprobe
cookie:	3735928559

uprobe fdinfo:
link_type:	perf
link_id:	13
prog_tag:	bcf7977d3b93787c
prog_id:	21
name:	/proc/self/exe
offset:	63dce4
ref_ctr_offset:	33eee2a
event_type:	uprobe
cookie:	3735928559

tracepoint fdinfo:
link_type:	perf
link_id:	11
prog_tag:	bcf7977d3b93787c
prog_id:	22
tp_name:	sched_switch
event_type:	tracepoint
cookie:	3735928559

perf_event fdinfo:
link_type:	perf
link_id:	12
prog_tag:	bcf7977d3b93787c
prog_id:	23
type:	1
config:	2
event_type:	event
cookie:	3735928559

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/syscall.c | 118 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

Change list:
- v1 -> v2:
   - Andrii suggested:
     1. define event_type with string
     2. print offset and addr with hex

   - Jiri suggested:
     1. add ref_ctr_offset for uprobe
- v1:
    https://lore.kernel.org/bpf/20250604163723.3175258-1-chen.dylane@linux.dev

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 89d027cd7ca..928ff129087 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3795,6 +3795,31 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
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
+	seq_printf(seq,
+		   "name:\t%s\n"
+		   "offset:\t%llx\n"
+		   "missed:\t%lu\n"
+		   "addr:\t%llx\n"
+		   "event_type:\t%s\n"
+		   "cookie:\t%llu\n",
+		   name, offset, missed, addr, type == BPF_FD_TYPE_KRETPROBE ?
+		   "kretprobe" : "kprobe", event->bpf_cookie);
+}
 #endif
 
 #ifdef CONFIG_UPROBE_EVENTS
@@ -3823,6 +3848,30 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 	info->perf_event.uprobe.ref_ctr_offset = ref_ctr_offset;
 	return 0;
 }
+
+static void bpf_perf_link_fdinfo_uprobe(const struct perf_event *event,
+					struct seq_file *seq)
+{
+	const char *name;
+	int err;
+	u32 prog_id, type;
+	u64 offset, ref_ctr_offset;
+	unsigned long missed;
+
+	err = bpf_get_perf_event_info(event, &prog_id, &type, &name,
+				      &offset, &ref_ctr_offset, &missed);
+	if (err)
+		return;
+
+	seq_printf(seq,
+		   "name:\t%s\n"
+		   "offset:\t%llx\n"
+		   "ref_ctr_offset:\t%llx\n"
+		   "event_type:\t%s\n"
+		   "cookie:\t%llu\n",
+		   name, offset, ref_ctr_offset, type == BPF_FD_TYPE_URETPROBE ?
+		   "uretprobe" : "uprobe", event->bpf_cookie);
+}
 #endif
 
 static int bpf_perf_link_fill_probe(const struct perf_event *event,
@@ -3891,10 +3940,79 @@ static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
 	}
 }
 
+static void bpf_perf_event_link_show_fdinfo(const struct perf_event *event,
+					    struct seq_file *seq)
+{
+	seq_printf(seq,
+		   "type:\t%u\n"
+		   "config:\t%llu\n"
+		   "event_type:\t%s\n"
+		   "cookie:\t%llu\n",
+		   event->attr.type, event->attr.config,
+		   "event", event->bpf_cookie);
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
+		   "event_type:\t%s\n"
+		   "cookie:\t%llu\n",
+		   name, "tracepoint", event->bpf_cookie);
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


