Return-Path: <bpf+bounces-40332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C90D986BB3
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 06:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D07E2827DD
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 04:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5F41CA8D;
	Thu, 26 Sep 2024 04:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjosfsA4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248291D5AA1;
	Thu, 26 Sep 2024 04:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727324193; cv=none; b=QG+1MIAO7Bxs4eMrtG+vuFn+mzj9DmnT4t6yB3VlcruDgzcPTleuV2UNNPdpGscgdoVi/ljUPIP2BIhmVzKSCGrQAYBowqcmpoifVTw36fBEBeLMPt9IzftX9bjcGk0vGxe/41g81fgef3JFQ1CDSoYua9AadlVzvnzFpcsVMT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727324193; c=relaxed/simple;
	bh=YUi2PdZFzqDXd+/ooP06U52h+kHOzFfWJbmz5ZNvLiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEM+v2x+427EQJP7po8XkoXuhCo5kyiPJefxQRQi7busAOX/kYsyFQUDhY0ShSFWRX/csGZvGrHshssT0PntMQyQoitFJY0dhThGmZ98zysXHiMmcVJk8nNmUa9dlbZBp8UEPfmgOUTSeKuIVRnyp1ZEnYaz4svMqeVkY0IAn/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjosfsA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1698C4CEC5;
	Thu, 26 Sep 2024 04:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727324190;
	bh=YUi2PdZFzqDXd+/ooP06U52h+kHOzFfWJbmz5ZNvLiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BjosfsA4kjxink+AK5pZjb/moUlsKXwb9wepWUQDGisr31I6WFUdI6hOIccfLuu0K
	 HUYju9COw9Zs0UAnO6b9IQMu3a9P9b/v/2vb7/5Jxf/lkFvSZphDL5XJMBPVQl9tjK
	 jC184+x6ohZMaewWZmpr130rq9W/k9tvNp8NMuv6cuOJvYEiYg4q8C4VFrXfvI/OZG
	 BQHvDLjeMKeZD17Ns4zxCjSyN4exEJXz83cVaElvGUdu9u3nENAp4IvdbLAzY+BM+J
	 ZE2ZIbKSC1ljzjM30lype5PxFRqLpdg4JgGIbsT+EwJHdQU5Yd1GbWJx65zNZKsEVx
	 Ik+lDwutfszqQ==
Date: Wed, 25 Sep 2024 21:16:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, song@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH -next 1/2] perf stat: Increase perf_attr_map entries
Message-ID: <ZvTgHKl4eZvpyVml@google.com>
References: <20240925135523.367957-1-wutengda@huaweicloud.com>
 <20240925135523.367957-2-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240925135523.367957-2-wutengda@huaweicloud.com>

On Wed, Sep 25, 2024 at 01:55:22PM +0000, Tengda Wu wrote:
> bperf restricts the size of perf_attr_map's entries to 16, which
> cannot hold all events in many scenarios. A typical example is
> when the user specifies `-a -ddd` ([0]). And in other cases such as
> top-down analysis, which often requires a set of more than 16 PMUs
> to be collected simultaneously.
> 
> Fix this by increase perf_attr_map entries to 100, and an event
> number check has been introduced when bperf__load() to ensure that
> users receive a more friendly prompt when the event limit is reached.
> 
>   [0] https://lore.kernel.org/all/20230104064402.1551516-3-namhyung@kernel.org/

Apparently this patch was never applied.  I don't know how much you need
but having too many events at the same time won't be very useful because
multiplexing could reduce the accuracy.

Thanks,
Namhyung

> 
> Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware PMCs with BPF")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  tools/perf/util/bpf_counter.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index 7a8af60e0f51..3346129c20cf 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -28,7 +28,7 @@
>  #include "bpf_skel/bperf_leader.skel.h"
>  #include "bpf_skel/bperf_follower.skel.h"
>  
> -#define ATTR_MAP_SIZE 16
> +#define ATTR_MAP_SIZE 100
>  
>  static inline void *u64_to_ptr(__u64 ptr)
>  {
> @@ -451,6 +451,12 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>  	enum bperf_filter_type filter_type;
>  	__u32 filter_entry_cnt, i;
>  
> +	if (evsel->evlist->core.nr_entries > ATTR_MAP_SIZE) {
> +		pr_err("Too many events, please limit to %d or less\n",
> +			ATTR_MAP_SIZE);
> +		return -1;
> +	}
> +
>  	if (bperf_check_target(evsel, target, &filter_type, &filter_entry_cnt))
>  		return -1;
>  
> -- 
> 2.34.1
> 

