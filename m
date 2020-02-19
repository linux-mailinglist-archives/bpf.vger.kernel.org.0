Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5C31652DD
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2020 00:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBSXDu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 18:03:50 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41842 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgBSXDu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Feb 2020 18:03:50 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so1473056lfp.8;
        Wed, 19 Feb 2020 15:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u1b+ps8lztV4XyHEm278bMODq/J9Mw3/Gq8CUQAHwg0=;
        b=RYkYzbQ7IwwW9BSlL1ac6tlfCGg8H5b46i7ySkptMCIgV/dbWeRljn/EIy/rnhpd3C
         NlD3DZe05tqDxmEiXSQbIlgwb9wqo0NWO9X7VMnnJBvT6y91lBqdH7AwP5zVEuNG/b4a
         4RWH4DVZOswDnjGblE+Xn+01AP8r/D8MQGhqIscBgYtPwuvZWJoZqXRr77b0CDiDOrDW
         4dX75HL/9y6MNZwqatlYFJ+Pi3m1a53ULB7MkfQ+QIoTuZVSCFmtgM6SrkbvLHUAOxJ2
         xSOrVMprqSF6W2EKgQOuUcBVJi38ZRLe+/xtVOheyIqt3We80eleGytjDDvriAb6XlKO
         Vg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1b+ps8lztV4XyHEm278bMODq/J9Mw3/Gq8CUQAHwg0=;
        b=Z8yqZS+pdVIvNABfwbuAkb3C7aUqLX1NyHSEMIfvDI7Cr5sS/JcY0DUxlIPuG60z/W
         ZcI90R9rnpYt/aLjbgQkDcled0mNZzrJ7Lu9bhE7sOywzNwN3iERbWPHSDngnFTsN9fO
         zakLoJo1GHlrvD/rglbqobdWEC0UXp+PWC04CHOMP0x6Hk5Y1N1YRSBHGC8nzCJL8qXV
         VYiGWUy5iDe6iXZAAEozmPv8SS234EFo88Eo5kmtrgaZpnheRq0VAUT5QXoa/oHxguvk
         Hexrr+1raKXDBl3O1igIDmevkzQ0y88onSaH1N8ysb9nM206iiL5euRXODVvmHK2iHT2
         XZhw==
X-Gm-Message-State: APjAAAWxtxspTOFW2FOk9yix4aTK29D3OufTqUkT3RUIkeelXsW5x6IC
        EnkPT4xl5I8XNyvUkCifJlBQ33eIyT0RyYaa//jRHjtY
X-Google-Smtp-Source: APXvYqwisdx9+kc17pcpMePXcrmyys5g9WOMxpjMU9BkzTj75NWWighxckbh/Fq92t3ZM16FQIlmHD4iqfKLBbSnxgY=
X-Received: by 2002:a19:5013:: with SMTP id e19mr14559430lfb.8.1582153428297;
 Wed, 19 Feb 2020 15:03:48 -0800 (PST)
MIME-Version: 1.0
References: <20200218030432.4600-1-dxu@dxuuu.xyz> <20200218030432.4600-3-dxu@dxuuu.xyz>
 <CAADnVQKA3ZCEAynRQOaorAxF4hP2ZgCD=6UMbF5yMCtrR7hw9A@mail.gmail.com>
In-Reply-To: <CAADnVQKA3ZCEAynRQOaorAxF4hP2ZgCD=6UMbF5yMCtrR7hw9A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Feb 2020 15:03:36 -0800
Message-ID: <CAADnVQLbBm6SULFf3sGNWznc2Q+pALLJpLsMO9XuyY1oXQoO6w@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 2/2] selftests/bpf: add bpf_read_branch_records()
 selftest
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 19, 2020 at 2:47 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 17, 2020 at 7:04 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Add a selftest to test:
> >
> > * default bpf_read_branch_records() behavior
> > * BPF_F_GET_BRANCH_RECORDS_SIZE flag behavior
> > * error path on non branch record perf events
> > * using helper to write to stack
> > * using helper to write to global
> >
> > On host with hardware counter support:
> >
> >     # ./test_progs -t perf_branches
> >     #27/1 perf_branches_hw:OK
> >     #27/2 perf_branches_no_hw:OK
> >     #27 perf_branches:OK
> >     Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> >
> > On host without hardware counter support (VM):
> >
> >     # ./test_progs -t perf_branches
> >     #27/1 perf_branches_hw:OK
> >     #27/2 perf_branches_no_hw:OK
> >     #27 perf_branches:OK
> >     Summary: 1/2 PASSED, 1 SKIPPED, 0 FAILED
>
> That's not what I see:
> ./test_progs -t perf_branches
> test_perf_branches_hw:FAIL:perf_event_open err -1
> #27/1 perf_branches_hw:FAIL
> #27/2 perf_branches_no_hw:OK
> #27 perf_branches:FAIL
> Summary: 0/1 PASSED, 0 SKIPPED, 2 FAILED
>
> I remember previous version used to work, but something changed.

Looks like the error code has changed.
I've added
if (errno == ENOENT || errno == EOPNOTSUPP)
and applied.
Please test your patches more carefully next time.
