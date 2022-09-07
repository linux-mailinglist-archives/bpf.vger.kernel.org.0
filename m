Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026905AFFCA
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 11:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiIGJBc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 05:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiIGJB3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 05:01:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BC5A61D7;
        Wed,  7 Sep 2022 02:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CW4HRExqenMAZ4nkOPhRQPHqMmykNX/6bRKuv9UMQPI=; b=G8oTDE1SgmYhSa6dJfZN9QQQPA
        LW7945Y4wGjJiecaY/8nTlvXM34hsZSqAdAdWbDRIWZozsISVbo6j0L4RvmoEe9KymC8JlUCj5r44
        63tumJP9Bqvv8Xe8DP6Zd44npmx8j4Cv4c15tdMACWx/JDKS7GMPtUmYWAz5r8wdyLOZRo61KjwZQ
        LnOWcHt5RVT22uM/5Z/aRV6GQTPkKqXJx1nO7D4tmSR94O1fl+n9WpVvzr5tF82a+/ar+sXQWOusz
        I5Me0fl8Mioo/ZgK4BCzWCy19CrniKXwmXtdXsYb4cwh5itlpRTA2pdr8Zxmz9OqwuvOWVHP2kfqR
        lFf1orbg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVqvx-00APHN-7C; Wed, 07 Sep 2022 09:01:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C74C1300244;
        Wed,  7 Sep 2022 11:01:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77B5B2B98B8C4; Wed,  7 Sep 2022 11:01:20 +0200 (CEST)
Date:   Wed, 7 Sep 2022 11:01:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: [PATCH] objtool,x86: Teach decode about LOOP* instructions
Message-ID: <Yxhd4EMKyoFoH9y4@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
 <166251212072.632004.16078953024905883328.stgit@devnote2>
 <YxhDBAhYrs0Sfqjt@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxhDBAhYrs0Sfqjt@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 07, 2022 at 09:06:45AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 07, 2022 at 09:55:21AM +0900, Masami Hiramatsu (Google) wrote:
> 
> > +/* Return the jump target address or 0 */
> > +static inline unsigned long insn_get_branch_addr(struct insn *insn)
> > +{
> > +	switch (insn->opcode.bytes[0]) {
> > +	case 0xe0:	/* loopne */
> > +	case 0xe1:	/* loope */
> > +	case 0xe2:	/* loop */
> 
> Oh cute, objtool doesn't know about those, let me go add them.

---
Subject: objtool,x86: Teach decode about LOOP* instructions

With kprobes also needing to follow control flow; it was found that
objtool is missing the branches from the LOOP* instructions.

Reported-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index c260006106be..1c253b4b7ce0 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -635,6 +635,12 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		*type = INSN_CONTEXT_SWITCH;
 		break;
 
+	case 0xe0: /* loopne */
+	case 0xe1: /* loope */
+	case 0xe2: /* loop */
+		*type = INSN_JUMP_CONDITIONAL;
+		break;
+
 	case 0xe8:
 		*type = INSN_CALL;
 		/*

