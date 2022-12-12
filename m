Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB1649BCE
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 11:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiLLKO5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 05:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLLKO4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 05:14:56 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949C41FE;
        Mon, 12 Dec 2022 02:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2hHKL+D8xenvvKDhRsDXsAlyRtvLxbR4M+slc846P9k=; b=fxrjLtvF1k3a6iHnHITMHwxWsR
        x1jooI+/+iWKirFdNHvEeitxokOhOtqUZQY3uYXkFg2x4yWDvC5LQeci8fLyZb8cKvjgTIxNk1ap9
        7orogizmyjHnYPCL71cR3LNAmx9ysrYJ+dTKAaLfArxEvYaZ7vl+L/gvH82VnsEJjcRJd40ll8TYx
        qValtaNRNzp5tLiWArhcHABbeBbH00WqjVAUMAs7/BFSY5dHGCr9W9JAHJaErDLzOTkGOc/JaZXJE
        2lCkLgdfHVwm+8WIDY8LFS9FQyzIUXFFOYzepc/P5LyOEw38f4zN3f8ZxZBkVWlvx+6J2+2N7HOM8
        rkL+PerA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4fpB-009kA5-3D; Mon, 12 Dec 2022 10:14:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4BE39300293;
        Mon, 12 Dec 2022 11:14:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FF2A2024870B; Mon, 12 Dec 2022 11:14:16 +0100 (CET)
Date:   Mon, 12 Dec 2022 11:14:16 +0100
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
Message-ID: <Y5b++AttvjzyTTJV@hirez.programming.kicks-ass.net>
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

> Rolling out kernel upgrades is a slow and iterative process. At a large scale
> it can take months to roll a new kernel out to a fleet of servers. While this
> latency is expected and inevitable for normal kernel upgrades, it can become
> highly problematic when kernel changes are required to fix bugs. Livepatch [9]
> is available to quickly roll out critical security fixes to large fleets, but
> the scope of changes that can be applied with livepatching is fairly limited,
> and would likely not be usable for patching scheduling policies. With
> sched_ext, new scheduling policies can be rapidly rolled out to production
> environments.

I don't think we can or should use this argument to push BPF into ever
more places.

