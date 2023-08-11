Return-Path: <bpf+bounces-7588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F4A7794A3
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 18:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA603281AC6
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38BF219C2;
	Fri, 11 Aug 2023 16:24:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940551173A
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:24:16 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C8819AE
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 09:24:14 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40a47e8e38dso256911cf.1
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691771053; x=1692375853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEPiel43mLvfGLdJ4gA/PluIztW9arjxUN0zvbmsAGU=;
        b=H5EiGGCXxBoy1c8aJV5/VyJME0ggOWhMXQeEOOra6ptWOHvI2eYv5IwpLvNJSs6gUz
         J/IQCOiuIZIyDLBCvJb688l7e6/tPKqoMLIw7bBluMAzezx991QhR9pK7OHMx6qmvB2+
         4BdFGY4a4so+EYDTpzaSGO9hBmiRxXk0PbqE/tsOi6F7kbAfgCFVKnD5N+AJu2FG1oem
         1m5ljcHodgyvkLYQbFPSQQ2PODrD4a1b98c8I6t1DC2xbN31VT/4dg0ElCDUNeKrYXeD
         8Bi6EnipjiKiwHBCCYB5QIcwnhGlztbbH5G+yWW2MN4N/XXappc1sZBZpmdRR/qkdpq/
         ATkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771053; x=1692375853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEPiel43mLvfGLdJ4gA/PluIztW9arjxUN0zvbmsAGU=;
        b=Hrf60+PzZ8zUfsd4q/A8cXBpTc7cqCJ7eYKHpdSJbADAcJpwgbxSZKZbyH0tfhUQM1
         1ekN8fT3kxQ/VIgsANJNOjU2j63CzxI1pJj2pWgYC4GxLu/7p9pbCvqYua1BlDqm6CCJ
         6/2pPnx5IYhQt5uReQ9x0dC5DLNA0CoHa/6F489FXK2SimXkMWTQbuZFIReWBGPyO9CP
         YaveJvi1mgBc6RNUiqS6Qc/3/p2wzG7Kz8aTdrcox3I01Nx5Mc43InQqisZdW4ToGrlu
         isxewM/edjhOeWHHsD03pmDMGNjYQOhWflvjlgsZzh8pIoAeBZ1egmU5FfAaX6vMB3DE
         Asfw==
X-Gm-Message-State: AOJu0YyNPGpQ/vQ0SCLZ1/PmQeDYVeI/sS7rpmal4Bo2DgnaPxeLScby
	TuxNwQmSnGyMPYaYtP+Q9P/x6+eZSsyiXtRxEZqqDg==
X-Google-Smtp-Source: AGHT+IG+hBkDHsSW631iizhXtGdTTeZjFLZNXYJcAOc+JPR5KSgu2pmuTCaMzkKXL2woWO5xZZiBeSm/sSx80s0eudo=
X-Received: by 2002:ac8:5956:0:b0:3f0:af20:1a37 with SMTP id
 22-20020ac85956000000b003f0af201a37mr197988qtz.15.1691771053307; Fri, 11 Aug
 2023 09:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810184853.2860737-1-irogers@google.com> <20230810184853.2860737-3-irogers@google.com>
 <ZNZdTAI1YPre95mL@krava>
In-Reply-To: <ZNZdTAI1YPre95mL@krava>
From: Ian Rogers <irogers@google.com>
Date: Fri, 11 Aug 2023 09:24:01 -0700
Message-ID: <CAP-5=fVH+9RBYJW-TpXWVKV36UB1WYYMUMwW_cV=MxyZBoVziw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] perf trace: Migrate BPF augmentation to use a skeleton
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Fangrui Song <maskray@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Carsten Haitzler <carsten.haitzler@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, James Clark <james.clark@arm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>, Rob Herring <robh@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, Wang Nan <wangnan0@huawei.com>, 
	Wang ShaoBo <bobo.shaobowang@huawei.com>, YueHaibing <yuehaibing@huawei.com>, 
	Brendan Gregg <brendan.d.gregg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 9:09=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Aug 10, 2023 at 11:48:51AM -0700, Ian Rogers wrote:
