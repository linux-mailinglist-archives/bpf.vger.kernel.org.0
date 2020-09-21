Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EC627350A
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 23:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIUVk0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 17:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIUVkZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 17:40:25 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C075DC061755
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 14:40:25 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id g96so11326846ybi.12
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZBbJ09Gzgo8UGzZ5F1DBzPCAWJegWC8aMaVJdMTFeEQ=;
        b=MXDt7Q5zcI7A1cK342pTNKrGM2zoZQsOj5NV9Eaez7/IkgsLhZQLSIW9DJCvYsFhpU
         fq8Xda1EIvOZQBbFrRG/JwzEFtyU6+kfv6XW5Q7zRalP50943Si9fiuyhaK/T8rW7LEM
         SPxSj3PeB5Wl3zrKTtH0JdHoXxzLfIg7ptOBkKrPt9GW5vNVCl+Sr4EDgGoc9WooSAvS
         KrnAixD13ekmDvWZZgrdEZ0FHQWCgrm7zuuU0RnE1iNnH6WEH7TzLNbhZ2ttT7BGQH/y
         a5fkLg9oJdnstd9sUTEplforqN2Hw8PNwRWTuHMQYcBTpah6Bgsku8KMYAz3cfdwV3dE
         lnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZBbJ09Gzgo8UGzZ5F1DBzPCAWJegWC8aMaVJdMTFeEQ=;
        b=YWrEj8sbebK/5NFSdLlO5iLsejaKN5i0SMk9FPBL4AC3754sPG3/WepOVLGHF4GcjO
         uF/vDHRUqWx7J6V5UvHWdUGP/poQ3sKO/qpLheRVr5m5+BUNdY+kzR76qO+ykMgaXidM
         dpwZRcggCaUAZQVNa0vlhuni0Q3qImxdTjul7whW17ilVA2GQGG3KWyUmgw0AzsWxmX6
         R/yAm3ze5cgQ35oGzlvMTqbRINzqSUUPBsIXr4RCvHPr8svUj4RU8PmoWnWIIN/V0DKF
         MUKAV5xpn+ur8qEhzihhxU3t0Mo1iWImQVIXr9gxtsHfj3wYOiy3uc0WTaCbE9nUQ0DO
         0H6A==
X-Gm-Message-State: AOAM533ngbmOfSaYwhUDaXkT/WProE06FNZpL06A4TzQMwgBwb0/k/1r
        xrHUFGYYVmJE/UUzgLRSVxIL+tubzQpbmL6Z8to=
X-Google-Smtp-Source: ABdhPJy3GxVB+GZ1CFAC9o564783fhqm8xh3lzcpsHBH1vE/vSH6QDvoPCVevR8fwzwbZwSo6fFNxyxUQXPHn9+ENDg=
X-Received: by 2002:a25:730a:: with SMTP id o10mr2678364ybc.403.1600724425001;
 Mon, 21 Sep 2020 14:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200920144547.56771-1-xhao@linux.alibaba.com>
 <20200920144547.56771-3-xhao@linux.alibaba.com> <5f68dfdc66b63_1737020879@john-XPS-13-9370.notmuch>
In-Reply-To: <5f68dfdc66b63_1737020879@john-XPS-13-9370.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 21 Sep 2020 14:40:14 -0700
Message-ID: <CAEf4BzaMCUfVWcp0ScSre47TDMtqQd=yoUfb+w0QXWf=_952dQ@mail.gmail.com>
Subject: Re: [bpf-next 2/3] sample/bpf: Add log2 histogram function support
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Xin Hao <xhao@linux.alibaba.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        bpf <bpf@vger.kernel.org>, Wenbo Zhang <ethercflow@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 21, 2020 at 10:18 AM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Xin Hao wrote:
> > The relative functions is copy from bcc tools

you probably meant relevant, not relative?

> > source code: libbpf-tools/trace_helpers.c.
> > URL: https://github.com/iovisor/bcc.git
> >
> > Log2 histogram can display the change of the collected
> > data more conveniently.
> >
> > Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> > ---
> >  samples/bpf/common.h | 67 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644 samples/bpf/common.h
> >
> > diff --git a/samples/bpf/common.h b/samples/bpf/common.h
> > new file mode 100644
> > index 000000000000..ec60fb665544
> > --- /dev/null
> > +++ b/samples/bpf/common.h
> > @@ -0,0 +1,67 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of version 2 of the GNU General Public
> > + * License as published by the Free Software Foundation.
> > + */
> > +
>
> nit, for this patch and the last one we don't need the text. Just the SPDX
> identifier should be enough. Its at least in line with everything we have
> elsewhere.
>
> Also if there is a copyright on that original file we should pull it over
> as far as I understand it. I don't see anything there though so maybe
> not.

Original code is dual-licensed as (LGPL-2.1 OR BSD-2-Clause), probably
leaving a comment with original location and mentioning the original
license would be ok?

I've also CC'ed original author (Wenbo Zhang), just for visibility.

>
> > +#define min(x, y) ({                          \
> > +     typeof(x) _min1 = (x);                   \
> > +     typeof(y) _min2 = (y);                   \
> > +     (void) (&_min1 == &_min2);               \
> > +     _min1 < _min2 ? _min1 : _min2; })
>
> What was wrong with 'min(a,b) ((a) < (b) ? (a) : (b))' looks like
> below its just used for comparing two unsigned ints?
>
> Thanks.
>
> > +

[...]
