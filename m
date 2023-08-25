Return-Path: <bpf+bounces-8563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7E7788627
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 13:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D47C1C20F88
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC149D2EA;
	Fri, 25 Aug 2023 11:40:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B387C2FF
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:40:48 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359261FD7
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 04:40:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-977e0fbd742so97388766b.2
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 04:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692963644; x=1693568444;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vswk1NqZu4qraxDNzBPPbFzhYsWffkwDrUNgkV7B9Vw=;
        b=PzalQCkzHXDCJfHRTuCTV9SpvtKqYW9xh8IOfe/7ZCFXDizVbFNHP2pjy+4/OnkPtB
         X0/nxbNEr3R++21wEcNIvh0sGyEr5fyL6DxqrId7RzLcxXezZDcZ8u1K1G23CYUfwNb5
         twGLfT9z1JyavE0hea/584ufyYq9OGvIWu1KQQ59jzBtRaNcyWvkiOY/lAgcLRmtLZ7e
         hQVK/V0x/BA+hgfq7oZbodjeo/THdORFmzxUD4BFzvpyawhxmd3XUvT/EJ2VdkKR2Pey
         jzcyHMoki+7CpsCDYKR5Lb84qGKLcbg5j9HbpFtuxVUXXpiZ31R4HW5nn/NIZIeVSfXj
         +97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692963644; x=1693568444;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vswk1NqZu4qraxDNzBPPbFzhYsWffkwDrUNgkV7B9Vw=;
        b=LS0v/6QCp5fh9I0aK7nF7plqv17kLo47fCAhytcyAEtvJWSREsowAb4HA01vncQb8f
         9J6vUYKZUzcVjr7lUHe3x6bXeZfV39Psq7c8kNIg9Tjmzy4tj8yEKzVPdlHNEv/bZVeW
         chNdeeX4X031fmW6+jNvYAvE5txxTP33pypek2RgROQIAKof9be0DnbqSKGbJIoCjqSY
         niB+zfFio2vGO0emnWRhpHjVDevwSZZ0WF+8nFM/ISLHdBcEZ0OkvMrOe2hKLBbVooyF
         3I6OIBmuISeChyAGfp/Tk5uZyKbNbioLsSHu2D7OOw30oz7TfstV/yc/57iuUSGZwE+C
         Ypew==
X-Gm-Message-State: AOJu0YwV/2OeC5WgTTceifs5HcnfR8Fvjx5mOfl7Hg/Qx5McTR/gblZw
	GtoIRrt1ufeJFb7K9Ei0wVP8EUO2L5w=
X-Google-Smtp-Source: AGHT+IGSeRnGhb3f17M8T24ra+78LEf0GK78KBpi1GqFcDGwpGmd6tStSiCqvUblM+pzytdRzTYipA==
X-Received: by 2002:a17:906:4d2:b0:988:8be0:3077 with SMTP id g18-20020a17090604d200b009888be03077mr13815463eja.31.1692963644251;
        Fri, 25 Aug 2023 04:40:44 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709064e1500b0098f99048053sm894014eju.148.2023.08.25.04.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:40:43 -0700 (PDT)
Message-ID: <c7c1936bbfcb8b076de8b05db3baecae5d9fa8fd.camel@gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Add description for CO-RE relocations
From: Eduard Zingerman <eddyz87@gmail.com>
To: yonghong.song@linux.dev, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com
Date: Fri, 25 Aug 2023 14:40:42 +0300
In-Reply-To: <760317bb-188f-6967-b76d-1e9562a427b8@linux.dev>
References: <20230824230102.2117902-1-eddyz87@gmail.com>
	 <760317bb-188f-6967-b76d-1e9562a427b8@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-08-24 at 23:05 -0700, Yonghong Song wrote:
>=20
> On 8/24/23 4:01 PM, Eduard Zingerman wrote:
> > Add a section on CO-RE relocations to llvm_relo.rst.
> > Describe relevant .BTF.ext structure, `enum bpf_core_relo_kind`
> > and `struct bpf_core_relo` in some detail.
> > Description is based on doc-string from include/uapi/linux/bpf.h.
>=20
> Thanks Eduard. This is very helpful to give bpf deverlopers
> some insight about how different of core relocations are
> supported in llvm and libbpf.

