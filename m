Return-Path: <bpf+bounces-6200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B8C766E23
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 15:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE50282759
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 13:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7458B134D1;
	Fri, 28 Jul 2023 13:25:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25806C8C9
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 13:25:39 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3FD3C1F
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 06:25:35 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5841be7d15eso22629227b3.2
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 06:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690550734; x=1691155534;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MoQztmq/owaUYKeTT86IIMDbE5VM6+xqb0RmJ0Hk9A=;
        b=EWOBq10wlmunBS7S6e574vIklsvAvvdUjHOHIUcPFhVOftmY4zBu6SQWvQyh0IEN65
         X9WdHRfIVIUFcUiyPtBC1i1yEF904vnyH5jXdp0aozMZgAB8ANeRAjS8YDx6SPaKyRl5
         aiWa6z32GANebmMSBwCiMydGtf89G0CYEY16w6/h6Nq4Luv4oPfWgW4O2faT9goMYAjN
         Pa7JSSbJig4gnUNdW58ySk7Ei7WeNBpSi0YbMfj7qOk6sAljlqG+FMa6ehtUco41N/Qi
         EPKGdYVWWQFrlpWSFT+FnW3WYunZtRM/17BoCPJXNTv30uE8k4qhSC1yZcvVwaon6LZZ
         52sw==
X-Gm-Message-State: ABy/qLYtUk4V+dvsVafYLd8sAx/2+3rTTzws1hB8VDKElc5RzPMobnj3
	Aax93XyeZqu2w7Gu/g2wNBA=
X-Google-Smtp-Source: APBJJlF/48DI1eCsMNav6vuhFBnuy/BwH36M0QnUCNXh4iLmcp2FQ/kcvBEIbVUVcC0LmIVyvNP7Tw==
X-Received: by 2002:a0d:d98f:0:b0:577:2f3f:c712 with SMTP id b137-20020a0dd98f000000b005772f3fc712mr1664429ywe.40.1690550733824;
        Fri, 28 Jul 2023 06:25:33 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id g185-20020a0dddc2000000b005844f8d6d6csm1051203ywe.134.2023.07.28.06.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 06:25:33 -0700 (PDT)
Date: Fri, 28 Jul 2023 08:25:31 -0500
From: David Vernet <void@manifault.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Faust <david.faust@oracle.com>,
	Fangrui Song <maskray@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
	bpf@ietf.org
Subject: Re: [PATCH bpf-next v5 17/17] docs/bpf: Add documentation for new
 instructions
Message-ID: <20230728132531.GA7328@maniforge>
References: <20230728011143.3710005-1-yonghong.song@linux.dev>
 <20230728011342.3724411-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728011342.3724411-1-yonghong.song@linux.dev>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 06:13:42PM -0700, Yonghong Song wrote:
> Add documentation in instruction-set.rst for new instruction encoding
> and their corresponding operations. Also removed the question
> related to 'no BPF_SDIV' in bpf_design_QA.rst since we have
> BPF_SDIV insn now.

Sorry for reviewing this after it was merged. Leaving some thoughts
which can be addressed in a subsequent patch.

