Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E6D62A416
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 22:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiKOV27 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 16:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiKOV2t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 16:28:49 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D61C0C
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 13:28:47 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bs21so26592074wrb.4
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 13:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+PgiIofeiO7mggN8M8Es7YtkIns3NfdA2xeFDYLNzow=;
        b=hM9o4ZVb2rRwuUvmmVXgNJJ9k9LaTutYwMXp/FO3BMHVzs8gRRPfnfm5hUrmZ469Wm
         OYX5cQrdLlzjprrOeOnMu2W31SEa1qrfMAvDbTb62rS4WqjvbYdCjs6ksAt0ViJ/rSqP
         Q/ur7/jzz39580pDXxlDgSc3z335JmPt7M3WX8EEykr+/175YGnxV6awA4VCIrMQqL4c
         YPdGSR1IvSG76fbH27sZW1rE6HthC1Vl2MT4XrOxFi69PP+pLf76+l+S7mRkfk66ztMm
         F/vxmEGR1a8BZAE53eEpJO8BP8+3s1+fpgl5NzhjJ3FfW0UeHIZkz7Sn8M6yzj7xKUD8
         AV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PgiIofeiO7mggN8M8Es7YtkIns3NfdA2xeFDYLNzow=;
        b=Q+9jN2QorK48v8OB/rZ+BooCY+9m+gqnTKZ0LaL09WDBK9CQV5xCoel2+HaFSRr38D
         0W4Venw3pRaXRLRQJjomGWwkOfAKQrqQkdysBiVrnQvaJaZeKiIo4LmlZevmfZOh4Cmd
         PGPXRUdj/iC4SumK88NJhTpJPXXh7CqQWItouonXOKx0tsbP4TKQJvVaadBSEg1bNeg7
         7kJ/P/T2KisVrxpsmwxKOkkU4LJMOIdrdGb9XFnmroVxnkTcMiXUzwznEIMXWcu3SsVV
         0EAki4uQbal1Jwx3pWIjFlqV6QLg2/gHIXJypMGlfybHJaMVSJLqSG7J73I1++pV6h5P
         5zJw==
X-Gm-Message-State: ANoB5pkMfzY8Y/shmuq+7oi0ibdir3LEc3aCEiGGzJXy6OIpG9KY04MJ
        8TqDuF0KbC5X0Z87u5A/hU/PqDhv/mVzR/U1VRLTmg==
X-Google-Smtp-Source: AA0mqf7/ybbL7Fm4aS6zCSaoRkv1jfJte6wj6XYfGQTNVKi2jcbzoS1GXJir7fal1xvWcrPDrnOZ9HhquljQEMxKb1s=
X-Received: by 2002:a5d:6e89:0:b0:228:dd1d:8a42 with SMTP id
 k9-20020a5d6e89000000b00228dd1d8a42mr12152504wrz.375.1668547725891; Tue, 15
 Nov 2022 13:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com> <Y2vG13WVahGoib57@kernel.org>
 <CAP-5=fXMEE6LAoBcV-UtRRhG3wvVtzBW4r5FGz06=qsE2U6jPw@mail.gmail.com>
 <CAP-5=fXECqhQpvMVdyzFpNixGwC+9BBo_Jj9nXEZ1hsDvjRd8Q@mail.gmail.com> <Y2vxD1fgyCdO8nIO@kernel.org>
