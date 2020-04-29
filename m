Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922C31BD336
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 05:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgD2Dqa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 23:46:30 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30768 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgD2Dq3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 23:46:29 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03T3jXlb020748;
        Wed, 29 Apr 2020 12:45:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03T3jXlb020748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588131934;
        bh=J6Zz8rPIoOP2RxWt1vp9BH2krOQ6QyL5foLOOnRDXGA=;
        h=From:To:Cc:Subject:Date:From;
        b=pbkwY9WIC8+qobyGRxbFLVTBQ7BdgZozw2VehlZt7+zw8M8UXRU5aKB1CbWy/m3K+
         MueYuxb7MeDn8sfuFahj87Q1AMOOVEYvEyID7nMy9LSeX8vUUR5hOzdEAzzKnr1uhr
         Va0ZMDmxia4Vkz+1qgdJezKuKUvi//YRkyOq9+law7mDS06wBUwZq8wlORrwaQK7jw
         gwhn2EKot/y7cufNgyJWnrpsqWacaw1GtPiuoKbbIbnaHoQWKRfxiMNt4YO2ruJoZo
         Url7EVqPdTiP/ineyFRQlkmQknf6ldkBl2oQUEiYYY5z31WNziwF2KUBScHxEgsfBC
         du447ALrsma5w==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 00/15] kbuild: support 'userprogs' syntax
Date:   Wed, 29 Apr 2020 12:45:12 +0900
Message-Id: <20200429034527.590520-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Several Makefiles use 'hostprogs' to build programs for the host
architecture where it is not appropriate to do so.
This is just because Kbuild lacks the support for building programs
for the target architecture.

This series introduce 'userprogs' syntax and use it from
sample and bpf Makefiles.

Sam worked on this in 2014.
https://lkml.org/lkml/2014/7/13/154

He used 'uapiprogs-y' but I just thought the meaning of
"UAPI programs" is unclear.

Naming the syntax is one of the most difficult parts.

I chose 'userprogs'. Anothor choice I had in my mind was 'targetprogs'.

You can test this series quickly by 'make allmodconfig samples/'

When building objects for userspace, [U] is displayed.

masahiro@oscar:~/workspace/linux$ make allmodconfig samples/
  [snip]
  AR      samples/vfio-mdev/built-in.a
  CC [M]  samples/vfio-mdev/mtty.o
  CC [M]  samples/vfio-mdev/mdpy.o
  CC [M]  samples/vfio-mdev/mdpy-fb.o
  CC [M]  samples/vfio-mdev/mbochs.o
  AR      samples/mei/built-in.a
  CC [U]  samples/mei/mei-amt-version
  CC [U]  samples/auxdisplay/cfag12864b-example
  CC [M]  samples/configfs/configfs_sample.o
  CC [M]  samples/connector/cn_test.o
  CC [U]  samples/connector/ucon
  CC [M]  samples/ftrace/ftrace-direct.o
  CC [M]  samples/ftrace/ftrace-direct-too.o
  CC [M]  samples/ftrace/ftrace-direct-modify.o
  CC [M]  samples/ftrace/sample-trace-array.o
  CC [U]  samples/hidraw/hid-example
  CC [M]  samples/hw_breakpoint/data_breakpoint.o
  CC [M]  samples/kdb/kdb_hello.o
  CC [M]  samples/kfifo/bytestream-example.o
  CC [M]  samples/kfifo/dma-example.o
  CC [M]  samples/kfifo/inttype-example.o
  CC [M]  samples/kfifo/record-example.o
  CC [M]  samples/kobject/kobject-example.o
  CC [M]  samples/kobject/kset-example.o
  CC [M]  samples/kprobes/kprobe_example.o
  CC [M]  samples/kprobes/kretprobe_example.o
  CC [M]  samples/livepatch/livepatch-sample.o
  CC [M]  samples/livepatch/livepatch-shadow-mod.o
  CC [M]  samples/livepatch/livepatch-shadow-fix1.o
  CC [M]  samples/livepatch/livepatch-shadow-fix2.o
  CC [M]  samples/livepatch/livepatch-callbacks-demo.o
  CC [M]  samples/livepatch/livepatch-callbacks-mod.o
  CC [M]  samples/livepatch/livepatch-callbacks-busymod.o
  CC [M]  samples/rpmsg/rpmsg_client_sample.o
  CC [U]  samples/seccomp/bpf-fancy.o
  CC [U]  samples/seccomp/bpf-helper.o
  LD [U]  samples/seccomp/bpf-fancy
  CC [U]  samples/seccomp/dropper
  CC [U]  samples/seccomp/bpf-direct
  CC [U]  samples/seccomp/user-trap
  CC [U]  samples/timers/hpet_example
  CC [M]  samples/trace_events/trace-events-sample.o
  CC [M]  samples/trace_printk/trace-printk.o
  CC [U]  samples/uhid/uhid-example
  CC [M]  samples/v4l/v4l2-pci-skeleton.o
  CC [U]  samples/vfs/test-fsmount
  CC [U]  samples/vfs/test-statx
