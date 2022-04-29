Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1148651521D
	for <lists+bpf@lfdr.de>; Fri, 29 Apr 2022 19:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379665AbiD2RcH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Apr 2022 13:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379613AbiD2Ray (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Apr 2022 13:30:54 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB65D347D;
        Fri, 29 Apr 2022 10:27:35 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id c15so11309278ljr.9;
        Fri, 29 Apr 2022 10:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7D+3I+t+Bjx7AMKWUHFNEPdjcA8rwqba3c0NxnUB1Ig=;
        b=kBtsUOObhlN8E18kG1QnGHGpezp6+3VVhlE++hcP0TcLxqTmSnNnO824fRj73SRiVo
         ugJ317qV+fzm7qOXFDCc5bzxaqypEhAE2xy4LbOqxnOyqvll19nYYIT+XVQLbt/yM5jn
         4OZZH+jy9OUbv4TVOOYjuNulSXoBzcKlIL5UyUMrYaFMIMkeU68/c+sZdj7QinEl0dra
         lHm7rhNNa8thbHoCcUYKvSp6v3wGj+TDtRw9OBUVZs2iAowGmpGiB6X8vhjNtQ9eZ1UL
         gL+WQBz9GEBBxCUW3vA6V/p03Aag/YsQ4+zhINc8ybxKi04OaUP8vmHptYlhlJrX13Jj
         K8Gw==
X-Gm-Message-State: AOAM533Ck5DlIyycpJn4EEmYu+PTncOhM0ps4zurQiLVYs4QqkmkuQI8
        6yEP3FOYZrqN3hzFsTJjQ0f7p5jBq0O0QmiMr25ymok9
X-Google-Smtp-Source: ABdhPJwGsWqOXKrdEp28MJBR1YmmNLpGT2LFnM8lpsYHWSfz03w7N1XefoFp1yb+g2fwHgrueil2ICAo0Rrh7Kd9KWA=
X-Received: by 2002:a2e:1613:0:b0:24f:2ee0:351a with SMTP id
 w19-20020a2e1613000000b0024f2ee0351amr189180ljd.180.1651253254034; Fri, 29
 Apr 2022 10:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220422150507.222488-1-namhyung@kernel.org> <20220422150507.222488-3-namhyung@kernel.org>
 <CA+khW7gvDaDiA458StkOEvUfvr1Rx4d65+530z2tq52VkJqaoA@mail.gmail.com>
In-Reply-To: <CA+khW7gvDaDiA458StkOEvUfvr1Rx4d65+530z2tq52VkJqaoA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 29 Apr 2022 10:27:23 -0700
Message-ID: <CAM9d7cjytSO9chTZBnKLnNsOz4LtwZo4G1LbEBJbLGGpPieaxA@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf record: Enable off-cpu analysis with BPF
To:     Hao Luo <haoluo@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Hao,

On Wed, Apr 27, 2022 at 4:07 PM Hao Luo <haoluo@google.com> wrote:
>
> Hi Namhyung,
>
> On Fri, Apr 22, 2022 at 8:05 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
>
> [...]
>
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Makefile.perf               |   1 +
> >  tools/perf/builtin-record.c            |  21 +++
> >  tools/perf/util/Build                  |   1 +
> >  tools/perf/util/bpf_off_cpu.c          | 208 +++++++++++++++++++++++++
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c | 137 ++++++++++++++++
> >  tools/perf/util/off_cpu.h              |  22 +++
> >  6 files changed, 390 insertions(+)
> >  create mode 100644 tools/perf/util/bpf_off_cpu.c
> >  create mode 100644 tools/perf/util/bpf_skel/off_cpu.bpf.c
> >  create mode 100644 tools/perf/util/off_cpu.h
> >
>
> [...]
>
> > diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > new file mode 100644
> > index 000000000000..2bc6f7cc59ea
> > --- /dev/null
> > +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> >
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_HASH);
> > +       __uint(key_size, sizeof(__u32));
> > +       __uint(value_size, sizeof(struct tstamp_data));
> > +       __uint(max_entries, MAX_ENTRIES);
> > +} tstamp SEC(".maps");
>
> I think using task local storage for this tstamp would be more
> efficient. There is an example in
> tools/bpf/runqslower/runqslower.bpf.c

Right, will change in v2.

Thanks,
Namhyung
