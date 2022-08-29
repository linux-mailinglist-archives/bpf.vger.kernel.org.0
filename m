Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD9D5A5314
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 19:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiH2RZB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 13:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH2RY5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 13:24:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312DF9FEB
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 10:24:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bu22so10728667wrb.3
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 10:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JHEoFDBYkf+wx8UJlazL9iiOjkp5vY9J/9mubKGK77U=;
        b=ddU2FvjbjGLKBhjwXR22Ss4a19qcGqXzLI6UAaaamdUNn19uKUVvETZSXaviXhx2JT
         yr7atnCbEvKkbQRMDTKXJBxWr0zN82CPE7TkUy+Iv7qwgvO6lBV0sW/r3o+wZDf2yFFp
         rZFHh6FqMczphAJ2L+FtYkGQqxaqMs5qlcUQFq17/Mms/e+r3zN7iVjiBBOGjuNmu1eP
         2BPQ767jqZTJt4tea81cRG6KG4mDD1+x0ZGmBZSoQZQbjjdXgga447u+IpmBqjPeTca6
         6dRZD0I7JYyMBfWsoM0aiogMgfKD18NTkmTZAMTA7uAtm/6jLLq9u7VwBi6tudDXpLK5
         6Klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JHEoFDBYkf+wx8UJlazL9iiOjkp5vY9J/9mubKGK77U=;
        b=e/HAukblopArlNql2pCGMdSxN1UoQ6VPMEzJ3q9eee1pjzkBK5PO/eiJ+SyGuFIxU7
         3+IeEThoi7tShr8QMgVlJI7Ag24nwi1s5XHqFMQI0O66iFlirEjYkjRWj4iD3CD+a8Vy
         UWkBbcB46FlWIO+B6HfxuNWxxLoAmDPKUggMV1PnFU/vA3aCQOl95cp9OwLzHotKXVsd
         7Q+E5Omlli+t1UZJ3CWMWLZgHM3eX+acgHCtraTqAmFuJWU+V3ZNkDqY4N9xkNs4WQsC
         lcyaF+b3FStAropvUrtfAj0DAJjUUdYJmEW0ptvqDv4tUhI/bGPNi+2IeSM3ntBc9Jhx
         caNA==
X-Gm-Message-State: ACgBeo2MfTLPSGi71zZmsTyWmDBDi4CQl9i8ng4qLtanhkgCszsuRlRb
        cxMj3tBfGvwQdUMUrY9G75NcaGizg+K+wodJcmFV2Q==
X-Google-Smtp-Source: AA6agR4RF/cRQWbRPZWLxBSY+YwtXh6Rf4LW59Ah0otUmTd/0uS8zjk3pR01RTPPb4e0kuBkgo5GHSZl8k3PPVRxxak=
X-Received: by 2002:a5d:6d0c:0:b0:225:4ff9:7e67 with SMTP id
 e12-20020a5d6d0c000000b002254ff97e67mr7022846wrq.534.1661793891577; Mon, 29
 Aug 2022 10:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220826230639.1249436-1-yosryahmed@google.com> <CACYkzJ4=YCZ-rwBdjm59zff-M9q103m6yTnm7da1znbAGX2Ojw@mail.gmail.com>
In-Reply-To: <CACYkzJ4=YCZ-rwBdjm59zff-M9q103m6yTnm7da1znbAGX2Ojw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 29 Aug 2022 10:24:15 -0700
Message-ID: <CAJD7tkZtUk8jmtEk559_njcPstyJ5td1xSKPGsqrbggnB6wADg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: simplify cgroup_hierarchical_stats selftest
To:     KP Singh <kpsingh@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
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

On Sun, Aug 28, 2022 at 3:48 PM KP Singh <kpsingh@kernel.org> wrote:
>
> On Sat, Aug 27, 2022 at 1:06 AM Yosry Ahmed <yosryahmed@google.com> wrote:
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
>
> Acked-by: KP Singh <kpsingh@kernel.org>
>
> > ---
> >
> > When the test failed on Alexei's setup because the memory controller was
> > not enabled I realized this is an unnecessary dependency for the test,
> > which inspired this patch :) I am not sure if this prompt a Fixes tag as
> > the test wasn't broken.
>
> yeah, this is an improvement, I don't think a fixes tag is needed here.
>
> >
> > ---
> >  .../prog_tests/cgroup_hierarchical_stats.c    | 157 ++++++---------
> >  .../bpf/progs/cgroup_hierarchical_stats.c     | 181 ++++++------------
> >  2 files changed, 118 insertions(+), 220 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> > index bed1661596f7..12a6d4ddbd77 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> > @@ -1,6 +1,9 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> > - * Functions to manage eBPF programs attached to cgroup subsystems
> > + * This test runs a BPF program that keeps a stat of the number of processes
> > + * that ever attached to a cgroup, and makes sure that BPF integrates well with
> > + * the rstat framework to efficiently collect those stat percpu to avoid
> > + * locking, and to efficiently aggregate the stat across the hierarchy.
> >   *
> >   * Copyright 2022 Google LLC.
> >   */
> > @@ -21,8 +24,10 @@
> >  #define PAGE_SIZE 4096
> >  #define MB(x) (x << 20)
> >
> > +#define PROCESSES_PER_CGROUP 3
> > +
> >  #define BPFFS_ROOT "/sys/fs/bpf/"
> > -#define BPFFS_VMSCAN BPFFS_ROOT"vmscan/"
> > +#define BPFFS_ATTACH_COUNTERS BPFFS_ROOT"attach_counters/"
>
> minor nit: Is there a missing space here?
> i.e
>
> #define BPFFS_ATTACH_COUNTERS BPFFS_ROOT "attach_counters/"
>
> (this was a case in the line you changed so I am not sure if it's intentional)
>

Thanks for taking a look! Yeah I forgot that even if I added a space
there C will still concatenate those strings without adding any
spaces, so I guess it is better with that space.

> The rest looks good to me, so  maintainers could, potentially, push it
> with the minor edit if needed?

Yeah if that space can be added that would be great. Otherwise I can send a v2.

>
>
> >
> >  #define CG_ROOT_NAME "root"
> >  #define CG_ROOT_ID 1
> > @@ -79,7 +84,7 @@ static int setup_bpffs(void)
> >                 return err;
> >
> >
>
> [...]
>
> > -       return 1;
> > +       return 0;
> >  }
> > --
> > 2.37.2.672.g94769d06f0-goog
> >
