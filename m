Return-Path: <bpf+bounces-8702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855E778902B
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 23:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379EB281857
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 21:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284E9193AB;
	Fri, 25 Aug 2023 21:10:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C382419386
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 21:10:09 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C4F2114
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 14:10:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bf3f59905so163667566b.3
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692997806; x=1693602606;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5LbMDmWApOGCoie5sXiP2+oW/lXeDqyDdorqK9LnG+k=;
        b=XjVJLQ8eSlPVqEEOiOq2+KHbMiD7LgQI6xWYLj+73nhR4mbprtxeQwfx7p9D4ZKCQ/
         vrigGJed2euaYxSmPJu5hN1gnCPcqgdKqBE8hcaFAWRqTDJvTzaSWsEJiEsdrc7g17hi
         VtZJK999+2KVDpTBSpq1r+f+S7e/J8jMQaEM5YDMzttkalK3SGML8jyIGn8oTm/u54F4
         WZd3neGf6UbAt908tqOmiRgMH6IShl/WpxAKxNjLwQYDBuD4K1KOrTTCS1n2KR0XGOkq
         DKRX+D4tTX9qZwpZljMpdX3jUuUMzAxl+11xdZp9evjAIfwSr/ULj454ZpNrAk3XiVOL
         jovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692997806; x=1693602606;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5LbMDmWApOGCoie5sXiP2+oW/lXeDqyDdorqK9LnG+k=;
        b=L6AAJuF4xqzokCquATVtiXUdXf644shKgIlAiy1bQlntOayMpYnTjsmqDqiKoKd7t1
         f/mApojnzpQ7F3etVxQoih74sISAzF+E/fClkR2SrODC/G0o4nXzOX0+8S3jTzfplujx
         C6aHIKA7f8kkqVqyTiJf0Z6GvFAbDx6ZlKhALlLwtYKjH4kue1aSuM95jVo6gFhsZuv9
         u99Kojc0uuD0yb+zj/jnleW30yiaxLpPioHZXOzf3u05OT6VMbQFM7TFKGtGPUvvQy4X
         c0ckshDLqKNHyUW4I2+JNBO9luTPD7XAa5Tfx9mhP5ShF4fyUDmwXFdI/7ZzWhPSaYC8
         2NhA==
X-Gm-Message-State: AOJu0YyFSI9zqmcmG8yURDnY2A9UCwmAJnzckutp4uDIHyUHhZKHbR9t
	tn8Osum1xtJ8SDfEzwxthdMPXDQGSesHww==
X-Google-Smtp-Source: AGHT+IHdoljDsKe3kpF28j0IBXzWChPZEcdN4WW3h/2rjjxR4DgQIEXSebiKHBp/PoiGF6Reo7cT6w==
X-Received: by 2002:a17:907:7603:b0:9a1:e395:2d10 with SMTP id jx3-20020a170907760300b009a1e3952d10mr6777574ejc.75.1692997806039;
        Fri, 25 Aug 2023 14:10:06 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id va17-20020a17090711d100b00992b71d8f19sm1342663ejb.133.2023.08.25.14.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:10:05 -0700 (PDT)
Message-ID: <0538002efbbc5e887c9e740c7891d2f88ca17e4b.camel@gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Add description for CO-RE relocations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Sat, 26 Aug 2023 00:10:04 +0300
In-Reply-To: <CAEf4BzYzhHHSDA9MTMbrR_on-e7uqBUdOo690bEtCXYjg5cC6A@mail.gmail.com>
References: <20230824230102.2117902-1-eddyz87@gmail.com>
	 <CAEf4BzYzhHHSDA9MTMbrR_on-e7uqBUdOo690bEtCXYjg5cC6A@mail.gmail.com>
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

