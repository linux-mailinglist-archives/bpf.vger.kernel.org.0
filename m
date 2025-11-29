Return-Path: <bpf+bounces-75759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EC5C93D8C
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 13:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1383347208
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 12:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9C62741AB;
	Sat, 29 Nov 2025 12:36:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A8778F3A;
	Sat, 29 Nov 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764419818; cv=none; b=Wsi6CMI7Q3Lwx24W6nD7gvl9lfVLDgxiUHJCPdM7wCxpQMKYG/MPqqTI7WV5P8VOmQnLvecvCBWUlbgCj22hm547hK6iTywtJGffDjn8/Dt5ekx1diGIPVRd+qCtpn6ln2qpMbjn7LN+tVgYIhRWKyGS4ntUqCjFWGrb6rHIDb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764419818; c=relaxed/simple;
	bh=DiV1stPWOn0B1rqNeg36zldNtgUkou0lBtBa+NAFznI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=B4i9fkDEK1UUWGm0YKFPK+yPpEVcq8V2eWtuAqYtmbBAIXvJjaMP7y7k3NkzhoUcB97TFpyJd9XqOi8zL1BOLKH+run+xozSawQSjT+VzDjdzSltA4A0JomRyLaJapt21lGMUTEf2H9CRkMTjbxyxntJZWlkiOR2aASd9/zmgC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D1E51063;
	Sat, 29 Nov 2025 04:36:46 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF5043F66E;
	Sat, 29 Nov 2025 04:36:51 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	kevin.brodsky@arm.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	urezki@gmail.com
Cc: kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH] kasan: hw_tags: fix a false positive case of vrealloc in alloced size
Date: Sat, 29 Nov 2025 12:36:47 +0000
Message-Id: <20251129123648.1785982-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a memory region is allocated with vmalloc() and later expanded with
vrealloc() — while still within the originally allocated size —
KASAN may report a false positive because
it does not update the tags for the newly expanded portion of the memory.

A typical example of this pattern occurs in the BPF verifier,
and the following is a related false positive report:

[ 2206.486476] ==================================================================
[ 2206.486509] BUG: KASAN: invalid-access in __memcpy+0xc/0x30
[ 2206.486607] Write at addr f5ff800083765270 by task test_progs/205
[ 2206.486664] Pointer tag: [f5], memory tag: [fe]
[ 2206.486703]
[ 2206.486745] CPU: 4 UID: 0 PID: 205 Comm: test_progs Tainted: G           OE       6.18.0-rc7+ #145 PREEMPT(full)
[ 2206.486861] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[ 2206.486897] Hardware name:  , BIOS
[ 2206.486932] Call trace:
[ 2206.486961]  show_stack+0x24/0x40 (C)
[ 2206.487071]  __dump_stack+0x28/0x48
[ 2206.487182]  dump_stack_lvl+0x7c/0xb0
[ 2206.487293]  print_address_description+0x80/0x270
[ 2206.487403]  print_report+0x94/0x100
[ 2206.487505]  kasan_report+0xd8/0x150
[ 2206.487606]  __do_kernel_fault+0x64/0x268
[ 2206.487717]  do_bad_area+0x38/0x110
[ 2206.487820]  do_tag_check_fault+0x38/0x60
[ 2206.487936]  do_mem_abort+0x48/0xc8
[ 2206.488042]  el1_abort+0x40/0x70
[ 2206.488127]  el1h_64_sync_handler+0x50/0x118
[ 2206.488217]  el1h_64_sync+0xa4/0xa8
[ 2206.488303]  __memcpy+0xc/0x30 (P)
[ 2206.488412]  do_misc_fixups+0x4f8/0x1950
[ 2206.488528]  bpf_check+0x31c/0x840
[ 2206.488638]  bpf_prog_load+0x58c/0x658
[ 2206.488737]  __sys_bpf+0x364/0x488
[ 2206.488833]  __arm64_sys_bpf+0x30/0x58
[ 2206.488920]  invoke_syscall+0x68/0xe8
[ 2206.489033]  el0_svc_common+0xb0/0xf8
[ 2206.489143]  do_el0_svc+0x28/0x48
[ 2206.489249]  el0_svc+0x40/0xe8
[ 2206.489337]  el0t_64_sync_handler+0x84/0x140
[ 2206.489427]  el0t_64_sync+0x1bc/0x1c0

Here, 0xf5ff800083765000 is vmalloc()ed address for
env->insn_aux_data with the size of 0x268.
While this region is expanded size by 0x478 and initialise
increased region to apply patched instructions,
a false positive is triggered at the address 0xf5ff800083765270
because __kasan_unpoison_vmalloc() with KASAN_VMALLOC_PROT_NORMAL flag only
doesn't update the tag on increaed region.

To address this, introduces KASAN_VMALLOC_EXPAND flag which
is used to expand vmalloc()ed memory in range of real allocated size
to update tag for increased region.

Fixes: 23689e91fb22 ("kasan, vmalloc: add vmalloc tagging for HW_TAGS”)
Cc: <stable@vger.kernel.org>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 include/linux/kasan.h |  1 +
 mm/kasan/hw_tags.c    | 11 +++++++++--
 mm/vmalloc.c          |  1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index d12e1a5f5a9a..0608c5d4e6cf 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -28,6 +28,7 @@ typedef unsigned int __bitwise kasan_vmalloc_flags_t;
 #define KASAN_VMALLOC_INIT		((__force kasan_vmalloc_flags_t)0x01u)
 #define KASAN_VMALLOC_VM_ALLOC		((__force kasan_vmalloc_flags_t)0x02u)
 #define KASAN_VMALLOC_PROT_NORMAL	((__force kasan_vmalloc_flags_t)0x04u)
+#define KASAN_VMALLOC_EXPAND		((__force kasan_vmalloc_flags_t)0x08u)

 #define KASAN_VMALLOC_PAGE_RANGE 0x1 /* Apply exsiting page range */
 #define KASAN_VMALLOC_TLB_FLUSH  0x2 /* TLB flush */
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 1c373cc4b3fa..d768c7360093 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -347,7 +347,7 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
 	 *
 	 * For non-VM_ALLOC allocations, page_alloc memory is tagged as usual.
 	 */
-	if (!(flags & KASAN_VMALLOC_VM_ALLOC)) {
+	if (!(flags & (KASAN_VMALLOC_VM_ALLOC | KASAN_VMALLOC_EXPAND))) {
 		WARN_ON(flags & KASAN_VMALLOC_INIT);
 		return (void *)start;
 	}
@@ -361,7 +361,14 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
 		return (void *)start;
 	}

-	tag = kasan_random_tag();
+	if (flags & KASAN_VMALLOC_EXPAND) {
+		size = round_up(size + ((unsigned long)start & KASAN_GRANULE_MASK),
+				KASAN_GRANULE_SIZE);
+		start = PTR_ALIGN_DOWN(start, KASAN_GRANULE_SIZE);
+		tag = get_tag(start);
+	} else
+		tag = kasan_random_tag();
+
 	start = set_tag(start, tag);

 	/* Unpoison and initialize memory up to size. */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 798b2ed21e46..6bfbf26fea3b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4176,6 +4176,7 @@ void *vrealloc_node_align_noprof(const void *p, size_t size, unsigned long align
 	 */
 	if (size <= alloced_size) {
 		kasan_unpoison_vmalloc(p + old_size, size - old_size,
+				       KASAN_VMALLOC_EXPAND |
 				       KASAN_VMALLOC_PROT_NORMAL);
 		/*
 		 * No need to zero memory here, as unused memory will have
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


