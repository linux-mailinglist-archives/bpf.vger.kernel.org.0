Return-Path: <bpf+bounces-33485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D02A91DE4C
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 13:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75CB287D99
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 11:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FE314A0AD;
	Mon,  1 Jul 2024 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jEn8Mtv7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D739FD0;
	Mon,  1 Jul 2024 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834430; cv=none; b=cw7F+WoZO8uvvgIz29W3UZ3JUHg0Xs/YChQGKTPeb8mo5QYvaQSnwv04dI6wEzSU9O+6xHBHqG8rTX+rFDwSUIIDT7sNj7H1La2JfDNvdRpop8pr5/AoW/6OVjIeWEObwlnWVb8kbK4Sb6LNech5OlVE/e2YnWM0XDih6vlAWxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834430; c=relaxed/simple;
	bh=E2SnfFMvT+E1B567h4g9xMSnvPuIxKVznMN8ASJtLNk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WB43dJFhSyeToqxcnUm4zm8QSf4zmDcizueBTZslfN9ckuFKRgx4YLaoINLThDIeO4pVynXjdHtCVvMkHgNQ5Fg9wiDa1tc/Y2Z2hiITUPZmI0uAdf7KrdRlCQdwGi0gFu0RNfZRk+kytaXa+t1A+7At8YGdO11bJAxscrf87YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jEn8Mtv7; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719834429; x=1751370429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/eZpTUApNQiqilMlz5GmmlOhx2SUgIHpktJjtzY22MM=;
  b=jEn8Mtv7gUFlLKuBbTuwpWAx42+VzsFyRISUkOXoutwO+toADMS48fqE
   t25CmFwTn861VW+ImuzKr9aCd9bz6RQS+RWje2Ye0vj4RYJKmRlS7yIRT
   hD7/4as6Hw23LYLQccXnXwwBU0R4QhRdnpqpL2/krGZH5uL8+4mZntdI1
   M=;
X-IronPort-AV: E=Sophos;i="6.09,176,1716249600"; 
   d="scan'208";a="737563960"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 11:47:02 +0000
Received: from EX19MTAUEA001.ant.amazon.com [10.0.29.78:11889]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.43.6:2525] with esmtp (Farcaster)
 id 162e19d4-0971-4b1f-930f-a0e74b8532b6; Mon, 1 Jul 2024 11:47:01 +0000 (UTC)
X-Farcaster-Flow-ID: 162e19d4-0971-4b1f-930f-a0e74b8532b6
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 1 Jul 2024 11:47:01 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (10.15.97.110) by
 mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Mon, 1 Jul 2024 11:47:01 +0000
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id 46B972084A; Mon,  1 Jul 2024 11:47:01 +0000 (UTC)
From: Puranjay Mohan <pjy@amazon.com>
To: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Russell King" <russell.king@oracle.com>, Alan Maguire
	<alan.maguire@oracle.com>, "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
	<stable@vger.kernel.org>
CC: <pjy@amazon.com>, <puranjay@kernel.org>, <puranjay12@gmail.com>
Subject: [PATCH 5.10] arm64/bpf: Remove 128MB limit for BPF JIT programs
Date: Mon, 1 Jul 2024 11:46:59 +0000
Message-ID: <20240701114659.39539-1-pjy@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Russell King <russell.king@oracle.com>

[ Upstream commit b89ddf4cca43f1269093942cf5c4e457fd45c335 ]

