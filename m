Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09724EB6C3
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 01:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiC2Xbo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Mar 2022 19:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiC2Xbo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Mar 2022 19:31:44 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94701EC48;
        Tue, 29 Mar 2022 16:30:00 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t13so14845232pgn.8;
        Tue, 29 Mar 2022 16:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KvFCFp39fcZMgF3qrB2Wxye/PpzuYjmzOhgExsjshNg=;
        b=SsW+w1ynBPr+p6WJt1nv1wq0HHEkQA/T36bSMU6ljqQaVj1UT5s3a8d6Of+A4VsFRg
         GZVxQ43NSdtuYkMzTkLVoQJ+lHmv/nk6BpSScWzGqnRtZ7PDbst0E40HCam1KiCnRTDD
         8zw4B9ezNv49fYGbKLJRP78K6TYMIyHoqC7KaXeySubwQNibcPzInmb1Rv8Z1KbqGUUu
         TwZyW9EveDrMwWglC5F2WFmVsXczcrr0z+tvs+M9UWkfCE3RJkHZ0l62TqvVyxV2p1bp
         LwxajxAumXM4aplBmebCiqhGFynrRHdF55NDgNDjPz8ek9gZS3b2osmXXt6W1SqdDgUO
         GCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KvFCFp39fcZMgF3qrB2Wxye/PpzuYjmzOhgExsjshNg=;
        b=nydX/dfN6pGJ1KzMAqAgIdfKrRCu3gvzob8zoGwvQUmOKoFBHAWTDpJkFXiBAQcZ/S
         Ieet3ml5Z0Dzbjc5cc3Zj1pqRENNxMXAuGolQ0asBP7ZzQJ96WZo6UyDfLFKAjeYXf+X
         2v6Yi/gre9UJJaQkCQUS0QVmRqD9pWj6jwGws3DwzsrFGNamPK3G99d2ZjxwMQpNn95m
         B0nOND2/Zxeav9J67ErbtW1LZnWYLJIiYRPVbyB2j30r0u33RqovMk5yY4x70jwuhbvW
         1oTdCrTqOhQnwjMA/fZVLR+/YfWHI+yIC3HfInDKhKUv91TZGt2o8gR2WGxV3xmP24ce
         EFDA==
X-Gm-Message-State: AOAM5317oPTNmAVQyucobrMesHMLMDBfCijjl1jqAVSR+pdKCKIb2GBy
        Y032XKO0jK3vE1H08Hx4dgM=
X-Google-Smtp-Source: ABdhPJzD4q0ecXgk/6K8S+DN1g9/+3l9kjxwV+2sM2Fn3Q2wSxOKAR6as2rKejhPoB8u4TlhmVMMiQ==
X-Received: by 2002:a05:6a00:1824:b0:4f6:dc69:227e with SMTP id y36-20020a056a00182400b004f6dc69227emr30302603pfa.58.1648596600114;
        Tue, 29 Mar 2022 16:30:00 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:f900])
        by smtp.gmail.com with ESMTPSA id b10-20020a056a00114a00b004f784ba5e6asm22022029pfm.17.2022.03.29.16.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:29:59 -0700 (PDT)
Date:   Tue, 29 Mar 2022 16:29:56 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hao Luo <haoluo@google.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 0/2] Mmapable task local storage.
Message-ID: <20220329232956.gbsr65jdbe4lw2m6@ast-mbp>
References: <20220324234123.1608337-1-haoluo@google.com>
 <9cdf860d-8370-95b5-1688-af03265cc874@fb.com>
 <CA+khW7g3hy61qnvtqUizaW+qB6wk=Y9cjivhORshOk=ZzTXJ-A@mail.gmail.com>
 <CA+khW7iq+UKsfQxdT3QpSqPUFN8gQWWDLoQ9zxB=uWTs63AZEA@mail.gmail.com>
 <20220329093753.26wc3noelqrwlrcj@apollo.legion>
 <CA+khW7jW47SALTfxMKfQoA0Qwqd22GC0z4S5juFTbxLfTSbFEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7jW47SALTfxMKfQoA0Qwqd22GC0z4S5juFTbxLfTSbFEQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 29, 2022 at 10:43:42AM -0700, Hao Luo wrote:
> On Tue, Mar 29, 2022 at 2:37 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Mon, Mar 28, 2022 at 11:16:15PM IST, Hao Luo wrote:
> > > On Mon, Mar 28, 2022 at 10:39 AM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > Hi Yonghong,
> > > >
> > > > On Fri, Mar 25, 2022 at 12:16 PM Yonghong Song <yhs@fb.com> wrote:
> > > > >
> > > > > On 3/24/22 4:41 PM, Hao Luo wrote:
> > > > > > Some map types support mmap operation, which allows userspace to
> > > > > > communicate with BPF programs directly. Currently only arraymap
> > > > > > and ringbuf have mmap implemented.
> > > > > >
> > > > > > However, in some use cases, when multiple program instances can
> > > > > > run concurrently, global mmapable memory can cause race. In that
> > > > > > case, userspace needs to provide necessary synchronizations to
> > > > > > coordinate the usage of mapped global data. This can be a source
> > > > > > of bottleneck.
> > > > >
> > > > > I can see your use case here. Each calling process can get the
> > > > > corresponding bpf program task local storage data through
> > > > > mmap interface. As you mentioned, there is a tradeoff
> > > > > between more memory vs. non-global synchronization.
> > > > >
> > > > > I am thinking that another bpf_iter approach can retrieve
> > > > > the similar result. We could implement a bpf_iter
> > > > > for task local storage map, optionally it can provide
> > > > > a tid to retrieve the data for that particular tid.
> > > > > This way, user space needs an explicit syscall, but
> > > > > does not need to allocate more memory than necessary.
> > > > >
> > > > > WDYT?
> > > > >
> > > >
> > > > Thanks for the suggestion. I have two thoughts about bpf_iter + tid and mmap:
> > > >
> > > > - mmap prevents the calling task from reading other task's value.
> > > > Using bpf_iter, one can pass other task's tid to get their values. I
> > > > assume there are two potential ways of passing tid to bpf_iter: one is
> > > > to use global data in bpf prog, the other is adding tid parameterized
> > > > iter_link. For the first, it's not easy for unpriv tasks to use. For
> > > > the second, we need to create one iter_link object for each interested
> > > > tid. It may not be easy to use either.
> > > >
> > > > - Regarding adding an explicit syscall. I thought about adding
> > > > write/read syscalls for task local storage maps, just like reading
> > > > values from iter_link. Writing or reading task local storage map
> > > > updates/reads the current task's value. I think this could achieve the
> > > > same effect as mmap.
> > > >
> > >
> > > Actually, my use case of using mmap on task local storage is to allow
> > > userspace to pass FDs into bpf prog. Some of the helpers I want to add
> > > need to take an FD as parameter and the bpf progs can run
> > > concurrently, thus using global data is racy. Mmapable task local
> > > storage is the best solution I can find for this purpose.
> > >
> > > Song also mentioned to me offline, that mmapable task local storage
> > > may be useful for his use case.
> > >
> > > I am actually open to other proposals.
> > >
> >
> > You could also use a syscall prog, and use bpf_prog_test_run to update local
> > storage for current. Data can be passed for that specific prog invocation using
> > ctx. You might have to enable bpf_task_storage helpers in it though, since they
> > are not allowed to be called right now.
> >
> 
> The loading process needs CAP_BPF to load bpf_prog_test_run. I'm
> thinking of allowing any thread including unpriv ones to be able to
> pass data to the prog and update their own storage.

If I understand the use case correctly all of this mmap-ing is only to
allow unpriv userspace to access a priv map via unpriv mmap() syscall.
But the map can be accessed as unpriv already.
Pin it with the world read creds and do map_lookup sys_bpf cmd on it.
