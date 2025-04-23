Return-Path: <bpf+bounces-56504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B094A99502
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 18:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771E41BA31CB
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 16:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4610F27FD7D;
	Wed, 23 Apr 2025 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IriTGtjo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ED927FD42;
	Wed, 23 Apr 2025 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425178; cv=none; b=hMoxFZCZ0mPZ6hyadJyHqRvrxHnKYy3qsjQqRcOC5ODaaXEb4wsQ0lCgEkNo4pEzaClequ5rRiluB4jBH2c+Ez2tOSvX7u1eIqdjT6sr2ogPwzDgPJDnvGBXhsfYHl34VudBmS8Vy4RN1x4tz4G+6LDnXx1rpACdGSCXXq2JM2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425178; c=relaxed/simple;
	bh=q6ScX9mWRWztFOA5aq1RyBHqHRm/hPzxoPr1yx5+Sbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOblEs0Ttw9sCyEwFe571PhEaeFhF3uobp8pfUezehAjxCDi9JeIob295smsrYiaF2zYFg28SOBWGGwi+jb2086PbClyAInOtDa15P89qMrMb6Y1AN5Q/KHX34v6Nr++4Q7ZC83l7lDJS1tSQjlmWp4NhOzirB9vDUM9yPqiBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IriTGtjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFD6C4CEE8;
	Wed, 23 Apr 2025 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745425178;
	bh=q6ScX9mWRWztFOA5aq1RyBHqHRm/hPzxoPr1yx5+Sbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IriTGtjo2LqN3oML1AWXEYX7t6sgbaii8sJNCRpB2GEGZykrnN5rAM/2Tez9f1k30
	 A8SXm0G3RuyJomLqNYomZpZzrd2Xsv4KQoDfnnaRA4WsZ5BZc9xIEV89Untwy9itYn
	 dTAx9Gq89eDsITq96jX60WqBLMgXaO9UZqyX7p3ZUtZ6cdpa5wQzJfhd7AhqDouw9Q
	 VU+pSyImBjg1Qe1BC/HwJso6uAsuQpyuIe0iojlbzJYLNhCRh9B0xlPc/Cws187ioL
	 qK7ai2DW1Jeocqg/oEVEIyttRnQs0OshGM+oFGzqorr5TrAZ9OHDINzO2j+V8EcbAr
	 B+09mRb4A1MCA==
Date: Wed, 23 Apr 2025 13:19:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 1/2] perf trace: Implement syscall summary in BPF
Message-ID: <aAkTFyihA9bwBx6V@x1>
References: <20250326044001.3503432-1-namhyung@kernel.org>
 <CAH0uvojPaZ-byE-quc=sUvXyExaZPU3PUjdTYOzE5iDAT_wNVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvojPaZ-byE-quc=sUvXyExaZPU3PUjdTYOzE5iDAT_wNVA@mail.gmail.com>

