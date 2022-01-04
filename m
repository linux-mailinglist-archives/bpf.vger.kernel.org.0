Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9498548438B
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 15:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiADOkz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 09:40:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230044AbiADOkz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Jan 2022 09:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641307253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yjF/HkcVKz/JEhsGrCG5Ee+s8aLEGsQuOHneC2aFbZc=;
        b=Ipg+oGG40JT5VMf1BT1HWFiYPLOpplYIlAJ/WRtxQK7/zaAEBm0NzfGaaD4JsIQ85qOXSf
        sJgwNxDMa/AGvBff979KfNKvXoin00pxNBm/eaJoAqNjzg8oVKiSkbvZONAONY1Uc753PA
        lzuQaOaP9o3a1+f1RmoUWaQaruq1cgo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-yLstmadVMaSz2AlObw5Ztw-1; Tue, 04 Jan 2022 09:40:53 -0500
X-MC-Unique: yLstmadVMaSz2AlObw5Ztw-1
Received: by mail-wr1-f69.google.com with SMTP id h12-20020adfa4cc000000b001a22dceda69so11773624wrb.16
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 06:40:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yjF/HkcVKz/JEhsGrCG5Ee+s8aLEGsQuOHneC2aFbZc=;
        b=UpR9P/fNXFBhONsVryksxN7gclNLyUJ00Q5AbzhyE88TJdNP50eNEXuLyKH08/lBKO
         RosCuqMXkW0K0P4+hIAdmZW1fbVq8Z7SZIvKNhHIHeFFFPieE6n8Ljsz96XKdugGsQdO
         +GVdVVZPUG/i8WULKVfsC7QrXge9T3gBn9OMdML7onq4LrFJDv8+pkMyY+ZCg2do/4SI
         gStAs0sAUsbN6Wl57b59ciOLzsfTOyP/Ue7gCkH6yjoUlk/PRB+rcxjbCLY0V/aWLm0F
         vvg5hLiU3JL6q4TUvt53xwZ+4q7gmjmNPzEsvH9Iy3Jx7aqOIhg1qhEI7yY6vXTkbeHm
         kJsw==
X-Gm-Message-State: AOAM531S5j1qIn4y/3h3LS3LyxCCxKlu3aaMOqM6QDE/q1tZ6UdTVulC
        jLOypA2mAspzD6z/tDhfdEYNUMrv7CF4MZttVVq8zTjUBcfAZdyuH17L23nc9aG5a2HMz0t3CBq
        yoBq/a+q9WDAG
X-Received: by 2002:a5d:6546:: with SMTP id z6mr43402782wrv.516.1641307251325;
        Tue, 04 Jan 2022 06:40:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRS0u8ZoT1tsRxza5yCzGKCGxKsTddHRB9On2QtVajv3vMP2xFcFlYVbXT/FDWiVkGetlqQQ==
X-Received: by 2002:a5d:6546:: with SMTP id z6mr43402769wrv.516.1641307251089;
        Tue, 04 Jan 2022 06:40:51 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id b5sm8082377wrr.19.2022.01.04.06.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:40:50 -0800 (PST)
Date:   Tue, 4 Jan 2022 15:40:49 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Christy Lee <christyc.y.lee@gmail.com>
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
Subject: Re: [PATCH bpf-next 2/2] perf: stop using deprecated
 bpf__object_next() API
Message-ID: <YdRccTaunl9Fo63X@krava>
References: <20211216222108.110518-1-christylee@fb.com>
 <20211216222108.110518-3-christylee@fb.com>
 <YcGO271nDvfMeSlK@krava>
 <CAEf4BzZpNvEtfsVHUJGfwi_1xM+7-ohBPKPrRo--X=fYkYLrsw@mail.gmail.com>
 <YcMr1LeP6zUBdCiK@krava>
 <CAEf4Bzb2HWiuJmeb6WxE2Dift5qQOLBE=j1ZqfpVMjuWV3+EDg@mail.gmail.com>
 <CAPqJDZouQHpUXv4dEGKKe=UjwkZu3=GMQ2M9g2zLYOV6a=gZbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPqJDZouQHpUXv4dEGKKe=UjwkZu3=GMQ2M9g2zLYOV6a=gZbw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 29, 2021 at 11:01:35AM -0800, Christy Lee wrote:

SNIP

