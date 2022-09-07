Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5225B00B3
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 11:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiIGJkP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 05:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiIGJkN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 05:40:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BB67C51E;
        Wed,  7 Sep 2022 02:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ex5u/DhuX8rfuZXDg71Tz6zguvwlJJtmepZqH7Lmb3c=; b=A8XCFB+1zTOUphyf2Gdumbmm7K
        wghc5J1leBQTaioJqDDFwxZqvCstiM/S6DXhbGQ5g9oP/3FFNGNJaT0MJA6gPxC2+PFFoEadIAOYI
        QwPlh0VZ0iRK/p5sF6j6nC61KFQbWVwy6QJ6JNhhfFmV40Qgt9goXax/hOCbMKhBlrfC59G9vLkTv
        1b0E/zIUzdjjDWlgu30TwQ37QGlHSBY8cYBKEcHgNQFzrKqIlA+ET2kElNgtXh3TjEtEixqYHZLTj
        nXKD5GcHsb9BUi2389q/InhjQd0gG9XPpjkrRDU8nmqwwM48n9HbzbsjVFUv6pZyu+9U0vc9iyLot
        Q11CQ7uQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVrXR-00APdq-6V; Wed, 07 Sep 2022 09:40:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96D5C3003B0;
        Wed,  7 Sep 2022 11:40:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 866F52B99C334; Wed,  7 Sep 2022 11:40:04 +0200 (CEST)
Date:   Wed, 7 Sep 2022 11:40:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] objtool,x86: Teach decode about LOOP* instructions
Message-ID: <Yxhm9HuSKSjznSzP@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
 <166251212072.632004.16078953024905883328.stgit@devnote2>
 <YxhDBAhYrs0Sfqjt@hirez.programming.kicks-ass.net>
 <Yxhd4EMKyoFoH9y4@hirez.programming.kicks-ass.net>
 <7ef4b0d724894ff394f9d8921f8c4332@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ef4b0d724894ff394f9d8921f8c4332@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 07, 2022 at 09:06:12AM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 07 September 2022 10:01
> > 
> > On Wed, Sep 07, 2022 at 09:06:45AM +0200, Peter Zijlstra wrote:
> > > On Wed, Sep 07, 2022 at 09:55:21AM +0900, Masami Hiramatsu (Google) wrote:
> > >
> > > > +/* Return the jump target address or 0 */
> > > > +static inline unsigned long insn_get_branch_addr(struct insn *insn)
> > > > +{
> > > > +	switch (insn->opcode.bytes[0]) {
> > > > +	case 0xe0:	/* loopne */
> > > > +	case 0xe1:	/* loope */
> > > > +	case 0xe2:	/* loop */
> > >
> > > Oh cute, objtool doesn't know about those, let me go add them.
> 
> Do they ever appear in the kernel?

No; that is, not on any of the random vmlinux.o images I checked this
morning.

Still, best to properly decode them anyway.
