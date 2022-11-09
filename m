Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FC66230DF
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 18:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiKIRAx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 12:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiKIRAe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 12:00:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6826F2AC45
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 08:57:16 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id cl5so26661331wrb.9
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 08:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sm+dCJJEEQ7+EkYSQ+2VmevEgeRaXIz8X5u6MUXZr/4=;
        b=pt1hevZ/5ESgT5JreBgXBlk/6uOGLTnnGIj/GQxrwlw4Q8rVXWUcxYcwD5Q76rUQeM
         XIeuSoUziACWuO0j+ulMnNjc7yYF22PDy2OdVKL0F5O9x4fFgBZvleZbeW83DHyJmfVp
         3ZPjOlmhaVBefvjqFJ6q5dvnRvDjZQ1VNxjuFBRIAa7Po+RJwNNyI143AEYVytPj54MO
         G3Jp0fm+yaRnFioLGyK6hX5zer53xQsjYADktpKhOLW6lLB2VNyt055iv/Z16iFF6dZb
         GdP+YwE9jOsAygmm9y3FBsxYln65X9smPMZisDgKxKNHfB6N6LITt8iS7tFEXZnnwMsZ
         kEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sm+dCJJEEQ7+EkYSQ+2VmevEgeRaXIz8X5u6MUXZr/4=;
        b=6BT8W3BxGwidFT5b0gL8NwaEiLX11+7Di/45xZZmZkfW2h+fQvSCf0Mh1tXnB+6SnJ
         D1ixRdvlrB1rabZlAhCdkaaANEnlKVj14XnSIH3fEnHQgX32XEW3FtWV5xWNnWVShye9
         B4NXuwC4B+0N1Q6tQfEVUohHPZ6L2N4oqAWU0LGut8vYmoHg8rprBqK3mFDKk5dsPNJd
         vztk/cQx07+tcFi/o3ML3ZkGAugFGWapiltSNdeOEXOxw078FXf+o0ZoFgYcHY1Jloly
         svuTxv8LEhCUhoFusw2S/9/ANXqXyfgf6t7YRMwMDvepiCs5bJtYfEOI0oc2bHOKkl1Q
         STbA==
X-Gm-Message-State: ACrzQf3bgGgGrVXKrDo5Pn9/f3enz9zZHuzvcmmueIAYXcc5jGrvT7+Q
        TyaBFt1N4Dyl4/gwiP8iTVVn6XW5c4B6EmvTPGx2+A==
X-Google-Smtp-Source: AMsMyM7f9ipxs0uFXI99tel5Zn8OfimI7ECFVy1MVtrJ/1z2KWpRTqQT8fQGCnnh957/FkfpU4FCmuC2AqOEZAokIaE=
X-Received: by 2002:a5d:47a6:0:b0:236:7854:246d with SMTP id
 6-20020a5d47a6000000b002367854246dmr38446444wrb.300.1668013034686; Wed, 09
 Nov 2022 08:57:14 -0800 (PST)
MIME-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com> <Y2vG13WVahGoib57@kernel.org>
 <CAP-5=fXMEE6LAoBcV-UtRRhG3wvVtzBW4r5FGz06=qsE2U6jPw@mail.gmail.com>
In-Reply-To: <CAP-5=fXMEE6LAoBcV-UtRRhG3wvVtzBW4r5FGz06=qsE2U6jPw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 9 Nov 2022 08:57:01 -0800
Message-ID: <CAP-5=fXECqhQpvMVdyzFpNixGwC+9BBo_Jj9nXEZ1hsDvjRd8Q@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 9, 2022 at 8:52 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Nov 9, 2022 at 7:27 AM Arnaldo Carvalho de Melo <acme@kernel.org>=
 wrote:
