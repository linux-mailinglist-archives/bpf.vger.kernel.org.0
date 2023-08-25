Return-Path: <bpf+bounces-8543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98973787F84
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 08:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E79A2816BC
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 06:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BC217EC;
	Fri, 25 Aug 2023 06:05:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C6B288F4
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 06:05:37 +0000 (UTC)
Received: from out-2.mta1.migadu.com (out-2.mta1.migadu.com [IPv6:2001:41d0:203:375::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CD61BC7
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 23:05:35 -0700 (PDT)
Message-ID: <760317bb-188f-6967-b76d-1e9562a427b8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692943533; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkGqiKJ5a4A0RTrDkbc+NQOISVUCehZGoV2zNJ5hdqw=;
	b=IuW4AQCeYHyhbUqinSAegELCZPVgq2P4BYym86FBuQ56FzaMXqNpSElY2c2M4V5U3scBnF
	atCNC1hq4R8M6jkYB4LbEX2g2mwQz2N/FXNgWD3r5UsMlSw4tQpYaT1wCjJIzUbSt9Fldx
	E2EMoLc0+8rDQLnJPN13aksTKh9wSVs=
Date: Thu, 24 Aug 2023 23:05:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] docs/bpf: Add description for CO-RE relocations
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com
References: <20230824230102.2117902-1-eddyz87@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230824230102.2117902-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/24/23 4:01 PM, Eduard Zingerman wrote:
> Add a section on CO-RE relocations to llvm_relo.rst.
> Describe relevant .BTF.ext structure, `enum bpf_core_relo_kind`
> and `struct bpf_core_relo` in some detail.
> Description is based on doc-string from include/uapi/linux/bpf.h.

Thanks Eduard. This is very helpful to give bpf deverlopers
some insight about how different of core relocations are
supported in llvm and libbpf.

Some comments below.

> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   Documentation/bpf/btf.rst        |  27 ++++-
>   Documentation/bpf/llvm_reloc.rst | 178 +++++++++++++++++++++++++++++++
>   2 files changed, 201 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index f32db1f44ae9..c0530211c3c1 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -726,8 +726,8 @@ same as the one describe in :ref:`BTF_Type_String`.
>   4.2 .BTF.ext section
>   --------------------
>   
> -The .BTF.ext section encodes func_info and line_info which needs loader
> -manipulation before loading into the kernel.
> +The .BTF.ext section encodes func_info, line_info and CO-RE relocations
> +which needs loader manipulation before loading into the kernel.
>   
>   The specification for .BTF.ext section is defined at ``tools/lib/bpf/btf.h``
>   and ``tools/lib/bpf/btf.c``.
> @@ -745,11 +745,16 @@ The current header of .BTF.ext section::
>           __u32   func_info_len;
>           __u32   line_info_off;
>           __u32   line_info_len;
> +
> +        /* optional part of .BTF.ext header */
> +        __u32   core_relo_off;
> +        __u32   core_relo_len;
>       };
>   
>   It is very similar to .BTF section. Instead of type/string section, it
> -contains func_info and line_info section. See :ref:`BPF_Prog_Load` for details
> -about func_info and line_info record format.
> +contains func_info, line_info and core_relo sub-sections.
> +See :ref:`BPF_Prog_Load` for details about func_info and line_info
> +record format.
>   
>   The func_info is organized as below.::
>   
> @@ -787,6 +792,20 @@ kernel API, the ``insn_off`` is the instruction offset in the unit of ``struct
>   bpf_insn``. For ELF API, the ``insn_off`` is the byte offset from the
>   beginning of section (``btf_ext_info_sec->sec_name_off``).
>   
> +The core_relo is organized as below.::
> +
> +     core_relo_rec_size
> +     btf_ext_info_sec for section #1 /* core_relo for section #1 */
> +     btf_ext_info_sec for section #2 /* core_relo for section #2 */
> +
> +``core_relo_rec_size`` specifies the size of ``bpf_core_relo``
> +structure when .BTF.ext is generated. All ``bpf_core_relo`` structures
> +within a single ``btf_ext_info_sec`` describe relocations applied to
> +section named by ``btf_ext_info_sec::sec_name_off``.

bpf_ext_info_sec->sec_name_off ?

