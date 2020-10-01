Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C491927FEA9
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 13:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbgJALxC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 07:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731767AbgJALxC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 07:53:02 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C618CC0613D0;
        Thu,  1 Oct 2020 04:53:01 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m34so3843721pgl.9;
        Thu, 01 Oct 2020 04:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ew4VpFAID5/91wHSxcOL77yeQtHrkm/V+7lDob87O50=;
        b=Rm8sVxbEC6FnNBaWCS0c/8J0FWn/fO/biBVrxzj0ZxEuhtBeQ72F3kr5eghywKeDsJ
         zt6MOjNPJTG7QxzRCEh3yTBGBdPQEeOWTg/2GxfGCxVUk+/BAFCKiDVQ2U0q/ecMIJkW
         Z6c1RqbK4/PEE7ci2tU+2It6OFH/GXYjDXrV/mqDhVPuC3HCeA5iZ4+VRMdwqmoU9QhG
         g/r8pRkfNgfJrh8jG9WmFrzpYnEXR3jitLarnsv0wZb5gDA8K+Tn59r1vOmm8ymTuOts
         3bGr8I7n8OVTyy8lSrqM667WxT0+JXzWEXoIB2CNlhdu/LPkCSFMupe5KfZym/dvdDzK
         bggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ew4VpFAID5/91wHSxcOL77yeQtHrkm/V+7lDob87O50=;
        b=su2ystPVhd61ZTX3uUp1rZ0Y/zith54+PL/+T+BijPu6ELW+WzrMabT0hmqqX20CxH
         sxnCQh18V5snfRv9Z+5FoD86X4KCtT+AsE1gq4mobWt1t6y/6blz9kXDY6OYNbacs6Qt
         58lucozDWkNe4QLpIN+E4Wf0B6YRbW7yB6U82mrS2UAhvyIQUTpsVq4w/p1MoM/j9teJ
         Rqh/ug1EsavBKpzK3mmZ8ITx8Nb5knuQPPGOpgtJX3OjzUNBHwgUuiQUFOyCXwvkFh6B
         81oHAJZWVPp6hnm0t230L7ajG/9DOtHesLcDX2igOqTTEZplxVorfbfTBeo6DwvimRvN
         O5vA==
X-Gm-Message-State: AOAM532Y4CVyEQSz0k12N/4fXjsly4WCwufd1HOFeLAH8ThOZp+bdSao
        B4L3C785ps3qvtvzZLDSHYWSP9le2hWXrWGaqLU=
X-Google-Smtp-Source: ABdhPJyStB+vgk3YD1yY5mZQmL9Xp3Jb8gyCmADH8SYrhYoKtl75PkiUyvJnXc4nhxlGvoFoI7J+PufgaOmSsyXd0dU=
X-Received: by 2002:aa7:8d4c:0:b029:150:f692:4129 with SMTP id
 s12-20020aa78d4c0000b0290150f6924129mr2315007pfe.11.1601553181129; Thu, 01
 Oct 2020 04:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601478774.git.yifeifz2@illinois.edu> <b16456e8dbc378c41b73c00c56854a3c30580833.1601478774.git.yifeifz2@illinois.edu>
 <202009301432.C862BBC4B@keescook>
In-Reply-To: <202009301432.C862BBC4B@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 1 Oct 2020 06:52:50 -0500
Message-ID: <CABqSeATqYuEAb=i1nxufbVQUWRw6FDbb9x0DYJz87U0RbQj14A@mail.gmail.com>
Subject: Re: [PATCH v3 seccomp 2/5] seccomp/cache: Add "emulator" to check if
 filter is constant allow
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
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

On Wed, Sep 30, 2020 at 5:40 PM Kees Cook <keescook@chromium.org> wrote:
> I don't want this config: there is only 1 caching mechanism happening
> in this series and I do not want to have it buildable as "off": it
> should be available for all supported architectures. When further caching
> methods happen, the config can be introduced then (though I'll likely
> argue it should then be a boot param to allow distro kernels to make it
> selectable).

Alright, we can think about configuration (or boot param) when more
methods happen then.

> The guiding principle with seccomp's designs is to always make things
> _more_ restrictive, never less. While we can never escape the
> consequences of having seccomp_is_const_allow() report the wrong
> answer, we can at least follow the basic principles, hopefully
> minimizing the impact.
>
> When the bitmap starts with "always allowed" and we only flip it towards
> "run full filters", we're only ever making things more restrictive. If
> we instead go from "run full filters" towards "always allowed", we run
> the risk of making things less restrictive. For example: a process that
> maliciously adds a filter that the emulator mistakenly evaluates to
> "always allow" doesn't suddenly cause all the prior filters to stop running.
> (i.e. this isolates the flaw outcome, and doesn't depend on the early
> "do not emulate if we already know we have to run filters" case before
> the emulation call: there is no code path that allows the cache to
> weaken: it can only maintain it being wrong).
>
> Without any seccomp filter installed, all syscalls are "always allowed"
> (from the perspective of the seccomp boundary), so the default of the
> cache needs to be "always allowed".

I cannot follow this. If a 'process that maliciously adds a filter
that the emulator mistakenly evaluates to "always allow" doesn't
suddenly cause all the prior filters to stop running', hence, you
want, by default, the cache to be as transparent as possible. You
would lift the restriction if and only if you are absolutely sure it
does not cause an impact.

In this patch, if there are prior filters, it goes through this logic:

        if (bitmap_prev && !test_bit(nr, bitmap_prev))
            continue;

Hence, if the malicious filter were to happen, and prior filters were
supposed to run, then seccomp_is_const_allow is simply not invoked --
what it returns cannot be used maliciously by an adversary.

>         if (bitmap_prev) {
>                 /* The new filter must be as restrictive as the last. */
>                 bitmap_copy(bitmap, bitmap_prev, bitmap_size);
>         } else {
>                 /* Before any filters, all syscalls are always allowed. */
>                 bitmap_fill(bitmap, bitmap_size);
>         }
>
>         for (nr = 0; nr < bitmap_size; nr++) {
>                 /* No bitmap change: not a cacheable action. */
>                 if (!test_bit(nr, bitmap_prev) ||
>                         continue;
>
>                 /* No bitmap change: continue to always allow. */
>                 if (seccomp_is_const_allow(fprog, &sd))
>                         continue;
>
>                 /* Not a cacheable action: always run filters. */
>                 clear_bit(nr, bitmap);

I'm not strongly against this logic. I just feel unconvinced that this
is any different with a slightly increased complexity.

YiFei Zhu
