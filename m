Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE74B4ECB4B
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 20:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349673AbiC3SID (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Mar 2022 14:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349742AbiC3SHy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Mar 2022 14:07:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FF630F4D
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 11:06:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c7so3853271wrd.0
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 11:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zvp1zdAPhHyHCHfcvFIUi1mzPpcUV4cVly2pIh80IFk=;
        b=EU9ubGbPLd8WO6OOrR8SBcLk1JhfCEuFFRo3ShaevmriYxWeLbSQKTnITshiE7yQe6
         hEN+aBIV8KiJzQXAzKcTnVa9GMzNCnJJMeP81I+tGImIgQtCDFF4XqA3tfyxwA4aVcjy
         BPKydHqhm17yG2mSBUQem8xuyLVI3coOfvcaOkT/4j5BIYpowsAQNdKZUoNAb4YtKPiD
         7VZYYI8Yts6mgdYPImbTu9uSSdWoddyL63dLWmUoVzxSMx1dajlN+60SIsebxMU7b+R+
         g4skI34qHltJrO78k92lY7HidkLwH1GewmzxzfmMFBYJGVnh6cPBBxTlaTnhtz3xYB47
         aB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zvp1zdAPhHyHCHfcvFIUi1mzPpcUV4cVly2pIh80IFk=;
        b=28ZsXFtvRnaLIIOAkzGraRM8/sFV/52PZymkb9axZWHtuHyl8KdaPTKW0W6qhl/210
         eqz6b3cukFJebWPVCEDTWXdOFkDhfEYNx7UjN3Od2hlaaF105FR1DB2SD3kc9epdmc5d
         uBfsOA29L47qx//1U4bSlwgMCs5NmETlrpoFL/WGRL4fkCFt9lHiNb4bRdhwzVyEzpDh
         dzciXhZWdF+BHHFGvTdnoDiCDi35plP/FmZRemuf6H7dwVlVMriogEeG/a+hbGlz1H0v
         zlobdVMjR3cCeH1hMZ0+ogtpchuG0n+N0r4uFtN5Dg7K6up/POumuUpSdFIL8WrkEFHF
         Xwxg==
X-Gm-Message-State: AOAM532Io05VWgQauI/hbJw1bMhYa4HaKuF3Datd/+G/ejj4dHFmi81A
        BGAxRX/LzGgsMZD+LN13qPiVOHcGKiU6Xdfcb5tmFA==
X-Google-Smtp-Source: ABdhPJxVwtXjWLQCOzosoYOyEA2tN1Luf12r7oaqUmmzH7xFdWTRbQAjrdb3KYPlRglfmLC03u4utFgEWCuaHbJDuXM=
X-Received: by 2002:adf:a411:0:b0:205:c4e1:6ee6 with SMTP id
 d17-20020adfa411000000b00205c4e16ee6mr721542wra.489.1648663566926; Wed, 30
 Mar 2022 11:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220324234123.1608337-1-haoluo@google.com> <9cdf860d-8370-95b5-1688-af03265cc874@fb.com>
 <CA+khW7g3hy61qnvtqUizaW+qB6wk=Y9cjivhORshOk=ZzTXJ-A@mail.gmail.com>
 <CA+khW7iq+UKsfQxdT3QpSqPUFN8gQWWDLoQ9zxB=uWTs63AZEA@mail.gmail.com>
 <20220329093753.26wc3noelqrwlrcj@apollo.legion> <CA+khW7jW47SALTfxMKfQoA0Qwqd22GC0z4S5juFTbxLfTSbFEQ@mail.gmail.com>
 <20220329214536.etivluwqqxxxphp2@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220329214536.etivluwqqxxxphp2@kafai-mbp.dhcp.thefacebook.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 30 Mar 2022 11:05:55 -0700
Message-ID: <CA+khW7hB2YsnQZ3-QE+EWbJU05vuFRWur=hWPRxNO1LaUVGOqA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/2] Mmapable task local storage.
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
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

