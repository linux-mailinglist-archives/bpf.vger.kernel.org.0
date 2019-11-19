Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585A2102D15
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 20:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfKST5T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Nov 2019 14:57:19 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56590 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726722AbfKST5S (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 19 Nov 2019 14:57:18 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJJoO7t019764
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2019 11:57:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=/6BEGsHag1h2Cy3YiE75UEz/XF4GDU6yx+oFph8INho=;
 b=Uf73OJX8Cfbq/wjHZZIhv82Sk5qP/ABWpQRsb53jZ4eIn0vPhhAPVi//DVI06c00+1C5
 5O+GUNhe+/TWgLubRJo1QSlmvcohjos9W3aFUhTJo5ij/Llwj0+mJXFn4Ky0p6+JC7pe
 EhrMyCXSAJOhCtJJgWlpx5PckJl4Ducvo1E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wb1pfm1b8-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2019 11:57:16 -0800
Received: from 2401:db00:12:909f:face:0:3:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Nov 2019 11:57:13 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id E733D3702314; Tue, 19 Nov 2019 11:57:12 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 2/3] bpf: allow s32/u32 return types in verifier for bpf helpers
Date:   Tue, 19 Nov 2019 11:57:12 -0800
Message-ID: <20191119195712.3692027-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119195711.3691681-1-yhs@fb.com>
References: <20191119195711.3691681-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_06:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 suspectscore=13
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911190163
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, for all helpers with integer return type,
the verifier permits a single return type, RET_INTEGER,
which represents 64-bit return value from the helper,
and the verifier will assign 64-bit value ranges for these
return values. Such an assumption is different
from what compiler sees and the generated code with
llvm alu32 mode, and may lead verification failure.

For example, with latest llvm, selftest test_progs
failed for program raw_tracepoint/kfree_skb.
The source code looks like below:

  static __always_inline uint64_t read_str_var(...)
  {
    len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN, value->ptr);
    if (len > STROBE_MAX_STR_LEN)
      return 0;
    ...
    return len;
  }
  for (int i = 0; i < STROBE_MAX_STRS; ++i) {
    payload += read_str_var(cfg, i, tls_base, &value, data, payload);
  }

In the above, "cfg" refers to map "strobemeta_cfgs" and the signature
for bpf_probe_read_user_str() is:
 static int (*bpf_probe_read_user_str)(void *dst, __u32 size, const void *unsafe_ptr) = (void *) 114;
in tools/lib/bpf/bpf_helper_defs.h.

The code path causing verification failure looks like below:
  193: call bpf_probe_read_user_str
  194: if (w0 > 0x1) goto pc + 2
  195: *(u16 *)(r7 +80) = r0
  196: r6 = r0
  ...
  199: r8 = *(u64 *)(r10 -416)
  200: r8 += r6
  R1 unbounded memory access, make sure to bounds check any array access into a map

After insn 193, the current verifier assumes r0 can be any 64-bit value.
  R0=inv(id=0)
At insn 194, the compiler assumes bpf_probe_read_user_str() will return
  an __s32 value hences uses subregister w0 at insn 194 and at
  branch false target, the w0 range can be refined to unsigned values <= 1.
  But since insn 193 marks r0 with non-empty upper 32bit value, the new
  umax_value becomes 0xffffffff00000001.
  R0_w=inv(id=0,umax_value=18446744069414584321)
At insn 196, the register r0 is assigned to r6.
At insn 199, map pointer to strobemeta_cfgs map is restored and further refined
  at insn 200 and 201.
At insn 200, the verifier complains r8 + r6 unbounded memory access since r6 has
  R6_rw=invP(id=0,umax_value=18446744069414584321)

The pattern can be roughly described by the following steps:
  . helper return 32bit value, but return value marked conservatively.
  . sub-registeer w0 is refined.
  . r0 is used and the refined w0 range is lost.
  . later use of r0 may trigger some kind of unbound failure.

