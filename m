Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6015649E28
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 12:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiLLLuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 06:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLLLuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 06:50:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB28865FE;
        Mon, 12 Dec 2022 03:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mupZhswKfkylzMFVJeC8AXLjnLXa3nZsQoZVhef6zkY=; b=PPBMj/R/Aga9LLznUlxeGoEclT
        Z0wjBIuaDNJnVaF1hH+hlGDg0Gh1VencdkwL9TB9yHWEL27RaxjrrGR5ZWri3pKmFeVaha2jmwK+p
        Hlyms/Qe8xP/nmDMYjqexsnmW//NdNl3R/z+VmF2YSBLJXbKLWaPw/2G1t1WVFVtYCt7LoaT6axZN
        FIWSEgycLz/Mpx0ENO65dUrWyKQnCeMji8bzZsOHhLiAa4Cqy+6H3X8bNjj3IyxgxYSh8LgSld0DQ
        G3zVY9TgPyKuX6qSdkBV4igIeVrBHx3EWTsDJX4cgLVcQ4C4GnMo1azGk14N81exT9x62U0q1i90H
        t6xgBj/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4hJx-00B00K-If; Mon, 12 Dec 2022 11:50:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B03E5300137;
        Mon, 12 Dec 2022 12:49:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A98A2024871C; Mon, 12 Dec 2022 12:49:59 +0100 (CET)
Date:   Mon, 12 Dec 2022 12:49:59 +0100
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
Subject: Re: [PATCH 08/31] sched: Expose css_tg() and __setscheduler_prio()
 in kernel/sched/sched.h
Message-ID: <Y5cVZzcfqQ7nAm4p@hirez.programming.kicks-ass.net>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-9-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130082313.3241517-9-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 10:22:50PM -1000, Tejun Heo wrote:
> These will be used by a new sched_class.

Uhhh.. wtf does a policy need __setscheduler_prio() for?
