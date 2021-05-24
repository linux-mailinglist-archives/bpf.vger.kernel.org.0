Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1292A38F396
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 21:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhEXTWi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 15:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbhEXTWh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 15:22:37 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47324C061574
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 12:21:09 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id y36so22974093ybi.11
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 12:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uPawkITlXjtKLClBcEGUf8uRNSkP6evLq/703mR7mzw=;
        b=QdBYtAuNOE7++oyhjzpA7lzfsUPb261DYW02UnIYl/bP7SpSQcM18VB4VdNvdJEhzI
         D36X+/A8BJO4d8Q351s11WL1OiilkNidSz85jxB5BsEAhO1QmCFoxdKdcPfGzMy1GbzL
         WvISa221XY0WaYDy8mxEdkh9iq1WB15hMnMLRqCJ13l8zmlJSSC5MZ0oCL2j4cXzEczN
         l0qsM+9TojwmLd7G6I4swXOonTg46Q+8ESi550ZhjgbJL61v9R9CyLHSUfjOZoTd9zaM
         69mDY78O09i353wqf0EF3qqmBhBNpra3F4+nQcJ+RVizmWWHCIXqavMhx0nOkt4zcZvk
         y8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPawkITlXjtKLClBcEGUf8uRNSkP6evLq/703mR7mzw=;
        b=a3q64+zMhBVhaoz2hayKHEp0j1S/O3NMsHPtqER4P/Ui7qX14Ldo63/XURzwxxf7hb
         V4N4gA83gQVpuPyf0x5UI0vH6ZLaCmGkD2cHClpXAhc6T2AIj1CZdsGSRBo9pjubvSk8
         u2ZQgyiDMwIlTOyx7nXMr7gfhAq7oEKkbff0THThCg1mcc5ogdXrY0rF5kxOndHd9MH4
         NqN1jTDePajqjta9MZfH5HMU0E++wpfWzylk7/a/Brs38fwL3NUiu/ARFrXw8722F0G+
         dRZ6shEmn2S+54UW5KNeeYdlTW1fWEdvhW087JlhTJJ2jwVbEBCkS9eGiHISJfEco9Dt
         zLZg==
X-Gm-Message-State: AOAM533Wt0WStB0oPRmkPOOkCQzjHR+T9q3aDSdt14ADVkwA8vDy7lHd
        U6uEidKhDjWMuF9WOTBcjnTt/rP58vAqI2yVoQUbhadp
X-Google-Smtp-Source: ABdhPJzU96aKU8IOJuVgtziaaX74Z94DyoLB2vS7+lQRN07+0dGu5OgRSDTe1StDRQZak9hzLcT6MK9UZF+46AmrAAY=
X-Received: by 2002:a5b:286:: with SMTP id x6mr38997081ybl.347.1621884068503;
 Mon, 24 May 2021 12:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210522163925.3757287-1-yhs@fb.com> <CAEf4Bzb+gqH6aB72y+vCaHrq7HNNAROPV+2X0976CzCAmY8Jrw@mail.gmail.com>
 <22162d9d-7e89-53b2-015f-5e88a953c4dd@fb.com>
