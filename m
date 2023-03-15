Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745886BBDCD
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 21:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCOUNP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 16:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCOUNO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 16:13:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C93A97FE6;
        Wed, 15 Mar 2023 13:12:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9661061E6D;
        Wed, 15 Mar 2023 20:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B40C433EF;
        Wed, 15 Mar 2023 20:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678911168;
        bh=g0754OHqe2yFCjcPUTFuodgAheOV8MsvOBi98NuOpEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SC26OrW2tzrgsQ9j9uC5PSGxuQGrGVKOkiW7bauXVTRXuOts34OJ9BQO3uIkttk5a
         yPhrlUiUlUb+tk0VqpKuaiaUMKMwcPVMH7HESd6u3k+Sg4EfhEsvNYbxcUZ2snjyBF
         G68IhmLaPTN0/phBIjrYfoXyxhSjdZW6iT8BT62+RVWAF050bSgVpDL+CQbzambKh5
         vWPe74aPiPIamCEdwKGMaNB+SxzUhtgy9ZbdEuK3TJK6kwaRTYTIZDfx4WFF33jfeR
         UDGNYPEy7AhzS/jXu2+XfDP6umPgyAB94D9dfai7xdYNRCv9s/r9WSpip+rM9ovrcj
         5IVY7T2W/8weg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E8D9A4049F; Wed, 15 Mar 2023 17:12:44 -0300 (-03)
Date:   Wed, 15 Mar 2023 17:12:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 02/10] perf bpf filter: Implement event sample filtering
Message-ID: <ZBImvCSuWFUgjgQj@kernel.org>
References: <20230314234237.3008956-1-namhyung@kernel.org>
 <20230314234237.3008956-3-namhyung@kernel.org>
 <ZBHxRaP7BC+qDzJ/@kernel.org>
 <ZBH0s5P2KV5bJR3h@kernel.org>
 <CAM9d7cjrFT=c-Obw8TsVk3ntGtUEUoGzco8mUssiSPvuZN-iKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAM9d7cjrFT=c-Obw8TsVk3ntGtUEUoGzco8mUssiSPvuZN-iKw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Mar 15, 2023 at 09:51:03AM -0700, Namhyung Kim escreveu:
> On Wed, Mar 15, 2023 at 9:39=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Mar 15, 2023 at 01:24:37PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Em Tue, Mar 14, 2023 at 04:42:29PM -0700, Namhyung Kim escreveu:
> > > > The BPF program will be attached to a perf_event and be triggered w=
hen
> > > > it overflows.  It'd iterate the filters map and compare the sample
> > > > value according to the expression.  If any of them fails, the sample
> > > > would be dropped.
> > > >
> > > > Also it needs to have the corresponding sample data for the express=
ion
> > > > so it compares data->sample_flags with the given value.  To access =
the
> > > > sample data, it uses the bpf_cast_to_kern_ctx() kfunc which was add=
ed
> > > > in v6.2 kernel.
> > > >
> > > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > >
> > >
> > > I'm noticing this while building on a debian:11 container:
> > >
> > >   GENSKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
> > >   GENSKEL /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h
> > >   GENSKEL /tmp/build/perf/util/bpf_skel/func_latency.skel.h
> > >   GENSKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
> > >   GENSKEL /tmp/build/perf/util/bpf_skel/kwork_trace.skel.h
> > >   GENSKEL /tmp/build/perf/util/bpf_skel/sample_filter.skel.h
> > > libbpf: failed to find BTF for extern 'bpf_cast_to_kern_ctx' [21] sec=
tion: -2
> > > Error: failed to open BPF object file: No such file or directory
> > > make[2]: *** [Makefile.perf:1085: /tmp/build/perf/util/bpf_skel/sampl=
e_filter.skel.h] Error 254
> > > make[2]: *** Deleting file '/tmp/build/perf/util/bpf_skel/sample_filt=
er.skel.h'
> > > make[2]: *** Waiting for unfinished jobs....
> > > make[1]: *** [Makefile.perf:236: sub-make] Error 2
> > > make: *** [Makefile:70: all] Error 2
> > > make: Leaving directory '/git/perf-6.3.0-rc1/tools/perf'
> > > + exit 1
> > > [perfbuilder@five 11]$
> >
> > Same thing on debian:10
>=20
> Hmm.. I thought extern symbols with__ksym are runtime
> dependencies and it should build on old kernels too.
>=20
> BPF folks, any suggestions?

Fedora 33 also fails, see below, but these work:

[perfbuilder@five ~]$ grep Ok dm.log/summary=20
   1   131.48 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514=
 (Red Hat 8.5.0-16) , clang version 14.0.6 (Red Hat 14.0.6-1.module_el8.7.0=
+3277+b822483f)
   2   132.99 almalinux:9                   : Ok   gcc (GCC) 11.3.1 2022042=
1 (Red Hat 11.3.1-2) , clang version 14.0.6 (Red Hat 14.0.6-4.el9_1)
   3   162.36 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20=
211027) 10.3.1 20211027 , Alpine clang version 12.0.1
   4   155.25 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20=
