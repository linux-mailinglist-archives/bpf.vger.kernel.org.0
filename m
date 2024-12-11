Return-Path: <bpf+bounces-46665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 458C39ED6BB
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 20:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F16188408B
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 19:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E66202F88;
	Wed, 11 Dec 2024 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1ypOQiC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D82594A3;
	Wed, 11 Dec 2024 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733946300; cv=none; b=dT/BoPqaQSmSYRBHSi6PpBw0Nb8sriR0rIvow+bve6QZ22RvtqkXW7TuMcr/KyZjO9oCCTMbtHwt017RY7Xt+sG46A20BIsi+2OCOmbEev1LqLE63EjXa8Ei9i4QGdlDRIOIEwnhOYvlfhrrncPLnb060jaqXsXM52CDdsRamsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733946300; c=relaxed/simple;
	bh=Vg5J7bpAvisbUNV39Kztftl751Y5mcACEYs59HWtPXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fpx4q33okgOohDgPJ2xpr3MJxET6fKdnwXgEIMhxuAzBmyUtI7sg3XuRejMgERQm3+GoT+pxBuLfT3lPbhS7fbGP06ciYgZOUeuks9TCNEoLVXDLfyrh1W9fBAxNra8UWxnkOiSA1m986ekJd+p4UiaNgxNqHDSiN1GTSv9WjZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1ypOQiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1AEC4CED2;
	Wed, 11 Dec 2024 19:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733946300;
	bh=Vg5J7bpAvisbUNV39Kztftl751Y5mcACEYs59HWtPXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1ypOQiCKPrkxaqswbp3KsfOLkxNoA6awtMlQRFcChWZUsahcP+A3nGj2WHwkqIw1
	 gs5LLOAOy2AwfWCaz44UwA7wTxXf5+H3gbT501YuCHjtEgDopPWCECGYe7bg8ti274
	 KSiROl4NJHcg4Nigwp85tkIc62G2VZ76JgHmHhtp2t99+orRlr7Hvn04LN/PScfS9F
	 TE0h1BvNO3GzC+LnCv7Y8JvBt+sdaU6gThk9Jtn0OXyp0sSAu4MasfXbKtEHzP+xrk
	 lZSq/rUuuCp0Afapu7crxZ1Gp2PTdNnu7+RQYm+30oc5mkkOwApTpVAnRmAUZVQ90A
	 tMDkzv31rGnBw==
Date: Wed, 11 Dec 2024 11:44:57 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Quentin Monnet <qmo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <Z1nruXG6U0yYA5fK@google.com>
References: <20241211093114.263742-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
> 
> 
> Leo Yan (3):
>   tools build: Add feature test for libelf with ZSTD
>   perf: build: Minor improvement for linking libzstd
>   bpftool: Link zstd lib required by libelf

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

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
> 

