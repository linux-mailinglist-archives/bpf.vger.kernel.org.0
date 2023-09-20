Return-Path: <bpf+bounces-10491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C9F7A8E81
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 23:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A952B209DF
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 21:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27CF405CF;
	Wed, 20 Sep 2023 21:32:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD5441A88
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 21:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D70FC433C8;
	Wed, 20 Sep 2023 21:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695245543;
	bh=hpJ6WUdVwn4SXMLUBxWi1SOcwWHkAcgKpCbLJ/W8W/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rbNuAoAuoXMrdb+s3cMHfB+GriI5IR3t4NiUlA+R8ZKrqSiA8y/SIytpXcdIA9fo6
	 ZgsF7y/Ax7Fl8ReXDx8MDHpyusBfW6vxrX8WMWuLXcBUN6emDUaRU4gDZpc1CcjiCR
	 LHJXY+rjmRQGK6DJqSqxg6p5WpOO/3j4aQsxnfGglE2DJKdUtxsmYQyJpQ2NtlslBT
	 qpCVnqIC4Wceg4nz9yfmIvsY2s2dL9NA3Di7+cwBKLyVwhu3ZzprShSCUn1iqTQyPc
	 GF0RCZZbSPxw8UztghMqsU3ZqeCuLUo/rOb1nMXQqpGI0B1ENWXILQr/pfEr2d37/g
	 84WWLhkXxawMQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCHv3 bpf-next 3/9] bpf: Add missed value to kprobe perf link info
Date: Wed, 20 Sep 2023 23:31:39 +0200
Message-ID: <20230920213145.1941596-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920213145.1941596-1-jolsa@kernel.org>
References: <20230920213145.1941596-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missed value to kprobe attached through perf link info to
hold the stats of missed kprobe handler execution.

The kprobe's missed counter gets incremented when kprobe handler
is not executed due to another kprobe running on the same cpu.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/trace_events.h   |  6 ++++--
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           | 14 ++++++++------
 kernel/trace/bpf_trace.c       |  5 +++--
 kernel/trace/trace_kprobe.c    | 14 +++++++++++---
 tools/include/uapi/linux/bpf.h |  1 +
 6 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 21ae37e49319..5eb88a66eb68 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -761,7 +761,8 @@ struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name);
 void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp);
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
-			    u64 *probe_offset, u64 *probe_addr);
+			    u64 *probe_offset, u64 *probe_addr,
+			    unsigned long *missed);
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 #else
@@ -801,7 +802,7 @@ static inline void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 static inline int bpf_get_perf_event_info(const struct perf_event *event,
 					  u32 *prog_id, u32 *fd_type,
 					  const char **buf, u64 *probe_offset,
-					  u64 *probe_addr)
+					  u64 *probe_addr, unsigned long *missed)
 {
 	return -EOPNOTSUPP;
 }
@@ -877,6 +878,7 @@ extern void perf_kprobe_destroy(struct perf_event *event);
 extern int bpf_get_kprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **symbol,
 			       u64 *probe_offset, u64 *probe_addr,
+			       unsigned long *missed,
 			       bool perf_type_tracepoint);
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e5216420ec73..e824b0c50425 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6546,6 +6546,7 @@ struct bpf_link_info {
 					__u32 name_len;
 					__u32 offset; /* offset from func_name */
 					__u64 addr;
+					__u64 missed;
 				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
 				struct {
 					__aligned_u64 tp_name;   /* in/out */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 85c1d908f70f..6b5280f14a53 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3374,7 +3374,7 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
 static int bpf_perf_link_fill_common(const struct perf_event *event,
 				     char __user *uname, u32 ulen,
 				     u64 *probe_offset, u64 *probe_addr,
-				     u32 *fd_type)
+				     u32 *fd_type, unsigned long *missed)
 {
 	const char *buf;
 	u32 prog_id;
@@ -3385,7 +3385,7 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 		return -EINVAL;
 
 	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
-				      probe_offset, probe_addr);
+				      probe_offset, probe_addr, missed);
 	if (err)
 		return err;
 	if (!uname)
@@ -3408,6 +3408,7 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 				     struct bpf_link_info *info)
 {
+	unsigned long missed;
 	char __user *uname;
 	u64 addr, offset;
 	u32 ulen, type;
@@ -3416,7 +3417,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 	uname = u64_to_user_ptr(info->perf_event.kprobe.func_name);
 	ulen = info->perf_event.kprobe.name_len;
 	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
-					&type);
+					&type, &missed);
 	if (err)
 		return err;
 	if (type == BPF_FD_TYPE_KRETPROBE)
