Return-Path: <bpf+bounces-8536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2A6787BC3
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 01:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434DE1C20F2D
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 23:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE8EBE78;
	Thu, 24 Aug 2023 23:02:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32DC7E
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 23:02:04 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B321BD8
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 16:01:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-500a398cda5so498062e87.0
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 16:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692918117; x=1693522917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4+B/qUi+5/cWmRV9wSP5rQC3KhX1nJUoLwuDJoiectM=;
        b=ipHw13OqZoFOpMBFGfcIyiwTvoH3JIY5JBcJq1eSKuZFOUmFDXRhi7Vsl+7U27wxrC
         CBES9vIfFymwrdBWIPeuv2ced8QNpeNQPOwMxZkDkpZySiLU4Rzf8peXKJZrmyQMKXaB
         2jj7Ii5riiU+hQjXF5HcGE2HKRcTqnOopAUx6PG4G3zK3xX92VTJIeSX8ARndAYqK3P2
         og5Nciteve9Gl4cteQWJ74uaE71+7PcIj3KQWYl5btfe3rzVLgBuY+vX0uB6vUm23OMW
         zkCRddnyy8S1oH4ho9dwPaiB3ZpBcMt83xR6at3QRG4dC3GT98qU02BSjykjM40ttvZ5
         fY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692918117; x=1693522917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+B/qUi+5/cWmRV9wSP5rQC3KhX1nJUoLwuDJoiectM=;
        b=HKmeT0qQhGzkfJS28GHk1GD5gjeXOQ4lusbrc7J48fx1o59W+vMqG0JH3IwzDZ8XJZ
         wnw7ToxjeMnQ5nnHhs1O+b3QGBGrwJx5+D/IP+UAEgkWNl/kmsTsPtGWYHvosvWw51Sm
         Lr1ktU0OhameyZRtN9O3wB30Z13i4k3iadW003St38zqCCKPlWi1iQ+CIW63VMxT8Gjo
         jwPuDkNMq/U1qMPEyGdrf/birMyXvdeBIGmd4dfdhv6aviYu0ywLcqgmsnD7cQq3izyq
         P/gUcjJ5TSh4HMS3NXYOeaVcIHBC1UJtTKw9906MsvQG34Uqb7iuY5Ud5CdVxfg5AxC1
         /zNw==
X-Gm-Message-State: AOJu0YxEtMy1+fIlNTnUHlg5YFsaEGPv717T1o6gULfMAsqDy++gXFNM
	Uxkg2B/aVpDchiM+ebw4Xy5I9CJJw+U=
X-Google-Smtp-Source: AGHT+IEgodOETktFBRsw6pwzdhWM7ZJjKPhAP/onbPzGnKRLdz9wll9RNUyy2ZFxH1ljCcz+sP8/7A==
X-Received: by 2002:a05:6512:3191:b0:4fb:9f93:365f with SMTP id i17-20020a056512319100b004fb9f93365fmr16087551lfe.38.1692918116909;
        Thu, 24 Aug 2023 16:01:56 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id jx13-20020a170906ca4d00b00992d122af63sm178297ejb.89.2023.08.24.16.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 16:01:56 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] docs/bpf: Add description for CO-RE relocations
Date: Fri, 25 Aug 2023 02:01:02 +0300
Message-ID: <20230824230102.2117902-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a section on CO-RE relocations to llvm_relo.rst.
Describe relevant .BTF.ext structure, `enum bpf_core_relo_kind`
and `struct bpf_core_relo` in some detail.
Description is based on doc-string from include/uapi/linux/bpf.h.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 Documentation/bpf/btf.rst        |  27 ++++-
 Documentation/bpf/llvm_reloc.rst | 178 +++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index f32db1f44ae9..c0530211c3c1 100644
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
@@ -745,11 +745,16 @@ The current header of .BTF.ext section::
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
 
