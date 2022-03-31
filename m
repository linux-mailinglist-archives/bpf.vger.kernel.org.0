Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B524EE413
	for <lists+bpf@lfdr.de>; Fri,  1 Apr 2022 00:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242494AbiCaWeN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 18:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242474AbiCaWeM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 18:34:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AB11B9FF3
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 15:32:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66A5C6127D
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 22:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8305C3410F
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 22:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648765942;
        bh=MI8AewDSQkp1S3OGkehy1DQErFde/A/tnZsKwUdv8F4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lhQiSoGpV0ttrCt64gxcdlRVxUPVdVtzxK39qNRHsjzFwqlunr4FujTCAZA3YGNTM
         xgUHPDHNbMtUSvqMwhVPlHlfebgCm0kwJPMmgj8xcI0BChfVJkDwS8SKQ9rp53UqER
         ryP+RAa5sa+nvgVr1CCXmoj30PPNzzyLHFrOZx1e9gEwnp7VAsnz3mZ0H1gdul+9AG
         AngPjloMsCsBKsCyPEO/Ci+jR6ezpCgcSc1eZ0Tr6wq8SMNvPjhci2paEjKCQLTBeF
         eKuh/b9Ps8iOxP9JJ+W0LiK45jHNwjLO7uO8G+wvUOR/j9m0nNrfNLu2URXBNawQIs
         Fuvt/K4KNFrlw==
Received: by mail-ed1-f46.google.com with SMTP id b24so905845edu.10
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 15:32:22 -0700 (PDT)
X-Gm-Message-State: AOAM530Sa7k4zeMlDf/1zpHORRuKid/B5GxH7tAUuQvgGCutzIxg7PMP
        TRnb+jPf9pWmlYyH3hB75PGdHufAYpqbMA/IV8Zw5A==
X-Google-Smtp-Source: ABdhPJwhoWz6DTXp6kj/giCuaqEceu+yembhXjMKP1Iyqzysm3LTuspPTK9zOGnc8SVv2O1RoZgWqcQlxjNXsYO1Wzg=
X-Received: by 2002:a05:6402:348b:b0:419:172c:e2aa with SMTP id
 v11-20020a056402348b00b00419172ce2aamr18499542edc.261.1648765940962; Thu, 31
 Mar 2022 15:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220324234123.1608337-1-haoluo@google.com> <9cdf860d-8370-95b5-1688-af03265cc874@fb.com>
 <CA+khW7g3hy61qnvtqUizaW+qB6wk=Y9cjivhORshOk=ZzTXJ-A@mail.gmail.com>
 <CA+khW7iq+UKsfQxdT3QpSqPUFN8gQWWDLoQ9zxB=uWTs63AZEA@mail.gmail.com>
 <20220329093753.26wc3noelqrwlrcj@apollo.legion> <CA+khW7jW47SALTfxMKfQoA0Qwqd22GC0z4S5juFTbxLfTSbFEQ@mail.gmail.com>
 <20220329232956.gbsr65jdbe4lw2m6@ast-mbp> <CA+khW7jyvp4PKGu5GS8GDf=Lr4EdRUz8kraaTfiZ2oGm704Cpw@mail.gmail.com>
 <CAADnVQLTBhCTAx1a_nev7CgMZxv1Bb7ecz1AFRin8tHmjPREJA@mail.gmail.com> <CA+khW7iqiKTLi75oSPe+ibV8afR_SPgtg7Q+nEswmMOFZaAebA@mail.gmail.com>