@@ -3425,6 +3426,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 		info->perf_event.type = BPF_PERF_EVENT_KPROBE;
 
 	info->perf_event.kprobe.offset = offset;
+	info->perf_event.kprobe.missed = missed;
 	if (!kallsyms_show_value(current_cred()))
 		addr = 0;
 	info->perf_event.kprobe.addr = addr;
@@ -3444,7 +3446,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 	uname = u64_to_user_ptr(info->perf_event.uprobe.file_name);
 	ulen = info->perf_event.uprobe.name_len;
 	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
-					&type);
+					&type, NULL);
 	if (err)
 		return err;
 
@@ -3480,7 +3482,7 @@ static int bpf_perf_link_fill_tracepoint(const struct perf_event *event,
 	uname = u64_to_user_ptr(info->perf_event.tracepoint.tp_name);
 	ulen = info->perf_event.tracepoint.name_len;
 	info->perf_event.type = BPF_PERF_EVENT_TRACEPOINT;
-	return bpf_perf_link_fill_common(event, uname, ulen, NULL, NULL, NULL);
+	return bpf_perf_link_fill_common(event, uname, ulen, NULL, NULL, NULL, NULL);
 }
 
 static int bpf_perf_link_fill_perf_event(const struct perf_event *event,
@@ -4813,7 +4815,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 
 		err = bpf_get_perf_event_info(event, &prog_id, &fd_type,
 					      &buf, &probe_offset,
-					      &probe_addr);
+					      &probe_addr, NULL);
 		if (!err)
 			err = bpf_task_fd_query_copy(attr, uattr, prog_id,
 						     fd_type, buf,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index aec52938c703..a9d8634b503c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2384,7 +2384,8 @@ int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
 
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
-			    u64 *probe_offset, u64 *probe_addr)
+			    u64 *probe_offset, u64 *probe_addr,
+			    unsigned long *missed)
 {
 	bool is_tracepoint, is_syscall_tp;
 	struct bpf_prog *prog;
@@ -2419,7 +2420,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 #ifdef CONFIG_KPROBE_EVENTS
 		if (flags & TRACE_EVENT_FL_KPROBE)
 			err = bpf_get_kprobe_info(event, fd_type, buf,
-						  probe_offset, probe_addr,
+						  probe_offset, probe_addr, missed,
 						  event->attr.type == PERF_TYPE_TRACEPOINT);
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3d7a180a8427..961a78ffd6d2 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1189,6 +1189,12 @@ static const struct file_operations kprobe_events_ops = {
 	.write		= probes_write,
 };
 
+static unsigned long trace_kprobe_missed(struct trace_kprobe *tk)
+{
+	return trace_kprobe_is_return(tk) ?
+		tk->rp.kp.nmissed + tk->rp.nmissed : tk->rp.kp.nmissed;
+}
+
 /* Probes profiling interfaces */
 static int probes_profile_seq_show(struct seq_file *m, void *v)
 {
@@ -1200,8 +1206,7 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
 		return 0;
 
 	tk = to_trace_kprobe(ev);
-	nmissed = trace_kprobe_is_return(tk) ?
-		tk->rp.kp.nmissed + tk->rp.nmissed : tk->rp.kp.nmissed;
+	nmissed = trace_kprobe_missed(tk);
 	seq_printf(m, "  %-44s %15lu %15lu\n",
 		   trace_probe_name(&tk->tp),
 		   trace_kprobe_nhit(tk),
@@ -1547,7 +1552,8 @@ NOKPROBE_SYMBOL(kretprobe_perf_func);
 
 int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 			const char **symbol, u64 *probe_offset,
-			u64 *probe_addr, bool perf_type_tracepoint)
+			u64 *probe_addr, unsigned long *missed,
+			bool perf_type_tracepoint)
 {
 	const char *pevent = trace_event_name(event->tp_event);
 	const char *group = event->tp_event->class->system;
@@ -1566,6 +1572,8 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 	*probe_addr = kallsyms_show_value(current_cred()) ?
 		      (unsigned long)tk->rp.kp.addr : 0;
 	*symbol = tk->symbol;
+	if (missed)
+		*missed = trace_kprobe_missed(tk);
 	return 0;
 }
 #endif	/* CONFIG_PERF_EVENTS */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e5216420ec73..e824b0c50425 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6546,6 +6546,7 @@ struct bpf_link_info {
 					__u32 name_len;
 					__u32 offset; /* offset from func_name */
 					__u64 addr;
+					__u64 missed;
 				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
 				struct {
 					__aligned_u64 tp_name;   /* in/out */
-- 
2.41.0


