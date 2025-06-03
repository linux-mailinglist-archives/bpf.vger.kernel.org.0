Return-Path: <bpf+bounces-59565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE51ACCFE1
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 00:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588793A43D1
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 22:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651DB253346;
	Tue,  3 Jun 2025 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmZz/5Pf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B419CC39;
	Tue,  3 Jun 2025 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989974; cv=none; b=TJ+uYyJ3f4kE6hTUfREJM45y3wx2TvCM1ST/brqmWUneOaiuVoMmOGBe5qd4yySQNJKyWbNVosL1LN451jkjb83+KHNNjxXu6KPtad8CrtG4ptn30HsBETmlTQqU+gX24D1JdzsmfwuyKiDfzol4ZtLzuvjWueU91+Pz49k7Mbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989974; c=relaxed/simple;
	bh=bPXsRXpAxnlibilkjqrzAMmxKvKrgapASq5nd7CJUvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0DsLDhr52aQvh6rkqBQGHN1iuwBKurGJ+qP12i2R/aDJTVGJq1RBSRE7Rc3jIUwsribOv94NN8FV/IFWf15AqJT2Yz7VOiytSUKI6GkZ8ZayXKPNy6Mvokrb3xsNYuJ25DLQk1z6u77wB9MtGvvqjhYceDy4S3b2KrEvHhe8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmZz/5Pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86428C4CEED;
	Tue,  3 Jun 2025 22:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748989974;
	bh=bPXsRXpAxnlibilkjqrzAMmxKvKrgapASq5nd7CJUvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hmZz/5PfB227KENsmt29kjBaKus3m8PO+zxGimbW3gsLF5YE1htDXTfEIhb3yx+8N
	 y7ClgVBPtzn3Gu5E9YpXzkJBIFKsFw/p3cc6YnuXY+b0eb/erRbuKtTTWnbSqNfBku
	 dX9IiyVIG8yIaGau5llRcvSQNnTK5U2lbMKcBQOOklK9V6rQt4UweGEC840QeHthyP
	 1EhuduCSyCmNgjfRXCk8xVP8Qk736HxEtV7gkY2XfJfmSZ8mLoIpt8xK3aEDSQryMB
	 qjn9kbxgS9T3Ywx99UdD41rDLKOZZ54rdBUV/ThCmObgmdwUuimq2dimGm3Hqa5BP8
	 eu1lMiTy9n8fA==
Date: Tue, 3 Jun 2025 15:32:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: Re: [PATCH v3 00/10] Move uid filtering to BPF filters
Message-ID: <aD94FJN4Pjsx7exP@google.com>
References: <20250425214008.176100-1-irogers@google.com>
 <CAP-5=fXiYHbe9gd_TNyy=txzrd+ONxecnpZr+uPeOnF5XxunGw@mail.gmail.com>
 <aD586_XkeOH2_Fes@google.com>
 <CAP-5=fUXJ6fW4738Fnx9AK2mPeA74ZpYKv=Ui6wYLWXE3KRRTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUXJ6fW4738Fnx9AK2mPeA74ZpYKv=Ui6wYLWXE3KRRTQ@mail.gmail.com>

On Mon, Jun 02, 2025 at 11:26:12PM -0700, Ian Rogers wrote:
> On Mon, Jun 2, 2025 at 9:41 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Tue, May 27, 2025 at 01:39:21PM -0700, Ian Rogers wrote:
> > > On Fri, Apr 25, 2025 at 2:40 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > Rather than scanning /proc and skipping PIDs based on their UIDs, use
> > > > BPF filters for uid filtering. The /proc scanning in thread_map is
> > > > racy as the PID may exit before the perf_event_open causing perf to
> > > > abort. BPF UID filters are more robust as they avoid the race. The
> > > > /proc scanning also misses processes starting after the perf
> > > > command. Add a helper for commands that support UID filtering and wire
> > > > up. Remove the non-BPF UID filtering support given it doesn't work.
> > > >
> > > > v3: Add lengthier commit messages as requested by Arnaldo. Rebase on
> > > >     tmp.perf-tools-next.
> > > >
> > > > v2: Add a perf record uid test (Namhyung) and force setting
> > > >     system-wide for perf trace and perf record (Namhyung). Ensure the
> > > >     uid filter isn't set on tracepoint evsels.
> > > >
> > > > v1: https://lore.kernel.org/lkml/20250111190143.1029906-1-irogers@google.com/
> > >
> > > Ping. Thanks,
> >
> > I'm ok with preferring BPF over /proc scanning, but still hesitate to
> > remove it since some people don't use BPF.  Can you please drop that
> > part and make parse_uid_filter() conditional on BPF?
> 
> Hi Namhyung,
> 
> The approach of scanning /proc fails as:
> 1) processes that start after perf starts will be missed,
> 2) processes that terminate between being scanned in /proc and
> perf_event_open will cause perf to fail (essentially the -u option is
> just sugar to scan /proc and then provide the processes as if they
> were a -p option - such an approach doesn't need building into the
> tool).

Yeah, I remember we had this discussion before.  I think (1) is not true
as perf events will be inherited to children (but there is a race).  And
(2) is a real problem but it's also about a race and it can succeed.

Maybe we could change it to skip failed events when the target is a
user but that's not the direction you want.

> 
> This patch series adds a test [1] and perf test has lots of processes
> starting and exiting, matching condition (2) above*. If this series
> were changed to an approach that uses BPF and falls back on /proc
> scanning then the -u option would be broken for both reasons above but
> also prove a constant source of test flakes.
> 
> Rather than give the users something both frustrating to use (keeps
> quitting due to failed opens) and broken (missing processes) I think
> it is better to quit perf at that point informing the user they need
> more permissions to load the BPF program. This also makes the -u
> option testable.
> 
> So the request for a change I don't think is sensible as it provides a
> worse user and testing experience. There is also the cognitive load of
> having the /proc scanning code in the code base, whereas the BPF
> filter is largely isolated.

But I think the problem is that it has different requirements - BPF and
root privilege.  So it should be used after checking the requirements
and fail or fallback.

Does it print proper error messages if not?  With that we can deprecate
the existing behavior and remove it later.

Thanks,
Namhyung


