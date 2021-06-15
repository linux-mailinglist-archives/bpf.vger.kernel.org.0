Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B483A85D7
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 17:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhFOQBb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 12:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232286AbhFOQAs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 12:00:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6768061476
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623772723;
        bh=amEblgIPT1NfY1RZGQzuUahXJIDk2dfbV3nBEFhE7/w=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=R5CyU/i+EEDtR/FXBiCfvebJl/IATdDljHeKhQEF/vBqVBhDXfAvVSitX0HRANXVa
         ti4xarIX71/mUPG9kdc6Bxz5+mmPWg0g12bZQioNe45qMd6Yx/TgoaHwvggFu0eYQL
         PgxOMQrmYe0QISCWHUmitfPVwPYnIsMd9dtxHyliGpV075nz+aUOH7dinXQh8pE9+m
         4aYBeutetDuPMcjH4Hg7dfVD9IJb1ctMILeMGXPBVzrD7IqXGRIwfgO2ZDcBxQRTGH
         AD3CXMvlb6XxFFzsU5zaZXre8i4Cpr4iOK82UVUfsOhNPiYmhP0dLZTHwByLwsuswo
         HBoTN2FJP87KQ==
Received: by mail-lf1-f54.google.com with SMTP id r5so27887236lfr.5
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 08:58:43 -0700 (PDT)
X-Gm-Message-State: AOAM533IJLPjv1vsb4i0L9eea6MsuPD66FEfSgApvmPdltAtofYQyWZ5
        3UDEZJ5bPNiFp1Zp7Fzqkx5Qin0sHo2+UeEwBfcWXw==
X-Google-Smtp-Source: ABdhPJy6LjMUXH32Os0U6qRL0T+wcTJANLVivRLfkSFZCyx5prOKf6R6m6+QtJbjxeEJHA0DAPb7UpfU4KYakpWznUE=
X-Received: by 2002:ac2:44bc:: with SMTP id c28mr72767lfm.9.1623772721707;
 Tue, 15 Jun 2021 08:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAGG-pUTpppu-voYuT81LiTMAUA5oAWwnAwYQVAhyPwj3CwnZPA@mail.gmail.com>
 <CAEf4BzZkK9X2RadSYUWV5oh960iwaw3y5EKr7zu8WZ7XnRYz6g@mail.gmail.com>
 <CAHn8xc==x92fXpOM42-FJ_ondhGPdMOrTmgYr3K=w8WvZqXEVQ@mail.gmail.com>
 <CACYkzJ59tvKKxaG9S+QLVbC=4szbFjouDUDaaTCNUytQBT7nSg@mail.gmail.com>
 <CAGG-pUQTTBtqJgMo07bFdJS-nKBZDi9UzSYVQ200tsKP6iuTVQ@mail.gmail.com>
 <CACYkzJ5odOMQzcbfnvJmW52uxs50FY1=kSbADvD4UCF9fh3X5w@mail.gmail.com> <CAGG-pURQ4hxQe8w3zdW4y1hBRn1sGikB_5oodid_NHaw_U=9iw@mail.gmail.com>
