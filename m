Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E34839E9BE
	for <lists+bpf@lfdr.de>; Tue,  8 Jun 2021 00:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFGWsH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Jun 2021 18:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhFGWsG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Jun 2021 18:48:06 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B912AC061574
        for <bpf@vger.kernel.org>; Mon,  7 Jun 2021 15:46:01 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id p184so27321791yba.11
        for <bpf@vger.kernel.org>; Mon, 07 Jun 2021 15:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYtNUuoM++ZIbA2Tb17Wyeb5apgZpSWDm0OWtFPJOTs=;
        b=JA1JHl5RViYPYwyDFZVmvufjzenPeomYePJJj9WZpJqmyyNSzuX5lubK7DOjLXXGLx
         ulJ12Ir2nmqZjBGe66osl7cCfqVTvSFQ3th5xBsVnDGDi5LrXUUmQMBIlP1ijAwyzIf/
         fTKdnvw7QJWjohLBcLn23vVCyCoG+Neow0XQUsqMFSC9JlHIsOUDk6PK6dqx7EUAP4HC
         agZ0Oo8rQ8xrm0EwkSv4WX9XdSFYDgB5GXFjtj8/PCdblxUPBKiyf/RGrUlIroQ+JlXg
         qzZdxfDp84iprCCQLDrayUDK0ZeatR/Ptp6ByE7boXb1yxUUrpPUjFLfcbu2vGEl1GBF
         V7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYtNUuoM++ZIbA2Tb17Wyeb5apgZpSWDm0OWtFPJOTs=;
        b=el8tAIqGw4zDKpXXnTuRB5uSlFKguONKGylDb6T9iEnZlHxnS/aR9q2pCjxkL3wp+j
         ju2jPwtFgTFhzbcmvCFlpYXAAnrk510iXj42NptnmfUzW6dHKvlIp+88ujB8Q+c8+/iS
         yfWxTQfQOuLO6ZdKbqMalaMSX/w1Na1Z0GMaL+yGfRJIZ3FejTNJoxFdt8XPqaHmzGE6
         xsP9rKgCWkbuEB5GcMEfNNYxKIzbRrvnUdteYZdHqVYwCcgFKWT5Ia5OlyZtLMp/+Sdr
         4u0c/FFeIwdRxuStlXsXoxk9prnH4CWJftHjSCKpjmxJuTu5trwwP/YmPv1mxtLY4ski
         UkHg==
X-Gm-Message-State: AOAM533x9uEHO1evjQviYlLFbs2R2mDcwazUXOsfuxzAFDunP/9ZCcPf
        psKM1zj4+7IpNcrcvj0GICK6+tvWNTDIvbgqeOow2hiH1jo=
X-Google-Smtp-Source: ABdhPJwWKdR3g4Mqz3CKqWcrLySnI7N6N7eUxefaizYh4X0KtQxPpIfPYRmaVkTetpXY4LHVMZzyoHWJdayR6ZYtm3A=
X-Received: by 2002:a5b:f05:: with SMTP id x5mr27010417ybr.425.1623105958479;
 Mon, 07 Jun 2021 15:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210429054734.53264-1-grantseltzer@gmail.com>
 <877dkkd7gp.fsf@meer.lwn.net> <CAO658oV2vJ0O=D3HWXyCUztsHD5GzDY_5p3jaAicEqqj+2-i+Q@mail.gmail.com>
 <87tunnc0oj.fsf@meer.lwn.net> <CAO658oUMkxR7VO1i3wCYHp7hMC3exP3ccHqeA-2BGnL4bPwfPA@mail.gmail.com>
 <CAEf4BzZJUtPiGn+8mkzNd2k+-3EEE85_xezab3RYy9ZW4zqANQ@mail.gmail.com>
 <CAO658oWPrEDBE8FUBuDUnrBVM91Mgu-svXfXgAXawAUp1MmWZA@mail.gmail.com>
 <CAEf4BzZJDqR7mRSKbOCWfZV-dqwin+PGYxBTTYMVVYwriD33JQ@mail.gmail.com>
 <CAO658oUAg02tN4Gr9r5PJvb93HhN_yj3BzpvC2oVc6oaSn0FUw@mail.gmail.com>
 <CAEf4BzY=JQiHquwoUypU2fD4Xe5rr+DuQA2Xw=n6OXvH7hXbew@mail.gmail.com>
 <CAO658oUH3u8yWV3Ft-96OCrgkzLacv_saecv4e1u4a_X0nF0eg@mail.gmail.com>
 <87wnrd9zp8.fsf@meer.lwn.net> <CAO658oW-_-bOX=xZNjzR=S89rY99gzuwh8Ln9MNtgA4zkwEh+g@mail.gmail.com>
 <875yyx895z.fsf@meer.lwn.net> <CAO658oWwqtZFnhVg3hC8dO=2obOKn5Mp2uqrOYa-3xsNwiRU8Q@mail.gmail.com>
 <CAO658oXRN=JnP+e=qM2-uBu94BxoWCyHcScOgSwxpoHOw5ByLQ@mail.gmail.com>
