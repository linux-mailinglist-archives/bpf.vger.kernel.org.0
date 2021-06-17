Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B363F3ABC8B
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 21:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhFQTW3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 15:22:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232109AbhFQTWX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 15:22:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA00F613E1;
        Thu, 17 Jun 2021 19:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623957615;
        bh=DN1dKKh82VC332PLOIPUDfqY/yz9hU4wlhkBHuwu6eA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEqxsgbzCNMgAi7+74kiQrGRpxLNx+5Hn6uEReR3uWptLybxcDG8aN1F2jFRkgOPi
         mJl6F4Z3gdC3epRXEowKeReh4/F7L4njEMtsnPGs8K2n6e5rJ3Elmwbz/GbtTyqjeK
         YnF9kpH1HbN7pukdFzhH5UcP3UoopLoKuUCkj640wYjHx+2EHAqqd7b4cU9qJMON7n
         TiKqMIynzbr3FWQpP/H2Omrcjp/z445GqTQwTPZvFI2ADd4RQEljWqdYQIloX8exlv
         Xi1BT7saN8vVhyaD2jB0vwPqfAFwGe8+/gXm9Sn3D1zGgVcN2xXSFmfErxnpOWfmyM
         faQzchZQ68kVA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8987E40B1A; Thu, 17 Jun 2021 16:20:12 -0300 (-03)
Date:   Thu, 17 Jun 2021 16:20:12 -0300
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
Subject: Re: [PATCH 3/4] perf test: Add verbose skip output for bpf counters
Message-ID: <YMugbNVy4hyrzYi2@kernel.org>
References: <20210617184216.2075588-1-irogers@google.com>
 <20210617184216.2075588-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617184216.2075588-3-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jun 17, 2021 at 11:42:15AM -0700, Ian Rogers escreveu:
> Provide additional context for when the stat bpf counters test skips.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/stat_bpf_counters.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
> index 2f9948b3d943..81d61b6e1208 100755
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
