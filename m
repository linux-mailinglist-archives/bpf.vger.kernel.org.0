Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8AF4EE46F
	for <lists+bpf@lfdr.de>; Fri,  1 Apr 2022 01:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242734AbiCaXIk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 19:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242742AbiCaXIh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 19:08:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF6D24059B;
        Thu, 31 Mar 2022 16:06:45 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p4-20020a17090ad30400b001c7ca87c05bso3708594pju.1;
        Thu, 31 Mar 2022 16:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKAht4Ion1OwdeqcTBFrhBWqALLlFWaAgtCdJ5b2OjM=;
        b=OTfvqdRGYGDDRHHSL9p5mQ3TGnr83D4JSyL4V/16PTVahbtrE6Rx3ye+EnQQmCiG9i
         YKX7am+hrJKLcOx4b4aKrUdT/4U/1teMbUkkevVnUlUsteXDzGxYJESr8Lb2nHGzT5kA
         g4laf36lJMCCmbcVQmFz0BHISFFb14paBQXejkgWengXMv7GSAK5jkIX5J1SODI+mSQr
         Lfoy4N9h2WlzzBBHCINHIbDa7vaxEOJkDh+DagHucoYCuCL9bjaxaJePcPxAGexz1LFp
         vRoVnCBsHG5VS40h3k0yEyZsg+QVU3SerZSh/ljAPDrZk10nKhpBbVr2rvppvAluRRal
         0ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKAht4Ion1OwdeqcTBFrhBWqALLlFWaAgtCdJ5b2OjM=;
        b=fqORu4OtRHMHXVu1TRv/cIA/dzR0LRHS8M3O2b4QHWSwiRMLBp0OI1fFrodlpuV+8T
         h80z9uoBakbdUdVFqqrNS1o/xksXd6O0xA1Oh72XBnLCdNwToJyAdlGyuFd2cIXVJhsN
         zl2HMfMEpRVoD0me3qWbjf8dUP4qg6xUYpF9rFPNBaDxaGn8/BsFd5QC37w0e9Nn6OHJ
         S7DKrcQK1tjgASEngQSeYZjYdpWQvAz2tcAoBxmVWHDSWyhkhkNzGXGrwYk5Kx8ZMbxl
         gtbjPygkkH37yR5UAHkoxavjgiVWhOJxsLgf/oMokrR0zrvvu+gDWYZ2caUVmC7cAtKp
         X6zQ==
X-Gm-Message-State: AOAM532G65pBjLRKy5DLuRBp1Vt748PMCdL6guIqDvXqUqgHGvghVej3
        WIpHTuozRpdemJSjsbD++fNJ11l3eki74oORUjc=
X-Google-Smtp-Source: ABdhPJwKXQcAeSWoX0tt14yODiYUowjG2VohAaY9IghVE+sFbIEwAOPtkr/z8rylASimvoDiaGTPkvhc6QhuOUsAmAM=
X-Received: by 2002:a17:90b:4f43:b0:1c7:552b:7553 with SMTP id
 pj3-20020a17090b4f4300b001c7552b7553mr8458767pjb.117.1648768005058; Thu, 31
 Mar 2022 16:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220324234123.1608337-1-haoluo@google.com> <9cdf860d-8370-95b5-1688-af03265cc874@fb.com>
 <CA+khW7g3hy61qnvtqUizaW+qB6wk=Y9cjivhORshOk=ZzTXJ-A@mail.gmail.com>
 <CA+khW7iq+UKsfQxdT3QpSqPUFN8gQWWDLoQ9zxB=uWTs63AZEA@mail.gmail.com>
 <20220329093753.26wc3noelqrwlrcj@apollo.legion> <CA+khW7jW47SALTfxMKfQoA0Qwqd22GC0z4S5juFTbxLfTSbFEQ@mail.gmail.com>
 <20220329232956.gbsr65jdbe4lw2m6@ast-mbp> <CA+khW7jyvp4PKGu5GS8GDf=Lr4EdRUz8kraaTfiZ2oGm704Cpw@mail.gmail.com>
 <CAADnVQLTBhCTAx1a_nev7CgMZxv1Bb7ecz1AFRin8tHmjPREJA@mail.gmail.com>
 <CA+khW7iqiKTLi75oSPe+ibV8afR_SPgtg7Q+nEswmMOFZaAebA@mail.gmail.com> <CACYkzJ6-csGkdMQiGYYr5_DgShPWrUFfs92sUOhwzQt=T13+SA@mail.gmail.com>
In-Reply-To: <CACYkzJ6-csGkdMQiGYYr5_DgShPWrUFfs92sUOhwzQt=T13+SA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 31 Mar 2022 16:06:34 -0700
Message-ID: <CAADnVQJtBFuJxCfawdaK=ce2PfeS23SeYb0i_9dnEm1j5BpUiw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/2] Mmapable task local storage.
To:     KP Singh <kpsingh@kernel.org>
Cc:     Hao Luo <haoluo@google.com>, Jann Horn <jannh@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
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

