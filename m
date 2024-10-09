Return-Path: <bpf+bounces-41353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84AD995EEA
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 07:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCFC1F2446F
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 05:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536D915C13A;
	Wed,  9 Oct 2024 05:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccdEkl3w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7598152E02;
	Wed,  9 Oct 2024 05:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728451298; cv=none; b=Cv0mYW3haG+dBd85/udOA2i6W5bkOx+sHkoC/2J2gOlvSznxX2RAGLdHEq2VPzPUmc2s9Vq6wJBE+rFEkVBYY/G0hGBvh5BARwI0y5bRIN1GkzRtvTeHyD23KDzqQ5thjIYtteLKXSdE79VXlgii49/KJY1ur593SWdk8/NLjN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728451298; c=relaxed/simple;
	bh=Bz0/Aw0M5QZMtagLOWKJLDIELNT5BFqVqkzIy9dcock=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2u+y9+WaUxayfOVt7YjhCUX62ohmcDDIm8b3EpmuoXcaAa4FraxMuPCZpPor9Ka432v9swRHsZrhtSjR47z3eXLc2Kp4Z1UYbzskYwTUE8c+d/iAgzK+tFoAVdqhHVlob2p9I4AmB433ELRNznNCmhTeaGrlDPmAGmB4uI+IkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccdEkl3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC82C4CECE;
	Wed,  9 Oct 2024 05:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728451298;
	bh=Bz0/Aw0M5QZMtagLOWKJLDIELNT5BFqVqkzIy9dcock=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ccdEkl3wj9uXf+LNXCnP2ize2quJEYizc1903JpgJY7kFblSzqg6Bg11EmwOjrOwR
	 uu/OS7t0wDIJHakCra/hheRBA4DYJcxXnYuvyPjYBmYvu9jkUTfPZDbc3h73pEwass
	 bgBsIXpm7EacNqF2AeM9eePPi/MRKblvWg89wlM1D3KU6CLANjv8KWftOK/89JDhYu
	 cIHdR+fI6DNUCGE2KZjegTeNuZRbAB+CjKel6th9lwyyRo+UuGOXKja6V34HbWxsJD
	 BWqMpYksyusvn21ZEzFBflTB5WAqrOxVI3hepuywRSCxYMUqj0IX5uGihvyGMjPrED
	 +jzqtmVzHQlTg==
Date: Tue, 8 Oct 2024 22:21:36 -0700
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
Message-ID: <ZwYS4FEP5yMOCXEv@google.com>
References: <20240916014318.267709-1-wutengda@huaweicloud.com>
 <729eef63-6aed-44db-b18a-eb4bf96aeaab@huaweicloud.com>
 <ZvTYduigMBtlmNbK@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvTYduigMBtlmNbK@google.com>

On Wed, Sep 25, 2024 at 08:43:50PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Sep 25, 2024 at 10:16:16PM +0800, Tengda Wu wrote:
> > Hello,
> > 
> > Sorry for pinging again. Is there any other suggestion with this patch set?
> > If there is, please let me know.
> 
> Sorry I was traveling last week.  I think it's good now.
> 
> Song, can I get your ack?

He seems to be very busy.  I'll pick this up and run some tests.

Thanks,
Namhyung

> 
> > 
> > On 2024/9/16 9:43, Tengda Wu wrote:
> > > Hi,
> > > 
> > > Here is the 3th version of the series to support inherit events for bperf.
> > > This version add pid or tgid selection based on filter type in new_task
> > > prog to avoid memory waste and potential count loss.
> > > 
> > > 
> > > bperf (perf-stat --bpf-counter) has not supported inherit events
> > > during fork() since it was first introduced.
> > > 
> > > This patch series tries to add this support by:
> > >  1) adding two new bpf programs to monitor task lifecycle;
> > >  2) recording new tasks in the filter map dynamically;
> > >  3) reusing `accum_key` of parent task for new tasks.
> > > 
> > > Thanks,
> > > Tengda
> > > 
> > > 
> > > Changelog:
> > > ---------
> > > v3: (Address comments from Namhyung, thanks)
> > >  * Use pid or tgid based on filter type in new_task prog
> > >  * Add comments to explain pid usage for TGID type in exit_task prog
> > > 
> > > v2: https://lore.kernel.org/all/20240905115918.772234-1-wutengda@huaweicloud.com/
> > >  * Remove the unused init_filter_entries in follower bpf, declare
> > >    a global filter_entry_count in bpf_counter instead
> > >  * Attach on_newtask and on_exittask progs only if the filter type
> > >    is either PID or TGID
> > > 
> > > v1: https://lore.kernel.org/all/20240904123103.732507-1-wutengda@huaweicloud.com/
> > > 
> > > 
> > > Tengda Wu (2):
> > >   perf stat: Support inherit events during fork() for bperf
> > >   perf test: Use sqrtloop workload to test bperf event
> > > 
> > >  tools/perf/tests/shell/stat_bpf_counters.sh   |  2 +-
> > >  tools/perf/util/bpf_counter.c                 | 32 +++++--
> > >  tools/perf/util/bpf_skel/bperf_follower.bpf.c | 87 +++++++++++++++++--
> > >  tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
> > >  4 files changed, 112 insertions(+), 14 deletions(-)
> > > 
> > 

