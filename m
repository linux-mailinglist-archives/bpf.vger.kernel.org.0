Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5291CEC1A
	for <lists+bpf@lfdr.de>; Tue, 12 May 2020 06:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgELEfc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 May 2020 00:35:32 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:51674 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgELEfb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 May 2020 00:35:31 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 04C4ZD5O021118;
        Tue, 12 May 2020 13:35:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 04C4ZD5O021118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589258114;
        bh=Zc/JMr1NeOPCLi6khUpFKWNc1X+NiHrIEKTM+sXYRac=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OzCtvM8GvN+ZCB9+p3csGiC6IRilbuwymmBCLGcc76Cz9/37L/J3fiKkMNf/lA1tn
         4sxxOLBqlaN0Q4IQhWZ3ekzi1Cz7UipBjcIeUVkanSFKbO9lyX05G+/YvHWFYqiYEI
         nAsSzQiC9Dcmy/X+0Z/qTKUXzukEWFMe67ryY/cCRQqh3MMM+/BqES6MfxcEilKSyv
         PmBsdZHMjZEaivKIkq9Pa1kUCdTXX6ZEtEnHv6D4yvVxAidPYEK51bwzKnl+pwWQ5u
         IFsgNrK4pEr0gCeOvhaa2pXQIrHaNcJXcVwewWqhNtyfhObovt+l3WD5BSp2g9jg6B
         DOkjcGfdU1TIg==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id x6so7089776vso.1;
        Mon, 11 May 2020 21:35:13 -0700 (PDT)
X-Gm-Message-State: AOAM531+2VMzlg1Mg5BeOo3JNWwuWSw1sMPrDNs2DyRUQMUqIqDn3ZAW
        1Q2pTBKnwlG7Czl8GbDOcKqeWY8C67L5mmp55/o=
X-Google-Smtp-Source: ABdhPJzKWYsZN47HnqDzmmUsGpoQoaAnvDbEWKFaax9wl0EddbtvC43Ot+KrnCM2s9Iw0hZhFzjDeZ37oYgKRcHZHFo=
X-Received: by 2002:a67:d00e:: with SMTP id r14mr3327265vsi.215.1589258112774;
 Mon, 11 May 2020 21:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200429034527.590520-1-masahiroy@kernel.org>
In-Reply-To: <20200429034527.590520-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 12 May 2020 13:34:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNARgFip=ywrLdF8Z5uznQBmYTZfxn5PHR9jSnYEJDxYc_w@mail.gmail.com>
Message-ID: <CAK7LNARgFip=ywrLdF8Z5uznQBmYTZfxn5PHR9jSnYEJDxYc_w@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] kbuild: support 'userprogs' syntax
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 29, 2020 at 12:45 PM Masahiro Yamada <masahiroy@kernel.org> wro=
te:
>
>
> Several Makefiles use 'hostprogs' to build programs for the host
> architecture where it is not appropriate to do so.
> This is just because Kbuild lacks the support for building programs
> for the target architecture.
>
> This series introduce 'userprogs' syntax and use it from
> sample and bpf Makefiles.
>
> Sam worked on this in 2014.
> https://lkml.org/lkml/2014/7/13/154
>
> He used 'uapiprogs-y' but I just thought the meaning of
> "UAPI programs" is unclear.
>
> Naming the syntax is one of the most difficult parts.
>
> I chose 'userprogs'. Anothor choice I had in my mind was 'targetprogs'.
>
> You can test this series quickly by 'make allmodconfig samples/'
>
> When building objects for userspace, [U] is displayed.
>
> masahiro@oscar:~/workspace/linux$ make allmodconfig samples/


All applied to linux-kbuild.


