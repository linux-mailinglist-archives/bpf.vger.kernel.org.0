Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2774458E9
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 18:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhKDRuC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 13:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhKDRuC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 13:50:02 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC68CC061714;
        Thu,  4 Nov 2021 10:47:23 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id o12so16383697ybk.1;
        Thu, 04 Nov 2021 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EnloO58hBnVw7b0fHzcjnyEvTAEh2MgNxjIqozqohqE=;
        b=Zkkp8BEQkhBaksVN4tZcXVGOzR09Aj7T5Tw93NgEJzvCO2WTZr1+APBsEbMdWdztY7
         Z/Y5MAFZOEDZWf3A3261WqMfRY102pLc4/x+lEXXhOxtBOpzfTj974ZAjPpLzd0Qe+2W
         eHbyvCCVabwX4jbt/T2WP6VMtlmJceyXZeQnbzJOgQyamXICO4EZcoP/QZRL/ehELM7t
         E8JQNuxuwUli2N6JDd34y7OU0FZePJnKQKR4ycciyRQ5T3rgO8QZpcR7Z2dQt5JlGKI/
         V/vGs+BZwNjSgefYxG5z43aBhKLZZlOHQ2hPLgZRzbRES9MK53pc2Hl9arvbQnobonHh
         rVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EnloO58hBnVw7b0fHzcjnyEvTAEh2MgNxjIqozqohqE=;
        b=WbjGn0lrLlg7Y92YLFlPnA5YqjhDSFULMMi2KeUwTh+p1r8qrhr2M2H0aRqQL9g/s7
         1NpzWwBlP4GPDMqQkcE87+bFZqXcCQjBzG8BeHOSd8NRTddFhau2MzeqPHjLwbvc0y1R
         l5fCu08eTQXwp/qhd57EvL4WGK5sCdklgUQ7dH2RTdxI9g+Q94wln8d2va0YFBEnmvos
         43XGg9N1fntN87MOJ3E+Lch4kBpF0C4kOGs2ocPveRuqqv+YH05ZB+y/EGedbsf8vXxB
         M6ZuyYjOFHMCYe92goG+cwl1qMcWXppFQs3p2gsdt86ErPFPEHbSO+I9e/L3kvaUnoTR
         wF2A==
X-Gm-Message-State: AOAM5334wC82wh4CJtyl3Rz0IutwnxV+Gp+N/ugDuW7hclVfZJZb4bjb
        xoJ3x14ffQunNyCGFng4DoZZEzM7OQfWIfeb2yI=
X-Google-Smtp-Source: ABdhPJz/pi1IN+P/M+j20x2q0rFDMs3igugLLJAT+WeKpaW/EuhBfTM42uyOBD8EBjyMWf57a6eIg8chAGQ6yfyC6rY=
X-Received: by 2002:a25:d187:: with SMTP id i129mr45116599ybg.2.1636048043146;
 Thu, 04 Nov 2021 10:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <YYQadWbtdZ9Ff9N4@kernel.org>
In-Reply-To: <YYQadWbtdZ9Ff9N4@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 Nov 2021 10:47:12 -0700
Message-ID: <CAEf4Bzaj4_hXDxk18aJvk2bxJ-rPb++DpPVEeUw0pN-tJuiy0Q@mail.gmail.com>
Subject: Re: perf build broken looking for bpf/{libbpf,bpf}.h after merge with upstream
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 4, 2021 at 10:38 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
> Hi Song,
>

cc Quentin as well, might be related to recent Makefiles revamp for
users of libbpf. But in bpf-next perf builds perfectly fine, so not
sure.

