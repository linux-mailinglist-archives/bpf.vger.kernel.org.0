Return-Path: <bpf+bounces-12208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522287C911D
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 01:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF61DB20C2E
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 23:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2652C856;
	Fri, 13 Oct 2023 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khOgFP81"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56002273E6;
	Fri, 13 Oct 2023 23:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCD3C433C7;
	Fri, 13 Oct 2023 23:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697238046;
	bh=8qM9BSYxF4si0oZK0+zWRYG3pweYYK3vSzWPG9FsH9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khOgFP816HxAaaJBFb9SGkC1jihPOk1bYRxg562/KgHri4N7/lK+1LGiW2kHsAThk
	 gMBZIDfcFSDqO7i12sQH5uibP0qc4F721SRUSQqpoqbzo8lhOTdY8N3EC4TqTR8H1p
	 PSBYfs/hwM54RDVmnyDt7vcN8971GsikBv/x1WUdB/tPfi6JBIwV7LyzOIKvFrkCre
	 GAQFDP7ZWclQxwciGSXhmaL8uUhKe4uGzRkWM8vqEJDweudGRCh3IWB/Futq4tMW9n
	 nJ8wYUrH5yUdjN67zTzuEYY9W11dvWp9+DOUeJ5/xUnz7cxQTiE8moewpu2IWKwLgo
	 W7sZkk+MRDhSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id B2AEA40016; Fri, 13 Oct 2023 20:00:43 -0300 (-03)
Date: Fri, 13 Oct 2023 20:00:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH] perf lock contention: Clear lock addr after use
Message-ID: <ZSnMGwlppacZGaXf@kernel.org>
References: <20230928235018.2136-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928235018.2136-1-namhyung@kernel.org>
X-Url: http://acmel.wordpress.com

Em Thu, Sep 28, 2023 at 04:50:18PM -0700, Namhyung Kim escreveu:
> It checks the current lock to calculated the delta of contention time.

> The address is saved in the tstamp map which is allocated at begining of
> contention and released at end of contention.
> 
> But it's possible for bpf_map_delete_elem() to fail.  In that case, the

How can it fail? 

You do:

        pelem = bpf_map_lookup_elem(&tstamp, &pid);
        if (!pelem || pelem->lock != ctx[0])
                return 0;

So it is there, why would the removal using the same key fail?

The patch should work as-is, I'm just curious about what would make
there removal of a map entry that was successfully looked up on the same
contention_end prog to fail when being removed...

- Arnaldo

> element in the tstamp map kept for the current lock and it makes the
> next contention for the same lock tracked incorrectly.  Specificially
> the next contention begin will see the existing element for the task and
> it'd just return.  Then the next contention end will see the element and
> calculate the time using the timestamp for the previous begin.
> 
> This can result in a large value for two small contentions happened from
> time to time.  Let's clear the lock address so that it can be updated
> next time even if the bpf_map_delete_elem() failed.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 4900a5dfb4a4..b11179452e19 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -389,6 +389,7 @@ int contention_end(u64 *ctx)
>  
>  	duration = bpf_ktime_get_ns() - pelem->timestamp;
>  	if ((__s64)duration < 0) {
> +		pelem->lock = 0;
>  		bpf_map_delete_elem(&tstamp, &pid);
>  		__sync_fetch_and_add(&time_fail, 1);
>  		return 0;
> @@ -422,6 +423,7 @@ int contention_end(u64 *ctx)
>  	data = bpf_map_lookup_elem(&lock_stat, &key);
>  	if (!data) {
>  		if (data_map_full) {
> +			pelem->lock = 0;
>  			bpf_map_delete_elem(&tstamp, &pid);
>  			__sync_fetch_and_add(&data_fail, 1);
>  			return 0;
> @@ -445,6 +447,7 @@ int contention_end(u64 *ctx)
>  				data_map_full = 1;
>  			__sync_fetch_and_add(&data_fail, 1);
>  		}
> +		pelem->lock = 0;
>  		bpf_map_delete_elem(&tstamp, &pid);
>  		return 0;
>  	}
> @@ -458,6 +461,7 @@ int contention_end(u64 *ctx)
>  	if (data->min_time > duration)
>  		data->min_time = duration;
>  
> +	pelem->lock = 0;
>  	bpf_map_delete_elem(&tstamp, &pid);
>  	return 0;
>  }
> -- 
> 2.42.0.582.g8ccd20d70d-goog
> 

-- 

- Arnaldo

