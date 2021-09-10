Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C52B40718E
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 20:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhIJTAg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 15:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIJTAg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 15:00:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3D3C061574;
        Fri, 10 Sep 2021 11:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9YGobc0SWIJL+l3HkzowCvjbKEJxnEkUTVIXD+Ukz10=; b=AEI+C3YKBw44VQ2KDAzFRRJz+r
        f63c/meakil2zhmGoVOnmu9l5JnOW7Mt8v7lnrSzgw4X/VVbdQDr/L6avxJwaqzmX9UYeTZPmQDQ3
        MXoBXWZAMwT9hYx3aOdxyhVK+Bvu/Q5YofVCDHuWyZ3H4xFTZ2o+TQ/RpRnM8LdexOkmGmQyjk7Gn
        R4dSweNtfJ2b2K75zigVOYTOmJrkYaRR/UiR5gcc4BMZQuImuhKc5fmt6pD9U7p1fvoeYSvgaZ6RY
        b9aR9R/BXCF4vyjjGOUpL+NtQetwlvB3FL0avJNKmw+bUPQm/lLtqxynewjgLWcpQDezei7nqFXlb
        oeygdYXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOljQ-00BH8Q-Py; Fri, 10 Sep 2021 18:58:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 00CF498627A; Fri, 10 Sep 2021 20:58:35 +0200 (CEST)
Date:   Fri, 10 Sep 2021 20:58:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, kjain@linux.ibm.com, kernel-team@fb.com,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH v7 bpf-next 3/3] selftests/bpf: add test for
 bpf_get_branch_snapshot
Message-ID: <20210910185835.GR4323@worktop.programming.kicks-ass.net>
References: <20210910183352.3151445-1-songliubraving@fb.com>
 <20210910183352.3151445-4-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910183352.3151445-4-songliubraving@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 10, 2021 at 11:33:52AM -0700, Song Liu wrote:
> +	/* Given we stop LBR in software, we will waste a few entries.
> +	 * But we should try to waste as few as possible entries. We are at
> +	 * about 7 on x86_64 systems.
> +	 * Add a check for < 10 so that we get heads-up when something
> +	 * changes and wastes too many entries.
> +	 */
> +	ASSERT_LT(skel->bss->wasted_entries, 10, "check_wasted_entries");

It might be worth pointing out that you can easily bust this limit by
enabling all the various tracepoints that are still in that code, but
that that isn't a hard error since that's not the expected use case.

For example there's the wrmsr tracepoint that will inject 6 or so
branches on top of that you now have. And I also think there's a
tracepoint in local_irq_save() that can trigger.
