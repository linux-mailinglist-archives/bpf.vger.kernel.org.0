Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF8D69D674
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 23:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjBTWuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 17:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjBTWuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 17:50:20 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD79C199C3
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 14:50:18 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id na9-20020a17090b4c0900b0023058bbd7b2so2798361pjb.0
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 14:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HoLvfwc8NO/VMdHYFRY2VFkJ81v4zkjRrOeb4uiecw4=;
        b=FMpSQmhdoo4RVN5ya6T8syVL0E+qxf2XWwTpSZWywqgwH4LUPM3ECcXQMrShd5OBEW
         6zuZ7t8rndTy9BeZe2OgXjdStxGdmrnQG0z0OhR25n9szqhHgoesJDA9MrgtncVof7RV
         M8pvRZX0SdIEHmideSz3HWG2vTjM2IrdSIpRRLOiF5IgymwGcm4WVYVd1zbhujAXYYws
         2xpH4fTn2KT+YpNU0UnW/UiQzISeRQeW13ncycyGoj0ryvjjciuwhHY696V77SBc49l8
         4vB3HeGDzFiTo0UHyTnR/0H4HuQIU9nd0kZL0g1sLIRQWp2rTjXxgLZGSG3icCuFuBbn
         xdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HoLvfwc8NO/VMdHYFRY2VFkJ81v4zkjRrOeb4uiecw4=;
        b=CpsZbxxCzf2Qo0BvDLpq9UZ3867Ja8xNk9BLmVFSb34skbTRnEPPubUiV8nYx+ts2P
         l8Zi9YdKoFSmArlG8KN5Nq+zgmRxrfUkna/3vPv7l9yNg5t+hvuxTGOjnDh84/xY5Nhc
         f5xyR34tMXE+Wj2Nfb4BGxnmqoLCaqx5SCAbBqOhqYa3M938vRerStHobf6aoByCioys
         lwut2PanK05tY0a9nDJPLopINYeTL/FBrRgNaycfjrEs/8YMD4wG+s/diMHQvULdkMEy
         mq7xoQTwKGXS8o0uZHnVqyUn+CGqqkGr2HiC7rEl8RZEvnzUAMWNBZw0qiNs/A7nHPQp
         hvTg==
X-Gm-Message-State: AO0yUKUsL/7k2/yl4gjUb+oP8qdoZmO2RjVJXzRDeyv40xc6itrZurbM
        GUl+Oou59uMK9jgWRyAONaF6Qt0eG6g=
X-Google-Smtp-Source: AK7set+N/L9g087MA7dud031JyM7kJKzWcA5K1cJd5YiMBo/b68AftjXdK7OwnYwPLofTDrWIbvLRA==
X-Received: by 2002:a05:6a20:3d22:b0:cb:2c8e:14c with SMTP id y34-20020a056a203d2200b000cb2c8e014cmr3959216pzi.10.1676933417919;
        Mon, 20 Feb 2023 14:50:17 -0800 (PST)
Received: from mariner-vm.. (c-71-197-160-159.hsd1.wa.comcast.net. [71.197.160.159])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7804c000000b00590ede84b1csm8452111pfm.147.2023.02.20.14.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:50:17 -0800 (PST)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next] bpf, docs: Explain helper functions
Date:   Mon, 20 Feb 2023 22:50:13 +0000
Message-Id: <20230220225013.2068-1-dthaler1968@googlemail.com>
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

V2 -> V3: addressed comments from David Vernet
---
 Documentation/bpf/clang-notes.rst     |  6 ++++++
 Documentation/bpf/instruction-set.rst | 19 ++++++++++++++++++-
 Documentation/bpf/linux-notes.rst     |  8 ++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

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
index af515de5fc3..148dd2a2e39 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -239,7 +239,7 @@ BPF_JSET  0x40   PC += off if dst & src
 BPF_JNE   0x50   PC += off if dst != src
 BPF_JSGT  0x60   PC += off if dst > src     signed
 BPF_JSGE  0x70   PC += off if dst >= src    signed
-BPF_CALL  0x80   function call
+BPF_CALL  0x80   function call              see `Helper functions`_
 BPF_EXIT  0x90   function / program return  BPF_JMP only
 BPF_JLT   0xa0   PC += off if dst < src     unsigned
 BPF_JLE   0xb0   PC += off if dst <= src    unsigned
@@ -250,6 +250,23 @@ BPF_JSLE  0xd0   PC += off if dst <= src    signed
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

