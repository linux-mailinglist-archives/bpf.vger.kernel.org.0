Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAABA2BB6E6
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 21:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbgKTUaO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 15:30:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:10342 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731023AbgKTUaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 15:30:05 -0500
IronPort-SDR: K2d95Nu4mp/a4670UE8IY5Wnz0GTiZGFqnjXwYRXAq4ZHQKzykQnpYSSNXJsTTAR2rc3xH0g/1
 OzZRtPm8nknQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="235683303"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="235683303"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:03 -0800
IronPort-SDR: E3Uc8tOndvBdwSPq0RRlnOjyyziKbRbBuO7nCsOiNMuCDPsSgn1Bym+Sc3Bcy/sFyeXqTRpAyd
 3bo/AIxGPz6A==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="342163305"
Received: from rpedgeco-mobl.amr.corp.intel.com (HELO localhost.intel.com) ([10.209.105.214])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:03 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, jeyu@kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, luto@kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, x86@kernel.org,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com
Cc:     elena.reshetova@intel.com, ira.weiny@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC 06/10] x86/alternatives: Handle perm_allocs for modules
Date:   Fri, 20 Nov 2020 12:24:22 -0800
Message-Id: <20201120202426.18009-7-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Modules being loaded using perm_allocs may have a separate writable
address. Handle this case in alternatives for operations called during
module loading.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/alternative.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 2400ad62f330..e6d8a696540b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -373,7 +373,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 						  struct alt_instr *end)
 {
 	struct alt_instr *a;
-	u8 *instr, *replacement;
+	u8 *instr, *writ_instr, *replacement, *writ_replacement;
 	u8 insn_buff[MAX_PATCH_LEN];
 
 	DPRINTK("alt table %px, -> %px", start, end);
@@ -391,11 +391,13 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 
 		instr = (u8 *)&a->instr_offset + a->instr_offset;
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
+		writ_instr = (u8 *)module_adjust_writable_addr(instr);
+		writ_replacement = (u8 *)module_adjust_writable_addr(replacement);
 		BUG_ON(a->instrlen > sizeof(insn_buff));
 		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
 		if (!boot_cpu_has(a->cpuid)) {
 			if (a->padlen > 1)
-				optimize_nops(a, instr);
+				optimize_nops(a, writ_instr);
 
 			continue;
 		}
@@ -403,13 +405,13 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		DPRINTK("feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d), pad: %d",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
-			instr, instr, a->instrlen,
+			writ_instr, instr, a->instrlen,
 			replacement, a->replacementlen, a->padlen);
 
 		DUMP_BYTES(instr, a->instrlen, "%px: old_insn: ", instr);
 		DUMP_BYTES(replacement, a->replacementlen, "%px: rpl_insn: ", replacement);
 
-		memcpy(insn_buff, replacement, a->replacementlen);
+		memcpy(insn_buff, writ_replacement, a->replacementlen);
 		insn_buff_sz = a->replacementlen;
 
 		/*
@@ -435,7 +437,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		}
 		DUMP_BYTES(insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
 
-		text_poke_early(instr, insn_buff, insn_buff_sz);
+		text_poke_early(writ_instr, insn_buff, insn_buff_sz);
 	}
 }
 
@@ -496,6 +498,10 @@ void __init_or_module alternatives_smp_module_add(struct module *mod,
 						  void *text,  void *text_end)
 {
 	struct smp_alt_module *smp;
+	void *w_locks = module_adjust_writable_addr(locks);
+	void *w_locks_end = module_adjust_writable_addr(locks_end);
+	void *w_text = module_adjust_writable_addr(text);
+	void *w_text_end = module_adjust_writable_addr(text_end);
 
 	mutex_lock(&text_mutex);
 	if (!uniproc_patched)
@@ -522,7 +528,7 @@ void __init_or_module alternatives_smp_module_add(struct module *mod,
 
 	list_add_tail(&smp->next, &smp_alt_modules);
 smp_unlock:
-	alternatives_smp_unlock(locks, locks_end, text, text_end);
+	alternatives_smp_unlock(w_locks, w_locks_end, w_text, w_text_end);
 unlock:
 	mutex_unlock(&text_mutex);
 }
@@ -601,17 +607,18 @@ void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
 
 	for (p = start; p < end; p++) {
 		unsigned int used;
+		void *writable = module_adjust_writable_addr(p->instr);
 
 		BUG_ON(p->len > MAX_PATCH_LEN);
 		/* prep the buffer with the original instructions */
-		memcpy(insn_buff, p->instr, p->len);
-		used = pv_ops.init.patch(p->type, insn_buff, (unsigned long)p->instr, p->len);
+		memcpy(insn_buff, writable, p->len);
+		used = pv_ops.init.patch(p->type, insn_buff, (unsigned long)writable, p->len);
 
 		BUG_ON(used > p->len);
 
 		/* Pad the rest with nops */
 		add_nops(insn_buff + used, p->len - used);
-		text_poke_early(p->instr, insn_buff, p->len);
+		text_poke_early(writable, insn_buff, p->len);
 	}
 }
 extern struct paravirt_patch_site __start_parainstructions[],
-- 
2.20.1

