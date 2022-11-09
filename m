Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B4E62308D
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 17:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiKIQyG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 11:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiKIQx3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 11:53:29 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF3327920
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 08:52:44 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p16so11225074wmc.3
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 08:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeazlkoR15bj6bus0hUXdYMA3hw2fOnNyQLZPc3/V6I=;
        b=Ws+WdGa1MPyo/8p+N127B4G4oW53e9d/89TZpilCjUeq0TfGFm7xfq48areBge1KL2
         y4vaG3qbPBQ2NCmMyn9oyBK2TmEzNVa7bpQtJehl0tYPt2yRQc7uJc5XeImf1OEECQzE
         SThf6zwPRQaLojRHoA6DYQCCdUWA/bx+thODGaLIb8KLdijjcP3nNjbS65fRVQTqEa/R
         fn3Q7hZzzmvPWny5KBa8ZPh5nG2E8qZMta+sZydNo9ErwO2+26/+sYzEy7WIMhPUDVOK
         eLey+8eihleDNsbHRL/Z9qCzgK8ScDD121qqS7PxylDT8aV6CICE9QNgkyika3aWfSxW
         +Urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeazlkoR15bj6bus0hUXdYMA3hw2fOnNyQLZPc3/V6I=;
        b=Qu3qDvJuYilOR7cPKAmolx/G8Pfzz+q76uw+yAae/9ZfFd4VpnYr42AI+6SGwdpwOj
         9OREJyAgBaoXpF9CXlClTO9n6lKFOuE2whN505/WXw8NrUM3qEy594RA3nG7Fn7Ye2iR
         jZxO5kyXfIx5bXI3WNMDyYOxNG0ATyXcin3gN6jEbovWk99JJuXXcPHHwzjSrNbBSMXQ
         rltVSqa6SBq79+YXVz4gYLWYlAa98qu0F96XeUn4WuduvzyAq6k84V8ZuxL9Jw3FxjCW
         VnGn5dQwkpz8bZC6MqMvcdtxpIn+gek3Jakr2wW7ZUM92osgnHRdwvXqgzX4C5+OODet
         uIUA==
X-Gm-Message-State: ANoB5pkQHLNRzK93Pt2LcW1gYKl0ml3VaDB09eHtXlfmUcsqtZHQ0gWN
        E8+km4WnWVE4IZdk32sGV1A88SXaVFYRiDJ5bwfsyQ==
X-Google-Smtp-Source: AA0mqf70GgSs4M39HKz55xfSCOPPY2j7rJrV6rTKC2wuhQZwcsfqbHBobJp3b5VB18QenxkiWlbw/moxSpr3sdUCtFs=
X-Received: by 2002:a05:600c:3ba1:b0:3cf:a511:320c with SMTP id
 n33-20020a05600c3ba100b003cfa511320cmr13625122wms.182.1668012762285; Wed, 09
 Nov 2022 08:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com> <Y2vG13WVahGoib57@kernel.org>
In-Reply-To: <Y2vG13WVahGoib57@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 9 Nov 2022 08:52:29 -0800
Message-ID: <CAP-5=fXMEE6LAoBcV-UtRRhG3wvVtzBW4r5FGz06=qsE2U6jPw@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 9, 2022 at 7:27 AM Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>
> Em Mon, Nov 07, 2022 at 11:35:04PM -0800, Ian Rogers escreveu:
> > The previous build would add -Itools/lib and get dependencies for
> > libtraceevent, libsubcmd, libsymbol, libapi and libbpf meaning that
> > overriding these libraries would change the link time dependency but
> > the headers would erroneously come from tools/lib. Fix the build to
> > install headers and then depend on these. To reduce exposing internal
> > headers/APIs some clean up is performed. tools/lib/symbol has a
> > Makefile added, while tools/lib/api and tools/lib/subcmd have install
> > targets added. The pattern used for the dependencies in Makefile.perf
> > is modelled on libbpf.
>
> It builds with O=3D, I tried it one by one, but  there are problems with
> make from a detached tarball, that is how I do the container builds, see
> below, I'm trying to figure this out...

Sorry, I didn't know to test this. The added Build and Makefile in
libsymbol are missing, so I'd guess that's the major issue.

Thanks,
Ian

