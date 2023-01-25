Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6947F67BC6E
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 21:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbjAYUSY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 15:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbjAYUSV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 15:18:21 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82C9457F2
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 12:18:19 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id w15so4167206qvs.11
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 12:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cYtHZjWsrd7R0LtWjDZLi5QD+qP4+8mntk7kXWvmHI=;
        b=NNf+7yUQ6Z85EvEe8RN8qUeQhbhV1TSTB/xTL34SZhvvqfumCZfA6lL9XIXsXr76PR
         keNdJjjm71ZhGmwTht8APE+Z5CQzZPZWpDe0Da5EAxmOg/bwEcYlUQGqHbL3583ERNIj
         zAE0W83gv6f5LowXj4l+aKST/9Hf8zbaUIXvAlTyE5KFA6E77bqlQsgCccq7BrVCyufh
         9tG14BigLv7ouZ9g9U9+XQSvSPV/FHk/hemwKafdrs0Q8vDP9HPBTP55RPbWCDh/5Tuh
         ilwZzmxFJ1Kf+eDLya80OjpD6LrAOGxAZ0oVDs2JgpwskSdVCi3eAt3Doz3F1k0hadi/
         FtPA==
X-Gm-Message-State: AFqh2kplTB9elk/LwDRRPTDR7uZVPQOeAOVQTntv7zCKM9C/nxnppytR
        3Vk8vijfQzMLIuC/xBew48E=
X-Google-Smtp-Source: AMrXdXv+FEmexcSxZIOz4rUscTGMEwyshvq5mMbagZNdlGpnZy2DALiIVt7MZQyNkCTfHFFQd4kmqA==
X-Received: by 2002:a05:6214:3b89:b0:4c7:7257:68a2 with SMTP id nf9-20020a0562143b8900b004c7725768a2mr52339551qvb.15.1674677898801;
        Wed, 25 Jan 2023 12:18:18 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:113e])
        by smtp.gmail.com with ESMTPSA id ay38-20020a05620a17a600b006fcb77f3bd6sm4199094qkb.98.2023.01.25.12.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:18:18 -0800 (PST)
Date:   Wed, 25 Jan 2023 14:18:16 -0600
From:   David Vernet <void@manifault.com>
To:     dthaler1968@googlemail.com
Cc:     bpf@vger.kernel.org, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>
Subject: Re: [PATCH] bpf, docs: Use consistent names for the same field
Message-ID: <Y9GOiIbWz5mL0nSv@maniforge>
References: <20230125185817.6408-1-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125185817.6408-1-dthaler1968@googlemail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 25, 2023 at 06:58:17PM +0000, dthaler1968@googlemail.com wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Use consistent names for the same field, e.g., 'dst' vs 'dst_reg'.
> Previously a mix of terms were used for the same thing in various cases.
> 
> Changes since last submission: addressed comments from Alexei and Stanislav

In the future, if sending subsequent iterations of a patch, could you
please follow the typical versioning  and changelog convention described
in [0]?

[0]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/instruction-set.rst | 105 ++++++++++++++++++--------
>  1 file changed, 74 insertions(+), 31 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 2d3fe59bd26..3778c807cbb 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -30,20 +30,59 @@ Instruction encoding
>  eBPF has two instruction encodings:
>  
>  * the basic instruction encoding, which uses 64 bits to encode an instruction
> -* the wide instruction encoding, which appends a second 64-bit immediate value
> -  (imm64) after the basic instruction for a total of 128 bits.
> +* the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
> +  constant) value after the basic instruction for a total of 128 bits.
>  
> -The basic instruction encoding looks as follows:
> +The basic instruction encoding is as follows, where MSB and LSB mean the most significant
> +bits and least significant bits, respectively:
>  
>  =============  =======  ===============  ====================  ============
>  32 bits (MSB)  16 bits  4 bits           4 bits                8 bits (LSB)
>  =============  =======  ===============  ====================  ============
> -immediate      offset   source register  destination register  opcode
> +imm            offset   src              dst                   opcode

What's the rationale for changing source register and destination
register to src and dst respectively here? Below you clarify that they
mean something other than register number after this section in the
document, so why not just leave them as is here to avoid any confusion?

>  =============  =======  ===============  ====================  ============
>  
> +imm

Can we make all of these bold, just to slightly improve readability.
E.g.:

**imm**

> +  signed integer immediate value
> +
> +offset
> +  signed integer offset used with pointer arithmetic
> +
> +src
> +  the source register number (0-10), except where otherwise specified
> +  (`64-bit immediate instructions`_ reuse this field for other purposes)
> +
> +dst
> +  destination register number (0-10)
> +
> +opcode
> +  operation to perform
> +
>  Note that most instructions do not use all of the fields.
>  Unused fields shall be cleared to zero.
>  
> +As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
> +instruction uses a 64-bit immediate value that is constructed as follows.

FWIW, I'd consider moving this description of how imm64 is encoded into
the 64-bit immediate instructions section, as it only has relevance in
that context anyways.

What do you think?

