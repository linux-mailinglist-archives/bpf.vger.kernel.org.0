Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0463A890B
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFOTCU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 15:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhFOTCU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 15:02:20 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F05C061574
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 12:00:14 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id b13so22028996ybk.4
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVlIIiT0gcQPhT/8hsZq7bVo4RUhbgI39Z9TZQXpcwU=;
        b=kyrW61introFwdiSpD/zgLXv8D7LDPftinjF+4SBBsohBXDOB1Ej1G2r/kpnPQ1xkh
         LTO7FRT1c7jb/nM+SYj8xffpMDeYVi5pLQBx/WbEjf0xGeEkB4yrh41QM1L99tyvOe34
         XoHvbC0BsA52MJdCml/Ayaj4BXXf3zKfPn2GI/B21/D1SpOmj7PdGsLlAZ8mDqX+Kjg2
         btd42cBEri5BPGAZ7wgZYEXoi358MWO6zeFujGVp51xUjsIB2gtTETqxIWYcZ32kcVUU
         cxHQLaLnoRVZwYt0FeDYImbcZw1WAGTL+VkfYcSpA8AeZ8d4dhDUyey5Vs7mP2jTsiF1
         2S4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVlIIiT0gcQPhT/8hsZq7bVo4RUhbgI39Z9TZQXpcwU=;
        b=F4jJvkT+ulIaRpeg3UZ6gPabdNiETYN2q2C552cVU4cGuB63G0GDR8CyU1erjdecA1
         fGIUoiHHUlJlU8jVeZ9yWPYnnFDA7Tayz35Rs9WgqSL//9GBRX01w6dDetR9jZZwWKdy
         i8Whp2JQFk/RDwNQ6UtETNPqDBupEdbfqK1DnZ/sFYlITOXMXF92UzxeNgqU/op6inUp
         7bEc6nRUMTfgDpAeCcd7xogbV4ueygsePybX2XICG8PJZEDCPOrTZqjABZ8TRqHphQN8
         x3D0VC9pDy1k66ImYIb8gb5AY0/nVX6MJlNFpqgg/OJi6sY1ZiA0hfUmOiAH0LXnS3XP
         pDHA==
X-Gm-Message-State: AOAM5318FShWlEkoLC2Film0gYiTHKLosRqoKc6lGd673qNcpKgP4VvL
        u9R4TeWiwwgKJgObjdzGZxIPqwIWjLTwz1MSsu8=
X-Google-Smtp-Source: ABdhPJzJKDn5E+nsUYxzh1oTLqccLlPBj681w3NBKCl9Oh9APUGA7fMuEchRPVybx9ZuCstbI63Kga1JUwiqPp6X5JQ=
X-Received: by 2002:a25:4182:: with SMTP id o124mr828773yba.27.1623783613317;
 Tue, 15 Jun 2021 12:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAGG-pUTpppu-voYuT81LiTMAUA5oAWwnAwYQVAhyPwj3CwnZPA@mail.gmail.com>
 <CAEf4BzZkK9X2RadSYUWV5oh960iwaw3y5EKr7zu8WZ7XnRYz6g@mail.gmail.com>
 <CAHn8xc==x92fXpOM42-FJ_ondhGPdMOrTmgYr3K=w8WvZqXEVQ@mail.gmail.com>
 <CACYkzJ59tvKKxaG9S+QLVbC=4szbFjouDUDaaTCNUytQBT7nSg@mail.gmail.com>
 <CAGG-pUQTTBtqJgMo07bFdJS-nKBZDi9UzSYVQ200tsKP6iuTVQ@mail.gmail.com>
 <CACYkzJ5odOMQzcbfnvJmW52uxs50FY1=kSbADvD4UCF9fh3X5w@mail.gmail.com>
 <CAGG-pURQ4hxQe8w3zdW4y1hBRn1sGikB_5oodid_NHaw_U=9iw@mail.gmail.com>
 <CACYkzJ5dgxdNJK6vjdfA37PX9zkDpS1QcZgUTdO4ywzkM4-6fQ@mail.gmail.com> <CAGG-pURkzDB5na9OpZ5QJFofG7YWm1EYCENs2O988T3QpbhwTA@mail.gmail.com>