On Fri, Mar 28, 2025 at 06:46:36PM -0700, Howard Chu wrote:
> Hello Namhyung,
> 
> On Tue, Mar 25, 2025 at 9:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > When -s/--summary option is used, it doesn't need (augmented) arguments
> > of syscalls.  Let's skip the augmentation and load another small BPF
> > program to collect the statistics in the kernel instead of copying the
> > data to the ring-buffer to calculate the stats in userspace.  This will
> > be much more light-weight than the existing approach and remove any lost
> > events.
> >
> > Let's add a new option --bpf-summary to control this behavior.  I cannot
> > make it default because there's no way to get e_machine in the BPF which
> > is needed for detecting different ABIs like 32-bit compat mode.
> >
> > No functional changes intended except for no more LOST events. :)
> >
> >   $ sudo ./perf trace -as --summary-mode=total --bpf-summary sleep 1
> >
> >    Summary of events:
> >
> >    total, 6194 events
> >
> >      syscall            calls  errors  total       min       avg       max       stddev
> >                                        (msec)    (msec)    (msec)    (msec)        (%)
> >      --------------- --------  ------ -------- --------- --------- ---------     ------
> >      epoll_wait           561      0  4530.843     0.000     8.076   520.941     18.75%
> >      futex                693     45  4317.231     0.000     6.230   500.077     21.98%
> >      poll                 300      0  1040.109     0.000     3.467   120.928     17.02%
> >      clock_nanosleep        1      0  1000.172  1000.172  1000.172  1000.172      0.00%
> >      ppoll                360      0   872.386     0.001     2.423   253.275     41.91%
> >      epoll_pwait           14      0   384.349     0.001    27.453   380.002     98.79%
> >      pselect6              14      0   108.130     7.198     7.724     8.206      0.85%
> >      nanosleep             39      0    43.378     0.069     1.112    10.084     44.23%
> >      ...
> >
> > Cc: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > v4)
> >  * fix segfault on -S  (Howard)
> >  * correct some comments  (Howard)
> 
> + if (!hashmap__find(hash, map_key->nr, &data)) {
> 
> I think you should mention the hashmap's map_key->nr update, as this
> change is actually important for the feature.
> 
> >
> > v3)
> >  * support -S/--with-summary option too  (Howard)
> >  * make it work only with -a/--all-cpus  (Howard)
> >  * fix stddev calculation  (Howard)
> >  * add some comments about syscall_data  (Howard)
> >
> > v2)
> >  * Rebased on top of Ian's e_machine changes
> >  * add --bpf-summary option
> >  * support per-thread summary
> >  * add stddev calculation  (Howard)
> >
> >  tools/perf/Documentation/perf-trace.txt       |   6 +
> >  tools/perf/Makefile.perf                      |   2 +-
> >  tools/perf/builtin-trace.c                    |  54 ++-
> >  tools/perf/util/Build                         |   1 +
> >  tools/perf/util/bpf-trace-summary.c           | 347 ++++++++++++++++++
> >  .../perf/util/bpf_skel/syscall_summary.bpf.c  | 118 ++++++
> >  tools/perf/util/bpf_skel/syscall_summary.h    |  25 ++
> >  tools/perf/util/trace.h                       |  37 ++
> >  8 files changed, 577 insertions(+), 13 deletions(-)
> >  create mode 100644 tools/perf/util/bpf-trace-summary.c
> >  create mode 100644 tools/perf/util/bpf_skel/syscall_summary.bpf.c
> >  create mode 100644 tools/perf/util/bpf_skel/syscall_summary.h
> >  create mode 100644 tools/perf/util/trace.h
> >
> > diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
> > index 887dc37773d0f4d6..a8a0d8c33438fef7 100644
> > --- a/tools/perf/Documentation/perf-trace.txt
> > +++ b/tools/perf/Documentation/perf-trace.txt
> > @@ -251,6 +251,12 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
> >         pretty-printing serves as a fallback to hand-crafted pretty printers, as the latter can
> >         better pretty-print integer flags and struct pointers.
> >
> > +--bpf-summary::
> > +       Collect system call statistics in BPF.  This is only for live mode and
> > +       works well with -s/--summary option where no argument information is
> > +       required.

root@number:~#> 
> It works with -S as well, doesn't it?

Yes, I tested it:

