Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4695B04A8
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 15:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiIGNFa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 09:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiIGNF0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 09:05:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A3424092;
        Wed,  7 Sep 2022 06:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kpPb9FZKLL7QQXvoFpRetjYb96UzC24nWBfneFEYOiE=; b=XvVjPq1NB5NC/OZGSspv+CF+uC
        E3NYs/YQKFioRcgzm39m4t13fATLdEpkgmjphWfxAdbxYPNFrG6FNxNGbflCBWuwIDE3Un/3r4v78
        b8HkwwvlwzlVlC2QjUtrxRIAZYpeKam0IW0hLrc5+ny8/IBVKTtuy9YpPztXDbiQop609uLzDGoT5
        uubw+HFFKiBO9qOqaQKSmEKsvsrXqvNRIkJ0VWmQ2zpeStDaZH25xM+orgfsvM/uvirbXfQnomVYo
        wV4Es33QPpe2jWIsB76vn3tPxNrBiHNIhUfyGz9RkfVJK0+VjLufYd7JwMhwYbK7K7KOqbGYMNe0E
        Ws+zTXGA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVujy-00ARjW-2K; Wed, 07 Sep 2022 13:05:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CF6A3002A3;
        Wed,  7 Sep 2022 15:05:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82D20203C2334; Wed,  7 Sep 2022 15:05:13 +0200 (CEST)
Date:   Wed, 7 Sep 2022 15:05:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/kprobes: Fix kprobes instruction boudary check
 with CONFIG_RETHUNK
Message-ID: <YxiXCf1LcFqj5di6@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
 <166251212072.632004.16078953024905883328.stgit@devnote2>
 <YxhQIBKzi+L0KDhc@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxhQIBKzi+L0KDhc@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 07, 2022 at 10:02:41AM +0200, Peter Zijlstra wrote:

> 	struct queue q;
> 
> 	start = paddr - offset;
> 	end = start + size;
> 	push(&q, paddr - offset);
> 
> 	while (start = pop(&q)) {
> 		for_each_insn(&insn, start, end, buf) {
> 			if (insn.kaddr == paddr)
> 				return 1;
> 
> 			target = insn_get_branch_addr(&insn);
> 			if (target)
> 				push(&q, target);
> 
> 			if (dead_end_insn(&insn))
> 				break;
> 		}
> 	}

There is the very rare case of intra-function-calls; but I *think*
they're all in noinstr/nokprobe code anyway.

For instance we have RSB stuffing code like:

	.rept 16
	call 1f;
	int3
	1:
	.endr
	add $(BITS_PER_LONG/8) * 16, %_ASM_SP

And the proposed will be horribly confused by that. But like said; it
should also never try and untangle it.
