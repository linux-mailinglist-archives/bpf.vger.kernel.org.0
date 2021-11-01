Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D3B442239
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 22:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhKAVF0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 17:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhKAVF0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 17:05:26 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFEDC061714
        for <bpf@vger.kernel.org>; Mon,  1 Nov 2021 14:02:51 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 131so36261899ybc.7
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7IKfXvFpkKoqpXMaAFF4okrAnw9Aqe+ggPJ4vESijKg=;
        b=RO+Uhd9CL//tS3WZ2hHf6+xYZlkhPQ/cTzAVumJRHqJo/Pvvf2W+WJCwcIAk/4o5zX
         yGLgqAgmxI1xGZWAfLny0fMFvJKteJDFC8ki+twngIlKvizUDcZaoSnIcHQYT24hoaH6
         Few8OMrXYO7MJEKe+R+nXgE/2w8EXhtEQFLqqtzPCFpkWi7TjtRH7HNu0QUIK+ypmp3S
         q2M2ginaiiMvAi5YU9p63ssjZTPw+DczmZMg7Uw6uQRSgPrXpWIx2auupgj28KZso+hT
         3PMuh+pq8kpkNOCbhe4wIEkRbjvX6fRQqdfn21cmKnCiiRLS5lXz53DRMyku8HVBTnl9
         3SHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7IKfXvFpkKoqpXMaAFF4okrAnw9Aqe+ggPJ4vESijKg=;
        b=7yUktz7EdXaAgXAVNbsV0SvbBxFj531EUXXN/9hlfpaM5YZ9N66FbK46qfjwB9tx4t
         uQbPCFRXVzEDJhi2YFMBEUsi9SJq42uWFAUEUt8oS6kKL3IzTvORF+fSXeFncgsNwgiB
         CIwODLZoLNEKPxTIMjl/pWpdwmnrf1YYcTHP3TIyM75gB6pJKqBEUvqd2u9zqDdZ9jjA
         NGguNjPWSZ4uIwurLrBW1/3KAGBRcpKjknSYqp3KXX0c+IxjYcHWSA5zMcD87Vyw5H/h
         K2bTtt2FimdlZmOzV1eUmLaKESujzDPtiEunFYvVpuQ8ezzTmO6OyoMhCdhN3xLQKOns
         L//w==
X-Gm-Message-State: AOAM531jCDG50UzCdOf1vxsGR2WJ95GivAMR9rJ83uB+Pk0erosNJp31
        NKrRlRZibqF/jMJdXFd5i/MX4V1IkS+8G0ZFgGU=
X-Google-Smtp-Source: ABdhPJz5r9dajcmIxUjCSMFaHZZghFy1esvjaK1IDyX80R5ZiYutcknAr/XjIlt+2esYnlSjspXiF7Y1U+Z6hZYvUdg=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr31831169ybj.433.1635800571182;
 Mon, 01 Nov 2021 14:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211030045941.3514948-1-andrii@kernel.org> <20211030045941.3514948-3-andrii@kernel.org>
 <4e19e5e1-e722-5d49-c493-fda2efd3fea1@iogearbox.net>
In-Reply-To: <4e19e5e1-e722-5d49-c493-fda2efd3fea1@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Nov 2021 14:02:40 -0700
Message-ID: <CAEf4Bza8bYm_Su-EDT3wxKgQep=wjYz-+CAQDjUUFRGQ-gEKmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/14] libbpf: add bpf() syscall wrapper into
 public API
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 1, 2021 at 9:00 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 10/30/21 6:59 AM, Andrii Nakryiko wrote:
> > Move internal sys_bpf() helper into bpf.h and expose as public API.
> > __NR_bpf definition logic is also moved. Renamed sys_bpf() into bpf() to
> > follow libbpf naming conventions. Adapt internal uses accordingly.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> [...]
> >
> > +/*
> > + * Kernel headers might be outdated, so define __NR_bpf explicitly, if necessary.
> > + */
> > +#ifndef __NR_bpf
> > +# if defined(__i386__)
> > +#  define __NR_bpf 357
> > +# elif defined(__x86_64__)
> > +#  define __NR_bpf 321
> > +# elif defined(__aarch64__)
> > +#  define __NR_bpf 280
> > +# elif defined(__sparc__)
> > +#  define __NR_bpf 349
> > +# elif defined(__s390__)
> > +#  define __NR_bpf 351
> > +# elif defined(__arc__)
> > +#  define __NR_bpf 280
> > +# else
> > +#  error __NR_bpf not defined. libbpf does not support your arch.
> > +# endif
> > +#endif
>
> Do we still need this nowadays, presumably it's been long enough that system headers do
> have __NR_bpf by now?

No idea, didn't want to risk it, tbh. But I'll just drop the change
for now. I started this patch set by moving more `static inline` stuff
into bpf.h that used sys_bpf(), but ended up going in a different
direction, ultimately. So this patch isn't necessary and I'll drop it.
We can always revisit later.

>
> > +static inline long bpf(enum bpf_cmd cmd, union bpf_attr *attr, unsigned int size)
> > +{
> > +     return syscall(__NR_bpf, cmd, attr, size);
> > +}
> > +
> >   struct bpf_create_map_attr {
> >       const char *name;
> >       enum bpf_map_type map_type;
> >
>
