Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695C04EB2E3
	for <lists+bpf@lfdr.de>; Tue, 29 Mar 2022 19:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbiC2Rpj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Mar 2022 13:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbiC2Rph (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Mar 2022 13:45:37 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3B6241B41
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 10:43:54 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id ke15so14929773qvb.11
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2noiAB4JhD//sQbtMNMDRU7L/9/z/AP4LRXU3Z5+JvY=;
        b=otNRkeUJnJtKzUMsBnrSWYanbhWeN1Nr/I/fVv2Rq8w/YmJEhFqXr6Rdld/RrqKqq/
         Q+QQ8gzlwSLGScMxlQeoDphNNODvqG7q/KBtSzPMBramlM33AO68I36uzWljETzdzbWY
         YsnqA+fY31Sm+w7+q5jq4FGCjr6DS7m2Wlnf1UQ2NgeTlzm8JSaRD+c8FvhlhqMCTFU6
         WDDWdB+FuCgV80VJHGOOxuoA3iQQa3f+x8z1Q4d4nKPsoKB8P7IkUeG7O41qZTpKYZkC
         Xa4ZWwSgDht52/RJdVxsEs9kRTRtDL6yjBmtPGOfqbNNYY6pasj9PcjTjlNc+lfWIWNb
         nKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2noiAB4JhD//sQbtMNMDRU7L/9/z/AP4LRXU3Z5+JvY=;
        b=8JAsgivBD16tXXODLe++WlOkdSZHp2jIMtGT2IWORbM4CYSF3UPKABxo64RkYYDcEm
         QLV+VH97/k5WWnx5R/D2+27YAGeZnVCF/nU/sCZ8SEPjkClmxFwXigtsS7iU+3crcuJL
         bKao9ZBRR8qzo2XnViIhU9zNYR8Cog0XLGz5zcyInq9lH5xI6b50PSsoF+Y1PpE/aC3g
         FnkLmmIasR+Eth7fk/betUgJ0zkIguCaPXeSVDwT2NB9Gktqz35BaW122WcaS2VIFyG+
         U/30vDRYQy2SzQrKWzhe3POvOpxYHrCOt+iauKaYoUF8BWPXu1ilHbQqpLzCgMSneRxq
         /htg==
X-Gm-Message-State: AOAM531+8/eOHxCwri/6rTQHckGPOZZIod84P+5m0Rp+46gC9rFejD04
        fh6BYhGlH9VUxatvA+nJLCxJbPQLly02cyIHDWxDDw==
X-Google-Smtp-Source: ABdhPJzS0MyLxNl7VoGIMNAjsfEGHGfg+9QRPDqN6YXeAuaXQZzcG+MJ9zzBtsMr7izpJQNsjGTrAhKsvfpztruHfHs=
X-Received: by 2002:a05:6214:d8d:b0:441:686e:f2c6 with SMTP id
 e13-20020a0562140d8d00b00441686ef2c6mr27348549qve.44.1648575833484; Tue, 29
 Mar 2022 10:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220324234123.1608337-1-haoluo@google.com> <9cdf860d-8370-95b5-1688-af03265cc874@fb.com>
 <CA+khW7g3hy61qnvtqUizaW+qB6wk=Y9cjivhORshOk=ZzTXJ-A@mail.gmail.com>
 <CA+khW7iq+UKsfQxdT3QpSqPUFN8gQWWDLoQ9zxB=uWTs63AZEA@mail.gmail.com> <20220329093753.26wc3noelqrwlrcj@apollo.legion>
In-Reply-To: <20220329093753.26wc3noelqrwlrcj@apollo.legion>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 29 Mar 2022 10:43:42 -0700
Message-ID: <CA+khW7jW47SALTfxMKfQoA0Qwqd22GC0z4S5juFTbxLfTSbFEQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/2] Mmapable task local storage.
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
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

