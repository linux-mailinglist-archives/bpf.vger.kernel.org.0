Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EE8400AD1
	for <lists+bpf@lfdr.de>; Sat,  4 Sep 2021 13:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbhIDK0G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Sep 2021 06:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhIDK0E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Sep 2021 06:26:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74D3C061575;
        Sat,  4 Sep 2021 03:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QEFGMQJ2WP0sty7LjvnD/gj9uF39L/OqqqlqNHn7lWk=; b=j2a16Kyax11/plC2V3jBaxM2nm
        Zzv5MQ8EhlEb2KSlVkgxmYL4d/IdfsbU48e9tAmShVAVk7rZnALBCMyKXMh8jyKHxxx/Cx/8ybAX/
        TOyu3rOSVpmQ9xU8iovVapUWVGMJRycE2GHbN3yk7G5rieA5fKeIxiihFTnBrceu1TKzk+Lv87Z5a
        oSFQeNi4Jw9A4IesKvI5nzg79tGYaQtsB3GZEfh7hkNBE+mDuaSmqTmr0ArC44j7abf78FkTEv1i6
        WvQWkVoTEKJs4E4XcA/uqn4Y3uVB/i/f5ExzcLT+Jgs1sysgklw8gWf3c56l23PEmuidBiX4yePwH
        Eprrbkfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMSqc-005EXM-G6; Sat, 04 Sep 2021 10:24:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F842986283; Sat,  4 Sep 2021 12:24:30 +0200 (CEST)
Date:   Sat, 4 Sep 2021 12:24:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Message-ID: <20210904102430.GD4323@worktop.programming.kicks-ass.net>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-3-songliubraving@fb.com>
 <YTHhOy1gqr44C1bI@hirez.programming.kicks-ass.net>
 <CAEf4BzZ0eq1iFh1oVwTZ7+bQkb=pJShgDWzUSAp41sk30iQunQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ0eq1iFh1oVwTZ7+bQkb=pJShgDWzUSAp41sk30iQunQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 03, 2021 at 10:10:16AM -0700, Andrii Nakryiko wrote:
> > I suppose you have to have this helper function because the JIT cannot
> > emit static_call()... although in this case one could cheat and simply
> > emit a call to static_call_query() and not bother with dynamic updates
> > (because there aren't any).
> 
> If that's safe, let's do it.

I'll try and remember to look into static_call_lock(), a means of
forever denying future static_call_update() calls. That should make this
more obvious.
