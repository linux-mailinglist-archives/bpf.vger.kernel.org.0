Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4BE21C199
	for <lists+bpf@lfdr.de>; Sat, 11 Jul 2020 03:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgGKB3e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jul 2020 21:29:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40056 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727017AbgGKB3e (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Jul 2020 21:29:34 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 06B1TTga002741
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 18:29:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=qp2hoE/pqt0LGBJIrpJTXfBycOk0rkspQzKcnnz52Fg=;
 b=aD0KwEIQROStMf1PqCsxRkgxmLI7Ey06q84JmutVneC+UNIsEq6Aa5p9w5OSmGEm8A8J
 ByPO8Gh9WERAt+VSYPV5TikqbmBrIzSxpB4AS20Bk10a7M7MA/AzV87ZioI8dgdTNm7e
 pmuHjBYGrEx04apGpB6ZCkBk/3N154ZOCec= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 325k2un5y8-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 18:29:31 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 10 Jul 2020 18:29:02 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 2004062E51F8; Fri, 10 Jul 2020 18:26:56 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/5] bpf: introduce bpf_get_callchain_stackid
Date:   Fri, 10 Jul 2020 18:26:37 -0700
Message-ID: <20200711012639.3429622-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200711012639.3429622-1-songliubraving@fb.com>
References: <20200711012639.3429622-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_14:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007110007
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This helper is only used by BPF program attached to perf_event. If the
perf_event has PEBS entries, calling get_perf_callchain from BPF program
may cause unwinder errors. bpf_get_callchain_stackid serves as alternativ=
e
to bpf_get_stackid for these BPF programs.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       | 43 +++++++++++++++++++++++
 kernel/bpf/stackmap.c          | 63 ++++++++++++++++++++++++++--------
 kernel/bpf/verifier.c          |  4 ++-
 kernel/trace/bpf_trace.c       |  2 ++
 scripts/bpf_helpers_doc.py     |  2 ++
 tools/include/uapi/linux/bpf.h | 43 +++++++++++++++++++++++
 7 files changed, 142 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0cd7f6884c5cd..45cf12acb0e26 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1628,6 +1628,7 @@ extern const struct bpf_func_proto bpf_get_current_=
comm_proto;
 extern const struct bpf_func_proto bpf_get_stackid_proto;
 extern const struct bpf_func_proto bpf_get_stack_proto;
 extern const struct bpf_func_proto bpf_get_task_stack_proto;
