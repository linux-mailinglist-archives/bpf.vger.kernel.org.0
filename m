Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00A86BBA32
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 17:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjCOQvS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 15 Mar 2023 12:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjCOQvR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 12:51:17 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCFF3C0E;
        Wed, 15 Mar 2023 09:51:15 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id g6so8079230iov.13;
        Wed, 15 Mar 2023 09:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678899075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=to46wqpcUpRiCJFUTvKaXabbwPqf75Nx4TGMntb563k=;
        b=69qi2+YbuSlSO9cJ+xYtCY6gJcAelqrz0kTghhEvYfvSiUGv95xBvR10mPKCrSj0Ko
         PYEi7opbT0o1P6j/q1LrEDNvddDZaWGvq/BY58lRRaFlgKDUc+HALDt8Rs0beKmaoNM+
         8H7ufcRueW+R9YPMZ+UmLdGqkpML34CDcaRNUNmzMJ1pgCabLKqz0JFVlW+Anaxpm06U
         LdQ0VHSbVwo5PfnXampVlVzs1xLouqqADAnbUEKeq69RjbG14hwlIqt5H6/GafwfxlVq
         cSnalAvrmcDs8Sqmhez8loUz8Ad3V1QfOsIdeMnpMg7H9UHv/VNMt8ciWQW0iNUJkN/0
         zxUw==
X-Gm-Message-State: AO0yUKXyb59rZP2AeTOFtwHoajWJMGaprj25DHum8mj+Zahg9NHvjXB4
        l9rkSijXdlbRXXYhwAYpKvroHOtmTOpQp6zaI/E=
X-Google-Smtp-Source: AK7set9zMHo4JNWp06axiugZYKrl+EPq5+mjbbbt084jmN80YVpH3BTq63ZfZMYSGhHWoK1kfih/XkdA+Qo4++Qq3/s=
X-Received: by 2002:a5d:8d87:0:b0:744:f5bb:6e60 with SMTP id
 b7-20020a5d8d87000000b00744f5bb6e60mr19953396ioj.1.1678899074752; Wed, 15 Mar
 2023 09:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230314234237.3008956-1-namhyung@kernel.org> <20230314234237.3008956-3-namhyung@kernel.org>
 <ZBHxRaP7BC+qDzJ/@kernel.org> <ZBH0s5P2KV5bJR3h@kernel.org>
In-Reply-To: <ZBH0s5P2KV5bJR3h@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 15 Mar 2023 09:51:03 -0700
Message-ID: <CAM9d7cjrFT=c-Obw8TsVk3ntGtUEUoGzco8mUssiSPvuZN-iKw@mail.gmail.com>
Subject: Re: [PATCH 02/10] perf bpf filter: Implement event sample filtering
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 15, 2023 at 9:39 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Mar 15, 2023 at 01:24:37PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Mar 14, 2023 at 04:42:29PM -0700, Namhyung Kim escreveu:
> > > The BPF program will be attached to a perf_event and be triggered when
> > > it overflows.  It'd iterate the filters map and compare the sample
> > > value according to the expression.  If any of them fails, the sample
> > > would be dropped.
> > >
> > > Also it needs to have the corresponding sample data for the expression
> > > so it compares data->sample_flags with the given value.  To access the
> > > sample data, it uses the bpf_cast_to_kern_ctx() kfunc which was added
> > > in v6.2 kernel.
> > >
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> >
> > I'm noticing this while building on a debian:11 container:
> >
> >   GENSKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
> >   GENSKEL /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h
> >   GENSKEL /tmp/build/perf/util/bpf_skel/func_latency.skel.h
> >   GENSKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
> >   GENSKEL /tmp/build/perf/util/bpf_skel/kwork_trace.skel.h
> >   GENSKEL /tmp/build/perf/util/bpf_skel/sample_filter.skel.h
> > libbpf: failed to find BTF for extern 'bpf_cast_to_kern_ctx' [21] section: -2
> > Error: failed to open BPF object file: No such file or directory
> > make[2]: *** [Makefile.perf:1085: /tmp/build/perf/util/bpf_skel/sample_filter.skel.h] Error 254
> > make[2]: *** Deleting file '/tmp/build/perf/util/bpf_skel/sample_filter.skel.h'
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [Makefile.perf:236: sub-make] Error 2
> > make: *** [Makefile:70: all] Error 2
> > make: Leaving directory '/git/perf-6.3.0-rc1/tools/perf'
> > + exit 1
> > [perfbuilder@five 11]$
>
> Same thing on debian:10

