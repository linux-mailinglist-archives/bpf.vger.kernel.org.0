Return-Path: <bpf+bounces-70226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E27C6BB4DBB
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 20:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5914237A6
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 18:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D47276059;
	Thu,  2 Oct 2025 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBNnkyWu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B59199BC;
	Thu,  2 Oct 2025 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428836; cv=none; b=s2sqRPYrVDSlCEsrA8eTYKtlzzASFL3fTHdBL1Ye1AbmehsvLFDYrUAzqabelKUugyjXQsyKWYk9NRd0ol3vSobjqo6lqhEH+EYpHU2xN/vRVKfeXrGDGdmYHfF6a9VMbSsY8JbF5m7XpSAMfdCfDMkRi4nFsNEk8BoP3ToKbUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428836; c=relaxed/simple;
	bh=+rNDhqtqqe0nUxbkfG3s9/MheX8ThCsOyszH+HFi8LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQA/ssIUJS0COEjU5rWRIDzn38gMNa6K0izjDaUCWU5X5fnj8L2bqdgailLGpVo6DDhgL1F0aHdHBMHShbPDZRo8hdlrGBa1QBwQTUY4vpX7tclHrzLS+YJ3ZOHnSQJ19nPSSLxTNOIErQKKeJZ4ehdeKS1a1qU0r5CzBvGt4uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBNnkyWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26716C4CEF4;
	Thu,  2 Oct 2025 18:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759428836;
	bh=+rNDhqtqqe0nUxbkfG3s9/MheX8ThCsOyszH+HFi8LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBNnkyWuxfCYodDcKY0Ih0NFbyy4jFAe6kPbeSH2km9Ot6zYVrRwjxcJvWazt/aZB
	 t9CpLafoxAxMJC2O9wAYkKZadMS6/p+o/4QQ/V/hGU70Mf2XzQsB7vVajGiSVLsArD
	 7cPoDqk15tlYHyUUZPgfU/Yd8Vu7sBGVICvIj5cBbNFwIF7jLbKxL4fj5dOugCTvpX
	 Z3rhPqVpp8/8O6cA2scP50OXn5UwfMgNPQri+fOSGd8QP4ET77aihGqNScP5LJUKOo
	 k2fZS6xj5xq0p7OTEX7JSiWARJ0+W1s0WmRkMT3OIwGE3pbeGO0Be2AZleXXmBBeDt
	 nUXf7Iu9zMICQ==
Date: Thu, 2 Oct 2025 15:13:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yuyang Huang <yuyanghuang@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Petr Machata <petrm@nvidia.com>,
	Maurice Lambert <mauricelambert434@gmail.com>,
	Jonas Gottlieb <jonas.gottlieb@stackit.cloud>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v1 0/4] perf/tools build related fixes
Message-ID: <aN7A4AklA7byxiFe@x1>
References: <20250905224708.2469021-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905224708.2469021-1-irogers@google.com>

On Fri, Sep 05, 2025 at 03:47:04PM -0700, Ian Rogers wrote:
> Add missing header files and #includes to fix the build in some
> environments like bazel.
> 
> Ian Rogers (4):
>   perf bench futex: Add missing stdbool.h
>   tools bitmap: Add missing asm-generic/bitsperlong.h include
>   tools include: Replace tools linux/gfp_types.h with kernel version
>   tools include: Add headers to make tools builds more hermetic

Thanks, applied to perf-tools-next,

- Arnaldo

