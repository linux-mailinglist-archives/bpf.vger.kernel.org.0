Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF63A2BB6DE
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 21:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbgKTUaF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 15:30:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:10351 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730856AbgKTUaE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 15:30:04 -0500
IronPort-SDR: ZoWTypuqFe5meE/xGJe+L1iS6t6cyzZtCxRfH+plddRPwKrovaPxv4IZ+7bPQkQXtgqXe0hIB2
 tMg1pk0kGWgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="235683289"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="235683289"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:02 -0800
IronPort-SDR: Nejog16WYJC4xxerTZ+ibwwHr1kTjU4E3AjULdju3ILgQzs5Mm8WYSfWQjfJf8KUA0rzVfOlbJ
 6FznREPW5cog==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="342163294"
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
Subject: [PATCH RFC 04/10] module: Support separate writable allocation
Date:   Fri, 20 Nov 2020 12:24:20 -0800
Message-Id: <20201120202426.18009-5-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The perm_alloc interface supports architectures to direct writes
intended for an allocation to a separate writable staging area before a
mapping is made live. In order to support this, change modules to write
to the address provided by perm_writable_addr(). Currently this is the
same address of the final allocation, so this patch should not create
any functional change yet.

To facilitate re-direction to separate writable staging areas, create a
helper module_adjust_writable_addr(). This function will return an
allocation's writable address if the parameter address is from a module
that is in the process of being loaded. If the address does not meet that
criteria, simply return the address passed in. This helper, while a
little heavy weight, will allow callers in upcoming patches to simply
retrieve the writable address without context of what module is being
loaded.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/module.h | 22 ++++++++++++++++++++++
 kernel/module.c        | 14 +++++++++-----
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 9964f909d879..32dd22b2a38a 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -576,6 +576,23 @@ struct perm_allocation *module_get_allocation(struct module *mod, unsigned long
 bool module_perm_alloc(struct module_layout *layout);
 void module_perm_free(struct module_layout *layout);
 
+static inline void *module_adjust_writable_addr(void *addr)
+{
+	unsigned long laddr = (unsigned long)addr;
+	struct module *mod;
+
+	mutex_lock(&module_mutex);
+	mod = __module_address(laddr);
+	if (!mod) {
+		mutex_unlock(&module_mutex);
+		return addr;
+	}
+	mutex_unlock(&module_mutex);
+	/* The module shouldn't be going away if someone is trying to write to it */
+
+	return (void *)perm_writable_addr(module_get_allocation(mod, laddr), laddr);
+}
+
 static inline bool within_module_core(unsigned long addr,
 				      const struct module *mod)
 {
@@ -853,6 +870,11 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
 	return ptr;
 }
 
+static inline void *module_adjust_writable_addr(void *addr)
+{
+	return addr;
+}
+
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS
diff --git a/kernel/module.c b/kernel/module.c
index 0b31c44798e2..d0afedd36cea 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3457,7 +3457,7 @@ static int move_module(struct module *mod, struct load_info *info)
 	/* Transfer each section which specifies SHF_ALLOC */
 	pr_debug("final section addresses:\n");
 	for (i = 0; i < info->hdr->e_shnum; i++) {
-		void *dest;
+		void *dest, *wdest;
 		struct perm_allocation *alloc;
 
 		Elf_Shdr *shdr = &info->sechdrs[i];
@@ -3470,9 +3470,10 @@ static int move_module(struct module *mod, struct load_info *info)
 		else
 			alloc = get_alloc_from_layout(&mod->core_layout, shdr->sh_entsize);
 		dest = (void *)perm_alloc_address(alloc) + (shdr->sh_entsize & ~ALL_OFFSET_MASK);
+		wdest = (void *)perm_writable_addr(alloc, (unsigned long)dest);
 
 		if (shdr->sh_type != SHT_NOBITS)
-			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
+			memcpy(wdest, (void *)shdr->sh_addr, shdr->sh_size);
 		/* Update sh_addr to point to copy in image. */
 		shdr->sh_addr = (unsigned long)dest;
 		pr_debug("\t0x%lx %s\n",
@@ -3645,12 +3646,15 @@ int __weak module_finalize(const Elf_Ehdr *hdr,
 
 static int post_relocation(struct module *mod, const struct load_info *info)
 {
+	struct exception_table_entry *extable_writ = module_adjust_writable_addr(mod->extable);
+	void *pcpu = (void *)info->sechdrs[info->index.pcpu].sh_addr;
+	void *percpu_writ = module_adjust_writable_addr(pcpu);
+
 	/* Sort exception table now relocations are done. */
-	sort_extable(mod->extable, mod->extable + mod->num_exentries);
+	sort_extable(extable_writ, mod->extable + mod->num_exentries);
 
 	/* Copy relocated percpu area over. */
-	percpu_modcopy(mod, (void *)info->sechdrs[info->index.pcpu].sh_addr,
-		       info->sechdrs[info->index.pcpu].sh_size);
+	percpu_modcopy(mod, percpu_writ, info->sechdrs[info->index.pcpu].sh_size);
 
 	/* Setup kallsyms-specific fields. */
 	add_kallsyms(mod, info);
-- 
2.20.1

