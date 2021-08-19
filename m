Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846E63F1FE0
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 20:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhHSS2G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 14:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhHSS2E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Aug 2021 14:28:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7A2C061575;
        Thu, 19 Aug 2021 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+bTbGbKR1TC3lLaeYOl/sYgM2QGbnXnwBH0Mh0F17/8=; b=dwnz0X/tx54x1HktT+4On+TT9z
        latNRYxu0+rNhJfDYrdmGkBAEoK1AnNpwjGsZ1DeRptGGLHrrpEcyaS1ktmEWDQcmX/L2leHgCqX4
        bbH9hgbcBUt25KNkD3idyXf5xo4ZECBZRG5jhA++GLITSSgR9K18BwvyVDRiY+vQ77Ygv+7UKPiJW
        s/1Yljo76fi0RXFMl1mw8ImBKRQrMqcgzFIaUQGChBdO7Qlwj3WMC52bnbVLzgmDMW16pXXH2PKqS
        b5jUIyHThWO14FWV3SUQcjYmwYF/DgAcjb02UeZQyeWJZPSc1KbWur0bvdiP6vyr6/Pc5+wJF9BPb
        R7wd1eHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGml6-00BAqC-1B; Thu, 19 Aug 2021 18:27:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 675863012AD;
        Thu, 19 Aug 2021 20:27:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D012202317D2; Thu, 19 Aug 2021 20:27:19 +0200 (CEST)
Date:   Thu, 19 Aug 2021 20:27:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Like Xu <like.xu@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC] bpf: lbr: enable reading LBR from tracing bpf programs
Message-ID: <YR6ih+pKSm5TVVBc@hirez.programming.kicks-ass.net>
References: <20210818012937.2522409-1-songliubraving@fb.com>
 <YRzPwClswwxHXVHe@hirez.programming.kicks-ass.net>
 <962EDD5A-1B35-4C7F-A0A1-3EBC32EE63AB@fb.com>
 <YR5HJkPyaM3TWkkl@hirez.programming.kicks-ass.net>
 <AB509D87-67C6-4B7F-AEFB-2324845C310C@fb.com>
 <YR6dreGQSe4oQFBr@hirez.programming.kicks-ass.net>
 <A5F7CF90-27F9-476C-B87C-CAD2A6BE5DA4@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A5F7CF90-27F9-476C-B87C-CAD2A6BE5DA4@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 19, 2021 at 06:22:07PM +0000, Song Liu wrote:

> > And if we're going to be adding new pmu::methods then I figure one that
> > does the whole sample state might be more useful.
> 
> What do you mean by "whole sample state"? To integrate with exiting
> perf_sample_data, like perf_output_sample()?

Yeah, the PMI can/does set more than data->br_stack, but I'm now
thinking that without an actual PMI, much of that will not be possible.
br_stack is special here.

Oh well, carry on I suppose.
