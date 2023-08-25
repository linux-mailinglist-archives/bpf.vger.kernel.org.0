Return-Path: <bpf+bounces-8701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182A0789007
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 22:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BC91C20F9E
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 20:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8E1193A0;
	Fri, 25 Aug 2023 20:58:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A468174F7
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 20:58:04 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0562136
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 13:58:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52683b68c2fso1945754a12.0
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 13:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692997081; x=1693601881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/v6uwEVTLxipbBO4JZ1kLiUUHLdgN0NmJYvXs9g82c=;
        b=lYkcEwD5FuSbqsFsiXAn5pW7B5FuCGrOhwUg9saoecOqJNNikYDyzAT/RVlojowWer
         NDducbjCzLeWwPAJM8voQBDhKasvuvSJqshNb57xvytmQ0nCPnSoDEtvQm32HTiWpUIv
         MBUTyxSKsgqoAl/YCvtT0ppTPYtzYBT2u8+V1vuQmTa169naTuixnheJgQtEABqmt0fW
         quADbn64tdlBryUUlM+RFFHA//QLJ/JqIpnYk9yWWCcWrQK/lYgF6rX1r7q1j+NIjVkc
         /WLga2+dYjEGTy2NtRjnID0UOfKVR7IyxGmdbISaGtq6TUNEiGdt+9tHNQ68Dqco+TF1
         2BYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692997081; x=1693601881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/v6uwEVTLxipbBO4JZ1kLiUUHLdgN0NmJYvXs9g82c=;
        b=hv0qUIwuIZbtETxQMgeDfjb414ko2Xd9IL5swlb7TXqBbdhPxzfi6SU0oBdysjYGPC
         DO+j/nEaeM6DPgJJPDCzjLBuzvfC2+fckXrrkztObhTKDRv2ta34dqp5GTHvQys9+hQ1
         Z3XN51qk0bhAlx3FMY9ByYhRKr1VBR7fMFC7Sq0D1DoULLdZ/VpHGGFUgRwvzDKv4CJv
         FlEI1Mv8PkOHyE92gDrp/yQqaSU0g3zL4f0IVBEEERoWVfpa74Dxm04fKioUh7L9+8Ef
         DiQjBjuomvnmnhIuV1nhJMPhBaCBXSSvnTYD8oBVaQ+QBc+sZl93n0tpm9sNwElh5E7S
         FtzA==
X-Gm-Message-State: AOJu0Yx73gWohuTtaIdob0XTFhIScSd3jkkkSYu4FAp9YPKIAtyFIdU5
	uJgv+8hmABYGV1HtrVmgJRxJyo3Upj8VHiVzAPQ=
X-Google-Smtp-Source: AGHT+IEv8YdXfQOXhNNfRq/KL+TB1Yky1J5+5Xhd9GbNEqEK9qCixwxRUHDCRmrvkwILuSlfpBuJ51BndKKiJA183wg=
X-Received: by 2002:aa7:c648:0:b0:525:7e46:940 with SMTP id
 z8-20020aa7c648000000b005257e460940mr16719979edr.24.1692997081433; Fri, 25
 Aug 2023 13:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824230102.2117902-1-eddyz87@gmail.com>
In-Reply-To: <20230824230102.2117902-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Aug 2023 13:57:49 -0700
Message-ID: <CAEf4BzYzhHHSDA9MTMbrR_on-e7uqBUdOo690bEtCXYjg5cC6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Add description for CO-RE relocations
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 4:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Add a section on CO-RE relocations to llvm_relo.rst.
> Describe relevant .BTF.ext structure, `enum bpf_core_relo_kind`
> and `struct bpf_core_relo` in some detail.
> Description is based on doc-string from include/uapi/linux/bpf.h.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

Looks great overall, thanks a lot for adding this!

