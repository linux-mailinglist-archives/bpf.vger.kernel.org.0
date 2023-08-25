Return-Path: <bpf+bounces-8623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C49788C0C
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 17:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17B01C20FE4
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 15:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2893B101DE;
	Fri, 25 Aug 2023 15:01:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67ECA60
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 15:01:27 +0000 (UTC)
Received: from out-244.mta1.migadu.com (out-244.mta1.migadu.com [IPv6:2001:41d0:203:375::f4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FED2126
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 08:01:25 -0700 (PDT)
Message-ID: <c20192da-766f-0ba0-9645-bd2d8c53f316@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692975684; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UpEUat4M3ga3nhSDZWjkh9RTt5p9c2F1c7Bw2b92FQ=;
	b=fwqLehPZPi18IqbYBTLONLUvnivGjlspsjJy0beMPFnPyoSHhlyB0KzKkaaiRDh7KDFFV1
	MUiakFKVHEPlZEpElXeFZKkCvn8VbDQT8mXscws9luE3IsXK8Ilgm68AmlIiz8MBPOwh6l
	rMaJ+MIG4oJeGkZzFOJPbPvMpRQtvM4=
Date: Fri, 25 Aug 2023 08:01:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] docs/bpf: Add description for CO-RE relocations
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com
References: <20230824230102.2117902-1-eddyz87@gmail.com>
 <760317bb-188f-6967-b76d-1e9562a427b8@linux.dev>
 <c7c1936bbfcb8b076de8b05db3baecae5d9fa8fd.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <c7c1936bbfcb8b076de8b05db3baecae5d9fa8fd.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/25/23 4:40 AM, Eduard Zingerman wrote:
> On Thu, 2023-08-24 at 23:05 -0700, Yonghong Song wrote:
>>
>> On 8/24/23 4:01 PM, Eduard Zingerman wrote:
>>> Add a section on CO-RE relocations to llvm_relo.rst.
>>> Describe relevant .BTF.ext structure, `enum bpf_core_relo_kind`
>>> and `struct bpf_core_relo` in some detail.
>>> Description is based on doc-string from include/uapi/linux/bpf.h.
>>
>> Thanks Eduard. This is very helpful to give bpf deverlopers
>> some insight about how different of core relocations are
>> supported in llvm and libbpf.
> 
> Hi Yonghong,
> thank you for taking a look.
> 
>>
>> Some comments below.
>>
>>>
>>> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>>> ---
>>>    Documentation/bpf/btf.rst        |  27 ++++-
>>>    Documentation/bpf/llvm_reloc.rst | 178 +++++++++++++++++++++++++++++++
>>>    2 files changed, 201 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
>>> index f32db1f44ae9..c0530211c3c1 100644
>>> --- a/Documentation/bpf/btf.rst
>>> +++ b/Documentation/bpf/btf.rst
>>> @@ -726,8 +726,8 @@ same as the one describe in :ref:`BTF_Type_String`.
>>>    4.2 .BTF.ext section
>>>    --------------------
[...]
>>> +
>>> +The complete list of relocation kinds is represented by the following enum:
>>> +
>>> +.. code-block:: c
>>> +
>>> + enum bpf_core_relo_kind {
>>> +	BPF_CORE_FIELD_BYTE_OFFSET = 0,  /* field byte offset */
>>> +	BPF_CORE_FIELD_BYTE_SIZE   = 1,  /* field size in bytes */
>>> +	BPF_CORE_FIELD_EXISTS      = 2,  /* field existence in target kernel */
>>> +	BPF_CORE_FIELD_SIGNED      = 3,  /* field signedness (0 - unsigned, 1 - signed) */
>>> +	BPF_CORE_FIELD_LSHIFT_U64  = 4,  /* bitfield-specific left bitshift */
>>> +	BPF_CORE_FIELD_RSHIFT_U64  = 5,  /* bitfield-specific right bitshift */
>>> +	BPF_CORE_TYPE_ID_LOCAL     = 6,  /* type ID in local BPF object */
>>> +	BPF_CORE_TYPE_ID_TARGET    = 7,  /* type ID in target kernel */
>>> +	BPF_CORE_TYPE_EXISTS       = 8,  /* type existence in target kernel */
>>> +	BPF_CORE_TYPE_SIZE         = 9,  /* type size in bytes */
>>> +	BPF_CORE_ENUMVAL_EXISTS    = 10, /* enum value existence in target kernel */
>>> +	BPF_CORE_ENUMVAL_VALUE     = 11, /* enum value integer value */
>>> +	BPF_CORE_TYPE_MATCHES      = 12, /* type match in target kernel */
>>> + };
>>> +
[...]
>>> +
>>> +CO-RE Relocation Examples
>>> +=========================
>>> +
>>> +For the following C code:
>>> +
>>> +.. code-block:: c
>>> +
>>> + struct foo {
>>> +     int a;
>>> +     int b;
>>> + } __attribute__((preserve_access_index));
>>> +
>>> + enum bar { U, V };
>>> +
>>> + void buz(struct foo *s, volatile unsigned long *g) {
>>> +   s->a = 1;
>>> +   *g = __builtin_preserve_field_info(s->b, 1);
>>> +   *g = __builtin_preserve_type_info(*s, 1);
>>> +   *g = __builtin_preserve_enum_value(*(enum bar *)V, 1);
>>
>> Maybe __builtin_btf_type_id() can be added as well?
>> So far, clang only supports the above 4 builtin's for core
>> relocations.
> 
> Will add __builtin_btf_type_id() as well.
> 
>>
>>> + }
>>> +
>>> +With the following BTF definititions:
>>> +
>>> +.. code-block::
>>> +
>>> + ...
>>> + [2] STRUCT 'foo' size=8 vlen=2
>>> + 	'a' type_id=3 bits_offset=0
>>> + 	'b' type_id=3 bits_offset=32
>>> + [3] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>>> + ...
>>> + [9] ENUM 'bar' encoding=UNSIGNED size=4 vlen=2
>>> + 	'U' val=0
>>> + 	'V' val=1
>>> +
>>> +The following relocation entries would be generated:
>>> +
>>> +.. code-block:: c
>>> +
>>> +   <buz>:
>>> +       0:	*(u32 *)(r1 + 0x0) = 0x1
>>> +		00:  CO-RE <byte_off> [2] struct foo::a (0:0)
>>> +       1:	r1 = 0x4
>>> +		08:  CO-RE <byte_sz> [2] struct foo::b (0:1)
>>> +       2:	*(u64 *)(r2 + 0x0) = r1
>>> +       3:	r1 = 0x8
>>> +		18:  CO-RE <type_size> [2] struct foo
>>> +       4:	*(u64 *)(r2 + 0x0) = r1
>>> +       5:	r1 = 0x1 ll
>>> +		28:  CO-RE <enumval_value> [9] enum bar::V = 1
>>> +       7:	*(u64 *)(r2 + 0x0) = r1
>>> +       8:	exit
>>> +
>>
>> It would be great if we can have an example for each of above
>> core relocation kinds.
> 
> You mean all 13 kinds, right?

Yes, it would be great if we have at least one example for each kind
to illustrate what this relo kind intends to do.

> 
>>
>>> +Note: modifications for llvm-objdump to show these relocation entries
>>> +are currently work in progress.
> 
> 

