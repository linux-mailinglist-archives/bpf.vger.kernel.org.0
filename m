Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF9A60FA90
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 16:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbiJ0Oji (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 10:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiJ0Ojh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 10:39:37 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861C026576
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 07:39:35 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id f22so1247669qto.3
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4W9neA9Kpon8S9MP6UDODUqYxQ43Symz/mF9Y0tGOA=;
        b=Ab7fAToKMh0Vkf0kupAeSwRnBxeYjo2G4R8H78sWkRIpwpY2aDgPgMgZL/oZhfOUwF
         IUup5yG6+Kx4zt9bgaaYWyBLeQav7as/+7biMg7U36aP5eehGNPw0ISgtBnhSti3iF5N
         f67tTnqqHoWpZwAqhOYd8QJYXZAdC1q8k0p6E/IkMl9cXFGaSTPpDrfKpQfLVYCE5+oq
         Hhw1czjNtNt5hcYrfZJGikF2gAszZybn1v0BP9eQLSyyYbBk11KYC0ZnlmOQ9ouPXQNP
         bDTHHH57+IyPtMFLlV7/wIWfof3mSWf83eexJfq3OlbvbIfMNuHchVMMWIvcDBgNBTOm
         ZVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4W9neA9Kpon8S9MP6UDODUqYxQ43Symz/mF9Y0tGOA=;
        b=vCVDxVEpEF7R0UuVAvUbRlvHJC/RJtAYSjyQXFsp2GNgaj3Un+x1kWDpZWOm4WQDz0
         Bkit843Ow6g8IKqXal8vImXsAuF7rgZ1fMgJolodKPHcnLLbYD+DZS1TuLPDH8nU1gJb
         /fX0dvFmWjO84mrZpAWAVy64B1kXLsUnLpEEIkRojrqOcsB3weVve80p8FZ28DI+OK/T
         5bsQ6TqFmjxJXvL63G7R59KsmjILmvz7egeXrs2RxySYNqMa+eNtdzi/9Yww1aNKRGei
         C4IB4s6SZirFNTUn58JSRjbXoF9ZLp9+Ma74z4sibDzYmKcCRJqciTRwXu/IeT2TPeP+
         tvPw==
X-Gm-Message-State: ACrzQf0Xs6vhlJf5HdzuC6Cs4gYfByoLysjU11FMXPLNhZudUABhcMFg
        aNWyAyY+zarqer/pptTKeQuP38HUk5+MtA==
X-Google-Smtp-Source: AMsMyM7fz+zLh5vmnEK12BzPXn6bJHV3qKQMmCN90QycC7XkR+SFmSO1aKjQHTeAkqzD0T8FDOFCwg==
X-Received: by 2002:a05:622a:38b:b0:39c:e87e:5b3d with SMTP id j11-20020a05622a038b00b0039ce87e5b3dmr40783623qtx.532.1666881574223;
        Thu, 27 Oct 2022 07:39:34 -0700 (PDT)
Received: from mariner-vm.. (c-67-185-99-176.hsd1.wa.comcast.net. [67.185.99.176])
        by smtp.gmail.com with ESMTPSA id n3-20020a05620a294300b006ed138e89f2sm1060825qkp.123.2022.10.27.07.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 07:39:33 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 3/4] bpf, docs: Use consistent names for the same field
Date:   Thu, 27 Oct 2022 14:39:13 +0000
Message-Id: <20221027143914.1928-3-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20221027143914.1928-1-dthaler1968@googlemail.com>
References: <20221027143914.1928-1-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Dave Thaler <dthaler@microsoft.com>

Use consistent names for the same field

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 107 ++++++++++++++++++--------
 1 file changed, 76 insertions(+), 31 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 74dcc13a9..aa1b37cb5 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -35,20 +35,59 @@ Instruction encoding
 eBPF has two instruction encodings:
 
 * the basic instruction encoding, which uses 64 bits to encode an instruction
-* the wide instruction encoding, which appends a second 64-bit immediate value
-  (imm64) after the basic instruction for a total of 128 bits.
+* the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
+  constant) value after the basic instruction for a total of 128 bits.
 
-The basic instruction encoding looks as follows:
+The basic instruction encoding is as follows, where MSB and LSB mean the most significant
+bits and least significant bits, respectively:
 
 =============  =======  ===============  ====================  ============
 32 bits (MSB)  16 bits  4 bits           4 bits                8 bits (LSB)
 =============  =======  ===============  ====================  ============
-immediate      offset   source register  destination register  opcode
+imm            offset   src              dst                   opcode
 =============  =======  ===============  ====================  ============
 
+imm
+  signed integer immediate value
+
+offset
+  signed integer offset used with pointer arithmetic
+
+src
+  the source register number (0-10), except where otherwise specified
+  (`64-bit immediate instructions`_ reuse this field for other purposes)
+
+dst
+  destination register number (0-10)
+
+opcode
+  operation to perform
+
 Note that most instructions do not use all of the fields.
 Unused fields shall be cleared to zero.
 
+As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
+instruction uses a 64-bit immediate value that is constructed as follows.
+The 64 bits following the basic instruction contain a pseudo instruction
+using the same format but with opcode, dst, src, and offset all set to zero,
+and imm containing the high 32 bits of the immediate value.
+
+=================  ==================
+64 bits (MSB)      64 bits (LSB)
+=================  ==================
+basic instruction  pseudo instruction
+=================  ==================
+
+Thus the 64-bit immediate value is constructed as follows:
+
+  imm64 = imm + (next_imm << 32)
+
+where 'next_imm' refers to the imm value of the pseudo instruction
+following the basic instruction.
+
+In the remainder of this document 'src' and 'dst' refer to the values of the source
+and destination registers, respectively, rather than the register number.
+
 Instruction classes
 -------------------
 
