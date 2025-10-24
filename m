Return-Path: <bpf+bounces-71984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D998C04295
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 04:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D4B1897B1C
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 02:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4253E261393;
	Fri, 24 Oct 2025 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="if//yMXC"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AEF35B124;
	Fri, 24 Oct 2025 02:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273947; cv=none; b=YlZrBQMAAuFz16XYX4n1Jn352R2MYuT1yf69zdjL0S46vCdZeIjyeOGC1oTyUeSqqVxPP+PObjRr7bJ0VaKv68aIdqlqWrxosWeDo6bcUvcIl51fgm1xCS541aEg2skX9Ogt6ghF9BMMYqbHZiDrE59bSFY7cNPXJNrHJzmjWuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273947; c=relaxed/simple;
	bh=+bWkbj74UQMuSywzFvC5TyrUsm/MJS5VftNRwta5zmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2dbq8baK0Pb9dWTRXC6pXTlUhHXa61JNiwpRDrou1pB1RlmIB+YlhWKoXI+zrK0KhfHVR3H2tj1heOumn4k8yLfibBLj1JhEHflhMEeiwLP5V9nfCjnzbaiHxqe7lSUylTsGm0ZJPMenl3KeAqm6kCw9W6MzPECFAhz9ncLb/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=if//yMXC; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761273935; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kA7KXxhepSGddwzRkRmqoP1od5m6kWQ5gxhF01zwg98=;
	b=if//yMXC/O64JiHN8UHYQr1Snig61yYAXAKQGg/I/y1nnL4EZ7qRwr8YV9vnfMBUGF7wNh4ZANgJrlfzXot3s/BfcghyCwT6x6EWup+jCHP7E+KA0CBTrahTrt36VetPwtOMG6x225gs3k1XOXAFk82ugNY73qro2Pq32qK6eg8=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqsjR79_1761273933 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 10:45:35 +0800
Message-ID: <fc75b170-86c1-49b6-a321-7dca56ad824a@linux.alibaba.com>
Date: Fri, 24 Oct 2025 10:45:33 +0800
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
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <CAP-5=fWupb62_QKM3bZO9K9yeJqC2H-bdi6dQNM7zAsLTJoDow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/24 00:08, Ian Rogers 写道:
> On Wed, Oct 22, 2025 at 6:50 PM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>
>> When using perf record with the `--overwrite` option, a segmentation fault
>> occurs if an event fails to open. For example:
>>
>>    perf record -e cycles-ct -F 1000 -a --overwrite
>>    Error:
>>    cycles-ct:H: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
>>    perf: Segmentation fault
>>        #0 0x6466b6 in dump_stack debug.c:366
>>        #1 0x646729 in sighandler_dump_stack debug.c:378
>>        #2 0x453fd1 in sigsegv_handler builtin-record.c:722
>>        #3 0x7f8454e65090 in __restore_rt libc-2.32.so[54090]
>>        #4 0x6c5671 in __perf_event__synthesize_id_index synthetic-events.c:1862
>>        #5 0x6c5ac0 in perf_event__synthesize_id_index synthetic-events.c:1943
>>        #6 0x458090 in record__synthesize builtin-record.c:2075
>>        #7 0x45a85a in __cmd_record builtin-record.c:2888
>>        #8 0x45deb6 in cmd_record builtin-record.c:4374
>>        #9 0x4e5e33 in run_builtin perf.c:349
>>        #10 0x4e60bf in handle_internal_command perf.c:401
>>        #11 0x4e6215 in run_argv perf.c:448
>>        #12 0x4e653a in main perf.c:555
>>        #13 0x7f8454e4fa72 in __libc_start_main libc-2.32.so[3ea72]
>>        #14 0x43a3ee in _start ??:0
>>
>> The --overwrite option implies --tail-synthesize, which collects non-sample
>> events reflecting the system status when recording finishes. However, when
>> evsel opening fails (e.g., unsupported event 'cycles-ct'), session->evlist
>> is not initialized and remains NULL. The code unconditionally calls
>> record__synthesize() in the error path, which iterates through the NULL
>> evlist pointer and causes a segfault.
>>
>> To fix it, move the record__synthesize() call inside the error check block, so
>> it's only called when there was no error during recording, ensuring that evlist
>> is properly initialized.
>>
>> Fixes: 4ea648aec019 ("perf record: Add --tail-synthesize option")
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> This looks great! I wonder if we can add a test, perhaps here:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/record.sh?h=perf-tools-next#n435
> something like:
> ```
> $ perf record -e foobar -F 1000 -a --overwrite -o /dev/null -- sleep 0.1
> ```
> in a new test subsection for test_overwrite? foobar would be an event
> that we could assume isn't present. Could you help with a test
> covering the problems you've uncovered and perhaps related flags?
> 

Hi, Ian,

Good suggestion, I'd like to add a test. But foobar may not a good case.

Regarding your example:

   perf record -e foobar -a --overwrite -o /dev/null -- sleep 0.1
   event syntax error: 'foobar'
                        \___ Bad event name

   Unable to find event on a PMU of 'foobar'
   Run 'perf list' for a list of valid events

    Usage: perf record [<options>] [<command>]
       or: perf record [<options>] -- <command> [<options>]

       -e, --event <event>   event selector. use 'perf list' to list available events


The issue with using foobar is that it's an invalid event name, and the
perf parser will reject it much earlier. This means the test would exit
before reaching the part of the code path we want to verify (where
record__synthesize() could be called).

A potential alternative could be testing an error case such as EACCES:

   perf record -e cycles -C 0 --overwrite -o /dev/null -- sleep 0.1

This could reproduce the scenario of a failure when attempting to access
a valid event, such as due to permission restrictions. However, the
limitation here is that users may override
/proc/sys/kernel/perf_event_paranoid, which affects whether or not this
test would succeed in triggering an EACCES error.


If you have any other suggestions or ideas for a better way to simulate
this situation, I'd love to hear them.

Thanks.
Shuai

