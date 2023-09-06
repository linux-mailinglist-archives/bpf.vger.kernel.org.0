Return-Path: <bpf+bounces-9377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC89794515
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 23:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA93C2812FE
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 21:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A59125A0;
	Wed,  6 Sep 2023 21:28:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1741811CB8
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 21:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628A3C433C8;
	Wed,  6 Sep 2023 21:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694035691;
	bh=97KtZLFki8TYIdeuSt8RiztJLygVCH9CnWN8bj1BXpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DgUoVWuBhBn5cDUBE7Kd5AczoOgQGiWzZmBVbqSMtB0k59yLwIB3tCUnZqhN5Zl/6
	 GWeWLkJXdiueV9biyBGWJLqBU9HREI9ZNbpRNmG20oWvV4i8/4Wv3qisShK92srKOc
	 9COjCv2WBoHT5q5Rsr3ft6aWQfSHjfAdSwi0Ec4Plr8y7eo4+/Drt/DiISeIFFRRb6
	 RiPLG+YrgIRW5v4YZME797MEZF2c/CQIljO1INuM6u06N8yi4GGh3RblMAFJTb/zvi
	 7oMe5ZmvxD8cieZj9KBd6nRTZlD7tZ+gd8Qbqb5zkGbLVnW5hyR8uWU9mR70fai9Wq
	 LWyOYRavyebeQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 8524F403F4; Wed,  6 Sep 2023 18:28:08 -0300 (-03)
Date: Wed, 6 Sep 2023 18:28:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCHSET 0/5] perf lock contention: Add cgroup support (v2)
Message-ID: <ZPju6GNFy3sALgRb@kernel.org>
References: <20230906174903.346486-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906174903.346486-1-namhyung@kernel.org>
X-Url: http://acmel.wordpress.com

Em Wed, Sep 06, 2023 at 10:48:58AM -0700, Namhyung Kim escreveu:
> Hello,
> 
> The cgroup support comes with two flavors.  One is to aggregate the
> result by cgroups and the other is to filter result for the given
> cgroups.  For now, it only works in BPF mode.
> 
> * v2 changes
>  - fix compiler errors  (Arnaldo)
>  - add Reviewed-by from Ian

Thanks, applied, tested, pushing to tmp.perf-tools-next.

- Arnaldo

