Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D743E5F4C2F
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 00:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJDWsC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 18:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiJDWr6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 18:47:58 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB756E892
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 15:47:57 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r18so759622pgr.12
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 15:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=L3HBuLVOIuSnWaNCSD43IXohM6FfOxl09nrs6BQJGy8=;
        b=naqZgqRyry8QYE1r+A2R8AKLunuEGem5xZRaT3JkGY3DqSMcUqCdSud68bBgi0KBA8
         FWKzftoOWfsBBrMi4M67csNCwSwuUrvSBovZ1i56OXMdWbNFr+jTChsBfyo7/f3Iktgu
         7/deZqdzGjm0kuISGzZz/ZmKma/Cy8qP/vrV1TppTGUkv5Od9j7L/+XV5liU50tN74un
         Ub5OOqvaaCcDdPPiEg1YJC396kTiMeBHFDpxiuiZSdQmAgBTZCgBBI1XnKmsLCUxW/0t
         CBuYdDjPbhLJkYZTJ5nubJh6tuAUfYX7YkTgOCSPoeVYvO0VYarBcgrF/qgF6d3K0yTY
         40kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=L3HBuLVOIuSnWaNCSD43IXohM6FfOxl09nrs6BQJGy8=;
        b=MQpku5dSzcr5aBwyyBfMr5/EpVswG5nYtjslkn8t+KLAQqnKq1nIQqSamfArDRs/2D
         YCyt10RjWXVIbxI+Vir/d7UoQi0Ir5AFpqiC+oQzvKv/zltYFgUrEymsAUy6LSv4CJVc
         baCqcqUM7bCsfYwq0S9N2B9i/BZbLJXfplRyNv9AFC6yRtMkEpDdHjh1lwCO/KtQGI8T
         6lLXNXUvNGU9VGIdjCalPbyJOdrCocmE1qsj5pblVqu9uEWixgtYO/CUmhscQQcyBTzk
         hy89cbt+Mc4kA5xP65MK7meLvtahhGu6zJQoK/pvB94b+LyOxS6VsyM3NDKiQcC8fgqu
         /53g==
X-Gm-Message-State: ACrzQf0syz7bml0S+xUIDtSxRcda8jVrRUMogIuwLUGtl8YonFEm8jdx
        9JXJDCflGem0xbzTI4iDXIu9brfUfbw=
X-Google-Smtp-Source: AMsMyM5zpXRsZZJbWupZUAcwi2/Lq/VlqZ7+hLyymexXxDjNutmLLe/OXW6a49epSPXwqmcKz5HpBw==
X-Received: by 2002:a63:fa42:0:b0:44d:b59c:674b with SMTP id g2-20020a63fa42000000b0044db59c674bmr11301355pgk.207.1664923676563;
        Tue, 04 Oct 2022 15:47:56 -0700 (PDT)
Received: from mariner-vm.. ([131.107.174.139])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b0016c0eb202a5sm9487369plg.225.2022.10.04.15.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 15:47:56 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 8/9] bpf, docs: Add extended call instructions
Date:   Tue,  4 Oct 2022 22:47:44 +0000
Message-Id: <20221004224745.1430-8-dthaler1968@googlemail.com>
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

Add extended call instructions

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 52 +++++++++++++++++----------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 5ce1a85cd..d0685a06f 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -263,24 +263,26 @@ otherwise identical operations.
 
 The 4-bit 'code' field encodes the operation as below, where PC is the program counter:
 
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
+========  =====  ===  ==========================  ========================
+code      value  src  description                 notes
+========  =====  ===  ==========================  ========================
+BPF_JA    0x0    0x0  PC += offset                BPF_JMP only
+BPF_JEQ   0x1    any  PC += offset if dst == src
+BPF_JGT   0x2    any  PC += offset if dst > src   unsigned
+BPF_JGE   0x3    any  PC += offset if dst >= src  unsigned
+BPF_JSET  0x4    any  PC += offset if dst & src
+BPF_JNE   0x5    any  PC += offset if dst != src
+BPF_JSGT  0x6    any  PC += offset if dst > src   signed
+BPF_JSGE  0x7    any  PC += offset if dst >= src  signed
+BPF_CALL  0x8    0x0  call helper function imm    see `Helper functions`_
+BPF_CALL  0x8    0x1  call PC += offset           see `eBPF functions`_
+BPF_CALL  0x8    0x2  call runtime function imm   see `Runtime functions`_
+BPF_EXIT  0x9    0x0  return                      BPF_JMP only
+BPF_JLT   0xa    any  PC += offset if dst < src   unsigned
+BPF_JLE   0xb    any  PC += offset if dst <= src  unsigned
+BPF_JSLT  0xc    any  PC += offset if dst < src   signed
+BPF_JSLE  0xd    any  PC += offset if dst <= src  signed
+========  =====  ===  ==========================  ========================
 
 Helper functions
 ~~~~~~~~~~~~~~~~
@@ -299,6 +301,18 @@ with the remaining registers being ignored.  The definition of a helper function
 is responsible for specifying the type (e.g., integer, pointer, etc.) of the value returned,
 the number of arguments, and the type of each argument.
 
+Runtime functions
+~~~~~~~~~~~~~~~~~
+Runtime functions are like helper functions except that they are not specific
+to eBPF programs.  They use a different numbering space from helper functions,
+but otherwise the same considerations apply.
+
+eBPF functions
+~~~~~~~~~~~~~~
+eBPF functions are functions exposed by the same eBPF program as the caller,
+and are referenced by offset from the call instruction, similar to ``BPF_JA``.
+A ``BPF_EXIT`` within the eBPF function will return to the caller.
+
 Load and store instructions
 ===========================
 
@@ -580,6 +594,8 @@ opcode  src  imm   description                                          referenc
 0x7f    any  0x00  dst >>= src                                          `Arithmetic instructions`_
 0x84    0x0  0x00  dst = (u32)-dst                                      `Arithmetic instructions`_
 0x85    0x0  any   call helper function imm                             `Helper functions`_
+0x85    0x1  any   call PC += offset                                    `eBPF functions`_
+0x85    0x2  any   call runtime function imm                            `Runtime functions`_
 0x87    0x0  0x00  dst = -dst                                           `Arithmetic instructions`_
 0x94    0x0  any   dst = (u32)((imm != 0) ? (dst % imm) : dst)          `Arithmetic instructions`_
 0x95    0x0  0x00  return                                               `Jump instructions`_
-- 
2.33.4

