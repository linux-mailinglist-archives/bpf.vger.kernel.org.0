Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EAE44DB3C
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 18:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhKKRtG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 12:49:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233705AbhKKRtF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 12:49:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19DF361268;
        Thu, 11 Nov 2021 17:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636652776;
        bh=t4v6QOc8d9eGSyxQQvFgi8E+t/3B1gGlPGRtk+Vx7oY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lUUYvyrdTrYhN6QE+b8PSFlD4+yIrsonGhp8QuubwS/ADwuoOc6Vl+eXUNPmb/FpD
         vA9ab5TQD3Kk+tp2rIAU25qeMj0OrzVnGajTZV2RIFJtsTtaebpfsqXqHDmDh8jjyN
         idhQFydwkOaxdrHuqut8J/SVrmlYNg6zXscEU4h+jj/zHYOjyCQyi8hxvmF/QE53MX
         XnpuQNjxim6UEaNEUv/ocyyVVeH7aLNY1abgddaUzbezBSIjHLMeQyh2EofS+AmO2i
         7eTMbhSRv2iprdlK1X+NlxDIN5J8N/t/RqOYoLUFwqnqepa9f7r8Bhek9mKvzIToVf
         s/4U3aZLaHifA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0FD8E410A1; Thu, 11 Nov 2021 14:46:13 -0300 (-03)
Date:   Thu, 11 Nov 2021 14:46:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH dwarves v2 0/2] btf: support typedef
 DW_TAG_LLVM_annotation
Message-ID: <YY1W5FlMlaN6DGaN@kernel.org>
References: <20211102233500.1024582-1-yhs@fb.com>
 <CAEf4BzZXVjTgZH-t0kXP6rwyA=dxQqc3VAHdmh-eFHY5OdbGYA@mail.gmail.com>
 <e89bbd11-724a-d186-26d6-ce34435702f1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89bbd11-724a-d186-26d6-ce34435702f1@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Nov 09, 2021 at 09:23:30PM -0800, Yonghong Song escreveu:
> 
> 
> On 11/2/21 5:11 PM, Andrii Nakryiko wrote:
> > On Tue, Nov 2, 2021 at 4:35 PM Yonghong Song <yhs@fb.com> wrote:
> > > 
> > > Latest llvm is able to generate DW_TAG_LLVM_annotation for typedef
> > > declarations. Latest bpf-next supports BTF_KIND_DECL_TAG for
> > > typedef declarations. This patch implemented dwarf DW_TAG_LLVM_annotation
> > > to btf BTF_KIND_DECL_TAG conversion. Patch 1 is for dwarf_loader
> > > to process DW_TAG_LLVM_annotation tags. Patch 2 is for the
> > > dwarf->btf conversion.
> > > 
> > > Changelog:
> > >    v1 -> v2:
> > >     - change some "if" statements to "switch" statement.
> > > 
> > 
> > LGTM.
> > 
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Arnaldo, did you get chance to look at this patch set?

Yeah, I've merged and put it in the tmp.master branch so that libbpf's
CI can have a go on it.

I'm also updating my clang/llvm build to test it.

Thanks,

- Arnaldo
 
> > 
> > > Yonghong Song (2):
> > >    dwarf_loader: support typedef DW_TAG_LLVM_annotation
> > >    btf_encoder: generate BTF_KIND_DECL_TAGs for typedef btf_decl_tag
> > >      attributes
> > > 
> > >   btf_encoder.c  | 17 ++++++++++++++---
> > >   dwarf_loader.c |  7 ++-----
> > >   2 files changed, 16 insertions(+), 8 deletions(-)
> > > 
> > > --
> > > 2.30.2
> > > 

-- 

- Arnaldo
