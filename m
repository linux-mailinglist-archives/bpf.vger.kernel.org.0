Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017C66602A5
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 15:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjAFOzj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 09:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbjAFOzg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 09:55:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22158110B;
        Fri,  6 Jan 2023 06:55:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 30257CE1D06;
        Fri,  6 Jan 2023 14:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1194BC433EF;
        Fri,  6 Jan 2023 14:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673016932;
        bh=UyzAwDFj483hUCSJgJwOF1/K5+N5Cz7AuCJePXSb/Ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W++K1xDs78oD3sadQHcJb/VGnRR+TjNwleDAIIMV7LiJ34YG6txNOJKG5XyfFTdOA
         Rjg4fCFEMjCyP16hwAJ2Ym6dsdRpm/SpW1Jd0SS3VcEkX8R/vZ7lHhEa4tnfSHdsmb
         r8P8sSxug0TnC9/JJ1vAeZ1hqwWaBE0dPT3O3yj31/vzTVu/kPEHISNgVkCPBenBxf
         tYUAq6YlgwkdP5uJTn7wZQNIgHy5cFKRB8dXWia6ljjho3zD34S69Su+13AlOBHu8W
         Z+CZeTH/5LkbRYhbJn9uLzP66wmUqtHuBkJE08VPJxq7z04MUsnlem+/etCUqpfK8h
         4WAq+21OPTrQA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9396840468; Fri,  6 Jan 2023 11:55:29 -0300 (-03)
Date:   Fri, 6 Jan 2023 11:55:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v2 1/2] perf build: Properly guard libbpf includes
Message-ID: <Y7g2YXNaP0VM+F1o@kernel.org>
References: <20230106142537.607399-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106142537.607399-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Jan 06, 2023 at 06:25:36AM -0800, Ian Rogers escreveu:
> Including libbpf header files should be guarded by
> HAVE_LIBBPF_SUPPORT. In bpf_counter.h, move the skeleton utilities
> under HAVE_BPF_SKEL.
> 
> Fixes: d6a735ef3277 ("perf bpf_counter: Move common functions to bpf_counter.h")
> Reported-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

Can this be done in a way that reduces patch size?

- Arnaldo

> ---
>  tools/perf/builtin-trace.c    |  2 +
>  tools/perf/util/bpf_counter.h | 85 ++++++++++++++++++-----------------
>  2 files changed, 46 insertions(+), 41 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 86e06f136f40..d21fe0f32a6d 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -16,7 +16,9 @@
>  
>  #include "util/record.h"
>  #include <api/fs/tracing_path.h>
> +#ifdef HAVE_LIBBPF_SUPPORT
>  #include <bpf/bpf.h>
> +#endif
>  #include "util/bpf_map.h"
>  #include "util/rlimit.h"
>  #include "builtin.h"
> diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
> index 4dbf26408b69..9113c8bf5cb0 100644
> --- a/tools/perf/util/bpf_counter.h
> +++ b/tools/perf/util/bpf_counter.h
> @@ -4,9 +4,12 @@
>  
>  #include <linux/list.h>
>  #include <sys/resource.h>
> +
> +#ifdef HAVE_LIBBPF_SUPPORT
>  #include <bpf/bpf.h>
>  #include <bpf/btf.h>
>  #include <bpf/libbpf.h>
> +#endif
>  
>  struct evsel;
>  struct target;
> @@ -42,6 +45,47 @@ int bpf_counter__read(struct evsel *evsel);
>  void bpf_counter__destroy(struct evsel *evsel);
>  int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd);
>  
> +static inline __u32 bpf_link_get_id(int fd)
> +{
> +	struct bpf_link_info link_info = { .id = 0, };
> +	__u32 link_info_len = sizeof(link_info);
> +
> +	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> +	return link_info.id;
> +}
> +
> +static inline __u32 bpf_link_get_prog_id(int fd)
> +{
> +	struct bpf_link_info link_info = { .id = 0, };
> +	__u32 link_info_len = sizeof(link_info);
> +
> +	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> +	return link_info.prog_id;
> +}
> +
> +static inline __u32 bpf_map_get_id(int fd)
> +{
> +	struct bpf_map_info map_info = { .id = 0, };
> +	__u32 map_info_len = sizeof(map_info);
> +
> +	bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> +	return map_info.id;
> +}
> +
> +/* trigger the leader program on a cpu */
> +static inline int bperf_trigger_reading(int prog_fd, int cpu)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> +			    .ctx_in = NULL,
> +			    .ctx_size_in = 0,
> +			    .flags = BPF_F_TEST_RUN_ON_CPU,
> +			    .cpu = cpu,
> +			    .retval = 0,
> +		);
> +
> +	return bpf_prog_test_run_opts(prog_fd, &opts);
> +}
> +
>  #else /* HAVE_BPF_SKEL */
>  
>  #include <linux/err.h>
> @@ -87,45 +131,4 @@ static inline void set_max_rlimit(void)
>  	setrlimit(RLIMIT_MEMLOCK, &rinf);
>  }
>  
> -static inline __u32 bpf_link_get_id(int fd)
> -{
> -	struct bpf_link_info link_info = { .id = 0, };
> -	__u32 link_info_len = sizeof(link_info);
> -
> -	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> -	return link_info.id;
> -}
> -
> -static inline __u32 bpf_link_get_prog_id(int fd)
> -{
> -	struct bpf_link_info link_info = { .id = 0, };
> -	__u32 link_info_len = sizeof(link_info);
> -
> -	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> -	return link_info.prog_id;
> -}
> -
> -static inline __u32 bpf_map_get_id(int fd)
> -{
> -	struct bpf_map_info map_info = { .id = 0, };
> -	__u32 map_info_len = sizeof(map_info);
> -
> -	bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> -	return map_info.id;
> -}
> -
> -/* trigger the leader program on a cpu */
> -static inline int bperf_trigger_reading(int prog_fd, int cpu)
> -{
> -	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> -			    .ctx_in = NULL,
> -			    .ctx_size_in = 0,
> -			    .flags = BPF_F_TEST_RUN_ON_CPU,
> -			    .cpu = cpu,
> -			    .retval = 0,
> -		);
> -
> -	return bpf_prog_test_run_opts(prog_fd, &opts);
> -}
> -
>  #endif /* __PERF_BPF_COUNTER_H */
> -- 
> 2.39.0.314.g84b9a713c41-goog

-- 

- Arnaldo
