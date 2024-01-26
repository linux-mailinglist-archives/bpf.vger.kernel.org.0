Return-Path: <bpf+bounces-20386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD3383D9B9
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 12:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D62299E66
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 11:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048431B80E;
	Fri, 26 Jan 2024 11:54:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698EB18E29;
	Fri, 26 Jan 2024 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270043; cv=none; b=tN7ApugfrATqZSYXAcfUSu1khDQfz7gd1pdAwxZtDRvvKDr1x5onBiO4eiEvqXBLNjs6vUrLLa7r1ln/sRbf/1+QFvHf3Lj1pKzHuHc2z8X7B3dGxBKpEce6rdCYSJpAfHkNsgk7iQqbS+UxpTtbEpuufcKP/j7Ss5pPn9FJ9YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270043; c=relaxed/simple;
	bh=+mv8iw36yquBwDHN1YjbbaoxbrYUeC0YRNOVzv7XZCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Atw/N+DlSaKHCsWA2M4m6bBQJ0SHJcKxU+s4lq5GRRuREOV8fjk0t15WUs/8fNFFr+ZCGJFdBPTebQrg+q+W3jhpjJufXOHXZ2e+VgqM+TcbAotmC6l30zNaVEryjR7FS2jPs7Vh0gl8wkrhbtVG4kwd/pNiPVIr7tY+KKpxOXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TLx1H03NWz4f3jqg;
	Fri, 26 Jan 2024 19:53:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 678F81A0272;
	Fri, 26 Jan 2024 19:53:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ42nbNllmgoCA--.1892S7;
	Fri, 26 Jan 2024 19:53:56 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: x86@kernel.org,
	bpf@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	xingwei lee <xrivendell7@gmail.com>,
	Jann Horn <jannh@google.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	houtao1@huawei.com
Subject: [PATCH bpf v2 3/3] selftest/bpf: Test the read of vsyscall page under x86-64
Date: Fri, 26 Jan 2024 19:54:23 +0800
Message-Id: <20240126115423.3943360-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240126115423.3943360-1-houtao@huaweicloud.com>
References: <20240126115423.3943360-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ42nbNllmgoCA--.1892S7
X-Coremail-Antispam: 1UD129KBjvJXoW3GryrAw18JFWxuF1xWF13CFg_yoW7ZF4Up3
	Z5Aa4akr4fJ342yr4xWws8uFWrZr1kXF45Arn7X3W3ur47Zr95tryIga4qqF15GrsIgrW5
	Xa97Ka95Kr4UJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Under x86-64, when using bpf_probe_read_kernel{_str}() or
bpf_probe_read{_str}() to read vsyscall page, the read may trigger oops,
so add one test case to ensure that the problem is fixed. Beside those
four bpf helpers mentioned above, testing the read of vsyscall page by
using bpf_probe_read_user{_str} and bpf_copy_from_user{_task}() as well.

The test case passes the address of vsyscall page to these six helpers
and checks whether the returned values are expected:

1) For bpf_probe_read_kernel{_str}()/bpf_probe_read{_str}(), the
   expected return value is -ERANGE as shown below:

bpf_probe_read_kernel_common
  copy_from_kernel_nofault
    // false, return -ERANGE
    copy_from_kernel_nofault_allowed

2) For bpf_probe_read_user{_str}(), the expected return value is -EFAULT
   as show below:

bpf_probe_read_user_common
  copy_from_user_nofault
    // false, return -EFAULT
    __access_ok

3) For bpf_copy_from_user(), the expected return value is -EFAULT:

// return -EFAULT
bpf_copy_from_user
  copy_from_user
    _copy_from_user
      // return false
      access_ok

4) For bpf_copy_from_user_task(), the expected return value is -EFAULT:

// return -EFAULT
bpf_copy_from_user_task
  access_process_vm
    // return 0
    vma_lookup()
    // return 0
    expand_stack()

The occurrence of oops depends on the availability of CPU SMAP [1]
feature and there are three possible configurations of vsyscall page in
boot cmd-line: vsyscall={xonly|none|emulate}, so there are totally six
possible combinations. Under all these combinations, the running of the
test case succeeds.

