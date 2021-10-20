Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38D43564B
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 01:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJTXMv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 19:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTXMu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 19:12:50 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95C6C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 16:10:35 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i84so14707399ybc.12
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 16:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8jPJnEp1bl+Pi4xCFFRCWgTZRA5tN9E/xl8UqU/pTU=;
        b=D33V5weLuz3xa8H5UtPjlNE+fxPuAEZgoLu0n614qIOJRtYs2nNyrMN6QHvViMx757
         xAlqFKGMJmxhg6pxpFr63X7nV04oSKcI+OtP5YvJxPPZVhxlbLYPwHkCYgduasRihAmA
         XeXdBS7gsf+1iu6dMQDrFdnm8GHNqScZvcQRR79Gzwsp9FYK2hX+Cc/zGeUWIk0PhRhC
         OZrqTLriAGc4VciirZCGpJOi2DvpOMDS2wHNEuwqzmEkNkpn4nXBTDhzjjq0M3+SEcJI
         y4bP6pRPQHgWd7i+vcr0zOuGk3sWTr98GvccHpBTcyNZVmfZASroho+wzkQ5mr5HgsUm
         iuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8jPJnEp1bl+Pi4xCFFRCWgTZRA5tN9E/xl8UqU/pTU=;
        b=BE89OwxtKRGbBw+jfy6JzQqYnDDw5PTJ44uPsA93A6ujqjpsXTVGPl1I00GoURCVsZ
         CRr75oyeACPNiZ9vfav5bZuikZlcNSTEauai5WzdLx4knP34MoCVA7R0Zt0FIXTya1f5
         JgnYICqWhZV6+sTCEiMasvw0h6xtfyvy5snMGKYKcBiy4qW/UVpGNGXolx/Ooap6qWTf
         mTLTwOobouqOtZpfiD0AgnK/1J+3sOqKZZabMSHYEFvrrnH6NDUuCg5q5IXKyKGm1wMW
         aKUkIvJnFMyyHx/O7KZO6qOX8aSdzoVyC9dMQN2TPCgExXgTBpvC9sub6FoTOhDxwMqd
         vH9g==
X-Gm-Message-State: AOAM530u1y64u8wTKtBF+u/tgujFOwuXd+zbiUjDQDRU4U8Khr1feqGe
        YMqeHczqVzutkgYzKlp9NufYpStCgSlkKJ6gvMA=
X-Google-Smtp-Source: ABdhPJy6sCNfWQGqK6I/g7L2w+aQbxTz1HHfS/eppw3LtsOopSpqUYke9z3OOVF/ZXjTzUxzl1AuxoiXyIjFl8tX3kY=
X-Received: by 2002:a25:24c1:: with SMTP id k184mr2276309ybk.2.1634771434941;
 Wed, 20 Oct 2021 16:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211013160902.428340-1-iii@linux.ibm.com> <20211013160902.428340-5-iii@linux.ibm.com>
 <CAEf4BzbQcsz8Y1_MVhnyjCaYx-t-MWBD8xykF3x-UHE9a+X8HQ@mail.gmail.com> <9c925536f10105414327ed70e7e50321061c9204.camel@linux.ibm.com>
In-Reply-To: <9c925536f10105414327ed70e7e50321061c9204.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 16:10:23 -0700
Message-ID: <CAEf4Bza9Vq7P8OL7bwSo9xSjHfqX20XMFRnfT7Kvtji6-YQMug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] libbpf: Fix ptr_is_aligned() usages
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 20, 2021 at 4:05 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Wed, 2021-10-20 at 11:44 -0700, Andrii Nakryiko wrote:
> > On Wed, Oct 13, 2021 at 9:09 AM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > Currently ptr_is_aligned() takes size, and not alignment, as a
> > > parameter, which may be overly pessimistic e.g. for __i128 on s390,
> > > which must be only 8-byte aligned. Fix by using btf__align_of()
> > > where
> > > possible - one notable exception is ptr_sz, for which there is no
> > > corresponding type.
> > >
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > >  tools/lib/bpf/btf_dump.c | 12 +++++-------
> > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > > index 25ce60828e8d..da345520892f 100644
> > > --- a/tools/lib/bpf/btf_dump.c
> > > +++ b/tools/lib/bpf/btf_dump.c
> > > @@ -1657,9 +1657,9 @@ static int
> > > btf_dump_base_type_check_zero(struct btf_dump *d,
> > >         return 0;
> > >  }
> > >
> > > -static bool ptr_is_aligned(const void *data, int data_sz)
> > > +static bool ptr_is_aligned(const void *data, int alignment)
> > >  {
> > > -       return ((uintptr_t)data) % data_sz == 0;
> > > +       return ((uintptr_t)data) % alignment == 0;
> >
> > btf__align_of() can return 0 on error and this will be div by 0. I
> > think the better approach would be for ptr_is_aligned to accept
> > struct
> > btf *btf and __u32 type_id, call btf__align_of() based on btf and
> > type
> > id, handle 0 case pessimistically (assume not aligned).
>
> I thought about this, but it won't cover the ptr_sz case. Maybe we
> just need two functions - I'll give it a try tomorrow.
>

Sorry, what's the ptr_sz case? Is this about btf_ptr_sz() helper somehow?
