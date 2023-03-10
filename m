Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9726B6B5589
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 00:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjCJXWT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 18:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjCJXWK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 18:22:10 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1D712803D
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:22:02 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id ix20so736041plb.3
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678490522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ovs2pWouL0zG8S9v7T5aAoAVp2zo1YGAkL51w1OyII=;
        b=FTPicBdIc3Yga8gHiNndT1N02HnLjb0gLXWzab+zHAqUbxzg3oAYJssgl84QYsPMjn
         c17jeoRWeafw3eFA/CuxE1SRFSm9p4iY6WVM0aE6srTO+evFSl63Uvf8Ns6FdvJ/Ix5j
         Hxmt6F3wKH5E7zq5uMYAwfL2wqv7+0Ol/jJee62u7P9Ovw9Wzitrjme3FyS+YqE9EBfN
         k6ItC+S1mjp/hFHNEmGZ2swD69g+zojrHW8svig+0wObnOrNJTos4AzxZ2Db7SlAvzUs
         2PXa9hhodtDuL4e5Ray26R7ZjxWOiJbaMnBwto40t8WZqGmw9JP7e5s1pqP3dZDP44Eu
         qSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678490522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Ovs2pWouL0zG8S9v7T5aAoAVp2zo1YGAkL51w1OyII=;
        b=3lsFvhIP4OlP4tQq+C2pk3/VMlCAzAV808cFdPpdqsw6f+ZfQ3f9JwEN69rxD+u1oH
         ViM6fggeTNy7NdqaaEPs8u9sBSdL53lzQoxIPehHBpUDfLnrDVGHdoC9MRCrC2H2tK9I
         F5C6qWuEUBUH/u6Lzo294I2jKMqltTZNhAyiab6lJEV/mS4Yocz7635sUs28pVRKUx2S
         BsP8LV37/zkUAaBo43ufGkGXd1yAWzqnrmO8R1YLU6BrPWGRfJl2aps8aqiiEPAwbQzK
         skhg36KQ4+KsB/fXGnfIVlleE+44V+Zg7q1V0BMkE3M/ogph7whkqCxfA6rpzgkjLDxE
         OCGw==
X-Gm-Message-State: AO0yUKXhlotAal3CjsslEbKJmp1k/Rrh+4i3mnhCbgsaV0VustS3Ppgu
        qck8X/4j9OaCkiesVnNMvH3FXwIsoOM=
X-Google-Smtp-Source: AK7set+2AShT27Mjqrxtf34dqe46AVn6cYhEslLLw7Ewi9Ot0ee0UtqhDbpMJMhvjyG3Ue2rmVqn+g==
X-Received: by 2002:a17:902:e801:b0:19a:b4a9:9df7 with SMTP id u1-20020a170902e80100b0019ab4a99df7mr32125402plg.53.1678490521682;
        Fri, 10 Mar 2023 15:22:01 -0800 (PST)
Received: from mariner-vm.. ([131.107.147.213])
        by smtp.gmail.com with ESMTPSA id kx4-20020a170902f94400b0019aaee7915csm460470plb.232.2023.03.10.15.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 15:22:01 -0800 (PST)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next] bpf, docs: Add extended call instructions
Date:   Fri, 10 Mar 2023 23:21:44 +0000
Message-Id: <20230310232144.4077-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Dave Thaler <dthaler@microsoft.com>

Add extended call instructions.  Since BPF can be used in userland
or SmartNICs, this uses the more generic "runtime functions"
rather than the kernel specific "kfuncs" as a term.

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 50 +++++++++++++++++----------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 5e43e14abe8..bc2319a7707 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -242,24 +242,26 @@ Jump instructions
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
 
 The eBPF program needs to store the return value into register R0 before doing a
 BPF_EXIT.
@@ -272,6 +274,18 @@ set of function calls exposed by the runtime.  Each helper
 function is identified by an integer used in a ``BPF_CALL`` instruction.
 The available helper functions may differ for each program type.
 
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
 
-- 
2.33.4

