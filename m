Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53007278ECF
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 18:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgIYQjb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 12:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgIYQjb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 12:39:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0123AC0613CE;
        Fri, 25 Sep 2020 09:39:31 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k13so3732006pfg.1;
        Fri, 25 Sep 2020 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=We4c1ICLefb45lgkpgey0ZztAECSO/V5IQ3/lYTx0I4=;
        b=NUk6qpse0T5FTgje3rJBQ8NoqKcjBaGi1nGfHxq1QhIPF5SjYlPh3mnQLDGvqCx2q6
         NYgDBzzQqFIPF9c1TJsVpHRF5f4xMNo8b/R00Gy4WNe1xslqvIP+6pLdnLRGAuDU/dF5
         oSVnv/qbSGjBwz2WcdALRvAectNhf/UmU9IwAHkZGSkqmxt34tNT2wRURDE0Dz0SMIL+
         JSHwAradhStfE+oo2ycMnVy+YfyQsqK1B/QqSVA177v7AmiI5cAMeveKTSr3FWxLaXsG
         LSz5zsiSLQX52ziSoCbm1T/Gcv6BFthqkbh6Z3OWA+tTrIMDh5P/eXZErwLuuWSxUvfI
         bH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=We4c1ICLefb45lgkpgey0ZztAECSO/V5IQ3/lYTx0I4=;
        b=PCDPJR+fS5OO4tVATfFAOiwHwOwEqeg/idCStJM+GJJoM5eW1CjK6mmXVbwfrzWBUB
         4qu2M4l9oMoHu6PK9zUtXK69NxqolpRV30VCqWUi663KmKsVqpJhEZ9wGi2mX4mC4M/b
         vjmZ3jDAb+W2+fQ317P1TxzAXaEFIrn81CHHZQCEkMwN8hv3TJKCBCo0XWudZmZyHyt1
         Bh7sdaLKP30i4II66YlQXxxitKOlkdoNMqDXNy+dn04UBoUzf4OTtICoy3ZMB+/GCAXN
         A3aFixgXyuTqasV5dh3oabaQHhR0yMUcJCd+AhJ02pgNbRqzH8fqxXerwYCb9KQM7EaA
         Kd0Q==
X-Gm-Message-State: AOAM530+fNvWPZHIrFoX7sRtZjEVxDbxufGdrd8s3TOlWWaGGmLgIOEb
        YpjROym2GLSeTVtjFcYscUxuHPUbCn9POBPP+R1wPyO20PTdjw==
X-Google-Smtp-Source: ABdhPJw59LuaxUUp30+zgQCKzKm6ocn/Skfo2I74OYhGOoc6OavtsdxUPBqj79tXlm1rgIZZur3Rwdl8twbiU7usz6Q=
X-Received: by 2002:aa7:8d4c:0:b029:150:f692:4129 with SMTP id
 s12-20020aa78d4c0000b0290150f6924129mr114530pfe.11.1601051970465; Fri, 25 Sep
 2020 09:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <b792335294ee5598d0fb42702a49becbce2f925f.1600661419.git.yifeifz2@illinois.edu>
 <202009241658.A062D6AE@keescook> <CABqSeAQ=joheH+0LUZ201U-XwFFsHN3Ouo5FGoscUwn+itkL2w@mail.gmail.com>
 <202009242000.DE12689BD8@keescook> <CABqSeATWoFXM6uBHywVrJCo1JvCwHZ6gyegiJp_y4nr97BY-3Q@mail.gmail.com>
In-Reply-To: <CABqSeATWoFXM6uBHywVrJCo1JvCwHZ6gyegiJp_y4nr97BY-3Q@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Fri, 25 Sep 2020 11:39:18 -0500
Message-ID: <CABqSeARSufFuFf85VFyTXNkfcWOPE5d9H2C-OuYza4WDdk70fw@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 2/6] asm/syscall.h: Add syscall_arches[] array
To:     Kees Cook <keescook@chromium.org>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        Linux Containers <containers@lists.linux-foundation.org>,
        bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 10:28 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> Ah. Makes sense.
>
> > Ironicailly, that's the only place I actually know for sure where people
> > using x32 because it shows measurable (10%) speed-up for builders:
> > https://lore.kernel.org/lkml/CAOesGMgu1i3p7XMZuCEtj63T-ST_jh+BfaHy-K6LhgqNriKHAA@mail.gmail.com
>
> Wow. 10% is significant. Makes you wonder why x32 hasn't conquered the world.
>
> > So, yes, as you and Jann both point out, it wouldn't be terrible to just
> > ignore x32, it seems a shame to penalize it. That said, if the masking
> > step from my v1 is actually noticable on a native workload, then yeah,
> > probably x32 should be ignored. My instinct (not measured) is that it's
> > faster than walking a small array.[citation needed]
>
> You convince me that penalizing supporting x32 would be a pity :( The
> 10% is so nice I want it.

I'm rethinking this -- the majority of our users will not use x32. I
don't think it's that useful for the majority to run all the
simulations and have the memory footprint if only a small minority
will use it.

I also just checked Debian, and it has boot-time disabling of the x32
arch downstream [1]:
CONFIG_X86_X32=y
CONFIG_X86_X32_DISABLED=y

Which means we will still generate all the code for x32 in seccomp
even though people probably won't be using it...

I also talked to some of my peers and they had a point regarding how
x32 limiting address space to 4GiB is very harsh on many modern
language runtimes, so even though it provides a 10% speed boost, its
adoption is hard -- one has to compile all the C libraries in x32 in
addition to x86_64, since one would have programs needing > 4GiB
address space needing x86_64 version of the libraries.

[1] https://wiki.debian.org/X32Port

YiFei Zhu
