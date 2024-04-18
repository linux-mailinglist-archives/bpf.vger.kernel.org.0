Return-Path: <bpf+bounces-27168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D108AA405
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 22:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69081F22194
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 20:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76887184113;
	Thu, 18 Apr 2024 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVWE9koW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B974503A;
	Thu, 18 Apr 2024 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472059; cv=none; b=FnY2xdqyMVSwNBCD8y8uwjUaBe+jPR+vOgocUQ+7Ecl8L4p5iPLbzcf8Z122BdY9dN7ziE6kfUA0BcX4P4Z8WNQy/k2/kcFb+F8z6onqUHRl2m5lkb1cvUmHgISA922HwDmxUjgi6V6AkCKuAhuKmEB0jmiKz3Ctd+ofGpc9cvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472059; c=relaxed/simple;
	bh=56WvnS3f709B7K9RPGkczORnhOF3uY6m2yAEXZgpwNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pBj8/UsfuRco4p+L70HFWhjxzilwLvcL0r/QdBalCi74F0m/MHfzMoX7g7PLmNjD2CPDGEaPydY/bTgB5BCa2wwuQ9EgzLbZM/V6N0Z3fg9/oLJj/V/XL63aBMRjGb3CEfwA7/pIKq9dhqKAjDx2TWbCDoClOZXjYrAYu6v5xtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVWE9koW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713472058; x=1745008058;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=56WvnS3f709B7K9RPGkczORnhOF3uY6m2yAEXZgpwNA=;
  b=IVWE9koWD0uyIs6RnHA1/iziVe8vTygbJ/6eUzIbs7T7gJi/xpw+ci16
   I4wpVo5b1Q1lc4981iBPXHyvetScOZFcG4wXL/Qv+wsqD3THLmt3uI0hx
   ROFUNh/gz+EdxcRAWoqKPTkRkCLYfJtBpcCPhywRBbNF7D44KxjWBfPxF
   7qtk4u9UgDH/bycm/5HHopK9ZeAZsZi1XFXq5FZ5xgeVX8e0MTpEmSl+m
   DlLZMQR1/y5pkQr5oUuR4qU9xobF5yCYGlAeBSXIYyK/fzhn8f9WjRG9U
   rTfH/x+SR5aMunS0hGCwpgNzxKHROz4SusAv9qjW66lFa0uIEQPYjWRDW
   A==;
