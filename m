Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488465B0474
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 14:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiIGM5C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 08:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIGM5B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 08:57:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D151B61DBD;
        Wed,  7 Sep 2022 05:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=saz/FrJ1w47O2wLBfc2rAqnN8dl7BoLqINnYw53up78=; b=J/AlguoYEKFUJHZzZTzTeihCY2
        1eIruknXw5y/I46AHz3YFYUNX0+Wu6rDfuE7xaknQKQKS3iEtybFg74Lyl0GPD0eBs4V9oHTK56OO
        llkUfN0yU7B4h8tMB2ob7MFt9PGq6CMSHh3SuS2LIYv4TJYCo049bHFuiXRuyyXfmyBxUHO1z8ZW9
        lC/GPtw46IQF29WjzV2tJZQb/9pYS427AolTPvgnUzBQRwOPZNus/f0FeFbcYzQti87V4UxUWK6YB
        nro8XkeDj8nBpOUASApqByDfB8uPAqCE+yCcZ61VkFxPz7BfyS2gcp6AZvAhQAF6Qq30N/iqH+D65
        Wbv4amcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVubu-00ARZI-39; Wed, 07 Sep 2022 12:56:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 593473002A3;
        Wed,  7 Sep 2022 14:56:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE50C203C2334; Wed,  7 Sep 2022 14:56:52 +0200 (CEST)
Date:   Wed, 7 Sep 2022 14:56:52 +0200
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
Message-ID: <YxiVFJ9UdM5KeIXf@hirez.programming.kicks-ass.net>
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

>  	if (!kallsyms_lookup_size_offset(paddr, NULL, &offset))
>  		return 0;
>  

One more thing:

  https://lkml.kernel.org/r/20220902130951.853460809@infradead.org

can result in negative offsets. The expression:

	'paddr - offset'

will still get you to +0, but I might not have fully considered things
when I wrote that patch.
