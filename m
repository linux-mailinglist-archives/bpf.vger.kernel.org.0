Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB4037316E
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 22:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhEDUed (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 16:34:33 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:19167 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbhEDUec (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 16:34:32 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4FZWl4551Wz2DPg;
        Tue,  4 May 2021 16:33:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1620160416; bh=lTZ/lVLMWtbFhPZP+g/je+yhXr5csjuHDqGr9x80lZQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=TOYQrncra9Gnai/6or0hMCaDdLiTTZVrchRI7b7/0OP3QLRNckNBLOC3mqGk0yVh/
         fpBjmeXlvO8qwocHeviveyO0X52e7YyDj5z9Saytbxb0iXUtSnIsglEKlHB/SfmvD2
         Q0TDnF3fYi+GLQJWEYF2jfBuZacxObVTCVfb48T4=
Received: by mail-yb1-f181.google.com with SMTP id l7so13911287ybf.8;
        Tue, 04 May 2021 13:33:36 -0700 (PDT)
X-Gm-Message-State: AOAM5314o5b7T4GIHMHAPqZt29cR/wAl+051MXHAcdVN27ElILw8C4cu
        8C5ssabZeZ83ypErofFeIpj3oMDKdCqbFCPKXbQ=
X-Google-Smtp-Source: ABdhPJzSu8AkpmhEIsw2NZgdeS4gQHrnZSlUQHP1cTKF3tAM8qwY6+MVc74w6j2O70No9S/0WKrHfYU44V3uQtTuV70=
X-Received: by 2002:a25:348f:: with SMTP id b137mr37826198yba.248.1620160416247;
 Tue, 04 May 2021 13:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20210504110519.16097-1-alx.manpages@gmail.com> <CAADnVQLdW=jH1CUP02jokEu3Sh+=xKsCXvjA19kfz7KOn9mzkA@mail.gmail.com>
 <YJFZHW2afbAMVOmE@kroah.com> <69fb22e0-84bd-47fb-35b5-537a7d39c692@gmail.com>
 <YJFxArfp8wN3ILJb@kroah.com> <CAKCAbMg_eRCsD-HYmryL8XEuZcaM1Qdfp4XD85QKT6To+h3QcQ@mail.gmail.com>
 <6740a229-842e-b368-86eb-defc786b3658@gmail.com> <8a184afe-14b7-ed15-eb6a-960ea05251d1@iogearbox.net>
In-Reply-To: <8a184afe-14b7-ed15-eb6a-960ea05251d1@iogearbox.net>
From:   Zack Weinberg <zackw@panix.com>
Date:   Tue, 4 May 2021 16:33:24 -0400
X-Gmail-Original-Message-ID: <CAKCAbMidJ=UhsMumDcwiqvkGEG5SROPnv=OA379w_=0dZk5W5g@mail.gmail.com>
Message-ID: <CAKCAbMidJ=UhsMumDcwiqvkGEG5SROPnv=OA379w_=0dZk5W5g@mail.gmail.com>
Subject: Re: [RFC v2] bpf.2: Use standard types and attributes
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>,
        David Laight <David.Laight@aculab.com>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 4, 2021 at 4:06 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > I'm trying to clarify the manual pages as much as possible, by using standard conventions and similar structure all around the pages.  Not everyone understands kernel conventions.  Basically, Zack said very much what I had in mind with this patch.
>
> But then are you also converting, for example, __{le,be}{16,32,64} to plain
> uint{16,32,64}_t in the man pages and thus removing contextual information
> (or inventing new equivalent types)?
>
> What about other types exposed to user space like __sum16, __wsum, or __poll_t
> when they are part of a man page, etc?

Fields that are specifically in some endianness that isn't
(necessarily) the CPU's _should_ be documented as such in the manpage,
but I dunno if __{le,be}{16,32,64} as a type name is the ideal way to
do it.  There is no off-the-shelf notation for this as far as I know.

I do not know what __sum16, __wsum, and __poll_t are used for, but I
want to remind everyone again that the kernel's concerns are not
necessarily user space's concerns and the information that should
appear in the manpages is the information that is most relevant to
user space programmers.

zw
