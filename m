Return-Path: <bpf+bounces-35558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777CA93B7DF
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 22:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37271F24A02
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 20:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C266F16D4D5;
	Wed, 24 Jul 2024 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mes+7MTw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04416D308;
	Wed, 24 Jul 2024 20:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852066; cv=none; b=Zm/sxD7FDTsV/92IJ6Ol25az44pZ0zurjQZqKY4UFRaQIxZE62Yku2UlPoLxpzW+Wz6g2kvQiFF4ipNUEj6YrR43lVe2MUtx1YDn+dyrzZSizwT4loIBw7JYXjU5tS2pPLtM+w97lUU45envm0Tz991veTu/SgbRJd7FfIbyChc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852066; c=relaxed/simple;
	bh=Ld5TTZZvSCCpJ3mjdBpoxxWL7Cw7l77HwOaRxvieC9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgI1uBz7LX4TGVA9b5+GKVl326XtQSSyzfAy4OIEEY+aDpDaZk0VERXyrDTVwy9/pPaMrSNhrSW1OudWfLX1TRJcxLNVqBTIm4xJ/Tb2JkjM72Lg1RMmwa4HL6JfNMaXykMyfIhXoQAZbtO9fF72y3bBu4jqIxG7n+ORRRH89tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mes+7MTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8A0C32781;
	Wed, 24 Jul 2024 20:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721852065;
	bh=Ld5TTZZvSCCpJ3mjdBpoxxWL7Cw7l77HwOaRxvieC9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mes+7MTwYOjqG2WHET0ycKTG2QOwJDVWmWx6g5NMJAFWj0le5/6MXIMNLY4GSvVe4
	 0wCqKG20FvLjjQ6GS/sTtLv25IJj2SlGaZejTeaGq9qOi4MM4HzqF5Yz2WNATc1q4/
	 ISkxEfwBC5YmTQbfnBVATlt+X+HZncfr8wGvBIm8GttJ+9eLmjUtVK37wnwD+ndaDV
	 0NyvXCMOamJMKXkTv3tO6F0iYbFhgiyDo1NoXAGQmjegYaOA2iE06A2u+eLDgnMrC4
	 deLcjyEHAxO0xYu4O1TsYOv3P+7Z9GZyHWM3SUv763BU0Y4EKP1Vc+dK49BbSiWDKx
	 0XKOmwQTByyIA==
Date: Wed, 24 Jul 2024 13:14:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
	Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 1/8] perf bpf-filter: Make filters map a single entry
 hashmap
Message-ID: <ZqFgnwK5ZSjmEAQj@google.com>
References: <20240703223035.2024586-1-namhyung@kernel.org>
 <20240703223035.2024586-2-namhyung@kernel.org>
 <ZqFOE9PkW39h2mHs@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqFOE9PkW39h2mHs@x1>

On Wed, Jul 24, 2024 at 03:55:15PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jul 03, 2024 at 03:30:28PM -0700, Namhyung Kim wrote:
> > And the value is now an array.  This is to support multiple filter
> > entries in the map later.
>  
> > No functional changes intended.
> 
> > +++ b/tools/perf/util/bpf-filter.c
> > @@ -93,71 +93,102 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
> >  
> >  int perf_bpf_filter__prepare(struct evsel *evsel)
> >  {
> > -	int i, x, y, fd;
> > +	int i, x, y, fd, ret;
> >  	struct sample_filter_bpf *skel;
> >  	struct bpf_program *prog;
> >  	struct bpf_link *link;
> >  	struct perf_bpf_filter_expr *expr;
> > +	struct perf_bpf_filter_entry *entry;
> > +
> > +	entry = calloc(MAX_FILTERS, sizeof(*entry));
> > +	if (entry == NULL)
> > +		return -1;
> 
> I'm changing this to -ENOMEM since you use errno values in the other
> failure cases, ok?

Sure thing!

Thanks,
Namhyung

> 
> This:
> 
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 2510832d83f95e03..e98bacf41a248ced 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -102,7 +102,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel)
>  
>  	entry = calloc(MAX_FILTERS, sizeof(*entry));
>  	if (entry == NULL)
> -		return -1;
> +		return -ENOMEM;
>  
>  	skel = sample_filter_bpf__open_and_load();
>  	if (!skel) {

