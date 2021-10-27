Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1006F43C5D0
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 10:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhJ0JBB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 05:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbhJ0JAy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 05:00:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB8DC061745
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 01:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8kDZVERolORkFGbEFI3gQAAb9SpVjedaRkguUav/LRc=; b=GlOTVI7O0X+gp7sw3nh54Nk8cx
        rqXgrpLaVnVUxo6eB3mK3nnrSnhN7VMOUOfBJYKXcQAMUok+ezwKT2+CehhRh1mKY1Y8a8V3+K7fb
        GIDpK9FajCj8qvPL77E1Qpviha3IoaetwnCoACHAc3Ip3rQeThr1PXqlIKT9gaRoHeiGUkTYFH/F8
        yfbj5Y2IdxlClKdav+VFmj8mzHDzxUYojULKRCvq2FhfcRAJQ5ZgWbY8cOrkGMj9uKtuKFoGMWe3Y
        flZP5CjSdNcOUq51mGwnxcuEVAeyE2d8N1GuFnWyTm7U1fjVYnjSpuoJ7gAxofYuBUWHnbIoyvgcr
        Co9h9A4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfelJ-00CWVw-CL
        for bpf@vger.kernel.org; Wed, 27 Oct 2021 08:58:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 86FE630077D
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 70FE2236E43D9; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Message-ID: <20211027085520.295549715@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 10:52:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bpf@vger.kernel.org
Subject: [PATCH bpf-next 04/17] objtool: Shrink struct instruction
References: <20211027085243.008677168@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Any one instruction can only ever call a single function, therefore
insn->mcount_loc_node is superfluous and can use insn->call_node.

This shrinks struct instruction, which is by far the most numerous
structure objtool creates.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c                 |    6 +++---
 tools/objtool/include/objtool/check.h |    1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -701,7 +701,7 @@ static int create_mcount_loc_sections(st
 		return 0;
 
 	idx = 0;
-	list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node)
+	list_for_each_entry(insn, &file->mcount_loc_list, call_node)
 		idx++;
 
 	sec = elf_create_section(file->elf, "__mcount_loc", 0, sizeof(unsigned long), idx);
@@ -709,7 +709,7 @@ static int create_mcount_loc_sections(st
 		return -1;
 
 	idx = 0;
-	list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node) {
+	list_for_each_entry(insn, &file->mcount_loc_list, call_node) {
 
 		loc = (unsigned long *)sec->data->d_buf + idx;
 		memset(loc, 0, sizeof(unsigned long));
@@ -1049,7 +1049,7 @@ static void annotate_call_site(struct ob
 
 		insn->type = INSN_NOP;
 
-		list_add_tail(&insn->mcount_loc_node, &file->mcount_loc_list);
+		list_add_tail(&insn->call_node, &file->mcount_loc_list);
 		return;
 	}
 }
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -40,7 +40,6 @@ struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
 	struct list_head call_node;
-	struct list_head mcount_loc_node;
 	struct section *sec;
 	unsigned long offset;
 	unsigned int len;


