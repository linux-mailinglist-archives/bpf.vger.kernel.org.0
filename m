Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4D3442651
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 05:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhKBEIj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 00:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhKBEIh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Nov 2021 00:08:37 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D439C061714;
        Mon,  1 Nov 2021 21:06:03 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id d204so49832330ybb.4;
        Mon, 01 Nov 2021 21:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hKu2C6iWObgpY6Uxijr5O+vBNZnv9w++B0eV8phTFtc=;
        b=kBxw59cHn7I+wIiCFArWLhvCrGVvnZ6wT+67gu+BmSZ2oXautKICrC46RSh/O33OSY
         duUKLIsUYBw6QmJU1bZ/i8wJeApOmqpFevyDtUJj7D3N4p1P8Q30D1rKSarUK2lBAiIl
         P9rMHubBVt6PDHvNZzDPVm6HcdMg3pFqFd22hv7elsXHi70xmEgcm2HGlf80aKPIp4CS
         6PrGlfDM0FGLIIpAFKsUt9htT/yD0eb8BOJhSHsR46cpnHRAOJz/Sfjh+rF2sf617QA0
         qGdNkMaeJRP8808nc9gYvDowfPKDAKQXz3N/qsbEoapV4syQvLAzILaAvfM1I0hEKo9/
         QGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hKu2C6iWObgpY6Uxijr5O+vBNZnv9w++B0eV8phTFtc=;
        b=fIj7TQvk2hZkdF1btSCIfkZ+iY6DP3U38I167chWmT2WDpJ5/VU9ybaRNWmqHKzAht
         XraxZWEkyuYI4MwMn/f8/HFrbI52w/FgPSJalAO4KJbPmJLnG5IdOhO5QEZPCM0CJR96
         C3k1KoMSLi3pcikn5ZvefjBEdYJeQkT+a3Sdl4jgAiu0JM8FPCdZ8Nc5mxp/vh8Fldf0
         GX/xkdwJ7p+Q7dZYU7K19xmce1fMK17HQ4BNXfzHYwgJFs3+a8CC78ju14e+o2ucoYqb
         H85nMlkQdMWtLRoSZzx1snVObcsche3B8ywvV83jQ4Nfymq9zG7vqUetVgRMx25Ns4mv
         2i9Q==
X-Gm-Message-State: AOAM530MbE1e//YQrQellj40BJD/hM5IJU5hbjD3AvTBJpnkKbtKPjT/
        CtPZt7cwD36aziMtF6c4VO4VmZ7HpCb0jN7461A=
X-Google-Smtp-Source: ABdhPJwzZj7lM7f5QTwYI+Ozv2/ggyDDcFK7Jry8mDo13pqkCM1Xb2pHWCwdsG32chaCcWsaf/0zRIDGTQQ/XXy+Gcc=
X-Received: by 2002:a25:d16:: with SMTP id 22mr29065541ybn.51.1635825962597;
 Mon, 01 Nov 2021 21:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211028164357.1439102-1-revest@chromium.org> <20211028224653.qhuwkp75fridkzpw@kafai-mbp.dhcp.thefacebook.com>
 <CABRcYmLWAp6kYJBA2g+DvNQcg-5NaAz7u51ucBMPfW0dGykZAg@mail.gmail.com>
 <204584e8-7817-f445-1e73-b23552f54c2f@gmail.com> <CABRcYmJxp6-GSDRZfBQ-_7MbaJWTM_W4Ok=nSxLVEJ3+Sn7Fpw@mail.gmail.com>
 <dccc55b4-9f45-4b1c-2166-184a8979bdc6@fb.com> <CAADnVQ+pwWWumw9_--jj7e_RL=n6Q3jhe6yawuSeMJzpFi_E2A@mail.gmail.com>
 <CAEf4BzZ-YtppVG2GARkc_MNu-khqJXgS4=ThzOV4W6gic1rCxg@mail.gmail.com> <CAADnVQLKkqjnTOAqm3KeP45XsbfDATWcASJr5uoNOYT33W40OQ@mail.gmail.com>
In-Reply-To: <CAADnVQLKkqjnTOAqm3KeP45XsbfDATWcASJr5uoNOYT33W40OQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Nov 2021 21:05:51 -0700
Message-ID: <CAEf4Bzb4Prxt48bfX8qJ-GSMXPZU9ndkqExvPtOWzEsuK965ig@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_d_path in perf_event_mmap
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Florent Revest <revest@chromium.org>,
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

On Mon, Nov 1, 2021 at 8:20 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 1, 2021 at 8:16 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > >     FILE *vm_file = vma->vm_file; /* no checking is needed, vma from
> > > > parameter which is not NULL */
> > > >     if (vm_file)
> > > >       bpf_d_path(&vm_file->f_path, path, sizeof(path));
> > >
> > > That should work.
> > > The verifier can achieve that by marking certain fields as PTR_TO_BTF_ID_OR_NULL
> > > instead of PTR_TO_BTF_ID while walking such pointers.
> > > And then disallow pointer arithmetic on PTR_TO_BTF_ID_OR_NULL until it
> > > goes through 'if (Rx == NULL)' check inside the program and gets converted to
> > > PTR_TO_BTF_ID.
> > > Initially we can hard code such fields via BTF_ID(struct, file) macro.'
> > > So any pointer that results into a 'struct file' pointer will be
> > > PTR_TO_BTF_ID_OR_NULL.
> >
> > Can we just require all helpers to check NULL if they accept
> > PTR_TO_BTF_ID? It's always been a case that PTR_TO_BTF_ID can be null.
> > We should audit all the helpers with ARG_PTR_TO_BTF_ID and ensure they
> > do proper validation, of course.
> >
> > Or am I missing the essence of the issue?
>
> It's not a pointer dereference. It's math on the pointer. The
> &vm_file->f_path part.

Ah, I see... Makes sense now.

> The helper can check that it's [0, few_pages] and declare it's bad.

That's basically what happens with direct memory reads, so I guess it
would be fine.

> I guess we can do that and only do what I proposed for "more than a page"
> math on the pointer. Or even disallow "add more than a page offset to
> PTR_TO_BTF_ID"
> for now, since it will cover 99% of the cases.
