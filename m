Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C976B1365
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 21:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjCHUxJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 15:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCHUxJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 15:53:09 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D296123305
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 12:53:06 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so99694pjz.1
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 12:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678308786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JSPqJSHFcoBtsX/5P4b9fPdo+mPyhMh5bqZUtzJBWfQ=;
        b=EnL8FBsSqJ+pL3d1QDmRUcDQVRzEAYlbvLlrJNHDnCP1WCR9IlEAtuACWC3QFmHpp6
         4sKTA9/faI1TpiRfPvSvfnMA97ygk9bbV99Jbu4tlKsomduWkvoRzM6oxm9GxbcojPqg
         HG29vGX8Ysi/nsqA4qvz2h+HbdlRzb0GMR/pkRFlornJFV52KNaU9xKNEWRbA/LLDVWn
         h86sUPRvlFzuV+V2pOoEHVQJAup4GQ/fmJJc7mBaENopkQIuagyCFIT49x1kYGKIee/9
         YO1THVGh1pHSj+yb4jbWgbC449/+umg+rOi1Q+QgtUbZzhyoI6UouP8GGqb+YeAt0L+b
         sj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678308786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSPqJSHFcoBtsX/5P4b9fPdo+mPyhMh5bqZUtzJBWfQ=;
        b=CJup8OY1aXEkisyfFMZGvYEQLGYPK/GkFGqPvQH5zwihBlwhIyp7EKZ4WqO1Jzn/U5
         TudY/7XEZs6XGasKADwCvS+Hgrwc1quKiQPG4lrvDndgRcNED/+a8lp3sBv73GYE/noR
         cIJmbJHi+46hg7BiaOfgkjKjkcecvF5jbXOlJ8PazRRLIU2BVp1JbbDCSeaFqH85Is/0
         2x0XdVHF5xitqFJorUoY6UALgQTAn75kyVHyw4Heq0hTOSrDCdLs8Qwy8cZSMm14oMPu
         TtKhTqhwx/YnJWATk6u0U75oLdhEvWvSjlCVjqG5U/hIUTgRS7ll1fooassVXMBIMEgD
         Ppjg==
X-Gm-Message-State: AO0yUKXWbLUrnAiy23OBm275nYu1Ia/GLcaGWdogU00lOmjzclOBqOU2
        9jCKs6cCdA65FgBzPDPfM9oFRlLyvHo=
X-Google-Smtp-Source: AK7set/i4FSY5OAOe2hhOqoiS3A35wtt4/44I2zE7wqU2OVtabrSzg9LMeeLxN25trzAUzs1tEec4g==
X-Received: by 2002:a05:6a20:841a:b0:bc:96bd:d701 with SMTP id c26-20020a056a20841a00b000bc96bdd701mr27400733pzd.13.1678308786036;
        Wed, 08 Mar 2023 12:53:06 -0800 (PST)
Received: from mariner-vm.. ([131.107.1.182])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79143000000b005810c4286d6sm9784462pfi.0.2023.03.08.12.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 12:53:05 -0800 (PST)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next v4] bpf, docs: Explain helper functions
Date:   Wed,  8 Mar 2023 20:53:03 +0000
Message-Id: <20230308205303.1308-1-dthaler1968@googlemail.com>
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

Add brief text about existence of helper functions, with details to go in
separate psABI text.

Note that text about runtime functions (kfuncs) is part of a separate patch,
not this one.

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
V1 -> V2: addressed comments from Alexei and Stanislav

V2 -> V3: addressed comments from David Vernet

V3 -> V4: removed text that should be in psABI
---
 Documentation/bpf/clang-notes.rst     | 6 ++++++
 Documentation/bpf/instruction-set.rst | 9 ++++++++-
 Documentation/bpf/linux-notes.rst     | 8 ++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/clang-notes.rst b/Documentation/bpf/clang-notes.rst
index 528feddf2db..2c872a1ee08 100644
--- a/Documentation/bpf/clang-notes.rst
+++ b/Documentation/bpf/clang-notes.rst
@@ -20,6 +20,12 @@ Arithmetic instructions
 For CPU versions prior to 3, Clang v7.0 and later can enable ``BPF_ALU`` support with
 ``-Xclang -target-feature -Xclang +alu32``.  In CPU version 3, support is automatically included.
 
+Jump instructions
+=================
+
+If ``-O0`` is used, Clang will generate the ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d)
+instruction, which is not supported by the Linux kernel verifier.
+
 Atomic operations
 =================
 
diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index db8789e6969..5e43e14abe8 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -253,7 +253,7 @@ BPF_JSET  0x40   PC += off if dst & src
 BPF_JNE   0x50   PC += off if dst != src
 BPF_JSGT  0x60   PC += off if dst > src     signed
 BPF_JSGE  0x70   PC += off if dst >= src    signed
-BPF_CALL  0x80   function call
+BPF_CALL  0x80   function call              see `Helper functions`_
 BPF_EXIT  0x90   function / program return  BPF_JMP only
 BPF_JLT   0xa0   PC += off if dst < src     unsigned
 BPF_JLE   0xb0   PC += off if dst <= src    unsigned
@@ -264,6 +264,13 @@ BPF_JSLE  0xd0   PC += off if dst <= src    signed
 The eBPF program needs to store the return value into register R0 before doing a
 BPF_EXIT.
 
+Helper functions
+~~~~~~~~~~~~~~~~
+
+Helper functions are a concept whereby BPF programs can call into a
+set of function calls exposed by the runtime.  Each helper
+function is identified by an integer used in a ``BPF_CALL`` instruction.
+The available helper functions may differ for each program type.
 
 Load and store instructions
 ===========================
diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
index 956b0c86699..f43b9c797bc 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/linux-notes.rst
@@ -12,6 +12,14 @@ Byte swap instructions
 
 ``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` and ``BPF_TO_BE`` respectively.
 
+Jump instructions
+=================
+
+``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function
+integer would be read from a specified register, is not currently supported
+by the verifier.  Any programs with this instruction will fail to load
+until such support is added.
+
 Legacy BPF Packet access instructions
 =====================================
 
-- 
2.33.4

