Return-Path: <bpf+bounces-64303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CFCB1131B
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 23:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3101C27A6B
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 21:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7A02EE99D;
	Thu, 24 Jul 2025 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iG4eOp1E"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4FD2EE971
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392431; cv=none; b=KXhaOe1GrAkedvXq5ktu7VMMnD7OirZIDJ37gKt5fkApIGH6QWKE0amBAK65DJWfmVRq9B2pNZlFm1ECMMRyZMQF1caf59mqW8mDpszWOOHovC+ZEtzGFqBhEvGxrs4r9iHByJX5L1r1YfeTyqiwGlz7XlSj9Ke4sj0HE6TqG7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392431; c=relaxed/simple;
	bh=DLfx5UxUqQRRsSNJOR1gvua75ykoDeSRS+ogkYCD0t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UofKhosBL5UiRlGgANjED9qkHqmdrIfUF+gKvcd7uMC54OWE2oGODuGtB/EU/7nueJ30tf4YspgjQHE3se7eRnzRSJ9h/Y2XaRdk9rsJu2T8Tp65OW3kQUeZWwKKAtL8ZBbdqj0W1BgPfAKw/qT//2AmFlWhUYEvpnEK3prsUMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iG4eOp1E; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <83d1b791-85fd-49ea-9c40-f3ba4c23850d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753392413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aiDMgTgdg/bop1UfVygXoPnAhLssawEJ/6Y7IIh/JkQ=;
	b=iG4eOp1EKGa5ZwNd0y/wBHUvYnLUWUKuWudYdhG/j83CJAcdOLEHVwNFlXDBUR9RpWgLKE
	iK4NzmVFO60ofsdk/8boSSCcZqFL7t4niwMMCX7OP/D225NdcwaVjzAr1W8dDRpNoK1dsX
	Qwo8W3MrVw9BMXvyGq+lsQFkdvBxMys=
Date: Thu, 24 Jul 2025 14:26:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC dwarves] btf_encoder: Remove duplicates from functions
 entries
To: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Menglong Dong <menglong8.dong@gmail.com>, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
 Song Liu <songliubraving@fb.com>, Eduard Zingerman <eddyz87@gmail.com>
References: <20250717152512.488022-1-jolsa@kernel.org>
 <e4fece83-8267-4929-b1aa-65a9e2882dd8@oracle.com> <aH5OW0rtSuMn1st1@krava>
 <6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev>
 <e88caa24-6bfa-457c-8e88-d00ed775ebd1@oracle.com>
 <98f41eaf6dd364745013650d58c5f254a592221c@linux.dev> <aIDFh26qdAURVL0u@krava>
 <f44af47f-e05e-4fa4-95ca-bf95f04e4c27@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <f44af47f-e05e-4fa4-95ca-bf95f04e4c27@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/24/25 10:54 AM, Alan Maguire wrote:
