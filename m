Return-Path: <bpf+bounces-28436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EAB8B9AC7
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 14:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74726B2401A
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 12:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF25084DF5;
	Thu,  2 May 2024 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2ne8OiY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2887F65E20;
	Thu,  2 May 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714652650; cv=none; b=Kgow0IuGlYGwxbXtbSRRW3MNdxI0u6Am6YgCxwFfecaRSuUUApIXndT3soSSPAkYJ6zszXL1ztSQl3OMzfTFnKNKsgLtMiKluBLy/1zJBizaBVmwzfN1BROs2qtUsJKXGw+5HVhGaj0DiunByynkuoWMqctLGbu6hzna5OAHClY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714652650; c=relaxed/simple;
	bh=i71ywxUeskPv7X2cS5R4+uhw8eVE+iyv8HMxABm6vMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=us2TTM2p940fFTDgUI8iI/YKIzX1JUAOWnLjqi1IeydNcpU8ddJVdwYQFsEC5vmeAWIPwM4SCA+bDGHo9b6jlZqUGjNUIETMVeBHYd16iT8JRiKT4i82GBh+jcCJatsaH9qOoBc8lsHkg3uNZh45XeoxGoPrBc8u6FPNhgRZLTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2ne8OiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AFAC113CC;
	Thu,  2 May 2024 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714652649;
	bh=i71ywxUeskPv7X2cS5R4+uhw8eVE+iyv8HMxABm6vMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2ne8OiYCUdk2LwVmCsAW87c2foWTYTVVQswoiIr3gkeDC7XFho2CZTtWqLbvY9kD
	 FR+ST2Qs0PwdxM1qyjgSsFT3NX0XsWi30tl2TTxuMyE1WxuSNc/tgdXQ4uAQlyJAge
	 4TUB8epf4nHWVMZTYlihIOp0Jv3Z1DIin+c7nJ94aY1yKTO7TpDNvzCChBl+vfXADh
	 t6lJbNBdq0AfTZmChiAmfoOAqthVQhlmGfTbU9RbdUgWxewAKO1Dz6UlXPDXixi9CK
	 sYwExxq+1hBZrl4krd5NsyEYRTPSw29NNaKHIf8/tjWTqwKREu25AiAPfV4uRAZAnn
	 JkL9VmK8yRu+w==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCHv4 bpf-next 4/7] selftests/bpf: Add uretprobe syscall test for regs changes
Date: Thu,  2 May 2024 14:23:10 +0200
Message-ID: <20240502122313.1579719-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502122313.1579719-1-jolsa@kernel.org>
References: <20240502122313.1579719-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that creates uprobe consumer on uretprobe which changes some
of the registers. Making sure the changed registers are propagated to the
user space when the ureptobe syscall trampoline is used on x86_64.

To be able to do this, adding support to bpf_testmod to create uprobe via
new attribute file:
  /sys/kernel/bpf_testmod_uprobe

This file is expecting file offset and creates related uprobe on current
process exe file and removes existing uprobe if offset is 0. The can be
only single uprobe at any time.

The uprobe has specific consumer that changes registers used in ureprobe
syscall trampoline and which are later checked in the test.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 123 +++++++++++++++++-
 .../selftests/bpf/prog_tests/uprobe_syscall.c |  67 ++++++++++
 2 files changed, 189 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index eb2b78552ca2..27a12d125b9f 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -10,6 +10,7 @@
 #include <linux/percpu-defs.h>
 #include <linux/sysfs.h>
 #include <linux/tracepoint.h>
+#include <linux/namei.h>
 #include "bpf_testmod.h"
 #include "bpf_testmod_kfunc.h"
 
@@ -343,6 +344,119 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
 	.write = bpf_testmod_test_write,
 };
 
