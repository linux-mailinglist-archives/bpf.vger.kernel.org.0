Return-Path: <bpf+bounces-7994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9718A77FAF2
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 17:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4112D282090
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328E815AC4;
	Thu, 17 Aug 2023 15:37:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE11549E;
	Thu, 17 Aug 2023 15:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8759AC433C9;
	Thu, 17 Aug 2023 15:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692286646;
	bh=FsTOQy1J00h09RqORDICXkOwRWchRTxx4z6I0fSFUFo=;
	h=Date:From:To:Cc:Subject:From;
	b=uE51BkgLq5R2nrgeqCvtJgTcvmmzvUBASge7HSt89nmd8mvPSRvSNydYnNd0wU6N8
	 j0eJZWNEuNC3BkoAxS0Ev0GulJxwdnD0xdzh4vhnFdLo/W1r6cCM9v16BuBPJlNqF9
	 LShOhR9Fxrec+DNc+0vJvpC58c4JTFXZAtbORgnO1EZepqyufpdZPlRsq1maBGZgtn
	 VeIuI6q8wxWHW0D0kDqcLBdcPlUwiaCYgGyQtzLwHUV0blwsZdT1Lc1WFc1VW/iU0z
	 B+eQOjQBleKRevzOWOmTfvscWIskHar38lVn0vBHH7n/1srto/MImsyR1KdjmKYnyD
	 f7UmniOxDsKig==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 986DD404DF; Thu, 17 Aug 2023 12:37:23 -0300 (-03)
Date: Thu, 17 Aug 2023 12:37:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, bpf@vger.kernel.org,
	Brendan Gregg <brendan.d.gregg@gmail.com>,
	Carsten Haitzler <carsten.haitzler@arm.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Fangrui Song <maskray@google.com>, He Kuang <hekuang@huawei.com>,
	Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@arm.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@linaro.org>, llvm@lists.linux.dev,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Rob Herring <robh@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>,
	Tom Rix <trix@redhat.com>, Wang Nan <wangnan0@huawei.com>,
	Wang ShaoBo <bobo.shaobowang@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>, Yonghong Song <yhs@fb.com>,
	YueHaibing <yuehaibing@huawei.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf trace: Use the augmented_raw_syscall BPF skel only
 for tracing syscalls
Message-ID: <ZN4+s2Wl+zYmXTDj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It is possible to use 'perf trace' with tracepoints and in that case we
can't initialize/use the augmented_raw_syscalls BPF skel.

For instance, this usecase:

  # perf trace -e sched:*exec --max-events=5
         ? (         ): NetworkManager/1183  ... [continued]: poll())                                             = 1
     0.043 ( 0.007 ms): NetworkManager/1183 epoll_wait(epfd: 17<anon_inode:[eventpoll]>, events: 0x55555f90e920, maxevents: 6) = 0
     0.060 ( 0.007 ms): NetworkManager/1183 write(fd: 3<anon_inode:[eventfd]>, buf: 0x7ffc5a27cd30, count: 8)     = 8
     0.073 ( 0.005 ms): NetworkManager/1183 epoll_wait(epfd: 24<anon_inode:[eventpoll]>, events: 0x7ffc5a27cd20, maxevents: 2) = 1
     0.082 ( 0.010 ms): NetworkManager/1183 recvmmsg(fd: 26<socket:[30298]>, mmsg: 0x7ffc5a27caa0, vlen: 8)       = 1
  #

Where we want to trace just some sched tracepoints ending in 'exec' ends
up tracing all syscalls.

Fix it by checking existing trace->trace_syscalls boolean to see if we
need the augmenter.

A followup patch will move those sections of code used only with the
augmenter to separate functions, to get it cleaner and remove the goto,
done just for reviewing purposes.

With this patch in place the previous behaviour is restored: no syscalls
when we have other events and no syscall names:

  [root@quaco ~]# perf probe do_filp_open "filename=pathname->name:string"
  Added new event:
    probe:do_filp_open   (on do_filp_open with filename=pathname->name:string)

  You can now use it in all perf tools, such as:

	  perf record -e probe:do_filp_open -aR sleep 1

  [root@quaco ~]# perf trace --max-events=10 -e probe:do_filp_open sleep 1
     0.000 sleep/455122 probe:do_filp_open(__probe_ip: -1186560412, filename: "/etc/ld.so.cache")
     0.056 sleep/455122 probe:do_filp_open(__probe_ip: -1186560412, filename: "/lib64/libc.so.6")
     0.481 sleep/455122 probe:do_filp_open(__probe_ip: -1186560412, filename: "/usr/lib/locale/locale-archive")
     0.501 sleep/455122 probe:do_filp_open(__probe_ip: -1186560412, filename: "/usr/share/locale/locale.alias")
     0.572 sleep/455122 probe:do_filp_open(__probe_ip: -1186560412, filename: "/usr/lib/locale/en_US.UTF-8/LC_IDENTIFICATION")
     0.581 sleep/455122 probe:do_filp_open(__probe_ip: -1186560412, filename: "/usr/lib/locale/en_US.utf8/LC_IDENTIFICATION")
     0.616 sleep/455122 probe:do_filp_open(__probe_ip: -1186560412, filename: "/usr/lib64/gconv/gconv-modules.cache")
     0.656 sleep/455122 probe:do_filp_open(__probe_ip: -1186560412, filename: "/usr/lib/locale/en_US.UTF-8/LC_MEASUREMENT")
     0.664 sleep/455122 probe:do_filp_open(__probe_ip: -1186560412, filename: "/usr/lib/locale/en_US.utf8/LC_MEASUREMENT")
     0.696 sleep/455122 probe:do_filp_open(__probe_ip: -1186560412, filename: "/usr/lib/locale/en_US.UTF-8/LC_TELEPHONE")
  [root@quaco ~]#

