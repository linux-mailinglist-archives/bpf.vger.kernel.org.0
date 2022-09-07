Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97035B0690
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 16:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiIGO3G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 10:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiIGO3B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 10:29:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB6F4F1B1;
        Wed,  7 Sep 2022 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=inHqbG6NSnuJ5skBNuf/ekCdeq4XFuOJvc4VpR5QXL4=; b=m+PLj/7AfIBomU+XrCnPnsSCWP
        vmOP+WwlHmrgshXWAHq6bpC8mNVC266LHnU8+tSDwYhdo863MH2MFD0YaLoEhC2o7jzQbsAyQWUj0
        8Ghop8M/3BEk8oUuO703ZHkkDzFmtYbLezlyf3kEBfEsoXIB/0KE4qoOwk3Dnm9AiwXy+12YirkJx
        J4rFEUEw/sprFxvFoTHlSp3ni3ADG7owkgsp3sYkckOFsLLBfHXkRDqGfkExGD0qYK8GOluUxP1QD
        7fbRPmB5C+mN5q/BSALV6v3lFA5Gy+0ovf+14NLA8O3XMmvl6tMT1UOAdpOI8cPD8eNMAGzpW83+X
        jFt2tphw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVw2Y-00BQC8-TF; Wed, 07 Sep 2022 14:28:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C847730013F;
        Wed,  7 Sep 2022 16:28:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE3912B9CF1E2; Wed,  7 Sep 2022 16:28:28 +0200 (CEST)
Date:   Wed, 7 Sep 2022 16:28:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/kprobes: Fix kprobes instruction boudary check
 with CONFIG_RETHUNK
Message-ID: <YxiqjKU9xGma3Bnt@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
 <166251212072.632004.16078953024905883328.stgit@devnote2>
 <YxiVFJ9UdM5KeIXf@hirez.programming.kicks-ass.net>
 <20220907224913.dfdbea2ec6cd637438dbd09a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907224913.dfdbea2ec6cd637438dbd09a@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 07, 2022 at 10:49:13PM +0900, Masami Hiramatsu wrote:
> On Wed, 7 Sep 2022 14:56:52 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Sep 07, 2022 at 09:55:21AM +0900, Masami Hiramatsu (Google) wrote:
> > 
> > >  	if (!kallsyms_lookup_size_offset(paddr, NULL, &offset))
> > >  		return 0;
> > >  
> > 
> > One more thing:
> > 
> >   https://lkml.kernel.org/r/20220902130951.853460809@infradead.org
> > 
> > can result in negative offsets. The expression:
> > 
> > 	'paddr - offset'
> > 
> > will still get you to +0, but I might not have fully considered things
> > when I wrote that patch.
> 
> Hmm, isn't 'offset' unsigned? If 'paddr - offset' is still available
> to find the function entry address, it is OK to me.

Yeah, but the magic of 2s complement means it doesn't matter ;-)