> On 23/07/2025 12:22, Jiri Olsa wrote:
>> On Tue, Jul 22, 2025 at 10:58:52PM +0000, Ihor Solodrai wrote:
>>
>> SNIP
>>
>>> @@ -1338,48 +1381,39 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>>>   	return 0;
>>>   }
>>>   
>>> -static int functions_cmp(const void *_a, const void *_b)
>>> +static int elf_function__name_cmp(const void *_a, const void *_b)
>>>   {
>>>   	const struct elf_function *a = _a;
>>>   	const struct elf_function *b = _b;
>>>   
>>> -	/* if search key allows prefix match, verify target has matching
>>> -	 * prefix len and prefix matches.
>>> -	 */
>>> -	if (a->prefixlen && a->prefixlen == b->prefixlen)
>>> -		return strncmp(a->name, b->name, b->prefixlen);
>>
>> nice to see this one removed ;-)
>>
>>>   	return strcmp(a->name, b->name);
>>>   }
>>>   
>>> -#ifndef max
>>> -#define max(x, y) ((x) < (y) ? (y) : (x))
>>> -#endif
>>> -
>>>   static int saved_functions_cmp(const void *_a, const void *_b)
>>>   {
>>>   	const struct btf_encoder_func_state *a = _a;
>>>   	const struct btf_encoder_func_state *b = _b;
>>>   
>>> -	return functions_cmp(a->elf, b->elf);
>>> +	return elf_function__name_cmp(a->elf, b->elf);
>>>   }
>>>   
>>>   static int saved_functions_combine(struct btf_encoder_func_state *a, struct btf_encoder_func_state *b)
>>>   {
>>> -	uint8_t optimized, unexpected, inconsistent;
>>> -	int ret;
>>> +	uint8_t optimized, unexpected, inconsistent, ambiguous_addr;
>>> +
>>> +	if (a->elf != b->elf)
>>> +		return 1;
>>>   
>>> -	ret = strncmp(a->elf->name, b->elf->name,
>>> -		      max(a->elf->prefixlen, b->elf->prefixlen));
>>> -	if (ret != 0)
>>> -		return ret;
>>>   	optimized = a->optimized_parms | b->optimized_parms;
>>>   	unexpected = a->unexpected_reg | b->unexpected_reg;
>>>   	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
>>> -	if (!unexpected && !inconsistent && !funcs__match(a, b))
>>> +	ambiguous_addr = a->ambiguous_addr | b->ambiguous_addr;
>>> +	if (!unexpected && !inconsistent && !ambiguous_addr && !funcs__match(a, b))
>>>   		inconsistent = 1;
>>>   	a->optimized_parms = b->optimized_parms = optimized;
>>>   	a->unexpected_reg = b->unexpected_reg = unexpected;
>>>   	a->inconsistent_proto = b->inconsistent_proto = inconsistent;
>>> +	a->ambiguous_addr = b->ambiguous_addr = ambiguous_addr;
>>
>>
>> I had to add change below to get the functions with multiple addresses out
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index fcc30aa9d97f..7b9679794790 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -1466,7 +1466,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>>   		 * just do not _use_ them.  Only exclude functions with
>>   		 * unexpected register use or multiple inconsistent prototypes.
>>   		 */
>> -		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto;
>> +		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto && !state->ambiguous_addr;
>>   
>>   		if (add_to_btf) {
>>   			err = btf_encoder__add_func(state->encoder, state);
>>
>>
>> other than that I like the approach
>>
> 
> Thanks for the patch! I ran it through CI [1] with the above change plus
> an added whitespace after the function name in the printf() in
> btf_encoder__log_func_skip(). The btf_functions.sh test expects
> whitespace after function names when examining skipped functions, so
> either the test should be updated to handle no whitespace or we should
> ensure the space is there after the function name like this:
> 
>          printf("%s : skipping BTF encoding of function due to ",
> func->name);
> 
> Otherwise we get a CI failure that is nothing to do with the changes.
> 
> With this in place we do however lose a lot of functions it seems, some
> I suspect unnecessarily. For example:
> 
> 
> Looking at
> 
>   < void __tcp_send_ack(struct sock * sk, u32 rcv_nxt, u16 flags);
> 
> ffffffff83c83170 t __tcp_send_ack.part.0
> ffffffff83c83310 T __tcp_send_ack
> 
> So __tcp_send_ack is partially inlined, but partial inlines should not
> count as ambiguous addresses I think. We should probably ensure we skip
> .part suffixes as well as .cold in calculating ambiguous addresses.
> 
> I modified the patch somewhat and we wind up losing ~400 functions
> instead of over 700, see [2].
> 
> Modified patch is at [3]. If the mods look okay to you Ihor would you
> mind sending it officially? Would be great to get wider testing to
> ensure it doesn't break anything or leave any functions out unexpectedly.

Alan, Jiri, thank you for review and testing. I sent this draft in a bit 
of a rush, sorry.

I'll incorporate your suggestions, test the patch a bit more and then
will send a clean version. I am curious what functions are lost and
why, will report if notice anything interesting.

> 
>> SNIP
>>
>>> @@ -2153,18 +2191,75 @@ static int elf_functions__collect(struct elf_functions *functions)
>>>   		goto out_free;
>>>   	}
>>>   
>>> +	/* First, collect an elf_function for each GElf_Sym
>>> +	 * Where func->name is without a suffix
>>> +	 */
>>>   	functions->cnt = 0;
>>>   	elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sym_sec_idx) {
>>> -		elf_functions__collect_function(functions, &sym);
>>> +
>>> +		if (elf_sym__type(&sym) != STT_FUNC)
>>> +			continue;
>>> +
>>> +		sym_name = elf_sym__name(&sym, functions->symtab);
>>> +		if (!sym_name)
>>> +			continue;
>>> +
>>> +		func = &functions->entries[functions->cnt];
>>> +
>>> +		const char *suffix = strchr(sym_name, '.');
>>> +		if (suffix) {
>>> +			functions->suffix_cnt++;
>>
>> do we need suffix_cnt now?
>>
> 
> think it's been unused for a while now, so can be removed I think.
> 
> Thanks again for working on this!
> 
> Alan
> 
> [1] https://github.com/alan-maguire/dwarves/actions/runs/16500065295
> [2]
> https://github.com/alan-maguire/dwarves/actions/runs/16501897430/job/46662503155
> [3]
> https://github.com/acmel/dwarves/commit/30dffd7fc34e7753b3d21b4b3f1a5e17814c224f
> 
>> thanks,
>> jirka
>>
>>
>>> +			func->name = strndup(sym_name, suffix - sym_name);
>>> +		} else {
>>> +			func->name = strdup(sym_name);
>>> +		}
>>> +		if (!func->name) {
>>> +			err = -ENOMEM;
>>> +			goto out_free;
>>> +		}
>>> +
>>> +		func_sym.name = sym_name;
>>> +		func_sym.addr = sym.st_value;
>>> +
>>> +		err = elf_function__push_sym(func, &func_sym);
>>> +		if (err)
>>> +			goto out_free;
>>> +
>>> +		functions->cnt++;
>>>   	}
>>
>> SNIP
> 


