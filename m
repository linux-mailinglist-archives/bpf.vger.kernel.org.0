Return-Path: <bpf+bounces-13601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C26787DBA3E
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 14:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC3D1C20AD2
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 13:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5A315EAC;
	Mon, 30 Oct 2023 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ThTZIsHZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4183239
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 13:05:34 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD7CDB
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 06:05:33 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UD546s019958;
	Mon, 30 Oct 2023 13:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=Mv7V1/wZDcRfKeGYpc1zOMBeoaDUbt7wnukJNS11wEs=;
 b=ThTZIsHZuc5ZYaDMkeXgJ7xkjMH3yJPlknN2Q+7B8093bFPbJxO+jQMLZJOAI6imTEDO
 dfqlsFor/crPy1n940zPJ7H0Bdif5pKljbszVAo+2e3FHWqSImEgGzT1lKnIhyraJfTK
 39dIFW8mCVlng2EWxrSBKK8UJyHGH17LHwiCDU57y1YVt/rDiaatNjXOJCMVfNml4J7e
 nJ7hL7NUhsIIp0roz9GoAzczG+pFf5QoLc4T5KIYSi8yQqY8CejXkewZlxTegGS519h9
 zw+XwZOL36fw9XbXGtfVrjLa47jTZOeXmJlTu4fuBcsv9BUL9fojUCQaY2QfLxwzbIdv iA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2cnygnhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Oct 2023 13:05:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39UAWbA9011291;
	Mon, 30 Oct 2023 13:02:12 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1eujrqu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Oct 2023 13:02:12 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39UD2Bhe11141624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Oct 2023 13:02:12 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5CDB58061;
	Mon, 30 Oct 2023 13:02:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D0E558058;
	Mon, 30 Oct 2023 13:02:08 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.51.133])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Oct 2023 13:02:07 +0000 (GMT)
X-Mailer: emacs 29.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH v7 1/5] powerpc/code-patching: introduce
 patch_instructions()
In-Reply-To: <20231020141358.643575-2-hbathini@linux.ibm.com>
References: <20231020141358.643575-1-hbathini@linux.ibm.com>
 <20231020141358.643575-2-hbathini@linux.ibm.com>
Date: Mon, 30 Oct 2023 18:32:05 +0530
Message-ID: <87fs1s9sc2.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5aIB13ZF00NpxabvCFb0CZ05YJiRXTMj
X-Proofpoint-GUID: 5aIB13ZF00NpxabvCFb0CZ05YJiRXTMj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=729 phishscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300100

Hari Bathini <hbathini@linux.ibm.com> writes:

> patch_instruction() entails setting up pte, patching the instruction,
> clearing the pte and flushing the tlb. If multiple instructions need
> to be patched, every instruction would have to go through the above
> drill unnecessarily. Instead, introduce patch_instructions() function
> that sets up the pte, clears the pte and flushes the tlb only once
> per page range of instructions to be patched. Duplicate most of the
> patch_instruction() code instead of merging with it, to avoid the
> performance degradation observed on ppc32, for patch_instruction(),
> with the code path merged. Also, setup poking_init() always as BPF
> expects poking_init() to be setup even when STRICT_KERNEL_RWX is off.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Acked-by: Song Liu <song@kernel.org>
>

A lot of this is duplicate of patch_instruction(). Can we consolidate
thing between them? 

