Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FD3457F7D
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 17:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbhKTQ1O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Nov 2021 11:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhKTQ1O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Nov 2021 11:27:14 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7142C061574
        for <bpf@vger.kernel.org>; Sat, 20 Nov 2021 08:24:10 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q12so11299340pgh.5
        for <bpf@vger.kernel.org>; Sat, 20 Nov 2021 08:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hVvl0Js0wI5fswO2QLOYNb3hVwkVi5oHoZq46yQ6A+A=;
        b=oofkEBbduFC9D12zGNBeOwESkg9MQj5CK6pX0ZSizdbKRJURuLT5WiW8lBdZ07qzB1
         yrv+QgKPiqG42bpLiICxFeCtlzDufyyo6KYic62I7bJmbB3mQyDSnjKJZ/Pd8bzfUsab
         8nQ05gVltgThsL2E2JajaVZHe7IDkRpZOEGc1HAorbohSmNbls1ylFrGjJ+2BOU1a1XF
         CErEocSjheReCtQeQ5WP0wDgeij/zzp7cZ2tcBTOyEUXS19lsjDdpQdEoGPc5Y+U4Pu7
         eSh5m6jNZM2vtN5AYw8aZaBn2m7QhBKY+vYsVKR8VV4vd+2mu4gSr+6l1NKTX31wAKk6
         +PZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hVvl0Js0wI5fswO2QLOYNb3hVwkVi5oHoZq46yQ6A+A=;
        b=ZqBLYxceO2nj5iDwq6nglpGteOcFRlyzo5HiRl14Nq51SEDga9VADK4DKDz5uFP0xX
         6rNTmwY/2ztJGN2tVy7hltZQ8Zf9b7szjd8R2WbC3bZ7lyIpo4VqlvgwI92WKAVz6OGU
         M3R0w63emCUx8VYAlbGdHsqRACmvPdHNL87rJeWBOiNXr62BMMtA1Pe+ft3eyzQ2ySl7
         5TphXg7zmSU73iinuxaZV8yq0gF+DguKhZnh7dxpwLSqP/2J2J00Zeh/iKiaUhOVrd1t
         eK/VUvpw1SJL3yuZyBwzdCT0BaFK8yApbfxUm9EnTvTs9ygQ2PyPS0tycWjbGK44PUOJ
         CiFg==
X-Gm-Message-State: AOAM530B9ckUtyJ7fRCTMbinGFLd7D+qUTCJqh7rDMlbVgHws0udlP8c
        AaHcpws2heZ176jkS6amqvxblIIwRNhMm6gxNFc=
X-Google-Smtp-Source: ABdhPJz5R9kmsU3FlZQ9juhtLQa7aS6r6Zq2iTUarIEcdHUpZKJ5XtCZAY+idgF7CGHJ7RQxQpyoOwVYgXGbLfCoeZQ=
X-Received: by 2002:a63:a50a:: with SMTP id n10mr16005277pgf.310.1637425450183;
 Sat, 20 Nov 2021 08:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
 <20211120033255.91214-4-alexei.starovoitov@gmail.com> <CAFnufp1ncBbD=K3bJxjzLNCg-VgHeQruJTdVE+9rj+E85+kc9w@mail.gmail.com>
In-Reply-To: <CAFnufp1ncBbD=K3bJxjzLNCg-VgHeQruJTdVE+9rj+E85+kc9w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 20 Nov 2021 08:23:59 -0800
Message-ID: <CAADnVQLA-A2WiEjFUpEMebz_W=4mdzFYX-K0VYG1Ny_2uUyYVg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/13] bpf: Prepare relo_core.c for kernel duty.
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 20, 2021 at 7:27 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> On Sat, Nov 20, 2021 at 4:33 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Make relo_core.c to be compiled for the kernel and for user space libbpf.
> >
> > Note the patch is reducing BPF_CORE_SPEC_MAX_LEN from 64 to 32.
> > This is the maximum number of nested structs and arrays.
> > For example:
> >  struct sample {
> >      int a;
> >      struct {
> >          int b[10];
> >      };
> >  };
> >
> >  struct sample *s = ...;
> >  int y = &s->b[5];
>
> I don't understand this. Is this intentional, or it should be one of:
>
> int y = s->b[5];
> int *y = &s->b[5];

Eagle eye. I copy pasted this typo from libbpf.
Will fix in all places at once either in a respin or in a separate patch.
For the purpose of the example it could be either.
int *y = &s->b[5]; is a relocatable ADD.
int y = s->b[5]; is a relocatable LDX.
