Return-Path: <bpf+bounces-8312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C4F784CEB
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 00:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330D028119D
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 22:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BD834CEA;
	Tue, 22 Aug 2023 22:39:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D174D2019C
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 22:39:24 +0000 (UTC)
Received: from out-33.mta1.migadu.com (out-33.mta1.migadu.com [IPv6:2001:41d0:203:375::21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316D6CDD
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 15:39:23 -0700 (PDT)
Message-ID: <f7c404d8-41b5-a48d-f156-5556b38f384e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692743960; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXVBE/a+QKe1wKLb9h6iIzA3ZKdGeRkIShWIgGrQ82s=;
	b=es4z/NuOx9MInVKMSMk5FrvD/RfPDavATv+8qFnyfZqF4h5noKCwxR3683pv63PAurtCES
	HxBS2ICmEx+iawpqpgY4AbKORTf8zRu8wths2gg7dfZDdfHaEWalcXA757Txs1OCCpil4r
	9XJVl+IgPOAqz8OK3++gnW6Wq8cKnwM=
Date: Tue, 22 Aug 2023 15:39:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v2 00/14] Exceptions - 1/2
Content-Language: en-US
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
 <CAP01T75MjLeu01FJjxcEF3O1f+4=MiP3St_2M5fmTW9RqkGPnw@mail.gmail.com>
 <87lee2enow.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87lee2enow.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/22/23 3:07 PM, Jose E. Marchesi wrote:
> 
>> On Wed, 9 Aug 2023 at 17:11, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>>>
>>> [...]
>>>
>>> Known issues
>>> ------------
>>>
>>>   * Just asm volatile ("call bpf_throw" :::) does not emit DATASEC .ksyms
>>>     for bpf_throw, there needs to be explicit call in C for clang to emit
>>>     the DATASEC info in BTF, leading to errors during compilation.
>>>
>>
>> Hi Yonghong, I'd like to ask you about this issue to figure out
>> whether this is something worth fixing in clang or not.
>> It pops up in programs which only use bpf_assert macros (which emit
>> the call to bpf_throw using inline assembly) and not bpf_throw kfunc
>> directly.
>>
>> I believe in case we emit a call bpf_throw instruction, the BPF
>> backend code will not see any DWARF debug info for the respective
>> symbol, so it will also not be able to convert it and emit anything to
>> .BTF section in case no direct call without asm volatile is present.
>> Therefore my guess is that this isn't something that can be fixed in
>> clang/LLVM.
> 
> Besides, please keep in mind that GCC doens't have an integrated
> assembler, and therefore relying on clang's understanding on the
> instructions in inline assembly is something to avoid.
> 
>> There are also options like the one below to work around it.
>> if ((volatile int){0}) bpf_throw();
>> asm volatile ("call bpf_throw");
> 
> I can confirm the above results in a BTF entry for bpf_throw with
> bpf-unknown-none-gcc -gbtf.

Kumar, you are correct.
For clang, symbols inside 'asm volatile' statement or generally
inside any asm code (e.g., kernel .s files) won't generate an entry
in dwarf. The
   if ((volatile int){0}) bpf_throw();
will force a dwarf, hence btf, entry.

The unfortunately thing is the above code will generate redundant code
like
   0000000000000000 <foo>:
        0:       b7 01 00 00 00 00 00 00 r1 = 0x0
        1:       63 1a fc ff 00 00 00 00 *(u32 *)(r10 - 0x4) = r1
        2:       61 a1 fc ff 00 00 00 00 r1 = *(u32 *)(r10 - 0x4)
        3:       15 01 01 00 00 00 00 00 if r1 == 0x0 goto +0x1 <LBB0_2>
        4:       85 10 00 00 ff ff ff ff call -0x1

0000000000000028 <LBB0_2>:
        5:       85 10 00 00 ff ff ff ff call -0x1
        6:       b7 00 00 00 00 00 00 00 r0 = 0x0
        7:       95 00 00 00 00 00 00 00 exit

I am curious why in bpf_assert macro bpf_throw() kfunc cannot
be used?

