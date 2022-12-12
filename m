Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EBB649D8E
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 12:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiLLL2w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 06:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiLLL2v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 06:28:51 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F6231E;
        Mon, 12 Dec 2022 03:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aPCq5QjQ7nVUQw50mTEY6sEu3k3UNBF5jPLWNgYPtCo=; b=VCOxZarE3hZ5ss5LXGp/ijHe1b
        /ntM61IKrd0dlYLrD3IGZ8OXhAtkYj9dZMNWZhAArywAgtrbb2KpCN3Wqp3zhzS8+vbsKEb+D2RpC
        O/vg1NBlFWQfmUl5jy8/NrHgbbhlk8spZ+B5heH5Q6kXhkxgzgLJk9YeggwhcL3FwZcbbU1vH5O0v
        IifRdNjkPZ2YlcFdtmchRz6Igd6pRCJd35BWocTIvogTMTpXf89l58aAdC4ddEzc1+Z1czngaoKvA
        Oq6mL24LGP1rrvwrssX4LE+yGVY2Bzmdg3dbhFPzKCduh0AN/aWTRnFyY0l/WHDDv0wNLA4AaLEbv
        PAn6ZPIQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4gz0-009lF1-F9; Mon, 12 Dec 2022 11:28:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6354300293;
        Mon, 12 Dec 2022 12:28:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C910E20B2B4EA; Mon, 12 Dec 2022 12:28:29 +0100 (CET)
Date:   Mon, 12 Dec 2022 12:28:29 +0100
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
Subject: Re: [PATCH 06/31] sched: Add sched_class->switching_to() and expose
 check_class_changing/changed()
Message-ID: <Y5cQXTDhfvk2LIWU@hirez.programming.kicks-ass.net>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-7-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130082313.3241517-7-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 10:22:48PM -1000, Tejun Heo wrote:
> When a task switches to a new sched_class, the prev and new classes are
> notified through ->switched_from() and ->switched_to(), respectively, after
> the switching is done. However, a new sched_class needs to prepare the task
> state before it is enqueued on the new class for the first time.

How and why isn't sched_fork() sufficient?