Hmm.. I thought extern symbols with__ksym are runtime
dependencies and it should build on old kernels too.

BPF folks, any suggestions?

Thanks,
Namhyung


>
> libbpf: failed to find BTF for extern 'bpf_cast_to_kern_ctx' [21] section: -2
> Error: failed to open BPF object file: No such file or directory
> make[2]: *** [Makefile.perf:1085: /tmp/build/perf/util/bpf_skel/sample_filter.skel.h] Error 254
> make[2]: *** Deleting file '/tmp/build/perf/util/bpf_skel/sample_filter.skel.h'
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [Makefile.perf:236: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> make: Leaving directory '/git/perf-6.3.0-rc1/tools/perf'
> + exit 1
> [perfbuilder@five 10]$
>
> Works with debian:experimental:
>
>
> [perfbuilder@five experimental]$ export BUILD_TARBALL=http://192.168.86.10/perf/perf-6.3.0-rc1.tar.xz
> [perfbuilder@five experimental]$ time dm .
>    1   147.54 debian:experimental           : Ok   gcc (Debian 12.2.0-14) 12.2.0 , Debian clang version 14.0.6
> BUILD_TARBALL_HEAD=d34a77f6cd75d2a75c64e78f3d949a12903a7cf0
>
> Both with:
>
> Debian clang version 14.0.6
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/12
> Selected GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/12
> Candidate multilib: .;@m64
> Selected multilib: .;@m64
> + rm -rf /tmp/build/perf
> + mkdir /tmp/build/perf
> + make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= -C tools/perf O=/tmp/build/perf CC=clang
>
> and:
>
> COLLECT_GCC=gcc
> COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/12/lto-wrapper
> OFFLOAD_TARGET_NAMES=nvptx-none:amdgcn-amdhsa
> OFFLOAD_TARGET_DEFAULT=1
> Target: x86_64-linux-gnu
> Configured with: ../src/configure -v --with-pkgversion='Debian 12.2.0-14' --with-bugurl=file:///usr/share/doc/gcc-12/README.Bugs --enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++,m2 --prefix=/usr --with-gcc-major-version-only --program-suffix=-12 --program-prefix=x86_64-linux-gnu- --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --libdir=/usr/lib --enable-nls --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-vtable-verify --enable-plugin --enable-default-pie --with-system-zlib --enable-libphobos-checking=release --with-target-system-zlib=auto --enable-objc-gc=auto --enable-multiarch --disable-werror --enable-cet --with-arch-32=i686 --with-abi=m64 --with-multilib-list=m32,m64,mx32 --enable-multilib --with-tune=generic --enable-offload-targets=nvptx-none=/build/gcc-12-bTRWOB/gcc-12-12.2.0/debian/tmp-nvptx/usr,amdgcn-amdhsa=/build/gcc-12-bTRWOB/gcc-12-12.2.0/debian/tmp-gcn/usr --enable-offload-defaulted --without-cuda-driver --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu
> Thread model: posix
> Supported LTO compression algorithms: zlib zstd
> gcc version 12.2.0 (Debian 12.2.0-14)
> + make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= -C tools/perf O=/tmp/build/perf
> make: Entering directory '/git/perf-6.3.0-rc1/tools/perf'
>
>
> >
> > > ---
> > >  tools/perf/Makefile.perf                     |   2 +-
> > >  tools/perf/util/bpf-filter.c                 |  64 ++++++++++
> > >  tools/perf/util/bpf-filter.h                 |  26 ++--
> > >  tools/perf/util/bpf_skel/sample-filter.h     |  24 ++++
> > >  tools/perf/util/bpf_skel/sample_filter.bpf.c | 126 +++++++++++++++++++
> > >  tools/perf/util/evsel.h                      |   7 +-
> > >  6 files changed, 236 insertions(+), 13 deletions(-)
> > >  create mode 100644 tools/perf/util/bpf_skel/sample-filter.h
> > >  create mode 100644 tools/perf/util/bpf_skel/sample_filter.bpf.c
> > >
> > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > index dc9dda09b076..ed6b6a070f79 100644
> > > --- a/tools/perf/Makefile.perf
> > > +++ b/tools/perf/Makefile.perf
> > > @@ -1050,7 +1050,7 @@ SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
> > >  SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
> > >  SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
> > >  SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
> > > -SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
> > > +SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h $(SKEL_OUT)/sample_filter.skel.h
> > >
> > >  $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
> > >     $(Q)$(MKDIR) -p $@
> > > diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> > > index c72e35d51240..f20e1bc03778 100644
> > > --- a/tools/perf/util/bpf-filter.c
> > > +++ b/tools/perf/util/bpf-filter.c
> > > @@ -1,10 +1,74 @@
> > >  /* SPDX-License-Identifier: GPL-2.0 */
> > >  #include <stdlib.h>
> > >
> > > +#include <bpf/bpf.h>
> > > +#include <linux/err.h>
> > > +#include <internal/xyarray.h>
> > > +
> > > +#include "util/debug.h"
> > > +#include "util/evsel.h"
> > > +
> > >  #include "util/bpf-filter.h"
> > >  #include "util/bpf-filter-flex.h"
> > >  #include "util/bpf-filter-bison.h"
> > >
> > > +#include "bpf_skel/sample-filter.h"
> > > +#include "bpf_skel/sample_filter.skel.h"
> > > +
> > > +#define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
> > > +
> > > +int perf_bpf_filter__prepare(struct evsel *evsel)
> > > +{
> > > +   int i, x, y, fd;
> > > +   struct sample_filter_bpf *skel;
> > > +   struct bpf_program *prog;
> > > +   struct bpf_link *link;
> > > +   struct perf_bpf_filter_expr *expr;
> > > +
> > > +   skel = sample_filter_bpf__open_and_load();
> > > +   if (!skel) {
> > > +           pr_err("Failed to load perf sample-filter BPF skeleton\n");
> > > +           return -1;
> > > +   }
> > > +
> > > +   i = 0;
> > > +   fd = bpf_map__fd(skel->maps.filters);
> > > +   list_for_each_entry(expr, &evsel->bpf_filters, list) {
> > > +           struct perf_bpf_filter_entry entry = {
> > > +                   .op = expr->op,
> > > +                   .flags = expr->sample_flags,
> > > +                   .value = expr->val,
> > > +           };
> > > +           bpf_map_update_elem(fd, &i, &entry, BPF_ANY);
> > > +           i++;
> > > +   }
> > > +
> > > +   prog = skel->progs.perf_sample_filter;
> > > +   for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
> > > +           for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
> > > +                   link = bpf_program__attach_perf_event(prog, FD(evsel, x, y));
> > > +                   if (IS_ERR(link)) {
> > > +                           pr_err("Failed to attach perf sample-filter program\n");
> > > +                           return PTR_ERR(link);
> > > +                   }
> > > +           }
> > > +   }
> > > +   evsel->bpf_skel = skel;
> > > +   return 0;
> > > +}
> > > +
> > > +int perf_bpf_filter__destroy(struct evsel *evsel)
> > > +{
> > > +   struct perf_bpf_filter_expr *expr, *tmp;
> > > +
> > > +   list_for_each_entry_safe(expr, tmp, &evsel->bpf_filters, list) {
> > > +           list_del(&expr->list);
> > > +           free(expr);
> > > +   }
> > > +   sample_filter_bpf__destroy(evsel->bpf_skel);
> > > +   return 0;
> > > +}
> > > +
> > >  struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags,
> > >                                                    enum perf_bpf_filter_op op,
> > >                                                    unsigned long val)
> > > diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
> > > index 93a0d3de038c..eb8e1ac43cdf 100644
> > > --- a/tools/perf/util/bpf-filter.h
> > > +++ b/tools/perf/util/bpf-filter.h
> > > @@ -4,15 +4,7 @@
> > >
> > >  #include <linux/list.h>
> > >
> > > -enum perf_bpf_filter_op {
> > > -   PBF_OP_EQ,
> > > -   PBF_OP_NEQ,
> > > -   PBF_OP_GT,
> > > -   PBF_OP_GE,
> > > -   PBF_OP_LT,
> > > -   PBF_OP_LE,
> > > -   PBF_OP_AND,
> > > -};
> > > +#include "bpf_skel/sample-filter.h"
> > >
> > >  struct perf_bpf_filter_expr {
> > >     struct list_head list;
> > > @@ -21,16 +13,30 @@ struct perf_bpf_filter_expr {
> > >     unsigned long val;
> > >  };
> > >
> > > +struct evsel;
> > > +
> > >  #ifdef HAVE_BPF_SKEL
> > >  struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags,
> > >                                                    enum perf_bpf_filter_op op,
> > >                                                    unsigned long val);
> > >  int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
> > > +int perf_bpf_filter__prepare(struct evsel *evsel);
> > > +int perf_bpf_filter__destroy(struct evsel *evsel);
> > > +
> > >  #else /* !HAVE_BPF_SKEL */
> > > +
> > >  static inline int perf_bpf_filter__parse(struct list_head *expr_head __maybe_unused,
> > >                                      const char *str __maybe_unused)
> > >  {
> > > -   return -ENOSYS;
> > > +   return -EOPNOTSUPP;
> > > +}
> > > +static inline int perf_bpf_filter__prepare(struct evsel *evsel __maybe_unused)
> > > +{
> > > +   return -EOPNOTSUPP;
> > > +}
> > > +static inline int perf_bpf_filter__destroy(struct evsel *evsel __maybe_unused)
> > > +{
> > > +   return -EOPNOTSUPP;
> > >  }
> > >  #endif /* HAVE_BPF_SKEL*/
> > >  #endif /* PERF_UTIL_BPF_FILTER_H */
> > > diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
> > > new file mode 100644
> > > index 000000000000..862060bfda14
> > > --- /dev/null
> > > +++ b/tools/perf/util/bpf_skel/sample-filter.h
> > > @@ -0,0 +1,24 @@
> > > +#ifndef PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H
> > > +#define PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H
> > > +
> > > +#define MAX_FILTERS  32
> > > +
> > > +/* supported filter operations */
> > > +enum perf_bpf_filter_op {
> > > +   PBF_OP_EQ,
> > > +   PBF_OP_NEQ,
> > > +   PBF_OP_GT,
> > > +   PBF_OP_GE,
> > > +   PBF_OP_LT,
> > > +   PBF_OP_LE,
> > > +   PBF_OP_AND
> > > +};
> > > +
> > > +/* BPF map entry for filtering */
> > > +struct perf_bpf_filter_entry {
> > > +   enum perf_bpf_filter_op op;
> > > +   __u64 flags;
> > > +   __u64 value;
> > > +};
> > > +
> > > +#endif /* PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H */
> > > \ No newline at end of file
> > > diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > > new file mode 100644
> > > index 000000000000..c07256279c3e
> > > --- /dev/null
> > > +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > > @@ -0,0 +1,126 @@
> > > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +// Copyright (c) 2023 Google
> > > +#include "vmlinux.h"
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_tracing.h>
> > > +#include <bpf/bpf_core_read.h>
> > > +
> > > +#include "sample-filter.h"
> > > +
> > > +/* BPF map that will be filled by user space */
> > > +struct filters {
> > > +   __uint(type, BPF_MAP_TYPE_ARRAY);
> > > +   __type(key, int);
> > > +   __type(value, struct perf_bpf_filter_entry);
> > > +   __uint(max_entries, MAX_FILTERS);
> > > +} filters SEC(".maps");
> > > +
> > > +int dropped;
> > > +
> > > +void *bpf_cast_to_kern_ctx(void *) __ksym;
> > > +
> > > +/* new kernel perf_sample_data definition */
> > > +struct perf_sample_data___new {
> > > +   __u64 sample_flags;
> > > +} __attribute__((preserve_access_index));
> > > +
> > > +/* helper function to return the given perf sample data */
> > > +static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
> > > +                               struct perf_bpf_filter_entry *entry)
> > > +{
> > > +   struct perf_sample_data___new *data = (void *)kctx->data;
> > > +
> > > +   if (!bpf_core_field_exists(data->sample_flags) ||
> > > +       (data->sample_flags & entry->flags) == 0)
> > > +           return 0;
> > > +
> > > +   switch (entry->flags) {
> > > +   case PERF_SAMPLE_IP:
> > > +           return kctx->data->ip;
> > > +   case PERF_SAMPLE_ID:
> > > +           return kctx->data->id;
> > > +   case PERF_SAMPLE_TID:
> > > +           return kctx->data->tid_entry.tid;
> > > +   case PERF_SAMPLE_CPU:
> > > +           return kctx->data->cpu_entry.cpu;
> > > +   case PERF_SAMPLE_TIME:
> > > +           return kctx->data->time;
> > > +   case PERF_SAMPLE_ADDR:
> > > +           return kctx->data->addr;
> > > +   case PERF_SAMPLE_PERIOD:
> > > +           return kctx->data->period;
> > > +   case PERF_SAMPLE_TRANSACTION:
> > > +           return kctx->data->txn;
> > > +   case PERF_SAMPLE_WEIGHT:
> > > +           return kctx->data->weight.full;
> > > +   case PERF_SAMPLE_PHYS_ADDR:
> > > +           return kctx->data->phys_addr;
> > > +   case PERF_SAMPLE_CODE_PAGE_SIZE:
> > > +           return kctx->data->code_page_size;
> > > +   case PERF_SAMPLE_DATA_PAGE_SIZE:
> > > +           return kctx->data->data_page_size;
> > > +   default:
> > > +           break;
> > > +   }
> > > +   return 0;
> > > +}
> > > +
> > > +/* BPF program to be called from perf event overflow handler */
> > > +SEC("perf_event")
> > > +int perf_sample_filter(void *ctx)
> > > +{
> > > +   struct bpf_perf_event_data_kern *kctx;
> > > +   struct perf_bpf_filter_entry *entry;
> > > +   __u64 sample_data;
> > > +   int i;
> > > +
> > > +   kctx = bpf_cast_to_kern_ctx(ctx);
> > > +
> > > +   for (i = 0; i < MAX_FILTERS; i++) {
> > > +           int key = i; /* needed for verifier :( */
> > > +
> > > +           entry = bpf_map_lookup_elem(&filters, &key);
> > > +           if (entry == NULL)
> > > +                   break;
> > > +           sample_data = perf_get_sample(kctx, entry);
> > > +
> > > +           switch (entry->op) {
> > > +           case PBF_OP_EQ:
> > > +                   if (!(sample_data == entry->value))
> > > +                           goto drop;
> > > +                   break;
> > > +           case PBF_OP_NEQ:
> > > +                   if (!(sample_data != entry->value))
> > > +                           goto drop;
> > > +                   break;
> > > +           case PBF_OP_GT:
> > > +                   if (!(sample_data > entry->value))
> > > +                           goto drop;
> > > +                   break;
> > > +           case PBF_OP_GE:
> > > +                   if (!(sample_data >= entry->value))
> > > +                           goto drop;
> > > +                   break;
> > > +           case PBF_OP_LT:
> > > +                   if (!(sample_data < entry->value))
> > > +                           goto drop;
> > > +                   break;
> > > +           case PBF_OP_LE:
> > > +                   if (!(sample_data <= entry->value))
> > > +                           goto drop;
> > > +                   break;
> > > +           case PBF_OP_AND:
> > > +                   if (!(sample_data & entry->value))
> > > +                           goto drop;
> > > +                   break;
> > > +           }
> > > +   }
> > > +   /* generate sample data */
> > > +   return 1;
> > > +
> > > +drop:
> > > +   __sync_fetch_and_add(&dropped, 1);
> > > +   return 0;
> > > +}
> > > +
> > > +char LICENSE[] SEC("license") = "Dual BSD/GPL";
> > > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > > index c272c06565c0..68072ec655ce 100644
> > > --- a/tools/perf/util/evsel.h
> > > +++ b/tools/perf/util/evsel.h
> > > @@ -150,8 +150,10 @@ struct evsel {
> > >      */
> > >     struct bpf_counter_ops  *bpf_counter_ops;
> > >
> > > -   /* for perf-stat -b */
> > > -   struct list_head        bpf_counter_list;
> > > +   union {
> > > +           struct list_head        bpf_counter_list; /* for perf-stat -b */
> > > +           struct list_head        bpf_filters; /* for perf-record --filter */
> > > +   };
> > >
> > >     /* for perf-stat --use-bpf */
> > >     int                     bperf_leader_prog_fd;
> > > @@ -159,6 +161,7 @@ struct evsel {
> > >     union {
> > >             struct bperf_leader_bpf *leader_skel;
> > >             struct bperf_follower_bpf *follower_skel;
> > > +           void *bpf_skel;
> > >     };
> > >     unsigned long           open_flags;
> > >     int                     precise_ip_original;
> > > --
> > > 2.40.0.rc1.284.g88254d51c5-goog
> > >
> >
> > --
> >
> > - Arnaldo
>
> --
>
> - Arnaldo
