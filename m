Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC34C6D8642
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 20:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjDEStO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 14:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbjDEStN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 14:49:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56675FFB
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 11:49:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-948a1aec279so63203166b.2
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680720550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EkeCZmww7V8kGFzNPHLWnZyeBpCmE6gPXpN6r1p6wk=;
        b=RZTN4Ui3zoY+BBLOsYO3UPq6v8CtRLNEj7XBmzqv8dSaSLFj94uxzTFH77glhsMH4Y
         cJby5100iDtFznUv/9noSr+YEdHk+i3gdSH6sntWNodQHHbgLJLPrg9me99oeHGubbmF
         G3rHL8NStlFTAXY9rF7kmoKF3eXSVtkNsAi9HlXgXlKVY4c47CpkalelAIJI5Fc5Yuc6
         WG1EFwQxnRB8EwIgpBIeH0tGsIgMNtSCRsR2S2CSRoN+aATUFJk2RYyaShlndNJ3gnqW
         aDy+74idHlXMpV0sfLM65D67SCZ1wltIENxzxtCXPNjx5qmJhl2LKawEkRN4Av1qqjLI
         S0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680720550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EkeCZmww7V8kGFzNPHLWnZyeBpCmE6gPXpN6r1p6wk=;
        b=zqY6GSPLlKkvcJsR7omTzdWT9hhxbOjUi50lUdAZzpAxDbxoCo/RomvX487DfpKK7S
         o1gtJcmWu3r3em32UoA5bJELt8AtP6q2fbbfcEMjBR7A7Js1AIs8sER3b22PSxHzKHXv
         Witt0wXC2OTuc8xbZsGZhHeDn2CHLPmhexmveixJIs3EVtz2Q+3EV9iXEJfv8wk791tf
         mB7VkOjL2OuoRGkY5qjCvyT5434U3m3vIpOM/8pD4SgbLy2dStcEH+3oN1wYRS+XtZSx
         g4qjekIAcXSh6lshd5N2I+eNB4P3zwOo3IHOCq3nbloIBHNJMQLKnekYwLAdTEg6Y1Tz
         TkIQ==
X-Gm-Message-State: AAQBX9fgTqind7CrFLRGCafK6mbYrMUFYmt8xBoz0D2Iujv5ApzroaZw
        3co9HyKdAOmduhllllFnTaa85St3tc3ExO2cya4=
X-Google-Smtp-Source: AKy350aEEAr1yhYLm51pmav1SDxXfwjuemW4PfGMScx1BOg2l2Yoasg4BfO/c/y9o5fKnkEakZvSTE29gRXxNXrHKVU=
X-Received: by 2002:a50:aa93:0:b0:4c0:71e6:9dc5 with SMTP id
 q19-20020a50aa93000000b004c071e69dc5mr1687479edc.1.1680720550077; Wed, 05 Apr
 2023 11:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PiJmRwv8UTyQuEBmn1aHg5mXGqHSpAiOJF0Xo9SwZLfW623A@mail.gmail.com>
 <CAEf4BzZntoM0fHzgBuGiqiTNkq=jT-f09nwub-MHyguJCfLeNA@mail.gmail.com>
 <CA+PiJmSNnQ9DD+JVc9hG7iEj5ZDZfhOhYAMKs+f=kXs=DZxuAA@mail.gmail.com>
 <CAADnVQKMrsc+Dxz3uWeKzCPDfr0XKWaWsbn3AeEm+RCmp-apUQ@mail.gmail.com>
 <CA+PiJmT4KyWAAEbYWggOLdy-WR=m1D+EO3j1+=UbY-wVUpzYDA@mail.gmail.com> <20230405025726.nesfo5rwuiqnzgqc@macbook-pro-6.dhcp.thefacebook.com>
In-Reply-To: <20230405025726.nesfo5rwuiqnzgqc@macbook-pro-6.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Apr 2023 11:48:58 -0700
Message-ID: <CAEf4BzaD+8tStmJ4i5TeSNpCMhwZ4CkTYMYf+N9YHwK46EtCcA@mail.gmail.com>
Subject: Re: Dynptrs and Strings
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 4, 2023 at 7:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 04, 2023 at 06:50:08PM -0700, Daniel Rosenberg wrote:
> > On Tue, Apr 4, 2023 at 3:58=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > I'm pretty sure we can make bpf_dynptr_data() support readonly dynptr=
s.
> > > Should be easy to add in the verifier.
> > > But could you pseudo code what you're trying to do first?
> > >
> >
> > I'm trying to do something like this:
> >
> > bpf_fuse_get_ro_dynptr(name, &name_ptr);
>
> so the idea that bpf prog will see opaque ctx =3D=3D name and a set
> of kfuncs will extract different things from ctx into local dynptrs ?
>
> Have you considered passing dynptr-s directly into bpf progs
> as arguments of struct_ops callbacks?
> That would be faster or slower performance wise?
>
> > name_buf =3D bpf_dynptr_data(&name_ptr, 4);
> > if (!bpf_strncmp(name_buf, 4, "test"))
> >    return 42;
> > return 0;
> >
> > Really I just want to work with the data in the dynptrs in as
> > convenient a way as possible.
> > I'd like to avoid copying the data if it isn't necessary.
>
> of course.

