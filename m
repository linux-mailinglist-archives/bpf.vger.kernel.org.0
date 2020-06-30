Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D7A20EE83
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 08:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgF3GbS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 02:31:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22272 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729984AbgF3GbS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Jun 2020 02:31:18 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U6VBSd006290
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 23:31:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=czk4m9xAeijPvlOb9z7rWYdAgWaJCjtM7IBktGe2EGY=;
 b=J0kZTUJyU6PlO3cc26dipCFdtpmh7f2/Bgr/XutJk82XFE78OlZh+9ssQPCLpXOAnyQR
 AdQy4W5t61acWKujlLmM8tf4AoQykiQuDaByOA1cjIjvAJZQ2gcC8vhi8x6viFVpfArw
 nowxe3OxLJEIUzE/WMUePwjX1YZwzwFcxVY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31x3mmk0q3-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 23:31:15 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 29 Jun 2020 23:31:06 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 7B84762E5211; Mon, 29 Jun 2020 23:28:53 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@chromium.org>, Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 bpf-next 2/4] bpf: introduce helper bpf_get_task_stack()
Date:   Mon, 29 Jun 2020 23:28:44 -0700
Message-ID: <20200630062846.664389-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630062846.664389-1-songliubraving@fb.com>
References: <20200630062846.664389-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_01:2020-06-30,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 cotscore=-2147483648 spamscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=9
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006300048
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce helper bpf_get_task_stack(), which dumps stack trace of given
task. This is different to bpf_get_stack(), which gets stack track of
current task. One potential use case of bpf_get_task_stack() is to call
it from bpf_iter__task and dump all /proc/<pid>/stack to a seq_file.

bpf_get_task_stack() uses stack_trace_save_tsk() instead of
get_perf_callchain() for kernel stack. The benefit of this choice is that
stack_trace_save_tsk() doesn't require changes in arch/. The downside of
using stack_trace_save_tsk() is that stack_trace_save_tsk() dumps the
stack trace to unsigned long array. For 32-bit systems, we need to
translate it to u64 array.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       | 36 +++++++++++++++-
 kernel/bpf/stackmap.c          | 77 ++++++++++++++++++++++++++++++++--
 kernel/bpf/verifier.c          |  4 +-
 kernel/trace/bpf_trace.c       |  2 +
 scripts/bpf_helpers_doc.py     |  2 +
 tools/include/uapi/linux/bpf.h | 36 +++++++++++++++-
 7 files changed, 151 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3d2ade703a357..0cd7f6884c5cd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1627,6 +1627,7 @@ extern const struct bpf_func_proto bpf_get_current_=
uid_gid_proto;
 extern const struct bpf_func_proto bpf_get_current_comm_proto;
 extern const struct bpf_func_proto bpf_get_stackid_proto;
 extern const struct bpf_func_proto bpf_get_stack_proto;
