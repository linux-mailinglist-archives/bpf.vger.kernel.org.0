Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918D3662537
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 13:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjAIMO6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 07:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237193AbjAIMOm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 07:14:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC311A81C;
        Mon,  9 Jan 2023 04:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v24BERDCC4RQqnJo6tY3NjXwHdQxUjz76w0sCn1hN0s=; b=RVU2AE8iKiuhsgAoyx5dG/mc0d
        90++PABn9zvVMjRpnqPOqCldq4sKv1pXC+pB5VI/V4ReF/xkTJXDzBaUrzxqb073MdOZbbn+Qbkpz
        3IbOg16KTqP9Ei8XFlgRABKEtPDb1IJSqPQ+g3jy55ElX0RxxAa1iV1zwot3FrQA98tziyk+sOnOY
        8uKhv2Ze67AijbLWvNIJCg8f9xU0DxuXg2BqR/RY0q4X7y7D9lKtT/PP37TAkh0LqADsDUtcNWcFk
        ROD4AmU2GsUViN/mTtndNPqCkdxcgSP8yQ3DQO0nBv9xgXQ3v9tC20ueJVHTs53KoKndaqxKh23dY
        gmJUSJqg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEr37-002G3g-Cu; Mon, 09 Jan 2023 12:14:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 894AA3005C9;
        Mon,  9 Jan 2023 13:14:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69868201ABB83; Mon,  9 Jan 2023 13:14:31 +0100 (CET)
Date:   Mon, 9 Jan 2023 13:14:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 2/3] perf/core: Set data->sample_flags in
 perf_prepare_sample()
Message-ID: <Y7wFJ+NF0NwnmzLa@hirez.programming.kicks-ass.net>
References: <20221229204101.1099430-1-namhyung@kernel.org>
 <20221229204101.1099430-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229204101.1099430-2-namhyung@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 29, 2022 at 12:41:00PM -0800, Namhyung Kim wrote:

So I like the general idea; I just think it's turned into a bit of a
mess. That is code is already overly branchy which is known to hurt
performance, we should really try and not make it worse than absolutely
needed.

>  kernel/events/core.c | 86 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 63 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index eacc3702654d..70bff8a04583 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7582,14 +7582,21 @@ void perf_prepare_sample(struct perf_event_header *header,
>  	filtered_sample_type = sample_type & ~data->sample_flags;
>  	__perf_event_header__init_id(header, data, event, filtered_sample_type);
>  
> -	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
> -		data->ip = perf_instruction_pointer(regs);
> +	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE)) {
> +		/* attr.sample_type may not have PERF_SAMPLE_IP */

Right, but that shouldn't matter, IIRC its OK to have more bits set in
data->sample_flags than we have set in attr.sample_type. It just means
we have data available for sample types we're (possibly) not using.

That is, I think you can simply write this like:

> +		if (!(data->sample_flags & PERF_SAMPLE_IP)) {
> +			data->ip = perf_instruction_pointer(regs);
> +			data->sample_flags |= PERF_SAMPLE_IP;
> +		}
> +	}

	if (filtered_sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE)) {
		data->ip = perf_instruction_pointer(regs);
		data->sample_flags |= PERF_SAMPLE_IP);
	}

	...

	if (filtered_sample_type & PERF_SAMPLE_CODE_PAGE_SIZE) {
		data->code_page_size = perf_get_page_size(data->ip);
		data->sample_flags |= PERF_SAMPLE_CODE_PAGE_SIZE;
	}

Then after a single perf_prepare_sample() run we have:

  pre			|	post
  ----------------------------------------
  0			|	0
  IP			|	IP
  CODE_PAGE_SIZE	|	IP|CODE_PAGE_SIZE
  IP|CODE_PAGE_SIZE	|	IP|CODE_PAGE_SIZE

So while data->sample_flags will have an extra bit set in the 3rd case,
that will not affect perf_sample_outout() which only looks at data->type
(== attr.sample_type).

And since data->sample_flags will have both bits set, a second run will
filter out both and avoid the extra work (except doing that will mess up
the branch predictors).


>  	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
>  		int size = 1;
>  
> -		if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
> +		if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN) {
>  			data->callchain = perf_callchain(event, regs);
> +			data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
> +		}
>  
>  		size += data->callchain->nr;
>  

This, why can't this be:

	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN) {
		data->callchain = perf_callchain(event, regs);
		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;

		header->size += (1 + data->callchain->nr) * sizeof(u64);
	}

I suppose this is because perf_event_header lives on the stack of the
overflow handler and all that isn't available / relevant for the BPF
thing.

And we can't pull that out into anther function without adding yet
another branch fest.

However; inspired by your next patch; we can do something like so:

	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN) {
		data->callchain = perf_callchain(event, regs);
		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;

		data->size += (1 + data->callchain->nr) * sizeof(u64);
	}

And then have __perf_event_output() (or something thereabout) do:

	perf_prepare_sample(data, event, regs);
	perf_prepare_header(&header, data, event);
	err = output_begin(&handle, data, event, header.size);
	if (err)
		goto exit;
	perf_output_sample(&handle, &header, data, event);
	perf_output_end(&handle);

With perf_prepare_header() being something like:

	header->type = PERF_RECORD_SAMPLE;
	header->size = sizeof(*header) + event->header_size + data->size;
	header->misc = perf_misc_flags(regs);
	...

Hmm ?

(same for all the other sites)
