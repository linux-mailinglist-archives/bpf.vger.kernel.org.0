Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB34ECC3E
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 20:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350434AbiC3S3r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Mar 2022 14:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbiC3S3l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Mar 2022 14:29:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAE813CF1
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 11:26:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w4so30464081wrg.12
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrVy6mGFfTezARgPXoahkDtUgtA05SdD0ISAtqjQGmo=;
        b=jeqXOpWvuvTFAZ5ufyJ6gMquwMoLSR57f2nzBHCjKg89AFDu8SChd/gG11luYWyf/D
         2CzAPJvMu3VE37HnTb9n1joxjZ8rZDv/jLDDQxoVM13w9/HSGar33+yelws0I0RzDXuD
         x2FC6sCuQ9+sVj/AU5EaPqcneuIHFnQREQK/aMTMnhAMlvN3cHdfJ8kvton6FPr1ui7l
         TyizdoluHflvQQylTJfOXWxZfJrf+Q445FSF/JpxF90ldhCvP4quYkT1gFYAnZIwXKwy
         TrGMEBsTo5N+WAfY46pjgOj3zGDxRdC25j6ZfW1QRM2FQ67tj18/9FH5vik6eMeh2Euq
         8AWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrVy6mGFfTezARgPXoahkDtUgtA05SdD0ISAtqjQGmo=;
        b=kpIKbaXmYSsVnb/CslAL240LNMmtE/KVWmi0fPOjkpJfEoVlW4PMCW+2P96wSw46MA
         4YO+BW14fc4kEpDMkH04Hp+YK4QXpZ9Z1tpSVKN7mDuRyXE9rQ9bcdOvvKCmTTkx/6AK
         STk8Ulqw9uHaee8QmysfdQLb/ZGY9DOXSnqTp/NIW9NHLuUzfhy6Ny5mwMqAc5kJa5Jc
         FNiZfLkuCvzsHvtf9tOylo9CKG5rKEHA21eU6IN9HHznRYsJJZk/mNLD057nztE3gOLC
         51oUCUwFbsoU8fHln2qd3tMAV+fFZNz6kNL6i6o4Z+dOPpJzci+09ZZvzvo4eQZ55JNK
         LE4A==
X-Gm-Message-State: AOAM533Amr4em4MI4GhKpYS9p81cLEF5abSFdvCS2SBjymGsslTECo45
        3lrDpXxUZJZe5G/1fokpqa0NiYxhn/D/tag/BsUNNA==
X-Google-Smtp-Source: ABdhPJyHXpZ33Cgj5l28R7EnxJQfhSJzEztJTVsFHQXl/nJtwWID/KYZkpjVOJJC80I9hdIvxXiGJ1M1XbFYufMG0uk=
X-Received: by 2002:a5d:68ce:0:b0:204:1a8c:749a with SMTP id
 p14-20020a5d68ce000000b002041a8c749amr821161wrw.392.1648664788452; Wed, 30
 Mar 2022 11:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220324234123.1608337-1-haoluo@google.com> <9cdf860d-8370-95b5-1688-af03265cc874@fb.com>
 <CA+khW7g3hy61qnvtqUizaW+qB6wk=Y9cjivhORshOk=ZzTXJ-A@mail.gmail.com>
 <CA+khW7iq+UKsfQxdT3QpSqPUFN8gQWWDLoQ9zxB=uWTs63AZEA@mail.gmail.com>
 <20220329093753.26wc3noelqrwlrcj@apollo.legion> <CA+khW7jW47SALTfxMKfQoA0Qwqd22GC0z4S5juFTbxLfTSbFEQ@mail.gmail.com>
 <20220329232956.gbsr65jdbe4lw2m6@ast-mbp> <CA+khW7jyvp4PKGu5GS8GDf=Lr4EdRUz8kraaTfiZ2oGm704Cpw@mail.gmail.com>
 <CAADnVQLTBhCTAx1a_nev7CgMZxv1Bb7ecz1AFRin8tHmjPREJA@mail.gmail.com>
In-Reply-To: <CAADnVQLTBhCTAx1a_nev7CgMZxv1Bb7ecz1AFRin8tHmjPREJA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 30 Mar 2022 11:26:17 -0700
Message-ID: <CA+khW7iqiKTLi75oSPe+ibV8afR_SPgtg7Q+nEswmMOFZaAebA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/2] Mmapable task local storage.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
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

