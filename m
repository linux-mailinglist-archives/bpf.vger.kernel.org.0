Return-Path: <bpf+bounces-1035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3AF70CB29
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 22:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573FA280A6A
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 20:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D95F174C0;
	Mon, 22 May 2023 20:34:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB021154AF
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 20:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84C7C4339B;
	Mon, 22 May 2023 20:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684787657;
	bh=CR+uhegPGZnQF02rO5sFeA05nPiC/9Ec9ZWdVQpJmlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NjQ3hoh4ha/iUxGPxWNu2SKDmxUuYh2SJImlsMDK6q4UgG9rUr+NvWycE7mmGS+KS
	 F49spCPs8lRMeEvjtQGnrxGDpIMA4mmy+4c/Yg4284v9IcvjYfPYh+M9h96WncZQJs
	 J5l2z2jI58XzRx3J0RgJri5RQAXsIZHp/5O/KsrTXuQ5fkLZQMvqP8JevAS4dla65V
	 5dl3ag7vA6cV+5QG9PKivZlH5/OQ1KdF7T7TADHIxMPD/llQrpdeUTAbTQNaXJBEMw
	 8ECIdVo8BFvcMeU2CVqzlkY0Wq7rQXbFb4CBCMVEJSxra1PpTKb4BpN26ERuKR2Uim
	 RMy642v/iMArg==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	x86@kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tsahee Zidenberg <tsahee@annapurnalabs.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Mah=C3=A9=20Tardy?= <mahe.tardy@isovalent.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH stable 5.4 1/8] uaccess: Add strict non-pagefault kernel-space read function
Date: Mon, 22 May 2023 22:33:45 +0200
Message-Id: <20230522203352.738576-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522203352.738576-1-jolsa@kernel.org>
References: <20230522203352.738576-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

commit 75a1a607bb7e6d918be3aca11ec2214a275392f4 upstream.

Add two new probe_kernel_read_strict() and strncpy_from_unsafe_strict()
helpers which by default alias to the __probe_kernel_read() and the
__strncpy_from_unsafe(), respectively, but can be overridden by archs
which have non-overlapping address ranges for kernel space and user
space in order to bail out with -EFAULT when attempting to probe user
memory including non-canonical user access addresses [0]:

  4-level page tables:
    user-space mem: 0x0000000000000000 - 0x00007fffffffffff
    non-canonical:  0x0000800000000000 - 0xffff7fffffffffff

  5-level page tables:
    user-space mem: 0x0000000000000000 - 0x00ffffffffffffff
    non-canonical:  0x0100000000000000 - 0xfeffffffffffffff

The idea is that these helpers are complementary to the probe_user_read()
and strncpy_from_unsafe_user() which probe user-only memory. Both added
helpers here do the same, but for kernel-only addresses.

