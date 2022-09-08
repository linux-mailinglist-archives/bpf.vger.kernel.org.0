Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2095B18B6
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 11:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiIHJay (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 05:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIHJax (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 05:30:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271D4FBF0D;
        Thu,  8 Sep 2022 02:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4MQ/3HGThheOE676Gtz/fWCeZc9RZXa0nz2XTU+rVR0=; b=qW9cM24gcEoPTV0wVO9iHF0J/E
        iUioIaP55admIXelPy7HNav1bFCfmLWpCEFE3553+CnIhvQEfGSMjmJnSBlXdDcXE8C2sdO/w+M+V
        tvJbGZCyzCkloalKnBrMZFQlhnlA4mE/TSUvjb0KUyLeGqCDVJ+gU0yFMOycUB/ojbq3MlDk4gClH
        xDfzs9C4kCpFEWA73CnxQyzz2DqcnNydsb2TXUGa6rJswDhZSqtrsaBycW+N2sA2YrRtHIkfqr+ox
        AuFMvJAJejxm0Q48bPpKyPkj/HPWQydEeZMyi2VifTsDeGzPZh/jral6V//YOtphy7s+SYn3GkXeH
        xUj6pKhw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWDru-00AfeU-JD; Thu, 08 Sep 2022 09:30:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 89F51300074;
        Thu,  8 Sep 2022 11:30:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3235F2B9A6CCA; Thu,  8 Sep 2022 11:30:41 +0200 (CEST)
Date:   Thu, 8 Sep 2022 11:30:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/kprobes: Fix kprobes instruction boudary
 check with CONFIG_RETHUNK
Message-ID: <Yxm2QU1NJIkIyrrU@hirez.programming.kicks-ass.net>
References: <166260087224.759381.4170102827490658262.stgit@devnote2>
 <166260088298.759381.11727280480035568118.stgit@devnote2>
 <20220908050855.w77mimzznrlp6pwe@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908050855.w77mimzznrlp6pwe@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 07, 2022 at 10:08:55PM -0700, Josh Poimboeuf wrote:
> On Thu, Sep 08, 2022 at 10:34:43AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the CONFIG_RETHUNK and CONFIG_SLS will use INT3 for stopping
> > speculative execution after RET instruction, kprobes always failes to
> > check the probed instruction boundary by decoding the function body if
> > the probed address is after such sequence. (Note that some conditional
> > code blocks will be placed after function return, if compiler decides
> > it is not on the hot path.)
> > 
> > This is because kprobes expects someone (e.g. kgdb) puts the INT3 as
> > a software breakpoint and it will replace the original instruction.
> > But these INT3 are not such purpose, it doesn't need to recover the
> > original instruction.
> > 
> > To avoid this issue, memorize the branch target address during decoding
> > and if there is INT3, restart decoding from unchecked target address.
> 
> Hm, is kprobes conflicting with kgdb actually a realistic concern?
> Seems like a dangerous combination

Yeah, not in my book. If you use kgdb you'd better be ready to hold
pieces anyway, that thing is terrible.

> Wouldn't it be much simpler to just encode the knowledge that
> 
>   	if (CONFIG_RETHUNK && !X86_FEATURE_RETHUNK)
> 		// all rets are followed by four INT3s
> 	else if (CONFIG_SLS)
> 		// all rets are followed by one INT3

At the very least that doesn't deal with the INT3 after JMP thing the
compilers should do once they catch up. This issue seems to keep getting
lost, but is now part of the AMD Branch Type Confusion (it was disclosed
in an earlier thing, but I keep forgetting what that was called).

Once that lands the rules are:

 0-5 INT3 after RET, !CONFIG_RETHUNK && !CONFIG_SLS: 0
                     CONFIG_SLS: 1
		     CONFIG_RETHUNK: 4-5 depending on compiler version

 0-1 INT3 after RET: !CONFIG_SLS: 0
		     CONFIG_SLS: 0-1 depending on compiler version

Now, given we know the compiler version at build time, this could be
determined and used in kprobes, but meh.

We also *should* put an INT3 after indirect jumps when patching the
retpolines. We don't appear to do so, but that's recommended even for
Intel I think.

Let me go do a patch.
