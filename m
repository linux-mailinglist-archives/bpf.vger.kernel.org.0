Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587A45B01C6
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 12:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiIGKV4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 06:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiIGKVf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 06:21:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525A9BB928;
        Wed,  7 Sep 2022 03:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1fH5lTZY7lQmt0IWsqcmVB1n5jzNzdsis9xUZCJTmIQ=; b=ftWDfnPgM0cLdEJqlAVK81kaJr
        1kWcDQzrg6ONx3W+61Pd8n0DiP+q/KvOx6bvNHekc3JNnTco+EjQyqIpySaVvMXE5uQDzV3Yc5QXy
        /0UC7qmfvhAG/VFzBKzNHdckGXehM+NahBzwystLfw35yJxrxf3qx2I/LKS3Mq+LdKwMfcAITtNb+
        OO/W6XCgryjxyXxUjflkVWFJZhFHaVfJ/z7D9DgJfUd6kISO4sbqcVvR/IyMhArBU0jrcMLsDqPs9
        OAQ4svWMwIwZy0h+hGwXKm+avpSJAqwBKti24abyKzh0AJ8sOt6N7TRSOmxUtxlNBeiDrEM/935vv
        wkcQcqPw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVs9F-00BGKJ-Fh; Wed, 07 Sep 2022 10:19:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 762F330013F;
        Wed,  7 Sep 2022 12:19:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2601F203C2334; Wed,  7 Sep 2022 12:19:06 +0200 (CEST)
Date:   Wed, 7 Sep 2022 12:19:06 +0200
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
Message-ID: <YxhwGkmRy/kJa9fG@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
 <166251212072.632004.16078953024905883328.stgit@devnote2>
 <YxhQIBKzi+L0KDhc@hirez.programming.kicks-ass.net>
 <20220907184957.d41f085a998b2c7485353171@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907184957.d41f085a998b2c7485353171@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 07, 2022 at 06:49:57PM +0900, Masami Hiramatsu wrote:
> Yeah, this looks good to me. What I just need is to add expanding
> queue buffer. (can we use xarray for this purpose?)

Yeah, xarray might just work.

I need to go fetch the kids from school, but if I remember I'll modify
objtool to tell us the max number required here (for any one particular
build obviously).
