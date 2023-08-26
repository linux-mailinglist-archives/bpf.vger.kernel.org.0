Return-Path: <bpf+bounces-8760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E30B7899BA
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 00:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DA01C2088C
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 22:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09471095C;
	Sat, 26 Aug 2023 22:29:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ACFA53
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 22:29:40 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B9D1BE
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 15:29:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52683b68c2fso2857324a12.0
        for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 15:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693088976; x=1693693776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFGevvGpch/zvVRaWWpqfxMC7kZ4sHa326NIhTVDcXw=;
        b=Cg6JYaH5RLLNquWHCrsJWCVUpMrrokdcdR5tQysDlAeJp9LrkJ1NPzy83qblV75sD3
         HJZQrXpvCAWJO08NTQIzgM8RUkapNhC99k9Pyn8Wop/Bphh38Kt7ZMfGCb0g0HFp5tGv
         8UffKZI1q417F/TnmRjqJXKVp5H6yl4FHvQs4pb78d3bjOiu1VlRqENJpw8cVXoJg45f
         HMtCMlFYj2yQ0P9aQBN+77hEYDa1Dd4dRUPANALEwXiYQ487UkvLJVv7SdSB5HYCiG1P
         tMT0w8nAf2yutT/S3L3iurUMIB/iVlPhOkY0zSokr5mcj7ncHZDkxgWaedXmG81TLsGk
         hacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693088976; x=1693693776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFGevvGpch/zvVRaWWpqfxMC7kZ4sHa326NIhTVDcXw=;
        b=gEbod60MiX/hyOHYuu20qDjBeaVyLyDLlyaXgf+Q9tcPAf0ibce+TEF/Jw6e2gNea9
         glso0ty/OcDyQKnTzmyOhzxck3cAnFiAtLajbx8aTcIN6s1ypPlMQ9098yNX/jWenG0Y
         6JTgMEBy5KIAWpr+tbMJ6VDwxvFMtX2daTKb+vFu9f6e26J4jLOB70jRQqjVeW+iQLzq
         4AvPTfKteDyMDWAAN10/I++wVwGrb3wd4Nv5AyQq5NNe+MWi9cQxEaov+RD0gYLEKaJa
         PyE7WSNCrL0iTv1LxpDXb3wsHNG7zeXbU50oB71ogQZZn9MoTQ5kwuBvyqbJAznO+Jzm
         Kp9w==
X-Gm-Message-State: AOJu0YwiW74CN2D52tuDv5nUE/0ub16pEDHq0S6KXz0pbfdhnSLz6QfV
	5suJTsoAjXqFNphWPMi2JQUBi1cI2OA=
X-Google-Smtp-Source: AGHT+IGsCfI6u21tGt2v6abvsSx2PE6SnUydqKMsaZm02BuMjCmFZrZ7hGl1Gtb8EmNvFjtrNtMuMQ==
X-Received: by 2002:a17:906:1cf:b0:9a1:ddb9:6546 with SMTP id 15-20020a17090601cf00b009a1ddb96546mr7977520ejj.61.1693088976338;
        Sat, 26 Aug 2023 15:29:36 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id kb12-20020a1709070f8c00b0099297782aa9sm2679716ejc.49.2023.08.26.15.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 15:29:36 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 1/1] docs/bpf: Add description for CO-RE relocations
Date: Sun, 27 Aug 2023 01:29:12 +0300
Message-ID: <20230826222912.2560865-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230826222912.2560865-1-eddyz87@gmail.com>
References: <20230826222912.2560865-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a section on CO-RE relocations to llvm_relo.rst.
Describe relevant .BTF.ext structure, `enum bpf_core_relo_kind`
and `struct bpf_core_relo` in some detail.
Description is based on doc-strings from:
- include/uapi/linux/bpf.h:struct bpf_core_relo
- tools/lib/bpf/relo_core.c:__bpf_core_types_match()

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 Documentation/bpf/btf.rst        |  31 +++-
 Documentation/bpf/llvm_reloc.rst | 304 +++++++++++++++++++++++++++++++
 2 files changed, 329 insertions(+), 6 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index f32db1f44ae9..ffc11afee569 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -726,8 +726,8 @@ same as the one describe in :ref:`BTF_Type_String`.
 4.2 .BTF.ext section
 --------------------
 