In-Reply-To: <Y2vxD1fgyCdO8nIO@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Nov 2022 13:28:33 -0800
Message-ID: <CAP-5=fWL96JpGd0W+Q6cGWd_KQeNNv76w4qRcVBtGriMkQuxjQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/14] Fix perf tools/lib includes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: multipart/mixed; boundary="0000000000007ee45705ed890aef"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--0000000000007ee45705ed890aef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 9, 2022 at 10:27 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Nov 09, 2022 at 08:57:01AM -0800, Ian Rogers escreveu:
> > On Wed, Nov 9, 2022 at 8:52 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Wed, Nov 9, 2022 at 7:27 AM Arnaldo Carvalho de Melo <acme@kernel.=
org> wrote:
> > > >
> > > > Em Mon, Nov 07, 2022 at 11:35:04PM -0800, Ian Rogers escreveu:
> > > > > The previous build would add -Itools/lib and get dependencies for
> > > > > libtraceevent, libsubcmd, libsymbol, libapi and libbpf meaning th=
at
> > > > > overriding these libraries would change the link time dependency =
but
> > > > > the headers would erroneously come from tools/lib. Fix the build =
to
> > > > > install headers and then depend on these. To reduce exposing inte=
rnal
> > > > > headers/APIs some clean up is performed. tools/lib/symbol has a
> > > > > Makefile added, while tools/lib/api and tools/lib/subcmd have ins=
tall
> > > > > targets added. The pattern used for the dependencies in Makefile.=
perf
> > > > > is modelled on libbpf.
> > > >
> > > > It builds with O=3D, I tried it one by one, but  there are problems=
 with
> > > > make from a detached tarball, that is how I do the container builds=
, see
> > > > below, I'm trying to figure this out...
> > >
> > > Sorry, I didn't know to test this. The added Build and Makefile in
> > > libsymbol are missing, so I'd guess that's the major issue.
> > >
> > > Thanks,
> > > Ian
> >
> > The following fixes this for me:
>
> But then there are some other problems related to making sure those
> libraries are built and installed _before_ perf proper starts building
> when it expects to find the headers for those libraries.
>
> So perhaps we need to first run the 'install' target for those libraries
> before build perf proper?
>
> I'm pushing what I have to perf/tools-libs-includes branch.

Attached is the last patch with changes to the dependencies. Moving
the dependencies to prepare addresses the issue. I tested by adding
sleeps to the install_headers targets to make them slow.

Thanks,
Ian

