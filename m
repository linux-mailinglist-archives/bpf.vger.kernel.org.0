Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D4D6F002D
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 06:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbjD0E17 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 27 Apr 2023 00:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbjD0E17 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 00:27:59 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3532D79
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 21:27:58 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-555d2810415so115445737b3.0
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 21:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682569677; x=1685161677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+e6/Fx8P0I3hL3FNrSQrDXI1FUZppPMChi8reymTgs=;
        b=KFqMba6Hhe8JCwGE3N2Mh1sPkI92Li+xHq6ea21/NFURHWjMYeSk5hW9avti1ZY4b7
         65U+bETDokZ+PFx6SdDz0MK59e5aVm0lAgC68/3ETZQUVWyEnyiEH0nRKsNzNZqkZgD7
         NwaF7nM29UqdEo8Ccg0ugVpzPBm/xoOIuaM53oJFt7tGeUeaJWUnLwyl7PIsRAr+Wur0
         Gb9rxkTqHwhCx1rcm4SJWCKvmhjnJPfIe2M31QX1qpQ/hPtm0bmhfvkF2JK33u75DLwo
         Xt7soHEO+XW2SNBzMJAay4S65HaYJMQvDDBEXOVP5y8Lk7rDX5NrxR6h5VCmMsJYcNkF
         ojhw==
X-Gm-Message-State: AC+VfDwmN4KSXscrhZyISPqJbay/K6kKWIC/a+DiAw0W1+rZTIFmNVWB
        q5Pfz2u6JTD2/lLpPTFWjenthMvmbCTC+JgNC2U=
X-Google-Smtp-Source: ACHHUZ6TAA8/CoTO/uaj4OsN+bG9stCdG/YoaZtIJ5XuZIn1t0PRgBu5G8+M+CLLNHYkT49HEyuVtfogBrvpxzWqtQE=
X-Received: by 2002:a81:a196:0:b0:552:e5dd:3d0a with SMTP id
 y144-20020a81a196000000b00552e5dd3d0amr350255ywg.17.1682569677128; Wed, 26
 Apr 2023 21:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230427001425.563232-1-namhyung@kernel.org> <CAEf4BzYs6iD+iE4RZnXTKHhBHCOr9r7AdhsBWWDpivy7sshPKw@mail.gmail.com>
 <CAM9d7ci3xAcnqdkpb-J4rv7yfiB2Trb-e2h7gfj6Wu5N_V7a-Q@mail.gmail.com> <c2a5cb6d-8779-4197-d491-d2249bb49635@gmail.com>
In-Reply-To: <c2a5cb6d-8779-4197-d491-d2249bb49635@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 26 Apr 2023 21:27:45 -0700
Message-ID: <CAM9d7cjsu4R=BGaKTUrCckGG-B8wbSbf0NLUBzSk8McX5DrRwg@mail.gmail.com>
Subject: Re: [HELP] failed to resolve CO-RE relocation
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Hengqi,

On Wed, Apr 26, 2023 at 9:20 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Hi, Namhyung
>
> On 2023/4/27 10:21, Namhyung Kim wrote:
> > Hello Andrii,
> >
> > On Wed, Apr 26, 2023 at 6:19 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Wed, Apr 26, 2023 at 5:14 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >>>
> >>> Hello,
> >>>
> >>> I'm having a problem of loading perf lock contention BPF program [1]
> >>> on old kernels.  It has collect_lock_syms() to get the address of each
> >>> CPU's run-queue lock.  The kernel 5.14 changed the name of the field
> >>> so there's bpf_core_field_exists to check the name like below.
> >>>
> >>>         if (bpf_core_field_exists(rq_new->__lock))
> >>>                 lock_addr = (__u64)&rq_new->__lock;
> >>>         else
> >>>                 lock_addr = (__u64)&rq_old->lock;
> >>
> >> I suspect compiler rewrites it to something like
> >>
> >>    lock_addr = (__u64)&rq_old->lock;
> >>    if (bpf_core_field_exists(rq_new->__lock))
> >>         lock_addr = (__u64)&rq_new->__lock;
> >>
> >> so rq_old relocation always happens and ends up being not guarded
> >> properly. You can try adding barrier_var(rq_new) and
> >> barrier_var(rq_old) around if and inside branches, that should
> >> pessimize compiler
> >>
> >> alternatively if you do
> >>
> >> if (bpf_core_field_exists(rq_new->__lock))
> >>     lock_addr = (__u64)&rq_new->__lock;
> >> else if (bpf_core_field_exists(rq_old->lock))
> >>     lock_addr = (__u64)&rq_old->lock;
> >> else
> >>     lock_addr = 0; /* or signal error somehow */
> >>
> >> It might work as well.
> >
> > Thanks a lot for your comment!
> >
> > I've tried the below code but no luck. :(
> >
> >         barrier_var(rq_old);
> >         barrier_var(rq_new);
> >
> >         if (bpf_core_field_exists(rq_old->lock)) {
> >             barrier_var(rq_old);
> >             lock_addr = (__u64)&rq_old->lock;
>
> Have you tried `BPF_CORE_READ(rq_old, lock)` ?

No, but I think it'd dereference the lock, right?
I just want to get the address of the lock field.

Thanks,
Namhyung

>
> >         } else if (bpf_core_field_exists(rq_new->__lock)) {
> >             barrier_var(rq_new);
> >             lock_addr = (__u64)&rq_new->__lock;
> >         } else
> >             lock_addr = 0;
> >
> >
> > ; int BPF_PROG(collect_lock_syms)
> > 0: (b7) r8 = 0                        ; R8_w=0
> > 1: (b7) r7 = 1                        ; R7_w=1
> > 2: <invalid CO-RE relocation>
> > failed to resolve CO-RE relocation <byte_off> [381] struct
> > rq___old.lock (0:0 @ offset 0)
> > processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > peak_states 0 mark_read
> >
> > Thanks,
> > Namhyung
>
> Cheers,
> Hengqi
