Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955853ABC9A
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 21:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhFQTX3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 15:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233463AbhFQTX0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 15:23:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B94286113C;
        Thu, 17 Jun 2021 19:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623957677;
        bh=q5hlbRHsFfjAH3UdAr/zMY+SdxbDvMeHp5XqmXpwAXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NvOGs48Qy8+G0VLwCZWag7aP5F3xT4A3ZpNoreo0uTmngyd9DiBQDDppqsXgcLbhC
         kx9SFL2G+tiHlddtoqZsbcMhx+uwB041KHG6Xg3v5UhuuYp4Go1GdiN9MLgJoe1x03
         QOVzn/W2GBzqiPXz3fDBxDq7r4uecx63Bc835t5mrVjSJdC5CV9JXYqoqQ4SdHFnZt
         EubX502xsTN5kelmirnMgJrhVUYdOKYilWh/84EfD2+1cCiZnTc6U+fonwhvRw///2
         u+K9VONqxAybZIAnKQ1TvUL5u/WDwLfcmLqgoR1cKqUzbYhq25Xe7L5N3bGKRciX2z
         BwCtq+QB7OK5g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4577F40B1A; Thu, 17 Jun 2021 16:21:15 -0300 (-03)
Date:   Thu, 17 Jun 2021 16:21:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 4/4] perf test: Make stat bpf counters test more robust
Message-ID: <YMugqwLGdkJrrrRT@kernel.org>
References: <20210617184216.2075588-1-irogers@google.com>
 <20210617184216.2075588-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617184216.2075588-4-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jun 17, 2021 at 11:42:16AM -0700, Ian Rogers escreveu:
> If the test is run on a hypervisor then the cycles event may not be
> counted, skip the test in this situation. Fail the test if cycles are
> not counted in the subsequent bpf counter run.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/stat_bpf_counters.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
> index 81d61b6e1208..2aed20dc2262 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> @@ -31,7 +31,15 @@ if ! perf stat --bpf-counters true > /dev/null 2>&1; then
>  fi
>  
>  base_cycles=$(perf stat --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
> +if [ "$base_cycles" == "<not" ]; then
> +	echo "Skipping: cycles event not counted"
> +	exit 2
> +fi
>  bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
> +if [ "$bpf_cycles" == "<not" ]; then
> +	echo "Failed: cycles not counted with --bpf-counters"
> +	exit 1
> +fi
>  
>  compare_number $base_cycles $bpf_cycles
>  exit 0
> -- 
> 2.32.0.288.g62a8d224e6-goog
> 

-- 

- Arnaldo
