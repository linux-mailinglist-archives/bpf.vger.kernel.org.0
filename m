Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB5930804D
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 22:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhA1VMH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 16:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhA1VME (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 16:12:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C08964D9E;
        Thu, 28 Jan 2021 21:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611868283;
        bh=wJjMxfyNprbZR+oAPShma0n4nDYyE9Z2iDgM5PEcgLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xz9o1F4DWWmB0+LTJsFqPzi7VUlROZhZR+0yYQKbCf4Te/a9DvRbSt3PWTj7nDb0F
         gD/BdmLcKCypVJtvWfjkRnxlI/BCawYYMPaZvswyclAvxs3pV3SmSqnSbl3BralNjf
         RKUMYh2l9Bt1VQ4Jz08qxAd4WxDcJ6JpT5c84FexHLV75aobAY/ML16zqxdnvC02ns
         VksiBjeeBWUv3A2zUZQ8anF2wd25cXzxDBJnGbdAhptYm71c2AERvqDpD3TM/M48JG
         fQi8JnGkPpWYQTQsad9Kokew5KWODSuYqs68kdd4XNOxdlU7ec49p6hHgg6RHzMWOm
         S7sp/ND0t7K1Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E6E6B40513; Thu, 28 Jan 2021 18:11:20 -0300 (-03)
Date:   Thu, 28 Jan 2021 18:11:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Tom Stellard <tstellar@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Mark Wielaard <mark@klomp.org>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFT] pahole 1.20 RC was Re: [PATCH] btf_encoder: Add extra
 checks for symbol names
Message-ID: <20210128211120.GB794568@kernel.org>
References: <20210112184004.1302879-1-jolsa@kernel.org>
 <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
 <20210121133825.GB12699@kernel.org>
 <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
 <CAEf4BzaVAp=W47KmMsfpj_wuJR-Gvmav=tdKdoHKAC3AW-976w@mail.gmail.com>
 <CA+icZUW6g9=sMD3hj5g+ZXOwE_DxfxO3SX2Tb-bFTiWnQLb_EA@mail.gmail.com>
 <CAEf4BzZ-uU3vkMA1RPt1f2HbgaHoenTxeVadyxuLuFGwN9ntyw@mail.gmail.com>
 <20210128200046.GA794568@kernel.org>
 <CA+icZUWi_3=T2B-bv4dd6D78rpHKVyYrkpxEVcXPW5saqHttCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWi_3=T2B-bv4dd6D78rpHKVyYrkpxEVcXPW5saqHttCg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jan 28, 2021 at 09:57:14PM +0100, Sedat Dilek escreveu:
> On Thu, Jan 28, 2021 at 9:00 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:

> > Em Thu, Jan 21, 2021 at 08:11:17PM -0800, Andrii Nakryiko escreveu:
> > > On Thu, Jan 21, 2021 at 6:07 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > Do you want Nick's DWARF v5 patch-series as a base?

> > > Arnaldo was going to figure out the DWARF v5 problem, so I'm leaving
> > > it up to him. I'm curious about DWARF v4 problems because no one yet
> > > reported that previously.

> > I think I have the reported one fixed, Andrii, can you please do
> > whatever pre-release tests you can in your environment with what is in:

> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=DW_AT_data_bit_offset

> > ?

> > The cset has the tests I performed and the references to the bugzilla
> > ticket and Daniel has tested as well for his XDR + gcc 11 problem.
> 
> What Git tree should someone use to test this?
> Linus Git?
> bpf / bpf-next?

The one you were having problems with :)

This pahole branch should be handling multiple problems, this is the
list of changes since v1.19:

[acme@five pahole]$ git log --oneline v1.19..
b91b19840b0062b8 (HEAD -> master, quaco/master, origin/DW_AT_data_bit_offset) dwarf_loader: Support DW_AT_data_bit_offset
c692e8ac5ccbab99 dwarf_loader: Optimize a bit the reading of DW_AT_data_member_location
65917b24942ce620 dwarf_loader: Fix typo
77205a119c85e396 dwarf_loader: Introduce __attr_offset() to reuse call to dwarf_attr()
8ec231f6b0c8aaef dwarf_loader: Support DW_FORM_implicit_const in attr_numeric()
7453895e01edb535 (origin/master, origin/HEAD) btf_encoder: Improve ELF error reporting
1bb49897dd2b65b0 bpf_encoder: Translate SHN_XINDEX in symbol's st_shndx values
3f8aad340bf1a188 elf_symtab: Handle SHN_XINDEX index in elf_section_by_name()
e32b9800e650a6eb btf_encoder: Add extra checks for symbol names
82749180b23d3c9c libbpf: allow to use packaged version
452dbcf35f1a7bf9 btf_encoder: Improve error-handling around objcopy
cf381f9a3822d68b btf_encoder: Fix handling of restrict qualifier
b688e35970600c15 btf_encoder: fix skipping per-CPU variables at offset 0
8c009d6ce762dfc9 btf_encoder: fix BTF variable generation for kernel modules
b94e97e015a94e6b dwarves: Fix compilation on 32-bit architectures
17df51c700248f02 btf_encoder: Detect kernel module ftrace addresses
06ca639505fc56c6 btf_encoder: Use address size based on ELF's class
aff60970d16b909e btf_encoder: Factor filter_functions function
1e6a3fed6e52d365 rpm: Fix changelog date
[acme@five pahole]$

Now I just need to do the boilerplate update of the version number,
Changes and .spec file, to release v1.20.

- Arnaldo