To remove such failure, r0 range at insn 193 should be more aligned with
what user expect based on function prototype in bpf_helper_defs.h, i.e.,
its value range should be with 32-bit value. This patches distinguished
32-bit from 64-bit return values in verifier with proper return value
ranges in r0. In the above case,
after insn 193, the verifier will give r0 range as
  R0_w=inv(id=0,smin_value=-2147483648,smax_value=2147483647,umax_value=4294967295,var_off=(0x0; 0xffffffff))
after insn 194, the new r0 range will be
  R0_w=inv(id=0,umax_value=1,var_off=(0x0; 0x1))
This better register range avoids above verification failure.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h      |  4 +++-
 include/linux/tnum.h     |  3 ++-
 kernel/bpf/helpers.c     |  8 ++++----
 kernel/bpf/tnum.c        |  3 ++-
 kernel/bpf/verifier.c    | 38 +++++++++++++++++++++++++++++++++-----
 kernel/trace/bpf_trace.c |  4 ++--
 net/core/filter.c        | 16 ++++++++--------
 7 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e913dd5946ae..a727706d1e3c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -224,7 +224,9 @@ enum bpf_arg_type {
 
 /* type of values returned from helper functions */
 enum bpf_return_type {
-	RET_INTEGER,			/* function returns integer */
+	RET_INTEGER = 0,		/* function returns s32/u32 */
+	RET_INT32 = 0,
+	RET_INT64 = 1,			/* function returns s64/u64 */
 	RET_VOID,			/* function doesn't return anything */
 	RET_PTR_TO_MAP_VALUE,		/* returns a pointer to map elem value */
 	RET_PTR_TO_MAP_VALUE_OR_NULL,	/* returns a pointer to map elem value or NULL */
diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index c17af77f3fae..0f11f3af9ec5 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -19,7 +19,8 @@ struct tnum {
 /* Constructors */
 /* Represent a known constant as a tnum. */
 struct tnum tnum_const(u64 value);
-/* A completely unknown value */
+/* Completely unknown 32-bit and 64-bit values */
+extern const struct tnum tnum_unknown32;
 extern const struct tnum tnum_unknown;
 /* A value that's unknown except that @min <= value <= @max */
 struct tnum tnum_range(u64 min, u64 max);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5e28718928ca..86c757a1801c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -149,7 +149,7 @@ BPF_CALL_0(bpf_ktime_get_ns)
 const struct bpf_func_proto bpf_ktime_get_ns_proto = {
 	.func		= bpf_ktime_get_ns,
 	.gpl_only	= true,
-	.ret_type	= RET_INTEGER,
+	.ret_type	= RET_INT64,
 };
 
 BPF_CALL_0(bpf_get_current_pid_tgid)
@@ -165,7 +165,7 @@ BPF_CALL_0(bpf_get_current_pid_tgid)
 const struct bpf_func_proto bpf_get_current_pid_tgid_proto = {
 	.func		= bpf_get_current_pid_tgid,
 	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
+	.ret_type	= RET_INT64,
 };
 
 BPF_CALL_0(bpf_get_current_uid_gid)
@@ -185,7 +185,7 @@ BPF_CALL_0(bpf_get_current_uid_gid)
 const struct bpf_func_proto bpf_get_current_uid_gid_proto = {
 	.func		= bpf_get_current_uid_gid,
 	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
+	.ret_type	= RET_INT64,
 };
 
 BPF_CALL_2(bpf_get_current_comm, char *, buf, u32, size)
@@ -323,7 +323,7 @@ BPF_CALL_0(bpf_get_current_cgroup_id)
 const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
 	.func		= bpf_get_current_cgroup_id,
 	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
+	.ret_type	= RET_INT64,
 };
 
 #ifdef CONFIG_CGROUP_BPF
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index ca52b9642943..7248e83adf45 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -10,7 +10,8 @@
 #include <linux/tnum.h>
 
 #define TNUM(_v, _m)	(struct tnum){.value = _v, .mask = _m}
-/* A completely unknown value */
+/* completely unknown 32-bit and 64-bit values */
+const struct tnum tnum_unknown32 = { .value = 0, .mask = 0xffffffffULL };
 const struct tnum tnum_unknown = { .value = 0, .mask = -1 };
 
 struct tnum tnum_const(u64 value)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a344b08aef77..945827351758 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1024,6 +1024,15 @@ static void __mark_reg_unbounded(struct bpf_reg_state *reg)
 	reg->umax_value = U64_MAX;
 }
 
+/* Reset the min/max bounds of a sub register */
+static void __mark_subreg_unbounded(struct bpf_reg_state *subreg)
+{
+	subreg->smin_value = S32_MIN;
+	subreg->smax_value = S32_MAX;
+	subreg->umin_value = 0;
+	subreg->umax_value = U32_MAX;
+}
+
 /* Mark a register as having a completely unknown (scalar) value. */
 static void __mark_reg_unknown(struct bpf_reg_state *reg)
 {
@@ -1038,6 +1047,20 @@ static void __mark_reg_unknown(struct bpf_reg_state *reg)
 	__mark_reg_unbounded(reg);
 }
 
+/* Mark a sub register as having a completely unknown (scalar) value. */
+static void __mark_subreg_unknown(struct bpf_reg_state *subreg)
+{
+	/*
+	 * Clear type, id, off, and union(map_ptr, range) and
+	 * padding between 'type' and union
+	 */
+	memset(subreg, 0, offsetof(struct bpf_reg_state, var_off));
+	subreg->type = SCALAR_VALUE;
+	subreg->var_off = tnum_unknown32;
+	subreg->frameno = 0;
+	__mark_subreg_unbounded(subreg);
+}
+
 static void mark_reg_unknown(struct bpf_verifier_env *env,
 			     struct bpf_reg_state *regs, u32 regno)
 {
@@ -4040,7 +4063,7 @@ static void do_refine_retval_range(struct bpf_reg_state *regs, int ret_type,
 {
 	struct bpf_reg_state *ret_reg = &regs[BPF_REG_0];
 
-	if (ret_type != RET_INTEGER ||
+	if ((ret_type != RET_INTEGER && ret_type != RET_INT64) ||
 	    (func_id != BPF_FUNC_get_stack &&
 	     func_id != BPF_FUNC_probe_read_str))
 		return;
@@ -4109,7 +4132,7 @@ static int check_reference_leak(struct bpf_verifier_env *env)
 static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn_idx)
 {
 	const struct bpf_func_proto *fn = NULL;
-	struct bpf_reg_state *regs;
+	struct bpf_reg_state *regs, *reg0;
 	struct bpf_call_arg_meta meta;
 	bool changes_data;
 	int i, err;
@@ -4210,13 +4233,18 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
 	}
 
-	/* helper call returns 64-bit value. */
-	regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
+	/* helper call returns 64-bit value internally. */
+	reg0 = regs + BPF_REG_0;
+	reg0->subreg_def = DEF_NOT_SUBREG;
 
 	/* update return register (already marked as written above) */
-	if (fn->ret_type == RET_INTEGER) {
+	if (fn->ret_type == RET_INT64) {
 		/* sets type to SCALAR_VALUE */
 		mark_reg_unknown(env, regs, BPF_REG_0);
+	} else if (fn->ret_type == RET_INTEGER) {
+		/* sets type to SCALAR_VALUE */
+		__mark_subreg_unknown(reg0);
+		__set_unknown_reg_precise(env, reg0);
 	} else if (fn->ret_type == RET_VOID) {
 		regs[BPF_REG_0].type = NOT_INIT;
 	} else if (fn->ret_type == RET_PTR_TO_MAP_VALUE_OR_NULL ||
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ffc91d4935ac..0bfce8499212 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -500,7 +500,7 @@ BPF_CALL_2(bpf_perf_event_read, struct bpf_map *, map, u64, flags)
 static const struct bpf_func_proto bpf_perf_event_read_proto = {
 	.func		= bpf_perf_event_read,
 	.gpl_only	= true,
-	.ret_type	= RET_INTEGER,
+	.ret_type	= RET_INT64,
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_ANYTHING,
 };
@@ -673,7 +673,7 @@ BPF_CALL_0(bpf_get_current_task)
 static const struct bpf_func_proto bpf_get_current_task_proto = {
 	.func		= bpf_get_current_task,
 	.gpl_only	= true,
-	.ret_type	= RET_INTEGER,
+	.ret_type	= RET_INT64,
 };
 
 BPF_CALL_2(bpf_current_task_under_cgroup, struct bpf_map *, map, u32, idx)
diff --git a/net/core/filter.c b/net/core/filter.c
index 49ded4a7588a..b9c45a986c73 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1998,7 +1998,7 @@ static const struct bpf_func_proto bpf_csum_diff_proto = {
 	.func		= bpf_csum_diff,
 	.gpl_only	= false,
 	.pkt_access	= true,
-	.ret_type	= RET_INTEGER,
+	.ret_type	= RET_INT64,
 	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_PTR_TO_MEM_OR_NULL,
@@ -2021,7 +2021,7 @@ BPF_CALL_2(bpf_csum_update, struct sk_buff *, skb, __wsum, csum)
 static const struct bpf_func_proto bpf_csum_update_proto = {
 	.func		= bpf_csum_update,
 	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
+	.ret_type	= RET_INT64,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 };
@@ -4108,7 +4108,7 @@ BPF_CALL_1(bpf_skb_cgroup_id, const struct sk_buff *, skb)
 static const struct bpf_func_proto bpf_skb_cgroup_id_proto = {
 	.func           = bpf_skb_cgroup_id,
 	.gpl_only       = false,
-	.ret_type       = RET_INTEGER,
+	.ret_type       = RET_INT64,
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
 
@@ -4133,7 +4133,7 @@ BPF_CALL_2(bpf_skb_ancestor_cgroup_id, const struct sk_buff *, skb, int,
 static const struct bpf_func_proto bpf_skb_ancestor_cgroup_id_proto = {
 	.func           = bpf_skb_ancestor_cgroup_id,
 	.gpl_only       = false,
-	.ret_type       = RET_INTEGER,
+	.ret_type       = RET_INT64,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
 };
@@ -4179,7 +4179,7 @@ BPF_CALL_1(bpf_get_socket_cookie, struct sk_buff *, skb)
 static const struct bpf_func_proto bpf_get_socket_cookie_proto = {
 	.func           = bpf_get_socket_cookie,
 	.gpl_only       = false,
-	.ret_type       = RET_INTEGER,
+	.ret_type       = RET_INT64,
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
 
@@ -4191,7 +4191,7 @@ BPF_CALL_1(bpf_get_socket_cookie_sock_addr, struct bpf_sock_addr_kern *, ctx)
 static const struct bpf_func_proto bpf_get_socket_cookie_sock_addr_proto = {
 	.func		= bpf_get_socket_cookie_sock_addr,
 	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
+	.ret_type	= RET_INT64,
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
@@ -4203,7 +4203,7 @@ BPF_CALL_1(bpf_get_socket_cookie_sock_ops, struct bpf_sock_ops_kern *, ctx)
 static const struct bpf_func_proto bpf_get_socket_cookie_sock_ops_proto = {
 	.func		= bpf_get_socket_cookie_sock_ops,
 	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
+	.ret_type	= RET_INT64,
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
@@ -5931,7 +5931,7 @@ static const struct bpf_func_proto bpf_tcp_gen_syncookie_proto = {
 	.func		= bpf_tcp_gen_syncookie,
 	.gpl_only	= true, /* __cookie_v*_init_sequence() is GPL */
 	.pkt_access	= true,
-	.ret_type	= RET_INTEGER,
+	.ret_type	= RET_INT64,
 	.arg1_type	= ARG_PTR_TO_SOCK_COMMON,
 	.arg2_type	= ARG_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
-- 
2.17.1

