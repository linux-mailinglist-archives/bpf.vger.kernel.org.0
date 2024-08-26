Return-Path: <bpf+bounces-38082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A5D95F40D
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 16:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C298A1F22256
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 14:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4047E18E058;
	Mon, 26 Aug 2024 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efm049mD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD718BBBF;
	Mon, 26 Aug 2024 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683148; cv=none; b=Rf1CV5Yd2ZVOOzTufQ8x6xwzGmCKuSXqM1R43mKi9zgWpeZpBiHzN3z4cFxDT5k4jyvDS3dUZJobGN71h8bFUG3mq+9e/I98WRTzV1cJVSe+6T7W6LVW1U5hzOf9iYRV1WYXDGiFWngdohfwhsRm1hrNVRBUkfu0VodjjkDWoZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683148; c=relaxed/simple;
	bh=Q9cvkCm+QmO1/pKn33PAu1ov/cyn+nHAhRP/EgZb/io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTNKFghpfk6mIXoWeXXYBO71mMUAWXT3TgzyrGG4+LgINHtX4HELDfjfGBrcjTces8nkMgfBpAnz8hu3fhLnMfhVRrxYHiYwsP1r+GA0Edb5LLWBkTru23x4Hhx7sbxl1m+tVIoeqTNkzy4eZR6ZNGy5VtIMNowW1ZOWqUlaGDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efm049mD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93147C4FEEB;
	Mon, 26 Aug 2024 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724683148;
	bh=Q9cvkCm+QmO1/pKn33PAu1ov/cyn+nHAhRP/EgZb/io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efm049mD2kZwjY0XKiloGnyNBxieWW7od3YFciHShVzKzoWWrAwPvboJiSKLIDWOD
	 3XSLIqeVluPjQuJ0i09ks34OCls2YpPrB81nSqMIDkvFFvQjtL8qT0A2R9vEKi/K+O
	 hegx/5mnHutGnd0GyfU6SvGpETGn3rqBjnSa4iS6iAcTxcn6waqeASZ0V0W4XJkJCP
	 zV2LrMCe04cFZ1Gh9oSwAxGZP4qKD9tlS9MyzGQ6JEXOOLZ9Ke55y4QiiqyBP3gTnY
	 A0fQ7yosjfw2lKkeXj4HYK6fzQcYaRstIk47xVEQsLPxESUVTREPxucpazTzx9SQFB
	 dGvWbkBfBoDqg==
Date: Mon, 26 Aug 2024 11:39:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH v3 2/3] perf tools: Print lost samples due to BPF filter
Message-ID: <ZsyTiEmr8_OsSnup@x1>
References: <20240820154504.128923-1-namhyung@kernel.org>
 <20240820154504.128923-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820154504.128923-2-namhyung@kernel.org>

On Tue, Aug 20, 2024 at 08:45:03AM -0700, Namhyung Kim wrote:
> Print the actual dropped sample count in the event stat.

Thanks, applied the series.

- Arnaldo

