Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CF227738C
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 16:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgIXOG2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgIXOG1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 10:06:27 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D35C0613CE
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 07:06:27 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p9so4671610ejf.6
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTKhozomiksQmEwUGZ3qRDCL7Z7QGtyosMbot5Bgjyk=;
        b=fdN4Y3Kn7nTC3mmnwcEAVtvHKFTOVqvEfnnuyMGVG7zBy90zeoG1JAX+VL+L714dQX
         4KrJyZex66L5th/3yiM6GTAyUmHH7cIpCZf6bWWempwGqcsy0petGFjbk8SPWfYl/g6v
         nHTcr0Ht7tS8M141EgEoM2g1XzgVqh+VOUkcZ6nv2IZ7mZuVthmc+1Bo3AFfP4FIx1A9
         ZvzPoDNLA4JlU9mj23VSuTxWEyhzaDiRq3b1OFJbe9n5ugBclzEMAMgvwisDPjxbnCXy
         pMGse6Kh2JIdlYgRWxy8zxQ2lpyxHMdzFg4ook3wHyXs+AlV3e8mCP1SCiPb7ldjVNO4
         BlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTKhozomiksQmEwUGZ3qRDCL7Z7QGtyosMbot5Bgjyk=;
        b=tmyvnoOI4KGSn9agY94IHFNwYfyR2Bv3N32rUzl0fpq6eBuiHRgnvLZtXp/wJCxJ2z
         7bvfCruBNmdxsSOm1EGGK4NbEafI0iWbDW1+KNv6h0Tin8egGQuOWTJ3n5NDl52xf/c1
         tptiYPrAUCKTwo0OOu7f4fvSeOCFLXT85OE0uUlYoOFa9xq41nh5Hi+fYfPipTfUmkk1
         rLxdsnvWE7gjNpIBI/v1Me0wNYdAg6Umwij4+dW4hTpKgZQ4Mm5R+EswFA1KrY7sSGbN
         AOTri3nUnu4RmvZEHqS7lOfmEFVHTdfix+t3Bv27LqO+dfZAnLA8VbgpD8/nDANB6dR1
         W8/g==
X-Gm-Message-State: AOAM530Z7hjovzbM7+Uwj/yb60XnRZODfqa0sjwpN+HCqEfSavEYM1jd
        R7D2DkRJVszCfzBokw6lHB09nq/VUSDTfKzmcIVd2g==
X-Google-Smtp-Source: ABdhPJwwyHaADMpJhLyRUcgsXvG5IwoHzjYXcthXS5FPqRPTRojTWAbOTxrURqPaQIBCU/TwFEcT0uEP/6pO6oOXUGw=
X-Received: by 2002:a17:906:1f94:: with SMTP id t20mr4800ejr.493.1600956385788;
 Thu, 24 Sep 2020 07:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org> <43039bb6-9d9f-b347-fa92-ea34ccc21d3d@rasmusvillemoes.dk>
In-Reply-To: <43039bb6-9d9f-b347-fa92-ea34ccc21d3d@rasmusvillemoes.dk>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 24 Sep 2020 16:05:59 +0200
Message-ID: <CAG48ez3Z5Cxxc47x8gZiy9xgEVPL5gH-g0HNPNqndkAnJCbwKw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] seccomp: Implement constant action bitmaps
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 3:40 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 24/09/2020 01.29, Kees Cook wrote:
> > rfc: https://lore.kernel.org/lkml/20200616074934.1600036-1-keescook@chromium.org/
> > alternative: https://lore.kernel.org/containers/cover.1600661418.git.yifeifz2@illinois.edu/
> > v1:
> > - rebase to for-next/seccomp
> > - finish X86_X32 support for both pinning and bitmaps
> > - replace TLB magic with Jann's emulator
> > - add JSET insn
> >
> > TODO:
> > - add ALU|AND insn
> > - significantly more testing
> >
> > Hi,
> >
> > This is a refresh of my earlier constant action bitmap series. It looks
> > like the RFC was missed on the container list, so I've CCed it now. :)
> > I'd like to work from this series, as it handles the multi-architecture
> > stuff.
>
> So, I agree with Jann's point that the only thing that matters is that
> always-allowed syscalls are indeed allowed fast.
>
> But one thing I'm wondering about and I haven't seen addressed anywhere:
> Why build the bitmap on the kernel side (with all the complexity of
> having to emulate the filter for all syscalls)? Why can't userspace just
> hand the kernel "here's a new filter: the syscalls in this bitmap are
> always allowed noquestionsasked, for the rest, run this bpf". Sure, that
> might require a new syscall or extending seccomp(2) somewhat, but isn't
> that a _lot_ simpler? It would probably also mean that the bpf we do get
> handed is a lot smaller. Userspace might need to pass a couple of
> bitmaps, one for each relevant arch, but you get the overall idea.

It's not really a lot of logic though; and there are a bunch of
different things in userspace that talk to the seccomp() syscall that
would have to be updated if we made this part of the UAPI. libseccomp,
Chrome, Android, OpenSSH, bubblewrap, ... - overall, if we can make
the existing interface faster, it'll be less effort, and there will be
less code duplication (because otherwise every user of seccomp will
have to implement the same thing in userspace).

Doing this internally with the old UAPI also means that we're not
creating any additional commitments in terms of UAPI - if we come up
with something better in the future, we can just rip this stuff out.
If we created a new UAPI, we'd have to stay, in some form, compatible
with it forever.

> I'm also a bit worried about the performance of doing that emulation;
> that's constant extra overhead for, say, launching a docker container.
>
> Regardless of how the kernel's bitmap gets created, something like
>
> +       if (nr < NR_syscalls) {
> +               if (test_bit(nr, bitmaps->allow)) {
> +                       *filter_ret = SECCOMP_RET_ALLOW;
> +                       return true;
> +               }
>
> probably wants some nospec protection somewhere to avoid the irony of
> seccomp() being used actively by bad guys.

Good point...
