Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3223A86B6
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 18:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhFOQoY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 12:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOQoX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 12:44:23 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639E8C061574
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 09:42:17 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o21so972216pll.6
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjmSBYtfxAim/t5/8CJowDiF87aQ4TSXLNnw5odfAWk=;
        b=ax7XYDMvUs2ajQojFI1bwToAv84+g2H+RdDQ4pfbCzp3QRf9s3q8HxBrEzHn8qgalJ
         /ccvZrS2nqVkYL33ob8XYK2ydKrm2wuDYpjGi3J41ELf9z1qe7wZr2nVsPUx9qRIIdrR
         soVSs9b08hlSu7Cahh6YDJPMjOfFH0NMsZPwTDlJBobfyonadrXHm9weMXrfI2mK8NsU
         n+VYtyUz+runUlFKPLglUwC6pOu4tR58in9uZuN/ituRZMpjiC+2/6/yudSu1eeL7srb
         g1cEVAqkn/rFHZFYW6KLk3kmWr1+b0/kZy7xVLyZG2JqiVEz2Izo+DQUIxbPBmIfW+wH
         yEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjmSBYtfxAim/t5/8CJowDiF87aQ4TSXLNnw5odfAWk=;
        b=M/wtkZpdKrr/709UmKTYLGWgyRKQXTQOJJAvYZWb8c6RWA/el94swx1f1wbXlOYzQe
         oAy0iD/MMOpBztH2kB9amAQ7AlFDZp4NqLCvGt6HzlTuzhlP1dfrbGRovNNFuFi45f3Q
         FmUvdhWmKhgeH70hX16NXSUig3XKk8cV+qJUW8rvRDS+YGBY9N3EZcbkgE9QVCy05sst
         jJ4bT6u39AqCeNvHM1+rB9LS5In5MVRgRonqyheWwgNCcshO8SSmRjn6IX+TSGPFyb3x
         Z6rGv5nEVepSrFi5ZPTOZjfdjOUSsjEioyGynBnHhgpKwRSXPCjlpoQWi4/nvLg/eowd
         HB/w==
X-Gm-Message-State: AOAM532VRQ+G8yi/q1H3zBntdV3MQFZHsOGE7M9LFpdAU7zwqc9QQ1lQ
        CaHbkY5LyAaUphKLOce+0b4RPXlvHr7ZOf77iccvClyoG6aNbg==
X-Google-Smtp-Source: ABdhPJyE2adWPOmpw5ng9tELFgaqLgCYW9pAbK5qbyJmy6lpEbfZZICKPjMHaSluADndX3PwQ0gDRLqGdhwhMai3EfI=
X-Received: by 2002:a17:90b:3ecb:: with SMTP id rm11mr65686pjb.95.1623775336769;
 Tue, 15 Jun 2021 09:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAGG-pUTpppu-voYuT81LiTMAUA5oAWwnAwYQVAhyPwj3CwnZPA@mail.gmail.com>
 <CAEf4BzZkK9X2RadSYUWV5oh960iwaw3y5EKr7zu8WZ7XnRYz6g@mail.gmail.com>
 <CAHn8xc==x92fXpOM42-FJ_ondhGPdMOrTmgYr3K=w8WvZqXEVQ@mail.gmail.com>
 <CACYkzJ59tvKKxaG9S+QLVbC=4szbFjouDUDaaTCNUytQBT7nSg@mail.gmail.com>
 <CAGG-pUQTTBtqJgMo07bFdJS-nKBZDi9UzSYVQ200tsKP6iuTVQ@mail.gmail.com>
 <CACYkzJ5odOMQzcbfnvJmW52uxs50FY1=kSbADvD4UCF9fh3X5w@mail.gmail.com>
 <CAGG-pURQ4hxQe8w3zdW4y1hBRn1sGikB_5oodid_NHaw_U=9iw@mail.gmail.com> <CACYkzJ5dgxdNJK6vjdfA37PX9zkDpS1QcZgUTdO4ywzkM4-6fQ@mail.gmail.com>