In-Reply-To: <CAO658oXRN=JnP+e=qM2-uBu94BxoWCyHcScOgSwxpoHOw5ByLQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Jun 2021 15:45:47 -0700
Message-ID: <CAEf4Bzaupx7dvv8nZAQKqo2UbdRmYgCb=54Uy0x5+96UTD6DTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Autogenerating API documentation
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 4, 2021 at 2:19 PM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> On Tue, Jun 1, 2021 at 9:06 PM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
> >
> > On Tue, Jun 1, 2021 at 7:19 PM Jonathan Corbet <corbet@lwn.net> wrote:
> > >
> > > Grant Seltzer Richman <grantseltzer@gmail.com> writes:
> > >
> > > > Andrii cuts releases of libbpf using the github mirror at
> > > > github.com/libbpf/libbpf. There's more context in the README there,
> > > > but most of the major distributions package libbpf from this mirror.
> > > > Since developers that use libbpf in their applications include libbpf
> > > > based on these github releases instead of versions of Linux (i.e. I
> > > > use libbpf 0.4, not libbpf from linux 5.14), it's important to have
> > > > the API documentation be labeled by the github release versions. Is
> > > > there any mechanism in the kernel docs that would allow us to do that?
> > > > Would it make more sense for the libbpf community to maintain their
> > > > own documentation system/website for this purpose?
> > >
> > > It depends on how you want that labeling to look, I guess.  One simple
> > > thing might be to put a DOC: block into the libbpf code that holds the
> > > version number, then use a kernel-doc directive to pull it in in the
> > > appropriate place.  Alternatives might include adding a bit of magic to
> > > Documentation/conf.py to fetch a "#define VERSION# out of the source
> > > somewhere and stash the information away.
> >
> > Gotcha, I will investigate these approaches. Thanks!
>
> After investigating/attempting these approaches, my opinion is that it
> would be better to have a separate libbpf documentation system (sphinx
> configuration files). This way we can maintain separate versions of
> the documentation for each release/version without having duplicate
> pages, and without having to heavily change the kernel docs files to
> fit libbpf specific needs.

So I assume you looked at the DOC: block that Jonathan suggested
above? Can you walk us a bit on how that would look like and why you
think it's not going to work?

>
> If you check out libbpf.readthedocs.io you can see what that would
> look like. I made a test release (v21.21.21) to show how easy this is.
> That is being pulled from my PR at github.com/libbpf/libbpf/pull/260.

It looks pretty nice. Where does v21.21.21 come from, though? It's
also weird that docs are under src/docs, not just under docs/, but I
assume that's a quick hack to demonstrate this?

>
> I'm fine with having this new sphinx configuration in the kernel tree,
> I'm also fine with having it on the github mirror. Both make sense to
> me. Either way the comment docs have to be submitted through the
> mailing list.
>
> One last idea I have is to have the non-api docs (for example, the
> document describing naming convention in libbpf) in the kernel tree,
> and sync it in the github mirror.
>
> Please feel free to ask questions, I've been thinking a lot about
> this! Once we decide on which way to go I can have this up and running
> almost immediately.

To be entirely honest, I'm already a bit lost on all the
possibilities. It would be great if you can summarize what's possible
and how it would look like.

As a general guidance, I think we should try to keep all the
documentation in one place (which means kernel sources, because that's
where API documentation will have to leave). As for config files,
unless they will "stick out" too much, I'd keep them close to the docs
themselves. If not, putting them in Github mirror is fine by me as
well.

Pretty much the only important aspect, from my point of view, is that
docs are versioned according to the libbpf version, not kernel
version. Otherwise huge confusion will ensue for all the users of
libbpf, most of not all of which are using Github mirror.

Does this make sense and is doable?

> > >
> > > If you're wanting to replace the version code that appears at the top of
> > > the left column in the HTML output, though, it's going to be a bit
> > > harder.  I don't doubt we can do it, but it may require messing around
> > > with template files and such.
> > >
> > > Thanks,
> > >
> > > jon