On Fri, 2023-08-25 at 13:57 -0700, Andrii Nakryiko wrote:
> On Thu, Aug 24, 2023 at 4:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > Add a section on CO-RE relocations to llvm_relo.rst.
> > Describe relevant .BTF.ext structure, `enum bpf_core_relo_kind`
> > and `struct bpf_core_relo` in some detail.
> > Description is based on doc-string from include/uapi/linux/bpf.h.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
>=20
> Looks great overall, thanks a lot for adding this!
>=20
> >  Documentation/bpf/btf.rst        |  27 ++++-
> >  Documentation/bpf/llvm_reloc.rst | 178 +++++++++++++++++++++++++++++++
> >  2 files changed, 201 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> > index f32db1f44ae9..c0530211c3c1 100644
> > --- a/Documentation/bpf/btf.rst
> > +++ b/Documentation/bpf/btf.rst
> > @@ -726,8 +726,8 @@ same as the one describe in :ref:`BTF_Type_String`.
> >  4.2 .BTF.ext section
> >  --------------------
> >=20
> > -The .BTF.ext section encodes func_info and line_info which needs loade=
r
> > -manipulation before loading into the kernel.
> > +The .BTF.ext section encodes func_info, line_info and CO-RE relocation=
s
> > +which needs loader manipulation before loading into the kernel.
> >=20
> >  The specification for .BTF.ext section is defined at ``tools/lib/bpf/b=
tf.h``
> >  and ``tools/lib/bpf/btf.c``.
> > @@ -745,11 +745,16 @@ The current header of .BTF.ext section::
> >          __u32   func_info_len;
> >          __u32   line_info_off;
> >          __u32   line_info_len;
> > +
> > +        /* optional part of .BTF.ext header */
> > +        __u32   core_relo_off;
> > +        __u32   core_relo_len;
> >      };
> >=20
> >  It is very similar to .BTF section. Instead of type/string section, it
> > -contains func_info and line_info section. See :ref:`BPF_Prog_Load` for=
 details
> > -about func_info and line_info record format.
> > +contains func_info, line_info and core_relo sub-sections.
> > +See :ref:`BPF_Prog_Load` for details about func_info and line_info
> > +record format.
> >=20
> >  The func_info is organized as below.::
> >=20
> > @@ -787,6 +792,20 @@ kernel API, the ``insn_off`` is the instruction of=
fset in the unit of ``struct
> >  bpf_insn``. For ELF API, the ``insn_off`` is the byte offset from the
> >  beginning of section (``btf_ext_info_sec->sec_name_off``).
> >=20
> > +The core_relo is organized as below.::
> > +
> > +     core_relo_rec_size
>=20
> nit: should we specify that this is __u32 value? Same for func_info
> and line_info. I'm not sure we ever explicitly mention this this
> record size is 4 byte long.

Yeap, we don't mention it anywhere, I will add __u32 to the
description.

>=20
> > +     btf_ext_info_sec for section #1 /* core_relo for section #1 */
> > +     btf_ext_info_sec for section #2 /* core_relo for section #2 */
> > +
> > +``core_relo_rec_size`` specifies the size of ``bpf_core_relo``
> > +structure when .BTF.ext is generated. All ``bpf_core_relo`` structures
> > +within a single ``btf_ext_info_sec`` describe relocations applied to
> > +section named by ``btf_ext_info_sec::sec_name_off``.
> > +
> > +See :ref:`Documentation/bpf/llvm_reloc <btf-co-re-relocations>`
> > +for more information on CO-RE relocations.
> > +
> >  4.2 .BTF_ids section
> >  --------------------
> >=20
> > diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_=
reloc.rst
> > index 450e6403fe3d..efe0b6ea4921 100644
> > --- a/Documentation/bpf/llvm_reloc.rst
> > +++ b/Documentation/bpf/llvm_reloc.rst
> > @@ -240,3 +240,181 @@ The .BTF/.BTF.ext sections has R_BPF_64_NODYLD32 =
relocations::
> >        Offset             Info             Type               Symbol's =
Value  Symbol's Name
> >    000000000000002c  0000000200000004 R_BPF_64_NODYLD32      0000000000=
000000 .text
> >    0000000000000040  0000000200000004 R_BPF_64_NODYLD32      0000000000=
000000 .text
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
> > +  of a specific structure field in the target kernel.
> > +
> > +* Type-based - patch instruction with type related information, e.g.
> > +  change immediate field of the BPF_MOV instruction to 0 or 1 to
> > +  reflect if specific type is present in the target kernel.
> > +
> > +* Enum-based - patch instruction with enum related information, e.g.
> > +  change immediate field of the BPF_MOV instruction to reflect value
> > +  of a specific enum literal in the target kernel.
> > +
>=20
> Instead of referencing BPF_MOV specifically, would it be useful to
> incorporate all the different instructions that can be relocated?
> bpf_core_patch_insn comment has a nice summary, maybe we can somehow
> reuse it in this doc as well?
>=20
>  * Currently supported classes of BPF instruction are:
>  * 1. rX =3D <imm> (assignment with immediate operand);
>  * 2. rX +=3D <imm> (arithmetic operations with immediate operand);
>  * 3. rX =3D <imm64> (load with 64-bit immediate value);
>  * 4. rX =3D *(T *)(rY + <off>), where T is one of {u8, u16, u32, u64};
>  * 5. *(T *)(rX + <off>) =3D rY, where T is one of {u8, u16, u32, u64};
>  * 6. *(T *)(rX + <off>) =3D <imm>, where T is one of {u8, u16, u32, u64}=
.

