Return-Path: <bpf+bounces-73097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA9DC23090
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 03:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6471A24C08
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 02:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B372F5A14;
	Fri, 31 Oct 2025 02:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wIL0q/7z"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817B2F363E;
	Fri, 31 Oct 2025 02:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878216; cv=none; b=VarJ4n03hCBm0j5x6XFJCU+7GdxOoPmLRtgfNu4yZ1gVirbdwUjWVj4BZ5ERyZhvYDxiNSOJ0xroXEDDAapRdrFkDWiVRT6ZH5w1a+ln3NPk7I56YUhx5ITJ9dEl4K7ovt53nKevM30lBJWz4NCSZHMkhL/dWWUwLUo9w81Y3tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878216; c=relaxed/simple;
	bh=NUA053BqgqawXS1Qozx//QoxkeT9MqL31R1qOGEfwBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQpGaScj09eS+AJxElpLeorX6EtkY85HeyNSRfwPgr1QlZdqLszYRJbQgyU+AVVFivQl5s6u9a8+NF8Z2dwyr+aX4JRnYQ+E+fsA4mtIsTdDqr/TWujacMbcUe5qI+UvFPgEEXGTEzDKgzLm5feObCgv1dzNZRi+qnI4snsh7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wIL0q/7z; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761878200; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PyeoLWnDjTpu6Bq9KrYA09g/UfFxetHtGXnQlFKNsX0=;
	b=wIL0q/7zMLtxHpx5wliNI3yF9CjFjIreOyY1A7jybBAiV0jdm19YYyS6uK0a0EtDk2BRciFPGn/ljf+WnHDL3pbLnqLj6sRFF5TNP/kjBtpWnZEWeysRKPcqH6vdt/+LBgqAccABO/9HivqSvFub/bAbHl/e3XcocGH04wK0WYY=
