Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5000C39C23A
	for <lists+bpf@lfdr.de>; Fri,  4 Jun 2021 23:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhFDVVD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Jun 2021 17:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFDVVD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Jun 2021 17:21:03 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E994C061766
        for <bpf@vger.kernel.org>; Fri,  4 Jun 2021 14:19:05 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id w28so6035792uae.4
        for <bpf@vger.kernel.org>; Fri, 04 Jun 2021 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6TxKeHwVqfQSLI4TPZlB5IuqeTui533BK23YX8yl/o=;
        b=Twd/g2XvgRISWF6HMjmbBYcRs/1HkbGXcswAJznHo7iMsn/HdLnpEii3AOzag9udv1
         MuzxX4qJSB3NrMk1yDQMo8huthPyMt9jrPLUmknKt4sFsa/Rj4M6n2ZgHBAoMIr78Iin
         jdKNvzRYxVoOidPmJtPRUralfSmcXztAvP+7BeIoEnk9BCqlbaIA+eokR6bhiyNLYwwV
         D22kWbxMz7QkwBIsIMMrxsPiLH229Dkl0h1cxYFkRokbYcCfrYTAEJg/WnHc6hlgPx9h
         n8HQakeKbNIBRrU104OcvsXwqwr0IwZrDNqn0TbgZMSJS9PWmd/we7yh+O7gCf1qU7ir
         YFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6TxKeHwVqfQSLI4TPZlB5IuqeTui533BK23YX8yl/o=;
        b=S/vIaXTpp5rkbR1mXEzqQ8yNI304YZN2tUQZMKo81gbSPoTSDbtCnT0rRVJn6yMxr1
         hKOJgWBdU4tAeY8CLbxM7ldG/4EsG7oPdk7gNPe6TaHe/SGbXg6CpPVhmGiETVUyBRau
         7/VLN9IspJYLK8GVaPHwib3OpffNiDx7gokL+cDlKbh8k9OMkgIYkegzo+bn1P0c0CTx
         lzCmKdPaHGYlawm/xVSBnQPCS6HNhSJjIefJEb3aXeHzv1fuv3/557OElHuqPixi1flY
         i8GnDn8XWvdGtcMTJ20QFpd3WysQ94ipzfZQZ+xa7G1wDE0nxxH8TITfAnLM3sm80KtW
         qRGw==
X-Gm-Message-State: AOAM530gEj8EK1tSaLxQEZCrHH8RX5FW03j3WTlIUe095LmNXIu+xr2M
        tdaQ4IjKLPOS3gg6LbOKULCtU2K5bXcqA6SA5zz5b73A2wIT2g==
X-Google-Smtp-Source: ABdhPJyLAQ3KPcnxzz9K1vwH8VtaPkaMf3L1ZRAXtutummNpRPfkaDwYFJ1OSYslvJc2W0CdCJDlda7A9jPJQEdRpuA=
X-Received: by 2002:ab0:5961:: with SMTP id o30mr5135057uad.127.1622841544223;
 Fri, 04 Jun 2021 14:19:04 -0700 (PDT)
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
In-Reply-To: <CAO658oWwqtZFnhVg3hC8dO=2obOKn5Mp2uqrOYa-3xsNwiRU8Q@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Fri, 4 Jun 2021 17:18:53 -0400
Message-ID: <CAO658oXRN=JnP+e=qM2-uBu94BxoWCyHcScOgSwxpoHOw5ByLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Autogenerating API documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 1, 2021 at 9:06 PM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> On Tue, Jun 1, 2021 at 7:19 PM Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > Grant Seltzer Richman <grantseltzer@gmail.com> writes:
> >
> > > Andrii cuts releases of libbpf using the github mirror at
> > > github.com/libbpf/libbpf. There's more context in the README there,
> > > but most of the major distributions package libbpf from this mirror.
> > > Since developers that use libbpf in their applications include libbpf
> > > based on these github releases instead of versions of Linux (i.e. I
> > > use libbpf 0.4, not libbpf from linux 5.14), it's important to have
> > > the API documentation be labeled by the github release versions. Is
> > > there any mechanism in the kernel docs that would allow us to do that?
> > > Would it make more sense for the libbpf community to maintain their
> > > own documentation system/website for this purpose?
> >
> > It depends on how you want that labeling to look, I guess.  One simple
> > thing might be to put a DOC: block into the libbpf code that holds the
> > version number, then use a kernel-doc directive to pull it in in the
> > appropriate place.  Alternatives might include adding a bit of magic to
> > Documentation/conf.py to fetch a "#define VERSION# out of the source
> > somewhere and stash the information away.
>
> Gotcha, I will investigate these approaches. Thanks!

After investigating/attempting these approaches, my opinion is that it
would be better to have a separate libbpf documentation system (sphinx
configuration files). This way we can maintain separate versions of
the documentation for each release/version without having duplicate
pages, and without having to heavily change the kernel docs files to
fit libbpf specific needs.

If you check out libbpf.readthedocs.io you can see what that would
look like. I made a test release (v21.21.21) to show how easy this is.
That is being pulled from my PR at github.com/libbpf/libbpf/pull/260.

I'm fine with having this new sphinx configuration in the kernel tree,
I'm also fine with having it on the github mirror. Both make sense to
me. Either way the comment docs have to be submitted through the
mailing list.

One last idea I have is to have the non-api docs (for example, the
document describing naming convention in libbpf) in the kernel tree,
and sync it in the github mirror.

Please feel free to ask questions, I've been thinking a lot about
this! Once we decide on which way to go I can have this up and running
almost immediately.
> >
> > If you're wanting to replace the version code that appears at the top of
> > the left column in the HTML output, though, it's going to be a bit
> > harder.  I don't doubt we can do it, but it may require messing around
> > with template files and such.
> >
> > Thanks,
> >
> > jon
