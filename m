Return-Path: <bpf+bounces-64824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43439B17545
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 18:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8978818C291F
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 16:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E16723DEAD;
	Thu, 31 Jul 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bDhhSDIl"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE3C1F4607
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980694; cv=none; b=GKvd/PrQk59ItX1ASlCQuFH2dlsSM56F9VHKKtxgutlYqT/IADL8G71jAlH3/8+/hl3/wFQg8wVFh2wgkwuSmEjgJsdwnqX14Jtl42xfQge40miPmIL+0BgYtj+WsO3Tz9h5gPfi0do165O3A1JyM/Mf7Qr6d9j5+l5WF+YuipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980694; c=relaxed/simple;
	bh=jNto6uFd/Hecv7DpJEqjKB5VPwlBLjHLBWvKPMemAlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sw54PSHih//PkLV/baH0An/jJLfJSTXqpH5iWg81+nCYFx/l0zhVVrujmdpuQpuoJL1xgweRXDiJWglZ1Bo4HgLXsaFOrJFoXbKX+VQuwwU2SkaYBK8xEQGr2nz5qAUEtExyHXoraeX6A1CGWFaYRyVXUrcqUznfvBDg/3QAJ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bDhhSDIl; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5fe3af2b-a12e-40d7-9f9d-d7c26d98cf14@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753980688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIoHHa+z8Sc7m5R9za9NlmzQV7MZR+j9aTVGygT2Ksw=;
	b=bDhhSDIlnXKBvNstDp7ee53oKQeY4CGKFgHIHbUexY9SJiFECJVlMpRluHvQKRjzKL700z
	Ng3qjSyL+o6Vc2pz+TtqqPMlLb2SeVLZaljckE62IVknUUmV893PGoileNlHbRzQ1+gA8W
	8rU+aQ+mce75tixpjDzKTsSrEjr5Tdc=
Date: Thu, 31 Jul 2025 09:51:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v2] btf_encoder: group all function ELF syms by
 function name
To: Alan Maguire <alan.maguire@oracle.com>, olsajiri@gmail.com,
 dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, acme@kernel.org, andrii@kernel.org, ast@kernel.org,
 eddyz87@gmail.com, menglong8.dong@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kernel-team@meta.com
References: <20250729020308.103139-1-isolodrai@meta.com>
 <79a329ef-9bb3-454e-9135-731f2fd51951@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <79a329ef-9bb3-454e-9135-731f2fd51951@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/31/25 7:16 AM, Alan Maguire wrote:
> On 29/07/2025 03:03, Ihor Solodrai wrote:
>> btf_encoder collects function ELF symbols into a table, which is later
>> used for processing DWARF data and determining whether a function can
>> be added to BTF.
>>
>> So far the ELF symbol name was used as a key for search in this table,
>> and a search by prefix match was attempted in cases when ELF symbol
>> name has a compiler-generated suffix.
>>
>> This implementation has bugs [1][2], causing some functions to be
>> inappropriately excluded from (or included into) BTF.
>>
>> Rework the implementation of the ELF functions table. Use a name of a
>> function without any suffix - symbol name before the first occurrence
>> of '.' - as a key. This way btf_encoder__find_function() always
>> returns a valid elf_function object (or NULL).
>>
>> Collect an array of symbol name + address pairs from GElf_Sym for each
>> elf_function when building the elf_functions table.
>>
>> Introduce ambiguous_addr flag to the btf_encoder_func_state. It is set
>> when the function is saved by examining the array of ELF symbols in
>> elf_function__has_ambiguous_address(). It tests whether there is only
>> one unique address for this function name, taking into account that
>> some addresses associated with it are not relevant:
>>    * ".cold" suffix indicates a piece of hot/cold split
>>    * ".part" suffix indicates a piece of partial inline
>>
>> When inspecting symbol name we have to search for any occurrence of
>> the target suffix, as opposed to testing the entire suffix, or the end
>> of a string. This is because suffixes may be combined by the compiler,
>> for example producing ".isra0.cold", and the conclusion will be
>> incorrect.
>>
>> In saved_functions_combine() check ambiguous_addr when deciding
>> whether a function should be included in BTF.
>>
>> Successful CI run: https://github.com/acmel/dwarves/pull/68/checks
>>
>> I manually spot checked some of the ~200 functions from vmlinux (BPF
>> CI-like kconfig) that are now excluded: all of those that I checked
>> had multiple addresses, and some where static functions from different
>> files with the same name.
>>
>> [1] https://lore.kernel.org/bpf/2f8c792e-9675-4385-b1cb-10266c72bd45@linux.dev/
>> [2] https://lore.kernel.org/dwarves/6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev/
>>
>> v1: https://lore.kernel.org/dwarves/98f41eaf6dd364745013650d58c5f254a592221c@linux.dev/
>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> 
> Thanks for doing this Ihor! Apologies for just thinking of this now, but
> why don't we filter out the .cold and .part functions earlier, not even
> adding them to the ELF functions list? Something like this on top of
> your patch:
> 
> $ git diff
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 0aa94ae..f61db0f 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1188,27 +1188,6 @@ static struct btf_encoder_func_state
> *btf_encoder__alloc_func_state(struct btf_e
>          return state;
>   }
> 
> -/* some "." suffixes do not correspond to real functions;
> - * - .part for partial inline
> - * - .cold for rarely-used codepath extracted for better code locality
> - */
> -static bool str_contains_non_fn_suffix(const char *str) {
> -       static const char *skip[] = {
> -               ".cold",
> -               ".part"
> -       };
> -       char *suffix = strchr(str, '.');
> -       int i;
> -
> -       if (!suffix)
> -               return false;
> -       for (i = 0; i < ARRAY_SIZE(skip); i++) {
> -               if (strstr(suffix, skip[i]))
> -                       return true;
> -       }
> -       return false;
> -}
> -
>   static bool elf_function__has_ambiguous_address(struct elf_function
> *func) {
>          struct elf_function_sym *sym;
>          uint64_t addr;
> @@ -1219,12 +1198,10 @@ static bool
> elf_function__has_ambiguous_address(struct elf_function *func) {
>          addr = 0;
>          for (int i = 0; i < func->sym_cnt; i++) {
>                  sym = &func->syms[i];
> -               if (!str_contains_non_fn_suffix(sym->name)) {
> -                       if (addr && addr != sym->addr)
> -                               return true;
> -                       else
> +               if (addr && addr != sym->addr)
> +                       return true;
> +               else
>                                  addr = sym->addr;
> -               }
>          }
> 
> 
>          return false;
> @@ -2208,9 +2185,12 @@ static int elf_functions__collect(struct
> elf_functions *functions)
>                  func = &functions->entries[functions->cnt];
> 
>                  suffix = strchr(sym_name, '.');
> -               if (suffix)
> +               if (suffix) {
> +                       if (strstr(suffix, ".part") ||
> +                           strstr(suffix, ".cold"))
> +                               continue;
>                          func->name = strndup(sym_name, suffix - sym_name);
> -               else
> +               } else
>                          func->name = strdup(sym_name);
> 
>                  if (!func->name) {
> 
> I think that would work and saves later string comparisons, what do you
> think?

My thinking was that in the future pahole may want to use the
information about those symbols when generating BTF, such as for
(partial) inline support. But that is a stretch, as those potential
features are complicated.

And it would be easy to add the suffixed symbols back when
necessary. So will change in v3.


> 
>> ---
>>   btf_encoder.c | 250 ++++++++++++++++++++++++++++++++------------------
>>   1 file changed, 162 insertions(+), 88 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 0bc2334..0aa94ae 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -87,16 +87,22 @@ struct btf_encoder_func_state {
>>   	uint8_t optimized_parms:1;
>>   	uint8_t unexpected_reg:1;
>>   	uint8_t inconsistent_proto:1;
>> +	uint8_t ambiguous_addr:1;
>>   	int ret_type_id;
>>   	struct btf_encoder_func_parm *parms;
>>   	struct btf_encoder_func_annot *annots;
>>   };
>>   
>> +struct elf_function_sym {
>> +	const char *name;
>> +	uint64_t addr;
>> +};
>> +
>>   struct elf_function {
>> -	const char	*name;
>> -	char		*alias;
>> -	size_t		prefixlen;
>> -	bool		kfunc;
>> +	char		*name;
>> +	struct elf_function_sym *syms;
>> +	uint8_t 	sym_cnt;
>> +	uint8_t		kfunc:1;
>>   	uint32_t	kfunc_flags;
>>   };
>>   
>> @@ -115,7 +121,6 @@ struct elf_functions {
>>   	struct elf_symtab *symtab;
>>   	struct elf_function *entries;
>>   	int cnt;
>> -	int suffix_cnt; /* number of .isra, .part etc */
>>   };
>>   
>>   /*
>> @@ -161,10 +166,18 @@ struct btf_kfunc_set_range {
>>   	uint64_t end;
>>   };
>>   
>> +static inline void elf_function__free_content(struct elf_function *func) {
>> +	free(func->name);
>> +	if (func->sym_cnt)
>> +		free(func->syms);
>> +	memset(func, 0, sizeof(*func));
>> +}
>> +
>>   static inline void elf_functions__delete(struct elf_functions *funcs)
>>   {
>> -	for (int i = 0; i < funcs->cnt; i++)
>> -		free(funcs->entries[i].alias);
>> +	for (int i = 0; i < funcs->cnt; i++) {
>> +		elf_function__free_content(&funcs->entries[i]);
>> +	}
>>   	free(funcs->entries);
>>   	elf_symtab__delete(funcs->symtab);
>>   	list_del(&funcs->node);
>> @@ -981,8 +994,7 @@ static void btf_encoder__log_func_skip(struct btf_encoder *encoder, struct elf_f
>>   
>>   	if (!encoder->verbose)
>>   		return;
>> -	printf("%s (%s): skipping BTF encoding of function due to ",
>> -	       func->alias ?: func->name, func->name);
>> +	printf("%s : skipping BTF encoding of function due to ", func->name);
>>   	va_start(ap, fmt);
>>   	vprintf(fmt, ap);
>>   	va_end(ap);
>> @@ -1176,6 +1188,48 @@ static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_e
>>   	return state;
>>   }
>>   
>> +/* some "." suffixes do not correspond to real functions;
>> + * - .part for partial inline
>> + * - .cold for rarely-used codepath extracted for better code locality
>> + */
>> +static bool str_contains_non_fn_suffix(const char *str) {
>> +	static const char *skip[] = {
>> +		".cold",
>> +		".part"
>> +	};
>> +	char *suffix = strchr(str, '.');
>> +	int i;
>> +
>> +	if (!suffix)
>> +		return false;
>> +	for (i = 0; i < ARRAY_SIZE(skip); i++) {
>> +		if (strstr(suffix, skip[i]))
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +static bool elf_function__has_ambiguous_address(struct elf_function *func) {
>> +	struct elf_function_sym *sym;
>> +	uint64_t addr;
>> +
>> +	if (func->sym_cnt <= 1)
>> +		return false;
>> +
>> +	addr = 0;
>> +	for (int i = 0; i < func->sym_cnt; i++) {
>> +		sym = &func->syms[i];
>> +		if (!str_contains_non_fn_suffix(sym->name)) {
>> +			if (addr && addr != sym->addr)
>> +				return true;
>> +			else
>> +			 	addr = sym->addr;
>> +		}
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>   static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
>>   {
>>   	struct btf_encoder_func_state *state = btf_encoder__alloc_func_state(encoder);
>> @@ -1191,6 +1245,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>>   
>>   	state->encoder = encoder;
>>   	state->elf = func;
>> +	state->ambiguous_addr = elf_function__has_ambiguous_address(func);
>>   	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
>>   	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
>>   	if (state->nr_parms > 0) {
>> @@ -1294,7 +1349,7 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>>   	int err;
>>   
>>   	btf_fnproto_id = btf_encoder__add_func_proto(encoder, NULL, state);
>> -	name = func->alias ?: func->name;
>> +	name = func->name;
>>   	if (btf_fnproto_id >= 0)
>>   		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
>>   						      name, false);
>> @@ -1338,48 +1393,39 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>>   	return 0;
>>   }
>>   
>> -static int functions_cmp(const void *_a, const void *_b)
>> +static int elf_function__name_cmp(const void *_a, const void *_b)
>>   {
>>   	const struct elf_function *a = _a;
>>   	const struct elf_function *b = _b;
>>   
>> -	/* if search key allows prefix match, verify target has matching
>> -	 * prefix len and prefix matches.
>> -	 */
>> -	if (a->prefixlen && a->prefixlen == b->prefixlen)
>> -		return strncmp(a->name, b->name, b->prefixlen);
>>   	return strcmp(a->name, b->name);
>>   }
>>   
>> -#ifndef max
>> -#define max(x, y) ((x) < (y) ? (y) : (x))
>> -#endif
>> -
>>   static int saved_functions_cmp(const void *_a, const void *_b)
>>   {
>>   	const struct btf_encoder_func_state *a = _a;
>>   	const struct btf_encoder_func_state *b = _b;
>>   
>> -	return functions_cmp(a->elf, b->elf);
>> +	return elf_function__name_cmp(a->elf, b->elf);
>>   }
>>   
>>   static int saved_functions_combine(struct btf_encoder_func_state *a, struct btf_encoder_func_state *b)
>>   {
>> -	uint8_t optimized, unexpected, inconsistent;
>> -	int ret;
>> +	uint8_t optimized, unexpected, inconsistent, ambiguous_addr;
>> +
>> +	if (a->elf != b->elf)
>> +		return 1;
>>   
>> -	ret = strncmp(a->elf->name, b->elf->name,
>> -		      max(a->elf->prefixlen, b->elf->prefixlen));
>> -	if (ret != 0)
>> -		return ret;
>>   	optimized = a->optimized_parms | b->optimized_parms;
>>   	unexpected = a->unexpected_reg | b->unexpected_reg;
>>   	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
>> -	if (!unexpected && !inconsistent && !funcs__match(a, b))
>> +	ambiguous_addr = a->ambiguous_addr | b->ambiguous_addr;
>> +	if (!unexpected && !inconsistent && !ambiguous_addr && !funcs__match(a, b))
>>   		inconsistent = 1;
>>   	a->optimized_parms = b->optimized_parms = optimized;
>>   	a->unexpected_reg = b->unexpected_reg = unexpected;
>>   	a->inconsistent_proto = b->inconsistent_proto = inconsistent;
>> +	a->ambiguous_addr = b->ambiguous_addr = ambiguous_addr;
>>   
>>   	return 0;
>>   }
>> @@ -1432,7 +1478,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>>   		 * just do not _use_ them.  Only exclude functions with
>>   		 * unexpected register use or multiple inconsistent prototypes.
>>   		 */
>> -		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto;
>> +		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto && !state->ambiguous_addr;
>>   
>>   		if (add_to_btf) {
>>   			err = btf_encoder__add_func(state->encoder, state);
>> @@ -1447,32 +1493,6 @@ out:
>>   	return err;
>>   }
>>   
>> -static void elf_functions__collect_function(struct elf_functions *functions, GElf_Sym *sym)
>> -{
>> -	struct elf_function *func;
>> -	const char *name;
>> -
>> -	if (elf_sym__type(sym) != STT_FUNC)
>> -		return;
>> -
>> -	name = elf_sym__name(sym, functions->symtab);
>> -	if (!name)
>> -		return;
>> -
>> -	func = &functions->entries[functions->cnt];
>> -	func->name = name;
>> -	if (strchr(name, '.')) {
>> -		const char *suffix = strchr(name, '.');
>> -
>> -		functions->suffix_cnt++;
>> -		func->prefixlen = suffix - name;
>> -	} else {
>> -		func->prefixlen = strlen(name);
>> -	}
>> -
>> -	functions->cnt++;
>> -}
>> -
>>   static struct elf_functions *btf_encoder__elf_functions(struct btf_encoder *encoder)
>>   {
>>   	struct elf_functions *funcs = NULL;
>> @@ -1490,13 +1510,12 @@ static struct elf_functions *btf_encoder__elf_functions(struct btf_encoder *enco
>>   	return funcs;
>>   }
>>   
>> -static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder,
>> -						       const char *name, size_t prefixlen)
>> +static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder, const char *name)
>>   {
>>   	struct elf_functions *funcs = elf_functions__find(encoder->cu->elf, &encoder->elf_functions_list);
>> -	struct elf_function key = { .name = name, .prefixlen = prefixlen };
>> +	struct elf_function key = { .name = (char*)name };
>>   
>> -	return bsearch(&key, funcs->entries, funcs->cnt, sizeof(key), functions_cmp);
>> +	return bsearch(&key, funcs->entries, funcs->cnt, sizeof(key), elf_function__name_cmp);
>>   }
>>   
>>   static bool btf_name_char_ok(char c, bool first)
>> @@ -2060,7 +2079,7 @@ static int btf_encoder__collect_kfuncs(struct btf_encoder *encoder)
>>   			continue;
>>   		}
>>   
>> -		elf_fn = btf_encoder__find_function(encoder, func, 0);
>> +		elf_fn = btf_encoder__find_function(encoder, func);
>>   		if (elf_fn) {
>>   			elf_fn->kfunc = true;
>>   			elf_fn->kfunc_flags = pair->flags;
>> @@ -2135,14 +2154,34 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
>>   	return err;
>>   }
>>   
>> +static inline int elf_function__push_sym(struct elf_function *func, struct elf_function_sym *sym) {
>> +	struct elf_function_sym *tmp;
>> +
>> +	if (func->sym_cnt)
>> +		tmp = realloc(func->syms, (func->sym_cnt + 1) * sizeof(func->syms[0]));
>> +	else
>> +		tmp = calloc(sizeof(func->syms[0]), 1);
>> +
>> +	if (!tmp)
>> +		return -ENOMEM;
>> +
>> +	func->syms = tmp;
>> +	func->syms[func->sym_cnt] = *sym;
>> +	func->sym_cnt++;
>> +
>> +	return 0;
>> +}
>> +
>>   static int elf_functions__collect(struct elf_functions *functions)
>>   {
>>   	uint32_t nr_symbols = elf_symtab__nr_symbols(functions->symtab);
>> -	struct elf_function *tmp;
>> +	struct elf_function_sym func_sym;
>> +	struct elf_function *func, *tmp;
>> +	const char *sym_name, *suffix;
>>   	Elf32_Word sym_sec_idx;
>> +	int err = 0, i, j;
>>   	uint32_t core_id;
>>   	GElf_Sym sym;
>> -	int err = 0;
>>   
>>   	/* We know that number of functions is less than number of symbols,
>>   	 * so we can overallocate temporarily.
>> @@ -2153,18 +2192,72 @@ static int elf_functions__collect(struct elf_functions *functions)
>>   		goto out_free;
>>   	}
>>   
>> +	/* First, collect an elf_function for each GElf_Sym
>> +	 * Where func->name is without a suffix
>> +	 */
>>   	functions->cnt = 0;
>>   	elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sym_sec_idx) {
>> -		elf_functions__collect_function(functions, &sym);
>> +
>> +		if (elf_sym__type(&sym) != STT_FUNC)
>> +			continue;
>> +
>> +		sym_name = elf_sym__name(&sym, functions->symtab);
>> +		if (!sym_name)
>> +			continue;
>> +
>> +		func = &functions->entries[functions->cnt];
>> +
>> +		suffix = strchr(sym_name, '.');
>> +		if (suffix)
>> +			func->name = strndup(sym_name, suffix - sym_name);
>> +		else
>> +			func->name = strdup(sym_name);
>> +
>> +		if (!func->name) {
>> +			err = -ENOMEM;
>> +			goto out_free;
>> +		}
>> +
>> +		func_sym.name = sym_name;
>> +		func_sym.addr = sym.st_value;
>> +
>> +		err = elf_function__push_sym(func, &func_sym);
>> +		if (err)
>> +			goto out_free;
>> +
>> +		functions->cnt++;
>>   	}
>>   
>> +	/* At this point functions->entries is an unordered array of elf_function
>> +	 * each having a name (without a suffix) and a single elf_function_sym (maybe with suffix)
>> +	 * Now let's sort this table by name.
>> +	 */
>>   	if (functions->cnt) {
>> -		qsort(functions->entries, functions->cnt, sizeof(*functions->entries), functions_cmp);
>> +		qsort(functions->entries, functions->cnt, sizeof(*functions->entries), elf_function__name_cmp);
>>   	} else {
>>   		err = 0;
>>   		goto out_free;
>>   	}
>>   
>> +	/* Finally dedup by name, transforming { name -> syms[1] } entries into { name -> syms[n] } */
>> +	i = 0;
>> +	j = 1;
>> +	for (j = 1; j < functions->cnt; j++) {
>> +		struct elf_function *a = &functions->entries[i];
>> +		struct elf_function *b = &functions->entries[j];
>> +
>> +		if (!strcmp(a->name, b->name)) {
>> +			elf_function__push_sym(a, &b->syms[0]);
>> +			elf_function__free_content(b);
>> +		} else {
>> +			i++;
>> +			if (i != j)
>> +				functions->entries[i] = functions->entries[j];
>> +		}
>> +	}
>> +
>> +	functions->cnt = i + 1;
>> +
>>   	/* Reallocate to the exact size */
>>   	tmp = realloc(functions->entries, functions->cnt * sizeof(struct elf_function));
>>   	if (tmp) {
>> @@ -2661,30 +2754,11 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>   			if (!name)
>>   				continue;
>>   
>> -			/* prefer exact function name match... */
>> -			func = btf_encoder__find_function(encoder, name, 0);
>> -			if (!func && funcs->suffix_cnt &&
>> -			    conf_load->btf_gen_optimized) {
>> -				/* falling back to name.isra.0 match if no exact
>> -				 * match is found; only bother if we found any
>> -				 * .suffix function names.  The function
>> -				 * will be saved and added once we ensure
>> -				 * it does not have optimized-out parameters
>> -				 * in any cu.
>> -				 */
>> -				func = btf_encoder__find_function(encoder, name,
>> -								  strlen(name));
>> -				if (func) {
>> -					if (encoder->verbose)
>> -						printf("matched function '%s' with '%s'%s\n",
>> -						       name, func->name,
>> -						       fn->proto.optimized_parms ?
>> -						       ", has optimized-out parameters" :
>> -						       fn->proto.unexpected_reg ? ", has unexpected register use by params" :
>> -						       "");
>> -					if (!func->alias)
>> -						func->alias = strdup(name);
>> -				}
>> +			func = btf_encoder__find_function(encoder, name);
>> +			if (!func) {
>> +				if (encoder->verbose)
>> +					printf("could not find function '%s' in the ELF functions table\n", name);
>> +				continue;
>>   			}
>>   		} else {
>>   			if (!fn->external)
> 


