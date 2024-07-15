Return-Path: <bpf+bounces-34829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F214931879
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 18:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FEB9B22587
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 16:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32F71C6A3;
	Mon, 15 Jul 2024 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C2/pkzq9"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E5B14295;
	Mon, 15 Jul 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061019; cv=none; b=VDFNVFICJjyrY76NqEJUr25e3K3qcE2GlgDd0OOXbP9TbnjHRcK/ISqwYLAFL3Xrnr9xLAhIX7HLi9MqSb45oEGuzbwLQ3WzQjjh3HYUZg4EZfs18VPCddt3/X4aZD1jLE9CEeggOXKwCWH0gcSO1lNA+JiwvOGbCasSEd4Sy+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061019; c=relaxed/simple;
	bh=kfktuDARrpRgAbO8NSRW1XuQuWx2B9PGzM3Bx/I+ifs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6v/R8JRXLZc5JbLEROHWuwVCez9B4D7TUl7lSUqlAQ+Kxd6Kx3Z5BwT1JEgKolI9pbfeSJBiJ1eAaVOwlmrsXTnMXOS9nI7gEo6LBepO9BwiNkrwZKAepLWFvSenLR+h5N17xk2MAzWYKIprnmykltEBX+TynEP30OOUxP2UUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C2/pkzq9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kfktuDARrpRgAbO8NSRW1XuQuWx2B9PGzM3Bx/I+ifs=; b=C2/pkzq9BaANLiUP+HbfJ+P8Sa
	fPeSPnViefj7/HsTK0AVSF5ys61S1vbFgbM0p1l1nNrrqo6EluViOcxAkaFQS25IfNAkYKf+3/CwQ
	qRL+lJqG/iqsbUGoxP/oWGxsO1wSBcm5QU+6+NRdPpHY5rTxA9iDrNVi0UO/Mh304BUGPp1aZtYB2
	Tjuk4axLNSjnlikwGQJjudap/ERCXhJNy/wP1zTq6cVEEJ3ZsPrYamZlYj/qjDpIr6Qzx+Fur0dxN
	yTM++UudH6k4r4ez06MLIxAcQ4E8bEXhZ/wqHKe7HTBtsCa1yLX0uHuig0zIv14/SwftPD9IO/jPC
	DGofXkQw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTOaS-00000001p9D-0eQq;
	Mon, 15 Jul 2024 16:30:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 809A53003FF; Mon, 15 Jul 2024 18:30:03 +0200 (CEST)
Date: Mon, 15 Jul 2024 18:30:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kyle Huey <me@kylehuey.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, khuey@kylehuey.com,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	robert@ocallahan.org, Joe Damato <jdamato@fastly.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing
 events
Message-ID: <20240715163003.GK14400@noisy.programming.kicks-ass.net>
References: <20240713044645.10840-1-khuey@kylehuey.com>
 <ZpLkR2qOo0wTyfqB@krava>
 <20240715111208.GB14400@noisy.programming.kicks-ass.net>
 <CAP045ArBNZ559RFrvDTsHj42S4W+BuReHe+XV2tBPSeoHOMMpA@mail.gmail.com>
 <20240715150410.GJ14400@noisy.programming.kicks-ass.net>
 <CAP045Aq3Mv2oDMCU8-Afe7Ne+RLH62120F3RWqc+p9STpcxyxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP045Aq3Mv2oDMCU8-Afe7Ne+RLH62120F3RWqc+p9STpcxyxg@mail.gmail.com>

On Mon, Jul 15, 2024 at 08:19:44AM -0700, Kyle Huey wrote:

> I think this would probably work but stealing the bit seems far more
> complicated than just gating on perf_event_is_tracing().

perf_event_is_tracing() is something like 3 branches. It is not a simple
conditional. Combined with that re-load and the wrong return value, this
all wants a cleanup.

Using that LSB works, it's just that the code aint pretty.