220219) 11.2.1 20220219 , Alpine clang version 13.0.1
   5   136.69 alpine:3.17                   : Ok   gcc (Alpine 12.2.1_git20=
220924-r4) 12.2.1 20220924 , Alpine clang version 15.0.7
   6   158.08 alpine:edge                   : Ok   gcc (Alpine 12.2.1_git20=
220924-r9) 12.2.1 20220924 , Alpine clang version 15.0.7
  12   137.19 archlinux:base                : Ok   gcc (GCC) 12.2.0 , clang=
 version 14.0.6
  13   117.85 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514=
 (Red Hat 8.5.0-18) , clang version 15.0.7 (Red Hat 15.0.7-1.module_el8.8.0=
+1258+af79b238)
  17   122.65 debian:experimental           : Ok   gcc (Debian 12.2.0-14) 1=
2.2.0 , Debian clang version 14.0.6
  30   165.29 fedora:34                     : Ok   gcc (GCC) 11.3.1 2022042=
1 (Red Hat 11.3.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  33   153.26 fedora:35                     : Ok   gcc (GCC) 11.3.1 2022042=
1 (Red Hat 11.3.1-3) , clang version 13.0.1 (Fedora 13.0.1-1.fc35)
  34   152.66 fedora:36                     : Ok   gcc (GCC) 12.2.1 2022112=
1 (Red Hat 12.2.1-4) , clang version 14.0.5 (Fedora 14.0.5-2.fc36)
  35   154.36 fedora:37                     : Ok   gcc (GCC) 12.2.1 2022112=
1 (Red Hat 12.2.1-4) , clang version 15.0.7 (Fedora 15.0.7-1.fc37)
  36   145.45 fedora:38                     : Ok   gcc (GCC) 13.0.1 2023020=
8 (Red Hat 13.0.1-0) , clang version 15.0.7 (Fedora 15.0.7-2.fc38)
  37   166.89 fedora:rawhide                : Ok   gcc (GCC) 13.0.1 2023012=
7 (Red Hat 13.0.1-0) , clang version 15.0.7 (Fedora 15.0.7-2.fc38)
  44   146.10 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 ,=
 clang version 13.0.1
  45   165.87 opensuse:15.5                 : Ok   gcc (SUSE Linux) 7.5.0 ,=
 clang version 15.0.2
  46   167.90 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 12.2.1 =
20221020 [revision 0aaef83351473e8f4eb774f8f999bbe87a4866d7] , clang versio=
n 15.0.6
  47   130.58 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514=
 (Red Hat 8.5.0-16.0.2) , clang version 14.0.6 (Red Hat 14.0.6-1.0.1.module=
+el8.7.0+20823+214a699d)
  49   132.09 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514=
 (Red Hat 8.5.0-16) , clang version 14.0.6 (Red Hat 14.0.6-1.module+el8.7.0=
+1080+d88dc670)
  64   161.49 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.3.0-1ubun=
tu1~22.04) 11.3.0 , Ubuntu clang version 14.0.0-1ubuntu1
[perfbuilder@five ~]$

[perfbuilder@five ~]$ for a in `grep Ok dm.log/summary | cut -c15- | cut -d=
: -f1,2`; do grep -q GENSKEL.*sample_filter dm.log/$a && echo $a ; done
almalinux:8
almalinux:9
alpine:3.15
alpine:3.16
alpine:3.17
alpine:edge
archlinux:base
centos:stream
debian:experimental
fedora:34
fedora:35
fedora:36
fedora:37
fedora:38
fedora:rawhide
opensuse:15.4
opensuse:15.5
opensuse:tumbleweed
oraclelinux:8
rockylinux:8
ubuntu:22.04
[perfbuilder@five ~]$

Using built-in specs.
COLLECT_GCC=3Dgcc
COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/x86_64-redhat-linux/10/lto-wrapper
OFFLOAD_TARGET_NAMES=3Dnvptx-none
OFFLOAD_TARGET_DEFAULT=3D1
Target: x86_64-redhat-linux
Configured with: ../configure --enable-bootstrap --enable-languages=3Dc,c++=
,fortran,objc,obj-c++,ada,go,d,lto --prefix=3D/usr --mandir=3D/usr/share/ma=
n --infodir=3D/usr/share/info --with-bugurl=3Dhttp://bugzilla.redhat.com/bu=
gzilla --enable-shared --enable-threads=3Dposix --enable-checking=3Drelease=
 --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libun=
wind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-=
gcc-major-version-only --with-linker-hash-style=3Dgnu --enable-plugin --ena=
ble-initfini-array --with-isl --enable-offload-targets=3Dnvptx-none --witho=
ut-cuda-driver --enable-gnu-indirect-function --enable-cet --with-tune=3Dge=
neric --with-arch_32=3Di686 --build=3Dx86_64-redhat-linux
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 10.3.1 20210422 (Red Hat 10.3.1-1) (GCC)
+ make PYTHON=3Dpython3 ARCH=3D CROSS_COMPILE=3D EXTRA_CFLAGS=3D -C tools/p=
erf O=3D/tmp/build/perf
make: Entering directory '/git/perf-6.3.0-rc1/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
  HOSTCC  /tmp/build/perf/fixdep.o
  HOSTLD  /tmp/build/perf/fixdep-in.o
  LINK    /tmp/build/perf/fixdep
Makefile.config:1046: No libbabeltrace found, disables 'perf data' CTF form=
at support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1137: libpfm4 not found, disables libpfm4 support. Please i=
nstall libpfm4-dev

