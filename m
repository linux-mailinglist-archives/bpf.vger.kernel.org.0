Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3269A69D756
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 00:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBTXy2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 18:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjBTXy0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 18:54:26 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E861E9F7
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 15:54:10 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u10so2857199pjc.5
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 15:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJUe+9v1CZXfift4Q5/8Wx6jYVo+7jdMbA9wEfyMc00=;
        b=Aqj9LNYYsrRTbcPbICZWSgVbJ3N+yvI2KrJw7RvT6qaAGfOXMSgqk7AG3HYf08YILf
         Lxkv7fYet2JsRNukf6VVgq5mGXhlHfu3RZ04jz4iePZiScr2K57jteJGyq2LdID0gB/w
         11lBcjyGefGq2J5W1ESCo3DtqzJxlBKGEiQJli8nRF1iunIaD9LHvCBlG7dmz+Jjp+3A
         hvE4lozMzcqMDCrl+BPmEEJI0Gj/9rKbGueyAWedrw8AHZQA2ZICQjBRoDlgEBn5CUz2
         exM3nzye+wNE/IbuieAEeyxDegiXeYgvaZBBK5gbsx0GGLIeEkd3vaBYnWAkloxCs82/
         SZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJUe+9v1CZXfift4Q5/8Wx6jYVo+7jdMbA9wEfyMc00=;
        b=3f+BM68i03LlenLrcymFuvXWmuJRHvoZO6c0DkUMKnhIrY639osH9WlJRqzeu/PsTg
         WjLBZWbYcXRvuj1ijtXAOXGevkqWkzxVrdBRMiu1F/JJSyZ6f2YkggjX6guSvcTQ/PGe
         uCwTf/juMCYS6bncuNNtMJk9KBZWNiu2X0gE7K7Y+Ju/jNSPBf+5JZCxSXqiofjtUSo/
         rQKvdiKDn6C35/gzuB4EUlTnTQGQWxc6Q9IDc7JH9q7+5TVxgJi03ekPwdQQYfFvuxPi
         FvYIQPehtBFfYe1XCzFwHMhDDbMEkRY4ODbl9nx8Lz7l3+bvhCVBXsDclaCVs1mrRkp6
         1t0g==
X-Gm-Message-State: AO0yUKXe/3YHP4vhu7guiH/UtZ3EUIgnBMjHoym4CgLaiuwuhEFhT1Ni
        Ts/axlxr79mzZIPnjSXgQNNgBdsfK5E=
X-Google-Smtp-Source: AK7set++3PAIjlPuoG8UYbIyl0ZplVRx7/twqSHzLj6aGT50ABE3a7MSH5wd871NeYk82mls9G1HRg==
X-Received: by 2002:a17:903:2291:b0:19b:33c0:4092 with SMTP id b17-20020a170903229100b0019b33c04092mr3395363plh.24.1676937249917;
        Mon, 20 Feb 2023 15:54:09 -0800 (PST)
Received: from mariner-vm.. (c-71-197-160-159.hsd1.wa.comcast.net. [71.197.160.159])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902bf4200b0019a6d3851afsm8480398pls.141.2023.02.20.15.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 15:54:09 -0800 (PST)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next v2] bpf, docs: Add docs on extended 64-bit immediate instructions
Date:   Mon, 20 Feb 2023 23:54:05 +0000
Message-Id: <20230220235405.4289-1-dthaler1968@googlemail.com>
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
index af515de5fc3..d3ef8733795 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -371,14 +371,54 @@ and loaded back to ``R0``.
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

