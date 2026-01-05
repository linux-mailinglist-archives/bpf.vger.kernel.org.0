Return-Path: <bpf+bounces-77851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC060CF4BC2
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 17:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57FA530EB645
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CE930FF3B;
	Mon,  5 Jan 2026 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cna3ZqU5"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92677304BDE
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630233; cv=none; b=oJxrbQUA7yyuxc/PYfU1nSmiMMwu8nWzD1GdD1xQJVfAx8dpuVk7LVkzlAHL1kIdCOWZfcAoKE6h4S7w7yaZTUNVQp6JB7/N0CJ4D3BBg97uNLpB4romTrbycrbGf975eRoVMopiyD4GjKZ8sf+R5ollBOkv7RudSlbmU7gMzTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630233; c=relaxed/simple;
	bh=UpicWfuFGkAyH55oy5ZfRfu3OTy4TTzXiPHz76h6LzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYRWwtdLSwXrKoG5D6f9fT0gKYJ1SXyCfL+pssUM4oCnFJU8qbPRtNjOEtpSpr6GmQbCQ9BULsLssWhvskt3SXKgNi7r07ly2qQ88jtJldf1c2KPLrSBqzvAb6juwL8eUUt57DfRctcqpQRIj0j09A9Kjm9a+MDnpxtzIo/ZkaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cna3ZqU5; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6b0968a3-406b-412f-acbb-c00ac2ad7c93@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767630219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZcsIi/hgkJOdRzQn+g9a79QLtiVLVb8EtJjUToIHoc=;
	b=Cna3ZqU5YiEZ4ShGHqMtNhyg0jhTXUfQH8m+mBERS9CmxkmfmWGBNf/9Rylc5xEE197O0h
	haFlkYA5pGGiffTI8HNiht+6G0QNvmYngfMKsQtR4SBElOassvI33o3tIwtDUuinKncMWi
	qwpSW6yauUBR0TBlj/5Xie8+7bFkj3c=
Date: Mon, 5 Jan 2026 08:23:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves] btf_encoder: prefer strong function definitions
 for BTF generation
Content-Language: en-GB
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>
References: <20251231085322.3248063-1-mattbobrowski@google.com>
 <926aca4a-d7d5-4e7d-9096-77b27374c5cd@linux.dev>
 <aVt139VXMTka-hYw@google.com> <aVuk1e73g7ZTHqMY@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aVuk1e73g7ZTHqMY@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 1/5/26 3:47 AM, Matt Bobrowski wrote:
> On Mon, Jan 05, 2026 at 08:27:11AM +0000, Matt Bobrowski wrote:
>> On Fri, Jan 02, 2026 at 10:46:00AM -0800, Yonghong Song wrote:
>>>
>>> On 12/31/25 12:53 AM, Matt Bobrowski wrote:
>>>> Currently, when a function has both a weak and a strong definition
>>>> across different compilation units (CUs), the BTF encoder arbitrarily
>>>> selects one to generate the BTF entry. This selection fundamentally is
>>>> dependent on the order in which pahole processes the CUs.
>>>>
>>>> This indifference often leads to a mismatch where the generated BTF
>>>> reflects the weak definition's prototype, even though the linker
>>>> selected the strong definition for the final vmlinux binary.
>>>>
>>>> A notable example described in [0] involving function
>>>> bpf_lsm_mmap_file(). Both weak and strong definitions exist,
>>>> distinguished only by parameter names (e.g., file vs
>>>> file__nullable). While the strong definition is linked into the
>>>> vmlinux object, the generated BTF contained the prototype for the weak
>>>> definition. This causes issues for BPF verifier (e.g., __nullable
>>>> annotation semantics), or tools relying on accurate type information.
>>>>
>>>> To fix this, ensure the BTF encoder selects the function definition
>>>> corresponding to the actual code linked into the binary. This is
>>>> achieved by comparing the DWARF function address (DW_AT_low_pc) with
>>>> the ELF symbol address (st_value). Only the DWARF entry for the strong
>>>> definition will match the final resolved ELF symbol address.
>>>>
>>>> [0] https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
>>>>
>>>> Link: https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
>>>> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
>>> LGTM with some nits below.
>> Thanks for the review.
>>
>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>>
>>>> ---
>>>>    btf_encoder.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 36 insertions(+)
>>>>
>>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>>> index b37ee7f..0462094 100644
>>>> --- a/btf_encoder.c
>>>> +++ b/btf_encoder.c
>>>> @@ -79,6 +79,7 @@ struct btf_encoder_func_annot {
>>>>    /* state used to do later encoding of saved functions */
>>>>    struct btf_encoder_func_state {
>>>> +	uint64_t addr;
>>>>    	struct elf_function *elf;
>>>>    	uint32_t type_id_off;
>>>>    	uint16_t nr_parms;
>>>> @@ -1258,6 +1259,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>>>>    	if (!state)
>>>>    		return -ENOMEM;
>>>> +	state->addr = function__addr(fn);
>>>>    	state->elf = func;
>>>>    	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
>>>>    	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
>>>> @@ -1477,6 +1479,29 @@ static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
>>>>    	encoder->func_states.cap = 0;
>>>>    }
>>>> +static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct btf_encoder_func_state *combined_states,
>>>> +									  int combined_cnt)
>>>> +{
>>>> +	int i, j;
>>>> +
>>>> +	/*
>>>> +	 * The same elf_function is shared amongst combined functions,
>>>> +	 * as per saved_functions_combine().
>>>> +	 */
>>>> +	struct elf_function *elf = combined_states[0].elf;
>>> The logic is okay. But can we limit elf->sym_cnt to be 1 here?
>>> This will match the case where two functions (weak and strong)
>>> co-exist in compiler and eventually only strong/global function
>>> will survive.
>> In fact, checking again I believe that the loop is redundant because
>> elf_function__has_ambiguous_address() ensures that if we reach this
>> point, all symbols for the function share the same address. Therefore,
>> checking the first symbol (elf->syms[0]) should be sufficient and
>> equivalent to checking all of them.
>>
>> Will send through a v2 with this amendment.
> Hm, actually, no. I don't think the addresses stored within
> elf->syms[#].addr should all be assumed to be the same at the point
> which the new btf_encoder__select_canonical_state() function is called
> (due to things like skip_encoding_inconsistent_proto possibly taking
> effect). Therefore, I think it's best that we leave things as is and
> exhaustively iterate through all elf->syms? I don't believe there's
> any adverse effects in doing it this way anyway?

No. Your code is correct. For elf->sym_cnt, it covers both sym_cnt
is 1 or more than 1. My previous suggestion is to single out the
sym_cnt = 1 case since it is what you try to fix.

I am okay with the current implementation since it is correct.
Maybe Alan and Arnaldo have additional comments about the code.

>
>>>> +
>>>> +	for (i = 0; i < combined_cnt; i++) {
>>>> +		struct btf_encoder_func_state *state = &combined_states[i];
>>>> +
>>>> +		for (j = 0; j < elf->sym_cnt; j++) {
>>>> +			if (state->addr == elf->syms[j].addr)
>>>> +				return state;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return &combined_states[0];
>>>> +}
>>>> +
>>>>    static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_encoding_inconsistent_proto)
>>>>    {
>>>>    	struct btf_encoder_func_state *saved_fns = encoder->func_states.array;
>>>> @@ -1517,6 +1542,17 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>>>>    					0, 0);
>>>>    		if (add_to_btf) {
>>>> +			/*
>>>> +			 * We're to add the current function within
>>>> +			 * BTF. Although, from all functions that have
>>>> +			 * possibly been combined via
>>>> +			 * saved_functions_combine(), ensure to only
>>>> +			 * select and emit BTF for the most canonical
>>>> +			 * function definition.
>>>> +			 */
>>>> +			if (j - i > 1)
>>>> +				state = btf_encoder__select_canonical_state(state, j - i);
>>>> +
>>>>    			if (is_kfunc_state(state))
>>>>    				err = btf_encoder__add_bpf_kfunc(encoder, state);
>>>>    			else