note that even if bpf_dynptr_slice() accepts a buffer, it won't ever
touch it for LOCAL dynptrs, as the data is already linear in memory.
This buffer is filled out only for skb/xdp **and** only if requested
memory range can't be accessed as sequential memory. So you won't be
copying data.

For bpf_dynptr_read(), yep, it will copy data. Regardless if you are
going to use it or not, we should relax the condition that final
buffer should be smaller or equal to dynptr actual size, it should be
bigger and we should just write to first N bytes of it.

>
> > At the moment I'm using bpf_dynptr_slice and declaring an empty and
> > unused buffer. I'm then hitting an issue with bpf_strncmp not
> > expecting mem that's tagged as being associated with a dynptr. I'm
> > currently working around that by adjusting check_reg_type to be less
> > picky, stripping away DYNPTR_TYPE_LOCAL if we're looking at an
> > ARG_PTR_TO_MEM. I suspect that would also be the case for other dynptr
> > types.

So this seems unintended (or there is some unintentional misuse of
memory vs dynptr itself), we might be missing something in how we
handle arguments right now. It would be nice if you can send a patch
with a small selftest demonstrating this (and maybe a fix :) ).

> >
> > I guess for dynptr_data to support R/O, the dynptr in question would
> > just need to be tagged as read-only or read/write by the verifier
> > previously, and then it could just pass along that tag to the mem it
> > returns.
>
> yep. Don't be shy from improving the verifier to your needs.

We had previous discussions about whether to treat read-only as a
runtime-only or statically known attribute. There were pros and cons,
I don't remember what we ended up deciding. We do some custom handling
for some SKB programs, but it would be good to handle this
universally, yep.

>
> > >
> > > Do you expect bpf prog to see both ro and rw dynptrs on input?
> > > And you want bpf prog to use bpf_dynptr_data() to access these buffer=
s
> > > wrapped as dynptr-s?
> > > The string manipulation questions muddy the picture here.
> > > If bpf progs deals with file system block data why strings?
> > > Is that a separate set of bpf prog hooks that receive strings on
> > > input wrapped as dynptrs?
> > > What are those strings? file path?
> > > We need more info to help you design the interface, so it's easy to
> > > use from bpf prog pov.
> >
> > I have a few usecases for them. I've restructured fuse-bpf to use
> > struct ops. Each fuse operation has an associated prefilter and
> > postfilter op.
> > At the moment I'm using dynptrs for any variable length block of data
> > that these ops need. For many operations, this includes the file name.
> > In some, a path. Other times, it's file data, or xattr names/data.
> > They can all have different sizes, and may be backed by data that may
> > not be changed, like the dentry name field. I have a pair of kfuncs
> > for requesting a dynptr from an opaque storage type, so you can avoid
> > having to make unnecessary copies if you're not planning on making
> > modifications. The r/w version of the kfunc will allocate new space
> > and copy data as needed. They're a direct analog of the helper
> > functions from the initial patch. The opaque structure includes
> > information about the current and max size of the argument, whether
> > the current backing is read-only, and other flags for cleanup if the
> > helper allocates memory.
> >
> > The Fuse bpf programs may alter those fields, and then returns whether
> > it was able to handle the request, or if the request must go to
> > userspace.
> >
> > While the fields have a max size, their actual size isn't available
> > until runtime. That makes the current set of dynptr functions largely
> > unusable, since I believe they all require a known constant size to
> > access, and I don't think the helper to return the length of a dynptr
> > counts for that as far as the verifier is concerned. Worst case, I

correct, because operations like bpf_dynptr_data() and
bpf_dynptr_slice() are asking verifier to access any of N requested
bytes directly. So the verifier has to make sure that all N bytes (if
returned as non-NULL pointer) are valid and accessible.

> > suppose more of those interactions could happen behind kfuncs, where
> > they can perform runtime checks. That may end up being overly
> > restrictive though.
>
> Overall makes sense, but a bit too abstract for concrete suggestions.
> I think it would be best if you just send your rough patches to the list
> with comments where things still need work and we will go from there.

+1. I feel like we are just missing a few helpers to help extract
and/or compare variable-sized strings (like bpf_dynptr_strncmp
mentioned earlier) for all this to work well. But a concrete use case
would allow us to design a coherent set of APIs to help with this.
