Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C810649D5D
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 12:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiLLLRo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 06:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiLLLRG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 06:17:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964DF65CB;
        Mon, 12 Dec 2022 03:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0x/J6MjwpVWZFw3GS/riOJMOsvUk2gQMR6aRy5Y8xT4=; b=ostUdyHkSJwpf2go2dxt0W+KN0
        ZXXmVQIzBIttv8RI0L/gTnlOR1klqUa+HTTy34Vt12BmEoEzCiqf4z0WSSMzpXn0N5N/HI70shtV8
        ug6KD8/0vdZWxyyOr92tML/EY0OiNcpb5g1HudUmO1Aj4kvqtiZmvWElEsnK1WECVJJT9SwqM076n
        OdXIKF4E6YwmOHNTQ/8mHte1INv+eIFFY6GrNidps/yXmtzK0HHRhpBNeKEKwjmop1YI2LoVRpdJZ
        UwSso2G/qCnHm3g1SqUmR8edbdTFpd8wiSbDN65+mNarL9+dsgy2DjjSBVyGATm8nUuCgguNvWe51
        Q11rvR4w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4gkg-00AyD7-5d; Mon, 12 Dec 2022 11:13:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACE81300137;
        Mon, 12 Dec 2022 12:13:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 95B8C209FB782; Mon, 12 Dec 2022 12:13:31 +0100 (CET)
Date:   Mon, 12 Dec 2022 12:13:31 +0100
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
Subject: Re: [PATCH 04/31] sched: Allow sched_cgroup_fork() to fail and
 introduce sched_cancel_fork()
Message-ID: <Y5cM24M4007WcPod@hirez.programming.kicks-ass.net>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-5-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130082313.3241517-5-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 10:22:46PM -1000, Tejun Heo wrote:
> A new sched_clas needs a bit more control over forking. This patch makes the
                 ^
                 (insufficient s's)

> following changes:
> 
> * Add sched_cancel_fork() which is called if fork fails after sched_fork()
>   succeeds so that the preparation can be undone.
> 
> * Allow sched_cgroup_fork() to fail.
> 
> Neither is used yet and this patch shouldn't cause any behavior changes.

Fails to explain why this would be needed and why that would be a good
thing. IOW, total lack of justification.
