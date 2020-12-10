Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF8B2D6C31
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 01:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgLJXus (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 18:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgLJXu3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Dec 2020 18:50:29 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E523C0613CF;
        Thu, 10 Dec 2020 15:49:49 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id l14so6432477ybq.3;
        Thu, 10 Dec 2020 15:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uaA9pzlExQ0SleG42bO0r3RWL5rb1qRGcmLI39XsQtU=;
        b=DZ1Tay1fA2N9/F0bktr8bR3Z9tzmxiy6/Fz5aSZkYGyu9f3qTb1jO84tnOV55WWfV6
         XA6LmJQ2GMVwEvvxXQPRi6X7eUXKPPd7a4DdKKwHQHWfer1NVo/XUeQ12gnZI8Pqpj4i
         DE5W3ENJHR06gY8ImbDmcBzQfUuU+WDNtp6rXSeWVnvd+xSf/omk1OKs/RtoBJcqYWQZ
         56GFW2ZEgHfsD1SX0OqFb8+hzG2wzRLrjXfadz5J8fBCTDOsh9mA3QlSAqVBWRDKHBYI
         ohDrpB7JVLnOx5H2rBAm2+mfw/kIzarvNg5mOetYq79fbtnqVSvZbVtpSqw7/PF0G1xn
         jOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uaA9pzlExQ0SleG42bO0r3RWL5rb1qRGcmLI39XsQtU=;
        b=CDU2Q0OilrIN75qMRGmUXEejjKbs8qAOZKKtAFc29EN7DetVC9lEmoQ0hY7/Gdx5Lv
         f8RH5C7xzn1yhLU6IsOVBGxmsrjJ1WKTeeBxjfqXAR3JykV9DhpBXN6GTg0l217UFnSg
         iCzj8zOVB/kZxUCYUX58RLkrDNcnj8Mx8WoxuD/9iGBB77dfO0VJXFjt9PNT964WNont
         SW0iW0oPlfNypKC35UMQWJWNLDaGQuBwW6ufu9nW+TeHH9o98uT5uIVF24mEV1VGp0ZC
         KkihbYsOIqxO1sDo/4q/QXpbknnBroVIbpjbvlWFuKJ2CS+UjeG/ycNuqu4ZAH9RVXmV
         J+6A==
X-Gm-Message-State: AOAM532nXZpmirrR7Fz7yYV2mj3twai5vqnKDUGJM8/7qo7LRrCXuh/y
        UFK4P6unBr/MMtka7cSvqlubVwxijBIfCrsK0L24WiJCUbhUpQ==
X-Google-Smtp-Source: ABdhPJyog2y39LsdkToBbNLR2/CJUY1t2VZfThN5B1RNcLWOw4Jlr4aODRbM2CuD3IX1T7H8C1uFNtpMrPELmzap5bo=
X-Received: by 2002:a25:6a05:: with SMTP id f5mr14687082ybc.459.1607644188731;
 Thu, 10 Dec 2020 15:49:48 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzZWabv_hExaANQyQ71L2JHYqXaT4hFj52w-poWoVYWKqQ@mail.gmail.com>
 <20201210164315.GA184880@krava> <CAEf4BzaBOoZsSK8yGZBhwFzAADkQKsGt1quV9RvFk_+WZr=Y=Q@mail.gmail.com>
 <20201210234201.GC186916@krava>
In-Reply-To: <20201210234201.GC186916@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Dec 2020 15:49:38 -0800
Message-ID: <CAEf4BzbJY5w1nbY7k593wHJcMZwS0mw8mDoCpsH_BdDbLUOYyQ@mail.gmail.com>
Subject: Re: Per-CPU variables in modules and pahole
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 10, 2020 at 3:42 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Dec 10, 2020 at 09:02:05AM -0800, Andrii Nakryiko wrote:
>
> SNIP
>
> >
> > yes, ELF symbol's value is 4, but when iterating DWARF variables
> > (0x10e70 + 4) is returned. It does look like a special handling of
> > modules. I missed that libdw does some special things for specifically
> > modules. Further debugging yesterday showed that 0x10e70 roughly
> > corresponds to the offset of .data..per_cpu if you count all the
> > allocatable data sections that come before it. So I think you are
> > right. We should probably centralize the logic of kernel module
> > detection so that we can handle these module vs non-module differences
> > properly.
> >
> > >
> > > not sure this is related but looks like similar issue I had to
> > > solve for modules functions, as described in the changelog:
> > > (not merged yet)
> > >
> > >     btf_encoder: Detect kernel module ftrace addresses
> > >
> > >     ...
> > >     There's one tricky point with kernel modules wrt Elf object,
> > >     which we get from dwfl_module_getelf function. This function
> > >     performs all possible relocations, including __mcount_loc
> > >     section.
> > >
> > >     So addrs array contains relocated values, which we need take
> > >     into account when we compare them to functions values which
> > >     are relative to their sections.
> > >     ...
> > >
> > > The 0x10e74 value could be relocated 4.. but it's me guessing,
> > > because not sure where you see that address exactly
> >
> >
> > It comes up in cu__encode_btf(), var->ip.addr is not 4, as we expect it to be.
>
> I'm taking section sh_addr for each function and relocate
> the addr value for kernel modules, check setup_functions
> function
>
> I don't see this being somehow centralized, looks simple
> enough to me for each case

I meant centralized detection of whether we are working with the
module or vmlinux or something else. setup_functions() currently has
very specific heuristic for that. So I'd like to extract that or come
up with some other way that won't be so function specific
(__start_mcount_loc symbol vs __mcount_loc section).

>
> jirka
>
