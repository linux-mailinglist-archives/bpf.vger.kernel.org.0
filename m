Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8260A5B4F99
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 17:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIKPOU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 11:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIKPOT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 11:14:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671B211822;
        Sun, 11 Sep 2022 08:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gUjgkgqQUfPWz+NslSISjd1M2mXkp5vFzEkXcy4Wohc=; b=YVmYPaTBUOFkae+zv5N1DpZmAe
        C67K+lZVgxYE4ykj8wQ/yBeVqgpTauN4pMcjK4bQ+oyx0x/ubuPEhkdPGDJxRmd2qYZUi2oRGMbzw
        4zo1lX2yctp5ie3Ofa5u4OXmJAUaTjKNWmJ2CZcEnUeGRYvavsq/mNipQq4Cl54I1ECxaADZOBqBz
        z4UESMIlHgHu4EMIHgBCRFOzZB3r2EKjNOMB9B3fTCtOBkKe7V1FF/IS5byuYVDtXARLywx+fP/Oa
        DkB68SOZt8yz0yUOgwmRkjRLG8O844Z/GEBRKGjFw2mbQc8LXR1vN2orcBBfvlmXXb2+Oq+rcOv6M
        FlMaTxLQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXOez-00F95E-09; Sun, 11 Sep 2022 15:14:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59289300074;
        Sun, 11 Sep 2022 17:14:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40C362B165753; Sun, 11 Sep 2022 17:14:10 +0200 (CEST)
Date:   Sun, 11 Sep 2022 17:14:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH] x86,retpoline: Be sure to emit INT3 after JMP *%\reg
Message-ID: <Yx37QmkpvPoyHFMN@hirez.programming.kicks-ass.net>
References: <166260087224.759381.4170102827490658262.stgit@devnote2>
 <166260088298.759381.11727280480035568118.stgit@devnote2>
 <20220908050855.w77mimzznrlp6pwe@treble>
 <Yxm2QU1NJIkIyrrU@hirez.programming.kicks-ass.net>
 <Yxm+QkFPOhrVSH6q@hirez.programming.kicks-ass.net>
 <CAADnVQKWTaXFqYri9VG3ux-CJEBsjAP5PetH6Q1ccS8HoeP28g@mail.gmail.com>
 <Yxr2TaWaN8VjJ60D@hirez.programming.kicks-ass.net>
 <20220909164809.k5vkeujwpvywkpmt@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909164809.k5vkeujwpvywkpmt@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 09, 2022 at 09:48:09AM -0700, Josh Poimboeuf wrote:
> On Fri, Sep 09, 2022 at 10:16:13AM +0200, Peter Zijlstra wrote:
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -419,7 +419,9 @@ static void emit_indirect_jump(u8 **ppro
> >  		OPTIMIZER_HIDE_VAR(reg);
> >  		emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
> >  	} else {
> > -		EMIT2(0xFF, 0xE0 + reg);
> > +		EMIT2(0xFF, 0xE0 + reg);	/* jmp *%\reg */
> > +		if (IS_ENABLED(CONFIG_RETPOLINE) || IS_ENABLED(CONFIG_SLS))
> > +			EMIT1(0xCC);		/* int3 */
> >  	}
> 
> Hm, if you have retpolines disabled at runtime, why would you want this.

Because I don't think eIBRS guarantees it will not SLS.
