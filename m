Return-Path: <bpf+bounces-59905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 962C3AD079D
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 19:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E4217AB93
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0554828BAA9;
	Fri,  6 Jun 2025 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyakNKYa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770AC17BEBF;
	Fri,  6 Jun 2025 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749231693; cv=none; b=uwKTDst8v8hsGfBsToUE5KPq3dKm0r0l2ZBTAzRUPEg2EM2rEOzCtRQetzKYYY2F8k1mzNffN6ogNcVZ61IOhIrM4GoAYutUP8mL1+gSzZs7iHEayq25mZr2xKYvfU9RCFgp/c4Zafdqnd/BLtYYBT1DxTnkFuPsGSsxv/qyK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749231693; c=relaxed/simple;
	bh=3z6gULRGSAh8REL27ME7jEm4UNqexttqJzi/Uxti4Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjZdL3uwvV6rxj+W//VpR0s9reu7y4L6CeqpSB0sbhVeQzo58Moq1pcya+PZGUBw0YG73NxAxpUTxbd5GeSK3es7iGOetbDlYzDRkryKM3tdgH0AscOWowdP2fnXXay6CY7us4fF9YDeLfOpjVh3Iqd8pXrvIWGvdliKPFZC/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyakNKYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEF6C4CEEB;
	Fri,  6 Jun 2025 17:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749231693;
	bh=3z6gULRGSAh8REL27ME7jEm4UNqexttqJzi/Uxti4Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AyakNKYao0384/Y3+jQCnOMZgtIbDe/6wyxxjl4mkAVrS5d9QGD+B5QjXFDOzK9l+
	 EK7afY3ouo3XY2ce/KMQtj+PO5TCTAZVT4g/Zn9QGdXtbgxvcoUrf2JvyKgk82Y3TE
	 AroqJ7SqG/antp1vWkHoOLOvjnuDGrRytjOlLVfJm8ek4bEhKoLPiAkYrf1e1EyXKY
	 2NTQTsfLWsayAWRsNPLiaqimK+iRIr1wHdCuoWemXbuAdn38p+hnlNTNKQ52xTF26b
	 xJEzcBktSyjlGRxe7rWstJdXlvcNIdgDcxuAk+hBYGzBEjjDubnrf1lM/cIB0HBX9b
	 f9C6EnmaPd9kw==
Date: Fri, 6 Jun 2025 10:41:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Chun-Tse Shao <ctshao@google.com>, Leo Yan <leo.yan@arm.com>,
	Hao Ge <gehao@kylinos.cn>, Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Tengda Wu <wutengda@huaweicloud.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 03/10] perf parse-events: Add parse_uid_filter helper
Message-ID: <aEMoSj0kmWo9LEaF@google.com>
References: <20250604174545.2853620-1-irogers@google.com>
 <20250604174545.2853620-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604174545.2853620-4-irogers@google.com>

Hi Ian,

On Wed, Jun 04, 2025 at 10:45:37AM -0700, Ian Rogers wrote:
> Add parse_uid_filter filter as a helper to parse_filter, that
> constructs a uid filter string. As uid filters don't work with
> tracepoint filters, add a is_possible_tp_filter function so the
> tracepoint filter isn't attempted for tracepoint evsels.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 33 ++++++++++++++++++++++++++++++++-
>  tools/perf/util/parse-events.h |  1 +
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index d96adf23dc94..7f34e602fc08 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -25,6 +25,7 @@
>  #include "pmu.h"
>  #include "pmus.h"
>  #include "asm/bug.h"
> +#include "ui/ui.h"
>  #include "util/parse-branch-options.h"
>  #include "util/evsel_config.h"
>  #include "util/event.h"
> @@ -2561,6 +2562,12 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
>  	return 0;
>  }
>  
> +/* Will a tracepoint filter work for str or should a BPF filter be used? */
> +static bool is_possible_tp_filter(const char *str)
> +{
> +	return strstr(str, "uid") == NULL;
> +}
> +
>  static int set_filter(struct evsel *evsel, const void *arg)
>  {
>  	const char *str = arg;
> @@ -2573,7 +2580,7 @@ static int set_filter(struct evsel *evsel, const void *arg)
>  		return -1;
>  	}
>  
> -	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
> +	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT && is_possible_tp_filter(str)) {
>  		if (evsel__append_tp_filter(evsel, str) < 0) {
>  			fprintf(stderr,
>  				"not enough memory to hold filter string\n");
> @@ -2609,6 +2616,30 @@ int parse_filter(const struct option *opt, const char *str,
>  					  (const void *)str);
>  }
>  
> +int parse_uid_filter(struct evlist *evlist, uid_t uid)

It failed to build on alpine 3.18.

util/parse-events.h:48:45: error: unknown type name 'uid_t'                     
   48 | int parse_uid_filter(struct evlist *evlist, uid_t uid);                 
      |                                             ^~~~~

I'll add this.

Thanks,
Namhyung


---8<---
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index ab242f6710313993..931780911e071ec6 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -11,6 +11,7 @@
 #include <linux/perf_event.h>
 #include <stdio.h>
 #include <string.h>
+#include <sys/types.h>
 
 struct evsel;
 struct evlist;



> +{
> +	struct option opt = {
> +		.value = &evlist,
> +	};
> +	char buf[128];
> +	int ret;
> +
> +	snprintf(buf, sizeof(buf), "uid == %d", uid);
> +	ret = parse_filter(&opt, buf, /*unset=*/0);
> +	if (ret) {
> +		if (use_browser >= 1) {
> +			/*
> +			 * Use ui__warning so a pop up appears above the
> +			 * underlying BPF error message.
> +			 */
> +			ui__warning("Failed to add UID filtering that uses BPF filtering.\n");
> +		} else {
> +			fprintf(stderr, "Failed to add UID filtering that uses BPF filtering.\n");
> +		}
> +	}
> +	return ret;
> +}
> +
>  static int add_exclude_perf_filter(struct evsel *evsel,
>  				   const void *arg __maybe_unused)
>  {
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index ab242f671031..46e5a01be61c 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -45,6 +45,7 @@ static inline int parse_events(struct evlist *evlist, const char *str,
>  int parse_event(struct evlist *evlist, const char *str);
>  
>  int parse_filter(const struct option *opt, const char *str, int unset);
> +int parse_uid_filter(struct evlist *evlist, uid_t uid);
>  int exclude_perf(const struct option *opt, const char *arg, int unset);
>  
>  enum parse_events__term_val_type {
> -- 
> 2.50.0.rc0.604.gd4ff7b7c86-goog
> 

