Return-Path: <bpf+bounces-66711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7517DB38AD8
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D515520883F
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 20:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834E02FE048;
	Wed, 27 Aug 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJkW8sIC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAAF2EE61C;
	Wed, 27 Aug 2025 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326262; cv=none; b=kTvavCsriIiHc2lpP2zvp+H3owpios//BOWlyskgWvx9y436OOfHQyeVWw5qS6+haTJ19tMuiKc0+r1ZaNuzMRTr2HvZKSvCEis42gwuYagyb0XvCO/e4kCzVOvVGR1kbx0LpAp+Xp2rU9gO4am82lPd3L+jP0a4DwtcAmlg8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326262; c=relaxed/simple;
	bh=8N2d9jIRzG/27NeBhv8n4ni+hFpJLErKf4yPWJZA+Hs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZlOHThLMtb4O98ANEOTIUExo75L5tIftz3r9j7fE8A6npsxkFxCMYNK7+TinrMez68mQfHgiEAMHKax4yBKvLZNi3U/0GaNaXv0xZaC3vi2HWtK0bbDqIu9gT3m0R0QIFCZm/GHEwmISfvfeA4Uifkc1wIWg/va08KQWaQ2PYBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJkW8sIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF2AC4CEF7;
	Wed, 27 Aug 2025 20:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756326261;
	bh=8N2d9jIRzG/27NeBhv8n4ni+hFpJLErKf4yPWJZA+Hs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=XJkW8sICm6eRg1hVqJnlwAMqT/8N8iYTQIGujM8FktgvkhT4MIe/wLu8OEuGehyH5
	 8GT2J9KnM2SjPz+rQixUW7KU5NBkozPfd3SJ3+vRNubQ5q5Y4CiQa5wDD7yxjjJt4S
	 vv+tBjBamux4ZJncmf95mmxV50nX1vWtIaiSE5IZll8bMdiMM1ZSVsNtlXSVZRUTNh
	 2RgxUWyW7CiT7acN41WzpKPxJXyY79vLXDyyymd77/QDRH1cC9MEC8Mjf9ubvSgtzB
	 bxoaWiVF0eEF1AZ9wKtnzkQkhVVGNcoWvf9tdmFwe/5GZItd08ib2WUnX2gbWfO8WA
	 QILCBR4ZiP3wg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urMhE-00000003kwB-1n6z;
	Wed, 27 Aug 2025 16:24:40 -0400
Message-ID: <20250827202440.264683085@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 27 Aug 2025 16:15:49 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>,
 "Carlos O'Donell" <codonell@redhat.com>
Subject: [PATCH v10 01/11] unwind_user/sframe: Add support for reading .sframe headers
References: <20250827201548.448472904@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

In preparation for unwinding user space stacks with sframe, add basic
sframe compile infrastructure and support for reading the .sframe
section header.

sframe_add_section() reads the header and unconditionally returns an
error, so it's not very useful yet.  A subsequent patch will improve
that.

Link: https://lore.kernel.org/all/f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org/

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS            |   1 +
 arch/Kconfig           |   3 +
 include/linux/sframe.h |  40 ++++++++++++
 kernel/unwind/Makefile |   3 +-
 kernel/unwind/sframe.c | 136 +++++++++++++++++++++++++++++++++++++++++
 kernel/unwind/sframe.h |  71 +++++++++++++++++++++
 6 files changed, 253 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/sframe.h
 create mode 100644 kernel/unwind/sframe.c
 create mode 100644 kernel/unwind/sframe.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fed6cd812d79..42b0fb83516a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26333,6 +26333,7 @@ USERSPACE STACK UNWINDING
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 S:	Maintained
+F:	include/linux/sframe.h
 F:	include/linux/unwind*.h
 F:	kernel/unwind/
 
diff --git a/arch/Kconfig b/arch/Kconfig
index d1b4ffd6e085..69fcabf53088 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -451,6 +451,9 @@ config HAVE_UNWIND_USER_FP
 	bool
 	select UNWIND_USER
 
