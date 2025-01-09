Return-Path: <bpf+bounces-48435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F6BA08010
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 19:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E473C3A6E7E
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 18:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C27B19E7F8;
	Thu,  9 Jan 2025 18:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMAKn4yU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9E4BA2D;
	Thu,  9 Jan 2025 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448397; cv=none; b=ADnzl2R+sEVtCyOFfwaS5vMuaiVPmqJs3hjhX/mBBnUTD3sYl6VWM3K344BRPr2mwxQgEQwZWLa/WMhPsJujQ1Gw43JwXA0U/WBWcnZ+o5VH1dlPf4HafH03FI7JJfTgrzcZH5bLvHY7GDwb4o7/1m0tG/+R4XWFxzG9++FtNwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448397; c=relaxed/simple;
	bh=Q730T9l0V3HidIqfh/bUj1eA3JwApgsyq6x0VOp6rXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNoLJTClVPFV5FOX96LglQYXik5X/54hzwGUWXQvDfC/kK2rfB8a05kFqygXIJc06HUCSHqQQc2JSfBjm4CGbCvSjwLhMp3BJwNw+89nIuqWEGrn99FdzYayeZKwUI8KWVlPlm4S8TZD5C5cqdiQgmZuzd1d0snWRNcEClBAZIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMAKn4yU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F83C4CED2;
	Thu,  9 Jan 2025 18:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736448396;
	bh=Q730T9l0V3HidIqfh/bUj1eA3JwApgsyq6x0VOp6rXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMAKn4yUFLNHvBhAbM/GXyl7HUfj8QSWLsrHMT848IjZagrx5dIzQMHyykCLs7IWT
	 ssSgkCKWsiunZN3t4VmwZ2f4hfQ+g/PfpAUXGo6OwMG6D4chxO+BUK5bWNdkZLCIu5
	 aa6W/It3uaNGnop0ZgZ2p8kAeorXFfAITUf+ujRdSrT++YLTGrYE9BQvlaVnQhAofu
	 ROihJ5IkrU3tNmGbL29r49BHYQZxVIp8U5HRKyRdq8m6loGkQBfgEC91eU45WtTFBC
	 EaMaYTePYEi+ZbdRi6jLRl46ujOQHoDlcz6O5jTgQTE4ZpMvSgemIXN5b+wbBPELyG
	 WdA37wmMDuxEw==
Date: Thu, 9 Jan 2025 15:46:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH] perf trace: Fix unaligned access for augmented args
Message-ID: <Z4AZiTNhI9qKGYh3@x1>
References: <20250102201248.790841-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102201248.790841-1-namhyung@kernel.org>

On Thu, Jan 02, 2025 at 12:12:47PM -0800, Namhyung Kim wrote:
> Some version of compilers reported unaligned accesses in perf trace when
> undefined-behavior sanitizer is on.  I found that it uses raw data in the
> sample directly and assuming it's properly aligned.
> 
> Unlike other sample fields, the raw data is not 8-byte aligned because
> there's a size field (u32) before the actual data.  So I added a static
> buffer in syscall__augmented_args() and return it instead.  This is not
> ideal but should work well as perf trace is single-threaded.
> 
> A better approach would be aligning the raw data by adding a 4-byte data
> before the augmented args but I'm afraid it'd break the backward
> compatibility.
 
You mean for 'perf trace record' files?

Older tools will not be able to process new files, while old files will
be remain processable by new tools if we insert a u32 with zeroes before
the size field, that way if the first u32 is not zero, we do as you do
below and incur the cost of copying to that intermediary buffer,
otherwise we read the real size in the next u32 and don't incur the cost
of copying.

Your fix below works as it incurs the cost all the time, which is ok for
now, but as a follow up patch we can see if the approach I described
above works.

Applying.

- Arnaldo

> Closes: https://lore.kernel.org/r/Z2STgyD1p456Qqhg@google.com
> Cc: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-trace.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index e70e634fbfaf33f5..3f06411514c5b58a 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2582,7 +2582,6 @@ static int trace__fprintf_sample(struct trace *trace, struct evsel *evsel,
>  
>  static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sample, int *augmented_args_size, int raw_augmented_args_size)
>  {
> -	void *augmented_args = NULL;
>  	/*
>  	 * For now with BPF raw_augmented we hook into raw_syscalls:sys_enter
>  	 * and there we get all 6 syscall args plus the tracepoint common fields
> @@ -2600,10 +2599,24 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
>  	int args_size = raw_augmented_args_size ?: sc->args_size;
>  
>  	*augmented_args_size = sample->raw_size - args_size;
> -	if (*augmented_args_size > 0)
> -		augmented_args = sample->raw_data + args_size;
> +	if (*augmented_args_size > 0) {
> +		static uintptr_t argbuf[1024]; /* assuming single-threaded */
> +
> +		if ((size_t)(*augmented_args_size) > sizeof(argbuf))
> +			return NULL;
> +
> +		/*
> +		 * The perf ring-buffer is 8-byte aligned but sample->raw_data
> +		 * is not because it's preceded by u32 size.  Later, beautifier
> +		 * will use the augmented args with stricter alignments like in
> +		 * some struct.  To make sure it's aligned, let's copy the args
> +		 * into a static buffer as it's single-threaded for now.
> +		 */
> +		memcpy(argbuf, sample->raw_data + args_size, *augmented_args_size);
>  
> -	return augmented_args;
> +		return argbuf;
> +	}
> +	return NULL;
>  }
>  
>  static void syscall__exit(struct syscall *sc)
> -- 
> 2.47.1.613.gc27f4b7a9f-goog

