Return-Path: <bpf+bounces-35564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EDB93B894
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 23:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2A2CB2462B
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 21:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A9B13A877;
	Wed, 24 Jul 2024 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxcGwS8e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8024D134DE;
	Wed, 24 Jul 2024 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721856985; cv=none; b=Z02mXQsOZyggn3Klugjp4EgRzD8E+geUlEP3dzGJS/4wSm2DzrqKTwWQ124omP8tWBehOJmoF6P2pk+aiePhEsmpzoYScu4d+XydSQg1sZpbOVk8w+KJayHaRZaZ9EiY2hLDuSLPs7n9r5UD4hDuZY+xyVCd8tJq0F7iJQ3dVpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721856985; c=relaxed/simple;
	bh=6t/E9h3MDJhAhp51br8ddE+yreH52rCuq+TC2hJxXuU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gX6yqs4Y6QuY2XK1mB09+gYKUSbHiFvthuvgSgxrWCGGGnnmKRGYAZKXMThYucrqD4be/SURG++RMnfUvz9ukpnymee+L+UahROIGTsrFsFGlIFAbOEd31DJXnp9KvBdh3IJQkjje8Vjcz4zHSuV/MpdkApIcyNj7s2DVt5g7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxcGwS8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F595C32781;
	Wed, 24 Jul 2024 21:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721856985;
	bh=6t/E9h3MDJhAhp51br8ddE+yreH52rCuq+TC2hJxXuU=;
	h=Date:From:To:Cc:Subject:From;
	b=YxcGwS8eR+oSfEXqzll1gRAUs1+gMlgr5tlz+/4M9LtVbvJC16ldPVmQZvLa1Vqdt
	 TekjZqUwu9i3AiQMxQyO1yzxK4Ltjy7BNnG5bLlSpGHhwW77ve33jDMcMJVnNxmekp
	 5EIpTW07o1C4z+f8kvuPwkyhX4Tt1LA895mHdOfWgD++xgbnQw5KAjOhu9WXrAPVif
	 IlVcwCgqxjUAKYQnlxfjfK5rvrufNZrPK4ZK9UqceOySjKms2E7fs0aUfcI+jSCsfu
	 odG+JFKgp0ZDorDoiO4OQQqPATT8hbc43KfVuHYAXWC6UQkUqsMb/4BpnS3vW4q/f8
	 O44ofyanP9uxw==
Date: Wed, 24 Jul 2024 18:36:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org
Cc: Guilherme Amadio <amadio@gentoo.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: perf tools build clash with capstone
Message-ID: <ZqFz1eKplFvhOx16@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Still investigating, but seems just a namespace clash, haven't yet
pinpointed the cset where this problem was introduced.

Probably alpine:3.19/archlinux:base are the first where capstone devel
files are available.

