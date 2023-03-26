Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BDC6C92B1
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 07:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjCZFty (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 01:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjCZFtx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 01:49:53 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCECA5ED
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 22:49:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id kc4so5596560plb.10
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 22:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679809791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dsnl98mxwuPgSq/fK7s8X/ES+pPt1XPsXTYF8f1Y/N0=;
        b=N491PqBZt9l4cYyy6YqFdskQ/qE3QA//9Z6DVjazi31+Xm2HqSr2h8kqiGNRu2gTi1
         5xx0IOLnhN/ZeOY0rqFtB//JA/lhR95lBBbziYANrxxV2G+C+jAtfiZpGD7yLsR7ZaQ7
         4tvRVsBJlNUaEt8lRa/x4cWTEQ/QmOMwWEvKlH2m/jU6zwh7mIOOs12hoaYoIVSdB8p1
         E3Lv3Xk4qIE2F5jJuSvFO5uVLNtOP1ipzl5xTrEX7KZ7DI99qgTK6vjt3DeK94S/myGv
         ZKmZ6N4gEciyBYfOFjBfDZdkut7HGIclAMPde0RFxPAUpr8GyPFy9sLp+bZNMrjBj6bU
         CMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679809791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dsnl98mxwuPgSq/fK7s8X/ES+pPt1XPsXTYF8f1Y/N0=;
        b=UhRgtXPfTF6ekGqpxd1z/Obur/3mRiWRIdBXMMSn8I4Ego+EnB2oD0Ju9HL31tQ7cy
         pm8fuPqfwq/sggMRricU/+aYxF/7Mc4mDgYsqpCRqSI35rZd29loMdAca/cfOdcB80If
         9ZTNyigsGRpFbR8eIKft6PgwuhIhM+9blAe6c/4PIinGopwiT2KPIxRnHKlT7d5TcI2f
         GoP4wyw1tE+GNY6Z1KLJiEmB3pMMlQRqEteHvwzjHBSqq8HWTzteOGOyOMKyZpBlEObi
         tPqFPXJrr/J0wXlOSRQXQT5aVds3EvwEKYy+FXWmoL4Ys8u8puLED7+08iCgg09129cR
         HmtQ==
X-Gm-Message-State: AO0yUKVfASkYHw+C19p77T13kNdWm+PvVa6N7igni1zyuuQtWPbvXwoM
        v/dTCGZs5rbqHFOLH8nxnywmC9KL2VpdzQ==
X-Google-Smtp-Source: AK7set+oREZzZTMi0/pZBbAaB4PUnUnUC8H1ke0ty2E1M/TaYjwrEcmeVpPOZ2MHP0rFV9h9E77uJw==
X-Received: by 2002:a05:6a20:1221:b0:da:acdf:d241 with SMTP id v33-20020a056a20122100b000daacdfd241mr6281876pzf.45.1679809791510;
        Sat, 25 Mar 2023 22:49:51 -0700 (PDT)
Received: from mariner-vm.. (dhcp-81de.meeting.ietf.org. [31.133.129.222])
        by smtp.gmail.com with ESMTPSA id n3-20020a654883000000b0051322a5aa64sm3879353pgs.3.2023.03.25.22.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 22:49:51 -0700 (PDT)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next v4] bpf, docs: Add docs on extended 64-bit immediate instructions
Date:   Sun, 26 Mar 2023 05:49:46 +0000
Message-Id: <20230326054946.2331-1-dthaler1968@googlemail.com>
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

Add docs on extended 64-bit immediate instructions, including six instructions
previously undocumented.  Include a brief description of maps and variables,
as used by those instructions.

V1 -> V2: rebased on top of latest master

V2 -> V3: addressed comments from Alexei

V3 -> V4: addressed comments from David Vernet

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 57 +++++++++++++++++++++++----
 Documentation/bpf/linux-notes.rst     | 22 +++++++++++
 2 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index b4464058905..b3efa4b74ec 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -401,14 +401,55 @@ and loaded back to ``R0``.
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
+The following table defines a set of ``BPF_IMM | BPF_DW | BPF_LD`` instructions
+with opcode subtypes in the 'src' field, using new terms such as "map"
+defined further below:
+
+=========================  ======  ===  =========================================  ===========  ==============
+opcode construction        opcode  src  pseudocode                                 imm type     dst type
+=========================  ======  ===  =========================================  ===========  ==============
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = imm64                                integer      integer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst = map_by_fd(imm)                       map fd       map
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst = map_val(map_by_fd(imm)) + next_imm   map fd       data pointer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)                        variable id  data pointer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst = code_addr(imm)                       integer      code pointer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst = map_by_idx(imm)                      map index    map
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst = map_val(map_by_idx(imm)) + next_imm  map index    data pointer
+=========================  ======  ===  =========================================  ===========  ==============
+
+where
+
+* map_by_fd(imm) means to convert a 32-bit POSIX file descriptor into an address of a map (see `Maps`_)
+* map_by_idx(imm) means to convert a 32-bit index into an address of a map
+* map_val(map) gets the address of the first value in a given map
+* var_addr(imm) gets the address of a platform variable (see `Platform Variables`_) with a given id
+* code_addr(imm) gets the address of the instruction at a specified relative offset in number of (64-bit) instructions
+* the 'imm type' can be used by disassemblers for display
+* the 'dst type' can be used for verification and JIT compilation purposes
+
+Maps
+~~~~
+
+Maps are shared memory regions accessible by eBPF programs on some platforms.
+A map can have various semantics as defined in a separate document, and may or may not have a single
+contiguous memory region, but the 'map_val(map)' is currently only defined for maps that do have a single
+contiguous memory region.
+
+Each map can have a POSIX file descriptor (fd) if supported by the platform,
+where 'map_by_fd(imm)' means to get the map with the specified file descriptor.
+Each BPF program can also be defined to use a set of maps associated with the program
+at load time, and 'map_by_idx(imm)' means to get the map with the given index in the set
+associated with the BPF program containing the instruction.
+
+Platform Variables
+~~~~~~~~~~~~~~~~~~
+
+Platform variables are memory regions, identified by integer ids, exposed by the runtime and accessible by BPF programs on
+some platforms.  The 'var_addr(imm)' operation means to get the address of the memory region
+identified by the given id.
 
 Legacy BPF Packet access instructions
 -------------------------------------
diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
index f43b9c797bc..508d009d3be 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/linux-notes.rst
@@ -20,6 +20,28 @@ integer would be read from a specified register, is not currently supported
 by the verifier.  Any programs with this instruction will fail to load
 until such support is added.
 
+Maps
+====
+
+Linux only supports the 'map_val(map)' operation on array maps with a single element.
+
+Linux uses an fd_array to store maps associated with a BPF program. Thus,
+map_by_idx(imm) uses the fd at that index in the array.
+
+Variables
+=========
+
+The following 64-bit immediate instruction specifies that a variable address,
+which corresponds to some integer stored in the 'imm' field, should be loaded:
+
+=========================  ======  ===  =========================================  ===========  ==============
+opcode construction        opcode  src  pseudocode                                 imm type     dst type
+=========================  ======  ===  =========================================  ===========  ==============
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)                        variable id  data pointer
+=========================  ======  ===  =========================================  ===========  ==============
+
+On Linux, this integer is a BTF ID.
+
 Legacy BPF Packet access instructions
 =====================================
 
-- 
2.33.4

