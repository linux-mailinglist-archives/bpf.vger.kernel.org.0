Return-Path: <bpf+bounces-36190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D327A943B2A
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 02:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552831F232B7
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 00:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45DD16D4EF;
	Thu,  1 Aug 2024 00:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6qm1Ajp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F627158A1E;
	Thu,  1 Aug 2024 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471170; cv=none; b=Svk5xI9/CE6Anu0E3m6jp9kwdBN5trUWeUY9IIdzjOPNwVLsIgFcY2QSyk5XUcUBlEgkQrIqsIkri7a2TtMg9vGAKep1pcTGaoR+P6ZHsfUa50Q6eegcONlo0oHrLoiqOxN5LGRlqybzmqqKd6HPzb1u7VUWtLeozxE5f4a6gHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471170; c=relaxed/simple;
	bh=Fy8XJo46oUm48yce0+7UYQt99s2mqOhUCwrIB7eiB+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+rHX0/hMFGgXXymGA2c5mFBGRWDQy2A+fwveTiOFwKbPeJnPBznGmwVOJu43PptnQ0l/RY61x4oIfbxa5d+dvGZmch5NMkb07HrBNEy3/732JtVU805HoQ6bcHVTMr0wWu2n28PaHoYmWX/o/ntFPg0dZe/k7djRBio3+4xiME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6qm1Ajp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70246C116B1;
	Thu,  1 Aug 2024 00:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471169;
	bh=Fy8XJo46oUm48yce0+7UYQt99s2mqOhUCwrIB7eiB+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6qm1AjpTwSGt99mFSq2ecEzUsq4bx9A79o2bAxdIYlnfa0MNrHlSGmtLLTSEkxHw
	 RdN216olm+I8wchBEGoTjPhTAAU5/sBcg3VkhlrJBt/dK5SnuA7dSY7EMF6103kHcV
	 YLhHAHMIAsoOQPpi5w+QAghJIZVHPfcik63BtnJj8RP+mNjz3b9QGDqmZ4XROMAWVs
	 Z8N5bzwoKEILdjNNKKPq+KY5hz/M4FluTbfYcCYBoopC229gQo8MC8ub9K6/1zXf06
	 O5zkdNcvrlAss+Sb+9evPUDr1/yQKeIF7EbR24EqfgvUHw74Zq63/SdUJaq0u+c2iS
	 hnWYPS2mS/A0Q==
Date: Wed, 31 Jul 2024 17:12:47 -0700
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
Message-ID: <ZqrS_80S91EvnQE0@google.com>
References: <20240703223035.2024586-1-namhyung@kernel.org>
 <20240703223035.2024586-9-namhyung@kernel.org>
 <ZqpFvxFcZMHeAdqp@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqpFvxFcZMHeAdqp@x1>

