Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ABB5EA8E9
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbiIZOsI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 10:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiIZOrp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 10:47:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEB512D31;
        Mon, 26 Sep 2022 06:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E5EBB80977;
        Mon, 26 Sep 2022 13:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3400C433D6;
        Mon, 26 Sep 2022 13:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664197922;
        bh=Jsje8LjAcUn+Fmbb7fCNpBAb/YI9LGJswkzqxoQMl4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGyu5g8xH5ILFC+gRf2+/fNl3+m0ImwvdmIfbWuS+62nn0tUNiUXE2d0NasMR+4VX
         usHFI/uhJBSRHx5uTpbd3ZdFBo9AIf39fWd8mLu+OjGvk0gKxQf9cR3EKouI8Wy/vJ
         f+Y54rcFMG1v7fVZ20Pf9RMrpKFTY2uDRphE41jQ+yYJYxxmFy2k8p45Q/+XRyUQAh
         myL1NGXaHH6nn1GG1lh2bHft1uRO0HF83/pZq+IFk7mJCdAxTV0gimZyxWCF8LbA5Q
         +sdaQeBJpIoG2HrFoUFwbfjwK3blSdmbHGISpENdAPEFVzkphtVqVhhsVxCP0AKDVK
         ZJk3xdDsMtMDw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B9389403B0; Mon, 26 Sep 2022 14:11:59 +0100 (IST)
Date:   Mon, 26 Sep 2022 14:11:59 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v4] perf tools: Get a perf cgroup more portably in BPF
Message-ID: <YzGlH51Idwet/NE9@kernel.org>
References: <20220923063205.772936-1-namhyung@kernel.org>
 <CAP-5=fWwNwtocMR3s1Su2k2vZAwL4yhX19UGZ4i0dMXFDFFBJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWwNwtocMR3s1Su2k2vZAwL4yhX19UGZ4i0dMXFDFFBJA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Sep 23, 2022 at 09:45:19AM -0700, Ian Rogers escreveu:
> On Thu, Sep 22, 2022 at 11:32 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The perf_event_cgrp_id can be different on other configurations.
> > To be more portable as CO-RE, it needs to get the cgroup subsys id
> > using the bpf_core_enum_value() helper.
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Would be good to get this into perf/urgent, does it need Fixes tags for that?

I got it into the perf/urgent branch.

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> > v4 changes)
> >  * add a missing check in the off_cpu
> >
> > v3 changes)
> >  * check compiler features for enum value
> >
> > v2 changes)
> >  * fix off_cpu.bpf.c too
> >  * get perf_subsys_id only once
> >
> >  tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 11 ++++++++++-
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c      | 18 ++++++++++++++----
> >  2 files changed, 24 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > index 292c430768b5..8e7520e273db 100644
> > --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > @@ -48,6 +48,7 @@ const volatile __u32 num_cpus = 1;
> >
> >  int enabled = 0;
> >  int use_cgroup_v2 = 0;
> > +int perf_subsys_id = -1;
> >
> >  static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
> >  {
> > @@ -58,7 +59,15 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
> >         int level;
> >         int cnt;
> >
> > -       cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_event_cgrp_id], cgroup);
> > +       if (perf_subsys_id == -1) {
> > +#if __has_builtin(__builtin_preserve_enum_value)
> > +               perf_subsys_id = bpf_core_enum_value(enum cgroup_subsys_id,
> > +                                                    perf_event_cgrp_id);
> > +#else
> > +               perf_subsys_id = perf_event_cgrp_id;
> > +#endif
> > +       }
> > +       cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_subsys_id], cgroup);
> >         level = BPF_CORE_READ(cgrp, level);
> >
> >         for (cnt = 0; i < MAX_LEVELS; i++) {
> > diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > index c4ba2bcf179f..38e3b287dbb2 100644
> > --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > @@ -94,6 +94,8 @@ const volatile bool has_prev_state = false;
> >  const volatile bool needs_cgroup = false;
> >  const volatile bool uses_cgroup_v1 = false;
> >
> > +int perf_subsys_id = -1;
> > +
> >  /*
> >   * Old kernel used to call it task_struct->state and now it's '__state'.
> >   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> > @@ -119,11 +121,19 @@ static inline __u64 get_cgroup_id(struct task_struct *t)
> >  {
> >         struct cgroup *cgrp;
> >
> > -       if (uses_cgroup_v1)
> > -               cgrp = BPF_CORE_READ(t, cgroups, subsys[perf_event_cgrp_id], cgroup);
> > -       else
> > -               cgrp = BPF_CORE_READ(t, cgroups, dfl_cgrp);
> > +       if (!uses_cgroup_v1)
> > +               return BPF_CORE_READ(t, cgroups, dfl_cgrp, kn, id);
> > +
> > +       if (perf_subsys_id == -1) {
> > +#if __has_builtin(__builtin_preserve_enum_value)
> > +               perf_subsys_id = bpf_core_enum_value(enum cgroup_subsys_id,
> > +                                                    perf_event_cgrp_id);
> > +#else
> > +               perf_subsys_id = perf_event_cgrp_id;
> > +#endif
> > +       }
> >
> > +       cgrp = BPF_CORE_READ(t, cgroups, subsys[perf_subsys_id], cgroup);
> >         return BPF_CORE_READ(cgrp, kn, id);
> >  }
> >
> > --
> > 2.37.3.998.g577e59143f-goog
> >

-- 

- Arnaldo
