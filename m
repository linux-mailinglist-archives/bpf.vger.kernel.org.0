Return-Path: <bpf+bounces-7910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE1277E607
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 18:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E271C2111B
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 16:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576BA16424;
	Wed, 16 Aug 2023 16:08:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9672DDD0;
	Wed, 16 Aug 2023 16:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C076EC433C9;
	Wed, 16 Aug 2023 16:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692202098;
	bh=jrViBcOF+k6elFlQX62ESQoaEbSxiZkNTyIObFNP2QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TVFZMUtHsV2VIWG0rixURPjsGCWWHkv3h4qWbmQ/gsXrJXAoa+0NGs/UNZFdbbHOP
	 1WUYPSLX4B5dkW96aZgv2YTOJUmJvXYG5o2zObPaQwfdKJN7xKUf9WMYqVdMTn6f7r
	 hu/I/LtC2s/6t/POesRwsako4rUossFMexa3oA1FXZWkyckvd33PjDgS/t7ifUgBAm
	 XPJRiqFkQN4oTapRoHEgen5/hcm3W85eeUa5HUD9W7SP6K/g2LeUaSV23Acl416+oM
	 IpIJoLWvgGwvfvPgaLr1K0uJovIT8BJQOqDSRL/r157cL5pyDx5F/sEag9Ko9Is5Nv
	 tl69G0aRrEAug==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id C9B47404DF; Wed, 16 Aug 2023 13:08:14 -0300 (-03)
Date: Wed, 16 Aug 2023 13:08:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Fangrui Song <maskray@google.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Carsten Haitzler <carsten.haitzler@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	James Clark <james.clark@arm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
	Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, llvm@lists.linux.dev,
	Wang Nan <wangnan0@huawei.com>,
	Wang ShaoBo <bobo.shaobowang@huawei.com>,
	YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>,
	Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: [PATCH v1 2/4] perf trace: Migrate BPF augmentation to use a
 skeleton
Message-ID: <ZNz0bmclvZPg5Y/X@kernel.org>
References: <20230810184853.2860737-1-irogers@google.com>
 <20230810184853.2860737-3-irogers@google.com>
 <ZNuK1TFwdjyezV3I@kernel.org>
 <CAP-5=fURf+vv3TA4cRx1MiV3DDp=3wo0g5dBYH43DKtPhNZQsQ@mail.gmail.com>
 <ZNzK70eH3ISoL8r0@kernel.org>
 <ZNzNh9Myua1xjNuL@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNzNh9Myua1xjNuL@kernel.org>
X-Url: http://acmel.wordpress.com

Em Wed, Aug 16, 2023 at 10:22:15AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Aug 16, 2023 at 10:11:11AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Just taking notes about things to work on top of what is in
> > tmp.perf-tools-next, that will move to perf-tools-next soon:

> > We need to make these libbpf error messages appear only in verbose mode,
> > and probably have a hint about unprivileged BPF, a quick attempt failed
> > after several attempts at getting privileges :-\

> > Probably attaching to tracepoints is off limits to !root even with
> > /proc/sys/kernel/unprivileged_bpf_disabled set to zero.

> yep, the libbpf sys_bpf call to check if it could load a basic BPF
> bytecode (prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2) succeeds,
> but then, later we manage to create the maps, etc to then stumble on 
 
> bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=8272, max_entries=1, map_flags=0, inner_map_fd=0, map_name="augmented_args_", map_ifindex=0, btf_fd=0, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 7
> bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0000\0\0\0000\0\0\0\t\0\0\0\1\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=81, btf_log_size=0, btf_log_level=0}, 32) = -1 EPERM (Operation not permitted)
 
> and:
 
> bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACEPOINT, insn_cnt=2, insns=0x1758340, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(6, 4, 7), prog_flags=0, prog_name="syscall_unaugme", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0, fd_array=NULL}, 144) = -1 EPERM (Operation not permitted)
 
> So 'perf trace' should just not try to load the augmented_raw_syscalls
> BPF skel for !root.