> >
> > Em Mon, Nov 07, 2022 at 11:35:04PM -0800, Ian Rogers escreveu:
> > > The previous build would add -Itools/lib and get dependencies for
> > > libtraceevent, libsubcmd, libsymbol, libapi and libbpf meaning that
> > > overriding these libraries would change the link time dependency but
> > > the headers would erroneously come from tools/lib. Fix the build to
> > > install headers and then depend on these. To reduce exposing internal
> > > headers/APIs some clean up is performed. tools/lib/symbol has a
> > > Makefile added, while tools/lib/api and tools/lib/subcmd have install
> > > targets added. The pattern used for the dependencies in Makefile.perf
> > > is modelled on libbpf.
> >
> > It builds with O=3D, I tried it one by one, but  there are problems wit=
h
> > make from a detached tarball, that is how I do the container builds, se=
e
> > below, I'm trying to figure this out...
>
> Sorry, I didn't know to test this. The added Build and Makefile in
> libsymbol are missing, so I'd guess that's the major issue.
>
> Thanks,
> Ian

The following fixes this for me:

--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -13,8 +13,7 @@ tools/lib/ctype.c
tools/lib/hweight.c
tools/lib/rbtree.c
tools/lib/string.c
-tools/lib/symbol/kallsyms.c
-tools/lib/symbol/kallsyms.h
+tools/lib/symbol
tools/lib/find_bit.c
tools/lib/bitmap.c
tools/lib/list_sort.c

Thanks,
Ian

