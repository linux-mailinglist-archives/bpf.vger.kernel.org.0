Return-Path: <bpf+bounces-44539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A7E9C455F
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 19:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E807D1F22603
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1DC1BC085;
	Mon, 11 Nov 2024 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YLTY7kii"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1A1AB521
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351093; cv=none; b=BzRD+NxXIfwgvi49GKj6TXlhOpmnwLIVJElmTE5h1xNqDcpedm7jVc1rgpnGZV+Ng3imF+lqIrYZJzTrUdJO37saiFRGU0HlxMYV2IWS9jF3gTtkDWiuVKgPWkRgYcnOHFwDu56Y+X4iP2pPN0g2NdR3PMj2zPgbMWZTA3DO9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351093; c=relaxed/simple;
	bh=SWZWrFtToNG0AJBiQmqz1a4/hDFm3KrK/dn4IK/nwFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gw5PojZKdUsMFbdmIJn8HqYZe9CrHa7YFq3ccARv/+VTiQpk0Kiz9gmNFjuSiZKrVAJ4241xxZ4mMP06U2hh/LQ464KMG/diRCjpimN9cZx9NpaKbHy/2ily0nv9avnUQ1Mma6V/Zl5A6TfcI2mTyoE23VY5wpfZc/3jXhbUBDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YLTY7kii; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <762f7d67-4d4f-4d94-a2c3-6f6b11913c8d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731351079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zc0SvEnN9qn/KwKIL4KDePheWcsNTOTzc/mAp8GZt8U=;
	b=YLTY7kiiwpOWH0F4tkLLxeUY7C+4ycBKmD9zd1D1iM7m7W/sXOD+6qgN4sEt59i6vbU3h1
	2sGU7MthmrtxvdAzM21BBlk6uklpnTQk3SS7ry0dGoIyvjLycpMrIuMRNygfFfMpkVv/Q9
	+Sp2V8gCyyWVnFM5P5kPEH1YDr2n3sU=
Date: Mon, 11 Nov 2024 10:51:05 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: Check DW_OP_[GNU_]entry_value
 for possible parameter matching
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Song Liu <song@kernel.org>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
 <20241108180524.1198900-1-yonghong.song@linux.dev>
 <31dea31e6f75916fdc078d433263daa6bb0bffdc.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <31dea31e6f75916fdc078d433263daa6bb0bffdc.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 11/10/24 3:38 AM, Eduard Zingerman wrote:
> On Fri, 2024-11-08 at 10:05 -0800, Yonghong Song wrote:
>
> [...]
>
>> For one of internal 6.11 kernel, there are 62498 functions in BTF and
>> perf_event_read() is not there. With this patch, there are 61552 functions
>> in BTF and perf_event_read() is included.
> Hi Yonghong,
>
> I checked this patch using my local kernel build and do see a
> difference in generated funcs: 47756 vs 47721 funcs with and without.
> Looking at DWARF for the newly added functions, the do indeed have
> DW_OP_entry_value(expected_reg) in their list of locations.
>
>> Reported-by: Song Liu <song@kernel.org>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   dwarf_loader.c | 81 +++++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 57 insertions(+), 24 deletions(-)
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index e0b8c11..1fe44bc 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -1169,34 +1169,67 @@ static bool check_dwarf_locations(Dwarf_Attribute *attr, struct parameter *parm,
>>   		return false;
>>   
>>   #if _ELFUTILS_PREREQ(0, 157)
>> -	/* dwarf_getlocations() handles location lists; here we are
>> -	 * only interested in the first expr.
>> -	 */
>> -	if (dwarf_getlocations(attr, 0, &base, &start, &end,
>> -			       &loc.expr, &loc.exprlen) > 0 &&
>> -		loc.exprlen != 0) {
>> -		expr = loc.expr;
>> -
>> -		switch (expr->atom) {
>> -		case DW_OP_reg0 ... DW_OP_reg31:
>> -			/* mark parameters that use an unexpected
>> -			 * register to hold a parameter; these will
>> -			 * be problematic for users of BTF as they
>> -			 * violate expectations about register
>> -			 * contents.
>> +	bool reg_matched = false, reg_unmatched = false, first_expr_reg = false, ret = false;
>> +	ptrdiff_t offset = 0;
>> +	int loc_num = -1;
>> +
>> +	while ((offset = dwarf_getlocations(attr, offset, &base, &start, &end, &loc.expr, &loc.exprlen)) > 0 &&
>> +	       loc.exprlen != 0) {
>> +		ret = true;
>> +		loc_num++;
>> +
>> +		for (int i = 0; i < loc.exprlen; i++) {
> I'm not sure if you need to iterate every expression in the list.
> The list is a stack program, so each expression is a command.

For this particular case, we do not need to iterate every expression in
the list. For a location like
     [0xffffffff812c6323, 0xffffffff812c63fe): DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
We only cares the DW_OP_GNU_entry_value(DW_OP_reg5 RDI), so check the *first*
entry of each location is enough.

>
>> +			Dwarf_Attribute entry_attr;
>> +			Dwarf_Op *entry_ops;
>> +			size_t entry_len;
>> +
>> +			expr = &loc.expr[i];
>> +			switch (expr->atom) {
>> +			case DW_OP_reg0 ... DW_OP_reg31:
>> +				/* first location, first expression */
>> +				if (loc_num == 0 && i == 0) {
>> +					if (expected_reg >= 0) {
>> +						if (expected_reg == expr->atom) {
>> +							reg_matched = true;
> reg_matched is never really used in conditionals, as everywhere it is
> set to 'true' the 'return true' follows.

Right, there is no need to have 'reg_matches' variable.

>
> [...]
>
>> +	if (reg_unmatched)
>> +		parm->unexpected_reg = 1;
>> +	else if (ret && !first_expr_reg)
>> +		parm->optimized = 1;
> It is a bit unfortunate, that parm->optimized is now set in two functions.
> What do you think about the simplification as at the end of this email?

My original intention is to have *clear* separate for two cases,
_ELFUTILS_PREREQ(0, 157) or not. But if we intends to only visit
the first attr of every location, the things indeed can be simplified.

>
> Also, it appears there is some bug either in pahole or in libdw's
> implementation of dwarf_getlocation(). When I try both your patch-set
> and my variant there is a segfault once in a while:
>
>    $ for i in $(seq 1 100); \
>      do echo "---> $i"; \
>         pahole -j --skip_encoding_btf_inconsistent_proto -J --btf_encode_detached=/dev/null vmlinux ; \
>      done
>    ---> 1
>    ...
>    ---> 71
>    Segmentation fault (core dumped)
>    ...
>
> The segfault happens only when -j (multiple threads) is passed.
> If pahole is built with sanitizers
> (passing -DCMAKE_C_FLAGS="-fsanitize=undefined,address")
> the stack trace looks as follows:
>
> AddressSanitizer:DEADLYSIGNAL
> =================================================================
> ==2360650==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000008 (pc 0x7f20bcb29200 bp 0x7f208f7fc110 sp 0x7f208f7fc0b8 T18)
> ==2360650==The signal is caused by a READ memory access.
> ==2360650==Hint: address points to the zero page.
>      #0 0x7f20bcb29200 in maybe_split_for_insert /usr/src/debug/glibc-2.39-22.fc40.x86_64/misc/tsearch.c:228
>      #1 0x7f20bcb29465 in __GI___tsearch /usr/src/debug/glibc-2.39-22.fc40.x86_64/misc/tsearch.c:358
>      #2 0x7f20bcb29465 in __GI___tsearch /usr/src/debug/glibc-2.39-22.fc40.x86_64/misc/tsearch.c:290
>      #3 0x7f20bd489a51 in tsearch.part.0 (/lib64/libasan.so.8+0x89a51) (BuildId: a4ad7eb954b390cf00f07fa10952988a41d9fc7a)
>      #4 0x7f20bdb07601 in __libdw_intern_expression (/lib64/libdw.so.1+0x35601) (BuildId: b06d0f436023c584e2d618f94f530d9e22671078)
>      #5 0x7f20bdb09c70 in dwarf_getlocation (/lib64/libdw.so.1+0x37c70) (BuildId: b06d0f436023c584e2d618f94f530d9e22671078)
>      #6 0x4912c4 in parameter__new (/home/eddy/work/dwarves-fork/build/pahole+0x4912c4) (BuildId: 2cc4f329c9ca6d293d2044fae936e6a4b0ffa85a)
>      #7 0x495bfa in die__process_function (/home/eddy/work/dwarves-fork/build/pahole+0x495bfa) (BuildId: 2cc4f329c9ca6d293d2044fae936e6a4b0ffa85a)
>      #8 0x498671 in __die__process_tag (/home/eddy/work/dwarves-fork/build/pahole+0x498671) (BuildId: 2cc4f329c9ca6d293d2044fae936e6a4b0ffa85a)
>      #9 0x49c692 in die__process_unit (/home/eddy/work/dwarves-fork/build/pahole+0x49c692) (BuildId: 2cc4f329c9ca6d293d2044fae936e6a4b0ffa85a)
>      #10 0x49cb5f in die__process (/home/eddy/work/dwarves-fork/build/pahole+0x49cb5f) (BuildId: 2cc4f329c9ca6d293d2044fae936e6a4b0ffa85a)
>      #11 0x4a3767 in dwarf_cus__process_cu (/home/eddy/work/dwarves-fork/build/pahole+0x4a3767) (BuildId: 2cc4f329c9ca6d293d2044fae936e6a4b0ffa85a)
>      #12 0x4a3f8f in dwarf_cus__process_cu_thread (/home/eddy/work/dwarves-fork/build/pahole+0x4a3f8f) (BuildId: 2cc4f329c9ca6d293d2044fae936e6a4b0ffa85a)
>      #13 0x7f20bd45df95 in asan_thread_start(void*) (/lib64/libasan.so.8+0x5df95) (BuildId: a4ad7eb954b390cf00f07fa10952988a41d9fc7a)
>      #14 0x7f20bcaa66d6 in start_thread /usr/src/debug/glibc-2.39-22.fc40.x86_64/nptl/pthread_create.c:447
>      #15 0x7f20bcb2a60b in clone3 ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78

I didn't notice this one during my test. But as later discussion suggested,
this is something we want to fix.

>
> ---
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index ec8641b..c5c2298 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1157,16 +1157,83 @@ static struct template_parameter_pack *template_parameter_pack__new(Dwarf_Die *d
>   	return pack;
>   }
>   
> +static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
> +				      ptrdiff_t offset, Dwarf_Addr *basep,
> +				      Dwarf_Addr *startp, Dwarf_Addr *endp,
> +				      Dwarf_Op **expr, size_t *exprlen)
> +{
> +#if _ELFUTILS_PREREQ(0, 157)
> +	return dwarf_getlocations(attr, offset, basep, startp, endp, expr, exprlen);
> +#else
> +	int err;
> +
> +	if (offset)
> +		return 0;
> +
> +	err = dwarf_getlocation(attr, expr, exprlen);
> +	return err < 0 ? err : 1;
> +#endif
> +}
> +
> +/* For DW_AT_location 'attr':
> + * - if first location is DW_OP_regXX with expected number, returns the register;
> + * - if location DW_OP_entry_value(DW_OP_regXX) is in the list, returns the register;
> + * - if first location is DW_OP_regXX, returns the register;
> + * - otherwise returns -1.
> + */
> +static int param_reg_at_entry(Dwarf_Attribute *attr, int expected_reg)
> +{
> +	Dwarf_Op *expr, *entry_ops, *first_expr = NULL;
> +	Dwarf_Addr base, start, end;
> +	Dwarf_Attribute entry_attr;
> +	size_t exprlen, entry_len;
> +	ptrdiff_t offset = 0;
> +        int loc_num = -1;
> +
> +        while ((offset = __dwarf_getlocations(attr, offset, &base, &start, &end, &expr, &exprlen)) > 0) {
> +		loc_num++;
> +
> +		/* Convert expression list (XX DW_OP_stack_value) -> (XX).
> +		 * DW_OP_stack_value instructs interpreter to pop current value from
> +		 * DWARF expression evaluation stack, and thus is not important here.
> +		 */
> +		if (exprlen > 1 && expr[exprlen - 1].atom == DW_OP_stack_value)
> +			exprlen--;
> +
> +		if (exprlen != 1)
> +			continue;
> +
> +		switch (expr->atom) {
> +		/* match DW_OP_regXX at first location */
> +		case DW_OP_reg0 ... DW_OP_reg31:
> +			if (loc_num == 0) {
> +				if(expr->atom == expected_reg)
> +					return expr->atom;
> +				first_expr = expr;
> +			}
> +		/* match DW_OP_entry_value(DW_OP_regXX) at any location */
> +		case DW_OP_entry_value:
> +		case DW_OP_GNU_entry_value:
> +			if (dwarf_getlocation_attr (attr, expr, &entry_attr) == 0 &&
> +			    dwarf_getlocation (&entry_attr, &entry_ops, &entry_len) == 0 &&
> +			    entry_len == 1)
> +				return entry_ops->atom;
> +			break;
> +		}
> +	}
> +	if (first_expr)
> +		return first_expr->atom;
> +	return -1;
> +}
> +
>   static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>   					struct conf_load *conf, int param_idx)
>   {
>   	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
>   
>   	if (parm != NULL) {
> -		Dwarf_Addr base, start, end;
>   		bool has_const_value;
>   		Dwarf_Attribute attr;
> -		struct location loc;
>   
>   		tag__init(&parm->tag, cu, die);
>   		parm->name = attr_string(die, DW_AT_name, conf);
> @@ -1208,35 +1275,21 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>   		 */
>   		has_const_value = dwarf_attr(die, DW_AT_const_value, &attr) != NULL;
>   		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
> -		/* dwarf_getlocations() handles location lists; here we are
> -		 * only interested in the first expr.
> -		 */
> -		if (parm->has_loc &&
> -#if _ELFUTILS_PREREQ(0, 157)
> -		    dwarf_getlocations(&attr, 0, &base, &start, &end,
> -				       &loc.expr, &loc.exprlen) > 0 &&
> -#else
> -		    dwarf_getlocation(&attr, &loc.expr, &loc.exprlen) == 0 &&
> -#endif
> -			loc.exprlen != 0) {
> +
> +		if (parm->has_loc) {
>   			int expected_reg = cu->register_params[param_idx];
> -			Dwarf_Op *expr = loc.expr;
> +			int actual_reg = param_reg_at_entry(&attr, expected_reg);
>   
> -			switch (expr->atom) {
> -			case DW_OP_reg0 ... DW_OP_reg31:
> +			if (actual_reg < 0)
> +				parm->optimized = 1;
> +			else if (expected_reg >= 0 && expected_reg != actual_reg)
>   				/* mark parameters that use an unexpected
>   				 * register to hold a parameter; these will
>   				 * be problematic for users of BTF as they
>   				 * violate expectations about register
>   				 * contents.
>   				 */
> -				if (expected_reg >= 0 && expected_reg != expr->atom)
> -					parm->unexpected_reg = 1;
> -				break;
> -			default:
> -				parm->optimized = 1;
> -				break;
> -			}
> +				parm->unexpected_reg = 1;
>   		} else if (has_const_value) {
>   			parm->optimized = 1;
>   		}

Thanks. With only visited the first attr for location list, we can 
indeed have less changes compared to original code.