On Wed, Mar 30, 2022 at 11:16 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 30, 2022 at 11:06 AM Hao Luo <haoluo@google.com> wrote:
> >
> > On Tue, Mar 29, 2022 at 4:30 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Mar 29, 2022 at 10:43:42AM -0700, Hao Luo wrote:
> > > > On Tue, Mar 29, 2022 at 2:37 AM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > > >
> > > > > On Mon, Mar 28, 2022 at 11:16:15PM IST, Hao Luo wrote:
> > > > > > On Mon, Mar 28, 2022 at 10:39 AM Hao Luo <haoluo@google.com> wrote:
> > > > > > >
> > > > > > > Hi Yonghong,
> > > > > > >
> > > > > > > On Fri, Mar 25, 2022 at 12:16 PM Yonghong Song <yhs@fb.com> wrote:
> > > > > > > >
> > > > > > > > On 3/24/22 4:41 PM, Hao Luo wrote:
> > > > > > > > > Some map types support mmap operation, which allows userspace to
> > > > > > > > > communicate with BPF programs directly. Currently only arraymap
> > > > > > > > > and ringbuf have mmap implemented.
> > > > > > > > >
> > > > > > > > > However, in some use cases, when multiple program instances can
> > > > > > > > > run concurrently, global mmapable memory can cause race. In that
> > > > > > > > > case, userspace needs to provide necessary synchronizations to
> > > > > > > > > coordinate the usage of mapped global data. This can be a source
> > > > > > > > > of bottleneck.
> > > > > > > >
> > > > > > > > I can see your use case here. Each calling process can get the
> > > > > > > > corresponding bpf program task local storage data through
> > > > > > > > mmap interface. As you mentioned, there is a tradeoff
> > > > > > > > between more memory vs. non-global synchronization.
> > > > > > > >
> > > > > > > > I am thinking that another bpf_iter approach can retrieve
> > > > > > > > the similar result. We could implement a bpf_iter
> > > > > > > > for task local storage map, optionally it can provide
> > > > > > > > a tid to retrieve the data for that particular tid.
> > > > > > > > This way, user space needs an explicit syscall, but
> > > > > > > > does not need to allocate more memory than necessary.
> > > > > > > >
> > > > > > > > WDYT?
> > > > > > > >
> > > > > > >
> > > > > > > Thanks for the suggestion. I have two thoughts about bpf_iter + tid and mmap:
> > > > > > >
> > > > > > > - mmap prevents the calling task from reading other task's value.
> > > > > > > Using bpf_iter, one can pass other task's tid to get their values. I
> > > > > > > assume there are two potential ways of passing tid to bpf_iter: one is
> > > > > > > to use global data in bpf prog, the other is adding tid parameterized
> > > > > > > iter_link. For the first, it's not easy for unpriv tasks to use. For
> > > > > > > the second, we need to create one iter_link object for each interested
> > > > > > > tid. It may not be easy to use either.
> > > > > > >
> > > > > > > - Regarding adding an explicit syscall. I thought about adding
> > > > > > > write/read syscalls for task local storage maps, just like reading
> > > > > > > values from iter_link. Writing or reading task local storage map
> > > > > > > updates/reads the current task's value. I think this could achieve the
> > > > > > > same effect as mmap.
> > > > > > >
> > > > > >
> > > > > > Actually, my use case of using mmap on task local storage is to allow
> > > > > > userspace to pass FDs into bpf prog. Some of the helpers I want to add
> > > > > > need to take an FD as parameter and the bpf progs can run
> > > > > > concurrently, thus using global data is racy. Mmapable task local
> > > > > > storage is the best solution I can find for this purpose.
> > > > > >
> > > > > > Song also mentioned to me offline, that mmapable task local storage
> > > > > > may be useful for his use case.
> > > > > >
> > > > > > I am actually open to other proposals.
> > > > > >
> > > > >
> > > > > You could also use a syscall prog, and use bpf_prog_test_run to update local
> > > > > storage for current. Data can be passed for that specific prog invocation using
> > > > > ctx. You might have to enable bpf_task_storage helpers in it though, since they
> > > > > are not allowed to be called right now.
> > > > >
> > > >
> > > > The loading process needs CAP_BPF to load bpf_prog_test_run. I'm
> > > > thinking of allowing any thread including unpriv ones to be able to
> > > > pass data to the prog and update their own storage.
> > >
> > > If I understand the use case correctly all of this mmap-ing is only to
> > > allow unpriv userspace to access a priv map via unpriv mmap() syscall.
> > > But the map can be accessed as unpriv already.
> > > Pin it with the world read creds and do map_lookup sys_bpf cmd on it.
> >
> > Right, but, if I understand correctly, with
> > sysctl_unprivileged_bpf_disabled, unpriv tasks are not able to make
> > use of __sys_bpf(). Is there anything I missed?
>
> That sysctl is a heavy hammer. Let's fix it instead.
> map lookup/update/delete can be allowed for unpriv for certain map types.
> There are permissions checks in corresponding lookup/update calls already.

This sounds great. If we can allow basic map operations for some map
types, it will change many use cases I'm looking at. Let me take a
look and report back.
