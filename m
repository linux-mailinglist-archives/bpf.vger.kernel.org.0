Return-Path: <bpf+bounces-61554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E329AAE8BA6
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 19:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3041A17859F
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6EE2D5414;
	Wed, 25 Jun 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrASA0hL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6502BCF5B;
	Wed, 25 Jun 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750873212; cv=none; b=q2NB+mRCdTUZBP7kCh824SbmoFUynW3YENcLFVLtaQM/gIZmdxheXx7HCtETM3qJgspaj9Yq9pZmLYBANuvB2rfsXOwOGKSSZNxnBQtDKS09Xss9JF0fVHC7HQd2+cFlfYxLLYvsyXWGgmiXCn4K2OKfBB0qbUD4wp2JS/YrOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750873212; c=relaxed/simple;
	bh=fo1sysK3iaf8fpiLsTNTcSaDSwwEBquylDdCzpddS1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Spk02zBKdIAiwISg7f4Ho21NIByzWRMHJ1WpEemOaF+tEa98jjVSU2UVOhTLhZBJJERI1pGMK8C2J/PCOnfIhxTZVqzrHSrHarHvq4W+UrPZgo+pJJDHFWpK+Oqtzw0MEGWTolrxEu4gsTLGvS5K6tQcv56YnIqaMQfgcnULnU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrASA0hL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E555C4CEEA;
	Wed, 25 Jun 2025 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750873211;
	bh=fo1sysK3iaf8fpiLsTNTcSaDSwwEBquylDdCzpddS1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrASA0hLeMqhurjuE8ZeFeXCB2qVL+99/cLVPOUY1IjzQmL0yMCQsXiPTdgMnf0np
	 v+8O53Xx1XvNMFdmd426PN8Z5hmP1MH4/ufGDI1t04UyERC2Az1G+qlmQbPYxxkUoi
	 b5k4gXcDYhXKaCB31QnHpQzftFASxnmRhFDCy5PyNWIoZypgUbUl+ZSepkJCvbLUfF
	 BeqyJ8SYwr//LXeARU5IB4fMTaXmXeflWyw8Ub4MJy4m0lGBdxFc+g8U7lB2XUd/Kp
	 4CuA3eYjV24gPUVrZZgIOepE6jqA5CAtlRGW/NF911jB00v6bbX2K3R6t1c3tCd233
	 T1mgD+ab8uTew==
Date: Wed, 25 Jun 2025 10:40:08 -0700
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
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Pipe mode header dumping and minor space saving
Message-ID: <aFw0eBq2FBgy21IN@google.com>
References: <20250607061238.161756-1-irogers@google.com>
 <aFr4VwxaAi5u5U2F@google.com>
 <CAP-5=fUh5uJhbgdr0iYqB7DD=hZgdbAr+34yss=pCVwnWG08yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUh5uJhbgdr0iYqB7DD=hZgdbAr+34yss=pCVwnWG08yQ@mail.gmail.com>

On Tue, Jun 24, 2025 at 01:15:13PM -0700, Ian Rogers wrote:
> On Tue, Jun 24, 2025 at 12:11 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Jun 06, 2025 at 11:12:34PM -0700, Ian Rogers wrote:
> > > Pipe mode has no header and emits the data as if it were events. The
> > > dumping of features was controlled by the --header/-I options which
> > > makes little sense when they are events, normally traced when
> > > dump_trace is true. Switch to making pipe feature events also be
> > > traced with detail when other events are.
> >
> > I'm not sure I'm following.  Are you saying the pipe mode doesn't
> > support features with --header/-I option?
> 
> No, in pipe mode it currently shows just PERF_RECORD_FEATURE or
> PERF_RECORD_ATTR for the details of the events containing these
> things. The reason being that the dumping is controlled by separate
> header flags (--header and -I). In patch 1 the commit message shows
> the before:
> ```
> $ perf record -o - -a sleep 1 | perf script -D -i -
> ...
> 0x2c8@pipe [0x54]: event: 80
> .
> . ... raw event: size 84 bytes
> .  0000:  50 00 00 00 00 00 54 00 05 00 00 00 00 00 00 00  P.....T.........
> .  0010:  40 00 00 00 36 2e 31 35 2e 72 63 37 2e 67 61 64  @...6.15.rc7.gad
> .  0020:  32 61 36 39 31 63 39 39 66 62 00 00 00 00 00 00  2a691c99fb......
> .  0030:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> .  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> .  0050:  00 00 00 00                                      ....
> 
> 0 0 0x2c8 [0x54]: PERF_RECORD_FEATURE
> ```
> 
> That is we have a feature "event" but there are no details there to
> try to be able to understand the feature event. After the change this
> becomes:
> ```
> $ perf record -o - -a sleep 1 | perf script -D -i -
> ...
> 0x2c8@pipe [0x54]: event: 80
> .
> . ... raw event: size 84 bytes
> .  0000:  50 00 00 00 00 00 54 00 05 00 00 00 00 00 00 00  P.....T.........
> .  0010:  40 00 00 00 36 2e 31 35 2e 72 63 37 2e 67 61 64  @...6.15.rc7.gad
> .  0020:  32 61 36 39 31 63 39 39 66 62 00 00 00 00 00 00  2a691c99fb......
> .  0030:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> .  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> .  0050:  00 00 00 00                                      ....
> 
> 0 0 0x2c8 [0x54]: PERF_RECORD_FEATURE, # perf version : 6.15.rc7.gad2a691c99fb
> ```
> 
> So now in the dump trace output I can see this was a feature for perf
> version and what that value is. There are often multiple
> PERF_RECORD_FEATURE and PERF_RECORD_ATTR "events" and so the extra
> trace output helps in being able to work out what's going on.

Thanks for the clarification, I was confused if it's fixing -I or -D. :)

Namhyung


