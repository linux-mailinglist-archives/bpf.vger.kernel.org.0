Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502A43D620E
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 18:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhGZPeE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 26 Jul 2021 11:34:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45484 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234611AbhGZPdo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Jul 2021 11:33:44 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QGDj7p028321
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 09:14:13 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a1ydj0f98-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 09:14:12 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 09:12:29 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 69BC53D405AD; Mon, 26 Jul 2021 09:12:24 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 bpf-next 05/14] bpf: allow to specify user-provided context value for BPF perf links
Date:   Mon, 26 Jul 2021 09:12:02 -0700
Message-ID: <20210726161211.925206-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726161211.925206-1-andrii@kernel.org>
References: <20210726161211.925206-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _HKXiwNuZG0RjujHFvhXIFSmf-o9wgfV
X-Proofpoint-GUID: _HKXiwNuZG0RjujHFvhXIFSmf-o9wgfV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_10:2021-07-26,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=951 clxscore=1034 adultscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260094
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add ability for users to specify custom u64 value when creating BPF link for
perf_event-backed BPF programs (kprobe/uprobe, perf_event, tracepoints).

This is useful for cases when the same BPF program is used for attaching and
processing invocation of different tracepoints/kprobes/uprobes in a generic
fashion, but such that each invocation is distinguished from each other (e.g.,
BPF program can look up additional information associated with a specific
kernel function without having to rely on function IP lookups). This enables
new use cases to be implemented simply and efficiently that previously were
possible only through code generation (and thus multiple instances of almost
identical BPF program) or compilation at runtime (BCC-style) on target hosts
(even more expensive resource-wise). For uprobes it is not even possible in
some cases to know function IP before hand (e.g., when attaching to shared
library without PID filtering, in which case base load address is not known
for a library).

This is done by storing u64 user_ctx in struct bpf_prog_array_item,
corresponding to each attached and run BPF program. Given cgroup BPF programs
already use 2 8-byte pointers for their needs and cgroup BPF programs don't
have (yet?) support for user_ctx, reuse that space through union of
cgroup_storage and new user_ctx field.

Make it available to kprobe/tracepoint BPF programs through bpf_trace_run_ctx.
This is set by BPF_PROG_RUN_ARRAY, used by kprobe/uprobe/tracepoint BPF
program execution code, which luckily is now also split from
BPF_PROG_RUN_ARRAY_CG. This run context will be utilized by a new BPF helper
giving access to this user context value from inside a BPF program. Generic
perf_event BPF programs will access this value from perf_event itself through
passed in BPF program context.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 drivers/media/rc/bpf-lirc.c    |  4 ++--
 include/linux/bpf.h            | 16 +++++++++++++++-
 include/linux/perf_event.h     |  1 +
 include/linux/trace_events.h   |  6 +++---
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/bpf/core.c              | 29 ++++++++++++++++++-----------
 kernel/bpf/syscall.c           |  2 +-
 kernel/events/core.c           | 21 ++++++++++++++-------
 kernel/trace/bpf_trace.c       |  8 +++++---
 tools/include/uapi/linux/bpf.h |  7 +++++++
 10 files changed, 73 insertions(+), 28 deletions(-)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index afae0afe3f81..7490494273e4 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -160,7 +160,7 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
 		goto unlock;
 	}
 
-	ret = bpf_prog_array_copy(old_array, NULL, prog, &new_array);
+	ret = bpf_prog_array_copy(old_array, NULL, prog, 0, &new_array);
 	if (ret < 0)
 		goto unlock;
 
@@ -193,7 +193,7 @@ static int lirc_bpf_detach(struct rc_dev *rcdev, struct bpf_prog *prog)
 	}
 
 	old_array = lirc_rcu_dereference(raw->progs);
