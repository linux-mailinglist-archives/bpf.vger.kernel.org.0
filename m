Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC5664B3DA
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 12:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbiLMLLV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 06:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbiLMLKa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 06:10:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55142AE45;
        Tue, 13 Dec 2022 03:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+nRf/6V6wXsRw4fo3uuanPnY17TIgFQIAFrRDe+Tsy0=; b=UCFo+1waL8A3D+bUWjAD0OTxvs
        kKvdiOplI6Qsuga3/0/V9jlGiqqk062VFJJ9jzstVBML5kh7q63Ngvb4aEfkABooxLviTdSoml0S9
        9KdCu69mDfHMpRyjoMiuXv4yiiXYdCdRAHd43e6YcnfMu0KNQbOjO3Z0nDU1hdMGEzvzLCK1AXDGc
        u71v5UHhxUAqSNQRjDJpB5997o0e8SxsTYpON+84bNjpqieH5/NMcrE9xgYpz9lLYW6ViYuGK7ZR6
        6HgZV9NsxyhBziXdLBKmRROiYyMXDmB7T4YxM+s7ztwOELSslilLpmU4wxdil3UTcoq6qBtS0Xue3
        V+qGpHcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p53Aq-00C9Ic-SI; Tue, 13 Dec 2022 11:10:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D8E330015E;
        Tue, 13 Dec 2022 12:02:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1247E201FEA66; Tue, 13 Dec 2022 12:02:44 +0100 (CET)
Date:   Tue, 13 Dec 2022 12:02:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        brho@google.com, bristot@redhat.com, bsegall@google.com,
        daniel@iogearbox.net, derkling@google.com,
        dietmar.eggemann@arm.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, dvernet@meta.com, haoluo@google.com,
        joshdon@google.com, juri.lelli@redhat.com, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, martin.lau@kernel.org,
        mgorman@suse.de, mingo@redhat.com, pjt@google.com,
        riel@surriel.com, rostedt@goodmis.org, tj@kernel.org,
        torvalds@linux-foundation.org, vincent.guittot@linaro.org,
        vschneid@redhat.com, posk@posk.io
Subject: Re: [PATCH 31/31] sched_ext: Add a rust userspace hybrid example
 scheduler
Message-ID: <Y5hb05fll8jXc0Ck@hirez.programming.kicks-ass.net>
References: <Y5c0qEuyn8cAvLGQ@hirez.programming.kicks-ass.net>
 <20221212210547.1105894-1-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212210547.1105894-1-posk@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 01:05:47PM -0800, Peter Oskolkov wrote:
> Peter Zijlstra wrote:
> 
> > I long for the UMCG patches -- that
> > at least was somewhat sane and trivially composes, unlike all this
> > madness.
> 
> A surprise, to be sure, but a welcome one!

Well, I did somewhat like it as I put significant effort into it. In
fact I was >.< near to merging the lot when you changed your mind and
went the syscall route.

At that point something happened (I fell ill or a holiday or something)
but it basically got snowed under as I had already been ignoring the
inbox while doing the UMCG thing and I just never managed to get back to
it (like a 1000 other things :/ -- this maintainer thing really is like
drinking from a firehose).