+config HAVE_UNWIND_USER_SFRAME
+	bool
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/linux/sframe.h b/include/linux/sframe.h
new file mode 100644
index 000000000000..0584f661f698
--- /dev/null
+++ b/include/linux/sframe.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SFRAME_H
+#define _LINUX_SFRAME_H
+
+#include <linux/mm_types.h>
+#include <linux/unwind_user_types.h>
+
+#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
+
+struct sframe_section {
+	unsigned long	sframe_start;
+	unsigned long	sframe_end;
+	unsigned long	text_start;
+	unsigned long	text_end;
+
+	unsigned long	fdes_start;
+	unsigned long	fres_start;
+	unsigned long	fres_end;
+	unsigned int	num_fdes;
+
+	signed char	ra_off;
+	signed char	fp_off;
+};
+
+extern int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
+			      unsigned long text_start, unsigned long text_end);
+extern int sframe_remove_section(unsigned long sframe_addr);
+
+#else /* !CONFIG_HAVE_UNWIND_USER_SFRAME */
+
+static inline int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
+				     unsigned long text_start, unsigned long text_end)
+{
+	return -ENOSYS;
+}
+static inline int sframe_remove_section(unsigned long sframe_addr) { return -ENOSYS; }
+
+#endif /* CONFIG_HAVE_UNWIND_USER_SFRAME */
+
+#endif /* _LINUX_SFRAME_H */
diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
index eae37bea54fd..146038165865 100644
--- a/kernel/unwind/Makefile
+++ b/kernel/unwind/Makefile
@@ -1 +1,2 @@
- obj-$(CONFIG_UNWIND_USER)	+= user.o deferred.o
+ obj-$(CONFIG_UNWIND_USER)		+= user.o deferred.o
+ obj-$(CONFIG_HAVE_UNWIND_USER_SFRAME)	+= sframe.o
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
new file mode 100644
index 000000000000..20287f795b36
--- /dev/null
+++ b/kernel/unwind/sframe.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Userspace sframe access functions
+ */
+
+#define pr_fmt(fmt)	"sframe: " fmt
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/srcu.h>
+#include <linux/uaccess.h>
+#include <linux/mm.h>
+#include <linux/string_helpers.h>
+#include <linux/sframe.h>
+#include <linux/unwind_user_types.h>
+
+#include "sframe.h"
+
+#define dbg(fmt, ...)							\
+	pr_debug("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
+
+static void free_section(struct sframe_section *sec)
+{
+	kfree(sec);
+}
+
+static int sframe_read_header(struct sframe_section *sec)
+{
+	unsigned long header_end, fdes_start, fdes_end, fres_start, fres_end;
+	struct sframe_header shdr;
+	unsigned int num_fdes;
+
+	if (copy_from_user(&shdr, (void __user *)sec->sframe_start, sizeof(shdr))) {
+		dbg("header usercopy failed\n");
+		return -EFAULT;
+	}
+
+	if (shdr.preamble.magic != SFRAME_MAGIC ||
+	    shdr.preamble.version != SFRAME_VERSION_2 ||
+	    !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
+	    shdr.auxhdr_len) {
+		dbg("bad/unsupported sframe header\n");
+		return -EINVAL;
+	}
+
+	if (!shdr.num_fdes || !shdr.num_fres) {
+		dbg("no fde/fre entries\n");
+		return -EINVAL;
+	}
+
+	header_end = sec->sframe_start + SFRAME_HEADER_SIZE(shdr);
+	if (header_end >= sec->sframe_end) {
+		dbg("header doesn't fit in section\n");
+		return -EINVAL;
+	}
+
+	num_fdes   = shdr.num_fdes;
+	fdes_start = header_end + shdr.fdes_off;
+	fdes_end   = fdes_start + (num_fdes * sizeof(struct sframe_fde));
+
+	fres_start = header_end + shdr.fres_off;
+	fres_end   = fres_start + shdr.fre_len;
+
+	if (fres_start < fdes_end || fres_end > sec->sframe_end) {
+		dbg("inconsistent fde/fre offsets\n");
+		return -EINVAL;
+	}
+
+	sec->num_fdes		= num_fdes;
+	sec->fdes_start		= fdes_start;
+	sec->fres_start		= fres_start;
+	sec->fres_end		= fres_end;
+
+	sec->ra_off		= shdr.cfa_fixed_ra_offset;
+	sec->fp_off		= shdr.cfa_fixed_fp_offset;
+
+	return 0;
+}
+
+int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
+		       unsigned long text_start, unsigned long text_end)
+{
+	struct maple_tree *sframe_mt = &current->mm->sframe_mt;
+	struct vm_area_struct *sframe_vma, *text_vma;
+	struct mm_struct *mm = current->mm;
+	struct sframe_section *sec;
+	int ret;
+
+	if (!sframe_start || !sframe_end || !text_start || !text_end) {
+		dbg("zero-length sframe/text address\n");
+		return -EINVAL;
+	}
+
+	scoped_guard(mmap_read_lock, mm) {
+		sframe_vma = vma_lookup(mm, sframe_start);
+		if (!sframe_vma || sframe_end > sframe_vma->vm_end) {
+			dbg("bad sframe address (0x%lx - 0x%lx)\n",
+			    sframe_start, sframe_end);
+			return -EINVAL;
+		}
+
+		text_vma = vma_lookup(mm, text_start);
+		if (!text_vma ||
+		    !(text_vma->vm_flags & VM_EXEC) ||
+		    text_end > text_vma->vm_end) {
+			dbg("bad text address (0x%lx - 0x%lx)\n",
+			    text_start, text_end);
+			return -EINVAL;
+		}
+	}
+
+	sec = kzalloc(sizeof(*sec), GFP_KERNEL);
+	if (!sec)
+		return -ENOMEM;
+
+	sec->sframe_start	= sframe_start;
+	sec->sframe_end		= sframe_end;
+	sec->text_start		= text_start;
+	sec->text_end		= text_end;
+
+	ret = sframe_read_header(sec);
+	if (ret)
+		goto err_free;
+
+	/* TODO nowhere to store it yet - just free it and return an error */
+	ret = -ENOSYS;
+
+err_free:
+	free_section(sec);
+	return ret;
+}
+
+int sframe_remove_section(unsigned long sframe_start)
+{
+	return -ENOSYS;
+}
diff --git a/kernel/unwind/sframe.h b/kernel/unwind/sframe.h
new file mode 100644
index 000000000000..e9bfccfaf5b4
--- /dev/null
+++ b/kernel/unwind/sframe.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * From https://www.sourceware.org/binutils/docs/sframe-spec.html
+ */
+#ifndef _SFRAME_H
+#define _SFRAME_H
+
+#include <linux/types.h>
+
+#define SFRAME_VERSION_1			1
+#define SFRAME_VERSION_2			2
+#define SFRAME_MAGIC				0xdee2
+
+#define SFRAME_F_FDE_SORTED			0x1
+#define SFRAME_F_FRAME_POINTER			0x2
+
+#define SFRAME_ABI_AARCH64_ENDIAN_BIG		1
+#define SFRAME_ABI_AARCH64_ENDIAN_LITTLE	2
+#define SFRAME_ABI_AMD64_ENDIAN_LITTLE		3
+
+#define SFRAME_FDE_TYPE_PCINC			0
+#define SFRAME_FDE_TYPE_PCMASK			1
+
+struct sframe_preamble {
+	u16	magic;
+	u8	version;
+	u8	flags;
+} __packed;
+
+struct sframe_header {
+	struct sframe_preamble preamble;
+	u8	abi_arch;
+	s8	cfa_fixed_fp_offset;
+	s8	cfa_fixed_ra_offset;
+	u8	auxhdr_len;
+	u32	num_fdes;
+	u32	num_fres;
+	u32	fre_len;
+	u32	fdes_off;
+	u32	fres_off;
+} __packed;
+
+#define SFRAME_HEADER_SIZE(header) \
+	((sizeof(struct sframe_header) + header.auxhdr_len))
+
+#define SFRAME_AARCH64_PAUTH_KEY_A		0
+#define SFRAME_AARCH64_PAUTH_KEY_B		1
+
+struct sframe_fde {
+	s32	start_addr;
+	u32	func_size;
+	u32	fres_off;
+	u32	fres_num;
+	u8	info;
+	u8	rep_size;
+	u16 padding;
+} __packed;
+
+#define SFRAME_FUNC_FRE_TYPE(data)		(data & 0xf)
+#define SFRAME_FUNC_FDE_TYPE(data)		((data >> 4) & 0x1)
+#define SFRAME_FUNC_PAUTH_KEY(data)		((data >> 5) & 0x1)
+
+#define SFRAME_BASE_REG_FP			0
+#define SFRAME_BASE_REG_SP			1
+
+#define SFRAME_FRE_CFA_BASE_REG_ID(data)	(data & 0x1)
+#define SFRAME_FRE_OFFSET_COUNT(data)		((data >> 1) & 0xf)
+#define SFRAME_FRE_OFFSET_SIZE(data)		((data >> 5) & 0x3)
+#define SFRAME_FRE_MANGLED_RA_P(data)		((data >> 7) & 0x1)
+
+#endif /* _SFRAME_H */
-- 
2.50.1



