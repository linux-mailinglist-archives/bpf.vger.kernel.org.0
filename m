Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC68486936
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 18:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242443AbiAFRyv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 12:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241987AbiAFRyu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 12:54:50 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75394C061245;
        Thu,  6 Jan 2022 09:54:50 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id t204so4773136oie.7;
        Thu, 06 Jan 2022 09:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zayjP3D/fuoryO+xuawRzL2dL0yx27QBEU+Hbg2g5Mw=;
        b=V1jDhgPs3MFnxDI/M2gOtEhPQKEf3jHb6ddCzl2murJR2aypCQyL4m94TK2kDOnmOp
         DQAI1HLuFMrb5m427uNWx0O5slyHFxj/wPXDsFk+i3kvrXKOyeDqJjwdQZcwyOI9EOaW
         wkLIpzMbQKtmK7rlMCH+a8gKHfNaz84aLv5dbu5CjwOsFEeyCyPhWS5J8ehDlJ6oH/Qq
         5DJe0Gc1vpF+s7amqmjmi+rWkP1DOKtrLvS/boLbfkMYIDMud2A4zZ/ktl1hfIlxwPvX
         dm+oa6Ty2wXJduoCYbkLSQ8DkbPVt0XQ36KdJVmV+vhZmMck4H5aKuD/eJgiYB6tc/iy
         1dJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zayjP3D/fuoryO+xuawRzL2dL0yx27QBEU+Hbg2g5Mw=;
        b=sepEYMRJJmmJWbTBLLHt1g1GO8IOx4WGyapDufy1XkA+xW9gT/VcXIOG3vVBpTVGg7
         fwLYFHeDFgMQTtp1rXm/F382zmUVDVg/kbzWshEOslbzzOTtEjGAME2qnuhl3/2cKTOJ
         U5qv5ufECXfgikiC19RlN5zcx9mYHD3OUI3ByLM2siG8tNyjgYefoI4ONFp/6uHSsEul
         zXd1Lrv+0IUvQMiZuXe6kkK6PG+VbY7Sjwxc7frwRDv93jLDSuOo4wny1m93bgEh4w8N
         OrWcZ4hUjW+joG/k46eg6fSCUxGH/aRfwAMx0gmEeUWK7u0DLRwMWERaZuRekY12esDN
         cbnw==
X-Gm-Message-State: AOAM531EpXfUCrAYU286XnQb0WSanBG7ADwVofuOImcPbnCRs77jwZLW
        +rNuH/lNpJnnfdV0cZpEgYDNENDKHw9uUZH3Tfk=
X-Google-Smtp-Source: ABdhPJwGswYn2GtCTApEjgP7+szLiIOf8+6XlAaLsgpoixSBgjMS+FEM2AQGoi+e0CbSldSdTx1puzBc4EiYB4i1dAA=
X-Received: by 2002:a54:468b:: with SMTP id k11mr7235526oic.105.1641491689681;
 Thu, 06 Jan 2022 09:54:49 -0800 (PST)
MIME-Version: 1.0
References: <20211216222108.110518-1-christylee@fb.com> <20211216222108.110518-3-christylee@fb.com>
 <YcGO271nDvfMeSlK@krava> <CAEf4BzZpNvEtfsVHUJGfwi_1xM+7-ohBPKPrRo--X=fYkYLrsw@mail.gmail.com>
 <YcMr1LeP6zUBdCiK@krava> <CAEf4Bzb2HWiuJmeb6WxE2Dift5qQOLBE=j1ZqfpVMjuWV3+EDg@mail.gmail.com>
 <CAPqJDZouQHpUXv4dEGKKe=UjwkZu3=GMQ2M9g2zLYOV6a=gZbw@mail.gmail.com>
 <YdRccTaunl9Fo63X@krava> <YdWhz1qaRncxNC/6@krava>