@@ -76,20 +115,24 @@ For arithmetic and jump instructions (``BPF_ALU``, ``BPF_ALU64``, ``BPF_JMP`` an
 ==============  ======  =================
 4 bits (MSB)    1 bit   3 bits (LSB)
 ==============  ======  =================
-operation code  source  instruction class
+code            source  instruction class
 ==============  ======  =================
 
-The 4th bit encodes the source operand:
+code
+  the operation code, whose meaning varies by instruction class
 
-  ======  =====  ========================================
-  source  value  description
-  ======  =====  ========================================
-  BPF_K   0x00   use 32-bit immediate as source operand
-  BPF_X   0x08   use 'src_reg' register as source operand
-  ======  =====  ========================================
+source
+  the source operand location, which unless otherwise specified is one of:
 
-The four MSB bits store the operation code.
+  ======  =====  ==========================================
+  source  value  description
+  ======  =====  ==========================================
+  BPF_K   0x00   use 32-bit 'imm' value as source operand
+  BPF_X   0x08   use 'src' register value as source operand
+  ======  =====  ==========================================
 
+instruction class
+  the instruction class (see `Instruction classes`_)
 
 Arithmetic instructions
 -----------------------
@@ -117,6 +160,8 @@ BPF_ARSH  0xc0   sign extending shift right
 BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
 ========  =====  ==========================================================
 
+where 'src' is the source operand value.
+
 Underflow and overflow are allowed during arithmetic operations,
 meaning the 64-bit or 32-bit value will wrap.  If
 eBPF program execution would result in division by zero,
@@ -126,21 +171,21 @@ the destination register is instead left unchanged.
 
 ``BPF_ADD | BPF_X | BPF_ALU`` means::
 
-  dst_reg = (u32) dst_reg + (u32) src_reg;
+  dst = (u32) ((u32) dst + (u32) src)
 
 where '(u32)' indicates truncation to 32 bits.
 
 ``BPF_ADD | BPF_X | BPF_ALU64`` means::
 
-  dst_reg = dst_reg + src_reg
+  dst = dst + src
 
 ``BPF_XOR | BPF_K | BPF_ALU`` means::
 
-  src_reg = (u32) src_reg ^ (u32) imm32
+  src = (u32) src ^ (u32) imm
 
 ``BPF_XOR | BPF_K | BPF_ALU64`` means::
 
-  src_reg = src_reg ^ imm32
+  src = src ^ imm
 
 Also note that the division and modulo operations are unsigned,
 where 'imm' is first sign extended to 64 bits and then converted
@@ -173,11 +218,11 @@ Examples:
 
 ``BPF_ALU | BPF_TO_LE | BPF_END`` with imm = 16 means::
 
-  dst_reg = htole16(dst_reg)
+  dst = htole16(dst)
 
 ``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 64 means::
 
-  dst_reg = htobe64(dst_reg)
+  dst = htobe64(dst)
 
 Jump instructions
 -----------------
@@ -252,15 +297,15 @@ instructions that transfer data between a register and memory.
 
 ``BPF_MEM | <size> | BPF_STX`` means::
 
-  *(size *) (dst_reg + off) = src_reg
+  *(size *) (dst + offset) = src_reg
 
 ``BPF_MEM | <size> | BPF_ST`` means::
 
-  *(size *) (dst_reg + off) = imm32
+  *(size *) (dst + offset) = imm32
 
 ``BPF_MEM | <size> | BPF_LDX`` means::
 
-  dst_reg = *(size *) (src_reg + off)
+  dst = *(size *) (src + offset)
 
 Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
 
@@ -294,11 +339,11 @@ BPF_XOR   0xa0   atomic xor
 
 ``BPF_ATOMIC | BPF_W  | BPF_STX`` with 'imm' = BPF_ADD means::
 
-  *(u32 *)(dst_reg + off16) += src_reg
+  *(u32 *)(dst + offset) += src
 
 ``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF ADD means::
 
-  *(u64 *)(dst_reg + off16) += src_reg
+  *(u64 *)(dst + offset) += src
 
 In addition to the simple atomic operations, there also is a modifier and
 two complex atomic operations:
@@ -313,16 +358,16 @@ BPF_CMPXCHG  0xf0 | BPF_FETCH  atomic compare and exchange
 
 The ``BPF_FETCH`` modifier is optional for simple atomic operations, and
 always set for the complex atomic operations.  If the ``BPF_FETCH`` flag
-is set, then the operation also overwrites ``src_reg`` with the value that
+is set, then the operation also overwrites ``src`` with the value that
 was in memory before it was modified.
 
-The ``BPF_XCHG`` operation atomically exchanges ``src_reg`` with the value
-addressed by ``dst_reg + off``.
+The ``BPF_XCHG`` operation atomically exchanges ``src`` with the value
+addressed by ``dst + offset``.
 
 The ``BPF_CMPXCHG`` operation atomically compares the value addressed by
-``dst_reg + off`` with ``R0``. If they match, the value addressed by
-``dst_reg + off`` is replaced with ``src_reg``. In either case, the
-value that was at ``dst_reg + off`` before the operation is zero-extended
+``dst + offset`` with ``R0``. If they match, the value addressed by
+``dst + offset`` is replaced with ``src``. In either case, the
+value that was at ``dst + offset`` before the operation is zero-extended
 and loaded back to ``R0``.
 
 64-bit immediate instructions
@@ -335,7 +380,7 @@ There is currently only one such instruction.
 
 ``BPF_LD | BPF_DW | BPF_IMM`` means::
 
-  dst_reg = imm64
+  dst = imm64
 
 
 Legacy BPF Packet access instructions
-- 
2.33.4

