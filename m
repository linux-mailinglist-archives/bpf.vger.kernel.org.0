Return-Path: <bpf+bounces-73186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574E9C26A8A
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 20:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC27189510A
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 19:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF2B2D8395;
	Fri, 31 Oct 2025 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjWL7R6n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB774A23;
	Fri, 31 Oct 2025 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761937249; cv=none; b=gdCxy06mR1RE7wA0FFuj5DFYU4rQBHqTTD6ZCHltNUrNjnZ3YwjTV+eqZq2/UpV6VnRTesnFIrVHNl0lBQWivTc567+3KfZWuEq8rbL6q1Gz15Wnnwp3LdaqpBrzPawyFH+rl/n7SMvl9mFZZolRp7UmA4U1vYL5oFYDVc7XUyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761937249; c=relaxed/simple;
	bh=RWs1yrQBByMB0Ajp5Oy5HX3k99V4RMS+MxY+pO58YRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCPlSqrfOJw1AWHZamca9CiYcgC5UC236PWN+0bNglMj7n19e477Iqn95kRkJ5QV/9go5Aq748dtqYuV9aMxcpX+zS7ZGnJoSeOgCUNJv6rSaIM5w29yrBEXv+PLbE1d4LOeB9FoLUAuCj53y6E2gVmCPSgavxRMwr95PWuGXds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjWL7R6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D61AC4CEF1;
	Fri, 31 Oct 2025 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761937248;
	bh=RWs1yrQBByMB0Ajp5Oy5HX3k99V4RMS+MxY+pO58YRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZjWL7R6nMRbcFhuRMZY/Ent5SVWUFtoPmvQIfT0UbK0SoGxwsDDsS5n9b+3C4z6kN
	 NgQM3onpX4PgrWnAITohe5u4PNYaUuSY3viBNS5NWxm7UfKJyPskti2QJhGUrMFteK
	 RtW9mCgnUMTOcnuz5TMVbCMcuEi7E52dTGcMZhtG0rvmGcT7+4JJ9sdvc90M6VFswZ
	 8ikuSvaMQCF3WF47ZbJRqGNHidrfDW3SKmuopMhgmTTkHJyCWmUGKdWY7hAF+qINzh
	 9BOPi46J60BdJt/hOuXoijQGzBJlm4LPOeCpjV+9gYrMXPDOqxPlU6y/xxCloL5Pay
	 6SmBy92pZUv6g==
Date: Fri, 31 Oct 2025 12:00:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	alexander.shishkin@linux.intel.com, peterz@infradead.org,
	james.clark@arm.com, leo.yan@linaro.org, mingo@redhat.com,
	baolin.wang@linux.alibaba.com, acme@kernel.org,
	mark.rutland@arm.com, jolsa@kernel.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	nathan@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] perf record: skip synthesize event when open evsel failed
Message-ID: <aQUHXotIjne3vHm_@google.com>
References: <20251023015043.38868-1-xueshuai@linux.alibaba.com>
 <CAP-5=fWupb62_QKM3bZO9K9yeJqC2H-bdi6dQNM7zAsLTJoDow@mail.gmail.com>
 <fc75b170-86c1-49b6-a321-7dca56ad824a@linux.alibaba.com>
 <eed27aaf-fd0a-4609-a30b-68e7c5c11890@linux.alibaba.com>
 <CAP-5=fVLGRsn7icH1cgmb==f5_D6Vr2CbzirAv7DY4Afjm4O2A@mail.gmail.com>
 <5a06462a-697d-47b6-b51e-6438005b6130@linux.alibaba.com>
 <CAP-5=fUvwokP=MYmS7kZqjCk+ZYs8A-9G+i3zt-zvjdZA6E_Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUvwokP=MYmS7kZqjCk+ZYs8A-9G+i3zt-zvjdZA6E_Jg@mail.gmail.com>

Hello,