In-Reply-To: <CACYkzJ5dgxdNJK6vjdfA37PX9zkDpS1QcZgUTdO4ywzkM4-6fQ@mail.gmail.com>
From:   "Geyslan G. Bem" <geyslan@gmail.com>
Date:   Tue, 15 Jun 2021 13:40:26 -0300
Message-ID: <CAGG-pURkzDB5na9OpZ5QJFofG7YWm1EYCENs2O988T3QpbhwTA@mail.gmail.com>
Subject: Re: kernel bpf test_progs - vm wrong libc version
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 15 Jun 2021 at 12:58, KP Singh <kpsingh@kernel.org> wrote:
>
> On Tue, Jun 15, 2021 at 4:57 PM Geyslan G. Bem <geyslan@gmail.com> wrote:
> >
> > On Tue, 15 Jun 2021 at 11:33, KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > On Tue, Jun 15, 2021 at 2:34 PM Geyslan G. Bem <geyslan@gmail.com> wrote:
> > > >
> > > > On Tue, 15 Jun 2021 at 06:58, KP Singh <kpsingh@kernel.org> wrote:
> > > > >
> > > > > On Tue, Jun 15, 2021 at 10:06 AM Jussi Maki <joamaki@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 15, 2021 at 8:28 AM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > It seems kind of silly to update our perfectly working image just
> > > > > > > because a new version of glibc was released. Is there any way for you
> > > > > > > to down-grade glibc or build it in some compatibility mode, etc?
> > > > > > > selftests don't really rely on any bleeding-edge features of glibc.
> > > > > >
> > > > > > I've also hit this issue as Ubuntu 21.04 ships with glibc 2.33. I
> > > > > > ended up solving it the hard way by rebuilding the image (I needed few
> > > > > > other tools at the time anyway). Definitely agree it's a bit silly if
> > > > > > we'd need to bump the image every time there's a new glibc version out
> > > > > > there. I did try and see if there's a way to build against newer
> > > > > > glibc, but target older versions and I didn't find a way to do that.
> > > > > > Would statically linking test-progs be an option to avoid this kind of
> > > > > > breakage in the future?
> > > > >
> > > > > I think static linking tests_progs is the only real way one can solve this.
> > > > > Even if we keep updating the image, there will still be users that will hit
> > > > > glibc version issues.
> > > >
> > > > I agree once the image remains static.
> > > >
> > > > >
> > > > > Andrii, Maybe we can have a mode for vmtest.sh can build test_progs
> > > > > statically?
> > > > >
> > > > > maybe something like:
> > > >
> > > > These changes generates the output:
> > > >
> > > >   BINARY   test_maps
> > > > /usr/bin/ld: cannot find -lcap
> > > > collect2: error: ld returned 1 exit status
> > > > make: *** [Makefile:492:
> > > > /home/uzu/code/bpf-next/tools/testing/selftests/bpf/test_maps] Error 1
> > > >
> > > > libcap and acl are installed
> > >
> > > Are you sure you have libcap-dev installed? I don't see this on my system.
> >
> > As Arch packages maintain headers, I suppose libcap has everything.
> >
> > $ yay -F libcap.so
> > core/libcap 2.49-1 [installed: 2.50-2]
> >     usr/lib/libcap.so
> > multilib/lib32-libcap 2.49-1 [installed: 2.50-1]
> >     usr/lib32/libcap.so
> >
> > $ yay -F cap-ng.h
> > core/libcap-ng 0.8.2-1 [installed]
> >     usr/include/cap-ng.h
> >
> > $ ls -l /usr/include/cap*
> > -rw-r--r-- 1 root root 3402 dez  9  2020 /usr/include/cap-ng.h
> >
> > $ ls -l /usr/lib/libcap*
> > lrwxrwxrwx 1 root root    18 dez  9  2020 /usr/lib/libcap-ng.so ->
> > libcap-ng.so.0.0.0
> > lrwxrwxrwx 1 root root    18 dez  9  2020 /usr/lib/libcap-ng.so.0 ->
> > libcap-ng.so.0.0.0
> > -rwxr-xr-x 1 root root 26424 dez  9  2020 /usr/lib/libcap-ng.so.0.0.0
> > lrwxrwxrwx 1 root root    11 jun  7 14:25 /usr/lib/libcap.so -> libcap.so.2
> > lrwxrwxrwx 1 root root    14 jun  7 14:25 /usr/lib/libcap.so.2 -> libcap.so.2.50
> > -rw-r--r-- 1 root root 38704 jun  7 14:25 /usr/lib/libcap.so.2.50
> >
> > https://archlinux.org/packages/core/x86_64/libcap/
> > https://archlinux.org/packages/core/x86_64/libcap-ng/
> >
> > Anything, please contact me. I want to help.
>
> Apologies I missed adding the list in my previous reply.
>
> I think your distribution is missing static libcap
>
> $ dpkg -L libcap-dev
>
> [...]
>
> /usr/lib/x86_64-linux-gnu
> /usr/lib/x86_64-linux-gnu/libcap.a
> /usr/lib/x86_64-linux-gnu/libpsx.a
>
> [...]
>
> It seems like arch does not have them:
>
> https://bbs.archlinux.org/viewtopic.php?id=245303

Indeed.

>
> and they don't plan to either. So you can either build the library locally
> or possibly move to a distribution that provides static linking.

I think this would keep things in different host environments
complicated. I'm more likely to create a proper VM to handle kernel
source and bpf tests, since bpf also demands llvm13 (cutting edge)
which is conflicting with other projects.

>
> [incase we decide to use the static linking for vmtest.sh]

It's still a good decision for environments with readily available
static binaries.

Thanks a million for your attention.

-- 
Regards,

Geyslan G. Bem