> > Previously a BPF event of augmented_raw_syscalls.c could be used to
> > enable augmentation of syscalls by perf trace. As BPF events are no
> > longer supported, switch to using a BPF skeleton which when attached
> > explicitly opens the sysenter and sysexit tracepoints.
> >
> > The dump map is removed as debugging wasn't supported by the
> > augmentation and bpf_printk can be used when necessary.
> >
> > Remove tools/perf/examples/bpf/augmented_raw_syscalls.c so that the
> > rename/migration to a BPF skeleton captures that this was the source.
>
> there's still some:
>
> [jolsa@krava perf]$ grep -r augmented_raw_syscalls.c
> builtin-trace.c:         * (now tools/perf/examples/bpf/augmented_raw_sys=
calls.c, so that it
> builtin-trace.c:                                 * tools/perf/examples/bp=
f/augmented_raw_syscalls.c,
> Documentation/perf-trace.txt:   living in tools/perf/examples/bpf/augment=
ed_raw_syscalls.c. For now this

Agreed, I'll double check but the later patches remove these. I was
trying to keep this patch down to a minimum one approach switch to the
other.

Thanks,
Ian

> jirka
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Makefile.perf                      |   1 +
> >  tools/perf/builtin-trace.c                    | 180 +++++++++++-------
> >  .../bpf_skel/augmented_raw_syscalls.bpf.c}    |  27 +--
> >  3 files changed, 131 insertions(+), 77 deletions(-)
> >  rename tools/perf/{examples/bpf/augmented_raw_syscalls.c =3D> util/bpf=
_skel/augmented_raw_syscalls.bpf.c} (96%)
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 6ec5079fd697..0e1597712b95 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -1042,6 +1042,7 @@ SKELETONS +=3D $(SKEL_OUT)/bperf_cgroup.skel.h $(=
SKEL_OUT)/func_latency.skel.h
> >  SKELETONS +=3D $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.=
skel.h
> >  SKELETONS +=3D $(SKEL_OUT)/kwork_trace.skel.h $(SKEL_OUT)/sample_filte=
r.skel.h
> >  SKELETONS +=3D $(SKEL_OUT)/bench_uprobe.skel.h
> > +SKELETONS +=3D $(SKEL_OUT)/augmented_raw_syscalls.skel.h
> >
> >  $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(=
LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
> >       $(Q)$(MKDIR) -p $@
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 59862467e781..8625fca42cd8 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -19,6 +19,9 @@
> >  #ifdef HAVE_LIBBPF_SUPPORT
> >  #include <bpf/bpf.h>
> >  #include <bpf/libbpf.h>
> > +#ifdef HAVE_BPF_SKEL
> > +#include "bpf_skel/augmented_raw_syscalls.skel.h"
> > +#endif
> >  #endif
> >  #include "util/bpf_map.h"
> >  #include "util/rlimit.h"
> > @@ -127,25 +130,19 @@ struct trace {
> >       struct syscalltbl       *sctbl;
> >       struct {
> >               struct syscall  *table;
> > -             struct { // per syscall BPF_MAP_TYPE_PROG_ARRAY
> > -                     struct bpf_map  *sys_enter,
> > -                                     *sys_exit;
> > -             }               prog_array;
> >               struct {
> >                       struct evsel *sys_enter,
> > -                                       *sys_exit,
> > -                                       *augmented;
> > +                             *sys_exit,
> > +                             *bpf_output;
> >               }               events;
> > -             struct bpf_program *unaugmented_prog;
> >       } syscalls;
> > -     struct {
> > -             struct bpf_map *map;
> > -     } dump;
> > +#ifdef HAVE_BPF_SKEL
> > +     struct augmented_raw_syscalls_bpf *skel;
> > +#endif
> >       struct record_opts      opts;
> >       struct evlist   *evlist;
> >       struct machine          *host;
> >       struct thread           *current;
> > -     struct bpf_object       *bpf_obj;
> >       struct cgroup           *cgroup;
> >       u64                     base_time;
> >       FILE                    *output;
> > @@ -415,6 +412,7 @@ static int evsel__init_syscall_tp(struct evsel *evs=
el)
> >               if (evsel__init_tp_uint_field(evsel, &sc->id, "__syscall_=
nr") &&
> >                   evsel__init_tp_uint_field(evsel, &sc->id, "nr"))
> >                       return -ENOENT;
> > +
> >               return 0;
> >       }
> >
> > @@ -2845,7 +2843,7 @@ static int trace__event_handler(struct trace *tra=
ce, struct evsel *evsel,
> >       if (thread)
> >               trace__fprintf_comm_tid(trace, thread, trace->output);
> >
> > -     if (evsel =3D=3D trace->syscalls.events.augmented) {
> > +     if (evsel =3D=3D trace->syscalls.events.bpf_output) {
> >               int id =3D perf_evsel__sc_tp_uint(evsel, id, sample);
> >               struct syscall *sc =3D trace__syscall_info(trace, evsel, =
id);
> >
> > @@ -3278,24 +3276,16 @@ static int trace__set_ev_qualifier_tp_filter(st=
ruct trace *trace)
> >       goto out;
> >  }
> >
> > -#ifdef HAVE_LIBBPF_SUPPORT
> > -static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace=
, const char *name)
> > -{
> > -     if (trace->bpf_obj =3D=3D NULL)
> > -             return NULL;
> > -
> > -     return bpf_object__find_map_by_name(trace->bpf_obj, name);
> > -}
> > -
> > +#ifdef HAVE_BPF_SKEL
> >  static struct bpf_program *trace__find_bpf_program_by_title(struct tra=
ce *trace, const char *name)
> >  {
> >       struct bpf_program *pos, *prog =3D NULL;
> >       const char *sec_name;
> >
> > -     if (trace->bpf_obj =3D=3D NULL)
> > +     if (trace->skel->obj =3D=3D NULL)
> >               return NULL;
> >
> > -     bpf_object__for_each_program(pos, trace->bpf_obj) {
> > +     bpf_object__for_each_program(pos, trace->skel->obj) {
> >               sec_name =3D bpf_program__section_name(pos);
> >               if (sec_name && !strcmp(sec_name, name)) {
> >                       prog =3D pos;
> > @@ -3313,12 +3303,14 @@ static struct bpf_program *trace__find_syscall_=
bpf_prog(struct trace *trace, str
> >
> >       if (prog_name =3D=3D NULL) {
> >               char default_prog_name[256];
> > -             scnprintf(default_prog_name, sizeof(default_prog_name), "=
!syscalls:sys_%s_%s", type, sc->name);
> > +             scnprintf(default_prog_name, sizeof(default_prog_name), "=
tp/syscalls/sys_%s_%s",
> > +                       type, sc->name);
> >               prog =3D trace__find_bpf_program_by_title(trace, default_=
prog_name);
> >               if (prog !=3D NULL)
> >                       goto out_found;
> >               if (sc->fmt && sc->fmt->alias) {
> > -                     scnprintf(default_prog_name, sizeof(default_prog_=
name), "!syscalls:sys_%s_%s", type, sc->fmt->alias);
> > +                     scnprintf(default_prog_name, sizeof(default_prog_=
name),
> > +                               "tp/syscalls/sys_%s_%s", type, sc->fmt-=
>alias);
> >                       prog =3D trace__find_bpf_program_by_title(trace, =
default_prog_name);
> >                       if (prog !=3D NULL)
> >                               goto out_found;
> > @@ -3336,7 +3328,7 @@ static struct bpf_program *trace__find_syscall_bp=
f_prog(struct trace *trace, str
> >       pr_debug("Couldn't find BPF prog \"%s\" to associate with syscall=
s:sys_%s_%s, not augmenting it\n",
> >                prog_name, type, sc->name);
> >  out_unaugmented:
> > -     return trace->syscalls.unaugmented_prog;
> > +     return trace->skel->progs.syscall_unaugmented;
> >  }
> >
> >  static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
> > @@ -3353,13 +3345,21 @@ static void trace__init_syscall_bpf_progs(struc=
t trace *trace, int id)
> >  static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int id)
> >  {
> >       struct syscall *sc =3D trace__syscall_info(trace, NULL, id);
> > -     return sc ? bpf_program__fd(sc->bpf_prog.sys_enter) : bpf_program=
__fd(trace->syscalls.unaugmented_prog);
> > +
> > +     if (sc)
> > +             return bpf_program__fd(sc->bpf_prog.sys_enter);
> > +
> > +     return bpf_program__fd(trace->skel->progs.syscall_unaugmented);
> >  }
> >
> >  static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
> >  {
> >       struct syscall *sc =3D trace__syscall_info(trace, NULL, id);
> > -     return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program_=
_fd(trace->syscalls.unaugmented_prog);
> > +
> > +     if (sc)
> > +             return bpf_program__fd(sc->bpf_prog.sys_exit);
> > +
> > +     return bpf_program__fd(trace->skel->progs.syscall_unaugmented);
> >  }
> >
> >  static struct bpf_program *trace__find_usable_bpf_prog_entry(struct tr=
ace *trace, struct syscall *sc)
> > @@ -3384,7 +3384,7 @@ static struct bpf_program *trace__find_usable_bpf=
_prog_entry(struct trace *trace
> >               bool is_candidate =3D false;
> >
> >               if (pair =3D=3D NULL || pair =3D=3D sc ||
> > -                 pair->bpf_prog.sys_enter =3D=3D trace->syscalls.unaug=
mented_prog)
> > +                 pair->bpf_prog.sys_enter =3D=3D trace->skel->progs.sy=
scall_unaugmented)
> >                       continue;
> >
> >               for (field =3D sc->args, candidate_field =3D pair->args;
> > @@ -3437,7 +3437,7 @@ static struct bpf_program *trace__find_usable_bpf=
_prog_entry(struct trace *trace
> >                */
> >               if (pair_prog =3D=3D NULL) {
> >                       pair_prog =3D trace__find_syscall_bpf_prog(trace,=
 pair, pair->fmt ? pair->fmt->bpf_prog_name.sys_enter : NULL, "enter");
> > -                     if (pair_prog =3D=3D trace->syscalls.unaugmented_=
prog)
> > +                     if (pair_prog =3D=3D trace->skel->progs.syscall_u=
naugmented)
> >                               goto next_candidate;
> >               }
> >
> > @@ -3452,8 +3452,8 @@ static struct bpf_program *trace__find_usable_bpf=
_prog_entry(struct trace *trace
> >
> >  static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trac=
e)
> >  {
> > -     int map_enter_fd =3D bpf_map__fd(trace->syscalls.prog_array.sys_e=
nter),
> > -         map_exit_fd  =3D bpf_map__fd(trace->syscalls.prog_array.sys_e=
xit);
> > +     int map_enter_fd =3D bpf_map__fd(trace->skel->maps.syscalls_sys_e=
nter);
> > +     int map_exit_fd  =3D bpf_map__fd(trace->skel->maps.syscalls_sys_e=
xit);
> >       int err =3D 0, key;
> >
> >       for (key =3D 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
> > @@ -3515,7 +3515,7 @@ static int trace__init_syscalls_bpf_prog_array_ma=
ps(struct trace *trace)
> >                * For now we're just reusing the sys_enter prog, and if =
it
> >                * already has an augmenter, we don't need to find one.
> >                */
> > -             if (sc->bpf_prog.sys_enter !=3D trace->syscalls.unaugment=
ed_prog)
> > +             if (sc->bpf_prog.sys_enter !=3D trace->skel->progs.syscal=
l_unaugmented)
> >                       continue;
> >
> >               /*
> > @@ -3538,22 +3538,9 @@ static int trace__init_syscalls_bpf_prog_array_m=
aps(struct trace *trace)
> >                       break;
> >       }
> >
> > -
> >       return err;
> >  }
> > -
> > -#else // HAVE_LIBBPF_SUPPORT
> > -static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace=
 __maybe_unused,
> > -                                                const char *name __may=
be_unused)
> > -{
> > -     return NULL;
> > -}
> > -
> > -static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trac=
e __maybe_unused)
> > -{
> > -     return 0;
> > -}
> > -#endif // HAVE_LIBBPF_SUPPORT
> > +#endif // HAVE_BPF_SKEL
> >
> >  static int trace__set_ev_qualifier_filter(struct trace *trace)
> >  {
> > @@ -3917,13 +3904,31 @@ static int trace__run(struct trace *trace, int =
argc, const char **argv)
> >       err =3D evlist__open(evlist);
> >       if (err < 0)
> >               goto out_error_open;
> > +#ifdef HAVE_BPF_SKEL
> > +     {
> > +             struct perf_cpu cpu;
> >
> > +             /*
> > +              * Set up the __augmented_syscalls__ BPF map to hold for =
each
> > +              * CPU the bpf-output event's file descriptor.
> > +              */
> > +             perf_cpu_map__for_each_cpu(cpu, i, trace->syscalls.events=
.bpf_output->core.cpus) {
> > +                     bpf_map__update_elem(trace->skel->maps.__augmente=
d_syscalls__,
> > +                                     &cpu.cpu, sizeof(int),
> > +                                     xyarray__entry(trace->syscalls.ev=
ents.bpf_output->core.fd,
> > +                                                    cpu.cpu, 0),
> > +                                     sizeof(__u32), BPF_ANY);
> > +             }
> > +     }
> > +#endif
> >       err =3D trace__set_filter_pids(trace);
> >       if (err < 0)
> >               goto out_error_mem;
> >
> > -     if (trace->syscalls.prog_array.sys_enter)
> > +#ifdef HAVE_BPF_SKEL
> > +     if (trace->skel->progs.sys_enter)
> >               trace__init_syscalls_bpf_prog_array_maps(trace);
> > +#endif
> >
> >       if (trace->ev_qualifier_ids.nr > 0) {
> >               err =3D trace__set_ev_qualifier_filter(trace);
> > @@ -3956,9 +3961,6 @@ static int trace__run(struct trace *trace, int ar=
gc, const char **argv)
> >       if (err < 0)
> >               goto out_error_apply_filters;
> >
> > -     if (trace->dump.map)
> > -             bpf_map__fprintf(trace->dump.map, trace->output);
> > -
> >       err =3D evlist__mmap(evlist, trace->opts.mmap_pages);
> >       if (err < 0)
> >               goto out_error_mmap;
> > @@ -4655,6 +4657,18 @@ static void trace__exit(struct trace *trace)
> >       zfree(&trace->perfconfig_events);
> >  }
> >
> > +#ifdef HAVE_BPF_SKEL
> > +static int bpf__setup_bpf_output(struct evlist *evlist)
> > +{
> > +     int err =3D parse_event(evlist, "bpf-output/no-inherit=3D1,name=
=3D__augmented_syscalls__/");
> > +
> > +     if (err)
> > +             pr_debug("ERROR: failed to create the \"__augmented_sysca=
lls__\" bpf-output event\n");
> > +
> > +     return err;
> > +}
> > +#endif
> > +
> >  int cmd_trace(int argc, const char **argv)
> >  {
> >       const char *trace_usage[] =3D {
> > @@ -4686,7 +4700,6 @@ int cmd_trace(int argc, const char **argv)
> >               .max_stack =3D UINT_MAX,
> >               .max_events =3D ULONG_MAX,
> >       };
> > -     const char *map_dump_str =3D NULL;
> >       const char *output_name =3D NULL;
> >       const struct option trace_options[] =3D {
> >       OPT_CALLBACK('e', "event", &trace, "event",
> > @@ -4720,9 +4733,6 @@ int cmd_trace(int argc, const char **argv)
> >       OPT_CALLBACK(0, "duration", &trace, "float",
> >                    "show only events with duration > N.M ms",
> >                    trace__set_duration),
> > -#ifdef HAVE_LIBBPF_SUPPORT
> > -     OPT_STRING(0, "map-dump", &map_dump_str, "BPF map", "BPF map to p=
eriodically dump"),
> > -#endif
> >       OPT_BOOLEAN(0, "sched", &trace.sched, "show blocking scheduler ev=
ents"),
> >       OPT_INCR('v', "verbose", &verbose, "be more verbose"),
> >       OPT_BOOLEAN('T', "time", &trace.full_time,
> > @@ -4849,16 +4859,55 @@ int cmd_trace(int argc, const char **argv)
> >                                      "cgroup monitoring only available =
in system-wide mode");
> >       }
> >
> > -     err =3D -1;
> > +#ifdef HAVE_BPF_SKEL
> > +     trace.skel =3D augmented_raw_syscalls_bpf__open();
> > +     if (!trace.skel) {
> > +             pr_debug("Failed to open augmented syscalls BPF skeleton"=
);
> > +     } else {
> > +             /*
> > +              * Disable attaching the BPF programs except for sys_ente=
r and
> > +              * sys_exit that tail call into this as necessary.
> > +              */
> > +             bpf_program__set_autoattach(trace.skel->progs.syscall_una=
ugmented,
> > +                                         /*autoattach=3D*/false);
> > +             bpf_program__set_autoattach(trace.skel->progs.sys_enter_c=
onnect,
> > +                                         /*autoattach=3D*/false);
> > +             bpf_program__set_autoattach(trace.skel->progs.sys_enter_s=
endto,
> > +                                         /*autoattach=3D*/false);
> > +             bpf_program__set_autoattach(trace.skel->progs.sys_enter_o=
pen,
> > +                                         /*autoattach=3D*/false);
> > +             bpf_program__set_autoattach(trace.skel->progs.sys_enter_o=
penat,
> > +                                         /*autoattach=3D*/false);
> > +             bpf_program__set_autoattach(trace.skel->progs.sys_enter_r=
ename,
> > +                                         /*autoattach=3D*/false);
> > +             bpf_program__set_autoattach(trace.skel->progs.sys_enter_r=
enameat,
> > +                                         /*autoattach=3D*/false);
> > +             bpf_program__set_autoattach(trace.skel->progs.sys_enter_p=
erf_event_open,
> > +                                         /*autoattach=3D*/false);
> > +             bpf_program__set_autoattach(trace.skel->progs.sys_enter_c=
lock_nanosleep,
> > +                                         /*autoattach=3D*/false);
> > +
> > +             err =3D augmented_raw_syscalls_bpf__load(trace.skel);
> >
> > -     if (map_dump_str) {
> > -             trace.dump.map =3D trace__find_bpf_map_by_name(&trace, ma=
p_dump_str);
> > -             if (trace.dump.map =3D=3D NULL) {
> > -                     pr_err("ERROR: BPF map \"%s\" not found\n", map_d=
ump_str);
> > -                     goto out;
> > +             if (err < 0) {
> > +                     pr_debug("Failed to load augmented syscalls BPF s=
keleton\n");
> > +             } else {
> > +                     augmented_raw_syscalls_bpf__attach(trace.skel);
> > +                     trace__add_syscall_newtp(&trace);
> >               }
> >       }
> >
> > +     err =3D bpf__setup_bpf_output(trace.evlist);
> > +     if (err) {
> > +             libbpf_strerror(err, bf, sizeof(bf));
> > +             pr_err("ERROR: Setup BPF output event failed: %s\n", bf);
> > +             goto out;
> > +     }
> > +     trace.syscalls.events.bpf_output =3D evlist__last(trace.evlist);
> > +     assert(!strcmp(evsel__name(trace.syscalls.events.bpf_output), "__=
augmented_syscalls__"));
> > +#endif
> > +     err =3D -1;
> > +
> >       if (trace.trace_pgfaults) {
> >               trace.opts.sample_address =3D true;
> >               trace.opts.sample_time =3D true;
> > @@ -4909,7 +4958,7 @@ int cmd_trace(int argc, const char **argv)
> >        * buffers that are being copied from kernel to userspace, think =
'read'
> >        * syscall.
> >        */
> > -     if (trace.syscalls.events.augmented) {
> > +     if (trace.syscalls.events.bpf_output) {
> >               evlist__for_each_entry(trace.evlist, evsel) {
> >                       bool raw_syscalls_sys_exit =3D strcmp(evsel__name=
(evsel), "raw_syscalls:sys_exit") =3D=3D 0;
> >
> > @@ -4918,9 +4967,9 @@ int cmd_trace(int argc, const char **argv)
> >                               goto init_augmented_syscall_tp;
> >                       }
> >
> > -                     if (trace.syscalls.events.augmented->priv =3D=3D =
NULL &&
> > +                     if (trace.syscalls.events.bpf_output->priv =3D=3D=
 NULL &&
> >                           strstr(evsel__name(evsel), "syscalls:sys_ente=
r")) {
> > -                             struct evsel *augmented =3D trace.syscall=
s.events.augmented;
> > +                             struct evsel *augmented =3D trace.syscall=
s.events.bpf_output;
> >                               if (evsel__init_augmented_syscall_tp(augm=
ented, evsel) ||
> >                                   evsel__init_augmented_syscall_tp_args=
(augmented))
> >                                       goto out;
> > @@ -5025,5 +5074,8 @@ int cmd_trace(int argc, const char **argv)
> >               fclose(trace.output);
> >  out:
> >       trace__exit(&trace);
> > +#ifdef HAVE_BPF_SKEL
> > +     augmented_raw_syscalls_bpf__destroy(trace.skel);
> > +#endif
> >       return err;
> >  }
> > diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/p=
erf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > similarity index 96%
> > rename from tools/perf/examples/bpf/augmented_raw_syscalls.c
> > rename to tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > index 9a03189d33d3..70478b9460ee 100644
> > --- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
> > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > @@ -18,6 +18,8 @@
> >  #include <bpf/bpf_helpers.h>
> >  #include <linux/limits.h>
> >
> > +#define MAX_CPUS  4096
> > +
> >  // FIXME: These should come from system headers
> >  typedef char bool;
> >  typedef int pid_t;
> > @@ -34,7 +36,7 @@ struct __augmented_syscalls__ {
> >       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> >       __type(key, int);
> >       __type(value, __u32);
> > -     __uint(max_entries, __NR_CPUS__);
> > +     __uint(max_entries, MAX_CPUS);
> >  } __augmented_syscalls__ SEC(".maps");
> >
> >  /*
> > @@ -170,7 +172,7 @@ unsigned int augmented_arg__read_str(struct augment=
ed_arg *augmented_arg, const
> >       return augmented_len;
> >  }
> >
> > -SEC("!raw_syscalls:unaugmented")
> > +SEC("tp/raw_syscalls/sys_enter")
> >  int syscall_unaugmented(struct syscall_enter_args *args)
> >  {
> >       return 1;
> > @@ -182,7 +184,7 @@ int syscall_unaugmented(struct syscall_enter_args *=
args)
> >   * on from there, reading the first syscall arg as a string, i.e. open=
's
> >   * filename.
> >   */
> > -SEC("!syscalls:sys_enter_connect")
> > +SEC("tp/syscalls/sys_enter_connect")
> >  int sys_enter_connect(struct syscall_enter_args *args)
> >  {
> >       struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
> > @@ -201,7 +203,7 @@ int sys_enter_connect(struct syscall_enter_args *ar=
gs)
> >       return augmented__output(args, augmented_args, len + socklen);
> >  }
> >
> > -SEC("!syscalls:sys_enter_sendto")
> > +SEC("tp/syscalls/sys_enter_sendto")
> >  int sys_enter_sendto(struct syscall_enter_args *args)
> >  {
> >       struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
> > @@ -220,7 +222,7 @@ int sys_enter_sendto(struct syscall_enter_args *arg=
s)
> >       return augmented__output(args, augmented_args, len + socklen);
> >  }
> >
> > -SEC("!syscalls:sys_enter_open")
> > +SEC("tp/syscalls/sys_enter_open")
> >  int sys_enter_open(struct syscall_enter_args *args)
> >  {
> >       struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
> > @@ -235,7 +237,7 @@ int sys_enter_open(struct syscall_enter_args *args)
> >       return augmented__output(args, augmented_args, len);
> >  }
> >
> > -SEC("!syscalls:sys_enter_openat")
> > +SEC("tp/syscalls/sys_enter_openat")
> >  int sys_enter_openat(struct syscall_enter_args *args)
> >  {
> >       struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
> > @@ -250,7 +252,7 @@ int sys_enter_openat(struct syscall_enter_args *arg=
s)
> >       return augmented__output(args, augmented_args, len);
> >  }
> >
> > -SEC("!syscalls:sys_enter_rename")
> > +SEC("tp/syscalls/sys_enter_rename")
> >  int sys_enter_rename(struct syscall_enter_args *args)
> >  {
> >       struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
> > @@ -267,7 +269,7 @@ int sys_enter_rename(struct syscall_enter_args *arg=
s)
> >       return augmented__output(args, augmented_args, len);
> >  }
> >
> > -SEC("!syscalls:sys_enter_renameat")
> > +SEC("tp/syscalls/sys_enter_renameat")
> >  int sys_enter_renameat(struct syscall_enter_args *args)
> >  {
> >       struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
> > @@ -295,7 +297,7 @@ struct perf_event_attr_size {
> >          __u32                   size;
> >  };
> >
> > -SEC("!syscalls:sys_enter_perf_event_open")
> > +SEC("tp/syscalls/sys_enter_perf_event_open")
> >  int sys_enter_perf_event_open(struct syscall_enter_args *args)
> >  {
> >       struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
> > @@ -327,7 +329,7 @@ int sys_enter_perf_event_open(struct syscall_enter_=
args *args)
> >       return 1; /* Failure: don't filter */
> >  }
> >
> > -SEC("!syscalls:sys_enter_clock_nanosleep")
> > +SEC("tp/syscalls/sys_enter_clock_nanosleep")
> >  int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
> >  {
> >       struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
> > @@ -358,7 +360,7 @@ static bool pid_filter__has(struct pids_filtered *p=
ids, pid_t pid)
> >       return bpf_map_lookup_elem(pids, &pid) !=3D NULL;
> >  }
> >
> > -SEC("raw_syscalls:sys_enter")
> > +SEC("tp/raw_syscalls/sys_enter")
> >  int sys_enter(struct syscall_enter_args *args)
> >  {
> >       struct augmented_args_payload *augmented_args;
> > @@ -371,7 +373,6 @@ int sys_enter(struct syscall_enter_args *args)
> >        * We'll add to this as we add augmented syscalls right after tha=
t
> >        * initial, non-augmented raw_syscalls:sys_enter payload.
> >        */
> > -     unsigned int len =3D sizeof(augmented_args->args);
> >
> >       if (pid_filter__has(&pids_filtered, getpid()))
> >               return 0;
> > @@ -393,7 +394,7 @@ int sys_enter(struct syscall_enter_args *args)
> >       return 0;
> >  }
> >
> > -SEC("raw_syscalls:sys_exit")
> > +SEC("tp/raw_syscalls/sys_exit")
> >  int sys_exit(struct syscall_exit_args *args)
> >  {
> >       struct syscall_exit_args exit_args;
> > --
> > 2.41.0.640.ga95def55d0-goog
> >

