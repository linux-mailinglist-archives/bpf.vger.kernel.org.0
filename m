Return-Path: <bpf+bounces-38553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8487D9662C4
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 15:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2118AB20BF8
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 13:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD43D1A7AD0;
	Fri, 30 Aug 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYgN5f+h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE8518EFD2;
	Fri, 30 Aug 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023856; cv=none; b=SckaW4ifcW3xx44ErxvNkk4A9lgHqj2zDnRj8tTIzqvfDFf+wvxXWe/z4uR0AIN0lI0/h5qDwEqV1G81Vcy4j0nVSDzX2MJx0and30CVsXPcUcwWdXt9PHyoecJ7YDKnSx8B1Du+fywg2AMnWdy/Pd6DbGknttsP7Ynegv35Tic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023856; c=relaxed/simple;
	bh=mfeW/dQ8kjLmkQq9sv1rxcQaPZFy1TbjCAt7LHtG9VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdIACfBAim/3yuXT8rbAq42F9ZI8fpCVQMbfCEWXaS/W4V/rGh7NDQuurw6UAoQ+1UtM9WKN44rn0Ht3q2FrkBm3fRL8p3ZlIks2XW466+wg4qgiBCDTlYxmBwKfDjz5cyguGhTq3ETFxJRQTKwH++A47IdyacNrcgTE5yKlbDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYgN5f+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2BBC4CEC2;
	Fri, 30 Aug 2024 13:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023855;
	bh=mfeW/dQ8kjLmkQq9sv1rxcQaPZFy1TbjCAt7LHtG9VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uYgN5f+h+BXRZpCe7XalhR1miF+MuQMUE0/q6qeTB6nOx+4FxLm/+nNOfhdULO5Vx
	 bNkNLgbLU4MLFbZb/4bxqsNZXeLpJ4WsXvADrMoHrpMsszaQ7lMsRfi5OC9x6A8Lql
	 vY4qkERRq0CqFm8KIRJ9NUuPcxt3luobX9bqw9/eMPO/G7Qfyn8akRGOkPXjflGxIo
	 q7C5m3f93p8GAR2HaqEiez9+eP076avfoseLdtLFeUGBm5LOzkCUGdiS2ojjFbPY7S
	 /MuR8EkZJLp+/rLYTBjDYLEE0KKBvWkb08YVYb4GVQkZgah6Er5xom9aZiTxzTPwY4
	 Otln68+WykiSw==
Date: Fri, 30 Aug 2024 10:17:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH 1/3] perf lock contention: Handle error in a single place
Message-ID: <ZtHGbFyJYLzzVRou@x1>
References: <20240830065150.1758962-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830065150.1758962-1-namhyung@kernel.org>

On Thu, Aug 29, 2024 at 11:51:48PM -0700, Namhyung Kim wrote:
> It has some duplicate codes to do the same job.  Let's add a label and
> goto there to handle errors in a single place.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index d931a898c434..e8a6f6463019 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -439,11 +439,8 @@ int contention_end(u64 *ctx)
>  
>  	duration = bpf_ktime_get_ns() - pelem->timestamp;
>  	if ((__s64)duration < 0) {
> -		pelem->lock = 0;
> -		if (need_delete)
> -			bpf_map_delete_elem(&tstamp, &pid);
>  		__sync_fetch_and_add(&time_fail, 1);
> -		return 0;
> +		goto out;
>  	}
>  
>  	switch (aggr_mode) {
> @@ -477,11 +474,8 @@ int contention_end(u64 *ctx)
>  	data = bpf_map_lookup_elem(&lock_stat, &key);
>  	if (!data) {
>  		if (data_map_full) {
> -			pelem->lock = 0;
> -			if (need_delete)
> -				bpf_map_delete_elem(&tstamp, &pid);
>  			__sync_fetch_and_add(&data_fail, 1);
> -			return 0;
> +			goto out;
>  		}
>  
>  		struct contention_data first = {
> @@ -502,10 +496,7 @@ int contention_end(u64 *ctx)
>  				data_map_full = 1;
>  			__sync_fetch_and_add(&data_fail, 1);
>  		}
> -		pelem->lock = 0;
> -		if (need_delete)
> -			bpf_map_delete_elem(&tstamp, &pid);
> -		return 0;
> +		goto out;
>  	}
>  
>  	__sync_fetch_and_add(&data->total_time, duration);
> @@ -517,6 +508,7 @@ int contention_end(u64 *ctx)
>  	if (data->min_time > duration)
>  		data->min_time = duration;
>  
> +out:
>  	pelem->lock = 0;
>  	if (need_delete)
>  		bpf_map_delete_elem(&tstamp, &pid);
> -- 
> 2.46.0.469.g59c65b2a67-goog