-	ret = bpf_prog_array_copy(old_array, prog, NULL, &new_array);
+	ret = bpf_prog_array_copy(old_array, prog, NULL, 0, &new_array);
 	/*
 	 * Do not use bpf_prog_array_delete_safe() as we would end up
 	 * with a dummy entry in the array, and the we would free the
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9c44b56b698f..74b35faf0b73 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1114,7 +1114,10 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
  */
 struct bpf_prog_array_item {
 	struct bpf_prog *prog;
-	struct bpf_cgroup_storage *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
+	union {
+		struct bpf_cgroup_storage *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
+		u64 user_ctx;
+	};
 };
 
 struct bpf_prog_array {
@@ -1140,6 +1143,7 @@ int bpf_prog_array_copy_info(struct bpf_prog_array *array,
 int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			struct bpf_prog *exclude_prog,
 			struct bpf_prog *include_prog,
+			u64 include_user_ctx,
 			struct bpf_prog_array **new_array);
 
 struct bpf_run_ctx {};
@@ -1149,6 +1153,11 @@ struct bpf_cg_run_ctx {
 	const struct bpf_prog_array_item *prog_item;
 };
 
+struct bpf_trace_run_ctx {
+	struct bpf_run_ctx run_ctx;
+	u64 user_ctx;
+};
+
 #ifdef CONFIG_BPF_SYSCALL
 static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
 {
@@ -1247,6 +1256,8 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
 	const struct bpf_prog_array_item *item;
 	const struct bpf_prog *prog;
 	const struct bpf_prog_array *array;
+	struct bpf_run_ctx *old_run_ctx;
+	struct bpf_trace_run_ctx run_ctx;
 	u32 ret = 1;
 
 	migrate_disable();
@@ -1254,11 +1265,14 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
 	array = rcu_dereference(array_rcu);
 	if (unlikely(!array))
 		goto out;
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	item = &array->items[0];
 	while ((prog = READ_ONCE(item->prog))) {
+		run_ctx.user_ctx = item->user_ctx;
 		ret &= run_prog(prog, ctx);
 		item++;
 	}
+	bpf_reset_run_ctx(old_run_ctx);
 out:
 	rcu_read_unlock();
 	migrate_enable();
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2d510ad750ed..97ab46802800 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -762,6 +762,7 @@ struct perf_event {
 #ifdef CONFIG_BPF_SYSCALL
 	perf_overflow_handler_t		orig_overflow_handler;
 	struct bpf_prog			*prog;
+	u64				user_ctx;
 #endif
 
 #ifdef CONFIG_EVENT_TRACING
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 8ac92560d3a3..4543852f1480 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -675,7 +675,7 @@ trace_trigger_soft_disabled(struct trace_event_file *file)
 
 #ifdef CONFIG_BPF_EVENTS
 unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
-int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
+int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 user_ctx);
 void perf_event_detach_bpf_prog(struct perf_event *event);
 int perf_event_query_prog_array(struct perf_event *event, void __user *info);
 int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
@@ -692,7 +692,7 @@ static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *c
 }
 
 static inline int
-perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog)
+perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 user_ctx)
 {
 	return -EOPNOTSUPP;
 }
@@ -803,7 +803,7 @@ extern void ftrace_profile_free_filter(struct perf_event *event);
 void perf_trace_buf_update(void *record, u16 type);
 void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
 
-int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
+int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 user_ctx);
 void perf_event_free_bpf_prog(struct perf_event *event);
 
 void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 00b1267ab4f0..bc1fd54a8f58 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1448,6 +1448,13 @@ union bpf_attr {
 				__aligned_u64	iter_info;	/* extra bpf_iter_link_info */
 				__u32		iter_info_len;	/* iter_info length */
 			};
+			struct {
+				/* black box user-provided value passed through
+				 * to BPF program at the execution time and
+				 * accessible through bpf_get_user_ctx() BPF helper
+				 */
+				__u64		user_ctx;
+			} perf_event;
 		};
 	} link_create;
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9b1577498373..7e4c8bf3e8d1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2097,13 +2097,13 @@ int bpf_prog_array_update_at(struct bpf_prog_array *array, int index,
 int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			struct bpf_prog *exclude_prog,
 			struct bpf_prog *include_prog,
+			u64 include_user_ctx,
 			struct bpf_prog_array **new_array)
 {
 	int new_prog_cnt, carry_prog_cnt = 0;
-	struct bpf_prog_array_item *existing;
+	struct bpf_prog_array_item *existing, *new;
 	struct bpf_prog_array *array;
 	bool found_exclude = false;
-	int new_prog_idx = 0;
 
 	/* Figure out how many existing progs we need to carry over to
 	 * the new array.
@@ -2140,20 +2140,27 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 	array = bpf_prog_array_alloc(new_prog_cnt + 1, GFP_KERNEL);
 	if (!array)
 		return -ENOMEM;
+	new = array->items;
 
 	/* Fill in the new prog array */
 	if (carry_prog_cnt) {
 		existing = old_array->items;
-		for (; existing->prog; existing++)
-			if (existing->prog != exclude_prog &&
-			    existing->prog != &dummy_bpf_prog.prog) {
-				array->items[new_prog_idx++].prog =
-					existing->prog;
-			}
+		for (; existing->prog; existing++) {
+			if (existing->prog == exclude_prog ||
+			    existing->prog == &dummy_bpf_prog.prog)
+				continue;
+
+			new->prog = existing->prog;
+			new->user_ctx = existing->user_ctx;
+			new++;
+		}
 	}
-	if (include_prog)
-		array->items[new_prog_idx++].prog = include_prog;
-	array->items[new_prog_idx].prog = NULL;
+	if (include_prog) {
+		new->prog = include_prog;
+		new->user_ctx = include_user_ctx;
+		new++;
+	}
+	new->prog = NULL;
 	*new_array = array;
 	return 0;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 80c03bedd6e6..67f82d053935 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2963,7 +2963,7 @@ static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *pro
 	}
 
 	event = perf_file->private_data;
