Return-Path: <bpf+bounces-9597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11227996FF
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 11:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521BE281842
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613B71FA7;
	Sat,  9 Sep 2023 09:13:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275C1C07
	for <bpf@vger.kernel.org>; Sat,  9 Sep 2023 09:13:27 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352A1186;
	Sat,  9 Sep 2023 02:13:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RjS292V72z4f3nTy;
	Sat,  9 Sep 2023 17:13:21 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCHGtoxN_xkjs8ZAA--.11005S2;
	Sat, 09 Sep 2023 17:13:22 +0800 (CST)
Message-ID: <2095a591-8f3e-318c-a390-a43a653ce6d5@huaweicloud.com>
Date: Sat, 9 Sep 2023 17:13:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v5 2/3] arm64: patching: Add aarch64_insn_set()
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
 bpf@vger.kernel.org, kpsingh@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230908144320.2474-1-puranjay12@gmail.com>
 <20230908144320.2474-3-puranjay12@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20230908144320.2474-3-puranjay12@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHGtoxN_xkjs8ZAA--.11005S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1DAr4DAw1UCw1kGFyrCrg_yoW5XrWrpF
	1Durn5Gw48WrWxXryfGws8XFnxG395Gr9xXFZrWa1IyryUZFy5KFn5KF1UZFW5Ar109r4I
	9FsavrZ5WF1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrcTmDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/8/2023 10:43 PM, Puranjay Mohan wrote:
> The BPF JIT needs to write invalid instructions to RX regions of memory
> to invalidate removed BPF programs. This needs a function like memset()
> that can work with RX memory.
> 
> Implement aarch64_insn_set() which is similar to text_poke_set() of x86.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>   arch/arm64/include/asm/patching.h |  1 +
>   arch/arm64/kernel/patching.c      | 40 +++++++++++++++++++++++++++++++
>   2 files changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
> index f78a0409cbdb..551933338739 100644
> --- a/arch/arm64/include/asm/patching.h
> +++ b/arch/arm64/include/asm/patching.h
> @@ -8,6 +8,7 @@ int aarch64_insn_read(void *addr, u32 *insnp);
>   int aarch64_insn_write(void *addr, u32 insn);
>   
>   int aarch64_insn_write_literal_u64(void *addr, u64 val);
> +int aarch64_insn_set(void *dst, const u32 insn, size_t len);
>   void *aarch64_insn_copy(void *dst, const void *src, size_t len);
>   
>   int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> index 243d6ae8d2d8..63d9e0e77806 100644
> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c
> @@ -146,6 +146,46 @@ noinstr void *aarch64_insn_copy(void *dst, const void *src, size_t len)
>   	return dst;
>   }
>   
> +/**
> + * aarch64_insn_set - memset for RX memory regions.
> + * @dst: address to modify
> + * @c: value to set

insn

> + * @len: length of memory region.
> + *
> + * Useful for JITs to fill regions of RX memory with illegal instructions.
> + */
> +noinstr int aarch64_insn_set(void *dst, const u32 insn, size_t len)

const is unnecessary

> +{
> +	unsigned long flags;
> +	size_t patched = 0;
> +	size_t size;
> +	void *waddr;
> +	void *ptr;
> +
> +	/* A64 instructions must be word aligned */
> +	if ((uintptr_t)dst & 0x3)
> +		return -EINVAL;
> +
> +	raw_spin_lock_irqsave(&patch_lock, flags);
> +
> +	while (patched < len) {
> +		ptr = dst + patched;
> +		size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
> +			     len - patched);
> +
> +		waddr = patch_map(ptr, FIX_TEXT_POKE0);
> +		memset32(waddr, insn, size / 4);
> +		patch_unmap(FIX_TEXT_POKE0);
> +
> +		patched += size;
> +	}
> +	raw_spin_unlock_irqrestore(&patch_lock, flags);
> +
> +	caches_clean_inval_pou((uintptr_t)dst, (uintptr_t)dst + len);
> +
> +	return 0;
> +}
> +

this function shares most of the code with aarch64_insn_copy(), how about
extracting the shared code to a separate function?

>   int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
>   {
>   	u32 *tp = addr;


