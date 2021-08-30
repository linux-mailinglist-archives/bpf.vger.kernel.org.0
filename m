Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885903FB3CF
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 12:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbhH3K0m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 06:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhH3K0m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 06:26:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55D5C061575;
        Mon, 30 Aug 2021 03:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zz+aqp/XGpyd1iC8O795/y6Kat+qjTYy7lakfmWUgDQ=; b=AqoqXvyigMzdVGJdyx45l9Ng5s
        wGnZ3ftBYoxY5tOx/XRIKWlise1TkjDTRw1hLkf9GTI4HhfcFJJm1I4yLEFUsSoJQKOaq0YUsN7XZ
        XNUJyKicmvWfD8ccUOgdOdLS7ETXB0vlYRONHdPtyKgzinQopSYWte4HVlQKOC1HVHZoJraz2SMQy
        LTXOci1EwWtUnnk6A+2gyhJNnrB8WZn3rdE0V6E67wF38kF2S+bOoYAPytepp6J4C2zH8FdSxIL3W
        wUr4j5uLbY274DGIqXx8MofhZrVxBrfJ+mgz37IEhaMuBI6J4mYxP087P76HlNgp6M7SBmv0CCOJx
        d5E/eLGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKeRQ-0000wj-69; Mon, 30 Aug 2021 10:23:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AC25981BFF; Mon, 30 Aug 2021 12:22:58 +0200 (CEST)
Date:   Mon, 30 Aug 2021 12:22:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, kjain@linux.ibm.com, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 1/3] perf: enable branch record for software
 events
Message-ID: <20210830102258.GI4353@worktop.programming.kicks-ass.net>
References: <20210826221306.2280066-1-songliubraving@fb.com>
 <20210826221306.2280066-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826221306.2280066-2-songliubraving@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 26, 2021 at 03:13:04PM -0700, Song Liu wrote:
> +int dummy_perf_snapshot_branch_stack(struct perf_branch_snapshot *br_snapshot);
> +
> +DECLARE_STATIC_CALL(perf_snapshot_branch_stack, dummy_perf_snapshot_branch_stack);
> +
>  #endif /* _LINUX_PERF_EVENT_H */
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 011cc5069b7ba..c53fe90e630ac 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13437,3 +13437,6 @@ struct cgroup_subsys perf_event_cgrp_subsys = {
>  	.threaded	= true,
>  };
>  #endif /* CONFIG_CGROUP_PERF */
> +
> +DEFINE_STATIC_CALL_NULL(perf_snapshot_branch_stack,
> +			dummy_perf_snapshot_branch_stack);

This isn't right...

The whole dummy_perf_snapshot_branch_stack() thing is a declaration only
and used as a typedef. Also, DEFINE_STATIC_CALL_NULL() and
static_call_cond() rely on a void return value, which it doesn't have.

Did you want:

  DECLARE_STATIC_CALL(perf_snapshot_branch_stack, void (*)(struct perf_branch_snapshot *));

  DEFINE_STATIC_CALL_NULL(perf_snapshot_branch_stack, void (*)(struct perf_branch_snapshot *));

  static_call_cond(perf_snapshot_branch_stack)(...);

*OR*, do you actually need that return value, in which case you're
probably looking for:

  DECLARE_STATIC_CALL(perf_snapshot_branch_stack, int (*)(struct perf_branch_snapshot *));

  DEFINE_STATIC_CALL_RET0(perf_snapshot_branch_stack, int (*)(struct perf_branch_snapshot *));

  ret = static_call(perf_snapshot_branch_stack)(...);

?
