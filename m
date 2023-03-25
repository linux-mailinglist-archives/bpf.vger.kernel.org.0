Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440666C8D17
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 11:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjCYKXZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 06:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCYKXY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 06:23:24 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A696CC00
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 03:23:22 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id z18so2457002pgj.13
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 03:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679739801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ogHvFp5W4VZQ/COOYeomRjYjWy0vaDSzhVHiCwG/GNA=;
        b=nKniuQtfwCWDxyUC7y62NuvEqUaaeoz6ovTkjl7ixashWxqDPAl7uceRtMJ2UN2PsC
         7iTR+YeTfU1SREVw6y2ErIBFf6Mrx1YnQSIfvQmXZF8s3S1dYXO0MlQ29aKeOG6McUXq
         TDXLq8Lm73dM10XSh1qA88/u56MeD6jqB/xUEAhhpN2sOHdOlLcDqtNfJrx8jC8W34iB
         KrWRhuXiZKP7jGdj7o+2fcWc0v534Pf9fI/8X8lagzm8ZvxbQjf1CjnpSL1UD+Ds4xKD
         en0C1YGElvmFny+QSDAm8xMRGqg+aD6QHmjG3nHm1/dXLeTWVVzSZlISFgEsc87gWGL0
         umYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679739801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogHvFp5W4VZQ/COOYeomRjYjWy0vaDSzhVHiCwG/GNA=;
        b=RIxE+fHNwIhFeAU374b7CEeYHd0MCKs6aV2uR4lN1Slw75mzT5756qaB7aCaecxJJR
         qZHh/zzUgvVoMUC8E6tSRpom1PasWCWbDxmAnvz+8KHCB2ulRyiRDKGVhs1zY5g1bCZk
         XNq1zD4Nn3epvaODaJrodTlmZPvmWoR39GVeIAMIeOX4SUVYx7OIl72HCrTjzmIR0pi0
         Qq0eXGNvP1PJfizyFkzD56bacD5O+uESGJ3fvH+SWmI9/KKldFKeJgyMU/YlATdZjvP4
         t6XtyraWrBfHtlnzKSCITKFbAGAxcKthZ+lYxioRL7uITCI3XcXXO7ETQdyeDH7G5o2x
         UP+g==
X-Gm-Message-State: AAQBX9c1DipadC2AmlqK+5WT1fTI746m0MZro8p8aPMGzj6lmOye+Qh1
        jH1UHxovpdXj2GlChEiBrf2S2AbL+Dy4rg==
X-Google-Smtp-Source: AKy350ZsB3wy/CQK0jh4OwZTY01awUg86+Nrd/g4DZtjTd9emvgfURQQvmW9BbW+88onXo48g1jbPA==
X-Received: by 2002:a62:1a49:0:b0:625:ffed:b3d1 with SMTP id a70-20020a621a49000000b00625ffedb3d1mr5270258pfa.7.1679739801213;
        Sat, 25 Mar 2023 03:23:21 -0700 (PDT)
Received: from mariner-vm.. (dhcp-9320.meeting.ietf.org. [31.133.147.32])
        by smtp.gmail.com with ESMTPSA id a24-20020a62e218000000b00627f2f23624sm11656419pfi.159.2023.03.25.03.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 03:23:20 -0700 (PDT)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next v4] bpf, docs: Add extended call instructions
Date:   Sat, 25 Mar 2023 10:23:14 +0000
Message-Id: <20230325102314.1504-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Dave Thaler <dthaler@microsoft.com>

Add extended call instructions.  Uses the term "program-local" for
call by offset.  And there are instructions for calling helper functions
by "address" (the old way of using integer values), and for calling
helper functions by BTF ID (for kfuncs).

---
V1 -> V2: addressed comments from David Vernet

V2 -> V3: make descriptions in table consistent with updated names

