Return-Path: <bpf+bounces-37327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B59953D3E
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28781C2295A
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AFC1547EB;
	Thu, 15 Aug 2024 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uVA9c4r6"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CCE14D2B8
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760187; cv=none; b=hpopWsZnu26DhVE21WikDKcZnNd4KwHBHPso2JV2gbUzfZFm2JXq76v8nDXOIZ26Agv3rCj46ma0UvPu2sNS4LYra680X0+AAZ2fwifPK1ZqaP0tfqMAK6NoeuC2FwbpugQjyoURveYFu3TFwJF0H0ihDKMkRJFBiM40BSDPIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760187; c=relaxed/simple;
	bh=uAK9Sqvv3/ak1hm6gfyKWFng3edpaTucbxLN8kPh5uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMnEWQkJxP1/BlZToUP9SIMZ2xKdaAvxHkghttGD7Asnu4PAQmHy2JN2H6TprxyjNP0CrJygx8QdMiL8XMOSzP10c028wp1prjnTSDxIjfedxTwaL/WGzmRkMKqOsDXH5eJ1cQmHg2SjP36qw288DVsDFQAfxpI41E1ealw7shU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uVA9c4r6; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a78f3cc-883a-4d37-b455-15e74684e8cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723760180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gay4vESmSy//XOB5aNnXJi23YMAfkhrtlzu86Hqncgo=;
	b=uVA9c4r6xJNxn0b9sj7IlCnJq5CoubQQG2WTSiqgLcZBh+xxfi8o29sHp3lW1vGt1c7Zkj
	Wx+swzHfGcD4s5qitm2lPdVmMmXs0T4gsKXIA8fD6xCfPeQUSUqAwWir+XLmcyC71DIZGV
	oSu7kBc40F2D4lyIUGk9pK9gOO1Ihq8=
Date: Thu, 15 Aug 2024 15:16:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: support nocsr patterns for calls to
 kfuncs
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com
References: <20240812234356.2089263-1-eddyz87@gmail.com>
 <20240812234356.2089263-2-eddyz87@gmail.com>
 <CAEf4BzZXyq8Y85v6UQo+xZZCyxSndsnHpPQnxfR-_FOfVqMseg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZXyq8Y85v6UQo+xZZCyxSndsnHpPQnxfR-_FOfVqMseg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/15/24 2:24 PM, Andrii Nakryiko wrote:
