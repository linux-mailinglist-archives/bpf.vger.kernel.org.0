Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F176C923D
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 05:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjCZDbd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 23:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjCZDb1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 23:31:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2D0B461
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 20:31:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso5493552pjb.2
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 20:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679801486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XlHpbGw7+Ms576ncdpnLtB28q3yr93WH1GlSK/iUZQs=;
        b=Yg1zBctdQVO606jr/JEfAhGvIpISO9R+d1qh/e3GM3bedFvUpGLB8li6k6XL8KtNfd
         Y+b0jC014vIau/RK9tJMu6Az5ptKs0jn2dIXGL3E2QAuuFPuHO7yXQ/OnUQinmHLy21P
         nCr7++Fm2OM1g6qdcCUCbU2yX4Y/fVRFHATSZGcZ9WBddPQ+bpDUmq/YoZcmF2eL9OLn
         8n/kd8QWSCBi9sLK7EYlpDL9XwvwV//DBkXLdUzRlahD3jQADpYW9yLDFUfAai7RYDw7
         C6QyVsDMrbIgfce7NRCIxzkxnuEZidx9J2yQ5VF4WXfNEWLTtZ86W/4N/HEWyTpoGBLI
         cuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679801486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlHpbGw7+Ms576ncdpnLtB28q3yr93WH1GlSK/iUZQs=;
        b=nLlzOCfbEmabDaUHsgJeaMipCMlw7oYFsqH1d1MCq1KEpp/sJ0UIWI48S8tuyLo7PW
         mKtzmMwQk4fqctP7caPVKPKfNI+y/UmpSjDzjCPt3/SzZ1Fi3s02Fp+VD683r0uF0f79
         AT3VDc2A/PQoeruk7vv0m+bYOy9r21S2+20Q2fDNM6x27tjdCC2hbRy0PWuYTCQpVfT3
         bVOcy8mTprZ7g1WablAGzdTZz06Nk0YByfsjkksRLl1M6lHGYW156nBXjnRBiuZEPSFq
         7Wqd8A/a0d/BxKlC0kzY1PGTum7YhjlSxshPJ0vSA398hzHdI2VpLvr6yc+bGUIgnWjI
         hGxw==
X-Gm-Message-State: AAQBX9dQDRiVH8K3F73/Mh7QpqIiFMqVQxwlNkH/TiL9jJbNEOzD1jeV
        0O/iLKWeyjhh7d534VXkSHPPrWpUCHVqwloH
X-Google-Smtp-Source: AKy350YytfvdxHE/n3b/wDgLFzPDwbKSxN2w8EQ4GPeWaZJEaApo/DRwdpqT4cv5kILPNO3/416BBg==
X-Received: by 2002:a17:903:2309:b0:19b:dae0:c97d with SMTP id d9-20020a170903230900b0019bdae0c97dmr9261272plh.32.1679801485897;
        Sat, 25 Mar 2023 20:31:25 -0700 (PDT)
Received: from mariner-vm.. (dhcp-81de.meeting.ietf.org. [31.133.129.222])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709029a0c00b0019a75ea08e5sm16676983plp.33.2023.03.25.20.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 20:31:25 -0700 (PDT)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next v5] bpf, docs: Add extended call instructions
Date:   Sun, 26 Mar 2023 03:31:17 +0000
Message-Id: <20230326033117.1075-1-dthaler1968@googlemail.com>
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

V1 -> V2: addressed comments from David Vernet

V2 -> V3: make descriptions in table consistent with updated names

V3 -> V4: addressed comments from Alexei

V4 -> V5: fixed alignment

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 59 +++++++++++++++++----------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index b4464058905..b77280eb926 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -243,27 +243,29 @@ Jump instructions
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
+BPF_CALL  0x8    0x0  call helper function by address              see `Helper functions`_
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
 
 Example:
 
@@ -277,9 +279,22 @@ Helper functions
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

