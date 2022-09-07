Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F7F5B00ED
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 11:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiIGJxY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 05:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiIGJxX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 05:53:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FE6AED86;
        Wed,  7 Sep 2022 02:53:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D2753CE1B0A;
        Wed,  7 Sep 2022 09:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8EEC433D7;
        Wed,  7 Sep 2022 09:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662544397;
        bh=SoVSVoDeNFNPdZcLz1kUYVKzcVZLSHnQuHzOIPhXmsE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uM0Mm0BzO+sEEpgI3+rBBmfz8T9FkFOkWg6G+7VliNTyRtwmCUq9ttBcNgWED5X8L
         bceDgt0iWbSIunn24JuMi5o1KEfy8eiWGS9Px2diY0M3GIYC0ZErnLNnYSYbHhfD03
         5ZXA2PIQc6G1C2rdUeOrXaVU9Sui7d+W360kXL1hdx/iFwwiOA6O1wPW/84wcYnmgB
         uUuRO19OHO0esSS+HLHK0x5IJOK7ztfUngSfc4B04WTj3P6tbVd9fPU//o44iRfwpW
         C4qAM1lGphzPR2G3BK11OB4NUhtb6fwEnZErUbmvFYpAdGT/UAFFoIR5i+2aiyy+vz
         B5ATNTG01BVLg==
Date:   Wed, 7 Sep 2022 18:53:12 +0900
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
Message-Id: <20220907185312.3cc1c2c063912f1ca6f8ea2f@kernel.org>
In-Reply-To: <YxhmnDqSkE8CP3UX@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
        <166251212072.632004.16078953024905883328.stgit@devnote2>
        <YxhDBAhYrs0Sfqjt@hirez.programming.kicks-ass.net>
        <20220907181218.41facc0902789c77e42170ea@kernel.org>
        <YxhmnDqSkE8CP3UX@hirez.programming.kicks-ass.net>
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

On Wed, 7 Sep 2022 11:38:36 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Sep 07, 2022 at 06:12:18PM +0900, Masami Hiramatsu wrote:
> > OK, it should be updated. Where can I refer the names (especially '.dX' suffixes)?
> 
> https://sourceware.org/binutils/docs-2.23.1/as/i386_002dMnemonics.html
> 
>   `.d8' or `.d32' suffix prefers 8bit or 32bit displacement in encoding.

This is good to know. OK, I'll use this.

Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
