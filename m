Return-Path: <bpf+bounces-29748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B838C6343
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 11:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A3E1F230DE
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B5355C0A;
	Wed, 15 May 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X+PkpahR"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5036B5A0F5;
	Wed, 15 May 2024 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763528; cv=none; b=lGLDzoKutCX7O3upF4XBx/2GznfGADJPV6OGY63kFhnrgBqWmRxbEWVg/gqDtWr3P5HPLpeCLFcHy//gozk3pJsTNLUmXSpqUE0XknDqIVM+iJHA5lDU/5z7pohJjf1lll/4kegsBroMTh0uPsq91WGg86CAi5E4h3/9lDjvT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763528; c=relaxed/simple;
	bh=mIm962IF10bdWS0VjUWThN6tROwBuUJv1m8MYht87Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1fdbe2XQQEnqlJ0sl6wRD61HRnYeRBWuvZrcs1yZlnbyIeGhKN32S3+Ap7YE/zf58/yRGctFFxTopT3Hcu+ImNTz3HkRPKj2Abzkw6Atcb4+kiLcsTAtfPylIf1YwC/XtTlcENaNNCQcqPm8iIMZCXTbUdVR7qONqDOlTCUUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X+PkpahR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=bw07bIpSCJ/6547TDCpYtK4MhhGWZ4UOhTjbzZBecaw=; b=X+PkpahRQrFnvf3SXhfKjeI5rP
	c7Km4Hfpcl06bjSZvd1AgoInaxPlctKsMtlsNqHOtFf6GGFdbk68VIwaFuKZbN6D48KFBQ8a41gMK
	aeLMpi6vtJB+nWe5i/aGk7XGoSKfrNGIorJvXuCQqbl8u79Nywsvq02vrypAGZ8j00mfBLYlo38Jh
	gvviAqOAqJUB0vNBVOWFZKinU40WNZu8bXUsBXz5ZP66LKyTXkOT8qvU3B8rQ0vVA/RuD6xsPOK2k
	fFaxd4sEX6gsbJ0pK1uoYRA1ykOnb1zbKZd1lwje1muDusiDnl6mFPC3yyB3wCdepJNGVX9yQPI0A
	pl8zH4kQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7ATA-0000000A8lu-1oQT;
	Wed, 15 May 2024 08:58:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1C94630068B; Wed, 15 May 2024 10:58:40 +0200 (CEST)
Date: Wed, 15 May 2024 10:58:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Yabin Cui <yabinc@google.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 3/3] perf/core: Check sample_type in
 perf_sample_save_brstack
Message-ID: <20240515085840.GD40213@noisy.programming.kicks-ass.net>
References: <20240510191423.2297538-1-yabinc@google.com>
 <20240510191423.2297538-4-yabinc@google.com>
 <CAM9d7chNz8-84m28q5qSLjUjZ=Ni1CA_JzbB_P+YJooLQd85YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chNz8-84m28q5qSLjUjZ=Ni1CA_JzbB_P+YJooLQd85YA@mail.gmail.com>

On Fri, May 10, 2024 at 02:29:58PM -0700, Namhyung Kim wrote:
> On Fri, May 10, 2024 at 12:14 PM Yabin Cui <yabinc@google.com> wrote:
> >
> > Check sample_type in perf_sample_save_brstack() to prevent
> > saving branch stack data when it isn't required.
> >
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Yabin Cui <yabinc@google.com>
> 
> It seems powerpc has the similar bug, then you need this:
> 
> Fixes: eb55b455ef9c ("perf/core: Add perf_sample_save_brstack() helper")

Is this really a bug? AFAICT it just does unneeded work, no?

