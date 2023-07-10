Return-Path: <bpf+bounces-4596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455A174D4DF
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 14:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002932811FD
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5FA1097A;
	Mon, 10 Jul 2023 12:01:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBC711182
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 12:01:00 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C4AD1;
	Mon, 10 Jul 2023 05:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7a3aObqALZ0RGVJNPU87pW+rmJD5s/3iTVbIQ9L7MVY=; b=jK+jMf+l74JDzsvgKRmBF4nw95
	wxZTqNU1gg/WKprlF0LO8D2en3yOA61Kshjq/DxDa+/kqZ8nFhKca0gXFfKQ9qfbo3n54C4MiC+T8
	T+QNDSKZM+ucpPDLOZKvE4Wlu59PAFYBtGhMoaFzuK+hRQAa5dP8UxK+rVrEbFgt+4iAYDthzC1bs
	SogNMxPbjzWK3WpN02v+NQIvlaG+N8WLW6/HjEjuC2psnZ7/fUnr6xR8ijWA9XaGX2czu7u6g2WAD
	Uzc/C+ixvg5d7maGag0HUi3Zjetl5ab3nfcGsNdvPTGTr7597PFKqsPoIfJuekshDJoV42NZSZz7Z
	2pLsxtPg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qIpZ6-00EZpt-FH; Mon, 10 Jul 2023 12:00:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87F0630017D;
	Mon, 10 Jul 2023 14:00:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6B79B2B3B25E1; Mon, 10 Jul 2023 14:00:26 +0200 (CEST)
Date: Mon, 10 Jul 2023 14:00:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: alexander.shishkin@linux.intel.com, james.clark@arm.com,
	leo.yan@linaro.org, mingo@redhat.com, baolin.wang@linux.alibaba.com,
	acme@kernel.org, mark.rutland@arm.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [Patch v2] perf/core: Bail out early if the request AUX area is
 out of bound
Message-ID: <20230710120026.GA3034907@hirez.programming.kicks-ass.net>
References: <20230613123211.58393-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613123211.58393-1-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 13, 2023 at 08:32:11PM +0800, Shuai Xue wrote:

>  kernel/events/ring_buffer.c              | 13 +++++++++++++
>  tools/perf/Documentation/perf-record.txt |  3 ++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index a0433f37b024..e514aaba9d42 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -673,6 +673,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>  	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
>  	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
>  	int ret = -ENOMEM, max_order;
> +	size_t bytes;
>  
>  	if (!has_aux(event))
>  		return -EOPNOTSUPP;
> @@ -699,6 +700,18 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>  		watermark = 0;
>  	}
>  
> +	/*
> +	 * 'rb->aux_pages' allocated by kcalloc() is a pointer array which is
> +	 * used to maintains AUX trace pages. The allocated page for this array
> +	 * is physically contiguous (and virtually contiguous) with an order of
> +	 * 0..MAX_ORDER. If the size of pointer array crosses the limitation set
> +	 * by MAX_ORDER, it reveals a WARNING.
> +	 *
> +	 * So bail out early if the request AUX area is out of bound.
> +	 */
> +	if (check_mul_overflow(nr_pages, sizeof(void *), &bytes) ||
> +	    get_order(bytes) > MAX_ORDER)
> +		return -EINVAL;

This is all quite horrific :/ What's wrong with something simple:

	/* Can't allocate more than MAX_ORDER  */
	if (get_order((unsigned long)nr_pages * sizeof(void*)) > MAX_ORDER)
		return -EINVAL;

If you're on 32bit then nr_pages should never be big enough to overflow,
fundamentally you'll only have 32-PAGE_SHIFT bits in nr_pages.


>  	rb->aux_pages = kcalloc_node(nr_pages, sizeof(void *), GFP_KERNEL,
>  				     node);



