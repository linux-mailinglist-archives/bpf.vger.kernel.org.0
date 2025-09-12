Return-Path: <bpf+bounces-68265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D51EBB55818
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 23:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8410D1896791
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 21:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4BE2DECCD;
	Fri, 12 Sep 2025 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EXz/FrYD"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC127280C
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711402; cv=none; b=QvQUH5roAxg4Lt3hXQOgl++sywLc42hlCVYDhNDG+ZirEV3XnGFZW6uJ/MCNXEyF0QTE8Khwru3i/1gjWrabYzytCu/iirGjIS2F7gAZ37Sz+xWzMMdxMGaomHFWm2eu7AtbZwPII6jxIZ1uZw8av2c6iw2FKOUXpjNUFdhKgTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711402; c=relaxed/simple;
	bh=tNcYr5ziqs6D8Tk6SiXuOUEiirhboBKH4zEUjW3nj/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EH5DZp8NgIZkPalQ0gfdmx+KbBZmD39A1F3Le1RUp4l72i7anL4NK2qDNhzhN07XATES1/fdITvCAz8zrg3q0viuTuZFwarS0isTf59GZ9UIeTlt+nW5ttbZ/o+E4qB6qjw9m7y1Lz+66afk323yCQIOG89ay/1kB+BO5qaxvGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EXz/FrYD; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8c93b586-1ebd-44c1-87d6-bcbb8030f795@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757711398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7SST8umNfuQI1uj5w85mwFvKzhhH3zx+XI2NwpkpMs=;
	b=EXz/FrYD+KUVjFXdQDMRdidl/sSKPAfYFlPGoTsOsxXoyx66KHRYyhVkbpCatQ1G0+Xckg
	+0VEO/8KF17Aka1OPF5zg0jc84I4Jol6aMAQFRA6xa7j2s6PDA/5eTSdO1RVA7SsD5/7OC
	0bMMD8V6Elf1RgNC4tmvEl5voS0kQ2E=
Date: Fri, 12 Sep 2025 14:09:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv3 perf/core 0/6] uprobe,bpf: Allow to change app registers
 from uprobe registers
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>
References: <20250909123857.315599-1-jolsa@kernel.org>
 <CAEf4Bzb4ErWn=2SajBcyJxqGEYy0DXmtWuXKLskPGLG-Y9POFA@mail.gmail.com>
 <7f591ac9-d3e0-4404-987c-40eceaf51fbb@linux.dev> <aMSIr1oItIfWQd5R@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <aMSIr1oItIfWQd5R@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/12/25 1:55 PM, Jiri Olsa wrote:
> On Fri, Sep 12, 2025 at 01:28:55PM -0700, Ihor Solodrai wrote:
>> On 9/9/25 9:41 AM, Andrii Nakryiko wrote:
>>> On Tue, Sep 9, 2025 at 8:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>>>
>>>> hi,
>>>> we recently had several requests for tetragon to be able to change
>>>> user application function return value or divert its execution through
>>>> instruction pointer change.
>>>>
>>>> This patchset adds support for uprobe program to change app's registers
>>>> including instruction pointer.
>>>>
>>>> v3 changes:
>>>> - deny attach of kprobe,multi with kprobe_write_ctx set [Alexei]
>>>> - added more tests for denied kprobe attachment
>>>>
>>>> thanks,
>>>> jirka
>>>>
>>>>
>>>> ---
>>>> Jiri Olsa (6):
>>>>         bpf: Allow uprobe program to change context registers
>>>>         uprobe: Do not emulate/sstep original instruction when ip is changed
>>>>         selftests/bpf: Add uprobe context registers changes test
>>>>         selftests/bpf: Add uprobe context ip register change test
>>>>         selftests/bpf: Add kprobe write ctx attach test
>>>>         selftests/bpf: Add kprobe multi write ctx attach test
>>>>
>>>
>>> For the series:
>>>
>>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>>
>>> Question is which tree will this go through? Most changes are in BPF,
>>> so probably bpf-next, right?
>>
>> Hi Jiri.
>>
>> This series does not apply to current bpf-next, see below.
>>
>> Could you please respin it with bpf-next tag?
>> E.g. "[PATCH v4 bpf-next 0/6] ..."
>>
> 
> hi,
> the uprobe change it needs to be on top of the optimized uprobes (tip/perf/core)
> but the bpf selftests patches could be applied on bpf-next/master and disabled
> in CI until tip/perf/core changes are merged in?

Currently the series isn't even picked up by CI properly because it
doesn't apply. It's not that the tests are failing.

If there is a dependency on external (to bpf-next) commit, we could
add it as a temporary CI patch or just wait for it to be merged in.

But if you can make this series applicable to bpf-next without
tip/perf/core changes, you can do that and add relevant tests to
`tools/testing/selftests/bpf/DENYLIST`. It's important to not forget
to remove them later though.

> 
> thanks,
> jirka
> 
> 
>> Thanks!
>>
>> $ git log -1 --oneline
>> a578b54a8ad2 (HEAD -> master, origin/master, origin/HEAD,
>> kernel-patches/bpf-next) Merge branch
>> 'bpf-report-arena-faults-to-bpf-streams'
>> $ b4 am 20250909123857.315599-1-jolsa@kernel.org
>> [...]
>> $ git am ./v3_20250909_jolsa_uprobe_bpf_allow_to_change_app_registers_from_uprobe_registers.mbx
>> Applying: bpf: Allow uprobe program to change context registers
>> Applying: uprobe: Do not emulate/sstep original instruction when ip is
>> changed
>> error: patch failed: kernel/events/uprobes.c:2768
>> error: kernel/events/uprobes.c: patch does not apply
>> Patch failed at 0002 uprobe: Do not emulate/sstep original instruction when
>> ip is changed
>> [...]
>>
>>>
>>>>    include/linux/bpf.h                                        |   1 +
>>>>    kernel/events/core.c                                       |   4 +++
>>>>    kernel/events/uprobes.c                                    |   7 +++++
>>>>    kernel/trace/bpf_trace.c                                   |   7 +++--
>>>>    tools/testing/selftests/bpf/prog_tests/attach_probe.c      |  28 +++++++++++++++++
>>>>    tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c |  27 ++++++++++++++++
>>>>    tools/testing/selftests/bpf/prog_tests/uprobe.c            | 156 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>>    tools/testing/selftests/bpf/progs/kprobe_write_ctx.c       |  22 +++++++++++++
>>>>    tools/testing/selftests/bpf/progs/test_uprobe.c            |  38 +++++++++++++++++++++++
>>>>    9 files changed, 287 insertions(+), 3 deletions(-)
>>>>    create mode 100644 tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
>>