On Tue, Mar 29, 2022 at 2:37 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, Mar 28, 2022 at 11:16:15PM IST, Hao Luo wrote:
> > On Mon, Mar 28, 2022 at 10:39 AM Hao Luo <haoluo@google.com> wrote:
> > >
> > > Hi Yonghong,
> > >
> > > On Fri, Mar 25, 2022 at 12:16 PM Yonghong Song <yhs@fb.com> wrote:
> > > >
> > > > On 3/24/22 4:41 PM, Hao Luo wrote:
> > > > > Some map types support mmap operation, which allows userspace to
> > > > > communicate with BPF programs directly. Currently only arraymap
> > > > > and ringbuf have mmap implemented.
> > > > >
> > > > > However, in some use cases, when multiple program instances can
> > > > > run concurrently, global mmapable memory can cause race. In that
> > > > > case, userspace needs to provide necessary synchronizations to
> > > > > coordinate the usage of mapped global data. This can be a source
> > > > > of bottleneck.
> > > >
> > > > I can see your use case here. Each calling process can get the
> > > > corresponding bpf program task local storage data through
> > > > mmap interface. As you mentioned, there is a tradeoff
> > > > between more memory vs. non-global synchronization.
> > > >
> > > > I am thinking that another bpf_iter approach can retrieve
> > > > the similar result. We could implement a bpf_iter
> > > > for task local storage map, optionally it can provide
> > > > a tid to retrieve the data for that particular tid.
> > > > This way, user space needs an explicit syscall, but
> > > > does not need to allocate more memory than necessary.
> > > >
> > > > WDYT?
> > > >
> > >
> > > Thanks for the suggestion. I have two thoughts about bpf_iter + tid and mmap:
> > >
> > > - mmap prevents the calling task from reading other task's value.
> > > Using bpf_iter, one can pass other task's tid to get their values. I
> > > assume there are two potential ways of passing tid to bpf_iter: one is
> > > to use global data in bpf prog, the other is adding tid parameterized
> > > iter_link. For the first, it's not easy for unpriv tasks to use. For
> > > the second, we need to create one iter_link object for each interested
> > > tid. It may not be easy to use either.
> > >
> > > - Regarding adding an explicit syscall. I thought about adding
> > > write/read syscalls for task local storage maps, just like reading
> > > values from iter_link. Writing or reading task local storage map
> > > updates/reads the current task's value. I think this could achieve the
> > > same effect as mmap.
> > >
> >
> > Actually, my use case of using mmap on task local storage is to allow
> > userspace to pass FDs into bpf prog. Some of the helpers I want to add
> > need to take an FD as parameter and the bpf progs can run
> > concurrently, thus using global data is racy. Mmapable task local
> > storage is the best solution I can find for this purpose.
> >
> > Song also mentioned to me offline, that mmapable task local storage
> > may be useful for his use case.
> >
> > I am actually open to other proposals.
> >
>
> You could also use a syscall prog, and use bpf_prog_test_run to update local
> storage for current. Data can be passed for that specific prog invocation using
> ctx. You might have to enable bpf_task_storage helpers in it though, since they
> are not allowed to be called right now.
>

The loading process needs CAP_BPF to load bpf_prog_test_run. I'm
thinking of allowing any thread including unpriv ones to be able to
pass data to the prog and update their own storage.

> > > > >
> > > > > It would be great to have a mmapable local storage in that case.
> > > > > This patch adds that.
> > > > >
> > > > > Mmap isn't BPF syscall, so unpriv users can also use it to
> > > > > interact with maps.
> > > > >
> > > > > Currently the only way of allocating mmapable map area is using
> > > > > vmalloc() and it's only used at map allocation time. Vmalloc()
> > > > > may sleep, therefore it's not suitable for maps that may allocate
> > > > > memory in an atomic context such as local storage. Local storage
> > > > > uses kmalloc() with GFP_ATOMIC, which doesn't sleep. This patch
> > > > > uses kmalloc() with GFP_ATOMIC as well for mmapable map area.
> > > > >
> > > > > Allocating mmapable memory has requirment on page alignment. So we
> > > > > have to deliberately allocate more memory than necessary to obtain
> > > > > an address that has sdata->data aligned at page boundary. The
> > > > > calculations for mmapable allocation size, and the actual
> > > > > allocation/deallocation are packaged in three functions:
> > > > >
> > > > >   - bpf_map_mmapable_alloc_size()
> > > > >   - bpf_map_mmapable_kzalloc()
> > > > >   - bpf_map_mmapable_kfree()
> > > > >
> > > > > BPF local storage uses them to provide generic mmap API:
> > > > >
> > > > >   - bpf_local_storage_mmap()
> > > > >
> > > > > And task local storage adds the mmap callback:
> > > > >
> > > > >   - task_storage_map_mmap()
> > > > >
> > > > > When application calls mmap on a task local storage, it gets its
> > > > > own local storage.
> > > > >
> > > > > Overall, mmapable local storage trades off memory with flexibility
> > > > > and efficiency. It brings memory fragmentation but can make programs
> > > > > stateless. Therefore useful in some cases.
> > > > >
> > > > > Hao Luo (2):
> > > > >    bpf: Mmapable local storage.
> > > > >    selftests/bpf: Test mmapable task local storage.
> > > > >
> > > > >   include/linux/bpf.h                           |  4 +
> > > > >   include/linux/bpf_local_storage.h             |  5 +-
> > > > >   kernel/bpf/bpf_local_storage.c                | 73 +++++++++++++++++--
> > > > >   kernel/bpf/bpf_task_storage.c                 | 40 ++++++++++
> > > > >   kernel/bpf/syscall.c                          | 67 +++++++++++++++++
> > > > >   .../bpf/prog_tests/task_local_storage.c       | 38 ++++++++++
> > > > >   .../bpf/progs/task_local_storage_mmapable.c   | 38 ++++++++++
> > > > >   7 files changed, 257 insertions(+), 8 deletions(-)
> > > > >   create mode 100644 tools/testing/selftests/bpf/progs/task_local_storage_mmapable.c
> > > > >
>
> --
> Kartikeya
