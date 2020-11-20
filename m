Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406942BB6EE
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 21:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbgKTUa1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 15:30:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:10348 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731017AbgKTUaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 15:30:05 -0500
IronPort-SDR: Y/Mh/T9GvdCZFtMqTf6wPcjw49m4asX23QB7wCRKt3lTlIfgQtQ6JH5aAcjo1AV70V4QjxeX4K
 inuBMoOtCBjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="235683296"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="235683296"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:03 -0800
IronPort-SDR: II4ekpkhOvKaWBqJedqpw9lKC/FogA54M5cqtk2mIsaXaaDR8zAXkVs+TgD+DICnZJ3XUcjpCg
 sq9q0khmZD0w==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="342163300"
Received: from rpedgeco-mobl.amr.corp.intel.com (HELO localhost.intel.com) ([10.209.105.214])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:02 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, jeyu@kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, luto@kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, x86@kernel.org,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com
Cc:     elena.reshetova@intel.com, ira.weiny@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC 05/10] x86/modules: Use real perm_allocations
Date:   Fri, 20 Nov 2020 12:24:21 -0800
Message-Id: <20201120202426.18009-6-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

x86 relocations require all of the text sections to be within 2GB of
eachother. So as long as the allocations are somewhere in the module area,
relocations can be applied. So relax the restriction of having the module
regions for a module core or init area be virtually contiguous.

Also, apply relocations at the writable address of the perm_allocation to
support a future implementation that has the writable address in a
different allocation.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/module.c | 84 +++++++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 34b153cbd4ac..7b369f5ffdb7 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -85,6 +85,58 @@ void *module_alloc(unsigned long size)
 	return p;
 }
 
+bool module_perm_alloc(struct module_layout *layout)
+{
+	unsigned long vstart = MODULES_VADDR + get_module_load_offset();
+	unsigned long vend = MODULES_END;
+	unsigned int text_page_cnt = PAGE_ALIGN(layout->text.size) >> PAGE_SHIFT;
+	unsigned int ro_page_cnt = PAGE_ALIGN(layout->ro.size) >> PAGE_SHIFT;
+	unsigned int ro_after_init_page_cnt = PAGE_ALIGN(layout->ro_after_init.size) >> PAGE_SHIFT;
+	unsigned int rw_page_cnt = PAGE_ALIGN(layout->rw.size) >> PAGE_SHIFT;
+
+	layout->text.alloc = NULL;
+	layout->ro.alloc = NULL;
+	layout->ro_after_init.alloc = NULL;
+	layout->rw.alloc = NULL;
+
+	layout->text.alloc = perm_alloc(vstart, vend, text_page_cnt, PERM_RX);
+	if (!layout->text.alloc && layout->text.size)
+		goto out;
+
+	layout->ro.alloc = perm_alloc(vstart, vend, ro_page_cnt, PERM_R);
+	if (!layout->ro.alloc && layout->ro.size)
+		goto text_free_out;
+
+	layout->ro_after_init.alloc = perm_alloc(vstart, vend, ro_after_init_page_cnt, PERM_RW);
+	if (!layout->ro_after_init.alloc && layout->ro_after_init.size)
+		goto ro_free_out;
+
+	layout->rw.alloc = perm_alloc(vstart, vend, rw_page_cnt, PERM_RW);
+	if (!layout->rw.alloc && layout->rw.size)
+		goto ro_after_init_out;
+
+	return true;
+ro_after_init_out:
+	perm_free(layout->ro_after_init.alloc);
+	layout->ro_after_init.alloc = NULL;
+ro_free_out:
+	perm_free(layout->ro.alloc);
+	layout->ro.alloc = NULL;
+text_free_out:
+	perm_free(layout->text.alloc);
+	layout->text.alloc = NULL;
+out:
+	return false;
+}
+
+void module_perm_free(struct module_layout *layout)
+{
+	perm_free(layout->text.alloc);
+	perm_free(layout->ro.alloc);
+	perm_free(layout->ro_after_init.alloc);
+	perm_free(layout->rw.alloc);
+}
+
 #ifdef CONFIG_X86_32
 int apply_relocate(Elf32_Shdr *sechdrs,
 		   const char *strtab,
@@ -134,9 +186,11 @@ static int __apply_relocate_add(Elf64_Shdr *sechdrs,
 		   void *(*write)(void *dest, const void *src, size_t len))
 {
 	unsigned int i;
+	struct perm_allocation *alloc;
 	Elf64_Rela *rel = (void *)sechdrs[relsec].sh_addr;
 	Elf64_Sym *sym;
 	void *loc;
+	void *writable_loc;
 	u64 val;
 
 	DEBUGP("Applying relocate section %u to %u\n",
@@ -146,6 +200,9 @@ static int __apply_relocate_add(Elf64_Shdr *sechdrs,
 		loc = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rel[i].r_offset;
 
+		alloc = module_get_allocation(me, (unsigned long)loc);
+		writable_loc = (void *)perm_writable_addr(alloc, (unsigned long)loc);
+
 		/* This is the symbol it is referring to.  Note that all
 		   undefined symbols have been resolved.  */
 		sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
@@ -161,40 +218,40 @@ static int __apply_relocate_add(Elf64_Shdr *sechdrs,
 		case R_X86_64_NONE:
 			break;
 		case R_X86_64_64:
-			if (*(u64 *)loc != 0)
+			if (*(u64 *)writable_loc != 0)
 				goto invalid_relocation;
-			write(loc, &val, 8);
+			write(writable_loc, &val, 8);
 			break;
 		case R_X86_64_32:
-			if (*(u32 *)loc != 0)
+			if (*(u32 *)writable_loc != 0)
 				goto invalid_relocation;
-			write(loc, &val, 4);
-			if (val != *(u32 *)loc)
+			write(writable_loc, &val, 4);
+			if (val != *(u32 *)writable_loc)
 				goto overflow;
 			break;
 		case R_X86_64_32S:
-			if (*(s32 *)loc != 0)
+			if (*(s32 *)writable_loc != 0)
 				goto invalid_relocation;
-			write(loc, &val, 4);
-			if ((s64)val != *(s32 *)loc)
+			write(writable_loc, &val, 4);
+			if ((s64)val != *(s32 *)writable_loc)
 				goto overflow;
 			break;
 		case R_X86_64_PC32:
 		case R_X86_64_PLT32:
-			if (*(u32 *)loc != 0)
+			if (*(u32 *)writable_loc != 0)
 				goto invalid_relocation;
 			val -= (u64)loc;
-			write(loc, &val, 4);
+			write(writable_loc, &val, 4);
 #if 0
-			if ((s64)val != *(s32 *)loc)
+			if ((s64)val != *(s32 *)writable_loc)
 				goto overflow;
 #endif
 			break;
 		case R_X86_64_PC64:
-			if (*(u64 *)loc != 0)
+			if (*(u64 *)writable_loc != 0)
 				goto invalid_relocation;
 			val -= (u64)loc;
-			write(loc, &val, 8);
+			write(writable_loc, &val, 8);
 			break;
 		default:
 			pr_err("%s: Unknown rela relocation: %llu\n",
@@ -273,6 +330,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *aseg = (void *)alt->sh_addr;
 		apply_alternatives(aseg, aseg + alt->sh_size);
 	}
+
 	if (locks && text) {
 		void *lseg = (void *)locks->sh_addr;
 		void *tseg = (void *)text->sh_addr;
-- 
2.20.1