> 
> Cc: bpf@ietf.org
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  Documentation/bpf/bpf_design_QA.rst           |   5 -
>  .../bpf/standardization/instruction-set.rst   | 115 ++++++++++++------
>  2 files changed, 79 insertions(+), 41 deletions(-)
> 
> diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
> index 38372a956d65..eb19c945f4d5 100644
> --- a/Documentation/bpf/bpf_design_QA.rst
> +++ b/Documentation/bpf/bpf_design_QA.rst
> @@ -140,11 +140,6 @@ A: Because if we picked one-to-one relationship to x64 it would have made
>  it more complicated to support on arm64 and other archs. Also it
>  needs div-by-zero runtime check.
>  
> -Q: Why there is no BPF_SDIV for signed divide operation?
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -A: Because it would be rarely used. llvm errors in such case and
> -prints a suggestion to use unsigned divide instead.
> -
>  Q: Why BPF has implicit prologue and epilogue?
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  A: Because architectures like sparc have register windows and in general
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> index 6ef5534b410a..23e880a83a1f 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -154,24 +154,27 @@ otherwise identical operations.
>  The 'code' field encodes the operation as below, where 'src' and 'dst' refer
>  to the values of the source and destination registers, respectively.
>  
> -========  =====  ==========================================================
> -code      value  description
> -========  =====  ==========================================================
> -BPF_ADD   0x00   dst += src
> -BPF_SUB   0x10   dst -= src
> -BPF_MUL   0x20   dst \*= src
> -BPF_DIV   0x30   dst = (src != 0) ? (dst / src) : 0
> -BPF_OR    0x40   dst \|= src
> -BPF_AND   0x50   dst &= src
> -BPF_LSH   0x60   dst <<= (src & mask)
> -BPF_RSH   0x70   dst >>= (src & mask)
> -BPF_NEG   0x80   dst = -dst
> -BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
> -BPF_XOR   0xa0   dst ^= src
> -BPF_MOV   0xb0   dst = src
> -BPF_ARSH  0xc0   sign extending dst >>= (src & mask)
> -BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
> -========  =====  ==========================================================
> +========  =====  =======  ==========================================================
> +code      value  offset   description
> +========  =====  =======  ==========================================================
> +BPF_ADD   0x00   0        dst += src
> +BPF_SUB   0x10   0        dst -= src
> +BPF_MUL   0x20   0        dst \*= src
> +BPF_DIV   0x30   0        dst = (src != 0) ? (dst / src) : 0
> +BPF_SDIV  0x30   1        dst = (src != 0) ? (dst s/ src) : 0
> +BPF_OR    0x40   0        dst \|= src
> +BPF_AND   0x50   0        dst &= src
> +BPF_LSH   0x60   0        dst <<= (src & mask)
> +BPF_RSH   0x70   0        dst >>= (src & mask)
> +BPF_NEG   0x80   0        dst = -dst
> +BPF_MOD   0x90   0        dst = (src != 0) ? (dst % src) : dst
> +BPF_SMOD  0x90   1        dst = (src != 0) ? (dst s% src) : dst
> +BPF_XOR   0xa0   0        dst ^= src
> +BPF_MOV   0xb0   0        dst = src
> +BPF_MOVSX 0xb0   8/16/32  dst = (s8,s16,s32)src
> +BPF_ARSH  0xc0   0        sign extending dst >>= (src & mask)
> +BPF_END   0xd0   0        byte swap operations (see `Byte swap instructions`_ below)
> +========  =====  ============  ==========================================================

Looks like the alignment is off here.

>  
>  Underflow and overflow are allowed during arithmetic operations, meaning
>  the 64-bit or 32-bit value will wrap. If eBPF program execution would
> @@ -198,11 +201,20 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
>  
>    dst = dst ^ imm32
>  
> -Also note that the division and modulo operations are unsigned. Thus, for
> -``BPF_ALU``, 'imm' is first interpreted as an unsigned 32-bit value, whereas
> -for ``BPF_ALU64``, 'imm' is first sign extended to 64 bits and the result
> -interpreted as an unsigned 64-bit value. There are no instructions for
> -signed division or modulo.
> +Note that most instructions have instruction offset of 0. But three instructions
> +(BPF_SDIV, BPF_SMOD, BPF_MOVSX) have non-zero offset.

Can we be consistent with where we apply ``<code>``? It we're going to
e.g. apply it to ``BPF_ALU`` below, we should apply it here as well
(note that there are a couple small grammatical changes as well):

Note that most instructions have an offset of 0. Only three instructions
(``BPF_SDIV``, ``BPF_SMOD``, ``BPF_MOVSX``) have a non-zero offset.

