Return-Path: <bpf+bounces-46622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66EE9ECD0A
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 14:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F22B167FCF
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D322368F4;
	Wed, 11 Dec 2024 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0xD4zK7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F723027B;
	Wed, 11 Dec 2024 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923095; cv=none; b=GU0ufi123fbHIzVSqR4l2VTZ+KaMNEh/hkHXeah9mK/vNoMPUje965jr0dsZxGjgfEBD2STIxjVEFHv8q400Kqm3bl+c/uAmnNUmoN4h/PSRiPAHZ5auxmmY1U2dRgps78D66tWpS2dYKYGGk60ML/HxY1WUdfuYB3BywLogqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923095; c=relaxed/simple;
	bh=PQLkiEpSAqfQOdP48tewy/yiI9/+9NdmNBOuITix0t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLUJiBOXZWQXGXgtqg71TbLuC4FGAYgzUQJ45xYIejvDg115yjTBZZLpwuL+vOLNA1JYRfiO/wFHjIkiS1SQ9F+fwnBScQQu73j+XXoNxzzV7q1Xhh6qDHDS8lPYIV/xPHqS7cE3n+UdPG2WZ6jNS1d7D1tjZWcv7ZwT6k4kYgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0xD4zK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD7DC4CEDE;
	Wed, 11 Dec 2024 13:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733923093;
	bh=PQLkiEpSAqfQOdP48tewy/yiI9/+9NdmNBOuITix0t0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u0xD4zK7JFbJkpJzIwg9fshUDAG2vB9c0VPqj5HJEq6d4O31nJ0s8OC422odK3oMP
	 9DY7t2Ph9j8L4oTNmzHkuEymI7ZpKVQOwLSKbds2dyCXwZXYJ1iU/mfwTEaxP6i8lA
	 2Hjls13Esh5kMLdOFDTf6kYaO2mKzCa9c6FXLRsnh+V4qlmQ3hoBuLHkYru/ngIA10
	 F69UDuhWuBgdW1yrmnfRs3LxkR9BsjEb+Fv+4OAuiz1gscuIseWGXS2DDeF6+QBBMQ
	 B37IuFtFF5SEYH06wrl1oacgp4ogF+IxfyJmffJbCcGR7sxkB7tNeLev1QjtMx/IKg
	 pIgI6YCdqD4LA==
Date: Wed, 11 Dec 2024 10:18:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Quentin Monnet <qmo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Nick Terrell <terrelln@fb.com>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Guilherme Amadio <amadio@gentoo.org>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 0/3] bpftool: Fix the static linkage failure
Message-ID: <Z1mREhJElE6cSrPT@x1>
References: <20241211093114.263742-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211093114.263742-1-leo.yan@arm.com>

On Wed, Dec 11, 2024 at 09:31:11AM +0000, Leo Yan wrote:
> This series follows up on the discussion in [1] for fixing the static
> linkage issue in bpftool.
> 
> Patch 01 introduces a new feature for libelf-zstd.  If this feature
> is detected, it means the zstd lib is required by libelf.
> 
> Patch 02 is a minor improvement for linking the zstd lib in the perf.
> 
> Patch 03 fixes the static build failure by linking the zstd lib when
> the feature-libelf-zstd is detected.
> 
> [1] https://lore.kernel.org/linux-perf-users/Z1H9-9xrWM4FBbNI@mini-arch/T/#m2300b127424e9e2ace7da497a20d88534eb6866f

So, this was originally reported as a perf build failure when trying a
static build, so something not so common, no urgency, I guess, but it
involves a tools/perf/bpftool/Makefile change, I think I can process
this as I'll then test it in the many build containers for old distros I
have, ok?

- Arnaldo
 
> 
> Leo Yan (3):
>   tools build: Add feature test for libelf with ZSTD
>   perf: build: Minor improvement for linking libzstd
>   bpftool: Link zstd lib required by libelf
> 
>  tools/bpf/bpftool/Makefile             | 8 ++++++++
>  tools/build/Makefile.feature           | 1 +
>  tools/build/feature/Makefile           | 4 ++++
>  tools/build/feature/test-all.c         | 4 ++++
>  tools/build/feature/test-libelf-zstd.c | 9 +++++++++
>  tools/perf/Makefile.config             | 8 +++++++-
>  6 files changed, 33 insertions(+), 1 deletion(-)
>  create mode 100644 tools/build/feature/test-libelf-zstd.c
> 
> -- 
> 2.34.1

