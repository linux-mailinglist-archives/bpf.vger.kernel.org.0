Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6553A4458EF
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 18:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhKDRwL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 13:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230100AbhKDRwK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 13:52:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AE57611C0;
        Thu,  4 Nov 2021 17:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636048172;
        bh=RjP7KPbcBAtwjv++cnW88FYxOBwhOK2DM2RigxMIas8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dEumvIsK5hJHhZFcRPJjw63NP0VENz3qhhTFMnFFYHmUo6xmtTOZR6fFLzJo9Pipb
         afBE/MhYECRdP1Q3pQjZlnBdx/K06J7DELoj6ZMzcDpW9/yDArTnQDvpfOgQWb7F7G
         GThebOfFEOYeJ2RGKVCceUktOuqkjtCd9vn5ZeoKqwGTa9cUUuMIev2GlXNwWuv8kS
         +mJoauPJXQgh6DIKyJWpoiLSPSrXwm4V/arNqHNilZckaqeK/2xovQWgZY9QWfnYcT
         tEWpQGItcaHkN0D7IteoOJUEJwY04HVd1iIThNJidpD0rTu3T8KLjIBMTPdf3jvSvX
         6ehPXie57BeVA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2C558410A1; Thu,  4 Nov 2021 14:49:30 -0300 (-03)
Date:   Thu, 4 Nov 2021 14:49:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf build broken looking for bpf/{libbpf,bpf}.h after merge
 with upstream
Message-ID: <YYQdKijyt20cBQik@kernel.org>
References: <YYQadWbtdZ9Ff9N4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYQadWbtdZ9Ff9N4@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Nov 04, 2021 at 02:37:57PM -0300, Arnaldo Carvalho de Melo escreveu:
> 
> Hi Song,
> 
> 	I just did a merge with upstream and I'm getting this:
> 
>   LINK    /tmp/build/perf/plugins/plugin_scsi.so
>   INSTALL trace_plugins

To clarify, the command line to build perf that results in this problem
is:

  make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin
 
> Auto-detecting system features:
> ...                        libbfd: [ on  ]
> ...        disassembler-four-args: [ on  ]
> ...                          zlib: [ on  ]
> ...                        libcap: [ on  ]
> ...               clang-bpf-co-re: [ on  ]
> 
> 
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//libbpf//include/bpf
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp//libbpf//include/bpf/hashmap.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp//libbpf//include/bpf/nlattr.h
>   GEN     /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/bpf_helper_defs.h
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf_probes.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/xsk.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/bpf.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/nlattr.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/btf.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf_errno.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/hashmap.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/str_error.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/netlink.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/btf_dump.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/ringbuf.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/strset.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/linker.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/gen_loader.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/relo_core.o
>   LD      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf-in.o
>   LINK    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/libbpf.a
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/main.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/common.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/gen.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/json_writer.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/btf.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/xlated_dumper.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/btf_dumper.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/disasm.o
> gen.c:15:10: fatal error: bpf/bpf.h: No such file or directory
>    15 | #include <bpf/bpf.h>
>       |          ^~~~~~~~~~~
> compilation terminated.
> make[3]: *** [Makefile:213: /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/gen.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> xlated_dumper.c:10:10: fatal error: bpf/libbpf.h: No such file or directory
>    10 | #include <bpf/libbpf.h>
>       |          ^~~~~~~~~~~~~~
> compilation terminated.
> btf.c:15:10: fatal error: bpf/bpf.h: No such file or directory
>    15 | #include <bpf/bpf.h>
>       |          ^~~~~~~~~~~
> compilation terminated.
> make[3]: *** [Makefile:213: /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/xlated_dumper.o] Error 1
> make[3]: *** [Makefile:213: /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/btf.o] Error 1
> main.c:12:10: fatal error: bpf/bpf.h: No such file or directory
>    12 | #include <bpf/bpf.h>
>       |          ^~~~~~~~~~~
> compilation terminated.
> make[3]: *** [Makefile:213: /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/main.o] Error 1
> btf_dumper.c:12:10: fatal error: bpf/btf.h: No such file or directory
>    12 | #include <bpf/btf.h>
>       |          ^~~~~~~~~~~
> compilation terminated.
> make[3]: *** [Makefile:213: /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/btf_dumper.o] Error 1
> common.c:24:10: fatal error: bpf/bpf.h: No such file or directory
>    24 | #include <bpf/bpf.h>
>       |          ^~~~~~~~~~~
> compilation terminated.
> make[3]: *** [Makefile:213: /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/common.o] Error 1
> make[2]: *** [Makefile.perf:1048: /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/bpftool] Error 2
> make[1]: *** [Makefile.perf:240: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/var/home/acme/git/perf/tools/perf'
> 
>  Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin':
> 
>           6,965.78 msec task-clock:u              #    1.492 CPUs utilized
>           6,937.93 msec cpu-clock:u               #    1.486 CPUs utilized
> 
>        4.669198336 seconds time elapsed
> 
>        4.015978000 seconds user
>        3.202660000 seconds sys
> 
> 
> 70: Event expansion for cgroups                                     : Ok
> 88: perf all metricgroups test                                      : FAILED!
> ⬢[acme@toolbox perf]$ find tools/ -name bpf.h
> tools/include/uapi/linux/bpf.h
> tools/lib/bpf/bpf.h
> tools/perf/include/bpf/bpf.h
> ⬢[acme@toolbox perf]$ find tools/ -name libbpf.h
> tools/lib/bpf/libbpf.h
> ⬢[acme@toolbox perf]$ find tools/perf/ -name gen.c
> ⬢[acme@toolbox perf]$
> 
> Before the merge, with pristine sources I wasn't getting this,
> investigating now.
> 
> ⬢[acme@toolbox perf]$ git show HEAD
> commit e1498f18537a1639963370a4635c6fb99e7d672b (HEAD -> perf/core)
> Merge: 32f7aa2731b24ad8 abfecb39092029c4
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Thu Nov 4 14:32:11 2021 -0300
> 
>     Merge remote-tracking branch 'torvalds/master' into perf/core
> 
>     To pick up some tools/perf/ patches that went via tip/perf/core, such
>     as:
> 
>       tools/perf: Add mem_hops field in perf_mem_data_src structure
> 
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ⬢[acme@toolbox perf]$
> 
> ⬢[acme@toolbox perf]$ git log --oneline -10 torvalds/master
> abfecb39092029c4 (torvalds/master) Merge tag 'tty-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> 95faf6ba654dd334 Merge tag 'driver-core-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> 5c904c66ed4e86c3 Merge tag 'char-misc-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
> 5cd4dc44b8a0f656 Merge tag 'staging-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> 048ff8629e117d84 Merge tag 'usb-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> 7ddb58cb0ecae8e8 Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> ce840177930f591a Merge tag 'defconfig-5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> d461e96cd22b5aeb Merge tag 'drivers-5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> ae45d84fc36d01dc Merge tag 'dt-5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> 2219b0ceefe835b9 Merge tag 'soc-5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> ⬢[acme@toolbox perf]$
> 
> - Arnaldo

-- 

- Arnaldo
