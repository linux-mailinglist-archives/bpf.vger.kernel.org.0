Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22885693280
	for <lists+bpf@lfdr.de>; Sat, 11 Feb 2023 17:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjBKQez (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Feb 2023 11:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBKQey (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Feb 2023 11:34:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D866426848;
        Sat, 11 Feb 2023 08:34:53 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id fi26so7866902edb.7;
        Sat, 11 Feb 2023 08:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GdQ9tak96Dy9uB/Zmg/NLNczt6OnEeM92nMXwoZd93E=;
        b=j/XocirCN1GQGaNpx7o9M7HdBkAiQZEPUJT8heh9E1WS2ZPPYaPbHYYfXeu6CqaN78
         jYpjZTMnszG7xIqAayZcmFWDHFBiSafIfAz3vMEN+d2jnc68yseajI7qUqc0OmpsCRW9
         FeHccKg+ukNHvZJ6e7iskwxsd/U3aoNJpNJh1Dw5gRYZXy5NS8zSvNTSvQZd1apce5K3
         Ql3SgzUwBZZr++Cf7KMhg7caMFeOCxuZVsKdwI20iSNbQ1GNLvPdTpKCB3PRvWp6zCNv
         gouUaqLR4LhFZKaxbLfblKAymiajjiCX41NSQouM2qTd6Armpi3DOI5QehRy1zYbvOqK
         Yw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdQ9tak96Dy9uB/Zmg/NLNczt6OnEeM92nMXwoZd93E=;
        b=q9db780jT+HtzFYNd82qgcgAMMmbcpeHpaq6xMw/QcLWGuNTaEheVzRkBDGQGnrynE
         vgv0pHJ/+uPNztdTccIym+LUvIFFf0fWHV/43hlEKRShivySLcFWSX06S8vrf0AxnoOL
         7XWLD02BVnDT19k0PLqbdUgUD99QXVBBK49uF/ha6MB+yUV6YreN3iBLVW2K07C3OFo7
         zZnOWgbPK9OQC1npWwSdLNnZYvByOwyx8WNMwnZhKNNqwDa/SQUm4vCAQLf8AvvzKUZg
         pDIMzI5V2srEcl54pvNasScPuAfim5RJ9asfI1vyHXMcInMibqeFd22c6e3+uRbGMcAP
         5elg==
X-Gm-Message-State: AO0yUKUkwp7YvXAy7ulDSeqWFVcHzw2GiLwufR3hsG4nDrxESeQfdfvQ
        /32pTT2aLpkcrAEb9HzY7Wt7DaOF4jYftavu/ms=
X-Google-Smtp-Source: AK7set/udMjRCmrE595y7OkiYi0r2K55VF2upVtW7pM9hXpaRlhrxkWzwICuC73Ho/bh+qt0NPmFgM2z9ozhamsDIJk=
X-Received: by 2002:a50:9f65:0:b0:4ac:b38f:51a1 with SMTP id
 b92-20020a509f65000000b004acb38f51a1mr1307807edf.6.1676133292290; Sat, 11 Feb
 2023 08:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com> <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
 <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com> <1d97a5c0-d1fb-a625-8e8d-25ef799ee9e2@huaweicloud.com>
 <e205d4a3-a885-93c7-5d02-2e9fd87348e8@meta.com> <CAADnVQLCWdN-Rw7BBxqErUdxBGOMNq39NkM3XJ=O=saG08yVgw@mail.gmail.com>
 <20230210163258.phekigglpquitq33@apollo> <CAADnVQLVi7CcW9ci62Dps4mxCEqHOYvYJ-Fant-0kSy0vPZ3AA@mail.gmail.com>
 <bf936f22-f8b7-c4a3-41a1-c3f2f115e67a@huaweicloud.com> <CAADnVQKecUqGF-gLFS5Wiz7_E-cHOkp7NPCUK0woHUmJG6hEuA@mail.gmail.com>
In-Reply-To: <CAADnVQKecUqGF-gLFS5Wiz7_E-cHOkp7NPCUK0woHUmJG6hEuA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 11 Feb 2023 08:34:41 -0800
Message-ID: <CAADnVQJzS9MQKS2EqrdxO7rVLyjUYD6OG-Yefak62-JRNcheZg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Hou Tao <houtao1@huawei.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 11, 2023 at 8:33 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 10, 2023 at 5:10 PM Hou Tao <houtao@huaweicloud.com> wrote:
> > >> Hou, are you plannning to resubmit this change? I also hit this while testing my
> > >> changes on bpf-next.
> > > Are you talking about the whole patch set or just GFP_ZERO in mem_alloc?
> > > The former will take a long time to settle.
> > > The latter is trivial.
> > > To unblock yourself just add GFP_ZERO in an extra patch?
> > Sorry for the long delay. Just find find out time to do some tests to compare
> > the performance of bzero and ctor. After it is done, will resubmit on next week.
>
> I still don't like ctor as a concept. In general the callbacks in the critical
> path are guaranteed to be slow due to retpoline overhead.
> Please send a patch to add GFP_ZERO.
>
> Also I realized that we can make the BPF_REUSE_AFTER_RCU_GP flag usable
> without risking OOM by only waiting for normal rcu GP and not rcu_tasks_trace.
> This approach will work for inner nodes of qptrie, since bpf progs
> never see pointers to them. It will work for local storage
> converted to bpf_mem_alloc too. It wouldn't need to use its own call_rcu.
> It's also safe without uaf caveat in sleepable progs and sleepable progs

I meant 'safe with uaf caveat'.
Safe because we wait for rcu_task_trace later before returning to kernel memory.

> can use explicit bpf_rcu_read_lock() when they want to avoid uaf.
> So please respin the set with rcu gp only and that new flag.
