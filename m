Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEE743B1D1
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbhJZMHx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 08:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbhJZMHt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 08:07:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C98FC061220;
        Tue, 26 Oct 2021 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8kDZVERolORkFGbEFI3gQAAb9SpVjedaRkguUav/LRc=; b=kh9KcajrAc2AAzATUAaQFxgqMb
        siCQD6i8pQcqq5lmYfyH3FI2u9cdZ9rqeN9YlVgSB9+H8H3OsvAlx1AoS6NZ/svQKhBoWbNeIyo1S
        WSu6DGm07NJOjWCNuVHy3nbZb3GzRj2xQVH2m2iIDhOnm0rz3WRLiRb2Wlfrn9Nl5lTkAbx8+JhmR
        wsf3f4b9uqC+NuAMTkMCzmKeUc7sBeWnfzXQH9UXbUwWYMN12lD5IcTjuadF/c2T4aGjlbr/Lh9Bp
        MGbrc9n1//6sh3S3Wk8GMkkka90PrC2A0gNufLr2RGuNVYjyF82yBYtCKbnbn3lLS3jfdwKp4vesT
        AL5miO9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfLCd-00CM0t-9B; Tue, 26 Oct 2021 12:05:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1FB12300288;
        Tue, 26 Oct 2021 14:05:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 05A1525E57E56; Tue, 26 Oct 2021 14:05:14 +0200 (CEST)
Message-ID: <20211026120309.785456706@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 26 Oct 2021 14:01:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com,
        bpf@vger.kernel.org
Subject: [PATCH v3 03/16] objtool: Shrink struct instruction
References: <20211026120132.613201817@infradead.org>
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