In-Reply-To: <YdWhz1qaRncxNC/6@krava>
From:   Christy Lee <christyc.y.lee@gmail.com>
Date:   Thu, 6 Jan 2022 09:54:38 -0800
Message-ID: <CAPqJDZpZrrg4UBz19H-HyEMk7rzn+PCe=qpYDR0uHvD3nPr4yw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] perf: stop using deprecated
 bpf__object_next() API
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        He Kuang <hekuang@huawei.com>, Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thank you so much, I was able to reproduce the original tests after applying
the bug fix. I will submit a new patch set with the more detailed comments.

The only deprecated functions that need to be removed after this would be
bpf_program__set_prep() (how perf sets the bpf prologue) and
bpf_program__nth_fd() (how perf leverages multi instance bpf). They look a
little more involved and I'm not sure how to approach those. Jiri, would you
mind taking a look at those please?

Christy

On Wed, Jan 5, 2022 at 5:49 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 04, 2022 at 03:40:49PM +0100, Jiri Olsa wrote:
> > On Wed, Dec 29, 2021 at 11:01:35AM -0800, Christy Lee wrote:
> >
> > SNIP
> >
> > > > >
> > > > > I don't use it, I just know it's there.. that's why I asked ;-)
> > > > >
> > > > > it's possible to specify bpf program on the perf command line
> > > > > to be attached to event, like:
> > > > >
> > > > >       # cat tools/perf/examples/bpf/hello.c
> > > > >       #include <stdio.h>
> > > > >
> > > > >       int syscall_enter(openat)(void *args)
> > > > >       {
> > > > >               puts("Hello, world\n");
> > > > >               return 0;
> > > > >       }
> > > > >
> > > > >       license(GPL);
> > > > >       #
> > > > >       # perf trace -e openat,tools/perf/examples/bpf/hello.c cat /etc/passwd > /dev/null
> > > > >          0.016 (         ): __bpf_stdout__:Hello, world
> > > > >          0.018 ( 0.010 ms): cat/9079 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
> > > > >          0.057 (         ): __bpf_stdout__:Hello, world
> > > > >          0.059 ( 0.011 ms): cat/9079 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC) = 3
> > > > >          0.417 (         ): __bpf_stdout__:Hello, world
> > > > >          0.419 ( 0.009 ms): cat/9079 openat(dfd: CWD, filename: /etc/passwd) = 3
> > > > >       #
> > > > >
> > > > > I took that example from commit message
> > > [...]
> > >
> > > I found the original commit aa3abf30bb28addcf593578d37447d42e3f65fc3
> > > that included a test case, but I'm having trouble reproducing it due to syntax
> > > error. I am running this on bpf-next master without my patches.
> > >
> > > I ran 'perf test -v LLVM' and used it's output to generate a script for
> > > compiling the perf test object:
> > >
> > > --------------------------------------------------
> > > $ cat ~/bin/hello-ebpf
> > > INPUT_FILE=/tmp/test.c
> > > OUTPUT_FILE=/tmp/test.o
> > >
> > > export KBUILD_DIR=/lib/modules/5.12.0-0_fbk2_3390_g7ecb4ac46d7f/build
> > > export NR_CPUS=56
> > > export LINUX_VERSION_CODE=0x50c00
> > > export CLANG_EXEC=/data/users/christylee/devtools/llvm/latest/bin/clang
> > > export CLANG_OPTIONS=-xc
> > > export KERNEL_INC_OPTIONS="-nostdinc -isystem
> > > /data/users/christylee/devtools/gcc/10.3.0/lib/gcc/x86_64-pc-linux-gnu/10.3.0/include
> > > -I./arch/\
> > > x86/include -I./arch/x86/include/generated  -I./include
> > > -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi
> > > -I./include/uapi -I./in\
> > > clude/generated/uapi -include ./include/linux/compiler-version.h
> > > -include ./include/linux/kconfig.h"
> > > export PERF_BPF_INC_OPTIONS=-I/home/christylee/lib/perf/include/bpf
> > > export WORKING_DIR=/lib/modules/5.12.0-0_fbk2_3390_g7ecb4ac46d7f/build
> > > export CLANG_SOURCE=-
> > >
> > > rm -f $OUTPUT_FILE
> > > cat $INPUT_FILE |
> > > /data/users/christylee/devtools/llvm/latest/bin/clang -D__KERNEL__
> > > -D__NR_CPUS__=56 -DLINUX_VERSION_CODE=0x50c00 -xc  -I/ho\
> > > me/christylee/lib/perf/include/bpf  -nostdinc -isystem
> > > /data/users/christylee/devtools/gcc/10.3.0/lib/gcc/x86_64-pc-linux-gnu/10.3.0/include
> > > \
> > > -I./arch/x86/include -I./arch/x86/include/generated  -I./include
> > > -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi
> > > -I./include/ua\
> > > pi -I./include/generated/uapi -include
> > > ./include/linux/compiler-version.h -include ./include/linux/kconfig.h
> > > -Wno-unused-value -Wno-pointer-\
> > > sign -working-directory
> > > /lib/modules/5.12.0-0_fbk2_3390_g7ecb4ac46d7f/build -c - -target bpf
> > > -O2 -o $OUTPUT_FILE
> > > --------------------------------------------------
> > >
> > > I then wrote and compiled a script that ask to get asks to put a probe
> > > at a function that
> > > does not exists in the kernel, it errors out as expected:
> > >
> > > $ cat /tmp/test.c
> > > __attribute__((section("fork=does_not_exist"), used)) int fork(void *ctx) {
> > >     return 0;
> > > }
> > >
> > > char _license[] __attribute__((section("license"), used)) = "GPL";
> > > int _version __attribute__((section("version"), used)) = 0x40100;
> > > $ cd ~/bin && ./hello-ebpf
> > > $ perf record --event /tmp/test.o sleep 1
> > > Using perf wrapper that supports hot-text. Try perf.real if you
> > > encounter any issues.
> > > Probe point 'does_not_exist' not found.
> > > event syntax error: '/tmp/test.o'
> > >                      \___ You need to check probing points in BPF file
> > >
> > > (add -v to see detail)
> > > Run 'perf list' for a list of valid events
> > >
> > >  Usage: perf record [<options>] [<command>]
> > >     or: perf record [<options>] -- <command> [<options>]
> > >
> > >     -e, --event <event>   event selector. use 'perf list' to list
> > > available events
> > >
> > > ---------------------------------------------------
> > >
> > > Next I changed the attribute to something that exists in the kernel.
> > > As expected, it errors out
> > > with permission problem:
> > > $ cat /tmp/test.c
> > > __attribute__((section("fork=fork_init"), used)) int fork(void *ctx) {
> > >     return 0;
> > > }
> > > char _license[] __attribute__((section("license"), used)) = "GPL";
> > > int _version __attribute__((section("version"), used)) = 0x40100;
> > > $ grep fork_init /proc/kallsyms
> > > ffffffff8146e250 T xfs_ifork_init_cow
> > > ffffffff83980481 T fork_init
> > > $ cd ~/bin && ./hello-ebpf
> > > $ perf record --event /tmp/test.o sleep 1
> > > Using perf wrapper that supports hot-text. Try perf.real if you
> > > encounter any issues.
> > > Failed to open kprobe_events: Permission denied
> > > event syntax error: '/tmp/test.o'
> > >                      \___ You need to be root
> > >
> > > (add -v to see detail)
> > > Run 'perf list' for a list of valid events
> > >
> > >  Usage: perf record [<options>] [<command>]
> > >     or: perf record [<options>] -- <command> [<options>]
> > >
> > >     -e, --event <event>   event selector. use 'perf list' to list
> > > available events
> > >
> > > ---------------------------------------------------
> > >
> > > So I reran as root, but this time I get an invalid syntax error:
> > >
> > > # perf record --event /tmp/test.o -v sleep 1
> > > Using perf wrapper that supports hot-text. Try perf.real if you
> > > encounter any issues.
> > > Failed to write event: Invalid argument
> > > event syntax error: '/tmp/test.o'
> > >                      \___ Invalid argument
> > >
> > > (add -v to see detail)
> > > Run 'perf list' for a list of valid events
> > >
> > >  Usage: perf record [<options>] [<command>]
> > >     or: perf record [<options>] -- <command> [<options>]
> > >
> > >     -e, --event <event>   event selector. use 'perf list' to list
> > > available events
> > > ---------------------------------------------------
> > >
> > > Is there a different way to attach a custom event probe point?
> > >
> >
> > nice, good question ;-)
> >
> > looks like there are no volunteers from original authors,
> > I'll check on that
>
> there's small bug in perf trace that makes it to die early,
> (fix below) but other than that it works.. I'll send full
> patch later
>
> you need to specify full path for bpf object, not like in the
> example I pasted above.. I recall fixing that in code because
> it clashed with pmu syntax
>
> so on fedora 35 I can run following with the change below:
>
>         # ./perf trace -e openat,/home/jolsa/linux-qemu/tools/perf/examples/bpf/hello.c
>         /home/jolsa/linux-qemu/tools/perf/examples/bpf/hello.c:5:2: warning: variable length array folded to constant array as an extension [-Wgnu-folding-constant]
>                 puts("Hello, world\n");
>                 ^
>         /home/jolsa/lib/perf/include/bpf/stdio.h:14:10: note: expanded from macro 'puts'
>                    char __from[__len] = from; \
>                         ^
>         1 warning generated.
>              0.000 (         ): systemd-resolv/1142 __bpf_stdout__(Hello, world)
>              0.016 ( 0.031 ms): systemd-resolv/1142 openat(dfd: CWD, filename: 0x6b1c4a70, flags: RDONLY|CLOEXEC)         = -1 ENOENT (No such file or directory)
>              0.070 (         ): systemd-resolv/1142 __bpf_stdout__(Hello, world)
>              0.074 ( 0.011 ms): systemd-resolv/1142 openat(dfd: CWD, filename: 0x6b1c4a70, flags: RDONLY|CLOEXEC)         = -1 ENOENT (No such file or directory)
>              0.097 (         ): systemd-resolv/1142 __bpf_stdout__(Hello, world)
>              0.101 ( 0.010 ms): systemd-resolv/1142 openat(dfd: CWD, filename: 0x6b1c4a70, flags: RDONLY|CLOEXEC)         = -1 ENOENT (No such file or directory)
>              0.123 (         ): systemd-resolv/1142 __bpf_stdout__(Hello, world)
>              0.127 ( 0.010 ms): systemd-resolv/1142 openat(dfd: CWD, filename: 0x6b1c4a70, flags: RDONLY|CLOEXEC)         = -1 ENOENT (No such file or directory)
>              0.148 (         ): systemd-resolv/1142 __bpf_stdout__(Hello, world)
>              0.152 ( 0.010 ms): systemd-resolv/1142 openat(dfd: CWD, filename: 0x6b1c4a70, flags: RDONLY|CLOEXEC)         = -1 ENOENT (No such file or directory)
>              0.219 (         ): systemd-resolv/1142 __bpf_stdout__(Hello, world)
>         ...
>
>
> jirka
>
>
> ---
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 97121fb45842..df9fc00b4cd6 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3936,6 +3936,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>         bool draining = false;
>
>         trace->live = true;
> +       signal(SIGCHLD, sig_handler);
>
>         if (!trace->raw_augmented_syscalls) {
>                 if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
> @@ -4884,7 +4885,6 @@ int cmd_trace(int argc, const char **argv)
>
>         signal(SIGSEGV, sighandler_dump_stack);
>         signal(SIGFPE, sighandler_dump_stack);
> -       signal(SIGCHLD, sig_handler);
>         signal(SIGINT, sig_handler);
>
>         trace.evlist = evlist__new();
>
