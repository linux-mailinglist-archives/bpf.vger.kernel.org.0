Return-Path: <bpf+bounces-44284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D532D9C0D4F
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 18:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B2B0B2127B
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAE4217647;
	Thu,  7 Nov 2024 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu0C3o41"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D276217644
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001886; cv=none; b=GUjqNdTvfkvoHHU0ej2hweGWKlKcVuIKt8FnJG30XeLSCm6NZE0xoF6HFXRMWxxN6vSnopl15oKbkzCXWFG/Dkh/sZxADaKPaFmrrdj8qMsh/1rdVomIDzrfoEs3WxZ6v4gDIbikfp1RycsT7Yjd2tBmhNTVbNfjn5pQPChEDiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001886; c=relaxed/simple;
	bh=lhOwOqPhl971dY4LuEdUW624D+07j1rE76HNPErVRMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EE6VYE6HUR1yNs4CcNK+9qCSWS66mxpOHBtsNZcw+BmwHN6O+mC3JHKRGlpBBIPZmXgWyD6tetYB7W3HPkDQtTDEQl41s5jgSIq3yHq9kVw/3Rx05wfoqwS6gCSQGVnx4whNy7UZn+kp+YeJdNsjV97iO4V2ZgeFe+aM8fh7jms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu0C3o41; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so956555a12.1
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 09:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731001883; x=1731606683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbZpL19J8+oXwnEW3To+0SjnpH8PqYyqRnaDJVKi96I=;
        b=Cu0C3o41ipzRgcePFMQM+A4qa0sMVPP55WhnhQXm+9xQpXbx0YwxQ9C7YVM8SVm4MZ
         4vOwUApk2Xa7ZgZDbwxItob0Ve/hlFTagzewejAH+JstKB3TFFB3pOCIaJGTZhT5RuYX
         9/t481B1PzEy38GC13MPUKTCh6UX7so5trfw5Oz04o0IVcM8rnXTesAZ2dR4J3dEE5By
         8ckqOwxMM9kvFAgjK0Uzw5JxbN0EfnCibzH0o3IqASNkZBPg2kvy2JmPirG6Je2iwc7e
         fEHjz6DBboQnl3FAXZ3hvL1exb2Hl7cV1XJ1GSToacO+kYCM7XhsLUX4U3clo9C+WjJx
         /7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731001883; x=1731606683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbZpL19J8+oXwnEW3To+0SjnpH8PqYyqRnaDJVKi96I=;
        b=EnD0RJDuA7u2WYEG8MdHOj6qUzsre1DBpNY5IN/Q7Cl9p3d+Vs6N10pfbYnTM4TSTm
         K1PtILQZVmSRsGBKVjNXr7PssTcJa8eywXnjAKmYGYtMdT1XdEqh2r0JVDroFf53bcSt
         y8t8bCnSwbC9zFP4sX/MyzbSL9Vs/rgrzojX2tD3wOuyrzxIo+9guuespbBnil2OGDSS
         +cii7ABhoUO2iusZstm4wVA7GZOzz0jwMNMR9toO74cNAPoekSIr1xtA7s/iJ+OVGbwr
         JG4fssWrS7QHtCfj+qFYNkn0OuXh1p1El67cP0LHzigTVYuiLQUuyBKIK/Q5ji7p6oxk
         Dk+Q==
X-Gm-Message-State: AOJu0Ywz1zEFNtasEryNQy4HOFSM42f3Y7HdyFQ5EKnY+/5uzwPveV+M
	nqlO3VCOMjNxfj5g1tDukWsYn3Yf2W5llZfK6D3eWF8PnEdgPuitHyJGyPaZ
X-Google-Smtp-Source: AGHT+IGfAWGoR7z0hZ9Y7Jh/WZK6vlNUpohcrgZUMZ5yDw4JjSkWv6g1WCXSBV2bSyNai03Oi8/eJA==
X-Received: by 2002:a05:6a21:99a5:b0:1d8:b8da:d658 with SMTP id adf61e73a8af0-1dc1e397e84mr1342426637.27.1731001883294;
        Thu, 07 Nov 2024 09:51:23 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f52b32sm1730686a91.5.2024.11.07.09.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:51:22 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 10/11] selftests/bpf: tests to verify handling of inlined kfuncs
