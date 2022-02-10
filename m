Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9844B1616
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 20:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343873AbiBJTSV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 14:18:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343959AbiBJTSR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 14:18:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CAF2CB;
        Thu, 10 Feb 2022 11:18:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7E2CB8272D;
        Thu, 10 Feb 2022 19:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF032C004E1;
        Thu, 10 Feb 2022 19:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644520694;
        bh=Fiwgta/9vq2UAQAkLikI+jDg3v2cUKzChDQXHTvQMtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NHjqkB8oZBNwQp5axgTZgS5EmVaqI4IIPqWMRc87/kW5sDgd9fIXBdsXEHmTuc5pT
         N7u1NMtAeI2zPErNYSu0PVogmJdkmUq+U8j7kMshhixxfYGofeqaaTfAeEvaCLMo/n
         0hqUp1Tbe6adk/bB2JEymN/StdU3DfYe+jbGqYZSnFllrhFzSK79aYBUl/uD7J4frw
         QVm7IEhHnbiUTDPc/ijJ1Zfw9YP35VK5EC2+2NVdX6ubBbgYw0c4nQcielVM90UKJO
         lzaa8ia/CZmva2A4CseNIKMfjBquRqYUMX9u4yRtQjTz23/jMFjmb34x/s7Je6xMzS
         995Y2KkvCfnSA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 46FAC400FE; Thu, 10 Feb 2022 16:18:10 -0300 (-03)
Date:   Thu, 10 Feb 2022 16:18:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/3] perf/bpf: Remove prologue generation
Message-ID: <YgVk8t6COJhDJyzj@kernel.org>
References: <20220123221932.537060-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123221932.537060-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sun, Jan 23, 2022 at 11:19:30PM +0100, Jiri Olsa escreveu:
> Removing code for ebpf program prologue generation.
> 
> The prologue code was used to get data for extra arguments specified
> in program section name, like:
> 
>   SEC("lock_page=__lock_page page->flags")
>   int lock_page(struct pt_regs *ctx, int err, unsigned long flags)
>   {
>          return 1;
>   }
> 
> This code is using deprecated libbpf API and blocks its removal.
> 
> This feature was not documented and broken for some time without
> anyone complaining, also original authors are not responding,
> so I'm removing it.

So, the example below breaks, how hard would be to move the deprecated
APIs to perf like was done in some other cases?

- Arnaldo

Before:

[root@quaco perf]# cat tools/perf/examples/bpf/5sec.c 
// SPDX-License-Identifier: GPL-2.0
/*
    Description:

    . Disable strace like syscall tracing (--no-syscalls), or try tracing
      just some (-e *sleep).

    . Attach a filter function to a kernel function, returning when it should
      be considered, i.e. appear on the output.

    . Run it system wide, so that any sleep of >= 5 seconds and < than 6
      seconds gets caught.

    . Ask for callgraphs using DWARF info, so that userspace can be unwound

    . While this is running, run something like "sleep 5s".

    . If we decide to add tv_nsec as well, then it becomes:

      int probe(hrtimer_nanosleep, rqtp->tv_sec rqtp->tv_nsec)(void *ctx, int err, long sec, long nsec)

      I.e. add where it comes from (rqtp->tv_nsec) and where it will be
      accessible in the function body (nsec)

    # perf trace --no-syscalls -e tools/perf/examples/bpf/5sec.c/call-graph=dwarf/
         0.000 perf_bpf_probe:func:(ffffffff9811b5f0) tv_sec=5
                                           hrtimer_nanosleep ([kernel.kallsyms])
                                           __x64_sys_nanosleep ([kernel.kallsyms])
                                           do_syscall_64 ([kernel.kallsyms])
                                           entry_SYSCALL_64 ([kernel.kallsyms])
                                           __GI___nanosleep (/usr/lib64/libc-2.26.so)
                                           rpl_nanosleep (/usr/bin/sleep)
                                           xnanosleep (/usr/bin/sleep)
                                           main (/usr/bin/sleep)
                                           __libc_start_main (/usr/lib64/libc-2.26.so)
                                           _start (/usr/bin/sleep)
    ^C#

   Copyright (C) 2018 Red Hat, Inc., Arnaldo Carvalho de Melo <acme@redhat.com>
*/

#include <bpf.h>

#define NSEC_PER_SEC	1000000000L

int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
{
	return sec / NSEC_PER_SEC == 5ULL;
}

license(GPL);
[root@quaco perf]# perf trace -e tools/perf/examples/bpf/5sec.c  sleep 5s
     0.000 perf_bpf_probe:hrtimer_nanosleep(__probe_ip: -1994947936, rqtp: 5000000000)
[root@quaco perf]#

After:

[root@quaco perf]# perf trace -e tools/perf/examples/bpf/5sec.c  sleep 5s
event syntax error: 'tools/perf/examples/bpf/5sec.c'
                     \___ Permission denied

(add -v to see detail)
Run 'perf list' for a list of valid events

 Usage: perf trace [<options>] [<command>]
    or: perf trace [<options>] -- <command> [<options>]
    or: perf trace record [<options>] [<command>]
    or: perf trace record [<options>] -- <command> [<options>]

    -e, --event <event>   event/syscall selector. use 'perf list' to list available events
