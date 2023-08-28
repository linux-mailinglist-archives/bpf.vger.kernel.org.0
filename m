Return-Path: <bpf+bounces-8825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8FD78A6E1
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 09:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861C5280DC2
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 07:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C195710FE;
	Mon, 28 Aug 2023 07:56:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E60EC2
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 07:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8373BC433C8;
	Mon, 28 Aug 2023 07:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693209395;
	bh=V8aINqUzm9Pn3MLc0yPY3lvJpsGjw27deUR24pZn2/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F1jidHojXybgR0xOoXDJRz2srj5YB6xsf7tiSXYyfgEGfQMspo74HWSJl1z6o+6ya
	 XuqYBb56/wpisWAuMvUnYV91l1APcd6kNpD3xm3xKohNtUMAoF56HMSugdbrcztHZA
	 J55KtY6tZVFXcuSmIYdcEIeQBpbibfj8p7rgHZUai+7NaN5C1zHzu5wnNfH4gEocSA
	 9tgx0ggSrzoCtqil8rZDPlaAYQAhPMAnEqzvQ7ltQmn61clDwQ3as5j5k+z09bu2Nk
	 aNb/Gyy0TgQR/Tvw7IXwPFxAh0rvLh1aXxAIb5o9JG9rV9Vf5P93GLM9Xj/QrtzdaG
	 ccInSEv/ysP0Q==
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
Subject: [PATCH bpf-next 05/12] bpf: Add missed value to kprobe perf link info
Date: Mon, 28 Aug 2023 09:55:30 +0200
Message-ID: <20230828075537.194192-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828075537.194192-1-jolsa@kernel.org>
References: <20230828075537.194192-1-jolsa@kernel.org>
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
 kernel/trace/trace_kprobe.c    |  5 ++++-
 tools/include/uapi/linux/bpf.h |  1 +
 6 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5b85cf18c350..3917ddcf90bf 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -750,7 +750,8 @@ struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name);
 void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp);
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
-			    u64 *probe_offset, u64 *probe_addr);
+			    u64 *probe_offset, u64 *probe_addr,
+			    unsigned long *missed);
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 #else
@@ -790,7 +791,7 @@ static inline void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 static inline int bpf_get_perf_event_info(const struct perf_event *event,
 					  u32 *prog_id, u32 *fd_type,
 					  const char **buf, u64 *probe_offset,
-					  u64 *probe_addr)
+					  u64 *probe_addr, unsigned long *missed)
 {
 	return -EOPNOTSUPP;
 }
@@ -865,6 +866,7 @@ extern void perf_kprobe_destroy(struct perf_event *event);
 extern int bpf_get_kprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **symbol,
 			       u64 *probe_offset, u64 *probe_addr,
+			       unsigned long *missed,
 			       bool perf_type_tracepoint);
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b754edfb0cd7..5a39c7a13499 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6539,6 +6539,7 @@ struct bpf_link_info {
 					__u32 name_len;
 					__u32 offset; /* offset from func_name */
 					__u64 addr;
+					__u64 missed;
 				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
 				struct {
 					__aligned_u64 tp_name;   /* in/out */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5d39d98f5eb1..775aeb869cfb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3392,7 +3392,7 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
 static int bpf_perf_link_fill_common(const struct perf_event *event,
 				     char __user *uname, u32 ulen,
 				     u64 *probe_offset, u64 *probe_addr,
-				     u32 *fd_type)
+				     u32 *fd_type, unsigned long *missed)
 {
 	const char *buf;
 	u32 prog_id;
@@ -3403,7 +3403,7 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 		return -EINVAL;
 
 	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
-				      probe_offset, probe_addr);
+				      probe_offset, probe_addr, missed);
 	if (err)
 		return err;
 	if (!uname)
@@ -3426,6 +3426,7 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 				     struct bpf_link_info *info)
 {
+	unsigned long missed;
 	char __user *uname;
 	u64 addr, offset;
 	u32 ulen, type;
@@ -3434,7 +3435,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 	uname = u64_to_user_ptr(info->perf_event.kprobe.func_name);
 	ulen = info->perf_event.kprobe.name_len;
 	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
-					&type);
+					&type, &missed);
 	if (err)
 		return err;
 	if (type == BPF_FD_TYPE_KRETPROBE)
@@ -3443,6 +3444,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 		info->perf_event.type = BPF_PERF_EVENT_KPROBE;
 
 	info->perf_event.kprobe.offset = offset;
+	info->perf_event.kprobe.missed = missed;
 	if (!kallsyms_show_value(current_cred()))
 		addr = 0;
 	info->perf_event.kprobe.addr = addr;
@@ -3462,7 +3464,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 	uname = u64_to_user_ptr(info->perf_event.uprobe.file_name);
 	ulen = info->perf_event.uprobe.name_len;
 	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
-					&type);
+					&type, NULL);
 	if (err)
 		return err;
 
@@ -3498,7 +3500,7 @@ static int bpf_perf_link_fill_tracepoint(const struct perf_event *event,
 	uname = u64_to_user_ptr(info->perf_event.tracepoint.tp_name);
 	ulen = info->perf_event.tracepoint.name_len;
 	info->perf_event.type = BPF_PERF_EVENT_TRACEPOINT;
-	return bpf_perf_link_fill_common(event, uname, ulen, NULL, NULL, NULL);
+	return bpf_perf_link_fill_common(event, uname, ulen, NULL, NULL, NULL, NULL);
 }
 
 static int bpf_perf_link_fill_perf_event(const struct perf_event *event,
@@ -4831,7 +4833,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 
 		err = bpf_get_perf_event_info(event, &prog_id, &fd_type,
 					      &buf, &probe_offset,
-					      &probe_addr);
+					      &probe_addr, NULL);
 		if (!err)
 			err = bpf_task_fd_query_copy(attr, uattr, prog_id,
 						     fd_type, buf,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0eaec3c4a5fd..cde6360bf8e8 100644
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
index 17c21c0b2dd1..998c88874507 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1546,7 +1546,8 @@ NOKPROBE_SYMBOL(kretprobe_perf_func);
 
 int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 			const char **symbol, u64 *probe_offset,
-			u64 *probe_addr, bool perf_type_tracepoint)
+			u64 *probe_addr, unsigned long *missed,
+			bool perf_type_tracepoint)
 {
 	const char *pevent = trace_event_name(event->tp_event);
 	const char *group = event->tp_event->class->system;
@@ -1565,6 +1566,8 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 	*probe_addr = kallsyms_show_value(current_cred()) ?
 		      (unsigned long)tk->rp.kp.addr : 0;
 	*symbol = tk->symbol;
+	if (missed)
+		*missed = tk->rp.kp.nmissed;
 	return 0;
 }
 #endif	/* CONFIG_PERF_EVENTS */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b754edfb0cd7..5a39c7a13499 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6539,6 +6539,7 @@ struct bpf_link_info {
 					__u32 name_len;
 					__u32 offset; /* offset from func_name */
 					__u64 addr;
+					__u64 missed;
 				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
 				struct {
 					__aligned_u64 tp_name;   /* in/out */
-- 
2.41.0


