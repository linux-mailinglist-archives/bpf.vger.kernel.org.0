Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A084B5BBB
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 22:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiBNU4b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 15:56:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiBNU40 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 15:56:26 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AB310DA74
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 12:56:05 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id g145so15537400qke.3
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 12:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ttJu1XMf1+hA+hrMQ5r00OCzrFkN94Y4YW3j0uNrxV8=;
        b=hr+TWd2YTvC14HH5KLVZE3+GCtF6eZvPPD6LASFw0DJGN9OgAZCjUR6WUWoVS69jSW
         clj8d86ROskMUqHEaPm3XQjwNDI3Rr91p0vT6W0xRLCGwXHAY5SxD8AhF0A+UC8ij/FT
         T4V46FpPWiYlBh/9OAZ9eRf1HztNX/WDBM+3w20JzYCZwoJg4+lKUstn2oxwFrSPl2me
         r2ey1rlgdh7vjxGQWvXEcfmKQ5Uehd0ZreduPnbsGVgzpRJCfFd3cQGyKLTpBc+ZbeAe
         Y545Xujo2QmmXI2Vz11AC8b39o3tVQJm4fRyt6gRfbxMzl8itRY34+gs5GuK4KjA7Sg9
         SDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttJu1XMf1+hA+hrMQ5r00OCzrFkN94Y4YW3j0uNrxV8=;
        b=3YYNsU4Pzm9C0wGRtzRUsMk9f2qrKKGPk0yOL+F3hr/SGTTpBTg0ufI+86O/euejBK
         MU5yBM4r0c91F/xE0cW++A7bAHT+w1ImQpyXUREZbtPkkZnu3iMg2mkydYl7RM10dbxP
         8IilIbbjRvbUEMRjAQKrldQuDpbsymmLm3Ep0pEFTTodoko+P7h092eU2eE80d+llwLM
         TP+A+lg+Ke+G3lw4Vw4es16BzOBcVF+xyW6EbMZA2DaafK0Rb2hjJ4acuikXnZY8mwoi
         mVMnYJ3ozT2Skmm2chId/LfqDup4qlEVBaDQ6TYkVhgin/Zi3RqZ5aM2ZDzpKHLbqIw5
         WtrA==
X-Gm-Message-State: AOAM5302TqjRi6AL6xQ56ibgeYKNkS4Mr/skdQeeWJJXHccZNCYAMgdl
        Rxayqj7MVwUoUmi9eyT8MHxD7KGioYct/QP+CQG0D19w12k=
X-Google-Smtp-Source: ABdhPJwiPFE8fdGZixjazWuzi7yJKv+5h1ACgsQMcp2+YO1XcbXd+6bVa6c5pWYdoHLKobd3nqtKYGMm6a6IidIncik=
X-Received: by 2002:ae9:ed96:: with SMTP id c144mr370649qkg.221.1644870221334;
 Mon, 14 Feb 2022 12:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20220201205534.1962784-1-haoluo@google.com> <20220201205534.1962784-6-haoluo@google.com>
 <20220203180414.blk6ou3ccmod2qck@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7jkJbvQrTx4oPJAoBZ0EOCtr3C2PKbrzhxj-7euBK8ojg@mail.gmail.com>
 <CAADnVQLZZ3SM2CDxnzgOnDgRtGU7+6wT9u5v4oFas5MnZF6DsQ@mail.gmail.com>
 <CA+khW7i+TScwPZ6-rcFKiXtxMm8hiZYJGH-wYb=7jBvDWg8pJQ@mail.gmail.com>
 <CAADnVQ+-29CS7nSXghKMgZjKte84L0nRDegUE0ObFm3d7E=eWw@mail.gmail.com>
 <CA+khW7iWd5MzZW_mCfgqHESi8okjNRiRMr0TM=CQzLkMsa_a5g@mail.gmail.com>
 <CAADnVQJcTAgcbwrOWO8EnbTdAcQ91HQmtpn7aKJGwHc=mEpJ1g@mail.gmail.com>
 <CA+khW7i46Rg8q=8goXdmuJuZ+NOuZ5AP6fSbSVzyqcU3C5iX4A@mail.gmail.com> <CAADnVQK+Eh9qCuoBWZ1cRQ4h+fS5J+zy+GePEGXijZ_BD_5Q3w@mail.gmail.com>
In-Reply-To: <CAADnVQK+Eh9qCuoBWZ1cRQ4h+fS5J+zy+GePEGXijZ_BD_5Q3w@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 14 Feb 2022 12:23:29 -0800
Message-ID: <CA+khW7jeptVgZziTqexXp2dNC0Kk+di8f8xkd2dTzXb8YR0Mjw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 5/5] selftests/bpf: test for pinning for
 cgroup_view link
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, Feb 14, 2022 at 11:25 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 14, 2022 at 10:29 AM Hao Luo <haoluo@google.com> wrote:
> > Hi Alexei,
> >
> > Actually, I found this almost worked, except that the tracepoints
> > cgroup_mkdir and cgroup_rmdir are not sleepable. They are inside a
> > spinlock's critical section with irq off. I guess one solution is to
> > offload the sleepable part of the bpf prog into a thread context. We
> > may create a dedicated kernel thread or use workqueue for this. Do you
> > have any advice?
>
> Are you referring to spin_lock in TRACE_CGROUP_PATH
> that protects global trace_cgroup_path[] buffer?

Yes, that's the spin_lock I am talking about.

> That is fixable.
> Do you actually need the string path returned by cgroup_path() in bpf prog?
> Maybe prog can call cgroup_path() by itself when necessary.
> Parsing strings isn't great anyway. The bpf prog probably needs the last
> part of the dir only. So cgrp->kn->name would do it?
> The TRACE_CGROUP_PATH wasn't designed to be turned on 24/7.
> That global spin_lock is not great for production use.
> No need to delegate sleepable bpf to thread context.
> Let's refactor that tracepoint a bit.

No, we don't need cgroup_path(). We are going to name the directories
by cgrp->kn->id. I can add a fast version for cgroup_xxx tracepoints,
which don't require the full path and can be turned on 24/7.
