Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AC7524738
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 09:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351134AbiELHnp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 03:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351130AbiELHno (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 03:43:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736AA1A15FA
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:43 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BMwZQu022821
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=1MX0HXf45SnWQTxzBfsIP7e6Kx4r5QDLBkFORamDFjs=;
 b=jVKfpV1t5WhmjRArcdd7yqHSIuf6JPJcNtGNhkas7IVdlaW5pTo1BYc7kEGsTwgsJr+I
 DYWMQzlm3adjevhMo5YNIpGdsvav8JpMyqGvYcneO7DtKi6DOxFOplK+/ATNcLtfP5X3
 6r77p9DK5rDKequkxkVsA7unKdlUS9ka4Vw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g055hrmew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:42 -0700
Received: from twshared41237.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 00:43:41 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 85F9478F7CC7; Thu, 12 May 2022 00:43:28 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 2/5] bpf: add get_reg_val helper
Date:   Thu, 12 May 2022 00:43:18 -0700
Message-ID: <20220512074321.2090073-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220512074321.2090073-1-davemarchevsky@fb.com>
References: <20220512074321.2090073-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CpYuH_LKPXXCS_xWA1SwyhtsYEU0WVuO
X-Proofpoint-GUID: CpYuH_LKPXXCS_xWA1SwyhtsYEU0WVuO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_01,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a helper which reads the value of specified register into memory.

Currently, bpf programs only have access to general-purpose registers
via struct pt_regs. Other registers, like SSE regs %xmm0-15, are
inaccessible, which makes some tracing usecases impossible. For example,
User Statically-Defined Tracing (USDT) probes may use SSE registers to
pass their arguments on x86. While this patch adds support for %xmm0-15
only, the helper is meant to be generic enough to support fetching any
reg.

A useful "value of register" definition for bpf programs is "value of
register before control transfer to kernel". pt_regs gives us this
currently, so it's the default behavior of the new helper. Fetching the
actual _current_ reg value is possible, though, by passing
BPF_GETREG_F_CURRENT flag as part of input.

For SSE regs we try to avoid digging around in task's fpu state by first
reading _current_ value, then checking to see if the state of cpu's
floating point regs matches task's view of them. If so, we can just
return _current_ value.

