Return-Path: <bpf+bounces-8753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B897897A9
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 17:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60045281774
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 15:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF13ADF6F;
	Sat, 26 Aug 2023 15:10:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0BD314
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 15:10:23 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226F310D7
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 08:10:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso417087266b.1
        for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 08:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693062618; x=1693667418;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0+q/dRyCabSnYyFVjXswD8cyTHSnLftX9i4q55IGZPk=;
        b=YowU9R0OslfLYSEZooIhK27rwhGYO2Kv7IuwnvNYN6iNbr5/PA/Bz8f4F6L2Xk2WHg
         0Gq7I9ypZmH17s9f0PYM8FXQSlFH4oObQvNLytX5oV+pO6uY4ItpULFqHqUy5hlwgqJf
         onuFb9ENqtVGNiq/FyZNQrQTsOjz5omJEs4fv72ovzmGJnrfviIa/xbiFoKVieqCJSVM
         +M4BR1/dZsdTjqfxkNrAq8933rBeQALbJVqXHQW+y8jSc5+DL1BVf/HlWproDaFrbhwh
         AHjXp+4/K1bZI+7PWVLznK0/91aP0dEXDdQTXswLeFAxd+IyKj76NV5bSkPgmvAt+pop
         ArPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693062618; x=1693667418;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+q/dRyCabSnYyFVjXswD8cyTHSnLftX9i4q55IGZPk=;
        b=ThEkUWt5Pfl+AdymG1JIdKz1VgfXILg4tTw/fsdXVO82bAc9DE4IV/gkBWetzsy9rL
         dbWHDnQBWMjaSWMT0CxC6oOzmzSPVGOAOFJawPRQqKJ0UCxoDYh5TxpmGx3HT5PUjfB9
         /bsz2+MO/jD2ouvme8LaidYoul30wyB9tj4l7qLiWcFVS2pylTQR/eNxeWLAv86SR9dY
         Uv8ncwwZpUKTAcbMHcfEs1IqAYChliMuAfJGkALcsudYx945PgGeKobBVahwRGXCI374
         daRnpNZ0mZtXWQUkG3Y26gHx20gSBHwbtEofZ5nkOkaOQKpPWh06j9GyvF2D/Gc1JuJw
         Ba6g==
X-Gm-Message-State: AOJu0YxadsCyMzXeLCv/qmdICPA7sgTloxVhX+9QgVnGVmGTxxakoXJ+
	RwM9vac6zbe8KG6I52XQk0wDdDab6T7Sqg==
X-Google-Smtp-Source: AGHT+IGtKHL1vP7n3DXG1yhZ0kYXh2526Ei6BZvHUQ9uGwkbehcKF9iFMafrnVHSwGRNruE1tJ7coA==
X-Received: by 2002:a17:907:80cc:b0:9a5:9b93:d60d with SMTP id io12-20020a17090780cc00b009a59b93d60dmr507674ejc.36.1693062618355;
        Sat, 26 Aug 2023 08:10:18 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h1-20020a1709062dc100b0098921e1b064sm2264255eji.181.2023.08.26.08.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 08:10:17 -0700 (PDT)
Message-ID: <3cf0b0c3fd62ad3720ff8b562488af0eca1282a3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] docs/bpf: Add description for CO-RE
 relocations
From: Eduard Zingerman <eddyz87@gmail.com>
To: yonghong.song@linux.dev, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com
Date: Sat, 26 Aug 2023 18:10:16 +0300
In-Reply-To: <0aa436da-0b5a-166a-b45d-2ad11a985508@linux.dev>
References: <20230825224527.2465062-1-eddyz87@gmail.com>
	 <20230825224527.2465062-2-eddyz87@gmail.com>
	 <0aa436da-0b5a-166a-b45d-2ad11a985508@linux.dev>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-08-25 at 21:24 -0700, Yonghong Song wrote:
>=20
> On 8/25/23 3:45 PM, Eduard Zingerman wrote:
> > Add a section on CO-RE relocations to llvm_relo.rst.
> > Describe relevant .BTF.ext structure, `enum bpf_core_relo_kind`
> > and `struct bpf_core_relo` in some detail.
> > Description is based on doc-strings from:
> > - include/uapi/linux/bpf.h:struct bpf_core_relo
> > - tools/lib/bpf/relo_core.c:__bpf_core_types_match()
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> LGTM with a couple minor nits below.

Thank you, will fix these nits in the v3.

