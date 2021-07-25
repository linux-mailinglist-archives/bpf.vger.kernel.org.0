Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1667C3D4F2E
	for <lists+bpf@lfdr.de>; Sun, 25 Jul 2021 19:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGYRBD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 25 Jul 2021 13:01:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59570 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhGYRBC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 25 Jul 2021 13:01:02 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16PHXWma007506
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 10:41:33 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a0j67w615-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 10:41:32 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Jul 2021 10:41:30 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 2ACB73D405B3; Sun, 25 Jul 2021 10:39:01 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH bpf-next 03/14] bpf: refactor perf_event_set_bpf_prog() to use struct bpf_prog input
Date:   Sun, 25 Jul 2021 10:38:34 -0700
Message-ID: <20210725173845.2593626-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210725173845.2593626-1-andrii@kernel.org>
References: <20210725173845.2593626-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: s7HuSI6QIRCF-oUpeVcOa9ThV7MX0rh6
X-Proofpoint-GUID: s7HuSI6QIRCF-oUpeVcOa9ThV7MX0rh6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-25_05:2021-07-23,2021-07-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 malwarescore=0 mlxscore=0 clxscore=1015 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107250126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make internal perf_event_set_bpf_prog() use struct bpf_prog pointer as an
input argument, which makes it easier to re-use for other internal uses
(coming up for BPF link in the next patch). BPF program FD is not as
convenient and in some cases it's not available. So switch to struct bpf_prog,
move out refcounting outside and let caller do bpf_prog_put() in case of an
error. This follows the approach of most of the other BPF internal functions.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/core.c | 61 ++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 464917096e73..bf4689403498 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5574,7 +5574,7 @@ static inline int perf_fget_light(int fd, struct fd *p)
 static int perf_event_set_output(struct perf_event *event,
 				 struct perf_event *output_event);
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
-static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
+static int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
 
@@ -5637,7 +5637,22 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 		return perf_event_set_filter(event, (void __user *)arg);
 
 	case PERF_EVENT_IOC_SET_BPF:
-		return perf_event_set_bpf_prog(event, arg);
+	{
+		struct bpf_prog *prog;
+		int err;
+
+		prog = bpf_prog_get(arg);
+		if (IS_ERR(prog))
+			return PTR_ERR(prog);
+
+		err = perf_event_set_bpf_prog(event, prog);
+		if (err) {
+			bpf_prog_put(prog);
+			return err;
+		}
+
+		return 0;
+	}
 
 	case PERF_EVENT_IOC_PAUSE_OUTPUT: {
 		struct perf_buffer *rb;
@@ -9923,10 +9938,8 @@ static void bpf_overflow_handler(struct perf_event *event,
 	event->orig_overflow_handler(event, data, regs);
 }
 
-static int perf_event_set_bpf_handler(struct perf_event *event, u32 prog_fd)
+static int perf_event_set_bpf_handler(struct perf_event *event, struct bpf_prog *prog)
 {
-	struct bpf_prog *prog;
-
 	if (event->overflow_handler_context)
 		/* hw breakpoint or kernel counter */
 		return -EINVAL;
@@ -9934,9 +9947,8 @@ static int perf_event_set_bpf_handler(struct perf_event *event, u32 prog_fd)
 	if (event->prog)
 		return -EEXIST;
 
-	prog = bpf_prog_get_type(prog_fd, BPF_PROG_TYPE_PERF_EVENT);
-	if (IS_ERR(prog))
-		return PTR_ERR(prog);
+	if (prog->type != BPF_PROG_TYPE_PERF_EVENT)
+		return -EINVAL;
 
 	if (event->attr.precise_ip &&
 	    prog->call_get_stack &&
@@ -9952,7 +9964,6 @@ static int perf_event_set_bpf_handler(struct perf_event *event, u32 prog_fd)
 		 * attached to perf_sample_data, do not allow attaching BPF
 		 * program that calls bpf_get_[stack|stackid].
 		 */
-		bpf_prog_put(prog);
 		return -EPROTO;
 	}
 
@@ -9974,7 +9985,7 @@ static void perf_event_free_bpf_handler(struct perf_event *event)
 	bpf_prog_put(prog);
 }
 #else
-static int perf_event_set_bpf_handler(struct perf_event *event, u32 prog_fd)
+static int perf_event_set_bpf_handler(struct perf_event *event, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;
 }
@@ -10002,14 +10013,12 @@ static inline bool perf_event_is_tracing(struct perf_event *event)
 	return false;
 }
 
-static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd)
+static int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog)
 {
 	bool is_kprobe, is_tracepoint, is_syscall_tp;
-	struct bpf_prog *prog;
-	int ret;
 
 	if (!perf_event_is_tracing(event))
-		return perf_event_set_bpf_handler(event, prog_fd);
+		return perf_event_set_bpf_handler(event, prog);
 
 	is_kprobe = event->tp_event->flags & TRACE_EVENT_FL_UKPROBE;
 	is_tracepoint = event->tp_event->flags & TRACE_EVENT_FL_TRACEPOINT;
@@ -10018,38 +10027,24 @@ static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd)
 		/* bpf programs can only be attached to u/kprobe or tracepoint */
 		return -EINVAL;
 
-	prog = bpf_prog_get(prog_fd);
-	if (IS_ERR(prog))
-		return PTR_ERR(prog);
-
 	if ((is_kprobe && prog->type != BPF_PROG_TYPE_KPROBE) ||
 	    (is_tracepoint && prog->type != BPF_PROG_TYPE_TRACEPOINT) ||
-	    (is_syscall_tp && prog->type != BPF_PROG_TYPE_TRACEPOINT)) {
-		/* valid fd, but invalid bpf program type */
-		bpf_prog_put(prog);
+	    (is_syscall_tp && prog->type != BPF_PROG_TYPE_TRACEPOINT))
 		return -EINVAL;
-	}
 
 	/* Kprobe override only works for kprobes, not uprobes. */
 	if (prog->kprobe_override &&
-	    !(event->tp_event->flags & TRACE_EVENT_FL_KPROBE)) {
-		bpf_prog_put(prog);
+	    !(event->tp_event->flags & TRACE_EVENT_FL_KPROBE))
 		return -EINVAL;
-	}
 
 	if (is_tracepoint || is_syscall_tp) {
 		int off = trace_event_get_offsets(event->tp_event);
 
-		if (prog->aux->max_ctx_offset > off) {
-			bpf_prog_put(prog);
+		if (prog->aux->max_ctx_offset > off)
 			return -EACCES;
-		}
 	}
 
-	ret = perf_event_attach_bpf_prog(event, prog);
-	if (ret)
-		bpf_prog_put(prog);
-	return ret;
+	return perf_event_attach_bpf_prog(event, prog);
 }
 
 static void perf_event_free_bpf_prog(struct perf_event *event)
@@ -10071,7 +10066,7 @@ static void perf_event_free_filter(struct perf_event *event)
 {
 }
 
-static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd)
+static int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog)
 {
 	return -ENOENT;
 }
-- 
2.30.2

