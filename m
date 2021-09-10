Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1CB4071B6
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 21:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhIJTJc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 15:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhIJTJb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 15:09:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E9CC061574;
        Fri, 10 Sep 2021 12:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RvbOKws0vugnzCKuDTONgPld9Ii4J9dkZzNenEfUNqQ=; b=lEb37XTIAAKxxFQZd/qjhReziA
        qvG9vN/kWb8vRH00OnuyV2Huaon4u9hYkWgGGy0ivwB01bHyInZP6t+UqQaoinoLYOGNaZAWIVAqe
        aGFAc1U1uoTjdoEa8EdYIpyQBT/GmAYf6ZhJtaiMtz7J6MEetoaWfjnioacDmDeKFBn36RI9LrHvK
        jfxGG1Uv1FZmZEgttfgIVznKLk+vd85IowrSXWo50Xr6NrH1SsoS654YnKwg1CH2j87Z07GdS+pr9
        snKUB7Iq6yM9yyJg0emhYGSvFjOr/63hJD6xot+O/YeMTkIhtk4tGzLGqX7KBSV2CJOm/6Ql26IN7
        rq0d3vqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOlsb-002CBg-DA; Fri, 10 Sep 2021 19:08:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E00B198627A; Fri, 10 Sep 2021 21:08:04 +0200 (CEST)
Date:   Fri, 10 Sep 2021 21:08:04 +0200
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
Message-ID: <20210910190804.GS4323@worktop.programming.kicks-ass.net>
References: <20210907202802.3675104-1-songliubraving@fb.com>
 <20210907202802.3675104-2-songliubraving@fb.com>
 <YTs2MpaI7iofckJI@hirez.programming.kicks-ass.net>
 <YTtjeyfJXXiDielu@hirez.programming.kicks-ass.net>
 <96445733-055E-41E3-986B-5E1DC04ADEFA@fb.com>
 <20210910184027.GQ4323@worktop.programming.kicks-ass.net>
 <20210910185003.GC5106@worktop.programming.kicks-ass.net>
 <6830FC62-995A-4282-BD30-76E2506ED993@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6830FC62-995A-4282-BD30-76E2506ED993@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 10, 2021 at 07:00:08PM +0000, Song Liu wrote:

> Hmm.. not really. We call migrate_disable() before entering the BPF program. 
> And the helper calls snapshot_branch_stack() inside the BPF program. To move
> it to before migrate_disable(), we will have to add a "whether to snapshot
> branch stack" check before entering the BPF program. This check, while is
> cheap, is added to all BPF programs on this hook, even when the program does 
> not use snapshot at all. So we would rather keep all logic inside the helper, 
> and not touch the common path. 

Moo :/ Because I also really don't want to expose struct rq, it's
currently nicely squirelled away in kernel/sched/ and doesn't get
anywhere near include/.

A well, maybe we can do something clever with migrate_disable() itself.
I'll put it on this endless todo list ;-)