>         I just did a merge with upstream and I'm getting this:
>
>   LINK    /tmp/build/perf/plugins/plugin_scsi.so
>   INSTALL trace_plugins
>
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
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp//libbpf//include/bpf/hashmap=
.h
>   INSTALL /tmp/build/perf/util/bpf_skel/.tmp//libbpf//include/bpf/nlattr.=
h
>   GEN     /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/bpf_helper=
_defs.h
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/libbpf.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/libbpf_probes.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/xsk.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/bpf.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/nlattr.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/btf.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/libbpf_errno.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/hashmap.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/str_error.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/netlink.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/btf_dump.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/bpf_prog_linfo.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/ringbuf.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/strset.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/linker.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/gen_loader.o
>   CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/relo_core.o
>   LD      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/libbpf-in.o
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
> make[3]: *** [Makefile:213: /tmp/build/perf/util/bpf_skel/.tmp//bootstrap=
/gen.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> xlated_dumper.c:10:10: fatal error: bpf/libbpf.h: No such file or directo=
ry
>    10 | #include <bpf/libbpf.h>
>       |          ^~~~~~~~~~~~~~
> compilation terminated.
> btf.c:15:10: fatal error: bpf/bpf.h: No such file or directory
>    15 | #include <bpf/bpf.h>
>       |          ^~~~~~~~~~~
> compilation terminated.
> make[3]: *** [Makefile:213: /tmp/build/perf/util/bpf_skel/.tmp//bootstrap=
/xlated_dumper.o] Error 1
> make[3]: *** [Makefile:213: /tmp/build/perf/util/bpf_skel/.tmp//bootstrap=
/btf.o] Error 1
> main.c:12:10: fatal error: bpf/bpf.h: No such file or directory
>    12 | #include <bpf/bpf.h>
>       |          ^~~~~~~~~~~
> compilation terminated.
> make[3]: *** [Makefile:213: /tmp/build/perf/util/bpf_skel/.tmp//bootstrap=
/main.o] Error 1
> btf_dumper.c:12:10: fatal error: bpf/btf.h: No such file or directory
>    12 | #include <bpf/btf.h>
>       |          ^~~~~~~~~~~
> compilation terminated.
> make[3]: *** [Makefile:213: /tmp/build/perf/util/bpf_skel/.tmp//bootstrap=
/btf_dumper.o] Error 1
> common.c:24:10: fatal error: bpf/bpf.h: No such file or directory
>    24 | #include <bpf/bpf.h>
>       |          ^~~~~~~~~~~
> compilation terminated.
> make[3]: *** [Makefile:213: /tmp/build/perf/util/bpf_skel/.tmp//bootstrap=
/common.o] Error 1
> make[2]: *** [Makefile.perf:1048: /tmp/build/perf/util/bpf_skel/.tmp/boot=
strap/bpftool] Error 2
> make[1]: *** [Makefile.perf:240: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/var/home/acme/git/perf/tools/perf'
>
>  Performance counter stats for 'make -k BUILD_BPF_SKEL=3D1 CORESIGHT=3D1 =
PYTHON=3Dpython3 O=3D/tmp/build/perf -C tools/perf install-bin':
>
>           6,965.78 msec task-clock:u              #    1.492 CPUs utilize=
d
>           6,937.93 msec cpu-clock:u               #    1.486 CPUs utilize=
d
>
>        4.669198336 seconds time elapsed
>
>        4.015978000 seconds user
>        3.202660000 seconds sys
>
>
> 70: Event expansion for cgroups                                     : Ok
> 88: perf all metricgroups test                                      : FAI=
LED!
> =E2=AC=A2[acme@toolbox perf]$ find tools/ -name bpf.h
> tools/include/uapi/linux/bpf.h
> tools/lib/bpf/bpf.h
> tools/perf/include/bpf/bpf.h
> =E2=AC=A2[acme@toolbox perf]$ find tools/ -name libbpf.h
> tools/lib/bpf/libbpf.h
> =E2=AC=A2[acme@toolbox perf]$ find tools/perf/ -name gen.c
> =E2=AC=A2[acme@toolbox perf]$
>
> Before the merge, with pristine sources I wasn't getting this,
> investigating now.
>
> =E2=AC=A2[acme@toolbox perf]$ git show HEAD
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
> =E2=AC=A2[acme@toolbox perf]$
>
> =E2=AC=A2[acme@toolbox perf]$ git log --oneline -10 torvalds/master
> abfecb39092029c4 (torvalds/master) Merge tag 'tty-5.16-rc1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> 95faf6ba654dd334 Merge tag 'driver-core-5.16-rc1' of git://git.kernel.org=
/pub/scm/linux/kernel/git/gregkh/driver-core
> 5c904c66ed4e86c3 Merge tag 'char-misc-5.16-rc1' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/gregkh/char-misc
> 5cd4dc44b8a0f656 Merge tag 'staging-5.16-rc1' of git://git.kernel.org/pub=
/scm/linux/kernel/git/gregkh/staging
> 048ff8629e117d84 Merge tag 'usb-5.16-rc1' of git://git.kernel.org/pub/scm=
/linux/kernel/git/gregkh/usb
> 7ddb58cb0ecae8e8 Merge tag 'clk-for-linus' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/clk/linux
> ce840177930f591a Merge tag 'defconfig-5.16' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/soc/soc
> d461e96cd22b5aeb Merge tag 'drivers-5.16' of git://git.kernel.org/pub/scm=
/linux/kernel/git/soc/soc
> ae45d84fc36d01dc Merge tag 'dt-5.16' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/soc/soc
> 2219b0ceefe835b9 Merge tag 'soc-5.16' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/soc/soc
> =E2=AC=A2[acme@toolbox perf]$
>
> - Arnaldo
