Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407161DAC84
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 09:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgETHqj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 03:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETHqi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 03:46:38 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23469C061A0F
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 00:46:37 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id o134so512330ybg.2
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 00:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GcskknYh95Rq/Z6Azk62iLDMqUdVtj6gS2U77ZaIoIU=;
        b=O44tJvlv/WeGAb2EUW5U1b7mccht+alKed3ccPJygFxfgOiFTPk1FratyivkGc09Lv
         xuzcQDqx5Hgm7ZErC5Ll1kGXoT8P4VVHw2p3iW54tOUCLs9CpnclbpknkrOPV24VSlU8
         8wM2T9eqOBFTanPK5rnk4LgPYPh3A7PxoiRB+LYZH1PxDB41pN1I8QZSzz1UT02PB29S
         FjvcxIKv5zbe9M1/LHogO3Ebj+KEt43IIO0zhchKc2GKE3vBi+nJAUELFit5FR/l2A4Y
         WYHNbIuCWPW8qutZwXV/iekANN7iMF5zJZu9FWhBbj+NHjs7eUbFUsYfOb/oRT3x4FVC
         xh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GcskknYh95Rq/Z6Azk62iLDMqUdVtj6gS2U77ZaIoIU=;
        b=qlKkWI4RucF7+x/ubiF318dc0SqMCDO0EkJyy/RTciDGMnvENCL5SwqFm4QgUEYEWC
         kEAMyVoDhDOlOnuADtaw0GRSXzYwu7vtKeGf9KIuSORzx0KpC1F7yIREwJVkS9GBNgbZ
         AlrrmXw6JgVIDHmoBBNnQxOPo8lodcCYin7cb0ObsmztQ2JUtkKxremX5Vb/ijzdKbn+
         JtUqOtYqgZr7/d7t5Beel2DHKrsPILY1lDS3H+cXXyy0yBOCOqtmnQTvbo6tcJv3qWjE
         XJeE+b7IktkAgV6yuCs6zGmY+njFlQqkrIegrOlkiNgSd/RoCPN4koZSyEME9X9AIQeO
         OeMw==
X-Gm-Message-State: AOAM533UM58NSufCVOa+siSXap9vo+Y/hHZRkfFkU8zx1Jvac2ArGpra
        O0Gy4pEda1QWBzHEd6oRIpjYLmiFGKAFq5yDiaNUwQ==
X-Google-Smtp-Source: ABdhPJwGvKZvdPEjgUaNjoxgTzneBcLyd71wFjTYqOE86+SlBKa4uqcqVAnujdHK89IgJTKnEatAb+OEoATUC4Gc+x0=
X-Received: by 2002:a25:7cc1:: with SMTP id x184mr5135676ybc.403.1589960793022;
 Wed, 20 May 2020 00:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200508053629.210324-1-irogers@google.com> <20200508053629.210324-13-irogers@google.com>
 <20200509002518.GF3538@tassilo.jf.intel.com> <CAP-5=fWYO2e9yVPuXGVKZ7TBP4PP6MjyEFiSd+20DOxYSLC--w@mail.gmail.com>
 <20200509024019.GI3538@tassilo.jf.intel.com>
In-Reply-To: <20200509024019.GI3538@tassilo.jf.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 May 2020 00:46:22 -0700
Message-ID: <CAP-5=fVPh0og6CmjM4G1bDGB_S+Sp4v_4WM3r5XqwQPbk7ASdg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 12/14] perf metricgroup: order event groups by size
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 8, 2020 at 7:40 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> > > I'm not sure if size is that great an heuristic. The dedup algorithm should
> > > work in any case even if you don't order by size, right?
> >
> > Consider two metrics:
> >  - metric 1 with events {A,B}
> >  - metric 2 with events {A,B,C,D}
> > If the list isn't sorted then as the matching takes the first group
> > with all the events, metric 1 will match {A,B} and metric 2 {A,B,C,D}.
> > If the order is sorted to {A,B,C,D},{A,B} then metric 1 matches within
> > the {A,B,C,D} group as does metric 2. The events in metric 1 aren't
> > used and are removed.
>
> Ok. It's better for the longer metric if they stay together.
>
> >
> > The dedup algorithm is very naive :-)
>
> I guess what matters is that it gives reasonable results on the current
> metrics. I assume it does?
>
> How much deduping is happening if you run all metrics?

Hi Andi,

I included this data in the latest cover-letter:
https://lore.kernel.org/lkml/20200520072814.128267-1-irogers@google.com/

> For toplev on my long term todo list was to compare it against
> a hopefully better schedule generated by or-tools, but I never
> got around to coding that up.
>
> -Andi

Agreed, and this relates to your comments about doing the algorithm as
a separate pass outside of find_evsel_group. For that, I don't
disagree but would like to land what we have and then follow up with
improvements.

Thanks,
Ian
