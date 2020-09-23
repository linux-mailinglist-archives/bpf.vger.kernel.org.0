Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A01727504F
	for <lists+bpf@lfdr.de>; Wed, 23 Sep 2020 07:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgIWFc4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 01:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgIWFc4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 01:32:56 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B544C061755
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2020 22:32:56 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id u25so17870145otq.6
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2020 22:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z7tJIdLl+ZwLgRYJG8yyy4oM8lPOSuBtWo8H0z2kGD0=;
        b=QEmI1kWuw7ombCyBkxi0mCVfVApGu5HUBaJiXcArZ/YbBjHMJGTE3gFnO2eG0RbE1R
         E6HZGzjWhEfAtJBmGAu66gX9V62EcDkgN4WUaDWm3Mb45q8e1LRZMMNLqb8qOnkUWZOe
         pM29nA4RhzNYfR/nkpR83j44gnQM8l/BEPv4oEgx/UiKziPgb4rWrNd3d8wAgrfASPlO
         R1uURMLm7SN6NUz+bjcsnU/q2SD5LS3wvIZcGiBruPy6mwW/Z+91cNASL4DVuC5koYHN
         fv3oMPGNNlmERuTVAfVG0XtyfiPAlEpiG3H+nHhkU5z7Ae3VKb8boAl96Js3qS3wnaFE
         HCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z7tJIdLl+ZwLgRYJG8yyy4oM8lPOSuBtWo8H0z2kGD0=;
        b=cSKJsaQ4FaSnd2iyVuiRdUCalJHHDKZHHztUemW+DGP6kleYd+Srp/OhEsT23iujQ4
         S7OqK0ESdokN/7N0octSvGLhBvKJBjNlEGLlei7WyuxPbKKzWJV24WdbQrEtJjulDxLy
         Z2iboRpiKsFQtbYVRjvPqzjt1nab4VWx/QN8+o47gO925WffTC7Iuj7uWUQBE/KSppoN
         GUd11RHla86V1tX+38LijHYOzW9bsveIUQ1PrLzUTeTFZQA1pXlZjnPEKdQduaSpaaC1
         NtzfWX7IsDJ4p2iWTQ276xBMo2FsBdkMXM3dzlw4suceeY0wU5lGUY/d4yyn5D1cfXse
         RS5g==
X-Gm-Message-State: AOAM5312rgJXdxHm5RS0BMYSlysjyBp2lhlrrVJsq8kg0XxldR//MMDc
        sUIiWn95Q+p3U3V0TZimlWMWINa6GwpJm1eEtUE=
X-Google-Smtp-Source: ABdhPJw+90f8zJj7bjTBNaxVNYDpM7XSH+3HUB4ZKxP6uX9tRuW91eMrYQfoqK+TOEVcYVJWEsCkp1JM5Vm9rgnAI44=
X-Received: by 2002:a05:6830:14d9:: with SMTP id t25mr5361113otq.188.1600839175535;
 Tue, 22 Sep 2020 22:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200920144547.56771-1-xhao@linux.alibaba.com>
 <20200920144547.56771-3-xhao@linux.alibaba.com> <5f68dfdc66b63_1737020879@john-XPS-13-9370.notmuch>
 <CAEf4BzaMCUfVWcp0ScSre47TDMtqQd=yoUfb+w0QXWf=_952dQ@mail.gmail.com> <275b1dbc-938e-626f-fc6c-5bbb6f76c270@linux.alibaba.com>
In-Reply-To: <275b1dbc-938e-626f-fc6c-5bbb6f76c270@linux.alibaba.com>
From:   Wenbo Zhang <ethercflow@gmail.com>
Date:   Wed, 23 Sep 2020 13:32:46 +0800
Message-ID: <CABtjQmbYoig=7PRT21O=GdKMLRg=MeVrzX2dzndv7C47LVNx2Q@mail.gmail.com>
Subject: Re: [bpf-next 2/3] sample/bpf: Add log2 histogram function support
To:     xhao@linux.alibaba.com
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>>
>> Also if there is a copyright on that original file we should pull it ove=
r
>> as far as I understand it. I don't see anything there though so maybe
>> not.
> There no copyright, it follow dual-licensed as (LGPL-2.1 OR BSD-2-Clause)
>
> Original code is dual-licensed as (LGPL-2.1 OR BSD-2-Clause), probably
> leaving a comment with original location and mentioning the original
> license would be ok?
> Ok, thanks
>
> I've also CC'ed original author (Wenbo Zhang), just for visibility.
> Thanks

Or you can add Copyright (c) 2020 Wenbo Zhang for fewer chars , either
way, thanks. :)


On Tue, Sep 22, 2020 at 10:06 AM Xin Hao <xhao@linux.alibaba.com> wrote:
>
>
> =E5=9C=A8 2020/9/22 =E4=B8=8A=E5=8D=885:40, Andrii Nakryiko =E5=86=99=E9=
=81=93:
> > On Mon, Sep 21, 2020 at 10:18 AM John Fastabend
> > <john.fastabend@gmail.com> wrote:
> >> Xin Hao wrote:
> >>> The relative functions is copy from bcc tools
> > you probably meant relevant, not relative?
> Yes
> >
> >>> source code: libbpf-tools/trace_helpers.c.
> >>> URL: https://github.com/iovisor/bcc.git
> >>>
> >>> Log2 histogram can display the change of the collected
> >>> data more conveniently.
> >>>
> >>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> >>> ---
> >>>   samples/bpf/common.h | 67 +++++++++++++++++++++++++++++++++++++++++=
+++
> >>>   1 file changed, 67 insertions(+)
> >>>   create mode 100644 samples/bpf/common.h
> >>>
> >>> diff --git a/samples/bpf/common.h b/samples/bpf/common.h
> >>> new file mode 100644
> >>> index 000000000000..ec60fb665544
> >>> --- /dev/null
> >>> +++ b/samples/bpf/common.h
> >>> @@ -0,0 +1,67 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or
> >>> + * modify it under the terms of version 2 of the GNU General Public
> >>> + * License as published by the Free Software Foundation.
> >>> + */
> >>> +
> >> nit, for this patch and the last one we don't need the text. Just the =
SPDX
> >> identifier should be enough. Its at least in line with everything we h=
ave
> >> elsewhere.
> Thanks, i will change it.
> >>
> >> Also if there is a copyright on that original file we should pull it o=
ver
> >> as far as I understand it. I don't see anything there though so maybe
> >> not.
> > There no copyright, it follow dual-licensed as (LGPL-2.1 OR BSD-2-Claus=
e)
> >
> > Original code is dual-licensed as (LGPL-2.1 OR BSD-2-Clause), probably
> > leaving a comment with original location and mentioning the original
> > license would be ok?
> Ok, thanks
> >
> > I've also CC'ed original author (Wenbo Zhang), just for visibility.
> Thanks
> >
> >>> +#define min(x, y) ({                          \
> >>> +     typeof(x) _min1 =3D (x);                   \
> >>> +     typeof(y) _min2 =3D (y);                   \
> >>> +     (void) (&_min1 =3D=3D &_min2);               \
> >>> +     _min1 < _min2 ? _min1 : _min2; })
> >> What was wrong with 'min(a,b) ((a) < (b) ? (a) : (b))' looks like
> >> below its just used for comparing two unsigned ints?
> >>
> >> Thanks.
>   I do not chang any codes, That's what the original code looks like
>
> >>
> >>> +
> > [...]
>
> --
> Best Regards!
> Xin Hao
>
