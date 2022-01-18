Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D668449242C
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 11:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbiARK5v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 05:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiARK5u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jan 2022 05:57:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8EFC061574
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 02:57:50 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ay4-20020a05600c1e0400b0034a81a94607so6329349wmb.1
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 02:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=e1A3tenjbgnzf93o+Ay1kHDcZptx9l3ljpAq4yyfwg4=;
        b=fRx/efporAsgFBWZkFvO55nWfwtyV7ydgTHL1LQTDUD1bemeCqnUR9qANlVNjNhskM
         zuAq+JzVrUL7T+6XmP+rSicfXOWh5ADLhH8Ymkt44iOIXOMs4Sky1O60IY5L9dIpanxh
         clnXjykWMta2U/lf+b2EBDVvBVNGXWW5mZVpeva7gDr4uh9bgzAdH0/5SziBaI4Zo0aB
         64YUzVzT0PQm4FPrvL6F4PzOx0mFDwjQXdgW7gkp7wzPDnKFprRYZWvlBW98GxUv2Gl7
         penIsKsPywLG3QgH4nHOjafMq8Vx8Z3QyhsDwQasebA38ma5ZoG/TP4LoV9MQgVqDlSa
         3Upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=e1A3tenjbgnzf93o+Ay1kHDcZptx9l3ljpAq4yyfwg4=;
        b=aYqD+/0f3qjAjiilePIoIiKDMXU2hUcyKrBfY91biZnMLEvcxqkuKYHevwQ7ncLteS
         FHTehM1QI6v3/SJmhGIz2A8lMpGKWd/Xz4aLVj1boHKbHuEXqM1zEcUU5wgZnzunZcmI
         calShMGSgE8VING+m4nzCggurG+m1TVAqym5PYQMeNn87+dxBcH/6YoUscipt9TxeXQH
         lJNrK1spnBR/PIErXR/bb+1mzKhWFrgrkyR/+6SLgcdyEOolJ8rUFb5SU8QuFriTvjdI
         uzQvy28oNWK2pNW5Fi6QFuHDSgDHUoRosLv0qbCMLI27Pq2lVhpULO44h7YTPtXB6shW
         RqxA==
X-Gm-Message-State: AOAM531/FYiaqobAbEd/XwMSbW8IrFqZcPv92vi7rcVR732jn4t5d4Ga
        dAoFGcklQbMPYp+nZOnd3YdGntXTwAVKW4Kl
X-Google-Smtp-Source: ABdhPJzt2D0sGpKF03gqXBNvuGU8cZBZW29eXIzYwdUszD76Io/ioPSYCaA1+7+kMuk31v918C9Rkw==
X-Received: by 2002:a5d:4582:: with SMTP id p2mr1869450wrq.130.1642503469098;
        Tue, 18 Jan 2022 02:57:49 -0800 (PST)
Received: from debian ([78.32.147.104])
        by smtp.gmail.com with ESMTPSA id f13sm14368788wri.35.2022.01.18.02.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 02:57:48 -0800 (PST)
Date:   Tue, 18 Jan 2022 10:57:47 +0000
From:   "Gabriele N. Tornetta" <phoenix1987@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     "Gabriele N. Tornetta" <phoenix1987@gmail.com>
Subject: [PATCH bpf-next 1/1] bpf: Add bpf_copy_from_user_remote to read a
 process VM given its PID.
Message-ID: <YeadK5ykhh7slnXL@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new BPF helper to read the VM of a process identified by PID.
Whilst PIDs are ambiguous without a namespace, many traditional
observability tools, like profilers and debuggers, accept a PID to
attach to a running process. The new helper proposed by this patch
is aimed at providing the capability of reading a remote process VM
to similar tools.

Signed-off-by: Gabriele N. Tornetta <phoenix1987@gmail.com>
---
 include/linux/bpf.h                           |  1 +
 include/uapi/linux/bpf.h                      |  9 +++++++
 kernel/bpf/helpers.c                          | 26 +++++++++++++++++++
 kernel/trace/bpf_trace.c                      |  2 ++
 scripts/bpf_doc.py                            |  1 +
 tools/include/uapi/linux/bpf.h                |  9 +++++++
 .../selftests/bpf/prog_tests/test_lsm.c       |  7 +++++
 tools/testing/selftests/bpf/progs/lsm.c       | 18 +++++++++++++
 8 files changed, 73 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6e947cd91152..96efa8912bbd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2222,6 +2222,7 @@ extern const struct bpf_func_proto bpf_kallsyms_lookup_name_proto;
 extern const struct bpf_func_proto bpf_find_vma_proto;
 extern const struct bpf_func_proto bpf_loop_proto;
 extern const struct bpf_func_proto bpf_strncmp_proto;
