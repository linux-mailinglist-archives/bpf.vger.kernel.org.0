Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F053D4F6E70
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 01:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiDFXUL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 19:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiDFXUK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 19:20:10 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDB5A2065
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 16:18:12 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z6so4973215iot.0
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 16:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ky/QcBOPGhvSLx30JxqiV46c0zWx/wKU9HEIfbxjYNY=;
        b=OQqs9NKJxYREpy304qKoknDF4jIehAHbS5/38DlmxRvdoHT6xgeL+J7SIFKvxAbUBp
         TKaRR9JRNWiyAVgLWHjy/+/wTv8wWLz0t8C9F2YdUDikr+bDgqbOLH+f79Wf0nTbvdBM
         EX+yuNHKd/QpIsAdz9wXuex01l9Xt8XxdvXgYkSt7fh4qOiKxy1Izo5Y1Y9Y3KlOMzaU
         tN3e8fOkInA3BzEfPGRlI8bsL951RGLzcR3Wx8aKpIzBhI1CfIwbmTlTP9KZzGmrhwFd
         NfVnugCOsIYRHuW1qGVZAylwHGhYpZIPV/k6OKq9188pgP+BdO7BOH/uSGO6ZW65pCyx
         kB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ky/QcBOPGhvSLx30JxqiV46c0zWx/wKU9HEIfbxjYNY=;
        b=1+Gc0VPOb1OK5ocJr6Ti8rUnDQrAoaMBuILRJXMT2kRGcshtk64cRn5+gHDRbNAUzt
         fXUL4Z7TGZkIdc0jnITnwv1BDn6FjN8neI1OyBvHRGQKueU0oc6PwfJN7wxW1pgv63Jv
         v2iOEpr7GVXpMp54dLp8bIDd9JuW4qqhpaoiwR+6HV2aCiv5rgy9dZZgw9Vg5pLPQ/F9
         +YApy8dBpoN+dAc1QLhYuSAC+R0gDRtBHhNNuqWVKwuMkOLOLEIrDA27bayYCbDxCjf8
         sVhQVFJ+EStdA2GDnYJniWgcU4W+KL3DXJxTwFSsriogVROZ/OSR+57qcbhTdZ+x/Hpu
         ew9w==
X-Gm-Message-State: AOAM530QpHtVNjit96af+Sa8OLTRdC3ogfigfL2G6lx0D1pkOyl56ArP
        EyeYYnT8ovLeBMo6oLatYHxVpN03qtZa89+/s599itBG
X-Google-Smtp-Source: ABdhPJyHEgiyVZwQOrfhKiddfvGa5aaJZStKTa4Kr9OkMKJT7xTvmwJWjcavGEVRQPo6xy92Y430cL6ZGQa5eLREenY=
X-Received: by 2002:a05:6602:735:b0:64c:adf1:ae09 with SMTP id
 g21-20020a056602073500b0064cadf1ae09mr5020593iox.79.1649287092066; Wed, 06
 Apr 2022 16:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oVD+0Ltuww1F-AZdPtSE4O4M-BH5NP_R-oSBWszZ3oZiQ@mail.gmail.com>
 <CAEf4BzY8kjQDrkKU2gZox8J9gF7iQ9ht=2GVmXuktCRg0sRqjA@mail.gmail.com> <CAO658oUbXfuYzK1fxTrEdHJffhxpvL9QBZLdOtY6uG98H1e0Lg@mail.gmail.com>
In-Reply-To: <CAO658oUbXfuYzK1fxTrEdHJffhxpvL9QBZLdOtY6uG98H1e0Lg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Apr 2022 16:18:01 -0700
Message-ID: <CAEf4BzZan24Fh-+f5OMkZEFtpMsStm+OpCoYuwbxQBwK2q7CJg@mail.gmail.com>
Subject: Re: Questions on BPF_PROG_TYPE_TRACING & fentry/fexit
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
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

On Wed, Apr 6, 2022 at 1:01 PM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> On Sun, Apr 3, 2022 at 7:47 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Apr 1, 2022 at 7:27 AM Grant Seltzer Richman
> > <grantseltzer@gmail.com> wrote:
> > >
> > > Hi there,
> > >
> > > I'm looking to implement programs of type BPF_PROG_TYPE_TRACING to
> > > replace kprobe/tracepoints because from what I can tell there's less
> > > performance overhead. However, I'm trying to understand restrictions
> > > and use cases.
> > >
> > > I see that there's a generic `bpf_program__attach()` which can be used
> > > to attach programs and it will attempt to auto-detect type and attach
> > > them accordingly.
> > >
> > > In practice, I'm curious what I can attach programs of this type to,
> > > and how are they specified? `bpf_program__attach()` doesn't take any
> > > parameters outside of the program itself. Does it attach based on the
> > > name of the program's name/section? If so, is there an idiomatic way
> > > of making sure this is correctly done?
> >
> > You can specify destination either in SEC() definition:
> > SEC("fentry/some_kernel_func") or you can use
> > bpf_program__set_attach_target(...) before BPF object is loaded.
>
> Can you elaborate more on `bpf_program__set_attach_target()`? I've
> been working through the selftests and understand that you can use it
> to attach bpf programs to other bpf programs, and kernel modules. Are
> there only certain types of bpf programs that can be attached to? Are
> there restrictions on what kind of programs can attach to others?

You can attach to kernel functions as well, if you specify
attach_prog_fd = 0. See the implementation in tools/lib/bpf/libbpf.c.
As for types of programs, it's fentry/fexit/fmod_ret and freplace for
attaching to other programs. All the details about freplace... I'm not
the best expert on that and you'll have to read kernel
code/docs/experiment.

>
> > >
> > > My follow up question is to ask how fentry/fexit relate. I've seen
> > > these referred to as program types but in code they appear as attach
> > > types, not program types. Can someone clarify?
> >
> > Formally they are different expected attach types for
> > BPF_PROG_TYPE_TRACING program type. There is also fmod_ret, which is
> > yet another expected attach type with still different semantics. But
> > it's like kprobe and kretprobe, they have very different semantics, so
> > we talk about them as two different types of BPF program.
> >
> > >
> > > As always I'm partly asking so that I can document this and avoid
> > > other people having the same confusion :-)
> > >
> >
> > Yep, I appreciate it. Please send follow up questions if you still
> > have some. Please check relevant selftests to see possible usages.
> >
> > > Thank you very much!
> > > Grant
