Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895F53ACDA4
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 16:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbhFROhG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 10:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234482AbhFROhG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 10:37:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36A9E6124C
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 14:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624026897;
        bh=N9UDQqZZ0AGkRnj0wbo6vhFy/OzbAwVWle+6q6z2zEE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I6xDCaaTg8JLe/S7puVXIXsQGZnVuZhz/PUd0TSQoia3rMoqkJax3LIqxWIXIbR43
         X2jIWkuVZbwZ1rkrb+y4W/e4nDsoRAkmJRNqkwweTz1pTwCHEwtbWV2lNi57lnZZ0/
         qISI/FCgWlBdAUY7WZ0fK7cSmvAif5n99GGniRLN29n3IRbmqrPyj5UZ86hrWzntLe
         fge4ViHz/E7M7mvtekrgpuI6KOi7OJm92Q0tE/6bNt12nt96jSbG59Va6ZPi4YdMlP
         d1XtNSwpLRedHqltnY+RclwX2jZxov43KdPn/p0bDtmtCoUQH1faomOdqK2L3JbWTK
         YcWoIppGbUsWg==
Received: by mail-lj1-f171.google.com with SMTP id s22so14335436ljg.5
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 07:34:57 -0700 (PDT)
X-Gm-Message-State: AOAM532fLcl4JJaKEqYHUbRHW0rD7LxS+sJ3H69uVZ7l4BhHqkgb5If0
        2POwEoGRYsVMXcGK0IWcEyvYhXv5Ykpa8B6BH7nGaQ==
X-Google-Smtp-Source: ABdhPJxFgzhPdZaJLYyEUz+jtblE+JDPDwN8rpiFfw6lzdJThmS4ki7Jf93lW+ogJw+qXT8dYHPUX70gb4GAo/drQj8=
X-Received: by 2002:a2e:9e8e:: with SMTP id f14mr9686603ljk.468.1624026895574;
 Fri, 18 Jun 2021 07:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAGG-pUTpppu-voYuT81LiTMAUA5oAWwnAwYQVAhyPwj3CwnZPA@mail.gmail.com>
 <CAEf4BzZkK9X2RadSYUWV5oh960iwaw3y5EKr7zu8WZ7XnRYz6g@mail.gmail.com>
 <CAHn8xc==x92fXpOM42-FJ_ondhGPdMOrTmgYr3K=w8WvZqXEVQ@mail.gmail.com>
 <CACYkzJ59tvKKxaG9S+QLVbC=4szbFjouDUDaaTCNUytQBT7nSg@mail.gmail.com>
 <CAGG-pUQTTBtqJgMo07bFdJS-nKBZDi9UzSYVQ200tsKP6iuTVQ@mail.gmail.com>
 <CACYkzJ5odOMQzcbfnvJmW52uxs50FY1=kSbADvD4UCF9fh3X5w@mail.gmail.com>
 <CAGG-pURQ4hxQe8w3zdW4y1hBRn1sGikB_5oodid_NHaw_U=9iw@mail.gmail.com>
 <CACYkzJ5dgxdNJK6vjdfA37PX9zkDpS1QcZgUTdO4ywzkM4-6fQ@mail.gmail.com>
 <CAGG-pURkzDB5na9OpZ5QJFofG7YWm1EYCENs2O988T3QpbhwTA@mail.gmail.com> <CAEf4BzbttnVxHccPjeFednpZ24Q4UHzTE96xbpMrFBBrZZXFDg@mail.gmail.com>
In-Reply-To: <CAEf4BzbttnVxHccPjeFednpZ24Q4UHzTE96xbpMrFBBrZZXFDg@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 18 Jun 2021 16:34:44 +0200
X-Gmail-Original-Message-ID: <CACYkzJ57Eo_A_F-kXo_EEcod6odhv6ACfYpiAqr2AXnr-n8hEA@mail.gmail.com>
Message-ID: <CACYkzJ57Eo_A_F-kXo_EEcod6odhv6ACfYpiAqr2AXnr-n8hEA@mail.gmail.com>
Subject: Re: kernel bpf test_progs - vm wrong libc version
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "Geyslan G. Bem" <geyslan@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 15, 2021 at 9:00 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jun 15, 2021 at 9:42 AM Geyslan G. Bem <geyslan@gmail.com> wrote:
> >
> > On Tue, 15 Jun 2021 at 12:58, KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > On Tue, Jun 15, 2021 at 4:57 PM Geyslan G. Bem <geyslan@gmail.com> wrote:
> > > >
> > > > On Tue, 15 Jun 2021 at 11:33, KP Singh <kpsingh@kernel.org> wrote:
> > > > >
> > > > > On Tue, Jun 15, 2021 at 2:34 PM Geyslan G. Bem <geyslan@gmail.com> wrote:

[...]

> > >
> > > [...]
> > >
> > > It seems like arch does not have them:
> > >
> > > https://bbs.archlinux.org/viewtopic.php?id=245303
> >
> > Indeed.
> >
> > >
> > > and they don't plan to either. So you can either build the library locally
> > > or possibly move to a distribution that provides static linking.
> >
> > I think this would keep things in different host environments
> > complicated. I'm more likely to create a proper VM to handle kernel
> > source and bpf tests, since bpf also demands llvm13 (cutting edge)
> > which is conflicting with other projects.
> >
>
> KP, how do you feel about teaching vmtest.sh to (optionally, if
> requested or if we detect that environment clang is too old) checkout
> clang and build it before building selftests? So many people would be
> grateful for this, I imagine! ;)

I agree, I also want to do it for pahole. It will save a lot of time when a
build error could simply be solved by updating clang and pahole.

>
> > >
> > > [incase we decide to use the static linking for vmtest.sh]
> >
> > It's still a good decision for environments with readily available
> > static binaries.
>
> yeah, it's a good option to have at the very least

Cool, will send a patch for this.

- KP

>
> >
> > Thanks a million for your attention.
> >
> > --
> > Regards,
> >
> > Geyslan G. Bem
