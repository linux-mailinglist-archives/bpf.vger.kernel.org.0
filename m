Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2474E9DC7
	for <lists+bpf@lfdr.de>; Mon, 28 Mar 2022 19:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbiC1RsK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 13:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244731AbiC1RsI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 13:48:08 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60B1275E6
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 10:46:27 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id k125so12059060qkf.0
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OTiPPMnOln50TZ8P+7s3GLF/+hjvE6KvjSzwQxSGV3c=;
        b=Fm0ykbJRyPVO/B3M1TtAUj97/2QpePdENLBvycMQl72Et5cFTTucKx3PxPU6vHbyaY
         2LOpjhVpM6xaSGIEYzZvrkFLwr0Z0NC0lcL7Kzzby+8EdCi1ztrnxpmgI6JDM+kitiKC
         4JsDfvrMM8cjNdu7pHpgwZwbW2GdCfoVOTBLGG00zBSchkCznKKlNQ0eV3bNZk4hnLNH
         NmfmYzK32P+srh3+Z/OMLGYTsmjFD0QMI2ZnXcAZuwRdI9KRXJOZ0iR3Cts8fxgcwrK4
         Nc0mv/b71Azz0yAA6vcTgzNRtHW63qnAwxup4p6/Yg4dlMORS++VXU7xSpjCTJ20Pjtq
         NNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OTiPPMnOln50TZ8P+7s3GLF/+hjvE6KvjSzwQxSGV3c=;
        b=yKJekupNkOK0owFOka8hBFzvNqJJSALXg5LNcauoEtMebaxs2IqHxg9dDWvAVbHbrz
         Ll3Ue4DvHn1wiswrgbdk8kIkURtNxYxmBx1PEg72+yPT+q/SvGYNCzs0fI6JOmEdSLTo
         YJYnbeRbaG+6aAEcBPxbz12huPArNo+DQLjpTtPL5PKKx6demWo4KOWw0ZoZBeNL15En
         jNQ170ueIKS4maFFqJQXAQ6z8ktzjEIadAbAT7e9uNilNA475ri8yCINH0rT4idcJ8BB
         MMtuxJgLklwkSnts3cU86xuAFCGTZ1QusbhGWWY8zya1s0cm8oEiCf7uPkUyExeDi20x
         7JOQ==
X-Gm-Message-State: AOAM531VSAFJoJun0I38rxXcfFmY+jqwVws57bmQC6f12te4/NGHxdAO
        AwNRYxDqHkxbSP/JzD0v5+4hku2yRFfV/uQiivRhFQ==
X-Google-Smtp-Source: ABdhPJzecbcZJmF/Fy7uF0Uu2GrbQXl/xaZaaQcxtzwDnpxDhCnIw5On4j0ksbMhk7IPAvvWDJ9cEz7ao83mUSO+GpY=
X-Received: by 2002:a05:620a:4110:b0:680:d70a:376d with SMTP id
 j16-20020a05620a411000b00680d70a376dmr3982436qko.446.1648489586646; Mon, 28
 Mar 2022 10:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220324234123.1608337-1-haoluo@google.com> <9cdf860d-8370-95b5-1688-af03265cc874@fb.com>
 <CA+khW7g3hy61qnvtqUizaW+qB6wk=Y9cjivhORshOk=ZzTXJ-A@mail.gmail.com>