Hi Yonghong,
thank you for taking a look.

>=20
> Some comments below.
>=20
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >   Documentation/bpf/btf.rst        |  27 ++++-
> >   Documentation/bpf/llvm_reloc.rst | 178 ++++++++++++++++++++++++++++++=
+
> >   2 files changed, 201 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> > index f32db1f44ae9..c0530211c3c1 100644
> > --- a/Documentation/bpf/btf.rst
> > +++ b/Documentation/bpf/btf.rst
> > @@ -726,8 +726,8 @@ same as the one describe in :ref:`BTF_Type_String`.
> >   4.2 .BTF.ext section
> >   --------------------
> >  =20
> > -The .BTF.ext section encodes func_info and line_info which needs loade=
r
> > -manipulation before loading into the kernel.
> > +The .BTF.ext section encodes func_info, line_info and CO-RE relocation=
s
> > +which needs loader manipulation before loading into the kernel.
> >  =20
> >   The specification for .BTF.ext section is defined at ``tools/lib/bpf/=
btf.h``
> >   and ``tools/lib/bpf/btf.c``.
> > @@ -745,11 +745,16 @@ The current header of .BTF.ext section::
> >           __u32   func_info_len;
> >           __u32   line_info_off;
> >           __u32   line_info_len;
> > +
> > +        /* optional part of .BTF.ext header */
> > +        __u32   core_relo_off;
> > +        __u32   core_relo_len;
> >       };
> >  =20
> >   It is very similar to .BTF section. Instead of type/string section, i=
t
> > -contains func_info and line_info section. See :ref:`BPF_Prog_Load` for=
 details
> > -about func_info and line_info record format.
> > +contains func_info, line_info and core_relo sub-sections.
> > +See :ref:`BPF_Prog_Load` for details about func_info and line_info
> > +record format.
> >  =20
> >   The func_info is organized as below.::
> >  =20
> > @@ -787,6 +792,20 @@ kernel API, the ``insn_off`` is the instruction of=
fset in the unit of ``struct
> >   bpf_insn``. For ELF API, the ``insn_off`` is the byte offset from the
> >   beginning of section (``btf_ext_info_sec->sec_name_off``).
> >  =20
> > +The core_relo is organized as below.::
> > +
> > +     core_relo_rec_size
> > +     btf_ext_info_sec for section #1 /* core_relo for section #1 */
> > +     btf_ext_info_sec for section #2 /* core_relo for section #2 */
> > +
> > +``core_relo_rec_size`` specifies the size of ``bpf_core_relo``
> > +structure when .BTF.ext is generated. All ``bpf_core_relo`` structures
> > +within a single ``btf_ext_info_sec`` describe relocations applied to
> > +section named by ``btf_ext_info_sec::sec_name_off``.
>=20
> bpf_ext_info_sec->sec_name_off ?

Will change.

>=20
> > +
> > +See :ref:`Documentation/bpf/llvm_reloc <btf-co-re-relocations>`
> > +for more information on CO-RE relocations.
> > +
> >   4.2 .BTF_ids section
> >   --------------------
> >  =20
> > diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_=
reloc.rst
> > index 450e6403fe3d..efe0b6ea4921 100644
> > --- a/Documentation/bpf/llvm_reloc.rst
> > +++ b/Documentation/bpf/llvm_reloc.rst
> > @@ -240,3 +240,181 @@ The .BTF/.BTF.ext sections has R_BPF_64_NODYLD32 =
relocations::
> >         Offset             Info             Type               Symbol's=
 Value  Symbol's Name
> >     000000000000002c  0000000200000004 R_BPF_64_NODYLD32      000000000=
0000000 .text
> >     0000000000000040  0000000200000004 R_BPF_64_NODYLD32      000000000=
0000000 .text
> > +
> > +.. _btf-co-re-relocations:
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +CO-RE Relocations
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +From object file point of view CO-RE mechanism is implemented as a set
> > +of CO-RE specific relocation records. These relocation records are not
> > +related to ELF relocations and are encoded in .BTF.ext section.
> > +See :ref:`Documentation/bpf/btf <BTF_Ext_Section>` for more
> > +information on .BTF.ext structure.
> > +
> > +
>=20
> one empty line here?

