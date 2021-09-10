Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5CB407179
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 20:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhIJSvY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 14:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhIJSvY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 14:51:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F87CC061574;
        Fri, 10 Sep 2021 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TJqZkDiudSfpKSVBnK+BZjQrmCRticHK6VbyrN5mug4=; b=J/x7SAyrhZDzIvdq5E7GI4wR1G
        yVVoFbVD71804A0/pq+ptAWRQeh4L/lMOECfVtiWfnm31FEYJN8cSnFb0Q8Uj0Q617GdCglHSGo3/
        1UC90e2cp0qKN9LVDAANxeyQQXvADmEkXPwOtC1jEoiKIvPICqE4gibwZuW3l5FM+PsvSCqgwc/qt
        N7PkBVh59zinlrIMKOCY5pSPK3I4T6AwF/IAQVozrEu5nQvxd05elLueors6DrFeULuEsC/2b35gH
        Ev1UwBceNAJyPYq6/oUTRJIPffCGBzLfI4QHGpOj0iRvsuZ4HsRymjgovRKzuavJb0HE5XlGvc4K8
        poI3zVAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOlb9-002C0h-Rx; Fri, 10 Sep 2021 18:50:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 71BE198627A; Fri, 10 Sep 2021 20:50:03 +0200 (CEST)
Date:   Fri, 10 Sep 2021 20:50:03 +0200
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
Message-ID: <20210910185003.GC5106@worktop.programming.kicks-ass.net>
References: <20210907202802.3675104-1-songliubraving@fb.com>
 <20210907202802.3675104-2-songliubraving@fb.com>
 <YTs2MpaI7iofckJI@hirez.programming.kicks-ass.net>
 <YTtjeyfJXXiDielu@hirez.programming.kicks-ass.net>
 <96445733-055E-41E3-986B-5E1DC04ADEFA@fb.com>
 <20210910184027.GQ4323@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910184027.GQ4323@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 10, 2021 at 08:40:27PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 10, 2021 at 06:27:36PM +0000, Song Liu wrote:
> 
> > This works great and saves 3 entries! We have the following now:
> 
> Yay!
> 
> > ID: 0 from bpf_get_branch_snapshot+18 to intel_pmu_snapshot_branch_stack+0
> 
> is unavoidable, we need to end up in intel_pmu_snapshot_branch_stack()
> eventually.
> 
> > ID: 1 from __brk_limit+477143934 to bpf_get_branch_snapshot+0
> 
> could be elided by having the JIT emit the call to
> intel_pmu_snapshot_branch_stack directly, instead of laundering it
> through that helper I suppose.
> 
> > ID: 2 from __brk_limit+477192263 to __brk_limit+477143880  # trampoline 
> > ID: 3 from __bpf_prog_enter+34 to __brk_limit+477192251
> 
> -ENOCLUE
> 
> > ID: 4 from migrate_disable+60 to __bpf_prog_enter+9
> > ID: 5 from __bpf_prog_enter+4 to migrate_disable+0
> 
> I suppose we can reduce that to a single branch if we inline
> migrate_disable() here, that thing unfortunately needs one branch
> itself.

Oooh, since we put local_irq_save/restore() in
intel_pmu_snapshot_branch_stack(), we no longer need to be after
migrate_disable(). You could go back to placing it earlier!