samples/vfs/test-statx.c:24:15: warning: ‘struct foo’ declared inside parameter list will not be visible outside of this definition or declaration
   24 | #define statx foo
      |               ^~~
  CC [U]  samples/watchdog/watchdog-simple
  AR      samples/built-in.a

Changes for v2:
  - Fix ARCH=i386 build error for bpfilter_umh
  - Rename 'user-ccflags' to 'userccflags'
    because 'user-ccflags' would conflict if an object
    called 'user.o' exists in the directory.
  - Support 'userldflags'

Masahiro Yamada (14):
  bpfilter: match bit size of bpfilter_umh to that of the kernel
  kbuild: add infrastructure to build userspace programs
  bpfilter: use 'userprogs' syntax to build bpfilter_umh
  samples: seccomp: build sample programs for target architecture
  kbuild: doc: document the new syntax 'userprogs'
  samples: uhid: build sample program for target architecture
  samples: hidraw: build sample program for target architecture
  samples: connector: build sample program for target architecture
  samples: vfs: build sample programs for target architecture
  samples: pidfd: build sample program for target architecture
  samples: mei: build sample program for target architecture
  samples: auxdisplay: use 'userprogs' syntax
  samples: timers: use 'userprogs' syntax
  samples: watchdog: use 'userprogs' syntax

Sam Ravnborg (1):
  samples: uhid: fix warnings in uhid-example

 Documentation/kbuild/makefiles.rst | 183 +++++++++++++++++++++--------
 Makefile                           |  13 +-
 init/Kconfig                       |   4 +-
 net/bpfilter/Makefile              |  11 +-
 samples/Kconfig                    |  26 +++-
 samples/Makefile                   |   4 +
 samples/auxdisplay/Makefile        |  11 +-
 samples/connector/Makefile         |  12 +-
 samples/hidraw/Makefile            |   9 +-
 samples/mei/Makefile               |   9 +-
 samples/pidfd/Makefile             |   8 +-
 samples/seccomp/Makefile           |  42 +------
 samples/timers/Makefile            |  17 +--
 samples/uhid/.gitignore            |   2 +
 samples/uhid/Makefile              |   9 +-
 samples/uhid/uhid-example.c        |   4 +-
 samples/vfs/Makefile               |  11 +-
 samples/watchdog/Makefile          |  10 +-
 scripts/Makefile.build             |   6 +
 scripts/Makefile.clean             |   2 +-
 scripts/Makefile.userprogs         |  45 +++++++
 usr/include/Makefile               |   4 +
 22 files changed, 267 insertions(+), 175 deletions(-)
 create mode 100644 samples/uhid/.gitignore
 create mode 100644 scripts/Makefile.userprogs

-- 
2.25.1

