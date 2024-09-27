Return-Path: <bpf+bounces-40425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3035998898E
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 19:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AB6281A1F
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C041C175D;
	Fri, 27 Sep 2024 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY2VXxVU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF1D524B0;
	Fri, 27 Sep 2024 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727457148; cv=none; b=s9NaBXOa/fzBr71QCJ4Gl2it2BUM3sdzM9qPRIYOMY3sN83q2pl56a6qn79SSIEUkNtjtf++X65nsWvL2rHUV3HwVFGD9ac0dS+oMg8ZdveJ8JGofF2jLLAljO6855mfalYH00I7fSvLik/njtX97Zxw2ptMxHSU8p+S4lMxFy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727457148; c=relaxed/simple;
	bh=/aepn4yxs2GacHcxTHHnxPFuOl6EiGqs7P8YQBP1mx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gj9eAHVq4SjoUjyl6op7bvPIJZrcM1mEpUQbEpfIjK6TtYp5wUUXnVIpOaC7ZArF95T5nCO+WPJJBOJEroJSM80jU2TU9WyFJ+2gusLwcRVMs9XXWf8U5baUyDBqlNtT5JAteBDkgEBCj2xQaztwVdWCqCq8revKJOua80WnLNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY2VXxVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8807C4CEC4;
	Fri, 27 Sep 2024 17:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727457147;
	bh=/aepn4yxs2GacHcxTHHnxPFuOl6EiGqs7P8YQBP1mx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oY2VXxVU+quI2gL/DOUPraf3nWFhrGOrvHRjkN5sCL/ieWgt22COKnTzY3JjtAXjy
	 qAjKdpNoHQl3/DkZfLjeymp81F0cYRURumPt1xzl8fwQid8d4rwdi13rKgQMFx11Ao
	 uPZIfWkON3PEE00qAlpPoAcRmga9vBYcPCgWXrqMLUeBXyWC48RCaxnU4dUEpec0y9
	 wenwpKyUNfxl3gOsog8iYPvbrPcuJpT++51TdCWPdqbGLhtjcwy+1y/RCxfmgCNq1I
	 kpuS/yoRfMJvI+mwUkV8PyhYwkgK3E9BEExElRfvDEz+K3qQ9vkkSOhMOnbRoSsal9
	 /5Xx6ICCcxeGA==
Date: Fri, 27 Sep 2024 10:12:24 -0700
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
Subject: Re: [PATCH -next 1/2] perf stat: Increase perf_attr_map entries
Message-ID: <ZvbnePGVmbWF0fAF@google.com>
References: <20240925135523.367957-1-wutengda@huaweicloud.com>
 <20240925135523.367957-2-wutengda@huaweicloud.com>
 <ZvTgHKl4eZvpyVml@google.com>
 <41d1d728-dbf4-4b0d-9855-19cd06e2a594@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41d1d728-dbf4-4b0d-9855-19cd06e2a594@huaweicloud.com>

On Fri, Sep 27, 2024 at 10:35:54AM +0800, Tengda Wu wrote:
> 
> 
> On 2024/9/26 12:16, Namhyung Kim wrote:
> > On Wed, Sep 25, 2024 at 01:55:22PM +0000, Tengda Wu wrote:
> >> bperf restricts the size of perf_attr_map's entries to 16, which
> >> cannot hold all events in many scenarios. A typical example is
> >> when the user specifies `-a -ddd` ([0]). And in other cases such as
> >> top-down analysis, which often requires a set of more than 16 PMUs
> >> to be collected simultaneously.
> >>
> >> Fix this by increase perf_attr_map entries to 100, and an event
> >> number check has been introduced when bperf__load() to ensure that
> >> users receive a more friendly prompt when the event limit is reached.
> >>
> >>   [0] https://lore.kernel.org/all/20230104064402.1551516-3-namhyung@kernel.org/
> > 
> > Apparently this patch was never applied.  I don't know how much you need
> > but having too many events at the same time won't be very useful because
> > multiplexing could reduce the accuracy.
> > 
> 
> Could you please explain why patch [0] was not merged at that time? I couldn't
> find this information from the previous emails.

I guess it's just fell through the crack. :)

> 
> In my scenario, we collect more than 40+ events to support necessary metric
> calculations, which multiplexing is inevitable. Although multiplexing may
> reduce accuracy, for the purpose of supporting metric calculations, these
> accuracy losses can be acceptable. Perf also has the same issue with multiplexing.
> Removing the event limit for bperf can provide users with additional options.
> 
> In addition to accuracy, we also care about overhead. I compared the overhead
> of bperf and perf by testing ./lat_ctx in lmbench [1], and found that the
> overhead of bperf stat is about 4% less than perf. This is why we choose to
> use bperf in some extreme scenarios.

Ok, thanks for explanation.  I think it's ok to increase the limit.

Thanks,
Namhyung

> 
>   [1] https://github.com/intel/lmbench
> 
> Thanks,
> Tengda
> 
> > 
> >>
> >> Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware PMCs with BPF")
> >> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> >> ---
> >>  tools/perf/util/bpf_counter.c | 8 +++++++-
> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> >> index 7a8af60e0f51..3346129c20cf 100644
> >> --- a/tools/perf/util/bpf_counter.c
> >> +++ b/tools/perf/util/bpf_counter.c
> >> @@ -28,7 +28,7 @@
> >>  #include "bpf_skel/bperf_leader.skel.h"
> >>  #include "bpf_skel/bperf_follower.skel.h"
> >>  
> >> -#define ATTR_MAP_SIZE 16
> >> +#define ATTR_MAP_SIZE 100
> >>  
> >>  static inline void *u64_to_ptr(__u64 ptr)
> >>  {
> >> @@ -451,6 +451,12 @@ static int bperf__load(struct evsel *evsel, struct target *target)
> >>  	enum bperf_filter_type filter_type;
> >>  	__u32 filter_entry_cnt, i;
> >>  
> >> +	if (evsel->evlist->core.nr_entries > ATTR_MAP_SIZE) {
> >> +		pr_err("Too many events, please limit to %d or less\n",
> >> +			ATTR_MAP_SIZE);
> >> +		return -1;
> >> +	}
> >> +
> >>  	if (bperf_check_target(evsel, target, &filter_type, &filter_entry_cnt))
> >>  		return -1;
> >>  
> >> -- 
> >> 2.34.1
> >>
> 