Auto-detecting system features:
=2E..                                   dwarf: [ on  ]
=2E..                      dwarf_getlocations: [ on  ]
=2E..                                   glibc: [ on  ]
=2E..                                  libbfd: [ on  ]
=2E..                          libbfd-buildid: [ on  ]
=2E..                                  libcap: [ on  ]
=2E..                                  libelf: [ on  ]
=2E..                                 libnuma: [ on  ]
=2E..                  numa_num_possible_cpus: [ on  ]
=2E..                                 libperl: [ on  ]
=2E..                               libpython: [ on  ]
=2E..                               libcrypto: [ on  ]
=2E..                               libunwind: [ on  ]
=2E..                      libdw-dwarf-unwind: [ on  ]
=2E..                                    zlib: [ on  ]
=2E..                                    lzma: [ on  ]
=2E..                               get_cpuid: [ on  ]
=2E..                                     bpf: [ on  ]
=2E..                                  libaio: [ on  ]
=2E..                                 libzstd: [ on  ]

  GEN     /tmp/build/perf/common-cmds.h
  PERF_VERSION =3D 6.3.rc1.gd34a77f6cd75
  GEN     perf-archive
  GEN     perf-iostat
  CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v0.o
  CC      /tmp/build/perf/dlfilters/dlfilter-show-cycles.o
  MKDIR   /tmp/build/perf/jvmti/
  MKDIR   /tmp/build/perf/jvmti/
  MKDIR   /tmp/build/perf/jvmti/
  MKDIR   /tmp/build/perf/jvmti/
  CC      /tmp/build/perf/jvmti/libjvmti.o
  CC      /tmp/build/perf/jvmti/jvmti_agent.o
  CC      /tmp/build/perf/jvmti/libstring.o
  CC      /tmp/build/perf/jvmti/libctype.o
  INSTALL /tmp/build/perf/libsubcmd/include/subcmd/exec-cmd.h
  INSTALL /tmp/build/perf/libsubcmd/include/subcmd/help.h
  INSTALL /tmp/build/perf/libsubcmd/include/subcmd/pager.h
  INSTALL /tmp/build/perf/libsubcmd/include/subcmd/parse-options.h
  INSTALL /tmp/build/perf/libsubcmd/include/subcmd/run-command.h
  CC      /tmp/build/perf/libsubcmd/exec-cmd.o
  CC      /tmp/build/perf/libsubcmd/help.o
  CC      /tmp/build/perf/libsubcmd/pager.o
  CC      /tmp/build/perf/libsubcmd/parse-options.o
  CC      /tmp/build/perf/libsubcmd/run-command.o
  CC      /tmp/build/perf/libsubcmd/sigchain.o
  CC      /tmp/build/perf/libsubcmd/subcmd-config.o
  LINK    /tmp/build/perf/dlfilters/dlfilter-show-cycles.so
  INSTALL libsubcmd_headers
  LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v0.so
  INSTALL /tmp/build/perf/libperf/include/perf/bpf_perf.h
  INSTALL /tmp/build/perf/libperf/include/perf/core.h
  INSTALL /tmp/build/perf/libperf/include/perf/cpumap.h
  INSTALL /tmp/build/perf/libperf/include/perf/threadmap.h
  INSTALL /tmp/build/perf/libsymbol/include/symbol/kallsyms.h
  INSTALL /tmp/build/perf/libapi/include/api/cpu.h
  INSTALL /tmp/build/perf/libperf/include/perf/evlist.h
  INSTALL /tmp/build/perf/libapi/include/api/debug.h
  INSTALL /tmp/build/perf/libperf/include/perf/evsel.h
  CC      /tmp/build/perf/libperf/core.o
  CC      /tmp/build/perf/libsymbol/kallsyms.o
  CC      /tmp/build/perf/libperf/cpumap.o
  INSTALL /tmp/build/perf/libapi/include/api/io.h
  INSTALL /tmp/build/perf/libperf/include/perf/event.h
  INSTALL /tmp/build/perf/libapi/include/api/fd/array.h
  MKDIR   /tmp/build/perf/libapi/fd/
  CC      /tmp/build/perf/libperf/threadmap.o
  INSTALL libsymbol_headers
  INSTALL /tmp/build/perf/libperf/include/perf/mmap.h
  INSTALL /tmp/build/perf/libapi/include/api/fs/fs.h
  CC      /tmp/build/perf/libperf/evsel.o
  GEN     /tmp/build/perf/libbpf/bpf_helper_defs.h
  CC      /tmp/build/perf/libperf/evlist.o
  MKDIR   /tmp/build/perf/libapi/fs/
  INSTALL /tmp/build/perf/libapi/include/api/fs/tracing_path.h
  MKDIR   /tmp/build/perf/libapi/fs/
  CC      /tmp/build/perf/libapi/fd/array.o
  CC      /tmp/build/perf/libperf/mmap.o
  MKDIR   /tmp/build/perf/libapi/fs/
  CC      /tmp/build/perf/libperf/zalloc.o
  CC      /tmp/build/perf/libapi/fs/fs.o
  CC      /tmp/build/perf/libperf/xyarray.o
  CC      /tmp/build/perf/libperf/lib.o
  CC      /tmp/build/perf/libapi/fs/tracing_path.o
  CC      /tmp/build/perf/libapi/fs/cgroup.o
  INSTALL /tmp/build/perf/libperf/include/internal/cpumap.h
  INSTALL /tmp/build/perf/libperf/include/internal/evlist.h
  CC      /tmp/build/perf/libapi/cpu.o
  CC      /tmp/build/perf/libapi/debug.o
  CC      /tmp/build/perf/libapi/str_error_r.o
  INSTALL /tmp/build/perf/libperf/include/internal/evsel.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf.h
  INSTALL /tmp/build/perf/libperf/include/internal/lib.h
  INSTALL libapi_headers
  INSTALL /tmp/build/perf/libperf/include/internal/mmap.h
  INSTALL /tmp/build/perf/libperf/include/internal/threadmap.h
  INSTALL /tmp/build/perf/libperf/include/internal/xyarray.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/btf.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_common.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_legacy.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_helpers.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_tracing.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_endian.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_core_read.h
  INSTALL libperf_headers
  INSTALL /tmp/build/perf/libbpf/include/bpf/skel_internal.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_version.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/usdt.bpf.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  INSTALL libbpf_headers
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  LD      /tmp/build/perf/libsymbol/libsymbol-in.o
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  LD      /tmp/build/perf/libapi/fd/libapi-in.o
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  CC      /tmp/build/perf/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /tmp/build/perf/libbpf/staticobjs/libbpf.o
  CC      /tmp/build/perf/libbpf/staticobjs/bpf.o
  CC      /tmp/build/perf/libbpf/staticobjs/nlattr.o
  CC      /tmp/build/perf/libbpf/staticobjs/btf.o
  CC      /tmp/build/perf/libbpf/staticobjs/libbpf_errno.o
  CC      /tmp/build/perf/libbpf/staticobjs/str_error.o
  CC      /tmp/build/perf/libbpf/staticobjs/netlink.o
  CC      /tmp/build/perf/libbpf/staticobjs/libbpf_probes.o
  CC      /tmp/build/perf/libbpf/staticobjs/hashmap.o
  CC      /tmp/build/perf/libbpf/staticobjs/btf_dump.o
  AR      /tmp/build/perf/libsymbol/libsymbol.a
  CC      /tmp/build/perf/libbpf/staticobjs/ringbuf.o
  LD      /tmp/build/perf/jvmti/jvmti-in.o
  CC      /tmp/build/perf/libbpf/staticobjs/strset.o
  CC      /tmp/build/perf/libbpf/staticobjs/linker.o
  CC      /tmp/build/perf/libbpf/staticobjs/gen_loader.o
  CC      /tmp/build/perf/libbpf/staticobjs/relo_core.o
  CC      /tmp/build/perf/libbpf/staticobjs/usdt.o
  LD      /tmp/build/perf/libapi/fs/libapi-in.o
  LINK    /tmp/build/perf/libperf-jvmti.so
  LD      /tmp/build/perf/libapi/libapi-in.o
  LD      /tmp/build/perf/libperf/libperf-in.o
  AR      /tmp/build/perf/libapi/libapi.a
  AR      /tmp/build/perf/libperf/libperf.a
  LD      /tmp/build/perf/libsubcmd/libsubcmd-in.o
  AR      /tmp/build/perf/libsubcmd/libsubcmd.a
  GEN     /tmp/build/perf/python/perf.cpython-39-x86_64-linux-gnu.so

