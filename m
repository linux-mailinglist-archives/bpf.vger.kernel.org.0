Return-Path: <bpf+bounces-27169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709338AA40D
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 22:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2732828179D
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 20:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CC018413E;
	Thu, 18 Apr 2024 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrK/OL7z"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932136D1C7;
	Thu, 18 Apr 2024 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472338; cv=none; b=qxZXfQxzEWOfk6Wd6rzuq+VEMC/NJOvZBgfqZ2xo4rjrzF/soFPOCwnsxNBeVf90CazGHYl/NYCveuACU/WOMwiruw0Ewyo1oqqd7K/YI/eujAfgiupDrZ8cAzP1MHAhIY+G1qev/RWCyPEOMdSCxjpohuynlSbqHIV3g92bn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472338; c=relaxed/simple;
	bh=eTofrBW04ChmFYUj1jF175/NjHjz6OAzhp9fdW7bFVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fr3xtyzPdTX88Z42UrGZSotOvNeSqFK5xD5/+Pkwk0BIe3mr2dbzV5PJtHrF9sz/4Gl1nDNmlV/72ykVfTQSe0X0I+Mv4L5vdGRp3ltTiiXg1WOsLOlIQthZG0uJEICWCq1gxgzKznzeLvBWsoHEltXzIGtcWcmebZAC86InV48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrK/OL7z; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713472337; x=1745008337;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=eTofrBW04ChmFYUj1jF175/NjHjz6OAzhp9fdW7bFVg=;
  b=LrK/OL7znoMsCoBwSKm3RJONEfC1VxBvxy9CmH3KAEQFRCBmiaqtVeyq
   mklYvm41011h0UEDeEOZJC7m6MD3s0Orv92JEWlrie+PNsPyH+2lp990W
   f7Ojd15mqJYAkLKV9vh2mbqUHtJZL8nnYg5tHdkl7/ssURQ0ToxsS9fn+
   75ZL6+uRk/lrOe76Y3AsR1xh6bJaOksO7Wb3jC7w7NqFHHsR3Jv8bbu4O
   JmPdvkeD/HgabWcq2SQ0ZlXmJPP2rQVqlCwmllYcMb+GeHXmfWl6dc13E
   Q0jAURxFKAs3A974dE8JtsmxmquSq29nqFXKnM1/c3hF+s2T1HtYiu3MS
   w==;
