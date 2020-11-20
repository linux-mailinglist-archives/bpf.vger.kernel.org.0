Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243572BB6E7
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 21:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbgKTUaO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 15:30:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:10348 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731043AbgKTUaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 15:30:05 -0500
IronPort-SDR: g9KTMKH16I0tf0sG0egd2iBrm0xjTaVZoINBmcUXqUB1xFuKKHMaHRBsa0amu2oIQ5H4WuumxB
 FKaIrlnH/6UA==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="235683310"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="235683310"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:04 -0800
IronPort-SDR: gJ6W2CFNMwn1RagqoGLH/KeqmBi6Dhzx2j/5cSBj3ZQTj3v8ZsjxGeTStmhQgZKVVm4KAoPcnN
 T/CopTEyg3wQ==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="342163319"
Received: from rpedgeco-mobl.amr.corp.intel.com (HELO localhost.intel.com) ([10.209.105.214])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:04 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, jeyu@kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, luto@kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, x86@kernel.org,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com
Cc:     elena.reshetova@intel.com, ira.weiny@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC 08/10] jump_label: Handle module writable address
Date:   Fri, 20 Nov 2020 12:24:24 -0800
Message-Id: <20201120202426.18009-9-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since modules can have a separate writable address during loading,
do the nop application at the writable address.

As long as info is on hand about if the operations is happening during
a module load, don't do a full text_poke() when writing data to a
writable address.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/jump_label.c | 18 ++++++++++++++++--
 kernel/jump_label.c          |  2 +-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index 5ba8477c2cb7..7a50148a63dd 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -63,6 +63,18 @@ static inline void __jump_label_transform(struct jump_entry *entry,
 					  int init)
 {
 	const void *opcode = __jump_label_set_jump_code(entry, type, init);
+	unsigned long addr = jump_entry_code(entry);
+	struct module *mod = __module_address(addr);
+	bool mod_writable = false;
+
+	if (mod) {
+		struct perm_allocation *alloc = module_get_allocation(mod, addr);
+
+		if (perm_is_writable(alloc)) {
+			addr = perm_writable_addr(alloc, addr);
+			mod_writable = true;
+		}
+	}
 
 	/*
 	 * As long as only a single processor is running and the code is still
@@ -74,9 +86,11 @@ static inline void __jump_label_transform(struct jump_entry *entry,
 	 * At the time the change is being done, just ignore whether we
 	 * are doing nop -> jump or jump -> nop transition, and assume
 	 * always nop being the 'currently valid' instruction
+	 *
+	 * If this is a module being loaded, text_poke_early can also be used.
 	 */
-	if (init || system_state == SYSTEM_BOOTING) {
-		text_poke_early((void *)jump_entry_code(entry), opcode,
+	if (init || system_state == SYSTEM_BOOTING || mod_writable) {
+		text_poke_early((void *)addr, opcode,
 				JUMP_LABEL_NOP_SIZE);
 		return;
 	}
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 015ef903ce8c..3919e78fce12 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -595,7 +595,7 @@ static void __jump_label_mod_update(struct static_key *key)
  */
 void jump_label_apply_nops(struct module *mod)
 {
-	struct jump_entry *iter_start = mod->jump_entries;
+	struct jump_entry *iter_start = module_adjust_writable_addr(mod->jump_entries);
 	struct jump_entry *iter_stop = iter_start + mod->num_jump_entries;
 	struct jump_entry *iter;
 
-- 
2.20.1

