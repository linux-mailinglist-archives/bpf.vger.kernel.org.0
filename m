Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02F45A56F4
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 00:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiH2WQv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 18:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiH2WQk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 18:16:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EBEA6AC7
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 15:16:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so5140168wmb.4
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 15:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HD633EfbN3tb6uFCu45l1iRXG26ohor9loINMI5UFVU=;
        b=SUtdpCu/SOcGU+qWxAFpyCReRSxrL/K6PFzJ+/br9oyXDpUkXwDACFm/6ovQltGWUO
         XBOMhVQTIv8mu0iVlA9ww+iYaabHGloTy6maqou87zRcCNHTk4Z/XIa6lSFamNNHjGVK
         Ru5pgBK29+Scxi+a+0gpuu1hS7KRPw1fxgJZPT40JSLE3HAQ4odX3g1cyXW0rW7PeZIY
         AXfIO9HwuZY8P8gbV/Y+UTQKp/EMy0t0NQNKX7n2gWLPHvNNDVQYh7qOH2OSgHmCdPA9
         yX0wuw95Jwu1z6HB5J1Pr1Y18Viec9NZp3PL8uGCbSNOvES7yoNsmBTOqKhWzPDJUknV
         78Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HD633EfbN3tb6uFCu45l1iRXG26ohor9loINMI5UFVU=;
        b=Y3cgNPASsP3XfoGfy8LB2CAPTqiY95KHxD76EiMn+hSYnFJKhdmM0XFK290LEh/VpV
         Vyhj6vvWUQ4/JGtId9rstZAfizzDt5LRA5VpYyUypg44eDhXfatkvhjsXZNeI4wxphym
         K2awSLmqKTNwUfnKUyLPUyhiX3O78+1/Z8WM5GB1xFnN7MhcxX0fJ2Rw/uF/VlYGNBTG
         vgldCnoebeoqQ+a5WncOXGKHgE+FbvHhDRiLvTpl9VlXgXcw2oKxlARjDkUa17VGsweu
         T/WtXz+6OSiOko519oJWjRWyCZzO3WmDAt9I07Ihau2cjZo4qU/tIThKoejI9HLQvxBA
         htCQ==
X-Gm-Message-State: ACgBeo1uKd58vc9oIhsoN/N2v9blkn5q98/Y97V7EtIuuiqBagab4t1Q
        EAGsi/OHzze+5rEzR1f3TMiufpKVTfKpZyqd1nW2HQ==
X-Google-Smtp-Source: AA6agR55y3N/Bia3lsmUgfym4cf6f/K7T33smt9ZGjVFVpWIKNnbjMr2sfb/9TUtY14Hh908C/LzkLs9pnrtbtTGwZU=
X-Received: by 2002:a1c:7315:0:b0:3a5:ff61:4080 with SMTP id
 d21-20020a1c7315000000b003a5ff614080mr7826816wmb.196.1661811390850; Mon, 29
 Aug 2022 15:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220826230639.1249436-1-yosryahmed@google.com> <CA+khW7iN6hyyBBR+4ey+9pNmEyKPZS82-C9kZ2NRXKMEOXHrng@mail.gmail.com>
In-Reply-To: <CA+khW7iN6hyyBBR+4ey+9pNmEyKPZS82-C9kZ2NRXKMEOXHrng@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 29 Aug 2022 15:15:54 -0700
Message-ID: <CAJD7tkYKYv+SKhCJs2281==55sALTX_DXifaWPv1w5=xrJjqQA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: simplify cgroup_hierarchical_stats selftest
To:     Hao Luo <haoluo@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Hao,

Thanks for taking a look!

On Mon, Aug 29, 2022 at 1:08 PM Hao Luo <haoluo@google.com> wrote:
>
> On Fri, Aug 26, 2022 at 4:06 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > The cgroup_hierarchical_stats selftest is complicated. It has to be,
> > because it tests an entire workflow of recording, aggregating, and
> > dumping cgroup stats. However, some of the complexity is unnecessary.
> > The test now enables the memory controller in a cgroup hierarchy, invokes
> > reclaim, measure reclaim time, THEN uses that reclaim time to test the
> > stats collection and aggregation. We don't need to use such a
> > complicated stat, as the context in which the stat is collected is
> > orthogonal.
> >
> > Simplify the test by using a simple stat instead of reclaim time, the
> > total number of times a process has ever entered a cgroup. This makes
> > the test simpler and removes the dependency on the memory controller and
> > the memory reclaim interface.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
>
> Yosry, please tag the patch with the repo it should be applied on:
> bpf-next or bpf.
>

Will do for v2.

> >
> > When the test failed on Alexei's setup because the memory controller was
> > not enabled I realized this is an unnecessary dependency for the test,
> > which inspired this patch :) I am not sure if this prompt a Fixes tag as
> > the test wasn't broken.
> >
> > ---
> >  .../prog_tests/cgroup_hierarchical_stats.c    | 157 ++++++---------
> >  .../bpf/progs/cgroup_hierarchical_stats.c     | 181 ++++++------------
> >  2 files changed, 118 insertions(+), 220 deletions(-)
> >
> [...]
> > diff --git a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> > index 8ab4253a1592..c74362854948 100644
> > --- a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> > +++ b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> > @@ -1,7 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> > - * Functions to manage eBPF programs attached to cgroup subsystems
> > - *
>
> Please also add comments here explaining what the programs in this file do.
>

Will do.

> >   * Copyright 2022 Google LLC.
> >   */
> [...]
> >
> > -SEC("tp_btf/mm_vmscan_memcg_reclaim_begin")
> > -int BPF_PROG(vmscan_start, int order, gfp_t gfp_flags)
> > +SEC("fentry/cgroup_attach_task")
>
> Can we select an attachpoint that is more stable? It seems
> 'cgroup_attach_task' is an internal helper function in cgroup, and its
> signature can change. I'd prefer using those commonly used tracepoints
> and EXPORT'ed functions. IMHO their interfaces are more stable.
>

Will try to find a more stable attach point. Thanks!

> > +int BPF_PROG(counter, struct cgroup *dst_cgrp, struct task_struct *leader,
> > +            bool threadgroup)
> >  {
> > -       struct task_struct *task = bpf_get_current_task_btf();
> > -       __u64 *start_time_ptr;
> > -
> > -       start_time_ptr = bpf_task_storage_get(&vmscan_start_time, task, 0,
> > -                                             BPF_LOCAL_STORAGE_GET_F_CREATE);
> > -       if (start_time_ptr)
> > -               *start_time_ptr = bpf_ktime_get_ns();
> > -       return 0;
> > -}
> [...]
> >  }
> > --
> > 2.37.2.672.g94769d06f0-goog
> >
