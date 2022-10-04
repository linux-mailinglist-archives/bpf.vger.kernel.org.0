Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0975F4C2C
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 00:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJDWr6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 18:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiJDWr4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 18:47:56 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952066E2D7
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 15:47:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d24so13903485pls.4
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 15:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zEN3tJpO8t5ZqWwyNkIZ+G7P4+jm/GP+61Xy5HR+PNs=;
        b=QFVeWuJqKXKFre5KI+N33U+Qv4fstjllxZpe7j8kOPSwdfEaDQ9k1aHO+EoGV8sLcA
         VT2yfMGuyPhZMfw/lHd/moJOozICzHcmU7MfYYRQI+QpYAtfZuhQJuHsUowS6ru7YRu4
         S6suI39KphtGYFMq8tjpLioed2uLN9E8wOx5IG0DesgCpRzM966zaMtTBiYLMdrT6wkO
         2+lt6si3cyoSuI93TImUwFSis9Iqy1JPWoyWzz1vhSkW10HsZzdCKHaWRHRHtT5xvZeo
         AZ/GRr1HxNfe6i1SeVR8x371KVYT6EedflyY6ki4zmBqNRcKsubkfuYM8k/EuoLkL6pk
         lReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zEN3tJpO8t5ZqWwyNkIZ+G7P4+jm/GP+61Xy5HR+PNs=;
        b=XO4fog4yGi33x1qnC35bvIIwsvzHTiYv7zq1FDNeRflOgr5pExPLlQNEJDxG1s9HVH
         MPzJ3ltY5IPUkSr9DWpyG+7ZGLKqruFL6LG3DP5USYn7WOaorAdNT9Xqd/1Q/6dmKR5O
         NmIY073jBGlwr9UwqhNkutO3c6jfWOEynH2htHSk8K8sTZzYY4zzzpJt5l64DTtoOoWI
         Tojvbr323a850gjGL+ydkEBC7s2s8Ai1Jv2oH2P4jNxAsutFeyGkUOEiJSValzMtLJJK
         zW3xLRHKahNdJAr/yP94Zg4dM+dYqkhVVmY72+TI+q1d21sj9FKo9BWt+nh+E4zL5CRx
         IxhQ==
X-Gm-Message-State: ACrzQf1r941tZvgP615gAOvhhVML9fSOQxNk7BFx30W4hPw+6u297BHR
        6oMYT94Aea36FWgjZDDkZtrWRY9ngXI=
X-Google-Smtp-Source: AMsMyM5REV+Ay/iev+8aN+7lMkdJy64zovKcymzQ5pM5d0lWOLfuFJkHcuVl8JhmXWLZ3zUYcbgsNg==
X-Received: by 2002:a17:902:9a8b:b0:17a:455:d967 with SMTP id w11-20020a1709029a8b00b0017a0455d967mr28354291plp.52.1664923673226;
        Tue, 04 Oct 2022 15:47:53 -0700 (PDT)
Received: from mariner-vm.. ([131.107.174.139])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b0016c0eb202a5sm9487369plg.225.2022.10.04.15.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 15:47:52 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 5/9] bpf, docs: Add appendix of all opcodes in order
Date:   Tue,  4 Oct 2022 22:47:41 +0000
Message-Id: <20221004224745.1430-5-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20221004224745.1430-1-dthaler1968@googlemail.com>
References: <20221004224745.1430-1-dthaler1968@googlemail.com>
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

Add appendix of all opcodes in order.
A couple of reviewers explicitly asked for this and have indicated it was
the most useful addition in the doc.

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 200 +++++++++++++++++++++++++-
 1 file changed, 199 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index f9e56d9d5..7c1e245df 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -11,7 +11,8 @@ Documentation conventions
 =========================
 
 For brevity, this document uses the type notion "u64", "u32", etc.
-to mean an unsigned integer whose width is the specified number of bits.
+to mean an unsigned integer whose width is the specified number of bits,
+and "s32", etc. to mean a signed integer of the specified number of bits.
 
 Registers and calling convention
 ================================
