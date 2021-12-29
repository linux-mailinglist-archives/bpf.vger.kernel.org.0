Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6C8481620
	for <lists+bpf@lfdr.de>; Wed, 29 Dec 2021 20:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhL2TBs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Dec 2021 14:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhL2TBr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Dec 2021 14:01:47 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7745AC061574;
        Wed, 29 Dec 2021 11:01:47 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id j124so36367334oih.12;
        Wed, 29 Dec 2021 11:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRINl9bSIHzu7cRYaq3FSH+P+41wU3Ojg7POjWfVokk=;
        b=KUjMjlBT6sMwDbvndonSVhsp9Pvln9VnycfMzUhILA6rexEPBAU5W1iTkw7rvbc1lb
         81JQBuVyRhYoJaI0a1p2Z52FRFKKocFX1dRuF4+AUdOSywBod7V/UW5xuQ3PDT9/YqMD
         y6aQf+hsf0xy48+axgZPIxSy5psApFt8JJMLaRoalVIxtjIaX7Jd1aHgXtVtm3D7wOc+
         cwPmFMUAOVmXF35HSgeGbfK0tHLYS4ptWeK3yUgnIa2J/vmRYsXSsXEoD/pjwjhuLbc3
         liJJpiJVM/LHrGGg39meeipvlNnVlAAVNQIEav8vwKAOsqK2IXVfqM56pbD74EqJux6V
         wnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRINl9bSIHzu7cRYaq3FSH+P+41wU3Ojg7POjWfVokk=;
        b=GHSnRcTnGYJrJ515T07rvRgVZNe3qdWX+wC+KgfJlucHmhACc6D4orLE61wtYEzKVy
         G7bChbQfYjfDxGSomgGSCN/JHxVdZJrxK1YtUm1lwvW2LORbGMxt7Uo6XgD/iG77ycPT
         aNP2BbMaKsetdFkSJ/XasF3kXMxSoXkjNFgNl4Z9wW5iCot/aMUZZsVd1P+rQoiMEY9g
         2zqYPRcA+y9EevD8GfGq9XwU2PSPAHWNiws58Chbbb9mhCHzbby5wjzgJQ9CZW08U8+Z
         gBMPFLK9SEdYuzMH8SzitBSXUMqr8CJKSOTF9dXuLtDWUVuA2cAwbN1id9/cXpPjuIl7
         vKaQ==
X-Gm-Message-State: AOAM5333zOpogbheZjzdFFKphaKtvNMKwoJkYVKUL1RC6JfjAbBLC0LH
        +rtK5ZLkYHjo/lizNMIG2qbaTTs5rVw/rZWL9Xo=
X-Google-Smtp-Source: ABdhPJyLpLTPbemnFAz0K/5iKmRl8VJ2LXGEIeRM45vEowlmW0ZyZc5MxNCRtAIhCb1iuCSH7HOiLADdzv4pZf5w1mQ=
X-Received: by 2002:a05:6808:1285:: with SMTP id a5mr20742944oiw.104.1640804506794;
 Wed, 29 Dec 2021 11:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20211216222108.110518-1-christylee@fb.com> <20211216222108.110518-3-christylee@fb.com>
 <YcGO271nDvfMeSlK@krava> <CAEf4BzZpNvEtfsVHUJGfwi_1xM+7-ohBPKPrRo--X=fYkYLrsw@mail.gmail.com>
 <YcMr1LeP6zUBdCiK@krava> <CAEf4Bzb2HWiuJmeb6WxE2Dift5qQOLBE=j1ZqfpVMjuWV3+EDg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb2HWiuJmeb6WxE2Dift5qQOLBE=j1ZqfpVMjuWV3+EDg@mail.gmail.com>
From:   Christy Lee <christyc.y.lee@gmail.com>
Date:   Wed, 29 Dec 2021 11:01:35 -0800
Message-ID: <CAPqJDZouQHpUXv4dEGKKe=UjwkZu3=GMQ2M9g2zLYOV6a=gZbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] perf: stop using deprecated
 bpf__object_next() API
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Christy Lee <christylee@fb.com>,
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

