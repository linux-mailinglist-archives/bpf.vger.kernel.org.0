Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD103B0C66
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 20:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhFVSI1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 14:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232649AbhFVSHc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Jun 2021 14:07:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9CE361002;
        Tue, 22 Jun 2021 18:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624385116;
        bh=M7SN4cyE6lxKrJXsUW54uqcvWeAJ7zpSgHeOVCwz/Dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BJ8F5u1A/4DRyluQ5RnCIPhyE4eD+Ny8LaEoU+VcF/RnOrbi21oZcfq7LFHpGkA7Z
         seOKSs784LpdxoBPlLJ06k17CzwZgFX9vYq+YE/bgiRqJ24Fc5+dR3AcTjQaatavls
         Yye33XMvlCGyekm+4DuEaU5a0vg3sS50ztoJzAdzi1t/CjJVqD6BY7nUfKCKToW94n
         4Ib+YZnGfV9UgkEj09A9riDH/lSqsZduFBQ0wLpslcG1JIdlv7OYtl8Qj3sDUYZlbZ
         VOPO7w4ytBwVW+34dZYJhPx4aEKG3dTdjPEzQoyEewKDwe3kbtD8d1e2SnHTcCFu8i
         ObmctWPVIOWMg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CE9B440B1A; Tue, 22 Jun 2021 15:05:12 -0300 (-03)
Date:   Tue, 22 Jun 2021 15:05:12 -0300
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
Subject: Re: [PATCH v2 3/3] perf test: Make stat bpf counters test more robust
Message-ID: <YNImWAy+mprxwNjt@kernel.org>
References: <20210621215648.2991319-1-irogers@google.com>
 <20210621215648.2991319-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621215648.2991319-3-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jun 21, 2021 at 02:56:48PM -0700, Ian Rogers escreveu:
> If the test is run on a hypervisor then the cycles event may not be
> counted, skip the test in this situation. Fail the test if cycles are
> not counted in the subsequent bpf counter run.

This one was already in,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/stat_bpf_counters.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
> index 85eb689fe202..6b156dd85469 100755
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