@@ -405,3 +406,200 @@ Legacy BPF Packet access instructions
 eBPF previously introduced special instructions for access to packet data that were
 carried over from classic BPF. However, these instructions are
 deprecated and should no longer be used.
+
+Appendix
+========
+
+For reference, the following table lists opcodes in order by value.
+
+======  ===  ====  ===================================================  ========================================
+opcode  src  imm   description                                          reference
+======  ===  ====  ===================================================  ========================================
+0x00    0x0  any   (additional immediate value)                         `64-bit immediate instructions`_
+0x04    0x0  any   dst = (u32)(dst + imm)                               `Arithmetic instructions`_
+0x05    0x0  0x00  goto +offset                                         `Jump instructions`_
+0x07    0x0  any   dst += imm                                           `Arithmetic instructions`_
+0x0c    any  0x00  dst = (u32)(dst + src)                               `Arithmetic instructions`_
+0x0f    any  0x00  dst += src                                           `Arithmetic instructions`_
+0x14    0x0  any   dst = (u32)(dst - imm)                               `Arithmetic instructions`_
+0x15    0x0  any   if dst == imm goto +offset                           `Jump instructions`_
+0x16    0x0  any   if (u32)dst == imm goto +offset                      `Jump instructions`_
+0x17    0x0  any   dst -= imm                                           `Arithmetic instructions`_
+0x18    0x0  any   dst = imm64                                          `64-bit immediate instructions`_
+0x1c    any  0x00  dst = (u32)(dst - src)                               `Arithmetic instructions`_
+0x1d    any  0x00  if dst == src goto +offset                           `Jump instructions`_
+0x1e    any  0x00  if (u32)dst == (u32)src goto +offset                 `Jump instructions`_
+0x1f    any  0x00  dst -= src                                           `Arithmetic instructions`_
+0x20    any  any   (deprecated, implementation-specific)                `Legacy BPF Packet access instructions`_
+0x24    0x0  any   dst = (u32)(dst \* imm)                              `Arithmetic instructions`_
+0x25    0x0  any   if dst > imm goto +offset                            `Jump instructions`_
+0x26    0x0  any   if (u32)dst > imm goto +offset                       `Jump instructions`_
+0x27    0x0  any   dst \*= imm                                          `Arithmetic instructions`_
+0x28    any  any   (deprecated, implementation-specific)                `Legacy BPF Packet access instructions`_
+0x2c    any  0x00  dst = (u32)(dst \* src)                              `Arithmetic instructions`_
+0x2d    any  0x00  if dst > src goto +offset                            `Jump instructions`_
+0x2e    any  0x00  if (u32)dst > (u32)src goto +offset                  `Jump instructions`_
+0x2f    any  0x00  dst \*= src                                          `Arithmetic instructions`_
+0x30    any  any   (deprecated, implementation-specific)                `Legacy BPF Packet access instructions`_
+0x34    0x0  any   dst = (u32)((imm != 0) ? (dst / imm) : 0)            `Arithmetic instructions`_
+0x35    0x0  any   if dst >= imm goto +offset                           `Jump instructions`_
+0x36    0x0  any   if (u32)dst >= imm goto +offset                      `Jump instructions`_
+0x37    0x0  any   dst = (imm != 0) ? (dst / imm) : 0                   `Arithmetic instructions`_
+0x38    any  any   (deprecated, implementation-specific)                `Legacy BPF Packet access instructions`_
+0x3c    any  0x00  dst = (u32)((imm != 0) ? (dst / src) : 0)            `Arithmetic instructions`_
+0x3d    any  0x00  if dst >= src goto +offset                           `Jump instructions`_
+0x3e    any  0x00  if (u32)dst >= (u32)src goto +offset                 `Jump instructions`_
+0x3f    any  0x00  dst = (src !+ 0) ? (dst / src) : 0                   `Arithmetic instructions`_
+0x40    any  any   (deprecated, implementation-specific)                `Legacy BPF Packet access instructions`_
+0x44    0x0  any   dst = (u32)(dst \| imm)                              `Arithmetic instructions`_
+0x45    0x0  any   if dst & imm goto +offset                            `Jump instructions`_
+0x46    0x0  any   if (u32)dst & imm goto +offset                       `Jump instructions`_
+0x47    0x0  any   dst \|= imm                                          `Arithmetic instructions`_
+0x48    any  any   (deprecated, implementation-specific)                `Legacy BPF Packet access instructions`_
+0x4c    any  0x00  dst = (u32)(dst \| src)                              `Arithmetic instructions`_
+0x4d    any  0x00  if dst & src goto +offset                            `Jump instructions`_
+0x4e    any  0x00  if (u32)dst & (u32)src goto +offset                  `Jump instructions`_
+0x4f    any  0x00  dst \|= src                                          `Arithmetic instructions`_
+0x50    any  any   (deprecated, implementation-specific)                `Legacy BPF Packet access instructions`_
+0x54    0x0  any   dst = (u32)(dst & imm)                               `Arithmetic instructions`_
+0x55    0x0  any   if dst != imm goto +offset                           `Jump instructions`_
+0x56    0x0  any   if (u32)dst != imm goto +offset                      `Jump instructions`_
+0x57    0x0  any   dst &= imm                                           `Arithmetic instructions`_
+0x58    any  any   (deprecated, implementation-specific)                `Legacy BPF Packet access instructions`_
+0x5c    any  0x00  dst = (u32)(dst & src)                               `Arithmetic instructions`_
+0x5d    any  0x00  if dst != src goto +offset                           `Jump instructions`_
+0x5e    any  0x00  if (u32)dst != (u32)src goto +offset                 `Jump instructions`_
+0x5f    any  0x00  dst &= src                                           `Arithmetic instructions`_
+0x61    any  0x00  dst = \*(u32 \*)(src + offset)                       `Load and store instructions`_
+0x62    0x0  any   \*(u32 \*)(dst + offset) = imm                       `Load and store instructions`_
+0x63    any  0x00  \*(u32 \*)(dst + offset) = src                       `Load and store instructions`_
+0x64    0x0  any   dst = (u32)(dst << imm)                              `Arithmetic instructions`_
+0x65    0x0  any   if dst s> imm goto +offset                           `Jump instructions`_
+0x66    0x0  any   if (s32)dst s> (s32)imm goto +offset                 `Jump instructions`_
+0x67    0x0  any   dst <<= imm                                          `Arithmetic instructions`_
+0x69    any  0x00  dst = \*(u16 \*)(src + offset)                       `Load and store instructions`_
+0x6a    0x0  any   \*(u16 \*)(dst + offset) = imm                       `Load and store instructions`_
+0x6b    any  0x00  \*(u16 \*)(dst + offset) = src                       `Load and store instructions`_
+0x6c    any  0x00  dst = (u32)(dst << src)                              `Arithmetic instructions`_
+0x6d    any  0x00  if dst s> src goto +offset                           `Jump instructions`_
+0x6e    any  0x00  if (s32)dst s> (s32)src goto +offset                 `Jump instructions`_
+0x6f    any  0x00  dst <<= src                                          `Arithmetic instructions`_
+0x71    any  0x00  dst = \*(u8 \*)(src + offset)                        `Load and store instructions`_
+0x72    0x0  any   \*(u8 \*)(dst + offset) = imm                        `Load and store instructions`_
+0x73    any  0x00  \*(u8 \*)(dst + offset) = src                        `Load and store instructions`_
+0x74    0x0  any   dst = (u32)(dst >> imm)                              `Arithmetic instructions`_
+0x75    0x0  any   if dst s>= imm goto +offset                          `Jump instructions`_
+0x76    0x0  any   if (s32)dst s>= (s32)imm goto +offset                `Jump instructions`_
+0x77    0x0  any   dst >>= imm                                          `Arithmetic instructions`_
+0x79    any  0x00  dst = \*(u64 \*)(src + offset)                       `Load and store instructions`_
+0x7a    0x0  any   \*(u64 \*)(dst + offset) = imm                       `Load and store instructions`_
+0x7b    any  0x00  \*(u64 \*)(dst + offset) = src                       `Load and store instructions`_
+0x7c    any  0x00  dst = (u32)(dst >> src)                              `Arithmetic instructions`_
+0x7d    any  0x00  if dst s>= src goto +offset                          `Jump instructions`_
+0x7e    any  0x00  if (s32)dst s>= (s32)src goto +offset                `Jump instructions`_
+0x7f    any  0x00  dst >>= src                                          `Arithmetic instructions`_
+0x84    0x0  0x00  dst = (u32)-dst                                      `Arithmetic instructions`_
+0x85    0x0  any   call helper function imm                             `Helper functions`_
+0x87    0x0  0x00  dst = -dst                                           `Arithmetic instructions`_
+0x94    0x0  any   dst = (u32)((imm != 0) ? (dst % imm) : dst)          `Arithmetic instructions`_
+0x95    0x0  0x00  return                                               `Jump instructions`_
+0x97    0x0  any   dst = (imm != 0) ? (dst % imm) : dst                 `Arithmetic instructions`_
+0x9c    any  0x00  dst = (u32)((src != 0) ? (dst % src) : dst)          `Arithmetic instructions`_
+0x9f    any  0x00  dst = (src != 0) ? (dst % src) : dst                 `Arithmetic instructions`_
+0xa4    0x0  any   dst = (u32)(dst ^ imm)                               `Arithmetic instructions`_
+0xa5    0x0  any   if dst < imm goto +offset                            `Jump instructions`_
+0xa6    0x0  any   if (u32)dst < imm goto +offset                       `Jump instructions`_
+0xa7    0x0  any   dst ^= imm                                           `Arithmetic instructions`_
+0xac    any  0x00  dst = (u32)(dst ^ src)                               `Arithmetic instructions`_
+0xad    any  0x00  if dst < src goto +offset                            `Jump instructions`_
+0xae    any  0x00  if (u32)dst < (u32)src goto +offset                  `Jump instructions`_
+0xaf    any  0x00  dst ^= src                                           `Arithmetic instructions`_
+0xb4    0x0  any   dst = (u32) imm                                      `Arithmetic instructions`_
+0xb5    0x0  any   if dst <= imm goto +offset                           `Jump instructions`_
+0xa6    0x0  any   if (u32)dst <= imm goto +offset                      `Jump instructions`_
+0xb7    0x0  any   dst = imm                                            `Arithmetic instructions`_
+0xbc    any  0x00  dst = (u32) src                                      `Arithmetic instructions`_
+0xbd    any  0x00  if dst <= src goto +offset                           `Jump instructions`_
+0xbe    any  0x00  if (u32)dst <= (u32)src goto +offset                 `Jump instructions`_
+0xbf    any  0x00  dst = src                                            `Arithmetic instructions`_
+0xc3    any  0x00  lock \*(u32 \*)(dst + offset) += src                 `Atomic operations`_
+0xc3    any  0x01  lock::                                               `Atomic operations`_
+
+                       *(u32 *)(dst + offset) += src
+                       src = *(u32 *)(dst + offset)
+0xc3    any  0x40  \*(u32 \*)(dst + offset) \|= src                     `Atomic operations`_
+0xc3    any  0x41  lock::                                               `Atomic operations`_
+
+                       *(u32 *)(dst + offset) |= src
+                       src = *(u32 *)(dst + offset)
+0xc3    any  0x50  \*(u32 \*)(dst + offset) &= src                      `Atomic operations`_
+0xc3    any  0x51  lock::                                               `Atomic operations`_
+
+                       *(u32 *)(dst + offset) &= src
+                       src = *(u32 *)(dst + offset)
+0xc3    any  0xa0  \*(u32 \*)(dst + offset) ^= src                      `Atomic operations`_
+0xc3    any  0xa1  lock::                                               `Atomic operations`_
+
+                       *(u32 *)(dst + offset) ^= src
+                       src = *(u32 *)(dst + offset)
+0xc3    any  0xe1  lock::                                               `Atomic operations`_
+
+                       temp = *(u32 *)(dst + offset)
+                       *(u32 *)(dst + offset) = src
+                       src = temp
+0xc3    any  0xf1  lock::                                               `Atomic operations`_
+
+                       temp = *(u32 *)(dst + offset)
+                       if *(u32)(dst + offset) == R0
+                          *(u32)(dst + offset) = src
+                       R0 = temp
+0xc4    0x0  any   dst = (u32)(dst s>> imm)                             `Arithmetic instructions`_
+0xc5    0x0  any   if dst s< imm goto +offset                           `Jump instructions`_
+0xc6    0x0  any   if (s32)dst s< (s32)imm goto +offset                 `Jump instructions`_
+0xc7    0x0  any   dst s>>= imm                                         `Arithmetic instructions`_
+0xcc    any  0x00  dst = (u32)(dst s>> src)                             `Arithmetic instructions`_
+0xcd    any  0x00  if dst s< src goto +offset                           `Jump instructions`_
+0xce    any  0x00  if (s32)dst s< (s32)src goto +offset                 `Jump instructions`_
+0xcf    any  0x00  dst s>>= src                                         `Arithmetic instructions`_
+0xd4    0x0  0x10  dst = htole16(dst)                                   `Byte swap instructions`_
+0xd4    0x0  0x20  dst = htole32(dst)                                   `Byte swap instructions`_
+0xd4    0x0  0x40  dst = htole64(dst)                                   `Byte swap instructions`_
+0xd5    0x0  any   if dst s<= imm goto +offset                          `Jump instructions`_
+0xd6    0x0  any   if (s32)dst s<= (s32)imm goto +offset                `Jump instructions`_
+0xdb    any  0x00  lock \*(u64 \*)(dst + offset) += src                 `Atomic operations`_
+0xdb    any  0x01  lock::                                               `Atomic operations`_
+
+                       *(u64 *)(dst + offset) += src
+                       src = *(u64 *)(dst + offset)
+0xdb    any  0x40  \*(u64 \*)(dst + offset) \|= src                     `Atomic operations`_
+0xdb    any  0x41  lock::                                               `Atomic operations`_
+
+                       *(u64 *)(dst + offset) |= src
+                       lock src = *(u64 *)(dst + offset)
+0xdb    any  0x50  \*(u64 \*)(dst + offset) &= src                      `Atomic operations`_
+0xdb    any  0x51  lock::                                               `Atomic operations`_
+
+                       *(u64 *)(dst + offset) &= src
+                       src = *(u64 *)(dst + offset)
+0xdb    any  0xa0  \*(u64 \*)(dst + offset) ^= src                      `Atomic operations`_
+0xdb    any  0xa1  lock::                                               `Atomic operations`_
+
+                       *(u64 *)(dst + offset) ^= src
+                       src = *(u64 *)(dst + offset)
+0xdb    any  0xe1  lock::                                               `Atomic operations`_
+
+                       temp = *(u64 *)(dst + offset)
+                       *(u64 *)(dst + offset) = src
+                       src = temp
+0xdb    any  0xf1  lock::                                               `Atomic operations`_
+
+                       temp = *(u64 *)(dst + offset)
+                       if *(u64)(dst + offset) == R0
+                          *(u64)(dst + offset) = src
+                       R0 = temp
+0xdc    0x0  0x10  dst = htobe16(dst)                                   `Byte swap instructions`_
+0xdc    0x0  0x20  dst = htobe32(dst)                                   `Byte swap instructions`_
+0xdc    0x0  0x40  dst = htobe64(dst)                                   `Byte swap instructions`_
+0xdd    any  0x00  if dst s<= src goto +offset                          `Jump instructions`_
+0xde    any  0x00  if (s32)dst s<= (s32)src goto +offset                `Jump instructions`_
+======  ===  ====  ===================================================  ========================================
-- 
2.33.4

