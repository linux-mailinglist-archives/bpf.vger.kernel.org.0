Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE7043C5E1
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 10:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbhJ0JCE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 05:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbhJ0JCE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 05:02:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52163C061570
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 01:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ZyqJYqzEhoI55BAZafjApib17SS+r+jtGse6fHN1APU=; b=j205C4rVZGcihFnkLhiv/8rPMl
        7mobHgbSM309ZmTDxOvAVPkNLleNT6foHv0TeoOOc3jO/6DDfQV7Uswgx77SqpbI06Vj9P/KCfGpJ
        WU4D8pTWuWmrV6f5/5dauiQPZC3km6tI6JITooaWu5mHGnEFJ7iq07K6BRR72P4AZWm4yl0gbQYvD
        ZBf5wVH5uF0vtSq9gkQa3uwTwmupAIH6Hh3L3BLaUwK+l1T+5a1ZrqG6BzM+H1pdSpWGHT9Ao+BFU
        H3+Aa9alQ2lFPBpVQtFlHq6kMVIt1KcbzrwsyEWYYGx4y35WGGKUjo/677kgbOYZ2iag49Fjq+xko
        tsRQi1Gw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfelI-00HWTD-Rm
        for bpf@vger.kernel.org; Wed, 27 Oct 2021 08:58:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E745300577
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 679F5236E43D5; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Message-ID: <20211027085520.105191946@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 10:52:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bpf@vger.kernel.org
Subject: [PATCH bpf-next 01/17] objtool: Handle __sanitize_cov*() tail calls
References: <20211027085243.008677168@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Turns out the compilers also generate tail calls to __sanitize_cov*(),
make sure to also patch those out in noinstr code.

Fixes: 0f1441b44e82 ("objtool: Fix noinstr vs KCOV")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20210624095147.818783799@infradead.org
---
 tools/objtool/arch/x86/decode.c      |   20 ++++
 tools/objtool/check.c                |  158 ++++++++++++++++++-----------------
 tools/objtool/include/objtool/arch.h |    1 
 3 files changed, 105 insertions(+), 74 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -659,6 +659,26 @@ const char *arch_nop_insn(int len)
 	return nops[len-1];
 }
 
+#define BYTE_RET	0xC3
+
+const char *arch_ret_insn(int len)
+{
+	static const char ret[5][5] = {
+		{ BYTE_RET },
+		{ BYTE_RET, BYTES_NOP1 },
+		{ BYTE_RET, BYTES_NOP2 },
+		{ BYTE_RET, BYTES_NOP3 },
+		{ BYTE_RET, BYTES_NOP4 },
+	};
+
+	if (len < 1 || len > 5) {
+		WARN("invalid RET size: %d\n", len);
+		return NULL;
+	}
+
+	return ret[len-1];
+}
+
 /* asm/alternative.h ? */
 
 #define ALTINSTR_FLAG_INV	(1 << 15)
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -828,6 +828,79 @@ static struct reloc *insn_reloc(struct o
 	return insn->reloc;
 }
 
+static void remove_insn_ops(struct instruction *insn)
+{
+	struct stack_op *op, *tmp;
+
+	list_for_each_entry_safe(op, tmp, &insn->stack_ops, list) {
+		list_del(&op->list);
+		free(op);
+	}
+}
+
+static void add_call_dest(struct objtool_file *file, struct instruction *insn,
+			  struct symbol *dest, bool sibling)
+{
+	struct reloc *reloc = insn_reloc(file, insn);
+
+	insn->call_dest = dest;
+	if (!dest)
+		return;
+
+	if (insn->call_dest->static_call_tramp) {
+		list_add_tail(&insn->call_node,
+			      &file->static_call_list);
+	}
+
+	/*
+	 * Many compilers cannot disable KCOV with a function attribute
+	 * so they need a little help, NOP out any KCOV calls from noinstr
+	 * text.
+	 */
+	if (insn->sec->noinstr &&
+	    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
+		if (reloc) {
+			reloc->type = R_NONE;
+			elf_write_reloc(file->elf, reloc);
+		}
+
+		elf_write_insn(file->elf, insn->sec,
+			       insn->offset, insn->len,
+			       sibling ? arch_ret_insn(insn->len)
+			               : arch_nop_insn(insn->len));
+
+		insn->type = sibling ? INSN_RETURN : INSN_NOP;
+	}
+
+	if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
+		if (sibling)
+			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
+
+		if (reloc) {
+			reloc->type = R_NONE;
+			elf_write_reloc(file->elf, reloc);
+		}
+
+		elf_write_insn(file->elf, insn->sec,
+			       insn->offset, insn->len,
+			       arch_nop_insn(insn->len));
+
+		insn->type = INSN_NOP;
+
+		list_add_tail(&insn->mcount_loc_node,
+			      &file->mcount_loc_list);
+	}
+
+	/*
+	 * Whatever stack impact regular CALLs have, should be undone
+	 * by the RETURN of the called function.
+	 *
+	 * Annotated intra-function calls retain the stack_ops but
+	 * are converted to JUMP, see read_intra_function_calls().
+	 */
+	remove_insn_ops(insn);
+}
+
 /*
  * Find the destination instructions for all jumps.
  */
