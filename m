Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CE45B4372
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 02:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiIJAuE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 20:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIJAuD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 20:50:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D47E3B979;
        Fri,  9 Sep 2022 17:50:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y3so7890088ejc.1;
        Fri, 09 Sep 2022 17:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FibNXoOIqGjam8FQaCwVIl7uN/7cSP7wgcWxw2l2siw=;
        b=VIt7nZL2lkC/K0df7BQHCSyhfMX9Si2xUJ5Cs8gGiuOncqtJ+7tOwJ4wrmsWtsNswx
         kMCauGsYuemow1y/DgT8/4vV+P0pbeVE9P0fHhvInu4jBAy/iDTqWHT9upeKF564rOrL
         JkNZcC6NZhhli/3l0cICoNeDb12y1YOkizmKSvq3S2IJBoZP2eP2wCMvgGY4uABIfN4c
         L+dw6CrZqBtawLX+UNY994qSUmcvhaFrI0nUDWRNFvjmXkRQ6hcvA9wHjcJNsEcz9SBr
         SEzt0m4mvz+wPuvr6f7IUDyjwdp/9LuVhs+yNMz/B0Pzt+/QG/B26L+FrDzyjClTnFrs
         Lqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FibNXoOIqGjam8FQaCwVIl7uN/7cSP7wgcWxw2l2siw=;
        b=3vV3okijbxeFRm1gNeyeTCusES5GNmnVynMUpllrxAkeV9T0HVzbdEcU0jYhCjaesC
         lOHHw0WhOv7f153ucJpUDjRILOKVJ/tSqt1kRIq7BqQcEmeerLvbwoTsFcM2jbElXLt0
         xWpOqlzshBhtCjqYMzVKQRsEoB6UaxdNBnYnkUHnYt3LPRMCLhK7XSURs73uo0L3Lf0e
         MjpcvFHnYfWKLIeAAMUAoHP8i+qdPcrYdUNQx6Tf5MhEqXT+A2rVsN3mSNl20xqlXfgO
         2QE4xy3UAiVOILKn/P+FfVpD554BLYZlG56RN4z94FAC3hF628FIx0bO4xcIOIozt5vS
         Mv1Q==
X-Gm-Message-State: ACgBeo0ZS95IoB+SJL0md/uLwYM993sJSoAqb1F2zH2rbiEGk0BSuXty
        vMsUzs9YfwDQD84P0nuZucofVrCg1BEkuaggKm4=
X-Google-Smtp-Source: AA6agR75RCJhiA1g3/v3+Kq3v8MmZyd48JcejsQBsUFSDdYqTQYnRFiLwJPPvhNMhm4PGJKjDRAPg3LEA0Hrtuuy05A=
X-Received: by 2002:a17:907:6096:b0:73d:9d12:4b04 with SMTP id
 ht22-20020a170907609600b0073d9d124b04mr11859936ejc.745.1662771000962; Fri, 09
 Sep 2022 17:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220826230639.1249436-1-yosryahmed@google.com>
 <CA+khW7iN6hyyBBR+4ey+9pNmEyKPZS82-C9kZ2NRXKMEOXHrng@mail.gmail.com>
 <CAJD7tkYKYv+SKhCJs2281==55sALTX_DXifaWPv1w5=xrJjqQA@mail.gmail.com>
 <CAJD7tkZg2jzDDR6vn5=-TS93Tm3P-YEQ+06KDsjg=Mzkt5LqsA@mail.gmail.com>
 <CA+khW7g-jeiXMM-K+KK7L3tzG0catFSM+x5vHKMs=PF=s+=Pag@mail.gmail.com>
 <CAJD7tkZ77JDt62CMw2AmpvTJ5fpVs0mkPdVqMJm8X8zCBq=LhA@mail.gmail.com> <CAJD7tkZz52GkTr+TuZnArEOsyxxMPnE5A1AKZfY-gjx0tUW6dQ@mail.gmail.com>
In-Reply-To: <CAJD7tkZz52GkTr+TuZnArEOsyxxMPnE5A1AKZfY-gjx0tUW6dQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Sep 2022 17:49:49 -0700
Message-ID: <CAEf4BzaH7xgoDfKstCmQzVY5HJpE8Hn8WFfyUU7PH64QpQcwsg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: simplify cgroup_hierarchical_stats selftest
To:     Yosry Ahmed <yosryahmed@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 6, 2022 at 2:35 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Mon, Aug 29, 2022 at 6:50 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Mon, Aug 29, 2022 at 6:42 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > On Mon, Aug 29, 2022 at 6:07 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > On Mon, Aug 29, 2022 at 3:15 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > >
> > > > > On Mon, Aug 29, 2022 at 1:08 PM Hao Luo <haoluo@google.com> wrote:
> > > > > >
> > > > > > On Fri, Aug 26, 2022 at 4:06 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > > >
> > > [...]
> > > > > > >
> > > > > > > -SEC("tp_btf/mm_vmscan_memcg_reclaim_begin")
> > > > > > > -int BPF_PROG(vmscan_start, int order, gfp_t gfp_flags)
> > > > > > > +SEC("fentry/cgroup_attach_task")
> > > > > >
> > > > > > Can we select an attachpoint that is more stable? It seems
> > > > > > 'cgroup_attach_task' is an internal helper function in cgroup, and its
> > > > > > signature can change. I'd prefer using those commonly used tracepoints
> > > > > > and EXPORT'ed functions. IMHO their interfaces are more stable.
> > > > > >
> > > > >
> > > > > Will try to find a more stable attach point. Thanks!
> > > >
> > > > Hey Hao,
> > > >
> > > > I couldn't find any suitable stable attach points under kernel/cgroup.
> > > > Most tracepoints are created using TRACE_CGROUP_PATH which only
> > > > invokes the tracepoint if the trace event is enabled, which I assume
> > > > is not something we can rely on. Otherwise, there is only
> > >
> > > Can we explicitly enable the cgroup_attach_task event, just for this
> > > test? If it's not easy, I am fine with using fentry.
> >
> > I see a couple of tests that read from /sys/kernel/debug/tracing, but
> > they are mostly reading event ids, I don't see any tests enabling or
> > disabling a tracing event, so I am not sure if that's an accepted
> > pattern. Also I am not sure if we can rely on tracefs being in that
> > path. Andrii, is this considered acceptable?
> >
>
> Anyone with thoughts here? Is it acceptable to explicitly enable a
> trace event in a BPF selftest to attach to a tracepoint that is only
> invoked if the trace event is enabled (e.g. cgroup_attach_task) ?
> Otherwise the test program would attach to the fentry of an internal
> function, which is more vulnerable to being changed and breaking the
> test (until someone updates the test with the new signature).
>

IMO it's fine to use fentry. If something changes about signature,
we'll detect it soon enough and adjust selftests.

Messing with global tracefs in selftests is less desirable. It will
also potentially force tests to be sequential.

> > >
> > > > trace_cgroup_setup_root() and trace_cgroup_destroy_root() which are
> > > > irrelevant here. A lot of EXPORT'ed functions are not called in the
> > > > kernel, or cannot be invoked from userspace (the test) in a
> > > > straightforward way. Even if they did, future changes to such code
> > > > paths can also change in the future, so I don't think there is really
> > > > a way to guarantee that future changes don't break the test.
> > > >
> > > > Let me know what you think.
> > > >