> =E2=AC=A2[acme@toolbox perf]$ make perf-tar-src-pkg
>   TAR
>   PERF_VERSION =3D 6.1.rc3.g7e5d8b7a1fbd
> =E2=AC=A2[acme@toolbox perf]$ mv perf-6.1.0-rc3.tar /tmp
> =E2=AC=A2[acme@toolbox perf]$ cd /tmp
> =E2=AC=A2[acme@toolbox tmp]$ tar xf perf-6.1.0-rc3.tar
> =E2=AC=A2[acme@toolbox tmp]$ cd perf-6.1.0-rc3/
> =E2=AC=A2[acme@toolbox perf-6.1.0-rc3]$ make -C tools/perf
> make: Entering directory '/tmp/perf-6.1.0-rc3/tools/perf'
>   BUILD:   Doing 'make -j32' parallel build
>   HOSTCC  fixdep.o
>   HOSTLD  fixdep-in.o
>   LINK    fixdep
>
> Auto-detecting system features:
> ...                                   dwarf: [ on  ]
> ...                      dwarf_getlocations: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libbfd: [ on  ]
> ...                          libbfd-buildid: [ on  ]
> ...                                  libcap: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                                 libperl: [ on  ]
> ...                               libpython: [ on  ]
> ...                               libcrypto: [ on  ]
> ...                               libunwind: [ on  ]
> ...                      libdw-dwarf-unwind: [ on  ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                               get_cpuid: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
>
>   GEN     common-cmds.h
>   PERF_VERSION =3D 6.1.rc3.g7e5d8b7a1fbd
>   CC      perf-read-vdso32
>   GEN     perf-archive
>   GEN     perf-iostat
>   CC      dlfilters/dlfilter-test-api-v0.o
>   CC      dlfilters/dlfilter-show-cycles.o
>   CC      jvmti/libjvmti.o
> make[3]: *** No rule to make target '/tmp/perf-6.1.0-rc3/tools/perf/libsy=
mbol/libsymbol.a'.  Stop.
> make[2]: *** [Makefile.perf:907: /tmp/perf-6.1.0-rc3/tools/perf/libsymbol=
/libsymbol.a] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC      jvmti/jvmti_agent.o
>   CC      jvmti/libstring.o
>   CC      jvmti/libctype.o
>   GEN     pmu-events/pmu-events.c
>   INSTALL headers
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/exec-cmd.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/help.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/pager.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/parse-options.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/run-command.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/sigchain.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/subcmd-config.o
>   INSTALL headers
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/event-parse.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_jbd=
2.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_hrt=
imer.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_kme=
m.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_kvm=
.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_mac=
80211.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_fun=
ction.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_sch=
ed_switch.o
>   INSTALL headers
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/core.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/cpu.o
>   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libapi/fd/
>   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/
>   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/
>   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fd/array.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/fs.o
>   GEN     /tmp/perf-6.1.0-rc3/tools/perf/libbpf/bpf_helper_defs.h
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/tracing_path.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/cgroup.o
>   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf.h
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/debug.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_fut=
ex.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_xen=
.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_scs=
i.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_cfg=
80211.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_tlb=
.o
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_jbd=
2-in.o
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_hrt=
imer-in.o
>   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/libbpf.h
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_kme=
m-in.o
>   INSTALL headers
>   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/btf.h
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_mac=
80211-in.o
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_sch=
ed_switch-in.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/cpumap.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/threadmap.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/str_error_r.o
>   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/libbpf_common=
.h
>   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_jbd=
2.so
>   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_hrt=
imer.so
>   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/libbpf_legacy=
.h
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_fun=
ction-in.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/evsel.o
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_kvm=
-in.o
>   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_kme=
m.so
>   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_mac=
80211.so
>   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_sch=
ed_switch.so
>   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_helpers.h
>   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_tracing.h
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/event-plugin.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/evlist.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/mmap.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/trace-seq.o
>   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_endian.h
>   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_core_read=
.h
> if [ ! -d ''/tmp/perf-6.1.0-rc3/tools/perf/libapi'/include/api/fs' ]; the=
n install -d -m 755 ''/tmp/perf-6.1.0-rc3/tools/perf/libapi'/include/api/fs=
'; fi; install fs/tracing_path.h -m 644 ''/tmp/perf-6.1.0-rc3/tools/perf/li=
bapi'/include/api/fs';
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fd/libapi-in.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/zalloc.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/parse-filter.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/parse-utils.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/kbuffer-parse.o
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_xen=
-in.o
>   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/skel_internal=
.h
>   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/libbpf_versio=
n.h
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/tep_strerror.o
>   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/usdt.bpf.h
>   INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_helper_de=
fs.h
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/event-parse-api.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/xyarray.o
>   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_fun=
ction.so
>   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_xen=
.so
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_fut=
ex-in.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/lib.o
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_scs=
i-in.o
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_cfg=
80211-in.o
>   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
>   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
>   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
>   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
>   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_kvm=
.so
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/libbpf.o
>   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_fut=
ex.so
>   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_scs=
i.so
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/bpf.o
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/libapi-in.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/nlattr.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/btf.o
>   MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_tlb=
-in.o
>   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_cfg=
80211.so
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/str_error.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/netlink.o
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libapi/libapi-in.o
>   LD      jvmti/jvmti-in.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/libbpf_errno.o
>   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_tlb=
.so
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/bpf_prog_linfo=
.o
>   AR      /tmp/perf-6.1.0-rc3/tools/perf/libapi/libapi.a
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/libbpf_probes.=
o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/hashmap.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/btf_dump.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/ringbuf.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/strset.o
>   GEN     /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/libtraceev=
ent-dynamic-list
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/linker.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/gen_loader.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/relo_core.o
>   CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/usdt.o
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/libsubcmd-in.o
>   AR      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/libsubcmd.a
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libperf/libperf-in.o
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/libtraceevent-in.o
>   AR      /tmp/perf-6.1.0-rc3/tools/perf/libperf/libperf.a
>   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/libtraceevent.a
>   CC      pmu-events/pmu-events.o
>   LD      pmu-events/pmu-events-in.o
>   LD      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/libbpf-in.o
>   LINK    /tmp/perf-6.1.0-rc3/tools/perf/libbpf/libbpf.a
> make[1]: *** [Makefile.perf:240: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> make: Leaving directory '/tmp/perf-6.1.0-rc3/tools/perf'
> =E2=AC=A2[acme@toolbox perf-6.1.0-rc3]$
>
>
>
> > The problem and solution were motivated by this issue and discussion:
> > https://lore.kernel.org/lkml/CAEf4BzbbOHQZUAe6iWaehKCPQAf3VC=3Dhq657buq=
e2_yRKxaK-A@mail.gmail.com/
> >
> > Ian Rogers (14):
> >   tools lib api: Add install target
> >   tools lib subcmd: Add install target
> >   perf build: Install libsubcmd locally when building
> >   perf build: Install libapi locally when building
> >   perf build: Install libperf locally when building
> >   perf build: Install libtraceevent locally when building
> >   tools lib api: Add missing install headers
> >   tools lib perf: Add missing install headers
> >   tool lib symbol: Add Makefile/Build
> >   perf build: Install libsymbol locally when building
> >   perf expr: Tidy hashmap dependency
> >   perf thread_map: Reduce exposure of libperf internal API
> >   perf cpumap: Tidy libperf includes
> >   perf build: Use tools/lib headers from install path
> >
> >  tools/lib/api/Makefile                        |  52 ++++++
> >  tools/lib/perf/Makefile                       |  10 +-
> >  tools/lib/subcmd/Makefile                     |  49 ++++++
> >  tools/lib/symbol/Build                        |   1 +
> >  tools/lib/symbol/Makefile                     | 115 +++++++++++++
> >  tools/perf/.gitignore                         |   7 +-
> >  tools/perf/Makefile.config                    |   2 -
> >  tools/perf/Makefile.perf                      | 152 ++++++++++++------
> >  tools/perf/builtin-stat.c                     |   1 +
> >  tools/perf/builtin-trace.c                    |   4 +-
> >  tools/perf/tests/cpumap.c                     |   2 +-
> >  tools/perf/tests/expr.c                       |   1 +
> >  tools/perf/tests/openat-syscall.c             |   1 +
> >  tools/perf/tests/pmu-events.c                 |   1 +
> >  tools/perf/tests/thread-map.c                 |   1 +
> >  tools/perf/util/Build                         |   5 -
> >  tools/perf/util/auxtrace.h                    |   2 +-
> >  tools/perf/util/bpf-loader.c                  |   4 -
> >  tools/perf/util/bpf_counter.c                 |   2 +-
> >  tools/perf/util/cpumap.c                      |   1 +
> >  tools/perf/util/cpumap.h                      |   2 +-
> >  tools/perf/util/evsel.c                       |   5 +-
> >  tools/perf/util/evsel.h                       |   2 -
> >  tools/perf/util/expr.c                        |   1 +
> >  tools/perf/util/expr.h                        |   7 +-
> >  tools/perf/util/metricgroup.c                 |   1 +
> >  tools/perf/util/python.c                      |   6 +-
> >  .../scripting-engines/trace-event-python.c    |   2 +-
> >  tools/perf/util/stat-shadow.c                 |   1 +
> >  tools/perf/util/stat.c                        |   4 -
> >  tools/perf/util/thread_map.c                  |   1 +
> >  tools/perf/util/thread_map.h                  |   2 -
> >  32 files changed, 361 insertions(+), 86 deletions(-)
> >  create mode 100644 tools/lib/symbol/Build
> >  create mode 100644 tools/lib/symbol/Makefile
> >
> > --
> > 2.38.1.431.g37b22c650d-goog
>
> --
>
> - Arnaldo
