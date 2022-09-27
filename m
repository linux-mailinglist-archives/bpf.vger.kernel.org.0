Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1626D5ECC88
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 21:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiI0TAU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 15:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiI0TAS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5691591C7
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l9-20020a17090a4d4900b00205e295400eso1583293pjh.4
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=sH8TUxBxA7sfvMxNoaNLX5BJpgCrsSg83OKotwSQSZk=;
        b=eiAjzKDxK1gK8dWo2bFxMLFDTCURD7t8kTfaKH8kFTNjJ4mOgdfrqbBWoeS25WVlvg
         dRKH6Hf8HKDr4Uii1Npi2AP+ZeyGGIgGm6x1ADvsGYwY+zUOAWTu2f+SG7w2Gwf2mYBX
         koblvjTdTp/77Bb8HY1MUX0lKqe42DnH8C8Um3LFff9CPA8++T57R0Wmr8Cmgn9/TDEk
         XNaRX4itoccTA/b30wewTJCczrkP1xITv+7xh/c2yeC2W8vjYXzSbrqw+mDeEN3/Yem9
         hRLo1peaAiVTmJrFAmMFgcLzqbb73CGontwTo27mFunWCHyEQOLcbx0EKgL7TyNRB1zd
         AWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=sH8TUxBxA7sfvMxNoaNLX5BJpgCrsSg83OKotwSQSZk=;
        b=B4XuZpqFvUaJVCoAlh3ICU95PRkKvROg+eviqOK2LeGYGNXxwGkM7gONxS59vwQZYQ
         h2mgbyFQsPCr1eT+DheIT1rk7r8Q7ZV/X7zBqEC+NEamUPvENirpWnGz74HxRMm/aFml
         7uDxt4iKl+Pc4uQcUM/l3vUAm1EugoDd6I3ts4K8zgObLiHfV1LaFgdPcSixqhQrCFBV
         adGz8T4jqdvBrhWaikqCzj0+lzeSVxtNYTJO7wresTkYOQKm7E2LUxzEjlwzgCecPze0
         45BiwkIJbK6Sak268x/Nj91wv2+sMnYEgBsmijezFivlJ55eZf8siWsGENl6uNzkuf32
         LzGA==
X-Gm-Message-State: ACrzQf2HkOxCBewSxKBQEa/Fcb9RaUPGXDIuvj2xiT2NWZJtIzEl6pC0
        ZFM8UYsS5aygMfZdB9xqVs3OjqImDMA=
X-Google-Smtp-Source: AMsMyM7H2GUG4Ri4tY5LsVZdqkAGqQPssqHSprsw04GZhiN3xO+2Rh7BBOErrvv1Awlj/7HLnGrq6A==
X-Received: by 2002:a17:902:cf4c:b0:179:f440:3284 with SMTP id e12-20020a170902cf4c00b00179f4403284mr2883935plg.24.1664305216242;
        Tue, 27 Sep 2022 12:00:16 -0700 (PDT)
Received: from mariner-vm.. ([131.107.1.181])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001f8aee0d826sm8737557pjb.53.2022.09.27.12.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:00:15 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 01/15] ebpf-docs: Move legacy packet instructions to a separate file
Date:   Tue, 27 Sep 2022 18:59:44 +0000
Message-Id: <20220927185958.14995-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
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

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 38 ++--------------
 Documentation/bpf/linux-notes.rst     | 65 +++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/bpf/linux-notes.rst

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 1b0e6711d..352f25a1e 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -282,8 +282,6 @@ arithmetic operations in the imm field to encode the atomic operation:
 
   *(u64 *)(dst_reg + off16) += src_reg
 
-``BPF_XADD`` is a deprecated name for ``BPF_ATOMIC | BPF_ADD``.
-
 In addition to the simple atomic operations, there also is a modifier and
 two complex atomic operations:
 
@@ -331,36 +329,6 @@ There is currently only one such instruction.
 Legacy BPF Packet access instructions
 -------------------------------------
 
