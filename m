Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316895F4C2E
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 00:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJDWsB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 18:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJDWr5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 18:47:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608F26E889
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 15:47:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z20so7373368plb.10
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 15:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=M+IB90+kiyf5PcAMVfEmmklfs6ttME515JdIhVOn4jQ=;
        b=RabfViOgzEUSM9XQGogxF2OWnylCKPAnQpXn8MzytDYxttnYz+OnIzaSidHfaVaK0j
         m+nCE5U1qIlD/qvwsri066QofeuCEdam1NA9ON9JG3mvmsFxtgs77IJVSUqodJ0yUaE2
         OjLGAnMERqs0T48jhP8tjvG5OUu1GghApecLeu7zVB47OpMz67a07foL1n/VGo6iP+Vo
         Jpt3ohOxx6lUOdlpxzSr+3TVSXrg9BFdtnsvfUV5Vnw9H6A32+F2YKr0ILQ99dW3obxn
         qhxAZ2KunKsMdYY/pUClOR4BLdwNuK3wri91K9zW13q+fpwcYGcYQj3kdy9gs7RZqAOJ
         AtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M+IB90+kiyf5PcAMVfEmmklfs6ttME515JdIhVOn4jQ=;
        b=tFRpm9JAJt5mxsB3gkXg1y+d+2+ad8PpA2uHqU3w7HxfXq2hnWpRSCvvEbqi5PVtZZ
         GPdlseMkq9Npwc1A/S1s4o6keoc2gpF8glMA/Yvtf8NazQAEUrRDMyeZWIem8/8UnJPJ
         38KR2jv35eOsbwnmIaCf8i6FGcO/fxsRbEcjHWVaNvo1mXVitmA0ETaRXI3pyOwwfZyI
         WM5BxRFLatE/S3SMOu14/NqHSN4PyAMfhdoak1r6VaMBkm7J4w5vFACxUip5HubNFeja
         wc+HuNurbxDW6FhoZCZyViqGwuWtCWTuqUBH+NHgWkLxxbkbjGQuPgGAF5sQoUnARepw
         UmxA==
X-Gm-Message-State: ACrzQf2klFnGvANCBbe/RWlKD9aCPfrx9T4Su+oqgRBXQdyVO9EBe7ua
        dgLA1eTsnaos3ScSX4XjkyW+7sRGRUE=
X-Google-Smtp-Source: AMsMyM6bQacfZXene3Hf2h1Owmtp0oGUtLm7ZYb8hKhO885WxM6OQm/uGH1KoJdZALv6mrN55P5k2g==
X-Received: by 2002:a17:902:d4d2:b0:17a:a33:e334 with SMTP id o18-20020a170902d4d200b0017a0a33e334mr29132980plg.17.1664923675441;
        Tue, 04 Oct 2022 15:47:55 -0700 (PDT)
Received: from mariner-vm.. ([131.107.174.139])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b0016c0eb202a5sm9487369plg.225.2022.10.04.15.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 15:47:54 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 7/9] bpf, docs: Add extended 64-bit immediate instructions
Date:   Tue,  4 Oct 2022 22:47:43 +0000
Message-Id: <20221004224745.1430-7-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20221004224745.1430-1-dthaler1968@googlemail.com>
References: <20221004224745.1430-1-dthaler1968@googlemail.com>
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

Add extended 64-bit immediate instructions

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 54 +++++++++++++++++++++++++--
 Documentation/bpf/linux-notes.rst     | 10 +++++
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 4d5a506be..5ce1a85cd 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -425,14 +425,54 @@ and loaded back to ``R0``.
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
@@ -460,6 +500,12 @@ opcode  src  imm   description                                          referenc
 0x16    0x0  any   if (u32)dst == imm goto +offset                      `Jump instructions`_
 0x17    0x0  any   dst -= imm                                           `Arithmetic instructions`_
 0x18    0x0  any   dst = imm64                                          `64-bit immediate instructions`_
+0x18    0x1  any   dst = map_by_fd(imm)                                 `64-bit immediate instructions`_
+0x18    0x2  any   dst = mva(map_by_fd(imm)) + next_imm                 `64-bit immediate instructions`_
+0x18    0x3  any   dst = variable_addr(imm)                             `64-bit immediate instructions`_
+0x18    0x4  any   dst = code_addr(imm)                                 `64-bit immediate instructions`_
+0x18    0x5  any   dst = map_by_idx(imm)                                `64-bit immediate instructions`_
+0x18    0x6  any   dst = mva(map_by_idx(imm)) + next_imm                `64-bit immediate instructions`_
 0x1c    any  0x00  dst = (u32)(dst - src)                               `Arithmetic instructions`_
 0x1d    any  0x00  if dst == src goto +offset                           `Jump instructions`_
 0x1e    any  0x00  if (u32)dst == (u32)src goto +offset                 `Jump instructions`_
diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
index 5860b73ea..fb050a485 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/linux-notes.rst
@@ -17,6 +17,16 @@ Byte swap instructions
 
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

