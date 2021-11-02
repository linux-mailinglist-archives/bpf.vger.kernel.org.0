Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7F244394C
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 00:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhKBXGc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 19:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhKBXGc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Nov 2021 19:06:32 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EB1C061714
        for <bpf@vger.kernel.org>; Tue,  2 Nov 2021 16:03:57 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id y17so662847ilb.9
        for <bpf@vger.kernel.org>; Tue, 02 Nov 2021 16:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ymKBrF1lHUXhO11qLF1Obbq9g7saDwiiQnV7ykje44=;
        b=YFGSHXOnzm3Nf6cQVlx1DrAesM0CL0yllAeadoyVP9ENEoi283lOqB4RtkwGGO442f
         BKtE7QHbG4YnEOqX97+q4xEnk8DI92aNflHXnuz95nzTy4NNSBqD82OCGswWldycNAVo
         zyGRIN7mUNUNa/kFrCKBAVOxcg11X9TopVtUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ymKBrF1lHUXhO11qLF1Obbq9g7saDwiiQnV7ykje44=;
        b=oSTaXZy4j8pADI6SMR6GdBgofXLN57s7RYVsyd/rJ8UfhS2oQ2IvlPSnnQyxefvz34
         Rp0hxkwddjWtMlFijZkFrtqYagbTd5ngeLwRHyuUWrs80z5vVHgVitYe9nnSnfywf3Iq
         XvmvTr47gxTPRXunq2AXa/Z+ti3lhEJjfp4Kw75uSDhcbnx0tiWtytMvskVTsCg1Go6Y
         /WVQRIND6RQs8Q6nkyd68hq7bIfstmORlDHIV1fBfrx9uEZktGKnF8chBv5HwqHHiudX
         iW75kt021ehH+7H86EMYKktbkSFOZC59+oPrRjzICEiZiVmabgvOj40Im6v2e2GMCXdv
         WaHw==
X-Gm-Message-State: AOAM531HMLnHeJeAymiG13RDLo9wQE5uJoKFEkWsSPUkjyUN2NHmQou/
        csNb6iHJIpT9g2pKTrPp8euNfko0/z9VrBaW5/g1Y1rZHs0aCg==
X-Google-Smtp-Source: ABdhPJxrEyxWhOFvEiJ7aJJq3ROYYxHETNEMLdfVno2uwC+yHFGeEJMQiQmUDl8OJyiSFOWGSCxCSglCc2mTTjZh5PI=
X-Received: by 2002:a92:c547:: with SMTP id a7mr15498371ilj.189.1635894236494;
 Tue, 02 Nov 2021 16:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211028164357.1439102-1-revest@chromium.org> <20211028224653.qhuwkp75fridkzpw@kafai-mbp.dhcp.thefacebook.com>
 <CABRcYmLWAp6kYJBA2g+DvNQcg-5NaAz7u51ucBMPfW0dGykZAg@mail.gmail.com>
 <204584e8-7817-f445-1e73-b23552f54c2f@gmail.com> <CABRcYmJxp6-GSDRZfBQ-_7MbaJWTM_W4Ok=nSxLVEJ3+Sn7Fpw@mail.gmail.com>
 <dccc55b4-9f45-4b1c-2166-184a8979bdc6@fb.com> <CAADnVQ+pwWWumw9_--jj7e_RL=n6Q3jhe6yawuSeMJzpFi_E2A@mail.gmail.com>
 <CAEf4BzZ-YtppVG2GARkc_MNu-khqJXgS4=ThzOV4W6gic1rCxg@mail.gmail.com>
 <CAADnVQLKkqjnTOAqm3KeP45XsbfDATWcASJr5uoNOYT33W40OQ@mail.gmail.com> <CAEf4Bzb4Prxt48bfX8qJ-GSMXPZU9ndkqExvPtOWzEsuK965ig@mail.gmail.com>
In-Reply-To: <CAEf4Bzb4Prxt48bfX8qJ-GSMXPZU9ndkqExvPtOWzEsuK965ig@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 3 Nov 2021 00:03:45 +0100
Message-ID: <CABRcYmKBAssv7YKqFnw5dOBA9NTCyNJ5DnffkiP6=NUjC3+USg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_d_path in perf_event_mmap
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 2, 2021 at 5:06 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Nov 1, 2021 at 8:20 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Nov 1, 2021 at 8:16 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > >     FILE *vm_file = vma->vm_file; /* no checking is needed, vma from
> > > > > parameter which is not NULL */
> > > > >     if (vm_file)
> > > > >       bpf_d_path(&vm_file->f_path, path, sizeof(path));
> > > >
> > > > That should work.
> > > > The verifier can achieve that by marking certain fields as PTR_TO_BTF_ID_OR_NULL
> > > > instead of PTR_TO_BTF_ID while walking such pointers.
> > > > And then disallow pointer arithmetic on PTR_TO_BTF_ID_OR_NULL until it
> > > > goes through 'if (Rx == NULL)' check inside the program and gets converted to
> > > > PTR_TO_BTF_ID.
> > > > Initially we can hard code such fields via BTF_ID(struct, file) macro.'
> > > > So any pointer that results into a 'struct file' pointer will be
> > > > PTR_TO_BTF_ID_OR_NULL.

Right, this is what I had in mind originally. But I was afraid this
could maybe prevent some existing programs from loading on newer
kernels ? Not sure if that's an issue.

> > The helper can check that it's [0, few_pages] and declare it's bad.
>
> That's basically what happens with direct memory reads, so I guess it
> would be fine.
>
> > I guess we can do that and only do what I proposed for "more than a page"
> > math on the pointer. Or even disallow "add more than a page offset to
> > PTR_TO_BTF_ID"
> > for now, since it will cover 99% of the cases.

Otherwise this sounds like a straightforward solution, yes :)
Especially if this is how direct memory accesses already work.

I'd be happy to look into this when I get some slack time. ;)
