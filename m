Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E821B4ECB99
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 20:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349817AbiC3SSK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Mar 2022 14:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350072AbiC3SSG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Mar 2022 14:18:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C26326F2;
        Wed, 30 Mar 2022 11:16:20 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id t2so19520962pfj.10;
        Wed, 30 Mar 2022 11:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fuPK1GcMmt5419kQiNnUNFzucW8kX6MZofO7oFt75mg=;
        b=gygBe8ITx/LBeEmghv58n7ugBhXHRJWXPOT0m0D7rgzezeung+Wwk1B2kD9VYRksOv
         5ZEta8ZWCremZsx26iheMwP+Dj/0esyS3W9G2M+84gewLGOkgitpexvwR38q5eJFiNNz
         LLa8td7npvNmAisiRJ7ekKaANn2eQtNkvNrHW0BAQTT3mnqsOGOvBK/tIjvWQ9cCnqG3
         N+WRsck6jr22zD7xyA9AYVtGozhTlPsHPfSYoEzq81T3kKlXyWwj+1BcSIaqZIvgIrMb
         kwKsokzLARuHfqUtymkLRWpfgO2/UJeMJuuw4fzqU7H40KVMTPLFhhtGwho+JB2ApxcC
         n/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fuPK1GcMmt5419kQiNnUNFzucW8kX6MZofO7oFt75mg=;
        b=AKMpRf7XjQufHSPpe+KhAp1Hx3h68oqGPYe7+nhA9dXfF0Gx0thJu4sdwckQCDmZV4
         xWT/HIBlxA7S5Jex7OSN3Ni9Bdo6ZGOId2O4WGved5mtObl3/d5f0gKG2Xw1x0hFI+xN
         WtGVwnIGSJSJRC9ya3wqkd6RABQ7lzaJcpeN3MPmY1QtnyinF0bkAcVKn/fU8Qfd0LV5
         AignRtQCZIbZ5xOviTZARvdU4idK7W8p2swouui8ZNTGQU7rNHxZTIj+Y1Z+tw7AAgX/
         1VfZKigve7OY7lfc4ntC4lBnCdVvyceHaQpg6Ap2TAAoptt3TSLUMe54topw4rl3BVze
         Qd2w==
X-Gm-Message-State: AOAM531nT4ncdbLTneETuk3pPauK7O0/c7n2sZLQlTp5l5ufQ01elqI3
        JRaTBDYXtJf16r3osLgPQFjOcHbIzzLMMd8Ti14=
X-Google-Smtp-Source: ABdhPJxV86MO98SqrxuJA1T2lSIpEx5wn+VSszlBEioWWGFcq0F3/ghCLYENNf3ZzV+xh2b/6C7Lv74kau851+Lu8Fs=
X-Received: by 2002:a05:6a00:1c9e:b0:4fa:d946:378b with SMTP id
 y30-20020a056a001c9e00b004fad946378bmr712880pfw.46.1648664179908; Wed, 30 Mar
 2022 11:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220324234123.1608337-1-haoluo@google.com> <9cdf860d-8370-95b5-1688-af03265cc874@fb.com>
 <CA+khW7g3hy61qnvtqUizaW+qB6wk=Y9cjivhORshOk=ZzTXJ-A@mail.gmail.com>
 <CA+khW7iq+UKsfQxdT3QpSqPUFN8gQWWDLoQ9zxB=uWTs63AZEA@mail.gmail.com>
 <20220329093753.26wc3noelqrwlrcj@apollo.legion> <CA+khW7jW47SALTfxMKfQoA0Qwqd22GC0z4S5juFTbxLfTSbFEQ@mail.gmail.com>
 <20220329232956.gbsr65jdbe4lw2m6@ast-mbp> <CA+khW7jyvp4PKGu5GS8GDf=Lr4EdRUz8kraaTfiZ2oGm704Cpw@mail.gmail.com>
