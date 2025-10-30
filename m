Return-Path: <bpf+bounces-73049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF3FC21343
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 17:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 912E34EC6BA
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A3A23816C;
	Thu, 30 Oct 2025 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BDCFzivK"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47F2DF149
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841928; cv=none; b=Y53splAPzg1o2yiE96QL6GAWyec6vd9oG00FGFAgVCzQfrvtlk92yYp2wVe3VFrUQk/4dnY3tN+Au7n7CL99mFgSYHwR3Mkd8eQ+wiCUjdmDaWVpNsbuSAIZup5b9gZLzi7YlcHvZBH8tq8dUXigSvEU5kbIQpHYgGATJw19ivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841928; c=relaxed/simple;
	bh=LvsVgjui+xkzsc16wqUAitJaNr7z/qDFzJ8IhokZBQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiQIL5xyvocpa724aU0p0r+VFuy6PsiSXkU33mfVvlyMtYMPotBWcsnKinZ/rD7kWpzrs2QzWBJPi22ynpjjbipesnlFDWt/PWlFU04zcda/vwaZ0S5pZq8u4xtkDuF1pXH4f2PLRqtD9z+bu7FQRR3YCvni1nwRipLScgbXVlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BDCFzivK; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <da20bc30-85be-44ab-b837-19aa97ebc431@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761841911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNzeQ9OrF0RxDX6QJrxesWPafhoDbt7IX7HVAQcbCek=;
	b=BDCFzivK29rh6YiZZJVU49dhJx8t5QGRwEUz+dZW8Duf5eqIy7IeC61HiMzUucCW4kr+wU
	O/s2HV8YrlmSFuNteIeV4GEeX2zlnSe9bErNEeViDPEfTdfhQXpNoKpRsomgkME5ryAzrK
	1CN1NUaOkXhmW1c0cpSaqeoEZGaJV0E=
Date: Thu, 30 Oct 2025 09:31:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Support for kfuncs with
 KF_MAGIC_ARGS
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org,
 tj@kernel.org, kernel-team@meta.com
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
 <20251029190113.3323406-4-ihor.solodrai@linux.dev>
 <b667472aeb77ac63a3de82dae77012c0285e0286.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <b667472aeb77ac63a3de82dae77012c0285e0286.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Eduard, thank you for a quick review.

On 10/29/25 4:54 PM, Eduard Zingerman wrote:
> On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
>> A kernel function bpf_foo with KF_MAGIC_ARGS flag is expected to have
>                                  ^^^^^^^^^^^^^
> 		I don't like this name very much.
> 		It bears very little context.
> 		Imo, KF_IMPLICIT_ARGS fits the use case much better.

I know, naming is hard...

The issue is that it's not only the flag, across the code we need
descriptive names for every "magic" thing:
  * a flagged function
    * how do we call it? kfunc_with_impl_args?
  * a function that exists only in BTF (_impl)
    * it's not an "implicit" function
    * it's not exactly an "implementation" function
    * "fake" is even worse than "magic" IMO, because it's not fake,
      but you could argue it's magical :D
    * btf_only_kfunc?
  * describing arguments is simpler: "implicit" seems ok, although as
    Alexei pointed out in previous iteration they are very much
    explicit in the kernel [1]

For me, "(BPF) interface" and "(kernel) implementation" pair of terms
makes sense, but then I think it would be logical to have both
declarations in the kernel.

The advantage of "magic" in this context is that it doesn't have
loaded meaning. But I agree this is a stretch, so can't insist.

[1] https://lore.kernel.org/bpf/CAADnVQLvuubey0A0Fk=bzN-=JG2UUQHRqBijZpuvqMQ+xy4W4g@mail.gmail.com/


> 
>> two types in BTF:
>>   * `bpf_foo` with a function prototype that omits __magic arguments
>>   * `bpf_foo_impl` with a function prototype that matches kernel
>>      declaration, but doesn't have a ksym associated with its name
> 
> Could you please start with an example here?
> Stating how `bpf_foo` needs to be declared in kernel, and what are the
> options to invoke it from bpf.  Then proceed with BTF details, etc.

Ok. I think I can reshuffle explanations between the cover letter and
commit message, it's a bit redundant already.

