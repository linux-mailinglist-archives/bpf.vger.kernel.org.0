Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6C355E986
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344815AbiF1Ooy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 10:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiF1Oox (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 10:44:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A240F2C101;
        Tue, 28 Jun 2022 07:44:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E729B81E1B;
        Tue, 28 Jun 2022 14:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2931C3411D;
        Tue, 28 Jun 2022 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656427489;
        bh=znnZhND4MStS8axD7DZM63GETTGWg85blo0qWJFB8GA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQO7rcBZRYhmXeHnTT48ArPTQjIZwXE+CIKGT7tBR/2gWhgtq33DrXd/PiRp5P3Ua
         75+a0cTOQmiueyuTi01tUB1C4hsSkaL+4RQeuX446zEqWzuPGmnFNCcNTgAEFdNoK1
         ejkT87qmo0HCTo+WVht65m2EwF0KmZMqvBD4oiBeT3Ar/G7+C0UiiUEB0t99CPvPa1
         wqCY6BXy+x8NuhO3XLl+Ww+xFz554dA8ZGMYBCXjZAqJ3+LXj4OW/zdMwBXjNF4VWA
         lyNV44TIBaR3EJ4Rvcmh/KkszSi2Ho8oa2D6JMk3vT0+L+W8BelRRZwPnEDX81/TRd
         EpBDBU/FQimUw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9A1BF4096F; Tue, 28 Jun 2022 11:44:46 -0300 (-03)
Date:   Tue, 28 Jun 2022 11:44:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: Re: [PATCH 1/6] perf offcpu: Fix a build failure on old kernels
Message-ID: <YrsT3iw+FEXb6kxF@kernel.org>
References: <20220624231313.367909-1-namhyung@kernel.org>
 <20220624231313.367909-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624231313.367909-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Jun 24, 2022 at 04:13:08PM -0700, Namhyung Kim escreveu:
> Old kernels have task_struct which contains "state" field and newer
> kernels have "__state".  While the get_task_state() in the BPF code
> handles that in some way, it assumed the current kernel has the new
> definition and it caused a build error on old kernels.
> 
> We should not assume anything and access them carefully.  Do not use
> the task struct directly and access them using new and old definitions
> in a row.

I added a:

Fixes: edc41a1099c2d08c ("perf record: Enable off-cpu analysis with BPF")

Ok?

- Arnaldo
 
> Reported-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_skel/off_cpu.bpf.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> index 792ae2847080..cc6d7fd55118 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -71,6 +71,11 @@ struct {
>  	__uint(max_entries, 1);
>  } cgroup_filter SEC(".maps");
>  
> +/* new kernel task_struct definition */
> +struct task_struct___new {
> +	long __state;
> +} __attribute__((preserve_access_index));
> +
>  /* old kernel task_struct definition */
>  struct task_struct___old {
>  	long state;
> @@ -93,14 +98,17 @@ const volatile bool uses_cgroup_v1 = false;
>   */
>  static inline int get_task_state(struct task_struct *t)
>  {
> -	if (bpf_core_field_exists(t->__state))
> -		return BPF_CORE_READ(t, __state);
> +	/* recast pointer to capture new type for compiler */
> +	struct task_struct___new *t_new = (void *)t;
>  
> -	/* recast pointer to capture task_struct___old type for compiler */
> -	struct task_struct___old *t_old = (void *)t;
> +	if (bpf_core_field_exists(t_new->__state)) {
> +		return BPF_CORE_READ(t_new, __state);
> +	} else {
> +		/* recast pointer to capture old type for compiler */
> +		struct task_struct___old *t_old = (void *)t;
>  
> -	/* now use old "state" name of the field */
> -	return BPF_CORE_READ(t_old, state);
> +		return BPF_CORE_READ(t_old, state);
> +	}
>  }
>  
>  static inline __u64 get_cgroup_id(struct task_struct *t)
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog

-- 

- Arnaldo
