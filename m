Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02436051A5
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 22:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJSU5d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 16:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJSU5c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 16:57:32 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638031BFBA9
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 13:57:31 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id o14-20020a056a00214e00b0056238ef46ebso9955914pfk.2
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 13:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iIDKUnCFZmkW0C8lHK0snuN783wF+SGvVl3OibRT+VI=;
        b=h8wmMroE0buPrcYmRXim+56sEAdJfP1fhIx54/YEwdEEz0q4KNcRLbDHgB4XGV1fQW
         G9u4gXarFgVRuFEXTNHZ7Oe6B428w+sbLROgz6y+6CX++MN52FgedTm/aiehdOXhyRD5
         U0iRH/Q9Rd21ye8br0t3hKqQuktq+MC7HeTP8m7idq0HGbhAbpE6qwgn8SwAegwmoA+f
         96afgYYK9TzCDWRXee+gn9J1mrDBqHHkiOZPNk6gXWr6kXCLffL9F+ixANTK3SVr9Dun
         9uHqTIxjAmxt4nV36oI3lq6OFAA1nUZcsWPByfQVX0jaQH0X9jvzmVsdpr4tnxojacp0
         ToDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIDKUnCFZmkW0C8lHK0snuN783wF+SGvVl3OibRT+VI=;
        b=kC8USD0Le8YvYqjIVuibT3dURMFMg3b8ELDHuI699uIwTvIuVhuagWeM6577sXSPgM
         S9qcfXTp7RCwYGDJiayB8nxK+M2W8sitefiK3QAi4LTeBoKG/XzmFLb4SYdiqJeyjKQQ
         9zNt2Np3hiJyF9BFt1tadzbwgWRnDpsotKDE9aNrlvs0dPvkcySZkQVe5C22WqWddyR9
         VR+fuCNsGFXyS+yIdENSOF23glL9YTgq/gHyIPl6SRW4IlsKs5DV7CkGoNAvO+VpY23A
         xe7kQLQL6K0Dm+TN7eZrzTIeLOOCLicGM1/3ZMxIYN4/MQGlcBztkfHn+986s3CDSXz/
         youw==
X-Gm-Message-State: ACrzQf3EU3MIkirpa90u6fvJ4BBQEzOXCOZJRW25LAMBr6KwTGQBor58
        czW/y/BvUkQ4F3p/8j+F+GJNn6k=
X-Google-Smtp-Source: AMsMyM7Q8GXECq43tLL8SweMxfseEPDB77qLBVvjXfAdIQywa2BcWlea6QsYycNkHVLbB+4WOBlVnuI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:22c1:b0:185:5276:92e5 with SMTP id
 y1-20020a17090322c100b00185527692e5mr10390270plg.134.1666213050949; Wed, 19
 Oct 2022 13:57:30 -0700 (PDT)
Date:   Wed, 19 Oct 2022 13:57:29 -0700
In-Reply-To: <20221019183845.905-3-dthaler1968@googlemail.com>
Mime-Version: 1.0
References: <20221019183845.905-1-dthaler1968@googlemail.com> <20221019183845.905-3-dthaler1968@googlemail.com>
Message-ID: <Y1BkuZKW7nCUrbx/@google.com>
Subject: Re: [PATCH 3/4] bpf, docs: Use consistent names for the same field
From:   sdf@google.com
To:     dthaler1968@googlemail.com
Cc:     bpf@vger.kernel.org, Dave Thaler <dthaler@microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/19, dthaler1968@googlemail.com wrote:
> From: Dave Thaler <dthaler@microsoft.com>

> Use consistent names for the same field

> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>   Documentation/bpf/instruction-set.rst | 107 ++++++++++++++++++--------
>   1 file changed, 76 insertions(+), 31 deletions(-)

> diff --git a/Documentation/bpf/instruction-set.rst  
> b/Documentation/bpf/instruction-set.rst
> index 3a64d4b49..29b599c70 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -35,20 +35,59 @@ Instruction encoding
>   eBPF has two instruction encodings:

