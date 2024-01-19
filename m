Return-Path: <bpf+bounces-19875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0928F832505
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 08:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3487BB20FB7
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 07:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC380D52F;
	Fri, 19 Jan 2024 07:29:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC3EBA49;
	Fri, 19 Jan 2024 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705649370; cv=none; b=Rn6UjbabGl2hJ97vilkIOGRFsFYM/eZRj+XOypBp/kNczSEicrsV61r6o+WQMajFXVb3JRzIGuIhI13UAKUtkIYFWEu5tDbeoziN+sxUJ5g7LMPd4zYn7kndNIc2zezuzJx8ZyTJcquMNuju7EpzXrlhw2iTEBlOz2kUw9+gDxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705649370; c=relaxed/simple;
	bh=BDbDiM503rZpMzxWvmUXCoATnE4hnkD3Xqcoy6MpcSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sWJnskOYE5NLGvm00AK1KgQDTmkTWXqg7oga2cJci78SRMewwiMEi8rNgsP+ezwkr8x74M35DrLMwFypY5Nfpck9jl652BosHdRvnZ54mQImU+0HdP01piFMDX9mRMFtWiQ9QejTaMPu9IUYY7YuTQ2X4opNLRXVpW/exwC0IzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TGWTB3YHWz4f3lW6;
	Fri, 19 Jan 2024 15:29:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A30F01A0D7B;
	Fri, 19 Jan 2024 15:29:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RHQJKplBOsuBQ--.42435S5;
	Fri, 19 Jan 2024 15:29:24 +0800 (CST)
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
	houtao1@huawei.com
Subject: [PATCH bpf 1/3] x86/mm: Move is_vsyscall_vaddr() into mm_internal.h
Date: Fri, 19 Jan 2024 15:30:17 +0800
Message-Id: <20240119073019.1528573-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240119073019.1528573-1-houtao@huaweicloud.com>
References: <20240119073019.1528573-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RHQJKplBOsuBQ--.42435S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1rGF43WrW8AF4kZF4xZwb_yoW8tr18pr
	y3Cas7Jr4vga9IkFZ7XFy5Aa15uan7KF48GrZFg3yYv3WYv3Wagr1xuwn5WryUJFykXF4f
	Xr4Yva48Cr1DAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Moving is_vsyscall_vaddr() into mm_internal.h to make it available for
copy_from_kernel_nofault_allowed() in arch/x86/mm/maccess.c.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 arch/x86/mm/fault.c       | 11 ++---------
 arch/x86/mm/mm_internal.h | 13 +++++++++++++
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 679b09cfe241c..69e007761d9a9 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -38,6 +38,8 @@
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
 
+#include "mm_internal.h"
+
 /*
  * Returns 0 if mmiotrace is disabled, or if the fault is not
  * handled by mmiotrace:
@@ -798,15 +800,6 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 	show_opcodes(regs, loglvl);
 }
 
-/*
- * The (legacy) vsyscall page is the long page in the kernel portion
- * of the address space that has user-accessible permissions.
- */
-static bool is_vsyscall_vaddr(unsigned long vaddr)
-{
-	return unlikely((vaddr & PAGE_MASK) == VSYSCALL_ADDR);
-}
-
 static void
 __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		       unsigned long address, u32 pkey, int si_code)
diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
index 3f37b5c80bb32..4ebf6051e1ed7 100644
--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -2,6 +2,10 @@
 #ifndef __X86_MM_INTERNAL_H
 #define __X86_MM_INTERNAL_H
 
+#include <uapi/asm/vsyscall.h>
+
+#include <asm/page_types.h>
+
 void *alloc_low_pages(unsigned int num);
 static inline void *alloc_low_page(void)
 {
@@ -25,4 +29,13 @@ void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache);
 
 extern unsigned long tlb_single_page_flush_ceiling;
 
+/*
+ * The (legacy) vsyscall page is the long page in the kernel portion
+ * of the address space that has user-accessible permissions.
+ */
+static inline bool is_vsyscall_vaddr(unsigned long vaddr)
+{
+	return unlikely((vaddr & PAGE_MASK) == VSYSCALL_ADDR);
+}
+
 #endif	/* __X86_MM_INTERNAL_H */
-- 
2.29.2