> > >
> > > I don't use it, I just know it's there.. that's why I asked ;-)
> > >
> > > it's possible to specify bpf program on the perf command line
> > > to be attached to event, like:
> > >
> > >       # cat tools/perf/examples/bpf/hello.c
> > >       #include <stdio.h>
> > >
> > >       int syscall_enter(openat)(void *args)
> > >       {
> > >               puts("Hello, world\n");
> > >               return 0;
> > >       }
> > >
> > >       license(GPL);
> > >       #
> > >       # perf trace -e openat,tools/perf/examples/bpf/hello.c cat /etc/passwd > /dev/null
> > >          0.016 (         ): __bpf_stdout__:Hello, world
> > >          0.018 ( 0.010 ms): cat/9079 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
> > >          0.057 (         ): __bpf_stdout__:Hello, world
> > >          0.059 ( 0.011 ms): cat/9079 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC) = 3
> > >          0.417 (         ): __bpf_stdout__:Hello, world
> > >          0.419 ( 0.009 ms): cat/9079 openat(dfd: CWD, filename: /etc/passwd) = 3
> > >       #
> > >
> > > I took that example from commit message
> [...]
> 
> I found the original commit aa3abf30bb28addcf593578d37447d42e3f65fc3
> that included a test case, but I'm having trouble reproducing it due to syntax
> error. I am running this on bpf-next master without my patches.
> 
> I ran 'perf test -v LLVM' and used it's output to generate a script for
> compiling the perf test object:
> 
> --------------------------------------------------
> $ cat ~/bin/hello-ebpf
> INPUT_FILE=/tmp/test.c
> OUTPUT_FILE=/tmp/test.o
> 
> export KBUILD_DIR=/lib/modules/5.12.0-0_fbk2_3390_g7ecb4ac46d7f/build
> export NR_CPUS=56
> export LINUX_VERSION_CODE=0x50c00
> export CLANG_EXEC=/data/users/christylee/devtools/llvm/latest/bin/clang
> export CLANG_OPTIONS=-xc
> export KERNEL_INC_OPTIONS="-nostdinc -isystem
> /data/users/christylee/devtools/gcc/10.3.0/lib/gcc/x86_64-pc-linux-gnu/10.3.0/include
> -I./arch/\
> x86/include -I./arch/x86/include/generated  -I./include
> -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi
> -I./include/uapi -I./in\
> clude/generated/uapi -include ./include/linux/compiler-version.h
> -include ./include/linux/kconfig.h"
> export PERF_BPF_INC_OPTIONS=-I/home/christylee/lib/perf/include/bpf
> export WORKING_DIR=/lib/modules/5.12.0-0_fbk2_3390_g7ecb4ac46d7f/build
> export CLANG_SOURCE=-
> 
> rm -f $OUTPUT_FILE
> cat $INPUT_FILE |
> /data/users/christylee/devtools/llvm/latest/bin/clang -D__KERNEL__
> -D__NR_CPUS__=56 -DLINUX_VERSION_CODE=0x50c00 -xc  -I/ho\
> me/christylee/lib/perf/include/bpf  -nostdinc -isystem
> /data/users/christylee/devtools/gcc/10.3.0/lib/gcc/x86_64-pc-linux-gnu/10.3.0/include
> \
> -I./arch/x86/include -I./arch/x86/include/generated  -I./include
> -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi
> -I./include/ua\
> pi -I./include/generated/uapi -include
> ./include/linux/compiler-version.h -include ./include/linux/kconfig.h
> -Wno-unused-value -Wno-pointer-\
> sign -working-directory
> /lib/modules/5.12.0-0_fbk2_3390_g7ecb4ac46d7f/build -c - -target bpf
> -O2 -o $OUTPUT_FILE
> --------------------------------------------------
> 
> I then wrote and compiled a script that ask to get asks to put a probe
> at a function that
> does not exists in the kernel, it errors out as expected:
> 
> $ cat /tmp/test.c
> __attribute__((section("fork=does_not_exist"), used)) int fork(void *ctx) {
>     return 0;
> }
> 
> char _license[] __attribute__((section("license"), used)) = "GPL";
> int _version __attribute__((section("version"), used)) = 0x40100;
> $ cd ~/bin && ./hello-ebpf
> $ perf record --event /tmp/test.o sleep 1
> Using perf wrapper that supports hot-text. Try perf.real if you
> encounter any issues.
> Probe point 'does_not_exist' not found.
> event syntax error: '/tmp/test.o'
>                      \___ You need to check probing points in BPF file
> 
> (add -v to see detail)
> Run 'perf list' for a list of valid events
> 
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
> 
>     -e, --event <event>   event selector. use 'perf list' to list
> available events
> 
> ---------------------------------------------------
> 
> Next I changed the attribute to something that exists in the kernel.
> As expected, it errors out
> with permission problem:
> $ cat /tmp/test.c
> __attribute__((section("fork=fork_init"), used)) int fork(void *ctx) {
>     return 0;
> }
> char _license[] __attribute__((section("license"), used)) = "GPL";
> int _version __attribute__((section("version"), used)) = 0x40100;
> $ grep fork_init /proc/kallsyms
> ffffffff8146e250 T xfs_ifork_init_cow
> ffffffff83980481 T fork_init
> $ cd ~/bin && ./hello-ebpf
> $ perf record --event /tmp/test.o sleep 1
> Using perf wrapper that supports hot-text. Try perf.real if you
> encounter any issues.
> Failed to open kprobe_events: Permission denied
> event syntax error: '/tmp/test.o'
>                      \___ You need to be root
> 
> (add -v to see detail)
> Run 'perf list' for a list of valid events
> 
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
> 
>     -e, --event <event>   event selector. use 'perf list' to list
> available events
> 
> ---------------------------------------------------
> 
> So I reran as root, but this time I get an invalid syntax error:
> 
> # perf record --event /tmp/test.o -v sleep 1
> Using perf wrapper that supports hot-text. Try perf.real if you
> encounter any issues.
> Failed to write event: Invalid argument
> event syntax error: '/tmp/test.o'
>                      \___ Invalid argument
> 
> (add -v to see detail)
> Run 'perf list' for a list of valid events
> 
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
> 
>     -e, --event <event>   event selector. use 'perf list' to list
> available events
> ---------------------------------------------------
> 
> Is there a different way to attach a custom event probe point?
> 

nice, good question ;-)

looks like there are no volunteers from original authors,
I'll check on that

thanks,
jirka

