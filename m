Return-Path: <bpf+bounces-46-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DF16F7952
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB837280FA1
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FF7C158;
	Thu,  4 May 2023 22:46:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246A3C14C
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:46:47 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0F3BA;
	Thu,  4 May 2023 15:46:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ab267e3528so8083615ad.0;
        Thu, 04 May 2023 15:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683240405; x=1685832405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p2bj78cFGTKoY9hMxKQqwLP1oh/46AWaP5OKPTFbXuw=;
        b=O38pyl2iTIXIM0pAlFz2cU0odBhXCj5fHILgOkUUWlfCbSaoyGvt+UG2kkCHfNMyKI
         q9JEd1gjd6ggpkUrEBCS6Ebz3gqzzyiMPYMkSbMJj7Jb+pce7eXQuiSPvzzUE06Y+bwa
         vg0HWedt5xZtSErdY8mLcbYXcbUpeJfji+hHlSx7unaz5bR+PGo57BpfAoDrRzx6i/2b
         6JG9FeMcabeouD6wXQyQ3r16So+GN0N7fD5PKufPMexupJ3flf8WR6HxWtZDcNG7ICa2
         LXvB44P1BWDQt98TeRXCQS39vZD9K/sxtJtkIndrySiBHYyo+g6iVrUaHAVR+8hdeB0Z
         M7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683240405; x=1685832405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2bj78cFGTKoY9hMxKQqwLP1oh/46AWaP5OKPTFbXuw=;
        b=UDy7tumzneRhe4Be5qSTL+2N6wa8XnOCVxmJh1lXvB6svMyK9j5hpUWwZvH1DJjAJ4
         hQFFuMrnf7aN+Qu4fc9zTKvFthjH0V6h4K36pQHNM3V7iBmkJIwpq+04raX0kRczHo9c
         CvytTffqnE2CNR3mKEhb4XFT15Zr5i9+kLyQMMxrDx1rDBkfqCp1wtPMmCs+KWLci8Vv
         r9J9XYCJz7ZwiZCCHwgVBVQPBMElq5FBVI+biGdtGvDM+fAvDn4NtyMWUYmSYUw1620b
         8xqc76VjwNXKv3Vow/kgqeqa87QZpNQhwFD7OoCTz6C8zT3bgHIMQiBZleCSOIEms/Tu
         Vzjg==
X-Gm-Message-State: AC+VfDyD+4iQWBAWt+5A/JJpVkIWPKcv/3RtX2yx8VvOA4AgSrXAd2eG
	QeEn18f8RSYYFE617Dfi+9k=
X-Google-Smtp-Source: ACHHUZ5y37zOX6jAcd+0ko/m7mNN0pGRCuco/wXfCBx4EDDoKKJ8LCNRfbxU3jr8I7kU8qym+4Oxyw==
X-Received: by 2002:a17:903:18c:b0:1a6:83fa:b370 with SMTP id z12-20020a170903018c00b001a683fab370mr5874827plg.2.1683240404454;
        Thu, 04 May 2023 15:46:44 -0700 (PDT)
Received: from google.com ([2620:15c:2d4:203:cf29:c3f3:b6aa:dcb5])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b001aaf5dcd762sm36331plh.214.2023.05.04.15.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:46:44 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
Date: Thu, 4 May 2023 15:46:41 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Changbin Du <changbin.du@huawei.com>, Hao Luo <haoluo@google.com>,
	Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Roman Lozko <lozko.roma@gmail.com>,
	Stephane Eranian <eranian@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	bpf <bpf@vger.kernel.org>
Subject: Re: BPF skels in perf .Re: [GIT PULL] perf tools changes for v6.4
Message-ID: <ZFQ10TwDqzbUZ2V0@google.com>
References: <20230503211801.897735-1-acme@kernel.org>
 <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <ZFOSUab5XEJD0kxj@kernel.org>
 <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org>
 <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org>
 <ZFQoQjCNtyMIulp+@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFQoQjCNtyMIulp+@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 04, 2023 at 06:48:50PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 04, 2023 at 04:07:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, May 04, 2023 at 11:50:07AM -0700, Andrii Nakryiko escreveu:
> > > On Thu, May 4, 2023 at 10:52 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > Andrii, can you add some more information about the usage of vmlinux.h
> > > > instead of using kernel headers?
> >  
> > > I'll just say that vmlinux.h is not a hard requirement to build BPF
> > > programs, it's more a convenience allowing easy access to definitions
> > > of both UAPI and kernel-internal structures for tracing needs and
> > > marking them relocatable using BPF CO-RE machinery. Lots of real-world
> > > applications just check-in pregenerated vmlinux.h to avoid build-time
> > > dependency on up-to-date host kernel and such.
> >  
> > > If vmlinux.h generation and usage is causing issues, though, given
> > > that perf's BPF programs don't seem to be using many different kernel
> > > types, it might be a better option to just use UAPI headers for public
> > > kernel type definitions, and just define CO-RE-relocatable minimal
> > > definitions locally in perf's BPF code for the other types necessary.
> > > E.g., if perf needs only pid and tgid from task_struct, this would
> > > suffice:
> >  
> > > struct task_struct {
> > >     int pid;
> > >     int tgid;
> > > } __attribute__((preserve_access_index));
> > 
> > Yeah, that seems like a way better approach, no vmlinux involved, libbpf
> > CO-RE notices that task_struct changed from this two integers version
> > (of course) and does the relocation to where it is in the running kernel
> > by using /sys/kernel/btf/vmlinux.
> 
> Doing it for one of the skels, build tested, runtime untested, but not
> using any vmlinux, BTF to help, not that bad, more verbose, but at least
> we state what are the fields we actually use, have those attribute
> documenting that those offsets will be recorded for future use, etc.
> 
> Namhyung, can you please check that this works?

