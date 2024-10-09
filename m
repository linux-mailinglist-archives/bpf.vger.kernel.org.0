Return-Path: <bpf+bounces-41352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE31995EE6
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 07:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E10C1C21BD1
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 05:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F71156653;
	Wed,  9 Oct 2024 05:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE7xGdQT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD501487CD;
	Wed,  9 Oct 2024 05:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728451220; cv=none; b=upgw/jbtX2s9pDdyJS3KS4CLp6CazypvwU615UZF/JCNAWGwz6X2qva+6p+T8TNUJ6FYr5FyOKuC2cMvB8DCUCMoSrM0CrDTxpLBDUJ2Qz5JleR8RsT65UJ8sOUab4hRndR9HyZ4DUmqql4qwUa68MK5nUo3GPWCsi56ddXw07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728451220; c=relaxed/simple;
	bh=VxkKoSpTbpvGNKlMYZPv7Q6sgZUtEUe7QAwtUYKL8o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/YNp4gnnXWSkS2l8/wwEsW+XvYv5WuxXLd2p/wHv8Z88MNL5Ci2hln1vIBX1vshoiXSVEGFcqnm2KOblv1HnUrjt5eyQ+RVjt2dodxa66opbP5T9UoBvi13cSJWzbW4s6qIgcSdPqsNCbzNj0VFhAm0Gu2hQDUUFFLUimY9yNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KE7xGdQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC86C4CEC5;
	Wed,  9 Oct 2024 05:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728451218;
	bh=VxkKoSpTbpvGNKlMYZPv7Q6sgZUtEUe7QAwtUYKL8o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KE7xGdQThy8JWe8Y2HOUeRN7zjewaMYrR6Kl7SP71VnTfzxv2XAKyoiZM1lwrunpY
	 xl41vkUDjjmMjAcjAOgBNYVuvofzbxI0gDRjsBRLDP9t0jmiOBw3g8777ZgSqCUhYg
	 pv83DLTBbdrqf/hwi9i77+QtATpKsFNPmHzxdjeBJP43spwGidUyDQ98at5367SzgA
	 vGRM5eBsAdkGJF6VBAam3a3SROSmEx7qhBeWegtZw7vB8JUgy4/yJprLXY+Yyji335
	 Wb1eUZx2r6wNv5gi2vTJGaJmdJXXmJ1aWFDsmn6xxo3a+x5Y+NMYIRUPEO4+I55GrX
	 CnGcSes16ZqXQ==
Date: Tue, 8 Oct 2024 22:20:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, song@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH -next 0/2] perf stat: a set of small fixes for bperf
Message-ID: <ZwYSkJqKRmB5NXrx@google.com>
References: <20240925135523.367957-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240925135523.367957-1-wutengda@huaweicloud.com>

Hello,

On Wed, Sep 25, 2024 at 01:55:21PM +0000, Tengda Wu wrote:
> Hi,
> 
> This is a set of small fixes for bperf (perf-stat --bpf-counters).
> 
> It aims to fix the following two issues:
>   1) bperf limited the number of events to a maximum of 16, which
>      caused failures in some scenarios and lacked friendly prompts. 
>   2) bperf failed to correctly handle whether events were supported,
>      resulting in the incorrect display when the event count was 0.
> 
> The reason for fixing these issues is that bperf is very useful in
> some cost-sensitive scenarios, such as top-down analysis scenarios.
> Increasing the attr map size can allow these scenarios to collect
> more events at the same time, making it possible to gather enough
> information to perform complex metric calculations in top-down.

So I tried this patchset and found a couple of issues.

1. Running bperf failed due to perf_event_attr map locking issue.
   It seems that the message is misleading since it didn't to get the
   lock actually.  I think it failed the map is not compatible anymore
   and the error message should say about that.

2. It seems bperf keeps the map pinned in the file system.  I'm not sure
   if we have an option to unpin the map automatically.  I had to find
   the path and delete it manually.

3. Currently bperf doesn't support event groups.  On Intel machines,
   topdown metrics are enabled by default and it makes the perf stat
   failing when --bpf-counters option is used (after the step 2).

    $ sudo ./perf stat -a --bpf-counters true
    bpf managed perf events do not yet support groups.

   Maybe we need to drop the topdown metrics when bperf fails.

Thanks,
Namhyung

> 
> Thanks,
> Tengda
> 
> Tengda Wu (2):
>   perf stat: Increase perf_attr_map entries
>   perf stat: Fix incorrect display of bperf when event count is 0
> 
>  tools/lib/perf/include/perf/bpf_perf.h |  1 +
>  tools/perf/util/bpf_counter.c          | 26 +++++++++++++++++---------
>  2 files changed, 18 insertions(+), 9 deletions(-)
> 
> -- 
> 2.34.1
> 