@@ -866,11 +939,7 @@ static int add_jump_destinations(struct
 			continue;
 		} else if (insn->func) {
 			/* internal or external sibling call (with reloc) */
-			insn->call_dest = reloc->sym;
-			if (insn->call_dest->static_call_tramp) {
-				list_add_tail(&insn->call_node,
-					      &file->static_call_list);
-			}
+			add_call_dest(file, insn, reloc->sym, true);
 			continue;
 		} else if (reloc->sym->sec->idx) {
 			dest_sec = reloc->sym->sec;
@@ -926,13 +995,8 @@ static int add_jump_destinations(struct
 
 			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
 				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
-
 				/* internal sibling call (without reloc) */
-				insn->call_dest = insn->jump_dest->func;
-				if (insn->call_dest->static_call_tramp) {
-					list_add_tail(&insn->call_node,
-						      &file->static_call_list);
-				}
+				add_call_dest(file, insn, insn->jump_dest->func, true);
 			}
 		}
 	}
@@ -940,16 +1004,6 @@ static int add_jump_destinations(struct
 	return 0;
 }
 
-static void remove_insn_ops(struct instruction *insn)
-{
-	struct stack_op *op, *tmp;
-
-	list_for_each_entry_safe(op, tmp, &insn->stack_ops, list) {
-		list_del(&op->list);
-		free(op);
-	}
-}
-
 static struct symbol *find_call_destination(struct section *sec, unsigned long offset)
 {
 	struct symbol *call_dest;
@@ -968,6 +1022,7 @@ static int add_call_destinations(struct
 {
 	struct instruction *insn;
 	unsigned long dest_off;
+	struct symbol *dest;
 	struct reloc *reloc;
 
 	for_each_insn(file, insn) {
@@ -977,7 +1032,9 @@ static int add_call_destinations(struct
 		reloc = insn_reloc(file, insn);
 		if (!reloc) {
 			dest_off = arch_jump_destination(insn);
-			insn->call_dest = find_call_destination(insn->sec, dest_off);
+			dest = find_call_destination(insn->sec, dest_off);
+
+			add_call_dest(file, insn, dest, false);
 
 			if (insn->ignore)
 				continue;
@@ -995,9 +1052,8 @@ static int add_call_destinations(struct
 
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-			insn->call_dest = find_call_destination(reloc->sym->sec,
-								dest_off);
-			if (!insn->call_dest) {
+			dest = find_call_destination(reloc->sym->sec, dest_off);
+			if (!dest) {
 				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
 					  insn->sec, insn->offset,
 					  reloc->sym->sec->name,
@@ -1005,6 +1061,8 @@ static int add_call_destinations(struct
 				return -1;
 			}
 
+			add_call_dest(file, insn, dest, false);
+
 		} else if (arch_is_retpoline(reloc->sym)) {
 			/*
 			 * Retpoline calls are really dynamic calls in
@@ -1020,55 +1078,7 @@ static int add_call_destinations(struct
 			continue;
 
 		} else
-			insn->call_dest = reloc->sym;
-
-		if (insn->call_dest && insn->call_dest->static_call_tramp) {
-			list_add_tail(&insn->call_node,
-				      &file->static_call_list);
-		}
-
-		/*
-		 * Many compilers cannot disable KCOV with a function attribute
-		 * so they need a little help, NOP out any KCOV calls from noinstr
-		 * text.
-		 */
-		if (insn->sec->noinstr &&
-		    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
-			if (reloc) {
-				reloc->type = R_NONE;
-				elf_write_reloc(file->elf, reloc);
-			}
-
-			elf_write_insn(file->elf, insn->sec,
-				       insn->offset, insn->len,
-				       arch_nop_insn(insn->len));
-			insn->type = INSN_NOP;
-		}
-
-		if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
-			if (reloc) {
-				reloc->type = R_NONE;
-				elf_write_reloc(file->elf, reloc);
-			}
-
-			elf_write_insn(file->elf, insn->sec,
-				       insn->offset, insn->len,
-				       arch_nop_insn(insn->len));
-
-			insn->type = INSN_NOP;
-
-			list_add_tail(&insn->mcount_loc_node,
-				      &file->mcount_loc_list);
-		}
-
-		/*
-		 * Whatever stack impact regular CALLs have, should be undone
-		 * by the RETURN of the called function.
-		 *
-		 * Annotated intra-function calls retain the stack_ops but
-		 * are converted to JUMP, see read_intra_function_calls().
-		 */
-		remove_insn_ops(insn);
+			add_call_dest(file, insn, reloc->sym, false);
 	}
 
 	return 0;
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -82,6 +82,7 @@ unsigned long arch_jump_destination(stru
 unsigned long arch_dest_reloc_offset(int addend);
 
 const char *arch_nop_insn(int len);
+const char *arch_ret_insn(int len);
 
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
 


