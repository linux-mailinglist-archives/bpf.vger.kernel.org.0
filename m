Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A5A48F42F
	for <lists+bpf@lfdr.de>; Sat, 15 Jan 2022 02:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiAOBiY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 20:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiAOBiX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jan 2022 20:38:23 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A56C061574
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 17:38:23 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id a18so3453009ilq.6
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 17:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pvp4ojlM9+L2d11SlIvRmBfq9TxJ/pkSWXvFVOyA4Eo=;
        b=O9cV+YbLeI4R9Dy4n6XnMReC9u18Mm8N4gv93M+TdeLuUdS+Jzwcnf7uoJInr+C+5q
         fes6otc2Ah2wyzDbtDV8Wtf0vrZ6DsaM1nJlDx52zvItlfxcfHDI42rZhS6NdtFrqY8l
         DoCT2VFkSpR6khgON6O8NHo93wF2066Af9xOH1EEy8XsaSZlG2W+08rXbEDZgkGMrn43
         kKMq0JvxaGanjmfN2/u9lJSV3LaixR4D7EdN60ohw4QLCTvaISCCoXoeY3TrPmLS8AAY
         UQtN46AxyS/7oC6Bs8S69XF9kAC4FWVEL1k83jO4q3OoZvp5JyD00UPWMaMrrLscEDBl
         vspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pvp4ojlM9+L2d11SlIvRmBfq9TxJ/pkSWXvFVOyA4Eo=;
        b=1yBlYjvr2FLKyu0HEznRR6gGk+YoDFJ9naqdE2R8rFBXHhGjtmz4uRdHR8Pfbox+XH
         55zPLV4YuY9NN/mn1Ho8CmcMccJ7ori74fZ24zAtn6iufYDq4tnS7Dz3wp+eiTCM3/nG
         LQdA+HmdNtaQd+JcPcY9KbxJpJgw0jur/Ul5xb1MBfsUOxDrTXBXeCOnZfnTTXO17+He
         bo1eRIfuM4EsjCvcVcV4q2RswAQK79kU9qxG24Q+zx+Tf0OFur/7si3TJDGUC9bpz3G0
         UzOuUJeAA1bPpyKwQ89o/eoS0fhJz1CfmFyT65JNHHbbjSUBh8Lq/PgpEsmoKkmduBVk
         rrMA==
X-Gm-Message-State: AOAM533COsB3RIQupa1ok8XRmekJFRMBoDP+HKBNNHkbBRec44PUuZXl
        I/G6dWu/7o+qYR28gse6DLPDSLLdC2KBBh+5A6c=
X-Google-Smtp-Source: ABdhPJzWN7Sxa8p8V8Yp7K9pTVkyizoVm4y4YBWFSw9QA424ud9sdZkDImWecvTurtY/WFMjJXiG9NAd3DnZlSRwXSE=
X-Received: by 2002:a05:6e02:1c02:: with SMTP id l2mr6323866ilh.239.1642210702954;
 Fri, 14 Jan 2022 17:38:22 -0800 (PST)
MIME-Version: 1.0
References: <CAADnVQ+nS1++7NwcAPuwO26CcuvNnPVMQgtwi4FDNcmHQEBm8g@mail.gmail.com>
 <20220114231426.426052-1-kennyyu@fb.com>
In-Reply-To: <20220114231426.426052-1-kennyyu@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 14 Jan 2022 17:38:11 -0800
Message-ID: <CAEf4BzY9s1ngF_ja_rrpY=1cNX=byVSjptNT-LaEKTsUJEfP6Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] selftests/bpf: Add test for sleepable bpf
 iterator programs
To:     Kenny Yu <kennyyu@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 14, 2022 at 3:14 PM Kenny Yu <kennyyu@fb.com> wrote:
>
> Hi Alexei,
>
> > > +// New helper added
> > > +static long (*bpf_access_process_vm)(
> > > +       struct task_struct *tsk,
> > > +       unsigned long addr,
> > > +       void *buf,
> > > +       int len,
> > > +       unsigned int gup_flags) = (void *)186;
> >
> > This shouldn't be needed.
> > Since patch 1 updates tools/include/uapi/linux/bpf.h
> > it will be in bpf_helper_defs.h automatically.
>
> I will fix. This is my first time writing selftests, so I am not too familiar
> with how these are built and run. For my understanding, are these tests
> meant to be built and run after booting the new kernel?

Look at vmtest.sh under tools/testing/selftests/bpf, it handles
building kernel, selftests and spinning up qemu instance for running
selftests inside it.

>
> > > +
> > > +// Copied from include/linux/mm.h
> > > +#define FOLL_REMOTE 0x2000 /* we are working on non-current tsk/mm */
> >
> > Please use C style comments only.
>
> I will fix.
>
> > > +       numread = bpf_access_process_vm(task,
> > > +                                       (unsigned long)ptr,
> > > +                                       (void *)&user_data,
> > > +                                       sizeof(uint32_t),
> > > +                                       FOLL_REMOTE);
> >
> > We probably would need to hide flags like FOLL_REMOTE
> > inside the helper otherwise prog might confuse the kernel.
> > In this case I'm not even sure that FOLL_REMOTE is needed.
> > I suspect gup_flags=0 in all cases will work fine.
> > We're not doing write here and not pining anything.
> > fast_gup is not necessary either.
>
> Thanks for the suggestion! I'll remove the flag argument from the helper
> to simplify the API for bpf programs. This means that the helper will have
> the following signature:
>
>   bpf_access_process_vm(struct task_struct *tsk,
>                         unsigned long addr,
>                         void *buf,
>                         int len);

keeping generic u64 flags makes sense for the future, so I'd keep it.

But I also wanted to point out that this helper is logically in the
same family as bpf_probe_read_kernel/user and bpf_copy_from_user, etc,
where we have consistent pattern that first two arguments specify
destination buffer (so buf + len) and the remaining ones specify
source (in probe_read it's just an address, here it's tsk_addr). So I
wonder if it would be less surprising and more consistent to reorder
and have:

buf, len, tsk, addr, flags

?

>
> Thanks for the feedback!
>
> Kenny
