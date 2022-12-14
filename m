Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB23564C558
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 09:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbiLNI4M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 03:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbiLNI4L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 03:56:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD53193E5;
        Wed, 14 Dec 2022 00:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4qLs78eGQyGNi4vbKjmNfC+O4t106kpYiQycgssyLgg=; b=AlMdipXWKjoZvGLLYhBVQtp7cU
        ++3Di3oxtUj/+FTTQjM/dMkIw7Kr6garFQt0pvSM/zVv0rb8RggX1BiJgX/lQw8HpxczpcUvDDLEB
        gjTa7HJrbWQh69l2hIQ25pJ2G9Tm9dvKs+/qv7U/RGoxnNW2loI/6P7z3ydQ8FWq433dfEMxQ1glm
        D0Atos5fdgQ/nV85bKV0BODWhpaUvb7lLK/3iHtjxjkP6zbgTSRODjsC0UGIXVDWOHD/BfbySyNO7
        60EbEj87UfnkCy8T+pQaQi1O7u2acmmGT0rYV3Ur29WnWo2OytMKZ4ASxaV3yTL//v+DKgouR9X+Z
        Eqrd+4Qw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5NYL-00D3P5-5R; Wed, 14 Dec 2022 08:55:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8003830030B;
        Wed, 14 Dec 2022 09:55:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51696202344B3; Wed, 14 Dec 2022 09:55:38 +0100 (CET)
Date:   Wed, 14 Dec 2022 09:55:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        brho@google.com, pjt@google.com, derkling@google.com,
        haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCHSET RFC] sched: Implement BPF extensible scheduler class
Message-ID: <Y5mPigH1bPatXNeB@hirez.programming.kicks-ass.net>
References: <20221130082313.3241517-1-tj@kernel.org>
 <Y5b++AttvjzyTTJV@hirez.programming.kicks-ass.net>
 <CABk29Ntf1ZMAmvkVTzj6=HjanHgn6Qu3-J8gHHyMM30yiHM3_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Ntf1ZMAmvkVTzj6=HjanHgn6Qu3-J8gHHyMM30yiHM3_w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 13, 2022 at 06:11:38PM -0800, Josh Don wrote:

> Improving scheduling performance requires rapid iteration to explore
> new policies and tune parameters, especially as hardware becomes more
> heterogeneous, and applications become more complex. Waiting months
> between evaluating scheduler policy changes is simply not scalable,
> but this is the reality with large fleets that require time for
> testing, qualification, and progressive rollout. The security angle
> should be clear from how involved it was to integrate core scheduling,
> for example.

Surely you can evaluate stuff on a small subset of machines -- I'm
fairly sure I've had google and facebook people tell me they do just
that, roll out the test kernel on tens to hundreds of thousand of
machines instead of the stupid number and see how it behaves there.

Statistics has something here I think, you can get a reliable
representation of stuff without having to sample *everyone*.

I was given to believe this was a fairly rapid process.

Just because you guys have more machines than is reasonable, doesn't
mean we have to put BPF everywhere.

Additionally, we don't merge and ship everybodies random debug patch
either -- you're free to do whatever you need to iterate on your own and
then send the patches that result from this experiment upstream. This is
how development works, no?