Further usecases which are straightforward to support, but
unimplemented:
  * using the helper to fetch general-purpose register value.
  currently-unused pt_regs parameter exists for this reason.

  * fetching rdtsc (w/ BPF_GETREG_F_CURRENT)

  * other architectures. s390 specifically might benefit from similar
  fpu reg fetching as USDT library was recently updated to support that
  architecture.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/uapi/linux/bpf.h       |  40 +++++++++
 kernel/trace/bpf_trace.c       | 148 +++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.h       |   1 +
 tools/include/uapi/linux/bpf.h |  40 +++++++++
 4 files changed, 229 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 444fe6f1cf35..3ef8f683ed9e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5154,6 +5154,18 @@ union bpf_attr {
  *		if not NULL, is a reference which must be released using its
  *		corresponding release function, or moved into a BPF map before
  *		program exit.
+ *
+ * long bpf_get_reg_val(void *dst, u32 size, u64 getreg_spec, struct pt_=
regs *regs, struct task_struct *tsk)
+ *	Description
+ *		Store the value of a SSE register specified by *getreg_spec*
+ *		into memory region of size *size* specified by *dst*. *getreg_spec*
+ *		is a combination of BPF_GETREG enum AND BPF_GETREG_F flag e.g.
+ *		(BPF_GETREG_X86_XMM0 << 32) | BPF_GETREG_F_CURRENT.*
+ *	Return
+ *		0 on success
+ *		**-ENOENT** if the system architecture does not have requested reg
+ *		**-EINVAL** if *getreg_spec* is invalid
+ *		**-EINVAL** if *size* !=3D bytes necessary to store requested reg va=
l
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5351,6 +5363,7 @@ union bpf_attr {
 	FN(skb_set_tstamp),		\
 	FN(ima_file_hash),		\
 	FN(kptr_xchg),			\
+	FN(get_reg_val),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
@@ -6318,6 +6331,33 @@ struct bpf_perf_event_value {
 	__u64 running;
 };
=20
+/* bpf_get_reg_val register enum */
+enum {
+	BPF_GETREG_X86_XMM0 =3D 0,
+	BPF_GETREG_X86_XMM1,
+	BPF_GETREG_X86_XMM2,
+	BPF_GETREG_X86_XMM3,
+	BPF_GETREG_X86_XMM4,
+	BPF_GETREG_X86_XMM5,
+	BPF_GETREG_X86_XMM6,
+	BPF_GETREG_X86_XMM7,
+	BPF_GETREG_X86_XMM8,
+	BPF_GETREG_X86_XMM9,
+	BPF_GETREG_X86_XMM10,
+	BPF_GETREG_X86_XMM11,
+	BPF_GETREG_X86_XMM12,
+	BPF_GETREG_X86_XMM13,
+	BPF_GETREG_X86_XMM14,
+	BPF_GETREG_X86_XMM15,
+	__MAX_BPF_GETREG,
+};
+
+/* bpf_get_reg_val flags */
+enum {
+	BPF_GETREG_F_NONE =3D 0,
+	BPF_GETREG_F_CURRENT =3D (1U << 0),
+};
+
 enum {
 	BPF_DEVCG_ACC_MKNOD	=3D (1ULL << 0),
 	BPF_DEVCG_ACC_READ	=3D (1ULL << 1),
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f15b826f9899..0de7d6b3af5b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -28,6 +28,10 @@
=20
 #include <asm/tlb.h>
=20
+#ifdef CONFIG_X86
+#include <asm/fpu/context.h>
+#endif
+
 #include "trace_probe.h"
 #include "trace.h"
=20
@@ -1166,6 +1170,148 @@ static const struct bpf_func_proto bpf_get_func_a=
rg_cnt_proto =3D {
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 };
=20
+#define XMM_REG_SZ 16
+
+#define __xmm_space_off(regno)				\
+	case BPF_GETREG_X86_XMM ## regno:		\
+		xmm_space_off =3D regno * 16;		\
+		break;
+
+static long getreg_read_xmm_fxsave(u32 reg, struct task_struct *tsk,
+				   void *data)
+{
+	struct fxregs_state *fxsave;
+	u32 xmm_space_off;
+
+	switch (reg) {
+	__xmm_space_off(0);
+	__xmm_space_off(1);
+	__xmm_space_off(2);
+	__xmm_space_off(3);
+	__xmm_space_off(4);
+	__xmm_space_off(5);
+	__xmm_space_off(6);
+	__xmm_space_off(7);
+#ifdef	CONFIG_X86_64
+	__xmm_space_off(8);
+	__xmm_space_off(9);
+	__xmm_space_off(10);
+	__xmm_space_off(11);
+	__xmm_space_off(12);
+	__xmm_space_off(13);
+	__xmm_space_off(14);
+	__xmm_space_off(15);
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	fxsave =3D &tsk->thread.fpu.fpstate->regs.fxsave;
+	memcpy(data, (void *)&fxsave->xmm_space + xmm_space_off, XMM_REG_SZ);
+	return 0;
+}
+
+#undef __xmm_space_off
+
+static bool getreg_is_xmm(u32 reg)
+{
+	return reg >=3D BPF_GETREG_X86_XMM0 && reg <=3D BPF_GETREG_X86_XMM15;
+}
+
+#define __bpf_sse_read(regno)							\
+	case BPF_GETREG_X86_XMM ## regno:					\
+		asm("movdqa %%xmm" #regno ", %0" : "=3Dm"(*(char *)data));	\
+		break;
+
+static long bpf_read_sse_reg(u32 reg, u32 flags, struct task_struct *tsk=
,
+			     void *data)
+{
+#ifdef CONFIG_X86
+	unsigned long irq_flags;
+	long err;
+
+	switch (reg) {
+	__bpf_sse_read(0);
+	__bpf_sse_read(1);
+	__bpf_sse_read(2);
+	__bpf_sse_read(3);
+	__bpf_sse_read(4);
+	__bpf_sse_read(5);
+	__bpf_sse_read(6);
+	__bpf_sse_read(7);
+#ifdef CONFIG_X86_64
+	__bpf_sse_read(8);
+	__bpf_sse_read(9);
+	__bpf_sse_read(10);
+	__bpf_sse_read(11);
+	__bpf_sse_read(12);
+	__bpf_sse_read(13);
+	__bpf_sse_read(14);
+	__bpf_sse_read(15);
+#endif /* CONFIG_X86_64 */
+	default:
+		return -EINVAL;
+	}
+
+	if (flags & BPF_GETREG_F_CURRENT)
+		return 0;
+
+	if (!fpregs_state_valid(&tsk->thread.fpu, smp_processor_id())) {
+		local_irq_save(irq_flags);
+		err =3D getreg_read_xmm_fxsave(reg, tsk, data);
+		local_irq_restore(irq_flags);
+		return err;
+	}
+
+	return 0;
+#else
+	return -ENOENT;
+#endif /* CONFIG_X86 */
+}
+
+#undef __bpf_sse_read
+
+BPF_CALL_5(get_reg_val, void *, dst, u32, size,
+	   u64, getreg_spec, struct pt_regs *, regs,
+	   struct task_struct *, tsk)
+{
+	u32 reg, flags;
+
+	reg =3D (u32)(getreg_spec >> 32);
+	flags =3D (u32)getreg_spec;
+	if (reg >=3D __MAX_BPF_GETREG)
+		return -EINVAL;
+
+	if (getreg_is_xmm(reg)) {
+#ifndef CONFIG_X86
+		return -ENOENT;
+#else
+		if (size !=3D XMM_REG_SZ)
+			return -EINVAL;
+
+		return bpf_read_sse_reg(reg, flags, tsk, dst);
+	}
+
+	return -EINVAL;
+#endif
+}
+
+BTF_ID_LIST(bpf_get_reg_val_ids)
+BTF_ID(struct, pt_regs)
+
+static const struct bpf_func_proto bpf_get_reg_val_proto =3D {
+	.func	=3D get_reg_val,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	=3D ARG_CONST_SIZE,
+	.arg3_type	=3D ARG_ANYTHING,
+	.arg4_type	=3D ARG_PTR_TO_BTF_ID_OR_NULL,
+	.arg4_btf_id	=3D &bpf_get_reg_val_ids[0],
+	.arg5_type	=3D ARG_PTR_TO_BTF_ID_OR_NULL,
+	.arg5_btf_id	=3D &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
+};
+
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog)
 {
@@ -1287,6 +1433,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 		return &bpf_find_vma_proto;
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
+	case BPF_FUNC_get_reg_val:
+		return &bpf_get_reg_val_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
diff --git a/kernel/trace/bpf_trace.h b/kernel/trace/bpf_trace.h
index 9acbc11ac7bb..b4b55706c2dd 100644
--- a/kernel/trace/bpf_trace.h
+++ b/kernel/trace/bpf_trace.h
@@ -29,6 +29,7 @@ TRACE_EVENT(bpf_trace_printk,
=20
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE bpf_trace
=20
 #include <trace/define_trace.h>
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 444fe6f1cf35..3ef8f683ed9e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5154,6 +5154,18 @@ union bpf_attr {
  *		if not NULL, is a reference which must be released using its
  *		corresponding release function, or moved into a BPF map before
  *		program exit.
+ *
+ * long bpf_get_reg_val(void *dst, u32 size, u64 getreg_spec, struct pt_=
regs *regs, struct task_struct *tsk)
+ *	Description
+ *		Store the value of a SSE register specified by *getreg_spec*
+ *		into memory region of size *size* specified by *dst*. *getreg_spec*
+ *		is a combination of BPF_GETREG enum AND BPF_GETREG_F flag e.g.
+ *		(BPF_GETREG_X86_XMM0 << 32) | BPF_GETREG_F_CURRENT.*
+ *	Return
+ *		0 on success
+ *		**-ENOENT** if the system architecture does not have requested reg
+ *		**-EINVAL** if *getreg_spec* is invalid
+ *		**-EINVAL** if *size* !=3D bytes necessary to store requested reg va=
l
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5351,6 +5363,7 @@ union bpf_attr {
 	FN(skb_set_tstamp),		\
 	FN(ima_file_hash),		\
 	FN(kptr_xchg),			\
+	FN(get_reg_val),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
@@ -6318,6 +6331,33 @@ struct bpf_perf_event_value {
 	__u64 running;
 };
=20
+/* bpf_get_reg_val register enum */
+enum {
+	BPF_GETREG_X86_XMM0 =3D 0,
+	BPF_GETREG_X86_XMM1,
+	BPF_GETREG_X86_XMM2,
+	BPF_GETREG_X86_XMM3,
+	BPF_GETREG_X86_XMM4,
+	BPF_GETREG_X86_XMM5,
+	BPF_GETREG_X86_XMM6,
+	BPF_GETREG_X86_XMM7,
+	BPF_GETREG_X86_XMM8,
+	BPF_GETREG_X86_XMM9,
+	BPF_GETREG_X86_XMM10,
+	BPF_GETREG_X86_XMM11,
+	BPF_GETREG_X86_XMM12,
+	BPF_GETREG_X86_XMM13,
+	BPF_GETREG_X86_XMM14,
+	BPF_GETREG_X86_XMM15,
+	__MAX_BPF_GETREG,
+};
+
+/* bpf_get_reg_val flags */
+enum {
+	BPF_GETREG_F_NONE =3D 0,
+	BPF_GETREG_F_CURRENT =3D (1U << 0),
+};
+
 enum {
 	BPF_DEVCG_ACC_MKNOD	=3D (1ULL << 0),
 	BPF_DEVCG_ACC_READ	=3D (1ULL << 1),
--=20
2.30.2

