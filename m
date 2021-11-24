Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A707345B3AB
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 05:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhKXEwi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 23:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhKXEwi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Nov 2021 23:52:38 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1111CC061574;
        Tue, 23 Nov 2021 20:49:29 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id j2so3604698ybg.9;
        Tue, 23 Nov 2021 20:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PikPoM3Syjnb7Q6YnRZDqBMqc38pdUqESbak8cv88tA=;
        b=L9Al8SQEmbXcUNjbsvHrH4wcbsvZATYmDNehhorNBBtrSBDYj+EUrUmJhjvnVeh6NK
         +9iqZ7iTKlWYVYnrNlZVF7uMpiu0xPjznH8TAn5IrJJW2lOyJLMu4jjxouq60ERPVwj4
         iu6/mXzyRPMHRWIK8pS3pwar4oN4AY2WDK9r7GebpRMq9ioPtkaXjixGwXJRYxadZTzz
         S3K9xmN7YaqkVmZZi38/oh0JQn0vNj+ePSbQL3+h1KlyqBWiRU48ydjPlCJwk9ACviZb
         9prMB26wKNEA432kadpe17YDrWmdYwQMOVe1p76QI32a7dMzc3sJtDuwNMbkYylR9eum
         fZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PikPoM3Syjnb7Q6YnRZDqBMqc38pdUqESbak8cv88tA=;
        b=mLc6eWLARPLWSN0iNQVU9ISW54pi9yLtonWm4QnnAIk3KCeuFeXwlnNtrObXEA8+DG
         kx51XiL9H5e8MxzjCSwg46t16hx8FTWoiQB8KxzCbbcXAWLMYtK/zU39Bbe40i1mw8DO
         ffeCxRTV+mLHyOqBgKLKfbbvLTWjDPhvGavV7GRQSSCcyz4zv/GW1HIGn5nBt/Ep70sa
         PS5cclGf6IqG6RDa1IBK+AVqJLrd/KH6RrsEpHZOJmxByeQSETlQY0huwF7lDzIOXakV
         +dVlzrNMyOv9hgQ8H/aaTqK4jYSG0TwqFSkp8AZH9zamccw0zHNvHY5Y2xavYaNYq5vl
         eEzA==
X-Gm-Message-State: AOAM533iUPfXHmO2rSRMgVtMthszKZYcjoHXT6w/iFZV4fqaEMnhgqy3
        Hgr/xJL6DHgcyKkOjTUZFCSXnGO9LoH030wiGz4=
X-Google-Smtp-Source: ABdhPJzZRfR1UaSQmL1a/ZduKk4llFH297JOmku5flL+gVUOP7E05nIJpTcxeDkid42NamaUCyIgH4ZkKePtoPtnKUk=
X-Received: by 2002:a05:6902:68d:: with SMTP id i13mr13410068ybt.2.1637729368237;
 Tue, 23 Nov 2021 20:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20211123045612.1387544-1-yhs@fb.com> <CAEf4BzbEMzpXKQ18FmFxgozAmbx8Mz87YamONpbAWaKDCULGjg@mail.gmail.com>
 <YZ17F85k9Ddhjgnc@kernel.org>
In-Reply-To: <YZ17F85k9Ddhjgnc@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Nov 2021 20:49:17 -0800
Message-ID: <CAEf4BzYH86PEKA0EDs2VkMCXrKjpLqxB+5Ry0Jsr9aoO+Mi88w@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 0/4] btf: support btf_type_tag attribute
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 23, 2021 at 3:36 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Nov 23, 2021 at 10:32:18AM -0800, Andrii Nakryiko escreveu:
> > On Mon, Nov 22, 2021 at 8:56 PM Yonghong Song <yhs@fb.com> wrote:
> > >
> > > btf_type_tag is a new llvm type attribute which is used similar
> > > to kernel __user/__rcu attributes. The format of btf_type_tag looks like
> > >   __attribute__((btf_type_tag("tag1")))
> > > For the case where the attribute applied to a pointee like
> > >   #define __tag1 __attribute__((btf_type_tag("tag1")))
> > >   #define __tag2 __attribute__((btf_type_tag("tag2")))
> > >   int __tag1 * __tag1 __tag2 *g;
> > > the information will be encoded in dwarf.
> > >
> > > In BTF, the attribute is encoded as a new kind
> > > BTF_KIND_TYPE_TAG and latest bpf-next supports it.
> > >
> > > The patch added support in pahole, specifically
> > > converts llvm dwarf btf_type_tag attributes to
> > > BTF types. Please see individual patches for details.
> > >
> > > Changelog:
> > >   v1 -> v2:
> > >      - reorg an if condition to reduce nesting level.
> > >      - add more comments to explain how to chain type tag types.
> > >
> > > Yonghong Song (4):
> > >   libbpf: sync with latest libbpf repo
> > >   dutil: move DW_TAG_LLVM_annotation definition to dutil.h
> > >   dwarf_loader: support btf_type_tag attribute
> > >   btf_encoder: support btf_type_tag attribute
> > >
> >
> > I thought that v1 was already applied, but either way LGTM. I'm not
>
> To the next branch, and the libbpf pahole CI is failing, since a few
> days, can you please take a look?

We've had Clang regression which Yonghong fixed very quickly, but then
we were blocked on Clang nightly builds being broken for days. Seems
like we got a new Clang today, so hopefully libbpf CI will be back to
green again.

>
> > super familiar with the DWARF loader parts, so I mostly just read it
> > very superficially :)
>
> I replaced the patches that changed, re-added the S-o-B for Yonghong and
> tested it with llvm-project HEAD.
>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> Adding it to the csets.
>
> Thanks!
>
> - Arnaldo
>
> >
> > >  btf_encoder.c  |   7 +++
> > >  dutil.h        |   4 ++
> > >  dwarf_loader.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++---
> > >  dwarves.h      |  38 +++++++++++++-
> > >  lib/bpf        |   2 +-
> > >  pahole.c       |   8 +++
> > >  6 files changed, 190 insertions(+), 9 deletions(-)
> > >
> > > --
> > > 2.30.2
> > >
>
> --
>
> - Arnaldo