+extern const struct bpf_func_proto bpf_get_callchain_stackid_proto;
 extern const struct bpf_func_proto bpf_sock_map_update_proto;
 extern const struct bpf_func_proto bpf_sock_hash_update_proto;
 extern const struct bpf_func_proto bpf_get_current_cgroup_id_proto;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 548a749aebb3e..a808accfbd457 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3319,6 +3319,48 @@ union bpf_attr {
  *		A non-negative value equal to or less than *size* on success,
  *		or a negative error in case of failure.
  *
+ * long bpf_get_callchain_stackid(struct perf_callchain_entry *callchain=
, struct bpf_map *map, u64 flags)
+ *	Description
+ *		Walk a user or a kernel stack and return its id. To achieve
+ *		this, the helper needs *callchain*, which is a pointer to a
+ *		valid perf_callchain_entry, and a pointer to a *map* of type
+ *		**BPF_MAP_TYPE_STACK_TRACE**.
+ *
+ *		The last argument, *flags*, holds the number of stack frames to
+ *		skip (from 0 to 255), masked with
+ *		**BPF_F_SKIP_FIELD_MASK**. The next bits can be used to set
+ *		a combination of the following flags:
+ *
+ *		**BPF_F_USER_STACK**
+ *			Collect a user space stack instead of a kernel stack.
+ *		**BPF_F_FAST_STACK_CMP**
+ *			Compare stacks by hash only.
+ *		**BPF_F_REUSE_STACKID**
+ *			If two different stacks hash into the same *stackid*,
+ *			discard the old one.
+ *
+ *		The stack id retrieved is a 32 bit long integer handle which
+ *		can be further combined with other data (including other stack
+ *		ids) and used as a key into maps. This can be useful for
+ *		generating a variety of graphs (such as flame graphs or off-cpu
+ *		graphs).
+ *
+ *		For walking a stack, this helper is an improvement over
+ *		**bpf_probe_read**\ (), which can be used with unrolled loops
+ *		but is not efficient and consumes a lot of eBPF instructions.
+ *		Instead, **bpf_get_callchain_stackid**\ () can collect up to
+ *		**PERF_MAX_STACK_DEPTH** both kernel and user frames. Note that
+ *		this limit can be controlled with the **sysctl** program, and
+ *		that it should be manually increased in order to profile long
+ *		user stacks (such as stacks for Java programs). To do so, use:
+ *
+ *		::
+ *
+ *			# sysctl kernel.perf_event_max_stack=3D<new value>
+ *	Return
+ *		The positive or null stack id on success, or a negative error
+ *		in case of failure.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3463,6 +3505,7 @@ union bpf_attr {
 	FN(skc_to_tcp_request_sock),	\
 	FN(skc_to_udp6_sock),		\
 	FN(get_task_stack),		\
+	FN(get_callchain_stackid),	\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index a6c361ed7937b..28acc610f7f94 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -386,11 +386,10 @@ get_callchain_entry_for_task(struct task_struct *ta=
sk, u32 init_nr)
 #endif
 }
=20
-BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, ma=
p,
-	   u64, flags)
+static long __bpf_get_stackid(struct bpf_map *map, struct perf_callchain=
_entry *trace,
+			      u64 flags)
 {
 	struct bpf_stack_map *smap =3D container_of(map, struct bpf_stack_map, =
map);
-	struct perf_callchain_entry *trace;
 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
 	u32 max_depth =3D map->value_size / stack_map_data_size(map);
 	/* stack_map_alloc() checks that max_depth <=3D sysctl_perf_event_max_s=
tack */
@@ -398,21 +397,9 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, =
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
@@ -477,6 +464,30 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, =
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
@@ -486,6 +497,28 @@ const struct bpf_func_proto bpf_get_stackid_proto =3D=
 {
 	.arg3_type	=3D ARG_ANYTHING,
 };
=20
+BPF_CALL_3(bpf_get_callchain_stackid, struct perf_callchain_entry *, cal=
lchain,
+	   struct bpf_map *, map, u64, flags)
+{
+	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
+			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
+		return -EINVAL;
+	if (!callchain)
+		return -EFAULT;
+	return __bpf_get_stackid(map, callchain, flags);
+}
+
+static int bpf_get_callchain_stackid_btf_ids[5];
+const struct bpf_func_proto bpf_get_callchain_stackid_proto =3D {
+	.func		=3D bpf_get_callchain_stackid,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_BTF_ID,
+	.arg2_type	=3D ARG_CONST_MAP_PTR,
+	.arg3_type	=3D ARG_ANYTHING,
+	.btf_id		=3D bpf_get_callchain_stackid_btf_ids,
+};
+
 static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *ta=
sk,
 			    void *buf, u32 size, u64 flags)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1e11b0f6fba31..07be75550ca93 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4094,7 +4094,8 @@ static int check_map_func_compatibility(struct bpf_=
verifier_env *env,
 			goto error;
 		break;
 	case BPF_MAP_TYPE_STACK_TRACE:
-		if (func_id !=3D BPF_FUNC_get_stackid)
+		if (func_id !=3D BPF_FUNC_get_stackid &&
+		    func_id !=3D BPF_FUNC_get_callchain_stackid)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_CGROUP_ARRAY:
@@ -4187,6 +4188,7 @@ static int check_map_func_compatibility(struct bpf_=
verifier_env *env,
 			goto error;
 		break;
 	case BPF_FUNC_get_stackid:
+	case BPF_FUNC_get_callchain_stackid:
 		if (map->map_type !=3D BPF_MAP_TYPE_STACK_TRACE)
 			goto error;
 		break;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c014846c2723c..7a504f734a025 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1396,6 +1396,8 @@ pe_prog_func_proto(enum bpf_func_id func_id, const =
struct bpf_prog *prog)
 		return &bpf_perf_prog_read_value_proto;
 	case BPF_FUNC_read_branch_records:
 		return &bpf_read_branch_records_proto;
+	case BPF_FUNC_get_callchain_stackid:
+		return &bpf_get_callchain_stackid_proto;
 	default:
 		return bpf_tracing_func_proto(func_id, prog);
 	}
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 6843376733df8..1b99e3618e492 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -427,6 +427,7 @@ class PrinterHelpers(Printer):
             'struct tcp_request_sock',
             'struct udp6_sock',
             'struct task_struct',
+            'struct perf_callchain_entry',
=20
             'struct __sk_buff',
             'struct sk_msg_md',
@@ -470,6 +471,7 @@ class PrinterHelpers(Printer):
             'struct tcp_request_sock',
             'struct udp6_sock',
             'struct task_struct',
+            'struct perf_callchain_entry',
     }
     mapped_types =3D {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 548a749aebb3e..a808accfbd457 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3319,6 +3319,48 @@ union bpf_attr {
  *		A non-negative value equal to or less than *size* on success,
  *		or a negative error in case of failure.
  *
+ * long bpf_get_callchain_stackid(struct perf_callchain_entry *callchain=
, struct bpf_map *map, u64 flags)
+ *	Description
+ *		Walk a user or a kernel stack and return its id. To achieve
+ *		this, the helper needs *callchain*, which is a pointer to a
+ *		valid perf_callchain_entry, and a pointer to a *map* of type
+ *		**BPF_MAP_TYPE_STACK_TRACE**.
+ *
+ *		The last argument, *flags*, holds the number of stack frames to
+ *		skip (from 0 to 255), masked with
+ *		**BPF_F_SKIP_FIELD_MASK**. The next bits can be used to set
+ *		a combination of the following flags:
+ *
+ *		**BPF_F_USER_STACK**
+ *			Collect a user space stack instead of a kernel stack.
+ *		**BPF_F_FAST_STACK_CMP**
+ *			Compare stacks by hash only.
+ *		**BPF_F_REUSE_STACKID**
+ *			If two different stacks hash into the same *stackid*,
+ *			discard the old one.
+ *
+ *		The stack id retrieved is a 32 bit long integer handle which
+ *		can be further combined with other data (including other stack
+ *		ids) and used as a key into maps. This can be useful for
+ *		generating a variety of graphs (such as flame graphs or off-cpu
+ *		graphs).
+ *
+ *		For walking a stack, this helper is an improvement over
+ *		**bpf_probe_read**\ (), which can be used with unrolled loops
+ *		but is not efficient and consumes a lot of eBPF instructions.
+ *		Instead, **bpf_get_callchain_stackid**\ () can collect up to
+ *		**PERF_MAX_STACK_DEPTH** both kernel and user frames. Note that
+ *		this limit can be controlled with the **sysctl** program, and
+ *		that it should be manually increased in order to profile long
+ *		user stacks (such as stacks for Java programs). To do so, use:
+ *
+ *		::
+ *
+ *			# sysctl kernel.perf_event_max_stack=3D<new value>
+ *	Return
+ *		The positive or null stack id on success, or a negative error
+ *		in case of failure.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3463,6 +3505,7 @@ union bpf_attr {
 	FN(skc_to_tcp_request_sock),	\
 	FN(skc_to_udp6_sock),		\
 	FN(get_task_stack),		\
+	FN(get_callchain_stackid),	\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.24.1

