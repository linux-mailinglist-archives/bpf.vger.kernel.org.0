Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684F065D57F
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 15:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbjADOV0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 09:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239410AbjADOVY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 09:21:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D9D38A;
        Wed,  4 Jan 2023 06:21:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E31EB6174E;
        Wed,  4 Jan 2023 14:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31743C433EF;
        Wed,  4 Jan 2023 14:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672842083;
        bh=VGhv39M7ZvdZ4R6rSSfVY15QnkI8S72J/pfHLmLDaGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTowqK06nFDvlyL3xR8NjzFU7r4BInoCdFJr5/oGad+uE4y+aMOvr7k8DSJs4GwGg
         LKD7X8+xR288oMO4I8vQ1QgTmmj/MfgdaTBzj5kfB3yd5fXnAc9Dz1BvlKOD3GlCUy
         gT66rmqcLpXsYRvyR/AHyqD01GHMOQlZ/fQXpkvvprpmshfPL0YLwucfH5El0dHdKz
         oXHG/+WTsHFGeUzbuQH+IWTUGLm3ECQG1PjMX/eTwD104cGdMc07vJiVHl2A3ZxJKK
         4Gd06BWRfL2VWVDEEgjAQ7IFxYpuGqNpLPxz0lrZhBoRjWtnv8taKy8ksfCOHfinIF
         SUzyHpGyVkHOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 964B240468; Wed,  4 Jan 2023 11:21:19 -0300 (-03)
Date:   Wed, 4 Jan 2023 11:21:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH 4/4] perf stat: Do not use the same cgroup more than once
Message-ID: <Y7WLX3W0yCrZUp2t@kernel.org>
References: <20230104064402.1551516-1-namhyung@kernel.org>
 <20230104064402.1551516-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104064402.1551516-5-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jan 03, 2023 at 10:44:02PM -0800, Namhyung Kim escreveu:
> The --for-each-cgroup can have the same cgroup multiple times, but it makes
> bpf counters confused (since they have the same cgroup id), and the last
> cgroup events are counted only.  Let's check the cgroup name before adding
> a new entry.
> 
> Before:
>   $ sudo ./perf stat -a --bpf-counters --for-each-cgroup /,/ sleep 1
> 
>    Performance counter stats for 'system wide':
> 
>        <not counted> msec cpu-clock                        /
>        <not counted>      context-switches                 /
>        <not counted>      cpu-migrations                   /
>        <not counted>      page-faults                      /
>        <not counted>      cycles                           /
>        <not counted>      instructions                     /
>        <not counted>      branches                         /
>        <not counted>      branch-misses                    /
>             8,016.04 msec cpu-clock                        /                #    7.998 CPUs utilized
>                6,152      context-switches                 /                #  767.461 /sec
>                  250      cpu-migrations                   /                #   31.187 /sec
>                  442      page-faults                      /                #   55.139 /sec
>          613,111,487      cycles                           /                #    0.076 GHz
>          280,599,604      instructions                     /                #    0.46  insn per cycle
>           57,692,724      branches                         /                #    7.197 M/sec
>            3,385,168      branch-misses                    /                #    5.87% of all branches
> 
>          1.002220125 seconds time elapsed
> 
> After:
>   $ sudo ./perf stat -a --bpf-counters --for-each-cgroup /,/  sleep 1
> 
>    Performance counter stats for 'system wide':
> 
>             8,013.38 msec cpu-clock                        /                #    7.998 CPUs utilized
>                6,859      context-switches                 /                #  855.944 /sec
>                  334      cpu-migrations                   /                #   41.680 /sec
>                  345      page-faults                      /                #   43.053 /sec
>          782,326,119      cycles                           /                #    0.098 GHz
>          471,645,724      instructions                     /                #    0.60  insn per cycle
>           94,963,430      branches                         /                #   11.851 M/sec
>            3,685,511      branch-misses                    /                #    3.88% of all branches
> 
>          1.001864539 seconds time elapsed
> 
> Fixes: bb1c15b60b981 ("perf stat: Support regex pattern in --for-each-cgroup")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Tested and appied.

- Arnaldo

> ---
>  tools/perf/util/cgroup.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index e99b41f9be45..cd978c240e0d 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -224,6 +224,19 @@ static int add_cgroup_name(const char *fpath, const struct stat *sb __maybe_unus
>  	return 0;
>  }
>  
> +static int check_and_add_cgroup_name(const char *fpath)
> +{
> +	struct cgroup_name *cn;
> +
> +	list_for_each_entry(cn, &cgroup_list, list) {
> +		if (!strcmp(cn->name, fpath))
> +			return 0;
> +	}
> +
> +	/* pretend if it's added by ftw() */
> +	return add_cgroup_name(fpath, NULL, FTW_D, NULL);
> +}
> +
>  static void release_cgroup_list(void)
>  {
>  	struct cgroup_name *cn;
> @@ -242,7 +255,7 @@ static int list_cgroups(const char *str)
>  	struct cgroup_name *cn;
>  	char *s;
>  
> -	/* use given name as is - for testing purpose */
> +	/* use given name as is when no regex is given */
>  	for (;;) {
>  		p = strchr(str, ',');
>  		e = p ? p : eos;
> @@ -253,13 +266,13 @@ static int list_cgroups(const char *str)
>  			s = strndup(str, e - str);
>  			if (!s)
>  				return -1;
> -			/* pretend if it's added by ftw() */
> -			ret = add_cgroup_name(s, NULL, FTW_D, NULL);
> +
> +			ret = check_and_add_cgroup_name(s);
>  			free(s);
> -			if (ret)
> +			if (ret < 0)
>  				return -1;
>  		} else {
> -			if (add_cgroup_name("", NULL, FTW_D, NULL) < 0)
> +			if (check_and_add_cgroup_name("/") < 0)
>  				return -1;
>  		}
>  
> -- 
> 2.39.0.314.g84b9a713c41-goog

-- 

- Arnaldo
