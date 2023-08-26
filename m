Return-Path: <bpf+bounces-8733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674047893C7
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 06:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF611C210A7
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 04:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28094A45;
	Sat, 26 Aug 2023 04:24:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E893E7E
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 04:24:33 +0000 (UTC)
Received: from out-251.mta1.migadu.com (out-251.mta1.migadu.com [IPv6:2001:41d0:203:375::fb])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B5C269E
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 21:24:31 -0700 (PDT)
Message-ID: <0aa436da-0b5a-166a-b45d-2ad11a985508@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693023869; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/4vT8YbvwHuECViZGWyxb60rboGdv+dWEC3fQ+1Wrs=;
	b=LAB3dNYFxtL+CnXCIQsaFq/pZhmo80clBlKU78+YYnjT+vF4skZ1zpE+SQC+ZObdFEL5KI
	2xMfn0Nb3/ZnwchgagpnGPY4crf7cQULXCZ6iOGW/RVhxsjuDJ5rn08XK5rFTUnQdWeHzL
	ZqtiZcDDCc0jNOsz5U+MMRYHE2caqwY=
Date: Fri, 25 Aug 2023 21:24:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v2 1/1] docs/bpf: Add description for CO-RE
 relocations
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com
References: <20230825224527.2465062-1-eddyz87@gmail.com>
 <20230825224527.2465062-2-eddyz87@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230825224527.2465062-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/25/23 3:45 PM, Eduard Zingerman wrote:
> Add a section on CO-RE relocations to llvm_relo.rst.
> Describe relevant .BTF.ext structure, `enum bpf_core_relo_kind`
> and `struct bpf_core_relo` in some detail.
> Description is based on doc-strings from:
> - include/uapi/linux/bpf.h:struct bpf_core_relo
> - tools/lib/bpf/relo_core.c:__bpf_core_types_match()
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

LGTM with a couple minor nits below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   Documentation/bpf/btf.rst        |  31 +++-
>   Documentation/bpf/llvm_reloc.rst | 304 +++++++++++++++++++++++++++++++
>   2 files changed, 329 insertions(+), 6 deletions(-)
> 
[...]
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
> +Notes:
> +
> +* ``BPF_CORE_FIELD_LSHIFT_U64`` and ``BPF_CORE_FIELD_RSHIFT_U64`` are
> +  supposed to be used to read bitfield values using the following
> +  algorithm:
> +
> +  .. code-block:: c
> +
> +     // To read bitfield ``f`` from ``struct s``
> +     is_signed = relo(s->f, BPF_CORE_FIELD_SIGNED)
> +     off = relo(s->f, BPF_CORE_FIELD_BYTE_OFFSET)
> +     sz  = relo(s->f, BPF_CORE_FIELD_BYTE_SIZE)
> +     l   = relo(s->f, BPF_CORE_FIELD_LSHIFT_U64)
> +     r   = relo(s->f, BPF_CORE_FIELD_RSHIFT_U64)
> +     // define ``v`` as signed or unsigned integer of size ``sz``
> +     v = *((void *)s) + off)

parenthesis not matching in the above.

How about below to a little bit more precise?
   v = *({s|u}<sz> *)((void *)s + off)

> +     v <<= l
> +     v >>= r
> +
[...]
> +
> +CO-RE Relocation Examples
> +=========================
> +
> +For the following C code:
> +
> +.. code-block:: c
> +
> + struct foo {
> +   int a;
> +   int b;
> +   unsigned c:15;
> + } __attribute__((preserve_access_index));
> +
> + enum bar { U, V };
> +
> +With the following BTF definitions:
> +
> +.. code-block::
> +
> + ...
> + [2] STRUCT 'foo' size=8 vlen=2
> + 	'a' type_id=3 bits_offset=0
> + 	'b' type_id=3 bits_offset=32
> +        'c' type_id=4 bits_offset=64 bitfield_size=15

Misalignment in the above.


> + [3] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> + [4] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> + ...
> + [16] ENUM 'bar' encoding=UNSIGNED size=4 vlen=2
> + 	'U' val=0
> + 	'V' val=1
> +
> +Field offset relocations are generated automatically when
> +``__attribute__((preserve_access_index))`` is used, for example:
> +
> +.. code-block:: c
> +
> +  void alpha(struct foo *s, volatile unsigned long *g) {
> +    *g = s->a;
> +    s->a = 1;
> +  }
> +
> +  00 <alpha>:
> +    0:  r3 = *(s32 *)(r1 + 0x0)
> +           00:  CO-RE <byte_off> [2] struct foo::a (0:0)
> +    1:  *(u64 *)(r2 + 0x0) = r3
> +    2:  *(u32 *)(r1 + 0x0) = 0x1
> +           10:  CO-RE <byte_off> [2] struct foo::a (0:0)
> +    3:  exit
> +
> +
> +All relocation kinds could be requested via built-in functions.
> +E.g. field-based relocations:
> +
> +.. code-block:: c
> +
> +  void bravo(struct foo *s, volatile unsigned long *g) {
> +    *g = __builtin_preserve_field_info(s->b, 0 /* field byte offset */);
> +    *g = __builtin_preserve_field_info(s->b, 1 /* field byte size */);
> +    *g = __builtin_preserve_field_info(s->b, 2 /* field existence */);
> +    *g = __builtin_preserve_field_info(s->b, 3 /* field signedness */);
> +    *g = __builtin_preserve_field_info(s->c, 4 /* bitfield left shift */);
> +    *g = __builtin_preserve_field_info(s->c, 5 /* bitfield right shift */);
> +  }
> +
> +  20 <bravo>:
> +     4:     r1 = 0x4
> +            20:  CO-RE <byte_off> [2] struct foo::b (0:1)
> +     5:     *(u64 *)(r2 + 0x0) = r1
> +     6:     r1 = 0x4
> +            30:  CO-RE <byte_sz> [2] struct foo::b (0:1)
> +     7:     *(u64 *)(r2 + 0x0) = r1
> +     8:     r1 = 0x1
> +            40:  CO-RE <field_exists> [2] struct foo::b (0:1)
> +     9:     *(u64 *)(r2 + 0x0) = r1
> +    10:     r1 = 0x1
> +            50:  CO-RE <signed> [2] struct foo::b (0:1)
> +    11:     *(u64 *)(r2 + 0x0) = r1
> +    12:     r1 = 0x31
> +            60:  CO-RE <lshift_u64> [2] struct foo::c (0:2)
> +    13:     *(u64 *)(r2 + 0x0) = r1
> +    14:     r1 = 0x31
> +            70:  CO-RE <rshift_u64> [2] struct foo::c (0:2)
> +    15:     *(u64 *)(r2 + 0x0) = r1
> +    16:     exit
> +
> +
[...]