Received: from 30.246.176.102(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WrNSDa1_1761878198 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Oct 2025 10:36:39 +0800
Message-ID: <5a06462a-697d-47b6-b51e-6438005b6130@linux.alibaba.com>
Date: Fri, 31 Oct 2025 10:36:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf record: skip synthesize event when open evsel failed
To: Ian Rogers <irogers@google.com>
Cc: alexander.shishkin@linux.intel.com, peterz@infradead.org,
 james.clark@arm.com, leo.yan@linaro.org, mingo@redhat.com,
 baolin.wang@linux.alibaba.com, acme@kernel.org, mark.rutland@arm.com,
 jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 nathan@kernel.org, bpf@vger.kernel.org
References: <20251023015043.38868-1-xueshuai@linux.alibaba.com>
 <CAP-5=fWupb62_QKM3bZO9K9yeJqC2H-bdi6dQNM7zAsLTJoDow@mail.gmail.com>
 <fc75b170-86c1-49b6-a321-7dca56ad824a@linux.alibaba.com>
 <eed27aaf-fd0a-4609-a30b-68e7c5c11890@linux.alibaba.com>
 <CAP-5=fVLGRsn7icH1cgmb==f5_D6Vr2CbzirAv7DY4Afjm4O2A@mail.gmail.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <CAP-5=fVLGRsn7icH1cgmb==f5_D6Vr2CbzirAv7DY4Afjm4O2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/31 01:32, Ian Rogers 写道:
> On Wed, Oct 29, 2025 at 5:55 AM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>
>>
>>
>> 在 2025/10/24 10:45, Shuai Xue 写道:
>>>
>>>
>>> 在 2025/10/24 00:08, Ian Rogers 写道:
>>>> On Wed, Oct 22, 2025 at 6:50 PM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>>>>
>>>>> When using perf record with the `--overwrite` option, a segmentation fault
>>>>> occurs if an event fails to open. For example:
>>>>>
>>>>>     perf record -e cycles-ct -F 1000 -a --overwrite
>>>>>     Error:
>>>>>     cycles-ct:H: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
>>>>>     perf: Segmentation fault
>>>>>         #0 0x6466b6 in dump_stack debug.c:366
>>>>>         #1 0x646729 in sighandler_dump_stack debug.c:378
>>>>>         #2 0x453fd1 in sigsegv_handler builtin-record.c:722
>>>>>         #3 0x7f8454e65090 in __restore_rt libc-2.32.so[54090]
>>>>>         #4 0x6c5671 in __perf_event__synthesize_id_index synthetic-events.c:1862
>>>>>         #5 0x6c5ac0 in perf_event__synthesize_id_index synthetic-events.c:1943
>>>>>         #6 0x458090 in record__synthesize builtin-record.c:2075
>>>>>         #7 0x45a85a in __cmd_record builtin-record.c:2888
>>>>>         #8 0x45deb6 in cmd_record builtin-record.c:4374
>>>>>         #9 0x4e5e33 in run_builtin perf.c:349
>>>>>         #10 0x4e60bf in handle_internal_command perf.c:401
>>>>>         #11 0x4e6215 in run_argv perf.c:448
>>>>>         #12 0x4e653a in main perf.c:555
>>>>>         #13 0x7f8454e4fa72 in __libc_start_main libc-2.32.so[3ea72]
>>>>>         #14 0x43a3ee in _start ??:0
>>>>>
>>>>> The --overwrite option implies --tail-synthesize, which collects non-sample
>>>>> events reflecting the system status when recording finishes. However, when
>>>>> evsel opening fails (e.g., unsupported event 'cycles-ct'), session->evlist
>>>>> is not initialized and remains NULL. The code unconditionally calls
>>>>> record__synthesize() in the error path, which iterates through the NULL
>>>>> evlist pointer and causes a segfault.
>>>>>
>>>>> To fix it, move the record__synthesize() call inside the error check block, so
>>>>> it's only called when there was no error during recording, ensuring that evlist
>>>>> is properly initialized.
>>>>>
>>>>> Fixes: 4ea648aec019 ("perf record: Add --tail-synthesize option")
>>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>>
>>>> This looks great! I wonder if we can add a test, perhaps here:
>>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/record.sh?h=perf-tools-next#n435
>>>> something like:
>>>> ```
>>>> $ perf record -e foobar -F 1000 -a --overwrite -o /dev/null -- sleep 0.1
>>>> ```
>>>> in a new test subsection for test_overwrite? foobar would be an event
>>>> that we could assume isn't present. Could you help with a test
>>>> covering the problems you've uncovered and perhaps related flags?
>>>>
>>>
>>> Hi, Ian,
>>>
>>> Good suggestion, I'd like to add a test. But foobar may not a good case.
>>>
>>> Regarding your example:
>>>
>>>     perf record -e foobar -a --overwrite -o /dev/null -- sleep 0.1
>>>     event syntax error: 'foobar'
>>>                          \___ Bad event name
>>>
>>>     Unable to find event on a PMU of 'foobar'
>>>     Run 'perf list' for a list of valid events
>>>
>>>      Usage: perf record [<options>] [<command>]
>>>         or: perf record [<options>] -- <command> [<options>]
>>>
>>>         -e, --event <event>   event selector. use 'perf list' to list available events
>>>
>>>
>>> The issue with using foobar is that it's an invalid event name, and the
>>> perf parser will reject it much earlier. This means the test would exit
>>> before reaching the part of the code path we want to verify (where
>>> record__synthesize() could be called).
>>>
>>> A potential alternative could be testing an error case such as EACCES:
>>>
>>>     perf record -e cycles -C 0 --overwrite -o /dev/null -- sleep 0.1
>>>
>>> This could reproduce the scenario of a failure when attempting to access
>>> a valid event, such as due to permission restrictions. However, the
>>> limitation here is that users may override
>>> /proc/sys/kernel/perf_event_paranoid, which affects whether or not this
>>> test would succeed in triggering an EACCES error.
>>>
>>>
>>> If you have any other suggestions or ideas for a better way to simulate
>>> this situation, I'd love to hear them.
>>>
>>> Thanks.
>>> Shuai
>>
>> Hi, Ian,
>>
>> Gentle ping.
> 
> Sorry, for the delay. I was trying to think of a better way given the
> problems you mention and then got distracted. I wonder if a legacy
> event that core PMUs never implement would be a good candidate to
> test. For example, the event "node-prefetch-misses" is for "Local
> memory prefetch misses" but the memory controller tends to be a
> separate PMU and this event is never implemented to my knowledge.
> Running this locally I see:
> 
> ```
> $ perf record -e node-prefetch-misses -a --overwrite -o /dev/null -- sleep 0.1
> Lowering default frequency rate from 4000 to 1750.
> Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
> Error:
> Failure to open event 'cpu_atom/node-prefetch-misses/' on PMU
> 'cpu_atom' which will be removed.
> No fallback found for 'cpu_atom/node-prefetch-misses/' for error 2
> Error:
> Failure to open event 'cpu_core/node-prefetch-misses/' on PMU
> 'cpu_core' which will be removed.
> No fallback found for 'cpu_core/node-prefetch-misses/' for error 2
> Error:
> Failure to open any events for recording.
> perf: Segmentation fault
>     #0 0x55a487ad8b87 in dump_stack debug.c:366
>     #1 0x55a487ad8bfd in sighandler_dump_stack debug.c:378
>     #2 0x55a4878c6f94 in sigsegv_handler builtin-record.c:722
>     #3 0x7f72aae49df0 in __restore_rt libc_sigaction.c:0
>     #4 0x55a487b57ef8 in __perf_event__synthesize_id_index
> synthetic-events.c:1862
>     #5 0x55a487b58346 in perf_event__synthesize_id_index synthetic-events.c:1943
>     #6 0x55a4878cb2a3 in record__synthesize builtin-record.c:2150
>     #7 0x55a4878cdada in __cmd_record builtin-record.c:2963
>     #8 0x55a4878d11ca in cmd_record builtin-record.c:4453
>     #9 0x55a48795b3cc in run_builtin perf.c:349
>     #10 0x55a48795b664 in handle_internal_command perf.c:401
>     #11 0x55a48795b7bd in run_argv perf.c:448
>     #12 0x55a48795bb06 in main perf.c:555
>     #13 0x7f72aae33ca8 in __libc_start_call_main libc_start_call_main.h:74
>     #14 0x7f72aae33d65 in __libc_start_main_alias_2 libc-start.c:128
>     #15 0x55a4878acf41 in _start perf[52f41]
> Segmentation fault
> ```


Hi, Ian，

Is node-prefetch-misses a platform specific event? Running it on ARM Yitian 710
and Intel SPR platform, I see:

$sudo perf record -e node-prefetch-misses
Error:
The node-prefetch-misses event is not supported.

Thanks.
Shuai

