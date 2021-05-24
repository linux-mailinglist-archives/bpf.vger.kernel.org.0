Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C4B38F39D
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 21:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhEXTZx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 15:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhEXTZv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 15:25:51 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84978C061574
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 12:24:22 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id l15so14318582ilh.1
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 12:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=g15IefYHukcIPWxtp11fXkXbUtQM6+EJ2yRe5AZ8YbY=;
        b=gTJSfwyFWDP4AzTNbr+y0yesYlZCR/TbmpBqBLUhcL3urblaE4DrSuXkAN4am/OPDp
         M5V6qTCBGdfzhTu0dHwA+ezT2cw67FyV3mvMGhQ0Xvzg/a2oiNTH0yKlOl8cWB4xnYpO
         HagYsjxKRhGXLY/J/YJCfTAljB/jjwYYYQEHBt3lAA64N93kANcNngLxVd6B4P8YZ7fx
         +kdnfHxvKaqWvwNoZDC23Q6XY14636T5cd+clrHIi0KaB+IZOkFJ5pOctl51HtvI7ilL
         9O5qYViNVLBqjLZh76mBeutK2Ijj/oD5q5a8WZHhOC78Khcrh0VKAK0olxiCO78LHqO+
         AB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=g15IefYHukcIPWxtp11fXkXbUtQM6+EJ2yRe5AZ8YbY=;
        b=JVxZFhhbKrqBzFh7oeHdSiY1c5YK6l7x3spHEgmraHXzq0LEQ2XTgy9A5hOrkeS51j
         Q7GcvbuKJOA8ew6UdJTYy3DHVgmHBOstsnOdpLC7rvw2HjXXu/DPSXjPBuFYKHt3UsqQ
         Vx6R6cPKzV2OOdA0Rs5LiPvv2qORqp1Z3slPC4U77rixuKY4dBjjLt6azxKTjAQrU92S
         15YMod3SYejzbg5sH3wkALtysg0LaSUdiStzMmtB6eTlFi2AwNHwVxcK08u8T1+kuytD
         iTzkKaPoCadigwmKuQZVfbBZJkwNi5tafK2BzHG32YlRQg/AnQkDHZ1KygHE1WFPfrAw
         wsrA==
X-Gm-Message-State: AOAM531ZAgz91vHEhxgqNSTu7nMQhfAl+tlYNEdYkWeMPgenMJGXowLR
        eZn8t9YX1tVYWT5JucAR0Qs=
X-Google-Smtp-Source: ABdhPJx+NAuu+ss4QoV2uyoHl/Y4+BdOUFC5+oTTl+K0bh27RaKzVuGoxZaxMlcYBRXsFwdl6B4uWg==
X-Received: by 2002:a05:6e02:104e:: with SMTP id p14mr19466575ilj.109.1621884261713;
        Mon, 24 May 2021 12:24:21 -0700 (PDT)
Received: from localhost ([172.242.244.146])
        by smtp.gmail.com with ESMTPSA id j10sm11573649ilk.87.2021.05.24.12.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 12:24:21 -0700 (PDT)
Date:   Mon, 24 May 2021 12:24:13 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Message-ID: <60abfd5d94d7_135f6208cd@john-XPS-13-9370.notmuch>
In-Reply-To: <22162d9d-7e89-53b2-015f-5e88a953c4dd@fb.com>
References: <20210522163925.3757287-1-yhs@fb.com>
 <CAEf4Bzb+gqH6aB72y+vCaHrq7HNNAROPV+2X0976CzCAmY8Jrw@mail.gmail.com>
 <22162d9d-7e89-53b2-015f-5e88a953c4dd@fb.com>
Subject: Re: [PATCH bpf-next] docs/bpf: add llvm_reloc.rst to explain llvm bpf
 relocations
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
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

Thanks Yonghong, I found this helpful. I still had to crack
open llvm code though to follow along. A couple small suggestions
below, may or may not be useful. Overall looks good. 

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

Above was too terse for me to follow without looking into some clang
examples. Maybe an example right here would help not sure? Maybe expand
the text a bit? I don't have a really good suggestion.

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

^^^ maybe add this note in the doc somewhere? I had similar questions.

> 
> libbpf or tools can write to full 64bits of imm values of ld_imm64 insn.
> 
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

^^^ maybe cross-reference llvm tests from kernel docs side? I often look at
these when I get something unexpected/unknown maybe others would find
it helpful, but not know where to look?

> 
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
> >> +Both ``R_BPF_64_ABS32`` and ``R_BPF_64_NODYLD32`` types are for 32-bit data.
> >> +But ``R_BPF_64_NODYLD32`` specifically refers to relocations in ``.BTF`` and
> >> +``.BTF.ext`` sections. For cases like bcc where llvm ``ExecutionEngine RuntimeDyld``
> >> +is involved, ``R_BPF_64_NODYLD32`` types of relocations should not be resolved
> >> +to actual function/variable address. Otherwise, ``.BTF`` and ``.BTF.ext``
> >> +become unusable by bcc and kernel.
> >> +
> >> +Type ``R_BPF_64_32`` is used for call instruction. The call target section
> >> +offset is stored at ``r_offset + 4`` (32bit) and calculated as
> >> +``(S + IA) / 8 - 1``.
> >> +
> >> +Examples
> >> +========
> >> +

I liked the examples.
