Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1083135B683
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 20:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbhDKSK2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 14:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbhDKSK1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Apr 2021 14:10:27 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC89C06138B;
        Sun, 11 Apr 2021 11:10:10 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id t14so9069518ilu.3;
        Sun, 11 Apr 2021 11:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=JQNvXT9pWRklR4Ey6+A9cehyQgEPTnJS6fNOvtK8e5w=;
        b=j2bdZ8wKstp+ze0/Q5jIvLLa5QS99k2gdHn1nvWQaZwtwxvVrzHgIzksA+Kqar/sPR
         zymqlS65/TkgwJB1sBLsTvL+MOkdtilgEbuJ8CMVlQzw135atekxYIU99ivGb5bmsdyD
         z8taEBp6KP0O4reFy58dZQcyLq7+YtnVa19OoqRbzmEx5Yr73+rwukGqXlXL1Kacsa6x
         t1NYtgPMcN93e9NYu73GhtH5tnPcbacQ1CTGPtax5t+KZ922yOe7r41QotCHXMdPpHyQ
         nclhyXbZF7ctxi4uutre6AK34RZmuR/+1EmhM5ekcPcfe1i6vc8LWDaOEbk5iQxAFGkt
         +wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=JQNvXT9pWRklR4Ey6+A9cehyQgEPTnJS6fNOvtK8e5w=;
        b=i208mEabmeNHeXHeStH1RmxzOrdqwWg4US483popW9DsDz9hHaacCAohFYzvrQwPsB
         FhLYEKDs07Qta28wcoofgXaodYdWv361Txv+iRhgz49el/7bD1re/WYGZJwpv6dSViyw
         1xAMCdcCYvTuuWZ+AiWOHQbRt5lbOeL7qR07Qctc6jlaiaLth4kJxFpKOUuZB2/pRtG3
         /magwoSwWSWzjPx70Tuc+8oQt4oiXfGyiD/2v/BZFmr2yh6F4GF0CRHnXQZjQOnZvnsg
         86ouWfV2BsywEpSibXhZwkuagNa5bMBVqyjqPuJNaAG+lsyKELMA3sLLXMjXWxa6ce6Y
         XtUA==
X-Gm-Message-State: AOAM531RFjUSmBq0yvkgyJ9NiJd+bG/uEoI8z65T3G3JDrKvx9nY1VN2
        Zr/uQK8N9AJLqKKlMe+VbucNgVfCFygprR9mlO2iETNvrhuisQ==
X-Google-Smtp-Source: ABdhPJyElJm6EwnjVStZdK02mg9t/Wk9ks6k3utipZt9i2m3v/NhsulmkamX0wNWP/NaDWMyrWW/PFpQ/MCY03Jeq2k=
X-Received: by 2002:a05:6e02:dea:: with SMTP id m10mr12772025ilj.112.1618164610166;
 Sun, 11 Apr 2021 11:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210401232723.3571287-1-yhs@fb.com> <CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN=UBNdQiO3g@mail.gmail.com>
 <CA+icZUVKCY4UJfSG_sXjZHwfOQZfBZQu0pj1VZ9cXX4e7w0n6g@mail.gmail.com>
 <c6daf068-ead0-810b-2afa-c4d1c8305893@fb.com> <CA+icZUWYQ8wjOYHYrTX52AbEa3nbXco6ZKdqeMwJaZfHuJ5BhA@mail.gmail.com>
 <128db515-14dc-4ff1-eacb-8e48fc1f6ff6@fb.com> <YG23xiRqJLYRtZgQ@kernel.org>
 <08f2eda5-2226-d551-d660-dba981b6ced8@fb.com> <CAK7LNASUkLi4gu-9TY7p7kaLFKtEFA1qA0kc3VtOcgH9xJgsfA@mail.gmail.com>
 <d43d8804-ff30-fa38-b9d0-5dc20df2d795@fb.com>
In-Reply-To: <d43d8804-ff30-fa38-b9d0-5dc20df2d795@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 11 Apr 2021 20:09:34 +0200
Message-ID: <CA+icZUXac=XVvyPDxvKHVpd2FWyTkBNp2zcFizA0DbCmfrDTUw@mail.gmail.com>
Subject: Re: [PATCH kbuild v4] kbuild: add an elfnote for whether vmlinux is
 built with lto
To:     Yonghong Song <yhs@fb.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 11, 2021 at 7:44 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/11/21 5:31 AM, Masahiro Yamada wrote:
> > On Wed, Apr 7, 2021 at 11:49 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 4/7/21 6:46 AM, Arnaldo Carvalho de Melo wrote:
> >>> Em Tue, Apr 06, 2021 at 11:23:27PM -0700, Yonghong Song escreveu:
> >>>> On 4/6/21 8:01 PM, Sedat Dilek wrote:
> >>>>> On Tue, Apr 6, 2021 at 6:13 PM Yonghong Song <yhs@fb.com> wrote:
> >>>>>> Masahiro and Michal,
> >>>
> >>>>>> Friendly ping. Any comments on this patch?
> >>>
> >>>>>> The addition LTO .notes information emitted by kernel is used by pahole
> >>>>>> in the following patch:
> >>>>>>        https://lore.kernel.org/bpf/20210401025825.2254746-1-yhs@fb.com/
> >>>>>>        (dwarf_loader: check .notes section for lto build info)
> >>>
> >>>>> the above pahole patch has this define and comment:
> >>>
> >>>>> -static bool cus__merging_cu(Dwarf *dw)
> >>>>> +/* Match the define in linux:include/linux/elfnote.h */
> >>>>> +#define LINUX_ELFNOTE_BUILD_LTO 0x101
> >>>
> >>>>> ...and does not fit with the define and comment in this kernel patch:
> >>>
> >>>>> +#include <linux/elfnote.h>
> >>>>> +
> >>>>> +#define LINUX_ELFNOTE_LTO_INFO 0x101
> >>>
> >>>> Thanks, Sedat. I am aware of this. I think we can wait in pahole
> >>>> to make a change until the kernel patch is finalized and merged.
> >>>> The kernel patch may still change as we haven't get
> >>>> maintainer's comment. This will avoid unnecessary churn's
> >>>> in pahole side.
> >>>
> >>> So, I tested with clang 12 on fedora rawhide as well on fedora 33, and
> >>> I'm satisfied with the current state to release v1.21, Masahiro, have
> >>> you had the time to look at this?
> >>>
> >>> Yonghong, as we have a fallback in case the ELF note isn't available, I
> >>> think we're safe even if the notes patch merge gets delayed, right?
> >>
> >> Right. That is why I separated the notes patch from other patches.
> >> We can revisit it once the kernel patch is settled.
> >>
> >>>
> >>> - Arnaldo
> >>>
> >
> >
> > Applied to linux-kbuild. Thanks.
>
> Thanks!
>

Great to see this applied.
Thanks.

- Sedat -