V3 -> V4: addressed comments from Alexei

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 59 +++++++++++++++++----------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 5e43e14abe8..ed8f35becb2 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -242,35 +242,50 @@ Jump instructions
 otherwise identical operations.
 The 'code' field encodes the operation as below:
 
-========  =====  =========================  ============
-code      value  description                notes
-========  =====  =========================  ============
-BPF_JA    0x00   PC += off                  BPF_JMP only
-BPF_JEQ   0x10   PC += off if dst == src
-BPF_JGT   0x20   PC += off if dst > src     unsigned
-BPF_JGE   0x30   PC += off if dst >= src    unsigned
-BPF_JSET  0x40   PC += off if dst & src
-BPF_JNE   0x50   PC += off if dst != src
-BPF_JSGT  0x60   PC += off if dst > src     signed
-BPF_JSGE  0x70   PC += off if dst >= src    signed
-BPF_CALL  0x80   function call              see `Helper functions`_
-BPF_EXIT  0x90   function / program return  BPF_JMP only
-BPF_JLT   0xa0   PC += off if dst < src     unsigned
-BPF_JLE   0xb0   PC += off if dst <= src    unsigned
-BPF_JSLT  0xc0   PC += off if dst < src     signed
-BPF_JSLE  0xd0   PC += off if dst <= src    signed
-========  =====  =========================  ============
+========  =====  ===  ===========================================  =========================================
+code      value  src  description                                  notes
+========  =====  ===  ===========================================  =========================================
+BPF_JA    0x0    0x0  PC += offset                                 BPF_JMP only
+BPF_JEQ   0x1    any  PC += offset if dst == src
+BPF_JGT   0x2    any  PC += offset if dst > src                    unsigned
+BPF_JGE   0x3    any  PC += offset if dst >= src                   unsigned
+BPF_JSET  0x4    any  PC += offset if dst & src
+BPF_JNE   0x5    any  PC += offset if dst != src
+BPF_JSGT  0x6    any  PC += offset if dst > src                    signed
+BPF_JSGE  0x7    any  PC += offset if dst >= src                   signed
+BPF_CALL  0x8    0x0  call helper function by address		   see `Helper functions`_
+BPF_CALL  0x8    0x1  call PC += offset                            see `Program-local functions`_
+BPF_CALL  0x8    0x2  call helper function by BTF ID               see `Helper functions`_
+BPF_EXIT  0x9    0x0  return                                       BPF_JMP only
+BPF_JLT   0xa    any  PC += offset if dst < src                    unsigned
+BPF_JLE   0xb    any  PC += offset if dst <= src                   unsigned
+BPF_JSLT  0xc    any  PC += offset if dst < src                    signed
+BPF_JSLE  0xd    any  PC += offset if dst <= src                   signed
+========  =====  ===  ===========================================  =========================================
 
 The eBPF program needs to store the return value into register R0 before doing a
-BPF_EXIT.
+``BPF_EXIT``.
 
 Helper functions
 ~~~~~~~~~~~~~~~~
 
 Helper functions are a concept whereby BPF programs can call into a
-set of function calls exposed by the runtime.  Each helper
-function is identified by an integer used in a ``BPF_CALL`` instruction.
-The available helper functions may differ for each program type.
+set of function calls exposed by the underlying platform.
+
+Historically, each helper function was identified by an address
+encoded in the imm field.  The available helper functions may differ
+for each program type, but address values are unique across all program types.
+
+Platforms that support the BPF Type Format (BTF) support identifying
+a helper function by a BTF ID encoded in the imm field, where the BTF ID
+identifies the helper name and type.
+
+Program-local functions
+~~~~~~~~~~~~~~~~~~~~~~~
+Program-local functions are functions exposed by the same BPF program as the
+caller, and are referenced by offset from the call instruction, similar to
+``BPF_JA``.  A ``BPF_EXIT`` within the program-local function will return to
+the caller.
 
 Load and store instructions
 ===========================
-- 
2.33.4