Will change.

>=20
> > +CO-RE relocations are applied to BPF instructions to update immediate
> > +or offset fields of the instruction at load time with information
> > +relevant for target kernel.
> > +
> > +Relocation kinds
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +There are several kinds of CO-RE relocations that could be split in
> > +three groups:
> > +
> > +* Field-based - patch instruction with field related information, e.g.
> > +  change offset field of the BPF_LD instruction to reflect offset
>=20
> BPF_LDX?

Correct, thank you.

>=20
> > +  of a specific structure field in the target kernel.
> > +
> > +* Type-based - patch instruction with type related information, e.g.
> > +  change immediate field of the BPF_MOV instruction to 0 or 1 to
> > +  reflect if specific type is present in the target kernel.
> > +
> > +* Enum-based - patch instruction with enum related information, e.g.
> > +  change immediate field of the BPF_MOV instruction to reflect value
> > +  of a specific enum literal in the target kernel.
>=20
> BPF_MOV -> BPF_LD_IMM64 ?
> below we actually have an example for this:
>    +       5:	r1 =3D 0x1 ll
>    +		28:  CO-RE <enumval_value> [9] enum bar::V =3D 1

Correct, thank you.

>=20
> > +
> > +The complete list of relocation kinds is represented by the following =
enum:
> > +
> > +.. code-block:: c
> > +
> > + enum bpf_core_relo_kind {
> > +	BPF_CORE_FIELD_BYTE_OFFSET =3D 0,  /* field byte offset */
> > +	BPF_CORE_FIELD_BYTE_SIZE   =3D 1,  /* field size in bytes */
> > +	BPF_CORE_FIELD_EXISTS      =3D 2,  /* field existence in target kerne=
l */
> > +	BPF_CORE_FIELD_SIGNED      =3D 3,  /* field signedness (0 - unsigned,=
 1 - signed) */
> > +	BPF_CORE_FIELD_LSHIFT_U64  =3D 4,  /* bitfield-specific left bitshift=
 */
> > +	BPF_CORE_FIELD_RSHIFT_U64  =3D 5,  /* bitfield-specific right bitshif=
t */
> > +	BPF_CORE_TYPE_ID_LOCAL     =3D 6,  /* type ID in local BPF object */
> > +	BPF_CORE_TYPE_ID_TARGET    =3D 7,  /* type ID in target kernel */
> > +	BPF_CORE_TYPE_EXISTS       =3D 8,  /* type existence in target kernel=
 */
> > +	BPF_CORE_TYPE_SIZE         =3D 9,  /* type size in bytes */
> > +	BPF_CORE_ENUMVAL_EXISTS    =3D 10, /* enum value existence in target =
kernel */
> > +	BPF_CORE_ENUMVAL_VALUE     =3D 11, /* enum value integer value */
> > +	BPF_CORE_TYPE_MATCHES      =3D 12, /* type match in target kernel */
> > + };
> > +
> > +CO-RE Relocation Record
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Relocation record is encoded as the following structure:
> > +
> > +.. code-block:: c
> > +
> > + struct bpf_core_relo {
> > +	__u32 insn_off;
> > +	__u32 type_id;
> > +	__u32 access_str_off;
> > +	enum bpf_core_relo_kind kind;
> > + };
> > +
> > +* ``insn_off`` - instruction offset (in bytes) within a code section
> > +  associated with this relocation;
> > +
> > +* ``type_id`` - BTF type ID of the "root" (containing) entity of a
> > +  relocatable type or field;
> > +
> > +* ``access_str_off`` - offset into corresponding .BTF string section.
> > +  String interpretation depends on specific relocation kind:
> > +
> > +  * for field-based relocations, string encodes an accessed field usin=
g
> > +    a sequence of field and array indices, separated by colon (:). It'=
s
> > +    conceptually very close to LLVM's `getelementptr <GEP_>`_ instruct=
ion's
> > +    arguments for identifying offset to a field. For example, consider=
 the