@@ -787,6 +792,20 @@ kernel API, the ``insn_off`` is the instruction offset in the unit of ``struct
 bpf_insn``. For ELF API, the ``insn_off`` is the byte offset from the
 beginning of section (``btf_ext_info_sec->sec_name_off``).
 
+The core_relo is organized as below.::
+
+     core_relo_rec_size
+     btf_ext_info_sec for section #1 /* core_relo for section #1 */
+     btf_ext_info_sec for section #2 /* core_relo for section #2 */
+
+``core_relo_rec_size`` specifies the size of ``bpf_core_relo``
+structure when .BTF.ext is generated. All ``bpf_core_relo`` structures
+within a single ``btf_ext_info_sec`` describe relocations applied to
+section named by ``btf_ext_info_sec::sec_name_off``.
+
+See :ref:`Documentation/bpf/llvm_reloc <btf-co-re-relocations>`
+for more information on CO-RE relocations.
+
 4.2 .BTF_ids section
 --------------------
 
diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_reloc.rst
index 450e6403fe3d..efe0b6ea4921 100644
--- a/Documentation/bpf/llvm_reloc.rst
+++ b/Documentation/bpf/llvm_reloc.rst
@@ -240,3 +240,181 @@ The .BTF/.BTF.ext sections has R_BPF_64_NODYLD32 relocations::
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
+
+CO-RE relocations are applied to BPF instructions to update immediate
+or offset fields of the instruction at load time with information
+relevant for target kernel.
+
+Relocation kinds
+================
+
+There are several kinds of CO-RE relocations that could be split in
+three groups:
+
+* Field-based - patch instruction with field related information, e.g.
+  change offset field of the BPF_LD instruction to reflect offset
+  of a specific structure field in the target kernel.
+
+* Type-based - patch instruction with type related information, e.g.
+  change immediate field of the BPF_MOV instruction to 0 or 1 to
+  reflect if specific type is present in the target kernel.
+
+* Enum-based - patch instruction with enum related information, e.g.
+  change immediate field of the BPF_MOV instruction to reflect value
+  of a specific enum literal in the target kernel.
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
+      * ``0``: index of field ``b`` in anonymous structure;
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
+     int a;
+     int b;
+ } __attribute__((preserve_access_index));
+
+ enum bar { U, V };
+
+ void buz(struct foo *s, volatile unsigned long *g) {
+   s->a = 1;
+   *g = __builtin_preserve_field_info(s->b, 1);
+   *g = __builtin_preserve_type_info(*s, 1);
+   *g = __builtin_preserve_enum_value(*(enum bar *)V, 1);
+ }
+
+With the following BTF definititions:
+
+.. code-block::
+
+ ...
+ [2] STRUCT 'foo' size=8 vlen=2
+ 	'a' type_id=3 bits_offset=0
+ 	'b' type_id=3 bits_offset=32
+ [3] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
+ ...
+ [9] ENUM 'bar' encoding=UNSIGNED size=4 vlen=2
+ 	'U' val=0
+ 	'V' val=1
+
+The following relocation entries would be generated:
+
+.. code-block:: c
+
+   <buz>:
+       0:	*(u32 *)(r1 + 0x0) = 0x1
+		00:  CO-RE <byte_off> [2] struct foo::a (0:0)
+       1:	r1 = 0x4
+		08:  CO-RE <byte_sz> [2] struct foo::b (0:1)
+       2:	*(u64 *)(r2 + 0x0) = r1
+       3:	r1 = 0x8
+		18:  CO-RE <type_size> [2] struct foo
+       4:	*(u64 *)(r2 + 0x0) = r1
+       5:	r1 = 0x1 ll
+		28:  CO-RE <enumval_value> [9] enum bar::V = 1
+       7:	*(u64 *)(r2 + 0x0) = r1
+       8:	exit
+
+Note: modifications for llvm-objdump to show these relocation entries
+are currently work in progress.
-- 
2.41.0


