Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2973EC7CC
	for <lists+bpf@lfdr.de>; Sun, 15 Aug 2021 09:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhHOHG4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 15 Aug 2021 03:06:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30394 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233937AbhHOHGy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 15 Aug 2021 03:06:54 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17F76MPr018493
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:25 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ae95qc58c-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:24 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 15 Aug 2021 00:06:19 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id B6B173D405A0; Sun, 15 Aug 2021 00:06:18 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v5 bpf-next 04/16] bpf: implement minimal BPF perf link
Date:   Sun, 15 Aug 2021 00:05:57 -0700
Message-ID: <20210815070609.987780-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210815070609.987780-1-andrii@kernel.org>
References: <20210815070609.987780-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: bjlXZDfwL69hA6c_ABK4CExKCcyKGmu7
X-Proofpoint-ORIG-GUID: bjlXZDfwL69hA6c_ABK4CExKCcyKGmu7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-15_02:2021-08-13,2021-08-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108150049
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce a new type of BPF link - BPF perf link. This brings perf_event-based
BPF program attachments (perf_event, tracepoints, kprobes, and uprobes) into
the common BPF link infrastructure, allowing to list all active perf_event
based attachments, auto-detaching BPF program from perf_event when link's FD
is closed, get generic BPF link fdinfo/get_info functionality.

BPF_LINK_CREATE command expects perf_event's FD as target_fd. No extra flags
are currently supported.

Force-detaching and atomic BPF program updates are not yet implemented, but
with perf_event-based BPF links we now have common framework for this without
the need to extend ioctl()-based perf_event interface.

One interesting consideration is a new value for bpf_attach_type, which
BPF_LINK_CREATE command expects. Generally, it's either 1-to-1 mapping from
bpf_attach_type to bpf_prog_type, or many-to-1 mapping from a subset of
bpf_attach_types to one bpf_prog_type (e.g., see BPF_PROG_TYPE_SK_SKB or
BPF_PROG_TYPE_CGROUP_SOCK). In this case, though, we have three different
program types (KPROBE, TRACEPOINT, PERF_EVENT) using the same perf_event-based
mechanism, so it's many bpf_prog_types to one bpf_attach_type. I chose to
define a single BPF_PERF_EVENT attach type for all of them and adjust
link_create()'s logic for checking correspondence between attach type and
program type.

The alternative would be to define three new attach types (e.g., BPF_KPROBE,
BPF_TRACEPOINT, and BPF_PERF_EVENT), but that seemed like unnecessary overkill
and BPF_KPROBE will cause naming conflicts with BPF_KPROBE() macro, defined by
libbpf. I chose to not do this to avoid unnecessary proliferation of
bpf_attach_type enum values and not have to deal with naming conflicts.

Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_types.h      |   3 +
 include/linux/trace_events.h   |   3 +
 include/uapi/linux/bpf.h       |   2 +
 kernel/bpf/syscall.c           | 105 ++++++++++++++++++++++++++++++---
 kernel/events/core.c           |  10 ++--
 tools/include/uapi/linux/bpf.h |   2 +
 6 files changed, 112 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index ae3ac3a2018c..9c81724e4b98 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -136,3 +136,6 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
 BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
 BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
 #endif
+#ifdef CONFIG_PERF_EVENTS
+BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
+#endif
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index ad413b382a3c..8ac92560d3a3 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -803,6 +803,9 @@ extern void ftrace_profile_free_filter(struct perf_event *event);
 void perf_trace_buf_update(void *record, u16 type);
 void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
 
+int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
+void perf_event_free_bpf_prog(struct perf_event *event);
+
 void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
 void bpf_trace_run2(struct bpf_prog *prog, u64 arg1, u64 arg2);
 void bpf_trace_run3(struct bpf_prog *prog, u64 arg1, u64 arg2,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2db6925e04f4..94fe8329b28f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -993,6 +993,7 @@ enum bpf_attach_type {
 	BPF_SK_SKB_VERDICT,
 	BPF_SK_REUSEPORT_SELECT,
 	BPF_SK_REUSEPORT_SELECT_OR_MIGRATE,
+	BPF_PERF_EVENT,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1006,6 +1007,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_ITER = 4,
 	BPF_LINK_TYPE_NETNS = 5,
 	BPF_LINK_TYPE_XDP = 6,
+	BPF_LINK_TYPE_PERF_EVENT = 7,
 
 	MAX_BPF_LINK_TYPE,
 };
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9a2068e39d23..80c03bedd6e6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2906,6 +2906,79 @@ static const struct bpf_link_ops bpf_raw_tp_link_lops = {
 	.fill_link_info = bpf_raw_tp_link_fill_link_info,
 };
 
+#ifdef CONFIG_PERF_EVENTS
+struct bpf_perf_link {
+	struct bpf_link link;
+	struct file *perf_file;
+};
+
+static void bpf_perf_link_release(struct bpf_link *link)
+{
+	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
+	struct perf_event *event = perf_link->perf_file->private_data;
+
+	perf_event_free_bpf_prog(event);
+	fput(perf_link->perf_file);
+}
+
+static void bpf_perf_link_dealloc(struct bpf_link *link)
+{
+	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
+
+	kfree(perf_link);
+}
+
+static const struct bpf_link_ops bpf_perf_link_lops = {
+	.release = bpf_perf_link_release,
+	.dealloc = bpf_perf_link_dealloc,
+};
+
+static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	struct bpf_link_primer link_primer;
+	struct bpf_perf_link *link;
+	struct perf_event *event;
+	struct file *perf_file;
+	int err;
+
+	if (attr->link_create.flags)
+		return -EINVAL;
+
+	perf_file = perf_event_get(attr->link_create.target_fd);
+	if (IS_ERR(perf_file))
+		return PTR_ERR(perf_file);
+
+	link = kzalloc(sizeof(*link), GFP_USER);
+	if (!link) {
+		err = -ENOMEM;
+		goto out_put_file;
+	}
+	bpf_link_init(&link->link, BPF_LINK_TYPE_PERF_EVENT, &bpf_perf_link_lops, prog);
+	link->perf_file = perf_file;
+
+	err = bpf_link_prime(&link->link, &link_primer);
+	if (err) {
+		kfree(link);
+		goto out_put_file;
+	}
+
+	event = perf_file->private_data;
+	err = perf_event_set_bpf_prog(event, prog);
+	if (err) {
+		bpf_link_cleanup(&link_primer);
+		goto out_put_file;
+	}
+	/* perf_event_set_bpf_prog() doesn't take its own refcnt on prog */
+	bpf_prog_inc(prog);
+
+	return bpf_link_settle(&link_primer);
+
+out_put_file:
+	fput(perf_file);
+	return err;
+}
+#endif /* CONFIG_PERF_EVENTS */
+
 #define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.prog_fd
 
 static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