On Wed, Jul 31, 2024 at 11:10:07AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jul 03, 2024 at 03:30:35PM -0700, Namhyung Kim wrote:
> > Now it can run the BPF filtering test with normal user if the BPF
> > objects are pinned by 'sudo perf record --setup-filter pin'.  Let's
> > update the test case to verify the behavior.  It'll skip the test if the
> > filter check is failed from a normal user, but it shows a message how to
> > set up the filters.
> > 
> > First, run the test as a normal user and it fails.
> > 
> >   $ perf test -vv filtering
> >    95: perf record sample filtering (by BPF) tests:
> >   --- start ---
> >   test child forked, pid 425677
> >   Checking BPF-filter privilege
> >   try 'sudo perf record --setup-filter pin' first.       <<<--- here
> >   bpf-filter test [Skipped permission]
> >   ---- end(-2) ----
> >    95: perf record sample filtering (by BPF) tests                     : Skip
> > 
> > According to the message, run the perf record command to pin the BPF
> > objects.
> > 
> >   $ sudo perf record --setup-filter pin
> > 
> > And re-run the test as a normal user.
> > 
> >   $ perf test -vv filtering
> >    95: perf record sample filtering (by BPF) tests:
> >   --- start ---
> >   test child forked, pid 424486
> >   Checking BPF-filter privilege
> >   Basic bpf-filter test
> >   Basic bpf-filter test [Success]
> >   Failing bpf-filter test
> >   Error: task-clock event does not have PERF_SAMPLE_CPU
> >   Failing bpf-filter test [Success]
> >   Group bpf-filter test
> >   Error: task-clock event does not have PERF_SAMPLE_CPU
> >   Error: task-clock event does not have PERF_SAMPLE_CODE_PAGE_SIZE
> >   Group bpf-filter test [Success]
> >   ---- end(0) ----
> >    95: perf record sample filtering (by BPF) tests                     : Ok
> 
> Ok, so I tested one of the examples you provide as a root user:
> 
> root@number:~# perf record -o- -e cycles:u --filter 'period < 10' perf test -w noploop | perf script -i-
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.024 MB - ]
>        perf-exec  228020 53029.825757:          1 cpu_core/cycles/u:      7fe361d1cc11 [unknown] ([unknown])
>        perf-exec  228020 53029.825760:          1 cpu_core/cycles/u:      7fe361d1cc11 [unknown] ([unknown])
>             perf  228020 53029.826313:          1 cpu_atom/cycles/u:      7fd80d7ba040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228020 53029.826316:          1 cpu_atom/cycles/u:      7fd80d7ba040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228020 53029.838051:          1 cpu_core/cycles/u:            53b062 noploop+0x62 (/home/acme/bin/perf)
>             perf  228020 53029.838054:          1 cpu_core/cycles/u:            53b062 noploop+0x62 (/home/acme/bin/perf)
>             perf  228020 53029.838055:          9 cpu_core/cycles/u:            53b062 noploop+0x62 (/home/acme/bin/perf)
>             perf  228020 53029.844137:          1 cpu_core/cycles/u:            53b05c noploop+0x5c (/home/acme/bin/perf)
>             perf  228020 53029.844139:          1 cpu_core/cycles/u:            53b05c noploop+0x5c (/home/acme/bin/perf)
> root@number:~# perf record -o- -e cycles:u --filter 'period < 100000' perf test -w noploop | perf script -i-
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.025 MB - ]
>        perf-exec  228084 53076.760776:          1 cpu_core/cycles/u:      7f7e7691cc11 [unknown] ([unknown])
>        perf-exec  228084 53076.760779:          1 cpu_core/cycles/u:      7f7e7691cc11 [unknown] ([unknown])
>        perf-exec  228084 53076.760779:         10 cpu_core/cycles/u:      7f7e7691cc11 [unknown] ([unknown])
>        perf-exec  228084 53076.760780:        497 cpu_core/cycles/u:      7f7e7691cc11 [unknown] ([unknown])
>        perf-exec  228084 53076.760781:      27924 cpu_core/cycles/u:      7f7e7691cc11 [unknown] ([unknown])
>             perf  228084 53076.761318:          1 cpu_atom/cycles/u:      7f317057d040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228084 53076.761320:          1 cpu_atom/cycles/u:      7f317057d040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228084 53076.761321:         14 cpu_atom/cycles/u:      7f317057d040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228084 53076.761322:        518 cpu_atom/cycles/u:      7f317057d040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228084 53076.761322:      20638 cpu_atom/cycles/u:      7f317057d040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228084 53076.768070:          1 cpu_core/cycles/u:      7f317056e898 _dl_relocate_object+0x1d8 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228084 53076.768072:          1 cpu_core/cycles/u:      7f317056e898 _dl_relocate_object+0x1d8 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228084 53076.768073:         17 cpu_core/cycles/u:      7f317056e898 _dl_relocate_object+0x1d8 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228084 53076.768073:        836 cpu_core/cycles/u:      7f317056e898 _dl_relocate_object+0x1d8 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228084 53076.768074:      44346 cpu_core/cycles/u:      7f317056e89b _dl_relocate_object+0x1db (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228084 53076.843976:          1 cpu_core/cycles/u:            53b05c noploop+0x5c (/home/acme/bin/perf)
>             perf  228084 53076.843978:          1 cpu_core/cycles/u:            53b05c noploop+0x5c (/home/acme/bin/perf)
>             perf  228084 53076.843979:         13 cpu_core/cycles/u:            53b05c noploop+0x5c (/home/acme/bin/perf)
>             perf  228084 53076.843979:        563 cpu_core/cycles/u:            53b05c noploop+0x5c (/home/acme/bin/perf)
>             perf  228084 53076.843980:      26519 cpu_core/cycles/u:            53b05c noploop+0x5c (/home/acme/bin/perf)
>             perf  228084 53077.482090:          1 cpu_core/cycles/u:            53b062 noploop+0x62 (/home/acme/bin/perf)
>             perf  228084 53077.482092:          1 cpu_core/cycles/u:            53b062 noploop+0x62 (/home/acme/bin/perf)
>             perf  228084 53077.482093:         15 cpu_core/cycles/u:            53b062 noploop+0x62 (/home/acme/bin/perf)
>             perf  228084 53077.482093:        746 cpu_core/cycles/u:            53b062 noploop+0x62 (/home/acme/bin/perf)
>             perf  228084 53077.482094:      38315 cpu_core/cycles/u:            53b05c noploop+0x5c (/home/acme/bin/perf)
> root@number:~#
> 
> Filtering by period works as advertised, now I have done as root;
> 
> root@number:~# perf record --setup-filter pin
> root@number:~# ls -la /sys/fs/bpf/perf_filter/
> total 0
> drwxr-xr-x. 2 root root 0 Jul 31 10:43 .
> drwxr-xr-t. 3 root root 0 Jul 31 10:43 ..
> -rw-rw-rw-. 1 root root 0 Jul 31 10:43 dropped
> -rw-rw-rw-. 1 root root 0 Jul 31 10:43 filters
> -rwxrwxrwx. 1 root root 0 Jul 31 10:43 perf_sample_filter
> -rw-rw-rw-. 1 root root 0 Jul 31 10:43 pid_hash
> -rw-------. 1 root root 0 Jul 31 10:43 sample_f_rodata
> root@number:~# ls -la /sys/fs/bpf/perf_filter/perf_sample_filter 
> -rwxrwxrwx. 1 root root 0 Jul 31 10:43 /sys/fs/bpf/perf_filter/perf_sample_filter
> root@number:~#
> 
> And as a normal user I try:
> 
> acme@number:~$ perf record -o- -e cycles:u perf test -w noploop | perf script -i- | head
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.204 MB - ]
>             perf  228218 53158.670585:          1 cpu_atom/cycles/u:      7f2fb1b6e040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228218 53158.670590:          1 cpu_atom/cycles/u:      7f2fb1b6e040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228218 53158.670592:          7 cpu_atom/cycles/u:      7f2fb1b6e040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228218 53158.670593:        117 cpu_atom/cycles/u:      7f2fb1b6e040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228218 53158.670595:       2152 cpu_atom/cycles/u:      7f2fb1b6e040 _start+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228218 53158.670604:      38977 cpu_atom/cycles/u:  ffffffff99201280 [unknown] ([unknown])
>             perf  228218 53158.670650:     167064 cpu_atom/cycles/u:      7f2fb1b67d7c intel_check_word.constprop.0+0x16c (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228218 53158.671472:     232830 cpu_atom/cycles/u:      7f2fb1b75d98 strcmp+0x78 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228218 53158.672710:     191183 cpu_atom/cycles/u:      7f2fb1b59311 _dl_map_object_from_fd+0xea1 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  228218 53158.673461:     158125 cpu_atom/cycles/u:      7f2fb1b77148 strcmp+0x1428 (/usr/lib64/ld-linux-x86-64.so.2)
> acme@number:~$
> 
> Ok, no filtering, bot samples, lets try to use filtering as with root:
> 
> acme@number:~$ perf record -o- -e cycles:u --filter 'period < 10000000' perf test -w noploop | perf script -i-
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.019 MB - ]
> acme@number:~$ perf record -o- -e cycles:u --filter 'period < 10000000' perf test -w noploop | perf script -i-
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.019 MB - ]
> acme@number:~$ perf record -o- -e cycles:u --filter 'period < 10000000' perf test -w noploop | perf script -i-
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.019 MB - ]
> acme@number:~$ perf record -o- -e cycles:u --filter 'period < 10000000' perf test -w noploop | perf script -i-
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.019 MB - ]
> acme@number:~$

