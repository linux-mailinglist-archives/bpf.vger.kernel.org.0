Return-Path: <bpf+bounces-13620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5AE7DC023
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 19:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17AC0B20E61
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 18:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12701199D0;
	Mon, 30 Oct 2023 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jVn+Ywkj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940BC19BAD
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 18:57:20 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C139D9
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 11:57:17 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UIuW6a023158;
	Mon, 30 Oct 2023 18:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=RQhcWmUBgZ1fKnY5Lo6A5MlrOXzHBKg/fL6GdR0+SBk=;
 b=jVn+YwkjyRS6HwNCEq5o60tHJ2UMmq7uecEg155nzqSOhZniwvLkxrYGxbzaloiQ73QO
 JNoPDpZHfpw0Eua5gqIBk7xoLnmGQHsKweC/JLxXhzEjdYBKHNctNhX9EK4UV0bQGbzv
 yHJRNMJ/ZrFiXzXGIxZbIJlfTQX45LZUDbueGJEjFttNXcKgBCwu0PQJKvXRxp5LhVVC
 JwGC4oJrrTiLuAEC/WuwcvrWQxoBzRAVkCOt6A91ap62WTHcJrauKj6DBgf0uc3fXVSJ
 zMQ23xwJOIbP38460lrSuPBOG4qFOr7UJqYBxcRK4/98ouBjAIUffm18ZXJkUT4u2Rev AA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2j6wg066-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Oct 2023 18:56:55 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39UIkip5000597;
	Mon, 30 Oct 2023 18:56:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1cmsufq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Oct 2023 18:56:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39UIuqJO16712364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Oct 2023 18:56:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F5D320049;
	Mon, 30 Oct 2023 18:56:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAFFF20040;
	Mon, 30 Oct 2023 18:56:49 +0000 (GMT)
Received: from [9.43.76.45] (unknown [9.43.76.45])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Oct 2023 18:56:49 +0000 (GMT)
Message-ID: <31da5cb9-b0fa-5561-0cce-db53477d4470@linux.ibm.com>
Date: Tue, 31 Oct 2023 00:26:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 1/5] powerpc/code-patching: introduce
 patch_instructions()
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
References: <20231020141358.643575-1-hbathini@linux.ibm.com>
 <20231020141358.643575-2-hbathini@linux.ibm.com>
 <87fs1s9sc2.fsf@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <87fs1s9sc2.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fYGO71rcWuXIS2uHwHc0WUxLNIcnTRfu
X-Proofpoint-ORIG-GUID: fYGO71rcWuXIS2uHwHc0WUxLNIcnTRfu
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300148

Hi Aneesh,

On 30/10/23 6:32 pm, Aneesh Kumar K.V wrote:
> Hari Bathini <hbathini@linux.ibm.com> writes:
> 
>> patch_instruction() entails setting up pte, patching the instruction,
>> clearing the pte and flushing the tlb. If multiple instructions need
>> to be patched, every instruction would have to go through the above
>> drill unnecessarily. Instead, introduce patch_instructions() function
>> that sets up the pte, clears the pte and flushes the tlb only once
>> per page range of instructions to be patched. Duplicate most of the
>> patch_instruction() code instead of merging with it, to avoid the
>> performance degradation observed on ppc32, for patch_instruction(),
>> with the code path merged. Also, setup poking_init() always as BPF
>> expects poking_init() to be setup even when STRICT_KERNEL_RWX is off.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> Acked-by: Song Liu <song@kernel.org>
>>
> 
> A lot of this is duplicate of patch_instruction(). Can we consolidate
> thing between them?

True. The code was consolidated till v5 but had to duplicate most of it
to avoid performance degradation reported on ppc32:

 
https://lore.kernel.org/all/6cceb564-8b52-4d98-9118-92a914f4871e@csgroup.eu/

