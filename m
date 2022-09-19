Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D99F5BD0D6
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 17:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiISPZ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 11:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiISPZd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 11:25:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B4138698
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 08:25:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b5so48045352wrr.5
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=n45E9SMZgH+mX1PWjYiZMymKuV6YbCkP9GERockComU=;
        b=dNQHSDyQ6K4k42wEqk+38fCzWID6a69lv0oPocPWguYAS6aIJMpef0hvGXvvNYWV4i
         mQdb48nMtIZvfL025qkNpYsITe82S6tqb3WAFEQSJy5cX3e9b5yb77psLPh8AYySCgoH
         CFCjoK0Mr7CtakzujfzCNpibES7Y00oOc4hH6KMCeNkomKqsc0pJVWJ/bHy6mgoE8B1L
         U/y/nnC9ZY3wOLmLFZVkhEtniaDFUKyeJUvJA3mhmmAItupbH83QsXSeGR8oXQqyaK9K
         ZlJYvBEGrc6gqchld+92Fv9EtuJY4UrKlyF6ZMLMcUb8NlOFwjWVUpPRESekg6kbm7ku
         LPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=n45E9SMZgH+mX1PWjYiZMymKuV6YbCkP9GERockComU=;
        b=S7yqTx8w407x7T938urDis48XYt9lk4jcOeqVrUoglAh8bR6/2p2CAY6KktoB5pul8
         7QCnlKwieqXdsNVYa553XUBIw8B8lEYOaVUrfAitaLLejQ+IYhF7qkOScSZgiylx89zM
         dEXQQ5MRhuupEcBW4zXxubZjyYAOr3AOUybf5uCPecTKBx9WpaahismhPqa8NMR77XiC
         9GeAwots8X5yvDpvyouKDa8KohV4q55RUvWXlanlQrUj8jZn9yliSsIcabpGkVSuA7rC
         CQ44D6DLpvdnqsj75CK8Qg5g019yYOBtWsDmE9F8tFkFVOfvhMkQWZLgPR/M1VXqy6qM
         WqHQ==
X-Gm-Message-State: ACrzQf2wgKbqtCc/vjP+73VwmGzobyEq2I63pFvLDI6c6PXFPRpqrFMC
        XZXu/3ePIRPUzpPjoPPyxp+pSxX3ixB1VcoJWmnTeA==
X-Google-Smtp-Source: AMsMyM7uoYYkjuWNMuec+kN6ZoFWa20saTu272aPCAqIPbKRj31DaNi5SJEl/KC7+Mzk7mgFGaGwxJyqvxJLpNyQK7c=
X-Received: by 2002:a5d:64e8:0:b0:22a:bbb0:fa with SMTP id g8-20020a5d64e8000000b0022abbb000famr11506842wri.372.1663601114664;
 Mon, 19 Sep 2022 08:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220826230639.1249436-1-yosryahmed@google.com>
 <CA+khW7iN6hyyBBR+4ey+9pNmEyKPZS82-C9kZ2NRXKMEOXHrng@mail.gmail.com>
 <CAJD7tkYKYv+SKhCJs2281==55sALTX_DXifaWPv1w5=xrJjqQA@mail.gmail.com>
 <CAJD7tkZg2jzDDR6vn5=-TS93Tm3P-YEQ+06KDsjg=Mzkt5LqsA@mail.gmail.com>
 <CA+khW7g-jeiXMM-K+KK7L3tzG0catFSM+x5vHKMs=PF=s+=Pag@mail.gmail.com>
 <CAJD7tkZ77JDt62CMw2AmpvTJ5fpVs0mkPdVqMJm8X8zCBq=LhA@mail.gmail.com>
 <CAJD7tkZz52GkTr+TuZnArEOsyxxMPnE5A1AKZfY-gjx0tUW6dQ@mail.gmail.com> <CAEf4BzaH7xgoDfKstCmQzVY5HJpE8Hn8WFfyUU7PH64QpQcwsg@mail.gmail.com>