>   [snip]
>   AR      samples/vfio-mdev/built-in.a
>   CC [M]  samples/vfio-mdev/mtty.o
>   CC [M]  samples/vfio-mdev/mdpy.o
>   CC [M]  samples/vfio-mdev/mdpy-fb.o
>   CC [M]  samples/vfio-mdev/mbochs.o
>   AR      samples/mei/built-in.a
>   CC [U]  samples/mei/mei-amt-version
>   CC [U]  samples/auxdisplay/cfag12864b-example
>   CC [M]  samples/configfs/configfs_sample.o
>   CC [M]  samples/connector/cn_test.o
>   CC [U]  samples/connector/ucon
>   CC [M]  samples/ftrace/ftrace-direct.o
>   CC [M]  samples/ftrace/ftrace-direct-too.o
>   CC [M]  samples/ftrace/ftrace-direct-modify.o
>   CC [M]  samples/ftrace/sample-trace-array.o
>   CC [U]  samples/hidraw/hid-example
>   CC [M]  samples/hw_breakpoint/data_breakpoint.o
>   CC [M]  samples/kdb/kdb_hello.o
>   CC [M]  samples/kfifo/bytestream-example.o
>   CC [M]  samples/kfifo/dma-example.o
>   CC [M]  samples/kfifo/inttype-example.o
>   CC [M]  samples/kfifo/record-example.o
>   CC [M]  samples/kobject/kobject-example.o
>   CC [M]  samples/kobject/kset-example.o
>   CC [M]  samples/kprobes/kprobe_example.o
>   CC [M]  samples/kprobes/kretprobe_example.o
>   CC [M]  samples/livepatch/livepatch-sample.o
>   CC [M]  samples/livepatch/livepatch-shadow-mod.o
>   CC [M]  samples/livepatch/livepatch-shadow-fix1.o
>   CC [M]  samples/livepatch/livepatch-shadow-fix2.o
>   CC [M]  samples/livepatch/livepatch-callbacks-demo.o
>   CC [M]  samples/livepatch/livepatch-callbacks-mod.o
>   CC [M]  samples/livepatch/livepatch-callbacks-busymod.o
>   CC [M]  samples/rpmsg/rpmsg_client_sample.o
>   CC [U]  samples/seccomp/bpf-fancy.o
>   CC [U]  samples/seccomp/bpf-helper.o
>   LD [U]  samples/seccomp/bpf-fancy
>   CC [U]  samples/seccomp/dropper
>   CC [U]  samples/seccomp/bpf-direct
>   CC [U]  samples/seccomp/user-trap
>   CC [U]  samples/timers/hpet_example
>   CC [M]  samples/trace_events/trace-events-sample.o
>   CC [M]  samples/trace_printk/trace-printk.o
>   CC [U]  samples/uhid/uhid-example
>   CC [M]  samples/v4l/v4l2-pci-skeleton.o
>   CC [U]  samples/vfs/test-fsmount
>   CC [U]  samples/vfs/test-statx
> samples/vfs/test-statx.c:24:15: warning: =E2=80=98struct foo=E2=80=99 dec=
lared inside parameter list will not be visible outside of this definition =
or declaration
>    24 | #define statx foo
>       |               ^~~
>   CC [U]  samples/watchdog/watchdog-simple
>   AR      samples/built-in.a
>
> Changes for v2:
>   - Fix ARCH=3Di386 build error for bpfilter_umh
>   - Rename 'user-ccflags' to 'userccflags'
>     because 'user-ccflags' would conflict if an object
>     called 'user.o' exists in the directory.
>   - Support 'userldflags'
>
> Masahiro Yamada (14):
>   bpfilter: match bit size of bpfilter_umh to that of the kernel
>   kbuild: add infrastructure to build userspace programs
>   bpfilter: use 'userprogs' syntax to build bpfilter_umh
>   samples: seccomp: build sample programs for target architecture
>   kbuild: doc: document the new syntax 'userprogs'
>   samples: uhid: build sample program for target architecture
>   samples: hidraw: build sample program for target architecture
>   samples: connector: build sample program for target architecture
>   samples: vfs: build sample programs for target architecture
>   samples: pidfd: build sample program for target architecture
>   samples: mei: build sample program for target architecture
>   samples: auxdisplay: use 'userprogs' syntax
>   samples: timers: use 'userprogs' syntax
>   samples: watchdog: use 'userprogs' syntax
>
> Sam Ravnborg (1):
>   samples: uhid: fix warnings in uhid-example
>
>  Documentation/kbuild/makefiles.rst | 183 +++++++++++++++++++++--------
>  Makefile                           |  13 +-
>  init/Kconfig                       |   4 +-
>  net/bpfilter/Makefile              |  11 +-
>  samples/Kconfig                    |  26 +++-
>  samples/Makefile                   |   4 +
>  samples/auxdisplay/Makefile        |  11 +-
>  samples/connector/Makefile         |  12 +-
>  samples/hidraw/Makefile            |   9 +-
>  samples/mei/Makefile               |   9 +-
>  samples/pidfd/Makefile             |   8 +-
>  samples/seccomp/Makefile           |  42 +------
>  samples/timers/Makefile            |  17 +--
>  samples/uhid/.gitignore            |   2 +
>  samples/uhid/Makefile              |   9 +-
>  samples/uhid/uhid-example.c        |   4 +-
>  samples/vfs/Makefile               |  11 +-
>  samples/watchdog/Makefile          |  10 +-
>  scripts/Makefile.build             |   6 +
>  scripts/Makefile.clean             |   2 +-
>  scripts/Makefile.userprogs         |  45 +++++++
>  usr/include/Makefile               |   4 +
>  22 files changed, 267 insertions(+), 175 deletions(-)
>  create mode 100644 samples/uhid/.gitignore
>  create mode 100644 scripts/Makefile.userprogs
>
> --
> 2.25.1
>


--=20
Best Regards
Masahiro Yamada
