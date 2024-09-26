Return-Path: <bpf+bounces-40331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CB0986B75
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 05:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68302B22069
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 03:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DE9176AD7;
	Thu, 26 Sep 2024 03:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thfJ5wd4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFD8170A0B;
	Thu, 26 Sep 2024 03:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727322233; cv=none; b=YMjQOpueDD9OHNzJ7wct4ZIXn47YHp+6KuRGWKDSHKwRb537k03k44uoXSBnOhzoo5IZx+gTDFRzxw27KlmRIwyYggV+o2cvPr8kKEYspnTrqMTItVewsrgEH1tb5ajNXQDxHr9RMH/DoACdsNXa52Kwox1rjT+iE9+zoM7eaOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727322233; c=relaxed/simple;
	bh=YdpuSZx/xJqb9wHYzeVQI0farEuF4nbcZ4eWalvjt+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ksht5eJO6fdFro7X9m5XyG0pwyapevdf87CwTentAG3Ni/pfiekNfgPIU3ucx9WtFOfl7OFdFrNdnp93TqeyhFb4ohS22hjrcY3gFmKcEQtvAHq4oQITuf7xWTzElDRPXQg5QD1WVX6F6H7Ep+38vK9QvoVa+tBhoYpqi0O6V+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thfJ5wd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FF3C4CEC5;
	Thu, 26 Sep 2024 03:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727322232;
	bh=YdpuSZx/xJqb9wHYzeVQI0farEuF4nbcZ4eWalvjt+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thfJ5wd48eCquzU2CnWNJ48oVTt+Sa93xcbR+FuL5a9kXgKMnMBn6eyWDqASzSRz7
	 tNknjivlFc83fef089UJIStnHen9VsdwaOEQEthikH7HIXRc2LKhbdTy952/7/xtkw
	 quwqDM6oJQiVJPOtaOOBRixcVdzq+gHZUR8oY9/JXdzKVHGu1GZ0kzrWtQCyacn8W7
	 4ryrVEwqz3GgxoWOd7/g2qwKXMP1fQUKu6v+B5N/d+cH+nF5btCxNPDSfWZP8e+WeA
	 mpOTDUR+1CIRmPyTluujmfD4QZr0ktlpQHiBciafXw9OgH9vq4AY0BO+x1Qv4dKG+w
	 ClqfZQMxQlPfQ==
Date: Wed, 25 Sep 2024 20:43:50 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>, song@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH -next v3 0/2] perf stat: Support inherit events for bperf
Message-ID: <ZvTYduigMBtlmNbK@google.com>
References: <20240916014318.267709-1-wutengda@huaweicloud.com>
 <729eef63-6aed-44db-b18a-eb4bf96aeaab@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <729eef63-6aed-44db-b18a-eb4bf96aeaab@huaweicloud.com>

Hello,

On Wed, Sep 25, 2024 at 10:16:16PM +0800, Tengda Wu wrote:
> Hello,
> 
> Sorry for pinging again. Is there any other suggestion with this patch set?
> If there is, please let me know.

Sorry I was traveling last week.  I think it's good now.

Song, can I get your ack?

Thanks,
Namhyung

> 
> On 2024/9/16 9:43, Tengda Wu wrote:
> > Hi,
> > 
> > Here is the 3th version of the series to support inherit events for bperf.
> > This version add pid or tgid selection based on filter type in new_task
> > prog to avoid memory waste and potential count loss.
> > 
> > 
> > bperf (perf-stat --bpf-counter) has not supported inherit events
> > during fork() since it was first introduced.
> > 
> > This patch series tries to add this support by:
> >  1) adding two new bpf programs to monitor task lifecycle;
> >  2) recording new tasks in the filter map dynamically;
> >  3) reusing `accum_key` of parent task for new tasks.
> > 
> > Thanks,
> > Tengda
> > 
> > 
> > Changelog:
> > ---------
> > v3: (Address comments from Namhyung, thanks)
> >  * Use pid or tgid based on filter type in new_task prog
> >  * Add comments to explain pid usage for TGID type in exit_task prog
> > 
> > v2: https://lore.kernel.org/all/20240905115918.772234-1-wutengda@huaweicloud.com/
> >  * Remove the unused init_filter_entries in follower bpf, declare
> >    a global filter_entry_count in bpf_counter instead
> >  * Attach on_newtask and on_exittask progs only if the filter type
> >    is either PID or TGID
> > 
> > v1: https://lore.kernel.org/all/20240904123103.732507-1-wutengda@huaweicloud.com/
> > 
> > 
> > Tengda Wu (2):
> >   perf stat: Support inherit events during fork() for bperf
> >   perf test: Use sqrtloop workload to test bperf event
> > 
> >  tools/perf/tests/shell/stat_bpf_counters.sh   |  2 +-
> >  tools/perf/util/bpf_counter.c                 | 32 +++++--
> >  tools/perf/util/bpf_skel/bperf_follower.bpf.c | 87 +++++++++++++++++--
> >  tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
> >  4 files changed, 112 insertions(+), 14 deletions(-)
> > 
> 

