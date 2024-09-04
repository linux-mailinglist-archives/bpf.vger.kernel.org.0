Return-Path: <bpf+bounces-38877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A2C96BDF8
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 15:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120862876EE
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 13:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3B61DC07C;
	Wed,  4 Sep 2024 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4sUI+ig"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E121DC06C;
	Wed,  4 Sep 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455407; cv=none; b=l0c1zqYvYuueYxrQ3QLfInKRhDWR1dEh78b/y+kkZ0uYmqnjRN7r4xXrUBawaDdbpqCgy4pLx+02xuYiqJpsiz5HTAJEjF27G8SMzqNDAui3Oqmt1RABtulqBjV7ysXv8PAZ99n8yA7mVbt7mxvZlvyaU+kfp4v2adMkZ3w4e/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455407; c=relaxed/simple;
	bh=y7saYhhmY4HIH/NGyMHPeLYHWBqEunS8IquI7fd6Rk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4GbDo2k85tXooCzvxjcecWfij529z8jIrQUp1txtus+0oc3iHIX6pP+DYr4jMF8x24RUymJWHtloTwzKZpsdsxMebENuYsa9IaAv9rj+E2bYCGqSd8yOpcDGz3cnlwUQpV2R57cTwa+jmrQdW2CSCIGnx8ry0UQr3Qofg7XV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4sUI+ig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEF1C4CEC6;
	Wed,  4 Sep 2024 13:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725455407;
	bh=y7saYhhmY4HIH/NGyMHPeLYHWBqEunS8IquI7fd6Rk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4sUI+igb6bNlHUhmZUe1PoS8r3JD6x8Thr+invKaUAWEMl9sxSDlDpoZFSCxkt9A
	 51XSZ76cZUhpFBA5MRk4LQcbREF1MrCyEgpN1fO8AvxjHSnnE48lJK11MrWrjjcrl2
	 9sgUv/iw1MA0u4r/ekonE60H5PqmbaZY8NbNx3mU3DLxAOmx2KPVhLkI323Bmh9yum
	 K6+WbdQ590B9T4EOtZlClV37loEt0W5Z3WCij1Btc4HZXBzi99gyouguODqp9nSxCi
	 EqA3xfNQRkxRO/Xz7AbPp5RVXj+c4UiXgm5zipHdViZCga2Swb7b/rD5tg57HVMcBJ
	 jGf3NultZ42tg==
Date: Wed, 4 Sep 2024 10:09:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Song Liu <song@kernel.org>, Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH -next 0/2] perf stat: Support inherit events for bperf
Message-ID: <ZthcJtXyWk7uJFZY@x1>
References: <20240904123103.732507-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904123103.732507-1-wutengda@huaweicloud.com>

On Wed, Sep 04, 2024 at 12:31:01PM +0000, Tengda Wu wrote:
> Hi,
> 
> bperf (perf-stat --bpf-counter) has not supported inherit events
> during fork() since it was first introduced.
> 
> This patch series tries to add this support by:
>  1) adding two new bpf programs to monitor task lifecycle;
>  2) recording new tasks in the filter map dynamically;
>  3) reusing `accum_key` of parent task for new tasks.

Song, can you please take a look?

Thanks in advance!

- Arnaldo
 
> Thanks,
> Tengda
> 
> Tengda Wu (2):
>   perf stat: Support inherit events during fork() for bperf
>   perf test: Use sqrtloop workload to test bperf event
> 
>  tools/perf/tests/shell/stat_bpf_counters.sh   |  2 +-
>  tools/perf/util/bpf_counter.c                 |  9 +--
>  tools/perf/util/bpf_skel/bperf_follower.bpf.c | 75 +++++++++++++++++--
>  tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
>  4 files changed, 79 insertions(+), 12 deletions(-)
> 
> -- 
> 2.34.1