> On Mon, Aug 12, 2024 at 4:44 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> Recognize nocsr patterns around kfunc calls.
>> For example, suppose bpf_cast_to_kern_ctx() follows nocsr contract
>> (which it does, it is rewritten by verifier as "r0 = r1" insn),
>> in such a case, rewrite BPF program below:
>>
>>    r2 = 1;
>>    *(u64 *)(r10 - 32) = r2;
>>    call %[bpf_cast_to_kern_ctx];
>>    r2 = *(u64 *)(r10 - 32);
>>    r0 = r2;
>>
>> Removing the spill/fill pair:
>>
>>    r2 = 1;
>>    call %[bpf_cast_to_kern_ctx];
>>    r0 = r2;
>>
>> Add a KF_NOCSR flag to mark kfuncs that follow nocsr contract.
>>
>> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>> ---
>>   include/linux/btf.h   |  1 +
>>   kernel/bpf/verifier.c | 36 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index cffb43133c68..59ca37300423 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -75,6 +75,7 @@
>>   #define KF_ITER_NEXT    (1 << 9) /* kfunc implements BPF iter next method */
>>   #define KF_ITER_DESTROY (1 << 10) /* kfunc implements BPF iter destructor */
>>   #define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu cs when they are invoked */
>> +#define KF_NOCSR        (1 << 12) /* kfunc follows nocsr calling contract */
>>
>>   /*
>>    * Tag marking a kernel function as a kfunc. This is meant to minimize the
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index df3be12096cf..c579f74be3f9 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -16140,6 +16140,28 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
>>          }
>>   }
>>
>> +/* Same as helper_nocsr_clobber_mask() but for kfuncs, see comment above */
>> +static u32 kfunc_nocsr_clobber_mask(struct bpf_kfunc_call_arg_meta *meta)
>> +{
>> +       const struct btf_param *params;
>> +       u32 vlen, i, mask;
>> +
>> +       params = btf_params(meta->func_proto);
>> +       vlen = btf_type_vlen(meta->func_proto);
>> +       mask = 0;
>> +       if (!btf_type_is_void(btf_type_by_id(meta->btf, meta->func_proto->type)))
>> +               mask |= BIT(BPF_REG_0);
>> +       for (i = 0; i < vlen; ++i)
>> +               mask |= BIT(BPF_REG_1 + i);
> Somewhere deep in btf_dump implementation of libbpf, there is a
> special handling of `<whatever> func(void)` (no args) function as
> having vlen == 1 and type being VOID (i.e., zero). I don't know if
> that still can happen, but I believe at some point we could get this
> vlen==1 and type=VOID for no-args functions. So I wonder if we should
> handle that here as well, or is it some compiler atavism we can forget
> about?

The case to have vlen=1 and type=VOID only happens for
bpf programs with llvm19 and later.
For example,

$ cat t.c
int foo(); // a kfunc or a helper
int bar() {
   return foo(1, 2);
}

$ clang --target=bpf -O2 -g -c t.c && llvm-dwarfdump t.o
t.c:3:13: warning: passing arguments to 'foo' without a prototype is deprecated in all versions of C and is not supported in C23 [-Wdeprecated-non-prototype]
     3 |   return foo(1, 2);
       |             ^
1 warning generated.
t.o:    file format elf64-bpf
...
0x00000039:   DW_TAG_subprogram
                 DW_AT_name      ("foo")
                 DW_AT_decl_file ("/home/yhs/t.c")
                 DW_AT_decl_line (1)
                 DW_AT_type      (0x00000043 "int")
                 DW_AT_declaration       (true)
                 DW_AT_external  (true)

0x00000041:     DW_TAG_unspecified_parameters

0x00000042:     NULL
...

If we do see a BPF kfunc/helper with vlen=1 and type is VOID,
that means the number of arguments is actual UNKNOWN
based on dwarf DW_TAG_subprogram tag. Although it is unlikely
people to write code like above, it might be still useful
to add check with vlen=1 and type=VOID and reject such a case.


>
>> +       return mask;
>> +}
>> +
>> +/* Same as verifier_inlines_helper_call() but for kfuncs, see comment above */
>> +static bool verifier_inlines_kfunc_call(struct bpf_kfunc_call_arg_meta *meta)
>> +{
>> +       return false;
>> +}
>> +
>>   /* GCC and LLVM define a no_caller_saved_registers function attribute.
>>    * This attribute means that function scratches only some of
>>    * the caller saved registers defined by ABI.
>> @@ -16238,6 +16260,20 @@ static void mark_nocsr_pattern_for_call(struct bpf_verifier_env *env,
>>                                    bpf_jit_inlines_helper_call(call->imm));
>>          }
>>
>> +       if (bpf_pseudo_kfunc_call(call)) {
>> +               struct bpf_kfunc_call_arg_meta meta;
>> +               int err;
>> +
>> +               err = fetch_kfunc_meta(env, call, &meta, NULL);
>> +               if (err < 0)
>> +                       /* error would be reported later */
>> +                       return;
>> +
>> +               clobbered_regs_mask = kfunc_nocsr_clobber_mask(&meta);
>> +               can_be_inlined = (meta.kfunc_flags & KF_NOCSR) &&
>> +                                verifier_inlines_kfunc_call(&meta);
>> +       }
>> +
>>          if (clobbered_regs_mask == ALL_CALLER_SAVED_REGS)
>>                  return;
>>
>> --
>> 2.45.2
>>