Good point. I will keep the BPF_MOV as an example for relocation kind
groups description and add this comment describing all relocatable
instructions.

> > +The complete list of relocation kinds is represented by the following =
enum:
> > +
> > +.. code-block:: c
> > +
> > + enum bpf_core_relo_kind {
> > +       BPF_CORE_FIELD_BYTE_OFFSET =3D 0,  /* field byte offset */
> > +       BPF_CORE_FIELD_BYTE_SIZE   =3D 1,  /* field size in bytes */
> > +       BPF_CORE_FIELD_EXISTS      =3D 2,  /* field existence in target=
 kernel */
> > +       BPF_CORE_FIELD_SIGNED      =3D 3,  /* field signedness (0 - uns=
igned, 1 - signed) */
> > +       BPF_CORE_FIELD_LSHIFT_U64  =3D 4,  /* bitfield-specific left bi=
tshift */
> > +       BPF_CORE_FIELD_RSHIFT_U64  =3D 5,  /* bitfield-specific right b=
itshift */
> > +       BPF_CORE_TYPE_ID_LOCAL     =3D 6,  /* type ID in local BPF obje=
ct */
> > +       BPF_CORE_TYPE_ID_TARGET    =3D 7,  /* type ID in target kernel =
*/
> > +       BPF_CORE_TYPE_EXISTS       =3D 8,  /* type existence in target =
kernel */
> > +       BPF_CORE_TYPE_SIZE         =3D 9,  /* type size in bytes */
> > +       BPF_CORE_ENUMVAL_EXISTS    =3D 10, /* enum value existence in t=
arget kernel */
> > +       BPF_CORE_ENUMVAL_VALUE     =3D 11, /* enum value integer value =
*/
> > +       BPF_CORE_TYPE_MATCHES      =3D 12, /* type match in target kern=
el */
> > + };
> > +
> > +CO-RE Relocation Record
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
>=20
> [...]
>=20
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
> > + }
> > +
> > +With the following BTF definititions:
>=20
> Gmail points to typo in "definitions"

Ouch.

> > +
> > +.. code-block::
> > +
> > + ...
> > + [2] STRUCT 'foo' size=3D8 vlen=3D2
> > +       'a' type_id=3D3 bits_offset=3D0
> > +       'b' type_id=3D3 bits_offset=3D32
> > + [3] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
> > + ...
> > + [9] ENUM 'bar' encoding=3DUNSIGNED size=3D4 vlen=3D2
> > +       'U' val=3D0
> > +       'V' val=3D1
> > +
> > +The following relocation entries would be generated:
> > +
> > +.. code-block:: c
> > +
> > +   <buz>:
> > +       0:      *(u32 *)(r1 + 0x0) =3D 0x1
> > +               00:  CO-RE <byte_off> [2] struct foo::a (0:0)
> > +       1:      r1 =3D 0x4
> > +               08:  CO-RE <byte_sz> [2] struct foo::b (0:1)
> > +       2:      *(u64 *)(r2 + 0x0) =3D r1
> > +       3:      r1 =3D 0x8
> > +               18:  CO-RE <type_size> [2] struct foo
> > +       4:      *(u64 *)(r2 + 0x0) =3D r1
> > +       5:      r1 =3D 0x1 ll
> > +               28:  CO-RE <enumval_value> [9] enum bar::V =3D 1
> > +       7:      *(u64 *)(r2 + 0x0) =3D r1
> > +       8:      exit
> > +
> > +Note: modifications for llvm-objdump to show these relocation entries
> > +are currently work in progress.
>=20
> Do we need this note here? Doesn't seem like you have any other
> reference to llvm-objdump?

Idk, I hope that llvm-objdump update would be merged eventually and
I'll replace the note with correct llvm-objdump incantation.