In-Reply-To: <CAEf4BzaH7xgoDfKstCmQzVY5HJpE8Hn8WFfyUU7PH64QpQcwsg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 19 Sep 2022 08:24:38 -0700
Message-ID: <CAJD7tkY24bKh7OQ3bNp42djsi6eGrs7yPNC_t9zsWz5DpGjEYA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: simplify cgroup_hierarchical_stats selftest
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, Andrii Nakryiko <andrii@kernel.org>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 9, 2022 at 5:50 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 6, 2022 at 2:35 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Mon, Aug 29, 2022 at 6:50 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > On Mon, Aug 29, 2022 at 6:42 PM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > On Mon, Aug 29, 2022 at 6:07 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > >
> > > > > On Mon, Aug 29, 2022 at 3:15 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > >
> > > > > > On Mon, Aug 29, 2022 at 1:08 PM Hao Luo <haoluo@google.com> wrote:
> > > > > > >
> > > > > > > On Fri, Aug 26, 2022 at 4:06 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > > > >
> > > > [...]
> > > > > > > >
> > > > > > > > -SEC("tp_btf/mm_vmscan_memcg_reclaim_begin")
> > > > > > > > -int BPF_PROG(vmscan_start, int order, gfp_t gfp_flags)
> > > > > > > > +SEC("fentry/cgroup_attach_task")
> > > > > > >
> > > > > > > Can we select an attachpoint that is more stable? It seems
> > > > > > > 'cgroup_attach_task' is an internal helper function in cgroup, and its
> > > > > > > signature can change. I'd prefer using those commonly used tracepoints
> > > > > > > and EXPORT'ed functions. IMHO their interfaces are more stable.
> > > > > > >
> > > > > >
> > > > > > Will try to find a more stable attach point. Thanks!
> > > > >
> > > > > Hey Hao,
> > > > >
> > > > > I couldn't find any suitable stable attach points under kernel/cgroup.
> > > > > Most tracepoints are created using TRACE_CGROUP_PATH which only
> > > > > invokes the tracepoint if the trace event is enabled, which I assume
> > > > > is not something we can rely on. Otherwise, there is only
> > > >
> > > > Can we explicitly enable the cgroup_attach_task event, just for this
> > > > test? If it's not easy, I am fine with using fentry.
> > >
> > > I see a couple of tests that read from /sys/kernel/debug/tracing, but
> > > they are mostly reading event ids, I don't see any tests enabling or
> > > disabling a tracing event, so I am not sure if that's an accepted
> > > pattern. Also I am not sure if we can rely on tracefs being in that
> > > path. Andrii, is this considered acceptable?
> > >
> >
> > Anyone with thoughts here? Is it acceptable to explicitly enable a
> > trace event in a BPF selftest to attach to a tracepoint that is only
> > invoked if the trace event is enabled (e.g. cgroup_attach_task) ?
> > Otherwise the test program would attach to the fentry of an internal
> > function, which is more vulnerable to being changed and breaking the
> > test (until someone updates the test with the new signature).
> >
>
> IMO it's fine to use fentry. If something changes about signature,
> we'll detect it soon enough and adjust selftests.
>
> Messing with global tracefs in selftests is less desirable. It will
> also potentially force tests to be sequential.
>

Undestood. Thanks Andrii.
Will send v2 with other comments from KP and Hao.

> > > >
> > > > > trace_cgroup_setup_root() and trace_cgroup_destroy_root() which are
> > > > > irrelevant here. A lot of EXPORT'ed functions are not called in the
> > > > > kernel, or cannot be invoked from userspace (the test) in a
> > > > > straightforward way. Even if they did, future changes to such code
> > > > > paths can also change in the future, so I don't think there is really
> > > > > a way to guarantee that future changes don't break the test.
> > > > >
> > > > > Let me know what you think.
> > > > >
