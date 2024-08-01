Return-Path: <bpf+bounces-36244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 667D6945478
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 00:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897821C22FF6
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 22:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EEA14D2BE;
	Thu,  1 Aug 2024 22:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLRbpe5V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61726145352;
	Thu,  1 Aug 2024 22:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722550949; cv=none; b=Q0CprLZT2kkj3R2jj0IxXxlkfdvqqcbQt1gXe+WNx33LcK5H3SqeDpHy5u4za1PqXVTR6eg683CCwj/+UqufooQ++OKNWVdjGvilt3iw/0CAyXU8PIoy6OOc03+GJjPVmvo5nasgbXYHCArh88h8LcD282o9VvAvY8uh8kgTigg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722550949; c=relaxed/simple;
	bh=l5u3lUTgXMYP2PHhcTr2ciMaIUga+HNMya4jSM+s2A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUAvS59LawvYIucZfhYnRtT2q/7pBvHOoHJZBe1MXR+eSgf+YVS6AqCw9u9Yx4scrbL1a07iLYBqbwYokMRM/KeZJuK171HNqp/n4oM8X4j58EcJNwmHdbSFU015NkpUz/bLYDiPzzljF12b1qXCM7BNRPbiBjVYC9B2dvL/JQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLRbpe5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861CEC32786;
	Thu,  1 Aug 2024 22:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722550949;
	bh=l5u3lUTgXMYP2PHhcTr2ciMaIUga+HNMya4jSM+s2A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLRbpe5V+mhOuQa+wrzDnfe34cu+ZxOI98tLYyzXKTHPHIaLeW6T4+xl4a5ORTjGH
	 /4YNqcEuP32VOXy4W3PR64gfME/LJ/lB+VrD1GCM8E0sDpJSh+nXX/fb08hp8Z77jU
	 BxNxplR39aE47/mOWuRiugtIlUbihx2RfJ3/QK2kx25n+w8rlkn1s5bdazkKzzQtzf
	 2lRKT4GxVhSqbi0iGDjkL/I5Y7GjLxNqziP/3i1luvT+HodfZeCOMcjx6w9yVUst60
	 dRnLpzeR/0CzbfCUz3BVT2OqernvWIBtjVlVczZpzFD985P4T8B/ktJY87R9r2HLFn
	 0QmaUSqy75vUQ==
Date: Thu, 1 Aug 2024 15:22:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
	Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 8/8] perf test: Update sample filtering test
Message-ID: <ZqwKoWpBN9G3u-K0@google.com>
References: <20240703223035.2024586-1-namhyung@kernel.org>
 <20240703223035.2024586-9-namhyung@kernel.org>
 <ZqpFvxFcZMHeAdqp@x1>
 <ZqrS_80S91EvnQE0@google.com>
 <ZqukTsjWqbx-xZ7L@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqukTsjWqbx-xZ7L@x1>