>   * the basic instruction encoding, which uses 64 bits to encode an  
> instruction
> -* the wide instruction encoding, which appends a second 64-bit immediate  
> value
> -  (imm64) after the basic instruction for a total of 128 bits.
> +* the wide instruction encoding, which appends a second 64-bit immediate  
> (i.e.,
> +  constant) value after the basic instruction for a total of 128 bits.

> -The basic instruction encoding looks as follows:
> +The basic instruction encoding is as follows, where MSB and LSB mean the  
> most significant
> +bits and least significant bits, respectively:

>   =============  =======  ===============  ====================   
> ============
>   32 bits (MSB)  16 bits  4 bits           4 bits                8 bits  
> (LSB)
>   =============  =======  ===============  ====================   
> ============
> -immediate      offset   source register  destination register  opcode
> +imm            offset   src              dst                   opcode
>   =============  =======  ===============  ====================   
> ============

> +imm
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
>   Note that most instructions do not use all of the fields.
>   Unused fields shall be cleared to zero.

> +As discussed below in `64-bit immediate instructions`_, a 64-bit  
> immediate
> +instruction uses a 64-bit immediate value that is constructed as follows.
> +The 64 bits following the basic instruction contain a pseudo instruction
> +using the same format but with opcode, dst, src, and offset all set to  
> zero,
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
> +  imm64 = imm + (next_imm << 32)
> +
> +where 'next_imm' refers to the imm value of the pseudo instruction
> +following the basic instruction.
> +
> +In the remainder of this document 'src' and 'dst' refer to the values of  
> the source
> +and destination registers, respectively, rather than the register number.
> +
>   Instruction classes
>   -------------------

> @@ -76,20 +115,24 @@ For arithmetic and jump instructions (``BPF_ALU``,  
> ``BPF_ALU64``, ``BPF_JMP`` an
>   ==============  ======  =================
>   4 bits (MSB)    1 bit   3 bits (LSB)
>   ==============  ======  =================
> -operation code  source  instruction class
> +code            source  instruction class
>   ==============  ======  =================

> -The 4th bit encodes the source operand:
> +code
> +  the operation code, whose meaning varies by instruction class

> -  ======  =====  ========================================
> -  source  value  description
> -  ======  =====  ========================================
> -  BPF_K   0x00   use 32-bit immediate as source operand
> -  BPF_X   0x08   use 'src_reg' register as source operand
> -  ======  =====  ========================================
> +source
> +  the source operand location, which unless otherwise specified is one  
> of:

> -The four MSB bits store the operation code.
> +  ======  =====  ==========================================
> +  source  value  description
> +  ======  =====  ==========================================
> +  BPF_K   0x00   use 32-bit 'imm' value as source operand
> +  BPF_X   0x08   use 'src' register value as source operand
> +  ======  =====  ==========================================

> +instruction class
> +  the instruction class (see `Instruction classes`_)

>   Arithmetic instructions
>   -----------------------
> @@ -117,6 +160,8 @@ BPF_ARSH  0xc0   sign extending shift right
>   BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_  
> below)
>   ========  =====   
> ==========================================================

> +where 'src' is the source operand value.
> +
>   Underflow and overflow are allowed during arithmetic operations,
>   meaning the 64-bit or 32-bit value will wrap.  If
>   eBPF program execution would result in division by zero,
> @@ -126,21 +171,21 @@ the destination register is instead left unchanged.

>   ``BPF_ADD | BPF_X | BPF_ALU`` means::

> -  dst_reg = (u32) dst_reg + (u32) src_reg;
> +  dst = (u32) (dst + src)

IIUC, by going from (u32) + (u32) to (u32)(), we want to signal that
the value will just wrap around? But isn't it more confusing now
because it's unclear what the sign of the dst/src is (s32 vs u32)?

