Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50BC3BF244
	for <lists+bpf@lfdr.de>; Thu,  8 Jul 2021 00:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhGGW6V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 18:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhGGW6V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 18:58:21 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D30C061574
        for <bpf@vger.kernel.org>; Wed,  7 Jul 2021 15:55:39 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i18so5739000yba.13
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 15:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Pt7HIPf0F9QxkP6F/8/Bdx9mVQFA+UxtpYl09Vy0tg=;
        b=Fy7HIRA07HknFI9snm2c042aagHP2OOo9NcTR3CTS8e7vgXQGjh5LvDJGmp36Cglnu
         R5womPuFFKQnnRtYQGVn8e8kjwW4ZHBM/0JUCisXsS+5xkkeJbI60XywAg5RmN53ie+w
         QLIQ3hAIs99h0RGLbmmD7YoDw0Zb2abiTvNPFLYDcPPDzCu9aYY6kzjPDdiZ4NsmZ1Z2
         wbuLipXV4345ERql0AUkul+oqxRRc9fqg+XvckzJ+rFSclfHzEFU3HCteuYLk70N/D5F
         kuOZMCwxxRquoexcgRUyQ5isw2U0uyeoSJR3Pg94aDHimmU4BstsRwjgr5ISIWMzXcQY
         wAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Pt7HIPf0F9QxkP6F/8/Bdx9mVQFA+UxtpYl09Vy0tg=;
        b=Xi9a4dS1eutCB5SV0ruLbLFgxQMun1sclYf1N4WcC1Ugd/M9UTxUcdhUtRr1MwBd3w
         IkeLU0xctd95Ydgzap7qubvprBqJ3itXihpptNz01OTJi0JVXxf56touj9QAEoyRdDqE
         LMLXZfI0Ht3LVI/oVFJrbQ5+oCD7E1mw9cXeVer+fKu2rQ8Rx6dWKVk1NQp4bvI5HVVc
         YIaQsHbiTKZHOpwCAFSklV5HNEWK+2EikmDSKno2hd9ui0unJtErXKAxixNQFEyBL8ne
         Cd5U/b67NfeoH4PC2vLB18QfNbnYN4rpPwGjUtL2KtFNiWv4xDEaal0CxA18ZzD3CdU5
         D+uQ==
X-Gm-Message-State: AOAM532pg794IGT6X9s3N8Lp6yYEa63jbI656dNA+wOPSuBiTl0uKTYi
        +K5yAKNL2PksCJa7rMgq565lnwIMyHlsHp7gHLQ=
X-Google-Smtp-Source: ABdhPJxHLtHjhsMFL06n3bW6OJLlNLS8tukYdzUxFKq7g7XaYHuKFjcTJOSiZTdTBqCVuu3dtM+qJ4J9AV8dfEhDVlE=
X-Received: by 2002:a25:b203:: with SMTP id i3mr35125967ybj.260.1625698538605;
 Wed, 07 Jul 2021 15:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210706172619.579001-1-m@lambda.lt> <CAPhsuW5nyaM5MNg=Q0ojLVQVsnyDrJNukB3WTQ+sk8t4etZiGA@mail.gmail.com>
 <1e96972a-c080-5f11-ab81-3680d594676d@lambda.lt>
In-Reply-To: <1e96972a-c080-5f11-ab81-3680d594676d@lambda.lt>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Jul 2021 15:55:27 -0700
Message-ID: <CAEf4BzYg-75Qofu4OP4OeT6-aO3KQfyTagA7dp4ZANsiMi03hw@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: fix reuse of pinned map on older kernel
To:     Martynas Pumputis <m@lambda.lt>
Cc:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 7, 2021 at 3:36 AM Martynas Pumputis <m@lambda.lt> wrote:
>
>
>
> On 7/7/21 1:32 AM, Song Liu wrote:
> > On Tue, Jul 6, 2021 at 10:24 AM Martynas Pumputis <m@lambda.lt> wrote:
> >>
> >> When loading a BPF program with a pinned map, the loader checks whether
> >> the pinned map can be reused, i.e. their properties match. To derive
> >> such of the pinned map, the loader invokes BPF_OBJ_GET_INFO_BY_FD and
> >> then does the comparison.
> >>
> >> Unfortunately, on < 4.12 kernels the BPF_OBJ_GET_INFO_BY_FD is not
> >> available, so loading the program fails with the following error:
> >>
> >>          libbpf: failed to get map info for map FD 5: Invalid argument
> >>          libbpf: couldn't reuse pinned map at
> >>                  '/sys/fs/bpf/tc/globals/cilium_call_policy': parameter
> >>                  mismatch"
> >>          libbpf: map 'cilium_call_policy': error reusing pinned map
> >>          libbpf: map 'cilium_call_policy': failed to create:
> >>                  Invalid argument(-22)
> >>          libbpf: failed to load object 'bpf_overlay.o'
> >>
> >> To fix this, probe the kernel for BPF_OBJ_GET_INFO_BY_FD support. If it
> >> doesn't support, then fallback to derivation of the map properties via
> >> /proc/$PID/fdinfo/$MAP_FD.
> >>
> >> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> >
> > The code looks good to me. Except a checkpatch CHECK:
> >
> > CHECK: Comparison to NULL could be written "!obj"
> > #96: FILE: tools/lib/bpf/libbpf.c:3943:
> > + if (obj == NULL || kernel_supports(obj, FEAT_OBJ_GET_INFO_BY_FD))
>
> Thanks for the review. I will send v2 with the fix.
>
> >
> > Also, I think this should target bpf-next tree?
>
> Considering that libbpf is supported on older kernels, w/o this patch it
> is impossible to use it on < 4.12 kernels for programs with pinned maps.
> Therefore, I think that this is a fix and thus it should target the bpf
> tree instead.

It does feel like a feature of supporting even older kernels. There
was nothing broken before, libbpf just didn't know how to get
information to validate map info. Now it knows how to do it for older
kernels. So I'd still route it through bpf-next tree.

>
> >
> > Thanks,
> > Song
> >
