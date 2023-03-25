Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222BF6C9146
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 23:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjCYWnT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 18:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYWnT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 18:43:19 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99F1C15D
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 15:43:17 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id m16so4342049qvi.12
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679784196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nAMeJisk8ChkxdCbQBngTRLghzgPLkrbcfrQCKwFeQ0=;
        b=heenfFFM+SqTSQbgqugA1Wqk1FULS9ksyMFPFwgP795RtmnyDF8JXd7ppLgThtVxMP
         BDNthCbocIY0M4yLQTJFuo6VkVCdtCCaqF9ti22KegQW/V3s54gjDGhIxmeEUMWruVtc
         Ouk1zZC6teh/Oi9+aLYHdCi7yj5p9+5IlC+cxZju7V4/8QqlXCp8/XIfkWs0f59vIKrb
         6v+4yUeQ9hMmNzopHxBY6hA7iBhkNVRzjZ1oFqniM9MVnt0VNX6fCni3/y4bDhtVHpA4
         hrG5k1QOcjP30LJqoTPEjMUhoTQ7SvKCEh5j4NeJ22WQIFVbyTdkQwz7oaZlnkAJR/IS
         /Mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679784196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAMeJisk8ChkxdCbQBngTRLghzgPLkrbcfrQCKwFeQ0=;
        b=8F9FZda3MVrWkXWnmD76Ea6dOucckY0MxUnCB5Jx8pbgWLVmqbWsTkryp1IWRPrO8U
         SaylHirpyXU3HoWOUqnx18GqOdR9HBGOV22bK6TPHwCKiUa7ZD88VkNWAAh3u7ZgfWT5
         hAJPd5x88yRntZCrntznJ1U/E6SA3pGJ+yx27Dm6DMmfMBwCYgaXpYqeV6E3R3RlELHz
         kFD7aamQVKs0OhISi5wJ37YHxj2H83t1pOYOxx0mqyfzhIKROoFJkxVG5bKv4ydHaTiY
         FMq/8Cq0Rm0HYcSroK1zQg8RnQj4HtdydrORV4wCASwoaYiWf/ukHbvoP6AAd4htutvB
         Y02g==
X-Gm-Message-State: AAQBX9fypiXKCxE9rWeK8wSmhooNpTRpe3ze3EN0VVUwweQaJAMKd7FX
        lEF1hL9ML93osRzgdO4OvQdHPrspDb+zdw==
X-Google-Smtp-Source: AKy350a3SProwu532sXuK68o89uSgCzpBouDbjKVLS9p5KQmC1SXROjDNUyoc2B4iZEro8VsPa2cMA==
X-Received: by 2002:ad4:5c62:0:b0:56f:820:6703 with SMTP id i2-20020ad45c62000000b0056f08206703mr12245452qvh.43.1679784196647;
        Sat, 25 Mar 2023 15:43:16 -0700 (PDT)
Received: from mariner-vm.. (dhcp-9320.meeting.ietf.org. [31.133.147.32])
        by smtp.gmail.com with ESMTPSA id w10-20020a0cff0a000000b005dd8b934585sm1748012qvt.29.2023.03.25.15.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 15:43:16 -0700 (PDT)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next v3] bpf, docs: Add docs on extended 64-bit immediate instructions
Date:   Sat, 25 Mar 2023 22:43:05 +0000
Message-Id: <20230325224305.2157-1-dthaler1968@googlemail.com>
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
previously undocumented.  Include a brief description of map objects, and variables,
as used by those instructions.

---
V1 -> V2: rebased on top of latest master

V2 -> V3: addressed comments from Alexei

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 56 +++++++++++++++++++++++----
 Documentation/bpf/linux-notes.rst     | 13 +++++++
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index db8789e6969..2c8347d63e7 100644
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
+* map_by_fd(imm) means to convert a 32-bit POSIX file descriptor into an address of a map object (see `Map objects`_)
+* map_by_idx(imm) means to convert a 32-bit index into an address of a map object
+* map_val(map) gets the address of the first value in a given map object
+* var_addr(imm) gets the address of a platform variable (see `Platform Variables`_) with a given id
+* code_addr(imm) gets the address of the instruction at a specified relative offset in number of (64-bit) instructions
+* the 'imm type' can be used by disassemblers for display
+* the 'dst type' can be used for verification and JIT compilation purposes
+
+Map objects
+~~~~~~~~~~~
+
+Maps are shared memory regions accessible by eBPF programs on some platforms, where we use the term "map object"
+to refer to an object containing the data and metadata (e.g., size) about the memory region.
+A map can have various semantics as defined in a separate document, and may or may not have a single
+contiguous memory region, but the 'map_val(map)' is currently only defined for maps that do have a single
+contiguous memory region.
+
+Each map object can have a POSIX file descriptor (fd) if supported by the platform,
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
index 956b0c86699..2d161467105 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/linux-notes.rst
@@ -12,6 +12,19 @@ Byte swap instructions
 
 ``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` and ``BPF_TO_BE`` respectively.
 
+Map objects
+===========
+
+Linux only supports the 'map_val(map)' operation on array maps with a single element.
+
+Linux uses an fd_array to store maps associated with a BPF program. Thus,
+map_by_index(index) uses the fd at that index in the array.
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