+/* bpf_testmod_uprobe sysfs attribute is so far enabled for x86_64 only,
+ * please see test_uretprobe_regs_change test
+ */
+#ifdef __x86_64__
+
+static int
+uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
+		   struct pt_regs *regs)
+
+{
+	regs->ax  = 0x12345678deadbeef;
+	regs->cx  = 0x87654321feebdaed;
+	regs->r11 = (u64) -1;
+	return true;
+}
+
+struct testmod_uprobe {
+	struct path path;
+	loff_t offset;
+	struct uprobe_consumer consumer;
+};
+
+static DEFINE_MUTEX(testmod_uprobe_mutex);
+
+static struct testmod_uprobe uprobe = {
+	.consumer.ret_handler = uprobe_ret_handler,
+};
+
+static int testmod_register_uprobe(loff_t offset)
+{
+	int err = -EBUSY;
+
+	if (uprobe.offset)
+		return -EBUSY;
+
+	mutex_lock(&testmod_uprobe_mutex);
+
+	if (uprobe.offset)
+		goto out;
+
+	err = kern_path("/proc/self/exe", LOOKUP_FOLLOW, &uprobe.path);
+	if (err)
+		goto out;
+
+	err = uprobe_register_refctr(d_real_inode(uprobe.path.dentry),
+				     offset, 0, &uprobe.consumer);
+	if (err)
+		path_put(&uprobe.path);
+	else
+		uprobe.offset = offset;
+
+out:
+	mutex_unlock(&testmod_uprobe_mutex);
+	return err;
+}
+
+static void testmod_unregister_uprobe(void)
+{
+	mutex_lock(&testmod_uprobe_mutex);
+
+	if (uprobe.offset) {
+		uprobe_unregister(d_real_inode(uprobe.path.dentry),
+				  uprobe.offset, &uprobe.consumer);
+		uprobe.offset = 0;
+	}
+
+	mutex_unlock(&testmod_uprobe_mutex);
+}
+
+static ssize_t
+bpf_testmod_uprobe_write(struct file *file, struct kobject *kobj,
+			 struct bin_attribute *bin_attr,
+			 char *buf, loff_t off, size_t len)
+{
+	unsigned long offset;
+	int err;
+
+	if (kstrtoul(buf, 0, &offset))
+		return -EINVAL;
+
+	if (offset)
+		err = testmod_register_uprobe(offset);
+	else
+		testmod_unregister_uprobe();
+
+	return err ?: strlen(buf);
+}
+
+static struct bin_attribute bin_attr_bpf_testmod_uprobe_file __ro_after_init = {
+	.attr = { .name = "bpf_testmod_uprobe", .mode = 0666, },
+	.write = bpf_testmod_uprobe_write,
+};
+
+static int register_bpf_testmod_uprobe(void)
+{
+	return sysfs_create_bin_file(kernel_kobj, &bin_attr_bpf_testmod_uprobe_file);
+}
+
+static void unregister_bpf_testmod_uprobe(void)
+{
+	testmod_unregister_uprobe();
+	sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_uprobe_file);
+}
+
+#else
+static int register_bpf_testmod_uprobe(void)
+{
+	return 0;
+}
+
+static void unregister_bpf_testmod_uprobe(void) { }
+#endif
+
 BTF_KFUNCS_START(bpf_testmod_common_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
@@ -655,7 +769,13 @@ static int bpf_testmod_init(void)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
 		return -EINVAL;
-	return sysfs_create_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
+	ret = sysfs_create_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
+	if (ret < 0)
+		return ret;
+	ret = register_bpf_testmod_uprobe();
+	if (ret < 0)
+		return ret;
+	return 0;
 }
 
 static void bpf_testmod_exit(void)
@@ -669,6 +789,7 @@ static void bpf_testmod_exit(void)
 		msleep(20);
 
 	sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
+	unregister_bpf_testmod_uprobe();
 }
 
 module_init(bpf_testmod_init);
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 311ac19d8992..1a50cd35205d 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -149,15 +149,82 @@ static void test_uretprobe_regs_equal(void)
 cleanup:
 	uprobe_syscall__destroy(skel);
 }
+
+#define BPF_TESTMOD_UPROBE_TEST_FILE "/sys/kernel/bpf_testmod_uprobe"
+
+static int write_bpf_testmod_uprobe(unsigned long offset)
+{
+	size_t n, ret;
+	char buf[30];
+	int fd;
+
+	n = sprintf(buf, "%lu", offset);
+
+	fd = open(BPF_TESTMOD_UPROBE_TEST_FILE, O_WRONLY);
+	if (fd < 0)
+		return -errno;
+
+	ret = write(fd, buf, n);
+	close(fd);
+	return ret != n ? (int) ret : 0;
+}
+
+static void test_uretprobe_regs_change(void)
+{
+	struct pt_regs before = {}, after = {};
+	unsigned long *pb = (unsigned long *) &before;
+	unsigned long *pa = (unsigned long *) &after;
+	unsigned long cnt = sizeof(before)/sizeof(*pb);
+	unsigned int i, err, offset;
+
+	offset = get_uprobe_offset(uretprobe_regs_trigger);
+
+	err = write_bpf_testmod_uprobe(offset);
+	if (!ASSERT_OK(err, "register_uprobe"))
+		return;
+
+	uretprobe_regs(&before, &after);
+
+	err = write_bpf_testmod_uprobe(0);
+	if (!ASSERT_OK(err, "unregister_uprobe"))
+		return;
+
+	for (i = 0; i < cnt; i++) {
+		unsigned int offset = i * sizeof(unsigned long);
+
+		switch (offset) {
+		case offsetof(struct pt_regs, rax):
+			ASSERT_EQ(pa[i], 0x12345678deadbeef, "rax");
+			break;
+		case offsetof(struct pt_regs, rcx):
+			ASSERT_EQ(pa[i], 0x87654321feebdaed, "rcx");
+			break;
+		case offsetof(struct pt_regs, r11):
+			ASSERT_EQ(pa[i], (__u64) -1, "r11");
+			break;
+		default:
+			if (!ASSERT_EQ(pa[i], pb[i], "register before-after value check"))
+				fprintf(stdout, "failed register offset %u\n", offset);
+		}
+	}
+}
+
 #else
 static void test_uretprobe_regs_equal(void)
 {
 	test__skip();
 }
+
+static void test_uretprobe_regs_change(void)
+{
+	test__skip();
+}
 #endif
 
 void test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
 		test_uretprobe_regs_equal();
+	if (test__start_subtest("uretprobe_regs_change"))
+		test_uretprobe_regs_change();
 }
-- 
2.44.0


