Return-Path: <bpf+bounces-61283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F85AAE452E
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 15:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 404F07A4951
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 13:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC03C248891;
	Mon, 23 Jun 2025 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F4kKHpCg"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6D419CD17
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686283; cv=none; b=b/xm/G3IARMKjBbKOUGCBlinxMtXywQZeknYlidVDNHCnyWIbRLmrQrIBwXc91I0Z3p7Ow16uypr3x6PJLVeGvbFCyvZ9Uo90I1oqwHne6wrYxvYRDqCQiE01KLkb/XEMaKCAgJW2chiFY8GRHslvviUiOMmIGnHBmqYUlzto+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686283; c=relaxed/simple;
	bh=CdKi0jDvUVtgmpGM9TtZNCcDFWVNlHr+SsoyArE/lHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3odT5ghJLFbfqzD6en3FT55ykEn6P5aHyVm24jGGA/AEHc7ULg3MhGnw3yCuBnmIFq/gxaisQt+dQ73bGOgDEJh5p6RS65QZtzhdaKMHkF+D4xFHR9VYGukQAjVDlG/FW5yQi61qZHkn3CzRyri4MBLL/5MfMOHasJG3kEv5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F4kKHpCg; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750686277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RExfSD+CLMxFPbIvVqYmib+kW765TmDE2ORtANrFGI0=;
	b=F4kKHpCguYy5TQI3R1c+GoYv/GgrZimz6SN9wojCyIUXhrlb+xM/Lk7443H55flv2rRLra
	l5JQ+qPeKGejTCbjHQ9ynYGJYOF8RCluSpKYuccs5tJ6M839TUgqt49VpP1sSP4jCX4rhL
	tlNUfKBSJ9WS9w+SM1zoPf3h/kgdmNg=
From: Tao Chen <chen.dylane@linux.dev>
To: kpsingh@kernel.org,
	mattbobrowski@google.com,
	song@kernel.org,
	jolsa@kernel.org,
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
Subject: [PATCH bpf-next v5 1/3] bpf: Show precise link_type for {uprobe,kprobe}_multi fdinfo
Date: Mon, 23 Jun 2025 21:43:40 +0800
Message-ID: <20250623134342.227347-1-chen.dylane@linux.dev>
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

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/trace_events.h | 10 ++++++++++
 kernel/bpf/syscall.c         |  9 ++++++++-
 kernel/trace/bpf_trace.c     | 28 ++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

Change list:
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

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index fa9cf4292df..951c91babbc 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -780,6 +780,8 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    unsigned long *missed);
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+void bpf_kprobe_multi_link_type_show(const struct bpf_link *link, char *link_type, int len);
+void bpf_uprobe_multi_link_type_show(const struct bpf_link *link, char *link_type, int len);
 #else
 static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
@@ -832,6 +834,14 @@ bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;
 }
+static inline void
+bpf_kprobe_multi_link_type_show(const struct bpf_link *link, char *link_type, int len)
+{
+}
+static inline void
+bpf_uprobe_multi_link_type_show(const struct bpf_link *link, char *link_type, int len)
+{
+}
 #endif
 
 enum {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 51ba1a7aa43..43b821b37bc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3226,9 +3226,16 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 	const struct bpf_prog *prog = link->prog;
 	enum bpf_link_type type = link->type;
 	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
+	char link_type[64] = {};
 
 	if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) {
-		seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
+		if (link->type == BPF_LINK_TYPE_KPROBE_MULTI)
+			bpf_kprobe_multi_link_type_show(link, link_type, sizeof(link_type));
+		else if (link->type == BPF_LINK_TYPE_UPROBE_MULTI)
+			bpf_uprobe_multi_link_type_show(link, link_type, sizeof(link_type));
+		else
+			strscpy(link_type, bpf_link_type_strs[type], sizeof(link_type));
+		seq_printf(m, "link_type:\t%s\n", link_type);
 	} else {
 		WARN_ONCE(1, "missing BPF_LINK_TYPE(...) for link type %u\n", type);
 		seq_printf(m, "link_type:\t<%u>\n", type);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 24b94870b50..8ecb1a9f85d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3016,7 +3016,21 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	kvfree(cookies);
 	return err;
 }
+
+void bpf_kprobe_multi_link_type_show(const struct bpf_link *link, char *link_type,
+				     int len)
+{
+	struct bpf_kprobe_multi_link *kmulti_link;
+
+	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
+	strscpy(link_type, kmulti_link->flags == BPF_F_KPROBE_MULTI_RETURN ?
+				"kretprobe_multi" : "kprobe_multi", len);
+}
 #else /* !CONFIG_FPROBE */
+void bpf_kprobe_multi_link_type_show(const struct bpf_link *link, char *link_type,
+				     int len)
+{
+}
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;
@@ -3407,7 +3421,21 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	path_put(&path);
 	return err;
 }
+
+void bpf_uprobe_multi_link_type_show(const struct bpf_link *link, char *link_type,
+				     int len)
+{
+	struct bpf_uprobe_multi_link *umulti_link;
+
+	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
+	strscpy(link_type, umulti_link->flags == BPF_F_UPROBE_MULTI_RETURN ?
+				"uretprobe_multi" : "uprobe_multi", len);
+}
 #else /* !CONFIG_UPROBES */
+void bpf_uprobe_multi_link_type_show(const struct bpf_link *link, char *link_type,
+				     int len)
+{
+}
 int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;
-- 
2.48.1


