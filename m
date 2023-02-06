Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0CF68C69B
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 20:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjBFTRP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 14:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjBFTRO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 14:17:14 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3772B094
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 11:16:53 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id a23so8876740pga.13
        for <bpf@vger.kernel.org>; Mon, 06 Feb 2023 11:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cORpCioTr+BojKiAQLNPWyjTCgpSASj/W1aFgjzOu88=;
        b=dsTV9cv1hg5eE1lZmgRUXDztrLBNm0IEWDQ0H4F7gra2p5eGBAmtXpNxZly4erIobU
         sRu7/idnHuBlc0Vy610YWBMUKXEU6w1H6EHurqeI2Tr9LfZT9NhGjhzyS2+EEd581Uar
         rmJ55AvpFppRXXCssGza7gM4YyPnVy8iKB8OIWoWCu9zRkJdJfu3c5UO/8nPIARdxbr3
         BrPxbQttHpn46qxLwQabmQop53lR3RukklHuUzx+haeGnumiXLS/7yD+TyW0ZD30QKpE
         D8zYfKCxQ0j/xbZHxBhC1KtH+XDcToyw4gBb9xnClFGwGaejSPTKndsnPQjESM+HOGrL
         Nz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cORpCioTr+BojKiAQLNPWyjTCgpSASj/W1aFgjzOu88=;
        b=C/x7Ki/VXbOqtqcRyTt0hRDQvceNtMBHbZhfkpLDvHRlpg8OtX2w9OIRgLnGnhIJ0T
         4K9MFYr2CuYb88tTCJtjnM4TlsxCMYph10XaPI6qIztYLvd/M1uxqz3vzAmzenmw+6J6
         UGcUM6Rt7cv7oZB/JJeESb+11pImMJ/10YZv6b0raqHiQNSkhEU3NNUn8gVWavSWQoqP
         xnBbYFPJ+bN53vxHYY8qIwWRDim19E978VVFB9RsuS6R/fBnrVJfipVvh8HjlgXc3WsP
         1q301whKu1WO2s0NF6gM2UZIsyEHuSRk0NJkOH5ExuM7cpoLASm03mpYLvtOTaWFP3JF
         53bA==
X-Gm-Message-State: AO0yUKUbhrdRDPS4wspXieQ64ug2cWSLdZQQ+tonQyNkkDuvDP+aWTp3
        H+L1ATGKCCjOqWjrht/LHcLXGnDcQIY=
X-Google-Smtp-Source: AK7set9vxSJktTU1krqm8armTxGvVRwF5NzjNF8Jaba2NTIR2WQQ575MveWbMVwI4D+0hLLO2VkCTg==
X-Received: by 2002:a62:8412:0:b0:58d:c1ca:9360 with SMTP id k18-20020a628412000000b0058dc1ca9360mr567493pfd.17.1675711011129;
        Mon, 06 Feb 2023 11:16:51 -0800 (PST)
Received: from mariner-vm.. ([131.107.147.156])
        by smtp.gmail.com with ESMTPSA id a24-20020aa79718000000b00593b82ea1cesm7474607pfg.49.2023.02.06.11.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:16:50 -0800 (PST)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next v2] bpf, docs: Explain helper functions
Date:   Mon,  6 Feb 2023 19:16:47 +0000
Message-Id: <20230206191647.2075-1-dthaler1968@googlemail.com>
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

Add text explaining helper functions.
Note that text about runtime functions (kfuncs) is part of a separate patch,
not this one.

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
V1 -> V2: addressed comments from Alexei and Stanislav
---
 Documentation/bpf/clang-notes.rst     |  5 +++++
 Documentation/bpf/instruction-set.rst | 22 +++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/clang-notes.rst b/Documentation/bpf/clang-notes.rst
index 528feddf2db..40c6185513a 100644
--- a/Documentation/bpf/clang-notes.rst
+++ b/Documentation/bpf/clang-notes.rst
@@ -20,6 +20,11 @@ Arithmetic instructions
 For CPU versions prior to 3, Clang v7.0 and later can enable ``BPF_ALU`` support with
 ``-Xclang -target-feature -Xclang +alu32``.  In CPU version 3, support is automatically included.
 
+Reserved instructions
+====================
+
+Clang will generate the reserved ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d) instruction if ``-O0`` is used.
+
 Atomic operations
 =================
 
diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 2d3fe59bd26..89a13f1cdeb 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -191,7 +191,7 @@ BPF_JSET  0x40   PC += off if dst & src
 BPF_JNE   0x50   PC += off if dst != src
 BPF_JSGT  0x60   PC += off if dst > src     signed
 BPF_JSGE  0x70   PC += off if dst >= src    signed
-BPF_CALL  0x80   function call
+BPF_CALL  0x80   function call              see `Helper functions`_
 BPF_EXIT  0x90   function / program return  BPF_JMP only
 BPF_JLT   0xa0   PC += off if dst < src     unsigned
 BPF_JLE   0xb0   PC += off if dst <= src    unsigned
@@ -202,6 +202,26 @@ BPF_JSLE  0xd0   PC += off if dst <= src    signed
 The eBPF program needs to store the return value into register R0 before doing a
 BPF_EXIT.
 
+Helper functions
+~~~~~~~~~~~~~~~~
+
+Helper functions are a concept whereby BPF programs can call into a
+set of function calls exposed by the runtime.  Each helper
+function is identified by an integer used in a ``BPF_CALL`` instruction.
+The available helper functions may differ for each program type.
+
+Conceptually, each helper function is implemented with a commonly shared function
+signature defined as:
+
+  u64 function(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5)
+
+In actuality, each helper function is defined as taking between 0 and 5 arguments,
+with the remaining registers being ignored.  The definition of a helper function
+is responsible for specifying the type (e.g., integer, pointer, etc.) of the value returned,
+the number of arguments, and the type of each argument.
+
+Note that ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function integer
+would be read from a specified register, is reserved and currently not permitted.
 
 Load and store instructions
 ===========================
-- 
2.33.4

