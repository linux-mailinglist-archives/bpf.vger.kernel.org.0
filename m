Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E684425FD
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 04:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhKBDXD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 23:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhKBDXD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 23:23:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6608C061714;
        Mon,  1 Nov 2021 20:20:28 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r28so18993827pga.0;
        Mon, 01 Nov 2021 20:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzmqKQY04x0Mf4v12yhiT4vRZMoRSKZyJDowpEUZgLM=;
        b=jFB1CeXudan1gpt+WYXrPANf21KVYr7eNwWcSdTX7/NP0/0z2t8Scz3zfU7h+h8Bh8
         TGzXwFsUK3hUfQoekamLiflZqX2w3Xhw9imauD6d9Qj5E561bl8jhXRZV+O0AUOpnPUC
         9Avp4G8ZygQon7Cm5akD2V91qbhHRLBl0EPxZbVkSkTy4G6Xi5MT1MpddEUJ5pqgtBd5
         YrDg7Ya1R4ZxMoHZWdBnHuPGn1Ea/bvZTt1pcLk1i5Ee70gsS4yPMHJ28XdKb+8dV3QZ
         AgyMKcV9AxZQcoREHiVqdXF8hEOimkj3rXUF1+/M+gZmY6APdOVKNWX3eIQTZ59SoEgw
         f3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzmqKQY04x0Mf4v12yhiT4vRZMoRSKZyJDowpEUZgLM=;
        b=jWLuq5pGjhRwKv6arbBuFKgk0aridU7Mim3BCOBUiBNH8hrBWU3Ane76O7+Eg7sBMd
         /gZJUlh+UnI+O/YmCL0huN+9AX+c481B6oYcZSOuFriX/jhe8DaL/19NgNQ9qFgHRZQB
         cmnW5eh77ItamvqVkMthsVRt2ryAPkz+Uc+/+CNMMFfCkzYruYd+CGwQZB8bQXw/nhgr
         N4jt6YcOk7QIUnnDCH1Jf2ZEhoAgPMEVmJOCNSKhQq2Zkx7Ek655wdPKfaiPQHL/knM1
         gDDclZGym0mA6kFaAu0zdL+sbfmMnftTxsamU7Vsx7FzPZjLrlWvzW23w28qm3eMrufz
         wHhQ==
X-Gm-Message-State: AOAM531TfISx6t1k5ewtppqkxFP0mpU7BxqpDMRRs1Ovdn0FaHkFW8AN
        8Uyky2PsPb5IU1tUPnMdDR1qtGyLZB2TBY22yhE=
X-Google-Smtp-Source: ABdhPJwdv1KNLDL9nmzyyC9NTW00o/MV6TecqdnK2ml7KeH69x0y2LowAWCTPO126l7tHvbrBg0nx+hO4Esmmra3724=
X-Received: by 2002:a63:8642:: with SMTP id x63mr8609418pgd.376.1635823228318;
 Mon, 01 Nov 2021 20:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211028164357.1439102-1-revest@chromium.org> <20211028224653.qhuwkp75fridkzpw@kafai-mbp.dhcp.thefacebook.com>
 <CABRcYmLWAp6kYJBA2g+DvNQcg-5NaAz7u51ucBMPfW0dGykZAg@mail.gmail.com>
 <204584e8-7817-f445-1e73-b23552f54c2f@gmail.com> <CABRcYmJxp6-GSDRZfBQ-_7MbaJWTM_W4Ok=nSxLVEJ3+Sn7Fpw@mail.gmail.com>
 <dccc55b4-9f45-4b1c-2166-184a8979bdc6@fb.com> <CAADnVQ+pwWWumw9_--jj7e_RL=n6Q3jhe6yawuSeMJzpFi_E2A@mail.gmail.com>
 <CAEf4BzZ-YtppVG2GARkc_MNu-khqJXgS4=ThzOV4W6gic1rCxg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ-YtppVG2GARkc_MNu-khqJXgS4=ThzOV4W6gic1rCxg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 1 Nov 2021 20:20:17 -0700
Message-ID: <CAADnVQLKkqjnTOAqm3KeP45XsbfDATWcASJr5uoNOYT33W40OQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_d_path in perf_event_mmap
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Mon, Nov 1, 2021 at 8:16 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > >
> > >     FILE *vm_file = vma->vm_file; /* no checking is needed, vma from
> > > parameter which is not NULL */
> > >     if (vm_file)
> > >       bpf_d_path(&vm_file->f_path, path, sizeof(path));
> >
> > That should work.
> > The verifier can achieve that by marking certain fields as PTR_TO_BTF_ID_OR_NULL
> > instead of PTR_TO_BTF_ID while walking such pointers.
> > And then disallow pointer arithmetic on PTR_TO_BTF_ID_OR_NULL until it
> > goes through 'if (Rx == NULL)' check inside the program and gets converted to
> > PTR_TO_BTF_ID.
> > Initially we can hard code such fields via BTF_ID(struct, file) macro.'
> > So any pointer that results into a 'struct file' pointer will be
> > PTR_TO_BTF_ID_OR_NULL.
>
> Can we just require all helpers to check NULL if they accept
> PTR_TO_BTF_ID? It's always been a case that PTR_TO_BTF_ID can be null.
> We should audit all the helpers with ARG_PTR_TO_BTF_ID and ensure they
> do proper validation, of course.
>
> Or am I missing the essence of the issue?

It's not a pointer dereference. It's math on the pointer. The
&vm_file->f_path part.
The helper can check that it's [0, few_pages] and declare it's bad.
I guess we can do that and only do what I proposed for "more than a page"
math on the pointer. Or even disallow "add more than a page offset to
PTR_TO_BTF_ID"
for now, since it will cover 99% of the cases.
