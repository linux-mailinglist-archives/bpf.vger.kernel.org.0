Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAD3FFB55
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2019 19:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfKQS1J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 17 Nov 2019 13:27:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60876 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbfKQS1J (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 17 Nov 2019 13:27:09 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAHIDqEM015339
        for <bpf@vger.kernel.org>; Sun, 17 Nov 2019 10:27:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=y/mO7l1KwifivkHkPsa0hzTAZcTb37KBE4w8474O6OU=;
 b=eseuH6nOFXRb9gdNpewXA5EgOkhmgPLyj/M437/BZLicI2H/5Zhpw9N4n9g2o3vQ+AKX
 MIumNm6qGp5HYu6Cr3QlM7jic3wCngCB14zef98qbnRJrn1HfvdMoL3DGGdvNsoAZ1/5
 w0HLfQWZmVtMrsuTOE8/FfJJHDdenihLDYM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wb1pvk55m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 17 Nov 2019 10:27:07 -0800
Received: from 2401:db00:2050:5102:face:0:37:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 17 Nov 2019 10:27:06 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 598CF3701CA1; Sun, 17 Nov 2019 10:27:04 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 1/2] [bpf] allow s32/u32 return types in verifier for bpf helpers
Date:   Sun, 17 Nov 2019 10:27:04 -0800
Message-ID: <20191117182704.656659-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191117182704.656602-1-yhs@fb.com>
References: <20191117182704.656602-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-17_04:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 suspectscore=13 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911170175
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
 kernel/bpf/helpers.c     |  8 ++++----
 kernel/bpf/verifier.c    | 30 +++++++++++++++++++++++++++---
 kernel/trace/bpf_trace.c |  4 ++--
 net/core/filter.c        | 16 ++++++++--------
 5 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b81cde47314..3d074d96d923 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -220,7 +220,9 @@ enum bpf_arg_type {
 
 /* type of values returned from helper functions */
 enum bpf_return_type {
-	RET_INTEGER,			/* function returns integer */
+	RET_INTEGER = 0,		/* function returns s32/u32 */
+	RET_INT32 = 0,
+	RET_INT64 = 1,			/* function returns s64/u64 */
 	RET_VOID,			/* function doesn't return anything */
 	RET_PTR_TO_MAP_VALUE,		/* returns a pointer to map elem value */
 	RET_PTR_TO_MAP_VALUE_OR_NULL,	/* returns a pointer to map elem value or NULL */
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e9dc95a18d44..06d3ecaf3cf3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1047,6 +1047,30 @@ static void mark_reg_unknown(struct bpf_verifier_env *env,
 			true : false;
 }
 
+static void mark_ret_reg_unknown(struct bpf_verifier_env *env,
+				 struct bpf_reg_state *regs,
+				 enum bpf_return_type ret_type)
+{
+	struct bpf_reg_state *reg = regs + BPF_REG_0;
+
+	memset(reg, 0, offsetof(struct bpf_reg_state, var_off));
+	reg->type = SCALAR_VALUE;
+
+	if (ret_type == RET_INT64) {
+		reg->var_off.mask = -1;
+		__mark_reg_unbounded(reg);
+	} else {
+		reg->var_off.mask = 0xffffffffULL;
+		reg->smin_value = S32_MIN;
+		reg->smax_value = S32_MAX;
+		reg->umin_value = 0;
+		reg->umax_value = U32_MAX;
+	}
+
+	regs->precise = env->subprog_cnt > 1 || !env->allow_ptr_leaks ?
+			true : false;
+}
+
 static void __mark_reg_not_init(struct bpf_reg_state *reg)
 {
 	__mark_reg_unknown(reg);
@@ -4034,7 +4058,7 @@ static void do_refine_retval_range(struct bpf_reg_state *regs, int ret_type,
 {
 	struct bpf_reg_state *ret_reg = &regs[BPF_REG_0];
 
-	if (ret_type != RET_INTEGER ||
+	if ((ret_type != RET_INTEGER && ret_type != RET_INT64) ||
 	    (func_id != BPF_FUNC_get_stack &&
 	     func_id != BPF_FUNC_probe_read_str))
 		return;
@@ -4208,9 +4232,9 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 	regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
 
 	/* update return register (already marked as written above) */
-	if (fn->ret_type == RET_INTEGER) {
+	if (fn->ret_type == RET_INTEGER || fn->ret_type == RET_INT64) {
 		/* sets type to SCALAR_VALUE */
-		mark_reg_unknown(env, regs, BPF_REG_0);
+		mark_ret_reg_unknown(env, regs, fn->ret_type);
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

