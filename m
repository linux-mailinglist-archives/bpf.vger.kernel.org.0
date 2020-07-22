Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66138229F73
	for <lists+bpf@lfdr.de>; Wed, 22 Jul 2020 20:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbgGVSpJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jul 2020 14:45:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36768 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732488AbgGVSo7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Jul 2020 14:44:59 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06MIZJSM000766
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 11:44:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kLiRNkzTf0D6xXXE4xYsJFN1/otcpDPBRxMJPlWMO1k=;
 b=SyzWyYKxzV+TF3gkjg3wzsnmg5wuJTMd26e/3f6YHqTW67Jpg6+FN9Q+v5oYqfuXCqTc
 by9eMGnhYV/adr+9xJ7liUHyi8pS3qY/zZuKXhX/muLFDeMDzYSQpYBcII59PbCSSr8U
 nL/tP+7PBW3DQEp85cp6lLqSRi+yAGO1iwc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32esyurd4m-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 11:44:57 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 11:44:56 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id DADC062E4E7F; Wed, 22 Jul 2020 11:42:15 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <brouer@redhat.com>, <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 bpf-next 1/4] bpf: separate bpf_get_[stack|stackid] for perf events BPF
Date:   Wed, 22 Jul 2020 11:42:07 -0700
Message-ID: <20200722184210.4078256-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200722184210.4078256-1-songliubraving@fb.com>
References: <20200722184210.4078256-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_10:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220119
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Calling get_perf_callchain() on perf_events from PEBS entries may cause
unwinder errors. To fix this issue, the callchain is fetched early. Such
perf_events are marked with __PERF_SAMPLE_CALLCHAIN_EARLY.

Similarly, calling bpf_get_[stack|stackid] on perf_events from PEBS may
also cause unwinder errors. To fix this, add separate version of these
two helpers, bpf_get_[stack|stackid]_pe. These two hepers use callchain i=
n
bpf_perf_event_data_kern->data->callchain.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/bpf.h      |   2 +
 kernel/bpf/stackmap.c    | 184 +++++++++++++++++++++++++++++++++++----
 kernel/trace/bpf_trace.c |   4 +-
 3 files changed, 170 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bae557ff2da8b..70e34a0ebbac6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1644,6 +1644,8 @@ extern const struct bpf_func_proto bpf_get_current_=
comm_proto;
 extern const struct bpf_func_proto bpf_get_stackid_proto;
 extern const struct bpf_func_proto bpf_get_stack_proto;
 extern const struct bpf_func_proto bpf_get_task_stack_proto;
+extern const struct bpf_func_proto bpf_get_stackid_proto_pe;
+extern const struct bpf_func_proto bpf_get_stack_proto_pe;
 extern const struct bpf_func_proto bpf_sock_map_update_proto;
 extern const struct bpf_func_proto bpf_sock_hash_update_proto;
 extern const struct bpf_func_proto bpf_get_current_cgroup_id_proto;
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 48d8e739975fa..5beb2f8c23da1 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -4,6 +4,7 @@
 #include <linux/bpf.h>
 #include <linux/jhash.h>
 #include <linux/filter.h>
+#include <linux/kernel.h>
 #include <linux/stacktrace.h>
 #include <linux/perf_event.h>
 #include <linux/elf.h>
@@ -387,11 +388,10 @@ get_callchain_entry_for_task(struct task_struct *ta=
sk, u32 init_nr)
 #endif
 }
=20
-BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, ma=
p,
-	   u64, flags)
+static long __bpf_get_stackid(struct bpf_map *map,
+			      struct perf_callchain_entry *trace, u64 flags)
 {
 	struct bpf_stack_map *smap =3D container_of(map, struct bpf_stack_map, =
map);
-	struct perf_callchain_entry *trace;
 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
 	u32 max_depth =3D map->value_size / stack_map_data_size(map);
 	/* stack_map_alloc() checks that max_depth <=3D sysctl_perf_event_max_s=
tack */
@@ -399,21 +399,9 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, =
struct bpf_map *, map,
 	u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
 	u32 hash, id, trace_nr, trace_len;
 	bool user =3D flags & BPF_F_USER_STACK;
-	bool kernel =3D !user;
 	u64 *ips;
 	bool hash_matches;
=20
-	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
-			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
-		return -EINVAL;
-
-	trace =3D get_perf_callchain(regs, init_nr, kernel, user,
-				   sysctl_perf_event_max_stack, false, false);
-
-	if (unlikely(!trace))
-		/* couldn't fetch the stack trace */
-		return -EFAULT;
-
 	/* get_perf_callchain() guarantees that trace->nr >=3D init_nr
 	 * and trace-nr <=3D sysctl_perf_event_max_stack, so trace_nr <=3D max_=
depth
 	 */
@@ -478,6 +466,30 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, =
struct bpf_map *, map,
 	return id;
 }