On Thu, Mar 31, 2022 at 3:32 PM KP Singh <kpsingh@kernel.org> wrote:
>
> On Wed, Mar 30, 2022 at 8:26 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Wed, Mar 30, 2022 at 11:16 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Mar 30, 2022 at 11:06 AM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > On Tue, Mar 29, 2022 at 4:30 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Tue, Mar 29, 2022 at 10:43:42AM -0700, Hao Luo wrote:
> > > > > > On Tue, Mar 29, 2022 at 2:37 AM Kumar Kartikeya Dwivedi
> > > > > > <memxor@gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, Mar 28, 2022 at 11:16:15PM IST, Hao Luo wrote:
> > > > > > > > On Mon, Mar 28, 2022 at 10:39 AM Hao Luo <haoluo@google.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Yonghong,
> > > > > > > > >
> > > > > > > > > On Fri, Mar 25, 2022 at 12:16 PM Yonghong Song <yhs@fb.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On 3/24/22 4:41 PM, Hao Luo wrote:
> > > > > > > > > > > Some map types support mmap operation, which allows userspace to
> > > > > > > > > > > communicate with BPF programs directly. Currently only arraymap
> > > > > > > > > > > and ringbuf have mmap implemented.
> > > > > > > > > > >
> > > > > > > > > > > However, in some use cases, when multiple program instances can
> > > > > > > > > > > run concurrently, global mmapable memory can cause race. In that
> > > > > > > > > > > case, userspace needs to provide necessary synchronizations to
> > > > > > > > > > > coordinate the usage of mapped global data. This can be a source
> > > > > > > > > > > of bottleneck.
> > > > > > > > > >
> > > > > > > > > > I can see your use case here. Each calling process can get the
> > > > > > > > > > corresponding bpf program task local storage data through
> > > > > > > > > > mmap interface. As you mentioned, there is a tradeoff
> > > > > > > > > > between more memory vs. non-global synchronization.
> > > > > > > > > >
> > > > > > > > > > I am thinking that another bpf_iter approach can retrieve
> > > > > > > > > > the similar result. We could implement a bpf_iter
> > > > > > > > > > for task local storage map, optionally it can provide
> > > > > > > > > > a tid to retrieve the data for that particular tid.
> > > > > > > > > > This way, user space needs an explicit syscall, but
> > > > > > > > > > does not need to allocate more memory than necessary.
> > > > > > > > > >
> > > > > > > > > > WDYT?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks for the suggestion. I have two thoughts about bpf_iter + tid and mmap:
> > > > > > > > >
> > > > > > > > > - mmap prevents the calling task from reading other task's value.
> > > > > > > > > Using bpf_iter, one can pass other task's tid to get their values. I
> > > > > > > > > assume there are two potential ways of passing tid to bpf_iter: one is
> > > > > > > > > to use global data in bpf prog, the other is adding tid parameterized
> > > > > > > > > iter_link. For the first, it's not easy for unpriv tasks to use. For
> > > > > > > > > the second, we need to create one iter_link object for each interested
> > > > > > > > > tid. It may not be easy to use either.
> > > > > > > > >
> > > > > > > > > - Regarding adding an explicit syscall. I thought about adding
> > > > > > > > > write/read syscalls for task local storage maps, just like reading
> > > > > > > > > values from iter_link. Writing or reading task local storage map
> > > > > > > > > updates/reads the current task's value. I think this could achieve the
> > > > > > > > > same effect as mmap.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Actually, my use case of using mmap on task local storage is to allow
> > > > > > > > userspace to pass FDs into bpf prog. Some of the helpers I want to add
> > > > > > > > need to take an FD as parameter and the bpf progs can run
> > > > > > > > concurrently, thus using global data is racy. Mmapable task local
> > > > > > > > storage is the best solution I can find for this purpose.
> > > > > > > >
> > > > > > > > Song also mentioned to me offline, that mmapable task local storage
> > > > > > > > may be useful for his use case.
> > > > > > > >
> > > > > > > > I am actually open to other proposals.
> > > > > > > >
> > > > > > >
> > > > > > > You could also use a syscall prog, and use bpf_prog_test_run to update local
> > > > > > > storage for current. Data can be passed for that specific prog invocation using
> > > > > > > ctx. You might have to enable bpf_task_storage helpers in it though, since they
> > > > > > > are not allowed to be called right now.
> > > > > > >
> > > > > >
> > > > > > The loading process needs CAP_BPF to load bpf_prog_test_run. I'm
> > > > > > thinking of allowing any thread including unpriv ones to be able to
> > > > > > pass data to the prog and update their own storage.
> > > > >
> > > > > If I understand the use case correctly all of this mmap-ing is only to
> > > > > allow unpriv userspace to access a priv map via unpriv mmap() syscall.
> > > > > But the map can be accessed as unpriv already.
> > > > > Pin it with the world read creds and do map_lookup sys_bpf cmd on it.
> > > >
> > > > Right, but, if I understand correctly, with
> > > > sysctl_unprivileged_bpf_disabled, unpriv tasks are not able to make
> > > > use of __sys_bpf(). Is there anything I missed?
> > >
> > > That sysctl is a heavy hammer. Let's fix it instead.
> > > map lookup/update/delete can be allowed for unpriv for certain map types.
> > > There are permissions checks in corresponding lookup/update calls already.
> >
>
> (Adding Jann)
>
> I wonder if we can tag a map as BPF_F_UNPRIVILEGED and allow the writes to
> only maps that are explicitly marked as writable by unprivileged processes.

I think it's overkill for existing unpriv maps like hash and array.
These maps by themself don't pose a security threat.
The sysctl was/is in the wrong place.

> We will have task local storage in LSM programs that we
> won't like unprivileged processes to write to as well.
>
> struct {
>         __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
>         __uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_UNPRIVILEGED);
>         __type(key, int);
>         __type(value, struct fd_storage);
> } task_fd_storage_map SEC(".maps");

local storage map was not exposed to unpriv before.
This would be a different consideration.
But even in such a case the extra flag looks unnecessary.
