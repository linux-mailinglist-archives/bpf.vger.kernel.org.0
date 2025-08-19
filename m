Return-Path: <bpf+bounces-66033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9090B2CD09
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 21:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA3524E4AF0
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 19:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8636532BF52;
	Tue, 19 Aug 2025 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vUT3HFWZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD82C32A3F4
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632132; cv=none; b=LeWeSALK6HpEd4JCtB/XXO8SHSdP7TllNuy82mKeTDnshrlesPisC+skPsVrQVnol0Bx/N43AJpP9OlxbxV9k5PTBU5ipjfwaECvv7aX/Wu8hRE36I+KJl+q4eJZb669BJe+YLG1liMSSYAXu4TkRhPz5zaHL58PA0yVdh3kwfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632132; c=relaxed/simple;
	bh=GNdmD23cnUUpMkrjNBvs3ossC7Y8/ypE+ibdnQT14DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIupsc9r9XzD+mfrLavInNKtvBY3HZfMjvJbTccL4LUm7Epk8eDVkUUJMS3Fw+/UtXtAoF7WlZNxyxIUHaYtbS5dO8/gEP7sdHNFddoud4mDXFgDAajdWd/H6G7ELFQ1kJ80yn9Jr8Bvc4mNZuojEfC9dAbi+cs6a9nTBbHpMvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vUT3HFWZ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d845b2ae-a231-4bd0-a3f2-b70f14b395ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755632127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsbBGhhrkpG4xAg6uyGXhWitoB1z4NFYvdixmUzIsl4=;
	b=vUT3HFWZkleaFCMJxU3g4c5NgaB4mzareXSycZIzGf9bmRhabOVAxWfomDGshRJtycmDnb
	KEHUEap81OuYIuY8p5nbqJ6oApkUV/Mm+ykW6jh34rKMkrhE40CYZIcj5+ZmMdR03Qp1LE
	v3H36mVCPSH7jWGsvwwWxvUij15S5Y0=
Date: Tue, 19 Aug 2025 12:34:53 -0700
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
 <647eb60a-c8f2-4ad3-ad98-b49b6e713402@oracle.com>
 <3dcf7a0d-4a65-43d9-8fe8-34c7e0e20d62@linux.dev>
 <5a926464-62bf-40b2-8ca4-a7669298a8ea@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <5a926464-62bf-40b2-8ca4-a7669298a8ea@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/5/25 4:24 AM, Alan Maguire wrote:
> On 01/08/2025 21:51, Ihor Solodrai wrote:
>> On 7/31/25 11:57 AM, Alan Maguire wrote:
>>> On 31/07/2025 15:16, Alan Maguire wrote:
>>>> On 29/07/2025 03:03, Ihor Solodrai wrote:
>>>>> btf_encoder collects function ELF symbols into a table, which is later
>>>>> used for processing DWARF data and determining whether a function can
>>>>> be added to BTF.
>>>>>
>>>>> So far the ELF symbol name was used as a key for search in this table,
>>>>> and a search by prefix match was attempted in cases when ELF symbol
>>>>> name has a compiler-generated suffix.
>>>>>
>>>>> This implementation has bugs [1][2], causing some functions to be
>>>>> inappropriately excluded from (or included into) BTF.
>>>>>
>>>>> Rework the implementation of the ELF functions table. Use a name of a
>>>>> function without any suffix - symbol name before the first occurrence
>>>>> of '.' - as a key. This way btf_encoder__find_function() always
>>>>> returns a valid elf_function object (or NULL).
>>>>>
>>>>> Collect an array of symbol name + address pairs from GElf_Sym for each
>>>>> elf_function when building the elf_functions table.
>>>>>
>>>>> Introduce ambiguous_addr flag to the btf_encoder_func_state. It is set
>>>>> when the function is saved by examining the array of ELF symbols in
>>>>> elf_function__has_ambiguous_address(). It tests whether there is only
>>>>> one unique address for this function name, taking into account that
>>>>> some addresses associated with it are not relevant:
>>>>>     * ".cold" suffix indicates a piece of hot/cold split
>>>>>     * ".part" suffix indicates a piece of partial inline
>>>>>
>>>>> When inspecting symbol name we have to search for any occurrence of
>>>>> the target suffix, as opposed to testing the entire suffix, or the end
>>>>> of a string. This is because suffixes may be combined by the compiler,
>>>>> for example producing ".isra0.cold", and the conclusion will be
>>>>> incorrect.
>>>>>
>>>>> In saved_functions_combine() check ambiguous_addr when deciding
>>>>> whether a function should be included in BTF.
>>>>>
>>>>> Successful CI run: https://github.com/acmel/dwarves/pull/68/checks
>>>>>
>>>>> I manually spot checked some of the ~200 functions from vmlinux (BPF
>>>>> CI-like kconfig) that are now excluded: all of those that I checked
>>>>> had multiple addresses, and some where static functions from different
>>>>> files with the same name.
>>>>>
>>>>> [1] https://lore.kernel.org/bpf/2f8c792e-9675-4385-
>>>>> b1cb-10266c72bd45@linux.dev/
>>>>> [2] https://lore.kernel.org/
>>>>> dwarves/6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev/
>>>>>
>>>>> v1: https://lore.kernel.org/
>>>>> dwarves/98f41eaf6dd364745013650d58c5f254a592221c@linux.dev/
>>>>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>>>>
>>>> Thanks for doing this Ihor! Apologies for just thinking of this now, but
>>>> why don't we filter out the .cold and .part functions earlier, not even
>>>> adding them to the ELF functions list? Something like this on top of
>>>> your patch:
>>>>
>>>> $ git diff
>>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>>> index 0aa94ae..f61db0f 100644
>>>> --- a/btf_encoder.c
>>>> +++ b/btf_encoder.c
>>>> @@ -1188,27 +1188,6 @@ static struct btf_encoder_func_state
>>>> *btf_encoder__alloc_func_state(struct btf_e
>>>>           return state;
>>>>    }
>>>>
>>>> -/* some "." suffixes do not correspond to real functions;
>>>> - * - .part for partial inline
>>>> - * - .cold for rarely-used codepath extracted for better code locality
>>>> - */
>>>> -static bool str_contains_non_fn_suffix(const char *str) {
>>>> -       static const char *skip[] = {
>>>> -               ".cold",
>>>> -               ".part"
>>>> -       };
>>>> -       char *suffix = strchr(str, '.');
>>>> -       int i;
>>>> -
>>>> -       if (!suffix)
>>>> -               return false;
>>>> -       for (i = 0; i < ARRAY_SIZE(skip); i++) {
>>>> -               if (strstr(suffix, skip[i]))
>>>> -                       return true;
>>>> -       }
>>>> -       return false;
>>>> -}
>>>> -
>>>>    static bool elf_function__has_ambiguous_address(struct elf_function
>>>> *func) {
>>>>           struct elf_function_sym *sym;
>>>>           uint64_t addr;
>>>> @@ -1219,12 +1198,10 @@ static bool
>>>> elf_function__has_ambiguous_address(struct elf_function *func) {
>>>>           addr = 0;
>>>>           for (int i = 0; i < func->sym_cnt; i++) {
>>>>                   sym = &func->syms[i];
>>>> -               if (!str_contains_non_fn_suffix(sym->name)) {
>>>> -                       if (addr && addr != sym->addr)
>>>> -                               return true;
>>>> -                       else
>>>> +               if (addr && addr != sym->addr)
>>>> +                       return true;
>>>> +               else
>>>>                                   addr = sym->addr;
>>>> -               }
>>>>           }
>>>>
>>>>
>>>>           return false;
>>>> @@ -2208,9 +2185,12 @@ static int elf_functions__collect(struct
>>>> elf_functions *functions)
>>>>                   func = &functions->entries[functions->cnt];
>>>>
>>>>                   suffix = strchr(sym_name, '.');
>>>> -               if (suffix)
>>>> +               if (suffix) {
>>>> +                       if (strstr(suffix, ".part") ||
>>>> +                           strstr(suffix, ".cold"))
>>>> +                               continue;
>>>>                           func->name = strndup(sym_name, suffix -
>>>> sym_name);
>>>> -               else
>>>> +               } else
>>>>                           func->name = strdup(sym_name);
>>>>
>>>>                   if (!func->name) {
>>>>
>>>> I think that would work and saves later string comparisons, what do you
>>>> think?
>>>>
>>>
>>> Apologies, this isn't sufficient. Considering cases like objpool_free(),
>>> the problem is it has two entries in ELF for objpool_free and
>>> objpool_free.part.0. So let's say we exclude objpool_free.part.0 from
>>> the ELF representation, then we could potentially end up excluding
>>> objpool_free as inconsistent if the DWARF for objpool_free.part.0
>>> doesn't match that of objpool_free. It would appear to be inconsistent
>>> but isn't really.
>>
>> Alan, as far as I can tell, in your example the function would be
>> considered inconsistent independent of whether .part is included in
>> elf_function->syms or not. We determine argument inconsistency based
>> on DWARF data (struct function) passed into btf_encoder__save_func().
>>
>> So if there is a difference in arguments between objpool_free.part.0
>> and objpool_free, it will be detected anyways.
>>
> 
> I think I've solved that in the following proof-of-concept series [1] -
> by retaining the .part functions in the ELF list _and_ matching the
> DWARF and ELF via address we can distinguish between foo and foo.part.0
> debug information and discard the latter such that it is not included in
> the determination of inconsistency.
> 
>> A significant difference between v2 and v3 (just sent [1]) is in that
>> if there is *only* "foo.part.0" symbol but no "foo", then it will not
>> be included in v3 (because it's not in the elf_functions table), but
>> would be in v2 (because there is only one address). And the correct
>> behavior from the BTF encoding point of view is v3.
>>
> 
> Yep, that part sounds good; I _think_ the approach I'm proposing solves
> that too, along with not incorrectly marking foo/foo.part.0 as inconsistent.
> 
> The series is the top 3 commits in [1]; the first commit [2] is yours
> modulo the small tweak of marking non-functions during ELF function
> creation. The second [3] uses address ranges to try harder to get
> address info from DWARF, while the final one [4] skips creating function
> state for functions that we address-match as the .part/.cold functions
> in debug info. This all allows us to better identify debug information
> that is tied to the non-function .part/.cold optimizations.

Hi Alan. Bumping this thread.

I haven't reviewed/tested your github changes thoroughly, but the
approach makes sense to me overall.

What do you think about applying the group-by-name patch [1] first,
maybe including your tweak? It would fix a couple of bugs right away.

And later you can send a more refined draft of patches to use
addresses for matching.

[1] 
https://lore.kernel.org/dwarves/20250801202009.3942492-1-ihor.solodrai@linux.dev/

> 
> 
> [1]
> https://github.com/acmel/dwarves/compare/master...alan-maguire:dwarves:pahole-next-remove-dupaddrs
> [2]
> https://github.com/acmel/dwarves/commit/e256ffaf13cce96c4e782192b2814e1a2664fe99
> [3]
> https://github.com/acmel/dwarves/commit/7cc2c1e21f1daeb29aa270fd9f23ef1ba99fcd4e
> [4]
> https://github.com/acmel/dwarves/commit/893f14c2a854c240a927294996f449a3ad63eaed
>> [1] https://lore.kernel.org/dwarves/20250801202009.3942492-1-
>> ihor.solodrai@linux.dev/
>>
>>
>>>
>>> I think the best thing might be to retain the .part/.cold repesentations
>>> in the ELF table but perhaps mark them with a flag (non_fn for
>>> non-function or similar?) at creation time to avoid expensive string
>>> comparisons later.
>>
>> That's a good point. In v3 I exclude .part and .cold from the table,
>> and store ambiguous_addr flag in elf_function. If anything, we should
>> be doing less string comparisons now.
>>
>>>
>>> On the subject of improving matching, we do have address info for DWARF
>>> functions in many cases like this, and that can help guide DWARF->ELF
>>> mapping. I have a patch that helps collect function address info in
>>> dwarf_loader.c; perhaps we could make use of it in doing more accurate
>>> matching? In the above case for example, we actually have DWARF function
>>> addresses for both objpool_free and objpool_free.part.0 so we could in
>>> that case figure out the DWARF-ELF mapping even though there are
>>> multiple ELF addresses and multiple DWARF representations.
>>>
>>> Haven't thought it through fully to be honest, but I think we want to
>>> avoid edge cases like the above where we either label a function as
>>> inconsistent or ambiguous unnecessarily. I'll try to come up with a
>>> rough proof-of-concept that weaves address-based matching into the
>>> approach you have here, since what you've done is a huge improvement.
>>> Again sorry for the noise here, I struggle to think through all the
>>> permutations we have to consider here to be honest.
>>>
>>> Thanks!
>>>
>>> Alan
>>>
>>>
>>> [...]
>>>
>>
>>
> 