Also, we do keep (u32) ^ (u32) for BPF_XOR below..


>   where '(u32)' indicates truncation to 32 bits.

>   ``BPF_ADD | BPF_X | BPF_ALU64`` means::

> -  dst_reg = dst_reg + src_reg
> +  dst = dst + src

>   ``BPF_XOR | BPF_K | BPF_ALU`` means::

> -  src_reg = (u32) src_reg ^ (u32) imm32
> +  src = (u32) src ^ (u32) imm

>   ``BPF_XOR | BPF_K | BPF_ALU64`` means::

> -  src_reg = src_reg ^ imm32
> +  src = src ^ imm

>   Also note that the division and modulo operations are unsigned,
>   where 'imm' is first sign extended to 64 bits and then converted
> @@ -173,11 +218,11 @@ Examples:

>   ``BPF_ALU | BPF_TO_LE | BPF_END`` with imm = 16 means::

> -  dst_reg = htole16(dst_reg)
> +  dst = htole16(dst)

>   ``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 64 means::

> -  dst_reg = htobe64(dst_reg)
> +  dst = htobe64(dst)

>   Jump instructions
>   -----------------
> @@ -252,15 +297,15 @@ instructions that transfer data between a register  
> and memory.

>   ``BPF_MEM | <size> | BPF_STX`` means::

> -  *(size *) (dst_reg + off) = src_reg
> +  *(size *) (dst + offset) = src_reg

>   ``BPF_MEM | <size> | BPF_ST`` means::

> -  *(size *) (dst_reg + off) = imm32
> +  *(size *) (dst + offset) = imm32

>   ``BPF_MEM | <size> | BPF_LDX`` means::

> -  dst_reg = *(size *) (src_reg + off)
> +  dst = *(size *) (src + offset)

>   Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.

> @@ -294,11 +339,11 @@ BPF_XOR   0xa0   atomic xor

>   ``BPF_ATOMIC | BPF_W  | BPF_STX`` with 'imm' = BPF_ADD means::

> -  *(u32 *)(dst_reg + off16) += src_reg
> +  *(u32 *)(dst + offset) += src

>   ``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF ADD means::

> -  *(u64 *)(dst_reg + off16) += src_reg
> +  *(u64 *)(dst + offset) += src

>   In addition to the simple atomic operations, there also is a modifier and
>   two complex atomic operations:
> @@ -313,16 +358,16 @@ BPF_CMPXCHG  0xf0 | BPF_FETCH  atomic compare and  
> exchange

>   The ``BPF_FETCH`` modifier is optional for simple atomic operations, and
>   always set for the complex atomic operations.  If the ``BPF_FETCH`` flag
> -is set, then the operation also overwrites ``src_reg`` with the value  
> that
> +is set, then the operation also overwrites ``src`` with the value that
>   was in memory before it was modified.

> -The ``BPF_XCHG`` operation atomically exchanges ``src_reg`` with the  
> value
> -addressed by ``dst_reg + off``.
> +The ``BPF_XCHG`` operation atomically exchanges ``src`` with the value
> +addressed by ``dst + offset``.

>   The ``BPF_CMPXCHG`` operation atomically compares the value addressed by
> -``dst_reg + off`` with ``R0``. If they match, the value addressed by
> -``dst_reg + off`` is replaced with ``src_reg``. In either case, the
> -value that was at ``dst_reg + off`` before the operation is zero-extended
> +``dst + offset`` with ``R0``. If they match, the value addressed by
> +``dst + offset`` is replaced with ``src``. In either case, the
> +value that was at ``dst + offset`` before the operation is zero-extended
>   and loaded back to ``R0``.

>   64-bit immediate instructions
> @@ -335,7 +380,7 @@ There is currently only one such instruction.

>   ``BPF_LD | BPF_DW | BPF_IMM`` means::

> -  dst_reg = imm64
> +  dst = imm64


>   Legacy BPF Packet access instructions
> --
> 2.33.4

