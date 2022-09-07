Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AE65B05C0
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 15:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiIGNx6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 09:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiIGNxz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 09:53:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B09EA4B06;
        Wed,  7 Sep 2022 06:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2053A618F6;
        Wed,  7 Sep 2022 13:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47798C433D6;
        Wed,  7 Sep 2022 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662558827;
        bh=q6/i/qbBofjSCPfJZTfV7IVR58zQawolVj3yGtzsVOM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hXZX8gxfkItWxQODXNjk4R9ORBkiVEflRNLjya3ab0XiRgS8KJk7CU0Bng6btQS2O
         iJlVzFd1f6FNZvwMytFAQkiIIEdNPo1MlxApSWMN74bFmF/Uf6EJPMXVWXsmR+wvuA
         B1RWTiIxvb6PWJ8mOZLYMixJmhdxS2loZ0UIlBCtla4CsRMTpPgfUoz2z1Y93MYYei
         s+7yFagExhAl/AQN8nhZ/ZK7NnHrx9fYDWk/yaM/Hps29vLVrv13tlIAHZgxvOLZA8
         yhc6zoA1y5yY2Xrs90npmCSeuiHeNCiDd0GuavWfITP9FJVOByWwetLY2+7auV7z8G
         2fDM6jnlL7ozw==
Date:   Wed, 7 Sep 2022 22:53:42 +0900
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
Message-Id: <20220907225342.7932294dc37fed3fbfd66d0e@kernel.org>
In-Reply-To: <YxiVvT56y0muNIKe@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
        <166251212072.632004.16078953024905883328.stgit@devnote2>
        <YxiVvT56y0muNIKe@hirez.programming.kicks-ass.net>
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

On Wed, 7 Sep 2022 14:59:41 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Sep 07, 2022 at 09:55:21AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the CONFIG_RETHUNK and CONFIG_SLS will use INT3 for padding after
> > RET instruction, kprobes always failes to check the probed instruction
> > boundary by decoding the function body if the probed address is after
> > such paddings (Note that some conditional code blocks will be placed
> > after RET instruction, if compiler decides it is not on the hot path.)
> > This is because kprobes expects someone (e.g. kgdb) puts the INT3 as
> > a software breakpoint and it will replace the original instruction.
> > But There are INT3 just for padding in the function, it doesn't need
> > to recover the original instruction.
> > 
> > To avoid this issue, if kprobe finds an INT3, it gets the address of
> > next non-INT3 byte, and search a branch which jumps to the address.
> > If there is the branch, these INT3 will be for padding, so it can be
> > skipped.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Fixes: 15e67227c49a ("x86: Undo return-thunk damage")
> 
> I take objection with this Fixes tag.. if anything it should be the SLS
> commit that predates this.
> 
>   e463a09af2f0 ("x86: Add straight-line-speculation mitigation")

Thanks, I'll change to it.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
