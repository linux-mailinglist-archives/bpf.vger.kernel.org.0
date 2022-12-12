Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4698D649B54
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 10:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiLLJid (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 04:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiLLJi1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 04:38:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D187A293;
        Mon, 12 Dec 2022 01:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MZjvdGsr7OQyc+WN8WWS9d9aoiScOd7BDAvol982NI4=; b=SkUFdD4cXgZJin1CbKwdnZF3+v
        PBy4SMek1/mx0YdhUrmZOuxhrW66sJsha6VNlvlYR6lP750n4SDvcUpjma6D/jzV6ml00fLJpAkqE
        +d6vWonMKNYt8wY8LEqU0CjedKmWBgep0wJlQzoMJSpgAjXWWOYk9PxJjccEDr1kmnYzxSdXxeIpq
        w+WKKemqKSewFB7/mRMKSquRCK5cxfif/0+sFEI7hPZXxAme5xNciZY1/iPoCNF3dZhL7w3LuD3Ok
        cMXuqgNsh6nNXzdnoTKfDWf/04vlzQVTy4fRKcMk7dxtwB6Bow3/ZQIR6mU3lcCgjiXH2F60XL/by
        oBkUUzXQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4fG7-00Atcl-P7; Mon, 12 Dec 2022 09:38:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D762300137;
        Mon, 12 Dec 2022 10:37:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D6C620AF3509; Mon, 12 Dec 2022 10:37:51 +0100 (CET)
Date:   Mon, 12 Dec 2022 10:37:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
        riel@surriel.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCHSET RFC] sched: Implement BPF extensible scheduler class
Message-ID: <Y5b2btWFJeEfTyJg@hirez.programming.kicks-ass.net>
References: <20221130082313.3241517-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130082313.3241517-1-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 10:22:42PM -1000, Tejun Heo wrote:

> Core scheduling is an example of a feature that took a significant amount of
> time and effort to integrate into the kernel.

Mostly because I dropped it on the floor once I heard about MDS. That
made me lose interest entirely. The only reason it eventually happened
was ChromeOS (Joel) pushing for it again.

> Part of the difficulty with core
> scheduling was the inherent mismatch in abstraction between the desire to
> perform core-wide scheduling, and the per-cpu design of the kernel scheduler.

Not really; the main difficultly was due to me wanting to do it outside
of the scheduling classes so that it fundamentally covers all of them.

Doing it inside a class (say CFS) would've made it significantly simpler.

> This caused issues, for example ensuring proper fairness between the
> independent runqueues of SMT siblings.

Inter-runqueue fairness is a known issue of CFS and quite independent of
core scheduling.


Anyway, I hate all of this. Linus NAK'ed loadable schedulers a number of
times in the past and this is just that again -- with the extra downside
of the whole BPF thing on top  :/

You look to be exposing a ton of stuff I've so far even refused
tracepoints for :-(

Anyway, I'm just back from a heavy dose of Covid and still taking it
easy, but I'll go read through the whole thing, hopefully I'll finish
before vanishing again for the x-mas break.