> > +    following C code:
> > +
> > +    .. code-block:: c
> > +
> > +       struct sample {
> > +           int a;
> > +           int b;
> > +           struct { int c[10]; };
> > +       } __attribute__((preserve_access_index));
> > +       struct sample *s;
> > +
> > +    * Access to ``s[0].a`` would be encoded as ``0:0``:
> > +
> > +      * ``0``: first element of ``s`` (as if ``s`` is an array);
> > +      * ``0``: index of field ``a`` in ``struct sample``.
> > +
> > +    * Access to ``s->a`` would be encoded as ``0:0`` as well.
> > +    * Access to ``s->b`` would be encoded as ``0:1``:
> > +
> > +      * ``0``: first element of ``s``;
> > +      * ``1``: index of field ``b`` in ``struct sample``.
> > +
> > +    * Access to ``s[1].c[5]`` would be encoded as ``1:2:0:5``:
> > +
> > +      * ``1``: second element of ``s``;
> > +      * ``2``: index of anonymous structure field in ``struct sample``=
;
> > +      * ``0``: index of field ``b`` in anonymous structure;
>=20
>=20
> ``b`` =3D> ``c``

Right, sorry, changed the example a few times ...

>=20
> > +      * ``5``: access to array element #5.
> > +
> > +  * for type-based relocations, string is expected to be just "0";
> > +
> > +  * for enum value-based relocations, string contains an index of enum
> > +     value within its enum type;
> > +
> > +* ``kind`` - one of ``enum bpf_core_relo_kind``.
> > +
> > +.. _GEP: https://llvm.org/docs/LangRef.html#getelementptr-instruction
> > +
> > +.. _btf_co_re_relocation_examples:
> > +
> > +CO-RE Relocation Examples
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +For the following C code:
> > +
> > +.. code-block:: c
> > +
> > + struct foo {
> > +     int a;
> > +     int b;
> > + } __attribute__((preserve_access_index));
> > +
> > + enum bar { U, V };
> > +
> > + void buz(struct foo *s, volatile unsigned long *g) {
> > +   s->a =3D 1;
> > +   *g =3D __builtin_preserve_field_info(s->b, 1);
> > +   *g =3D __builtin_preserve_type_info(*s, 1);
> > +   *g =3D __builtin_preserve_enum_value(*(enum bar *)V, 1);
>=20
> Maybe __builtin_btf_type_id() can be added as well?
> So far, clang only supports the above 4 builtin's for core
> relocations.

Will add __builtin_btf_type_id() as well.

>=20
> > + }
> > +
> > +With the following BTF definititions:
> > +
> > +.. code-block::
> > +
> > + ...
> > + [2] STRUCT 'foo' size=3D8 vlen=3D2
> > + 	'a' type_id=3D3 bits_offset=3D0
> > + 	'b' type_id=3D3 bits_offset=3D32
> > + [3] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
> > + ...
> > + [9] ENUM 'bar' encoding=3DUNSIGNED size=3D4 vlen=3D2
> > + 	'U' val=3D0
> > + 	'V' val=3D1
> > +
> > +The following relocation entries would be generated:
> > +
> > +.. code-block:: c
> > +
> > +   <buz>:
> > +       0:	*(u32 *)(r1 + 0x0) =3D 0x1
> > +		00:  CO-RE <byte_off> [2] struct foo::a (0:0)
> > +       1:	r1 =3D 0x4
> > +		08:  CO-RE <byte_sz> [2] struct foo::b (0:1)
> > +       2:	*(u64 *)(r2 + 0x0) =3D r1
> > +       3:	r1 =3D 0x8
> > +		18:  CO-RE <type_size> [2] struct foo
> > +       4:	*(u64 *)(r2 + 0x0) =3D r1
> > +       5:	r1 =3D 0x1 ll
> > +		28:  CO-RE <enumval_value> [9] enum bar::V =3D 1
> > +       7:	*(u64 *)(r2 + 0x0) =3D r1
> > +       8:	exit
> > +
>=20
> It would be great if we can have an example for each of above
> core relocation kinds.

You mean all 13 kinds, right?

>=20
> > +Note: modifications for llvm-objdump to show these relocation entries
> > +are currently work in progress.


