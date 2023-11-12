Return-Path: <bpf+bounces-14936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A137E8FCF
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 13:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6011FB20984
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 12:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AE2525A;
	Sun, 12 Nov 2023 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2BgJRgW4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED17136C
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:50:07 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC26130C2
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 04:50:04 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCiSwr012913;
	Sun, 12 Nov 2023 12:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=xKpzMlIPVcX7sZfuorZdtGd7QFBKIZzjpa4Z9V8e9UA=;
 b=2BgJRgW44X/WwVV03vfRujExQkYXfOBwJj7J33+nsgTC4HdgviMbUbQiOEP2KOlYXmMG
 lS7txSxsZVSNFelTpbV6eCWbrrXoocba2cbDy04WkAQ7CfqwmEM+b29UPwZySkOqq2VL
 jx/Ai8eLbIseLnrLd2Rj+lCF/dJ244BoasEyxP/OFO4CtWZRHPaOfgiqW95/JswIxOzh
 aYs0XJAbSWT8zo5wcSuzRKE/mNbhsayh8IsF06gPeDJIE3zQtUFS7dABP5d448uEKnHJ
 fSkAwuLPfT0R11Vmnd8H0Bxir/48F49aefibqaSGrkMuM+Zo5xQ5JlGipC1A/cPiDZ/q pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2r01eqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCF7EL009258;
	Sun, 12 Nov 2023 12:49:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxhngftk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:45 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ACCmceY029718;
	Sun, 12 Nov 2023 12:49:44 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-14.vpn.oracle.com [10.175.173.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxhngfep-17;
	Sun, 12 Nov 2023 12:49:44 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        masahiroy@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 16/17] selftests/bpf: build separate bpf_testmod module with standalone BTF
Date: Sun, 12 Nov 2023 12:48:33 +0000
Message-Id: <20231112124834.388735-17-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231112124834.388735-1-alan.maguire@oracle.com>
References: <20231112124834.388735-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120113
X-Proofpoint-ORIG-GUID: q7C1877-FWVJzqFdkI4TCXB6kc4A_kOO
X-Proofpoint-GUID: q7C1877-FWVJzqFdkI4TCXB6kc4A_kOO

From bpf_testmod.c, build bpf_testmod_standalone.ko which is identical to
bpf_testmod.ko aside from being built with standalone BTF, and having enough
differences in names such that both can be loaded simultaneously with
bpf_testmod.  It will be used to test standalone BTF loading.

bpf_testmod_standalone* files were generated mainly via running

sed 's/bpf_testmod/bpf_testmod_standalone/g'

...on the relevant files, and manually removing bpf_fentry_shadow_test()
from bpf_testmod_standalone.c to avoid a symbol clash that would prevent
it being loaded at the same time as bpf_testmod.  kfunc iters were also
renamed.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/bpf_testmod/Makefile        |  10 +-
 .../bpf_testmod_standalone-events.h           |  57 ++
 .../bpf/bpf_testmod/bpf_testmod_standalone.c  | 551 ++++++++++++++++++
 .../bpf/bpf_testmod/bpf_testmod_standalone.h  |  31 +
 .../bpf_testmod_standalone_kfunc.h            | 109 ++++
 5 files changed, 755 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone-events.h
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone.c
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone.h
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone_kfunc.h

diff --git a/tools/testing/selftests/bpf/bpf_testmod/Makefile b/tools/testing/selftests/bpf/bpf_testmod/Makefile
index 15cb36c4483a..d7ca383b1b0d 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/Makefile
+++ b/tools/testing/selftests/bpf/bpf_testmod/Makefile
@@ -7,13 +7,17 @@ else
 Q = @
 endif
 
-MODULES = bpf_testmod.ko
+MODULES = bpf_testmod.ko bpf_testmod_standalone.ko
+
+obj-m				+=	bpf_testmod.o
+obj-m				+=	bpf_testmod_standalone.o
 
-obj-m += bpf_testmod.o
 CFLAGS_bpf_testmod.o = -I$(src)
+CFLAGS_bpf_testmod_standalone.o += -I$(src)
 
 all:
-	+$(Q)make -C $(KDIR) M=$(BPF_TESTMOD_DIR) modules
+	+$(Q)make -C $(KDIR) M=$(BPF_TESTMOD_DIR) bpf_testmod.ko
+	+$(Q)make -C $(KDIR) BTF_BASE= M=$(BPF_TESTMOD_DIR) bpf_testmod_standalone.ko
 
 clean:
 	+$(Q)make -C $(KDIR) M=$(BPF_TESTMOD_DIR) clean
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone-events.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone-events.h
new file mode 100644
index 000000000000..ee1c668b0e3b
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone-events.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2020 Facebook */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM bpf_testmod_standalone
+
+#if !defined(_BPF_TESTMOD_EVENTS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _BPF_TESTMOD_EVENTS_H
+
+#include <linux/tracepoint.h>
+#include "bpf_testmod_standalone.h"
+
+TRACE_EVENT(bpf_testmod_standalone_test_read,
+	TP_PROTO(struct task_struct *task, struct bpf_testmod_standalone_test_read_ctx *ctx),
+	TP_ARGS(task, ctx),
+	TP_STRUCT__entry(
+		__field(pid_t, pid)
+		__array(char, comm, TASK_COMM_LEN)
+		__field(loff_t, off)
+		__field(size_t, len)
+	),
+	TP_fast_assign(
+		__entry->pid = task->pid;
+		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		__entry->off = ctx->off;
+		__entry->len = ctx->len;
+	),
+	TP_printk("pid=%d comm=%s off=%llu len=%zu",
+		  __entry->pid, __entry->comm, __entry->off, __entry->len)
+);
+
+/* A bare tracepoint with no event associated with it */
+DECLARE_TRACE(bpf_testmod_standalone_test_write_bare,
+	TP_PROTO(struct task_struct *task, struct bpf_testmod_standalone_test_write_ctx *ctx),
+	TP_ARGS(task, ctx)
+);
+
+#undef BPF_TESTMOD_DECLARE_TRACE
+#ifdef DECLARE_TRACE_WRITABLE
+#define BPF_TESTMOD_DECLARE_TRACE(call, proto, args, size) \
+	DECLARE_TRACE_WRITABLE(call, PARAMS(proto), PARAMS(args), size)
+#else
+#define BPF_TESTMOD_DECLARE_TRACE(call, proto, args, size) \
+	DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
+#endif
+
+BPF_TESTMOD_DECLARE_TRACE(bpf_testmod_standalone_test_writable_bare,
+	TP_PROTO(struct bpf_testmod_standalone_test_writable_ctx *ctx),
+	TP_ARGS(ctx),
+	sizeof(struct bpf_testmod_standalone_test_writable_ctx)
+);
+
+#endif /* _BPF_TESTMOD_EVENTS_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE bpf_testmod_standalone-events
+#include <trace/define_trace.h>
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone.c
new file mode 100644
index 000000000000..a0d7d1ade6ff
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone.c
@@ -0,0 +1,551 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/error-injection.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/percpu-defs.h>
+#include <linux/sysfs.h>
+#include <linux/tracepoint.h>
+#include "bpf_testmod_standalone.h"
+#include "bpf_testmod_standalone_kfunc.h"
+
+#define CREATE_TRACE_POINTS
+#include "bpf_testmod_standalone-events.h"
+
+typedef int (*func_proto_typedef)(long);
+typedef int (*func_proto_typedef_nested1)(func_proto_typedef);
+typedef int (*func_proto_typedef_nested2)(func_proto_typedef_nested1);
+
+DEFINE_PER_CPU(int, bpf_testmod_standalone_ksym_percpu) = 123;
+long bpf_testmod_standalone_test_struct_arg_result;
+
+struct bpf_testmod_standalone_struct_arg_1 {
+	int a;
+};
+struct bpf_testmod_standalone_struct_arg_2 {
+	long a;
+	long b;
+};
+
+struct bpf_testmod_standalone_struct_arg_3 {
+	int a;
+	int b[];
+};
+
+struct bpf_testmod_standalone_struct_arg_4 {
+	u64 a;
+	int b;
+};
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in bpf_testmod_standalone.ko BTF");
+
+noinline int
+bpf_testmod_standalone_test_struct_arg_1(struct bpf_testmod_standalone_struct_arg_2 a, int b, int c) {
+	bpf_testmod_standalone_test_struct_arg_result = a.a + a.b  + b + c;
+	return bpf_testmod_standalone_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_standalone_test_struct_arg_2(int a, struct bpf_testmod_standalone_struct_arg_2 b, int c) {
+	bpf_testmod_standalone_test_struct_arg_result = a + b.a + b.b + c;
+	return bpf_testmod_standalone_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_standalone_test_struct_arg_3(int a, int b, struct bpf_testmod_standalone_struct_arg_2 c) {
+	bpf_testmod_standalone_test_struct_arg_result = a + b + c.a + c.b;
+	return bpf_testmod_standalone_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_standalone_test_struct_arg_4(struct bpf_testmod_standalone_struct_arg_1 a, int b,
+			      int c, int d, struct bpf_testmod_standalone_struct_arg_2 e) {
+	bpf_testmod_standalone_test_struct_arg_result = a.a + b + c + d + e.a + e.b;
+	return bpf_testmod_standalone_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_standalone_test_struct_arg_5(void) {
+	bpf_testmod_standalone_test_struct_arg_result = 1;
+	return bpf_testmod_standalone_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_standalone_test_struct_arg_6(struct bpf_testmod_standalone_struct_arg_3 *a) {
+	bpf_testmod_standalone_test_struct_arg_result = a->b[0];
+	return bpf_testmod_standalone_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_standalone_test_struct_arg_7(u64 a, void *b, short c, int d, void *e,
+			      struct bpf_testmod_standalone_struct_arg_4 f)
+{
+	bpf_testmod_standalone_test_struct_arg_result = a + (long)b + c + d +
+		(long)e + f.a + f.b;
+	return bpf_testmod_standalone_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_standalone_test_struct_arg_8(u64 a, void *b, short c, int d, void *e,
+			      struct bpf_testmod_standalone_struct_arg_4 f, int g)
+{
+	bpf_testmod_standalone_test_struct_arg_result = a + (long)b + c + d +
+		(long)e + f.a + f.b + g;
+	return bpf_testmod_standalone_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_standalone_test_arg_ptr_to_struct(struct bpf_testmod_standalone_struct_arg_1 *a) {
+	bpf_testmod_standalone_test_struct_arg_result = a->a;
+	return bpf_testmod_standalone_test_struct_arg_result;
+}
+
+__bpf_kfunc void
+bpf_testmod_standalone_test_mod_kfunc(int i)
+{
+	*(int *)this_cpu_ptr(&bpf_testmod_standalone_ksym_percpu) = i;
+}
+
+__bpf_kfunc int bpf_iter_testmod_standalone_seq_new(struct bpf_iter_testmod_standalone_seq *it, s64 value, int cnt)
+{
+	if (cnt < 0) {
+		it->cnt = 0;
+		return -EINVAL;
+	}
+
+	it->value = value;
+	it->cnt = cnt;
+
+	return 0;
+}
+
+__bpf_kfunc s64 *bpf_iter_testmod_standalone_seq_next(struct bpf_iter_testmod_standalone_seq *it)
+{
+	if (it->cnt <= 0)
+		return NULL;
+
+	it->cnt--;
+
+	return &it->value;
+}
+
+__bpf_kfunc void bpf_iter_testmod_standalone_seq_destroy(struct bpf_iter_testmod_standalone_seq *it)
+{
+	it->cnt = 0;
+}
+
+__bpf_kfunc void bpf_kfunc_standalone_common_test(void)
+{
+}
+
+struct bpf_testmod_standalone_btf_type_tag_1 {
+	int a;
+};
+
+struct bpf_testmod_standalone_btf_type_tag_2 {
+	struct bpf_testmod_standalone_btf_type_tag_1 __user *p;
+};
+
+struct bpf_testmod_standalone_btf_type_tag_3 {
+	struct bpf_testmod_standalone_btf_type_tag_1 __percpu *p;
+};
+
+noinline int
+bpf_testmod_standalone_test_btf_type_tag_user_1(struct bpf_testmod_standalone_btf_type_tag_1 __user *arg) {
+	BTF_TYPE_EMIT(func_proto_typedef);
+	BTF_TYPE_EMIT(func_proto_typedef_nested1);
+	BTF_TYPE_EMIT(func_proto_typedef_nested2);
+	return arg->a;
+}
+
+noinline int
+bpf_testmod_standalone_test_btf_type_tag_user_2(struct bpf_testmod_standalone_btf_type_tag_2 *arg) {
+	return arg->p->a;
+}
+
+noinline int
+bpf_testmod_standalone_test_btf_type_tag_percpu_1(struct bpf_testmod_standalone_btf_type_tag_1 __percpu *arg) {
+	return arg->a;
+}
+
+noinline int
+bpf_testmod_standalone_test_btf_type_tag_percpu_2(struct bpf_testmod_standalone_btf_type_tag_3 *arg) {
+	return arg->p->a;
+}
+
+noinline int bpf_testmod_standalone_loop_test(int n)
+{
+	/* Make sum volatile, so smart compilers, such as clang, will not
+	 * optimize the code by removing the loop.
+	 */
+	volatile int sum = 0;
+	int i;
+
+	/* the primary goal of this test is to test LBR. Create a lot of
+	 * branches in the function, so we can catch it easily.
+	 */
+	for (i = 0; i < n; i++)
+		sum += i;
+	return sum;
+}
+
+__weak noinline struct file *bpf_testmod_standalone_return_ptr(int arg)
+{
+	static struct file f = {};
+
+	switch (arg) {
+	case 1: return (void *)EINVAL;		/* user addr */
+	case 2: return (void *)0xcafe4a11;	/* user addr */
+	case 3: return (void *)-EINVAL;		/* canonical, but invalid */
+	case 4: return (void *)(1ull << 60);	/* non-canonical and invalid */
+	case 5: return (void *)~(1ull << 30);	/* trigger extable */
+	case 6: return &f;			/* valid addr */
+	case 7: return (void *)((long)&f | 1);	/* kernel tricks */
+	default: return NULL;
+	}
+}
+
+noinline int bpf_testmod_standalone_fentry_test1(int a)
+{
+	return a + 1;
+}
+
+noinline int bpf_testmod_standalone_fentry_test2(int a, u64 b)
+{
+	return a + b;
+}
+
+noinline int bpf_testmod_standalone_fentry_test3(char a, int b, u64 c)
+{
+	return a + b + c;
+}
+
+noinline int bpf_testmod_standalone_fentry_test7(u64 a, void *b, short c, int d,
+				      void *e, char f, int g)
+{
+	return a + (long)b + c + d + (long)e + f + g;
+}
+
+noinline int bpf_testmod_standalone_fentry_test11(u64 a, void *b, short c, int d,
+				       void *e, char f, int g,
+				       unsigned int h, long i, __u64 j,
+				       unsigned long k)
+{
+	return a + (long)b + c + d + (long)e + f + g + h + i + j + k;
+}
+
+int bpf_testmod_standalone_fentry_ok;
+
+noinline ssize_t
+bpf_testmod_standalone_test_read(struct file *file, struct kobject *kobj,
+		      struct bin_attribute *bin_attr,
+		      char *buf, loff_t off, size_t len)
+{
+	struct bpf_testmod_standalone_test_read_ctx ctx = {
+		.buf = buf,
+		.off = off,
+		.len = len,
+	};
+	struct bpf_testmod_standalone_struct_arg_1 struct_arg1 = {10}, struct_arg1_2 = {-1};
+	struct bpf_testmod_standalone_struct_arg_2 struct_arg2 = {2, 3};
+	struct bpf_testmod_standalone_struct_arg_3 *struct_arg3;
+	struct bpf_testmod_standalone_struct_arg_4 struct_arg4 = {21, 22};
+	int i = 1;
+
+	while (bpf_testmod_standalone_return_ptr(i))
+		i++;
+
+	(void)bpf_testmod_standalone_test_struct_arg_1(struct_arg2, 1, 4);
+	(void)bpf_testmod_standalone_test_struct_arg_2(1, struct_arg2, 4);
+	(void)bpf_testmod_standalone_test_struct_arg_3(1, 4, struct_arg2);
+	(void)bpf_testmod_standalone_test_struct_arg_4(struct_arg1, 1, 2, 3, struct_arg2);
+	(void)bpf_testmod_standalone_test_struct_arg_5();
+	(void)bpf_testmod_standalone_test_struct_arg_7(16, (void *)17, 18, 19,
+					    (void *)20, struct_arg4);
+	(void)bpf_testmod_standalone_test_struct_arg_8(16, (void *)17, 18, 19,
+					    (void *)20, struct_arg4, 23);
+
+	(void)bpf_testmod_standalone_test_arg_ptr_to_struct(&struct_arg1_2);
+
+	struct_arg3 = kmalloc((sizeof(struct bpf_testmod_standalone_struct_arg_3) +
+				sizeof(int)), GFP_KERNEL);
+	if (struct_arg3 != NULL) {
+		struct_arg3->b[0] = 1;
+		(void)bpf_testmod_standalone_test_struct_arg_6(struct_arg3);
+		kfree(struct_arg3);
+	}
+
+	/* This is always true. Use the check to make sure the compiler
+	 * doesn't remove bpf_testmod_standalone_loop_test.
+	 */
+	if (bpf_testmod_standalone_loop_test(101) > 100)
+		trace_bpf_testmod_standalone_test_read(current, &ctx);
+
+	/* Magic number to enable writable tp */
+	if (len == 64) {
+		struct bpf_testmod_standalone_test_writable_ctx writable = {
+			.val = 1024,
+		};
+		trace_bpf_testmod_standalone_test_writable_bare(&writable);
+		if (writable.early_ret)
+			return snprintf(buf, len, "%d\n", writable.val);
+	}
+
+	if (bpf_testmod_standalone_fentry_test1(1) != 2 ||
+	    bpf_testmod_standalone_fentry_test2(2, 3) != 5 ||
+	    bpf_testmod_standalone_fentry_test3(4, 5, 6) != 15 ||
+	    bpf_testmod_standalone_fentry_test7(16, (void *)17, 18, 19, (void *)20,
+			21, 22) != 133 ||
+	    bpf_testmod_standalone_fentry_test11(16, (void *)17, 18, 19, (void *)20,
+			21, 22, 23, 24, 25, 26) != 231)
+		goto out;
+
+	bpf_testmod_standalone_fentry_ok = 1;
+out:
+	return -EIO; /* always fail */
+}
+EXPORT_SYMBOL(bpf_testmod_standalone_test_read);
+ALLOW_ERROR_INJECTION(bpf_testmod_standalone_test_read, ERRNO);
+
+noinline ssize_t
+bpf_testmod_standalone_test_write(struct file *file, struct kobject *kobj,
+		      struct bin_attribute *bin_attr,
+		      char *buf, loff_t off, size_t len)
+{
+	struct bpf_testmod_standalone_test_write_ctx ctx = {
+		.buf = buf,
+		.off = off,
+		.len = len,
+	};
+
+	trace_bpf_testmod_standalone_test_write_bare(current, &ctx);
+
+	return -EIO; /* always fail */
+}
+EXPORT_SYMBOL(bpf_testmod_standalone_test_write);
+ALLOW_ERROR_INJECTION(bpf_testmod_standalone_test_write, ERRNO);
+
+__diag_pop();
+
+static struct bin_attribute bin_attr_bpf_testmod_standalone_file __ro_after_init = {
+	.attr = { .name = "bpf_testmod_standalone", .mode = 0666, },
+	.read = bpf_testmod_standalone_test_read,
+	.write = bpf_testmod_standalone_test_write,
+};
+
+BTF_SET8_START(bpf_testmod_standalone_common_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_iter_testmod_standalone_seq_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_testmod_standalone_seq_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_testmod_standalone_seq_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_common_test)
+BTF_SET8_END(bpf_testmod_standalone_common_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_testmod_standalone_common_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_testmod_standalone_common_kfunc_ids,
+};
+
+__bpf_kfunc u64 bpf_kfunc_standalone_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
+{
+	return a + b + c + d;
+}
+
+__bpf_kfunc int bpf_kfunc_standalone_call_test2(struct sock *sk, u32 a, u32 b)
+{
+	return a + b;
+}
+
+__bpf_kfunc struct sock *bpf_kfunc_standalone_call_test3(struct sock *sk)
+{
+	return sk;
+}
+
+__bpf_kfunc long noinline bpf_kfunc_standalone_call_test4(signed char a, short b, int c, long d)
+{
+	/* Provoke the compiler to assume that the caller has sign-extended a,
+	 * b and c on platforms where this is required (e.g. s390x).
+	 */
+	return (long)a + (long)b + (long)c + d;
+}
+
+static struct prog_test_ref_kfunc prog_test_struct = {
+	.a = 42,
+	.b = 108,
+	.next = &prog_test_struct,
+	.cnt = REFCOUNT_INIT(1),
+};
+
+__bpf_kfunc struct prog_test_ref_kfunc *
+bpf_kfunc_standalone_call_test_acquire(unsigned long *scalar_ptr)
+{
+	refcount_inc(&prog_test_struct.cnt);
+	return &prog_test_struct;
+}
+
+__bpf_kfunc void bpf_kfunc_standalone_call_test_offset(struct prog_test_ref_kfunc *p)
+{
+	WARN_ON_ONCE(1);
+}
+
+__bpf_kfunc struct prog_test_member *
+bpf_kfunc_standalone_call_memb_acquire(void)
+{
+	WARN_ON_ONCE(1);
+	return NULL;
+}
+
+__bpf_kfunc void bpf_kfunc_standalone_call_memb1_release(struct prog_test_member1 *p)
+{
+	WARN_ON_ONCE(1);
+}
+
+static int *__bpf_kfunc_standalone_call_test_get_mem(struct prog_test_ref_kfunc *p, const int size)
+{
+	if (size > 2 * sizeof(int))
+		return NULL;
+
+	return (int *)p;
+}
+
+__bpf_kfunc int *bpf_kfunc_standalone_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p,
+						  const int rdwr_buf_size)
+{
+	return __bpf_kfunc_standalone_call_test_get_mem(p, rdwr_buf_size);
+}
+
+__bpf_kfunc int *bpf_kfunc_standalone_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p,
+						    const int rdonly_buf_size)
+{
+	return __bpf_kfunc_standalone_call_test_get_mem(p, rdonly_buf_size);
+}
+
+/* the next 2 ones can't be really used for testing expect to ensure
+ * that the verifier rejects the call.
+ * Acquire functions must return struct pointers, so these ones are
+ * failing.
+ */
+__bpf_kfunc int *bpf_kfunc_standalone_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p,
+						    const int rdonly_buf_size)
+{
+	return __bpf_kfunc_standalone_call_test_get_mem(p, rdonly_buf_size);
+}
+
+__bpf_kfunc void bpf_kfunc_standalone_call_int_mem_release(int *p)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_standalone_call_test_pass_ctx(struct __sk_buff *skb)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_standalone_call_test_pass1(struct prog_test_pass1 *p)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_standalone_call_test_pass2(struct prog_test_pass2 *p)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_standalone_call_test_fail1(struct prog_test_fail1 *p)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_standalone_call_test_fail2(struct prog_test_fail2 *p)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_standalone_call_test_fail3(struct prog_test_fail3 *p)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_standalone_call_test_mem_len_pass1(void *mem, int mem__sz)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_standalone_call_test_mem_len_fail1(void *mem, int len)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_standalone_call_test_mem_len_fail2(u64 *mem, int len)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_standalone_call_test_ref(struct prog_test_ref_kfunc *p)
+{
+	/* p != NULL, but p->cnt could be 0 */
+}
+
+__bpf_kfunc void bpf_kfunc_standalone_call_test_destructive(void)
+{
+}
+
+__bpf_kfunc static u32 bpf_kfunc_standalone_call_test_static_unused_arg(u32 arg, u32 unused)
+{
+	return arg;
+}
+
+BTF_SET8_START(bpf_testmod_standalone_check_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_testmod_standalone_test_mod_kfunc)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test1)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test2)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test3)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test4)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_mem_len_pass1)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_mem_len_fail1)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_mem_len_fail2)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_memb_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_memb1_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_get_rdwr_mem, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_get_rdonly_mem, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_acq_rdonly_mem, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_int_mem_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_pass_ctx)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_pass1)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_pass2)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_fail1)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_fail2)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_fail3)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_ref, KF_TRUSTED_ARGS | KF_RCU)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_destructive, KF_DESTRUCTIVE)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_static_unused_arg)
+BTF_ID_FLAGS(func, bpf_kfunc_standalone_call_test_offset)
+BTF_SET8_END(bpf_testmod_standalone_check_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_testmod_standalone_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_testmod_standalone_check_kfunc_ids,
+};
+
+extern int bpf_fentry_test1(int a);
+
+static int bpf_testmod_standalone_init(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_testmod_standalone_common_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_standalone_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_standalone_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_standalone_kfunc_set);
+	if (ret < 0)
+		return ret;
+	if (bpf_fentry_test1(0) < 0)
+		return -EINVAL;
+	return sysfs_create_bin_file(kernel_kobj, &bin_attr_bpf_testmod_standalone_file);
+}
+
+static void bpf_testmod_standalone_exit(void)
+{
+	return sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_standalone_file);
+}
+
+module_init(bpf_testmod_standalone_init);
+module_exit(bpf_testmod_standalone_exit);
+
+MODULE_AUTHOR("Andrii Nakryiko");
+MODULE_DESCRIPTION("BPF selftests module");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone.h
new file mode 100644
index 000000000000..a8a4d75d9a1d
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2020 Facebook */
+#ifndef _BPF_TESTMOD_STANDALONE_H
+#define _BPF_TESTMOD_STANDALONE_H
+
+#include <linux/types.h>
+
+struct bpf_testmod_standalone_test_read_ctx {
+	char *buf;
+	loff_t off;
+	size_t len;
+};
+
+struct bpf_testmod_standalone_test_write_ctx {
+	char *buf;
+	loff_t off;
+	size_t len;
+};
+
+struct bpf_testmod_standalone_test_writable_ctx {
+	bool early_ret;
+	int val;
+};
+
+/* BPF iter that returns *value* *n* times in a row */
+struct bpf_iter_testmod_standalone_seq {
+	s64 value;
+	int cnt;
+};
+
+#endif /* _BPF_TESTMOD_STANDALONE_H */
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone_kfunc.h
new file mode 100644
index 000000000000..a23cfd72d7f3
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_standalone_kfunc.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _BPF_TESTMOD_KFUNC_H
+#define _BPF_TESTMOD_KFUNC_H
+
+#ifndef __KERNEL__
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#else
+#define __ksym
+struct prog_test_member1 {
+	int a;
+};
+
+struct prog_test_member {
+	struct prog_test_member1 m;
+	int c;
+};
+
+struct prog_test_ref_kfunc {
+	int a;
+	int b;
+	struct prog_test_member memb;
+	struct prog_test_ref_kfunc *next;
+	refcount_t cnt;
+};
+#endif
+
+struct prog_test_pass1 {
+	int x0;
+	struct {
+		int x1;
+		struct {
+			int x2;
+			struct {
+				int x3;
+			};
+		};
+	};
+};
+
+struct prog_test_pass2 {
+	int len;
+	short arr1[4];
+	struct {
+		char arr2[4];
+		unsigned long arr3[8];
+	} x;
+};
+
+struct prog_test_fail1 {
+	void *p;
+	int x;
+};
+
+struct prog_test_fail2 {
+	int x8;
+	struct prog_test_pass1 x;
+};
+
+struct prog_test_fail3 {
+	int len;
+	char arr1[2];
+	char arr2[];
+};
+
+struct prog_test_ref_kfunc *
+bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
+void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
+void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p) __ksym;
+
+void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
+int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
+int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
+int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
+void bpf_kfunc_call_int_mem_release(int *p) __ksym;
+
+/* The bpf_kfunc_call_test_static_unused_arg is defined as static,
+ * but bpf program compilation needs to see it as global symbol.
+ */
+#ifndef __KERNEL__
+u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
+#endif
+
+void bpf_testmod_standalone_test_mod_kfunc(int i) __ksym;
+
+__u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
+				__u32 c, __u64 d) __ksym;
+int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
+struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
+long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
+
+void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
+void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
+void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
+void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
+
+void bpf_kfunc_call_test_destructive(void) __ksym;
+
+void bpf_kfunc_call_test_offset(struct prog_test_ref_kfunc *p);
+struct prog_test_member *bpf_kfunc_call_memb_acquire(void);
+void bpf_kfunc_call_memb1_release(struct prog_test_member1 *p);
+void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p);
+void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p);
+void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p);
+void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len);
+
+void bpf_kfunc_common_test(void) __ksym;
+#endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.31.1