Not really, I insisted and it is (was?) possible to make it work,
testing on some other machine and after having to change the permissions
recursively on tracefs (before a remount with mode=755 seemed to
work?).

I managed to make it work for !root, BPF collecting the pointer args for
openat, access (perf trace looks for syscall signatures and reuses BPF
progs for the ones matching one of the explicitely provided)
clock_namosleep, etc.

(re)Reading Documentation/admin-guide/perf-security.rst and getting it
into the hints system of 'perf trace' may make this process simpler and
safer, by using a group, etc. But it is possible, great!

I didn't even had to touch /proc/sys/kernel/unprivileged_bpf_disabled,
just the capabilities for the perf binary (which is a pretty big window,
but way smaller than touching /proc/sys/kernel/unprivileged_bpf_disabled).

So now we need to get BUILD_BPF_SKEL=1 to be the default but just emit a
warning when what is needed isn't available, just like with other
features, in that case 'perf trace' continues as today, no pointer arg
contents collection.

Unfortunately it is too late in the process for v6.6 even, so as soon as
perf-tools-next becomes perf-tools and we reopen it for v6.7 the first
patch should be this build BPF skels if what is needed is available.

I'll also check if we can enable BUILD_BPF_SKEL=1 in the distro packages
so that we collect some info from them about possible problems.

What I have is now in perf-tools-next, so should get into linux-next and
hopefully help in testing it, IIRC there are CIs that enable
BUILD_BPF_SKEL=1.

- Arnaldo

