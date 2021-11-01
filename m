Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21725442230
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 22:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhKAVDz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 17:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhKAVDy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 17:03:54 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3445C061714
        for <bpf@vger.kernel.org>; Mon,  1 Nov 2021 14:01:19 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id v64so41303827ybi.5
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7i99kDsTOSvgoI820rpzXmpXWP3S/5/EJZ5z+4ATF8=;
        b=cpwBySzhOKVJ6MX8cIHlEXlcQUf35TbTkqD2Iy9rR4JFcs4UCAMf/rqfn/0LCy910F
         7PwuEpX89E4meXBJCIbMqBjHlGfFtELH7x1tsE8w1KyUyyJWkI+KpX8lj5vagFsZakew
         fz50mb5so1lJfmohwdQOv6FnPr0SXdvu6JAvZc7pi/yWBP4yEXOcJ06EkC5qY0bs2BCM
         MHBEj6aSreiTmFIfX2bI9LPecKZ7YJNEL+1fz2A68IGs/vqdt4wVbmefarkcZErRYWpc
         Q45fdkYWFfnBTG9hJlwkCSS0mOt9tDUUWyN4vdoEuSEV6t3iYRqiWpXtj0rVujCRCHlC
         gxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7i99kDsTOSvgoI820rpzXmpXWP3S/5/EJZ5z+4ATF8=;
        b=xyaWqo3D5v4Wc7oE9nsUYOu6FHDmf3LkXZMiUiK8j44VnFYMDrNzQgq2bi1tOCF9cq
         82eG59CBY7pRtGNJ5xhmz6XtoGzcy2zj0X5pPGJMOpOSqLs+qAdwl+i+I7xeUX/4Vi1M
         5YJgW5M+yIayn456pMJ7Nspxa5sZp6NVlAOzMu2lAq9+IxcB0m15rTp+85Q9/3XSctOa
         MuQHWyLKp8Fq8iU1jhUmWXW4TaVek7kt2QvO5gjIOWC5sipwW9Gv7jN1mVxFygqpXsyD
         dYWGK96s0QpZEP0kNSwILPA9efdsKfG+sWzOp3AfGJiv5qIq+0+rr5u4vNoYFyLlMJYA
         YOPA==
X-Gm-Message-State: AOAM531X98SqCPm670r4ab+p5pCU3zV2MkSf98KilNXPvVBWKSDxRbgt
        sQpzYBzlQGraMA7wzEpJftBn18qd+9KXbte9ebA=
X-Google-Smtp-Source: ABdhPJzEwHs2CY+no1nnCLmIJZ491TDOgnaC61106M9jaKz9kyaojrFb00keifVIBuWmpQ75mTrw7c8OATcQueZwpYA=
X-Received: by 2002:a05:6902:1023:: with SMTP id x3mr4096202ybt.267.1635800479202;
 Mon, 01 Nov 2021 14:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211030045941.3514948-1-andrii@kernel.org> <20211030045941.3514948-3-andrii@kernel.org>
 <de592464-480a-ea1f-4702-c275f19f9585@gmail.com>
In-Reply-To: <de592464-480a-ea1f-4702-c275f19f9585@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Nov 2021 14:01:07 -0700
Message-ID: <CAEf4BzbekvyCGroty8CT-b0OX9VKt+CKAc+Tfc70QeR+2c43kA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/14] libbpf: add bpf() syscall wrapper into
 public API
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 1, 2021 at 9:01 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
>
>
> On 2021/10/30 12:59 PM, Andrii Nakryiko wrote:
> > Move internal sys_bpf() helper into bpf.h and expose as public API.
> > __NR_bpf definition logic is also moved. Renamed sys_bpf() into bpf() to
> > follow libbpf naming conventions. Adapt internal uses accordingly.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/bpf.c | 76 ++++++++++++++-------------------------------
> >  tools/lib/bpf/bpf.h | 30 ++++++++++++++++++
> >  2 files changed, 54 insertions(+), 52 deletions(-)
> >
>
> A little confuse about this public API. Shouldn't it be annotated with
> LIBBPF_API attribute and go into libbpf.map ?

It's a `static inline` helper, so it's not in any exported libbpf
symbols, so no LIBBPF_API for that. But as I just replied to Alexei,
I'll just drop this change for now.

>
> BTW, these headers can now be removed from bpf.c:
>
>   #include <stdlib.h>
>   #include <string.h>
>   #include <memory.h>
>   #include <unistd.h>
>   #include <asm/unistd.h>
>   #include <errno.h>
>   #include <linux/bpf.h>
>   #include "libbpf.h"
>
>

[...]

Please trim irrelevant parts of quoted email in your replies.