> +
> +The devision and modulo operations support both unsigned and signed flavors.
> +For unsigned operation (BPF_DIV and BPF_MOD), for ``BPF_ALU``, 'imm' is first
> +interpreted as an unsigned 32-bit value, whereas for ``BPF_ALU64``, 'imm' is
> +first sign extended to 64 bits and the result interpreted as an unsigned 64-bit

I prefer the form of how you described the BPF_SDIV and BPF_SMOD
instructions below. Can we use that for BPF_DIV / BPD_MOD, i.e.:

For unsigned operations (``BPF_DIV`` and ``BPF_MOD``), for ``BPF_ALU``,
'imm' is interpreted as a 32-bit unsigned value. For ``BPF_ALU64``,
'imm' is first sign extended from 32 to 64 bits, and then interpreted as
a 64-bit unsigned value.
/B
> +value.  For signed operation (BPF_SDIV and BPF_SMOD), for ``BPF_ALU``, 'imm' is

Same suggestion as above (``, and s/operation/operations)

> +interpreted as a signed value. For ``BPF_ALU64``, the 'imm' is sign extended
> +from 32 to 64 and interpreted as a signed 64-bit value.

Also suggest a slight modification to exactly match the form of the
unsigned description:

For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
'imm' is interpreted as a 32-bit signed value. For ``BPF_ALU64``, 'imm'
is first sign extended from 32 to 64 bits, and then interpreted as a
64-bit signed value.

> +
> +Instruction BPF_MOVSX does move operation with sign extension.

The ``BPF_MOVSX`` instruction does a move operation with sign extension.

> +``BPF_ALU | MOVSX`` sign extendes 8-bit and 16-bit into 32-bit and upper 32-bit are zeroed.

``BPF_ALU | BPF_MOVSX`` sign extends 8-bit and 16-bit operands into 32
bit operands, and zeroes the remaining upper 32 bits.

> +``BPF_ALU64 | MOVSX`` sign extends 8-bit, 16-bit and 32-bit into 64-bit.

``BPF_ALU64 | BPF_MOVSX`` sign extends 8-bit, 16-bit, and 32-bit
operands into 64 bit operands.

>  
>  Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F (31)
>  for 32-bit operations.
> @@ -210,21 +222,23 @@ for 32-bit operations.
>  Byte swap instructions
>  ~~~~~~~~~~~~~~~~~~~~~~

Not your change, but this underline should be converted to ----- to
match the other instruction type sections.

>  
> -The byte swap instructions use an instruction class of ``BPF_ALU`` and a 4-bit
> -'code' field of ``BPF_END``.
> +The byte swap instructions use instruction classes of ``BPF_ALU`` and ``BPF_ALU64``
> +and a 4-bit 'code' field of ``BPF_END``.
>  
>  The byte swap instructions operate on the destination register
>  only and do not use a separate source register or immediate value.
>  
> -The 1-bit source operand field in the opcode is used to select what byte
> -order the operation convert from or to:
> +For ``BPF_ALU``, the 1-bit source operand field in the opcode is used to select what byte
> +order the operation convert from or to. For ``BPF_ALU64``, the 1-bit source operand
> +field in the opcode is not used and must be 0.

For ``BPF_ALU``, the 1-bit source operand field in the opcode is used to
select what byte order the operation converts from or to. For
``BPF_ALU64``, the 1-bit source operand field in the opcode is reserved
and must be set to 0.

> -=========  =====  =================================================
> -source     value  description
> -=========  =====  =================================================
> -BPF_TO_LE  0x00   convert between host byte order and little endian
> -BPF_TO_BE  0x08   convert between host byte order and big endian
> -=========  =====  =================================================
> +=========  =========  =====  =================================================
> +class      source     value  description
> +=========  =========  =====  =================================================
> +BPF_ALU    BPF_TO_LE  0x00   convert between host byte order and little endian
> +BPF_ALU    BPF_TO_BE  0x08   convert between host byte order and big endian
> +BPF_ALU64  BPF_TO_LE  0x00   do byte swap unconditionally

