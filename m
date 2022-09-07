Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DF25B05A8
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 15:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiIGNt2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 09:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIGNt1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 09:49:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A60F15A0B;
        Wed,  7 Sep 2022 06:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A741B618F8;
        Wed,  7 Sep 2022 13:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAF5C433C1;
        Wed,  7 Sep 2022 13:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662558558;
        bh=jfGMvvgU73fOs5THoBpnCmLJXE/C7Z0KVrauUi0QOuk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T0SVWdR71IAWnTAHA6mbr3lYG0jMFn8ck2BHcixUXeMZvifPfyGgjS8t9oRUNiXjL
         jKTjNVoBti1VUp/SF4pRCpJbmfoOup/uBm46rg4faY/kuLIrtTiFqbyn87pWi5/EVX
         8lsKUdes1SqI755B3RoSUV1pw9CqOoSjWgLRYKpOgvdWdyY/4bMF6+IIM0sURKlBBD
         mEeRWlxSXkY4/jkAdramYzY7lqc4N9P2HiyQiVIdfxyDD7DpMp7dXHsdzGtP2ONhiT
         5Lv0VVFrXPX8v6waOyBI67xviG9Qshdi8QS/X5IYH9ooD5t1TEOIruRxWjRv3nW2J8
         HMDbvYZIn9zBg==
Date:   Wed, 7 Sep 2022 22:49:13 +0900
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
Message-Id: <20220907224913.dfdbea2ec6cd637438dbd09a@kernel.org>
In-Reply-To: <YxiVFJ9UdM5KeIXf@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
        <166251212072.632004.16078953024905883328.stgit@devnote2>
        <YxiVFJ9UdM5KeIXf@hirez.programming.kicks-ass.net>
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

On Wed, 7 Sep 2022 14:56:52 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Sep 07, 2022 at 09:55:21AM +0900, Masami Hiramatsu (Google) wrote:
> 
> >  	if (!kallsyms_lookup_size_offset(paddr, NULL, &offset))
> >  		return 0;
> >  
> 
> One more thing:
> 
>   https://lkml.kernel.org/r/20220902130951.853460809@infradead.org
> 
> can result in negative offsets. The expression:
> 
> 	'paddr - offset'
> 
> will still get you to +0, but I might not have fully considered things
> when I wrote that patch.

Hmm, isn't 'offset' unsigned? If 'paddr - offset' is still available
to find the function entry address, it is OK to me.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