root@number:~# perf trace -aS --summary-mode=total --bpf-summary sleep 0.000000001
     0.011 ( 0.008 ms): :146484/146484 execve(filename: "/home/acme/libexec/perf-core/sleep", argv: 0x7ffcdf2108f0, envp: 0x37fabf70) = -1 ENOENT (No such file or directory)
     0.021 ( 0.002 ms): :146484/146484 execve(filename: "/root/.local/bin/sleep", argv: 0x7ffcdf2108f0, envp: 0x37fabf70) = -1 ENOENT (No such file or directory)
     0.024 ( 0.002 ms): :146484/146484 execve(filename: "/root/bin/sleep", argv: 0x7ffcdf2108f0, envp: 0x37fabf70) = -1 ENOENT (No such file or directory)
     0.026 ( 0.002 ms): :146484/146484 execve(filename: "/usr/local/sbin/sleep", argv: 0x7ffcdf2108f0, envp: 0x37fabf70) = -1 ENOENT (No such file or directory)
     0.029 ( 0.001 ms): :146484/146484 execve(filename: "/usr/local/bin/sleep", argv: 0x7ffcdf2108f0, envp: 0x37fabf70) = -1 ENOENT (No such file or directory)
         ? (         ): sudo/115804  ... [continued]: ppoll())                                            = 1
     0.032 (         ): :146484/146484 execve(filename: "/usr/sbin/sleep", argv: 0x7ffcdf2108f0, envp: 0x37fabf70) ...
     0.146 ( 0.002 ms): sudo/115804 rt_sigaction(sig: TTIN, act: (struct sigaction){.sa_handler = (__sighandler_t)0x557bdbdec4c0,.sa_flags = (long unsigned int)67108864,.sa_restorer = (__sigrestore_t)0x7f50c6627bf0,}, oact: 0x7ffff79f7d80, sigsetsize: 8) = 0
     0.150 ( 0.003 ms): sudo/115804 read(fd: 9</dev/ptmx>, buf: 0x557be6008260, count: 65536)             = 297
     0.155 ( 0.001 ms): sudo/115804 rt_sigaction(sig: TTIN, act: (struct sigaction){.sa_handler = (__sighandler_t)0x1,.sa_flags = (long unsigned int)335544320,.sa_restorer = (__sigrestore_t)0x7f50c6627bf0,}, sigsetsize: 8) = 0
     0.158 ( 0.001 ms): sudo/115804 rt_sigprocmask(nset: 0x557bdbe1a6a0, oset: 0x7ffff79f7d70, sigsetsize: 8) = 0
     0.162 ( 0.001 ms): sudo/115804 rt_sigprocmask(how: SETMASK, nset: 0x7ffff79f7d70, sigsetsize: 8)     = 0
     0.165 ( 0.002 ms): sudo/115804 ppoll(ufds: 0x557be5f955b0, nfds: 5, sigsetsize: 8)                   = 2
     0.169 ( 0.001 ms): sudo/115804 rt_sigaction(sig: TTIN, act: (struct sigaction){.sa_handler = (__sighandler_t)0x557bdbdec4c0,.sa_flags = (long unsigned int)67108864,.sa_restorer = (__sigrestore_t)0x7f50c6627bf0,}, oact: 0x7ffff79f7d80, sigsetsize: 8) = 0
     0.171 ( 0.002 ms): sudo/115804 read(fd: 9</dev/ptmx>, buf: 0x557be6008389, count: 65239)             = 502
     0.175 ( 0.001 ms): sudo/115804 rt_sigaction(sig: TTIN, act: (struct sigaction){.sa_handler = (__sighandler_t)0x1,.sa_flags = (long unsigned int)335544320,.sa_restorer = (__sigrestore_t)0x7f50c6627bf0,}, sigsetsize: 8) = 0
     0.177 ( 0.001 ms): sudo/115804 rt_sigprocmask(nset: 0x557bdbe1a6a0, oset: 0x7ffff79f7d70, sigsetsize: 8) = 0
     0.179 ( 0.001 ms): sudo/115804 rt_sigprocmask(how: SETMASK, nset: 0x7ffff79f7d70, sigsetsize: 8)     = 0
     0.181 ( 0.001 ms): sudo/115804 rt_sigaction(sig: TTOU, act: (struct sigaction){.sa_handler = (__sighandler_t)0x557bdbdec4d0,.sa_flags = (long unsigned int)67108864,.sa_restorer = (__sigrestore_t)0x7f50c6627bf0,}, oact: 0x7ffff79f7d80, sigsetsize: 8) = 0
     0.183 ( 0.004 ms): sudo/115804 write(fd: 8</dev/tty>, buf:          ? (         ): :146484/, count: 799) = 799
     0.189 ( 0.001 ms): sudo/115804 rt_sigaction(sig: TTOU, act: (struct sigaction){.sa_handler = (__sighandler_t)0x1,.sa_flags = (long unsigned int)335544320,.sa_restorer = (__sigrestore_t)0x7f50c6627bf0,}, sigsetsize: 8) = 0
     0.193 ( 0.002 ms): sudo/115804 ppoll(ufds: 0x557be5f955b0, nfds: 4, sigsetsize: 8)                   = 1
     0.196 ( 0.001 ms): sudo/115804 rt_sigaction(sig: TTIN, act: (struct sigaction){.sa_handler = (__sighandler_t)0x557bdbdec4c0,.sa_flags = (long unsigned int)67108864,.sa_restorer = (__sigrestore_t)0x7f50c6627bf0,}, oact: 0x7ffff79f7d80, sigsetsize: 8) = 0
     0.199 ( 0.002 ms): sudo/115804 read(fd: 9</dev/ptmx>, buf: 0x557be6008260, count: 65536)             = 379
     0.201 ( 0.001 ms): sudo/115804 rt_sigaction(sig: TTIN, act: (struct sigaction){.sa_handler = (__sighandler_t)0x1,.sa_flags = (long unsigned int)335544320,.sa_restorer = (__sigrestore_t)0x7f50c6627bf0,}, sigsetsize: 8) = 0
     0.203 ( 0.001 ms): sudo/115804 rt_sigprocmask(nset: 0x557bdbe1a6a0, oset: 0x7ffff79f7d70, sigsetsize: 8) = 0
     0.205 ( 0.001 ms): sudo/115804 rt_sigprocmask(how: SETMASK, nset: 0x7ffff79f7d70, sigsetsize: 8)     = 0
     0.206 ( 0.002 ms): sudo/115804 ppoll(ufds: 0x557be5f955b0, nfds: 5, sigsetsize: 8)                   = 1
     0.209 ( 0.001 ms): sudo/115804 rt_sigaction(sig: TTOU, act: (struct sigaction){.sa_handler = (__sighandler_t)0x557bdbdec4d0,.sa_flags = (long unsigned int)67108864,.sa_restorer = (__sigrestore_t)0x7f50c6627bf0,}, oact: 0x7ffff79f7d80, sigsetsize: 8) = 0
     0.211 ( 0.002 ms): sudo/115804 write(fd: 8</dev/tty>, buf: ): :146484/146484 execve(filenam, count: 379) = 379
     0.213 ( 0.001 ms): sudo/115804 rt_sigaction(sig: TTOU, act: (struct sigaction){.sa_handler = (__sighandler_t)0x1,.sa_flags = (long unsigned int)335544320,.sa_restorer = (__sigrestore_t)0x7f50c6627bf0,}, sigsetsize: 8) = 0
         ? (         ): ptyxis/3622  ... [continued]: ppoll())                                            = 1
     0.215 (         ): sudo/115804 ppoll(ufds: 0x557be5f955b0, nfds: 4, sigsetsize: 8)                ...
     0.196 ( 0.002 ms): ptyxis/3622 write(fd: 4<anon_inode:[eventfd]>, buf: \1\0\0\0\0\0\0\0, count: 8)   = 8
     0.206 ( 0.003 ms): ptyxis/3622 read(fd: 41</dev/ptmx>, buf: 0x5586a84ee428, count: 8136)             = 800
     0.209 ( 0.001 ms): ptyxis/3622 read(fd: 41</dev/ptmx>, buf: 0x5586a84ee747, count: 7337)             = -1 EAGAIN (Resource temporarily unavailable)
     0.221 ( 0.001 ms): ptyxis/3622 write(fd: 4<anon_inode:[eventfd]>, buf: \1\0\0\0\0\0\0\0, count: 8)   = 8
     0.224 ( 0.002 ms): ptyxis/3622 ppoll(ufds: 0x5586a7e8f120, nfds: 10, tsp: 0x7ffdd1fbb470, sigsetsize: 8) = 2
     0.227 ( 0.001 ms): ptyxis/3622 read(fd: 4<anon_inode:[eventfd]>, buf: 0x7ffdd1fbb3a0, count: 8)      = 8
     0.229 ( 0.001 ms): ptyxis/3622 write(fd: 4<anon_inode:[eventfd]>, buf: \1\0\0\0\0\0\0\0, count: 8)   = 8
     0.231 ( 0.001 ms): ptyxis/3622 read(fd: 41</dev/ptmx>, buf: 0x5586a84ee747, count: 7337)             = 380
     0.233 ( 0.001 ms): ptyxis/3622 read(fd: 41</dev/ptmx>, buf: 0x5586a84ee8c2, count: 6958)             = -1 EAGAIN (Resource temporarily unavailable)
     0.234 ( 0.001 ms): ptyxis/3622 write(fd: 4<anon_inode:[eventfd]>, buf: \1\0\0\0\0\0\0\0, count: 8)   = 8
     0.236 ( 0.001 ms): ptyxis/3622 ppoll(ufds: 0x5586a7e8f120, nfds: 10, tsp: 0x7ffdd1fbb470, sigsetsize: 8) = 1
     0.238 ( 0.001 ms): ptyxis/3622 read(fd: 4<anon_inode:[eventfd]>, buf: 0x7ffdd1fbb3a0, count: 8)      = 8
         ? (         ): mdns_service/5565  ... [continued]: recvfrom())                                         = -1 EAGAIN (Resource temporarily unavailable)
     0.241 (         ): ptyxis/3622 ppoll(ufds: 0x5586a7e8f120, nfds: 10, tsp: 0x7ffdd1fbb470, sigsetsize: 8) ...
     0.032 ( 0.627 ms): sleep/146484  ... [continued]: execve())                                           = 0
     1.059 (         ): mdns_service/5565 recvfrom(fd: 292<socket:[81029]>, ubuf: 0x7f6cfdc454c0, size: 9000, addr: 0x7f6cfdc47b00, addr_len: 0x7f6cfdc47a00) ...
     0.676 ( 0.001 ms): sleep/146484 brk()                                                                 = 0x56443e2d4000
     0.689 ( 0.002 ms): sleep/146484 mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS)           = 0x7fe66d41d000
     0.693 ( 0.002 ms): sleep/146484 access(filename: "/etc/ld.so.preload", mode: R)                       = -1 ENOENT (No such file or directory)
     0.698 ( 0.002 ms): sleep/146484 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) = 3
     0.701 ( 0.001 ms): sleep/146484 fstat(fd: 3, statbuf: 0x7ffefb498350)                                 = 0
     0.704 ( 0.003 ms): sleep/146484 mmap(len: 76091, prot: READ, flags: PRIVATE, fd: 3)                   = 0x7fe66d40a000
     0.708 ( 0.001 ms): sleep/146484 close(fd: 3)                                                          = 0
     0.712 ( 0.002 ms): sleep/146484 openat(dfd: CWD, filename: "/lib64/libc.so.6", flags: RDONLY|CLOEXEC) = 3
     0.715 ( 0.001 ms): sleep/146484 read(fd: 3, buf: 0x7ffefb4984b8, count: 832)                          = 832
     0.717 ( 0.001 ms): sleep/146484 pread64(fd: 3, buf: 0x7ffefb4980a0, count: 784, pos: 64)              = 784
     0.719 ( 0.001 ms): sleep/146484 fstat(fd: 3, statbuf: 0x7ffefb498340)                                 = 0
     0.722 ( 0.001 ms): sleep/146484 pread64(fd: 3, buf: 0x7ffefb497f80, count: 784, pos: 64)              = 784
     0.723 ( 0.003 ms): sleep/146484 mmap(len: 2038872, prot: READ|EXEC, flags: PRIVATE|DENYWRITE, fd: 3)  = 0x7fe66d218000
     0.727 ( 0.004 ms): sleep/146484 mmap(addr: 0x7fe66d387000, len: 479232, prot: READ, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x16f000) = 0x7fe66d387000
     0.733 ( 0.003 ms): sleep/146484 mmap(addr: 0x7fe66d3fc000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x1e3000) = 0x7fe66d3fc000
     0.737 ( 0.002 ms): sleep/146484 mmap(addr: 0x7fe66d402000, len: 31832, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS) = 0x7fe66d402000
     0.743 ( 0.001 ms): sleep/146484 close(fd: 3)                                                          = 0
     0.748 ( 0.002 ms): sleep/146484 mmap(len: 12288, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS)          = 0x7fe66d215000
     0.753 ( 0.001 ms): sleep/146484 arch_prctl(option: SET_FS, arg2: 0x7fe66d215740)                      = 0
     0.754 ( 0.001 ms): sleep/146484 set_tid_address(tidptr: 0x7fe66d215a10)                               = 146484 (sleep)
     0.757 ( 0.001 ms): sleep/146484 set_robust_list(head: (struct robust_list_head){.list = (struct robust_list){.next = (struct robust_list *)0x7fe66d215a20,},.futex_offset = (long int)-32,}, len: 24) = 0
     0.759 ( 0.001 ms): sleep/146484 rseq(rseq: (struct rseq){.cpu_id = (__u32)4294967295,}, rseq_len: 32, sig: 1392848979) = 0
     0.780 ( 0.003 ms): sleep/146484 mprotect(start: 0x7fe66d3fc000, len: 16384, prot: READ)               = 0
     0.788 ( 0.002 ms): sleep/146484 mprotect(start: 0x564438854000, len: 4096, prot: READ)                = 0
     0.792 ( 0.002 ms): sleep/146484 mprotect(start: 0x7fe66d459000, len: 8192, prot: READ)                = 0
     0.798 ( 0.001 ms): sleep/146484 prlimit64(resource: STACK, old_rlim: 0x7ffefb498e90)                  = 0
     0.807 ( 0.003 ms): sleep/146484 munmap(addr: 0x7fe66d40a000, len: 76091)                              = 0
     0.817 ( 0.001 ms): sleep/146484 getrandom(ubuf: 0x7fe66d407218, len: 8, flags: NONBLOCK)              = 8
     0.819 ( 0.001 ms): sleep/146484 brk()                                                                 = 0x56443e2d4000
     0.821 ( 0.003 ms): sleep/146484 brk(brk: 0x56443e2f5000)                                              = 0x56443e2f5000
     0.827 ( 0.032 ms): sleep/146484 openat(dfd: CWD, filename: "", flags: RDONLY|CLOEXEC)                 = 3
     0.860 ( 0.001 ms): sleep/146484 fstat(fd: 3, statbuf: 0x7fe66d401800)                                 = 0
     0.862 ( 0.002 ms): sleep/146484 mmap(len: 233242544, prot: READ, flags: PRIVATE, fd: 3)               = 0x7fe65f200000
     0.867 ( 0.001 ms): sleep/146484 close(fd: 3)                                                          = 0
     0.888 ( 0.003 ms): sleep/146484 openat(dfd: CWD, filename: "/usr/share/locale/locale.alias", flags: RDONLY|CLOEXEC) = 3
     0.892 ( 0.001 ms): sleep/146484 fstat(fd: 3, statbuf: 0x7ffefb498a70)                                 = 0
     0.895 ( 0.002 ms): sleep/146484 read(fd: 3, buf: 0x56443e2d5680, count: 4096)                         = 2998
     0.901 ( 0.001 ms): sleep/146484 read(fd: 3, buf: 0x56443e2d5680, count: 4096)                         = 0
     0.903 ( 0.001 ms): sleep/146484 close(fd: 3)                                                          = 0
     0.909 ( 0.002 ms): sleep/146484 openat(dfd: CWD, filename: "/usr/share/locale/en_US.UTF-8/LC_MESSAGES/coreutils.mo") = -1 ENOENT (No such file or directory)
     0.912 ( 0.001 ms): sleep/146484 openat(dfd: CWD, filename: "/usr/share/locale/en_US.utf8/LC_MESSAGES/coreutils.mo") = -1 ENOENT (No such file or directory)
     0.914 ( 0.002 ms): sleep/146484 openat(dfd: CWD, filename: "/usr/share/locale/en_US/LC_MESSAGES/coreutils.mo") = -1 ENOENT (No such file or directory)
     0.916 ( 0.001 ms): sleep/146484 openat(dfd: CWD, filename: "/usr/share/locale/en.UTF-8/LC_MESSAGES/coreutils.mo") = -1 ENOENT (No such file or directory)
     0.918 ( 0.001 ms): sleep/146484 openat(dfd: CWD, filename: "/usr/share/locale/en.utf8/LC_MESSAGES/coreutils.mo") = -1 ENOENT (No such file or directory)
     0.920 ( 0.002 ms): sleep/146484 openat(dfd: CWD, filename: "/usr/share/locale/en/LC_MESSAGES/coreutils.mo") = -1 ENOENT (No such file or directory)
     0.930 ( 0.055 ms): sleep/146484 clock_nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 1 }, rmtp: 0x7ffefb4990f0) = 0
     0.987 ( 0.001 ms): sleep/146484 close(fd: 1)                                                          = 0
     0.989 ( 0.001 ms): sleep/146484 close(fd: 2)                                                          = 0
     0.992 (         ): sleep/146484 exit_group()                                                          = ?

 Summary of events:

 total, 3096 events

   syscall            calls  errors  total       min       avg       max       stddev
                                     (msec)    (msec)    (msec)    (msec)        (%)
   --------------- --------  ------ -------- --------- --------- ---------     ------
   ppoll                317      0    47.372     0.000     0.149     3.804     17.80%
   recvfrom               8      8    18.000     1.986     2.250     2.996      7.19%
   sched_setaffinity       66      0     0.743     0.001     0.011     0.021      6.16%
   execve                 6      5     0.644     0.001     0.107     0.630     97.28%
   write               1268      0     0.548     0.000     0.000     0.005      2.30%
   read                 390     75     0.158     0.000     0.000     0.012      9.19%
   ioctl                138      1     0.119     0.000     0.001     0.011     14.79%
   newfstatat            28     17     0.079     0.001     0.003     0.025     33.91%
   rt_sigaction         446      0     0.077     0.000     0.000     0.002      4.78%
   futex                 20      1     0.077     0.000     0.004     0.037     51.43%
   openat                13      6     0.057     0.001     0.004     0.032     51.97%
   clock_nanosleep        1      0     0.055     0.055     0.055     0.055      0.00%
   rt_sigprocmask       290      0     0.047     0.000     0.000     0.002      5.61%
   mmap                   8      0     0.021     0.002     0.003     0.004     12.60%
   poll                   4      0     0.015     0.000     0.004     0.014     92.77%
   readlink               5      0     0.014     0.001     0.003     0.005     28.80%
   close                 15      0     0.009     0.000     0.001     0.001     12.52%
   pread64               10      0     0.009     0.000     0.001     0.003     26.77%
   recvmsg               17     13     0.008     0.000     0.000     0.002     23.80%
   mprotect               3      0     0.006     0.002     0.002     0.003     15.31%
   sendmsg                5      0     0.006     0.001     0.001     0.002     21.98%
   fstat                  6      0     0.005     0.000     0.001     0.001     23.30%
   brk                    3      0     0.004     0.001     0.001     0.003     39.48%
   munmap                 1      0     0.003     0.003     0.003     0.003      0.00%
   access                 1      1     0.002     0.002     0.002     0.002      0.00%
   timerfd_settime        5      0     0.002     0.000     0.000     0.000     11.96%
   eventfd2               1      0     0.002     0.002     0.002     0.002      0.00%
   sched_getaffinity        2      0     0.001     0.001     0.001     0.001      0.96%
   getrandom              1      0     0.001     0.001     0.001     0.001      0.00%
   rt_sigreturn           1      0     0.001     0.001     0.001     0.001      0.00%
   prlimit64              1      0     0.001     0.001     0.001     0.001      0.00%
   set_tid_address        1      0     0.001     0.001     0.001     0.001      0.00%
   getpid                 6      0     0.001     0.000     0.000     0.000     14.19%
   arch_prctl             1      0     0.001     0.001     0.001     0.001      0.00%
   set_robust_list        1      0     0.001     0.001     0.001     0.001      0.00%
   rseq                   1      0     0.001     0.001     0.001     0.001      0.00%
   fcntl                  3      0     0.001     0.000     0.000     0.000     20.48%
   epoll_wait             2      0     0.001     0.000     0.000     0.000     38.12%
   uname                  1      0     0.000     0.000     0.000     0.000      0.00%
 
> Anyway, I don't mind adding these details later on, so
> 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks, applied to perf-tools-next,

- Arnaldo

