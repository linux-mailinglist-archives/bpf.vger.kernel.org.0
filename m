Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D09C4EAA9D
	for <lists+bpf@lfdr.de>; Tue, 29 Mar 2022 11:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbiC2JjR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Mar 2022 05:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiC2JjO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Mar 2022 05:39:14 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971819AE60;
        Tue, 29 Mar 2022 02:37:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p17so17117588plo.9;
        Tue, 29 Mar 2022 02:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/zlJA40sSqkljYS0OOWnIqBOc+WjJedBF8aU/fcWTTY=;
        b=GBpUDTqwoyA1YYDK+A7hIOVsqpUIHtyd/XQW8jY8XkvByC5xhT/PWj9sqv/yxYnYHp
         gOeRaBrFhbKni1j+MuVX52A4RdYJJcQtxv45xbcpUBBYgF4+CReT7Snzd25nnic7Rppr
         3/cTePEtG2Bb17U1K3CMQdeWyb/pxazFOpG7sVwbvvljBxN0wHheusTlmH6nuGYLSoZs
         BLiGXTruyAUPpDP9ormZQOpE3c4nShEHDPt2TP6PtSi+FgPjY6xEBDBvOcbkCNqODsG0
         kID+Dg2CnCsIskzc/ZUcV+1o6uqqReAmWuUCy+D+/zktcl0CfjdidksF90j8N2uGaS6j
         3xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/zlJA40sSqkljYS0OOWnIqBOc+WjJedBF8aU/fcWTTY=;
        b=xn7tJLA5KtRIvCJ7RT5Zj4YRGfsw10SG/Ytp0QnJvRYDnfIF//LpQ5rkD+3KZd4rp+
         gm67Q/AsMCZJi2Li8LptdXtq463AoGUaBYT/310m/COi6j9SyDGxtzBABgFoPYHY7kOU
         nLP04ACWPKybDo2G4SGucQINcWpjlP2iELhdsaUjJ0eXcfClMxHfgTvheFEO3lCKxPDF
         sN32MPOPMhtSyF/sOfpOmCnUkItn8vJqzhy2xfV5nEvtBUd6xAVQgnCAmIPTt7ld97nk
         CwPLIiI5KpJVb3NBvpmwzX55r+1PqZsKq+OhgpzPuBGnAwGtJ03Wiad3DeRONfKDT7tR
         k3PQ==
X-Gm-Message-State: AOAM531gaOprSe0ZTQANOK2yEx+ZP3MOn7mV2dT//dLkXW1amINibtBG
        ee0cXQ2Wr/TfKliet6w+86s=
X-Google-Smtp-Source: ABdhPJzT3dIG8SJFhjVfTkrfD3JKvEXGlgzY5FjXT20ao6Jple9/qf6KIxNrTIGZ95Toq+rymdekSQ==
X-Received: by 2002:a17:902:6b8b:b0:14d:66c4:f704 with SMTP id p11-20020a1709026b8b00b0014d66c4f704mr30087841plk.53.1648546649959;
        Tue, 29 Mar 2022 02:37:29 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a000cd000b004fadb6f0290sm19167984pfv.11.2022.03.29.02.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 02:37:29 -0700 (PDT)
Date:   Tue, 29 Mar 2022 15:07:53 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Hao Luo <haoluo@google.com>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 0/2] Mmapable task local storage.
Message-ID: <20220329093753.26wc3noelqrwlrcj@apollo.legion>
References: <20220324234123.1608337-1-haoluo@google.com>
 <9cdf860d-8370-95b5-1688-af03265cc874@fb.com>
 <CA+khW7g3hy61qnvtqUizaW+qB6wk=Y9cjivhORshOk=ZzTXJ-A@mail.gmail.com>
 <CA+khW7iq+UKsfQxdT3QpSqPUFN8gQWWDLoQ9zxB=uWTs63AZEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7iq+UKsfQxdT3QpSqPUFN8gQWWDLoQ9zxB=uWTs63AZEA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 28, 2022 at 11:16:15PM IST, Hao Luo wrote:
> On Mon, Mar 28, 2022 at 10:39 AM Hao Luo <haoluo@google.com> wrote:
> >
> > Hi Yonghong,
> >
> > On Fri, Mar 25, 2022 at 12:16 PM Yonghong Song <yhs@fb.com> wrote:
> > >
> > > On 3/24/22 4:41 PM, Hao Luo wrote:
> > > > Some map types support mmap operation, which allows userspace to
> > > > communicate with BPF programs directly. Currently only arraymap
> > > > and ringbuf have mmap implemented.
> > > >
> > > > However, in some use cases, when multiple program instances can
> > > > run concurrently, global mmapable memory can cause race. In that
> > > > case, userspace needs to provide necessary synchronizations to
> > > > coordinate the usage of mapped global data. This can be a source
> > > > of bottleneck.
> > >
> > > I can see your use case here. Each calling process can get the
> > > corresponding bpf program task local storage data through
> > > mmap interface. As you mentioned, there is a tradeoff
> > > between more memory vs. non-global synchronization.
> > >
> > > I am thinking that another bpf_iter approach can retrieve
> > > the similar result. We could implement a bpf_iter
> > > for task local storage map, optionally it can provide
> > > a tid to retrieve the data for that particular tid.
> > > This way, user space needs an explicit syscall, but
> > > does not need to allocate more memory than necessary.
> > >
> > > WDYT?
> > >
> >
> > Thanks for the suggestion. I have two thoughts about bpf_iter + tid and mmap:
> >
> > - mmap prevents the calling task from reading other task's value.
> > Using bpf_iter, one can pass other task's tid to get their values. I
> > assume there are two potential ways of passing tid to bpf_iter: one is
> > to use global data in bpf prog, the other is adding tid parameterized
> > iter_link. For the first, it's not easy for unpriv tasks to use. For
> > the second, we need to create one iter_link object for each interested
> > tid. It may not be easy to use either.
> >
> > - Regarding adding an explicit syscall. I thought about adding
> > write/read syscalls for task local storage maps, just like reading
> > values from iter_link. Writing or reading task local storage map
> > updates/reads the current task's value. I think this could achieve the
> > same effect as mmap.
> >
>
> Actually, my use case of using mmap on task local storage is to allow
> userspace to pass FDs into bpf prog. Some of the helpers I want to add
> need to take an FD as parameter and the bpf progs can run
> concurrently, thus using global data is racy. Mmapable task local
> storage is the best solution I can find for this purpose.
>
> Song also mentioned to me offline, that mmapable task local storage
> may be useful for his use case.
>
> I am actually open to other proposals.
>

You could also use a syscall prog, and use bpf_prog_test_run to update local
storage for current. Data can be passed for that specific prog invocation using
ctx. You might have to enable bpf_task_storage helpers in it though, since they
are not allowed to be called right now.

> > > >
> > > > It would be great to have a mmapable local storage in that case.
> > > > This patch adds that.
> > > >
> > > > Mmap isn't BPF syscall, so unpriv users can also use it to
> > > > interact with maps.
> > > >
> > > > Currently the only way of allocating mmapable map area is using
> > > > vmalloc() and it's only used at map allocation time. Vmalloc()
> > > > may sleep, therefore it's not suitable for maps that may allocate
> > > > memory in an atomic context such as local storage. Local storage
> > > > uses kmalloc() with GFP_ATOMIC, which doesn't sleep. This patch
> > > > uses kmalloc() with GFP_ATOMIC as well for mmapable map area.
> > > >
> > > > Allocating mmapable memory has requirment on page alignment. So we
> > > > have to deliberately allocate more memory than necessary to obtain
> > > > an address that has sdata->data aligned at page boundary. The
> > > > calculations for mmapable allocation size, and the actual
> > > > allocation/deallocation are packaged in three functions:
> > > >
> > > >   - bpf_map_mmapable_alloc_size()
> > > >   - bpf_map_mmapable_kzalloc()
> > > >   - bpf_map_mmapable_kfree()
> > > >
> > > > BPF local storage uses them to provide generic mmap API:
> > > >
> > > >   - bpf_local_storage_mmap()
> > > >
> > > > And task local storage adds the mmap callback:
> > > >
> > > >   - task_storage_map_mmap()
> > > >
> > > > When application calls mmap on a task local storage, it gets its
> > > > own local storage.
> > > >
> > > > Overall, mmapable local storage trades off memory with flexibility
> > > > and efficiency. It brings memory fragmentation but can make programs
> > > > stateless. Therefore useful in some cases.
> > > >
> > > > Hao Luo (2):
> > > >    bpf: Mmapable local storage.
> > > >    selftests/bpf: Test mmapable task local storage.
> > > >
> > > >   include/linux/bpf.h                           |  4 +
> > > >   include/linux/bpf_local_storage.h             |  5 +-
> > > >   kernel/bpf/bpf_local_storage.c                | 73 +++++++++++++++++--
> > > >   kernel/bpf/bpf_task_storage.c                 | 40 ++++++++++
> > > >   kernel/bpf/syscall.c                          | 67 +++++++++++++++++
> > > >   .../bpf/prog_tests/task_local_storage.c       | 38 ++++++++++
> > > >   .../bpf/progs/task_local_storage_mmapable.c   | 38 ++++++++++
> > > >   7 files changed, 257 insertions(+), 8 deletions(-)
> > > >   create mode 100644 tools/testing/selftests/bpf/progs/task_local_storage_mmapable.c
> > > >

--
Kartikeya
