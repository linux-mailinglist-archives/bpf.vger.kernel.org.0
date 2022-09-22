Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68A85E5A14
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 06:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiIVESq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 00:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIVESq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 00:18:46 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448E2A221D;
        Wed, 21 Sep 2022 21:18:41 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id c81so8696225oif.3;
        Wed, 21 Sep 2022 21:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BiJDFb1egZj2DilXc36Z+uvFDZtpiZX1P8hB3PYHb6E=;
        b=MXtoWWJvauDzGZZCb8+0hA+QcgwPTkgePefSM8tiLPWcOIK2saVb+HTUHf42+X1Oro
         YfxyoV1qPANYH3z9ZEymRJVNNniD3wRdo0Jgv67OzxaFoqFTMnQm9NOvmmFpBS9wFJCh
         LRQ7HilyDgOB24WS9tS3tXTPhS1PwPoxeXsR8f/vZfC86L+wAMpmkIXj/RHenwS/0Dd/
         YBZ8H0Hy3Cv1oIJJwU/pxFiW9qgKGjTpvJ9RBE492Zjtrd8wFhJDnl91pZTiP7eEIzLC
         qGQcPQep567/wqCB0jf/MG/IefFGMWVPmbYE11ZTtHwnJnkYUsZLmPzYRpGHZx1nfHzv
         fB5A==
X-Gm-Message-State: ACrzQf3VWAiIiaK71me+qoRXNXO5esBUdCyHVyMbrolvSFHmQRfcvQJo
        t6MqqdAskE5na7UGyGtrpzsaO4groJDt8C2ZVjFYGGNb
X-Google-Smtp-Source: AMsMyM7OPwbTse8PTpi/MDsKPxQX5nAosf2sgYG6nBP8E/QbNxyGBEeIDZWhP+9dn1sBQdGzj6E+pbE+qdlEbI6iW+U=
X-Received: by 2002:a05:6808:181e:b0:350:e92a:9ab1 with SMTP id
 bh30-20020a056808181e00b00350e92a9ab1mr695222oib.209.1663820320490; Wed, 21
 Sep 2022 21:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220922033349.2908447-1-namhyung@kernel.org> <CAP-5=fW5aDW0_t-u9tOy_-AgDQdz5ybOjMVUXqA-Hm0R8sSSSg@mail.gmail.com>
In-Reply-To: <CAP-5=fW5aDW0_t-u9tOy_-AgDQdz5ybOjMVUXqA-Hm0R8sSSSg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Sep 2022 21:18:29 -0700
Message-ID: <CAM9d7ch9iSKYwqT_oV-X2-Yr9rSjKB2R_qFS+t7ro8xMm-VPKg@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Get a perf cgroup more portably in BPF
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>
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

Hi Ian,

On Wed, Sep 21, 2022 at 8:54 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Sep 21, 2022 at 8:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The perf_event_cgrp_id can be different on other configurations.
> > To be more portable as CO-RE, it needs to get the cgroup subsys id
> > using the bpf_core_enum_value() helper.
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > index c72f8ad96f75..35a8e38d3ee3 100644
> > --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > @@ -57,8 +57,10 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
> >         __u32 *elem;
> >         int level;
> >         int cnt;
> > +       int perf_id;
> >
> > -       cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_event_cgrp_id], cgroup);
> > +       perf_id = bpf_core_enum_value(enum cgroup_subsys_id, perf_event_cgrp_id);
> > +       cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_id], cgroup);
>
> LGTM, do we need the same fix in off cpu?
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/bpf_skel/off_cpu.bpf.c?h=perf/core#n123

Right, will send v2.

Thanks,
Namhyung
