Return-Path: <bpf+bounces-51475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7040FA3522C
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 028E87A38F2
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 23:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E7222D7B3;
	Thu, 13 Feb 2025 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBnbq6ax"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF712753F5;
	Thu, 13 Feb 2025 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739489297; cv=none; b=PE+PNrlAwgcXXvic/zB+Xl68uiiXeqvO+ceXXDqSLRAi8NwSEboJ8PgiIMc6/tql0VSmOR9eRm4GbmBhNM8yj2wbg1jeIT+SVHqI2lrbX89jNDZAnQVuw2MphZlGAUuC/CoOip2UjfKZ7XCBrPSUNH5yMTqmHHJXl1xHWcPmT4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739489297; c=relaxed/simple;
	bh=1hpRD32+oTSKw4Be5mPLXZd2/5+RD6HWdyhv83wdPbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOVzVhEINGKW7L1IrFN8UL4Am4owZMjPUsSvWDhfDlxX/C5UEtP7psHqTxDyTomXERfpI6MrkZifxBuOC3EztpR6c6CMqZDnSw77fENJOS5YCG+sZoV81Xyrh/TMxu1z7PRA9vTOzM5Fca/d+LUGD96F2c3UR0RuvxFmkVeewcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBnbq6ax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B44C4CED1;
	Thu, 13 Feb 2025 23:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739489295;
	bh=1hpRD32+oTSKw4Be5mPLXZd2/5+RD6HWdyhv83wdPbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBnbq6axyW2OpH9mMeOGuPD2s5C5ZVNFJFk/dL32chk4zb4ivQ3puaxIOWYgoE9j/
	 TgVEGIz3OwvM3laQ/nPEHYt4Oii8d4jzU6hB2pZJmoc4e+jrRKPnQsD7vXCEob6zxD
	 qr8dc8jge7yERe168JfcdswqqgErPWXOh7M8sRivDd8zag7J57qC2hbRRy/GPCwiji
	 ui+r/Sk3gyoSMnxuDGCGn0ylU4zb1g+5SuWfMw0gvOjtc+c9fv82S2fsLEWIi9nb+5
	 wF5yeuyAkSjzH3D3NJENDYSiCRF6VcnnmEIK7tj53ztpluvjk3nditqs5/2nR+gEOn
	 q/H6osl59cx9w==
Date: Thu, 13 Feb 2025 15:28:13 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v5 5/5] perf lock: Update documentation for -o option in
 contention mode
Message-ID: <Z66ADd48l6lJnQSt@google.com>
References: <20250212222859.2086080-1-ctshao@google.com>
 <20250212222859.2086080-6-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212222859.2086080-6-ctshao@google.com>

On Wed, Feb 12, 2025 at 02:24:56PM -0800, Chun-Tse Shao wrote:
> This patch also decouple -o with -t, and shows warning to notify the new
> behavior for -ov.

I think it's better to squash this commit to the previous.

> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/builtin-lock.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 3dc100cf30ef..e16bda6ce525 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1817,7 +1817,7 @@ static void print_contention_result(struct lock_contention *con)
>  			break;
>  	}
>  
> -	if (con->owner && con->save_callstack) {
> +	if (con->owner && con->save_callstack && verbose > 0) {
>  		struct rb_root root = RB_ROOT;
>  
>  		if (symbol_conf.field_sep)
> @@ -1978,6 +1978,11 @@ static int check_lock_contention_options(const struct option *options,
>  		}
>  	}
>  
> +	if (show_lock_owner && !show_thread_stats) {
> +		pr_warning("Now -o try to show owner's callstack instead of pid and comm.\n");
> +		pr_warning("Please use -t option too to keep the old behavior.\n");
> +	}
> +
>  	return 0;
>  }
>  
> @@ -2569,7 +2574,8 @@ int cmd_lock(int argc, const char **argv)
>  		     "Filter specific address/symbol of locks", parse_lock_addr),
>  	OPT_CALLBACK('S', "callstack-filter", NULL, "NAMES",
>  		     "Filter specific function in the callstack", parse_call_stack),
> -	OPT_BOOLEAN('o', "lock-owner", &show_lock_owner, "show lock owners instead of waiters"),
> +	OPT_BOOLEAN('o', "lock-owner", &show_lock_owner, "show lock owners instead of waiters.\n"
> +		"\t\t\tThis option can be combined with -t, which shows owner's per thread lock stats, or -v, which shows owner's stacktrace"),

I think this description should go to the man page and leave the option
as is.  You made it to show the warning when it's actually used.

Thanks,
Namhyung


>  	OPT_STRING_NOEMPTY('x', "field-separator", &symbol_conf.field_sep, "separator",
>  		   "print result in CSV format with custom separator"),
>  	OPT_BOOLEAN(0, "lock-cgroup", &show_lock_cgroups, "show lock stats by cgroup"),
> -- 
> 2.48.1.502.g6dc24dfdaf-goog
> 

