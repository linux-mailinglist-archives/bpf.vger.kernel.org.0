Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7263FFBF5
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 10:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348279AbhICIaY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Sep 2021 04:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348150AbhICIaX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Sep 2021 04:30:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD9BC061575;
        Fri,  3 Sep 2021 01:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=63YjCZz8yI4FKXK+jv7rwHSVADBtiqi5HQcrAte2wY0=; b=ozlT/4knnZ1PqKs/7MNRFQJImq
        fW+jGTYcx5EzCZpxPjfnL/+TDVNNcAGfYnHChmTZZkLV1iWRNy4eFOzktJ55sJc9rtZ7QPNtp1wdx
        0o9yimgl5mP/ynzBxvQY2k23KNN8yLyUnxT+pYxUx87Q6W2klvDsw53pJTl6gU+g0WhQ3jHFoN2pc
        TTNR+UQO7Kq+ZvPxKm608ugUqpDUt7VKxDeGESG99pbyULGIjimb8xyGM9B17dQN2KVM0r60e//pL
        acklVuByNpC/Gfy0QuxSbMjRtUZueKyF3KEeDaxhj+9pjc9bvzCbt6F+nj7C7F9/zIlPPCJdToson
        dveUY/bg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mM4XV-004HcU-Bx; Fri, 03 Sep 2021 08:27:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E42B130018E;
        Fri,  3 Sep 2021 10:27:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDBFC209D9D99; Fri,  3 Sep 2021 10:27:08 +0200 (CEST)
Date:   Fri, 3 Sep 2021 10:27:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, kjain@linux.ibm.com, kernel-team@fb.com
Subject: Re: [PATCH v5 bpf-next 1/3] perf: enable branch record for software
 events
Message-ID: <YTHcXDhYDFsw9GQX@hirez.programming.kicks-ass.net>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902165706.2812867-2-songliubraving@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 02, 2021 at 09:57:04AM -0700, Song Liu wrote:

> +static int
> +intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +
> +	intel_pmu_disable_all();
> +	intel_pmu_lbr_read();
> +	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
> +
> +	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
> +	intel_pmu_enable_all(0);
> +	return cnt;
> +}

Given this disables the PMI from 'random' contexts, should we not add
IRQ disabling around this to avoid really bad behaviour?