> +The 64 bits following the basic instruction contain a pseudo instruction
> +using the same format but with opcode, dst, src, and offset all set to zero,
> +and imm containing the high 32 bits of the immediate value.
> +
> +=================  ==================
> +64 bits (MSB)      64 bits (LSB)
> +=================  ==================
> +basic instruction  pseudo instruction
> +=================  ==================
> +
> +Thus the 64-bit immediate value is constructed as follows:
> +
> +  imm64 = (next_imm << 32) | imm
> +
> +where 'next_imm' refers to the imm value of the pseudo instruction
> +following the basic instruction.
> +
> +In the remainder of this document 'src' and 'dst' refer to the values of the source
> +and destination registers, respectively, rather than the register number.
> +
>  Instruction classes
>  -------------------
>  
> @@ -71,20 +110,24 @@ For arithmetic and jump instructions (``BPF_ALU``, ``BPF_ALU64``, ``BPF_JMP`` an
>  ==============  ======  =================
>  4 bits (MSB)    1 bit   3 bits (LSB)
>  ==============  ======  =================
> -operation code  source  instruction class
> +code            source  instruction class
>  ==============  ======  =================
>  
> -The 4th bit encodes the source operand:
> +code
> +  the operation code, whose meaning varies by instruction class
>  
> -  ======  =====  ========================================
> -  source  value  description
> -  ======  =====  ========================================
> -  BPF_K   0x00   use 32-bit immediate as source operand
> -  BPF_X   0x08   use 'src_reg' register as source operand
> -  ======  =====  ========================================
> +source
> +  the source operand location, which unless otherwise specified is one of:
>  
> -The four MSB bits store the operation code.
> +  ======  =====  ==========================================
> +  source  value  description
> +  ======  =====  ==========================================
> +  BPF_K   0x00   use 32-bit 'imm' value as source operand
> +  BPF_X   0x08   use 'src' register value as source operand
> +  ======  =====  ==========================================
>  
> +instruction class
> +  the instruction class (see `Instruction classes`_)
>  
>  Arithmetic instructions
>  -----------------------
> @@ -121,19 +164,19 @@ the destination register is unchanged whereas for ``BPF_ALU`` the upper
>  
>  ``BPF_ADD | BPF_X | BPF_ALU`` means::
>  
> -  dst_reg = (u32) dst_reg + (u32) src_reg;
> +  dst = (u32) ((u32) dst + (u32) src)
>  
>  ``BPF_ADD | BPF_X | BPF_ALU64`` means::
>  
> -  dst_reg = dst_reg + src_reg
> +  dst = dst + src
>  
>  ``BPF_XOR | BPF_K | BPF_ALU`` means::
>  
> -  dst_reg = (u32) dst_reg ^ (u32) imm32
> +  dst = (u32) dst ^ (u32) imm32
>  
>  ``BPF_XOR | BPF_K | BPF_ALU64`` means::
>  
> -  dst_reg = dst_reg ^ imm32
> +  dst = dst ^ imm32
>  
>  Also note that the division and modulo operations are unsigned. Thus, for
>  ``BPF_ALU``, 'imm' is first interpreted as an unsigned 32-bit value, whereas
> @@ -167,11 +210,11 @@ Examples:
>  
>  ``BPF_ALU | BPF_TO_LE | BPF_END`` with imm = 16 means::
>  
> -  dst_reg = htole16(dst_reg)
> +  dst = htole16(dst)
>  
>  ``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 64 means::
>  
> -  dst_reg = htobe64(dst_reg)
> +  dst = htobe64(dst)
>  
>  Jump instructions
>  -----------------
> @@ -246,15 +289,15 @@ instructions that transfer data between a register and memory.
>  
>  ``BPF_MEM | <size> | BPF_STX`` means::
>  
> -  *(size *) (dst_reg + off) = src_reg
> +  *(size *) (dst + offset) = src_reg

s/src_reg/src

>  
>  ``BPF_MEM | <size> | BPF_ST`` means::
>  
> -  *(size *) (dst_reg + off) = imm32
> +  *(size *) (dst + offset) = imm32
>  
>  ``BPF_MEM | <size> | BPF_LDX`` means::
>  
> -  dst_reg = *(size *) (src_reg + off)
> +  dst = *(size *) (src + offset)
>  
>  Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
>  
> @@ -288,11 +331,11 @@ BPF_XOR   0xa0   atomic xor
>  
>  ``BPF_ATOMIC | BPF_W  | BPF_STX`` with 'imm' = BPF_ADD means::
>  
> -  *(u32 *)(dst_reg + off16) += src_reg
> +  *(u32 *)(dst + offset) += src
>  
>  ``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF ADD means::
>  
> -  *(u64 *)(dst_reg + off16) += src_reg
> +  *(u64 *)(dst + offset) += src
>  
>  In addition to the simple atomic operations, there also is a modifier and
>  two complex atomic operations:
> @@ -307,16 +350,16 @@ BPF_CMPXCHG  0xf0 | BPF_FETCH  atomic compare and exchange
>  
>  The ``BPF_FETCH`` modifier is optional for simple atomic operations, and
>  always set for the complex atomic operations.  If the ``BPF_FETCH`` flag
> -is set, then the operation also overwrites ``src_reg`` with the value that
> +is set, then the operation also overwrites ``src`` with the value that
>  was in memory before it was modified.
>  
> -The ``BPF_XCHG`` operation atomically exchanges ``src_reg`` with the value
> -addressed by ``dst_reg + off``.
> +The ``BPF_XCHG`` operation atomically exchanges ``src`` with the value
> +addressed by ``dst + offset``.
>  
>  The ``BPF_CMPXCHG`` operation atomically compares the value addressed by
> -``dst_reg + off`` with ``R0``. If they match, the value addressed by
> -``dst_reg + off`` is replaced with ``src_reg``. In either case, the
> -value that was at ``dst_reg + off`` before the operation is zero-extended
> +``dst + offset`` with ``R0``. If they match, the value addressed by
> +``dst + offset`` is replaced with ``src``. In either case, the
> +value that was at ``dst + offset`` before the operation is zero-extended
>  and loaded back to ``R0``.
>  
>  64-bit immediate instructions
> @@ -329,7 +372,7 @@ There is currently only one such instruction.
>  
>  ``BPF_LD | BPF_DW | BPF_IMM`` means::
>  
> -  dst_reg = imm64
> +  dst = imm64
>  
>  
>  Legacy BPF Packet access instructions
> -- 
> 2.33.4
> 
