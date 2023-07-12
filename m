Return-Path: <bpf+bounces-4858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F8E750CBB
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 17:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8461C21160
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C1624183;
	Wed, 12 Jul 2023 15:39:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9ED24169
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 15:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C662C433C7;
	Wed, 12 Jul 2023 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689176373;
	bh=kd5GqcBZiouq7TUihxd1vamZF0QZihUM3A0Xx+8Vd+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TebfYEGi8HDqVFsi2KAYUjKROan2KNGntvLx+K+ifVbCPcMx0x83V1O+Xf6OCbuCO
	 J285wr1USjuQ+UD3oUG8gwQ4tykNeoewzZW/PamcL5iEUU55LWjmymlcAYUzDlSrtD
	 uXga3oKr9JLlP2MqkJbvUZD36UfdqSc8Goaoc2Fbim0+k0w/B6LDXUt3YXCDwP1rTQ
	 9UZeHO1uU4U7dn9hynSRaOrcMhrcwFjD/pIGx2YlBcKOGYqkzkJHyWZLikmdfoxEb+
	 A/Nvl7AWhAsWg4ey2zT95wCytFj8/Ly/CyEwqY3nFIqKsOYZtrRNfwGwD1drNR2+8b
	 DpMSKMP/4lzHw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 69C5B40516; Wed, 12 Jul 2023 12:39:30 -0300 (-03)
Date: Wed, 12 Jul 2023 12:39:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [BUG] perf test: Regression because of d6e6286a12e7
Message-ID: <ZK7JMjN9LXTFEOvT@kernel.org>
References: <ab865e6d-06c5-078e-e404-7f90686db50d@amd.com>
 <CAEf4BzZK=zm9PkUwzJRgeQ=KXjKOK9TENUMTz+_FmU6kPjab7Q@mail.gmail.com>
 <78044efc-98d7-cd49-d2b5-4c2abb16d6c9@amd.com>
 <CAEf4BzZCrDftNdNicuMS7NoF+hNiQEQwsH_-RMBh3Xxg+AQwiw@mail.gmail.com>
 <146e00be-98c8-873d-081f-252647b71b12@amd.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <146e00be-98c8-873d-081f-252647b71b12@amd.com>
X-Url: http://acmel.wordpress.com

Em Wed, Jul 12, 2023 at 07:38:58PM +0530, Ravi Bangoria escreveu:
> On 11-Jul-23 3:06 AM, Andrii Nakryiko wrote:
> > On Sun, Jul 9, 2023 at 9:05 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >> On 08-Jul-23 4:46 AM, Andrii Nakryiko wrote:
> >>> On Wed, Jul 5, 2023 at 9:39 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >>>> I'm seeing perf test failure because of commit d6e6286a12e7 ("libbpf:
> >>>> disassociate section handler on explicit bpf_program__set_type() call").

> >>> Yep, this commit would reset catch-all custom handler, which perf is
> >>> setting. I've just sent a fix upstream ([0]). And once it lands, I'll
> >>> cut a v1.2.1 libbpf bugfix release with just this fix on top of v1.2.

> >>> Can you please double-check that this patch indeed fixes the issue for
> >>> you? I tried to do this locally, but for me perf test 42 fails both at
> >>> current bpf-next, with the above commit reverted, and with my fix
> >>> applied on top. So I can't be 100% sure.

> >>>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20230707231156.1711948-1-andrii@kernel.org/

> >> Thanks. A quick test seems to be working fine.

> > Alright, thanks for confirming! I've just released v1.2.1 bug fix
> > release with just this fix on top of v1.2.

> > Thanks for reporting!

> > But given v1.2 was cut on May 1st, and the offending commit landed
> > some time late March, I wonder how did this slip through the cracks
> > and go unreported for so long? Is there something we can do to catch
> > these perf-only regressions a bit sooner?

> I guess it got slipped because that patch went in via bpf tree. Would
> it be possible to run bpf related perf tests at the time of applying
> libbpf patches? Arnaldo might have better ideas :)

Right, perhaps the libbpf CI could try building perf, preferably with
BUILD_BPF_SKEL=1, to enable these tools:

[acme@nine linux]$ ls -la tools/perf/util/bpf_skel/*.bpf.*
-rw-r--r--. 1 acme acme  5581 Jul  7 12:38 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
-rw-r--r--. 1 acme acme  1764 Jul  7 12:38 tools/perf/util/bpf_skel/bperf_follower.bpf.c
-rw-r--r--. 1 acme acme  1438 Jul  7 12:38 tools/perf/util/bpf_skel/bperf_leader.bpf.c
-rw-r--r--. 1 acme acme  2290 Jul  7 12:38 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
-rw-r--r--. 1 acme acme  2164 Jul  7 12:38 tools/perf/util/bpf_skel/func_latency.bpf.c
-rw-r--r--. 1 acme acme  9017 Jul  7 12:38 tools/perf/util/bpf_skel/kwork_trace.bpf.c
-rw-r--r--. 1 acme acme 10147 Jul 12 11:49 tools/perf/util/bpf_skel/lock_contention.bpf.c
-rw-r--r--. 1 acme acme  6109 Jul  7 12:38 tools/perf/util/bpf_skel/off_cpu.bpf.c
-rw-r--r--. 1 acme acme  4932 Jul  7 12:38 tools/perf/util/bpf_skel/sample_filter.bpf.c
[acme@nine linux]$

There are 'perf test' entries for the BPF support in perf that is pre
libbpf skel functionality above and as well some for the libbpf based
skel features, such as:

[root@quaco ~]# perf test -vvv contention
 87: kernel lock contention analysis test                            :
--- start ---
test child forked, pid 213314
Testing perf lock record and perf lock contention
Testing perf lock contention --use-bpf
Testing perf lock record and perf lock contention at the same time
Testing perf lock contention --threads
Testing perf lock contention --lock-addr
Testing perf lock contention --type-filter (w/ spinlock)
Testing perf lock contention --lock-filter (w/ tasklist_lock)
Testing perf lock contention --callstack-filter (w/ unix_stream)
Testing perf lock contention --callstack-filter with task aggregation
Testing perf lock contention CSV output
test child finished with 0
---- end ----
kernel lock contention analysis test: Ok
[root@quaco ~]#

We could perhaps add support for some kind of tags to the tests, to
help run just the ones that use bpf and then you could use:

 # perf test --uses bpf

At first we would just add this tag, then we would use it for other
stuff as the need arises to run just a subset of the tests.

But for now you could start perhaps with:

[root@quaco ~]# perf test LLVM ; perf test "BPF " ; perf test "lock contention"
 40: LLVM search and compile                                         :
 40.1: Basic BPF llvm compile                                        : Ok
 40: LLVM search and compile                                         :
 40.1: Basic BPF llvm compile                                        : Ok
 40.3: Compile source for BPF prologue generation                    : Ok
 40.4: Compile source for BPF relocation                             : Ok
 42: BPF filter                                                      :
 42.1: Basic BPF filtering                                           : Ok
 42.2: BPF pinning                                                   : Ok
 42.3: BPF prologue generation                                       : FAILED!
 87: kernel lock contention analysis test                            : Ok
[root@quaco ~]#

- Arnaldo