=20
+BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, ma=
p,
+	   u64, flags)
+{
+	u32 max_depth =3D map->value_size / stack_map_data_size(map);
+	/* stack_map_alloc() checks that max_depth <=3D sysctl_perf_event_max_s=
tack */
+	u32 init_nr =3D sysctl_perf_event_max_stack - max_depth;
+	bool user =3D flags & BPF_F_USER_STACK;
+	struct perf_callchain_entry *trace;
+	bool kernel =3D !user;
+
+	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
+			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
+		return -EINVAL;
+
+	trace =3D get_perf_callchain(regs, init_nr, kernel, user,
+				   sysctl_perf_event_max_stack, false, false);
+
+	if (unlikely(!trace))
+		/* couldn't fetch the stack trace */
+		return -EFAULT;
+
+	return __bpf_get_stackid(map, trace, flags);
+}
+
 const struct bpf_func_proto bpf_get_stackid_proto =3D {
 	.func		=3D bpf_get_stackid,
 	.gpl_only	=3D true,
@@ -487,7 +499,77 @@ const struct bpf_func_proto bpf_get_stackid_proto =3D=
 {
 	.arg3_type	=3D ARG_ANYTHING,
 };
=20
+static __u64 count_kernel_ip(struct perf_callchain_entry *trace)
+{
+	__u64 nr_kernel =3D 0;
+
+	while (nr_kernel < trace->nr) {
+		if (trace->ip[nr_kernel] =3D=3D PERF_CONTEXT_USER)
+			break;
+		nr_kernel++;
+	}
+	return nr_kernel;
+}
+
+BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
+	   struct bpf_map *, map, u64, flags)
+{
+	struct perf_event *event =3D ctx->event;
+	struct perf_callchain_entry *trace;
+	bool kernel, user;
+	__u64 nr_kernel;
+	int ret;
+
+	/* perf_sample_data doesn't have callchain, use bpf_get_stackid */
+	if (!(event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
+		return bpf_get_stackid((unsigned long)(ctx->regs),
+				       (unsigned long) map, flags, 0, 0);
+
+	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
+			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
+		return -EINVAL;
+
+	user =3D flags & BPF_F_USER_STACK;
+	kernel =3D !user;
+
+	trace =3D ctx->data->callchain;
+	if (unlikely(!trace))
+		return -EFAULT;
+
+	nr_kernel =3D count_kernel_ip(trace);
+
+	if (kernel) {
+		__u64 nr =3D trace->nr;
+
+		trace->nr =3D nr_kernel;
+		ret =3D __bpf_get_stackid(map, trace, flags);
+
+		/* restore nr */
+		trace->nr =3D nr;
+	} else { /* user */
+		u64 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
+
+		skip +=3D nr_kernel;
+		if (skip > BPF_F_SKIP_FIELD_MASK)
+			return -EFAULT;
+
+		flags =3D (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
+		ret =3D __bpf_get_stackid(map, trace, flags);
+	}
+	return ret;
+}
+
+const struct bpf_func_proto bpf_get_stackid_proto_pe =3D {
+	.func		=3D bpf_get_stackid_pe,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_CTX,
+	.arg2_type	=3D ARG_CONST_MAP_PTR,
+	.arg3_type	=3D ARG_ANYTHING,
+};
+
 static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *ta=
sk,
+			    struct perf_callchain_entry *trace_in,
 			    void *buf, u32 size, u64 flags)
 {
 	u32 init_nr, trace_nr, copy_len, elem_size, num_elem;
@@ -520,7 +602,9 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
 	else
 		init_nr =3D sysctl_perf_event_max_stack - num_elem;
=20
-	if (kernel && task)
+	if (trace_in)
+		trace =3D trace_in;
+	else if (kernel && task)
 		trace =3D get_callchain_entry_for_task(task, init_nr);
 	else
 		trace =3D get_perf_callchain(regs, init_nr, kernel, user,
@@ -556,7 +640,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
 BPF_CALL_4(bpf_get_stack, struct pt_regs *, regs, void *, buf, u32, size=
,
 	   u64, flags)
 {
-	return __bpf_get_stack(regs, NULL, buf, size, flags);
+	return __bpf_get_stack(regs, NULL, NULL, buf, size, flags);
 }
=20
 const struct bpf_func_proto bpf_get_stack_proto =3D {
@@ -574,7 +658,7 @@ BPF_CALL_4(bpf_get_task_stack, struct task_struct *, =
task, void *, buf,
 {
 	struct pt_regs *regs =3D task_pt_regs(task);
=20
-	return __bpf_get_stack(regs, task, buf, size, flags);
+	return __bpf_get_stack(regs, task, NULL, buf, size, flags);
 }
=20
 BTF_ID_LIST(bpf_get_task_stack_btf_ids)
@@ -591,6 +675,70 @@ const struct bpf_func_proto bpf_get_task_stack_proto=
 =3D {
 	.btf_id		=3D bpf_get_task_stack_btf_ids,
 };
=20
+BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
+	   void *, buf, u32, size, u64, flags)
+{
+	struct perf_event *event =3D ctx->event;
+	struct perf_callchain_entry *trace;
+	bool kernel, user;
+	int err =3D -EINVAL;
+	__u64 nr_kernel;
+
+	if (!(event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
+		return __bpf_get_stack(ctx->regs, NULL, NULL, buf, size, flags);
+
+	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
+			       BPF_F_USER_BUILD_ID)))
+		goto clear;
+
+	user =3D flags & BPF_F_USER_STACK;
+	kernel =3D !user;
+
+	err =3D -EFAULT;
+	trace =3D ctx->data->callchain;
+	if (unlikely(!trace))
+		goto clear;
+
+	nr_kernel =3D count_kernel_ip(trace);
+
+	if (kernel) {
+		__u64 nr =3D trace->nr;
+
+		trace->nr =3D nr_kernel;
+		err =3D __bpf_get_stack(ctx->regs, NULL, trace, buf,
+				      size, flags);
+
+		/* restore nr */
+		trace->nr =3D nr;
+	} else { /* user */
+		u64 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
+
+		skip +=3D nr_kernel;
+		if (skip > BPF_F_SKIP_FIELD_MASK)
+			goto clear;
+
+		flags =3D (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
+		err =3D __bpf_get_stack(ctx->regs, NULL, trace, buf,
+				      size, flags);
+	}
+	return err;
+
+clear:
+	memset(buf, 0, size);
+	return err;
+
+}
+
+const struct bpf_func_proto bpf_get_stack_proto_pe =3D {
+	.func		=3D bpf_get_stack_pe,
+	.gpl_only	=3D true,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_CTX,
+	.arg2_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	=3D ARG_CONST_SIZE_OR_ZERO,
+	.arg4_type	=3D ARG_ANYTHING,
+};
+
 /* Called from eBPF program */
 static void *stack_map_lookup_elem(struct bpf_map *map, void *key)
 {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3cc0dcb60ca20..cb91ef902cc43 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1411,9 +1411,9 @@ pe_prog_func_proto(enum bpf_func_id func_id, const =
struct bpf_prog *prog)
 	case BPF_FUNC_perf_event_output:
 		return &bpf_perf_event_output_proto_tp;
 	case BPF_FUNC_get_stackid:
-		return &bpf_get_stackid_proto_tp;
+		return &bpf_get_stackid_proto_pe;
 	case BPF_FUNC_get_stack:
-		return &bpf_get_stack_proto_tp;
+		return &bpf_get_stack_proto_pe;
 	case BPF_FUNC_perf_prog_read_value:
 		return &bpf_perf_prog_read_value_proto;
 	case BPF_FUNC_read_branch_records:
--=20
2.24.1

