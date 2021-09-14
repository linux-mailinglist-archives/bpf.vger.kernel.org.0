Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D183640A532
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 06:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhINE0A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 00:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhINEZ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 00:25:59 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2F5C061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 21:24:43 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r2so11490945pgl.10
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 21:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AOKVL7NkgbI57/y6mwF6HrclDqcF0DiZ3Q5BxCHPQ70=;
        b=SFFSUMv7oOoBUTQ/AmwZhAU+YyjX1Xv84P3S9Gfb+q4CLjDV8V9ecSl5+nWnlG/gox
         l4OPqCDr8JZLPhwi2e2vggVS5y+AWEelp5oABzTajSiEA2SI3YPM76ROyxYIwQdC98RV
         D17o772g+HuFV7JUfMNt5Ho14ETrqsfIjYg/SU9cPTdq6Ytojpr5i5B/mPCqGJhZ8NeD
         kfHibXaVFJ/8Y3lw4gZ1dF5BYQ3QC8tmmkHmoFmVkYSWUVB4+tIdTcXYeJ9vF5S0mj+d
         oVe1Cc2ti1bgMKRpx2ygSGRd43/hP7RqWC+4zHvAHE3wGUpie79GEzDTFITsnIfbp7GU
         Dpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AOKVL7NkgbI57/y6mwF6HrclDqcF0DiZ3Q5BxCHPQ70=;
        b=m3+YYS2eEarzrhAXzUxJvRSV5o5g97PZldQCQNI8ryD3YNKhT8dWniQVIjB4pQITQh
         V+JE3ARapw4VTmmurhtdbchK/ceJx1KqqFC2YXYU6CNwqol9cG8+Y90xuch2EQgC5C6J
         x5363LCMA1XZlfCvb2EiwJ5ZR/Pijb+dgf9NCQHNbWJaC1t0vA4NWa9tHPlShGu3LIH5
         SMGEUsjBwlA4XeqChC4vjN2YCjh6Yygyapg68AN5k+jLELRzvy6W0/Bu789Du3ztYIUs
         YshzGXNoao9gYV2V3f2IH/YDMoE8FD0AKkCx4S1S+Ab9tvMYdkJNiaI4FVMlUgWHC0Me
         rohA==
X-Gm-Message-State: AOAM532x2+rdgbZ2DGSejeO8I90JT2ow76VAcasPtMqhDyyLB7DEDvkN
        Qn5tCyzqHOeU4N7xgJYKWgtoprUot3KVU4xxO5U=
X-Google-Smtp-Source: ABdhPJy+RT9OifhWpt093Aw6WzOb56XWsheqKKyR2opQGFsfACoLRclKfVE0WWBpVgyFQ5y3WcJPQpbW9r43EHLfMG8=
X-Received: by 2002:a62:b515:0:b0:438:42ab:2742 with SMTP id
 y21-20020a62b515000000b0043842ab2742mr2754082pfe.77.1631593482435; Mon, 13
 Sep 2021 21:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnuNNuenDT4Y_UHsny6BK_b1+g2joePAdapdn7aLCi99Rh3bg@mail.gmail.com>
 <CAEf4BzZokm=_5vdf3sCccTf2Enf0-kwij7dusykcgtWPkM=95g@mail.gmail.com>
In-Reply-To: <CAEf4BzZokm=_5vdf3sCccTf2Enf0-kwij7dusykcgtWPkM=95g@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 13 Sep 2021 21:24:31 -0700
Message-ID: <CAADnVQKN9uZ6KA97r1HzkWA63usdWatxXvV5+i=v=So1nirbVA@mail.gmail.com>
Subject: Re: Read process VM from kernel
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Gabriele <phoenix1987@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 8:48 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Sep 11, 2021 at 2:05 AM Gabriele <phoenix1987@gmail.com> wrote:
> >
> > Hi there
> >
> > I recently started playing around with libbpf and I was wondering if
> > it is possible to read a process' VM from the kernel side. In
> > user-space one could use process_vm_read, but I haven't been able to
> > find an equivalent BPF API for that.
>
> Currently only current process's memory (in which BPF program is
> running) can be read with bpf_probe_read_user(). I don't think there
> is anything that allows reading some other process' data like
> process_vm_read allows.

Indeed. Currently it's not possible, but this feature request
came up in the past and we couldn't do it until sleepable programs
came into existence.
Now ptrace_access_vm/process_vm_read could be added
as a bpf helper for sleepable programs.
Gab,
Please send a patch with a test case.