Date: Thu,  7 Nov 2024 09:50:39 -0800
Message-ID: <20241107175040.1659341-11-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107175040.1659341-1-eddyz87@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that:
- kfunc callsites are treated independently;
- scalar parameters range is known in the inlined body;
- null pointer parameters are known as null in the inlined body;
- type of dynptr parameters is known in the inlined body;
- memory references are passed as KERNEL_VALUE objects;
- callee saved registers r6-r9 are spilled/filled at before/after
  inlined body;
- r10 escapes in kfunc body.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/bpf_testmod/Makefile        |  24 +-
 .../{bpf_testmod.c => bpf_testmod_core.c}     |  25 ++
 .../bpf/bpf_testmod/test_inlinable_kfuncs.c   | 132 +++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   7 +
 .../bpf/progs/verifier_inlinable_kfuncs.c     | 253 ++++++++++++++++++
 5 files changed, 440 insertions(+), 1 deletion(-)
 rename tools/testing/selftests/bpf/bpf_testmod/{bpf_testmod.c => bpf_testmod_core.c} (97%)
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/test_inlinable_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_inlinable_kfuncs.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/Makefile b/tools/testing/selftests/bpf/bpf_testmod/Makefile
index 15cb36c4483a..242669a6954a 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/Makefile
+++ b/tools/testing/selftests/bpf/bpf_testmod/Makefile
@@ -10,7 +10,9 @@ endif
 MODULES = bpf_testmod.ko
 
 obj-m += bpf_testmod.o
-CFLAGS_bpf_testmod.o = -I$(src)
+CFLAGS_bpf_testmod_core.o = -I$(src)
+
+bpf_testmod-y := bpf_testmod_core.o test_inlinable_kfuncs.o
 
 all:
 	+$(Q)make -C $(KDIR) M=$(BPF_TESTMOD_DIR) modules
@@ -18,3 +20,23 @@ all:
 clean:
 	+$(Q)make -C $(KDIR) M=$(BPF_TESTMOD_DIR) clean
 
+ifdef CONFIG_CC_IS_CLANG
+
+CLANG ?= $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
+LLC ?= $(LLVM_PREFIX)llc$(LLVM_SUFFIX)
+
+CFLAGS_REMOVE_test_inlinable_kfuncs.bpf.bc.o += $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_test_inlinable_kfuncs.bpf.bc.o += $(PADDING_CFLAGS)
+CFLAGS_test_inlinable_kfuncs.bpf.bc.o += -D__FOR_BPF
+$(obj)/test_inlinable_kfuncs.bpf.bc.o: $(src)/test_inlinable_kfuncs.c
+	$(Q)$(CLANG) $(c_flags) -emit-llvm -c $< -o $@
+
+$(obj)/test_inlinable_kfuncs.bpf.o: $(obj)/test_inlinable_kfuncs.bpf.bc.o
+	$(Q)$(LLC) -mcpu=v3 --mtriple=bpf --filetype=obj $< -o $@
+
+$(obj)/test_inlinable_kfuncs.bpf.linked.o: $(obj)/test_inlinable_kfuncs.bpf.o
+	$(Q)$(BPFTOOL) gen object $@ $<
+
+$(obj)/bpf_testmod_core.o: $(obj)/test_inlinable_kfuncs.bpf.linked.o
+
+endif
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_core.c
similarity index 97%
rename from tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
rename to tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_core.c
index 987d41af71d2..586b752ad6eb 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_core.c
@@ -586,6 +586,14 @@ BTF_ID_FLAGS(func, bpf_kfunc_trusted_num_test, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_rcu_task_test, KF_RCU)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_test_inline_kfunc1)
+BTF_ID_FLAGS(func, bpf_test_inline_kfunc2)
+BTF_ID_FLAGS(func, bpf_test_inline_kfunc3)
+BTF_ID_FLAGS(func, bpf_test_inline_kfunc4)
+BTF_ID_FLAGS(func, bpf_test_inline_kfunc5)
+BTF_ID_FLAGS(func, bpf_test_inline_kfunc6)
+BTF_ID_FLAGS(func, bpf_test_inline_kfunc7)
+BTF_ID_FLAGS(func, bpf_test_inline_kfunc8)
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
 
 BTF_ID_LIST(bpf_testmod_dtor_ids)
