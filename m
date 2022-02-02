Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798F44A6976
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 02:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243590AbiBBBBv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 20:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiBBBBu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 20:01:50 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6531C061714;
        Tue,  1 Feb 2022 17:01:50 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id r144so23483508iod.9;
        Tue, 01 Feb 2022 17:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CmP0qq6/ekGkKvGdCo8XfDqIYTpqdkVRVTouUqww8QI=;
        b=b/Km9mNoWX8njHOWVWF7fZHUDevfwYi72UZvSkekAqn9CC2nAjbdB5fkmGeOcRMn71
         zM9q+PKqHvS+NAI2yYOSnC4rGHbkTp6xAFPWcvBR4EhFaEzab8u/+x/mCyLBcmyTg6CL
         IAvZl6G1eACTZmfkhfnueRTodaEMYRZOAda4xBBQyJII/Sg/e2xeQc3LsTROuBzGpOxP
         kD3nxWZvmf7C6BC/Oi7Y7x2CLZv/MjlWWJ9QPCS3MNz3oVoLTFRJWk4iGM2tyr4dYdsr
         pHOpd4XkFbbVEVu4kLgPnKslMA9WrKGY2KB/Whk79fEcIOaknXcfHXY9vSzaj39Tkwm8
         EoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CmP0qq6/ekGkKvGdCo8XfDqIYTpqdkVRVTouUqww8QI=;
        b=tnPdvd86kU7Ho/5GRvbjl7efP9Ijs3IFeqcSNIjyfE68bRIrWmGiEv+CIiOdGlsC+c
         irXV3kqRGTlDeMFukL9cWdzuGASkDXlUaz/Xvm8eva4TuA6qxLJP502UnEOfQY3vNMOz
         LGQ6B1PnsvOu+WI0yvl7tL5XlWoTCuwHMgJ59g/HiZ9UfzrV238QamMoF3Zih+8RRrem
         LrR30wFOiBCAwdU1ux0IVSX75bsRMgxkCJr3N3sIGLxZvsM5wfiSNui2u2j3ZLmnaU3R
         m6flDusdDHqSzbTpXcBQRprM5cqWDlptpn/2ENF8fJYP+yErnLmg/4iRIC5rUtCeyK7x
         gePg==
X-Gm-Message-State: AOAM531OVwFsRE8ZRURKGBG49H44iyrtGJyGxJkh0dgx7idwZ9n3k0e5
        wdM1eABvSADgCD84N7sAMRNJTWdrBQRlaUVl0+I=
X-Google-Smtp-Source: ABdhPJxKbhDeIkE3mRwXAteUh1zQzA58w8qn25C1Gsc07DPCltjoxAOsOOoCdZzmPPRc3L9u9sowSGv1Bb7KXABoqFI=
X-Received: by 2002:a02:7417:: with SMTP id o23mr15124921jac.145.1643763710194;
 Tue, 01 Feb 2022 17:01:50 -0800 (PST)
MIME-Version: 1.0
References: <20220123221932.537060-1-jolsa@kernel.org> <CAEf4BzZj7awfwi-JoAB=aahxVF8p6FKhgu4OKpyY_pjePy75ig@mail.gmail.com>
In-Reply-To: <CAEf4BzZj7awfwi-JoAB=aahxVF8p6FKhgu4OKpyY_pjePy75ig@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Feb 2022 17:01:38 -0800
Message-ID: <CAEf4BzZrggU7Ym7bucvjG7K+AmtxhD8UGCMPqXdpL3stUhpOEg@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf/bpf: Remove prologue generation
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 24, 2022 at 12:24 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Jan 23, 2022 at 2:19 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Removing code for ebpf program prologue generation.
> >
> > The prologue code was used to get data for extra arguments specified
> > in program section name, like:
> >
> >   SEC("lock_page=__lock_page page->flags")
> >   int lock_page(struct pt_regs *ctx, int err, unsigned long flags)
> >   {
> >          return 1;
> >   }
> >
> > This code is using deprecated libbpf API and blocks its removal.
> >
> > This feature was not documented and broken for some time without
> > anyone complaining, also original authors are not responding,
> > so I'm removing it.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/Makefile.config     |  11 -
> >  tools/perf/builtin-record.c    |  14 -
> >  tools/perf/util/bpf-loader.c   | 242 +---------------
> >  tools/perf/util/bpf-prologue.c | 508 ---------------------------------
> >  tools/perf/util/bpf-prologue.h |  37 ---
> >  5 files changed, 1 insertion(+), 811 deletions(-)
>
> Love the stats! Thanks for taking this on!
>

Hi,

Was this ever applied? If not, are there any blockers? I assume this
will go through the perf tree, right?

> >  delete mode 100644 tools/perf/util/bpf-prologue.c
> >  delete mode 100644 tools/perf/util/bpf-prologue.h
> >
>
> [...]