[1]: https://en.wikipedia.org/wiki/Supervisor_Mode_Access_Prevention

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/read_vsyscall.c  | 57 +++++++++++++++++++
 .../selftests/bpf/progs/read_vsyscall.c       | 45 +++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/read_vsyscall.c

diff --git a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
new file mode 100644
index 0000000000000..3405923fe4e65
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2024. Huawei Technologies Co., Ltd */
+#include "test_progs.h"
+#include "read_vsyscall.skel.h"
+
+#if defined(__x86_64__)
+/* For VSYSCALL_ADDR */
+#include <asm/vsyscall.h>
+#else
+/* To prevent build failure on non-x86 arch */
+#define VSYSCALL_ADDR 0UL
+#endif
+
+struct read_ret_desc {
+	const char *name;
+	int ret;
+} all_read[] = {
+	{ .name = "probe_read_kernel", .ret = -ERANGE },
+	{ .name = "probe_read_kernel_str", .ret = -ERANGE },
+	{ .name = "probe_read", .ret = -ERANGE },
+	{ .name = "probe_read_str", .ret = -ERANGE },
+	{ .name = "probe_read_user", .ret = -EFAULT },
+	{ .name = "probe_read_user_str", .ret = -EFAULT },
+	{ .name = "copy_from_user", .ret = -EFAULT },
+	{ .name = "copy_from_user_task", .ret = -EFAULT },
+};
+
+void test_read_vsyscall(void)
+{
+	struct read_vsyscall *skel;
+	unsigned int i;
+	int err;
+
+#if !defined(__x86_64__)
+	test__skip();
+	return;
+#endif
+	skel = read_vsyscall__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "read_vsyscall open_load"))
+		return;
+
+	skel->bss->target_pid = getpid();
+	err = read_vsyscall__attach(skel);
+	if (!ASSERT_EQ(err, 0, "read_vsyscall attach"))
+		goto out;
+
+	/* userspace may don't have vsyscall page due to LEGACY_VSYSCALL_NONE,
+	 * but it doesn't affect the returned error codes.
+	 */
+	skel->bss->user_ptr = (void *)VSYSCALL_ADDR;
+	usleep(1);
+
+	for (i = 0; i < ARRAY_SIZE(all_read); i++)
+		ASSERT_EQ(skel->bss->read_ret[i], all_read[i].ret, all_read[i].name);
+out:
+	read_vsyscall__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/read_vsyscall.c b/tools/testing/selftests/bpf/progs/read_vsyscall.c
new file mode 100644
index 0000000000000..986f96687ae15
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/read_vsyscall.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2024. Huawei Technologies Co., Ltd */
+#include <linux/types.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+
+int target_pid = 0;
+void *user_ptr = 0;
+int read_ret[8];
+
+char _license[] SEC("license") = "GPL";
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int do_probe_read(void *ctx)
+{
+	char buf[8];
+
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	read_ret[0] = bpf_probe_read_kernel(buf, sizeof(buf), user_ptr);
+	read_ret[1] = bpf_probe_read_kernel_str(buf, sizeof(buf), user_ptr);
+	read_ret[2] = bpf_probe_read(buf, sizeof(buf), user_ptr);
+	read_ret[3] = bpf_probe_read_str(buf, sizeof(buf), user_ptr);
+	read_ret[4] = bpf_probe_read_user(buf, sizeof(buf), user_ptr);
+	read_ret[5] = bpf_probe_read_user_str(buf, sizeof(buf), user_ptr);
+
+	return 0;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
+int do_copy_from_user(void *ctx)
+{
+	char buf[8];
+
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	read_ret[6] = bpf_copy_from_user(buf, sizeof(buf), user_ptr);
+	read_ret[7] = bpf_copy_from_user_task(buf, sizeof(buf), user_ptr,
+					      bpf_get_current_task_btf(), 0);
+
+	return 0;
+}
-- 
2.29.2


