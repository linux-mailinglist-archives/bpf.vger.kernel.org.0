Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45176B1354
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 21:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCHUqa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 15:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCHUq3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 15:46:29 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0400D234EF
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 12:46:28 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v11so18880672plz.8
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 12:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678308387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L8ZcjjhBiwRGJko2IIRlTomPDbsnZlPk0Gg0sXr/Noc=;
        b=GCrmfhuCXvzx/a9T5A69BdZRiokurLjq475tWjRv/GOGSkOxga6TE8DgG+0/dlH9MU
         BOYsdbkGaBFfgPiSxIEfPfO0NIMw/1Y120qvdGwu9bi0SedDI+M3tVzqJTHGBf1JiCEg
         KWZhho5q6eBOYEOaU+jElItghp+SF+wOpHQnWFpHkPWVi0+n7zt31+3LMJjcIjTU6GTx
         z3GTsvlgy8l/uY545vxuqtggltmOUPDoyYQsNtHP2AQ/x6ubFLg3nhvTZXUkwO2EWEQA
         H9RoXkQE9/WQ3Vco8AgJY7HUM4Xkwr7t6GTeqjvcMwtulCpTtDyO3HZO0GmdFfGbqq7S
         FLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678308387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8ZcjjhBiwRGJko2IIRlTomPDbsnZlPk0Gg0sXr/Noc=;
        b=QaFTyu7GtxdkyXwt+9606gZjwjWczoDLw+8nzExlFJLkNBIvxGi6V+CfQwZ2eAvxKR
         zjJpQy+HdolI0BmzlahmLu+FAizlV0CnKIkmLLEXIZLnn5n/73AFuseyQ73FwNljTWe8
         G4FdIaycrfAMDTnk8AeAoRYofxNS5vTsa/AnRvfktR4ltbQdb3drSDGBLF9srCxBNpbj
         g0jerjlYdvWtW1ooKNBffHpKgMqOoNndN4ZVEqQIV0x1sny79m7vpIwXa1jukrE86hDk
         JAjWdtuxlnl0izTl9E8IqR/p8r7nFjH+FocKvrOoI5QztTTMv+0zjIVVh4IbquBD1Joz
         LUEw==
X-Gm-Message-State: AO0yUKXMshIRN9z4QpBWv2Zzk/Wt+78Xwf9nOPuvXwMHEc1F6CvGNYuF
        YUp27U5GbXjqf957Xloeronrz6quZYo=
X-Google-Smtp-Source: AK7set+R40qI9VfxN0c0/2O6KEG9jUdZZgxXSMhVdcSiY/w9ZJIUnELN9IjqLBpNhNQiVXVFP5+3aA==
X-Received: by 2002:a17:903:41c8:b0:19a:6ec0:50c2 with SMTP id u8-20020a17090341c800b0019a6ec050c2mr23884039ple.26.1678308387191;
        Wed, 08 Mar 2023 12:46:27 -0800 (PST)
Received: from mariner-vm.. ([131.107.147.246])
        by smtp.gmail.com with ESMTPSA id kh4-20020a170903064400b0019cb4166266sm10233265plb.83.2023.03.08.12.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 12:46:26 -0800 (PST)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next v2 RESEND] bpf, docs: Add docs on extended 64-bit immediate instructions
Date:   Wed,  8 Mar 2023 20:46:23 +0000
Message-Id: <20230308204623.959-1-dthaler1968@googlemail.com>
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

Add docs on extended 64-bit immediate instructions, including six instructions
previously undocumented.  Include a brief description of map objects, and variables,
as used by those instructions.

---
V1 - V2: rebased on top of latest master

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 56 +++++++++++++++++++++++----
 Documentation/bpf/linux-notes.rst     | 10 +++++
 2 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index db8789e6969..89087913fbf 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -385,14 +385,54 @@ and loaded back to ``R0``.
 -----------------------------
 
 Instructions with the ``BPF_IMM`` 'mode' modifier use the wide instruction
-encoding for an extra imm64 value.
-
-There is currently only one such instruction.
-
-``BPF_LD | BPF_DW | BPF_IMM`` means::
-
-  dst = imm64
-
+encoding defined in `Instruction encoding`_, and use the 'src' field of the
+basic instruction to hold an opcode subtype.
+
+The following instructions are defined, and use additional concepts defined below:
+
+=========================  ======  ===  =====================================  ===========  ==============
+opcode construction        opcode  src  pseudocode                             imm type     dst type
+=========================  ======  ===  =====================================  ===========  ==============
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = imm64                            integer      integer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst = map_by_fd(imm)                   map fd       map
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst = mva(map_by_fd(imm)) + next_imm   map fd       data pointer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = variable_addr(imm)               variable id  data pointer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst = code_addr(imm)                   integer      code pointer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst = map_by_idx(imm)                  map index    map
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst = mva(map_by_idx(imm)) + next_imm  map index    data pointer
+=========================  ======  ===  =====================================  ===========  ==============
+
+where
+
+* map_by_fd(fd) means to convert a 32-bit POSIX file descriptor into an address of a map object (see `Map objects`_)
+* map_by_index(index) means to convert a 32-bit index into an address of a map object
+* mva(map) gets the address of the first value in a given map object
+* variable_addr(id) gets the address of a variable (see `Variables`_) with a given id
+* code_addr(offset) gets the address of the instruction at a specified relative offset in units of 64-bit blocks
+* the 'imm type' can be used by disassemblers for display
+* the 'dst type' can be used for verification and JIT compilation purposes
+
+Map objects
+~~~~~~~~~~~
+
+Maps are shared memory regions accessible by eBPF programs on some platforms, where we use the term "map object"
+to refer to an object containing the data and metadata (e.g., size) about the memory region.
+A map can have various semantics as defined in a separate document, and may or may not have a single
+contiguous memory region, but the 'mva(map)' is currently only defined for maps that do have a single
+contiguous memory region.  Support for maps is optional.
+
+Each map object can have a POSIX file descriptor (fd) if supported by the platform,
+where 'map_by_fd(fd)' means to get the map with the specified file descriptor.
+Each eBPF program can also be defined to use a set of maps associated with the program
+at load time, and 'map_by_index(index)' means to get the map with the given index in the set
+associated with the eBPF program containing the instruction.
+
+Variables
+~~~~~~~~~
+
+Variables are memory regions, identified by integer ids, accessible by eBPF programs on
+some platforms.  The 'variable_addr(id)' operation means to get the address of the memory region
+identified by the given id.  Support for such variables is optional.
 
 Legacy BPF Packet access instructions
 -------------------------------------
diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
index 956b0c86699..9a1bdbb8ac0 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/linux-notes.rst
@@ -12,6 +12,16 @@ Byte swap instructions
 
 ``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` and ``BPF_TO_BE`` respectively.
 
+Map objects
+===========
+
+Linux only supports the 'mva(map)' operation on array maps with a single element.
+
+Variables
+=========
+
+Linux uses BTF ids to identify variables.
+
 Legacy BPF Packet access instructions
 =====================================
 
-- 
2.33.4