@@ -4147,15 +4220,26 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	if (ret)
 		goto out;
 
-	if (prog->type == BPF_PROG_TYPE_EXT) {
+	switch (prog->type) {
+	case BPF_PROG_TYPE_EXT:
 		ret = tracing_bpf_link_attach(attr, uattr, prog);
 		goto out;
-	}
-
-	ptype = attach_type_to_prog_type(attr->link_create.attach_type);
-	if (ptype == BPF_PROG_TYPE_UNSPEC || ptype != prog->type) {
-		ret = -EINVAL;
-		goto out;
+	case BPF_PROG_TYPE_PERF_EVENT:
+	case BPF_PROG_TYPE_KPROBE:
+	case BPF_PROG_TYPE_TRACEPOINT:
+		if (attr->link_create.attach_type != BPF_PERF_EVENT) {
+			ret = -EINVAL;
+			goto out;
+		}
+		ptype = prog->type;
+		break;
+	default:
+		ptype = attach_type_to_prog_type(attr->link_create.attach_type);
+		if (ptype == BPF_PROG_TYPE_UNSPEC || ptype != prog->type) {
+			ret = -EINVAL;
+			goto out;
+		}
+		break;
 	}
 
 	switch (ptype) {
@@ -4179,6 +4263,13 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_PROG_TYPE_XDP:
 		ret = bpf_xdp_link_attach(attr, prog);
 		break;
+#endif
+#ifdef CONFIG_PERF_EVENTS
+	case BPF_PROG_TYPE_PERF_EVENT:
+	case BPF_PROG_TYPE_TRACEPOINT:
+	case BPF_PROG_TYPE_KPROBE:
+		ret = bpf_perf_link_attach(attr, prog);
+		break;
 #endif
 	default:
 		ret = -EINVAL;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2f07718bd41c..9fd65667bcb2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4697,7 +4697,6 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 }
 
 static void perf_event_free_filter(struct perf_event *event);
-static void perf_event_free_bpf_prog(struct perf_event *event);
 
 static void free_event_rcu(struct rcu_head *head)
 {
@@ -5574,7 +5573,6 @@ static inline int perf_fget_light(int fd, struct fd *p)
 static int perf_event_set_output(struct perf_event *event,
 				 struct perf_event *output_event);
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
-static int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
 
@@ -10013,7 +10011,7 @@ static inline bool perf_event_is_tracing(struct perf_event *event)
 	return false;
 }
 
-static int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog)
+int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog)
 {
 	bool is_kprobe, is_tracepoint, is_syscall_tp;
 
@@ -10047,7 +10045,7 @@ static int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *pr
 	return perf_event_attach_bpf_prog(event, prog);
 }
 
-static void perf_event_free_bpf_prog(struct perf_event *event)
+void perf_event_free_bpf_prog(struct perf_event *event)
 {
 	if (!perf_event_is_tracing(event)) {
 		perf_event_free_bpf_handler(event);
@@ -10066,12 +10064,12 @@ static void perf_event_free_filter(struct perf_event *event)
 {
 }
 
-static int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog)
+int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog)
 {
 	return -ENOENT;
 }
 
-static void perf_event_free_bpf_prog(struct perf_event *event)
+void perf_event_free_bpf_prog(struct perf_event *event)
 {
 }
 #endif /* CONFIG_EVENT_TRACING */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2db6925e04f4..94fe8329b28f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -993,6 +993,7 @@ enum bpf_attach_type {
 	BPF_SK_SKB_VERDICT,
 	BPF_SK_REUSEPORT_SELECT,
 	BPF_SK_REUSEPORT_SELECT_OR_MIGRATE,
+	BPF_PERF_EVENT,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1006,6 +1007,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_ITER = 4,
 	BPF_LINK_TYPE_NETNS = 5,
 	BPF_LINK_TYPE_XDP = 6,
+	BPF_LINK_TYPE_PERF_EVENT = 7,
 
 	MAX_BPF_LINK_TYPE,
 };
-- 
2.30.2

