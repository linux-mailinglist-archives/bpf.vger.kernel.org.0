Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C8C5ECC96
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 21:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiI0TA5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 15:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiI0TAo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA961BEA79
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d11so9895790pll.8
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=g7dKqq8ieDPDu8THRlVWwhDbW+P/kY6bJ0OccIy1imM=;
        b=INMP68CyAxO0YCFoT54yNnMi+M5KW+TWkDOvvYdN/nieXgT2g2+z3BKBCYbw78UK82
         /Gn/rxHLSAT22QqC0h9Oor7Z0e2TQfbOhL34eoHL+Ynk0dcCKa+ZJfbss9OX2o5xmxGk
         O/HlUg8yxCdKHS8MSYqz/xxC66NXrEkvG9iHKDlRonZ2Y6V9lqwdE/e1yH3z/xqFb9Wf
         OGTzxNYIbpZ1XVjeV1BjXzzJBUKsOlCIvshOcprwfcy8Jg/ykJRAkG2WMhdP8GBui/JA
         z6wK+EyfA+PrRkRmdJR+tAFYJnj2pFTHzUmaJje6uaL0TJuTQv4rz+EjoSjf1Dc6B0a9
         qlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=g7dKqq8ieDPDu8THRlVWwhDbW+P/kY6bJ0OccIy1imM=;
        b=Qsy1MsYNay6xwzcrSO1GhIaWsLpgLBGCrVUplTUYvDqmSWTNsKJ438+zDC7n5wEvUz
         knnGeCzps2NLzTjAVx9KKVP9V0bYWVjpis+iibj1R36uGedNKNlrdzgYaBh2c0ZQy1rP
         MUWuljbyedyPHDJfElEYQiUi0SMbN34hb7q9mYgIhf+0KZQ7UVymaEqIQKC+7HPcGiW8
         ABYIw6Vdwgyut0ZwSXBv5Io32fI15n2VDUs1VbLS+8IiL+H6tt8CM+X75VLLWyf6urES
         3kIkHNAvooFIcUWVJQU7UkK+m7+LGertawf8nU6qdTpoGNvNS80KZyWi0vICKgN8XqcX
         EBXQ==
X-Gm-Message-State: ACrzQf1IqIfg+gNEJoNZpLjuHe09I0IB4pNQG5Czg30xPe9gyAGtublo
        lOkfEtsm2A/tbigyM+Y+rCIrrcN7Eto=
X-Google-Smtp-Source: AMsMyM4n0NaT8JpJuFY/QPaHvxMKgavwypnkaMmOoPR32qTMqAWd6N9UPUt0cJInTDjvdEjWGJ0aZQ==
X-Received: by 2002:a17:902:e883:b0:177:f38f:6498 with SMTP id w3-20020a170902e88300b00177f38f6498mr27831948plg.32.1664305230251;
        Tue, 27 Sep 2022 12:00:30 -0700 (PDT)
Received: from mariner-vm.. ([131.107.1.181])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001f8aee0d826sm8737557pjb.53.2022.09.27.12.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:00:29 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 13/15] ebpf-docs: Add extended 64-bit immediate instructions
Date:   Tue, 27 Sep 2022 18:59:56 +0000
Message-Id: <20220927185958.14995-13-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20220927185958.14995-1-dthaler1968@googlemail.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
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

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 54 +++++++++++++++++++++++++--
 Documentation/bpf/linux-notes.rst     | 10 +++++
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 328207ff6..667d97715 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -430,14 +430,54 @@ and loaded back to ``R0``.
 -----------------------------
 
 Instructions with the ``BPF_IMM`` 'mode' modifier use the wide instruction
-encoding for an extra imm64 value.
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
 
-There is currently only one such instruction.
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
 
-``BPF_LD | BPF_DW | BPF_IMM`` means::
+Each map object can have a POSIX file descriptor (fd) if supported by the platform,
+where 'map_by_fd(fd)' means to get the map with the specified file descriptor.
+Each eBPF program can also be defined to use a set of maps associated with the program
+at load time, and 'map_by_index(index)' means to get the map with the given index in the set
+associated with the eBPF program containing the instruction.
 
-  dst = imm64
+Variables
+~~~~~~~~~
 
+Variables are memory regions, identified by integer ids, accessible by eBPF programs on
+some platforms.  The 'variable_addr(id)' operation means to get the address of the memory region
+identified by the given id.  Support for such variables is optional.
 
 Legacy BPF Packet access instructions
 -------------------------------------
@@ -465,6 +505,12 @@ opcode  src  imm   description                                          referenc
 0x16    0x0  any   if (uint32_t)dst == imm goto +offset                 `Jump instructions`_
 0x17    0x0  any   dst -= imm                                           `Arithmetic instructions`_
 0x18    0x0  any   dst = imm64                                          `64-bit immediate instructions`_
+0x18    0x1  any   dst = map_by_fd(imm)                                 `64-bit immediate instructions`_
+0x18    0x2  any   dst = mva(map_by_fd(imm)) + next_imm                 `64-bit immediate instructions`_
+0x18    0x3  any   dst = variable_addr(imm)                             `64-bit immediate instructions`_
+0x18    0x4  any   dst = code_addr(imm)                                 `64-bit immediate instructions`_
+0x18    0x5  any   dst = map_by_idx(imm)                                `64-bit immediate instructions`_
+0x18    0x6  any   dst = mva(map_by_idx(imm)) + next_imm                `64-bit immediate instructions`_
 0x1c    any  0x00  dst = (uint32_t)(dst - src)                          `Arithmetic instructions`_
 0x1d    any  0x00  if dst == src goto +offset                           `Jump instructions`_
 0x1e    any  0x00  if (uint32_t)dst == (uint32_t)src goto +offset       `Jump instructions`_
diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
index 0581ba326..e7f79242c 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/linux-notes.rst
@@ -24,6 +24,16 @@ Byte swap instructions
 
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

