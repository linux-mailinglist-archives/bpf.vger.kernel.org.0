Return-Path: <bpf+bounces-59410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D863BAC9ABB
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 13:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DDB67A70A8
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 11:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A9323BCE4;
	Sat, 31 May 2025 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXY4APr8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A82237163;
	Sat, 31 May 2025 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748691917; cv=none; b=Ey9QKwY6MPopDg6rvUmfPilNGXqKimdMMzukPNoH58gc1vMz42HL22Y9TshBODEIUX4OfG5T2sQO88psePDD5QkGbFfJd1uS+hTx4fGvG+7oVQdBuACGVSUvWxtgpHrd5truAwYvagyxCTe6+Oix/AHI9GHeKnHqjPl4wuW83T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748691917; c=relaxed/simple;
	bh=DjXMkjtM4ppbS/skmByM816vF5rWXU+Al3ViHaB6/Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdcOhIxDWzlZ1+PmPE5LO+k61059M8EfDRBZmKfzWH5usi5D+e9fod++WHWoL81Z7Lo8EmIzyn0MkJ+LVDIpzX73pCAwbpVKfk0rifQMs0FNH9cnFBmQuM+HhGJEG/Y0ANIVpvfINEeWn8mIZsXzrK6bPCM/xmh6Aii0gkrJ+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXY4APr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6435EC4CEE3;
	Sat, 31 May 2025 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748691914;
	bh=DjXMkjtM4ppbS/skmByM816vF5rWXU+Al3ViHaB6/Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXY4APr8Hr1Hfl4lGe6RS+LXTv7fXAGtkFCyhSpcb4cWIm106bGW8KbmZqtgm7IKF
	 lary8+pGSqI8B7nWlvvmv4Am3kyJ6sEHxT+HWn8JPAwZHIit4BdSNoS/MaCB983oXh
	 t1T18gd+p8anH66a8JsRyJOTVsl7T8+hJMAht+Fm+pnaPObpNIdkZKN3u/Fpp3yoE9
	 dQGPgu0GcwEfI+qOZP9YSaV/036KANtzdI6b9shFB578MzgCsyRO6/Usuvdln5iElz
	 rT4EUnatU8KEPcXyBmcl3bCjSW9k6lwoDvm1YUJnDfzwP6BAOPshRdQ/vbOONGv9Pz
	 D3LuQW01qsxzw==
Date: Sat, 31 May 2025 08:45:11 -0300
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
Message-ID: <aDrrxwPcSslAFnpb@x1>
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



Thanks, applied to perf-tools-next,

- Arnaldo

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
>  	tmp = realloc(delays, (nr_delays + 1) * sizeof(*delays));
>  	if (tmp == NULL) {
>  		pr_err("Memory allocation failure\n");
> -- 
> 2.49.0.1101.gccaa498523-goog