Commit 91fc957c9b1d ("arm64/bpf: don't allocate BPF JIT programs in module
memory") restricts BPF JIT program allocation to a 128MB region to ensure
BPF programs are still in branching range of each other. However this
restriction should not apply to the aarch64 JIT, since BPF_JMP | BPF_CALL
are implemented as a 64-bit move into a register and then a BLR instruction -
which has the effect of being able to call anything without proximity
limitation.

The practical reason to relax this restriction on JIT memory is that 128MB of
JIT memory can be quickly exhausted, especially where PAGE_SIZE is 64KB - one
page is needed per program. In cases where seccomp filters are applied to
multiple VMs on VM launch - such filters are classic BPF but converted to
BPF - this can severely limit the number of VMs that can be launched. In a
world where we support BPF JIT always on, turning off the JIT isn't always an
option either.

Fixes: 91fc957c9b1d ("arm64/bpf: don't allocate BPF JIT programs in module memory")
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Russell King <russell.king@oracle.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
Link: https://lore.kernel.org/bpf/1636131046-5982-2-git-send-email-alan.maguire@oracle.com
[Replace usage of in_bpf_jit() with is_bpf_text_address()]
Signed-off-by: Puranjay Mohan <pjy@amazon.com>
---
 arch/arm64/include/asm/extable.h | 9 ---------
 arch/arm64/include/asm/memory.h  | 5 +----
 arch/arm64/kernel/traps.c        | 2 +-
 arch/arm64/mm/extable.c          | 3 ++-
 arch/arm64/mm/ptdump.c           | 2 --
 arch/arm64/net/bpf_jit_comp.c    | 7 ++-----
 6 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/extable.h b/arch/arm64/include/asm/extable.h
index b15eb4a3e6b20..840a35ed92ec8 100644
--- a/arch/arm64/include/asm/extable.h
+++ b/arch/arm64/include/asm/extable.h
@@ -22,15 +22,6 @@ struct exception_table_entry
 
 #define ARCH_HAS_RELATIVE_EXTABLE
 
-static inline bool in_bpf_jit(struct pt_regs *regs)
-{
-	if (!IS_ENABLED(CONFIG_BPF_JIT))
-		return false;
-
-	return regs->pc >= BPF_JIT_REGION_START &&
-	       regs->pc < BPF_JIT_REGION_END;
-}
-
 #ifdef CONFIG_BPF_JIT
 int arm64_bpf_fixup_exception(const struct exception_table_entry *ex,
 			      struct pt_regs *regs);
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 505bdd75b5411..eef03120c0daf 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -44,11 +44,8 @@
 #define _PAGE_OFFSET(va)	(-(UL(1) << (va)))
 #define PAGE_OFFSET		(_PAGE_OFFSET(VA_BITS))
 #define KIMAGE_VADDR		(MODULES_END)
-#define BPF_JIT_REGION_START	(KASAN_SHADOW_END)
-#define BPF_JIT_REGION_SIZE	(SZ_128M)
-#define BPF_JIT_REGION_END	(BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
 #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
-#define MODULES_VADDR		(BPF_JIT_REGION_END)
+#define MODULES_VADDR		(_PAGE_END(VA_BITS_MIN))
 #define MODULES_VSIZE		(SZ_128M)
 #define VMEMMAP_START		(-VMEMMAP_SIZE - SZ_2M)
 #define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 563d07d3904e4..e9cc15414133f 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -913,7 +913,7 @@ static struct break_hook bug_break_hook = {
 static int reserved_fault_handler(struct pt_regs *regs, unsigned int esr)
 {
 	pr_err("%s generated an invalid instruction at %pS!\n",
-		in_bpf_jit(regs) ? "BPF JIT" : "Kernel text patching",
+		"Kernel text patching",
 		(void *)instruction_pointer(regs));
 
 	/* We cannot handle this */
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index aa0060178343a..9a8147b6878b9 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -5,6 +5,7 @@
 
 #include <linux/extable.h>
 #include <linux/uaccess.h>
+#include <linux/filter.h>
 
 int fixup_exception(struct pt_regs *regs)
 {
@@ -14,7 +15,7 @@ int fixup_exception(struct pt_regs *regs)
 	if (!fixup)
 		return 0;
 
-	if (in_bpf_jit(regs))
+	if (is_bpf_text_address(regs->pc))
 		return arm64_bpf_fixup_exception(fixup, regs);
 
 	regs->pc = (unsigned long)&fixup->fixup + fixup->fixup;
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 807dc634bbd24..ba6d1d89f9b2a 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -41,8 +41,6 @@ static struct addr_marker address_markers[] = {
 	{ 0 /* KASAN_SHADOW_START */,	"Kasan shadow start" },
 	{ KASAN_SHADOW_END,		"Kasan shadow end" },
 #endif
-	{ BPF_JIT_REGION_START,		"BPF start" },
-	{ BPF_JIT_REGION_END,		"BPF end" },
 	{ MODULES_VADDR,		"Modules start" },
 	{ MODULES_END,			"Modules end" },
 	{ VMALLOC_START,		"vmalloc() area" },
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 18627cbd6da4e..2a47165abbe5e 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1145,15 +1145,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 u64 bpf_jit_alloc_exec_limit(void)
 {
-	return BPF_JIT_REGION_SIZE;
+	return VMALLOC_END - VMALLOC_START;
 }
 
 void *bpf_jit_alloc_exec(unsigned long size)
 {
-	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
-				    BPF_JIT_REGION_END, GFP_KERNEL,
-				    PAGE_KERNEL, 0, NUMA_NO_NODE,
-				    __builtin_return_address(0));
+	return vmalloc(size);
 }
 
 void bpf_jit_free_exec(void *addr)
-- 
2.40.1


