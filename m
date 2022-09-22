Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208A25E6BAC
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 21:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiIVTXN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 15:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiIVTXM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 15:23:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894F2286D6;
        Thu, 22 Sep 2022 12:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EE9C61175;
        Thu, 22 Sep 2022 19:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52694C433D7;
        Thu, 22 Sep 2022 19:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663874590;
        bh=2DZjj8mS7EZ9M/LXHnntgYzTasGSbm7dQDwq3kbKrRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4c2Z+6Trx3SV1wFpJqn4BFOBW6BC8w7thIgfQWX74LAcI+V+O0N/WRFFUtd+Ihvi
         iLZ1wEggUF41RDsoday1TMULHLMRXkXw9122nsBxKAtPkt1RQLOzEWmmn8BRasg1CR
         E0NPWAYW29BrVPmUsJtdRzUG9B+8EtGqvT4xUet+SYLv+z/kONZ4iBxQQlbJbGDCWD
         Ws9HurS6Saaf/MjkBzf7ndLtNbfylsFF3wRgcLTWUrDoWhrZzhz9u2K4C4QOpIWak2
         YM7WsbMA0GjeUfgiIoUO0ZSSA58qUTDN/xok/YmcH1MQhk2VLMN9/S/CAzxX/Hk93v
         vLTOG1egpTOtA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0B3A6403B0; Thu, 22 Sep 2022 20:23:08 +0100 (IST)
Date:   Thu, 22 Sep 2022 20:23:08 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2] perf tools: Get a perf cgroup more portably in BPF
Message-ID: <Yyy2HAxVRy6TuTHQ@kernel.org>
References: <20220922044023.718774-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922044023.718774-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Sep 21, 2022 at 09:40:23PM -0700, Namhyung Kim escreveu:
> The perf_event_cgrp_id can be different on other configurations.
> To be more portable as CO-RE, it needs to get the cgroup subsys id
> using the bpf_core_enum_value() helper.
> 
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Applying, Ian, can I have your Reviewed-by?

- Arnaldo

> ---
> v2 changes)
>  * fix off_cpu.bpf.c too
>  * get perf_subsys_id only once
> 
>  tools/perf/util/bpf_skel/bperf_cgroup.bpf.c |  6 +++++-
>  tools/perf/util/bpf_skel/off_cpu.bpf.c      | 12 ++++++++----
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> index 292c430768b5..9223e4b87fe9 100644
> --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> @@ -48,6 +48,7 @@ const volatile __u32 num_cpus = 1;
>  
>  int enabled = 0;
>  int use_cgroup_v2 = 0;
> +int perf_subsys_id = -1;
>  
>  static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
>  {
> @@ -58,7 +59,10 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
>  	int level;
>  	int cnt;
>  
> -	cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_event_cgrp_id], cgroup);
> +	if (perf_subsys_id == -1)
> +		perf_subsys_id = bpf_core_enum_value(enum cgroup_subsys_id, perf_event_cgrp_id);
> +
> +	cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_subsys_id], cgroup);
>  	level = BPF_CORE_READ(cgrp, level);
>  
>  	for (cnt = 0; i < MAX_LEVELS; i++) {
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> index c4ba2bcf179f..e917ef7b8875 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -94,6 +94,8 @@ const volatile bool has_prev_state = false;
>  const volatile bool needs_cgroup = false;
>  const volatile bool uses_cgroup_v1 = false;
>  
> +int perf_subsys_id = -1;
> +
>  /*
>   * Old kernel used to call it task_struct->state and now it's '__state'.
>   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> @@ -119,11 +121,13 @@ static inline __u64 get_cgroup_id(struct task_struct *t)
>  {
>  	struct cgroup *cgrp;
>  
> -	if (uses_cgroup_v1)
> -		cgrp = BPF_CORE_READ(t, cgroups, subsys[perf_event_cgrp_id], cgroup);
> -	else
> -		cgrp = BPF_CORE_READ(t, cgroups, dfl_cgrp);
> +	if (!uses_cgroup_v1)
> +		return BPF_CORE_READ(t, cgroups, dfl_cgrp, kn, id);
> +
> +	if (perf_subsys_id == -1)
> +		perf_subsys_id = bpf_core_enum_value(enum cgroup_subsys_id, perf_event_cgrp_id);
>  
> +	cgrp = BPF_CORE_READ(t, cgroups, subsys[perf_subsys_id], cgroup);
>  	return BPF_CORE_READ(cgrp, kn, id);
>  }
>  
> -- 
> 2.37.3.968.ga6b4b080e4-goog

-- 

- Arnaldo