+extern const struct bpf_func_proto bpf_copy_from_user_remote_proto;
 
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b0383d371b9a..167ec1bc7248 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5018,6 +5018,14 @@ union bpf_attr {
  *
  *	Return
  *		The number of arguments of the traced function.
+ *
+ * long bpf_copy_from_user_remote(void *dst, u32 size, pid_t pid, const void *user_ptr)
+ *	Description
+ *		Read *size* bytes from user space address *user_ptr* of the prodess
+ *		*pid* and store the data in *dst*. This is essentially a wrapper of
+ *		**access_process_vm**\ ().
+ *	Return
+ *		The number of bytes read on success, or a negative error in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5206,6 +5214,7 @@ union bpf_attr {
 	FN(get_func_arg),		\
 	FN(get_func_ret),		\
 	FN(get_func_arg_cnt),		\
+	FN(copy_from_user_remote),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 01cfdf40c838..c055eec77466 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -16,6 +16,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/security.h>
+#include <linux/mm.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -671,6 +672,31 @@ const struct bpf_func_proto bpf_copy_from_user_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_4(bpf_copy_from_user_remote, void *, dst, u32, size,
+	   pid_t, pid, const void __user *, user_ptr)
+{
+	struct task_struct *task;
+
+	if (unlikely(size == 0))
+		return 0;
+
+	task = find_get_task_by_vpid(pid);
+	if (!task)
+		return -ESRCH;
+
+	return access_process_vm(task, (unsigned long)user_ptr, dst, size, 0);
+}
+
+const struct bpf_func_proto bpf_copy_from_user_remote_proto = {
+	.func		= bpf_copy_from_user_remote,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_ANYTHING,
+};
+
 BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
 {
 	if (cpu >= nr_cpu_ids)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 21aa30644219..b30cd5e6d703 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1257,6 +1257,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_find_vma_proto;
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
+	case BPF_FUNC_copy_from_user_remote:
+		return prog->aux->sleepable ? &bpf_copy_from_user_remote_proto : NULL;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index a6403ddf5de7..bd092f1692e2 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -614,6 +614,7 @@ class PrinterHelpers(Printer):
             'const struct sk_buff': 'const struct __sk_buff',
             'struct sk_msg_buff': 'struct sk_msg_md',
             'struct xdp_buff': 'struct xdp_md',
+            "pid_t": "int",
     }
     # Helpers overloaded for different context types.
     overloaded_helpers = [
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b0383d371b9a..167ec1bc7248 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5018,6 +5018,14 @@ union bpf_attr {
  *
  *	Return
  *		The number of arguments of the traced function.
+ *
+ * long bpf_copy_from_user_remote(void *dst, u32 size, pid_t pid, const void *user_ptr)
+ *	Description
+ *		Read *size* bytes from user space address *user_ptr* of the prodess
+ *		*pid* and store the data in *dst*. This is essentially a wrapper of
+ *		**access_process_vm**\ ().
+ *	Return
+ *		The number of bytes read on success, or a negative error in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5206,6 +5214,7 @@ union bpf_attr {
 	FN(get_func_arg),		\
 	FN(get_func_ret),		\
 	FN(get_func_arg_cnt),		\
+	FN(copy_from_user_remote),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/tools/testing/selftests/bpf/prog_tests/test_lsm.c b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
index 244c01125126..71014141c675 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_lsm.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
@@ -56,6 +56,7 @@ static int test_lsm(struct lsm *skel)
 	struct bpf_link *link;
 	int buf = 1234;
 	int err;
+	int fd;
 
 	err = lsm__attach(skel);
 	if (!ASSERT_OK(err, "attach"))
@@ -86,6 +87,12 @@ static int test_lsm(struct lsm *skel)
 
 	ASSERT_EQ(skel->bss->copy_test, 3, "copy_test");
 
+	fd = syscall(__NR_open, "/dev/null", syscall(__NR_getpid));
+	if (fd >= 0)
+		syscall(__NR_close, fd);
+
+	ASSERT_EQ(skel->bss->copy_remote_test, 1, "copy_remote_test");
+
 	lsm__detach(skel);
 
 	skel->bss->copy_test = 0;
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index 33694ef8acfa..469ff988b0e9 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -177,3 +177,21 @@ int BPF_PROG(test_sys_setdomainname, struct pt_regs *regs)
 		copy_test++;
 	return 0;
 }
+
+int copy_remote_test = 0;
+
+SEC("fentry.s/__x64_sys_open")
+int BPF_PROG(test_sys_open, struct pt_regs *regs)
+{
+	void *ptr = (void *)PT_REGS_PARM1(regs);
+	pid_t pid = (pid_t)PT_REGS_PARM2(regs);
+	char path[4];
+	long ret;
+
+	ret = bpf_copy_from_user_remote(&path, sizeof(path), pid, ptr);
+
+	if (ret == sizeof(path) && !__builtin_memcmp("/dev", path, 4))
+		copy_remote_test++;
+
+	return 0;
+}
-- 
2.30.2

