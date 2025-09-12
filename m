Return-Path: <bpf+bounces-68256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B0AB556F4
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 21:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 780994E15ED
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 19:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D26E32F770;
	Fri, 12 Sep 2025 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlHMvKmW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AEA327A2E;
	Fri, 12 Sep 2025 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757705752; cv=none; b=OR+bq7ySjhxWKNzsim27RPZ+xYdvbVe5pj3FpIuD13idyoBmfGbZhX0SamBtE8NVNzwiRZDcf8FKVbSbpeUaet2VEQolXKRgDEFTva+6CcY4kzFHgDphsQn9Tp3eTpDdNJwppB+RVS1FVonNdRFf2jz1wQIYvEE3W9E8h+OVICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757705752; c=relaxed/simple;
	bh=EuFoan44y9MtixCT5U0TLvDIdjhgkppaMVmj//N0gIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBCSEKA0fVdXU1xE4naycKRef46kf1PfYCIcVPjMqTIMzgL5/JO70a1xB+AfzNNwAW68Devuf3wWd93mHI6mlYtVe8D8sqxLZH+EjYMkJiaIQLfIsScg3t6hK2JzzFTzN0ReDvZhvWJtwFjcwIX7mhrfGbmxvwf4kLclh7O/Zr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlHMvKmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA3CC4CEF1;
	Fri, 12 Sep 2025 19:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757705752;
	bh=EuFoan44y9MtixCT5U0TLvDIdjhgkppaMVmj//N0gIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlHMvKmWxpBv6h+cFyw/9EEJlBNsJkahcd3bvPMc/P2PzeVOjiQrnk1W05TfKjNsb
	 krBRBgl/6ppA1Ec/zw0quRTvAWXiBDov2FFWoA/ac2VYXE+QfSc2NDW1Dp6hTezPTg
	 1TehB+LHSuHsBkYq5OTN2HJ/CtAW485PEBBdIuIPt0QKR4l8ig5McR09NHe5JAK2AA
	 e6RCyOdBdJWPKjBH3gBiqtwaWM6mHU6nzXFIX9fjYunHZLHPEncrjdUPOr/MvNbuTA
	 WZaXVx3XIGZv/DF+jhP5DqS+jBNnvAK79f/cT47vCBBvleG+eYHu+yUa+K6O6JA8wu
	 CeBELC4tmmIoA==
Date: Fri, 12 Sep 2025 16:35:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH RESEND] perf: Completely remove possibility to override
 MAX_NR_CPUS
Message-ID: <aMR2FZWyXekLEK0-@x1>
References: <b205802edbb6fcc78822f558dff7104e64b29864.1755510867.git.christophe.leroy@csgroup.eu>
 <7ded6ce4-1fcb-4e2d-94ab-5c330de6aea0@csgroup.eu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ded6ce4-1fcb-4e2d-94ab-5c330de6aea0@csgroup.eu>

On Fri, Sep 12, 2025 at 10:32:56AM +0200, Christophe Leroy wrote:
> Le 18/08/2025 à 11:57, Christophe Leroy a écrit :
> > Commit 21b8732eb447 ("perf tools: Allow overriding MAX_NR_CPUS at
> > compile time") added the capability to override MAX_NR_CPUS. At
> > that time it was necessary to reduce the huge amount of RAM used
> > by static stats variables.
> > 
> > But this has been unnecessary since commit 6a1e2c5c2673 ("perf stat:
> > Remove a set of shadow stats static variables"), and
> > commit e8399d34d568 ("libperf cpumap: Hide/reduce scope of
> > MAX_NR_CPUS") broke the build in that case because it failed to
> > add the guard around the new definition of MAX_NR_CPUS.
> > 
> > So cleanup things and remove guards completely to officialise it
> > is not necessary anymore to override MAX_NR_CPUS.
> > 
> > Link: https://lore.kernel.org/all/8c8553387ebf904a9e5a93eaf643cb01164d9fb3.1736188471.git.christophe.leroy@csgroup.eu/
> > Fixes: e8399d34d568 ("libperf cpumap: Hide/reduce scope of MAX_NR_CPUS")
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Gentle ping

Thanks, applied to perf-tools-next,

- Arnaldo