In-Reply-To: <CAGG-pURQ4hxQe8w3zdW4y1hBRn1sGikB_5oodid_NHaw_U=9iw@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 15 Jun 2021 17:58:30 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5dgxdNJK6vjdfA37PX9zkDpS1QcZgUTdO4ywzkM4-6fQ@mail.gmail.com>
Message-ID: <CACYkzJ5dgxdNJK6vjdfA37PX9zkDpS1QcZgUTdO4ywzkM4-6fQ@mail.gmail.com>
Subject: Re: kernel bpf test_progs - vm wrong libc version
To:     "Geyslan G. Bem" <geyslan@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 15, 2021 at 4:57 PM Geyslan G. Bem <geyslan@gmail.com> wrote:
>
> On Tue, 15 Jun 2021 at 11:33, KP Singh <kpsingh@kernel.org> wrote:
> >
> > On Tue, Jun 15, 2021 at 2:34 PM Geyslan G. Bem <geyslan@gmail.com> wrote:
> > >
> > > On Tue, 15 Jun 2021 at 06:58, KP Singh <kpsingh@kernel.org> wrote:
> > > >
> > > > On Tue, Jun 15, 2021 at 10:06 AM Jussi Maki <joamaki@gmail.com> wrote:
> > > > >
> > > > > On Tue, Jun 15, 2021 at 8:28 AM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > It seems kind of silly to update our perfectly working image just
> > > > > > because a new version of glibc was released. Is there any way for you
> > > > > > to down-grade glibc or build it in some compatibility mode, etc?
> > > > > > selftests don't really rely on any bleeding-edge features of glibc.
> > > > >
> > > > > I've also hit this issue as Ubuntu 21.04 ships with glibc 2.33. I
> > > > > ended up solving it the hard way by rebuilding the image (I needed few
> > > > > other tools at the time anyway). Definitely agree it's a bit silly if
> > > > > we'd need to bump the image every time there's a new glibc version out
> > > > > there. I did try and see if there's a way to build against newer
> > > > > glibc, but target older versions and I didn't find a way to do that.
> > > > > Would statically linking test-progs be an option to avoid this kind of
> > > > > breakage in the future?
> > > >
> > > > I think static linking tests_progs is the only real way one can solve this.
> > > > Even if we keep updating the image, there will still be users that will hit
> > > > glibc version issues.
> > >
> > > I agree once the image remains static.
> > >
> > > >
> > > > Andrii, Maybe we can have a mode for vmtest.sh can build test_progs
> > > > statically?
> > > >
> > > > maybe something like:
> > >
> > > These changes generates the output:
> > >
> > >   BINARY   test_maps
> > > /usr/bin/ld: cannot find -lcap
> > > collect2: error: ld returned 1 exit status
> > > make: *** [Makefile:492:
> > > /home/uzu/code/bpf-next/tools/testing/selftests/bpf/test_maps] Error 1
> > >
> > > libcap and acl are installed
> >
> > Are you sure you have libcap-dev installed? I don't see this on my system.
>
> As Arch packages maintain headers, I suppose libcap has everything.
>
> $ yay -F libcap.so
> core/libcap 2.49-1 [installed: 2.50-2]
>     usr/lib/libcap.so
> multilib/lib32-libcap 2.49-1 [installed: 2.50-1]
>     usr/lib32/libcap.so
>
> $ yay -F cap-ng.h
> core/libcap-ng 0.8.2-1 [installed]
>     usr/include/cap-ng.h
>
> $ ls -l /usr/include/cap*
> -rw-r--r-- 1 root root 3402 dez  9  2020 /usr/include/cap-ng.h
>
> $ ls -l /usr/lib/libcap*
> lrwxrwxrwx 1 root root    18 dez  9  2020 /usr/lib/libcap-ng.so ->
> libcap-ng.so.0.0.0
> lrwxrwxrwx 1 root root    18 dez  9  2020 /usr/lib/libcap-ng.so.0 ->
> libcap-ng.so.0.0.0
> -rwxr-xr-x 1 root root 26424 dez  9  2020 /usr/lib/libcap-ng.so.0.0.0
> lrwxrwxrwx 1 root root    11 jun  7 14:25 /usr/lib/libcap.so -> libcap.so.2
> lrwxrwxrwx 1 root root    14 jun  7 14:25 /usr/lib/libcap.so.2 -> libcap.so.2.50
> -rw-r--r-- 1 root root 38704 jun  7 14:25 /usr/lib/libcap.so.2.50
>
> https://archlinux.org/packages/core/x86_64/libcap/
> https://archlinux.org/packages/core/x86_64/libcap-ng/
>
> Anything, please contact me. I want to help.

Apologies I missed adding the list in my previous reply.

I think your distribution is missing static libcap

$ dpkg -L libcap-dev

[...]

/usr/lib/x86_64-linux-gnu
/usr/lib/x86_64-linux-gnu/libcap.a
/usr/lib/x86_64-linux-gnu/libpsx.a

[...]

It seems like arch does not have them:

https://bbs.archlinux.org/viewtopic.php?id=245303

and they don't plan to either. So you can either build the library locally
or possibly move to a distribution that provides static linking.

[incase we decide to use the static linking for vmtest.sh]
