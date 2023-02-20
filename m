Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A35269D67D
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 23:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjBTWwi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 17:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjBTWwh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 17:52:37 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8173421973
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 14:52:32 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id nt5-20020a17090b248500b00237161e33f4so941235pjb.4
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 14:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HoLvfwc8NO/VMdHYFRY2VFkJ81v4zkjRrOeb4uiecw4=;
        b=PUtr9BK6UG2xNZRKGkdI8i71W2ja/B8fElmqgaDaZKlZyldMLubrlOigPCVMMuP2kF
         fcGND+gbHX/SYUtQ+hT4ZWJiRbyliRWKSX+AGXxEt9faZ2ryxErzp8cKTZdZaaEemVDF
         aTsX5/RF2Xgin/SZR4rYJOnTRtn+VJlzzxG/Hy5dKEyfMr/uM8LZkamRLV7/G1qPYPo3
         4t0udZIeM/tsu/cqzEOf1nbBi2wAwbPA479QUKejom4M3v0lFasMaCGzhqILWfA63M5o
         pOgzWOiNMnWkMuXIhf2vk0chrdgbOvL2A9+U4nuUyp9Z8vgo4uCKKxhW9uXKMu9Fv6qf
         r7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HoLvfwc8NO/VMdHYFRY2VFkJ81v4zkjRrOeb4uiecw4=;
        b=AF8ge+DUFcOegUdrizeUW9DylAm/1171dlRYDdz+krLzlKaJn43/yfMCIZYLaH+/Gz
         cfvi7Ep2+5IQHO1QSnw+HILsuoIEJqnc7cqxc7DyxcOD+YImiuOhLY6zddVjDjVhwE6z
         JYst0ttWWiRu5BL/mk30BicwXgMySRWIA0jcS59Mk+C7W+2rZq3XRT6UY56ZsMWsUdGj
         7Zk1VPCnJuHG8XJw2hNqmX9CnGQHgwDzflOT3p5Y5ARd27EVW8454B0bBJWrU4xr6PIA
         jEAfFH6iByac+GuuojBpeDF/PFzcesOEG8X/bNv2NxpylgGwObv7eAYZxYN5DExqfp0+
         qvvw==
X-Gm-Message-State: AO0yUKWmK788LPstywb+KjXga8R1tweqi5shn4qHyVw/p96CVBUNQvwk
        //HBEAb7OHbG7124A0dZs/t010QvZL0=
X-Google-Smtp-Source: AK7set8QrjjPEBiw7DqeSsSACf3SZg4n20u/PwRvwfnE802PGeKRBN+IgSogsC9mItuvzJj0sNlvEQ==
X-Received: by 2002:a17:902:c411:b0:19a:9833:708 with SMTP id k17-20020a170902c41100b0019a98330708mr4850928plk.64.1676933551611;
        Mon, 20 Feb 2023 14:52:31 -0800 (PST)
Received: from mariner-vm.. (c-71-197-160-159.hsd1.wa.comcast.net. [71.197.160.159])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b00198ef76ce8dsm8445067pln.72.2023.02.20.14.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:52:31 -0800 (PST)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next v3] bpf, docs: Explain helper functions
Date:   Mon, 20 Feb 2023 22:52:28 +0000
Message-Id: <20230220225228.2129-1-dthaler1968@googlemail.com>
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