Both set of helpers are going to be used for BPF tracing. They also
explicitly avoid throwing the splat for non-canonical user addresses from
00c42373d397 ("x86-64: add warning for non-canonical user access address
dereferences").

For compat, the current probe_kernel_read() and strncpy_from_unsafe() are
left as-is.

  [0] Documentation/x86/x86_64/mm.txt

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: x86@kernel.org
Link: https://lore.kernel.org/bpf/eefeefd769aa5a013531f491a71f0936779e916b.1572649915.git.daniel@iogearbox.net
---
 arch/x86/mm/Makefile    |  2 +-
 arch/x86/mm/maccess.c   | 43 +++++++++++++++++++++++++++++++++++++++++
 include/linux/uaccess.h |  4 ++++
 mm/maccess.c            | 25 +++++++++++++++++++++++-
 4 files changed, 72 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/mm/maccess.c

diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 84373dc9b341..bbc68a54795e 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -13,7 +13,7 @@ CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
 endif
 
 obj-y	:=  init.o init_$(BITS).o fault.o ioremap.o extable.o pageattr.o mmap.o \
-	    pat.o pgtable.o physaddr.o setup_nx.o tlb.o cpu_entry_area.o
+	    pat.o pgtable.o physaddr.o setup_nx.o tlb.o cpu_entry_area.o maccess.o
 
 # Make sure __phys_addr has no stackprotector
 nostackp := $(call cc-option, -fno-stack-protector)
diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
new file mode 100644
index 000000000000..f5b85bdc0535
--- /dev/null
+++ b/arch/x86/mm/maccess.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/uaccess.h>
+#include <linux/kernel.h>
+
+#ifdef CONFIG_X86_64
+static __always_inline u64 canonical_address(u64 vaddr, u8 vaddr_bits)
+{
+	return ((s64)vaddr << (64 - vaddr_bits)) >> (64 - vaddr_bits);
+}
+
+static __always_inline bool invalid_probe_range(u64 vaddr)
+{
+	/*
+	 * Range covering the highest possible canonical userspace address
+	 * as well as non-canonical address range. For the canonical range
+	 * we also need to include the userspace guard page.
+	 */
+	return vaddr < TASK_SIZE_MAX + PAGE_SIZE ||
+	       canonical_address(vaddr, boot_cpu_data.x86_virt_bits) != vaddr;
+}
+#else
+static __always_inline bool invalid_probe_range(u64 vaddr)
+{
+	return vaddr < TASK_SIZE_MAX;
+}
+#endif
+
+long probe_kernel_read_strict(void *dst, const void *src, size_t size)
+{
+	if (unlikely(invalid_probe_range((unsigned long)src)))
+		return -EFAULT;
+
+	return __probe_kernel_read(dst, src, size);
+}
+
+long strncpy_from_unsafe_strict(char *dst, const void *unsafe_addr, long count)
+{
+	if (unlikely(invalid_probe_range((unsigned long)unsafe_addr)))
+		return -EFAULT;
+
+	return __strncpy_from_unsafe(dst, unsafe_addr, count);
+}
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 70941f49d66e..25ae650dcb1a 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -315,6 +315,7 @@ copy_struct_from_user(void *dst, size_t ksize, const void __user *src,
  * happens, handle that and return -EFAULT.
  */
 extern long probe_kernel_read(void *dst, const void *src, size_t size);
+extern long probe_kernel_read_strict(void *dst, const void *src, size_t size);
 extern long __probe_kernel_read(void *dst, const void *src, size_t size);
 
 /*
@@ -354,6 +355,9 @@ extern long notrace probe_user_write(void __user *dst, const void *src, size_t s
 extern long notrace __probe_user_write(void __user *dst, const void *src, size_t size);
 
 extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
+extern long strncpy_from_unsafe_strict(char *dst, const void *unsafe_addr,
+				       long count);
+extern long __strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
 extern long strncpy_from_unsafe_user(char *dst, const void __user *unsafe_addr,
 				     long count);
 extern long strnlen_unsafe_user(const void __user *unsafe_addr, long count);
diff --git a/mm/maccess.c b/mm/maccess.c
index 2d3c3d01064c..3ca8d97e5010 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -43,11 +43,20 @@ probe_write_common(void __user *dst, const void *src, size_t size)
  * do_page_fault() doesn't attempt to take mmap_sem.  This makes
  * probe_kernel_read() suitable for use within regions where the caller
  * already holds mmap_sem, or other locks which nest inside mmap_sem.
+ *
+ * probe_kernel_read_strict() is the same as probe_kernel_read() except for
+ * the case where architectures have non-overlapping user and kernel address
+ * ranges: probe_kernel_read_strict() will additionally return -EFAULT for
+ * probing memory on a user address range where probe_user_read() is supposed
+ * to be used instead.
  */
 
 long __weak probe_kernel_read(void *dst, const void *src, size_t size)
     __attribute__((alias("__probe_kernel_read")));
 
+long __weak probe_kernel_read_strict(void *dst, const void *src, size_t size)
+    __attribute__((alias("__probe_kernel_read")));
+
 long __probe_kernel_read(void *dst, const void *src, size_t size)
 {
 	long ret;
@@ -157,8 +166,22 @@ EXPORT_SYMBOL_GPL(probe_user_write);
  *
  * If @count is smaller than the length of the string, copies @count-1 bytes,
  * sets the last byte of @dst buffer to NUL and returns @count.
+ *
+ * strncpy_from_unsafe_strict() is the same as strncpy_from_unsafe() except
+ * for the case where architectures have non-overlapping user and kernel address
+ * ranges: strncpy_from_unsafe_strict() will additionally return -EFAULT for
+ * probing memory on a user address range where strncpy_from_unsafe_user() is
+ * supposed to be used instead.
  */
-long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
+
+long __weak strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
+    __attribute__((alias("__strncpy_from_unsafe")));
+
+long __weak strncpy_from_unsafe_strict(char *dst, const void *unsafe_addr,
+				       long count)
+    __attribute__((alias("__strncpy_from_unsafe")));
+
+long __strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
 {
 	mm_segment_t old_fs = get_fs();
 	const void *src = unsafe_addr;
-- 
2.40.1


