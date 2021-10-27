Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16F943C5D2
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 10:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbhJ0JBC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 05:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239736AbhJ0JAy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 05:00:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C42C0613B9
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 01:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=GwgsG3Di9p8rXuV3rA9P6bhShDt7bpjbsdpMJwdMdfA=; b=oW1C/2shG3Yc0ZXEWYeTSnL5v9
        u7PBFULNE/cOMLFN6faS/xyoRoEe1Y8B+R9g8gIzJX70dcG6Y9FhqT1sFvRHtgqoNnrUc+Rz/QByo
        ehbEYM3BFkZrjATBCPxN9zZ1uLrP4z0zHhz8IymHB9wpNmsj2Yo1y6pmOSv9sBOvda6maRYKmb32k
        0FTKW0Nn0Og3OqjRIFxbBPLyEXu7tshUe8aWnMXAIN31vODPMYI/i37xLfYgFCHozKT7XcL5kRzd3
        4uio8TO2DR/4NfI4H2xp9qodxRBEbjhQq3BQeBeYz+IBMiJzbKQBpHLwsV+LcZIZQBnFc9A55OtKg
        8yt0i6UQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfelJ-00CWVu-C8
        for bpf@vger.kernel.org; Wed, 27 Oct 2021 08:58:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8145C3005DD
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 69915236E43D8; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Message-ID: <20211027085520.169316183@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 10:52:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bpf@vger.kernel.org
Subject: [PATCH bpf-next 02/17] objtool: Classify symbols
References: <20211027085243.008677168@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In order to avoid calling str*cmp() on symbol names, over and over, do
them all once upfront and store the result.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c               |   34 ++++++++++++++++++++++------------
 tools/objtool/include/objtool/elf.h |    5 ++++-
 2 files changed, 26 insertions(+), 13 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -857,8 +857,7 @@ static void add_call_dest(struct objtool
 	 * so they need a little help, NOP out any KCOV calls from noinstr
 	 * text.
 	 */
-	if (insn->sec->noinstr &&
-	    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
+	if (insn->sec->noinstr && insn->call_dest->kcov) {
 		if (reloc) {
 			reloc->type = R_NONE;
 			elf_write_reloc(file->elf, reloc);
@@ -872,7 +871,7 @@ static void add_call_dest(struct objtool
 		insn->type = sibling ? INSN_RETURN : INSN_NOP;
 	}
 
-	if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
+	if (mcount && insn->call_dest->fentry) {
 		if (sibling)
 			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
 
@@ -922,7 +921,7 @@ static int add_jump_destinations(struct
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-		} else if (arch_is_retpoline(reloc->sym)) {
+		} else if (reloc->sym->retpoline_thunk) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.
@@ -1063,7 +1062,7 @@ static int add_call_destinations(struct
 
 			add_call_dest(file, insn, dest, false);
 
-		} else if (arch_is_retpoline(reloc->sym)) {
+		} else if (reloc->sym->retpoline_thunk) {
 			/*
 			 * Retpoline calls are really dynamic calls in
 			 * disguise, so convert them accordingly.
@@ -1747,17 +1746,28 @@ static int read_intra_function_calls(str
 	return 0;
 }
 
-static int read_static_call_tramps(struct objtool_file *file)
+static int classify_symbols(struct objtool_file *file)
 {
 	struct section *sec;
 	struct symbol *func;
 
 	for_each_sec(file, sec) {
 		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->bind == STB_GLOBAL &&
-			    !strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
+			if (func->bind != STB_GLOBAL)
+				continue;
+
+			if (!strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
 				     strlen(STATIC_CALL_TRAMP_PREFIX_STR)))
 				func->static_call_tramp = true;
+
+			if (arch_is_retpoline(func))
+				func->retpoline_thunk = true;
+
+			if (!strcmp(func->name, "__fentry__"))
+				func->fentry = true;
+
+			if (!strncmp(func->name, "__sanitizer_cov_", 16))
+				func->kcov = true;
 		}
 	}
 
@@ -1819,7 +1829,7 @@ static int decode_sections(struct objtoo
 	/*
 	 * Must be before add_{jump_call}_destination.
 	 */
-	ret = read_static_call_tramps(file);
+	ret = classify_symbols(file);
 	if (ret)
 		return ret;
 
@@ -1877,9 +1887,9 @@ static int decode_sections(struct objtoo
 
 static bool is_fentry_call(struct instruction *insn)
 {
-	if (insn->type == INSN_CALL && insn->call_dest &&
-	    insn->call_dest->type == STT_NOTYPE &&
-	    !strcmp(insn->call_dest->name, "__fentry__"))
+	if (insn->type == INSN_CALL &&
+	    insn->call_dest &&
+	    insn->call_dest->fentry)
 		return true;
 
 	return false;
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -56,7 +56,10 @@ struct symbol {
 	unsigned int len;
 	struct symbol *pfunc, *cfunc, *alias;
 	bool uaccess_safe;
-	bool static_call_tramp;
+	u8 static_call_tramp : 1;
+	u8 retpoline_thunk   : 1;
+	u8 fentry            : 1;
+	u8 kcov              : 1;
 };
 
 struct reloc {


