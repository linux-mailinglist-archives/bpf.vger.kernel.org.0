Return-Path: <bpf+bounces-35554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D46793B714
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 20:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89141F21E42
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 18:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0259316B72D;
	Wed, 24 Jul 2024 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsIHHzZX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B6F15FD16;
	Wed, 24 Jul 2024 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847319; cv=none; b=opaDbeyh/ytBVLHQ1+r1/glZGRpB/7htfTnJ4xVTUbAumPnysOY+ueMqBHj+I97qa2Sdw4zMQEekYx0eoMVMyyB/tBruEyJC2bAnxxzAVZZFFacVvW72xSsBfNVzo+EJmlSRx5IGilWLfJC4RzZhLHYPC8eMBd2ZMmW1h2cXR8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847319; c=relaxed/simple;
	bh=rlG/8dnf1KAraBD+FOFlmAA8ApSszk1iCqtrP23infY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faDJrQKhJlM9L4oUPi7z29GVo2Hv5919NcUqo1hSC5FetabgqhWPK9wF/4e5x75N4RsfGae3eVyyb5uLrH0WPwN5S4qswwHQu9vmZLC36M8uSS4ZJsX6ByWVjmIvCtDcx8lISR2aVaiWNCyS9AtQLDrTR8MoYNEVjvPG6Hjhvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsIHHzZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA82C32781;
	Wed, 24 Jul 2024 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721847319;
	bh=rlG/8dnf1KAraBD+FOFlmAA8ApSszk1iCqtrP23infY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CsIHHzZXIDovJ1vxROZYDVKuM+hKYlQsH4eO0OvXsWjGrXneOvkaQr6uIESe8mlRi
	 N8+V7CAtB1uxyLP3aAdNY45pGkiXBAGWaqv8mMxFk0tNg77LfgbbAaqakNrWKQJZaB
	 U5MG92K8dC4jO4/iM9yGC13vG1TlF95M/QjoH1QRFDdm8M8RZe+nsu7Mtwf6mOkTtJ
	 MR8ovqSfilCurlzUImnP1lJc1nBEhUP2g7Zc/OxaNaZG1+AtnpAq3hgz5g04rhUkqT
	 qwy2hWhpdofSPZ7pXS+vyIN7TbmnLWbScWJydDDneec+xkMjL7eKc1CzHDJoY6LYue
	 Deq9jYOgc41dA==
Date: Wed, 24 Jul 2024 15:55:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
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
Message-ID: <ZqFOE9PkW39h2mHs@x1>
References: <20240703223035.2024586-1-namhyung@kernel.org>
 <20240703223035.2024586-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703223035.2024586-2-namhyung@kernel.org>

On Wed, Jul 03, 2024 at 03:30:28PM -0700, Namhyung Kim wrote:
> And the value is now an array.  This is to support multiple filter
> entries in the map later.
 
> No functional changes intended.

> +++ b/tools/perf/util/bpf-filter.c
> @@ -93,71 +93,102 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
>  
>  int perf_bpf_filter__prepare(struct evsel *evsel)
>  {
> -	int i, x, y, fd;
> +	int i, x, y, fd, ret;
>  	struct sample_filter_bpf *skel;
>  	struct bpf_program *prog;
>  	struct bpf_link *link;
>  	struct perf_bpf_filter_expr *expr;
> +	struct perf_bpf_filter_entry *entry;
> +
> +	entry = calloc(MAX_FILTERS, sizeof(*entry));
> +	if (entry == NULL)
> +		return -1;

I'm changing this to -ENOMEM since you use errno values in the other
failure cases, ok?

This:

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 2510832d83f95e03..e98bacf41a248ced 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -102,7 +102,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel)
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
 	if (entry == NULL)
-		return -1;
+		return -ENOMEM;
 
 	skel = sample_filter_bpf__open_and_load();
 	if (!skel) {

