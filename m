Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1224C5B0486
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 14:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIGM7v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 08:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIGM7u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 08:59:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B4BE092;
        Wed,  7 Sep 2022 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qifuXb99qjoIlKm0NFGBn67x17ezYkhxW54+3QeGgIk=; b=QsUalTTJ6u2L9/i3S1Ur5CkPKf
        ypW9SE+7hPKkivkq4HjmaduBI9F2qEQxOhQRp+WuSxBgfw3DmO12SJX+RNuya92F70/jqjnb+odqv
        KFwTSItzW50xOXKBQ1EUKBmMeJHDRUpgTygZ3kA5jOxsNKCgm24t7vw2IPgFE/JOC4sd9aw2NRzAr
        PAKEdSVwqsPppEANnvqegLjolNx0cOE8uv46O2qTSLr0eiPP9ApZxmqZ0KF3WWgTroTpsWNz3QLu7
        RTrbmTdcQd8OXlAveugTvFf5TIusGxoSN1Mksz5oggd0pabpduTjZjh11UCtuSXbkuMwzGuThtLnh
        Fe4Vdt1A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVuee-00BMnC-Ek; Wed, 07 Sep 2022 12:59:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD8673002A3;
        Wed,  7 Sep 2022 14:59:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 921B4203C2334; Wed,  7 Sep 2022 14:59:41 +0200 (CEST)
Date:   Wed, 7 Sep 2022 14:59:41 +0200
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
Message-ID: <YxiVvT56y0muNIKe@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
 <166251212072.632004.16078953024905883328.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166251212072.632004.16078953024905883328.stgit@devnote2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 07, 2022 at 09:55:21AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the CONFIG_RETHUNK and CONFIG_SLS will use INT3 for padding after
> RET instruction, kprobes always failes to check the probed instruction
> boundary by decoding the function body if the probed address is after
> such paddings (Note that some conditional code blocks will be placed
> after RET instruction, if compiler decides it is not on the hot path.)
> This is because kprobes expects someone (e.g. kgdb) puts the INT3 as
> a software breakpoint and it will replace the original instruction.
> But There are INT3 just for padding in the function, it doesn't need
> to recover the original instruction.
> 
> To avoid this issue, if kprobe finds an INT3, it gets the address of
> next non-INT3 byte, and search a branch which jumps to the address.
> If there is the branch, these INT3 will be for padding, so it can be
> skipped.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Fixes: 15e67227c49a ("x86: Undo return-thunk damage")

I take objection with this Fixes tag.. if anything it should be the SLS
commit that predates this.

  e463a09af2f0 ("x86: Add straight-line-speculation mitigation")