Auto-detecting system features:
=2E..                         clang-bpf-co-re: [ on  ]
=2E..                                    llvm: [ on  ]
=2E..                                  libcap: [ on  ]
=2E..                                  libbfd: [ on  ]

  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/h=
ashmap.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/r=
elo_core.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/l=
ibbpf_internal.h
  GEN     /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/bpf_helper_de=
fs.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/l=
ibbpf.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/b=
pf.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/b=
tf.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/l=
ibbpf_common.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/l=
ibbpf_legacy.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/b=
pf_helpers.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/b=
pf_tracing.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/b=
pf_endian.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/b=
pf_core_read.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/s=
kel_internal.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/l=
ibbpf_version.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/u=
sdt.bpf.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/b=
pf_helper_defs.h
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
  INSTALL libbpf_headers
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/li=
bbpf_probes.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/li=
bbpf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bp=
f.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/nl=
attr.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bt=
f.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/li=
bbpf_errno.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/ha=
shmap.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/st=
r_error.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/ne=
tlink.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bp=
f_prog_linfo.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bt=
f_dump.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/ri=
ngbuf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/st=
rset.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/li=
nker.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/ge=
n_loader.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/re=
lo_core.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/us=
dt.o
  LD      /tmp/build/perf/libbpf/staticobjs/libbpf-in.o
  LINK    /tmp/build/perf/libbpf/libbpf.a
  LD      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/li=
bbpf-in.o
  LINK    /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/main.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/common.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/json_writer.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/gen.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/btf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/xlated_dumper.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/btf_dumper.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/disasm.o
  LINK    /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/bpftool
  GEN     /tmp/build/perf/util/bpf_skel/vmlinux.h
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/func_latency.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/off_cpu.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/lock_contention.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/kwork_trace.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/sample_filter.bpf.o
  GENSKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/func_latency.skel.h
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_fra=
me
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_fra=
me
libbpf: elf: skipping relo section(14) .rel.eh_frame for section(8) .eh_fra=
me
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_fra=
me
  GENSKEL /tmp/build/perf/util/bpf_skel/kwork_trace.skel.h
