Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B9931401F
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 21:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbhBHUPw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 15:15:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235728AbhBHUOd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 15:14:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72AA764DBD;
        Mon,  8 Feb 2021 20:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612815232;
        bh=9eiwOuTAuQybZ5MgTtMQsWZbpd4rExiKQ++TQauyoek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NBzHR2vgevsqVf5FKjDbORTh9MAHPBQBv389JfC+B7IdRXASz+6AsGG14opKR4mx0
         159ro3C5gKmY8op4VsSERV2jSFZtJ/psn65eOZ3wgwiiW2y7CNYxookeqvE5I5ZUGq
         hyMuxM0AuovIaE4r20gRA3X6ySI+36qb0DANtGRsHHtaAJkPGsWDuIfwixiJUWlMpt
         mPE5nzc0Zn50JioLviJ0ZElKlW6TFETl+qx5dMLVDf6DOGxJ+3wTpyLENCkCDxh79/
         hyfAZoKSWhFnwRGb49zEO/MKFwZ8lzvAvbU0/O6v7WszfOuAKBB+GT3o0YCHrM+aDE
         kohA/JW0zF5mg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DB48140513; Mon,  8 Feb 2021 17:13:49 -0300 (-03)
Date:   Mon, 8 Feb 2021 17:13:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Mark Wielaard <mark@klomp.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH dwarves v2] btf_encoder: sanitize non-regular int base
 type
Message-ID: <20210208201349.GU920417@kernel.org>
References: <20210207071726.3969978-1-yhs@fb.com>
 <CAKwvOdm81yoFXg65XPc=PTOC+P7J9TJuFc3ag9TvFkjGW0iGVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm81yoFXg65XPc=PTOC+P7J9TJuFc3ag9TvFkjGW0iGVg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Feb 08, 2021 at 11:22:48AM -0800, Nick Desaulniers escreveu:
> On Sat, Feb 6, 2021 at 11:17 PM Yonghong Song <yhs@fb.com> wrote:
> >
> > clang with dwarf5 may generate non-regular int base type,
> > i.e., not a signed/unsigned char/short/int/longlong/__int128.
> > Such base types are often used to describe
> > how an actual parameter or variable is generated. For example,
> >
> > 0x000015cf:   DW_TAG_base_type
> >                 DW_AT_name      ("DW_ATE_unsigned_1")
> >                 DW_AT_encoding  (DW_ATE_unsigned)
> >                 DW_AT_byte_size (0x00)
> >
> > 0x00010ed9:         DW_TAG_formal_parameter
> >                       DW_AT_location    (DW_OP_lit0,
> >                                          DW_OP_not,
> >                                          DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1",
> >                                          DW_OP_convert (0x000015d4) "DW_ATE_unsigned_8",
> >                                          DW_OP_stack_value)
> >                       DW_AT_abstract_origin     (0x00013984 "branch")
> >
> > What it does is with a literal "0", did a "not" operation, and the converted to
> > one-bit unsigned int and then 8-bit unsigned int.
> >
> > Another example,
> >
> > 0x000e97e4:   DW_TAG_base_type
> >                 DW_AT_name      ("DW_ATE_unsigned_24")
> >                 DW_AT_encoding  (DW_ATE_unsigned)
> >                 DW_AT_byte_size (0x03)
> >
> > 0x000f88f8:     DW_TAG_variable
> >                   DW_AT_location        (indexed (0x3c) loclist = 0x00008fb0:
> >                      [0xffffffff82808812, 0xffffffff82808817):
> >                          DW_OP_breg0 RAX+0,
> >                          DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> >                          DW_OP_convert (0x000e97df) "DW_ATE_unsigned_8",
> >                          DW_OP_stack_value,
> >                          DW_OP_piece 0x1,
> >                          DW_OP_breg0 RAX+0,
> >                          DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> >                          DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> >                          DW_OP_lit8,
> >                          DW_OP_shr,
> >                          DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> >                          DW_OP_convert (0x000e97e4) "DW_ATE_unsigned_24",
> >                          DW_OP_stack_value,
> >                          DW_OP_piece 0x3
> >                      ......
> >
> > At one point, a right shift by 8 happens and the result is converted to
> > 32-bit unsigned int and then to 24-bit unsigned int.
> >
> > BTF does not need any of these DW_OP_* information and such non-regular int
> > types will cause libbpf to emit errors.
> > Let us sanitize them to generate BTF acceptable to libbpf and kernel.
> >
> > Cc: Sedat Dilek <sedat.dilek@gmail.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> 
> Thanks for the patch!
> 
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for testing and documenting that you tested, added the tag to
the commit,

- Arnaldo
