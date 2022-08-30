Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E005A58D1
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 03:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiH3BHU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 21:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiH3BHU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 21:07:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1655D7F10A
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 18:07:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k9so12232609wri.0
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 18:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iXY5dhqtt+GaEA9JOFgzSPC/9abv6ejSAU61pIxPRME=;
        b=e+J0vrzSvlrS/JYfTy6KJKqq2wPKrVIbDyyvdMcZDx0cukujnLwwEuE09UVpZsTIAc
         WgDUJPFSixngaWvcffnSoqXD2kXhZ6g1QKgSsvvesr0pzFw1cnb1vO6ewlKuiWL5IWWT
         xa+Ek3JQXteMT6if21DTss98t5liylC04Sr3rVBI7xhoJqFZhyGKVEniLSaEG++HeNeE
         A/oowX+5ooZ9nTIfQmd2mcUQbCHmgzB2+8Y/mkvnM4OiwagA2z1KOpzhzgr70vdzduR/
         ENcCGtEIZ9zLCRgt5FewxbL7D6k+3BHDU9xzYWh/j9ZYGidwofBMXTt0fFkLfaPCHN2C
         PXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iXY5dhqtt+GaEA9JOFgzSPC/9abv6ejSAU61pIxPRME=;
        b=KKMwoTZvvW5XUGYoZtALHnhmJEui9GmwXZ02Npmc1V8WbndQ6DTR0IzmMojaCewuDC
         ee56OgS2qkLvGaUTTr5Vm64jKCVnP5f+nwjeSOp+pSeiW1S9pkPr12eFU4JwSSHuPZBa
         LhOuCmir7dosXhPJ4A7RZuxArzo9VTmoe9Tcjk/tBYblM9w25E7CI6BBD3x+ywNbyyF2
         jmFCXoGSdTlYEhR61IzC8qDO7CwKIMlipPiIJAGamcACXKgt2ZeGF9vpKzJddQXP5ptB
         rso6p0pQq6uQXPLidh7tF17E+fA65QOs8p7U9qJhta6t94oOpH7RTfQaYRmhFS+m0tsE
         6aIw==
X-Gm-Message-State: ACgBeo3IcmvEG8D9FnNx4cqGoyEWMYlKywf9grBh9HF3XXcutq4yAFNt
        RChLIOArwrk7pCKYRav48xWNWYQReZxHKohsfOYEcA==
X-Google-Smtp-Source: AA6agR6hFLRkkJ4QersafU+0XzbS5C/WkvP6CS5JeU1xCL4KejI+HazleqEuDJiqPmp0OSM14drj59108j/Q0nvFKPU=
X-Received: by 2002:a5d:5a82:0:b0:224:f744:1799 with SMTP id
 bp2-20020a5d5a82000000b00224f7441799mr7421991wrb.582.1661821637538; Mon, 29
 Aug 2022 18:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220826230639.1249436-1-yosryahmed@google.com>
 <CA+khW7iN6hyyBBR+4ey+9pNmEyKPZS82-C9kZ2NRXKMEOXHrng@mail.gmail.com> <CAJD7tkYKYv+SKhCJs2281==55sALTX_DXifaWPv1w5=xrJjqQA@mail.gmail.com>
In-Reply-To: <CAJD7tkYKYv+SKhCJs2281==55sALTX_DXifaWPv1w5=xrJjqQA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 29 Aug 2022 18:06:41 -0700
Message-ID: <CAJD7tkZg2jzDDR6vn5=-TS93Tm3P-YEQ+06KDsjg=Mzkt5LqsA@mail.gmail.com>
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

On Mon, Aug 29, 2022 at 3:15 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> Hi Hao,
>
> Thanks for taking a look!
>
> On Mon, Aug 29, 2022 at 1:08 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Fri, Aug 26, 2022 at 4:06 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > The cgroup_hierarchical_stats selftest is complicated. It has to be,
> > > because it tests an entire workflow of recording, aggregating, and
> > > dumping cgroup stats. However, some of the complexity is unnecessary.
> > > The test now enables the memory controller in a cgroup hierarchy, invokes
> > > reclaim, measure reclaim time, THEN uses that reclaim time to test the
> > > stats collection and aggregation. We don't need to use such a
> > > complicated stat, as the context in which the stat is collected is
> > > orthogonal.
> > >
> > > Simplify the test by using a simple stat instead of reclaim time, the
> > > total number of times a process has ever entered a cgroup. This makes
> > > the test simpler and removes the dependency on the memory controller and
> > > the memory reclaim interface.
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > ---
> >
> > Yosry, please tag the patch with the repo it should be applied on:
> > bpf-next or bpf.
> >
>
> Will do for v2.
>
> > >
> > > When the test failed on Alexei's setup because the memory controller was
> > > not enabled I realized this is an unnecessary dependency for the test,
> > > which inspired this patch :) I am not sure if this prompt a Fixes tag as
> > > the test wasn't broken.
> > >
> > > ---
> > >  .../prog_tests/cgroup_hierarchical_stats.c    | 157 ++++++---------
> > >  .../bpf/progs/cgroup_hierarchical_stats.c     | 181 ++++++------------
> > >  2 files changed, 118 insertions(+), 220 deletions(-)
> > >
> > [...]
> > > diff --git a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> > > index 8ab4253a1592..c74362854948 100644
> > > --- a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> > > +++ b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> > > @@ -1,7 +1,5 @@
> > >  // SPDX-License-Identifier: GPL-2.0-only
> > >  /*
> > > - * Functions to manage eBPF programs attached to cgroup subsystems
> > > - *
> >
> > Please also add comments here explaining what the programs in this file do.
> >
>
> Will do.
>
> > >   * Copyright 2022 Google LLC.
> > >   */
> > [...]
> > >
> > > -SEC("tp_btf/mm_vmscan_memcg_reclaim_begin")
> > > -int BPF_PROG(vmscan_start, int order, gfp_t gfp_flags)
> > > +SEC("fentry/cgroup_attach_task")
> >
> > Can we select an attachpoint that is more stable? It seems
> > 'cgroup_attach_task' is an internal helper function in cgroup, and its
> > signature can change. I'd prefer using those commonly used tracepoints
> > and EXPORT'ed functions. IMHO their interfaces are more stable.
> >
>
> Will try to find a more stable attach point. Thanks!

Hey Hao,

I couldn't find any suitable stable attach points under kernel/cgroup.
Most tracepoints are created using TRACE_CGROUP_PATH which only
invokes the tracepoint if the trace event is enabled, which I assume
is not something we can rely on. Otherwise, there is only
trace_cgroup_setup_root() and trace_cgroup_destroy_root() which are
irrelevant here. A lot of EXPORT'ed functions are not called in the
kernel, or cannot be invoked from userspace (the test) in a
straightforward way. Even if they did, future changes to such code
paths can also change in the future, so I don't think there is really
a way to guarantee that future changes don't break the test.

Let me know what you think.

>
> > > +int BPF_PROG(counter, struct cgroup *dst_cgrp, struct task_struct *leader,
> > > +            bool threadgroup)
> > >  {
> > > -       struct task_struct *task = bpf_get_current_task_btf();
> > > -       __u64 *start_time_ptr;
> > > -
> > > -       start_time_ptr = bpf_task_storage_get(&vmscan_start_time, task, 0,
> > > -                                             BPF_LOCAL_STORAGE_GET_F_CREATE);
> > > -       if (start_time_ptr)
> > > -               *start_time_ptr = bpf_ktime_get_ns();
> > > -       return 0;
> > > -}
> > [...]
> > >  }
> > > --
> > > 2.37.2.672.g94769d06f0-goog
> > >
