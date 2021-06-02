Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A628397DE2
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 03:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhFBBIU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 21:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhFBBIU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Jun 2021 21:08:20 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF409C061574
        for <bpf@vger.kernel.org>; Tue,  1 Jun 2021 18:06:36 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id u188so234011vsu.8
        for <bpf@vger.kernel.org>; Tue, 01 Jun 2021 18:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFJPZ3zTtzzQkYxPc63HfzYxojPPgSlWMEUMapnLFZE=;
        b=ErgTfvvm2AgRRaWw/V64IsyVzVVr8yTh0dU/vy7ZO8WFJtHbafZYIuxxqWX1YB3CZm
         hZGXdXO503szqEEWoa5p4L5Zg5SsfAUyqRVCO7qe7Xv460wdZO6o4YEVT+y9kiEdlFil
         Xd/rvg5G0442XpEnhLeU3U/DK/F+aLew6pLJLXU+hY/FX9KsTz94eqwz5MJFc1HoZs9j
         FLJ0l1E2v2Xz/6Sq15Nv6gSTG7r3VWObVtmr4l0ZoyUflxKrzIVCadakibP1UiCXVgSZ
         JK6CHG4AtPfi7PaLfaYnIx/SF5RK55fxXCtJH/PnVcmFWQLRYfo0g746TqTjQ1o0RxUc
         ALqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFJPZ3zTtzzQkYxPc63HfzYxojPPgSlWMEUMapnLFZE=;
        b=iAIksBzRIHjMug5RsYOKEq7eNnE55XbYJzUVvSNp/nioAWX83ujA2i+qtbWDbOSgqZ
         kvgTwYa+JUbBC949YEf26Ifa8F6mTtShpnTiNLaWuVvNpaM+uZYBr478LUHiO3fdxF3c
         J3FrkRwGCvwF0Pa2l+NLS4m6/Cj+SftQ2fHxgXCqTasFnIR1h4IVOtnS+sXplny6vFLi
         wG/KVN5zKrmmp8jP6Y2mIyB3AUAX6cEieKexUbsgVYYSzD0+5aBVJPpmBX9dyc57id0O
         lfMfhIW9/BAsrFda27pC8ZDKkujD48UWhpASy6vVMq4qL3ah6hpCk3qQj5v5KPxe9iEf
         4pEw==
X-Gm-Message-State: AOAM531dFUyZ5t25mDGoFgfEqAyM8Dzj9ifW9fz9ZEIoqDiY2iDvGKYj
        K/UyNGHuOBqfx1lpy3w0hgTlqnPKpcQvCGFE3iD1sj5hDdn7qA==
X-Google-Smtp-Source: ABdhPJx3+GZhTmVbqxp05sYbpMEYuDoFHrkUHruoIBIjRYA7r1SsBvJsYhgaXrBrXRdNhLttu3Pz3QysApfIq1ICPlI=
X-Received: by 2002:a05:6102:c46:: with SMTP id y6mr22918101vss.22.1622595996115;
 Tue, 01 Jun 2021 18:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210429054734.53264-1-grantseltzer@gmail.com>
 <877dkkd7gp.fsf@meer.lwn.net> <CAO658oV2vJ0O=D3HWXyCUztsHD5GzDY_5p3jaAicEqqj+2-i+Q@mail.gmail.com>
 <87tunnc0oj.fsf@meer.lwn.net> <CAO658oUMkxR7VO1i3wCYHp7hMC3exP3ccHqeA-2BGnL4bPwfPA@mail.gmail.com>
 <CAEf4BzZJUtPiGn+8mkzNd2k+-3EEE85_xezab3RYy9ZW4zqANQ@mail.gmail.com>
 <CAO658oWPrEDBE8FUBuDUnrBVM91Mgu-svXfXgAXawAUp1MmWZA@mail.gmail.com>
 <CAEf4BzZJDqR7mRSKbOCWfZV-dqwin+PGYxBTTYMVVYwriD33JQ@mail.gmail.com>
 <CAO658oUAg02tN4Gr9r5PJvb93HhN_yj3BzpvC2oVc6oaSn0FUw@mail.gmail.com>
 <CAEf4BzY=JQiHquwoUypU2fD4Xe5rr+DuQA2Xw=n6OXvH7hXbew@mail.gmail.com>
 <CAO658oUH3u8yWV3Ft-96OCrgkzLacv_saecv4e1u4a_X0nF0eg@mail.gmail.com>
 <87wnrd9zp8.fsf@meer.lwn.net> <CAO658oW-_-bOX=xZNjzR=S89rY99gzuwh8Ln9MNtgA4zkwEh+g@mail.gmail.com>
 <875yyx895z.fsf@meer.lwn.net>
In-Reply-To: <875yyx895z.fsf@meer.lwn.net>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Tue, 1 Jun 2021 21:06:25 -0400
Message-ID: <CAO658oWwqtZFnhVg3hC8dO=2obOKn5Mp2uqrOYa-3xsNwiRU8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Autogenerating API documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 1, 2021 at 7:19 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Grant Seltzer Richman <grantseltzer@gmail.com> writes:
>
> > Andrii cuts releases of libbpf using the github mirror at
> > github.com/libbpf/libbpf. There's more context in the README there,
> > but most of the major distributions package libbpf from this mirror.
> > Since developers that use libbpf in their applications include libbpf
> > based on these github releases instead of versions of Linux (i.e. I
> > use libbpf 0.4, not libbpf from linux 5.14), it's important to have
> > the API documentation be labeled by the github release versions. Is
> > there any mechanism in the kernel docs that would allow us to do that?
> > Would it make more sense for the libbpf community to maintain their
> > own documentation system/website for this purpose?
>
> It depends on how you want that labeling to look, I guess.  One simple
> thing might be to put a DOC: block into the libbpf code that holds the
> version number, then use a kernel-doc directive to pull it in in the
> appropriate place.  Alternatives might include adding a bit of magic to
> Documentation/conf.py to fetch a "#define VERSION# out of the source
> somewhere and stash the information away.

Gotcha, I will investigate these approaches. Thanks!
>
> If you're wanting to replace the version code that appears at the top of
> the left column in the HTML output, though, it's going to be a bit
> harder.  I don't doubt we can do it, but it may require messing around
> with template files and such.
>
> Thanks,
>
> jon