libbpf: elf: skipping unrecognized data section(17) .eh_frame
libbpf: elf: skipping relo section(29) .rel.eh_frame for section(17) .eh_fr=
ame
  GENSKEL /tmp/build/perf/util/bpf_skel/sample_filter.skel.h
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_fra=
me
libbpf: failed to find BTF for extern 'bpf_cast_to_kern_ctx' [21] section: =
-2
Error: failed to open BPF object file: No such file or directory
make[2]: *** [Makefile.perf:1085: /tmp/build/perf/util/bpf_skel/sample_filt=
er.skel.h] Error 254
make[2]: *** Deleting file '/tmp/build/perf/util/bpf_skel/sample_filter.ske=
l.h'
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:236: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/git/perf-6.3.0-rc1/tools/perf'
+ exit 1
[perfbuilder@five 33]$ fg

=20
> Thanks,
> Namhyung
>=20
>=20
> >
> > libbpf: failed to find BTF for extern 'bpf_cast_to_kern_ctx' [21] secti=
on: -2
> > Error: failed to open BPF object file: No such file or directory
> > make[2]: *** [Makefile.perf:1085: /tmp/build/perf/util/bpf_skel/sample_=
filter.skel.h] Error 254
> > make[2]: *** Deleting file '/tmp/build/perf/util/bpf_skel/sample_filter=
=2Eskel.h'
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [Makefile.perf:236: sub-make] Error 2
> > make: *** [Makefile:70: all] Error 2
> > make: Leaving directory '/git/perf-6.3.0-rc1/tools/perf'
> > + exit 1
> > [perfbuilder@five 10]$
> >
> > Works with debian:experimental:
> >
> >
> > [perfbuilder@five experimental]$ export BUILD_TARBALL=3Dhttp://192.168.=
86.10/perf/perf-6.3.0-rc1.tar.xz
> > [perfbuilder@five experimental]$ time dm .
> >    1   147.54 debian:experimental           : Ok   gcc (Debian 12.2.0-1=
4) 12.2.0 , Debian clang version 14.0.6
> > BUILD_TARBALL_HEAD=3Dd34a77f6cd75d2a75c64e78f3d949a12903a7cf0
> >
> > Both with:
> >
> > Debian clang version 14.0.6
> > Target: x86_64-pc-linux-gnu
> > Thread model: posix
> > InstalledDir: /usr/bin
> > Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/=
12
> > Selected GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/12
> > Candidate multilib: .;@m64
> > Selected multilib: .;@m64
> > + rm -rf /tmp/build/perf
> > + mkdir /tmp/build/perf
> > + make ARCH=3D CROSS_COMPILE=3D EXTRA_CFLAGS=3D -C tools/perf O=3D/tmp/=
build/perf CC=3Dclang
> >
> > and:
> >
> > COLLECT_GCC=3Dgcc
> > COLLECT_LTO_WRAPPER=3D/usr/lib/gcc/x86_64-linux-gnu/12/lto-wrapper
> > OFFLOAD_TARGET_NAMES=3Dnvptx-none:amdgcn-amdhsa
> > OFFLOAD_TARGET_DEFAULT=3D1
> > Target: x86_64-linux-gnu
> > Configured with: ../src/configure -v --with-pkgversion=3D'Debian 12.2.0=
-14' --with-bugurl=3Dfile:///usr/share/doc/gcc-12/README.Bugs --enable-lang=
uages=3Dc,ada,c++,go,d,fortran,objc,obj-c++,m2 --prefix=3D/usr --with-gcc-m=
ajor-version-only --program-suffix=3D-12 --program-prefix=3Dx86_64-linux-gn=
u- --enable-shared --enable-linker-build-id --libexecdir=3D/usr/lib --witho=
ut-included-gettext --enable-threads=3Dposix --libdir=3D/usr/lib --enable-n=
ls --enable-clocale=3Dgnu --enable-libstdcxx-debug --enable-libstdcxx-time=
=3Dyes --with-default-libstdcxx-abi=3Dnew --enable-gnu-unique-object --disa=
ble-vtable-verify --enable-plugin --enable-default-pie --with-system-zlib -=
-enable-libphobos-checking=3Drelease --with-target-system-zlib=3Dauto --ena=
ble-objc-gc=3Dauto --enable-multiarch --disable-werror --enable-cet --with-=
arch-32=3Di686 --with-abi=3Dm64 --with-multilib-list=3Dm32,m64,mx32 --enabl=
e-multilib --with-tune=3Dgeneric --enable-offload-targets=3Dnvptx-none=3D/b=
uild/gcc-12-bTRWOB/gcc-12-12.2.0/debian/tmp-nvptx/usr,amdgcn-amdhsa=3D/buil=
d/gcc-12-bTRWOB/gcc-12-12.2.0/debian/tmp-gcn/usr --enable-offload-defaulted=
 --without-cuda-driver --enable-checking=3Drelease --build=3Dx86_64-linux-g=
