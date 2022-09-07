Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3CE5B0017
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 11:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIGJM1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 05:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIGJM1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 05:12:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EF4A8953;
        Wed,  7 Sep 2022 02:12:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B5BF61807;
        Wed,  7 Sep 2022 09:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C7FC433C1;
        Wed,  7 Sep 2022 09:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662541942;
        bh=F5BqGSUu4iqZd/yq78KxwFvfS+QZgSQ08ldKXJylc+I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VWSuESpwMyaMRpPsshNsmHWjpMjTVb0M5LaYZogMT3o6j32+KsFbGzUkPjwVahokX
         GC4yyY4zhFyt6aG5EcVvMGfng7Mx2dsk/gUMmhV/1ueLnfC7B70D/OJfNsh25AJbi+
         5xuj3C8VM6UxtrlvZupHMAmNhN74uVGn8RHZCu3nxJIeKiMIfXUtjbP1tFTuEgMfbQ
         rRmQA1eUiFtbF5f9ocOBhAUjkT0L2ZrYpvSvlKRqorLAGPKBAr2Ia6Vo3DQEakonBK
         evmWYq5yajecXaL5zpuNqK46BNrsWqlfXpTI2H+MhBbNUpO6g3YF57Pofqq60mCU46
         w1jRJu2yR3jgQ==
Date:   Wed, 7 Sep 2022 18:12:18 +0900
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
Message-Id: <20220907181218.41facc0902789c77e42170ea@kernel.org>
In-Reply-To: <YxhDBAhYrs0Sfqjt@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
        <166251212072.632004.16078953024905883328.stgit@devnote2>
        <YxhDBAhYrs0Sfqjt@hirez.programming.kicks-ass.net>
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

On Wed, 7 Sep 2022 09:06:44 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

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
> 
> > +	case 0xe3:	/* jcxz */
> > +	case 0xe9:	/* near relative jump */
> 
>  /* JMP.d32 */
> 
> > +	case 0xeb:	/* short relative jump */
> 
>  /* JMP.d8 */
> 
> > +		break;
> > +	case 0x0f:
> > +		if ((insn->opcode.bytes[1] & 0xf0) == 0x80) /* jcc near */
> 
>  /* Jcc.d32 */
> 
> Are the GNU AS names for these things.

OK, it should be updated. Where can I refer the names (especially '.dX' suffixes)?

> 
> > +			break;
> > +		return 0;
> 
> > +	default:
> > +		if ((insn->opcode.bytes[0] & 0xf0) == 0x70) /* jcc short */
> > +			break;
> > +		return 0;
> 
> You could write that as:
> 
> 	case 0x70 ... 0x7f: /* Jcc.d8 */
> 		break;
> 
> 	default:
> 		return 0;

Thanks! I'll update it.

> 
> > +	}
> > +	return (unsigned long)insn->next_byte + insn->immediate.value;
> > +}
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