Yep, it works great!

  $ sudo ./perf stat -a --bpf-counters --for-each-cgroup /,user.slice,system.slice sleep 1
  
   Performance counter stats for 'system wide':
  
           64,110.41 msec cpu-clock                        /                #   64.004 CPUs utilized
              15,787      context-switches                 /                #  246.247 /sec
                  72      cpu-migrations                   /                #    1.123 /sec
               1,236      page-faults                      /                #   19.279 /sec
         848,608,137      cycles                           /                #    0.013 GHz                         (83.23%)
         106,928,070      stalled-cycles-frontend          /                #   12.60% frontend cycles idle        (83.23%)
         209,204,795      stalled-cycles-backend           /                #   24.65% backend cycles idle         (83.23%)
         645,183,025      instructions                     /                #    0.76  insn per cycle
                                                    #    0.32  stalled cycles per insn     (83.24%)
         141,776,876      branches                         /                #    2.211 M/sec                       (83.63%)
           3,001,078      branch-misses                    /                #    2.12% of all branches             (83.44%)
               66.67 msec cpu-clock                        user.slice       #    0.067 CPUs utilized
                 695      context-switches                 user.slice       #   10.424 K/sec
                  22      cpu-migrations                   user.slice       #  329.966 /sec
               1,202      page-faults                      user.slice       #   18.028 K/sec
         150,514,330      cycles                           user.slice       #    2.257 GHz                         (90.17%)
          13,504,605      stalled-cycles-frontend          user.slice       #    8.97% frontend cycles idle        (69.71%)
          38,859,376      stalled-cycles-backend           user.slice       #   25.82% backend cycles idle         (95.28%)
         189,382,145      instructions                     user.slice       #    1.26  insn per cycle
                                                    #    0.21  stalled cycles per insn     (88.92%)
          36,019,878      branches                         user.slice       #  540.242 M/sec                       (90.16%)
             697,723      branch-misses                    user.slice       #    1.94% of all branches             (65.77%)
               44.33 msec cpu-clock                        system.slice     #    0.044 CPUs utilized
               2,382      context-switches                 system.slice     #   53.732 K/sec
                  42      cpu-migrations                   system.slice     #  947.418 /sec
                  34      page-faults                      system.slice     #  766.958 /sec
         100,383,549      cycles                           system.slice     #    2.264 GHz                         (87.27%)
          10,165,225      stalled-cycles-frontend          system.slice     #   10.13% frontend cycles idle        (71.73%)
          29,964,682      stalled-cycles-backend           system.slice     #   29.85% backend cycles idle         (84.94%)
         101,210,743      instructions                     system.slice     #    1.01  insn per cycle
                                                    #    0.30  stalled cycles per insn     (80.68%)
          19,893,831      branches                         system.slice     #  448.757 M/sec                       (86.94%)
             397,854      branch-misses                    system.slice     #    2.00% of all branches             (88.42%)
  
         1.001667221 seconds time elapsed
  
Thanks,
Namhyung


> diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> index 6a438e0102c5a2cb..f376d162549ebd74 100644
> --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> @@ -1,11 +1,40 @@
>  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  // Copyright (c) 2021 Facebook
>  // Copyright (c) 2021 Google
> -#include "vmlinux.h"
> +#include <linux/types.h>
> +#include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_core_read.h>
>  
> +// libbpf's CO-RE will take care of the relocations so that these fields match
> +// the layout of these structs in the kernel where this ends up running on.
> +
> +struct cgroup_subsys_state {
> +	struct cgroup *cgroup;
> +} __attribute__((preserve_access_index));
> +
> +struct css_set {
> +	struct cgroup_subsys_state *subsys[13];
> +} __attribute__((preserve_access_index));
> +
> +struct task_struct {
> +	struct css_set *cgroups;
> +} __attribute__((preserve_access_index));
> +
> +struct kernfs_node {
> +	__u64 id;
> +}  __attribute__((preserve_access_index));
> +
> +struct cgroup {
> +	struct kernfs_node *kn;
> +	int                level;
> +}  __attribute__((preserve_access_index));
> +
> +enum cgroup_subsys_id {
> +	perf_event_cgrp_id  = 8,
> +};
> +
>  #define MAX_LEVELS  10  // max cgroup hierarchy level: arbitrary
>  #define MAX_EVENTS  32  // max events per cgroup: arbitrary
>  
> @@ -52,7 +81,7 @@ struct cgroup___new {
>  /* old kernel cgroup definition */
>  struct cgroup___old {
>  	int level;
> -	u64 ancestor_ids[];
> +	__u64 ancestor_ids[];
>  } __attribute__((preserve_access_index));
>  
>  const volatile __u32 num_events = 1;
> 

