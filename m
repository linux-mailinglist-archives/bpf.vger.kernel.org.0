Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55D03141B0
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 22:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhBHV05 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 8 Feb 2021 16:26:57 -0500
Received: from wildebeest.demon.nl ([212.238.236.112]:41524 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbhBHVZn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 16:25:43 -0500
Received: from tarox.wildebeest.org (tarox.wildebeest.org [172.31.17.39])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id 648CE3032F80;
        Mon,  8 Feb 2021 22:24:45 +0100 (CET)
Received: by tarox.wildebeest.org (Postfix, from userid 1000)
        id 0EF694005CCC; Mon,  8 Feb 2021 22:24:45 +0100 (CET)
Message-ID: <871a6cb9de4fc4551a1ddb91bb467cf7a5bef81b.camel@klomp.org>
Subject: Re: [PATCH dwarves v2] btf_encoder: sanitize non-regular int base
 type
From:   Mark Wielaard <mark@klomp.org>
To:     David Blaikie <blaikie@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Date:   Mon, 08 Feb 2021 22:24:44 +0100
In-Reply-To: <CAMXQf9_Qy5tD05ax1vtETnzM9szLxm95JgpHgT0HzjktixMNNQ@mail.gmail.com>
References: <20210207071726.3969978-1-yhs@fb.com>
         <a02164334d0e991820eefa45e2df1a8b49f5537e.camel@klomp.org>
         <CAKwvOdmMPjn-_opboZkVhRpYCUuKFv8G9GtKFAj=wqYRjr-jkA@mail.gmail.com>
         <CAMXQf9_Qy5tD05ax1vtETnzM9szLxm95JgpHgT0HzjktixMNNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on gnu.wildebeest.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

(Nice to have seen you just recently!)

On Mon, 2021-02-08 at 12:43 -0800, David Blaikie wrote:
> DW_OP_convert was added in DWARFv5 and it can be used for type conversions,
> these are created in the LLVM middle/backend during optimizations, not by
> the frontend. So the middle/backend doesn't have a way to create canonical
> DW_TAG_base_types for frontend language integer types - so it creates
> synthesized ones. So this is intentional/not a particularly quirky thing.
> 
> LLVM creates locations incrementally as optimizations are applied - without
> doing any particular canonicalization/reduction later on (maybe it has some
> canonicalization/reduction, but not a very wholistic/aggressive approach
> there) - so it can end up with something that is not the most compact
> representation.

But it seems to end up with a bogus representation (see below in the
original quoted message for an example). The issue isn't really that it
isn't an optimized constant representation (although it is kind of an
inefficient one). It is this DW_OP_convert applied to a
DW_TAG_base_type DIE with a DW_AT_byte_size of zero. Which doesn't
really make any sense to me. It feels like it is asking the DWARF
consumer to do a divide by zero here ("now express this value using
zero bits!"). Could you explain these syntactic "DW_ATE_unsigned_1"
base_type DIEs? What do they represent? Why do they have a zero size?
Should they really have a DW_AT_bit_size and a DW_AT_byte_size of 1?

Thanks,

Mark

> On Mon, Feb 8, 2021 at 11:17 AM Nick Desaulniers <ndesaulniers@google.com>
> wrote:
> 
> > On Sun, Feb 7, 2021 at 6:18 AM Mark Wielaard <mark@klomp.org> wrote:
> > > 
> > > Hi,
> > > 
> > > On Sat, 2021-02-06 at 23:17 -0800, Yonghong Song wrote:
> > > > clang with dwarf5 may generate non-regular int base type,
> > > > i.e., not a signed/unsigned char/short/int/longlong/__int128.
> > > > Such base types are often used to describe
> > > > how an actual parameter or variable is generated. For example,
> > > > 
> > > > 0x000015cf:   DW_TAG_base_type
> > > >                 DW_AT_name      ("DW_ATE_unsigned_1")
> > > >                 DW_AT_encoding  (DW_ATE_unsigned)
> > > >                 DW_AT_byte_size (0x00)
> > > > 
> > > > 0x00010ed9:         DW_TAG_formal_parameter
> > > >                       DW_AT_location    (DW_OP_lit0,
> > > >                                          DW_OP_not,
> > > >                                          DW_OP_convert (0x000015cf)
> > 
> > "DW_ATE_unsigned_1",
> > > >                                          DW_OP_convert (0x000015d4)
> > 
> > "DW_ATE_unsigned_8",
> > > >                                          DW_OP_stack_value)
> > > >                       DW_AT_abstract_origin     (0x00013984 "branch")
> > > > 
> > > > What it does is with a literal "0", did a "not" operation, and the
> > 
> > converted to
> > > > one-bit unsigned int and then 8-bit unsigned int.
> > > 
> > > Thanks for tracking this down. Do you have any idea why the clang
> > > compiler emits this? You might be right that it is intended to do what
> > > you describe it does (but then it would simply encode an unsigned
> > > constant 1 char in a very inefficient way). But as implemented it
> > > doesn't seem to make any sense. What would DW_OP_convert of an zero
> > > sized base type even mean (if it is intended as a 1 bit sized typed,
> > > then why is there no DW_AT_bit_size)?
> > 
> > David,
> > Any thoughts on the above sequence of DW_OP_ entries?  This is a part
> > of DWARF I'm unfamiliar with.
> > 
> > > 
> > > So I do think your patch makes sense. clang clearly is emitting
> > > something bogus. And so some fixup is needed. But maybe we should at
> > > least give a warning about it, otherwise it might never get fixed.
> > > 
> > > BTW. If these bogus base types are only emitted as part of a location
> > > expression and not as part of an actual function or variable type
> > > description, then why are we even trying to encode it as a BTF type? It
> > > might be cheaper to just skip/drop it. But maybe the code setup makes
> > > it hard to know whether or not such a (bogus) type is actually
> > > referenced from a function or variable description?
> > > 
> > > Cheers,
> > > 
> > > Mark
> > 
> > 
> > 
> > --
> > Thanks,
> > ~Nick Desaulniers
> > 