> 
>> ---
>>
>> Changes in v7:
>> * Fixed crash observed with !STRICT_RWX.
>>
>>
>>   arch/powerpc/include/asm/code-patching.h |   1 +
>>   arch/powerpc/lib/code-patching.c         | 141 ++++++++++++++++++++++-
>>   2 files changed, 139 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
>> index 3f881548fb61..0e29ccf903d0 100644
>> --- a/arch/powerpc/include/asm/code-patching.h
>> +++ b/arch/powerpc/include/asm/code-patching.h
>> @@ -74,6 +74,7 @@ int create_cond_branch(ppc_inst_t *instr, const u32 *addr,
>>   int patch_branch(u32 *addr, unsigned long target, int flags);
>>   int patch_instruction(u32 *addr, ppc_inst_t instr);
>>   int raw_patch_instruction(u32 *addr, ppc_inst_t instr);
>> +int patch_instructions(u32 *addr, u32 *code, size_t len, bool repeat_instr);
>>   
>>   static inline unsigned long patch_site_addr(s32 *site)
>>   {
>> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
>> index b00112d7ad46..e1c1fd9246d8 100644
>> --- a/arch/powerpc/lib/code-patching.c
>> +++ b/arch/powerpc/lib/code-patching.c
>> @@ -204,9 +204,6 @@ void __init poking_init(void)
>>   {
>>   	int ret;
>>   
>> -	if (!IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
>> -		return;
>> -
>>   	if (mm_patch_enabled())
>>   		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>>   					"powerpc/text_poke_mm:online",
>> @@ -378,6 +375,144 @@ int patch_instruction(u32 *addr, ppc_inst_t instr)
>>   }
>>   NOKPROBE_SYMBOL(patch_instruction);
>>   
>> +static int __patch_instructions(u32 *patch_addr, u32 *code, size_t len, bool repeat_instr)
>> +{
>> +	unsigned long start = (unsigned long)patch_addr;
>> +
>> +	/* Repeat instruction */
>> +	if (repeat_instr) {
>> +		ppc_inst_t instr = ppc_inst_read(code);
>> +
>> +		if (ppc_inst_prefixed(instr)) {
>> +			u64 val = ppc_inst_as_ulong(instr);
>> +
>> +			memset64((u64 *)patch_addr, val, len / 8);
>> +		} else {
>> +			u32 val = ppc_inst_val(instr);
>> +
>> +			memset32(patch_addr, val, len / 4);
>> +		}
>> +	} else {
>> +		memcpy(patch_addr, code, len);
>> +	}
>> +
>> +	smp_wmb();	/* smp write barrier */
>> +	flush_icache_range(start, start + len);
>> +	return 0;
>> +}
>> +
>> +/*
>> + * A page is mapped and instructions that fit the page are patched.
>> + * Assumes 'len' to be (PAGE_SIZE - offset_in_page(addr)) or below.
>> + */
>> +static int __do_patch_instructions_mm(u32 *addr, u32 *code, size_t len, bool repeat_instr)
>> +{
>> +	struct mm_struct *patching_mm, *orig_mm;
>> +	unsigned long pfn = get_patch_pfn(addr);
>> +	unsigned long text_poke_addr;
>> +	spinlock_t *ptl;
>> +	u32 *patch_addr;
>> +	pte_t *pte;
>> +	int err;
>> +
>> +	patching_mm = __this_cpu_read(cpu_patching_context.mm);
>> +	text_poke_addr = __this_cpu_read(cpu_patching_context.addr);
>> +	patch_addr = (u32 *)(text_poke_addr + offset_in_page(addr));
>> +
>> +	pte = get_locked_pte(patching_mm, text_poke_addr, &ptl);
>> +	if (!pte)
>> +		return -ENOMEM;
>> +
>> +	__set_pte_at(patching_mm, text_poke_addr, pte, pfn_pte(pfn, PAGE_KERNEL), 0);
>> +
>> +	/* order PTE update before use, also serves as the hwsync */
>> +	asm volatile("ptesync" ::: "memory");
>> +
>> +	/* order context switch after arbitrary prior code */
>> +	isync();
>> +
>> +	orig_mm = start_using_temp_mm(patching_mm);
>> +
>> +	err = __patch_instructions(patch_addr, code, len, repeat_instr);
>> +
>> +	/* context synchronisation performed by __patch_instructions */
>> +	stop_using_temp_mm(patching_mm, orig_mm);
>> +
>> +	pte_clear(patching_mm, text_poke_addr, pte);
>> +	/*
>> +	 * ptesync to order PTE update before TLB invalidation done
>> +	 * by radix__local_flush_tlb_page_psize (in _tlbiel_va)
>> +	 */
>> +	local_flush_tlb_page_psize(patching_mm, text_poke_addr, mmu_virtual_psize);
>> +
>> +	pte_unmap_unlock(pte, ptl);
>> +
>> +	return err;
>> +}
>> +
>> +/*
>> + * A page is mapped and instructions that fit the page are patched.
>> + * Assumes 'len' to be (PAGE_SIZE - offset_in_page(addr)) or below.
>> + */
>> +static int __do_patch_instructions(u32 *addr, u32 *code, size_t len, bool repeat_instr)
>> +{
>> +	unsigned long pfn = get_patch_pfn(addr);
>> +	unsigned long text_poke_addr;
>> +	u32 *patch_addr;
>> +	pte_t *pte;
>> +	int err;
>> +
>> +	text_poke_addr = (unsigned long)__this_cpu_read(cpu_patching_context.addr) & PAGE_MASK;
>> +	patch_addr = (u32 *)(text_poke_addr + offset_in_page(addr));
>> +
>> +	pte = __this_cpu_read(cpu_patching_context.pte);
>> +	__set_pte_at(&init_mm, text_poke_addr, pte, pfn_pte(pfn, PAGE_KERNEL), 0);
>> +	/* See ptesync comment in radix__set_pte_at() */
>> +	if (radix_enabled())
>> +		asm volatile("ptesync" ::: "memory");
>> +
>> +	err = __patch_instructions(patch_addr, code, len, repeat_instr);
>> +
>> +	pte_clear(&init_mm, text_poke_addr, pte);
>> +	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
>> +
>> +	return err;
>> +}
>> +
>> +/*
>> + * Patch 'addr' with 'len' bytes of instructions from 'code'.
>> + *
>> + * If repeat_instr is true, the same instruction is filled for
>> + * 'len' bytes.
>> + */
>> +int patch_instructions(u32 *addr, u32 *code, size_t len, bool repeat_instr)
>> +{
> 
> Will this break with prefix instructions?

No, afaics.. unless, the caller fails to setup the code buffer
appropriately..

Thanks
Hari

