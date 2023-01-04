Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC8765DF5D
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 22:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbjADVzx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 16:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbjADVzs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 16:55:48 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100F1E3FD
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 13:55:46 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i15so50593126edf.2
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 13:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LVEjZegwDYZGoHcmt7fWjNSRhlh3I00NZVl2D2lY6Ck=;
        b=A0kqIBkJsJ0GNv+7ZFU7owJnCMliEW7AiqMWnPwWpaysdqwAhSwvUKTxzofSQeiwEG
         klsDvd2ibrwHtBQzHHztm9/cTBEVOO8ilv8SmIcYLXoSck+c6Rz59gAJeY8NXTIx87ey
         6e8MT6nhKqU5AaVNFvszF5nt+H7BMcFy1yxwVyXfpQtORLSrmKygXZH4dkEKxT04wkbY
         mehSkLk1jzdQc7MHtbTAjEGcA9TVZQcEDsRmzoAR5cSsBEfrL7ziD36RwXymTOEpyYeL
         Vv5BcNHocf6c1pqEmYVA2zQMlnJPnxnM/O6mTaXXXI7xCe1otVKVfYa2aPyv9Mb3YklF
         V+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVEjZegwDYZGoHcmt7fWjNSRhlh3I00NZVl2D2lY6Ck=;
        b=GqodAYjI809Ld3kb+CF/erdaNaFu2Gei5p0Lp1lY2SNZNE+hb/tVaOkO6uX9pl6/0/
         zIGDwgmrIDZp3WdiN/aK2NLjXSokj+957TmrjuorYwglup8u7lyx4Wb1vAfLsFVbb5sM
         q/7l+osaJfBvKiKJmlSB5vKPB2rSrIooHH9hxs7OGhv52ewTSumfhRHZgy6Sc3TGTxGi
         wXxywVfRwnajulTGExnM7v9JOdiM07WuVy6SF+Q5LfiAtqSg9ibT7sKYJaUNSMPCTBTK
         Emoq6syCYQSe6QRxY4YuGhV3S6wJM34w33kZJSppyY1TArZsyYZR0FaLratDd3xE5orJ
         Deig==
X-Gm-Message-State: AFqh2krZmU7pdGk+0jjD/n1qYbo3MohIDPrBlfkjXPz5oU8V+pm330QU
        FEi1EvWUYZb8ln5R+t9xyHmpBS5pqO03P/eI0NI=
X-Google-Smtp-Source: AMrXdXvwKqlUBUcFOA3eIyUPcWbHydZ3t70dGYBIuXwtOtHKLHDjIUDU9qQDogjCQPqwYUCa7WZj6UM1g+U8jErvSyE=
X-Received: by 2002:aa7:cb52:0:b0:484:93ac:33a6 with SMTP id
 w18-20020aa7cb52000000b0048493ac33a6mr2842205edt.81.1672869344401; Wed, 04
 Jan 2023 13:55:44 -0800 (PST)
MIME-Version: 1.0
References: <20221208015434.ervz6q5j7bb4jt4a@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYGUf=yMry5Ezen2PZqvkfS+o1jSF2e1Fpa+pgAmx+OcA@mail.gmail.com>
 <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
 <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
 <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local> <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local> <CAEf4Bzbvg2bXOj8LPwkRQ0jfTR4y5XQn=ajK_ApVf5W-F=wG2Q@mail.gmail.com>
 <20230104194438.4lfigy2c5m4xx6hh@macbook-pro-6.dhcp.thefacebook.com>
