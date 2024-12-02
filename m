Return-Path: <bpf+bounces-45957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE4F9E0ED5
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 23:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F067B283F4
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 22:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE331DF960;
	Mon,  2 Dec 2024 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXcBzXPX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA641DA103;
	Mon,  2 Dec 2024 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176939; cv=none; b=Nddd7B5pNR5ddRJyyx+C82aP4/P2QOgs4HKCLsWhL6m/ZKe4lefRd2zza4bHtbVPIAbEVsR1gVWl7Cka3IcCi6f23yzGrf7esxzeeBanMBQwNqZyzyebinzotPyGl8ceqgKaZng33miIFdQfYM9VKpF2WUs0uN6gfxMWOcAxCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176939; c=relaxed/simple;
	bh=BgRpjY7BC7q4xN3V+4faL6OopzCSu02L2UVZ++G5pL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQiLdyYCY469BOCKSpe7JMdZzIpC6lHAuu4tqZXfYZhsKrP7nEKBSWCWf6VUoU3rYjuXgcjUwLPqhmI8qXVuVgIVgt+4rUmTpsRgav6iKGsQKXPxTD1y077c89PoJkqgem55GiYPTUB1QoxQr0WOCHV/LurYHMWruMZUnstBI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXcBzXPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF0DC4CED1;
	Mon,  2 Dec 2024 22:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733176939;
	bh=BgRpjY7BC7q4xN3V+4faL6OopzCSu02L2UVZ++G5pL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXcBzXPXkMrEi7/qxQ92iL8uL9zfW4Zul0hYwlTceeWq6SmcioR0UbW7QlQgpYk0o
	 /ChsC72XdqUxD7IUNgApSmwsm3S4HEcZ3bqyZ8woSSjQzRy/PaG06Tp3xcqfiWl/gb
	 yEmG4zybtiuzhZRGbpQTNglK1Idm9BLJOIEDisiM32eoYnXiedADIqvLjYQ+PiEo1L
	 go4MLjuMgQwXtwu5ghoThHe0K4k3VKCYaB979TQrf5I50mlcXs8kbvcz/xfHHCDM8/
	 CdI6Jrreh3tQXZRG5Av0OM7x45MC1jC60h6d1A6WS+6zP/CGIUWGf+hdDW7Y/mLWGr
	 NzubDmrw7mIcA==
Date: Mon, 2 Dec 2024 14:02:17 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@linaro.org,
	yangyicong@hisilicon.com, song@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 3/3] perf bpf: Fix two memory leakages when calling
 perf_env__insert_bpf_prog_info()
Message-ID: <Z04uaWQxI3LXfAtg@google.com>
References: <20241128125432.2748981-1-quic_zhonhan@quicinc.com>
 <20241128125432.2748981-4-quic_zhonhan@quicinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128125432.2748981-4-quic_zhonhan@quicinc.com>

Hello,

On Thu, Nov 28, 2024 at 08:54:32PM +0800, Zhongqiu Han wrote:
> If perf_env__insert_bpf_prog_info() returns false due to a duplicate bpf
> prog info node insertion, the temporary info_node and info_linear memory
> will leak. Add a check to ensure the memory is freed if the function
> returns false.
> 
> Fixes: 9c51f8788b5d ("perf env: Avoid recursively taking env->bpf_progs.lock")
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> ---
>  tools/perf/util/bpf-event.c | 10 ++++++++--
>  tools/perf/util/env.c       |  7 +++++--
>  tools/perf/util/env.h       |  2 +-
>  3 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 13608237c50e..c81444059ad0 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -289,7 +289,10 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
>  		}
>  
>  		info_node->info_linear = info_linear;
> -		perf_env__insert_bpf_prog_info(env, info_node);
> +		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
> +			free(info_linear);
> +			free(info_node);
> +		}
>  		info_linear = NULL;
>  
>  		/*
> @@ -480,7 +483,10 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
>  	info_node = malloc(sizeof(struct bpf_prog_info_node));
>  	if (info_node) {
>  		info_node->info_linear = info_linear;
> -		perf_env__insert_bpf_prog_info(env, info_node);
> +		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
> +			free(info_linear);
> +			free(info_node);
> +		}
>  	} else
>  		free(info_linear);
>  
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index d7865ae5f8f5..38401a289c24 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -24,12 +24,15 @@ struct perf_env perf_env;
>  #include "bpf-utils.h"
>  #include <bpf/libbpf.h>
>  
> -void perf_env__insert_bpf_prog_info(struct perf_env *env,
> +bool perf_env__insert_bpf_prog_info(struct perf_env *env,
>  				    struct bpf_prog_info_node *info_node)
>  {
> +	bool ret = true;

Please add a blank line between declaration and the other statements.
Also I think you can just use the return value of the internal function
instead of initializaing it to true.

Thanks,
Namhyung


>  	down_write(&env->bpf_progs.lock);
> -	__perf_env__insert_bpf_prog_info(env, info_node);
> +	if (!__perf_env__insert_bpf_prog_info(env, info_node))
> +		ret = false;
>  	up_write(&env->bpf_progs.lock);
> +	return ret;
>  }
>  
>  bool __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info_node *info_node)
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 9db2e5a625ed..da11add761d0 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -178,7 +178,7 @@ int perf_env__nr_cpus_avail(struct perf_env *env);
>  void perf_env__init(struct perf_env *env);
>  bool __perf_env__insert_bpf_prog_info(struct perf_env *env,
>  				      struct bpf_prog_info_node *info_node);
> -void perf_env__insert_bpf_prog_info(struct perf_env *env,
> +bool perf_env__insert_bpf_prog_info(struct perf_env *env,
>  				    struct bpf_prog_info_node *info_node);
>  struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
>  							__u32 prog_id);
> -- 
> 2.25.1
> 