>=20
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>=20
> > ---
> >   Documentation/bpf/btf.rst        |  31 +++-
> >   Documentation/bpf/llvm_reloc.rst | 304 ++++++++++++++++++++++++++++++=
+
> >   2 files changed, 329 insertions(+), 6 deletions(-)
> >=20
> [...]
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
> > +Notes:
> > +
> > +* ``BPF_CORE_FIELD_LSHIFT_U64`` and ``BPF_CORE_FIELD_RSHIFT_U64`` are
> > +  supposed to be used to read bitfield values using the following
> > +  algorithm:
> > +
> > +  .. code-block:: c
> > +
> > +     // To read bitfield ``f`` from ``struct s``
> > +     is_signed =3D relo(s->f, BPF_CORE_FIELD_SIGNED)
> > +     off =3D relo(s->f, BPF_CORE_FIELD_BYTE_OFFSET)
> > +     sz  =3D relo(s->f, BPF_CORE_FIELD_BYTE_SIZE)
> > +     l   =3D relo(s->f, BPF_CORE_FIELD_LSHIFT_U64)
> > +     r   =3D relo(s->f, BPF_CORE_FIELD_RSHIFT_U64)
> > +     // define ``v`` as signed or unsigned integer of size ``sz``
> > +     v =3D *((void *)s) + off)
>=20
> parenthesis not matching in the above.
>=20
> How about below to a little bit more precise?
>    v =3D *({s|u}<sz> *)((void *)s + off)
>=20
> > +     v <<=3D l
> > +     v >>=3D r
> > +
> [...]
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
> > +   int a;
> > +   int b;
> > +   unsigned c:15;
> > + } __attribute__((preserve_access_index));
> > +
> > + enum bar { U, V };
> > +
> > +With the following BTF definitions:
> > +
> > +.. code-block::
> > +
> > + ...
> > + [2] STRUCT 'foo' size=3D8 vlen=3D2
> > + 	'a' type_id=3D3 bits_offset=3D0
> > + 	'b' type_id=3D3 bits_offset=3D32
> > +        'c' type_id=3D4 bits_offset=3D64 bitfield_size=3D15
>=20
> Misalignment in the above.
>=20
>=20
> > + [3] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
> > + [4] INT 'unsigned int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=
=3D(none)
> > + ...
> > + [16] ENUM 'bar' encoding=3DUNSIGNED size=3D4 vlen=3D2
> > + 	'U' val=3D0
> > + 	'V' val=3D1
> > +
> > +Field offset relocations are generated automatically when
> > +``__attribute__((preserve_access_index))`` is used, for example:
> > +
> > +.. code-block:: c
> > +
> > +  void alpha(struct foo *s, volatile unsigned long *g) {
> > +    *g =3D s->a;
> > +    s->a =3D 1;
> > +  }
> > +
> > +  00 <alpha>:
> > +    0:  r3 =3D *(s32 *)(r1 + 0x0)
> > +           00:  CO-RE <byte_off> [2] struct foo::a (0:0)
> > +    1:  *(u64 *)(r2 + 0x0) =3D r3
> > +    2:  *(u32 *)(r1 + 0x0) =3D 0x1
> > +           10:  CO-RE <byte_off> [2] struct foo::a (0:0)
> > +    3:  exit
> > +
> > +
> > +All relocation kinds could be requested via built-in functions.
> > +E.g. field-based relocations:
> > +
> > +.. code-block:: c
> > +
> > +  void bravo(struct foo *s, volatile unsigned long *g) {
> > +    *g =3D __builtin_preserve_field_info(s->b, 0 /* field byte offset =
*/);
> > +    *g =3D __builtin_preserve_field_info(s->b, 1 /* field byte size */=
);
> > +    *g =3D __builtin_preserve_field_info(s->b, 2 /* field existence */=
);
> > +    *g =3D __builtin_preserve_field_info(s->b, 3 /* field signedness *=
/);
> > +    *g =3D __builtin_preserve_field_info(s->c, 4 /* bitfield left shif=
t */);
> > +    *g =3D __builtin_preserve_field_info(s->c, 5 /* bitfield right shi=
ft */);
> > +  }
> > +
> > +  20 <bravo>:
> > +     4:     r1 =3D 0x4
> > +            20:  CO-RE <byte_off> [2] struct foo::b (0:1)
> > +     5:     *(u64 *)(r2 + 0x0) =3D r1
> > +     6:     r1 =3D 0x4
> > +            30:  CO-RE <byte_sz> [2] struct foo::b (0:1)
> > +     7:     *(u64 *)(r2 + 0x0) =3D r1
> > +     8:     r1 =3D 0x1
> > +            40:  CO-RE <field_exists> [2] struct foo::b (0:1)
> > +     9:     *(u64 *)(r2 + 0x0) =3D r1
> > +    10:     r1 =3D 0x1
> > +            50:  CO-RE <signed> [2] struct foo::b (0:1)
> > +    11:     *(u64 *)(r2 + 0x0) =3D r1
> > +    12:     r1 =3D 0x31
> > +            60:  CO-RE <lshift_u64> [2] struct foo::c (0:2)
> > +    13:     *(u64 *)(r2 + 0x0) =3D r1
> > +    14:     r1 =3D 0x31
> > +            70:  CO-RE <rshift_u64> [2] struct foo::c (0:2)
> > +    15:     *(u64 *)(r2 + 0x0) =3D r1
> > +    16:     exit
> > +
> > +
> [...]