> 
>> In order to support magic kfuncs the verifier has to know how to
>> resolve calls both of `bpf_foo` and `bpf_foo_impl` to the correct BTF
>> function prototype and address.
>>
>> In add_kfunc_call() kfunc flags are inspected to detect a magic kfunc
>> or its _impl, and then the address and func_proto are adjusted for the
>> kfunc descriptor.
>>
>> In fetch_kfunc_meta() similar logic is used to fixup the contents of
>> struct bpf_kfunc_call_arg_meta.
>>
>> In check_kfunc_call() reset the subreg_def of registers holding magic
>> arguments to correctly track zero extensions.
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  include/linux/btf.h   |   1 +
>>  kernel/bpf/verifier.c | 123 ++++++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 120 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index 9c64bc5e5789..3fe20514692f 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -79,6 +79,7 @@
>>  #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
>>  #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
>>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
>> +#define KF_MAGIC_ARGS   (1 << 16) /* kfunc signature is different from its BPF signature */
>>  
>>  /*
>>   * Tag marking a kernel function as a kfunc. This is meant to minimize the
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index cb1b483be0fa..fcf0872b9e3d 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3263,17 +3263,68 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
>>  	return btf_vmlinux ?: ERR_PTR(-ENOENT);
>>  }
>>  
>> +/*
>> + * magic_kfuncs is used as a list of (foo, foo_impl) pairs
>> + */
>> +BTF_ID_LIST(magic_kfuncs)
>> +BTF_ID_UNUSED
>> +BTF_ID_LIST_END(magic_kfuncs)
>> +
>> +static s32 magic_kfunc_by_impl(s32 impl_func_id)
>> +{
>> +	int i;
>> +
>> +	for (i = 1; i < BTF_ID_LIST_SIZE(magic_kfuncs); i += 2) {
>> +		if (magic_kfuncs[i] == impl_func_id)
>                                        ^^^^^
> Nit: similarly, I'd rename this to something like "implicit_func_id"
>      or "fake_func_id. "impl" is confusing because this id has nothing
>      to do with implementation.
> 
>> +			return magic_kfuncs[i - 1];
>> +	}
>> +	return -ENOENT;
>> +}
>> +
>> +static s32 impl_by_magic_kfunc(s32 func_id)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < BTF_ID_LIST_SIZE(magic_kfuncs); i += 2) {
>> +		if (magic_kfuncs[i] == func_id)
>> +			return magic_kfuncs[i + 1];
>> +	}
>> +	return -ENOENT;
>> +}
>> +
>> +static const struct btf_type *find_magic_kfunc_proto(struct btf *desc_btf, s32 func_id)
>> +{
>> +	const struct btf_type *impl_func, *func_proto;
>> +	u32 impl_func_id;
>> +
>> +	impl_func_id = impl_by_magic_kfunc(func_id);
>> +	if (impl_func_id < 0)
>> +		return NULL;
>> +
>> +	impl_func = btf_type_by_id(desc_btf, impl_func_id);
>> +	if (!impl_func || !btf_type_is_func(impl_func))
>> +		return NULL;
>> +
>> +	func_proto = btf_type_by_id(desc_btf, impl_func->type);
>> +	if (!func_proto || !btf_type_is_func_proto(func_proto))
>> +		return NULL;
>> +
>> +	return func_proto;
>> +}
>> +
>>  static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>>  {
>> -	const struct btf_type *func, *func_proto;
>> +	const struct btf_type *func, *func_proto, *tmp_func;
>>  	struct bpf_kfunc_btf_tab *btf_tab;
>> +	const char *func_name, *tmp_name;
>>  	struct btf_func_model func_model;
>>  	struct bpf_kfunc_desc_tab *tab;
>>  	struct bpf_prog_aux *prog_aux;
>>  	struct bpf_kfunc_desc *desc;
>> -	const char *func_name;
>>  	struct btf *desc_btf;
>>  	unsigned long addr;
>> +	u32 *kfunc_flags;
>> +	s32 tmp_func_id;
>>  	int err;
>>  
>>  	prog_aux = env->prog->aux;
>> @@ -3349,8 +3400,37 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>>  		return -EINVAL;
>>  	}
>>  
>> +	kfunc_flags = btf_kfunc_flags(desc_btf, func_id, env->prog);
>>  	func_name = btf_name_by_offset(desc_btf, func->name_off);
>>  	addr = kallsyms_lookup_name(func_name);
>> +
>> +	/* This may be an _impl kfunc with KF_MAGIC_ARGS counterpart */
>> +	if (unlikely(!addr && !kfunc_flags)) {
>> +		tmp_func_id = magic_kfunc_by_impl(func_id);
> 
> I think there is no need to hide magic_kfunc_by_impl() call behind the
> above condition. It can be moved before kfunc_flags assignment.
> Then it wont be necessary to textually repeat btf_name_by_offset() and
> kallsyms_lookup_name() calls.

Not sure I follow...

Yes, !addr is enough to detect potential _impl function, but there is
no way around name lookup in BTF and then another address lookup.

The _impl function doesn't have an address, so after failed
  kallsyms_lookup_name("kfunc_impl");
we must do
  kallsyms_lookup_name("kfunc");
to find the correct address.

Or do you suggest doing something like:

  tmp_func_id = magic_kfunc_by_impl(func_id);
  if (tmp_func_id > 0)
      func_id = tmp_func_id;

at the beginning of add_kfunc_call()?


> 
>> +		if (tmp_func_id < 0)
>> +			return -EACCES;
> 
> Nit: this skips proper error reporting: "cannot find address for kernel function %s\n".
> 
>> +		tmp_func = btf_type_by_id(desc_btf, tmp_func_id);
>> +		if (!tmp_func || !btf_type_is_func(tmp_func))
> 
> Nit: this condition indicates a verifier bug, should it be reported as such?
> 
>> +			return -EACCES;
>> +		tmp_name = btf_name_by_offset(desc_btf, tmp_func->name_off);
>> +		addr = kallsyms_lookup_name(tmp_name);
>> +	}
>> +
>> +	/*
>> +	 * Note that kfunc_flags may be NULL at this point, which means that we couldn't find
>> +	 * func_id in any relevant kfunc_id_set. This most likely indicates an invalid kfunc call.
>> +	 * However we don't want to fail the verification here, because invalid calls may be
>> +	 * eliminated as dead code later.
>> +	 */
>> +	if (unlikely(kfunc_flags && KF_MAGIC_ARGS & *kfunc_flags)) {
>> +		func_proto = find_magic_kfunc_proto(desc_btf, func_id);
>> +		if (!func_proto) {
>> +			verbose(env, "cannot find _impl proto for kernel function %s\n",
>> +			func_name);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>>  	if (!addr) {
>>  		verbose(env, "cannot find address for kernel function %s\n",
>>  			func_name);
>> @@ -12051,6 +12131,11 @@ static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param
>>  	return btf_param_match_suffix(btf, arg, "__irq_flag");
>>  }
>>  
>> +static bool is_kfunc_arg_magic(const struct btf *btf, const struct btf_param *arg)
>> +{
>> +	return btf_param_match_suffix(btf, arg, "__magic");
>> +}
>> +
>>  static bool is_kfunc_arg_prog(const struct btf *btf, const struct btf_param *arg)
>>  {
>>  	return btf_param_match_suffix(btf, arg, "__prog");
>> @@ -13613,6 +13698,7 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
>>  	u32 func_id, *kfunc_flags;
>>  	const char *func_name;
>>  	struct btf *desc_btf;
>> +	s32 tmp_func_id;
>>  
>>  	if (kfunc_name)
>>  		*kfunc_name = NULL;
>> @@ -13632,10 +13718,28 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
>>  	func_proto = btf_type_by_id(desc_btf, func->type);
>>  
>>  	kfunc_flags = btf_kfunc_flags_if_allowed(desc_btf, func_id, env->prog);
>> -	if (!kfunc_flags) {
>> -		return -EACCES;
>> +	if (unlikely(!kfunc_flags)) {
> 
> What if we patch insn->imm to use the "fake" function id in add_kfunc_call()?
> Then modifications to fetch_kfunc_meta() wont be necessary.


I considered this. I wasn't sure it's safe to patch insn->imm at this
stage of verification. Also I thought it may be harder to debug the
verifier if we do btf id replacement in the calls pre-verification
(because we lose the original btf id).

Maybe I was too causious.

Alexei, Andrii, what do you think?


> 
>> +		/*
>> +		 * An _impl kfunc with KF_MAGIC_ARGS counterpart
>> +		 * does not have its own kfunc flags.
>> +		 */
>> +		tmp_func_id = magic_kfunc_by_impl(func_id);
>> +		if (tmp_func_id < 0)
>> +			return -EACCES;
>> +		kfunc_flags = btf_kfunc_flags_if_allowed(desc_btf, tmp_func_id, env->prog);
>> +		if (!kfunc_flags)
>> +			return -EACCES;
>> +	} else if (unlikely(KF_MAGIC_ARGS & *kfunc_flags)) {
>> +		/*
>> +		 * An actual func_proto of a kfunc with KF_MAGIC_ARGS flag
>> +		 * can be found through the corresponding _impl kfunc.
>> +		 */
>> +		func_proto = find_magic_kfunc_proto(desc_btf, func_id);
>>  	}
>>  
>> +	if (!func_proto)
>> +		return -EACCES;
>> +
>>  	memset(meta, 0, sizeof(*meta));
>>  	meta->btf = desc_btf;
>>  	meta->func_id = func_id;
>> @@ -14189,6 +14293,17 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>  	for (i = 0; i < nargs; i++) {
>>  		u32 regno = i + 1;
>>  
>> +		/*
>> +		 * Magic arguments are set after main verification pass.
>> +		 * For correct tracking of zero-extensions we have to reset subreg_def for such
>> +		 * args. Otherwise mark_btf_func_reg_size() will be inspecting subreg_def of regs
>> +		 * from an earlier (irrelevant) point in the program, which may lead to an error
>> +		 * in opt_subreg_zext_lo32_rnd_hi32().
>> +		 */
>> +		if (unlikely(KF_MAGIC_ARGS & meta.kfunc_flags
>> +				&& is_kfunc_arg_magic(desc_btf, &args[i])))
>> +			regs[regno].subreg_def = DEF_NOT_SUBREG;
>> +
>>  		t = btf_type_skip_modifiers(desc_btf, args[i].type, NULL);
>>  		if (btf_type_is_ptr(t))
>>  			mark_btf_func_reg_size(env, regno, sizeof(void *));