-The .BTF.ext section encodes func_info and line_info which needs loader
-manipulation before loading into the kernel.
+The .BTF.ext section encodes func_info, line_info and CO-RE relocations
+which needs loader manipulation before loading into the kernel.
 
 The specification for .BTF.ext section is defined at ``tools/lib/bpf/btf.h``
 and ``tools/lib/bpf/btf.c``.
@@ -745,15 +745,20 @@ The current header of .BTF.ext section::
         __u32   func_info_len;
         __u32   line_info_off;
         __u32   line_info_len;
+
+        /* optional part of .BTF.ext header */
+        __u32   core_relo_off;
+        __u32   core_relo_len;
     };
 
 It is very similar to .BTF section. Instead of type/string section, it
-contains func_info and line_info section. See :ref:`BPF_Prog_Load` for details
-about func_info and line_info record format.
+contains func_info, line_info and core_relo sub-sections.
+See :ref:`BPF_Prog_Load` for details about func_info and line_info
+record format.
 
 The func_info is organized as below.::
 
-     func_info_rec_size
+     func_info_rec_size              /* __u32 value */
      btf_ext_info_sec for section #1 /* func_info for section #1 */
      btf_ext_info_sec for section #2 /* func_info for section #2 */
      ...
@@ -773,7 +778,7 @@ Here, num_info must be greater than 0.
 
 The line_info is organized as below.::
 
-     line_info_rec_size
+     line_info_rec_size              /* __u32 value */
      btf_ext_info_sec for section #1 /* line_info for section #1 */
      btf_ext_info_sec for section #2 /* line_info for section #2 */
      ...
@@ -787,6 +792,20 @@ kernel API, the ``insn_off`` is the instruction offset in the unit of ``struct
 bpf_insn``. For ELF API, the ``insn_off`` is the byte offset from the
 beginning of section (``btf_ext_info_sec->sec_name_off``).
 
+The core_relo is organized as below.::
+
+     core_relo_rec_size              /* __u32 value */
+     btf_ext_info_sec for section #1 /* core_relo for section #1 */
+     btf_ext_info_sec for section #2 /* core_relo for section #2 */
+
+``core_relo_rec_size`` specifies the size of ``bpf_core_relo``
+structure when .BTF.ext is generated. All ``bpf_core_relo`` structures
+within a single ``btf_ext_info_sec`` describe relocations applied to
+section named by ``btf_ext_info_sec->sec_name_off``.
+
+See :ref:`Documentation/bpf/llvm_reloc <btf-co-re-relocations>`
+for more information on CO-RE relocations.
+
 4.2 .BTF_ids section
 --------------------
 
diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_reloc.rst
index 450e6403fe3d..73bf805000f2 100644
--- a/Documentation/bpf/llvm_reloc.rst
+++ b/Documentation/bpf/llvm_reloc.rst
@@ -240,3 +240,307 @@ The .BTF/.BTF.ext sections has R_BPF_64_NODYLD32 relocations::
       Offset             Info             Type               Symbol's Value  Symbol's Name
   000000000000002c  0000000200000004 R_BPF_64_NODYLD32      0000000000000000 .text
   0000000000000040  0000000200000004 R_BPF_64_NODYLD32      0000000000000000 .text
