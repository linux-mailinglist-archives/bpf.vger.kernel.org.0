Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C121A3ABC7E
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 21:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhFQTUm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 15:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232733AbhFQTUj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 15:20:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 126B56113C;
        Thu, 17 Jun 2021 19:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623957511;
        bh=vCVS05Pp89HYnhbA7y+ao2uqgP3WCql562KkD9r/PLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gBQ6I7t/ZXtNcVgHrq0+LxeWI+ACik7qP7iXmFmWThwykXa3l0uYEq0SlKqckg/PV
         HtVFjNNQLI+A98ssq2tJyJpqRz9eh4xgKIXa0lRXj3BfucnX4EbtBnH+kiJVmAQmhJ
         BFcmx/Av9PC2T0F+Oc2JMNuhtCCGSWxBg1iweDvWLJm5ymN1g6Wo9XW8WEqqiRzgAp
         l/DnWvKS2/p2kJqB49JudUD5cZrjlo38mC2VfWzRxE5V+wo69am+B4Sz5G/8Hhp6I5
         dKPMsQzZWVddDU/07KmAO7Yzi1gtqqkRdM0IpHQbPHMgesUp3ogN97aWQOCfREwKYJ
         gqxE78p8z2BOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E83D440B1A; Thu, 17 Jun 2021 16:18:27 -0300 (-03)
Date:   Thu, 17 Jun 2021 16:18:27 -0300
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
Subject: Re: [PATCH 1/4] perf test: Fix non-bash issue with stat bpf counters
Message-ID: <YMugA9HDxB57MFTS@kernel.org>
References: <20210617184216.2075588-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617184216.2075588-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jun 17, 2021 at 11:42:13AM -0700, Ian Rogers escreveu:
> $(( .. )) is a bash feature but the test's interpreter is !/bin/sh,
> switch the code to use expr.


Thanks, applied to perf/urgent.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/stat_bpf_counters.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
> index 22eb31e48ca7..2f9948b3d943 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> @@ -11,9 +11,9 @@ compare_number()
>         second_num=$2
>  
>         # upper bound is first_num * 110%
> -       upper=$(( $first_num + $first_num / 10 ))
> +       upper=$(expr $first_num + $first_num / 10 )
>         # lower bound is first_num * 90%
> -       lower=$(( $first_num - $first_num / 10 ))
> +       lower=$(expr $first_num - $first_num / 10 )
>  
>         if [ $second_num -gt $upper ] || [ $second_num -lt $lower ]; then
>                 echo "The difference between $first_num and $second_num are greater than 10%."
> -- 
> 2.32.0.288.g62a8d224e6-goog
> 

-- 

- Arnaldo
