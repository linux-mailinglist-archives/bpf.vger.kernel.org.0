Return-Path: <bpf+bounces-62803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E83E5AFEC95
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 16:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B715A645F20
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CD423770D;
	Wed,  9 Jul 2025 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IABsicUG"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9BE1DFE1
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072700; cv=none; b=m9v/ozK4fs9Mzb9Fj8cZKMyXkyOL9h/uUnLgUQuX92uxE6lKsXwzfCrLgKaBDTwHHzEHytGpUyyY/1BCZIxMTZcvjak4rEYWYxx70HfeC+Z4lKirPpdYT8uqKdiQp50NbdDUDY+oMqu8z0j4ZJMuK4tNk8Wsu15bZJaXzgpLipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072700; c=relaxed/simple;
	bh=7xzZbb2pWhDbw+dr0bvi+orlGxum+QL5cDmbAyVdpkE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=obwxaLhyol3P8/AaDN/8BSoetgY/zfQaTpBNA2Mu0yHcUDr99U/urthlHKEw3oBTuOzF4q6LNdauljIYweXwISEalhMp03DVeMZ6/281xsJ0AYNreR/+QcC+IosM514veL3hDvZY7cxvbffXaax/X2LqH0FvWn4GTg8xyWkQnEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IABsicUG; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <61597973-dd18-4cd1-ba7c-9b2f8862d86b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752072694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rInWJ0uE7l4cp2pIc+6mzoRHBSbm9pEksvhwSMb3uuw=;
	b=IABsicUGAsRLs0TKl1+Z+qkyKZnJea1IqRKUHeegPNllCWRYNZJRnk2N83PSb9bUOxUb57
	gKXBCzTUb54eD1xsW7fEqDETY5nDo9m5exzWIf5BVx1WHO45LDcdLd6gEtpATj52p3tzam
	CUylbjvXQWVr5OXjI7XHajfVAmwfqXU=
Date: Wed, 9 Jul 2025 07:51:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [External] : Re: Potential BPF Arena Security Vulnerability,
 Possible Memory Access and Overflow Issues
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: Yifei Liu <yifei.l.liu@oracle.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "ast@kernel.org" <ast@kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>
References: <1A9DA34D-7AC9-4A77-A07D-46B4DD0E3136@oracle.com>
 <CAADnVQKDeKmz95rHT4sRX9JhrRiBR06wngVck_cVzmGtDMiK7w@mail.gmail.com>
 <5B89E759-2B80-433F-92AD-9B0CB16C2308@oracle.com>
 <CAADnVQ+NOs9hJW=hFeAtOmtNdQ_CT6zdMu1FnhM3xKD-oYiKZA@mail.gmail.com>
 <d243e84a-8ca6-4f32-854f-8d4e709277f5@linux.dev>
 <7AF83153-6D89-4B98-9BF6-1BBE9CF05772@oracle.com>
 <F9AF01BC-EE27-4BA8-ACEF-A77EBEA87549@oracle.com>
 <78feeb4e-be58-4e02-ae08-119003b1b494@linux.dev>