>  Documentation/bpf/btf.rst        |  27 ++++-
>  Documentation/bpf/llvm_reloc.rst | 178 +++++++++++++++++++++++++++++++
>  2 files changed, 201 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index f32db1f44ae9..c0530211c3c1 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -726,8 +726,8 @@ same as the one describe in :ref:`BTF_Type_String`.
>  4.2 .BTF.ext section
>  --------------------
>
> -The .BTF.ext section encodes func_info and line_info which needs loader
> -manipulation before loading into the kernel.
> +The .BTF.ext section encodes func_info, line_info and CO-RE relocations
> +which needs loader manipulation before loading into the kernel.
>
>  The specification for .BTF.ext section is defined at ``tools/lib/bpf/btf=
.h``
>  and ``tools/lib/bpf/btf.c``.
> @@ -745,11 +745,16 @@ The current header of .BTF.ext section::
>          __u32   func_info_len;
>          __u32   line_info_off;
>          __u32   line_info_len;
> +
> +        /* optional part of .BTF.ext header */
> +        __u32   core_relo_off;
> +        __u32   core_relo_len;
>      };
>
>  It is very similar to .BTF section. Instead of type/string section, it
> -contains func_info and line_info section. See :ref:`BPF_Prog_Load` for d=
etails
> -about func_info and line_info record format.
> +contains func_info, line_info and core_relo sub-sections.
> +See :ref:`BPF_Prog_Load` for details about func_info and line_info
> +record format.
>
>  The func_info is organized as below.::
>
> @@ -787,6 +792,20 @@ kernel API, the ``insn_off`` is the instruction offs=
et in the unit of ``struct
>  bpf_insn``. For ELF API, the ``insn_off`` is the byte offset from the
>  beginning of section (``btf_ext_info_sec->sec_name_off``).
>
> +The core_relo is organized as below.::
> +
> +     core_relo_rec_size

nit: should we specify that this is __u32 value? Same for func_info
and line_info. I'm not sure we ever explicitly mention this this
record size is 4 byte long.

> +     btf_ext_info_sec for section #1 /* core_relo for section #1 */
> +     btf_ext_info_sec for section #2 /* core_relo for section #2 */
> +
> +``core_relo_rec_size`` specifies the size of ``bpf_core_relo``
> +structure when .BTF.ext is generated. All ``bpf_core_relo`` structures
> +within a single ``btf_ext_info_sec`` describe relocations applied to
> +section named by ``btf_ext_info_sec::sec_name_off``.
> +
> +See :ref:`Documentation/bpf/llvm_reloc <btf-co-re-relocations>`
> +for more information on CO-RE relocations.
> +
>  4.2 .BTF_ids section
>  --------------------
>
> diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_re=
loc.rst
> index 450e6403fe3d..efe0b6ea4921 100644
> --- a/Documentation/bpf/llvm_reloc.rst
> +++ b/Documentation/bpf/llvm_reloc.rst
> @@ -240,3 +240,181 @@ The .BTF/.BTF.ext sections has R_BPF_64_NODYLD32 re=
locations::
>        Offset             Info             Type               Symbol's Va=
lue  Symbol's Name
>    000000000000002c  0000000200000004 R_BPF_64_NODYLD32      000000000000=
0000 .text
>    0000000000000040  0000000200000004 R_BPF_64_NODYLD32      000000000000=
0000 .text
> +
> +.. _btf-co-re-relocations:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +CO-RE Relocations
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +From object file point of view CO-RE mechanism is implemented as a set
> +of CO-RE specific relocation records. These relocation records are not
> +related to ELF relocations and are encoded in .BTF.ext section.
> +See :ref:`Documentation/bpf/btf <BTF_Ext_Section>` for more
> +information on .BTF.ext structure.
> +
> +
> +CO-RE relocations are applied to BPF instructions to update immediate
> +or offset fields of the instruction at load time with information
> +relevant for target kernel.
> +
> +Relocation kinds
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +There are several kinds of CO-RE relocations that could be split in
> +three groups:
> +
> +* Field-based - patch instruction with field related information, e.g.
> +  change offset field of the BPF_LD instruction to reflect offset
> +  of a specific structure field in the target kernel.
> +
> +* Type-based - patch instruction with type related information, e.g.
> +  change immediate field of the BPF_MOV instruction to 0 or 1 to
> +  reflect if specific type is present in the target kernel.
> +
> +* Enum-based - patch instruction with enum related information, e.g.
> +  change immediate field of the BPF_MOV instruction to reflect value
> +  of a specific enum literal in the target kernel.
> +

