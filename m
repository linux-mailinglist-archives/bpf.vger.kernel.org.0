Return-Path: <bpf+bounces-13106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D9C7D46DC
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 07:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B07E1C2095A
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 05:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E95379C6;
	Tue, 24 Oct 2023 05:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdP94EYb"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A5B1863;
	Tue, 24 Oct 2023 05:19:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E052E5;
	Mon, 23 Oct 2023 22:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698124774; x=1729660774;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MRmrUcwHWy3mkUYsQTE4raBpxOs+Zla7IRIOfm8KL0s=;
  b=LdP94EYbwv/ytljH0cn7zpVWlkdSx6vV5lBpBgVHz+VxyZcO65eVYhqp
   NRkFbCZg1HWova8I7SrwqrtqRvDt6oaDUdVH2F1nkcy0U+Opvp72aYoWJ
   ixqrrkDzxVGWKLE8frV968dT73GfVnMKAeMgpcBBYnaoZEBso6yPjfTF0
   UK57PaqvnsB8Uu5/QHsRdaVgy3vTTO16/PL850AokJeeVEN8aIUYuQ1bf
   PYetRoOwJfvXVxZm3WG0FZrgsWNYO0jU8GOwaNe6MIjIyAtfBYlh+tP9k
   hzebVvjXRYRsk+8TBhPUtNNSvRKiWT491B/HK4KkoPsteT+qC8bOkMitu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5613032"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="5613032"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 22:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="6335219"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.63.12])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 22:19:21 -0700
Message-ID: <92fe21ab-af6f-4417-b241-eac0532e115a@intel.com>
Date: Tue, 24 Oct 2023 08:19:23 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] perf machine thread: Remove exited threads by
 default
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Nick Terrell <terrelln@fb.com>, Kan Liang <kan.liang@linux.intel.com>,
 Song Liu <song@kernel.org>, Sandipan Das <sandipan.das@amd.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 James Clark <james.clark@arm.com>, Liam Howlett <liam.howlett@oracle.com>,
 Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>,
 German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Artem Savkov <asavkov@redhat.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andi Kleen
 <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
References: <20231012062359.1616786-1-irogers@google.com>
 <20231012062359.1616786-14-irogers@google.com>
 <c04c196a-3f29-4b89-97a7-5e71def3d3ce@intel.com>
 <CAP-5=fX303b8-hQXWaRibtYFyBS2sQywDSKR6KhKMUMX_0gzrw@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fX303b8-hQXWaRibtYFyBS2sQywDSKR6KhKMUMX_0gzrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/10/23 21:49, Ian Rogers wrote:
> On Mon, Oct 23, 2023 at 7:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 12/10/23 09:23, Ian Rogers wrote:
>>> struct thread values hold onto references to mmaps, dsos, etc. When a
>>> thread exits it is necessary to clean all of this memory up by
>>> removing the thread from the machine's threads. Some tools require
>>> this doesn't happen, such as perf report if offcpu events exist or if
>>> a task list is being generated, so add a symbol_conf value to make the
>>> behavior optional. When an exited thread is left in the machine's
>>> threads, mark it as exited.
>>>
>>> This change relates to commit 40826c45eb0b ("perf thread: Remove
>>> notion of dead threads"). Dead threads were removed as they had a
>>> reference count of 0 and were difficult to reason about with the
>>> reference count checker. Here a thread is removed from threads when it
>>> exits, unless via symbol_conf the exited thread isn't remove and is
>>> marked as exited. Reference counting behaves as it normally does.
>>
>> Can we exclude AUX area tracing?
>>
>> Essentially, the EXIT event happens when the task is still running
>> in kernel mode, so the thread has not in fact fully exited.
>>
>> Example:
>>
>> # perf record -a --kcore -e intel_pt// uname
>>
>> Before:
>>
>> # perf script --itrace=b --show-task-events -C6 | grep -C10 EXIT
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb63124ee __perf_event_header__init_id+0x5e ([kernel.kallsyms]) => ffffffffb63124f7 __perf_event_header__init_id+0x67 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6312501 __perf_event_header__init_id+0x71 ([kernel.kallsyms]) => ffffffffb6312512 __perf_event_header__init_id+0x82 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6312531 __perf_event_header__init_id+0xa1 ([kernel.kallsyms]) => ffffffffb6316b3a perf_event_task_output+0x26a ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6316b40 perf_event_task_output+0x270 ([kernel.kallsyms]) => ffffffffb6316959 perf_event_task_output+0x89 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6316966 perf_event_task_output+0x96 ([kernel.kallsyms]) => ffffffffb6322040 perf_output_begin+0x0 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6322080 perf_output_begin+0x40 ([kernel.kallsyms]) => ffffffffb6194dc0 __rcu_read_lock+0x0 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6194de1 __rcu_read_lock+0x21 ([kernel.kallsyms]) => ffffffffb6322085 perf_output_begin+0x45 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb63220ce perf_output_begin+0x8e ([kernel.kallsyms]) => ffffffffb611d280 preempt_count_add+0x0 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb611d2bf preempt_count_add+0x3f ([kernel.kallsyms]) => ffffffffb63220d3 perf_output_begin+0x93 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb63220e8 perf_output_begin+0xa8 ([kernel.kallsyms]) => ffffffffb63220ff perf_output_begin+0xbf ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638: PERF_RECORD_EXIT(14740:14740):(14739:14739)
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6322119 perf_output_begin+0xd9 ([kernel.kallsyms]) => ffffffffb6322128 perf_output_begin+0xe8 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6322146 perf_output_begin+0x106 ([kernel.kallsyms]) => ffffffffb63220ea perf_output_begin+0xaa ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb63220f9 perf_output_begin+0xb9 ([kernel.kallsyms]) => ffffffffb63221ab perf_output_begin+0x16b ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb63221ae perf_output_begin+0x16e ([kernel.kallsyms]) => ffffffffb63221b6 perf_output_begin+0x176 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6322202 perf_output_begin+0x1c2 ([kernel.kallsyms]) => ffffffffb6322167 perf_output_begin+0x127 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb632218c perf_output_begin+0x14c ([kernel.kallsyms]) => ffffffffb631696b perf_event_task_output+0x9b ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6316990 perf_event_task_output+0xc0 ([kernel.kallsyms]) => ffffffffb61034a0 __task_pid_nr_ns+0x0 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb61034b7 __task_pid_nr_ns+0x17 ([kernel.kallsyms]) => ffffffffb6194dc0 __rcu_read_lock+0x0 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6194de1 __rcu_read_lock+0x21 ([kernel.kallsyms]) => ffffffffb61034bc __task_pid_nr_ns+0x1c ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6103503 __task_pid_nr_ns+0x63 ([kernel.kallsyms]) => ffffffffb610353b __task_pid_nr_ns+0x9b ([kernel.kallsyms])
>>
>> After:
>>
>> $ perf script --itrace=b --show-task-events -C6 | grep -C10 EXIT
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb63124ee __perf_event_header__init_id+0x5e ([kernel.kallsyms]) => ffffffffb63124f7 __perf_event_header__init_id+0x67 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6312501 __perf_event_header__init_id+0x71 ([kernel.kallsyms]) => ffffffffb6312512 __perf_event_header__init_id+0x82 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6312531 __perf_event_header__init_id+0xa1 ([kernel.kallsyms]) => ffffffffb6316b3a perf_event_task_output+0x26a ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6316b40 perf_event_task_output+0x270 ([kernel.kallsyms]) => ffffffffb6316959 perf_event_task_output+0x89 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6316966 perf_event_task_output+0x96 ([kernel.kallsyms]) => ffffffffb6322040 perf_output_begin+0x0 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6322080 perf_output_begin+0x40 ([kernel.kallsyms]) => ffffffffb6194dc0 __rcu_read_lock+0x0 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6194de1 __rcu_read_lock+0x21 ([kernel.kallsyms]) => ffffffffb6322085 perf_output_begin+0x45 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb63220ce perf_output_begin+0x8e ([kernel.kallsyms]) => ffffffffb611d280 preempt_count_add+0x0 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb611d2bf preempt_count_add+0x3f ([kernel.kallsyms]) => ffffffffb63220d3 perf_output_begin+0x93 ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638:          1   branches:  ffffffffb63220e8 perf_output_begin+0xa8 ([kernel.kallsyms]) => ffffffffb63220ff perf_output_begin+0xbf ([kernel.kallsyms])
>>            uname   14740 [006] 26795.092638: PERF_RECORD_EXIT(14740:14740):(14739:14739)
>>           :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb6322119 perf_output_begin+0xd9 ([kernel.kallsyms]) => ffffffffb6322128 perf_output_begin+0xe8 ([kernel.kallsyms])
>>           :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb6322146 perf_output_begin+0x106 ([kernel.kallsyms]) => ffffffffb63220ea perf_output_begin+0xaa ([kernel.kallsyms])
>>           :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb63220f9 perf_output_begin+0xb9 ([kernel.kallsyms]) => ffffffffb63221ab perf_output_begin+0x16b ([kernel.kallsyms])
>>           :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb63221ae perf_output_begin+0x16e ([kernel.kallsyms]) => ffffffffb63221b6 perf_output_begin+0x176 ([kernel.kallsyms])
>>           :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb6322202 perf_output_begin+0x1c2 ([kernel.kallsyms]) => ffffffffb6322167 perf_output_begin+0x127 ([kernel.kallsyms])
>>           :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb632218c perf_output_begin+0x14c ([kernel.kallsyms]) => ffffffffb631696b perf_event_task_output+0x9b ([kernel.kallsyms])
>>           :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb6316990 perf_event_task_output+0xc0 ([kernel.kallsyms]) => ffffffffb61034a0 __task_pid_nr_ns+0x0 ([kernel.kallsyms])
>>           :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb61034b7 __task_pid_nr_ns+0x17 ([kernel.kallsyms]) => ffffffffb6194dc0 __rcu_read_lock+0x0 ([kernel.kallsyms])
>>           :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb6194de1 __rcu_read_lock+0x21 ([kernel.kallsyms]) => ffffffffb61034bc __task_pid_nr_ns+0x1c ([kernel.kallsyms])
>>           :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb6103503 __task_pid_nr_ns+0x63 ([kernel.kallsyms]) => ffffffffb610353b __task_pid_nr_ns+0x9b ([kernel.kallsyms])
>>
>> This will also affect samples made after PERF_RECORD_EXIT but before
>> the task finishes exiting.
> 
> Makes sense. Would an appropriate fix be in perf_session__open to set:
> symbol_conf.keep_exited_threads = true;
> 
> when:
> perf_header__has_feat(&session->header, HEADER_AUXTRACE)
> 
> It is kind of hacky to be changing global state this way, but
> symbol_conf is like that in general.

That should work.  Alternatively, could be added to
perf_event__process_auxtrace_info() which would tie it
more directly to auxtrace, and wouldn't have to check
HEADER_AUXTRACE.