> +
> +See :ref:`Documentation/bpf/llvm_reloc <btf-co-re-relocations>`
> +for more information on CO-RE relocations.
> +
>   4.2 .BTF_ids section
>   --------------------
>   
> diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_reloc.rst
> index 450e6403fe3d..efe0b6ea4921 100644
> --- a/Documentation/bpf/llvm_reloc.rst
> +++ b/Documentation/bpf/llvm_reloc.rst
> @@ -240,3 +240,181 @@ The .BTF/.BTF.ext sections has R_BPF_64_NODYLD32 relocations::
>         Offset             Info             Type               Symbol's Value  Symbol's Name
>     000000000000002c  0000000200000004 R_BPF_64_NODYLD32      0000000000000000 .text
>     0000000000000040  0000000200000004 R_BPF_64_NODYLD32      0000000000000000 .text
> +
> +.. _btf-co-re-relocations:
> +
> +=================
> +CO-RE Relocations
> +=================
> +
> +From object file point of view CO-RE mechanism is implemented as a set
> +of CO-RE specific relocation records. These relocation records are not
> +related to ELF relocations and are encoded in .BTF.ext section.
> +See :ref:`Documentation/bpf/btf <BTF_Ext_Section>` for more
> +information on .BTF.ext structure.
> +
> +

one empty line here?

> +CO-RE relocations are applied to BPF instructions to update immediate
> +or offset fields of the instruction at load time with information
> +relevant for target kernel.
> +
> +Relocation kinds
> +================
> +
> +There are several kinds of CO-RE relocations that could be split in
> +three groups:
> +
> +* Field-based - patch instruction with field related information, e.g.
> +  change offset field of the BPF_LD instruction to reflect offset

BPF_LDX?

> +  of a specific structure field in the target kernel.
> +
> +* Type-based - patch instruction with type related information, e.g.
> +  change immediate field of the BPF_MOV instruction to 0 or 1 to
> +  reflect if specific type is present in the target kernel.
> +
> +* Enum-based - patch instruction with enum related information, e.g.
> +  change immediate field of the BPF_MOV instruction to reflect value
> +  of a specific enum literal in the target kernel.

BPF_MOV -> BPF_LD_IMM64 ?
below we actually have an example for this:
   +       5:	r1 = 0x1 ll
   +		28:  CO-RE <enumval_value> [9] enum bar::V = 1

> +
> +The complete list of relocation kinds is represented by the following enum:
> +
> +.. code-block:: c
> +
> + enum bpf_core_relo_kind {
> +	BPF_CORE_FIELD_BYTE_OFFSET = 0,  /* field byte offset */
> +	BPF_CORE_FIELD_BYTE_SIZE   = 1,  /* field size in bytes */
> +	BPF_CORE_FIELD_EXISTS      = 2,  /* field existence in target kernel */
> +	BPF_CORE_FIELD_SIGNED      = 3,  /* field signedness (0 - unsigned, 1 - signed) */
> +	BPF_CORE_FIELD_LSHIFT_U64  = 4,  /* bitfield-specific left bitshift */
> +	BPF_CORE_FIELD_RSHIFT_U64  = 5,  /* bitfield-specific right bitshift */
> +	BPF_CORE_TYPE_ID_LOCAL     = 6,  /* type ID in local BPF object */
> +	BPF_CORE_TYPE_ID_TARGET    = 7,  /* type ID in target kernel */
> +	BPF_CORE_TYPE_EXISTS       = 8,  /* type existence in target kernel */
> +	BPF_CORE_TYPE_SIZE         = 9,  /* type size in bytes */
> +	BPF_CORE_ENUMVAL_EXISTS    = 10, /* enum value existence in target kernel */
> +	BPF_CORE_ENUMVAL_VALUE     = 11, /* enum value integer value */
> +	BPF_CORE_TYPE_MATCHES      = 12, /* type match in target kernel */
> + };
> +
> +CO-RE Relocation Record
> +=======================
> +
> +Relocation record is encoded as the following structure:
> +
> +.. code-block:: c
> +
> + struct bpf_core_relo {
> +	__u32 insn_off;
> +	__u32 type_id;
> +	__u32 access_str_off;
> +	enum bpf_core_relo_kind kind;
> + };
> +
> +* ``insn_off`` - instruction offset (in bytes) within a code section
> +  associated with this relocation;
> +
> +* ``type_id`` - BTF type ID of the "root" (containing) entity of a
> +  relocatable type or field;
> +
> +* ``access_str_off`` - offset into corresponding .BTF string section.
> +  String interpretation depends on specific relocation kind:
> +
> +  * for field-based relocations, string encodes an accessed field using
> +    a sequence of field and array indices, separated by colon (:). It's
> +    conceptually very close to LLVM's `getelementptr <GEP_>`_ instruction's
> +    arguments for identifying offset to a field. For example, consider the
> +    following C code:
> +
> +    .. code-block:: c
> +
> +       struct sample {
> +           int a;
> +           int b;
> +           struct { int c[10]; };
> +       } __attribute__((preserve_access_index));
> +       struct sample *s;
> +
> +    * Access to ``s[0].a`` would be encoded as ``0:0``:
> +
> +      * ``0``: first element of ``s`` (as if ``s`` is an array);
> +      * ``0``: index of field ``a`` in ``struct sample``.
> +
> +    * Access to ``s->a`` would be encoded as ``0:0`` as well.
> +    * Access to ``s->b`` would be encoded as ``0:1``:
> +
> +      * ``0``: first element of ``s``;
> +      * ``1``: index of field ``b`` in ``struct sample``.
> +
> +    * Access to ``s[1].c[5]`` would be encoded as ``1:2:0:5``:
> +
> +      * ``1``: second element of ``s``;
> +      * ``2``: index of anonymous structure field in ``struct sample``;
> +      * ``0``: index of field ``b`` in anonymous structure;