nu --host=3Dx86_64-linux-gnu --target=3Dx86_64-linux-gnu
> > Thread model: posix
> > Supported LTO compression algorithms: zlib zstd
> > gcc version 12.2.0 (Debian 12.2.0-14)
> > + make ARCH=3D CROSS_COMPILE=3D EXTRA_CFLAGS=3D -C tools/perf O=3D/tmp/=
build/perf
> > make: Entering directory '/git/perf-6.3.0-rc1/tools/perf'
> >
> >
> > >
> > > > ---
> > > >  tools/perf/Makefile.perf                     |   2 +-
> > > >  tools/perf/util/bpf-filter.c                 |  64 ++++++++++
> > > >  tools/perf/util/bpf-filter.h                 |  26 ++--
> > > >  tools/perf/util/bpf_skel/sample-filter.h     |  24 ++++
> > > >  tools/perf/util/bpf_skel/sample_filter.bpf.c | 126 +++++++++++++++=
++++
> > > >  tools/perf/util/evsel.h                      |   7 +-
> > > >  6 files changed, 236 insertions(+), 13 deletions(-)
> > > >  create mode 100644 tools/perf/util/bpf_skel/sample-filter.h
> > > >  create mode 100644 tools/perf/util/bpf_skel/sample_filter.bpf.c
> > > >
> > > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > > index dc9dda09b076..ed6b6a070f79 100644
> > > > --- a/tools/perf/Makefile.perf
> > > > +++ b/tools/perf/Makefile.perf
> > > > @@ -1050,7 +1050,7 @@ SKELETONS :=3D $(SKEL_OUT)/bpf_prog_profiler.=
skel.h
> > > >  SKELETONS +=3D $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_f=
ollower.skel.h
> > > >  SKELETONS +=3D $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_la=
tency.skel.h
> > > >  SKELETONS +=3D $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_content=
ion.skel.h
> > > > -SKELETONS +=3D $(SKEL_OUT)/kwork_trace.skel.h
> > > > +SKELETONS +=3D $(SKEL_OUT)/kwork_trace.skel.h $(SKEL_OUT)/sample_f=
ilter.skel.h
> > > >
> > > >  $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT=
) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
> > > >     $(Q)$(MKDIR) -p $@
> > > > diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-fil=
ter.c
> > > > index c72e35d51240..f20e1bc03778 100644
> > > > --- a/tools/perf/util/bpf-filter.c
> > > > +++ b/tools/perf/util/bpf-filter.c
> > > > @@ -1,10 +1,74 @@
> > > >  /* SPDX-License-Identifier: GPL-2.0 */
> > > >  #include <stdlib.h>
> > > >
> > > > +#include <bpf/bpf.h>
> > > > +#include <linux/err.h>
> > > > +#include <internal/xyarray.h>
> > > > +
> > > > +#include "util/debug.h"
> > > > +#include "util/evsel.h"
> > > > +
> > > >  #include "util/bpf-filter.h"
> > > >  #include "util/bpf-filter-flex.h"
> > > >  #include "util/bpf-filter-bison.h"
> > > >
> > > > +#include "bpf_skel/sample-filter.h"
> > > > +#include "bpf_skel/sample_filter.skel.h"
> > > > +
> > > > +#define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
> > > > +
> > > > +int perf_bpf_filter__prepare(struct evsel *evsel)
> > > > +{
> > > > +   int i, x, y, fd;
> > > > +   struct sample_filter_bpf *skel;
> > > > +   struct bpf_program *prog;
> > > > +   struct bpf_link *link;
> > > > +   struct perf_bpf_filter_expr *expr;
> > > > +
> > > > +   skel =3D sample_filter_bpf__open_and_load();
> > > > +   if (!skel) {
> > > > +           pr_err("Failed to load perf sample-filter BPF skeleton\=
n");
> > > > +           return -1;
> > > > +   }
> > > > +
> > > > +   i =3D 0;
> > > > +   fd =3D bpf_map__fd(skel->maps.filters);
> > > > +   list_for_each_entry(expr, &evsel->bpf_filters, list) {
> > > > +           struct perf_bpf_filter_entry entry =3D {
> > > > +                   .op =3D expr->op,
> > > > +                   .flags =3D expr->sample_flags,
> > > > +                   .value =3D expr->val,
> > > > +           };
> > > > +           bpf_map_update_elem(fd, &i, &entry, BPF_ANY);
> > > > +           i++;
> > > > +   }
> > > > +
> > > > +   prog =3D skel->progs.perf_sample_filter;
> > > > +   for (x =3D 0; x < xyarray__max_x(evsel->core.fd); x++) {
> > > > +           for (y =3D 0; y < xyarray__max_y(evsel->core.fd); y++) {
> > > > +                   link =3D bpf_program__attach_perf_event(prog, F=
D(evsel, x, y));
> > > > +                   if (IS_ERR(link)) {
> > > > +                           pr_err("Failed to attach perf sample-fi=
lter program\n");
> > > > +                           return PTR_ERR(link);
> > > > +                   }
> > > > +           }
> > > > +   }
> > > > +   evsel->bpf_skel =3D skel;
> > > > +   return 0;
> > > > +}
> > > > +
> > > > +int perf_bpf_filter__destroy(struct evsel *evsel)
> > > > +{
> > > > +   struct perf_bpf_filter_expr *expr, *tmp;
> > > > +
> > > > +   list_for_each_entry_safe(expr, tmp, &evsel->bpf_filters, list) {
> > > > +           list_del(&expr->list);
> > > > +           free(expr);
> > > > +   }
> > > > +   sample_filter_bpf__destroy(evsel->bpf_skel);
> > > > +   return 0;
> > > > +}
> > > > +
> > > >  struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned lo=
ng sample_flags,
> > > >                                                    enum perf_bpf_fi=
lter_op op,
> > > >                                                    unsigned long va=
l)
> > > > diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-fil=
ter.h
> > > > index 93a0d3de038c..eb8e1ac43cdf 100644
> > > > --- a/tools/perf/util/bpf-filter.h
> > > > +++ b/tools/perf/util/bpf-filter.h
> > > > @@ -4,15 +4,7 @@
> > > >
> > > >  #include <linux/list.h>
> > > >
> > > > -enum perf_bpf_filter_op {
> > > > -   PBF_OP_EQ,
> > > > -   PBF_OP_NEQ,
> > > > -   PBF_OP_GT,
> > > > -   PBF_OP_GE,
> > > > -   PBF_OP_LT,
> > > > -   PBF_OP_LE,
> > > > -   PBF_OP_AND,
> > > > -};
> > > > +#include "bpf_skel/sample-filter.h"
> > > >
> > > >  struct perf_bpf_filter_expr {
> > > >     struct list_head list;
> > > > @@ -21,16 +13,30 @@ struct perf_bpf_filter_expr {
> > > >     unsigned long val;
> > > >  };
> > > >
> > > > +struct evsel;
> > > > +
> > > >  #ifdef HAVE_BPF_SKEL
> > > >  struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned lo=
ng sample_flags,
> > > >                                                    enum perf_bpf_fi=
lter_op op,
> > > >                                                    unsigned long va=
l);
> > > >  int perf_bpf_filter__parse(struct list_head *expr_head, const char=
 *str);
> > > > +int perf_bpf_filter__prepare(struct evsel *evsel);
> > > > +int perf_bpf_filter__destroy(struct evsel *evsel);
> > > > +
> > > >  #else /* !HAVE_BPF_SKEL */
> > > > +
> > > >  static inline int perf_bpf_filter__parse(struct list_head *expr_he=
ad __maybe_unused,
> > > >                                      const char *str __maybe_unused)
> > > >  {
> > > > -   return -ENOSYS;
> > > > +   return -EOPNOTSUPP;
> > > > +}
> > > > +static inline int perf_bpf_filter__prepare(struct evsel *evsel __m=
aybe_unused)
> > > > +{
> > > > +   return -EOPNOTSUPP;
> > > > +}
> > > > +static inline int perf_bpf_filter__destroy(struct evsel *evsel __m=
aybe_unused)
> > > > +{
> > > > +   return -EOPNOTSUPP;
> > > >  }
> > > >  #endif /* HAVE_BPF_SKEL*/
> > > >  #endif /* PERF_UTIL_BPF_FILTER_H */
> > > > diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/=
util/bpf_skel/sample-filter.h
> > > > new file mode 100644
> > > > index 000000000000..862060bfda14
> > > > --- /dev/null
> > > > +++ b/tools/perf/util/bpf_skel/sample-filter.h
> > > > @@ -0,0 +1,24 @@
> > > > +#ifndef PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H
> > > > +#define PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H
> > > > +
> > > > +#define MAX_FILTERS  32
> > > > +
> > > > +/* supported filter operations */
> > > > +enum perf_bpf_filter_op {
> > > > +   PBF_OP_EQ,
> > > > +   PBF_OP_NEQ,
> > > > +   PBF_OP_GT,
> > > > +   PBF_OP_GE,
> > > > +   PBF_OP_LT,
> > > > +   PBF_OP_LE,
> > > > +   PBF_OP_AND
> > > > +};
> > > > +
> > > > +/* BPF map entry for filtering */
> > > > +struct perf_bpf_filter_entry {
> > > > +   enum perf_bpf_filter_op op;
> > > > +   __u64 flags;
> > > > +   __u64 value;
> > > > +};
> > > > +
> > > > +#endif /* PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H */
> > > > \ No newline at end of file
> > > > diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/p=
erf/util/bpf_skel/sample_filter.bpf.c
> > > > new file mode 100644
> > > > index 000000000000..c07256279c3e
> > > > --- /dev/null
> > > > +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > > > @@ -0,0 +1,126 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +// Copyright (c) 2023 Google
> > > > +#include "vmlinux.h"
> > > > +#include <bpf/bpf_helpers.h>
> > > > +#include <bpf/bpf_tracing.h>
> > > > +#include <bpf/bpf_core_read.h>
> > > > +
> > > > +#include "sample-filter.h"
> > > > +
> > > > +/* BPF map that will be filled by user space */
> > > > +struct filters {
> > > > +   __uint(type, BPF_MAP_TYPE_ARRAY);
> > > > +   __type(key, int);
> > > > +   __type(value, struct perf_bpf_filter_entry);
> > > > +   __uint(max_entries, MAX_FILTERS);
> > > > +} filters SEC(".maps");
> > > > +
> > > > +int dropped;
> > > > +
> > > > +void *bpf_cast_to_kern_ctx(void *) __ksym;
> > > > +
> > > > +/* new kernel perf_sample_data definition */
> > > > +struct perf_sample_data___new {
> > > > +   __u64 sample_flags;
> > > > +} __attribute__((preserve_access_index));
> > > > +
> > > > +/* helper function to return the given perf sample data */
> > > > +static inline __u64 perf_get_sample(struct bpf_perf_event_data_ker=
n *kctx,
> > > > +                               struct perf_bpf_filter_entry *entry)
> > > > +{
> > > > +   struct perf_sample_data___new *data =3D (void *)kctx->data;
> > > > +
> > > > +   if (!bpf_core_field_exists(data->sample_flags) ||
> > > > +       (data->sample_flags & entry->flags) =3D=3D 0)
> > > > +           return 0;
> > > > +
> > > > +   switch (entry->flags) {
> > > > +   case PERF_SAMPLE_IP:
> > > > +           return kctx->data->ip;
> > > > +   case PERF_SAMPLE_ID:
> > > > +           return kctx->data->id;
> > > > +   case PERF_SAMPLE_TID:
> > > > +           return kctx->data->tid_entry.tid;
> > > > +   case PERF_SAMPLE_CPU:
> > > > +           return kctx->data->cpu_entry.cpu;
> > > > +   case PERF_SAMPLE_TIME:
> > > > +           return kctx->data->time;
> > > > +   case PERF_SAMPLE_ADDR:
> > > > +           return kctx->data->addr;
> > > > +   case PERF_SAMPLE_PERIOD:
> > > > +           return kctx->data->period;
> > > > +   case PERF_SAMPLE_TRANSACTION:
> > > > +           return kctx->data->txn;
> > > > +   case PERF_SAMPLE_WEIGHT:
> > > > +           return kctx->data->weight.full;
> > > > +   case PERF_SAMPLE_PHYS_ADDR:
> > > > +           return kctx->data->phys_addr;
> > > > +   case PERF_SAMPLE_CODE_PAGE_SIZE:
> > > > +           return kctx->data->code_page_size;
> > > > +   case PERF_SAMPLE_DATA_PAGE_SIZE:
> > > > +           return kctx->data->data_page_size;
> > > > +   default:
> > > > +           break;
> > > > +   }
> > > > +   return 0;
> > > > +}
> > > > +
> > > > +/* BPF program to be called from perf event overflow handler */
> > > > +SEC("perf_event")
> > > > +int perf_sample_filter(void *ctx)
> > > > +{
> > > > +   struct bpf_perf_event_data_kern *kctx;
> > > > +   struct perf_bpf_filter_entry *entry;
> > > > +   __u64 sample_data;
> > > > +   int i;
> > > > +
> > > > +   kctx =3D bpf_cast_to_kern_ctx(ctx);
> > > > +
> > > > +   for (i =3D 0; i < MAX_FILTERS; i++) {
> > > > +           int key =3D i; /* needed for verifier :( */
> > > > +
> > > > +           entry =3D bpf_map_lookup_elem(&filters, &key);
> > > > +           if (entry =3D=3D NULL)
> > > > +                   break;
> > > > +           sample_data =3D perf_get_sample(kctx, entry);
> > > > +
> > > > +           switch (entry->op) {
> > > > +           case PBF_OP_EQ:
> > > > +                   if (!(sample_data =3D=3D entry->value))
> > > > +                           goto drop;
> > > > +                   break;
> > > > +           case PBF_OP_NEQ:
> > > > +                   if (!(sample_data !=3D entry->value))
> > > > +                           goto drop;
> > > > +                   break;
> > > > +           case PBF_OP_GT:
> > > > +                   if (!(sample_data > entry->value))
> > > > +                           goto drop;
> > > > +                   break;
> > > > +           case PBF_OP_GE:
> > > > +                   if (!(sample_data >=3D entry->value))
> > > > +                           goto drop;
> > > > +                   break;
> > > > +           case PBF_OP_LT:
> > > > +                   if (!(sample_data < entry->value))
> > > > +                           goto drop;
> > > > +                   break;
> > > > +           case PBF_OP_LE:
> > > > +                   if (!(sample_data <=3D entry->value))
> > > > +                           goto drop;
> > > > +                   break;
> > > > +           case PBF_OP_AND:
> > > > +                   if (!(sample_data & entry->value))
> > > > +                           goto drop;
> > > > +                   break;
> > > > +           }
> > > > +   }
> > > > +   /* generate sample data */
> > > > +   return 1;
> > > > +
> > > > +drop:
> > > > +   __sync_fetch_and_add(&dropped, 1);
> > > > +   return 0;
> > > > +}
> > > > +
> > > > +char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
> > > > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > > > index c272c06565c0..68072ec655ce 100644
> > > > --- a/tools/perf/util/evsel.h
> > > > +++ b/tools/perf/util/evsel.h
> > > > @@ -150,8 +150,10 @@ struct evsel {
> > > >      */
> > > >     struct bpf_counter_ops  *bpf_counter_ops;
> > > >
> > > > -   /* for perf-stat -b */
> > > > -   struct list_head        bpf_counter_list;
> > > > +   union {
> > > > +           struct list_head        bpf_counter_list; /* for perf-s=
tat -b */
> > > > +           struct list_head        bpf_filters; /* for perf-record=
 --filter */
> > > > +   };
> > > >
> > > >     /* for perf-stat --use-bpf */
> > > >     int                     bperf_leader_prog_fd;
> > > > @@ -159,6 +161,7 @@ struct evsel {
> > > >     union {
> > > >             struct bperf_leader_bpf *leader_skel;
> > > >             struct bperf_follower_bpf *follower_skel;
> > > > +           void *bpf_skel;
> > > >     };
> > > >     unsigned long           open_flags;
> > > >     int                     precise_ip_original;
> > > > --
> > > > 2.40.0.rc1.284.g88254d51c5-goog
> > > >
> > >
> > > --
> > >
> > > - Arnaldo
> >
> > --
> >
> > - Arnaldo

--=20

- Arnaldo