On Tue, Mar 29, 2022 at 2:45 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Mar 29, 2022 at 10:43:42AM -0700, Hao Luo wrote:
> > On Tue, Mar 29, 2022 at 2:37 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Mon, Mar 28, 2022 at 11:16:15PM IST, Hao Luo wrote:
> > > > On Mon, Mar 28, 2022 at 10:39 AM Hao Luo <haoluo@google.com> wrote:
> > > > >
> > > > > Hi Yonghong,
> > > > >
> > > > > On Fri, Mar 25, 2022 at 12:16 PM Yonghong Song <yhs@fb.com> wrote:
> > > > > >
> > > > > > On 3/24/22 4:41 PM, Hao Luo wrote:
> > > > > > > Some map types support mmap operation, which allows userspace to
> > > > > > > communicate with BPF programs directly. Currently only arraymap
> > > > > > > and ringbuf have mmap implemented.
> > > > > > >
> > > > > > > However, in some use cases, when multiple program instances can
> > > > > > > run concurrently, global mmapable memory can cause race. In that
> > > > > > > case, userspace needs to provide necessary synchronizations to
> > > > > > > coordinate the usage of mapped global data. This can be a source
> > > > > > > of bottleneck.
> > > > > >
> > > > > > I can see your use case here. Each calling process can get the
> > > > > > corresponding bpf program task local storage data through
> > > > > > mmap interface. As you mentioned, there is a tradeoff
> > > > > > between more memory vs. non-global synchronization.
> > > > > >
> > > > > > I am thinking that another bpf_iter approach can retrieve
> > > > > > the similar result. We could implement a bpf_iter
> > > > > > for task local storage map, optionally it can provide
> > > > > > a tid to retrieve the data for that particular tid.
> > > > > > This way, user space needs an explicit syscall, but
> > > > > > does not need to allocate more memory than necessary.
> > > > > >
> > > > > > WDYT?
> > > > > >
> > > > >
> > > > > Thanks for the suggestion. I have two thoughts about bpf_iter + tid and mmap:
> > > > >
> > > > > - mmap prevents the calling task from reading other task's value.
> > > > > Using bpf_iter, one can pass other task's tid to get their values. I
> > > > > assume there are two potential ways of passing tid to bpf_iter: one is
> > > > > to use global data in bpf prog, the other is adding tid parameterized
> > > > > iter_link. For the first, it's not easy for unpriv tasks to use. For
> > > > > the second, we need to create one iter_link object for each interested
> > > > > tid. It may not be easy to use either.
> > > > >
> > > > > - Regarding adding an explicit syscall. I thought about adding
> > > > > write/read syscalls for task local storage maps, just like reading
> > > > > values from iter_link. Writing or reading task local storage map
> > > > > updates/reads the current task's value. I think this could achieve the
> > > > > same effect as mmap.
> > > > >
> > > >
> > > > Actually, my use case of using mmap on task local storage is to allow
> > > > userspace to pass FDs into bpf prog. Some of the helpers I want to add
> > > > need to take an FD as parameter and the bpf progs can run
> > > > concurrently, thus using global data is racy. Mmapable task local
> > > > storage is the best solution I can find for this purpose.
> Some more details is needed about the use case.  As long as there is
> storage local to an individual task, racing within this one task's
> specific storage is a non issue?
>

Race is still possible. In the use case I was thinking, the workflow is:

1. Current task mmaps a local storage map, writes a value to its local storage.
2. Current task then makes a syscall, which triggers a bpf prog.
3. The bpf prog reads the current task's local storage and fetches the
value stored by the task.

The steps above are sequential, therefore no race between task and bpf
prog. If a task accesses other task's local storage, there is still
race.

> The patch 2 example is doable with the current api and is pretty far from
> the above use case description.  The existing bpf_map_update_elem() and
> bpf_map_lookup_elem() can not solve your use case?
>

With sysctl_unprivileged_bpf_disabled, tasks without CAP_BPF are not
able to make use of __sys_bpf(). bpf_map_update_elem() and
bpf_map_lookup_elem() call __sys_bpf underneath IIRC. So unpriv tasks
can't use these two syscalls.

> or the current bpf_map_{update,lookup}_elem() works but
> prefer a direct data read/write interface?
>
> btw, how delete is going to look like ?
>

Good question. Deletion is not done from the userspace. It's done at
bpf prog side. The task mmaps its storage (which creates the storage),
writes a value. The bpf prog reads the value and deletes the storage.

> and do you see the mmap could be used with sk and inode storage instead
> of the 'current' task?
>

Yes. I think this patch can certainly extend to sk or inode or cgroup
local storage. But I don't have a use case yet.

> > > >
> > > > Song also mentioned to me offline, that mmapable task local storage
> > > > may be useful for his use case.
> > > >
> > > > I am actually open to other proposals.
> If the arraymap is local to an individual task, does it solve
> your use case?  Have you thought about storing an arraymap (which is mmap-able)
> in the local storage?  That could then be used to store ringbuf map and
> other bpf maps in local storage.  It is logically similar to map-in-map.
> The outer map is the pseudo local storage map here.
>

I haven't thought about this. IMHO, I feel it might be complicated to
properly set up the set of maps.


> > > >
> > >
> > > You could also use a syscall prog, and use bpf_prog_test_run to update local
> > > storage for current. Data can be passed for that specific prog invocation using
> > > ctx. You might have to enable bpf_task_storage helpers in it though, since they
> > > are not allowed to be called right now.
> > >
> >
> > The loading process needs CAP_BPF to load bpf_prog_test_run. I'm
> > thinking of allowing any thread including unpriv ones to be able to
> > pass data to the prog and update their own storage.