X-CSE-ConnectionGUID: BvQpMSHzSSW7vqubRI53kg==
X-CSE-MsgGUID: GXxCJSkPRb6XSVys8DGBVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="31527990"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="31527990"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 13:27:37 -0700
X-CSE-ConnectionGUID: 91hlfWN5QMq+K6lQWIka8w==
X-CSE-MsgGUID: O8kBm9WASfypw0PIe+8ARg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23728689"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 13:27:36 -0700
Received: from [10.212.69.180] (kliang2-mobl1.ccr.corp.intel.com [10.212.69.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id A2B38206DFDC;
	Thu, 18 Apr 2024 13:27:34 -0700 (PDT)
Message-ID: <ac8835f8-0ea5-4f28-941c-aa43f0da92fd@linux.intel.com>
Date: Thu, 18 Apr 2024 16:27:33 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] perf parse-events: Improve error message for bad
 numbers
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
 <20240416061533.921723-12-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240416061533.921723-12-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-16 2:15 a.m., Ian Rogers wrote:
> Use the error handler from the parse_state to give a more informative
> error message.
> 
> Before:
> ```
> $ perf stat -e 'cycles/period=99999999999999999999/' true
> event syntax error: 'cycles/period=99999999999999999999/'
>                                   \___ parser error
> Run 'perf list' for a list of valid events
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -e, --event <event>   event selector. use 'perf list' to list available events
> ```
> 
> After:
> ```
> $ perf stat -e 'cycles/period=99999999999999999999/' true
> event syntax error: 'cycles/period=99999999999999999999/'
>                                   \___ parser error
> 
> event syntax error: '..les/period=99999999999999999999/'
>                                   \___ Bad base 10 number "99999999999999999999"


It seems the patch only works for decimal?

./perf stat -e 'cycles/period=0xaaaaaaaaaaaaaaaaaaaaaa/' true
event syntax error: '..les/period=0xaaaaaaaaaaaaaaaaaaaaaa/'
                                   \___ parser error
 Run 'perf list' for a list of valid events

  Usage: perf stat [<options>] [<command>]

     -e, --event <event>   event selector. use 'perf list' to list
available events

Thanks,
Kan

> Run 'perf list' for a list of valid events
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -e, --event <event>   event selector. use 'perf list' to list available events
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.l | 40 ++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 6fe37003ab7b..0cd68c9f0d4f 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -18,26 +18,34 @@
>  
>  char *parse_events_get_text(yyscan_t yyscanner);
>  YYSTYPE *parse_events_get_lval(yyscan_t yyscanner);
> +int parse_events_get_column(yyscan_t yyscanner);
> +int parse_events_get_leng(yyscan_t yyscanner);
>  
> -static int __value(YYSTYPE *yylval, char *str, int base, int token)
> +static int get_column(yyscan_t scanner)
>  {
> -	u64 num;
> -
> -	errno = 0;
> -	num = strtoull(str, NULL, base);
> -	if (errno)
> -		return PE_ERROR;
> -
> -	yylval->num = num;
> -	return token;
> +	return parse_events_get_column(scanner) - parse_events_get_leng(scanner);
>  }
>  
> -static int value(yyscan_t scanner, int base)
> +static int value(struct parse_events_state *parse_state, yyscan_t scanner, int base)
>  {
>  	YYSTYPE *yylval = parse_events_get_lval(scanner);
>  	char *text = parse_events_get_text(scanner);
> +	u64 num;
>  
> -	return __value(yylval, text, base, PE_VALUE);
> +	errno = 0;
> +	num = strtoull(text, NULL, base);
> +	if (errno) {
> +		struct parse_events_error *error = parse_state->error;
> +		char *help = NULL;
> +
> +		if (asprintf(&help, "Bad base %d number \"%s\"", base, text) > 0)
> +			parse_events_error__handle(error, get_column(scanner), help , NULL);
> +
> +		return PE_ERROR;
> +	}
> +
> +	yylval->num = num;
> +	return PE_VALUE;
>  }
>  
>  static int str(yyscan_t scanner, int token)
> @@ -283,8 +291,8 @@ r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
>  	 */
>  "/"/{digit}		{ return PE_BP_SLASH; }
>  "/"/{non_digit}		{ BEGIN(config); return '/'; }
> -{num_dec}		{ return value(yyscanner, 10); }
> -{num_hex}		{ return value(yyscanner, 16); }
> +{num_dec}		{ return value(_parse_state, yyscanner, 10); }
> +{num_hex}		{ return value(_parse_state, yyscanner, 16); }
>  	/*
>  	 * We need to separate 'mem:' scanner part, in order to get specific
>  	 * modifier bits parsed out. Otherwise we would need to handle PE_NAME
> @@ -330,8 +338,8 @@ cgroup-switches					{ return sym(yyscanner, PERF_COUNT_SW_CGROUP_SWITCHES); }
>  {lc_type}-{lc_op_result}-{lc_op_result}	{ return str(yyscanner, PE_LEGACY_CACHE); }
>  mem:			{ BEGIN(mem); return PE_PREFIX_MEM; }
>  r{num_raw_hex}		{ return str(yyscanner, PE_RAW); }
> -{num_dec}		{ return value(yyscanner, 10); }
> -{num_hex}		{ return value(yyscanner, 16); }
> +{num_dec}		{ return value(_parse_state, yyscanner, 10); }
> +{num_hex}		{ return value(_parse_state, yyscanner, 16); }
>  
>  {modifier_event}	{ return str(yyscanner, PE_MODIFIER_EVENT); }
>  {name}			{ return str(yyscanner, PE_NAME); }