In-Reply-To: <78feeb4e-be58-4e02-ae08-119003b1b494@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/8/25 10:39 PM, Yonghong Song wrote:
>
>
> On 7/8/25 1:56 PM, Yifei Liu wrote:
>>
>>> On Jul 8, 2025, at 1:46 PM, yifei.l.liu@oracle.com wrote:
>>>
>>>
>>>
>>>> On Jul 8, 2025, at 12:53 PM, Yonghong Song 
>>>> <yonghong.song@linux.dev> wrote:
>>>>
>>>>
>>>>
>>>> On 7/7/25 4:06 PM, Alexei Starovoitov wrote:
>>>>> On Mon, Jul 7, 2025 at 2:43 PM Yifei Liu <yifei.l.liu@oracle.com> 
>>>>> wrote:
>>>>>>
>>>>>>> On Jul 7, 2025, at 2:19 PM, Alexei Starovoitov 
>>>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>>
>>>>>>> On Mon, Jul 7, 2025 at 1:44 PM Yifei Liu 
>>>>>>> <yifei.l.liu@oracle.com> wrote:
>>>>>>>> Hi Alexei,
>>>>>>>>
>>>>>>>> I recently noticed that the verifier_arena_large selftest would 
>>>>>>>> fail on the overflow and underflow section for 64k page size 
>>>>>>>> kernels. After a deeper investigation, the similar issue is 
>>>>>>>> also reproducible on 4k page size over both x86 and aarch64 
>>>>>>>> platforms.
>>>>>>>>
>>>>>>>> The root reason of this failure looks to be a failed or missing 
>>>>>>>> check of the pointer upper 32-bit from the user space. User 
>>>>>>>> space could access the arena space value even the pointer is 
>>>>>>>> not in the assigned user space pointer range. For example, if 
>>>>>>>> the user_vm_start is 7f7d26200000 and arena size is 4G (end 
>>>>>>>> upper bound is 7f7e26200000), when I set *(7f7e26200000 - 
>>>>>>>> 65536) = 20, I could also get the value of (7f7d26200000 - 
>>>>>>>> 65536) as 20. It should be 0 if that is out of the range.
>>>>>>>>
>>>>>>>> Could you please take a look at this issue? Or could you please 
>>>>>>>> point me where is the place doing the address translation and I 
>>>>>>>> could try to provide a patch for this?
>>>>>>>>
>>>>>>>> Thank you very much.
>>>>>>>> Yifei
>>>>>>>>
>>>>>>>> Methods on reproduce:
>>>>>>>> 1. Use a 64k page size arm based kernel and run 
>>>>>>>> verifier_arena_large selftest, it would failed on return 12 and 
>>>>>>>> 13. Or
>>>>>>> Are you sure you're running the latest kernel ?
>>>>>>> This sounds like issue fixed in commit 517e8a7835e8 ("bpf: Fix
>>>>>>> softlockup in arena_map_free on 64k page kernel”)
>>>>>> Thanks for the reply. I do check this fix and it is not related 
>>>>>> to the one I mentioned above. It just fix the guard
>>>>>> range so that it would not set the start address without page 
>>>>>> alignment.
>>>>>>
>>>>>>> In general this is not a security vulnerability in any way.
>>>>>>> 32-bit wraparound is there by design.
>>>>>> If we do not check the upper 32-bit value, it would be wide open 
>>>>>> for user-space to access the arena space.
>>>>>> And maybe even the user-space process cannot access the memory 
>>>>>> outside the 4G area because it would
>>>>>> try to translate all the pointers to that area.
>>>>> No idea what you're trying to say.
>>>>>
>>>>>> Plus, it would consistently fail the verifier_arena_large 
>>>>>> selftest for 64k page size kernels. Maybe we want to
>>>>>> skip some of the overflow/underflow tests if the page size is 64k?
>>>> I tried on my aarch64 machine which has 64K page size. The 
>>>> verifier_arena_large works fine for
>>>> me with either gcc11 or clang21. Could you give more details 
>>>> (traces) about the failure you observed?
>>> Sure, I paste a detailed output below.
>>>
>>> # ./test_progs -vv -t verifier_arena_large
>>> bpf_testmod.ko is already unloaded.
>>> Loading bpf_testmod.ko...
>>> Successfully loaded bpf_testmod.ko.
>>> tester_init:PASS:tester_log_buf 0 nsec
>>> libbpf: loading object 'verifier_arena_large' from buffer
>>> libbpf: elf: section(2) .symtab, size 192, link 1, flags 0, type=2
>>> libbpf: elf: section(3) syscall, size 760, link 0, flags 6, type=1
>>> libbpf: sec 'syscall': found program 'big_alloc1' at insn offset 0 
>>> (0 bytes), code size 95 insns (760 bytes)
>>> libbpf: elf: section(4) .maps, size 24, link 0, flags 3, type=1
>>> libbpf: elf: section(5) license, size 4, link 0, flags 3, type=1
>>> libbpf: license of verifier_arena_large is GPL
>>> libbpf: elf: section(6) .relsyscall, size 160, link 2, flags 40, type=9
>>> libbpf: elf: section(7) .BTF, size 1624, link 0, flags 0, type=1
>>> libbpf: elf: section(8) .BTF.ext, size 672, link 0, flags 0, type=1
>>> libbpf: looking for externs among 8 symbols...
>>> libbpf: collected 2 externs total
>>> libbpf: extern (ksym) #0: symbol 5, name bpf_arena_alloc_pages
>>> libbpf: extern (ksym) #1: symbol 6, name bpf_arena_free_pages
>>> libbpf: map 'arena': at sec_idx 4, offset 0.
>>> libbpf: map 'arena': found type = 33.
>>> libbpf: map 'arena': found max_entries = 65536.
>>> libbpf: map 'arena': found map_flags = 0x400.
>>> libbpf: sec '.relsyscall': collecting relocation for section(3) 
>>> 'syscall'
>>> libbpf: sec '.relsyscall': relo #0: insn #1 against 'arena'
>>> libbpf: prog 'big_alloc1': found map 0 (arena, sec 4, off 0) for 
>>> insn #1
>>> libbpf: sec '.relsyscall': relo #1: insn #7 against 
>>> 'bpf_arena_alloc_pages'
>>> libbpf: prog 'big_alloc1': found extern #0 'bpf_arena_alloc_pages' 
>>> (sym 5) for insn #7
>>> libbpf: sec '.relsyscall': relo #2: insn #17 against 'arena'
>>> libbpf: prog 'big_alloc1': found map 0 (arena, sec 4, off 0) for 
>>> insn #17
>>> libbpf: sec '.relsyscall': relo #3: insn #22 against 
>>> 'bpf_arena_alloc_pages'
>>> libbpf: prog 'big_alloc1': found extern #0 'bpf_arena_alloc_pages' 
>>> (sym 5) for insn #22
>>> libbpf: sec '.relsyscall': relo #4: insn #32 against 'arena'
>>> libbpf: prog 'big_alloc1': found map 0 (arena, sec 4, off 0) for 
>>> insn #32
>>> libbpf: sec '.relsyscall': relo #5: insn #37 against 
>>> 'bpf_arena_alloc_pages'
>>> libbpf: prog 'big_alloc1': found extern #0 'bpf_arena_alloc_pages' 
>>> (sym 5) for insn #37
>>> libbpf: sec '.relsyscall': relo #6: insn #46 against 'arena'
>>> libbpf: prog 'big_alloc1': found map 0 (arena, sec 4, off 0) for 
>>> insn #46
>>> libbpf: sec '.relsyscall': relo #7: insn #50 against 
>>> 'bpf_arena_free_pages'
>>> libbpf: prog 'big_alloc1': found extern #1 'bpf_arena_free_pages' 
>>> (sym 6) for insn #50
>>> libbpf: sec '.relsyscall': relo #8: insn #57 against 'arena'
>>> libbpf: prog 'big_alloc1': found map 0 (arena, sec 4, off 0) for 
>>> insn #57
>>> libbpf: sec '.relsyscall': relo #9: insn #63 against 
>>> 'bpf_arena_alloc_pages'
>>> libbpf: prog 'big_alloc1': found extern #0 'bpf_arena_alloc_pages' 
>>> (sym 5) for insn #63
>>> process_subtest:PASS:obj_open_mem 0 nsec
>>> process_subtest:PASS:specs_alloc 0 nsec
>>> libbpf: loading object 'verifier_arena_large' from buffer
>>> libbpf: elf: section(2) .symtab, size 192, link 1, flags 0, type=2
>>> libbpf: elf: section(3) syscall, size 760, link 0, flags 6, type=1
>>> libbpf: sec 'syscall': found program 'big_alloc1' at insn offset 0 
>>> (0 bytes), code size 95 insns (760 bytes)
>>> libbpf: elf: section(4) .maps, size 24, link 0, flags 3, type=1
>>> libbpf: elf: section(5) license, size 4, link 0, flags 3, type=1
>>> libbpf: license of verifier_arena_large is GPL
>>> libbpf: elf: section(6) .relsyscall, size 160, link 2, flags 40, type=9
>>> libbpf: elf: section(7) .BTF, size 1624, link 0, flags 0, type=1
>>> libbpf: elf: section(8) .BTF.ext, size 672, link 0, flags 0, type=1
>>> libbpf: looking for externs among 8 symbols...
>>> libbpf: collected 2 externs total
>>> libbpf: extern (ksym) #0: symbol 5, name bpf_arena_alloc_pages
>>> libbpf: extern (ksym) #1: symbol 6, name bpf_arena_free_pages
>>> libbpf: map 'arena': at sec_idx 4, offset 0.
>>> libbpf: map 'arena': found type = 33.
>>> libbpf: map 'arena': found max_entries = 65536.
>>> libbpf: map 'arena': found map_flags = 0x400.
>>> libbpf: sec '.relsyscall': collecting relocation for section(3) 
>>> 'syscall'
>>> libbpf: sec '.relsyscall': relo #0: insn #1 against 'arena'
>>> libbpf: prog 'big_alloc1': found map 0 (arena, sec 4, off 0) for 
>>> insn #1
>>> libbpf: sec '.relsyscall': relo #1: insn #7 against 
>>> 'bpf_arena_alloc_pages'
>>> libbpf: prog 'big_alloc1': found extern #0 'bpf_arena_alloc_pages' 
>>> (sym 5) for insn #7
>>> libbpf: sec '.relsyscall': relo #2: insn #17 against 'arena'
>>> libbpf: prog 'big_alloc1': found map 0 (arena, sec 4, off 0) for 
>>> insn #17
>>> libbpf: sec '.relsyscall': relo #3: insn #22 against 
>>> 'bpf_arena_alloc_pages'
>>> libbpf: prog 'big_alloc1': found extern #0 'bpf_arena_alloc_pages' 
>>> (sym 5) for insn #22
>>> libbpf: sec '.relsyscall': relo #4: insn #32 against 'arena'
>>> libbpf: prog 'big_alloc1': found map 0 (arena, sec 4, off 0) for 
>>> insn #32
>>> libbpf: sec '.relsyscall': relo #5: insn #37 against 
>>> 'bpf_arena_alloc_pages'
>>> libbpf: prog 'big_alloc1': found extern #0 'bpf_arena_alloc_pages' 
>>> (sym 5) for insn #37
>>> libbpf: sec '.relsyscall': relo #6: insn #46 against 'arena'
>>> libbpf: prog 'big_alloc1': found map 0 (arena, sec 4, off 0) for 
>>> insn #46
>>> libbpf: sec '.relsyscall': relo #7: insn #50 against 
>>> 'bpf_arena_free_pages'
>>> libbpf: prog 'big_alloc1': found extern #1 'bpf_arena_free_pages' 
>>> (sym 6) for insn #50
>>> libbpf: sec '.relsyscall': relo #8: insn #57 against 'arena'
>>> libbpf: prog 'big_alloc1': found map 0 (arena, sec 4, off 0) for 
>>> insn #57
>>> libbpf: sec '.relsyscall': relo #9: insn #63 against 
>>> 'bpf_arena_alloc_pages'
>>> libbpf: prog 'big_alloc1': found extern #0 'bpf_arena_alloc_pages' 
>>> (sym 5) for insn #63
>>> run_subtest:PASS:obj_open_mem 0 nsec
>>> libbpf: object 'verifier_arena_': failed (-95) to create BPF token 
>>> from '/sys/fs/bpf', skipping optional step...
>>> libbpf: loaded kernel BTF from '/sys/kernel/btf/vmlinux'
>>> libbpf: extern (func ksym) 'bpf_arena_alloc_pages': resolved to 
>>> vmlinux [136281]
>>> libbpf: extern (func ksym) 'bpf_arena_free_pages': resolved to 
>>> vmlinux [136283]
>>> libbpf: map 'arena': created successfully, fd=5
>>> run_subtest:PASS:unexpected_load_failure 0 nsec
>>> VERIFIER LOG:
>>> =============
>>> processed 105 insns (limit 1000000) max_states_per_insn 0 
>>> total_states 8 peak_states 8 mark_read 2
>>> =============
>>> do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
>>> run_subtest:FAIL:1037 Unexpected retval: 12 != 0
>>> #431/1   verifier_arena_large/big_alloc1:FAIL
>>> #431     verifier_arena_large:FAIL
>>> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>>> Successfully unloaded bpf_testmod.ko.
>>>
>>>
>>>>> Skip without full understanding is not a good idea.
>>>>> This test does:
>>>>>         if (*(page1 + PAGE_SIZE) != 0)
>>>>>                 return 11;
>>>>>         if (*(page1 - PAGE_SIZE) != 0)
>>>>>                 return 12;
>>>>>         if (*(page2 + PAGE_SIZE) != 0)
>>>>>                 return 13;
>>>>>         if (*(page2 - PAGE_SIZE) != 0)
>>>>>
>>>>> which gets compiled into bpf insns with positive and negative 
>>>>> 16-bit offsets.
>>>>> When PAGE_SIZE is 64k the code is compiled into some other form,
>>>>> since constant doesn't fit into 'off' field.
>>>>> So the code is not checking what it is supposed to.
>>>>> One way is to use inline asm. Another is to replace PAGE_SIZE
>>>>> with an actual 4k constant in big_alloc1() test.
>> I would believe it is not at the instruction part but at the run 
>> time. For the underflow, I have a simple patch
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c 
>> b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
>> index 6065f862d9643..292dc5712a47e 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
>> @@ -57,7 +57,8 @@ int big_alloc1(void *ctx)
>>                  return 10;
>>          if (*(page1 + PAGE_SIZE) != 0)
>>                  return 11;
>> -       if (*(page1 - PAGE_SIZE) != 0)
>> +       if (*(page1 - ARENA_SIZE -  PAGE_SIZE) != 0)
>>                  return 12;
>> The checked pointer (page1 - ARENA_SIZE -  PAGE_SIZE) is definitely 
>> out of the arena range in user space (page1 is the left boundary of 
>> the arena), but the value of it is not zero and it will get the value 
>> I set for *page2.
>
> I did some investigation. The following is what I am finding.
> First, the following code
>   #define PAGE_CNT 100
>   __u8 __arena * __arena page[PAGE_CNT]; /* occupies the first page */
> tells us the first page is occupied for page[PAGE_CNT].
>
> In big_alloc1(), we have
>         volatile char __arena *page1, *page2, *no_page, *page3;
>         void __arena *base;
>
>         page1 = base = bpf_arena_alloc_pages(&arena, NULL, 1, 
> NUMA_NO_NODE, 0);
>         if (!page1)
>                 return 1;
>         *page1 = 1;
> Here page1 is the second page.
>
> When later on, when we do
>         if (*(page1 - PAGE_SIZE) != 0)
>                 return 12;
> Here 'page1 - PAGE_SIZE' will be equal to the *first* page, i.e., the 
> page
> occupied by page[PAGE_CNT].
>
> So the key thing is about the first byte value in page[PAGE_CNT].
>
> The following is related skeleton header file:
>
> struct verifier_arena_large {
>         struct bpf_object_skeleton *skeleton;
>         struct bpf_object *obj;
>         struct {
>                 struct bpf_map *arena;
>                 struct bpf_map *bss;
>         } maps;
>         struct {
>                 struct bpf_program *big_alloc1;
>                 struct bpf_program *big_alloc2;
>         } progs;
>         struct {
>                 struct bpf_link *big_alloc1;
>                 struct bpf_link *big_alloc2;
>         } links;
>         struct verifier_arena_large__arena {
>                 __u8 *page[100];
>         } *arena;
>         struct verifier_arena_large__bss {
>                 __u8 *base;
>         } *bss;
>
> 'bss' map is an array map. But looks like struct 
> verifier_arena_large__arena
> is not creeating an array map and it relies page fault to allocate 
> memories
> for page[100]. The following is the page fault call stack:
>   ...
>   [  223.787995]  arena_vm_fault+0xc0/0x2a8
>   [  223.787996]  __do_fault+0x48/0xf0
>   [  223.788000]  do_pte_missing+0x3f8/0x1100
>   [  223.788002]  handle_mm_fault+0x4a8/0x7e0
>   [  223.788004]  do_page_fault+0x2cc/0x5f8
>   [  223.788006]  do_translation_fault+0x54/0x78
>   [  223.788008]  do_mem_abort+0x48/0xa0
>   [  223.788010]  el0_da+0x5c/0xb8
>   [  223.788012]  el0t_64_sync_handler+0x84/0x108
>   [  223.788013]  el0t_64_sync+0x198/0x1a0
>
> I have not figured out why the above happen. Probably somewhere triggered
> in libbpf. Did user space does anything with page[100]?

Did some further investigation. The above arena_vm_fault is caused by
libbpf copying init data for page[100] (total 800 bytes) to arena first page.


In my specific case,
   $ llvm-readelf -s verifier_arena_large.bpf.o
   ...
     22: 0000000000000000   800 OBJECT  GLOBAL DEFAULT     8 page
   ...

   $ llvm-readelf -S verifier_arena_large.bpf.o
   ...
     [ 8] .addr_space.1     PROGBITS        0000000000000000 0008a8 000320 00  WA  0   0  8
   ...
   $ llvm-readelf -x 8 verifier_arena_large.bpf.o
                                                                                                                                 
   Hex dump of section '.addr_space.1':
   0x00000000 00000000 00000000 00000000 00000000 ................
   0x00000010 00000000 00000000 00000000 00000000 ................
   ...

 From the above, we can see that the initial value for page[100]
are all zeros and for
	if (*(page1 - PAGE_SIZE) != 0)
		return 12
the if condition will be false.

If I hacked below to modify the first byte of page[100] from 0 to 1:

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index aee36402f0a3..30a7545384f0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5512,6 +5512,8 @@ bpf_object__create_maps(struct bpf_object *obj)
                                         return err;
                                 }
                                 if (obj->arena_data) {
+                                       pr_debug("YHS: copy arena_data, line %d, size %ld\n", __LINE__, obj->arena_data_sz);
+                                       ((char *)obj->arena_data)[0] = 1;
                                         memcpy(map->mmaped, obj->arena_data, obj->arena_data_sz);
                                         zfree(&obj->arena_data);

Then the test will fail as expected.

So the key thing is related to initial value of page[100].
Could you check your verifier_arena_large.bpf.o to see
whether page[100] initial value is 0 or not?
Which compiler did you use?

[...]