> ---
>
> Changes in v7:
> * Fixed crash observed with !STRICT_RWX.
>
>
>  arch/powerpc/include/asm/code-patching.h |   1 +
>  arch/powerpc/lib/code-patching.c         | 141 ++++++++++++++++++++++-
>  2 files changed, 139 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
> index 3f881548fb61..0e29ccf903d0 100644
> --- a/arch/powerpc/include/asm/code-patching.h
> +++ b/arch/powerpc/include/asm/code-patching.h
> @@ -74,6 +74,7 @@ int create_cond_branch(ppc_inst_t *instr, const u32 *addr,
>  int patch_branch(u32 *addr, unsigned long target, int flags);
>  int patch_instruction(u32 *addr, ppc_inst_t instr);
>  int raw_patch_instruction(u32 *addr, ppc_inst_t instr);
> +int patch_instructions(u32 *addr, u32 *code, size_t len, bool repeat_instr);
>  
>  static inline unsigned long patch_site_addr(s32 *site)
>  {
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index b00112d7ad46..e1c1fd9246d8 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -204,9 +204,6 @@ void __init poking_init(void)
>  {
>  	int ret;
>  
> -	if (!IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
> -		return;
> -
>  	if (mm_patch_enabled())
>  		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>  					"powerpc/text_poke_mm:online",
> @@ -378,6 +375,144 @@ int patch_instruction(u32 *addr, ppc_inst_t instr)
>  }
>  NOKPROBE_SYMBOL(patch_instruction);
>  
> +static int __patch_instructions(u32 *patch_addr, u32 *code, size_t len, bool repeat_instr)
> +{
> +	unsigned long start = (unsigned long)patch_addr;
> +
> +	/* Repeat instruction */
> +	if (repeat_instr) {
> +		ppc_inst_t instr = ppc_inst_read(code);
> +
> +		if (ppc_inst_prefixed(instr)) {
> +			u64 val = ppc_inst_as_ulong(instr);
> +
> +			memset64((u64 *)patch_addr, val, len / 8);
> +		} else {
> +			u32 val = ppc_inst_val(instr);
> +
> +			memset32(patch_addr, val, len / 4);
> +		}
> +	} else {
> +		memcpy(patch_addr, code, len);
> +	}
> +
> +	smp_wmb();	/* smp write barrier */
> +	flush_icache_range(start, start + len);
> +	return 0;
> +}
> +
> +/*
> + * A page is mapped and instructions that fit the page are patched.
> + * Assumes 'len' to be (PAGE_SIZE - offset_in_page(addr)) or below.
> + */
> +static int __do_patch_instructions_mm(u32 *addr, u32 *code, size_t len, bool repeat_instr)
> +{
> +	struct mm_struct *patching_mm, *orig_mm;
> +	unsigned long pfn = get_patch_pfn(addr);
> +	unsigned long text_poke_addr;
> +	spinlock_t *ptl;
> +	u32 *patch_addr;
> +	pte_t *pte;
> +	int err;
> +
> +	patching_mm = __this_cpu_read(cpu_patching_context.mm);
> +	text_poke_addr = __this_cpu_read(cpu_patching_context.addr);
> +	patch_addr = (u32 *)(text_poke_addr + offset_in_page(addr));
> +
> +	pte = get_locked_pte(patching_mm, text_poke_addr, &ptl);
> +	if (!pte)
> +		return -ENOMEM;
> +
> +	__set_pte_at(patching_mm, text_poke_addr, pte, pfn_pte(pfn, PAGE_KERNEL), 0);
> +
> +	/* order PTE update before use, also serves as the hwsync */
> +	asm volatile("ptesync" ::: "memory");
> +
> +	/* order context switch after arbitrary prior code */
> +	isync();
> +
> +	orig_mm = start_using_temp_mm(patching_mm);
> +
> +	err = __patch_instructions(patch_addr, code, len, repeat_instr);
> +
> +	/* context synchronisation performed by __patch_instructions */
> +	stop_using_temp_mm(patching_mm, orig_mm);
> +
> +	pte_clear(patching_mm, text_poke_addr, pte);
> +	/*
> +	 * ptesync to order PTE update before TLB invalidation done
> +	 * by radix__local_flush_tlb_page_psize (in _tlbiel_va)
> +	 */
> +	local_flush_tlb_page_psize(patching_mm, text_poke_addr, mmu_virtual_psize);
> +
> +	pte_unmap_unlock(pte, ptl);
> +
> +	return err;
> +}
> +
> +/*
> + * A page is mapped and instructions that fit the page are patched.
> + * Assumes 'len' to be (PAGE_SIZE - offset_in_page(addr)) or below.
> + */
> +static int __do_patch_instructions(u32 *addr, u32 *code, size_t len, bool repeat_instr)
> +{
> +	unsigned long pfn = get_patch_pfn(addr);
> +	unsigned long text_poke_addr;
> +	u32 *patch_addr;
> +	pte_t *pte;
> +	int err;
> +
> +	text_poke_addr = (unsigned long)__this_cpu_read(cpu_patching_context.addr) & PAGE_MASK;
> +	patch_addr = (u32 *)(text_poke_addr + offset_in_page(addr));
> +
> +	pte = __this_cpu_read(cpu_patching_context.pte);
> +	__set_pte_at(&init_mm, text_poke_addr, pte, pfn_pte(pfn, PAGE_KERNEL), 0);
> +	/* See ptesync comment in radix__set_pte_at() */
> +	if (radix_enabled())
> +		asm volatile("ptesync" ::: "memory");
> +
> +	err = __patch_instructions(patch_addr, code, len, repeat_instr);
> +
> +	pte_clear(&init_mm, text_poke_addr, pte);
> +	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
> +
> +	return err;
> +}
> +
> +/*
> + * Patch 'addr' with 'len' bytes of instructions from 'code'.
> + *
> + * If repeat_instr is true, the same instruction is filled for
> + * 'len' bytes.
> + */
> +int patch_instructions(u32 *addr, u32 *code, size_t len, bool repeat_instr)
> +{

Will this break with prefix instructions?

> +	while (len > 0) {
> +		unsigned long flags;
> +		size_t plen;
> +		int err;
> +
> +		plen = min_t(size_t, PAGE_SIZE - offset_in_page(addr), len);
> +
> +		local_irq_save(flags);
> +		if (mm_patch_enabled())
> +			err = __do_patch_instructions_mm(addr, code, plen, repeat_instr);
> +		else
> +			err = __do_patch_instructions(addr, code, plen, repeat_instr);
> +		local_irq_restore(flags);
> +		if (err)
> +			return err;
> +
> +		len -= plen;
> +		addr = (u32 *)((unsigned long)addr + plen);
> +		if (!repeat_instr)
> +			code = (u32 *)((unsigned long)code + plen);
> +	}
> +
> +	return 0;
> +}
> +NOKPROBE_SYMBOL(patch_instructions);
> +
>  int patch_branch(u32 *addr, unsigned long target, int flags)
>  {
>  	ppc_inst_t instr;
> -- 
> 2.41.0