On Thu, Aug 01, 2024 at 12:05:50PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jul 31, 2024 at 05:12:47PM -0700, Namhyung Kim wrote:
> > On Wed, Jul 31, 2024 at 11:10:07AM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Wed, Jul 03, 2024 at 03:30:35PM -0700, Namhyung Kim wrote:
> > > > Now it can run the BPF filtering test with normal user if the BPF
> > > > objects are pinned by 'sudo perf record --setup-filter pin'.  Let's
> > > > update the test case to verify the behavior.  It'll skip the test if the
> > > > filter check is failed from a normal user, but it shows a message how to
> > > > set up the filters.
> > > > 
> > > > First, run the test as a normal user and it fails.
> > > > 
> > > >   $ perf test -vv filtering
> > > >    95: perf record sample filtering (by BPF) tests:
> > > >   --- start ---
> > > >   test child forked, pid 425677
> > > >   Checking BPF-filter privilege
> > > >   try 'sudo perf record --setup-filter pin' first.       <<<--- here
> > > >   bpf-filter test [Skipped permission]
> > > >   ---- end(-2) ----
> > > >    95: perf record sample filtering (by BPF) tests                     : Skip
> > > > 
> > > > According to the message, run the perf record command to pin the BPF
> > > > objects.
> > > > 
> > > >   $ sudo perf record --setup-filter pin
> > > > 
> > > > And re-run the test as a normal user.
> > > > 
> > > >   $ perf test -vv filtering
> > > >    95: perf record sample filtering (by BPF) tests:
> > > >   --- start ---
> > > >   test child forked, pid 424486
> > > >   Checking BPF-filter privilege
> > > >   Basic bpf-filter test
> > > >   Basic bpf-filter test [Success]
> > > >   Failing bpf-filter test
> > > >   Error: task-clock event does not have PERF_SAMPLE_CPU
> > > >   Failing bpf-filter test [Success]
> > > >   Group bpf-filter test
> > > >   Error: task-clock event does not have PERF_SAMPLE_CPU
> > > >   Error: task-clock event does not have PERF_SAMPLE_CODE_PAGE_SIZE
> > > >   Group bpf-filter test [Success]
> > > >   ---- end(0) ----
> > > >    95: perf record sample filtering (by BPF) tests                     : Ok
> > > 
> > > Ok, so I tested one of the examples you provide as a root user:
> > > 
> > > root@number:~# perf record -o- -e cycles:u --filter 'period < 10' perf test -w noploop | perf script -i-
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.024 MB - ]
> > >        perf-exec  228020 53029.825757:          1 cpu_core/cycles/u:      7fe361d1cc11 [unknown] ([unknown])
> > >        perf-exec  228020 53029.825760:          1 cpu_core/cycles/u:      7fe361d1cc11 [unknown] ([unknown])
> > >             perf  228020 53029.826313:          1 cpu_atom/cycles/u:      7fd80d7ba040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228020 53029.826316:          1 cpu_atom/cycles/u:      7fd80d7ba040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228020 53029.838051:          1 cpu_core/cycles/u:            53b062 noploop+0x62 (/home/acme/bin/perf)
> > >             perf  228020 53029.838054:          1 cpu_core/cycles/u:            53b062 noploop+0x62 (/home/acme/bin/perf)
> > >             perf  228020 53029.838055:          9 cpu_core/cycles/u:            53b062 noploop+0x62 (/home/acme/bin/perf)
> > >             perf  228020 53029.844137:          1 cpu_core/cycles/u:            53b05c noploop+0x5c (/home/acme/bin/perf)
> > >             perf  228020 53029.844139:          1 cpu_core/cycles/u:            53b05c noploop+0x5c (/home/acme/bin/perf)
> > > root@number:~# perf record -o- -e cycles:u --filter 'period < 100000' perf test -w noploop | perf script -i-
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.025 MB - ]
> > >        perf-exec  228084 53076.760776:          1 cpu_core/cycles/u:      7f7e7691cc11 [unknown] ([unknown])
> > >        perf-exec  228084 53076.760779:          1 cpu_core/cycles/u:      7f7e7691cc11 [unknown] ([unknown])
> > >        perf-exec  228084 53076.760779:         10 cpu_core/cycles/u:      7f7e7691cc11 [unknown] ([unknown])
> > >        perf-exec  228084 53076.760780:        497 cpu_core/cycles/u:      7f7e7691cc11 [unknown] ([unknown])
> > >        perf-exec  228084 53076.760781:      27924 cpu_core/cycles/u:      7f7e7691cc11 [unknown] ([unknown])
> > >             perf  228084 53076.761318:          1 cpu_atom/cycles/u:      7f317057d040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228084 53076.761320:          1 cpu_atom/cycles/u:      7f317057d040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228084 53076.761321:         14 cpu_atom/cycles/u:      7f317057d040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228084 53076.761322:        518 cpu_atom/cycles/u:      7f317057d040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228084 53076.761322:      20638 cpu_atom/cycles/u:      7f317057d040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228084 53076.768070:          1 cpu_core/cycles/u:      7f317056e898 _dl_relocate_object+0x1d8 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228084 53076.768072:          1 cpu_core/cycles/u:      7f317056e898 _dl_relocate_object+0x1d8 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228084 53076.768073:         17 cpu_core/cycles/u:      7f317056e898 _dl_relocate_object+0x1d8 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228084 53076.768073:        836 cpu_core/cycles/u:      7f317056e898 _dl_relocate_object+0x1d8 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228084 53076.768074:      44346 cpu_core/cycles/u:      7f317056e89b _dl_relocate_object+0x1db (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228084 53076.843976:          1 cpu_core/cycles/u:            53b05c noploop+0x5c (/home/acme/bin/perf)
> > >             perf  228084 53076.843978:          1 cpu_core/cycles/u:            53b05c noploop+0x5c (/home/acme/bin/perf)
> > >             perf  228084 53076.843979:         13 cpu_core/cycles/u:            53b05c noploop+0x5c (/home/acme/bin/perf)
> > >             perf  228084 53076.843979:        563 cpu_core/cycles/u:            53b05c noploop+0x5c (/home/acme/bin/perf)
> > >             perf  228084 53076.843980:      26519 cpu_core/cycles/u:            53b05c noploop+0x5c (/home/acme/bin/perf)
> > >             perf  228084 53077.482090:          1 cpu_core/cycles/u:            53b062 noploop+0x62 (/home/acme/bin/perf)
> > >             perf  228084 53077.482092:          1 cpu_core/cycles/u:            53b062 noploop+0x62 (/home/acme/bin/perf)
> > >             perf  228084 53077.482093:         15 cpu_core/cycles/u:            53b062 noploop+0x62 (/home/acme/bin/perf)
> > >             perf  228084 53077.482093:        746 cpu_core/cycles/u:            53b062 noploop+0x62 (/home/acme/bin/perf)
> > >             perf  228084 53077.482094:      38315 cpu_core/cycles/u:            53b05c noploop+0x5c (/home/acme/bin/perf)
> > > root@number:~#
> > > 
> > > Filtering by period works as advertised, now I have done as root;
> > > 
> > > root@number:~# perf record --setup-filter pin
> > > root@number:~# ls -la /sys/fs/bpf/perf_filter/
> > > total 0
> > > drwxr-xr-x. 2 root root 0 Jul 31 10:43 .
> > > drwxr-xr-t. 3 root root 0 Jul 31 10:43 ..
> > > -rw-rw-rw-. 1 root root 0 Jul 31 10:43 dropped
> > > -rw-rw-rw-. 1 root root 0 Jul 31 10:43 filters
> > > -rwxrwxrwx. 1 root root 0 Jul 31 10:43 perf_sample_filter
> > > -rw-rw-rw-. 1 root root 0 Jul 31 10:43 pid_hash
> > > -rw-------. 1 root root 0 Jul 31 10:43 sample_f_rodata
> > > root@number:~# ls -la /sys/fs/bpf/perf_filter/perf_sample_filter 
> > > -rwxrwxrwx. 1 root root 0 Jul 31 10:43 /sys/fs/bpf/perf_filter/perf_sample_filter
> > > root@number:~#
> > > 
> > > And as a normal user I try:
> > > 
> > > acme@number:~$ perf record -o- -e cycles:u perf test -w noploop | perf script -i- | head
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.204 MB - ]
> > >             perf  228218 53158.670585:          1 cpu_atom/cycles/u:      7f2fb1b6e040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228218 53158.670590:          1 cpu_atom/cycles/u:      7f2fb1b6e040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228218 53158.670592:          7 cpu_atom/cycles/u:      7f2fb1b6e040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228218 53158.670593:        117 cpu_atom/cycles/u:      7f2fb1b6e040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228218 53158.670595:       2152 cpu_atom/cycles/u:      7f2fb1b6e040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228218 53158.670604:      38977 cpu_atom/cycles/u:  ffffffff99201280 [unknown] ([unknown])
> > >             perf  228218 53158.670650:     167064 cpu_atom/cycles/u:      7f2fb1b67d7c intel_check_word.constprop.0+0x16c (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228218 53158.671472:     232830 cpu_atom/cycles/u:      7f2fb1b75d98 strcmp+0x78 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228218 53158.672710:     191183 cpu_atom/cycles/u:      7f2fb1b59311 _dl_map_object_from_fd+0xea1 (/usr/lib64/ld-linux-x86-64.so.2)
> > >             perf  228218 53158.673461:     158125 cpu_atom/cycles/u:      7f2fb1b77148 strcmp+0x1428 (/usr/lib64/ld-linux-x86-64.so.2)
> > > acme@number:~$
> > > 
> > > Ok, no filtering, bot samples, lets try to use filtering as with root:
> > > 
> > > acme@number:~$ perf record -o- -e cycles:u --filter 'period < 10000000' perf test -w noploop | perf script -i-
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.019 MB - ]
> > > acme@number:~$ perf record -o- -e cycles:u --filter 'period < 10000000' perf test -w noploop | perf script -i-
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.019 MB - ]
> > > acme@number:~$ perf record -o- -e cycles:u --filter 'period < 10000000' perf test -w noploop | perf script -i-
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.019 MB - ]
> > > acme@number:~$ perf record -o- -e cycles:u --filter 'period < 10000000' perf test -w noploop | perf script -i-
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.019 MB - ]
> > > acme@number:~$
> > 
> > Hmm.. strange.  The above command works well for me.
> > 
> > > 
> > > acme@number:~$ perf record -v -e cycles:u --filter 'period < 10000000' perf test -w noploop 
> > > Using CPUID GenuineIntel-6-B7-1
> > > DEBUGINFOD_URLS=
> > > nr_cblocks: 0
> > > affinity: SYS
> > > mmap flush: 1
> > > comp level: 0
> > > Problems creating module maps, continuing anyway...
> > > pid hash: 228434 -> 13
> > > pid hash: 228434 -> 14
> > 
> > This part is a little strange as it's using two entries.  Hmm, are you
> > using a hybrid machine?  Anyway I think it should work there too..
> 
> Yes, I'll try it again on a 5950x since it isn't hybrid.
> 
> > Also the number is too high.. I expect 1 or 2.  Maybe it didn't release
> > all the entries.  Let me think about the case.
> 
> I'm inclined for now to keep this series merged and then take fixes on
> top, please advise if this isn't ok with you.

No objections, I'll investigate why it failed on your machine..

Thanks,
Namhyung