> > =E2=AC=A2[acme@toolbox perf]$ make perf-tar-src-pkg
> >   TAR
> >   PERF_VERSION =3D 6.1.rc3.g7e5d8b7a1fbd
> > =E2=AC=A2[acme@toolbox perf]$ mv perf-6.1.0-rc3.tar /tmp
> > =E2=AC=A2[acme@toolbox perf]$ cd /tmp
> > =E2=AC=A2[acme@toolbox tmp]$ tar xf perf-6.1.0-rc3.tar
> > =E2=AC=A2[acme@toolbox tmp]$ cd perf-6.1.0-rc3/
> > =E2=AC=A2[acme@toolbox perf-6.1.0-rc3]$ make -C tools/perf
> > make: Entering directory '/tmp/perf-6.1.0-rc3/tools/perf'
> >   BUILD:   Doing 'make -j32' parallel build
> >   HOSTCC  fixdep.o
> >   HOSTLD  fixdep-in.o
> >   LINK    fixdep
> >
> > Auto-detecting system features:
> > ...                                   dwarf: [ on  ]
> > ...                      dwarf_getlocations: [ on  ]
> > ...                                   glibc: [ on  ]
> > ...                                  libbfd: [ on  ]
> > ...                          libbfd-buildid: [ on  ]
> > ...                                  libcap: [ on  ]
> > ...                                  libelf: [ on  ]
> > ...                                 libnuma: [ on  ]
> > ...                  numa_num_possible_cpus: [ on  ]
> > ...                                 libperl: [ on  ]
> > ...                               libpython: [ on  ]
> > ...                               libcrypto: [ on  ]
> > ...                               libunwind: [ on  ]
> > ...                      libdw-dwarf-unwind: [ on  ]
> > ...                                    zlib: [ on  ]
> > ...                                    lzma: [ on  ]
> > ...                               get_cpuid: [ on  ]
> > ...                                     bpf: [ on  ]
> > ...                                  libaio: [ on  ]
> > ...                                 libzstd: [ on  ]
> >
> >   GEN     common-cmds.h
> >   PERF_VERSION =3D 6.1.rc3.g7e5d8b7a1fbd
> >   CC      perf-read-vdso32
> >   GEN     perf-archive
> >   GEN     perf-iostat
> >   CC      dlfilters/dlfilter-test-api-v0.o
> >   CC      dlfilters/dlfilter-show-cycles.o
> >   CC      jvmti/libjvmti.o
> > make[3]: *** No rule to make target '/tmp/perf-6.1.0-rc3/tools/perf/lib=
symbol/libsymbol.a'.  Stop.
> > make[2]: *** [Makefile.perf:907: /tmp/perf-6.1.0-rc3/tools/perf/libsymb=
ol/libsymbol.a] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> >   CC      jvmti/jvmti_agent.o
> >   CC      jvmti/libstring.o
> >   CC      jvmti/libctype.o
> >   GEN     pmu-events/pmu-events.c
> >   INSTALL headers
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/exec-cmd.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/help.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/pager.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/parse-options.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/run-command.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/sigchain.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/subcmd-config.o
> >   INSTALL headers
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/event-parse.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_j=
bd2.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_h=
rtimer.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_k=
mem.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_k=
vm.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_m=
ac80211.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_f=
unction.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_s=
ched_switch.o
> >   INSTALL headers
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/core.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/cpu.o
> >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libapi/fd/
> >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/
> >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/
> >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fd/array.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/fs.o
> >   GEN     /tmp/perf-6.1.0-rc3/tools/perf/libbpf/bpf_helper_defs.h
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/tracing_path.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/cgroup.o
> >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf.h
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/debug.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_f=
utex.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_x=
en.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_s=
csi.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_c=
fg80211.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_t=
lb.o
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_j=
bd2-in.o
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_h=
rtimer-in.o
> >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/libbpf.h
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_k=
mem-in.o
> >   INSTALL headers
> >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/btf.h
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_m=
ac80211-in.o
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_s=
ched_switch-in.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/cpumap.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/threadmap.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/str_error_r.o
> >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/libbpf_comm=
on.h
> >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_j=
bd2.so
> >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_h=
rtimer.so
> >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/libbpf_lega=
cy.h
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_f=
unction-in.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/evsel.o
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_k=
vm-in.o
> >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_k=
mem.so
> >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_m=
ac80211.so
> >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_s=
ched_switch.so
> >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_helpers=
.h
> >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_tracing=
.h
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/event-plugin.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/evlist.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/mmap.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/trace-seq.o
> >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_endian.=
h
> >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_core_re=
ad.h
> > if [ ! -d ''/tmp/perf-6.1.0-rc3/tools/perf/libapi'/include/api/fs' ]; t=
hen install -d -m 755 ''/tmp/perf-6.1.0-rc3/tools/perf/libapi'/include/api/=
fs'; fi; install fs/tracing_path.h -m 644 ''/tmp/perf-6.1.0-rc3/tools/perf/=
libapi'/include/api/fs';
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fd/libapi-in.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/zalloc.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/parse-filter.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/parse-utils.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/kbuffer-parse.o
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_x=
en-in.o
> >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/skel_intern=
al.h
> >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/libbpf_vers=
ion.h
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/tep_strerror.o
> >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/usdt.bpf.h
> >   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_helper_=
defs.h
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/event-parse-api.=
o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/xyarray.o
> >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_f=
unction.so
> >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_x=
en.so
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_f=
utex-in.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/lib.o
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_s=
csi-in.o
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_c=
fg80211-in.o
> >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
> >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
> >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
> >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
> >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_k=
vm.so
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/libbpf.o
> >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_f=
utex.so
> >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_s=
csi.so
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/bpf.o
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/libapi-in.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/nlattr.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/btf.o
> >   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_t=
lb-in.o
> >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_c=
fg80211.so
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/str_error.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/netlink.o
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libapi/libapi-in.o
> >   LD      jvmti/jvmti-in.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/libbpf_errno=
.o
> >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_t=
lb.so
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/bpf_prog_lin=
fo.o
> >   AR      /tmp/perf-6.1.0-rc3/tools/perf/libapi/libapi.a
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/libbpf_probe=
s.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/hashmap.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/btf_dump.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/ringbuf.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/strset.o
> >   GEN     /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/libtrace=
event-dynamic-list
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/linker.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/gen_loader.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/relo_core.o
> >   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/usdt.o
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/libsubcmd-in.o
> >   AR      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/libsubcmd.a
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libperf/libperf-in.o
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/libtraceevent-in=
.o
> >   AR      /tmp/perf-6.1.0-rc3/tools/perf/libperf/libperf.a
> >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/libtraceevent.a
> >   CC      pmu-events/pmu-events.o
> >   LD      pmu-events/pmu-events-in.o
> >   LD      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/libbpf-in.o
> >   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libbpf/libbpf.a
> > make[1]: *** [Makefile.perf:240: sub-make] Error 2
> > make: *** [Makefile:70: all] Error 2
> > make: Leaving directory '/tmp/perf-6.1.0-rc3/tools/perf'
> > =E2=AC=A2[acme@toolbox perf-6.1.0-rc3]$
> >
> >
> >
> > > The problem and solution were motivated by this issue and discussion:
> > > https://lore.kernel.org/lkml/CAEf4BzbbOHQZUAe6iWaehKCPQAf3VC=3Dhq657b=
uqe2_yRKxaK-A@mail.gmail.com/
> > >
> > > Ian Rogers (14):
> > >   tools lib api: Add install target
> > >   tools lib subcmd: Add install target
> > >   perf build: Install libsubcmd locally when building
> > >   perf build: Install libapi locally when building
> > >   perf build: Install libperf locally when building
> > >   perf build: Install libtraceevent locally when building
> > >   tools lib api: Add missing install headers
> > >   tools lib perf: Add missing install headers
> > >   tool lib symbol: Add Makefile/Build
> > >   perf build: Install libsymbol locally when building
> > >   perf expr: Tidy hashmap dependency
> > >   perf thread_map: Reduce exposure of libperf internal API
> > >   perf cpumap: Tidy libperf includes
> > >   perf build: Use tools/lib headers from install path
> > >
> > >  tools/lib/api/Makefile                        |  52 ++++++
> > >  tools/lib/perf/Makefile                       |  10 +-
> > >  tools/lib/subcmd/Makefile                     |  49 ++++++
> > >  tools/lib/symbol/Build                        |   1 +
> > >  tools/lib/symbol/Makefile                     | 115 +++++++++++++
> > >  tools/perf/.gitignore                         |   7 +-
> > >  tools/perf/Makefile.config                    |   2 -
> > >  tools/perf/Makefile.perf                      | 152 ++++++++++++----=
--
> > >  tools/perf/builtin-stat.c                     |   1 +
> > >  tools/perf/builtin-trace.c                    |   4 +-
> > >  tools/perf/tests/cpumap.c                     |   2 +-
> > >  tools/perf/tests/expr.c                       |   1 +
> > >  tools/perf/tests/openat-syscall.c             |   1 +
> > >  tools/perf/tests/pmu-events.c                 |   1 +
> > >  tools/perf/tests/thread-map.c                 |   1 +
> > >  tools/perf/util/Build                         |   5 -
> > >  tools/perf/util/auxtrace.h                    |   2 +-
> > >  tools/perf/util/bpf-loader.c                  |   4 -
> > >  tools/perf/util/bpf_counter.c                 |   2 +-
> > >  tools/perf/util/cpumap.c                      |   1 +
> > >  tools/perf/util/cpumap.h                      |   2 +-
> > >  tools/perf/util/evsel.c                       |   5 +-
> > >  tools/perf/util/evsel.h                       |   2 -
> > >  tools/perf/util/expr.c                        |   1 +
> > >  tools/perf/util/expr.h                        |   7 +-
> > >  tools/perf/util/metricgroup.c                 |   1 +
> > >  tools/perf/util/python.c                      |   6 +-
> > >  .../scripting-engines/trace-event-python.c    |   2 +-
> > >  tools/perf/util/stat-shadow.c                 |   1 +
> > >  tools/perf/util/stat.c                        |   4 -
> > >  tools/perf/util/thread_map.c                  |   1 +
> > >  tools/perf/util/thread_map.h                  |   2 -
> > >  32 files changed, 361 insertions(+), 86 deletions(-)
> > >  create mode 100644 tools/lib/symbol/Build
> > >  create mode 100644 tools/lib/symbol/Makefile
> > >
> > > --
> > > 2.38.1.431.g37b22c650d-goog
> >
> > --
> >
> > - Arnaldo
