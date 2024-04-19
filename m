Return-Path: <bpf+bounces-27221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA218AAF54
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 15:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9D11C2258D
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C7912AAEA;
	Fri, 19 Apr 2024 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/YqfsUo"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188A18624B;
	Fri, 19 Apr 2024 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533375; cv=none; b=fVToMUSWXOz8C2UPnIUxip0qajkOxukYJGLyHS5HBKX12HqayhmVL2MUNcPuFNqrtKXC5PARdHvc7A34rECAhT4FaenrwUBY/zK2xPSQ4sflZ/CqwiEjlx2IFKR6B4T2FYWlEwYjF73YKiZJhTE2zWxIugh2RXuBJ2T8AIcdeJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533375; c=relaxed/simple;
	bh=xqswkRP7xC0Owgm1HP3Ch7pzBLg7hHvhZLq55WlfYmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kF4xM79n4cYPRfveKJuyvetD3jKDMQMrn3VFuAUAdqDgg++3gaWCvjMR0YIVGjER2HNn5r6uolaLAtsdxk2ic3dgZRYdOaOYzgVR8wH3B35idC2FMg/QDVn6inSJ3tuxr51dc2dgHf8VlvR11x0YAi/KYwXn2TRWtLgXv4KuSG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/YqfsUo; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713533374; x=1745069374;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xqswkRP7xC0Owgm1HP3Ch7pzBLg7hHvhZLq55WlfYmA=;
  b=G/YqfsUobzZuKErbVGvkMQL7qWJtwsgCXUFmQ7UZXtROPqJKv8Zj6uHU
   ujR0NB6OT/elaoz5gPk6YSldABNndzP6gtk2OphUfaxDxW5lnL0CvAbUn
   5uStNIHe5vmZf3U/wKhmyKH+qpKjmYEMd0hwbPWn6kGe0jTG1W4JX2xly
   s9jqw2lwWAfYnkDvIjEAcjBQtOjtzAUxUIoD7yQJMgfjQO+6JQ21hZO7Z
   ijIC0fQFhPg9EoZpDK1x36Z9ePpVuCQszTUpjm4IC951NwTikIjS83Uil
   at+ZON89h5KBMJFTmJjj3uHVn6rKp4drDnrBD1LJ0/cfUu/f4IvP4Sq8c
   w==;
