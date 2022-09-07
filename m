Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3075B0637
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 16:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiIGOPK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 10:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiIGOPA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 10:15:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C239B1DA60;
        Wed,  7 Sep 2022 07:14:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F08D961912;
        Wed,  7 Sep 2022 14:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27238C43470;
        Wed,  7 Sep 2022 14:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662560094;
        bh=6/deA7kOvkEtq21+4xjp3bBFJhJUeBVvgaGaR1aGFzM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ceJ+hhBh8mlEiM7c3TFf1yDhOtySGUuho88tgA6mwqr1ZiXTsLK/Mu4b/9YZs1rxg
         rszCH8F/lMdyfcIPeusxFjOKEVZ2FDKRhP2DgxY8kEVVJlD0nn0Dcvb1vMbPqlx+Rf
         RLDZsqPkqvD53JpHkO08nRW2Bxdp8codLrb5zYzNMAC/S9Unjj7IzHZhnNxcnzI3tA
         BWLNAkYWlk9OvglgqtngQHOD95Zj6ZjFViuDFJ3/D2qKypVz2cf0k4oRytnFs3O3Tf
         0ttc4EyrT6/N6H4ZHJcM2VjlhlqA9F1mDJ5U1IbXvaktz30loiKxe9q/5+hJQopXUT
         Wavt6BXhrOsXQ==
Date:   Wed, 7 Sep 2022 23:14:50 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/kprobes: Fix kprobes instruction boudary check
 with CONFIG_RETHUNK
Message-Id: <20220907231450.0a5f085319251349a45465d8@kernel.org>
In-Reply-To: <YxiXCf1LcFqj5di6@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
        <166251212072.632004.16078953024905883328.stgit@devnote2>
        <YxhQIBKzi+L0KDhc@hirez.programming.kicks-ass.net>
        <YxiXCf1LcFqj5di6@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 7 Sep 2022 15:05:13 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Sep 07, 2022 at 10:02:41AM +0200, Peter Zijlstra wrote:
> 
> > 	struct queue q;
> > 
> > 	start = paddr - offset;
> > 	end = start + size;
> > 	push(&q, paddr - offset);
> > 
> > 	while (start = pop(&q)) {
> > 		for_each_insn(&insn, start, end, buf) {
> > 			if (insn.kaddr == paddr)
> > 				return 1;
> > 
> > 			target = insn_get_branch_addr(&insn);
> > 			if (target)
> > 				push(&q, target);
> > 
> > 			if (dead_end_insn(&insn))
> > 				break;
> > 		}
> > 	}
> 
> There is the very rare case of intra-function-calls; but I *think*
> they're all in noinstr/nokprobe code anyway.
> 
> For instance we have RSB stuffing code like:
> 
> 	.rept 16
> 	call 1f;
> 	int3
> 	1:
> 	.endr
> 	add $(BITS_PER_LONG/8) * 16, %_ASM_SP
> 
> And the proposed will be horribly confused by that. But like said; it
> should also never try and untangle it.

Yeah, but I guess if we break the decoding (internal) loop when we
hit an INT3, it maybe possible to be handled?

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
