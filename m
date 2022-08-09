Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB958D1AF
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 03:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244811AbiHIBSr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 21:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244736AbiHIBSq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 21:18:46 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94416636B
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 18:18:44 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id b7so7609158qvq.2
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 18:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YEeewL7u26t5xnjYAteTsi6uBftnEQWFJtji4zMngLI=;
        b=QM7K5PRSL41dOjkkhbr12boFvR549hO04dJ6wroBBRID09Qd38NtGUxr6+hJ5liFdh
         XADmeBQIhVFJtuCVXUkjFuwfdSvnHuxmLN1qDsStbSuWm4xjUEeppWn/O3X1TViF2Jfb
         vzG4LoMdmvy0fDsZvNLXes7sfmqTrmRozESBVcgJqVQJctpZogvFqk03nnLd9G2FE85j
         mvgIFtviM/gLC7idiwlUZ2Pm40O2ikuhBVo93f4phvXVe1dd5yEIxb7hUSbrH1BtaAKO
         6iyDof7WrBiuDe4ojNt5E4BwSCWP9fqef4pqYecQOrw1nt5uU4QtWucqjT597i1qxEwi
         J1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YEeewL7u26t5xnjYAteTsi6uBftnEQWFJtji4zMngLI=;
        b=dGYhmRNuBh4Fb64IpV18WcaJrkX9VUc65z/wsekUHer8AQf5wIrysv5dX7S9IaH0Qf
         v6pTSPBR51cYJIRfW/TEtSPm34E+k0ktNZoJmZSdfqLodIea85dKCmB0UxgBFx8nrJix
         73IfmiTFcURxvn+SQyvX2GUwlHVlY2LhtbqPEamJFdIRRE6W6/bTKoGkPhC16VgoVK2Z
         bIP8ghMBCRjvm2H9pEfmnF+CR9lmln6ZmKwvlUD02DBHqvdMrtO1tcMl91AzElq9bAU1
         m5fEHDJF8Ksvqu5j07jPeCP/BucM7M6CQ11ndY2h/JpXltbuD1+4P6Q9fdynL2PgSQJu
         aNYg==
X-Gm-Message-State: ACgBeo34NzqWp37nxSL8yTvA5/gpZ0Q0wy5tPNd5Hk2cldS/1RCF7sh1
        thq7LcwWTn1E11dc+b09VoK1Br6cn42VtQsCmpbEQp34QHIdAQ==
X-Google-Smtp-Source: AA6agR6GfNUHY3jjjD2/YbLO6QDE3wjQK3U0O5pNRoIUFkwF92SuJQ7vt+YDB3NGLYzJzR+CWS0iMHLYfxJ/o4LLEfE=
X-Received: by 2002:a0c:9101:0:b0:473:9b:d92a with SMTP id q1-20020a0c9101000000b00473009bd92amr18310037qvq.17.1660007923619;
 Mon, 08 Aug 2022 18:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220805214821.1058337-1-haoluo@google.com> <20220805214821.1058337-6-haoluo@google.com>
 <CAEf4BzarAHuR7mOeHToNiNMc03QnR=74cxt_h5LRymf1U6HevQ@mail.gmail.com>
In-Reply-To: <CAEf4BzarAHuR7mOeHToNiNMc03QnR=74cxt_h5LRymf1U6HevQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 8 Aug 2022 18:18:33 -0700
Message-ID: <CA+khW7gJS2pjc2eHXCkHirdHMqcmzZM_a4VPUvw9RAicgH9Q=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 5/8] selftests/bpf: Test cgroup_iter.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Michal Koutny <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 8, 2022 at 5:20 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Aug 5, 2022 at 2:49 PM Hao Luo <haoluo@google.com> wrote:
> >
> > Add a selftest for cgroup_iter. The selftest creates a mini cgroup tree
> > of the following structure:
> >
> >     ROOT (working cgroup)
> >      |
> >    PARENT
> >   /      \
> > CHILD1  CHILD2
> >
> > and tests the following scenarios:
> >
> >  - invalid cgroup fd.
> >  - pre-order walk over descendants from PARENT.
> >  - post-order walk over descendants from PARENT.
> >  - walk of ancestors from PARENT.
> >  - walk from PARENT in the default order, which is pre-order.
> >  - process only a single object (i.e. PARENT).
> >  - early termination.
> >
> > Acked-by: Yonghong Song <yhs@fb.com>
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
>
> LGTM.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>

Thanks!

> >  .../selftests/bpf/prog_tests/cgroup_iter.c    | 237 ++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/bpf_iter.h  |   7 +
> >  .../testing/selftests/bpf/progs/cgroup_iter.c |  39 +++
> >  3 files changed, 283 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter.c
> >
>
> [...]