Instead of referencing BPF_MOV specifically, would it be useful to
incorporate all the different instructions that can be relocated?
bpf_core_patch_insn comment has a nice summary, maybe we can somehow
reuse it in this doc as well?

 * Currently supported classes of BPF instruction are:
 * 1. rX =3D <imm> (assignment with immediate operand);
 * 2. rX +=3D <imm> (arithmetic operations with immediate operand);
 * 3. rX =3D <imm64> (load with 64-bit immediate value);
 * 4. rX =3D *(T *)(rY + <off>), where T is one of {u8, u16, u32, u64};
 * 5. *(T *)(rX + <off>) =3D rY, where T is one of {u8, u16, u32, u64};
 * 6. *(T *)(rX + <off>) =3D <imm>, where T is one of {u8, u16, u32, u64}.


> +The complete list of relocation kinds is represented by the following en=
um:
> +
> +.. code-block:: c
> +
> + enum bpf_core_relo_kind {
> +       BPF_CORE_FIELD_BYTE_OFFSET =3D 0,  /* field byte offset */
> +       BPF_CORE_FIELD_BYTE_SIZE   =3D 1,  /* field size in bytes */
> +       BPF_CORE_FIELD_EXISTS      =3D 2,  /* field existence in target k=
ernel */
> +       BPF_CORE_FIELD_SIGNED      =3D 3,  /* field signedness (0 - unsig=
ned, 1 - signed) */
> +       BPF_CORE_FIELD_LSHIFT_U64  =3D 4,  /* bitfield-specific left bits=
hift */
> +       BPF_CORE_FIELD_RSHIFT_U64  =3D 5,  /* bitfield-specific right bit=
shift */
> +       BPF_CORE_TYPE_ID_LOCAL     =3D 6,  /* type ID in local BPF object=
 */
> +       BPF_CORE_TYPE_ID_TARGET    =3D 7,  /* type ID in target kernel */
> +       BPF_CORE_TYPE_EXISTS       =3D 8,  /* type existence in target ke=
rnel */
> +       BPF_CORE_TYPE_SIZE         =3D 9,  /* type size in bytes */
> +       BPF_CORE_ENUMVAL_EXISTS    =3D 10, /* enum value existence in tar=
get kernel */
> +       BPF_CORE_ENUMVAL_VALUE     =3D 11, /* enum value integer value */
> +       BPF_CORE_TYPE_MATCHES      =3D 12, /* type match in target kernel=
 */
> + };
> +
> +CO-RE Relocation Record
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +

[...]

> +CO-RE Relocation Examples
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
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
> +   s->a =3D 1;
> +   *g =3D __builtin_preserve_field_info(s->b, 1);
> +   *g =3D __builtin_preserve_type_info(*s, 1);
> +   *g =3D __builtin_preserve_enum_value(*(enum bar *)V, 1);
> + }
> +
> +With the following BTF definititions:

Gmail points to typo in "definitions"

> +
> +.. code-block::
> +
> + ...
> + [2] STRUCT 'foo' size=3D8 vlen=3D2
> +       'a' type_id=3D3 bits_offset=3D0
> +       'b' type_id=3D3 bits_offset=3D32
> + [3] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
> + ...
> + [9] ENUM 'bar' encoding=3DUNSIGNED size=3D4 vlen=3D2
> +       'U' val=3D0
> +       'V' val=3D1
> +
> +The following relocation entries would be generated:
> +
> +.. code-block:: c
> +
> +   <buz>:
> +       0:      *(u32 *)(r1 + 0x0) =3D 0x1
> +               00:  CO-RE <byte_off> [2] struct foo::a (0:0)
> +       1:      r1 =3D 0x4
> +               08:  CO-RE <byte_sz> [2] struct foo::b (0:1)
> +       2:      *(u64 *)(r2 + 0x0) =3D r1
> +       3:      r1 =3D 0x8
> +               18:  CO-RE <type_size> [2] struct foo
> +       4:      *(u64 *)(r2 + 0x0) =3D r1
> +       5:      r1 =3D 0x1 ll
> +               28:  CO-RE <enumval_value> [9] enum bar::V =3D 1
> +       7:      *(u64 *)(r2 + 0x0) =3D r1
> +       8:      exit
> +
> +Note: modifications for llvm-objdump to show these relocation entries
> +are currently work in progress.

Do we need this note here? Doesn't seem like you have any other
reference to llvm-objdump?

> --
> 2.41.0
>

