Return-Path: <bpf+bounces-37127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 337E29510A3
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 01:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6FB284FEC
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 23:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B31AC438;
	Tue, 13 Aug 2024 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCnKqR+K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1C019925F;
	Tue, 13 Aug 2024 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723592036; cv=none; b=KO8/a5ny12pY1s8gN8YIyUU09wA3zx9/i2lISqE+Bd9yoR2yMvnuSVvzLWuyndgE58UDr3hBIT1k6Khs8EigcbqXQVG2/ZacSRbDr/ST+YKJpzlrxey+tnyH+bZK9fhiJlqqC+OSQfYbdjKgUusi94I9BfcesN83NEdC3SK4Il0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723592036; c=relaxed/simple;
	bh=wdy5dYHo0VRi5HWt7oMQmCvCvw4I+YE+5vJ/T8fyW7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHAkxWmOJaC3bxgU9whi/Khw/bsKicTb3UKrpU19isCrDsQI81eU+CCmZKw0dIkJ4SmvRRq92IH7B6ZemUIn/Sh4ajqOxvlHyu26YJLsYWfnU4w7+REaqj+9ro5PXgqH91H72ROyrwCTU6wU+Bcg1J/+01K//o9LhNg1rL4bBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCnKqR+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE16C32782;
	Tue, 13 Aug 2024 23:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723592035;
	bh=wdy5dYHo0VRi5HWt7oMQmCvCvw4I+YE+5vJ/T8fyW7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PCnKqR+K4YuZXFBEprwPB3R8OgkJ6yScS1NwQ2Zq4nJjoD5UJmtgxTEtxjdusjsAu
	 INZ8+8OHC7qNu1mQnmre5dnvycPd9fB/BUZ5hpd/p2bBco68ep+467eIXfPwspMrvs
	 4HhNMAoqKlcyU3A7zCBgNQeDh40vysvK4FYdudID/sLjUOWjlskVEUtDHZreg8NBcy
	 L9ePz+zNmPJ9WEIud10yCuRtZxNRp1Q9F7vGZ40VGVsQw4z6DSNeLfosa9LuhSfqfq
	 jC0Yy8Azu2Zkm8AjnMdnuVYB7OJMiFphJqT67ktZBHhCwJ23o4fYNs1YnI+xthe4cK
	 i3dnEldsNB/Dg==
Date: Tue, 13 Aug 2024 16:33:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
	Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf bpf-filter: Support multiple events properly
Message-ID: <ZrvtYf2BG1hQlLGM@google.com>
References: <20240802173752.1014527-1-namhyung@kernel.org>
 <ZrDpsnReuIClKFnk@x1>
 <ZrEgeLkZx6uor7fg@google.com>
 <ZrEolmUz_2I1fmdJ@x1>
 <ZrFAIc0G8n0-zgxt@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZrFAIc0G8n0-zgxt@google.com>

On Mon, Aug 05, 2024 at 02:12:01PM -0700, Namhyung Kim wrote:
> On Mon, Aug 05, 2024 at 04:31:34PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Aug 05, 2024 at 11:56:56AM -0700, Namhyung Kim wrote:
> > > On Mon, Aug 05, 2024 at 12:03:14PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Fri, Aug 02, 2024 at 10:37:52AM -0700, Namhyung Kim wrote:
> > > > > + * The BPF program returns 1 to accept the sample or 0 to drop it.
> > > > > + * The 'dropped' map is to keep how many samples it dropped by the filter and
> > > > > + * it will be reported as lost samples.
> > > > 
> > > > I think there is value in reporting how many were filtered out, I'm just
> > > > unsure about reporting it as "lost" samples, as lost has another
> > > > semantic associated, i.e. ring buffer was full or couldn't process it
> > > > for some other resource starvation issue, no?
> > > 
> > > Then we need a way to save the information.  It could be a new record
> > > type (PERF_RECORD_DROPPED_SAMPLES), a new misc flag in the lost samples
> > 
> > I guess "PERF_RECORD_FILTERED_SAMPLES" would be better, more precise,
> > wdyt?
> > 
> > > record or a header field.  I prefer the misc flag.
> > 
> > I think we can have both filtered and lost samples, so I would prefer
> > the new record type.
> 
> I think we can have two LOST_SAMPLES records then - one with the new
> misc flag for BPF and the other (without the flag) for the usual lost
> samples.  This would require minimal changes IMHO.

I've realized that I already added PERF_RECORD_MISC_LOST_SAMPLES_BPF in
the commit 27c6f2455b29f ("perf record: Record dropped sample count"). :)

I'll add that to the event stats.

Thanks,
Namhyung