X-CSE-ConnectionGUID: wvmv7zS/QRqsBwevIzrJhg==
X-CSE-MsgGUID: me4/i6M7S92W8vJeE6bNxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="34532021"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="34532021"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:29:33 -0700
X-CSE-ConnectionGUID: 0uQgHtY/QgmveFusb3jeJg==
X-CSE-MsgGUID: Tld8xbNRRUC14a6jfp668A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27986170"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:29:33 -0700
Received: from [10.212.13.6] (dojung-mobl.amr.corp.intel.com [10.212.13.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9E16F206DFDC;
	Fri, 19 Apr 2024 06:29:30 -0700 (PDT)
Message-ID: <7a576651-6780-41a5-ac69-46ce299367b5@linux.intel.com>
Date: Fri, 19 Apr 2024 09:29:29 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] perf parse-events: Improve error message for bad
 numbers
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org,
 Beeman Strong <beeman@rivosinc.com>
References: <20240416061533.921723-1-irogers@google.com>
 <20240416061533.921723-12-irogers@google.com>
 <ac8835f8-0ea5-4f28-941c-aa43f0da92fd@linux.intel.com>
 <CAP-5=fXkn-nFTqGEqBYt6NUvoXU7OyLJeSCnWdD3taLHyK-xtQ@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fXkn-nFTqGEqBYt6NUvoXU7OyLJeSCnWdD3taLHyK-xtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-04-18 5:07 p.m., Ian Rogers wrote:
> On Thu, Apr 18, 2024 at 1:27 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-04-16 2:15 a.m., Ian Rogers wrote:
>>> Use the error handler from the parse_state to give a more informative
>>> error message.
>>>
>>> Before:
>>> ```
>>> $ perf stat -e 'cycles/period=99999999999999999999/' true
>>> event syntax error: 'cycles/period=99999999999999999999/'
>>>                                   \___ parser error
>>> Run 'perf list' for a list of valid events
>>>
>>>  Usage: perf stat [<options>] [<command>]
>>>
>>>     -e, --event <event>   event selector. use 'perf list' to list available events
>>> ```
>>>
>>> After:
>>> ```
>>> $ perf stat -e 'cycles/period=99999999999999999999/' true
>>> event syntax error: 'cycles/period=99999999999999999999/'
>>>                                   \___ parser error
>>>
>>> event syntax error: '..les/period=99999999999999999999/'
>>>                                   \___ Bad base 10 number "99999999999999999999"
>>
>>
>> It seems the patch only works for decimal?
>>
>> ./perf stat -e 'cycles/period=0xaaaaaaaaaaaaaaaaaaaaaa/' true
>> event syntax error: '..les/period=0xaaaaaaaaaaaaaaaaaaaaaa/'
>>                                    \___ parser error
>>  Run 'perf list' for a list of valid events
>>
>>   Usage: perf stat [<options>] [<command>]
>>
>>      -e, --event <event>   event selector. use 'perf list' to list
>> available events
>>
>> Thanks,
>> Kan
> 
> Right, for hexadecimal we say the number of digits is at most 16, so
> when you exceed this the token is no longer recognized. It just
> becomes input that can't be parsed, hence parser error. Doing this
> means we can simplify other strtoull checks, but I agree having a
> better error message for hexadecimal would be good. Let's do it as
> follow up.

OK. There is already a warning. It's fine to provide a follow-up for a
better error message later.

Thanks,
Kan

> 
> Thanks,
> Ian
> 
>>> Run 'perf list' for a list of valid events
>>>
>>>  Usage: perf stat [<options>] [<command>]
>>>
>>>     -e, --event <event>   event selector. use 'perf list' to list available events
>>> ```
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/util/parse-events.l | 40 ++++++++++++++++++++--------------
>>>  1 file changed, 24 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
>>> index 6fe37003ab7b..0cd68c9f0d4f 100644
>>> --- a/tools/perf/util/parse-events.l
>>> +++ b/tools/perf/util/parse-events.l
>>> @@ -18,26 +18,34 @@
>>>
>>>  char *parse_events_get_text(yyscan_t yyscanner);
>>>  YYSTYPE *parse_events_get_lval(yyscan_t yyscanner);
>>> +int parse_events_get_column(yyscan_t yyscanner);
>>> +int parse_events_get_leng(yyscan_t yyscanner);
>>>
>>> -static int __value(YYSTYPE *yylval, char *str, int base, int token)
>>> +static int get_column(yyscan_t scanner)
>>>  {
>>> -     u64 num;
>>> -
>>> -     errno = 0;
>>> -     num = strtoull(str, NULL, base);
>>> -     if (errno)
>>> -             return PE_ERROR;
>>> -
>>> -     yylval->num = num;
>>> -     return token;
>>> +     return parse_events_get_column(scanner) - parse_events_get_leng(scanner);
>>>  }
>>>
>>> -static int value(yyscan_t scanner, int base)
>>> +static int value(struct parse_events_state *parse_state, yyscan_t scanner, int base)
>>>  {
>>>       YYSTYPE *yylval = parse_events_get_lval(scanner);
>>>       char *text = parse_events_get_text(scanner);
>>> +     u64 num;
>>>
>>> -     return __value(yylval, text, base, PE_VALUE);
>>> +     errno = 0;
>>> +     num = strtoull(text, NULL, base);
>>> +     if (errno) {
>>> +             struct parse_events_error *error = parse_state->error;
>>> +             char *help = NULL;
>>> +
>>> +             if (asprintf(&help, "Bad base %d number \"%s\"", base, text) > 0)
>>> +                     parse_events_error__handle(error, get_column(scanner), help , NULL);
>>> +
>>> +             return PE_ERROR;
>>> +     }
>>> +
>>> +     yylval->num = num;
>>> +     return PE_VALUE;
>>>  }
>>>
>>>  static int str(yyscan_t scanner, int token)
>>> @@ -283,8 +291,8 @@ r0x{num_raw_hex}  { return str(yyscanner, PE_RAW); }
>>>        */
>>>  "/"/{digit}          { return PE_BP_SLASH; }
>>>  "/"/{non_digit}              { BEGIN(config); return '/'; }
>>> -{num_dec}            { return value(yyscanner, 10); }
>>> -{num_hex}            { return value(yyscanner, 16); }
>>> +{num_dec}            { return value(_parse_state, yyscanner, 10); }
>>> +{num_hex}            { return value(_parse_state, yyscanner, 16); }
>>>       /*
>>>        * We need to separate 'mem:' scanner part, in order to get specific
>>>        * modifier bits parsed out. Otherwise we would need to handle PE_NAME
>>> @@ -330,8 +338,8 @@ cgroup-switches                                   { return sym(yyscanner, PERF_COUNT_SW_CGROUP_SWITCHES); }
>>>  {lc_type}-{lc_op_result}-{lc_op_result}      { return str(yyscanner, PE_LEGACY_CACHE); }
>>>  mem:                 { BEGIN(mem); return PE_PREFIX_MEM; }
>>>  r{num_raw_hex}               { return str(yyscanner, PE_RAW); }
>>> -{num_dec}            { return value(yyscanner, 10); }
>>> -{num_hex}            { return value(yyscanner, 16); }
>>> +{num_dec}            { return value(_parse_state, yyscanner, 10); }
>>> +{num_hex}            { return value(_parse_state, yyscanner, 16); }
>>>
>>>  {modifier_event}     { return str(yyscanner, PE_MODIFIER_EVENT); }
>>>  {name}                       { return str(yyscanner, PE_NAME); }
> 