> - Arnaldo
>
> > --- a/tools/perf/MANIFEST
> > +++ b/tools/perf/MANIFEST
> > @@ -13,8 +13,7 @@ tools/lib/ctype.c
> > tools/lib/hweight.c
> > tools/lib/rbtree.c
> > tools/lib/string.c
> > -tools/lib/symbol/kallsyms.c
> > -tools/lib/symbol/kallsyms.h
> > +tools/lib/symbol
> > tools/lib/find_bit.c
> > tools/lib/bitmap.c
> > tools/lib/list_sort.c
> >
> > Thanks,
> > Ian
> >
> > > > =E2=AC=A2[acme@toolbox perf]$ make perf-tar-src-pkg
> > > >   TAR
> > > >   PERF_VERSION =3D 6.1.rc3.g7e5d8b7a1fbd
> > > > =E2=AC=A2[acme@toolbox perf]$ mv perf-6.1.0-rc3.tar /tmp
> > > > =E2=AC=A2[acme@toolbox perf]$ cd /tmp
> > > > =E2=AC=A2[acme@toolbox tmp]$ tar xf perf-6.1.0-rc3.tar
> > > > =E2=AC=A2[acme@toolbox tmp]$ cd perf-6.1.0-rc3/
> > > > =E2=AC=A2[acme@toolbox perf-6.1.0-rc3]$ make -C tools/perf
> > > > make: Entering directory '/tmp/perf-6.1.0-rc3/tools/perf'
> > > >   BUILD:   Doing 'make -j32' parallel build
> > > >   HOSTCC  fixdep.o
> > > >   HOSTLD  fixdep-in.o
> > > >   LINK    fixdep
> > > >
> > > > Auto-detecting system features:
> > > > ...                                   dwarf: [ on  ]
> > > > ...                      dwarf_getlocations: [ on  ]
> > > > ...                                   glibc: [ on  ]
> > > > ...                                  libbfd: [ on  ]
> > > > ...                          libbfd-buildid: [ on  ]
> > > > ...                                  libcap: [ on  ]
> > > > ...                                  libelf: [ on  ]
> > > > ...                                 libnuma: [ on  ]
> > > > ...                  numa_num_possible_cpus: [ on  ]
> > > > ...                                 libperl: [ on  ]
> > > > ...                               libpython: [ on  ]
> > > > ...                               libcrypto: [ on  ]
> > > > ...                               libunwind: [ on  ]
> > > > ...                      libdw-dwarf-unwind: [ on  ]
> > > > ...                                    zlib: [ on  ]
> > > > ...                                    lzma: [ on  ]
> > > > ...                               get_cpuid: [ on  ]
> > > > ...                                     bpf: [ on  ]
> > > > ...                                  libaio: [ on  ]
> > > > ...                                 libzstd: [ on  ]
> > > >
> > > >   GEN     common-cmds.h
> > > >   PERF_VERSION =3D 6.1.rc3.g7e5d8b7a1fbd
> > > >   CC      perf-read-vdso32
> > > >   GEN     perf-archive
> > > >   GEN     perf-iostat
> > > >   CC      dlfilters/dlfilter-test-api-v0.o
> > > >   CC      dlfilters/dlfilter-show-cycles.o
> > > >   CC      jvmti/libjvmti.o
> > > > make[3]: *** No rule to make target '/tmp/perf-6.1.0-rc3/tools/perf=
/libsymbol/libsymbol.a'.  Stop.
> > > > make[2]: *** [Makefile.perf:907: /tmp/perf-6.1.0-rc3/tools/perf/lib=
symbol/libsymbol.a] Error 2
> > > > make[2]: *** Waiting for unfinished jobs....
> > > >   CC      jvmti/jvmti_agent.o
> > > >   CC      jvmti/libstring.o
> > > >   CC      jvmti/libctype.o
> > > >   GEN     pmu-events/pmu-events.c
> > > >   INSTALL headers
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/exec-cmd.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/help.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/pager.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/parse-options.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/run-command.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/sigchain.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/subcmd-config.o
> > > >   INSTALL headers
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/event-parse.=
o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_jbd2.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_hrtimer.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_kmem.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_kvm.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_mac80211.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_function.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_sched_switch.o
> > > >   INSTALL headers
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/core.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/cpu.o
> > > >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libapi/fd/
> > > >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/
> > > >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/
> > > >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fd/array.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/fs.o
> > > >   GEN     /tmp/perf-6.1.0-rc3/tools/perf/libbpf/bpf_helper_defs.h
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/tracing_path.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/cgroup.o
> > > >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf.h
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/debug.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_futex.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_xen.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_scsi.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_cfg80211.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_tlb.o
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_jbd2-in.o
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_hrtimer-in.o
> > > >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/libbpf.=
h
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_kmem-in.o
> > > >   INSTALL headers
> > > >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/btf.h
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_mac80211-in.o
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_sched_switch-in.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/cpumap.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/threadmap.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/str_error_r.o
> > > >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/libbpf_=
common.h
> > > >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_jbd2.so
> > > >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_hrtimer.so
> > > >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/libbpf_=
legacy.h
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_function-in.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/evsel.o
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_kvm-in.o
> > > >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_kmem.so
> > > >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_mac80211.so
> > > >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_sched_switch.so
> > > >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_hel=
pers.h
> > > >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_tra=
cing.h
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/event-plugin=
.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/evlist.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/mmap.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/trace-seq.o
> > > >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_end=
ian.h
> > > >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_cor=
e_read.h
> > > > if [ ! -d ''/tmp/perf-6.1.0-rc3/tools/perf/libapi'/include/api/fs' =
]; then install -d -m 755 ''/tmp/perf-6.1.0-rc3/tools/perf/libapi'/include/=
api/fs'; fi; install fs/tracing_path.h -m 644 ''/tmp/perf-6.1.0-rc3/tools/p=
erf/libapi'/include/api/fs';
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fd/libapi-in.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/zalloc.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/parse-filter=
.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/parse-utils.=
o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/kbuffer-pars=
e.o
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_xen-in.o
> > > >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/skel_in=
ternal.h
> > > >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/libbpf_=
version.h
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/tep_strerror=
.o
> > > >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/usdt.bp=
f.h
> > > >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_hel=
per_defs.h
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/event-parse-=
api.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/xyarray.o
> > > >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_function.so
> > > >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_xen.so
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_futex-in.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/lib.o
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_scsi-in.o
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_cfg80211-in.o
> > > >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
> > > >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
> > > >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
> > > >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
> > > >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_kvm.so
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/libbpf.o
> > > >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_futex.so
> > > >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_scsi.so
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/bpf.o
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/libapi-in.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/nlattr.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/btf.o
> > > >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_tlb-in.o
> > > >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_cfg80211.so
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/str_erro=
r.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/netlink.=
o
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libapi/libapi-in.o
> > > >   LD      jvmti/jvmti-in.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/libbpf_e=
rrno.o
> > > >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plug=
in_tlb.so
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/bpf_prog=
_linfo.o
> > > >   AR      /tmp/perf-6.1.0-rc3/tools/perf/libapi/libapi.a
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/libbpf_p=
robes.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/hashmap.=
o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/btf_dump=
.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/ringbuf.=
o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/strset.o
> > > >   GEN     /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/libt=
raceevent-dynamic-list
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/linker.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/gen_load=
er.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/relo_cor=
e.o
> > > >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/usdt.o
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/libsubcmd-in.o
> > > >   AR      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/libsubcmd.a
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libperf/libperf-in.o
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/libtraceeven=
t-in.o
> > > >   AR      /tmp/perf-6.1.0-rc3/tools/perf/libperf/libperf.a
> > > >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/libtraceeven=
t.a
> > > >   CC      pmu-events/pmu-events.o
> > > >   LD      pmu-events/pmu-events-in.o
> > > >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/libbpf-i=
n.o
> > > >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libbpf/libbpf.a
> > > > make[1]: *** [Makefile.perf:240: sub-make] Error 2
> > > > make: *** [Makefile:70: all] Error 2
> > > > make: Leaving directory '/tmp/perf-6.1.0-rc3/tools/perf'
> > > > =E2=AC=A2[acme@toolbox perf-6.1.0-rc3]$
> > > >
> > > >
> > > >
> > > > > The problem and solution were motivated by this issue and discuss=
ion:
> > > > > https://lore.kernel.org/lkml/CAEf4BzbbOHQZUAe6iWaehKCPQAf3VC=3Dhq=
657buqe2_yRKxaK-A@mail.gmail.com/
> > > > >
> > > > > Ian Rogers (14):
> > > > >   tools lib api: Add install target
> > > > >   tools lib subcmd: Add install target
> > > > >   perf build: Install libsubcmd locally when building
> > > > >   perf build: Install libapi locally when building
> > > > >   perf build: Install libperf locally when building
> > > > >   perf build: Install libtraceevent locally when building
> > > > >   tools lib api: Add missing install headers
> > > > >   tools lib perf: Add missing install headers
> > > > >   tool lib symbol: Add Makefile/Build
> > > > >   perf build: Install libsymbol locally when building
> > > > >   perf expr: Tidy hashmap dependency
> > > > >   perf thread_map: Reduce exposure of libperf internal API
> > > > >   perf cpumap: Tidy libperf includes
> > > > >   perf build: Use tools/lib headers from install path
> > > > >
> > > > >  tools/lib/api/Makefile                        |  52 ++++++
> > > > >  tools/lib/perf/Makefile                       |  10 +-
> > > > >  tools/lib/subcmd/Makefile                     |  49 ++++++
> > > > >  tools/lib/symbol/Build                        |   1 +
> > > > >  tools/lib/symbol/Makefile                     | 115 ++++++++++++=
+
> > > > >  tools/perf/.gitignore                         |   7 +-
> > > > >  tools/perf/Makefile.config                    |   2 -
> > > > >  tools/perf/Makefile.perf                      | 152 ++++++++++++=
------
> > > > >  tools/perf/builtin-stat.c                     |   1 +
> > > > >  tools/perf/builtin-trace.c                    |   4 +-
> > > > >  tools/perf/tests/cpumap.c                     |   2 +-
> > > > >  tools/perf/tests/expr.c                       |   1 +
> > > > >  tools/perf/tests/openat-syscall.c             |   1 +
> > > > >  tools/perf/tests/pmu-events.c                 |   1 +
> > > > >  tools/perf/tests/thread-map.c                 |   1 +
> > > > >  tools/perf/util/Build                         |   5 -
> > > > >  tools/perf/util/auxtrace.h                    |   2 +-
> > > > >  tools/perf/util/bpf-loader.c                  |   4 -
> > > > >  tools/perf/util/bpf_counter.c                 |   2 +-
> > > > >  tools/perf/util/cpumap.c                      |   1 +
> > > > >  tools/perf/util/cpumap.h                      |   2 +-
> > > > >  tools/perf/util/evsel.c                       |   5 +-
> > > > >  tools/perf/util/evsel.h                       |   2 -
> > > > >  tools/perf/util/expr.c                        |   1 +
> > > > >  tools/perf/util/expr.h                        |   7 +-
> > > > >  tools/perf/util/metricgroup.c                 |   1 +
> > > > >  tools/perf/util/python.c                      |   6 +-
> > > > >  .../scripting-engines/trace-event-python.c    |   2 +-
> > > > >  tools/perf/util/stat-shadow.c                 |   1 +
> > > > >  tools/perf/util/stat.c                        |   4 -
> > > > >  tools/perf/util/thread_map.c                  |   1 +
> > > > >  tools/perf/util/thread_map.h                  |   2 -
> > > > >  32 files changed, 361 insertions(+), 86 deletions(-)
> > > > >  create mode 100644 tools/lib/symbol/Build
> > > > >  create mode 100644 tools/lib/symbol/Makefile
> > > > >
> > > > > --
> > > > > 2.38.1.431.g37b22c650d-goog
> > > >
> > > > --
> > > >
> > > > - Arnaldo
>
> --
>
> - Arnaldo

