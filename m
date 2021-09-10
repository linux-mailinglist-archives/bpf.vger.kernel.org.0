Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BA6407107
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 20:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhIJSlt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 14:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIJSlt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 14:41:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0B4C061574;
        Fri, 10 Sep 2021 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h4jPQ7Zdr5Ida+XAg8yR3XSpVV86/qySljCfBrpPhJQ=; b=i3xiCww++hTiz5JqZRPOVQX7Gi
        C6sQr8nV7lGvueiQy8NPgpQmXWZgFO5db9flVZvPYgtYrFXt3g54fBQ7s90XeOwKj6saipHh0Cy3A
        aZbMkCl0m/RjThlWDMCEz0SnFQSiZVHf4M1ypAQy3zwMDoACDlciEJxcv89b+RHwhSCo/l4p9WiRr
        5s7tl/PbMXr2cz3VHJJSqQWBJU2o/YsvDHuk2oaCo8bXJKSJeaXLZe6lP781wRNKKTB4WRYHp551s
        xCUSDR+4FRNC9zpsRyxSpCgW/nW2J1959tYQkSJ5ypDlLig5S5D1h6WhXNE4h8fNapoSG3g1WmFct
        XkILBtJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOlRs-002BtX-EB; Fri, 10 Sep 2021 18:40:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4ED5B98627A; Fri, 10 Sep 2021 20:40:27 +0200 (CEST)
Date:   Fri, 10 Sep 2021 20:40:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v6 bpf-next 1/3] perf: enable branch record for software
 events
Message-ID: <20210910184027.GQ4323@worktop.programming.kicks-ass.net>
References: <20210907202802.3675104-1-songliubraving@fb.com>
 <20210907202802.3675104-2-songliubraving@fb.com>
 <YTs2MpaI7iofckJI@hirez.programming.kicks-ass.net>
 <YTtjeyfJXXiDielu@hirez.programming.kicks-ass.net>
 <96445733-055E-41E3-986B-5E1DC04ADEFA@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96445733-055E-41E3-986B-5E1DC04ADEFA@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 10, 2021 at 06:27:36PM +0000, Song Liu wrote:

> This works great and saves 3 entries! We have the following now:

Yay!

> ID: 0 from bpf_get_branch_snapshot+18 to intel_pmu_snapshot_branch_stack+0

is unavoidable, we need to end up in intel_pmu_snapshot_branch_stack()
eventually.

> ID: 1 from __brk_limit+477143934 to bpf_get_branch_snapshot+0

could be elided by having the JIT emit the call to
intel_pmu_snapshot_branch_stack directly, instead of laundering it
through that helper I suppose.

> ID: 2 from __brk_limit+477192263 to __brk_limit+477143880  # trampoline 
> ID: 3 from __bpf_prog_enter+34 to __brk_limit+477192251

-ENOCLUE

> ID: 4 from migrate_disable+60 to __bpf_prog_enter+9
> ID: 5 from __bpf_prog_enter+4 to migrate_disable+0

I suppose we can reduce that to a single branch if we inline
migrate_disable() here, that thing unfortunately needs one branch
itself.

> ID: 6 from bpf_testmod_loop_test+20 to __bpf_prog_enter+0

And this is the first branch out of the test program, giving 7 entries
now, of which we can remove at least 2 more with a bit of elbow greace,
right?

> ID: 7 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
> ID: 8 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
> 
> I will fold this in and send v7. 

Excellent.
