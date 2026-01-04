Return-Path: <bpf+bounces-77779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D517CF0EED
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 13:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B8B6300A6D9
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 12:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB20C28468E;
	Sun,  4 Jan 2026 12:36:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195D12AF1D;
	Sun,  4 Jan 2026 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767530197; cv=none; b=FZrLN6fZESmh8eJUhgL9OmAW1iFq6yO4ABe/Zc+3OBMQOs4AHhY+ACaMdIVket/xNl83DBSJ5j7lbuOPsbSLl65ezFAP/gcDPvC71txV90bKvFySY5ptLWjw1s3FZ76s72voy87HUBw1yf5F/kih3dersek5KFqHGsm7GL/g8/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767530197; c=relaxed/simple;
	bh=86+1c7H2UFQ62OsdAN8UTPAnfSH3afjSbkZR5rANUOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJ+4jMtrykJCwcZLJFJVXAAToVyBot8FHYlduQ1ynN5+7EA5Ro6mLA15rWR+OWRZPUqlNdq7uA4GuU5wzrderDWQn68Fx7mGM14wX1skT+nXChgGGiN596fQAydhcW+Px58qkPYQV9nmGQ7DT12eemLed/kzagQJdtLkMQglft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id D906F8B2A13; Sun,  4 Jan 2026 20:36:27 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: kasan-dev@googlegroups.com,
	andreyknvl@gmail.com
Cc: dvyukov@google.com,
	vincenzo.frascino@arm.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	linux-mm@kvack.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v1] kasan,mm: fix incomplete tag reset in change_memory_common()
Date: Sun,  4 Jan 2026 20:35:27 +0800
Message-ID: <20260104123532.272627-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Running KASAN KUnit tests with {HW,SW}_TAGS mode triggers a fault in
change_memory_common():

  Call trace:
   change_memory_common+0x168/0x210 (P)
   set_memory_ro+0x20/0x48
   vmalloc_helpers_tags+0xe8/0x338
   kunit_try_run_case+0x74/0x188
   kunit_generic_run_threadfn_adapter+0x30/0x70
   kthread+0x11c/0x200
   ret_from_fork+0x10/0x20
  ---[ end trace 0000000000000000 ]---
      # vmalloc_helpers_tags: try faulted
      not ok 67 vmalloc_helpers_tags

Commit a06494adb7ef ("arm64: mm: use untagged address to calculate page index")
fixed a KASAN warning in the BPF subsystem by adding kasan_reset_tag() to
the index calculation. In the execmem flow:

    bpf_prog_pack_alloc()
      -> bpf_jit_alloc_exec()
        -> execmem_alloc()

The returned address from execmem_vmalloc/execmem_cache_alloc is passed
through kasan_reset_tag(), so start has no tag while area->addr still
retains the original tag. The fix correctly handled this case by resetting
the tag on area->addr:

    (start - (unsigned long)kasan_reset_tag(area->addr)) >> PAGE_SHIFT

However, in normal vmalloc paths, both start and area->addr have matching
tags(or no tags). Resetting only area->addr causes a mismatch when
subtracting a tagged address from an untagged one, resulting in an
incorrect index.

Fix this by resetting tags on both addresses in the index calculation.
This ensures correct results regardless of the tag state of either address.

Tested with KASAN KUnit tests under CONFIG_KASAN_GENERIC,
CONFIG_KASAN_SW_TAGS, and CONFIG_KASAN_HW_TAGS - all pass. Also verified
the original BPF KASAN warning from [1] is still fixed.

[1] https://lore.kernel.org/all/20251118164115.GA3977565@ax162/

Fixes: a06494adb7ef ("arm64: mm: use untagged address to calculate page index")
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 arch/arm64/mm/pageattr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 508986608b49..358d1dc9a576 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -171,7 +171,8 @@ static int change_memory_common(unsigned long addr, int numpages,
 	 */
 	area = find_vm_area((void *)addr);
 	if (!area ||
-	    end > (unsigned long)kasan_reset_tag(area->addr) + area->size ||
+	    ((unsigned long)kasan_reset_tag((void *)end) >
+	     (unsigned long)kasan_reset_tag(area->addr) + area->size) ||
 	    ((area->flags & (VM_ALLOC | VM_ALLOW_HUGE_VMAP)) != VM_ALLOC))
 		return -EINVAL;
 
@@ -184,7 +185,8 @@ static int change_memory_common(unsigned long addr, int numpages,
 	 */
 	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
 			    pgprot_val(clear_mask) == PTE_RDONLY)) {
-		unsigned long idx = (start - (unsigned long)kasan_reset_tag(area->addr))
+		unsigned long idx = ((unsigned long)kasan_reset_tag((void *)start) -
+				     (unsigned long)kasan_reset_tag(area->addr))
 				    >> PAGE_SHIFT;
 		for (; numpages; idx++, numpages--) {
 			ret = __change_memory_common((u64)page_address(area->pages[idx]),
-- 
2.43.0