On Wed, Dec 22, 2021 at 2:17 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Dec 22, 2021 at 5:44 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Dec 21, 2021 at 01:58:14PM -0800, Andrii Nakryiko wrote:
> > > On Tue, Dec 21, 2021 at 12:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Thu, Dec 16, 2021 at 02:21:08PM -0800, Christy Lee wrote:
> > > > > bpf__object_next is deprecated, track bpf_objects directly in
> > > > > perf instead.
> > > > >
> > > > > Signed-off-by: Christy Lee <christylee@fb.com>
> > > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > ---
> > > > >  tools/perf/util/bpf-loader.c | 72 +++++++++++++++++++++++++++---------
> > > > >  tools/perf/util/bpf-loader.h |  1 +
> > > > >  2 files changed, 55 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> > > > > index 528aeb0ab79d..9e3988fd719a 100644
> > > > > --- a/tools/perf/util/bpf-loader.c
> > > > > +++ b/tools/perf/util/bpf-loader.c
> > > > > @@ -29,9 +29,6 @@
> > > > >
> > > > >  #include <internal/xyarray.h>
> > > > >
> > > > > -/* temporarily disable libbpf deprecation warnings */
> > > > > -#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > > > > -
> > > > >  static int libbpf_perf_print(enum libbpf_print_level level __attribute__((unused)),
> > > > >                             const char *fmt, va_list args)
> > > > >  {
> > > > > @@ -49,6 +46,36 @@ struct bpf_prog_priv {
> > > > >       int *type_mapping;
> > > > >  };
> > > > >
> > > > > +struct bpf_perf_object {
> > > > > +     struct bpf_object *obj;
> > > > > +     struct list_head list;
> > > > > +};
> > > > > +
> > > > > +static LIST_HEAD(bpf_objects_list);
> > > >
> > > > hum, so this duplicates libbpf's bpf_objects_list,
> > > > how do objects get on this list?
> > >
> > > yep, this list needs to be updated on perf side each time
> > > bpf_object__open() (and any variant of open) is called.
> > >
> > > >
> > > > could you please put more comments in changelog
> > > > and share how you tested this?
> > >
> > > I actually have no idea how to test this as well, can you please share
> > > some ideas?
> > >
> >
> > I don't use it, I just know it's there.. that's why I asked ;-)
> >
> > it's possible to specify bpf program on the perf command line
> > to be attached to event, like:
> >
> >       # cat tools/perf/examples/bpf/hello.c
> >       #include <stdio.h>
> >
> >       int syscall_enter(openat)(void *args)
> >       {
> >               puts("Hello, world\n");
> >               return 0;
> >       }
> >
> >       license(GPL);
> >       #
> >       # perf trace -e openat,tools/perf/examples/bpf/hello.c cat /etc/passwd > /dev/null
> >          0.016 (         ): __bpf_stdout__:Hello, world
> >          0.018 ( 0.010 ms): cat/9079 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
> >          0.057 (         ): __bpf_stdout__:Hello, world
> >          0.059 ( 0.011 ms): cat/9079 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC) = 3
> >          0.417 (         ): __bpf_stdout__:Hello, world
> >          0.419 ( 0.009 ms): cat/9079 openat(dfd: CWD, filename: /etc/passwd) = 3
> >       #
> >
> > I took that example from commit message
[...]

I found the original commit aa3abf30bb28addcf593578d37447d42e3f65fc3
that included a test case, but I'm having trouble reproducing it due to syntax
error. I am running this on bpf-next master without my patches.

I ran 'perf test -v LLVM' and used it's output to generate a script for
compiling the perf test object:

--------------------------------------------------
$ cat ~/bin/hello-ebpf
INPUT_FILE=/tmp/test.c
OUTPUT_FILE=/tmp/test.o