-eBPF has special instructions for access to packet data that have been
-carried over from classic BPF to retain the performance of legacy socket
-filters running in the eBPF interpreter.
-
-The instructions come in two forms: ``BPF_ABS | <size> | BPF_LD`` and
-``BPF_IND | <size> | BPF_LD``.
-
-These instructions are used to access packet data and can only be used when
-the program context is a pointer to networking packet.  ``BPF_ABS``
-accesses packet data at an absolute offset specified by the immediate data
-and ``BPF_IND`` access packet data at an offset that includes the value of
-a register in addition to the immediate data.
-
-These instructions have seven implicit operands:
-
- * Register R6 is an implicit input that must contain pointer to a
-   struct sk_buff.
- * Register R0 is an implicit output which contains the data fetched from
-   the packet.
- * Registers R1-R5 are scratch registers that are clobbered after a call to
-   ``BPF_ABS | BPF_LD`` or ``BPF_IND | BPF_LD`` instructions.
-
-These instructions have an implicit program exit condition as well. When an
-eBPF program is trying to access the data beyond the packet boundary, the
-program execution will be aborted.
-
-``BPF_ABS | BPF_W | BPF_LD`` means::
-
-  R0 = ntohl(*(u32 *) (((struct sk_buff *) R6)->data + imm32))
-
-``BPF_IND | BPF_W | BPF_LD`` means::
-
-  R0 = ntohl(*(u32 *) (((struct sk_buff *) R6)->data + src_reg + imm32))
+eBPF previously introduced special instructions for access to packet data that were
+carried over from classic BPF. However, these instructions are
+deprecated and should no longer be used.
diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
new file mode 100644
index 000000000..93c01386d
--- /dev/null
+++ b/Documentation/bpf/linux-notes.rst
@@ -0,0 +1,65 @@
+.. contents::
+.. sectnum::
+
+==========================
+Linux implementation notes
+==========================
+
+This document provides more details specific to the Linux kernel implementation of the eBPF instruction set.
+
+Legacy BPF Packet access instructions
+=====================================
+
+As mentioned in the `ISA standard documentation <instruction-set.rst#legacy-bpf-packet-access-instructions>`_,
+Linux has special eBPF instructions for access to packet data that have been
+carried over from classic BPF to retain the performance of legacy socket
+filters running in the eBPF interpreter.
+
+The instructions come in two forms: ``BPF_ABS | <size> | BPF_LD`` and
+``BPF_IND | <size> | BPF_LD``.
+
+These instructions are used to access packet data and can only be used when
+the program context is a pointer to a networking packet.  ``BPF_ABS``
+accesses packet data at an absolute offset specified by the immediate data
+and ``BPF_IND`` access packet data at an offset that includes the value of
+a register in addition to the immediate data.
+
+These instructions have seven implicit operands:
+
+* Register R6 is an implicit input that must contain a pointer to a
+  struct sk_buff.
+* Register R0 is an implicit output which contains the data fetched from
+  the packet.
+* Registers R1-R5 are scratch registers that are clobbered by the
+  instruction.
+
+These instructions have an implicit program exit condition as well. If an
+eBPF program attempts access data beyond the packet boundary, the
+program execution will be aborted.
+
+``BPF_ABS | BPF_W | BPF_LD`` (0x20) means::
+
+  R0 = ntohl(*(u32 *) ((struct sk_buff *) R6->data + imm))
+
+where ``ntohl()`` converts a 32-bit value from network byte order to host byte order.
+
+``BPF_IND | BPF_W | BPF_LD`` (0x40) means::
+
+  R0 = ntohl(*(u32 *) ((struct sk_buff *) R6->data + src + imm))
+
+Appendix
+========
+
+For reference, the following table lists legacy Linux-specific opcodes in order by value.
+
+======  ====  ===================================================  =============
+opcode  imm   description                                          reference
+======  ====  ===================================================  =============
+0x20    any   dst = ntohl(\*(uint32_t \*)(R6->data + imm))         `Legacy BPF Packet access instructions`_
+0x28    any   dst = ntohs(\*(uint16_t \*)(R6->data + imm))         `Legacy BPF Packet access instructions`_
+0x30    any   dst = (\*(uint8_t \*)(R6->data + imm))               `Legacy BPF Packet access instructions`_
+0x38    any   dst = ntohll(\*(uint64_t \*)(R6->data + imm))        `Legacy BPF Packet access instructions`_
+0x40    any   dst = ntohl(\*(uint32_t \*)(R6->data + src + imm))   `Legacy BPF Packet access instructions`_
+0x48    any   dst = ntohs(\*(uint16_t \*)(R6->data + src + imm))   `Legacy BPF Packet access instructions`_
+0x50    any   dst = \*(uint8_t \*)(R6->data + src + imm))          `Legacy BPF Packet access instructions`_
+0x58    any   dst = ntohll(\*(uint64_t \*)(R6->data + src + imm))  `Legacy BPF Packet access instructions`_
-- 
2.33.4

