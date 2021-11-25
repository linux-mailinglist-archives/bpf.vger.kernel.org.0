Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA46245E29A
	for <lists+bpf@lfdr.de>; Thu, 25 Nov 2021 22:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbhKYVit (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Nov 2021 16:38:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232297AbhKYVgt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Nov 2021 16:36:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C4B360FD9;
        Thu, 25 Nov 2021 21:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637876017;
        bh=5IFZJzj1I8zJqBPTXt9tThhLVBoGJYpI9UU4Ftr/7Uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VoLoRdExGOYQSBdZnoBUg1K2jDNzzGnrOqVahM5oc62OgmutQ9c3jH3robp4dwMmi
         BCLcaNtL982RASPHxJbhMMvMiOlTvvHVKBDjX6oDPM/xsv7tKxWvqrYio57Gl9bOlR
         XP2L5iJyX8HqgVeQ4ywaSyxHHJ7bNhF9jidL5mqnnhOkYoY8xIBsLiSTssCFpGe5yU
         haz82mO5CzbNJ9piPQLiHjr05EEVAdIKHrRK30/txfg/aDMHOv1I+7V6sq9GNZj00S
         9L8hLgjDFBbc2P723VJagyyJXfZmjXooLT8LxL1jBIxDOlxcBdFvccTh9J2zRx4b5f
         bzYldlCbcJS/w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 05C5440002; Thu, 25 Nov 2021 18:33:34 -0300 (-03)
Date:   Thu, 25 Nov 2021 18:33:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH dwarves v2 0/4] btf: support btf_type_tag attribute
Message-ID: <YaABLmIMey52fotW@kernel.org>
References: <20211123045612.1387544-1-yhs@fb.com>
 <CAEf4BzbEMzpXKQ18FmFxgozAmbx8Mz87YamONpbAWaKDCULGjg@mail.gmail.com>
 <YZ17F85k9Ddhjgnc@kernel.org>
 <CAEf4BzYH86PEKA0EDs2VkMCXrKjpLqxB+5Ry0Jsr9aoO+Mi88w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYH86PEKA0EDs2VkMCXrKjpLqxB+5Ry0Jsr9aoO+Mi88w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Nov 23, 2021 at 08:49:17PM -0800, Andrii Nakryiko escreveu:
> On Tue, Nov 23, 2021 at 3:36 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Nov 23, 2021 at 10:32:18AM -0800, Andrii Nakryiko escreveu:
> > > On Mon, Nov 22, 2021 at 8:56 PM Yonghong Song <yhs@fb.com> wrote:
> > > >
> > > > btf_type_tag is a new llvm type attribute which is used similar
> > > > to kernel __user/__rcu attributes. The format of btf_type_tag looks like
> > > >   __attribute__((btf_type_tag("tag1")))
> > > > For the case where the attribute applied to a pointee like
> > > >   #define __tag1 __attribute__((btf_type_tag("tag1")))
> > > >   #define __tag2 __attribute__((btf_type_tag("tag2")))
> > > >   int __tag1 * __tag1 __tag2 *g;
> > > > the information will be encoded in dwarf.
> > > >
> > > > In BTF, the attribute is encoded as a new kind
> > > > BTF_KIND_TYPE_TAG and latest bpf-next supports it.
> > > >
> > > > The patch added support in pahole, specifically
> > > > converts llvm dwarf btf_type_tag attributes to
> > > > BTF types. Please see individual patches for details.
> > > >
> > > > Changelog:
> > > >   v1 -> v2:
> > > >      - reorg an if condition to reduce nesting level.
> > > >      - add more comments to explain how to chain type tag types.
> > > >
> > > > Yonghong Song (4):
> > > >   libbpf: sync with latest libbpf repo
> > > >   dutil: move DW_TAG_LLVM_annotation definition to dutil.h
> > > >   dwarf_loader: support btf_type_tag attribute
> > > >   btf_encoder: support btf_type_tag attribute
> > > >
> > >
> > > I thought that v1 was already applied, but either way LGTM. I'm not
> >
> > To the next branch, and the libbpf pahole CI is failing, since a few
> > days, can you please take a look?
> 
> We've had Clang regression which Yonghong fixed very quickly, but then
> we were blocked on Clang nightly builds being broken for days. Seems
> like we got a new Clang today, so hopefully libbpf CI will be back to
> green again.

It is back to green, so I moved next to master, i.e. this series is now
on master.

- Arnaldo
 
> >
> > > super familiar with the DWARF loader parts, so I mostly just read it
> > > very superficially :)
> >
> > I replaced the patches that changed, re-added the S-o-B for Yonghong and
> > tested it with llvm-project HEAD.
> >
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Adding it to the csets.
> >
> > Thanks!
> >
> > - Arnaldo
> >
> > >
> > > >  btf_encoder.c  |   7 +++
> > > >  dutil.h        |   4 ++
> > > >  dwarf_loader.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++---
> > > >  dwarves.h      |  38 +++++++++++++-
> > > >  lib/bpf        |   2 +-
> > > >  pahole.c       |   8 +++
> > > >  6 files changed, 190 insertions(+), 9 deletions(-)
> > > >
> > > > --
> > > > 2.30.2
> > > >
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
