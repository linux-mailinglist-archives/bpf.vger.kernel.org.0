Return-Path: <bpf+bounces-57863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733FBAB192F
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 17:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8FCA26790
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 15:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A90423026D;
	Fri,  9 May 2025 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLgbQAus"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA5228C9D;
	Fri,  9 May 2025 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805706; cv=none; b=XCO0WLXwEkEoy/FzFlXgwgQh9pX7hvxs/FWTSVAh3g3jTJmpezK6oVCCE8qKQn6FBYxmEm4occDguE8Cs5IBNXca8kf1BXQPhIV3IYtCShOa9OZ9C3nOLNSz86zAgcDhXXdyQ2fVILsFqiR3h5GcTmeY/mrYd0oIIy5MBqA/Mxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805706; c=relaxed/simple;
	bh=wBjQfXrnYFf046xq7csQXka+67IngmWM78qorBmxYEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ovfm8XDyRcgsmyK9CqnoYOf9BjxrXgNuJOAHW0+wdbkMQqu/9HCWQOnddvheo3JMt4HPgw5OfTUjd3fQXefC/d1yLlpu5xBxyy4Q1uufN/0XwmIdej6p2puQxJUlMrZNXEtTovHPv60lPkS4j+07InbccxTzVc5mQTDa0LX2YZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLgbQAus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B286C4CEE4;
	Fri,  9 May 2025 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746805706;
	bh=wBjQfXrnYFf046xq7csQXka+67IngmWM78qorBmxYEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLgbQAusXReXrnsC7hdi5/wDxA81/FEyh8N31IqWbBLHhNQizEtb9lRIAdBjLvW9y
	 hj5bCornBQnMLMCMvmY9sExw2m2FDskioDEeR5epbDVYbulybEGH2PXA3zWfhw5Yaz
	 HpCKsoS7LZ75vUXQpVBz3OIh6NtLYVQ/oEFO7GhypP/Phvs8SL7gFVbbfbuy4X5YRG
	 6WaMmfoIJ+a4QocvPLxYj1lfyhrAySW8pqpt+P7+Nvgq/TgJ1r2x1cu9CFdejBy/fZ
	 L8f6Z+quBByE+vA3YwuZGXihO+KsVht7uO/VGH5Bs0gJkN1gW9hhbFU6Y65PWJ5xQD
	 RiNX3cTdARgOg==
Date: Fri, 9 May 2025 08:48:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [RFC/PATCH] perf lock contention: Add -J/--inject-delay option
Message-ID: <aB4jxs90zVid4Bx8@google.com>
References: <20250225075929.900995-1-namhyung@kernel.org>
 <aBzDpi25-LBgAjEj@x1>
 <aBzqGn0Ktbl38sOF@google.com>
 <aB0MSvrGA5fgH5Hj@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aB0MSvrGA5fgH5Hj@x1>

On Thu, May 08, 2025 at 04:55:54PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, May 08, 2025 at 10:30:02AM -0700, Namhyung Kim wrote:
> > On Thu, May 08, 2025 at 11:45:58AM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Mon, Feb 24, 2025 at 11:59:29PM -0800, Namhyung Kim wrote:
> > > > This is to slow down lock acquistion (on contention locks) deliberately.
> > > > A possible use case is to estimate impact on application performance by
> > > > optimization of kernel locking behavior.  By delaying the lock it can
> > > > simulate the worse condition as a control group, and then compare with
> > > > the current behavior as a optimized condition.
> 
> > > So this looks useful, I guess we can proceed and merge it?
> 
> > That'd be great. :)
> 
> Can you please refresh it?

Sure, will send v2.

Thanks,
Namhyung

> 
> ⬢ [acme@toolbox perf-tools-next]$        git am ./20250224_namhyung_perf_lock_contention_add_j_inject_delay_option.mbx
> Applying: perf lock contention: Add -J/--inject-delay option
> error: patch failed: tools/perf/util/bpf_skel/lock_contention.bpf.c:11
> error: tools/perf/util/bpf_skel/lock_contention.bpf.c: patch does not apply
> error: patch failed: tools/perf/util/lock-contention.h:140
> error: tools/perf/util/lock-contention.h: patch does not apply
> Patch failed at 0001 perf lock contention: Add -J/--inject-delay option
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config set advice.mergeConflict false"
> ⬢ [acme@toolbox perf-tools-next]$ git am --abort
> ⬢ [acme@toolbox perf-tools-next]$ 
> ⬢ [acme@toolbox perf-tools-next]$ patch -p1 < ./20250224_namhyung_perf_lock_contention_add_j_inject_delay_option.mbx
> patching file tools/perf/Documentation/perf-lock.txt
> Hunk #1 succeeded at 216 (offset 1 line).
> patching file tools/perf/builtin-lock.c
> Hunk #2 succeeded at 2003 (offset 30 lines).
> Hunk #3 succeeded at 2508 (offset 30 lines).
> Hunk #4 succeeded at 2652 (offset 30 lines).
> patching file tools/perf/util/bpf_lock_contention.c
> Hunk #1 succeeded at 261 (offset 78 lines).
> Hunk #2 succeeded at 373 (offset 80 lines).
> patching file tools/perf/util/bpf_skel/lock_contention.bpf.c
> Hunk #1 succeeded at 14 with fuzz 2 (offset 3 lines).
> Hunk #2 succeeded at 152 (offset 35 lines).
> Hunk #3 FAILED at 153.
> Hunk #4 succeeded at 397 (offset 39 lines).
> Hunk #5 succeeded at 835 with fuzz 1 (offset 230 lines).
> 1 out of 5 hunks FAILED -- saving rejects to file tools/perf/util/bpf_skel/lock_contention.bpf.c.rej
> patching file tools/perf/util/lock-contention.h
> Hunk #2 succeeded at 146 with fuzz 1.
> Hunk #3 succeeded at 156 (offset 1 line).
> ⬢ [acme@toolbox perf-tools-next]$