Hmm.. strange.  The above command works well for me.

> 
> acme@number:~$ perf record -v -e cycles:u --filter 'period < 10000000' perf test -w noploop 
> Using CPUID GenuineIntel-6-B7-1
> DEBUGINFOD_URLS=
> nr_cblocks: 0
> affinity: SYS
> mmap flush: 1
> comp level: 0
> Problems creating module maps, continuing anyway...
> pid hash: 228434 -> 13
> pid hash: 228434 -> 14

This part is a little strange as it's using two entries.  Hmm, are you
using a hybrid machine?  Anyway I think it should work there too..

Also the number is too high.. I expect 1 or 2.  Maybe it didn't release
all the entries.  Let me think about the case.

Thanks,
Namhyung


> mmap size 528384B
> Control descriptor is not initialized
> Couldn't start the BPF side band thread:
> BPF programs starting from now on won't be annotatable
> [ perf record: Woken up 1 times to write data ]
> failed to write feature CPU_PMU_CAPS
> [ perf record: Captured and wrote 0.009 MB perf.data ]
> acme@number:~$
> 
> I also tried with task-clock:
> 
> acme@number:~$ perf record -o- -e task-clock -c 10000 perf test -w noploop | perf script -i- | head
>             perf  229784 54146.473644:      10000 task-clock:u:      7faf38f1c622 get_common_indices.constprop.0+0xa2 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  229784 54146.473654:      10000 task-clock:u:      7faf38f1d323 update_active.constprop.0+0x383 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  229784 54146.473664:      10000 task-clock:u:      7faf38f1cd32 intel_check_word.constprop.0+0x122 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  229784 54146.473674:      10000 task-clock:u:      7faf38f1cd7c intel_check_word.constprop.0+0x16c (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  229784 54146.473684:      10000 task-clock:u:      7faf38f19de5 __tunable_get_val+0x75 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  229784 54146.473704:      10000 task-clock:u:      7faf38f190d0 rtld_mutex_dummy+0x0 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  229784 54146.473754:      10000 task-clock:u:      7faf38f1a80e _dl_cache_libcmp+0xe (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  229784 54146.473864:      10000 task-clock:u:      7faf38f2adb9 strcmp+0x99 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  229784 54146.473954:      10000 task-clock:u:      7faf38f1aa02 search_cache+0x112 (/usr/lib64/ld-linux-x86-64.so.2)
>             perf  229784 54146.474024:      10000 task-clock:u:      7faf38f0de38 _dl_map_object_from_fd+0x9c8 (/usr/lib64/ld-linux-x86-64.so.2)
> acme@number:~$ 
> acme@number:~$ perf record -o- -e task-clock -c 10000 --filter 'ip < 0xffffffff00000000' perf test -w noploop | perf script -i- 
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.127 MB - ]
> acme@number:~$
> 
> Ideas?
> 
> I'm keeping it in my local tree so that I run it through the container
> build tests meanwhile we try to understand this, what am I missing?
> 
> - Arnaldo
> 
> ⬢[acme@toolbox perf-tools-next]$ uname -a
> Linux toolbox 6.9.10-200.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jul 18 21:39:30 UTC 2024 x86_64 GNU/Linux
> ⬢[acme@toolbox perf-tools-next]$ perf -vv
> perf version 6.11.rc1.g77a71e434cf4
>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
>             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>            libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>                libpfm4: [ on  ]  # HAVE_LIBPFM
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
>   dwarf-unwind-support: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
>             libopencsd: [ on  ]  # HAVE_CSTRACE_SUPPORT
> ⬢[acme@toolbox perf-tools-next]$ git log --oneline -10
> 2a24133dc55000b3 (HEAD -> perf-tools-next) perf test: Update sample filtering test
> d6fed13469889202 perf record: Add --setup-filter option
> d8a2ec627150b7a4 perf record: Fix a potential error handling issue
> b0313e52f43035b5 perf bpf-filter: Support separate lost counts for each filter
> eb29dacbaf215fda perf bpf-filter: Support pin/unpin BPF object
> 086e7d06af7ce4eb perf bpf-filter: Split per-task filter use case
> d3453d1bb80cdbb2 perf bpf-filter: Pass 'target' to perf_bpf_filter__prepare()
> 736cd1c7a7105e1d perf bpf-filter: Make filters map a single entry hashmap
> 96ff640908b9808e perf jevents: Don't stop at the first matched pmu when searching a events table
> 379fe1f78ed5ceaf perf jevents: Use name for special find value (PMU_EVENTS__NOT_FOUND)
> ⬢[acme@toolbox perf-tools-next]$
>  
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/shell/record_bpf_filter.sh | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/perf/tests/shell/record_bpf_filter.sh b/tools/perf/tests/shell/record_bpf_filter.sh
> > index 31c593966e8c..c5882d620db7 100755
> > --- a/tools/perf/tests/shell/record_bpf_filter.sh
> > +++ b/tools/perf/tests/shell/record_bpf_filter.sh
> > @@ -22,15 +22,16 @@ trap trap_cleanup EXIT TERM INT
> >  test_bpf_filter_priv() {
> >    echo "Checking BPF-filter privilege"
> >  
> > -  if [ "$(id -u)" != 0 ]
> > -  then
> > -    echo "bpf-filter test [Skipped permission]"
> > -    err=2
> > -    return
> > -  fi
> >    if ! perf record -e task-clock --filter 'period > 1' \
> >  	  -o /dev/null --quiet true 2>&1
> >    then
> > +    if [ "$(id -u)" != 0 ]
> > +    then
> > +      echo "try 'sudo perf record --setup-filter pin' first."
> > +      echo "bpf-filter test [Skipped permission]"
> > +      err=2
> > +      return
> > +    fi
> >      echo "bpf-filter test [Skipped missing BPF support]"
> >      err=2
> >      return
> > -- 
> > 2.45.2.803.g4e1b14247a-goog
> > 