-	err = perf_event_set_bpf_prog(event, prog);
+	err = perf_event_set_bpf_prog(event, prog, attr->link_create.perf_event.user_ctx);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		goto out_put_file;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b125943599ce..3dcdf58290eb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5643,7 +5643,7 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 		if (IS_ERR(prog))
 			return PTR_ERR(prog);
 
-		err = perf_event_set_bpf_prog(event, prog);
+		err = perf_event_set_bpf_prog(event, prog, 0);
 		if (err) {
 			bpf_prog_put(prog);
 			return err;
@@ -9936,7 +9936,9 @@ static void bpf_overflow_handler(struct perf_event *event,
 	event->orig_overflow_handler(event, data, regs);
 }
 
-static int perf_event_set_bpf_handler(struct perf_event *event, struct bpf_prog *prog)
+static int perf_event_set_bpf_handler(struct perf_event *event,
+				      struct bpf_prog *prog,
+				      u64 user_ctx)
 {
 	if (event->overflow_handler_context)
 		/* hw breakpoint or kernel counter */
@@ -9966,6 +9968,7 @@ static int perf_event_set_bpf_handler(struct perf_event *event, struct bpf_prog
 	}
 
 	event->prog = prog;
+	event->user_ctx = user_ctx;
 	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
 	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
 	return 0;
@@ -9983,7 +9986,9 @@ static void perf_event_free_bpf_handler(struct perf_event *event)
 	bpf_prog_put(prog);
 }
 #else
-static int perf_event_set_bpf_handler(struct perf_event *event, struct bpf_prog *prog)
+static int perf_event_set_bpf_handler(struct perf_event *event,
+				      struct bpf_prog *prog,
+				      u64 user_ctx)
 {
 	return -EOPNOTSUPP;
 }
@@ -10011,12 +10016,13 @@ static inline bool perf_event_is_tracing(struct perf_event *event)
 	return false;
 }
 
-int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog)
+int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
+			    u64 user_ctx)
 {
 	bool is_kprobe, is_tracepoint, is_syscall_tp;
 
 	if (!perf_event_is_tracing(event))
-		return perf_event_set_bpf_handler(event, prog);
+		return perf_event_set_bpf_handler(event, prog, user_ctx);
 
 	is_kprobe = event->tp_event->flags & TRACE_EVENT_FL_UKPROBE;
 	is_tracepoint = event->tp_event->flags & TRACE_EVENT_FL_TRACEPOINT;
@@ -10042,7 +10048,7 @@ int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog)
 			return -EACCES;
 	}
 
-	return perf_event_attach_bpf_prog(event, prog);
+	return perf_event_attach_bpf_prog(event, prog, user_ctx);
 }
 
 void perf_event_free_bpf_prog(struct perf_event *event)
@@ -10064,7 +10070,8 @@ static void perf_event_free_filter(struct perf_event *event)
 {
 }
 
-int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog)
+int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
+			    u64 user_ctx)
 {
 	return -ENOENT;
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b427eac10780..c9cf6a0d0fb3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1674,7 +1674,8 @@ static DEFINE_MUTEX(bpf_event_mutex);
 #define BPF_TRACE_MAX_PROGS 64
 
 int perf_event_attach_bpf_prog(struct perf_event *event,
-			       struct bpf_prog *prog)
+			       struct bpf_prog *prog,
+			       u64 user_ctx)
 {
 	struct bpf_prog_array *old_array;
 	struct bpf_prog_array *new_array;
@@ -1701,12 +1702,13 @@ int perf_event_attach_bpf_prog(struct perf_event *event,
 		goto unlock;
 	}
 
-	ret = bpf_prog_array_copy(old_array, NULL, prog, &new_array);
+	ret = bpf_prog_array_copy(old_array, NULL, prog, user_ctx, &new_array);
 	if (ret < 0)
 		goto unlock;
 
 	/* set the new array to event->tp_event and set event->prog */
 	event->prog = prog;
+	event->user_ctx = user_ctx;
 	rcu_assign_pointer(event->tp_event->prog_array, new_array);
 	bpf_prog_array_free(old_array);
 
@@ -1727,7 +1729,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 		goto unlock;
 
 	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
-	ret = bpf_prog_array_copy(old_array, event->prog, NULL, &new_array);
+	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
 	if (ret == -ENOENT)
 		goto unlock;
 	if (ret < 0) {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 00b1267ab4f0..bc1fd54a8f58 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1448,6 +1448,13 @@ union bpf_attr {
 				__aligned_u64	iter_info;	/* extra bpf_iter_link_info */
 				__u32		iter_info_len;	/* iter_info length */
 			};
+			struct {
+				/* black box user-provided value passed through
+				 * to BPF program at the execution time and
+				 * accessible through bpf_get_user_ctx() BPF helper
+				 */
+				__u64		user_ctx;
+			} perf_event;
 		};
 	} link_create;
 
-- 
2.30.2