export KBUILD_DIR=/lib/modules/5.12.0-0_fbk2_3390_g7ecb4ac46d7f/build
export NR_CPUS=56
export LINUX_VERSION_CODE=0x50c00
export CLANG_EXEC=/data/users/christylee/devtools/llvm/latest/bin/clang
export CLANG_OPTIONS=-xc
export KERNEL_INC_OPTIONS="-nostdinc -isystem
/data/users/christylee/devtools/gcc/10.3.0/lib/gcc/x86_64-pc-linux-gnu/10.3.0/include
-I./arch/\
x86/include -I./arch/x86/include/generated  -I./include
-I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi
-I./include/uapi -I./in\
clude/generated/uapi -include ./include/linux/compiler-version.h
-include ./include/linux/kconfig.h"
export PERF_BPF_INC_OPTIONS=-I/home/christylee/lib/perf/include/bpf
export WORKING_DIR=/lib/modules/5.12.0-0_fbk2_3390_g7ecb4ac46d7f/build
export CLANG_SOURCE=-

rm -f $OUTPUT_FILE
cat $INPUT_FILE |
/data/users/christylee/devtools/llvm/latest/bin/clang -D__KERNEL__
-D__NR_CPUS__=56 -DLINUX_VERSION_CODE=0x50c00 -xc  -I/ho\
me/christylee/lib/perf/include/bpf  -nostdinc -isystem
/data/users/christylee/devtools/gcc/10.3.0/lib/gcc/x86_64-pc-linux-gnu/10.3.0/include
\
-I./arch/x86/include -I./arch/x86/include/generated  -I./include
-I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi
-I./include/ua\
pi -I./include/generated/uapi -include
./include/linux/compiler-version.h -include ./include/linux/kconfig.h
-Wno-unused-value -Wno-pointer-\
sign -working-directory
/lib/modules/5.12.0-0_fbk2_3390_g7ecb4ac46d7f/build -c - -target bpf
-O2 -o $OUTPUT_FILE
--------------------------------------------------

I then wrote and compiled a script that ask to get asks to put a probe
at a function that
does not exists in the kernel, it errors out as expected:

$ cat /tmp/test.c
__attribute__((section("fork=does_not_exist"), used)) int fork(void *ctx) {
    return 0;
}

char _license[] __attribute__((section("license"), used)) = "GPL";
int _version __attribute__((section("version"), used)) = 0x40100;
$ cd ~/bin && ./hello-ebpf
$ perf record --event /tmp/test.o sleep 1
Using perf wrapper that supports hot-text. Try perf.real if you
encounter any issues.
Probe point 'does_not_exist' not found.
event syntax error: '/tmp/test.o'
                     \___ You need to check probing points in BPF file

(add -v to see detail)
Run 'perf list' for a list of valid events

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. use 'perf list' to list
available events

---------------------------------------------------

Next I changed the attribute to something that exists in the kernel.
As expected, it errors out
with permission problem:
$ cat /tmp/test.c
__attribute__((section("fork=fork_init"), used)) int fork(void *ctx) {
    return 0;
}
char _license[] __attribute__((section("license"), used)) = "GPL";
int _version __attribute__((section("version"), used)) = 0x40100;
$ grep fork_init /proc/kallsyms
ffffffff8146e250 T xfs_ifork_init_cow
ffffffff83980481 T fork_init
$ cd ~/bin && ./hello-ebpf
$ perf record --event /tmp/test.o sleep 1
Using perf wrapper that supports hot-text. Try perf.real if you
encounter any issues.
Failed to open kprobe_events: Permission denied
event syntax error: '/tmp/test.o'
                     \___ You need to be root

(add -v to see detail)
Run 'perf list' for a list of valid events

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. use 'perf list' to list
available events

---------------------------------------------------

So I reran as root, but this time I get an invalid syntax error:

# perf record --event /tmp/test.o -v sleep 1
Using perf wrapper that supports hot-text. Try perf.real if you
encounter any issues.
Failed to write event: Invalid argument
event syntax error: '/tmp/test.o'
                     \___ Invalid argument

(add -v to see detail)
Run 'perf list' for a list of valid events

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. use 'perf list' to list
available events
---------------------------------------------------

Is there a different way to attach a custom event probe point?
