Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E00A3124A6
	for <lists+bpf@lfdr.de>; Sun,  7 Feb 2021 15:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBGOSs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 7 Feb 2021 09:18:48 -0500
Received: from wildebeest.demon.nl ([212.238.236.112]:41384 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhBGOSr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Feb 2021 09:18:47 -0500
Received: from tarox.wildebeest.org (tarox.wildebeest.org [172.31.17.39])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id 6AF71305EC8F;
        Sun,  7 Feb 2021 15:18:03 +0100 (CET)
Received: by tarox.wildebeest.org (Postfix, from userid 1000)
        id BAA02408F0ED; Sun,  7 Feb 2021 15:18:03 +0100 (CET)
Message-ID: <a02164334d0e991820eefa45e2df1a8b49f5537e.camel@klomp.org>
Subject: Re: [PATCH dwarves v2] btf_encoder: sanitize non-regular int base
 type
From:   Mark Wielaard <mark@klomp.org>
To:     Yonghong Song <yhs@fb.com>, acme@kernel.org,
        dwarves@vger.kernel.org
Cc:     bpf@vger.kernel.org, andriin@fb.com, ndesaulniers@google.com,
        sedat.dilek@gmail.com, Andrii Nakryiko <andrii@kernel.org>
Date:   Sun, 07 Feb 2021 15:18:03 +0100
In-Reply-To: <20210207071726.3969978-1-yhs@fb.com>
References: <20210207071726.3969978-1-yhs@fb.com>
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

Hi,

On Sat, 2021-02-06 at 23:17 -0800, Yonghong Song wrote:
> clang with dwarf5 may generate non-regular int base type,
> i.e., not a signed/unsigned char/short/int/longlong/__int128.
> Such base types are often used to describe
> how an actual parameter or variable is generated. For example,
> 
> 0x000015cf:   DW_TAG_base_type
>                 DW_AT_name      ("DW_ATE_unsigned_1")
>                 DW_AT_encoding  (DW_ATE_unsigned)
>                 DW_AT_byte_size (0x00)
> 
> 0x00010ed9:         DW_TAG_formal_parameter
>                       DW_AT_location    (DW_OP_lit0,
>                                          DW_OP_not,
>                                          DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1",
>                                          DW_OP_convert (0x000015d4) "DW_ATE_unsigned_8",
>                                          DW_OP_stack_value)
>                       DW_AT_abstract_origin     (0x00013984 "branch")
> 
> What it does is with a literal "0", did a "not" operation, and the converted to
> one-bit unsigned int and then 8-bit unsigned int.

Thanks for tracking this down. Do you have any idea why the clang
compiler emits this? You might be right that it is intended to do what
you describe it does (but then it would simply encode an unsigned
constant 1 char in a very inefficient way). But as implemented it
doesn't seem to make any sense. What would DW_OP_convert of an zero
sized base type even mean (if it is intended as a 1 bit sized typed,
then why is there no DW_AT_bit_size)?

So I do think your patch makes sense. clang clearly is emitting
something bogus. And so some fixup is needed. But maybe we should at
least give a warning about it, otherwise it might never get fixed.

BTW. If these bogus base types are only emitted as part of a location
expression and not as part of an actual function or variable type
description, then why are we even trying to encode it as a BTF type? It
might be cheaper to just skip/drop it. But maybe the code setup makes
it hard to know whether or not such a (bogus) type is actually
referenced from a function or variable description?

Cheers,

Mark