Should we say "Unused" or "Reserved" for BPF_ALU64 rather than
BPF_TO_LE?

> +=========  =========  =====  =================================================
>  
>  The 'imm' field encodes the width of the swap operations.  The following widths
>  are supported: 16, 32 and 64.
> @@ -239,6 +253,12 @@ Examples:
>  
>    dst = htobe64(dst)
>  
> +``BPF_ALU64 | BPF_TO_LE | BPF_END`` with imm = 16/32/64 means::
> +
> +  dst = bswap16 dst
> +  dst = bswap32 dst
> +  dst = bswap64 dst
> +
>  Jump instructions
>  -----------------
>  
> @@ -249,7 +269,8 @@ The 'code' field encodes the operation as below:
>  ========  =====  ===  ===========================================  =========================================
>  code      value  src  description                                  notes
>  ========  =====  ===  ===========================================  =========================================
> -BPF_JA    0x0    0x0  PC += offset                                 BPF_JMP only
> +BPF_JA    0x0    0x0  PC += offset                                 BPF_JMP class
> +BPF_JA    0x0    0x0  PC += imm                                    BPF_JMP32 class
>  BPF_JEQ   0x1    any  PC += offset if dst == src
>  BPF_JGT   0x2    any  PC += offset if dst > src                    unsigned
>  BPF_JGE   0x3    any  PC += offset if dst >= src                   unsigned
> @@ -278,6 +299,16 @@ Example:
>  
>  where 's>=' indicates a signed '>=' comparison.
>  
> +``BPF_JA | BPF_K | BPF_JMP32`` (0x06) means::
> +
> +  gotol +imm
> +
> +where 'imm' means the branch offset comes from insn 'imm' field.
> +
> +Note there are two flavors of BPF_JA instrions. BPF_JMP class permits 16-bit jump offset while
> +BPF_JMP32 permits 32-bit jump offset. A >16bit conditional jmp can be converted to a <16bit
> +conditional jmp plus a 32-bit unconditional jump.

Note that there are two flavors of ``BPF_JA`` instructions. The
``BPF_JMP`` class permits a 16-bit jump offset specified by 'offset'
field, whereas the ``BPF_JMP32`` class permits a 32-bit jump offset
specified by the 'imm' field. A > 16-bit conditional jump may be
converted to a < 16-bit conditional jump plus a 32-bit unconditional
jump.

> +
>  Helper functions
>  ~~~~~~~~~~~~~~~~
>  
> @@ -320,6 +351,7 @@ The mode modifier is one of:
>    BPF_ABS        0x20   legacy BPF packet access (absolute)   `Legacy BPF Packet access instructions`_
>    BPF_IND        0x40   legacy BPF packet access (indirect)   `Legacy BPF Packet access instructions`_
>    BPF_MEM        0x60   regular load and store operations     `Regular load and store operations`_
> +  BPF_MEMSX      0x80   sign-extension load operations        `Sign-extension load operations`_
>    BPF_ATOMIC     0xc0   atomic operations                     `Atomic operations`_
>    =============  =====  ====================================  =============
>  
> @@ -350,9 +382,20 @@ instructions that transfer data between a register and memory.
>  
>  ``BPF_MEM | <size> | BPF_LDX`` means::
>  
> -  dst = *(size *) (src + offset)
> +  dst = *(unsigned size *) (src + offset)
> +
> +Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW`` and
> +'unsigned size' is one of u8, u16, u32 and u64.

s/and/or

> +
> +The ``BPF_MEMSX`` mode modifier is used to encode sign-extension load
> +instructions that transfer data between a register and memory.
> +
> +``BPF_MEMSX | <size> | BPF_LDX`` means::
> +
> +  dst = *(signed size *) (src + offset)
>  
> -Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
> +Where size is one of: ``BPF_B``, ``BPF_H`` or ``BPF_W``, and
> +'signed size' is one of s8, s16 and s32.

s/and/or

>  
>  Atomic operations
>  -----------------
> -- 
> 2.34.1
> 
> 

