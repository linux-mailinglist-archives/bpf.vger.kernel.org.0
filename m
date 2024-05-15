Return-Path: <bpf+bounces-29747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E868C6340
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 11:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBE61C2121F
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 09:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD31157CB6;
	Wed, 15 May 2024 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kheFWwti"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6451A57CB5;
	Wed, 15 May 2024 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763491; cv=none; b=n5N0eqXbM/UHpsr5QnF/f6M3p9SsFKDqf70esQkSiwx0lq4QXkVPaVhAGm0uk9B3NT+XLkF9qoVaGnyKMi/UXA7fsRL55b4Sq2AfFXcuQ3wMZa4agSZ5UzYsDvU4VwXfB1X9WbH2oiksKmzBr32gXm4tqU4fTsZ6FlBJ7K0eooM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763491; c=relaxed/simple;
	bh=WxhNVJglXJ6bifS2+W6QqNp4SxMw1w+StWa+9MJ2u70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7m0DlJybF+13Mkik/nvrFCwf1k0kHQ1bj8xtnlTSSO3tKNkcifU1VH37c74E/Ri4tjQEjNVWB/VwSCTM/0jINsen5qzfbV44I7xNdU8ya+vBxvD1glC+XAPNZX/WAR/i+AUe0jHAWfDGjZOcC3J+R4YooXm0VfR1SHLEVpNiwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kheFWwti; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LN7R/89hFiNKE7ZDOsR+E6btUpw/DgQgLlnRJEQx8kQ=; b=kheFWwtiLwToB5Ja8OlBP3jaYi
	SxjYf45I3t5MbVXsSY+sz/7hLX9h2KLp6ECp9lF8CYolkN4XWvsTR6cAbTdRZUpJS1Ul9BpH8u+YH
	WR6Y9QZrSal5bja3nzexsfK/KnHnhkaJZbYfbAxrSsR/V9Bps1TvjMcXWYT8Ttqq8gUbYFKwLCNzD
	7aNOlg0i9qUOpFyfJ/aZVuUGfaZfe/tx3EYZREXNwV7W1kfxgyRcdhsQXj0f0Rb2gxEQ7aCR+JBg4
	pKNc8bzj6i6hPoASUbsJ2Wph9rqz8jgtv9c4czJiyRfm8wSAeFjoVMQ4k8wsdIiV4IPCh0Ks6UU74
	9H2Wt0dg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7ASR-0000000A8iI-3U4k;
	Wed, 15 May 2024 08:57:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 62178301105; Wed, 15 May 2024 10:57:55 +0200 (CEST)
Date: Wed, 15 May 2024 10:57:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yabin Cui <yabinc@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 1/3] perf/core: Save raw sample data conditionally
 based on sample type
Message-ID: <20240515085755.GC40213@noisy.programming.kicks-ass.net>
References: <20240510191423.2297538-1-yabinc@google.com>
 <20240510191423.2297538-2-yabinc@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510191423.2297538-2-yabinc@google.com>

On Fri, May 10, 2024 at 12:14:21PM -0700, Yabin Cui wrote:

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d2a15c0c6f8a..9fc55193ff99 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1240,12 +1240,16 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
>  }
>  
>  static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
> +					     struct perf_event *event,
>  					     struct perf_raw_record *raw)
>  {
>  	struct perf_raw_frag *frag = &raw->frag;
>  	u32 sum = 0;
>  	int size;
>  
> +	if (!(event->attr.sample_type & PERF_SAMPLE_RAW))
> +		return;
> +

Should we add something like:

	if (WARN_ON_ONCE(data->sample_flags & PERF_SAMPLE_RAW))
		return;

? And I suppose the same for all these other patches.

>  	do {
>  		sum += frag->size;
>  		if (perf_raw_frag_last(frag))



