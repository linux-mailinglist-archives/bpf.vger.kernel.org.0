Return-Path: <bpf+bounces-13727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF107DD3D4
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBDE1C20C26
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C35620322;
	Tue, 31 Oct 2023 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jUwt+Ydn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550972031C
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 17:04:10 +0000 (UTC)
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [IPv6:2001:41d0:1004:224b::af])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3F82109
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 10:04:08 -0700 (PDT)
Message-ID: <730b42c0-f289-49e6-9456-ca2c69b73a54@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698771844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93PgFQAH22lYty+T+8I0nRDelqU6HAGsbHROAWefYv8=;
	b=jUwt+Ydn2DaY8nN8TFt7nt1W7TQqhwTcOhl8BeXoch0+dw2qieJosNuwFxuc0uytzQBO1q
	BzUaMYMZX4wLBSFlSuHKAc7lNqspkIOz7ShrHX67aDHMmJu2TJziwsAJ01VcVgqcCpjWuS
	LEWfmEe9e4ZmPV1B6yPcgEoXRSdu+DE=
Date: Tue, 31 Oct 2023 13:03:59 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next] bpf: Add __bpf_kfunc_{start,end}_defs macros
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>,
 Jiri Olsa <olsajiri@gmail.com>
References: <20231030210638.2415306-1-davemarchevsky@fb.com>
 <CALOAHbAUhae1S1XUHNZAkSuOdvjS-ECSuKNoJRLAwtgp85L+dg@mail.gmail.com>
 <CAEf4BzYnDy4=tXX0S-G0dh2fPTXpJ+9PPF1uix-fRK49VA1hEg@mail.gmail.com>
 <CALOAHbC9A+NK6Y-z5L0r2XdaQ-ySuNsYr6A3a8y60WS76ayHPg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <CALOAHbC9A+NK6Y-z5L0r2XdaQ-ySuNsYr6A3a8y60WS76ayHPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/31/23 2:51 AM, Yafang Shao wrote:
> On Tue, Oct 31, 2023 at 2:23 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Mon, Oct 30, 2023 at 10:56 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>
>>> On Tue, Oct 31, 2023 at 5:07 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>>>
>>>> BPF kfuncs are meant to be called from BPF programs. Accordingly, most
>>>> kfuncs are not called from anywhere in the kernel, which the
>>>> -Wmissing-prototypes warning is unhappy about. We've peppered
>>>> __diag_ignore_all("-Wmissing-prototypes", ... everywhere kfuncs are
>>>> defined in the codebase to suppress this warning.
>>>>
>>>> This patch adds two macros meant to bound one or many kfunc definitions.
>>>> All existing kfunc definitions which use these __diag calls to suppress
>>>> -Wmissing-prototypes are migrated to use the newly-introduced macros.
>>>> A new __diag_ignore_all - for "-Wmissing-declarations" - is added to the
>>>> __bpf_kfunc_start_defs macro based on feedback from Andrii on an earlier
>>>> version of this patch [0] and another recent mailing list thread [1].
>>>>
>>>> In the future we might need to ignore different warnings or do other
>>>> kfunc-specific things. This change will make it easier to make such
>>>> modifications for all kfunc defs.
>>>>
>>>>   [0]: https://lore.kernel.org/bpf/CAEf4BzaE5dRWtK6RPLnjTW-MW9sx9K3Fn6uwqCTChK2Dcb1Xig@mail.gmail.com/
>>>>   [1]: https://lore.kernel.org/bpf/ZT+2qCc%2FaXep0%2FLf@krava/
>>>>
>>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>>>> Cc: Jiri Olsa <olsajiri@gmail.com>
>>>> ---
>>>>
>>>> This patch was submitted earlier as part of task_vma
>>>> iter series: https://lore.kernel.org/bpf/20231013204426.1074286-6-davemarchevsky@fb.com/
>>>>
>>>> This separate submission addresses Andrii's comments from
>>>> that thread.
>>>>
>>>>  include/linux/btf.h              |  9 +++++++++
>>>>  kernel/bpf/bpf_iter.c            |  6 ++----
>>>>  kernel/bpf/cpumask.c             |  6 ++----
>>>>  kernel/bpf/helpers.c             |  6 ++----
>>>>  kernel/bpf/map_iter.c            |  6 ++----
>>>>  kernel/bpf/task_iter.c           |  6 ++----
>>>>  kernel/trace/bpf_trace.c         |  6 ++----
>>>>  net/bpf/test_run.c               |  7 +++----
>>>>  net/core/filter.c                | 13 ++++---------
>>>>  net/core/xdp.c                   |  6 ++----
>>>>  net/ipv4/fou_bpf.c               |  6 ++----
>>>>  net/netfilter/nf_conntrack_bpf.c |  6 ++----
>>>>  net/netfilter/nf_nat_bpf.c       |  6 ++----
>>>>  net/xfrm/xfrm_interface_bpf.c    |  6 ++----
>>>>  14 files changed, 38 insertions(+), 57 deletions(-)
>>>>
>>>
>>> Thanks for your work.
>>>
>>> By using a simple grep for "__diag_ignore_all(\"-Wmissing-prototypes",
>>> it appears that the files net/socket.c,
>>> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c,
>>> kernel/cgroup/rstat.c and Documentation/bpf/kfuncs.rst are missing. It
>>> seems that we should also update them.
>>>
>>
>> rstat.c and net/socket.c don't have kfuncs, so those are not relevant
>> here.
> 
> The bpf_rstat_flush() and update_socket_protocol() can also trigger
> the -Wmissing-declarations.
> These two functions are for BPF only. Shouldn't we better include them as well ?
> 

I had this conundrum when writing the patch as well. Since they're not kfuncs
and the macros are meant to wrap kfunc definitions, I felt that it would be
confusing to someone unfamiliar with BPF internals. But I agree that the current
state isn't ideal either.

How about either:
  * I use the __bpf_kfunc_{start,end}_defs macros in those two places,
    with comment describing that they're not wrapping kfunc def, but rather
    BPF hook point that throws the same warnings.
  * Two additional macros, __bpf_hook_{start,end} are added, just
    pointing to __bpf_kfunc_{start,end} for now. They're used for
    these two functions

WDYT? 

>> But we are missing changes also in kernel/bpf/task_iter.c and
>> kernel/bpf/cgroup_iter.c
>>
>> And let's update Documentation/bpf/kfuncs.rst to use your new set of macros?
>>
>> With the above addressed, please add my ack. Thanks!
>>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>
>>> --
>>> Regards
>>> Yafang
> 
> 
> 

