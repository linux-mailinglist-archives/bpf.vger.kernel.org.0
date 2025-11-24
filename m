Return-Path: <bpf+bounces-75393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AEAC82694
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 21:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 718153490C9
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 20:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F0C2512EE;
	Mon, 24 Nov 2025 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTFiIFxI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6200A21D58B;
	Mon, 24 Nov 2025 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764016068; cv=none; b=LiOzP0bM3qNfLrV8qGu8oeXtzpF4Tl9Ml8OpSbqWZWO+FUEwovrsaWYHZpaEiRkoOPCVzVLbu/RrEoJiZ7vi2Ic2bQD5Aezaj5Sx4K5IfvVsTqJSzx6QG7XMeyWeDEYGDSTpOP4GNWxBierTMwawmSREeEu25O/uEhOtCxDJsvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764016068; c=relaxed/simple;
	bh=sFh+GJxftviI9ok4scpNd13sZc66q9ausSV1iblN4c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5lUaxehavBKIjVJfALoNytPim4ua0Fv73wbijEaT80OWpR9VVNA3K6Qh7a8X6kf8dTDs1qgoszYu/020N5qpOWfmHt/maMOqeNr8YuIXAtWXQpegb438E59iLALoJK1W4gzf9RWTKSXDHVWLymK6akeORfKxFITmAu2AwW4iNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTFiIFxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5CEC4CEF1;
	Mon, 24 Nov 2025 20:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764016067;
	bh=sFh+GJxftviI9ok4scpNd13sZc66q9ausSV1iblN4c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTFiIFxIHYF2h4iZEW4r2LkXe7JgcmqkYhBvEph60j/ynB8wATFGJnkwV/ugWvEJ/
	 mGe5GlToodlHPO0vVouG7Tu7SR8rmQ4qFtx6CIVOY2kb2F4efxIAKOm7Sb/gBMaglW
	 gBMUS69QgjvLMO4jv/nRk22+Rxd3XtI2RFzm6rCoH4PYIU08Y1Zp/WdvQRtoV4vKr8
	 39j/0aLog4GxdFCyPuGl6C3D01Fr4nQTLL4fVPh8mOU9b1UGe0mmSjiWXwcJfTSuhW
	 z4sf87j4Ufcz3ArMv+cXQC3LgnstY0rk4Lf/0likaWX/BV9KgYc4bIAeEXD7ImhXLA
	 H1D3YqWo4rUTw==
Date: Mon, 24 Nov 2025 12:27:45 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v6 3/6] perf record: Add --call-graph fp,defer option for
 deferred callchains
Message-ID: <aSS_wR973EKsdW-B@google.com>
References: <20251120234804.156340-1-namhyung@kernel.org>
 <20251120234804.156340-4-namhyung@kernel.org>
 <947ef366-435d-4b05-b0b1-685e569d0a1e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <947ef366-435d-4b05-b0b1-685e569d0a1e@linux.ibm.com>

Hello,

On Fri, Nov 21, 2025 at 07:26:34AM +0100, Thomas Richter wrote:
> On 11/21/25 00:48, Namhyung Kim wrote:
> > Add a new callchain record mode option for deferred callchains.  For now
> > it only works with FP (frame-pointer) mode.
> > 
> > And add the missing feature detection logic to clear the flag on old
> > kernels.
> > 
> >   $ perf record --call-graph fp,defer -vv true
> 
> Does this also works for dwarf format?
>     # perf record --call-graph dwarf,defer ....

No, it's not supported.  Maybe we can do similar just to dump stack
content and registers for dwarf before returning to user.

Thanks,
Namhyung