--0000000000007ee45705ed890aef
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-perf-build-Use-tools-lib-headers-from-install-path.patch"
Content-Disposition: attachment; 
	filename="0001-perf-build-Use-tools-lib-headers-from-install-path.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_laiq5gx20>
X-Attachment-Id: f_laiq5gx20

RnJvbSA4Y2RjYTNmODVjZDQzOThjZWVkZGVhNWJiYzlkNDIxZjBiZmRjNzZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+CkRhdGU6
IFdlZCwgOSBOb3YgMjAyMiAxMDo0OToxNCAtMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHBlcmYgYnVp
bGQ6IFVzZSB0b29scy9saWIgaGVhZGVycyBmcm9tIGluc3RhbGwgcGF0aAoKU3dpdGNoIC1JIGZy
b20gdG9vbHMvbGliIHRvIHRoZSBpbnN0YWxsIHBhdGggZm9yIHRoZSB0b29scy9saWIKbGlicmFy
aWVzLiBBZGQgdGhlIGluY2x1ZGVfaGVhZGVycyBidWlsZCB0YXJnZXRzIHRvIHByZXBhcmUgdGFy
Z2V0LCBhcwp3ZWxsIGFzIHBtdS1ldmVudHMuYyBjb21waWxhdGlvbiB0aGF0IGRlcGVuZGVzIG9u
IGxpYnBlcmYuCgpTaWduZWQtb2ZmLWJ5OiBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+
CkFja2VkLWJ5OiBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtlcm5lbC5vcmc+CkNjOiBBbGV4YW5k
ZXIgU2hpc2hraW4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+CkNjOiBBbmRy
aWkgTmFrcnlpa28gPGFuZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20+CkNjOiBKaXJpIE9sc2EgPGpv
bHNhQGtlcm5lbC5vcmc+CkNjOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPgpD
YzogTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGlyb3lAa2VybmVsLm9yZz4KQ2M6IE5pY2sgRGVzYXVs
bmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tPgpDYzogTmljb2xhcyBTY2hpZXIgPG5pY29s
YXNAZmphc2xlLmV1PgpDYzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPgpD
YzogU3RlcGhhbmUgRXJhbmlhbiA8ZXJhbmlhbkBnb29nbGUuY29tPgpDYzogYnBmQHZnZXIua2Vy
bmVsLm9yZwpMaW5rOiBodHRwOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjExMDkxODQ5MTQu
MTM1NzI5NS0xNS1pcm9nZXJzQGdvb2dsZS5jb20KU2lnbmVkLW9mZi1ieTogQXJuYWxkbyBDYXJ2
YWxobyBkZSBNZWxvIDxhY21lQHJlZGhhdC5jb20+Ci0tLQogdG9vbHMvcGVyZi9NYWtlZmlsZS5j
b25maWcgfCAgMiAtLQogdG9vbHMvcGVyZi9NYWtlZmlsZS5wZXJmICAgfCAxNCArKysrKysrKysr
KysrLQogMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvTWFrZWZpbGUuY29uZmlnIGIvdG9vbHMvcGVyZi9NYWtl
ZmlsZS5jb25maWcKaW5kZXggYTdmNmMwNjY5ZmFlLi45Y2MzYzQ4ZjMyODggMTAwNjQ0Ci0tLSBh
L3Rvb2xzL3BlcmYvTWFrZWZpbGUuY29uZmlnCisrKyBiL3Rvb2xzL3BlcmYvTWFrZWZpbGUuY29u
ZmlnCkBAIC0zNDksNyArMzQ5LDYgQEAgaWZlcSAoJChERUJVRyksMCkKICAgZW5kaWYKIGVuZGlm
CiAKLUlOQ19GTEFHUyArPSAtSSQoc3JjdHJlZSkvdG9vbHMvbGliL3BlcmYvaW5jbHVkZQogSU5D
X0ZMQUdTICs9IC1JJChzcmMtcGVyZikvdXRpbC9pbmNsdWRlCiBJTkNfRkxBR1MgKz0gLUkkKHNy
Yy1wZXJmKS9hcmNoLyQoU1JDQVJDSCkvaW5jbHVkZQogSU5DX0ZMQUdTICs9IC1JJChzcmN0cmVl
KS90b29scy9pbmNsdWRlLwpAQCAtMzY3LDcgKzM2Niw2IEBAIGVuZGlmCiAKIElOQ19GTEFHUyAr
PSAtSSQoc3JjLXBlcmYpL3V0aWwKIElOQ19GTEFHUyArPSAtSSQoc3JjLXBlcmYpCi1JTkNfRkxB
R1MgKz0gLUkkKHNyY3RyZWUpL3Rvb2xzL2xpYi8KIAogQ09SRV9DRkxBR1MgKz0gLURfTEFSR0VG
SUxFNjRfU09VUkNFIC1EX0ZJTEVfT0ZGU0VUX0JJVFM9NjQgLURfR05VX1NPVVJDRQogCmRpZmYg
LS1naXQgYS90b29scy9wZXJmL01ha2VmaWxlLnBlcmYgYi90b29scy9wZXJmL01ha2VmaWxlLnBl
cmYKaW5kZXggNmMxYTJhM2NjYzM4Li43NjZlYzk0NzExODMgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bl
cmYvTWFrZWZpbGUucGVyZgorKysgYi90b29scy9wZXJmL01ha2VmaWxlLnBlcmYKQEAgLTMwNSw2
ICszMDUsNyBAQCBMSUJUUkFDRUVWRU5UX0lOQ0xVREUgPSAkKExJQlRSQUNFRVZFTlRfREVTVERJ
UikvaW5jbHVkZQogTElCVFJBQ0VFVkVOVCA9ICQoTElCVFJBQ0VFVkVOVF9PVVRQVVQpL2xpYnRy
YWNlZXZlbnQuYQogZXhwb3J0IExJQlRSQUNFRVZFTlQKIExJQlRSQUNFRVZFTlRfRFlOQU1JQ19M
SVNUID0gJChMSUJUUkFDRUVWRU5UX1BMVUdJTlNfT1VUUFVUKS9saWJ0cmFjZWV2ZW50LWR5bmFt
aWMtbGlzdAorQ0ZMQUdTICs9IC1JJChMSUJUUkFDRUVWRU5UX09VVFBVVCkvaW5jbHVkZQogCiAj
CiAjIFRoZSBzdGF0aWMgYnVpbGQgaGFzIG5vIGR5bnN5bSB0YWJsZSwgc28gdGhpcyBkb2VzIG5v
dCB3b3JrIGZvcgpAQCAtMzIyLDYgKzMyMyw3IEBAIExJQkFQSV9ERVNURElSID0gJChMSUJBUElf
T1VUUFVUKQogTElCQVBJX0lOQ0xVREUgPSAkKExJQkFQSV9ERVNURElSKS9pbmNsdWRlCiBMSUJB
UEkgPSAkKExJQkFQSV9PVVRQVVQpL2xpYmFwaS5hCiBleHBvcnQgTElCQVBJCitDRkxBR1MgKz0g
LUkkKExJQkFQSV9PVVRQVVQpL2luY2x1ZGUKIAogaWZuZXEgKCQoT1VUUFVUKSwpCiAgIExJQkJQ
Rl9PVVRQVVQgPSAkKGFic3BhdGggJChPVVRQVVQpKS9saWJicGYKQEAgLTMzMSw2ICszMzMsNyBA
QCBlbmRpZgogTElCQlBGX0RFU1RESVIgPSAkKExJQkJQRl9PVVRQVVQpCiBMSUJCUEZfSU5DTFVE
RSA9ICQoTElCQlBGX0RFU1RESVIpL2luY2x1ZGUKIExJQkJQRiA9ICQoTElCQlBGX09VVFBVVCkv
bGliYnBmLmEKK0NGTEFHUyArPSAtSSQoTElCQlBGX09VVFBVVCkvaW5jbHVkZQogCiBpZm5lcSAo
JChPVVRQVVQpLCkKICAgTElCU1VCQ01EX09VVFBVVCA9ICQoYWJzcGF0aCAkKE9VVFBVVCkpL2xp
YnN1YmNtZApAQCAtMzQwLDYgKzM0Myw3IEBAIGVuZGlmCiBMSUJTVUJDTURfREVTVERJUiA9ICQo
TElCU1VCQ01EX09VVFBVVCkKIExJQlNVQkNNRF9JTkNMVURFID0gJChMSUJTVUJDTURfREVTVERJ
UikvaW5jbHVkZQogTElCU1VCQ01EID0gJChMSUJTVUJDTURfT1VUUFVUKS9saWJzdWJjbWQuYQor
Q0ZMQUdTICs9IC1JJChMSUJTVUJDTURfT1VUUFVUKS9pbmNsdWRlCiAKIGlmbmVxICgkKE9VVFBV
VCksKQogICBMSUJTWU1CT0xfT1VUUFVUID0gJChhYnNwYXRoICQoT1VUUFVUKSkvbGlic3ltYm9s
CkBAIC0zNDksNiArMzUzLDcgQEAgZW5kaWYKIExJQlNZTUJPTF9ERVNURElSID0gJChMSUJTWU1C
T0xfT1VUUFVUKQogTElCU1lNQk9MX0lOQ0xVREUgPSAkKExJQlNZTUJPTF9ERVNURElSKS9pbmNs
dWRlCiBMSUJTWU1CT0wgPSAkKExJQlNZTUJPTF9PVVRQVVQpL2xpYnN5bWJvbC5hCitDRkxBR1Mg
Kz0gLUkkKExJQlNZTUJPTF9PVVRQVVQpL2luY2x1ZGUKIAogaWZuZXEgKCQoT1VUUFVUKSwpCiAg
IExJQlBFUkZfT1VUUFVUID0gJChhYnNwYXRoICQoT1VUUFVUKSkvbGlicGVyZgpAQCAtMzU5LDYg
KzM2NCw3IEBAIExJQlBFUkZfREVTVERJUiA9ICQoTElCUEVSRl9PVVRQVVQpCiBMSUJQRVJGX0lO
Q0xVREUgPSAkKExJQlBFUkZfREVTVERJUikvaW5jbHVkZQogTElCUEVSRiA9ICQoTElCUEVSRl9P
VVRQVVQpL2xpYnBlcmYuYQogZXhwb3J0IExJQlBFUkYKK0NGTEFHUyArPSAtSSQoTElCUEVSRl9P
VVRQVVQpL2luY2x1ZGUKIAogIyBweXRob24gZXh0ZW5zaW9uIGJ1aWxkIGRpcmVjdG9yaWVzCiBQ
WVRIT05fRVhUQlVJTEQgICAgIDo9ICQoT1VUUFVUKXB5dGhvbl9leHRfYnVpbGQvCkBAIC02OTEs
NyArNjk3LDcgQEAgYnVpbGQgOj0gLWYgJChzcmN0cmVlKS90b29scy9idWlsZC9NYWtlZmlsZS5i
dWlsZCBkaXI9LiBvYmoKICQoUEVSRl9JTik6IHByZXBhcmUgRk9SQ0UKIAkkKFEpJChNQUtFKSAk
KGJ1aWxkKT1wZXJmCiAKLSQoUE1VX0VWRU5UU19JTik6IEZPUkNFCiskKFBNVV9FVkVOVFNfSU4p
OiBGT1JDRSAkKExJQlBFUkYpCiAJJChRKSQoTUFLRSkgLWYgJChzcmN0cmVlKS90b29scy9idWls
ZC9NYWtlZmlsZS5idWlsZCBkaXI9cG11LWV2ZW50cyBvYmo9cG11LWV2ZW50cwogCiAkKE9VVFBV
VClwZXJmOiAkKFBFUkZMSUJTKSAkKFBFUkZfSU4pICQoUE1VX0VWRU5UU19JTikgJChMSUJUUkFD
RUVWRU5UX0RZTkFNSUNfTElTVCkKQEAgLTc3NCw2ICs3ODAsMTIgQEAgcHJlcGFyZTogJChPVVRQ
VVQpUEVSRi1WRVJTSU9OLUZJTEUgJChPVVRQVVQpY29tbW9uLWNtZHMuaCBhcmNoaGVhZGVycyAk
KGRybV9pb2MKIAkkKHJlbmFtZV9mbGFnc19hcnJheSkgXAogCSQoYXJjaF9lcnJub19uYW1lX2Fy
cmF5KSBcCiAJJChzeW5jX2ZpbGVfcmFuZ2VfYXJyYXlzKSBcCisJJChMSUJBUEkpIFwKKwkkKExJ
QkJQRikgXAorCSQoTElCUEVSRikgXAorCSQoTElCU1VCQ01EKSBcCisJJChMSUJTWU1CT0wpIFwK
KwkkKExJQlRSQUNFRVZFTlQpIFwKIAlicGYtc2tlbAogCiAkKE9VVFBVVCklLm86ICUuYyBwcmVw
YXJlIEZPUkNFCi0tIAoyLjM4LjEuNDMxLmczN2IyMmM2NTBkLWdvb2cKCg==
--0000000000007ee45705ed890aef--