On Fri, Oct 31, 2025 at 09:04:38AM -0700, Ian Rogers wrote:
> On Thu, Oct 30, 2025 at 7:36 PM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> >
> > 在 2025/10/31 01:32, Ian Rogers 写道:
> > > On Wed, Oct 29, 2025 at 5:55 AM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> > >>
> > >>
> > >>
> > >> 在 2025/10/24 10:45, Shuai Xue 写道:
> > >>>
> > >>>
> > >>> 在 2025/10/24 00:08, Ian Rogers 写道:
> > >>>> On Wed, Oct 22, 2025 at 6:50 PM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> > >>>>>
> > >>>>> When using perf record with the `--overwrite` option, a segmentation fault
> > >>>>> occurs if an event fails to open. For example:
> > >>>>>
> > >>>>>     perf record -e cycles-ct -F 1000 -a --overwrite
> > >>>>>     Error:
> > >>>>>     cycles-ct:H: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
> > >>>>>     perf: Segmentation fault
> > >>>>>         #0 0x6466b6 in dump_stack debug.c:366
> > >>>>>         #1 0x646729 in sighandler_dump_stack debug.c:378
> > >>>>>         #2 0x453fd1 in sigsegv_handler builtin-record.c:722
> > >>>>>         #3 0x7f8454e65090 in __restore_rt libc-2.32.so[54090]
> > >>>>>         #4 0x6c5671 in __perf_event__synthesize_id_index synthetic-events.c:1862
> > >>>>>         #5 0x6c5ac0 in perf_event__synthesize_id_index synthetic-events.c:1943
> > >>>>>         #6 0x458090 in record__synthesize builtin-record.c:2075
> > >>>>>         #7 0x45a85a in __cmd_record builtin-record.c:2888
> > >>>>>         #8 0x45deb6 in cmd_record builtin-record.c:4374
> > >>>>>         #9 0x4e5e33 in run_builtin perf.c:349
> > >>>>>         #10 0x4e60bf in handle_internal_command perf.c:401
> > >>>>>         #11 0x4e6215 in run_argv perf.c:448
> > >>>>>         #12 0x4e653a in main perf.c:555
> > >>>>>         #13 0x7f8454e4fa72 in __libc_start_main libc-2.32.so[3ea72]
> > >>>>>         #14 0x43a3ee in _start ??:0
> > >>>>>
> > >>>>> The --overwrite option implies --tail-synthesize, which collects non-sample
> > >>>>> events reflecting the system status when recording finishes. However, when
> > >>>>> evsel opening fails (e.g., unsupported event 'cycles-ct'), session->evlist
> > >>>>> is not initialized and remains NULL. The code unconditionally calls
> > >>>>> record__synthesize() in the error path, which iterates through the NULL
> > >>>>> evlist pointer and causes a segfault.
> > >>>>>
> > >>>>> To fix it, move the record__synthesize() call inside the error check block, so
> > >>>>> it's only called when there was no error during recording, ensuring that evlist
> > >>>>> is properly initialized.
> > >>>>>
> > >>>>> Fixes: 4ea648aec019 ("perf record: Add --tail-synthesize option")
> > >>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > >>>>
> > >>>> This looks great! I wonder if we can add a test, perhaps here:
> > >>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/record.sh?h=perf-tools-next#n435
> > >>>> something like:
> > >>>> ```
> > >>>> $ perf record -e foobar -F 1000 -a --overwrite -o /dev/null -- sleep 0.1
> > >>>> ```
> > >>>> in a new test subsection for test_overwrite? foobar would be an event
> > >>>> that we could assume isn't present. Could you help with a test
> > >>>> covering the problems you've uncovered and perhaps related flags?
> > >>>>
> > >>>
> > >>> Hi, Ian,
> > >>>
> > >>> Good suggestion, I'd like to add a test. But foobar may not a good case.
> > >>>
> > >>> Regarding your example:
> > >>>
> > >>>     perf record -e foobar -a --overwrite -o /dev/null -- sleep 0.1
> > >>>     event syntax error: 'foobar'
> > >>>                          \___ Bad event name
> > >>>
> > >>>     Unable to find event on a PMU of 'foobar'
> > >>>     Run 'perf list' for a list of valid events
> > >>>
> > >>>      Usage: perf record [<options>] [<command>]
> > >>>         or: perf record [<options>] -- <command> [<options>]
> > >>>
> > >>>         -e, --event <event>   event selector. use 'perf list' to list available events
> > >>>
> > >>>
> > >>> The issue with using foobar is that it's an invalid event name, and the
> > >>> perf parser will reject it much earlier. This means the test would exit
> > >>> before reaching the part of the code path we want to verify (where
> > >>> record__synthesize() could be called).
> > >>>
> > >>> A potential alternative could be testing an error case such as EACCES:
> > >>>
> > >>>     perf record -e cycles -C 0 --overwrite -o /dev/null -- sleep 0.1
> > >>>
> > >>> This could reproduce the scenario of a failure when attempting to access
> > >>> a valid event, such as due to permission restrictions. However, the
> > >>> limitation here is that users may override
> > >>> /proc/sys/kernel/perf_event_paranoid, which affects whether or not this
> > >>> test would succeed in triggering an EACCES error.
> > >>>
> > >>>
> > >>> If you have any other suggestions or ideas for a better way to simulate
> > >>> this situation, I'd love to hear them.
> > >>>
> > >>> Thanks.
> > >>> Shuai
> > >>
> > >> Hi, Ian,
> > >>
> > >> Gentle ping.
> > >
> > > Sorry, for the delay. I was trying to think of a better way given the
> > > problems you mention and then got distracted. I wonder if a legacy
> > > event that core PMUs never implement would be a good candidate to
> > > test. For example, the event "node-prefetch-misses" is for "Local
> > > memory prefetch misses" but the memory controller tends to be a
> > > separate PMU and this event is never implemented to my knowledge.
> > > Running this locally I see:
> > >
> > > ```
> > > $ perf record -e node-prefetch-misses -a --overwrite -o /dev/null -- sleep 0.1
> > > Lowering default frequency rate from 4000 to 1750.
> > > Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
> > > Error:
> > > Failure to open event 'cpu_atom/node-prefetch-misses/' on PMU
> > > 'cpu_atom' which will be removed.
> > > No fallback found for 'cpu_atom/node-prefetch-misses/' for error 2
> > > Error:
> > > Failure to open event 'cpu_core/node-prefetch-misses/' on PMU
> > > 'cpu_core' which will be removed.
> > > No fallback found for 'cpu_core/node-prefetch-misses/' for error 2
> > > Error:
> > > Failure to open any events for recording.
> > > perf: Segmentation fault
> > >     #0 0x55a487ad8b87 in dump_stack debug.c:366
> > >     #1 0x55a487ad8bfd in sighandler_dump_stack debug.c:378
> > >     #2 0x55a4878c6f94 in sigsegv_handler builtin-record.c:722
> > >     #3 0x7f72aae49df0 in __restore_rt libc_sigaction.c:0
> > >     #4 0x55a487b57ef8 in __perf_event__synthesize_id_index
> > > synthetic-events.c:1862
> > >     #5 0x55a487b58346 in perf_event__synthesize_id_index synthetic-events.c:1943
> > >     #6 0x55a4878cb2a3 in record__synthesize builtin-record.c:2150
> > >     #7 0x55a4878cdada in __cmd_record builtin-record.c:2963
> > >     #8 0x55a4878d11ca in cmd_record builtin-record.c:4453
> > >     #9 0x55a48795b3cc in run_builtin perf.c:349
> > >     #10 0x55a48795b664 in handle_internal_command perf.c:401
> > >     #11 0x55a48795b7bd in run_argv perf.c:448
> > >     #12 0x55a48795bb06 in main perf.c:555
> > >     #13 0x7f72aae33ca8 in __libc_start_call_main libc_start_call_main.h:74
> > >     #14 0x7f72aae33d65 in __libc_start_main_alias_2 libc-start.c:128
> > >     #15 0x55a4878acf41 in _start perf[52f41]
> > > Segmentation fault
> > > ```
> >
> >
> > Hi, Ian，
> >
> > Is node-prefetch-misses a platform specific event? Running it on ARM Yitian 710
> > and Intel SPR platform, I see:
> >
> > $sudo perf record -e node-prefetch-misses
> > Error:
> > The node-prefetch-misses event is not supported.
> 
> Hi Shuai,
> 
> So node-prefetch-misses is a legacy event. Perf has a notion of events
> that are inbuilt to the kernel/PMU driver and get special fixed
> encodings. That said, the PMU driver in the kernel can just fail to
> support the events and I think that's uniformly the case for
> node-prefetch-misses. As shown by my reproduction of the crash, which
> I hope this suffices for a test - i.e. it is an event that parses but
> one that is never supported.

Maybe it's platform dependent.  I have no idea what's the best for this
test.  Any uncore event would work as well but it's not standardized.

I'll merge this fix first.

Thanks,
Namhyung


