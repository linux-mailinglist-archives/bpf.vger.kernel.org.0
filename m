Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F2A3B0C69
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 20:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhFVSIb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 14:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232986AbhFVSHj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Jun 2021 14:07:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 077666102A;
        Tue, 22 Jun 2021 18:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624385123;
        bh=xOr3aNQ3y835jCNRsNEiusqupvJHo+M8yZ7YyWDeqTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3pe/RwwsR7ftBaU/Mz28Rub+psTYf5StzRVhQvDEA+Vq8JVPnWsj7s8CvHrksTfu
         PLYh1GjY1y9yvNtoEw9MfJ033KzIfVh4v8j7js/VtcEJRaqwzs+1L5t9CXqznjvvxr
         GNJ3V/ZiWh8DbGcIFuuFOKpP3Q8LLszHhKDCme4vMGfsBN3yFisorBbddcnkPk1JQP
         5A/Tn5sne8AixOfhlRpQsEpzg+BczkOG7mCWoi1zodFjIv52dGP106KButUPBB/edo
         AA+wY0UR8nOGsAY4L7vEy1xsdu2l2bL1T96gZAv7XEZImT1L4y4+joKh8LK/D9YNJr
         rZ9Z35tFgcZpQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 332C840F21; Tue, 22 Jun 2021 15:05:21 -0300 (-03)
Date:   Tue, 22 Jun 2021 15:05:21 -0300
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
Subject: Re: [PATCH v2 2/3] perf test: Add verbose skip output for bpf
 counters
Message-ID: <YNImYYYbIuc5V98C@kernel.org>
References: <20210621215648.2991319-1-irogers@google.com>
 <20210621215648.2991319-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621215648.2991319-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jun 21, 2021 at 02:56:47PM -0700, Ian Rogers escreveu:
> Provide additional context for when the stat bpf counters test skips.

Ditto
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/stat_bpf_counters.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
> index 22eb31e48ca7..85eb689fe202 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> @@ -22,7 +22,13 @@ compare_number()
>  }
>  
>  # skip if --bpf-counters is not supported
> -perf stat --bpf-counters true > /dev/null 2>&1 || exit 2
> +if ! perf stat --bpf-counters true > /dev/null 2>&1; then
> +	if [ "$1" == "-v" ]; then
> +		echo "Skipping: --bpf-counters not supported"
> +		perf --no-pager stat --bpf-counters true || true
> +	fi
> +	exit 2
> +fi
>  
>  base_cycles=$(perf stat --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
>  bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
> -- 
> 2.32.0.288.g62a8d224e6-goog
> 

-- 

- Arnaldo
