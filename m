Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7493A35A05B
	for <lists+bpf@lfdr.de>; Fri,  9 Apr 2021 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhDINwF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Apr 2021 09:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232642AbhDINwE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Apr 2021 09:52:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0345961056;
        Fri,  9 Apr 2021 13:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617976311;
        bh=uPuP1kvlND/S6vBHHEzlpQWNGfefzScdkjh5MdnOWnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DuMSNPv8ZewTdA2wH2zJDOud4h8RKDNTONUY2C8nNaYmifsJZ1TC1/teOyEgotcv0
         b5VsRGkno/jnmOZ3+G1666pccMdYRkb7msLST0la0CXaIatDzFfDQorPEL1mAVTXcw
         HAHEh4IqXkESouW94AfXL8b3R7s0fSdGNLYLVAG0kbTyeieHxEG+QAemB+sTXvYU6B
         BhEpBy/3tmbpx3THPfjAh802KjT6YN4o+JLoanidI4PDhy32VSh4ID2BesVc3C4S/C
         d4hXr96PVXv4DFXANO72V9Byw8iP6/0bo6XV+iWFFktcReDBiu9Qmi4KWoDd9IGKrC
         0VyZcEnVm61uQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 05E1F40647; Fri,  9 Apr 2021 10:51:47 -0300 (-03)
Date:   Fri, 9 Apr 2021 10:51:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Yonghong Song <yhs@fb.com>, Arnaldo <arnaldo.melo@gmail.com>,
        David Blaikie <dblaikie@gmail.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFT] prepping up pahole 1.21, wanna test it? was Re: [PATCH
 dwarves] dwarf_loader: handle subprogram ret type with abstract_origin
 properly
Message-ID: <YHBb894gwG2Vc9K3@kernel.org>
References: <CAENS6EsiRsY1JptWJqu2wH=m4fkSiR+zD8JDD5DYke=ZnJOMrg@mail.gmail.com>
 <YGckYjyfxfNLzc34@kernel.org>
 <YGcw4iq9QNkFFfyt@kernel.org>
 <2d55d22b-d136-82b9-6a0f-8b09eeef7047@fb.com>
 <82dfd420-96f9-aedc-6cdc-bf20042455db@fb.com>
 <E9072F07-B689-402C-89F6-545B589EF7E4@gmail.com>
 <be7079b4-718c-e4a7-dff4-56543e5854a6@fb.com>
 <YG3RpVgLC9UEUrb8@kernel.org>
 <YG3SYoNWqb8DlP61@kernel.org>
 <YG90VJNUJA6EWZ1X@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG90VJNUJA6EWZ1X@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Apr 08, 2021 at 11:23:32PM +0200, Jiri Olsa escreveu:
> On Wed, Apr 07, 2021 at 12:40:18PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Apr 07, 2021 at 12:37:09PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Wed, Apr 07, 2021 at 07:54:26AM -0700, Yonghong Song escreveu:
> > > > Arnaldo, just in case that you missed it, please remember
> > > > to fold the above changes to the patch:
> > > >    [PATCH dwarves] dwarf_loader: handle subprogram ret type with
> > > > abstract_origin properly
> > > > Thanks!
> > > 
> > > Its there, I did it Sunday, IIRC:
> > > 
> > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=tmp.master&id=9adb014930f31c66608fa39a35ccea2daa5586ad
> > 
> > So I pushed it all to the master branch, hopefully some more people may
> > feel encouraged to give it a try for the various things it fixes since
> > 1.20:
> 
> heya,
> the test script passed

Thanks a lot for testing!

- Arnaldo
 
> jirka
> 
> > 
> > [acme@quaco pahole]$ git log --oneline v1.20..
> > ae0b7dde1fd50b12 (HEAD -> master, origin/tmp.master, origin/master, origin/HEAD, github/master, five/master, acme.korg/tmp.master, acme.korg/master) dwarf_loader: Handle DWARF5 DW_OP_addrx properly
> > 9adb014930f31c66 dwarf_loader: Handle subprogram ret type with abstract_origin properly
> > 5752d1951d081a80 dwarf_loader: Check .notes section for LTO build info
> > 209e45424ff4a22d dwarf_loader: Check .debug_abbrev for cross-CU references
> > 39227909db3cc2c2 dwarf_loader: Permit merging all DWARF CU's for clang LTO built binary
> > 763475ca1101ccfe dwarf_loader: Factor out common code to initialize a cu
> > d0d3fbd4744953e8 dwarf_loader: Permit a flexible HASHTAGS__BITS
> > ffe0ef4d73906c18 btf: Add --btf_gen_all flag
> > de708b33114d42c2 btf: Add support for the floating-point types
> > 4b7f8c04d009942b fprintf: Honour conf_fprintf.hex when printing enumerations
> > f2889ff163726336 Avoid warning when building with NDEBUG
> > 8e1f8c904e303d5d btf_encoder: Match ftrace addresses within ELF functions
> > 9fecc77ed82d429f dwarf_loader: Use a better hashing function, from libbpf
> > 0125de3a4c055cdf btf_encoder: Funnel ELF error reporting through a macro
> > 7d8e829f636f47ab btf_encoder: Sanitize non-regular int base type
> > [acme@quaco pahole]$
> > 
> > - Arnaldo
> > 
> 

-- 

- Arnaldo