[acme@five ~]$ uname -a
Linux five 6.2.15-100.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Thu May 11 16:51:53 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
[acme@five ~]$ id
uid=1000(acme) gid=1000(acme) groups=1000(acme),10(wheel) context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
[acme@five ~]$ perf trace sleep 1
         ? (         ): sleep/980735  ... [continued]: execve())                                           = 0
     0.031 ( 0.002 ms): sleep/980735 brk()                                                                 = 0x55c621548000
     0.039 ( 0.001 ms): sleep/980735 arch_prctl(option: 0x3001, arg2: 0x7ffeb8a6a460)                      = -1 EINVAL (Invalid argument)
     0.058 ( 0.006 ms): sleep/980735 access(filename: "/etc/ld.so.preload", mode: R)                       = -1 ENOENT (No such file or directory)
     0.068 ( 0.005 ms): sleep/980735 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) = 3
     0.074 ( 0.002 ms): sleep/980735 newfstatat(dfd: 3, filename: "", statbuf: 0x7ffeb8a69680, flag: 4096) = 0
     0.077 ( 0.006 ms): sleep/980735 mmap(len: 54771, prot: READ, flags: PRIVATE, fd: 3)                   = 0x7f6b95ad9000
     0.084 ( 0.001 ms): sleep/980735 close(fd: 3)                                                          = 0
     0.094 ( 0.006 ms): sleep/980735 openat(dfd: CWD, filename: "/lib64/libc.so.6", flags: RDONLY|CLOEXEC) = 3
     0.101 ( 0.002 ms): sleep/980735 read(fd: 3, buf: 0x7ffeb8a697e8, count: 832)                          = 832
     0.105 ( 0.001 ms): sleep/980735 pread64(fd: 3, buf: 0x7ffeb8a693e0, count: 784, pos: 64)              = 784
     0.107 ( 0.001 ms): sleep/980735 pread64(fd: 3, buf: 0x7ffeb8a69380, count: 80, pos: 848)              = 80
     0.110 ( 0.001 ms): sleep/980735 pread64(fd: 3, buf: 0x7ffeb8a69330, count: 68, pos: 928)              = 68
     0.113 ( 0.002 ms): sleep/980735 newfstatat(dfd: 3, filename: "", statbuf: 0x7ffeb8a69680, flag: 4096) = 0
     0.115 ( 0.003 ms): sleep/980735 mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS)           = 0x7f6b95ad7000
     0.122 ( 0.001 ms): sleep/980735 pread64(fd: 3, buf: 0x7ffeb8a692d0, count: 784, pos: 64)              = 784
     0.126 ( 0.006 ms): sleep/980735 mmap(len: 2104720, prot: READ, flags: PRIVATE|DENYWRITE, fd: 3)       = 0x7f6b95800000
     0.133 ( 0.013 ms): sleep/980735 mmap(addr: 0x7f6b95828000, len: 1523712, prot: READ|EXEC, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x28000) = 0x7f6b95828000
     0.147 ( 0.008 ms): sleep/980735 mmap(addr: 0x7f6b9599c000, len: 360448, prot: READ, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x19c000) = 0x7f6b9599c000
     0.156 ( 0.010 ms): sleep/980735 mmap(addr: 0x7f6b959f4000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x1f3000) = 0x7f6b959f4000
     0.171 ( 0.005 ms): sleep/980735 mmap(addr: 0x7f6b959fa000, len: 32144, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS) = 0x7f6b959fa000
     0.182 ( 0.001 ms): sleep/980735 close(fd: 3)                                                          = 0
     0.193 ( 0.003 ms): sleep/980735 mmap(len: 12288, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS)          = 0x7f6b95ad4000
     0.199 ( 0.001 ms): sleep/980735 arch_prctl(option: SET_FS, arg2: 0x7f6b95ad4740)                      = 0
     0.202 ( 0.001 ms): sleep/980735 set_tid_address(tidptr: 0x7f6b95ad4a10)                               = 980735 (sleep)
     0.204 ( 0.001 ms): sleep/980735 set_robust_list(head: 0x7f6b95ad4a20, len: 24)                        = 0
     0.206 ( 0.001 ms): sleep/980735 rseq(rseq: 0x7f6b95ad50e0, rseq_len: 32, sig: 1392848979)             = 0
     0.277 ( 0.010 ms): sleep/980735 mprotect(start: 0x7f6b959f4000, len: 16384, prot: READ)               = 0
     0.306 ( 0.007 ms): sleep/980735 mprotect(start: 0x55c61fa4a000, len: 4096, prot: READ)                = 0
     0.320 ( 0.010 ms): sleep/980735 mprotect(start: 0x7f6b95b1c000, len: 8192, prot: READ)                = 0
     0.340 ( 0.002 ms): sleep/980735 prlimit64(resource: STACK, old_rlim: 0x7ffeb8a6a1c0)                  = 0
     0.349 ( 0.009 ms): sleep/980735 munmap(addr: 0x7f6b95ad9000, len: 54771)                              = 0
     0.381 ( 0.002 ms): sleep/980735 getrandom(ubuf: 0x7f6b959ff4d8, len: 8, flags: NONBLOCK)              = 8
     0.386 ( 0.001 ms): sleep/980735 brk()                                                                 = 0x55c621548000
     0.388 ( 0.006 ms): sleep/980735 brk(brk: 0x55c621569000)                                              = 0x55c621569000
     0.403 ( 0.012 ms): sleep/980735 openat(dfd: CWD, filename: "", flags: RDONLY|CLOEXEC)                 = 3
     0.417 ( 0.003 ms): sleep/980735 newfstatat(dfd: 3, filename: "", statbuf: 0x7f6b959f9b80, flag: 4096) = 0
     0.422 ( 0.008 ms): sleep/980735 mmap(len: 224096080, prot: READ, flags: PRIVATE, fd: 3)               = 0x7f6b88200000
     0.436 ( 0.002 ms): sleep/980735 close(fd: 3)                                                          = 0
     0.480 (1000.041 ms): sleep/980735 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7ffeb8a6a450) = 0
  1000.552 ( 0.003 ms): sleep/980735 close(fd: 1)                                                          = 0
  1000.558 ( 0.002 ms): sleep/980735 close(fd: 2)                                                          = 0
  1000.565 (         ): sleep/980735 exit_group()                                                          = ?
[acme@five ~]$ getcap ~/bin/perf
/var/home/acme/bin/perf cap_perfmon,cap_bpf=ep
[acme@five ~]$ cat /proc/sys/kernel/unprivileged_bpf_disabled
2
[acme@five ~]$ cat /proc/sys/kernel/perf_event_paranoid
-1
[acme@five ~]$