X-CSE-ConnectionGUID: 5TKy305OQBaWBt/R14BV9w==
X-CSE-MsgGUID: 7VcqoL1TRzS1DJiYgFi4Sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9221383"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="9221383"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 13:32:15 -0700
X-CSE-ConnectionGUID: ZfGHhgzCSyO50yWFFQQtXw==
X-CSE-MsgGUID: cAKm/VLgR66gY2j5jJDnqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27732040"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 13:32:14 -0700
Received: from [10.212.69.180] (kliang2-mobl1.ccr.corp.intel.com [10.212.69.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 87454206DFDC;
	Thu, 18 Apr 2024 13:32:12 -0700 (PDT)
Message-ID: <e8147f53-1930-44d8-abb8-fee460ec355f@linux.intel.com>
Date: Thu, 18 Apr 2024 16:32:11 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] perf parse-events: Improvements to modifier
 parsing
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org,
 Beeman Strong <beeman@rivosinc.com>
References: <20240416061533.921723-1-irogers@google.com>
 <20240416061533.921723-14-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240416061533.921723-14-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-16 2:15 a.m., Ian Rogers wrote:
> Use a struct/bitmap rather than a copied string from lexer.
> 
> In lexer give improved error message when too many precise flags are
> given or repeated modifiers.
> 
> Before:
> ```
> $ perf stat -e 'cycles:kuk' true
> event syntax error: 'cycles:kuk'
>                             \___ Bad modifier
> ...
> $ perf stat -e 'cycles:pppp' true
> event syntax error: 'cycles:pppp'
>                             \___ Bad modifier
> ...
> $ perf stat -e '{instructions:p,cycles:pp}:pp' -a true
> event syntax error: '..cycles:pp}:pp'
>                                   \___ Bad modifier
> ...
> ```
> After:
> ```
> $ perf stat -e 'cycles:kuk' true
> event syntax error: 'cycles:kuk'
>                               \___ Duplicate modifier 'k' (kernel)
> ...
> $ perf stat -e 'cycles:pppp' true
> event syntax error: 'cycles:pppp'
>                                \___ Maximum precise value is 3
> ...
> $ perf stat -e '{instructions:p,cycles:pp}:pp' true
> event syntax error: '..cycles:pp}:pp'
>                                   \___ Maximum combined precise value is 3, adding precision to "cycles:pp"
> ...
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 250 ++++++++++++---------------------
>  tools/perf/util/parse-events.h |  23 ++-
>  tools/perf/util/parse-events.l |  75 +++++++++-
>  tools/perf/util/parse-events.y |  28 +---
>  4 files changed, 194 insertions(+), 182 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index ebada37ef98a..3ab533d0e653 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1700,12 +1700,6 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
>  	return -EINVAL;
>  }
>  
> -int parse_events__modifier_group(struct list_head *list,
> -				 char *event_mod)
> -{
> -	return parse_events__modifier_event(list, event_mod, true);
> -}
> -
>  void parse_events__set_leader(char *name, struct list_head *list)
>  {
>  	struct evsel *leader;
> @@ -1720,183 +1714,125 @@ void parse_events__set_leader(char *name, struct list_head *list)
>  	leader->group_name = name;
>  }
>  
> -struct event_modifier {
> -	int eu;
> -	int ek;
> -	int eh;
> -	int eH;
> -	int eG;
> -	int eI;
> -	int precise;
> -	int precise_max;
> -	int exclude_GH;
> -	int sample_read;
> -	int pinned;
> -	int weak;
> -	int exclusive;
> -	int bpf_counter;
> -};
> +static int parse_events__modifier_list(struct parse_events_state *parse_state,
> +				       YYLTYPE *loc,
> +				       struct list_head *list,
> +				       struct parse_events_modifier mod,
> +				       bool group)
> +{
> +	struct evsel *evsel;
>  
> -static int get_event_modifier(struct event_modifier *mod, char *str,
> -			       struct evsel *evsel)
> -{
> -	int eu = evsel ? evsel->core.attr.exclude_user : 0;
> -	int ek = evsel ? evsel->core.attr.exclude_kernel : 0;
> -	int eh = evsel ? evsel->core.attr.exclude_hv : 0;
> -	int eH = evsel ? evsel->core.attr.exclude_host : 0;
> -	int eG = evsel ? evsel->core.attr.exclude_guest : 0;
> -	int eI = evsel ? evsel->core.attr.exclude_idle : 0;
> -	int precise = evsel ? evsel->core.attr.precise_ip : 0;
> -	int precise_max = 0;
> -	int sample_read = 0;
> -	int pinned = evsel ? evsel->core.attr.pinned : 0;
> -	int exclusive = evsel ? evsel->core.attr.exclusive : 0;
> -
> -	int exclude = eu | ek | eh;
> -	int exclude_GH = evsel ? evsel->exclude_GH : 0;
> -	int weak = 0;
> -	int bpf_counter = 0;
> -
> -	memset(mod, 0, sizeof(*mod));
> -
> -	while (*str) {
> -		if (*str == 'u') {
> +	if (!group && mod.weak) {
> +		parse_events_error__handle(parse_state->error, loc->first_column,
> +					   strdup("Weak modifier is for use with groups"), NULL);
> +		return -EINVAL;
> +	}
> +
> +	__evlist__for_each_entry(list, evsel) {
> +		/* Translate modifiers into the equivalent evsel excludes. */
> +		int eu = group ? evsel->core.attr.exclude_user : 0;
> +		int ek = group ? evsel->core.attr.exclude_kernel : 0;
> +		int eh = group ? evsel->core.attr.exclude_hv : 0;
> +		int eH = group ? evsel->core.attr.exclude_host : 0;
> +		int eG = group ? evsel->core.attr.exclude_guest : 0;
> +		int exclude = eu | ek | eh;
> +		int exclude_GH = group ? evsel->exclude_GH : 0;
> +
> +		if (mod.precise) {
> +			/* use of precise requires exclude_guest */
> +			eG = 1;
> +		}
> +		if (mod.user) {
>  			if (!exclude)
>  				exclude = eu = ek = eh = 1;
>  			if (!exclude_GH && !perf_guest)
>  				eG = 1;
>  			eu = 0;
> -		} else if (*str == 'k') {
> +		}
> +		if (mod.kernel) {
>  			if (!exclude)
>  				exclude = eu = ek = eh = 1;
>  			ek = 0;
> -		} else if (*str == 'h') {
> +		}
> +		if (mod.hypervisor) {
>  			if (!exclude)
>  				exclude = eu = ek = eh = 1;
>  			eh = 0;
> -		} else if (*str == 'G') {
> +		}
> +		if (mod.guest) {
>  			if (!exclude_GH)
>  				exclude_GH = eG = eH = 1;
>  			eG = 0;
> -		} else if (*str == 'H') {
> +		}
> +		if (mod.host) {
>  			if (!exclude_GH)
>  				exclude_GH = eG = eH = 1;
>  			eH = 0;
> -		} else if (*str == 'I') {
> -			eI = 1;
> -		} else if (*str == 'p') {
> -			precise++;
> -			/* use of precise requires exclude_guest */
> -			if (!exclude_GH)
> -				eG = 1;
> -		} else if (*str == 'P') {
> -			precise_max = 1;
> -		} else if (*str == 'S') {
> -			sample_read = 1;
> -		} else if (*str == 'D') {
> -			pinned = 1;
> -		} else if (*str == 'e') {
> -			exclusive = 1;
> -		} else if (*str == 'W') {
> -			weak = 1;
> -		} else if (*str == 'b') {
> -			bpf_counter = 1;
> -		} else
> -			break;
> -
> -		++str;
> +		}
> +		evsel->core.attr.exclude_user   = eu;
> +		evsel->core.attr.exclude_kernel = ek;
> +		evsel->core.attr.exclude_hv     = eh;
> +		evsel->core.attr.exclude_host   = eH;
> +		evsel->core.attr.exclude_guest  = eG;
> +		evsel->exclude_GH               = exclude_GH;
> +
> +		/* Simple modifiers copied to the evsel. */
> +		if (mod.precise) {
> +			u8 precise = evsel->core.attr.precise_ip + mod.precise;
> +			/*
> +			 * precise ip:
> +			 *
> +			 *  0 - SAMPLE_IP can have arbitrary skid
> +			 *  1 - SAMPLE_IP must have constant skid
> +			 *  2 - SAMPLE_IP requested to have 0 skid
> +			 *  3 - SAMPLE_IP must have 0 skid
> +			 *
> +			 *  See also PERF_RECORD_MISC_EXACT_IP
> +			 */
> +			if (precise > 3) {

The pmu_max_precise() should return the max precise the current kernel
supports. It checks the /sys/devices/cpu/caps/max_precise.

I think we should use that value rather than hard code it to 3.

Thanks,
Kan

> +				char *help;
> +
> +				if (asprintf(&help,
> +					     "Maximum combined precise value is 3, adding precision to \"%s\"",
> +					     evsel__name(evsel)) > 0) {
> +					parse_events_error__handle(parse_state->error,
> +								   loc->first_column,
> +								   help, NULL);
> +				}
> +				return -EINVAL;
> +			}
> +			evsel->core.attr.precise_ip = precise;
> +		}
> +		if (mod.precise_max)
> +			evsel->precise_max = 1;
> +		if (mod.non_idle)
> +			evsel->core.attr.exclude_idle = 1;
> +		if (mod.sample_read)
> +			evsel->sample_read = 1;
> +		if (mod.pinned && evsel__is_group_leader(evsel))
> +			evsel->core.attr.pinned = 1;
> +		if (mod.exclusive && evsel__is_group_leader(evsel))
> +			evsel->core.attr.exclusive = 1;
> +		if (mod.weak)
> +			evsel->weak_group = true;
> +		if (mod.bpf)
> +			evsel->bpf_counter = true;
>  	}
> -
> -	/*
> -	 * precise ip:
> -	 *
> -	 *  0 - SAMPLE_IP can have arbitrary skid
> -	 *  1 - SAMPLE_IP must have constant skid
> -	 *  2 - SAMPLE_IP requested to have 0 skid
> -	 *  3 - SAMPLE_IP must have 0 skid
> -	 *
> -	 *  See also PERF_RECORD_MISC_EXACT_IP
> -	 */
> -	if (precise > 3)
> -		return -EINVAL;
> -
> -	mod->eu = eu;
> -	mod->ek = ek;
> -	mod->eh = eh;
> -	mod->eH = eH;
> -	mod->eG = eG;
> -	mod->eI = eI;
> -	mod->precise = precise;
> -	mod->precise_max = precise_max;
> -	mod->exclude_GH = exclude_GH;
> -	mod->sample_read = sample_read;
> -	mod->pinned = pinned;
> -	mod->weak = weak;
> -	mod->bpf_counter = bpf_counter;
> -	mod->exclusive = exclusive;
> -
>  	return 0;
>  }
>  
> -/*
> - * Basic modifier sanity check to validate it contains only one
> - * instance of any modifier (apart from 'p') present.
> - */
> -static int check_modifier(char *str)
> +int parse_events__modifier_group(struct parse_events_state *parse_state, void *loc,
> +				 struct list_head *list,
> +				 struct parse_events_modifier mod)
>  {
> -	char *p = str;
> -
> -	/* The sizeof includes 0 byte as well. */
> -	if (strlen(str) > (sizeof("ukhGHpppPSDIWeb") - 1))
> -		return -1;
> -
> -	while (*p) {
> -		if (*p != 'p' && strchr(p + 1, *p))
> -			return -1;
> -		p++;
> -	}
> -
> -	return 0;
> +	return parse_events__modifier_list(parse_state, loc, list, mod, /*group=*/true);
>  }
>  
> -int parse_events__modifier_event(struct list_head *list, char *str, bool add)
> +int parse_events__modifier_event(struct parse_events_state *parse_state, void *loc,
> +				 struct list_head *list,
> +				 struct parse_events_modifier mod)
>  {
> -	struct evsel *evsel;
> -	struct event_modifier mod;
> -
> -	if (str == NULL)
> -		return 0;
> -
> -	if (check_modifier(str))
> -		return -EINVAL;
> -
> -	if (!add && get_event_modifier(&mod, str, NULL))
> -		return -EINVAL;
> -
> -	__evlist__for_each_entry(list, evsel) {
> -		if (add && get_event_modifier(&mod, str, evsel))
> -			return -EINVAL;
> -
> -		evsel->core.attr.exclude_user   = mod.eu;
> -		evsel->core.attr.exclude_kernel = mod.ek;
> -		evsel->core.attr.exclude_hv     = mod.eh;
> -		evsel->core.attr.precise_ip     = mod.precise;
> -		evsel->core.attr.exclude_host   = mod.eH;
> -		evsel->core.attr.exclude_guest  = mod.eG;
> -		evsel->core.attr.exclude_idle   = mod.eI;
> -		evsel->exclude_GH          = mod.exclude_GH;
> -		evsel->sample_read         = mod.sample_read;
> -		evsel->precise_max         = mod.precise_max;
> -		evsel->weak_group	   = mod.weak;
> -		evsel->bpf_counter	   = mod.bpf_counter;
> -
> -		if (evsel__is_group_leader(evsel)) {
> -			evsel->core.attr.pinned = mod.pinned;
> -			evsel->core.attr.exclusive = mod.exclusive;
> -		}
> -	}
> -
> -	return 0;
> +	return parse_events__modifier_list(parse_state, loc, list, mod, /*group=*/false);
>  }
>  
>  int parse_events_name(struct list_head *list, const char *name)
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 290ae6c72ec5..f104faef1a78 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -186,8 +186,27 @@ void parse_events_terms__init(struct parse_events_terms *terms);
>  void parse_events_terms__exit(struct parse_events_terms *terms);
>  int parse_events_terms(struct parse_events_terms *terms, const char *str, FILE *input);
>  int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct strbuf *sb);
> -int parse_events__modifier_event(struct list_head *list, char *str, bool add);
> -int parse_events__modifier_group(struct list_head *list, char *event_mod);
> +
> +struct parse_events_modifier {
> +	u8 precise;	/* Number of repeated 'p' for precision. */
> +	bool precise_max : 1;	/* 'P' */
> +	bool non_idle : 1;	/* 'I' */
> +	bool sample_read : 1;	/* 'S' */
> +	bool pinned : 1;	/* 'D' */
> +	bool exclusive : 1;	/* 'e' */
> +	bool weak : 1;		/* 'W' */
> +	bool bpf : 1;		/* 'b' */
> +	bool user : 1;		/* 'u' */
> +	bool kernel : 1;	/* 'k' */
> +	bool hypervisor : 1;	/* 'h' */
> +	bool guest : 1;		/* 'G' */
> +	bool host : 1;		/* 'H' */
> +};
> +
> +int parse_events__modifier_event(struct parse_events_state *parse_state, void *loc,
> +				 struct list_head *list, struct parse_events_modifier mod);
> +int parse_events__modifier_group(struct parse_events_state *parse_state, void *loc,
> +				 struct list_head *list, struct parse_events_modifier mod);
>  int parse_events_name(struct list_head *list, const char *name);
>  int parse_events_add_tracepoint(struct list_head *list, int *idx,
>  				const char *sys, const char *event,
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 0cd68c9f0d4f..4aaf0c53d9b6 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -142,6 +142,77 @@ static int hw(yyscan_t scanner, int config)
>  	return PE_TERM_HW;
>  }
>  
> +static void modifiers_error(struct parse_events_state *parse_state, yyscan_t scanner,
> +			    int pos, char mod_char, const char *mod_name)
> +{
> +	struct parse_events_error *error = parse_state->error;
> +	char *help = NULL;
> +
> +	if (asprintf(&help, "Duplicate modifier '%c' (%s)", mod_char, mod_name) > 0)
> +		parse_events_error__handle(error, get_column(scanner) + pos, help , NULL);
> +}
> +
> +static int modifiers(struct parse_events_state *parse_state, yyscan_t scanner)
> +{
> +	YYSTYPE *yylval = parse_events_get_lval(scanner);
> +	char *text = parse_events_get_text(scanner);
> +	struct parse_events_modifier mod = { .precise = 0, };
> +
> +	for (size_t i = 0, n = strlen(text); i < n; i++) {
> +#define CASE(c, field)							\
> +		case c:							\
> +			if (mod.field) {				\
> +				modifiers_error(parse_state, scanner, i, c, #field); \
> +				return PE_ERROR;			\
> +			}						\
> +			mod.field = true;				\
> +			break
> +
> +		switch (text[i]) {
> +		CASE('u', user);
> +		CASE('k', kernel);
> +		CASE('h', hypervisor);
> +		CASE('I', non_idle);
> +		CASE('G', guest);
> +		CASE('H', host);
> +		case 'p':
> +			mod.precise++;
> +			/*
> +			 * precise ip:
> +			 *
> +			 *  0 - SAMPLE_IP can have arbitrary skid
> +			 *  1 - SAMPLE_IP must have constant skid
> +			 *  2 - SAMPLE_IP requested to have 0 skid
> +			 *  3 - SAMPLE_IP must have 0 skid
> +			 *
> +			 *  See also PERF_RECORD_MISC_EXACT_IP
> +			 */
> +			if (mod.precise > 3) {
> +				struct parse_events_error *error = parse_state->error;
> +				char *help = strdup("Maximum precise value is 3");
> +
> +				if (help) {
> +					parse_events_error__handle(error, get_column(scanner) + i,
> +								   help , NULL);
> +				}
> +				return PE_ERROR;
> +			}
> +			break;
> +		CASE('P', precise_max);
> +		CASE('S', sample_read);
> +		CASE('D', pinned);
> +		CASE('W', weak);
> +		CASE('e', exclusive);
> +		CASE('b', bpf);
> +		default:
> +			return PE_ERROR;
> +		}
> +#undef CASE
> +	}
> +	yylval->mod = mod;
> +	return PE_MODIFIER_EVENT;
> +}
> +
>  #define YY_USER_ACTION					\
>  do {							\
>  	yylloc->last_column  = yylloc->first_column;	\
> @@ -174,7 +245,7 @@ drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
>   * If you add a modifier you need to update check_modifier().
>   * Also, the letters in modifier_event must not be in modifier_bp.
>   */
> -modifier_event	[ukhpPGHSDIWeb]+
> +modifier_event	[ukhpPGHSDIWeb]{1,15}
>  modifier_bp	[rwx]{1,3}
>  lc_type 	(L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruction|LLC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|bpu|btb|bpc|node)
>  lc_op_result	(load|loads|read|store|stores|write|prefetch|prefetches|speculative-read|speculative-load|refs|Reference|ops|access|misses|miss)
> @@ -341,7 +412,7 @@ r{num_raw_hex}		{ return str(yyscanner, PE_RAW); }
>  {num_dec}		{ return value(_parse_state, yyscanner, 10); }
>  {num_hex}		{ return value(_parse_state, yyscanner, 16); }
>  
> -{modifier_event}	{ return str(yyscanner, PE_MODIFIER_EVENT); }
> +{modifier_event}	{ return modifiers(_parse_state, yyscanner); }
>  {name}			{ return str(yyscanner, PE_NAME); }
>  {name_tag}		{ return str(yyscanner, PE_NAME); }
>  "/"			{ BEGIN(config); return '/'; }
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 2c4817e126c1..79f254189be6 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -68,11 +68,11 @@ static void free_list_evsel(struct list_head* list_evsel)
>  %type <num> PE_VALUE
>  %type <num> PE_VALUE_SYM_SW
>  %type <num> PE_VALUE_SYM_TOOL
> +%type <mod> PE_MODIFIER_EVENT
>  %type <term_type> PE_TERM
>  %type <str> PE_RAW
>  %type <str> PE_NAME
>  %type <str> PE_LEGACY_CACHE
> -%type <str> PE_MODIFIER_EVENT
>  %type <str> PE_MODIFIER_BP
>  %type <str> PE_EVENT_NAME
>  %type <str> PE_DRV_CFG_TERM
> @@ -110,6 +110,7 @@ static void free_list_evsel(struct list_head* list_evsel)
>  {
>  	char *str;
>  	u64 num;
> +	struct parse_events_modifier mod;
>  	enum parse_events__term_type term_type;
>  	struct list_head *list_evsel;
>  	struct parse_events_terms *list_terms;
> @@ -175,20 +176,13 @@ event
>  group:
>  group_def ':' PE_MODIFIER_EVENT
>  {
> +	/* Apply the modifier to the events in the group_def. */
>  	struct list_head *list = $1;
>  	int err;
>  
> -	err = parse_events__modifier_group(list, $3);
> -	free($3);
> -	if (err) {
> -		struct parse_events_state *parse_state = _parse_state;
> -		struct parse_events_error *error = parse_state->error;
> -
> -		parse_events_error__handle(error, @3.first_column,
> -					   strdup("Bad modifier"), NULL);
> -		free_list_evsel(list);
> +	err = parse_events__modifier_group(_parse_state, &@3, list, $3);
> +	if (err)
>  		YYABORT;
> -	}
>  	$$ = list;
>  }
>  |
> @@ -238,17 +232,9 @@ event_name PE_MODIFIER_EVENT
>  	 * (there could be more events added for multiple tracepoint
>  	 * definitions via '*?'.
>  	 */
> -	err = parse_events__modifier_event(list, $2, false);
> -	free($2);
> -	if (err) {
> -		struct parse_events_state *parse_state = _parse_state;
> -		struct parse_events_error *error = parse_state->error;
> -
> -		parse_events_error__handle(error, @2.first_column,
> -					   strdup("Bad modifier"), NULL);
> -		free_list_evsel(list);
> +	err = parse_events__modifier_event(_parse_state, &@2, list, $2);
> +	if (err)
>  		YYABORT;
> -	}
>  	$$ = list;
>  }
>  |

