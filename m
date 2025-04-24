Return-Path: <bpf+bounces-56644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38E9A9B9F2
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 23:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A2F3B2D0E
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 21:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87FA221FA6;
	Thu, 24 Apr 2025 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlH2uCVt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053E1EDA35;
	Thu, 24 Apr 2025 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530515; cv=none; b=n7e2bBjsnFf+qEd6AcLnqdLpDLNMwMCdlrpUmPD5S/R6AGJsUjLcqqv4Om9i4BiSQylRxSt+gEfO2iacKpAQWb6mjcWiDIq5hlkDpMAzSWrDK0kbrvTPkZ0Z0XV+bHj+HQ5emzQrMu0XEy2kl5tfaXWrha5PM824oR4ay/rRvBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530515; c=relaxed/simple;
	bh=PrKkYRIlJvWKFYZLmBouuUGmii3H5YdNfIXLlJe7XtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6YoT17StGuRq38Zfio+wQXGqtnjMXIV79gJw6Mc+sOYvehGGdzKqRreTc//74XdyU8P/vIaqKpIyPrKD12ZtRIY22lLgox1hy447jtBcenn0GzaRtcS9vYMAwgXQDSfac3PvojYmV/vFvZjlIEVtGO9FZHMdxJ1nHeHtE3c7fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlH2uCVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33505C4CEE3;
	Thu, 24 Apr 2025 21:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530514;
	bh=PrKkYRIlJvWKFYZLmBouuUGmii3H5YdNfIXLlJe7XtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HlH2uCVtbAaYIeTfClE3ZdZYv2SBl4wO/cVxZBShZrgUrvToaxWkzEaUqEgvj/ORV
	 gprqxHogthQhrIPwDzRUR6602qSvGwEs4cL9rnxPE+LuCC2RNbtqBnprpnrDGD6aRd
	 mhYK8UC1gWppjllQEmyjcsG/JpqSxa+HDTkTQb14Qk206r9wgq6r0uXPOQJZkHyB4K
	 49S9+7xJWfCqc2S1TOZUG1XbbUKNQDPttR8mLAjHhIe+oIdIMXhEjDI+3Okk9tSq8m
	 4Z5jiJdMAn1xVIugT3N3ibi4/tljj5tU4JxpPyUOKUKekJhg8fevI/6DE2HDECLK6G
	 yed/q1anDYnww==
Date: Thu, 24 Apr 2025 18:35:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Xu Yang <xu.yang_2@nxp.com>, Tengda Wu <wutengda@huaweicloud.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 06/12] perf record: Switch user option to use BPF
 filter
Message-ID: <aAquj31djneyTwLG@x1>
References: <20250410173631.1713627-1-irogers@google.com>
 <20250410173631.1713627-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410173631.1713627-7-irogers@google.com>

On Thu, Apr 10, 2025 at 10:36:25AM -0700, Ian Rogers wrote:
> Finding user processes by scanning /proc is inherently racy and
> results in perf_event_open failures. Use a BPF filter to drop samples
> where the uid doesn't match. Ensure adding the BPF filter forces
> system-wide.

Since the BPF filter is not introduced in this patch, can you please
provide, in the commit log message or in the patch itself, some
commentary as to how this is accomplished thru a BPF filter?

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ba20bf7c011d..202c917fd122 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -173,6 +173,7 @@ struct record {
>  	bool			timestamp_boundary;
>  	bool			off_cpu;
>  	const char		*filter_action;
> +	const char		*uid_str;
>  	struct switch_output	switch_output;
>  	unsigned long long	samples;
>  	unsigned long		output_max_size;	/* = 0: unlimited */
> @@ -3460,8 +3461,7 @@ static struct option __record_options[] = {
>  		     "or ranges of time to enable events e.g. '-D 10-20,30-40'",
>  		     record__parse_event_enable_time),
>  	OPT_BOOLEAN(0, "kcore", &record.opts.kcore, "copy /proc/kcore"),
> -	OPT_STRING('u', "uid", &record.opts.target.uid_str, "user",
> -		   "user to profile"),
> +	OPT_STRING('u', "uid", &record.uid_str, "user", "user to profile"),
>  
>  	OPT_CALLBACK_NOOPT('b', "branch-any", &record.opts.branch_stack,
>  		     "branch any", "sample any taken branches",
> @@ -4196,19 +4196,24 @@ int cmd_record(int argc, const char **argv)
>  		ui__warning("%s\n", errbuf);
>  	}
>  
> -	err = target__parse_uid(&rec->opts.target);
> -	if (err) {
> -		int saved_errno = errno;
> +	if (rec->uid_str) {
> +		uid_t uid = parse_uid(rec->uid_str);
>  
> -		target__strerror(&rec->opts.target, err, errbuf, BUFSIZ);
> -		ui__error("%s", errbuf);
> +		if (uid == UINT_MAX) {
> +			ui__error("Invalid User: %s", rec->uid_str);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +		err = parse_uid_filter(rec->evlist, uid);
> +		if (err)
> +			goto out;
>  
> -		err = -saved_errno;
> -		goto out;
> +		/* User ID filtering implies system wide. */
> +		rec->opts.target.system_wide = true;
>  	}
>  
> -	/* Enable ignoring missing threads when -u/-p option is defined. */
> -	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
> +	/* Enable ignoring missing threads when -p option is defined. */
> +	rec->opts.ignore_missing_thread = rec->opts.target.pid;
>  
>  	evlist__warn_user_requested_cpus(rec->evlist, rec->opts.target.cpu_list);
>  
> -- 
> 2.49.0.604.gff1f9ca942-goog

