Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9036B6BEB
	for <lists+bpf@lfdr.de>; Sun, 12 Mar 2023 23:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjCLWUG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Mar 2023 18:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCLWUF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Mar 2023 18:20:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18712386B
        for <bpf@vger.kernel.org>; Sun, 12 Mar 2023 15:20:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id cp12so6551573pfb.5
        for <bpf@vger.kernel.org>; Sun, 12 Mar 2023 15:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678659602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xYujzr+4xlYsp4hLXF2Nr6HZ+Few30Sp+os012QoHbE=;
        b=jFxlzQKOr9uVFdDKXyWFkiFqX2udbIDA5p5jyb1EUpzu6RmvDz+TjM0VGNnACixIFV
         nQuSMPRh7fE9HL2UN8e/LtXZFvBljia/X3MSZGQKwS1vaV4gUSWbgCPc9tNzCho2n/6S
         gIZdk5TsrTN/LVvgj/GFx/4DoR/ApHhPt3XnAK4lEHPlwsWGgSa3tfpV92VDrRuEV24P
         d/RsTSkev/qZIv71rFQocg+TAk0iBAlEOt9uTlAxDDZasx2WOAn69kdWbIjMjAPDsbO7
         xdrI/dinzn1hFLk0IflyMjHys0ykx57iHu6vwx3ha0YI7FRFVsTMlAHRXGZLK68Y+PA0
         yWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678659602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYujzr+4xlYsp4hLXF2Nr6HZ+Few30Sp+os012QoHbE=;
        b=731YTsvlBOtwd52IiEsTVkKVO0YnE7zXkEWRhix1KDsyTZuMBlD/XxtAp23H9Uby91
         YixGgm9EjEDTkS7jqK/lV3py1lKskm6pB5Pt/qtZ9Zf7aubXkYWsyQ+flrEKu3E++0Gl
         DkLDjsOmaP8RiSI1udyWQMhGqDxo6En5GII9p4mijRyxzgGJzr3vGFI4HgDeJjnUvdvC
         ruVTgL5yPRM+bbAi1kdNvWBc26+9kbmhwH/0jrMQhOaZawKY0BcN44nAHVKKohprZO/i
         Fa6O3CTAsf1RGpcdK9PBnip3TU/KX7q3OFGYEA2mMVUSVlTh8WsOraDLF3gToZ2s4+Y2
         SODQ==
X-Gm-Message-State: AO0yUKWAL3ktTBCYuUCZ1DGvcxt0yOxVoJtsuVzXg57n274IUEGmgo2z
        qwZcdbukHiwKp4X1kwkZ5O+ZChbHM0s=
X-Google-Smtp-Source: AK7set/WZdNzdfmQzijNeQ9H+KTLMfp4PbuD+uV3XtTTUwFW7bvV74DDD+oxzsQqj454Se71EyyBjA==
X-Received: by 2002:a62:7995:0:b0:622:c72a:d0e0 with SMTP id u143-20020a627995000000b00622c72ad0e0mr4725518pfc.13.1678659602473;
        Sun, 12 Mar 2023 15:20:02 -0700 (PDT)
Received: from mariner-vm.. (c-71-197-160-159.hsd1.wa.comcast.net. [71.197.160.159])
        by smtp.gmail.com with ESMTPSA id bm16-20020a056a00321000b005afda149679sm3200820pfb.179.2023.03.12.15.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 15:20:01 -0700 (PDT)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next v3] bpf, docs: Add extended call instructions
Date:   Sun, 12 Mar 2023 22:19:58 +0000
Message-Id: <20230312221958.879-1-dthaler1968@googlemail.com>
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

Add extended call instructions.  Since BPF can be used in userland
or SmartNICs, this uses the more generic "Platform-specific helper functions"
term as suggested by David Vernet, rather than the kernel specific "kfuncs".

---
V1 -> V2: addressed comments from David Vernet

V2 -> V3: make descriptions in table consistent with updated names

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 63 +++++++++++++++++----------
 Documentation/bpf/linux-notes.rst     |  4 ++
 2 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 5e43e14abe8..f890bcd0dba 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -242,35 +242,52 @@ Jump instructions
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
+BPF_CALL  0x8    0x0  call platform-agnostic helper function imm   see `Platform-agnostic helper functions`_
+BPF_CALL  0x8    0x1  call PC += offset                            see `BPF-local functions`_
+BPF_CALL  0x8    0x2  call platform-specific helper function imm   see `Platform-specific helper functions`_
+BPF_EXIT  0x9    0x0  return                                       BPF_JMP only
+BPF_JLT   0xa    any  PC += offset if dst < src                    unsigned
+BPF_JLE   0xb    any  PC += offset if dst <= src                   unsigned
+BPF_JSLT  0xc    any  PC += offset if dst < src                    signed
+BPF_JSLE  0xd    any  PC += offset if dst <= src                   signed
+========  =====  ===  ===========================================  =========================================
 
 The eBPF program needs to store the return value into register R0 before doing a
 BPF_EXIT.
 
-Helper functions
-~~~~~~~~~~~~~~~~
+Platform-agnostic helper functions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Helper functions are a concept whereby BPF programs can call into a
-set of function calls exposed by the runtime.  Each helper
+Platform-agnostic helper functions are a concept whereby BPF programs can call
+into a set of function calls exposed by the runtime.  Each helper
 function is identified by an integer used in a ``BPF_CALL`` instruction.
-The available helper functions may differ for each program type.
+The available platform-agnostic helper functions may differ for each program
+type, but integer values are unique across all program types.
+
+Platform-specific helper functions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Platform-specific helper functions are helper functions that are unique to
+a particular platform.  They use a separate integer numbering space from
+platform-agnostic helper functions, but otherwise the same considerations
+apply.  Platforms are not required to implement any platform-specific
+functions.
+
+BPF-local functions
+~~~~~~~~~~~~~~
+BPF-local functions are functions exposed by the same BPF program as the caller,
+and are referenced by offset from the call instruction, similar to ``BPF_JA``.
+A ``BPF_EXIT`` within the BPF-local function will return to the caller.
 
 Load and store instructions
 ===========================
diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
index f43b9c797bc..bdc41293e8a 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/linux-notes.rst
@@ -20,6 +20,10 @@ integer would be read from a specified register, is not currently supported
 by the verifier.  Any programs with this instruction will fail to load
 until such support is added.
 
+For historical reasons, Linux has a number of Linux-specific helper functions
+that are encoded as platform-agnostic helper functions rather than
+ platform-specific helper functions ("kfuncs").
+
 Legacy BPF Packet access instructions
 =====================================
 
-- 
2.33.4

