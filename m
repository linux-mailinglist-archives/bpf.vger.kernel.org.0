Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87028394EDF
	for <lists+bpf@lfdr.de>; Sun, 30 May 2021 03:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhE3BP7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 May 2021 21:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhE3BP6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 May 2021 21:15:58 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0683C061574
        for <bpf@vger.kernel.org>; Sat, 29 May 2021 18:14:20 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id f84so11241820ybg.0
        for <bpf@vger.kernel.org>; Sat, 29 May 2021 18:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SifpbqqQdmz17+n6rnPTycAUUGqPDSCSUyuuOs/Hmek=;
        b=ZG0yv685Ge+AQnLsAP/O5RIJx/e+4Crmlvq1/jyKiLEm9mqLpqMuTU+iuLqSedJ+rS
         KdTJrLVi8oLvKzkxcOOKjg1sWGixSGl9RxPoL0xugV3E7XoHugbtJlArS1rtrhZfbuDZ
         PKDw0mDalK98gS41qOr+X2mVoX6kG30Oc3+4yI98ufD0myb88bIBs14QXo0dM2o+XAHL
         MLpASyjf2zjlwJoL0wOTCLA4wXL4xtVo59fgjW35hjOiMzDRGJeviYExoXuzg1op8dS/
         0Gzd1konnrrRFbHGYK+jGhz/e5oLUlQRWeM6CnqcmK56zxBFInwjXbS6KwnVnYwVULQr
         1Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SifpbqqQdmz17+n6rnPTycAUUGqPDSCSUyuuOs/Hmek=;
        b=O6nwHJIzVUAMvEyp8RDJRJUlSVB26Q/FPzpIBW5aZqb8YCDfjzy5LnQcNSpo6DYkR+
         UKJ1xr9YHGLx91LhgvrlUGeYVF/4VCJ0lcavql+PacvuvH4JUpKCf2evTR7jxxbkagxI
         3U9viL4aYIHAvO3j+mNbx2yG1NkJL23XuPM9VaSwN3iJTZ19qUPfyrnZp1seWmac8SkG
         aDMfq6X6zdc4jr6bgOJbMcecBmotlxKbmBOTLLXorXNgEteD3EXHNjbZ2C86e7qd6za0
         m1pRwVEh67UBv5sVe37m5HJiLRjdzegKtQ+hWXBNiipdj/VhbXxLVkXUqgQFvSFS0kiQ
         3C1A==
X-Gm-Message-State: AOAM530sY9vNUaXx3S6ZYpnh0FxMOYzWTlIFo73H95Qw/g6L7Go2K1oh
        sZaU+AN2GiMCuEgXrltrfWlmW3sYYlaAetfxG4o=
X-Google-Smtp-Source: ABdhPJycH+kiJZVbbtHao4iiq/XeKm1dPLlurmw0G0veo2dFmdeKJoE+L6Gsl6zmmv+7bE6zTeSSSZrulVlAtr/DXeg=
X-Received: by 2002:a25:4182:: with SMTP id o124mr3494960yba.27.1622337259870;
 Sat, 29 May 2021 18:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oV7yTT=8Uv_zipO=EY39B_Ye77XKjzAPcok5Z38B59Fhg@mail.gmail.com>
In-Reply-To: <CAO658oV7yTT=8Uv_zipO=EY39B_Ye77XKjzAPcok5Z38B59Fhg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 29 May 2021 18:14:08 -0700
Message-ID: <CAEf4BzZY+mmGHZRmsrLY_YPE52_LkcC3Nf0GwGVb=gmkyHgwFg@mail.gmail.com>
Subject: Re: Strategy for debugging 'Exceeded stack limit' errors
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, May 29, 2021 at 9:49 AM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> Hi all,
>
> I'm trying to reduce stack usage in my bpf program. I moved over to
> using `bpf_core_read()` instead of `bpf_probe_read()` and it appears
> to have made my program exceed the 512 byte stack limit.

bpf_core_read() is almost identical to bpf_probe_read() except it
might generated extra register assignment due to CO-RE relocation,
which in turn might cause stack spill due to register use, etc. So my
advice would be to try to simplify your code and split it into
sub-programs, easing the stack spill pressure for compiler. But the
link to example code would probably a good way to get more actionable
feedback.

>
> Are there any profiler tools or compiler flags I can use to figure out
> what is exactly using up the most memory?

llvm-objdump -d <bpf.o> and see what stores at big negative offsets
relative to r10 (which is a frame pointer)?

>
> Additionally, does anyone have good examples they can point me to of
> storing structures in per_cpu maps or local storage mechanisms?

selftests, as always (don't know about "good examples", but examples
nevertheless). See progs/profiler.inc.h in particular and its use of
per-CPU array for poor man's heap implementation (data_heap map).


>
> Thanks so much!
> Grant
