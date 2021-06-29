Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893193B7ABB
	for <lists+bpf@lfdr.de>; Wed, 30 Jun 2021 01:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbhF2XoZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 19:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbhF2XoZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 19:44:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8596BC061760
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 16:41:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id l24so481236edr.11
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 16:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GiAEL8RQlGKZ2BTwflqDz9oLqrOg69RXnUkKsnt0IhQ=;
        b=JaiQlo+eI+tPLSWg5G5cVJ4PuJqQmzFx43A1sD93Ip4z+NFzm+hOyqGY29Z2l2oxKO
         I1XhaoX7TYHHRPVC+tpdHXt4PBxADmkb99MkCiYQQL5e2ymwUTyxBq/ZYaQEsfXoD4wz
         /oD+Z8iIQkehPAB3J+09pyVOR+xwY7vZXStxNHWcSqIO8HF3Fdo91NLMQ6/UCkHhABIV
         YJm5LDOTRzb9V7ABk+FY9rpHhl61dwhpl7aVAGfUng2Os9/WwZ/mxOD2zXH5vBr6JNrx
         c0mvWUXhBTHQvvurzLWBe/a7AYxC22II1n/bANL6uf42i2FbdR8iLVRbpqZnWrH/6FXu
         towA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GiAEL8RQlGKZ2BTwflqDz9oLqrOg69RXnUkKsnt0IhQ=;
        b=Y3iV/zUKLxDF66H70SwVefnIjxMMaqAwLNVXMlj7tpihqmzMmoFDHS2YUHf660Xk6c
         CLdgBuEkkBMkEvAidwj/kq1b95MupiWfVeYdzY8Z+Nkj67Y/yVoiL7EXH9ffQBs5UF7q
         OCGnocyFFR4MZ0qiSMTG25Wm4rV+Dwf7eZ6jzufVwaa5MfwgwXVGGuJNAGLkm9upe/P8
         8d3DD6eglIxVRjaA8cHYWXilpTMJut1Gob3/MoDEKW6F81HOLze73Kpv5KmfsOLb9pFN
         d1vCUl0bbsD2KVz8DHDQG6mDnHrc7TMpJHeG8GZ2hs/sgWt52Y6s7432nREBJR/jenkk
         frJg==
X-Gm-Message-State: AOAM531iUrho3Lt1PZmpTusDcjnp6+wOf5HNrzRnppzG4N2S75/zjZ74
        zXnF+WLh/VA8WvUXvtNC1E3DfkSJGR8+WC2r3Bnp
X-Google-Smtp-Source: ABdhPJwQ/gd9GPqFB99hR/6YrU2skzGwUo5FP2tRuuD6vMxdu+L3YFy6u6VR1o88l9wUkV/CNkrsgRS8baGzwFw5+oM=
X-Received: by 2002:a05:6402:1d17:: with SMTP id dg23mr43360894edb.128.1625010114354;
 Tue, 29 Jun 2021 16:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <0b926f59-464d-4b67-8f32-329cf9695cf7@t-8ch.de>
 <CAHC9VhSTb75NEPZRm+Tkngv=SW8ntmSpVCrXMHHHWc2qYNZqCA@mail.gmail.com>
 <696bf938-c9d2-4b18-9f53-b6ff27035a97@t-8ch.de> <CAHC9VhSrki+=724CSQbDdiiMnM8oXTmFP-XFnOmq28c03x1RQQ@mail.gmail.com>
 <efb74f33-6876-48ec-bb9c-87b2247bdedb@t-8ch.de> <CAHC9VhTKOZepgVwpc=rh65-ziMTvSvgtCjP6S9+SQ=YDqg-vsA@mail.gmail.com>
 <60ba7e11-36af-4b24-9132-c5214f32bdad@t-8ch.de>
In-Reply-To: <60ba7e11-36af-4b24-9132-c5214f32bdad@t-8ch.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Jun 2021 19:41:43 -0400
Message-ID: <CAHC9VhSzqfnWUu=L2sW44S1y4TKR1j6=CV5rWRwsnHvZPdfrgA@mail.gmail.com>
Subject: Re: AUDIT_ARCH_ and __NR_syscall constants for seccomp filters
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 29, 2021 at 6:40 AM Thomas Wei=C3=9Fschuh <linux@weissschuh.net=
> wrote:
>
> On Mo, 2021-06-28T18:43-0400, Paul Moore wrote:
> > On Mon, Jun 28, 2021 at 1:58 PM Thomas Wei=C3=9Fschuh <linux@weissschuh=
.net> wrote:
> > >
> > > Hi again!
> >
> > !!! :)
>
> Indeed, hi!

'sup.

> > > On Mo, 2021-06-28T13:34-0400, Paul Moore wrote:
> > > > On Mon, Jun 28, 2021 at 1:13 PM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
> > > > > On Mo, 2021-06-28T12:59-0400, Paul Moore wrote:
> > > > > > On Mon, Jun 28, 2021 at 9:25 AM Thomas Wei=C3=9Fschuh <linux@we=
issschuh.net> wrote:

...

> To get back to my other question:
>
> Is there any chance a single given process can have multiple different AB=
Is
> active at the same time?
> Without using special syscalls to switch between them.
>
> Because if that is not possible I can skip the checks for the arch comple=
tely
> because the filter is constructed at compile time for the specific ABI
> targetted and all funky syscalls are forbidden anyways.

Is it common for a single executing process/executable to use multiple
ABIs?  No, I don't think so, although maybe someone can provide an
example where this happens normally.  However, don't ignore what might
be possible from a malicious userspace. :)

> PS: I know that this seems to be a lot of discussion for fairly little ga=
in in
> this specific case, but I'd like to use seccomp filters in the future mor=
e and
> am trying to find the most unobtrusive way to add them to applications fo=
r each
> given usecase.
> (For any larger applications that will certainly include libseccomp, but =
that
> feels overkill for very specific, zero-runtime-dependency utilities)

One thing to keep in mind is the maintainability of these tools you
are creating.  For example, several years ago there was no such thing
as direct socket syscalls on 32-bit x86, but now they exist alongside
the legacy socketcall() syscall.  Do your custom seccomp filters
handle that properly, for all combinations of kernel and libc?  What
about your older tools that were written back when socketcall() was
the only option?

There is also the issue of x86_64 and x32, but that may be of little
interest to you, and I hear that x32 may be deprecated in the future
(woo hoo!).

Regardless, there are lots of interesting corner cases with seccomp so
I would urge you to do your homework before using custom filters in
critical tools.

Good luck!

--=20
paul moore
www.paul-moore.com