perfbuilder@number:~$ export BUILD_TARBALL=http://192.168.86.42/perf/perf-6.10.0.tar.xz
perfbuilder@number:~$ time dm
   1   101.28 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-22) , clang version 17.0.6 (Red Hat 17.0.6-1.module_el8.10.0+3757+fc27b834) flex 2.6.1
   2   100.50 almalinux:9                   : Ok   gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3) , clang version 17.0.6 (AlmaLinux OS Foundation 17.0.6-5.el9) flex 2.6.4
   3   119.65 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1 flex 2.6.4
   4   117.18 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
   5    99.97 alpine:3.17                   : Ok   gcc (Alpine 12.2.1_git20220924-r4) 12.2.1 20220924 , Alpine clang version 15.0.7 flex 2.6.4
   6    92.95 alpine:3.18                   : Ok   gcc (Alpine 12.2.1_git20220924-r10) 12.2.1 20220924 , Alpine clang version 16.0.6 flex 2.6.4
   7    13.59 alpine:3.19                   : FAIL gcc version 13.2.1 20231014 (Alpine 13.2.1_git20231014) 
                     from util/disasm.c:29:
    /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
       94 | typedef enum bpf_insn {
          |              ^~~~~~~~
    In file included from /usr/include/capstone/capstone.h:325,
                     from /git/perf-6.10.0/tools/perf/util/print_insn.h:23,
                     from builtin-script.c:38:
    /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
       94 | typedef enum bpf_insn {
          |              ^~~~~~~~
    make[3]: *** [/git/perf-6.10.0/tools/build/Makefile.build:158: util] Error 2
      CC      /tmp/build/perf/util/event.o
      CC      /tmp/build/perf/builtin-script.o
      CC      /tmp/build/perf/util/evlist.o
      CC      /tmp/build/perf/arch/x86/util/env.o
    In file included from /usr/include/capstone/capstone.h:325,
                     from util/print_insn.h:23,
                     from util/disasm.c:29:
    /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
       94 | typedef enum bpf_insn {
          |              ^~~~~~~~
      CC      /tmp/build/perf/arch/x86/util/dwarf-regs.o
      CC      /tmp/build/perf/util/sideband_evlist.o
      CC      /tmp/build/perf/arch/x86/util/unwind-libunwind.o
      CC      /tmp/build/perf/builtin-kvm.o
      CC      /tmp/build/perf/builtin-inject.o
    make[4]: *** [/git/perf-6.10.0/tools/build/Makefile.build:106: /tmp/build/perf/util/disasm.o] Error 1
    make[4]: *** Waiting for unfinished jobs....
      CC      /tmp/build/perf/builtin-mem.o
    In file included from /usr/include/capstone/capstone.h:325,
                     from /git/perf-6.10.0/tools/perf/util/print_insn.h:23,
                     from builtin-script.c:38:
    /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
       94 | typedef enum bpf_insn {
          |              ^~~~~~~~
      CC      /tmp/build/perf/builtin-data.o
      CC      /tmp/build/perf/bench/breakpoint.o
      CC      /tmp/build/perf/tests/evsel-roundtrip-name.o
      CC      /tmp/build/perf/arch/x86/util/auxtrace.o
      CC      /tmp/build/perf/tests/evsel-tp-sched.o
   8    13.68 alpine:3.20                   : FAIL gcc version 13.2.1 20240309 (Alpine 13.2.1_git20240309) 
                     from util/disasm.c:29:
    /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
       94 | typedef enum bpf_insn {
          |              ^~~~~~~~
    In file included from /usr/include/capstone/capstone.h:325,
                     from /git/perf-6.10.0/tools/perf/util/print_insn.h:23,
                     from builtin-script.c:38:
    /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
       94 | typedef enum bpf_insn {
          |              ^~~~~~~~
    make[3]: *** [/git/perf-6.10.0/tools/build/Makefile.build:158: util] Error 2
      CC      /tmp/build/perf/bench/breakpoint.o
      CC      /tmp/build/perf/tests/hists_link.o
      CC      /tmp/build/perf/builtin-kvm.o
      CC      /tmp/build/perf/util/env.o
    In file included from /usr/include/capstone/capstone.h:325,
                     from util/print_insn.h:23,
                     from util/disasm.c:29:
    /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
       94 | typedef enum bpf_insn {
          |              ^~~~~~~~
    In file included from /usr/include/capstone/capstone.h:325,
                     from /git/perf-6.10.0/tools/perf/util/print_insn.h:23,
                     from builtin-script.c:38:
    /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
       94 | typedef enum bpf_insn {
          |              ^~~~~~~~
      CC      /tmp/build/perf/builtin-inject.o
      CC      /tmp/build/perf/arch/x86/util/intel-pt.o
      CC      /tmp/build/perf/util/event.o
    make[4]: *** [/git/perf-6.10.0/tools/build/Makefile.build:106: /tmp/build/perf/util/disasm.o] Error 1
    make[4]: *** Waiting for unfinished jobs....
   9    13.56 alpine:edge                   : FAIL gcc version 13.2.1 20240309 (Alpine 13.2.1_git20240309) 
                     from util/disasm.c:29:
    /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
       94 | typedef enum bpf_insn {
          |              ^~~~~~~~
    In file included from /usr/include/capstone/capstone.h:325,
                     from /git/perf-6.10.0/tools/perf/util/print_insn.h:23,
                     from builtin-script.c:38:
    /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
       94 | typedef enum bpf_insn {
          |              ^~~~~~~~
      CC      /tmp/build/perf/builtin-script.o
      CC      /tmp/build/perf/tests/hists_output.o
      CC      /tmp/build/perf/tests/hists_cumulate.o
      CC      /tmp/build/perf/bench/epoll-ctl.o
    In file included from /usr/include/capstone/capstone.h:325,
                     from util/print_insn.h:23,
                     from util/disasm.c:29:
    /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
       94 | typedef enum bpf_insn {
          |              ^~~~~~~~
      CC      /tmp/build/perf/util/sideband_evlist.o
      CC      /tmp/build/perf/builtin-kvm.o
      CC      /tmp/build/perf/arch/x86/util/auxtrace.o
    In file included from /usr/include/capstone/capstone.h:325,
                     from /git/perf-6.10.0/tools/perf/util/print_insn.h:23,
                     from builtin-script.c:38:
    /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
       94 | typedef enum bpf_insn {
          |              ^~~~~~~~
      CC      /tmp/build/perf/tests/python-use.o
      CC      /tmp/build/perf/util/evsel.o
    make[4]: *** [/git/perf-6.10.0/tools/build/Makefile.build:106: /tmp/build/perf/util/disasm.o] Error 1
    make[4]: *** Waiting for unfinished jobs....
      CC      /tmp/build/perf/builtin-inject.o
  10    12.00 amazonlinux:2                 : FAIL gcc version 7.3.1 20180712 (Red Hat 7.3.1-17) (GCC) 
  11    87.71 amazonlinux:2023              : Ok   gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2) , clang version 15.0.7 (Amazon Linux 15.0.7-3.amzn2023.0.1) flex 2.6.4
  12    86.71 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023.0.2) flex 2.6.4
  13    18.34 archlinux:base                : FAIL gcc version 13.2.1 20230801 (GCC) 
                     from builtin-script.c:38:
    /usr/include/capstone/bpf.h:94:14: error: ‘bpf_insn’ defined as wrong kind of tag
       94 | typedef enum bpf_insn {
          |              ^~~~~~~~
    In file included from /usr/include/capstone/capstone.h:325,
                     from util/print_insn.h:23,
                     from util/disasm.c:29:
    /usr/include/capstone/bpf.h:94:14: error: ‘bpf_insn’ defined as wrong kind of tag
       94 | typedef enum bpf_insn {
          |              ^~~~~~~~
      CC      /tmp/build/perf/util/copyfile.o
      CC      /tmp/build/perf/ui/browsers/scripts.o
      CC      /tmp/build/perf/bench/epoll-wait.o
      CC      /tmp/build/perf/arch/x86/util/mem-events.o
    In file included from /usr/include/capstone/capstone.h:325,
                     from /git/perf-6.10.0/tools/perf/util/print_insn.h:23,
                     from builtin-script.c:38:
    /usr/include/capstone/bpf.h:94:14: error: ‘bpf_insn’ defined as wrong kind of tag
       94 | typedef enum bpf_insn {
          |              ^~~~~~~~
      CC      /tmp/build/perf/builtin-data.o
      CC      /tmp/build/perf/ui/browsers/header.o
      CC      /tmp/build/perf/builtin-version.o
      CC      /tmp/build/perf/builtin-c2c.o
      CC      /tmp/build/perf/arch/x86/util/evsel.o
    --
      CC      /tmp/build/perf/arch/x86/util/intel-pt.o
      CC      /tmp/build/perf/util/sideband_evlist.o
      CC      /tmp/build/perf/util/evsel.o
      CC      /tmp/build/perf/arch/x86/util/intel-bts.o
    In file included from /usr/include/capstone/capstone.h:325,
                     from util/print_insn.h:23,
                     from util/disasm.c:29:
    /usr/include/capstone/bpf.h:94:14: error: ‘bpf_insn’ defined as wrong kind of tag
       94 | typedef enum bpf_insn {
          |              ^~~~~~~~
      CC      /tmp/build/perf/tests/pmu-events.o
      CC      /tmp/build/perf/util/evsel_fprintf.o
      CC      /tmp/build/perf/bench/kallsyms-parse.o
      CC      /tmp/build/perf/bench/find-bit-bench.o
      CC      /tmp/build/perf/tests/hists_common.o
  14   103.85 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-21) , clang version 17.0.6 (Red Hat 17.0.6-1.module_el8+767+9fa966b8) flex 2.6.1
  15    98.52 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 14.1.1 20240717 releases/gcc-14.1.0-275-g3a963d441a , clang version 17.0.6 flex 2.6.4

