Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AC927374F
	for <lists+bpf@lfdr.de>; Tue, 22 Sep 2020 02:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgIVA0O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 20:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbgIVA0O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 20:26:14 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3ACC0613CF
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 17:26:14 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a12so14474289eds.13
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 17:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G7Ck98WMie8De6O0pTDamAVkzQynN+XYnigX3qz8tH0=;
        b=k/z93i6OyQSEoXepask26HHwQk3IBf+bJK74Jop2UZRbnG76zfY4uGo4LrMenkM0zm
         vuXXzpu248e8WXJjF+yIbRf1oQSTDH/vH+HbRMObPEnr3axoMbxhiB3SAJgULvCCz79M
         uNljKMUaSbJyXYEa16ZHOYWCpO2wjYahMiL6kgPZqGlfMEGyMHCn1fyT9gqVquT2YY12
         BH5YyBtacnsqwewtapzcJe7jIZiqSkh3jfZWeeRpaGWM08VK1l+8loXjp+N671wTOw2N
         kMIsG4Ab98xHV23Gs1TY1e6EiYdOk4NEHCohbJKjOK2vT5lzDigPQznFKsKNjT39jRiy
         Z7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7Ck98WMie8De6O0pTDamAVkzQynN+XYnigX3qz8tH0=;
        b=doCFLqyAc6oVocYKrWvmrURTz1Nr8uk07OOcTNsPoGrF0Z+c/r6uk7gbXV2QF+Af7Q
         4KhvKVvtMq6q4OmB1Cv0dC5HbhQe2CAe9e6DCFrCUXJb8eYQsg8Q3sM64DrLjtBx2sUJ
         zQrYKGBuD6ChGhr2Pk5+k2wXZbxFCSl71j0psarWHaALLkd/6hzHEOo5tayi/PpbwIAK
         XeUBNoQ6T/ZkH0EV5ogJ19zmDq50YPln/GcIWLgr319p+VRsMDmq+bQHpmVNAk1T6Xzw
         ELJHPSny/LYuHN7S2Sg9R2X7nEHUrLqpeEgntxRNUtmLsB67f9HXaU5Kq6jMmIkw4nst
         U7GA==
X-Gm-Message-State: AOAM531LJRwPYW0zcslTrt847V29v6D2dxdPprb3uIAx+z9CKJFny373
        3L1ilBMMRcm/9XV8+NhVOqRhUcbEDxCXR0IJ43UPbQ==
X-Google-Smtp-Source: ABdhPJyFQ1Gq/sHgfmYT/vq4s/qP10k5TYYWZoaOsilWoxhPoBnktNQHuIjFbeqYafUSymIhlYjKGFwLYz/eJFOUEeY=
X-Received: by 2002:a50:fe98:: with SMTP id d24mr1408695edt.223.1600734372652;
 Mon, 21 Sep 2020 17:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu> <6af89348c08a4820039e614a090d35aa1583acff.1600661419.git.yifeifz2@illinois.edu>
 <CAG48ez0OqZavgm0BkGjCAJUr5UfRgbeCbmLOZFJ=Rj46COcN3Q@mail.gmail.com> <CABqSeAQhVFeG1Frvu60XfUnRQ78YRS2Uaw1EsBobKVku-vVoDQ@mail.gmail.com>
In-Reply-To: <CABqSeAQhVFeG1Frvu60XfUnRQ78YRS2Uaw1EsBobKVku-vVoDQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 22 Sep 2020 02:25:46 +0200
Message-ID: <CAG48ez1YWz9cnp08UZgeieYRhHdqh-ch7aNwc4JRBnGyrmgfMg@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 1/2] seccomp/cache: Add "emulator" to check if
 filter is arg-dependent
To:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Valentin Rothberg <vrothber@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 22, 2020 at 1:44 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> On Mon, Sep 21, 2020 at 12:47 PM Jann Horn <jannh@google.com> wrote:
> > > +       depends on SECCOMP
> > > +       depends on SECCOMP_FILTER
> >
> > SECCOMP_FILTER already depends on SECCOMP, so the "depends on SECCOMP"
> > line is unnecessary.
>
> The reason that this is here is because of the looks in menuconfig.
> SECCOMP is the direct previous entry, so if this depends on SECCOMP
> then the config would be indented. Is this looks not worth keeping or
> is there some better way to do this?

Ah, I didn't realize this.

> > > +       help
> > > +         Seccomp filters can potentially incur large overhead for each
> > > +         system call. This can alleviate some of the overhead.
> > > +
> > > +         If in doubt, select 'none'.
> >
> > This should not be in arch/x86. Other architectures, such as arm64,
> > should also be able to use this without extra work.
>
> In the initial RFC patch I only added to x86. I could add it to any
> arch that has seccomp filters. Though, I'm wondering, why is SECCOMP
> in the arch-specific Kconfigs?

Ugh, yeah, the existing code is already bad... as far as I can tell,
SECCOMP shouldn't be there, and instead the arch-specific Kconfig
should define something like HAVE_ARCH_SECCOMP and then arch/Kconfig
would define SECCOMP and let it depend on HAVE_ARCH_SECCOMP. It's
really gross how the SECCOMP config description has been copypasted
into a dozen different Kconfig files; and looking around a bit, you
can actually see that e.g. s390 has an utterly outdated help text
which still claims that seccomp is controlled via the ancient
"/proc/<pid>/seccomp". I guess this very nicely illustrates why
putting such options into arch-specific Kconfig is a bad idea. :P