In-Reply-To: <CA+khW7jyvp4PKGu5GS8GDf=Lr4EdRUz8kraaTfiZ2oGm704Cpw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 30 Mar 2022 11:16:08 -0700
Message-ID: <CAADnVQLTBhCTAx1a_nev7CgMZxv1Bb7ecz1AFRin8tHmjPREJA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/2] Mmapable task local storage.
To:     Hao Luo <haoluo@google.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 30, 2022 at 11:06 AM Hao Luo <haoluo@google.com> wrote:
>
> On Tue, Mar 29, 2022 at 4:30 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Mar 29, 2022 at 10:43:42AM -0700, Hao Luo wrote:
> > > On Tue, Mar 29, 2022 at 2:37 AM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Mon, Mar 28, 2022 at 11:16:15PM IST, Hao Luo wrote:
> > > > > On Mon, Mar 28, 2022 at 10:39 AM Hao Luo <haoluo@google.com> wrote:
> > > > > >
> > > > > > Hi Yonghong,
> > > > > >
> > > > > > On Fri, Mar 25, 2022 at 12:16 PM Yonghong Song <yhs@fb.com> wrote:
> > > > > > >
> > > > > > > On 3/24/22 4:41 PM, Hao Luo wrote:
> > > > > > > > Some map types support mmap operation, which allows userspace to
> > > > > > > > communicate with BPF programs directly. Currently only arraymap
> > > > > > > > and ringbuf have mmap implemented.
> > > > > > > >
> > > > > > > > However, in some use cases, when multiple program instances can
> > > > > > > > run concurrently, global mmapable memory can cause race. In that
> > > > > > > > case, userspace needs to provide necessary synchronizations to
> > > > > > > > coordinate the usage of mapped global data. This can be a source
> > > > > > > > of bottleneck.
> > > > > > >
> > > > > > > I can see your use case here. Each calling process can get the
> > > > > > > corresponding bpf program task local storage data through
> > > > > > > mmap interface. As you mentioned, there is a tradeoff
> > > > > > > between more memory vs. non-global synchronization.
> > > > > > >
> > > > > > > I am thinking that another bpf_iter approach can retrieve
> > > > > > > the similar result. We could implement a bpf_iter
> > > > > > > for task local storage map, optionally it can provide
> > > > > > > a tid to retrieve the data for that particular tid.
> > > > > > > This way, user space needs an explicit syscall, but
> > > > > > > does not need to allocate more memory than necessary.
> > > > > > >
> > > > > > > WDYT?
> > > > > > >
> > > > > >
> > > > > > Thanks for the suggestion. I have two thoughts about bpf_iter + tid and mmap:
> > > > > >
> > > > > > - mmap prevents the calling task from reading other task's value.
> > > > > > Using bpf_iter, one can pass other task's tid to get their values. I
> > > > > > assume there are two potential ways of passing tid to bpf_iter: one is
> > > > > > to use global data in bpf prog, the other is adding tid parameterized
> > > > > > iter_link. For the first, it's not easy for unpriv tasks to use. For
> > > > > > the second, we need to create one iter_link object for each interested
> > > > > > tid. It may not be easy to use either.
> > > > > >
> > > > > > - Regarding adding an explicit syscall. I thought about adding
> > > > > > write/read syscalls for task local storage maps, just like reading
> > > > > > values from iter_link. Writing or reading task local storage map
> > > > > > updates/reads the current task's value. I think this could achieve the
> > > > > > same effect as mmap.
> > > > > >
> > > > >
> > > > > Actually, my use case of using mmap on task local storage is to allow
> > > > > userspace to pass FDs into bpf prog. Some of the helpers I want to add
> > > > > need to take an FD as parameter and the bpf progs can run
> > > > > concurrently, thus using global data is racy. Mmapable task local
> > > > > storage is the best solution I can find for this purpose.
> > > > >
> > > > > Song also mentioned to me offline, that mmapable task local storage
> > > > > may be useful for his use case.
> > > > >
> > > > > I am actually open to other proposals.
> > > > >
> > > >
> > > > You could also use a syscall prog, and use bpf_prog_test_run to update local
> > > > storage for current. Data can be passed for that specific prog invocation using
> > > > ctx. You might have to enable bpf_task_storage helpers in it though, since they
> > > > are not allowed to be called right now.
> > > >
> > >
> > > The loading process needs CAP_BPF to load bpf_prog_test_run. I'm
> > > thinking of allowing any thread including unpriv ones to be able to
> > > pass data to the prog and update their own storage.
> >
> > If I understand the use case correctly all of this mmap-ing is only to
> > allow unpriv userspace to access a priv map via unpriv mmap() syscall.
> > But the map can be accessed as unpriv already.
> > Pin it with the world read creds and do map_lookup sys_bpf cmd on it.
>
> Right, but, if I understand correctly, with
> sysctl_unprivileged_bpf_disabled, unpriv tasks are not able to make
> use of __sys_bpf(). Is there anything I missed?

That sysctl is a heavy hammer. Let's fix it instead.
map lookup/update/delete can be allowed for unpriv for certain map types.
There are permissions checks in corresponding lookup/update calls already.
