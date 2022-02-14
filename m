Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84014B5AD8
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 21:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiBNUHc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 15:07:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiBNUHc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 15:07:32 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DB111ACE3;
        Mon, 14 Feb 2022 12:07:17 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id r27so18618073oiw.4;
        Mon, 14 Feb 2022 12:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+qaLj5PeJFZmiJ725JeU6P2tttdbBuvpV2cQ0sO28w=;
        b=HRaK5XDjfwgK07M+uIki6Hy3scx/ZNV3tSk5ugGAPnaWNgB1kcaO4X5LjC3AK3dGSB
         /2YubVyCCs/QL8epvMOPDGhWDbdMAPZRegrNiwGo1aYBItCy+AbIzPD5+X9y92kTK9xN
         mwzpDadGRImpO0OTvp64bqEr50T08Ms2LXw9vA1dVxjDVkcPhGh8Aw6y5ehK7cctyz4I
         C+pEL+ScxlB4v6ZHkr7gMiGNxnppf68osRxiZVX0WMcXJPh6EitaScsXW4N12nYey9E+
         /S73g9BaZhk9yZp17a1Q3Halqi4DT4U+dlEaTu/GP6zgv+3mgnFqaKlNBK2IArBSt6hv
         YpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+qaLj5PeJFZmiJ725JeU6P2tttdbBuvpV2cQ0sO28w=;
        b=2WtE20FljNJ7CCJIbycs3S+HKd4WKEmtepg68y3WC5wwhDGevjiePi1a8D2pcNqCAv
         xQfNCrnmVTeshw93Hi747zzk6yS9Wtv8A0lxyyPiijI6cP8iu1qCe50q3xitJNZ3fzsT
         JcTl5509nZBXYmvz38hFcfrFVz/SQvVt8HgAFKbolgRbhcX2zsDRz1tbXw/q1VvrhQNI
         UfCVzuFM4OiNmgheZXYh94WqUWO9WvCZQTg1qSg5FVenqGqqbYbfKshGnLxfPrg6/aZB
         KNEH6y1qLfvHO/WDA6ms0qyouAtNHaQjq3ne+JFvSdlbSBAm6s9bzEmYdrqETugDSeC2
         C4LA==
X-Gm-Message-State: AOAM533qFcZ81W6XTMTH3dx5RkHDgSrJ2prLWN1Oe4Vv7g5IiHWzh9sD
        k7lDWocmkpk6cCMCwhSadsnp+hkwvhVHGI+/Dcb6qL/cHOA=
X-Google-Smtp-Source: ABdhPJxkdJufelV5+Wulm+FPE68886UfKNvwL/u6QTOcUjhbFtvpANs+EwHHjny3HwHpiYb8Vh6woKOgUKLhncksRUI=
X-Received: by 2002:a17:90b:1d84:b0:1b4:dc8e:2cc2 with SMTP id
 pf4-20020a17090b1d8400b001b4dc8e2cc2mr192125pjb.122.1644866701752; Mon, 14
 Feb 2022 11:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20220201205534.1962784-1-haoluo@google.com> <20220201205534.1962784-6-haoluo@google.com>
 <20220203180414.blk6ou3ccmod2qck@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7jkJbvQrTx4oPJAoBZ0EOCtr3C2PKbrzhxj-7euBK8ojg@mail.gmail.com>
 <CAADnVQLZZ3SM2CDxnzgOnDgRtGU7+6wT9u5v4oFas5MnZF6DsQ@mail.gmail.com>
 <CA+khW7i+TScwPZ6-rcFKiXtxMm8hiZYJGH-wYb=7jBvDWg8pJQ@mail.gmail.com>
 <CAADnVQ+-29CS7nSXghKMgZjKte84L0nRDegUE0ObFm3d7E=eWw@mail.gmail.com>
 <CA+khW7iWd5MzZW_mCfgqHESi8okjNRiRMr0TM=CQzLkMsa_a5g@mail.gmail.com>
 <CAADnVQJcTAgcbwrOWO8EnbTdAcQ91HQmtpn7aKJGwHc=mEpJ1g@mail.gmail.com> <CA+khW7i46Rg8q=8goXdmuJuZ+NOuZ5AP6fSbSVzyqcU3C5iX4A@mail.gmail.com>
In-Reply-To: <CA+khW7i46Rg8q=8goXdmuJuZ+NOuZ5AP6fSbSVzyqcU3C5iX4A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 14 Feb 2022 11:24:50 -0800
Message-ID: <CAADnVQK+Eh9qCuoBWZ1cRQ4h+fS5J+zy+GePEGXijZ_BD_5Q3w@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 5/5] selftests/bpf: test for pinning for
 cgroup_view link
To:     Hao Luo <haoluo@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 14, 2022 at 10:29 AM Hao Luo <haoluo@google.com> wrote:
> Hi Alexei,
>
> Actually, I found this almost worked, except that the tracepoints
> cgroup_mkdir and cgroup_rmdir are not sleepable. They are inside a
> spinlock's critical section with irq off. I guess one solution is to
> offload the sleepable part of the bpf prog into a thread context. We
> may create a dedicated kernel thread or use workqueue for this. Do you
> have any advice?

Are you referring to spin_lock in TRACE_CGROUP_PATH
that protects global trace_cgroup_path[] buffer?
That is fixable.
Do you actually need the string path returned by cgroup_path() in bpf prog?
Maybe prog can call cgroup_path() by itself when necessary.
Parsing strings isn't great anyway. The bpf prog probably needs the last
part of the dir only. So cgrp->kn->name would do it?
The TRACE_CGROUP_PATH wasn't designed to be turned on 24/7.
That global spin_lock is not great for production use.
No need to delegate sleepable bpf to thread context.
Let's refactor that tracepoint a bit.