@@ -1315,6 +1323,19 @@ static struct bpf_struct_ops testmod_st_ops = {
 
 extern int bpf_fentry_test1(int a);
 
+asm (
+"	.pushsection .data, \"a\"			\n"
+"	.global test_inlinable_kfuncs_data		\n"
+"test_inlinable_kfuncs_data:				\n"
+"	.incbin \"test_inlinable_kfuncs.bpf.linked.o\"	\n"
+"	.global test_inlinable_kfuncs_data_end		\n"
+"test_inlinable_kfuncs_data_end:				\n"
+"	.popsection					\n"
+);
+
+extern void test_inlinable_kfuncs_data;
+extern void test_inlinable_kfuncs_data_end;
+
 static int bpf_testmod_init(void)
 {
 	const struct btf_id_dtor_kfunc bpf_testmod_dtors[] = {
@@ -1337,6 +1358,9 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_id_dtor_kfuncs(bpf_testmod_dtors,
 						 ARRAY_SIZE(bpf_testmod_dtors),
 						 THIS_MODULE);
+	ret = ret ?: bpf_register_inlinable_kfuncs(&test_inlinable_kfuncs_data,
+						 &test_inlinable_kfuncs_data_end - &test_inlinable_kfuncs_data,
+						 THIS_MODULE);
 	if (ret < 0)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
@@ -1373,6 +1397,7 @@ static void bpf_testmod_exit(void)
 	bpf_kfunc_close_sock();
 	sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
 	unregister_bpf_testmod_uprobe();
+	bpf_unregister_inlinable_kfuncs(THIS_MODULE);
 }
 
 module_init(bpf_testmod_init);
diff --git a/tools/testing/selftests/bpf/bpf_testmod/test_inlinable_kfuncs.c b/tools/testing/selftests/bpf/bpf_testmod/test_inlinable_kfuncs.c
new file mode 100644
index 000000000000..d8b90ee7f2b0
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_testmod/test_inlinable_kfuncs.c
@@ -0,0 +1,132 @@
+#include <linux/bpf.h>
+
+#define __imm(name) [name]"i"(name)
+
+__bpf_kfunc int bpf_test_inline_kfunc1(int p);
+__bpf_kfunc int bpf_test_inline_kfunc2(int *p);
+__bpf_kfunc int bpf_test_inline_kfunc3(void *p, u64 p__sz);
+__bpf_kfunc int bpf_test_inline_kfunc4(void);
+__bpf_kfunc int bpf_test_inline_kfunc5(struct bpf_dynptr *d);
+__bpf_kfunc int bpf_test_inline_kfunc6(void);
+__bpf_kfunc int bpf_test_inline_kfunc7(void);
+__bpf_kfunc int bpf_test_inline_kfunc8(void);
+
+#ifdef __FOR_BPF
+__attribute__((naked))
+int bpf_test_inline_kfunc1(int p)
+{
+	asm volatile (
+		"r0 = 42;"
+		"if r1 != 1 goto +1;"
+		"r0 = 11;"
+		"if r1 != 2 goto +1;"
+		"r0 = 22;"
+		"exit;"
+	);
+}
+
+__attribute__((naked))
+int bpf_test_inline_kfunc2(int *p)
+{
+	asm volatile (
+		"r0 = 42;"
+		"if r1 != 0 goto +1;"
+		"r0 = 24;"
+		"exit;"
+	);
+}
+
+__attribute__((naked))
+int bpf_test_inline_kfunc3(void *p, u64 p__sz)
+{
+	asm volatile (
+		"r1 = *(u64 *)(r1 + 0);"
+		"*(u64 *)(r1 + 0) = 42;"
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+__attribute__((naked))
+int bpf_test_inline_kfunc4(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"r1 = 1;"
+		"r2 = 2;"
+		"r6 = 3;"
+		"r7 = 4;"
+		"exit;"
+	);
+}
+
+__attribute__((naked))
+int bpf_test_inline_kfunc5(struct bpf_dynptr *d)
+{
+	asm volatile (
+		"   r1 = *(u32 *)(r1 + 8);"
+		"   r1 &= %[INV_RDONLY_BIT];"
+		"   r1 >>= %[TYPE_SHIFT];"
+		"   if r1 != %[BPF_DYNPTR_TYPE_SKB] goto 1f;"
+		"   r0 = 1;"
+		"   goto 3f;"
+		"1: if r1 != %[BPF_DYNPTR_TYPE_XDP] goto 2f;"
+		"   r0 = 2;"
+		"   goto 3f;"
+		"2: r0 = 3;"
+		"3: exit;"
+	:: __imm(BPF_DYNPTR_TYPE_SKB),
+	   __imm(BPF_DYNPTR_TYPE_XDP),
+	   [INV_RDONLY_BIT]"i"(~DYNPTR_RDONLY_BIT),
+	   [TYPE_SHIFT]"i"(DYNPTR_TYPE_SHIFT));
+}
+
+__attribute__((naked))
+int bpf_test_inline_kfunc6(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 8) = r0;"
+		"r0 = *(u64 *)(r10 - 8);"
+		"r6 = 1;"
+		"exit;"
+	);
+}
+
+__attribute__((naked))
+int bpf_test_inline_kfunc7(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 8) = r10;"
+		"exit;"
+	);
+}
+
+__attribute__((naked))
+int bpf_test_inline_kfunc8(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"r1 = r10;"
+		"exit;"
+	);
+}
+
+#endif  /* __FOR_BPF */
+
+#ifndef __FOR_BPF
+
+/* Only interested in BPF assembly bodies of these functions, keep dummy bodies */
+__bpf_kfunc int bpf_test_inline_kfunc1(int p) { return 0; }
+__bpf_kfunc int bpf_test_inline_kfunc2(int *p) { return 0; }
+__bpf_kfunc int bpf_test_inline_kfunc3(void *p, u64 p__sz) { return 0; }
+__bpf_kfunc int bpf_test_inline_kfunc4(void) { return 0; }
+__bpf_kfunc int bpf_test_inline_kfunc5(struct bpf_dynptr *p) { return 0; }
+__bpf_kfunc int bpf_test_inline_kfunc6(void) { return 0; }
+__bpf_kfunc int bpf_test_inline_kfunc7(void) { return 0; }
+__bpf_kfunc int bpf_test_inline_kfunc8(void) { return 0; }
+
+#endif /* __FOR_BPF not defined */
+
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index efd42c07f58a..730631603870 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -78,6 +78,7 @@
 #include "verifier_spill_fill.skel.h"
 #include "verifier_spin_lock.skel.h"
 #include "verifier_stack_ptr.skel.h"
