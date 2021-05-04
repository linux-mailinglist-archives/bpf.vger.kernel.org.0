Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BCA372FD5
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 20:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhEDSi3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 14:38:29 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:33091 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhEDSi2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 14:38:28 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4FZT981qdjz23wL;
        Tue,  4 May 2021 14:37:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1620153452; bh=6hZEbCz9pLVG1Juo29+y3XUezTwzfWrbH9RvIsLfcoo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=LquIxEHA/iFAS5hUtC8wK8rXXjzTNILhmxmXsNbWhp/zOwnSlfIDLuUAJRDxn7E8Q
         TkzRiehkjUpwkXiKG6V4xMMQ4ulHB6gy/lS+fGAJZWRYBqTwcSIzofySvcUE8f+rt1
         P1QN4Mn71eW9jBDkBeBTgnPAnnOyjFRyjyRzx4yQ=
Received: by mail-yb1-f177.google.com with SMTP id r8so13471020ybb.9;
        Tue, 04 May 2021 11:37:32 -0700 (PDT)
X-Gm-Message-State: AOAM531qF5cIiYnwvnUhhOkLFDnA19oeR6Yc5kK4NfLO+l/oiFMUhWrZ
        8FZQLm5hKhEPoreBsYr3MuXVQVX4r3Ij+vRKewY=
X-Google-Smtp-Source: ABdhPJzAtel3Wjk4eFZrc/WMEdVxWLfDG8PgEo5dUpee4xL8hswSsjwHJ7QmuV+aRCkJcqQx4KVXGIYAeHMUaO2Go6Y=
X-Received: by 2002:a25:7355:: with SMTP id o82mr37025773ybc.368.1620153451776;
 Tue, 04 May 2021 11:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20210504110519.16097-1-alx.manpages@gmail.com> <CAADnVQLdW=jH1CUP02jokEu3Sh+=xKsCXvjA19kfz7KOn9mzkA@mail.gmail.com>
 <YJFZHW2afbAMVOmE@kroah.com> <69fb22e0-84bd-47fb-35b5-537a7d39c692@gmail.com> <YJFxArfp8wN3ILJb@kroah.com>
In-Reply-To: <YJFxArfp8wN3ILJb@kroah.com>
From:   Zack Weinberg <zackw@panix.com>
Date:   Tue, 4 May 2021 14:37:20 -0400
X-Gmail-Original-Message-ID: <CAKCAbMg_eRCsD-HYmryL8XEuZcaM1Qdfp4XD85QKT6To+h3QcQ@mail.gmail.com>
Message-ID: <CAKCAbMg_eRCsD-HYmryL8XEuZcaM1Qdfp4XD85QKT6To+h3QcQ@mail.gmail.com>
Subject: Re: [RFC v2] bpf.2: Use standard types and attributes
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Joseph Myers <joseph@codesourcery.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 4, 2021 at 12:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, May 04, 2021 at 05:53:29PM +0200, Alejandro Colomar (man-pages) wrote:
> > On 5/4/21 4:24 PM, Greg KH wrote:
> > > I agree, the two are not the same type at all, this change should not be
> > > accepted.
> >
> > I get that in the kernel you don't use the standard fixed-width types (with
> > some exceptions), probably not to mess with code that relies on <stdint.h>
> > not being included (I hope there's not much code that relies on this in
> > 2021, but who knows).
> >
> > But, there is zero difference between these types, from the point of view of
> > the compiler.  There's 100% compatibility between those types, and you're
> > able to mix'n'match them.  See some example below.
...
> There's a very old post from Linus where he describes the difference
> between things like __u32 and uint32_t.  They are not the same, they
> live in different namespaces, and worlds, and can not always be swapped
> out for each other on all arches.
>
> Dig it up if you are curious, but for user/kernel apis you HAVE to use
> the __uNN and can not use uintNN_t variants, so don't try to mix/match
> them, it's good to just follow the kernel standard please.
...
> Nacked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Speaking from the C library's perspective, I'm going to push back
pretty hard on this NAK, for several reasons.

First, this is a proposed change to the manpages, not the headers
themselves.  Manpage documentation of C structs is *not* expected to
match the actual declaration in the headers.  The documented field
type is usually assignment-compatible with the actual type, but not
always.  There's no guarantee whatsoever that the fields are in the
same order as the header, or that the listed set of fields is
complete.

I would say that as long as any value of type __u32 can be stored in a
variable of type uint32_t without data loss, and vice versa, there is
no reason why manpages should *have to* use __u32 in preference to
uint32_t, and that in the absence of such a reason, the standard type
should be used.

Second, it's true that __u32 and uint32_t are in different namespaces,
and it may well be necessary for uapi <linux/*.h> headers to use the
__uNN names in order to preserve the C standard's distinction between
the program and the implementation, but that's *not* a reason for
documentation aimed at writers of user-space programs to use the
__uNN names.  In fact, it is exactly the opposite!  User space program
authors should, all else equal, be *discouraged* from using the __uNN
names, and avoiding their use in manpages is one way to do that.

Third, if there does in fact exist a situation where __uNN and
uintNN_t are *not* assignment compatible, THAT IS A BUG IN THE KERNEL.
Frankly, it would be such a catastrophic bug that I think Linus has to
have been *wrong*.  We would have noticed the problems long ago if he
were right.

I'm going to have to ask you to produce hard evidence for your claim
that __uNN and uintNN_t are not (always) assignment compatible, and
hard evidence why that can't be fixed within the kernel, or else
withdraw your objection.

zw
