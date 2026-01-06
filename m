Return-Path: <bpf+bounces-78017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F85CFB3EC
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 23:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 289F13072E8A
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 22:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8722DCF52;
	Tue,  6 Jan 2026 22:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pxa9uNrx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3775E2DEA6F;
	Tue,  6 Jan 2026 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737912; cv=none; b=rBj177Fjey/MC4tOXQgE+rwIDcJ+EhfKtPAtBRsyRh9viwSv3X4OeP+Lkiq4ox8isUNToB9bXvxJ8ofR2BdnXO+VF7WQoIB0HZ17wMbtc3RZD0DRT7uLMIKmzb+TQYHPuZni3KEPfKUBx3i2MsnhpVg6LYj2iHqZ8r/9eVN+XWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737912; c=relaxed/simple;
	bh=VxP3gN6EuETCO78G27pem7ZWOyviGO5t6cCqAm0GUuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGgYqOepFtChIoqPGje0ilpmxf6uHAGqOf1o4cYaVT/ez+nNEyTqiDDC8LfpxpZJYPUbOX5VWQh4iQcVE3qHmplWVo4wJI8THOK23PHgnjsWnXjUAaJJrjNZ7xddrZSy3KU5oRymQ1vrvL5oq0sJbL0MFvDbcskDRC1pZyAi+xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pxa9uNrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288E8C116C6;
	Tue,  6 Jan 2026 22:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767737911;
	bh=VxP3gN6EuETCO78G27pem7ZWOyviGO5t6cCqAm0GUuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pxa9uNrxiIF4RZGx5HinH42KcBAPUqsaPf6/Ts2txh8VTMXJxo9TLigNtwW1t/nDF
	 Wq56bhAV4mbhBP2gWfQnkARjrQDLgP0QffP20cR73hQqEQRD0jOZm3zlDLThQS+P+0
	 rxHYquOg7nOXlLPVgbbOghleN6AaX663rezS4P77jgtGwAcJ3nKeabwCYcAnrzcO5t
	 5lqwZG9Lgkwykci+43NTUXmTt3p2eTch/bjyTYh+qUHpR+Z5ZynsrSMFERCZlC3LFE
	 z0zss7oc3sSwBiM5IPgjzU/x+ZsQe3swHn3JZAZ2xinMQ0FCRb1GricmKGM3Ay1oRb
	 za4PYthjoInog==
Date: Tue, 6 Jan 2026 19:18:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>, Leo Yan <leo.yan@arm.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andres Freund <andres@anarazel.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nick Terrell <terrelln@fb.com>, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, llvm@lists.linux.dev,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Quentin Monnet <qmo@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH 0/5] perf build: nondistro build tidyups
Message-ID: <aV2KM5yEAoLWT8rx@x1>
References: <20251223-james-libbfd-feat-check-v1-0-0e901ba32ed9@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223-james-libbfd-feat-check-v1-0-0e901ba32ed9@linaro.org>

On Tue, Dec 23, 2025 at 05:00:23PM +0000, James Clark wrote:
> nondistro builds now require a specific version of libbfd, so this adds
> an error when doing an explicit BUILD_NONDISTRO build and some other
> related tidyups.
> 
> I'm not sure if the intention is to skip build-tests if something is
> missing, but I see it was done for libbpf versions, so I added the same
> for libbfd. This is the main thing that I hit, that build-test all of a
> sudden stopped working for me.
> 
> The first commit is also a cherry pick of an old commit that seemed to
> have been accidentally reverted in the unrelated change linked in the
> trailers.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> ---
> James Clark (4):
>       perf build: Do all non-distro feature checks in one go
>       perf build: Remove unused libbfd-buildid feature test
>       perf build: Feature test for libbfd thread safety API
>       perf build: Skip nondistro build test if libbfd is old
> 
> Roberto Sassu (1):
>       perf build: Remove FEATURE_CHECK_LDFLAGS-disassembler-{four-args,init-styled} setting
> 
>  tools/build/Makefile.feature                 |  2 +-
>  tools/build/feature/Makefile                 |  4 +--
>  tools/build/feature/test-libbfd-buildid.c    |  8 -----
>  tools/build/feature/test-libbfd-threadsafe.c | 18 ++++++++++
>  tools/perf/Makefile.config                   | 54 ++++++++++------------------
>  tools/perf/tests/make                        |  5 +++
>  6 files changed, 45 insertions(+), 46 deletions(-)
> ---
> base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
> change-id: 20251223-james-libbfd-feat-check-e0cd09d2c1e1
> 
> Best regards,
> -- 
> James Clark <james.clark@linaro.org>