+#include "verifier_inlinable_kfuncs.skel.h"
 #include "verifier_subprog_precision.skel.h"
 #include "verifier_subreg.skel.h"
 #include "verifier_tailcall_jit.skel.h"
@@ -291,3 +292,9 @@ void test_verifier_value_ptr_arith(void)
 		      verifier_value_ptr_arith__elf_bytes,
 		      init_value_ptr_arith_maps);
 }
+
+/* Do not drop CAP_SYS_ADMIN for these tests */
+void test_verifier_inlinable_kfuncs(void)
+{
+	RUN_TESTS(verifier_inlinable_kfuncs);
+}
diff --git a/tools/testing/selftests/bpf/progs/verifier_inlinable_kfuncs.c b/tools/testing/selftests/bpf/progs/verifier_inlinable_kfuncs.c
new file mode 100644
index 000000000000..bd1cf5f5956c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_inlinable_kfuncs.c
@@ -0,0 +1,253 @@
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+#include <stdbool.h>
+#include "bpf_kfuncs.h"
+
+extern int bpf_test_inline_kfunc1(int p) __ksym;
+extern int bpf_test_inline_kfunc2(int *p) __ksym;
+extern int bpf_test_inline_kfunc3(void *p, __u64 p__sz) __ksym;
+extern int bpf_test_inline_kfunc4(void) __ksym;
+extern int bpf_test_inline_kfunc5(const struct bpf_dynptr *p) __ksym;
+extern int bpf_test_inline_kfunc6(void) __ksym;
+extern int bpf_test_inline_kfunc7(void) __ksym;
+extern int bpf_test_inline_kfunc8(void) __ksym;
+
+SEC("socket")
+/* verify that scalar params are marked as precise */
+__log_level(2)
+/* first call to kfunc */
+__msg("1: (85) call bpf_test_inline_kfunc1")
+__msg("mark_precise: frame0: last_idx 1 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 1")
+/* second call to kfunc */
+__msg("3: (85) call bpf_test_inline_kfunc1")
+__msg("mark_precise: frame0: last_idx 3 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r1 stack= before 2: (b7) r1 = 2")
+/* check that dead code elimination took place independently for both callsites */
+__xlated("0: r1 = 1")
+__xlated("1: r0 = 42")
+__xlated("2: r0 = 11")
+__xlated("3: goto pc+0")
+__xlated("4: r1 = 2")
+__xlated("5: r0 = 42")
+__xlated("6: r0 = 22")
+__xlated("7: goto pc+0")
+__xlated("8: exit")
+__success
+__naked void two_callsites_scalar_param(void)
+{
+	asm volatile (
+		"r1 = 1;"
+		"call %[bpf_test_inline_kfunc1];"
+		"r1 = 2;"
+		"call %[bpf_test_inline_kfunc1];"
+		"exit;"
+		:
+		: __imm(bpf_test_inline_kfunc1)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__xlated("0: r1 = 0")
+__xlated("1: r0 = 42")
+__xlated("2: r0 = 24")
+__xlated("3: goto pc+0")
+__xlated("4: exit")
+__success
+__naked void param_null(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"call %[bpf_test_inline_kfunc2];"
+		"exit;"
+		:
+		: __imm(bpf_test_inline_kfunc2)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__xlated("0: r1 = r10")
+__xlated("1: r1 += -8")
+__xlated("2: r2 = 8")
+__xlated("3: r1 = *(u64 *)(r1 +0)")
+__xlated("4: *(u64 *)(r1 +0) = 42")
+__xlated("5: r0 = 0")
+__xlated("6: goto pc+0")
+__xlated("7: exit")
+__success
+__naked void param_kernel_value(void)
+{
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 8;"
+		"call %[bpf_test_inline_kfunc3];"
+		"exit;"
+		:
+		: __imm(bpf_test_inline_kfunc3)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__xlated("0: *(u64 *)(r10 -128) = r1")
+__xlated("1: *(u64 *)(r10 -136) = r6")
+__xlated("2: *(u64 *)(r10 -144) = r7")
+__xlated("3: r0 = 0")
+__xlated("4: r1 = 1")
+__xlated("5: r2 = 2")
+__xlated("6: r6 = 3")
+__xlated("7: r7 = 4")
+__xlated("8: goto pc+0")
+__xlated("9: r7 = *(u64 *)(r10 -144)")
+__xlated("10: r6 = *(u64 *)(r10 -136)")
+__xlated("11: r1 = *(u64 *)(r10 -128)")
+__xlated("12: exit")
+__success
+__naked void clobbered_regs(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 128) = r1;"
+		"call %[bpf_test_inline_kfunc4];"
+		"r1 = *(u64 *)(r10 - 128);"
+		"exit;"
+		:
+		: __imm(bpf_test_inline_kfunc4)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__xlated("0: *(u64 *)(r10 -32) = r1")
+__xlated("1: *(u64 *)(r10 -40) = r6")
+__xlated("2: r0 = 0")
+__xlated("3: *(u64 *)(r10 -48) = r0")
+__xlated("4: r0 = *(u64 *)(r10 -48)")
+__xlated("5: r6 = 1")
+__xlated("6: goto pc+0")
+__xlated("7: r6 = *(u64 *)(r10 -40)")
+__xlated("8: r1 = *(u64 *)(r10 -32)")
+__xlated("9: exit")
+__success
+__naked void clobbered_regs_and_stack(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 32) = r1;"
+		"call %[bpf_test_inline_kfunc6];"
+		"r1 = *(u64 *)(r10 - 32);"
+		"exit;"
+		:
+		: __imm(bpf_test_inline_kfunc6)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__xlated("0: call kernel-function")
+__xlated("1: exit")
+__success
+__naked void r10_escapes1(void)
+{
+	asm volatile (
+		"call %[bpf_test_inline_kfunc7];"
+		"exit;"
+		:
+		: __imm(bpf_test_inline_kfunc7)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__xlated("0: call kernel-function")
+__xlated("1: exit")
+__success
+__naked void r10_escapes2(void)
+{
+	asm volatile (
+		"call %[bpf_test_inline_kfunc8];"
+		"exit;"
+		:
+		: __imm(bpf_test_inline_kfunc8)
+		: __clobber_all
+	);
+}
+
+SEC("xdp")
+__xlated("5: r1 = r10")
+__xlated("6: r1 += -16")
+__xlated("7: r1 = *(u32 *)(r1 +8)")
+__xlated("8: r1 &= ")
+__xlated("9: r1 >>= ")
+__xlated("10: r0 = 2")
+__xlated("11: goto pc+0")
+__xlated("12: exit")
+__success
+__naked void param_dynptr1(void)
+{
+	asm volatile (
+		"r1 = r1;"
+		"r2 = 0;"
+		"r3 = r10;"
+		"r3 += -16;"
+		"call %[bpf_dynptr_from_xdp];"
+		"r1 = r10;"
+		"r1 += -16;"
+		"call %[bpf_test_inline_kfunc5];"
+		"exit;"
+		:
+		: __imm(bpf_test_inline_kfunc5),
+		  __imm(bpf_dynptr_from_xdp)
+		: __clobber_all
+	);
+}
+
+SEC("cgroup_skb/egress")
+__xlated("5: r1 = r10")
+__xlated("6: r1 += -16")
+__xlated("7: r1 = *(u32 *)(r1 +8)")
+__xlated("8: r1 &= ")
+__xlated("9: r1 >>= ")
+__xlated("10: r0 = 1")
+__xlated("11: goto pc+0")
+__xlated("12: r0 &= 3")
+__xlated("13: exit")
+__success
+__naked void param_dynptr2(void)
+{
+	asm volatile (
+		"r1 = r1;"
+		"r2 = 0;"
+		"r3 = r10;"
+		"r3 += -16;"
+		"call %[bpf_dynptr_from_skb];"
+		"r1 = r10;"
+		"r1 += -16;"
+		"call %[bpf_test_inline_kfunc5];"
+		"r0 &= 3;"
+		"exit;"
+		:
+		: __imm(bpf_test_inline_kfunc5),
+		  __imm(bpf_dynptr_from_skb)
+		: __clobber_all
+	);
+}
+
+void __kfunc_btf_root(void)
+{
+	bpf_test_inline_kfunc1(0);
+	bpf_test_inline_kfunc2(0);
+	bpf_test_inline_kfunc3(0, 0);
+	bpf_test_inline_kfunc4();
+	bpf_test_inline_kfunc5(0);
+	bpf_test_inline_kfunc6();
+	bpf_test_inline_kfunc7();
+	bpf_test_inline_kfunc8();
+	bpf_dynptr_from_skb(0, 0, 0);
+	bpf_dynptr_from_xdp(0, 0, 0);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.0