In-Reply-To: <20230104194438.4lfigy2c5m4xx6hh@macbook-pro-6.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Jan 2023 13:55:32 -0800
Message-ID: <CAEf4Bzag8K=7+TY-LPEiBJ7ocRi-U+SiDioAQvPDto+j0U5YaQ@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@meta.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 4, 2023 at 11:44 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jan 04, 2023 at 10:43:37AM -0800, Andrii Nakryiko wrote:
> > > extern bool bpf_dynptr_is_null(const struct bpf_dynptr *p) __ksym;
> > >
> > > will likely work with both gcc and clang.
> > > And if it doesn't we can fix it.
> > >
> > > While when gcc folks saw helpers:
> > >
> > > static bool (*bpf_dynptr_is_null)(const struct bpf_dynptr *p) = (void *) 777;
> > >
> > > they realized that it is a hack that abuses compiler optimizations.
> > > They even invented attr(kernel_helper) to workaround this issue.
> > > After a bunch of arguing gcc added support for this hack without attr,
> > > but it's going to be around forever... in gcc, in clang and in kernel.
> > > It's something that we could have fixed if it wasn't for uapi.
> > > Just one more example of unfixable mistake that causing issues
> > > to multiple projects.
> > > That's the core issue of kernel uapi rules: inability to fix mistakes.
> >
> > This is BPF ISA defining `call #N;` to call helper with ID N, which
> > you agree that it (ISA) has to be stable, documented and standardized,
> > right?
> >
> > Everything else is just how we expose those constants into C code and
> > how libbpf deals with them. Libbpf could support new attribute or even
> > extern-based convention, if necessary.
> >
> > But it wasn't necessary for years and only was brought up during GCC's
> > attempt to invent a new convention here. And they successfully dealt
> > with this challenge.
>
> 'dealt with this challenge'? You mean didn't, right?
> gcc doesn't guarantee that '= (void *) 777;' will work even with optimization on.

I don't use gcc-bpf, but given they dropped kernel_helper attribute,
and given you said "After a bunch of arguing gcc added support for
this hack without attr but it's going to be around forever..." I
assumed it does work. Are you saying it doesn't?

> In clang we cannot guarantee that either.

It works today, if it ever regresses there will be a lot of noise and
this regression will be fixed. So maybe technically it's not
guaranteed, but in practice it will keep working.

We had a `const volatile` case recently, variables were not being put
into .rodata section properly. GCC was changed to do it the same way
as Clang so that all the existing apps can keep working.


> Nothing requires a compiler to do constant propagation.
>
> >
> > Yes, we won't change existing helpers, but we can add new ones if we
> > need to extend them. That's how APIs work. Yes, they need careful
> > considerations when designing and implementing new APIs. Yes, mistakes
> > do happen, that's just fact of life and par for the course of software
> > development. Yes, we have to live with those mistakes. Nothing changed
> > about that.
> >
> > But somehow libraries and kernel still produce stable APIs and
> > maintain them because they clearly provide benefits to end users.
>
> Did you 'live with mistakes done in libbpf 0.x' ? No.

for a long time yes. And it's not apples to apples comparison, with
library it is possible to deprecate APIs, which is what we did. With
lots of work and gradual transition, but did it.

If we couldn't pull this through, yeah, I would live with whatever
APIs are there. And added new ones as a better replacement. As is
always done for APIs, nothing new here.

Within 0.x and 1.x APIs are stable and we live with them. This API
stability fear doesn't paralyze libbpf development, we still add new
stable APIs, if they are considered useful and thought through enough.

> You've introduced libbpf 1.0 with incompatible api and some users suffereed.

By "suffered" you mean a few systemd folks being grumpy about this?
And having to do 100 lines of code changes ([0]) to support two
incompatible major versions of libbpf *simultaneously*?

On the other hand we got a library with saner error propagation
behavior and various API normalizations and additions. Not too bad of
a trade off.

Sure, deprecation is not easy or free, there was a lot of prep work,
and some users had to adjust their code to use new APIs. But this is
quite a tangent.

  [0] https://github.com/systemd/systemd/pull/24511/

>
> > We'll get the same amount of flame when we try to change kfunc that's
> > widely adopted.
>
> Of course. That's why we need to define a stability and deperecation
> plan for them.

Lots of things that need to be defined and figured out, but we are
already quick to freeze BPF helpers.
