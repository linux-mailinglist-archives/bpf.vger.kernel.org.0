Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D521B31128B
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 21:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhBESuu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 13:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhBEStl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 13:49:41 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0BCC06174A;
        Fri,  5 Feb 2021 12:31:25 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id q9so7038986ilo.1;
        Fri, 05 Feb 2021 12:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=llZvMxl3ggWpC3s9VreNgdoWO96LK0zC9XkR4+niUk4=;
        b=YUpYhEhGYjPp4sgYrRUjxRYzVqfKTwTrnre9rM9HeKjA+43ou1hd+dRUBvzFma7hT2
         wlGy598bKhjGg7rNP2fP4cnPQi18kbKoEZQSUY0gpcELZRVLHNnJd7xgy2qW0wqRyWu8
         0nHqo4cVSJKgZ8TZFW6eTcSjrGK36ui7DwSiw7UJVXetzp2ZjYlLLyfy/sGNHkg91Vk/
         hBwrl5ASsKF5sFRivViTe/EwZAftauYVvej0tSckzBPgk+n/Ll2iCIVGPYmbaQ9xoujZ
         u4HaEDremMFJpwS3uTVYPO7ljvufNG1pHcbinYLkG507YAKq4IfvBVLfNuY43ub8rGDE
         xSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=llZvMxl3ggWpC3s9VreNgdoWO96LK0zC9XkR4+niUk4=;
        b=Q5aVlgeN4m4NlRKx8yYHhMvWxLNCRWznSIL2z4WYUn3Btv7C+/OBM512zP9YxA7slt
         +mRc09Jim2d6fhrM/tju0xadpFxVX+Ulg/UyRAqTfQN/54x9w6cJxvuWJgSMdcrSSJLw
         kzqm/6lcAHqj1O++An5zUE+dqv//clU/wz1UneWVxPVPn51nGWgdP9NngbVXKMuA7Qui
         YxURn4jdmLX88Tj5j+A+dbiuDwy4x9OBKLd936yyLoSXLDTVUAnLp8akXlqJ1FjFkkWJ
         SZanzjM7n6hTa39D+IOqWkSOGNIvyDCny1Z7UaQ2z/b51KBPwiNDT2ZPdEbejQxjrEf0
         LnUg==
X-Gm-Message-State: AOAM533zEkemqkwHfvzbv6gClOPVJTecLZ3uw39v0Vmh/xt6LKEYnTAb
        glrRtNXnsTifhc9ERAD5D1OZRYfYTHHwYRdkzxw=
X-Google-Smtp-Source: ABdhPJxWv0SwvCVq5P+poPayg/twsZ3ZMuJAZdpJv4jSUTItpIgIKQfUPBRM4GRfsIotCe3XcVScWZJEysoBBzj4gtE=
X-Received: by 2002:a05:6e02:d0:: with SMTP id r16mr5395474ilq.112.1612557085349;
 Fri, 05 Feb 2021 12:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
 <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
 <20210205152823.GD920417@kernel.org> <CA+icZUWzMdhuHDkcKMHAd39iMEijk65v2ADcz0=FdODr38sJ4w@mail.gmail.com>
 <CA+icZUXb1j-DrjvFEeeOGuR_pKmD_7_RusxpGQy+Pyhaoa==gA@mail.gmail.com>
 <CA+icZUVZA97V5C3kORqeSiaxRbfGbmzEaxgYf9RUMko4F76=7w@mail.gmail.com>
 <baa7c017-b2cf-b2cd-fbe8-2e021642f2e3@fb.com> <20210205192446.GH920417@kernel.org>
 <cb743ab8-9a66-a311-ed18-ecabf0947440@fb.com>
In-Reply-To: <cb743ab8-9a66-a311-ed18-ecabf0947440@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 5 Feb 2021 21:31:14 +0100
Message-ID: <CA+icZUUcjJASPN8NVgWNp+2h=WO-PT4Su3-yHZpynNHCrHEb-w@mail.gmail.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 5, 2021 at 9:03 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/5/21 11:24 AM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Feb 05, 2021 at 11:10:08AM -0800, Yonghong Song escreveu:
> >> On 2/5/21 11:06 AM, Sedat Dilek wrote:
> >>> On Fri, Feb 5, 2021 at 7:53 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>> Grepping through linux.git/tools I guess some BTF tools/libs need to
> >>> know what BTF_INT_UNSIGNED is?
> >
> >> BTF_INT_UNSIGNED needs kernel support. Maybe to teach pahole to
> >> ignore this for now until kernel infrastructure is ready.
> >
> > Yeah, I thought about doing that.
> >
> >> Not sure whether this information will be useful or not
> >> for BTF. This needs to be discussed separately.
> >
> > Maybe search for the rationale for its introduction in DWARF.
>
> In LLVM, we have:
>    uint8_t BTFEncoding;
>    switch (Encoding) {
>    case dwarf::DW_ATE_boolean:
>      BTFEncoding = BTF::INT_BOOL;
>      break;
>    case dwarf::DW_ATE_signed:
>    case dwarf::DW_ATE_signed_char:
>      BTFEncoding = BTF::INT_SIGNED;
>      break;
>    case dwarf::DW_ATE_unsigned:
>    case dwarf::DW_ATE_unsigned_char:
>      BTFEncoding = 0;
>      break;
>
> I think DW_ATE_unsigned can be ignored in pahole since
> the default encoding = 0. A simple comment is enough.
>

Yonghong Son, do you have a patch/diff for me?
Thanks.

- Sedat -
