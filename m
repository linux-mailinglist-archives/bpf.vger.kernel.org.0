Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6895B068D
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 16:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiIGO2s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 10:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiIGO2i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 10:28:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CDC326FA;
        Wed,  7 Sep 2022 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4jhBj7dPmuLTxxuJxIkQ2mZbwFHE39Abp5GfQEeQl1Q=; b=Oy1vOaX6GJfELthwRG8mE9fitw
        oyJaBrGQJU/P6ADlS3zGWu46PaNAJnBzxmwRJLxnJ+u9NwXDLimbVqHoauzy8kVnWiZ2S0iesF4ur
        QPx5yjzr+T10NPSvw/0CjWCUmVgby0yu2Q0AsCzksqFhkX7nGjKasR8SRIKtGzRmyCZem6pJSJCTL
        504zX85gXXSrYnd0BHkreFoEp2vTBDXvWKKEvalZpIEJA1K/sxTdgu52OfhmdbUB0puDxxfSR+WbD
        zqrvT386aJljaPg1BpxQT0tWlrn9whrEP01OESbxxl959IpS7R4A1rjGcZD0CmH32b1fQ+/YABfaD
        pb2yR1wg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVw26-00BQAI-Rx; Wed, 07 Sep 2022 14:28:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9A25C30013F;
        Wed,  7 Sep 2022 16:27:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23C792B9CF1E0; Wed,  7 Sep 2022 16:27:59 +0200 (CEST)
Date:   Wed, 7 Sep 2022 16:27:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/kprobes: Fix kprobes instruction boudary check
 with CONFIG_RETHUNK
Message-ID: <Yxiqb+QkSQeAPzJw@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
 <166251212072.632004.16078953024905883328.stgit@devnote2>
 <YxhQIBKzi+L0KDhc@hirez.programming.kicks-ass.net>
 <YxiXCf1LcFqj5di6@hirez.programming.kicks-ass.net>
 <20220907231450.0a5f085319251349a45465d8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907231450.0a5f085319251349a45465d8@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 07, 2022 at 11:14:50PM +0900, Masami Hiramatsu wrote:
> On Wed, 7 Sep 2022 15:05:13 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Sep 07, 2022 at 10:02:41AM +0200, Peter Zijlstra wrote:
> > 
> > > 	struct queue q;
> > > 
> > > 	start = paddr - offset;
> > > 	end = start + size;
> > > 	push(&q, paddr - offset);
> > > 
> > > 	while (start = pop(&q)) {
> > > 		for_each_insn(&insn, start, end, buf) {
> > > 			if (insn.kaddr == paddr)
> > > 				return 1;
> > > 
> > > 			target = insn_get_branch_addr(&insn);
> > > 			if (target)
> > > 				push(&q, target);
> > > 
> > > 			if (dead_end_insn(&insn))
> > > 				break;
> > > 		}
> > > 	}
> > 
> > There is the very rare case of intra-function-calls; but I *think*
> > they're all in noinstr/nokprobe code anyway.
> > 
> > For instance we have RSB stuffing code like:
> > 
> > 	.rept 16
> > 	call 1f;
> > 	int3
> > 	1:
> > 	.endr
> > 	add $(BITS_PER_LONG/8) * 16, %_ASM_SP
> > 
> > And the proposed will be horribly confused by that. But like said; it
> > should also never try and untangle it.
> 
> Yeah, but I guess if we break the decoding (internal) loop when we
> hit an INT3, it maybe possible to be handled?

If you make insn_get_branch_addr() return the target of CALL
instructions when this target is between function start and end, it
should work I think.

But like said; this construct is rare and all instances I can remember
should not be kprobes to begin with. These are all 'fun' things like
retpoline stubs and the the above RSB stuff loop.