As well as mixing syscalls with tracepoints, getting the syscall
tracepoints used augmented using the BPF skel:

  [root@quaco ~]# perf trace --max-events=10 -e open*,probe:do_filp_open sleep 1
     0.000 (         ): sleep/455124 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) ...
     0.005 (         ): sleep/455124 probe:do_filp_open(__probe_ip: -1186560412, filename: "/etc/ld.so.cache")
     0.000 ( 0.011 ms): sleep/455124  ... [continued]: openat())                                           = 3
     0.031 (         ): sleep/455124 openat(dfd: CWD, filename: "/lib64/libc.so.6", flags: RDONLY|CLOEXEC) ...
     0.033 (         ): sleep/455124 probe:do_filp_open(__probe_ip: -1186560412, filename: "/lib64/libc.so.6")
     0.031 ( 0.006 ms): sleep/455124  ... [continued]: openat())                                           = 3
     0.258 (         ): sleep/455124 openat(dfd: CWD, filename: "/usr/lib/locale/locale-archive", flags: RDONLY|CLOEXEC) ...
     0.261 (         ): sleep/455124 probe:do_filp_open(__probe_ip: -1186560412, filename: "/usr/lib/locale/locale-archive")
     0.258 ( 0.006 ms): sleep/455124  ... [continued]: openat())                                           = -1 ENOENT (No such file or directory)
     0.272 (         ): sleep/455124 openat(dfd: CWD, filename: "/usr/share/locale/locale.alias", flags: RDONLY|CLOEXEC) ...
     0.273  (        ): sleep/455124 probe:do_filp_open(__probe_ip: -1186560412, filename: "/usr/share/locale/locale.alias")

A final note: the probe:do_filp_open uses a kprobe (probably optimized
as its in the start of a function) that uses the kprobe_tracer mechanism
in the kernel to collect the pathname->name string and stash it into the
tracepoint created by 'perf probe' for that:

  [root@quaco ~]# cat /sys/kernel/debug/tracing/kprobe_events
  p:probe/do_filp_open _text+4621920 filename=+0(+0(%si)):string
  [root@quaco ~]#

While the syscalls:sys_enter_openat tracepoint gets its string from a
BPF program attached to raw_syscalls:sys_enter that tail calls into
another BPF program that knows the types for the openat syscall args and
thus can bpf_probe_read it right after the normal
sys_enter/sys_enter_openat tracepoint payload that comes prefixed with
whatever perf_event_open asked for (CPU, timestamp, etc):

  [root@quaco ~]# bpftool prog | grep -E "sys_enter |sys_enter_opena" -A3
  3176: tracepoint  name sys_enter  tag 0bc3fc9d11754ba1  gpl
	loaded_at 2023-08-17T12:32:20-0300  uid 0
	xlated 272B  jited 257B  memlock 4096B  map_ids 2462,2466,2463
	btf_id 2976
  --
  3180: tracepoint  name sys_enter_opena  tag 19dd077f00ec2f58  gpl
	  loaded_at 2023-08-17T12:32:20-0300  uid 0
	  xlated 328B  jited 206B  memlock 4096B  map_ids 2466,2465
	  btf_id 2976
  [root@quaco ~]#

Fixes: 42963c8bedeb864b ("perf trace: Migrate BPF augmentation to use a skeleton")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Cc: bpf@vger.kernel.org
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Carsten Haitzler <carsten.haitzler@arm.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Fangrui Song <maskray@google.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: llvm@lists.linux.dev
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Tom Rix <trix@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc: Yang Jihong <yangjihong1@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0ebfa95895e0bf4d..3964cf44cdbcb3e8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3895,7 +3895,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (err < 0)
 		goto out_error_open;
 #ifdef HAVE_BPF_SKEL
-	{
+	if (trace->syscalls.events.bpf_output) {
 		struct perf_cpu cpu;
 
 		/*
@@ -3916,7 +3916,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		goto out_error_mem;
 
 #ifdef HAVE_BPF_SKEL
-	if (trace->skel->progs.sys_enter)
+	if (trace->skel && trace->skel->progs.sys_enter)
 		trace__init_syscalls_bpf_prog_array_maps(trace);
 #endif
 
@@ -4850,6 +4850,9 @@ int cmd_trace(int argc, const char **argv)
 	}
 
 #ifdef HAVE_BPF_SKEL
+	if (!trace.trace_syscalls)
+		goto skip_augmentation;
+
 	trace.skel = augmented_raw_syscalls_bpf__open();
 	if (!trace.skel) {
 		pr_debug("Failed to open augmented syscalls BPF skeleton");
@@ -4884,6 +4887,7 @@ int cmd_trace(int argc, const char **argv)
 	}
 	trace.syscalls.events.bpf_output = evlist__last(trace.evlist);
 	assert(!strcmp(evsel__name(trace.syscalls.events.bpf_output), "__augmented_syscalls__"));
+skip_augmentation:
 #endif
 	err = -1;
 
-- 
2.41.0


