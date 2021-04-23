Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E6236930A
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 15:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhDWN1I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Apr 2021 09:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241875AbhDWN1I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Apr 2021 09:27:08 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154E5C06174A
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 06:26:30 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id s16so43636320iog.9
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 06:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W9t1u365J/63AT2Wytry3Gy5TCslV9JQ80oTdyfzGqA=;
        b=PZG/CKA0JMPJkboWk7lRr/z0ls0N6+Pb8D2Kj9oBOVyMRu/HgkUZlnAgMHgVxAUc/V
         w9xz/OgZ3w2YCLWxiezZP4JEOhkC1vASKWmffk6HsIjQJ+H7uZuo2G3DqJoRBYHv6PE4
         xTtuaua32tjtoTPLNLl33OjiJvscXab45quB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W9t1u365J/63AT2Wytry3Gy5TCslV9JQ80oTdyfzGqA=;
        b=Y6z5qqPtm9EWRFqfiS3zWrrFET42HyApEj9Vi32xy1LsM1we+XhuU5f89MXk7XqTlU
         CNkLqEFhn8ghg6kxJI8HMpqSy/HwXmXSw4qW21rlnKVuqi7qBJkWFs64gJa3CrG3nTMj
         aWQw0Z7xFhxnWXmHRS9hoNbI3ZiBXkZDXG8N3cRdh+HjgLrEMk37YYW/LzPqvoQXZ0de
         fnTAeUMdKOozE5xWPUwwtp06zAuR3oLxFjShBb4BAMar+rJcRCDtu/sgKNuFoE0s+EOi
         gqpC9JVi111X9jiAwU1TEWvREfcrFwWgm9ICJsQNHS9xEsv0iHYbB5IAaqjUBPRSIaL/
         Gl5A==
X-Gm-Message-State: AOAM533X20NDnx//ffHCw6hw4rnNTko5mP+jdvXb83DvrWENWoEXuRDU
        4cHL+II0pMC5tESpJWCAuh+CjBFwWcVMM50BbHJzYA==
X-Google-Smtp-Source: ABdhPJw/Euvb8E/egiY45whR7d/k3iOF05q2FshYhAQ9qfDnhF+bcbWfDBr83wk2mDDH490cjiBbUKgxMV0hwIEP8yY=
X-Received: by 2002:a05:6638:2515:: with SMTP id v21mr3691903jat.110.1619184389457;
 Fri, 23 Apr 2021 06:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210423011517.4069221-1-revest@chromium.org> <8f89faf1-d7e6-ebe0-fb7d-c5b8243d140a@rasmusvillemoes.dk>
In-Reply-To: <8f89faf1-d7e6-ebe0-fb7d-c5b8243d140a@rasmusvillemoes.dk>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 23 Apr 2021 15:26:18 +0200
Message-ID: <CABRcYmLDBfoM8rOwPf+SdqkmJgtFRLYF94S4Fv2eU=Uwg4asTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] Implement BPF formatted output helpers with bstr_printf
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 23, 2021 at 10:50 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 23/04/2021 03.15, Florent Revest wrote:
> > Our formatted output helpers are currently implemented with
> > snprintf-like functions which take arguments as va_list but the types
> > stored in a va_list need to be known at compilation time which causes
> > problems when dealing with arguments from the BPF world that are always
> > u64 but considered differently depending on the format specifiers they
> > are associated with at runtime.
> >
> > This series replaces snprintf usages with bstr_printf calls. This lets
> > us construct a binary representation of arguments in bpf_printf_prepare
> > at runtime that matches an ABI that is neither arch nor compiler
> > specific.
> >
> > This solves a bug reported by Rasmus Villemoes that would mangle
> > arguments on 32 bit machines.
>
> That's not entirely accurate. The arguments are also mangled on x86-64,
> it's just that in a few cases that goes unnoticed. That's why I
> suggested you try and take your test case (which I assume had been
> passing with flying colours on x86-64) and rearrange the specifiers,
> arguments and expected output string so that the (morally) 32 bit
> arguments end up beyond those-that-end-up-in-the-reg_save_area.
>
> IOWs, it is the 32 bit arguments that are mangled (because they get
> passed as-if they were actually 64 bits), and that applies on all
> architectures; nothing to do with sizeof(long).

Mh, yes, I get your point and I agree that my description does not
really fit what you reported.

I tried what you suggested though, with the current bpf-next/master on x86_64:
BPF_SNPRINTF(out, sizeof(out),
"%u %d %u %d %u %d %u %d %u %d %u %d",
1, -2, 3, -4, 5, -6, 7, -8, 9, -10, 11, -12);

And out is "1 -2 3 -4 5 -6 7 -8 9 -10 11 -12" so i can't seem to be
able to produce the bug you described.
Do you think I'm missing something? Would you try it differently ?