``b`` => ``c``

> +      * ``5``: access to array element #5.
> +
> +  * for type-based relocations, string is expected to be just "0";
> +
> +  * for enum value-based relocations, string contains an index of enum
> +     value within its enum type;
> +
> +* ``kind`` - one of ``enum bpf_core_relo_kind``.
> +
> +.. _GEP: https://llvm.org/docs/LangRef.html#getelementptr-instruction
> +
> +.. _btf_co_re_relocation_examples:
> +
> +CO-RE Relocation Examples
> +=========================
> +
> +For the following C code:
> +
> +.. code-block:: c
> +
> + struct foo {
> +     int a;
> +     int b;
> + } __attribute__((preserve_access_index));
> +
> + enum bar { U, V };
> +
> + void buz(struct foo *s, volatile unsigned long *g) {
> +   s->a = 1;
> +   *g = __builtin_preserve_field_info(s->b, 1);
> +   *g = __builtin_preserve_type_info(*s, 1);
> +   *g = __builtin_preserve_enum_value(*(enum bar *)V, 1);

Maybe __builtin_btf_type_id() can be added as well?
So far, clang only supports the above 4 builtin's for core
relocations.

> + }
> +
> +With the following BTF definititions:
> +
> +.. code-block::
> +
> + ...
> + [2] STRUCT 'foo' size=8 vlen=2
> + 	'a' type_id=3 bits_offset=0
> + 	'b' type_id=3 bits_offset=32
> + [3] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> + ...
> + [9] ENUM 'bar' encoding=UNSIGNED size=4 vlen=2
> + 	'U' val=0
> + 	'V' val=1
> +
> +The following relocation entries would be generated:
> +
> +.. code-block:: c
> +
> +   <buz>:
> +       0:	*(u32 *)(r1 + 0x0) = 0x1
> +		00:  CO-RE <byte_off> [2] struct foo::a (0:0)
> +       1:	r1 = 0x4
> +		08:  CO-RE <byte_sz> [2] struct foo::b (0:1)
> +       2:	*(u64 *)(r2 + 0x0) = r1
> +       3:	r1 = 0x8
> +		18:  CO-RE <type_size> [2] struct foo
> +       4:	*(u64 *)(r2 + 0x0) = r1
> +       5:	r1 = 0x1 ll
> +		28:  CO-RE <enumval_value> [9] enum bar::V = 1
> +       7:	*(u64 *)(r2 + 0x0) = r1
> +       8:	exit
> +

It would be great if we can have an example for each of above
core relocation kinds.

> +Note: modifications for llvm-objdump to show these relocation entries
> +are currently work in progress.