[root@quaco perf]# perf trace -v -e tools/perf/examples/bpf/5sec.c  sleep 5s
bpf: builtin compilation failed: -95, try external compiler
Kernel build dir is set to /lib/modules/5.15.18-200.fc35.x86_64/build
set env: KBUILD_DIR=/lib/modules/5.15.18-200.fc35.x86_64/build
unset env: KBUILD_OPTS
include option is set to -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/11/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h 
set env: NR_CPUS=8
set env: LINUX_VERSION_CODE=0x50f12
set env: CLANG_EXEC=/usr/lib64/ccache/clang
set env: CLANG_OPTIONS=-g
set env: KERNEL_INC_OPTIONS=-nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/11/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h 
set env: PERF_BPF_INC_OPTIONS=-I/home/acme/lib/perf/include/bpf
set env: WORKING_DIR=/lib/modules/5.15.18-200.fc35.x86_64/build
set env: CLANG_SOURCE=/home/acme/git/perf/tools/perf/examples/bpf/5sec.c
llvm compiling command template: $CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS -DLINUX_VERSION_CODE=$LINUX_VERSION_CODE $CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS -Wno-unused-value -Wno-pointer-sign -working-directory $WORKING_DIR -c "$CLANG_SOURCE" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE
llvm compiling command : /usr/lib64/ccache/clang -D__KERNEL__ -D__NR_CPUS__=8 -DLINUX_VERSION_CODE=0x50f12 -g -I/home/acme/lib/perf/include/bpf -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/11/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h  -Wno-unused-value -Wno-pointer-sign -working-directory /lib/modules/5.15.18-200.fc35.x86_64/build -c /home/acme/git/perf/tools/perf/examples/bpf/5sec.c -target bpf  -O2 -o - 
libbpf: loading object 'tools/perf/examples/bpf/5sec.c' from buffer
libbpf: elf: section(3) hrtimer_nanosleep=hrtimer_nanosleep rqtp, size 64, link 0, flags 6, type=1
libbpf: sec 'hrtimer_nanosleep=hrtimer_nanosleep rqtp': found program 'hrtimer_nanosleep' at insn offset 0 (0 bytes), code size 8 insns (64 bytes)
libbpf: elf: section(4) license, size 4, link 0, flags 3, type=1
libbpf: license of tools/perf/examples/bpf/5sec.c is GPL
libbpf: elf: section(5) version, size 4, link 0, flags 3, type=1
libbpf: kernel version of tools/perf/examples/bpf/5sec.c is 50f12
libbpf: elf: section(11) .BTF, size 558, link 0, flags 0, type=1
libbpf: elf: section(13) .BTF.ext, size 112, link 0, flags 0, type=1
libbpf: elf: section(20) .symtab, size 288, link 1, flags 0, type=2
libbpf: looking for externs among 12 symbols...
libbpf: collected 0 externs total
libbpf: prog 'hrtimer_nanosleep': unrecognized ELF section name 'hrtimer_nanosleep=hrtimer_nanosleep rqtp'
LLVM: dumping tools/perf/examples/bpf/5sec.o
bpf: config program 'hrtimer_nanosleep=hrtimer_nanosleep rqtp'
symbol:hrtimer_nanosleep file:(null) line:0 offset:0 return:0 lazy:(null)
parsing arg: rqtp into rqtp
bpf: config 'hrtimer_nanosleep=hrtimer_nanosleep rqtp' is ok
Looking at the vmlinux_path (8 entries long)
Using /usr/lib/debug/lib/modules/5.15.18-200.fc35.x86_64/vmlinux for symbols
Open Debuginfo file: /usr/lib/debug/.build-id/a5/6896963dc51b426302a1f1147842fb8f288ef2.debug
Try to find probe point from debuginfo.
Opening /sys/kernel/tracing//README write=0
Matched function: hrtimer_nanosleep [1af0959]
Probe point found: hrtimer_nanosleep+0
Searching 'rqtp' variable in context.
Converting variable rqtp into trace event.
rqtp type is long long int.
Found 1 probe_trace_events.
Opening /sys/kernel/tracing//kprobe_events write=1
Writing event: p:perf_bpf_probe/hrtimer_nanosleep _text+1540768 rqtp=%di:s64
libbpf: prog 'hrtimer_nanosleep': BPF program load failed: Permission denied
libbpf: prog 'hrtimer_nanosleep': -- BEGIN PROG LOAD LOG --
arg#0 reference type('UNKNOWN ') size cannot be determined: -22
; int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
0: (18) r1 = 0xfffffffed5fa0e00
; return sec / NSEC_PER_SEC == 5ULL;
2: (0f) r3 += r1
R3 !read_ok
processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: failed to load program 'hrtimer_nanosleep'
libbpf: failed to load object 'tools/perf/examples/bpf/5sec.c'
bpf: load objects failed: err=-13: (Permission denied)
event syntax error: 'tools/perf/examples/bpf/5sec.c'
                     \___ Permission denied

(add -v to see detail)
Run 'perf list' for a list of valid events

 Usage: perf trace [<options>] [<command>]
    or: perf trace [<options>] -- <command> [<options>]
    or: perf trace record [<options>] [<command>]
    or: perf trace record [<options>] -- <command> [<options>]

    -e, --event <event>   event/syscall selector. use 'perf list' to list available events
Opening /sys/kernel/tracing//kprobe_events write=1
Opening /sys/kernel/tracing//uprobe_events write=1
Parsing probe_events: p:perf_bpf_probe/hrtimer_nanosleep _text+1540768 rqtp=%di:s64
Group:perf_bpf_probe Event:hrtimer_nanosleep probe:p
Writing event: -:perf_bpf_probe/hrtimer_nanosleep
[root@quaco perf]# 