+
+.. _btf-co-re-relocations:
+
+=================
+CO-RE Relocations
+=================
+
+From object file point of view CO-RE mechanism is implemented as a set
+of CO-RE specific relocation records. These relocation records are not
+related to ELF relocations and are encoded in .BTF.ext section.
+See :ref:`Documentation/bpf/btf <BTF_Ext_Section>` for more
+information on .BTF.ext structure.
+
+CO-RE relocations are applied to BPF instructions to update immediate
+or offset fields of the instruction at load time with information
+relevant for target kernel.
+
+Field to patch is selected basing on the instruction class:
+
+* For BPF_ALU, BPF_ALU64, BPF_LD `immediate` field is patched;
+* For BPF_LDX, BPF_STX, BPF_ST `offset` field is patched;
+* BPF_JMP, BPF_JMP32 instructions **should not** be patched.
+
+Relocation kinds
+================
+
+There are several kinds of CO-RE relocations that could be split in
+three groups:
+
+* Field-based - patch instruction with field related information, e.g.
+  change offset field of the BPF_LDX instruction to reflect offset
+  of a specific structure field in the target kernel.
+
+* Type-based - patch instruction with type related information, e.g.
+  change immediate field of the BPF_ALU move instruction to 0 or 1 to
+  reflect if specific type is present in the target kernel.
+
+* Enum-based - patch instruction with enum related information, e.g.
+  change immediate field of the BPF_LD_IMM64 instruction to reflect
+  value of a specific enum literal in the target kernel.
+
+The complete list of relocation kinds is represented by the following enum:
+
+.. code-block:: c
+
+ enum bpf_core_relo_kind {
+	BPF_CORE_FIELD_BYTE_OFFSET = 0,  /* field byte offset */
+	BPF_CORE_FIELD_BYTE_SIZE   = 1,  /* field size in bytes */
+	BPF_CORE_FIELD_EXISTS      = 2,  /* field existence in target kernel */
+	BPF_CORE_FIELD_SIGNED      = 3,  /* field signedness (0 - unsigned, 1 - signed) */
+	BPF_CORE_FIELD_LSHIFT_U64  = 4,  /* bitfield-specific left bitshift */
+	BPF_CORE_FIELD_RSHIFT_U64  = 5,  /* bitfield-specific right bitshift */
+	BPF_CORE_TYPE_ID_LOCAL     = 6,  /* type ID in local BPF object */
+	BPF_CORE_TYPE_ID_TARGET    = 7,  /* type ID in target kernel */
+	BPF_CORE_TYPE_EXISTS       = 8,  /* type existence in target kernel */
+	BPF_CORE_TYPE_SIZE         = 9,  /* type size in bytes */
+	BPF_CORE_ENUMVAL_EXISTS    = 10, /* enum value existence in target kernel */
+	BPF_CORE_ENUMVAL_VALUE     = 11, /* enum value integer value */
+	BPF_CORE_TYPE_MATCHES      = 12, /* type match in target kernel */
+ };
+
+Notes:
+
+* ``BPF_CORE_FIELD_LSHIFT_U64`` and ``BPF_CORE_FIELD_RSHIFT_U64`` are
+  supposed to be used to read bitfield values using the following
+  algorithm:
+
+  .. code-block:: c
+
+     // To read bitfield ``f`` from ``struct s``
+     is_signed = relo(s->f, BPF_CORE_FIELD_SIGNED)
+     off = relo(s->f, BPF_CORE_FIELD_BYTE_OFFSET)
+     sz  = relo(s->f, BPF_CORE_FIELD_BYTE_SIZE)
+     l   = relo(s->f, BPF_CORE_FIELD_LSHIFT_U64)
+     r   = relo(s->f, BPF_CORE_FIELD_RSHIFT_U64)
+     // define ``v`` as signed or unsigned integer of size ``sz``
+     v = *({s|u}<sz> *)((void *)s + off)
+     v <<= l
+     v >>= r
+
+* The ``BPF_CORE_TYPE_MATCHES`` queries matching relation, defined as
+  follows:
+
+  * for integers: types match if size and signedness match;
+  * for arrays & pointers: target types are recursively matched;
+  * for structs & unions:
+
+    * local members need to exist in target with the same name;
+
+    * for each member we recursively check match unless it is already behind a
+      pointer, in which case we only check matching names and compatible kind;
+
+  * for enums:
+
+    * local variants have to have a match in target by symbolic name (but not
+      numeric value);
+
+    * size has to match (but enum may match enum64 and vice versa);
+
+  * for function pointers:
+
+    * number and position of arguments in local type has to match target;
+    * for each argument and the return value we recursively check match.
+
+CO-RE Relocation Record
+=======================
+
+Relocation record is encoded as the following structure:
+
+.. code-block:: c
+
+ struct bpf_core_relo {
+	__u32 insn_off;
+	__u32 type_id;
+	__u32 access_str_off;
+	enum bpf_core_relo_kind kind;
+ };
+
+* ``insn_off`` - instruction offset (in bytes) within a code section
+  associated with this relocation;
+
+* ``type_id`` - BTF type ID of the "root" (containing) entity of a
+  relocatable type or field;
+
+* ``access_str_off`` - offset into corresponding .BTF string section.
+  String interpretation depends on specific relocation kind:
+
+  * for field-based relocations, string encodes an accessed field using
+    a sequence of field and array indices, separated by colon (:). It's
+    conceptually very close to LLVM's `getelementptr <GEP_>`_ instruction's
+    arguments for identifying offset to a field. For example, consider the
+    following C code:
+
+    .. code-block:: c
+
+       struct sample {
+           int a;
+           int b;
+           struct { int c[10]; };
+       } __attribute__((preserve_access_index));
+       struct sample *s;
+
+    * Access to ``s[0].a`` would be encoded as ``0:0``:
+
+      * ``0``: first element of ``s`` (as if ``s`` is an array);
+      * ``0``: index of field ``a`` in ``struct sample``.
+
+    * Access to ``s->a`` would be encoded as ``0:0`` as well.
+    * Access to ``s->b`` would be encoded as ``0:1``:
+
+      * ``0``: first element of ``s``;
+      * ``1``: index of field ``b`` in ``struct sample``.
+
+    * Access to ``s[1].c[5]`` would be encoded as ``1:2:0:5``:
+
+      * ``1``: second element of ``s``;
+      * ``2``: index of anonymous structure field in ``struct sample``;
+      * ``0``: index of field ``c`` in anonymous structure;
+      * ``5``: access to array element #5.
+
+  * for type-based relocations, string is expected to be just "0";
+
+  * for enum value-based relocations, string contains an index of enum
+     value within its enum type;
+
+* ``kind`` - one of ``enum bpf_core_relo_kind``.
+
+.. _GEP: https://llvm.org/docs/LangRef.html#getelementptr-instruction
+
+.. _btf_co_re_relocation_examples:
+
+CO-RE Relocation Examples
+=========================
+
+For the following C code:
+
+.. code-block:: c
+
+ struct foo {
+   int a;
+   int b;
+   unsigned c:15;
+ } __attribute__((preserve_access_index));
+
+ enum bar { U, V };
+
+With the following BTF definitions:
+
+.. code-block::
+
+ ...
+ [2] STRUCT 'foo' size=8 vlen=2
+        'a' type_id=3 bits_offset=0
+        'b' type_id=3 bits_offset=32
+        'c' type_id=4 bits_offset=64 bitfield_size=15
+ [3] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
+ [4] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
+ ...
+ [16] ENUM 'bar' encoding=UNSIGNED size=4 vlen=2
+        'U' val=0
+        'V' val=1
+
+Field offset relocations are generated automatically when
+``__attribute__((preserve_access_index))`` is used, for example:
+
+.. code-block:: c
+
+  void alpha(struct foo *s, volatile unsigned long *g) {
+    *g = s->a;
+    s->a = 1;
+  }
+
+  00 <alpha>:
+    0:  r3 = *(s32 *)(r1 + 0x0)
+           00:  CO-RE <byte_off> [2] struct foo::a (0:0)
+    1:  *(u64 *)(r2 + 0x0) = r3
+    2:  *(u32 *)(r1 + 0x0) = 0x1
+           10:  CO-RE <byte_off> [2] struct foo::a (0:0)
+    3:  exit
+
+
+All relocation kinds could be requested via built-in functions.
+E.g. field-based relocations:
+
+.. code-block:: c
+
+  void bravo(struct foo *s, volatile unsigned long *g) {
+    *g = __builtin_preserve_field_info(s->b, 0 /* field byte offset */);
+    *g = __builtin_preserve_field_info(s->b, 1 /* field byte size */);
+    *g = __builtin_preserve_field_info(s->b, 2 /* field existence */);
+    *g = __builtin_preserve_field_info(s->b, 3 /* field signedness */);
+    *g = __builtin_preserve_field_info(s->c, 4 /* bitfield left shift */);
+    *g = __builtin_preserve_field_info(s->c, 5 /* bitfield right shift */);
+  }
+
+  20 <bravo>:
+     4:     r1 = 0x4
+            20:  CO-RE <byte_off> [2] struct foo::b (0:1)
+     5:     *(u64 *)(r2 + 0x0) = r1
+     6:     r1 = 0x4
+            30:  CO-RE <byte_sz> [2] struct foo::b (0:1)
+     7:     *(u64 *)(r2 + 0x0) = r1
+     8:     r1 = 0x1
+            40:  CO-RE <field_exists> [2] struct foo::b (0:1)
+     9:     *(u64 *)(r2 + 0x0) = r1
+    10:     r1 = 0x1
+            50:  CO-RE <signed> [2] struct foo::b (0:1)
+    11:     *(u64 *)(r2 + 0x0) = r1
+    12:     r1 = 0x31
+            60:  CO-RE <lshift_u64> [2] struct foo::c (0:2)
+    13:     *(u64 *)(r2 + 0x0) = r1
+    14:     r1 = 0x31
+            70:  CO-RE <rshift_u64> [2] struct foo::c (0:2)
+    15:     *(u64 *)(r2 + 0x0) = r1
+    16:     exit
+
+
+Type-based relocations:
+
+.. code-block:: c
+
+  void charlie(struct foo *s, volatile unsigned long *g) {
+    *g = __builtin_preserve_type_info(*s, 0 /* type existence */);
+    *g = __builtin_preserve_type_info(*s, 1 /* type size */);
+    *g = __builtin_preserve_type_info(*s, 2 /* type matches */);
+    *g = __builtin_btf_type_id(*s, 0 /* type id in this object file */);
+    *g = __builtin_btf_type_id(*s, 1 /* type id in target kernel */);
+  }
+
+  88 <charlie>:
+    17:     r1 = 0x1
+            88:  CO-RE <type_exists> [2] struct foo
+    18:     *(u64 *)(r2 + 0x0) = r1
+    19:     r1 = 0xc
+            98:  CO-RE <type_size> [2] struct foo
+    20:     *(u64 *)(r2 + 0x0) = r1
+    21:     r1 = 0x1
+            a8:  CO-RE <type_matches> [2] struct foo
+    22:     *(u64 *)(r2 + 0x0) = r1
+    23:     r1 = 0x2 ll
+            b8:  CO-RE <local_type_id> [2] struct foo
+    25:     *(u64 *)(r2 + 0x0) = r1
+    26:     r1 = 0x2 ll
+            d0:  CO-RE <target_type_id> [2] struct foo
+    28:     *(u64 *)(r2 + 0x0) = r1
+    29:     exit
+
+Enum-based relocations:
+
+.. code-block:: c
+
+  void delta(struct foo *s, volatile unsigned long *g) {
+    *g = __builtin_preserve_enum_value(*(enum bar *)U, 0 /* enum literal existence */);
+    *g = __builtin_preserve_enum_value(*(enum bar *)V, 1 /* enum literal value */);
+  }
+
+  f0 <delta>:
+    30:     r1 = 0x1 ll
+            f0:  CO-RE <enumval_exists> [16] enum bar::U = 0
+    32:     *(u64 *)(r2 + 0x0) = r1
+    33:     r1 = 0x1 ll
+            108:  CO-RE <enumval_value> [16] enum bar::V = 1
+    35:     *(u64 *)(r2 + 0x0) = r1
+    36:     exit
-- 
2.41.0


