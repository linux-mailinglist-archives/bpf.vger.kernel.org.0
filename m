Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3033E4E9DAD
	for <lists+bpf@lfdr.de>; Mon, 28 Mar 2022 19:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244625AbiC1Rlw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 13:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237132AbiC1Rlw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 13:41:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B34E3C713
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 10:40:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i4so2607937wrb.5
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7Pw0UDHvWPbyY/38qBqqCe3PVzLbMMxLL5t1gm37DE=;
        b=Svvqjb2SkS/48q6xbiX2X1wN7mDw3pfoVg/uY/pHR9KLPPwar6u6c+81vO+UOejvKF
         hpg5vPM09bdyxttV9wHFyd/TPD1bp4zjl6Y2rIjrJI8ugdvcmbyNDeKXP3mbDhUqW4tV
         jRzfIy1Tuu8erYzn5+TuzV7AfZl4vCUW+L2gO7UvFOyP7T04KWgnungqiVW5sFMrI/2u
         pPsFqx5SvlO9jrklFVUXFbw84Ncv97fsugiS35TbIYpu4xaTbeu+cELv+UHbSUpRZI34
         gqowc5bDLNi+zb9ZI8vzkDcZIwZDz6WJSNuFpZwncNjNiZainL83C/VRs0+OelDiphyz
         hNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7Pw0UDHvWPbyY/38qBqqCe3PVzLbMMxLL5t1gm37DE=;
        b=yfpKkblXGN9fuRR2h/AFj5yOg/TVx+UBgyBYVx8KgxsZlPw94WVJBJ0qCkzbhl/AQp
         x06m89SgueGk+Yw0iwvRiTOBjLAtYz1BUtnZ+Ny8JZ62H1c+tBEvcxTsGHQ4tykA6EG7
         wfonmulCbGwodfUWUwuh3uvyBhklDcZMddL1Y0rVcTEKSWeLX4Xd6Ta45ZqGwPe2NSTj
         SRkiuJjlUMtXv8LvngkDiWZSRnF1A1mjJNT8T2T67yItdo78EEHCS4CCpuE02V+yJvkk
         AUUcEuhmBdlkSxE5DEhKwukLPiBZlooWRSQJY3q/adNySa0a+vztko8jo53Oiaxvpz9K
         nzew==
X-Gm-Message-State: AOAM530amrE/+SWzm6+SXpyFXTolyIvxGcytla3i1CB4jQvRS2CdOq96
        7Dx/KwAkrRjgKNcv0xuhLlUEt/p5g3P50XjLofPrig==
X-Google-Smtp-Source: ABdhPJxSFYIGnJM4s7WQywzag2MO7U13kk65HieKtWAFHkndyBTCdzYExv1HceSUKep1wMeeCBcmHbWvq0ZzzdDz70s=
X-Received: by 2002:a05:6000:188f:b0:205:4d98:607a with SMTP id
 a15-20020a056000188f00b002054d98607amr24978901wri.505.1648489209640; Mon, 28
 Mar 2022 10:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220324234123.1608337-1-haoluo@google.com> <9cdf860d-8370-95b5-1688-af03265cc874@fb.com>
In-Reply-To: <9cdf860d-8370-95b5-1688-af03265cc874@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 28 Mar 2022 10:39:58 -0700
Message-ID: <CA+khW7g3hy61qnvtqUizaW+qB6wk=Y9cjivhORshOk=ZzTXJ-A@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/2] Mmapable task local storage.
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Yonghong,

On Fri, Mar 25, 2022 at 12:16 PM Yonghong Song <yhs@fb.com> wrote:
>
> On 3/24/22 4:41 PM, Hao Luo wrote:
> > Some map types support mmap operation, which allows userspace to
> > communicate with BPF programs directly. Currently only arraymap
> > and ringbuf have mmap implemented.
> >
> > However, in some use cases, when multiple program instances can
> > run concurrently, global mmapable memory can cause race. In that
> > case, userspace needs to provide necessary synchronizations to
> > coordinate the usage of mapped global data. This can be a source
> > of bottleneck.
>
> I can see your use case here. Each calling process can get the
> corresponding bpf program task local storage data through
> mmap interface. As you mentioned, there is a tradeoff
> between more memory vs. non-global synchronization.
>
> I am thinking that another bpf_iter approach can retrieve
> the similar result. We could implement a bpf_iter
> for task local storage map, optionally it can provide
> a tid to retrieve the data for that particular tid.
> This way, user space needs an explicit syscall, but
> does not need to allocate more memory than necessary.
>
> WDYT?
>

Thanks for the suggestion. I have two thoughts about bpf_iter + tid and mmap:

- mmap prevents the calling task from reading other task's value.
Using bpf_iter, one can pass other task's tid to get their values. I
assume there are two potential ways of passing tid to bpf_iter: one is
to use global data in bpf prog, the other is adding tid parameterized
iter_link. For the first, it's not easy for unpriv tasks to use. For
the second, we need to create one iter_link object for each interested
tid. It may not be easy to use either.

- Regarding adding an explicit syscall. I thought about adding
write/read syscalls for task local storage maps, just like reading
values from iter_link. Writing or reading task local storage map
updates/reads the current task's value. I think this could achieve the
same effect as mmap.

Hao

> >
> > It would be great to have a mmapable local storage in that case.
> > This patch adds that.
> >
> > Mmap isn't BPF syscall, so unpriv users can also use it to
> > interact with maps.
> >
> > Currently the only way of allocating mmapable map area is using
> > vmalloc() and it's only used at map allocation time. Vmalloc()
> > may sleep, therefore it's not suitable for maps that may allocate
> > memory in an atomic context such as local storage. Local storage
> > uses kmalloc() with GFP_ATOMIC, which doesn't sleep. This patch
> > uses kmalloc() with GFP_ATOMIC as well for mmapable map area.
> >
> > Allocating mmapable memory has requirment on page alignment. So we
> > have to deliberately allocate more memory than necessary to obtain
> > an address that has sdata->data aligned at page boundary. The
> > calculations for mmapable allocation size, and the actual
> > allocation/deallocation are packaged in three functions:
> >
> >   - bpf_map_mmapable_alloc_size()
> >   - bpf_map_mmapable_kzalloc()
> >   - bpf_map_mmapable_kfree()
> >
> > BPF local storage uses them to provide generic mmap API:
> >
> >   - bpf_local_storage_mmap()
> >
> > And task local storage adds the mmap callback:
> >
> >   - task_storage_map_mmap()
> >
> > When application calls mmap on a task local storage, it gets its
> > own local storage.
> >
> > Overall, mmapable local storage trades off memory with flexibility
> > and efficiency. It brings memory fragmentation but can make programs
> > stateless. Therefore useful in some cases.
> >
> > Hao Luo (2):
> >    bpf: Mmapable local storage.
> >    selftests/bpf: Test mmapable task local storage.
> >
> >   include/linux/bpf.h                           |  4 +
> >   include/linux/bpf_local_storage.h             |  5 +-
> >   kernel/bpf/bpf_local_storage.c                | 73 +++++++++++++++++--
> >   kernel/bpf/bpf_task_storage.c                 | 40 ++++++++++
> >   kernel/bpf/syscall.c                          | 67 +++++++++++++++++
> >   .../bpf/prog_tests/task_local_storage.c       | 38 ++++++++++
> >   .../bpf/progs/task_local_storage_mmapable.c   | 38 ++++++++++
> >   7 files changed, 257 insertions(+), 8 deletions(-)
> >   create mode 100644 tools/testing/selftests/bpf/progs/task_local_storage_mmapable.c
> >