In-Reply-To: <CA+khW7iqiKTLi75oSPe+ibV8afR_SPgtg7Q+nEswmMOFZaAebA@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 1 Apr 2022 00:32:10 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6-csGkdMQiGYYr5_DgShPWrUFfs92sUOhwzQt=T13+SA@mail.gmail.com>
Message-ID: <CACYkzJ6-csGkdMQiGYYr5_DgShPWrUFfs92sUOhwzQt=T13+SA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/2] Mmapable task local storage.
To:     Hao Luo <haoluo@google.com>, Jann Horn <jannh@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 30, 2022 at 8:26 PM Hao Luo <haoluo@google.com> wrote:
>
> On Wed, Mar 30, 2022 at 11:16 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Mar 30, 2022 at 11:06 AM Hao Luo <haoluo@google.com> wrote:
> > >
> > > On Tue, Mar 29, 2022 at 4:30 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Tue, Mar 29, 2022 at 10:43:42AM -0700, Hao Luo wrote:
> > > > > On Tue, Mar 29, 2022 at 2:37 AM Kumar Kartikeya Dwivedi
> > > > > <memxor@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Mar 28, 2022 at 11:16:15PM IST, Hao Luo wrote:
> > > > > > > On Mon, Mar 28, 2022 at 10:39 AM Hao Luo <haoluo@google.com> wrote:
> > > > > > > >
> > > > > > > > Hi Yonghong,
> > > > > > > >
> > > > > > > > On Fri, Mar 25, 2022 at 12:16 PM Yonghong Song <yhs@fb.com> wrote:
> > > > > > > > >
> > > > > > > > > On 3/24/22 4:41 PM, Hao Luo wrote:
> > > > > > > > > > Some map types support mmap operation, which allows userspace to
> > > > > > > > > > communicate with BPF programs directly. Currently only arraymap
> > > > > > > > > > and ringbuf have mmap implemented.
> > > > > > > > > >
> > > > > > > > > > However, in some use cases, when multiple program instances can
> > > > > > > > > > run concurrently, global mmapable memory can cause race. In that
> > > > > > > > > > case, userspace needs to provide necessary synchronizations to
> > > > > > > > > > coordinate the usage of mapped global data. This can be a source
> > > > > > > > > > of bottleneck.
> > > > > > > > >
> > > > > > > > > I can see your use case here. Each calling process can get the
> > > > > > > > > corresponding bpf program task local storage data through
> > > > > > > > > mmap interface. As you mentioned, there is a tradeoff
> > > > > > > > > between more memory vs. non-global synchronization.
> > > > > > > > >
> > > > > > > > > I am thinking that another bpf_iter approach can retrieve
> > > > > > > > > the similar result. We could implement a bpf_iter
> > > > > > > > > for task local storage map, optionally it can provide
> > > > > > > > > a tid to retrieve the data for that particular tid.
> > > > > > > > > This way, user space needs an explicit syscall, but
> > > > > > > > > does not need to allocate more memory than necessary.
> > > > > > > > >
> > > > > > > > > WDYT?
> > > > > > > > >
> > > > > > > >
> > > > > > > > Thanks for the suggestion. I have two thoughts about bpf_iter + tid and mmap:
> > > > > > > >
> > > > > > > > - mmap prevents the calling task from reading other task's value.
> > > > > > > > Using bpf_iter, one can pass other task's tid to get their values. I
> > > > > > > > assume there are two potential ways of passing tid to bpf_iter: one is
> > > > > > > > to use global data in bpf prog, the other is adding tid parameterized
> > > > > > > > iter_link. For the first, it's not easy for unpriv tasks to use. For
> > > > > > > > the second, we need to create one iter_link object for each interested
> > > > > > > > tid. It may not be easy to use either.
> > > > > > > >
> > > > > > > > - Regarding adding an explicit syscall. I thought about adding
> > > > > > > > write/read syscalls for task local storage maps, just like reading
> > > > > > > > values from iter_link. Writing or reading task local storage map
> > > > > > > > updates/reads the current task's value. I think this could achieve the
> > > > > > > > same effect as mmap.
> > > > > > > >
> > > > > > >
> > > > > > > Actually, my use case of using mmap on task local storage is to allow
> > > > > > > userspace to pass FDs into bpf prog. Some of the helpers I want to add
> > > > > > > need to take an FD as parameter and the bpf progs can run
> > > > > > > concurrently, thus using global data is racy. Mmapable task local
> > > > > > > storage is the best solution I can find for this purpose.
> > > > > > >
> > > > > > > Song also mentioned to me offline, that mmapable task local storage
> > > > > > > may be useful for his use case.
> > > > > > >
> > > > > > > I am actually open to other proposals.
> > > > > > >
> > > > > >
> > > > > > You could also use a syscall prog, and use bpf_prog_test_run to update local
> > > > > > storage for current. Data can be passed for that specific prog invocation using
> > > > > > ctx. You might have to enable bpf_task_storage helpers in it though, since they
> > > > > > are not allowed to be called right now.
> > > > > >
> > > > >
> > > > > The loading process needs CAP_BPF to load bpf_prog_test_run. I'm
> > > > > thinking of allowing any thread including unpriv ones to be able to
> > > > > pass data to the prog and update their own storage.
> > > >
> > > > If I understand the use case correctly all of this mmap-ing is only to
> > > > allow unpriv userspace to access a priv map via unpriv mmap() syscall.
> > > > But the map can be accessed as unpriv already.
> > > > Pin it with the world read creds and do map_lookup sys_bpf cmd on it.
> > >
> > > Right, but, if I understand correctly, with
> > > sysctl_unprivileged_bpf_disabled, unpriv tasks are not able to make
> > > use of __sys_bpf(). Is there anything I missed?
> >
> > That sysctl is a heavy hammer. Let's fix it instead.
> > map lookup/update/delete can be allowed for unpriv for certain map types.
> > There are permissions checks in corresponding lookup/update calls already.
>

(Adding Jann)

I wonder if we can tag a map as BPF_F_UNPRIVILEGED and allow the writes to
only maps that are explicitly marked as writable by unprivileged processes.

We will have task local storage in LSM programs that we
won't like unprivileged processes to write to as well.

struct {
        __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
        __uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_UNPRIVILEGED);
        __type(key, int);
        __type(value, struct fd_storage);
} task_fd_storage_map SEC(".maps");

- KP

> This sounds great. If we can allow basic map operations for some map
> types, it will change many use cases I'm looking at. Let me take a
> look and report back.