In-Reply-To: <CA+khW7g3hy61qnvtqUizaW+qB6wk=Y9cjivhORshOk=ZzTXJ-A@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 28 Mar 2022 10:46:15 -0700
Message-ID: <CA+khW7iq+UKsfQxdT3QpSqPUFN8gQWWDLoQ9zxB=uWTs63AZEA@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 28, 2022 at 10:39 AM Hao Luo <haoluo@google.com> wrote:
>
> Hi Yonghong,
>
> On Fri, Mar 25, 2022 at 12:16 PM Yonghong Song <yhs@fb.com> wrote:
> >
> > On 3/24/22 4:41 PM, Hao Luo wrote:
> > > Some map types support mmap operation, which allows userspace to
> > > communicate with BPF programs directly. Currently only arraymap
> > > and ringbuf have mmap implemented.
> > >
> > > However, in some use cases, when multiple program instances can
> > > run concurrently, global mmapable memory can cause race. In that
> > > case, userspace needs to provide necessary synchronizations to
> > > coordinate the usage of mapped global data. This can be a source
> > > of bottleneck.
> >
> > I can see your use case here. Each calling process can get the
> > corresponding bpf program task local storage data through
> > mmap interface. As you mentioned, there is a tradeoff
> > between more memory vs. non-global synchronization.
> >
> > I am thinking that another bpf_iter approach can retrieve
> > the similar result. We could implement a bpf_iter
> > for task local storage map, optionally it can provide
> > a tid to retrieve the data for that particular tid.
> > This way, user space needs an explicit syscall, but
> > does not need to allocate more memory than necessary.
> >
> > WDYT?
> >
>
> Thanks for the suggestion. I have two thoughts about bpf_iter + tid and mmap:
>
> - mmap prevents the calling task from reading other task's value.
> Using bpf_iter, one can pass other task's tid to get their values. I
> assume there are two potential ways of passing tid to bpf_iter: one is
> to use global data in bpf prog, the other is adding tid parameterized
> iter_link. For the first, it's not easy for unpriv tasks to use. For
> the second, we need to create one iter_link object for each interested
> tid. It may not be easy to use either.
>
> - Regarding adding an explicit syscall. I thought about adding
> write/read syscalls for task local storage maps, just like reading
> values from iter_link. Writing or reading task local storage map
> updates/reads the current task's value. I think this could achieve the
> same effect as mmap.
>

Actually, my use case of using mmap on task local storage is to allow
userspace to pass FDs into bpf prog. Some of the helpers I want to add
need to take an FD as parameter and the bpf progs can run
concurrently, thus using global data is racy. Mmapable task local
storage is the best solution I can find for this purpose.

Song also mentioned to me offline, that mmapable task local storage
may be useful for his use case.

I am actually open to other proposals.

> > >
> > > It would be great to have a mmapable local storage in that case.
> > > This patch adds that.
> > >
> > > Mmap isn't BPF syscall, so unpriv users can also use it to
> > > interact with maps.
> > >
> > > Currently the only way of allocating mmapable map area is using
> > > vmalloc() and it's only used at map allocation time. Vmalloc()
> > > may sleep, therefore it's not suitable for maps that may allocate
> > > memory in an atomic context such as local storage. Local storage
> > > uses kmalloc() with GFP_ATOMIC, which doesn't sleep. This patch
> > > uses kmalloc() with GFP_ATOMIC as well for mmapable map area.
> > >
> > > Allocating mmapable memory has requirment on page alignment. So we
> > > have to deliberately allocate more memory than necessary to obtain
> > > an address that has sdata->data aligned at page boundary. The
> > > calculations for mmapable allocation size, and the actual
> > > allocation/deallocation are packaged in three functions:
> > >
> > >   - bpf_map_mmapable_alloc_size()
> > >   - bpf_map_mmapable_kzalloc()
> > >   - bpf_map_mmapable_kfree()
> > >
> > > BPF local storage uses them to provide generic mmap API:
> > >
> > >   - bpf_local_storage_mmap()
> > >
> > > And task local storage adds the mmap callback:
> > >
> > >   - task_storage_map_mmap()
> > >
> > > When application calls mmap on a task local storage, it gets its
> > > own local storage.
> > >
> > > Overall, mmapable local storage trades off memory with flexibility
> > > and efficiency. It brings memory fragmentation but can make programs
> > > stateless. Therefore useful in some cases.
> > >
> > > Hao Luo (2):
> > >    bpf: Mmapable local storage.
> > >    selftests/bpf: Test mmapable task local storage.
> > >
> > >   include/linux/bpf.h                           |  4 +
> > >   include/linux/bpf_local_storage.h             |  5 +-
> > >   kernel/bpf/bpf_local_storage.c                | 73 +++++++++++++++++--
> > >   kernel/bpf/bpf_task_storage.c                 | 40 ++++++++++
> > >   kernel/bpf/syscall.c                          | 67 +++++++++++++++++
> > >   .../bpf/prog_tests/task_local_storage.c       | 38 ++++++++++
> > >   .../bpf/progs/task_local_storage_mmapable.c   | 38 ++++++++++
> > >   7 files changed, 257 insertions(+), 8 deletions(-)
> > >   create mode 100644 tools/testing/selftests/bpf/progs/task_local_storage_mmapable.c
> > >
