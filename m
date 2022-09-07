Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DA95AFCE1
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 08:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiIGGwo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 02:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiIGGwn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 02:52:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945396CD39;
        Tue,  6 Sep 2022 23:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RnlXlqAOM19R0kaFGigt83kvp+plQFMnYjHIbbb/6qI=; b=m7/1yFb0s50S7M292zPjscSOLY
        yRPL0vsA8r53tcjqjRem66vn/8um3OIpTDf3y2LvnPJozNOtu/uKszlLESigNsUts9wzz28vbvIrr
        nArbN+o7kKqi3C7yEOU+xgYU7luOnXvIXiCCUOPela9ro1q8IKuHwJEaPmA7ncLko1FTKmG6hdh7G
        b/nxDyQS4+mKdUUDxeidihffRL8j0uiDJSoU/xhwfkT+6ywAZuVxGOBzSNA7t7E/yadGCZJxGesdy
        OUOOR5+no7fooT/NCqSkNfWLxfE+q32iUQ8KzKYZBgSSENpDW5jVziu3GRgoz04h2UXlsVStNTH8X
        2D8JowEA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVovI-00AOEi-C2; Wed, 07 Sep 2022 06:52:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 65FE33006A4;
        Wed,  7 Sep 2022 08:52:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 120C3203C095B; Wed,  7 Sep 2022 08:52:30 +0200 (CEST)
Date:   Wed, 7 Sep 2022 08:52:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [PATCH 0/2] x86/kprobes: Fixes for CONFIG_RETHUNK
Message-ID: <Yxg/rZDPc1fKaS7H@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166251211081.632004.1842371136165709807.stgit@devnote2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 07, 2022 at 09:55:11AM +0900, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> Here is a couple of patches to fix kprobes and optprobe to work
> on the kernel with CONFIG_RETHUNK and CONFIG_SLS.
> 
> With these configs, the kernel functions may includes padding INT3 in
> the function code block (body) in addition to the gaps between functions.
> 
> Since kprobes on x86 has to ensure the probe address is a function

s/function/instruction/

> bondary, it decodes the instructions in the function until the address.
> If it finds an INT3 which is not embedded by kprobe, it stops decoding
> because usually the INT3 is used for debugging as a software breakpoint
> and such INT3 will replace the first byte of an original instruction.
> Without recovering it, kprobes can not continue to decode it. Thus the
> kprobes returns -EILSEQ as below.

In the absence of kgdb nobody else except kprobes itself will do this.

>  # echo "p:probe/vfs_truncate_L19 vfs_truncate+98" >> kprobe_events 
>  sh: write error: Invalid or incomplete multibyte or wide character
> 
> 
> Actually, those INT3s are just for padding and can be ignored.

They are speculations stops, not mere padding.


Anyway, let me get on with reading the actual patches :-)