In-Reply-To: <22162d9d-7e89-53b2-015f-5e88a953c4dd@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 May 2021 12:20:57 -0700
Message-ID: <CAEf4Bzb5CeZsxxApDLKNN5949e1ZzLprT4CSOvBsa5sR2rmTgg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: add llvm_reloc.rst to explain llvm bpf relocations
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 24, 2021 at 11:01 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 5/24/21 10:23 AM, Andrii Nakryiko wrote:
> > On Sat, May 22, 2021 at 9:39 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> LLVM upstream commit https://reviews.llvm.org/D102712
> >> made some changes to bpf relocations to make them
> >> llvm linker lld friendly. The scope of
> >> existing relocations R_BPF_64_{64,32} is narrowed
> >> and new relocations R_BPF_64_{ABS32,ABS64,NODYLD32}
> >> are introduced.
> >>
> >> Let us add some documentation about llvm bpf
> >> relocations so people can understand how to resolve
> >> them properly in their respective tools.
> >>
> >> Cc: John Fastabend <john.fastabend@gmail.com>
> >> Cc: Lorenz Bauer <lmb@cloudflare.com>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   Documentation/bpf/index.rst      |   1 +
> >>   Documentation/bpf/llvm_reloc.rst | 168 +++++++++++++++++++++++++++++++
> >>   2 files changed, 169 insertions(+)
> >>   create mode 100644 Documentation/bpf/llvm_reloc.rst
> >>
> >> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
> >> index a702f67dd45f..93e8cf12a6d4 100644
> >> --- a/Documentation/bpf/index.rst
> >> +++ b/Documentation/bpf/index.rst
> >> @@ -84,6 +84,7 @@ Other
> >>      :maxdepth: 1
> >>
> >>      ringbuf
> >> +   llvm_reloc
> >>
> >>   .. Links:
> >>   .. _networking-filter: ../networking/filter.rst
> >> diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_reloc.rst
> >> new file mode 100644
> >> index 000000000000..bc62bce591b1
> >> --- /dev/null
> >> +++ b/Documentation/bpf/llvm_reloc.rst
> >> @@ -0,0 +1,168 @@
> >> +.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >> +
> >> +====================
> >> +BPF LLVM Relocations
> >> +====================
> >> +
> >> +This document describes LLVM BPF backend relocation types.
> >> +
> >> +Relocation Record
> >> +=================
> >> +
> >> +LLVM BPF backend records each relocation with the following 16-byte
> >> +ELF structure::
> >> +
> >> +  typedef struct
> >> +  {
> >> +    Elf64_Addr    r_offset;  // Offset from the beginning of section.
> >> +    Elf64_Xword   r_info;    // Relocation type and symbol index.
> >> +  } Elf64_Rel;
> >> +
> >> +For static function/variable references, the symbol often refers to
> >> +the section itself which has a value of 0. To identify actual static
> >> +function/variable, its section offset or some computation result
> >> +based on section offset is written to the original insn/data buffer,
> >> +which is called ``IA`` (implicit addend) below.  For global
> >> +function/variables, the symbol refers to actual global and the implicit
> >> +addend is 0.
> >> +
> >> +Different Relocation Types
> >> +==========================
> >> +
> >> +Six relocation types are supported. The following is an overview and
> >> +``S`` represents the value of the symbol in the symbol table::
> >> +
> >> +  Enum  ELF Reloc Type     Description      BitSize  Offset        Calculation
> >> +  0     R_BPF_NONE         None
> >> +  1     R_BPF_64_64        ld_imm64 insn    32       r_offset + 4  S + IA
> >
> > There are cases where we set all 64-bits of ld_imm64 (e.g., extern
> > ksym, global variables). Or those will be a different relocation now
> > (R_BPF_64_ABS64?). If not, I think BitSize 64 is more correct here.
>
> It is still R_BPF_64_64. In llvm, we have restriction that section
> offset must be <= UINT32_MAX, and that is why only 32bit is used
> to find the actual symbol in symbol table. 32bit permits 4GB section
> which should enough in practice for a bpf program.
>
> libbpf or tools can write to full 64bits of imm values of ld_imm64 insn.
>

Ok, sounds good.

> The name is a little bit misleading, but it has become part of ABI
> and lives in /usr/include/elf.h and we are not able to change it
> any more.
>
> >
> > Looking at LLVM diff I haven't found a test for global variables (at
> > least I didn't realize it was there), so double-checking here (and it
> > might be a good idea to have an explicit test for global variables?)
>
> We have llvm/test/CodeGen/BPF/reloc.ll and
> llvm/test/CodeGen/BPF/reloc-btf.ll covering R_BPF_64_ABS64. But I think
> I can enhance
> llvm/test/CodeGen/BPF/reloc-2.ll to cover an explicit global variable case.
>

Great, thanks.

> >
> >> +  2     R_BPF_64_ABS64     normal data      64       r_offset      S + IA
> >> +  3     R_BPF_64_ABS32     normal data      32       r_offset      S + IA
> >> +  4     R_BPF_64_NODYLD32  .BTF[.ext] data  32       r_offset      S + IA
> >> +  10    R_BPF_64_32        call insn        32       r_offset + 4  (S + IA) / 8 - 1
> >> +
> >> +For example, ``R_BPF_64_64`` relocation type is used for ``ld_imm64`` instruction.
> >> +The actual to-be-relocated data is stored at ``r_offset + 4`` and the read/write
> >> +data bitsize is 32 (4 bytes). The relocation can be resolved with
> >> +the symbol value plus implicit addend.
> >> +
> >> +In another case, ``R_BPF_64_ABS64`` relocation type is used for normal 64-bit data.
> >> +The actual to-be-relocated data is stored at ``r_offset`` and the read/write data
> >> +bitsize is 64 (8 bytes). The relocation can be resolved with
> >> +the symbol value plus implicit addend.
> >> +

[...]
