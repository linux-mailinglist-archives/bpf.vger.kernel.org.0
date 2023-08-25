Return-Path: <bpf+bounces-8547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E0E788163
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 10:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7A128176E
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 08:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F59C567D;
	Fri, 25 Aug 2023 07:59:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6501FD3
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 07:59:58 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B3ACF1;
	Fri, 25 Aug 2023 00:59:56 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RXC4Y4q45z1L9Xm;
	Fri, 25 Aug 2023 15:58:21 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 25 Aug 2023 15:59:52 +0800
Message-ID: <adb0634f-701a-76e9-35e6-3a8c2c2fb207@huawei.com>
Date: Fri, 25 Aug 2023 15:59:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf-next v2 2/3] riscv: implement a memset like function
 for text
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>
References: <20230824133135.1176709-1-puranjay12@gmail.com>
 <20230824133135.1176709-3-puranjay12@gmail.com>
CC: <bjorn@kernel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <conor.dooley@microchip.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yhs@fb.com>, <kpsingh@kernel.org>,
	<linux-riscv@lists.infradead.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20230824133135.1176709-3-puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/24 21:31, Puranjay Mohan wrote:
> The BPF JIT needs to write invalid instructions to RX regions of memory
> to invalidate removed BPF programs. This needs a function like memset()
> that can work with RX memory.
> 
> Implement patch_text_set_nosync() which is similar to text_poke_set() of
> x86.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>   arch/riscv/include/asm/patch.h |  1 +
>   arch/riscv/kernel/patch.c      | 74 ++++++++++++++++++++++++++++++++++
>   2 files changed, 75 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
> index 63c98833d510..aa5c1830ea43 100644
> --- a/arch/riscv/include/asm/patch.h
> +++ b/arch/riscv/include/asm/patch.h
> @@ -7,6 +7,7 @@
>   #define _ASM_RISCV_PATCH_H
>   
>   int patch_text_nosync(void *addr, const void *insns, size_t len);
> +int patch_text_set_nosync(void *addr, const int c, size_t len);
>   int patch_text(void *addr, u32 *insns, int ninsns);
>   
>   extern int riscv_patch_in_stop_machine;
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 465b2eebbc37..24d49999ac1a 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -13,6 +13,7 @@
>   #include <asm/fixmap.h>
>   #include <asm/ftrace.h>
>   #include <asm/patch.h>
> +#include <asm/string.h>
>   
>   struct patch_insn {
>   	void *addr;
> @@ -53,6 +54,34 @@ static void patch_unmap(int fixmap)
>   }
>   NOKPROBE_SYMBOL(patch_unmap);
>   
> +static int __patch_insn_set(void *addr, const int c, size_t len)
> +{
> +	void *waddr = addr;
> +	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
> +	int ret;
> +
> +	/*
> +	 * Only two pages can be mapped at a time for writing.
> +	 */
> +	if (len > 2 * PAGE_SIZE)
> +		return -EINVAL;
> +

As a generic part, it better to add text_mutex lock assert.

> +	if (across_pages)
> +		patch_map(addr + PAGE_SIZE, FIX_TEXT_POKE1);
> +
> +	waddr = patch_map(addr, FIX_TEXT_POKE0);
> +
> +	memset(waddr, c, len);
> +
> +	patch_unmap(FIX_TEXT_POKE0);
> +
> +	if (across_pages)
> +		patch_unmap(FIX_TEXT_POKE1);
> +
> +	return 0;
> +}
> +NOKPROBE_SYMBOL(__patch_insn_set);
> +
>   static int __patch_insn_write(void *addr, const void *insn, size_t len)
>   {
>   	void *waddr = addr;
> @@ -95,6 +124,14 @@ static int __patch_insn_write(void *addr, const void *insn, size_t len)
>   }
>   NOKPROBE_SYMBOL(__patch_insn_write);
>   #else
> +static int __patch_insn_set (void *addr, const int c, size_t len)
> +{
> +	memset(addr, c, len);
> +
> +	return 0;
> +}
> +NOKPROBE_SYMBOL(__patch_insn_set);
> +
>   static int __patch_insn_write(void *addr, const void *insn, size_t len)
>   {
>   	return copy_to_kernel_nofault(addr, insn, len);
> @@ -102,6 +139,43 @@ static int __patch_insn_write(void *addr, const void *insn, size_t len)
>   NOKPROBE_SYMBOL(__patch_insn_write);
>   #endif /* CONFIG_MMU */
>   
> +static int patch_insn_set(void *addr, const int c, size_t len)
> +{
> +	size_t patched = 0;
> +	size_t size;
> +	int ret = 0;
> +
> +	/*
> +	 * __patch_insn_set() can only work on 2 pages at a time so call it in a
> +	 * loop with len <= 2 * PAGE_SIZE.
> +	 */
> +	while (patched < len && !ret) {
> +		size = min_t(size_t,
> +			     PAGE_SIZE * 2 - offset_in_page(addr + patched),
> +			     len - patched);
> +		ret = __patch_insn_set(addr + patched, c, size);
> +
> +		patched += size;
> +	}
> +
> +	return ret;
> +}
> +NOKPROBE_SYMBOL(patch_insn_set);
> +
> +int patch_text_set_nosync(void *addr, const int c, size_t len)
> +{
> +	u32 *tp = addr;
> +	int ret;
> +
> +	ret = patch_insn_set(tp, c, len);
> +
> +	if (!ret)
> +		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
> +
> +	return ret;
> +}
> +NOKPROBE_SYMBOL(patch_text_set_nosync);
> +
>   static int patch_insn_write(void *addr, const void *insn, size_t len)
>   {
>   	size_t patched = 0;

