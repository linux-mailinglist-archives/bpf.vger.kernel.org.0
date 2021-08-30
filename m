Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54753FBB6C
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 20:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhH3SJE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 14:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhH3SJE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 14:09:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54610C061575;
        Mon, 30 Aug 2021 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5nJ0B78IwLSywO3jWIuQ9w7tGOOIg6zRwu/EHc5ZzDg=; b=ZDXloUkb1RObwoIpzOvy2bgoSK
        qU/4DqdaQdEXI2Nzt5VcKeHrBKGm56b1iJQl3hvI/o+n2l048zu4fUePr49KF8keRskUeimu2xNGE
        mtPaKc4SwRaeLQ3qWntms3S4HdxUedEtZnyxyuUhUQ91ehStC0+VqIHE0iV2aibbhadebKy/jPWyP
        5vvl+mPiVVZjed6kt016ulJagKSZQpPEHMawvV+aHdnd4efC1iJU1n/rwenuWYSICvOT69XsZ+tnd
        M3cremX8Msu+t8yRrVHbdRSWONDHsbeBZzKA3cOcNxlJiOuNVAylbfSilLvS3K64+tcdmI6fDPG3L
        QzPr5HOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKlgs-000Oe8-0Y; Mon, 30 Aug 2021 18:07:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58EF43001F6;
        Mon, 30 Aug 2021 20:07:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4109C2C7F610C; Mon, 30 Aug 2021 20:07:24 +0200 (CEST)
Date:   Mon, 30 Aug 2021 20:07:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 1/3] perf: enable branch record for software
 events
Message-ID: <YS0eXMd5Y5yV/m1m@hirez.programming.kicks-ass.net>
References: <20210826221306.2280066-1-songliubraving@fb.com>
 <20210826221306.2280066-2-songliubraving@fb.com>
 <20210830102258.GI4353@worktop.programming.kicks-ass.net>
 <719D2DC2-CC5D-4C6A-94F4-DBCADDA291CC@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <719D2DC2-CC5D-4C6A-94F4-DBCADDA291CC@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 30, 2021 at 05:41:46PM +0000, Song Liu wrote:
> DECLARE_STATIC_CALL(perf_snapshot_branch_stack,
>                    int (*)(struct perf_branch_snapshot *));

> Something like 
> 
> typedef int (perf_snapshot_branch_stack_t)(struct perf_branch_snapshot *);
> DECLARE_STATIC_CALL(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
> 
> seems to work fine. 

Oh urg, indeed. It wants a function type, not a function pointer type.
I've been bitten by that before. Go with the typedef, that's the sanest.
