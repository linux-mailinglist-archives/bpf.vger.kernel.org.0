Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF33057B828
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbiGTOIB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 10:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240756AbiGTOHx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 10:07:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A854C32464;
        Wed, 20 Jul 2022 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6PI6oKjncaeSgZdoo1KKImqRT1hx/X10UQeSaaVVn7o=; b=Z3iIfX4rxk/k6ZBDox0GiYaoaN
        ssjccwkghqIAdo2UAzk9TqFJXYN7hZSqdJERTrGQzGz8OOzqW81Fx4RdGBwbKKohD51w0cJ7frDJF
        EJU32PQ7ghgtFjx0fhRfZttmk5uAeVTWYIkPbc2dcAjzKL8/VTX8NkE8dpPXLIeA2X1vD5iurZRld
        9jbmRtqAyKXgREF3KNag1on2PeaaN8nN2+l/LwuYBBtgEolRCoc71c6eTggKFh33mH1zPrvgzUyXd
        LfjuZRoJ/dNDsvXzhIZi7vWmBjvuxu8YGYJpoe4QW4JL8le7122J8m+eWN9yL64vCiKlRTH4Y7e5l
        P/4dUt9w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEAMT-00EWPO-7A; Wed, 20 Jul 2022 14:07:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0EED980BBE; Wed, 20 Jul 2022 16:07:36 +0200 (CEST)
Date:   Wed, 20 Jul 2022 16:07:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Dolgov <9erthalion6@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        songliubraving@fb.com, rostedt@goodmis.org, mingo@redhat.com,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v4 1/1] perf/kprobe: maxactive for fd-based kprobe
Message-ID: <YtgMKDgNLnMIkHLI@worktop.programming.kicks-ass.net>
References: <20220714193403.13211-1-9erthalion6@gmail.com>
 <YtB1PK+NUF5RL9Er@worktop.programming.kicks-ass.net>
 <20220715095236.ywv37a556ktl5oif@ddolgov.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715095236.ywv37a556ktl5oif@ddolgov.remote.csb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 15, 2022 at 11:52:36AM +0200, Dmitry Dolgov wrote:
> > On Thu, Jul 14, 2022 at 09:57:48PM +0200, Peter Zijlstra wrote:
> > On Thu, Jul 14, 2022 at 09:34:03PM +0200, Dmitrii Dolgov wrote:
> > > From: Song Liu <songliubraving@fb.com>
> > >
> > > Enable specifying maxactive for fd based kretprobe. This will be useful
> > > for tracing tools like bcc and bpftrace (see for example discussion [1]).
> > > Use highest 4 bit (bit 59-63) to allow specifying maxactive by log2.
> >
> > What's maxactive? This doesn't really tell me much.
> 
> Maxactive allows specifying how many instances of the specified function
> can be probed simultaneously, it would indeed make sense to mention this
> in the commit message.

But why would we need per-fd configurability? Isn't a global sysctrl
good enough?

> > Why are the top 4 bits the best to use?
> 
> This format exists mostly on proposal rights. Per previous discussions,
> 4 bits seem to be enough to cover reasonable range of maxactive values.
> Top bits seems like a natural place to me following perf_probe_config
> enum, but I would love to hear if there are any alternative suggestions?

I think the precedent you're referring to is UPROBE_REF_CTR, which is a
full 32bit. That lives in the upper half of the word because bit0 is
already taken and using the upper half makes the thing naturally
aligned.

If we only need 4 bits it's must simpler to simply stick it at the
bottom or so.

> 
> > > Note that changes in rethook implementation may render maxactive
> > > obsolete.
> >
> > Then why bother creating an ABI for it?
> 
> If I got Masami right, those potential changes mentioned above are only
> on the planning stage. At the same time the issue is annoying enough to
> try to solve it already now.

Masami; how hard would it be to do this? Creating an ABI for something
that's already planned to be removed seems unfortunate, it would be best
to see if we can find someone to accelerate this work.
