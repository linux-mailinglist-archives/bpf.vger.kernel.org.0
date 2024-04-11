Return-Path: <bpf+bounces-26572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8858A1EDD
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 20:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A947EB34B68
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 18:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E4012E5D;
	Thu, 11 Apr 2024 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgYbnuYC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7DE1863B;
	Thu, 11 Apr 2024 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712860951; cv=none; b=Y6hdvK/IiZ/MLbSWLGOKyUFjs3msHT6kBiRLZyS9F+gqpgUrpnhKVKUZ8x5gMwpmsOxMlw+qUC6v0PzFHBzPQzV8ffB3J7MPv17l19zd7iAiGyCrReKoGO3KoZO0j0xVMAKydYsQ6svM/pR3U+cWpOrjF9Y9fedr05aSdR84r94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712860951; c=relaxed/simple;
	bh=cNhplYhRegzLVfwCwfg5gMJlYQSZzSjONHOCJSpflbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIlWiJwQvBr4CK0c42f84kI5LYt+er0L0nFpZx6TxgFcO1FZfgQbTlGte1A3hPqapYtv6yz6LpzRlGxFAgmfUql7Ek/aBOTY8aK9VH5B30D0Q1Ncr0qasu6yXIrmPmUmw+8eIQ5uvvgXGPchOIxu88/DDDHuj7iWWc1xQvXCRRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgYbnuYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B40C072AA;
	Thu, 11 Apr 2024 18:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712860950;
	bh=cNhplYhRegzLVfwCwfg5gMJlYQSZzSjONHOCJSpflbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgYbnuYCc0JMHo7uYHO+6QPnfpboeaRS0PaGEwuP82rrgxX2VbGPLTYXeG5Jl5Gno
	 tmAz1OwNaUIuEdInYEtmBWThstsKGyxKqxx/KbgxT/KfJW6PGEdOyg6el7+67T/6eB
	 8Z32NOBritWtHec9WmFwsUhI+v4YDXC4kp9D4BlioNjU2AC6nMXxgaYgR8zylEaLRN
	 wfxeg52DgHDYuRu7HzlJ4WVbK4MEkI8uGENf4Gij0UomdzlxHXoIvCS370y1MWJxUA
	 R07NGa+iIMaswbN5Psz9l+ymZIfH0ycLV9ylYfUPraTKffS+ULtuv45bwZqlBTNnv7
	 hrYeHRm2ptkgg==
Date: Thu, 11 Apr 2024 15:42:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ben Gainey <ben.gainey@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Anne Macedo <retpolanne@posteo.net>,
	Changbin Du <changbin.du@huawei.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Li Dong <lidong@vivo.com>, Paran Lee <p4ranlee@gmail.com>,
	elfring@users.sourceforge.net,
	Markus Elfring <Markus.Elfring@web.de>,
	Yang Jihong <yangjihong1@huawei.com>,
	Chengen Du <chengen.du@canonical.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v3 00/12] dso/dsos memory savings and clean up
Message-ID: <ZhgvE7i9HGGar1eX@x1>
References: <20240410064214.2755936-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410064214.2755936-1-irogers@google.com>

On Tue, Apr 09, 2024 at 11:42:02PM -0700, Ian Rogers wrote:
> 12 more patches from:
> https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
> a near half year old adventure in trying to lower perf's dynamic
> memory use. Bits like the memory overhead of opendir are on the
> sidelines for now, too much fighting over how
> distributions/C-libraries present getdents. These changes are more
> good old fashioned replace an rb-tree with a sorted array and add
> reference count tracking.
> 
> The changes migrate dsos code, the collection of dso structs, more
> into the dsos.c/dsos.h files. As with maps and threads, this is done
> so the internals can be changed - replacing a linked list (for fast
> iteration) and an rb-tree (for fast finds) with a lazily sorted
> array. The complexity of operations remain roughly the same, although
> iterating an array is likely faster than iterating a linked list, the
> memory usage is at least reduce by half.

Got the first 5 patches, would be nice if more people could review it,
I'll try and get back to is soon.

- Arnaldo