+extern const struct bpf_func_proto bpf_get_task_stack_proto;
 extern const struct bpf_func_proto bpf_sock_map_update_proto;
 extern const struct bpf_func_proto bpf_sock_hash_update_proto;
 extern const struct bpf_func_proto bpf_get_current_cgroup_id_proto;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0cb8ec9488168..cefb78a77d928 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3285,6 +3285,39 @@ union bpf_attr {
  *		Dynamically cast a *sk* pointer to a *udp6_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or NULL otherwise.
+ *
+ * long bpf_get_task_stack(struct task_struct *task, void *buf, u32 size=
, u64 flags)
+ *	Description
+ *		Return a user or a kernel stack in bpf program provided buffer.
+ *		To achieve this, the helper needs *task*, which is a valid
+ *		pointer to struct task_struct. To store the stacktrace, the
+ *		bpf program provides *buf* with	a nonnegative *size*.
+ *
+ *		The last argument, *flags*, holds the number of stack frames to
+ *		skip (from 0 to 255), masked with
+ *		**BPF_F_SKIP_FIELD_MASK**. The next bits can be used to set
+ *		the following flags:
+ *
+ *		**BPF_F_USER_STACK**
+ *			Collect a user space stack instead of a kernel stack.
+ *		**BPF_F_USER_BUILD_ID**
+ *			Collect buildid+offset instead of ips for user stack,
+ *			only valid if **BPF_F_USER_STACK** is also specified.
+ *
+ *		**bpf_get_task_stack**\ () can collect up to
+ *		**PERF_MAX_STACK_DEPTH** both kernel and user frames, subject
+ *		to sufficient large buffer size. Note that
+ *		this limit can be controlled with the **sysctl** program, and
+ *		that it should be manually increased in order to profile long
+ *		user stacks (such as stacks for Java programs). To do so, use:
+ *
+ *		::
+ *
+ *			# sysctl kernel.perf_event_max_stack=3D<new value>
+ *	Return
+ *		A non-negative value equal to or less than *size* on success,
+ *		or a negative error in case of failure.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3427,7 +3460,8 @@ union bpf_attr {
 	FN(skc_to_tcp_sock),		\
 	FN(skc_to_tcp_timewait_sock),	\
 	FN(skc_to_tcp_request_sock),	\
-	FN(skc_to_udp6_sock),
+	FN(skc_to_udp6_sock),		\
+	FN(get_task_stack),
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
  * function eBPF program intends to call
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 27dc9b1b08a52..0ba66b29ef227 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -348,6 +348,40 @@ static void stack_map_get_build_id_offset(struct bpf=
_stack_build_id *id_offs,
 	}
 }
=20
+static struct perf_callchain_entry *
+get_callchain_entry_for_task(struct task_struct *task, u32 init_nr)
+{
+	struct perf_callchain_entry *entry;
+	int rctx;
+
+	entry =3D get_callchain_entry(&rctx);
+
+	if (!entry)
+		return NULL;
+
+	entry->nr =3D init_nr +
+		stack_trace_save_tsk(task, (unsigned long *)(entry->ip + init_nr),
+				     sysctl_perf_event_max_stack - init_nr, 0);
+
+	/* stack_trace_save_tsk() works on unsigned long array, while
+	 * perf_callchain_entry uses u64 array. For 32-bit systems, it is
+	 * necessary to fix this mismatch.
+	 */
+	if (__BITS_PER_LONG !=3D 64) {
+		unsigned long *from =3D (unsigned long *) entry->ip;
+		u64 *to =3D entry->ip;
+		int i;
+
+		/* copy data from the end to avoid using extra buffer */
+		for (i =3D entry->nr - 1; i >=3D (int)init_nr; i--)
+			to[i] =3D (u64)(from[i]);
+	}
+
+	put_callchain_entry(rctx);
+
+	return entry;
+}
+
 BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, ma=
p,
 	   u64, flags)
 {
@@ -448,8 +482,8 @@ const struct bpf_func_proto bpf_get_stackid_proto =3D=
 {
 	.arg3_type	=3D ARG_ANYTHING,
 };
=20
-BPF_CALL_4(bpf_get_stack, struct pt_regs *, regs, void *, buf, u32, size=
,
-	   u64, flags)
+static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *ta=
sk,
+			    void *buf, u32 size, u64 flags)
 {
 	u32 init_nr, trace_nr, copy_len, elem_size, num_elem;
 	bool user_build_id =3D flags & BPF_F_USER_BUILD_ID;
@@ -471,13 +505,22 @@ BPF_CALL_4(bpf_get_stack, struct pt_regs *, regs, v=
oid *, buf, u32, size,
 	if (unlikely(size % elem_size))
 		goto clear;
=20
+	/* cannot get valid user stack for task without user_mode regs */
+	if (task && user && !user_mode(regs))
+		goto err_fault;
+
 	num_elem =3D size / elem_size;
 	if (sysctl_perf_event_max_stack < num_elem)
 		init_nr =3D 0;
 	else
 		init_nr =3D sysctl_perf_event_max_stack - num_elem;
-	trace =3D get_perf_callchain(regs, init_nr, kernel, user,
-				   sysctl_perf_event_max_stack, false, false);
+
+	if (kernel && task)
+		trace =3D get_callchain_entry_for_task(task, init_nr);
+	else
+		trace =3D get_perf_callchain(regs, init_nr, kernel, user,
+					   sysctl_perf_event_max_stack,
+					   false, false);
 	if (unlikely(!trace))
 		goto err_fault;
=20
@@ -505,6 +548,12 @@ BPF_CALL_4(bpf_get_stack, struct pt_regs *, regs, vo=
id *, buf, u32, size,
 	return err;
 }
=20
+BPF_CALL_4(bpf_get_stack, struct pt_regs *, regs, void *, buf, u32, size=
,
+	   u64, flags)
+{
+	return __bpf_get_stack(regs, NULL, buf, size, flags);
+}
+
 const struct bpf_func_proto bpf_get_stack_proto =3D {
 	.func		=3D bpf_get_stack,
 	.gpl_only	=3D true,
@@ -515,6 +564,26 @@ const struct bpf_func_proto bpf_get_stack_proto =3D =
{
 	.arg4_type	=3D ARG_ANYTHING,
 };
=20
+BPF_CALL_4(bpf_get_task_stack, struct task_struct *, task, void *, buf,
+	   u32, size, u64, flags)
+{
+	struct pt_regs *regs =3D task_pt_regs(task);
+
+	return __bpf_get_stack(regs, task, buf, size, flags);
+}
+
+static int bpf_get_task_stack_btf_ids[5];
+const struct bpf_func_proto bpf_get_task_stack_proto =3D {
+	.func		=3D bpf_get_task_stack,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_BTF_ID,
+	.arg2_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	=3D ARG_CONST_SIZE_OR_ZERO,
+	.arg4_type	=3D ARG_ANYTHING,
+	.btf_id		=3D bpf_get_task_stack_btf_ids,
+};
+
 /* Called from eBPF program */
 static void *stack_map_lookup_elem(struct bpf_map *map, void *key)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7de98906ddf4a..b608185e1ffd5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4864,7 +4864,9 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, int func_id, int insn
 	if (err)
 		return err;
=20
-	if (func_id =3D=3D BPF_FUNC_get_stack && !env->prog->has_callchain_buf)=
 {
+	if ((func_id =3D=3D BPF_FUNC_get_stack ||
+	     func_id =3D=3D BPF_FUNC_get_task_stack) &&
+	    !env->prog->has_callchain_buf) {
 		const char *err_str;
=20
 #ifdef CONFIG_PERF_EVENTS
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5d59dda5f6615..977ba3b6f6c64 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1137,6 +1137,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 		return &bpf_ringbuf_query_proto;
 	case BPF_FUNC_jiffies64:
 		return &bpf_jiffies64_proto;
+	case BPF_FUNC_get_task_stack:
+		return &bpf_get_task_stack_proto;
 	default:
 		return NULL;
 	}
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 6bab40ff442e8..6843376733df8 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -426,6 +426,7 @@ class PrinterHelpers(Printer):
             'struct tcp_timewait_sock',
             'struct tcp_request_sock',
             'struct udp6_sock',
+            'struct task_struct',
=20
             'struct __sk_buff',
             'struct sk_msg_md',
@@ -468,6 +469,7 @@ class PrinterHelpers(Printer):
             'struct tcp_timewait_sock',
             'struct tcp_request_sock',
             'struct udp6_sock',
+            'struct task_struct',
     }
     mapped_types =3D {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 0cb8ec9488168..cefb78a77d928 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3285,6 +3285,39 @@ union bpf_attr {
  *		Dynamically cast a *sk* pointer to a *udp6_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or NULL otherwise.
+ *
+ * long bpf_get_task_stack(struct task_struct *task, void *buf, u32 size=
, u64 flags)
+ *	Description
+ *		Return a user or a kernel stack in bpf program provided buffer.
+ *		To achieve this, the helper needs *task*, which is a valid
+ *		pointer to struct task_struct. To store the stacktrace, the
+ *		bpf program provides *buf* with	a nonnegative *size*.
+ *
+ *		The last argument, *flags*, holds the number of stack frames to
+ *		skip (from 0 to 255), masked with
+ *		**BPF_F_SKIP_FIELD_MASK**. The next bits can be used to set
+ *		the following flags:
+ *
+ *		**BPF_F_USER_STACK**
+ *			Collect a user space stack instead of a kernel stack.
+ *		**BPF_F_USER_BUILD_ID**
+ *			Collect buildid+offset instead of ips for user stack,
+ *			only valid if **BPF_F_USER_STACK** is also specified.
+ *
+ *		**bpf_get_task_stack**\ () can collect up to
+ *		**PERF_MAX_STACK_DEPTH** both kernel and user frames, subject
+ *		to sufficient large buffer size. Note that
+ *		this limit can be controlled with the **sysctl** program, and
+ *		that it should be manually increased in order to profile long
+ *		user stacks (such as stacks for Java programs). To do so, use:
+ *
+ *		::
+ *
+ *			# sysctl kernel.perf_event_max_stack=3D<new value>
+ *	Return
+ *		A non-negative value equal to or less than *size* on success,
+ *		or a negative error in case of failure.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3427,7 +3460,8 @@ union bpf_attr {
 	FN(skc_to_tcp_sock),		\
 	FN(skc_to_tcp_timewait_sock),	\
 	FN(skc_to_tcp_request_sock),	\
-	FN(skc_to_udp6_sock),
+	FN(skc_to_udp6_sock),		\
+	FN(get_task_stack),
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
  * function eBPF program intends to call
--=20
2.24.1