In-Reply-To: <CAGG-pURkzDB5na9OpZ5QJFofG7YWm1EYCENs2O988T3QpbhwTA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Jun 2021 12:00:02 -0700
Message-ID: <CAEf4BzbttnVxHccPjeFednpZ24Q4UHzTE96xbpMrFBBrZZXFDg@mail.gmail.com>
Subject: Re: kernel bpf test_progs - vm wrong libc version
To:     "Geyslan G. Bem" <geyslan@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 15, 2021 at 9:42 AM Geyslan G. Bem <geyslan@gmail.com> wrote:
>
> On Tue, 15 Jun 2021 at 12:58, KP Singh <kpsingh@kernel.org> wrote:
> >
> > On Tue, Jun 15, 2021 at 4:57 PM Geyslan G. Bem <geyslan@gmail.com> wrote:
> > >
> > > On Tue, 15 Jun 2021 at 11:33, KP Singh <kpsingh@kernel.org> wrote:
> > > >
> > > > On Tue, Jun 15, 2021 at 2:34 PM Geyslan G. Bem <geyslan@gmail.com> wrote:
> > > > >
> > > > > On Tue, 15 Jun 2021 at 06:58, KP Singh <kpsingh@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, Jun 15, 2021 at 10:06 AM Jussi Maki <joamaki@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jun 15, 2021 at 8:28 AM Andrii Nakryiko
> > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > > It seems kind of silly to update our perfectly working image just
> > > > > > > > because a new version of glibc was released. Is there any way for you
> > > > > > > > to down-grade glibc or build it in some compatibility mode, etc?
> > > > > > > > selftests don't really rely on any bleeding-edge features of glibc.
> > > > > > >
> > > > > > > I've also hit this issue as Ubuntu 21.04 ships with glibc 2.33. I
> > > > > > > ended up solving it the hard way by rebuilding the image (I needed few
> > > > > > > other tools at the time anyway). Definitely agree it's a bit silly if
> > > > > > > we'd need to bump the image every time there's a new glibc version out
> > > > > > > there. I did try and see if there's a way to build against newer
> > > > > > > glibc, but target older versions and I didn't find a way to do that.
> > > > > > > Would statically linking test-progs be an option to avoid this kind of
> > > > > > > breakage in the future?
> > > > > >
> > > > > > I think static linking tests_progs is the only real way one can solve this.
> > > > > > Even if we keep updating the image, there will still be users that will hit
> > > > > > glibc version issues.
> > > > >
> > > > > I agree once the image remains static.
> > > > >
> > > > > >
> > > > > > Andrii, Maybe we can have a mode for vmtest.sh can build test_progs
> > > > > > statically?
> > > > > >
> > > > > > maybe something like:
> > > > >
> > > > > These changes generates the output:
> > > > >
> > > > >   BINARY   test_maps
> > > > > /usr/bin/ld: cannot find -lcap
> > > > > collect2: error: ld returned 1 exit status
> > > > > make: *** [Makefile:492:
> > > > > /home/uzu/code/bpf-next/tools/testing/selftests/bpf/test_maps] Error 1
> > > > >
> > > > > libcap and acl are installed
> > > >
> > > > Are you sure you have libcap-dev installed? I don't see this on my system.
> > >
> > > As Arch packages maintain headers, I suppose libcap has everything.
> > >
> > > $ yay -F libcap.so
> > > core/libcap 2.49-1 [installed: 2.50-2]
> > >     usr/lib/libcap.so
> > > multilib/lib32-libcap 2.49-1 [installed: 2.50-1]
> > >     usr/lib32/libcap.so
> > >
> > > $ yay -F cap-ng.h
> > > core/libcap-ng 0.8.2-1 [installed]
> > >     usr/include/cap-ng.h
> > >
> > > $ ls -l /usr/include/cap*
> > > -rw-r--r-- 1 root root 3402 dez  9  2020 /usr/include/cap-ng.h
> > >
> > > $ ls -l /usr/lib/libcap*
> > > lrwxrwxrwx 1 root root    18 dez  9  2020 /usr/lib/libcap-ng.so ->
> > > libcap-ng.so.0.0.0
> > > lrwxrwxrwx 1 root root    18 dez  9  2020 /usr/lib/libcap-ng.so.0 ->
> > > libcap-ng.so.0.0.0
> > > -rwxr-xr-x 1 root root 26424 dez  9  2020 /usr/lib/libcap-ng.so.0.0.0
> > > lrwxrwxrwx 1 root root    11 jun  7 14:25 /usr/lib/libcap.so -> libcap.so.2
> > > lrwxrwxrwx 1 root root    14 jun  7 14:25 /usr/lib/libcap.so.2 -> libcap.so.2.50
> > > -rw-r--r-- 1 root root 38704 jun  7 14:25 /usr/lib/libcap.so.2.50
> > >
> > > https://archlinux.org/packages/core/x86_64/libcap/
> > > https://archlinux.org/packages/core/x86_64/libcap-ng/
> > >
> > > Anything, please contact me. I want to help.
> >
> > Apologies I missed adding the list in my previous reply.
> >
> > I think your distribution is missing static libcap
> >
> > $ dpkg -L libcap-dev
> >
> > [...]
> >
> > /usr/lib/x86_64-linux-gnu
> > /usr/lib/x86_64-linux-gnu/libcap.a
> > /usr/lib/x86_64-linux-gnu/libpsx.a
> >
> > [...]
> >
> > It seems like arch does not have them:
> >
> > https://bbs.archlinux.org/viewtopic.php?id=245303
>
> Indeed.
>
> >
> > and they don't plan to either. So you can either build the library locally
> > or possibly move to a distribution that provides static linking.
>
> I think this would keep things in different host environments
> complicated. I'm more likely to create a proper VM to handle kernel
> source and bpf tests, since bpf also demands llvm13 (cutting edge)
> which is conflicting with other projects.
>

KP, how do you feel about teaching vmtest.sh to (optionally, if
requested or if we detect that environment clang is too old) checkout
clang and build it before building selftests? So many people would be
grateful for this, I imagine! ;)

> >
> > [incase we decide to use the static linking for vmtest.sh]
>
> It's still a good decision for environments with readily available
> static binaries.

yeah, it's a good option to have at the very least

>
> Thanks a million for your attention.
>
> --
> Regards,
>
> Geyslan G. Bem
