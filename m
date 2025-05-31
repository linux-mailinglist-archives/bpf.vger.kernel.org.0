Return-Path: <bpf+bounces-59411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B65AAC9ABC
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 13:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD24F189C6CD
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 11:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F0023BCE4;
	Sat, 31 May 2025 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEigLghs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D7EEAD0;
	Sat, 31 May 2025 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748692164; cv=none; b=Ii9n6bzo6d8qnronXd9lR8SHD7/Az7o6X0LKsZyVFJYtXb/fwOozhEl5EeyLLuI8JFg7l9tm518L9adqNDDIb1lMyp2/s8NHzNm3EznIJgi9eGbTdJ7vbTgDeWO/+5oY5uyyYg8Cg1pLMEnLz6+uEbFnGFxp4LUlrTySmJhOWfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748692164; c=relaxed/simple;
	bh=Af8HaQZyJpqo1jRB+/Ioz25AGaCCmNcBiYyroVixhYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+HkHKSF+8/uv2ms2cs5kv1DSgnnEjN0p0DBd8LWEjx/SpIWv0jSb53Nl0QgA498eIW2Zp8HNfne6pNPjhrxJXvUbv+he5mi2Q9o5a7XN68AqGsJNpcMhGdoTQRt407WEWpbcKA9F5678cQ8i1VlNQUpCYSPshSvqaI5wxolC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEigLghs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B02C4CEE3;
	Sat, 31 May 2025 11:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748692163;
	bh=Af8HaQZyJpqo1jRB+/Ioz25AGaCCmNcBiYyroVixhYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEigLghsEjebwnfmaWzIZ5IRtT/hfObwzEXTQ8Xrf0NraDdI9BxKvVpEfIRfyUKdI
	 /0xMCqtgKeTXOhGTsfqWy6U77gaq7n/52DNBUj64UXLWv3FoA6T+wyAqc8NmFlDeAp
	 rSxIV3jPteD9etdKv1FXVOxb4+SG3mgbqLWQq89MEJp80szksXbTpaYPaillKbAHJf
	 CriapOSmozuODEWbfG6yj+LIbcnSiuha19aZeePhoLsBFUeT2ees550idWHrMxYyQE
	 0uPyDG5SRBdH2IS9EuxY5vMzU96opEP49UZs5FcBITe94bMqIWj9e3W8lXaxfu4wxO
	 uNfnL0PIRWbHg==
Date: Sat, 31 May 2025 08:49:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH] perf lock contention: Reject more than 10ms delays for
 safety
Message-ID: <aDrswP62_-fy3vUC@x1>
References: <20250515181042.555189-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515181042.555189-1-namhyung@kernel.org>

On Thu, May 15, 2025 at 11:10:42AM -0700, Namhyung Kim wrote:
> Delaying kernel operations can be dangerous and the kernel may kill
> (non-sleepable) BPF programs running for long in the future.
> 
> Limit the max delay to 10ms and update the document about it.
> 
>   $ sudo ./perf lock con -abl -J 100000us@cgroup_mutex true
>   lock delay is too long: 100000us (> 10ms)
> 
>    Usage: perf lock contention [<options>]
> 
>       -J, --inject-delay <TIME@FUNC>
>                             Inject delays to specific locks
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-lock.txt | 8 ++++++--
>  tools/perf/builtin-lock.c              | 5 +++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> index 2d9aecf630422aa6..c17b3e318169f9dc 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -224,8 +224,12 @@ CONTENTION OPTIONS
>  	only with -b/--use-bpf.
>  
>  	The 'time' is specified in nsec but it can have a unit suffix.  Available
> -	units are "ms" and "us".  Note that it will busy-wait after it gets the
> -	lock.  Please use it at your own risk.
> +	units are "ms", "us" and "ns".  Currently it accepts up to 10ms of delays
> +	for safety reasons.
> +
> +	Note that it will busy-wait after it gets the lock. Delaying locks can
> +	have significant consequences including potential kernel crashes.  Please
> +	use it at your own risk.
>  
>  
>  SEE ALSO
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 41f6f3d2b779b986..3b3ade7a39cad01f 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2537,6 +2537,11 @@ static bool add_lock_delay(char *spec)
>  		return false;
>  	}
>  
> +	if (duration > 10 * 1000 * 1000) {
> +		pr_err("lock delay is too long: %s (> 10ms)\n", spec);
> +		return false;
> +	}
> +

Please consider to replace those 1000 * 1000 her and in other places
with NSEC_PER_MSEC in a followup patch for the next merge window.

- Arnaldo

>  	tmp = realloc(delays, (nr_delays + 1) * sizeof(*delays));
>  	if (tmp == NULL) {
>  		pr_err("Memory allocation failure\n");
> -- 
> 2.49.0.1101.gccaa498523-goog

