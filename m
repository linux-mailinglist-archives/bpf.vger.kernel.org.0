Return-Path: <bpf+bounces-9596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBC87996FD
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 11:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164421C20C49
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 09:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854211C3C;
	Sat,  9 Sep 2023 09:04:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CA730F89
	for <bpf@vger.kernel.org>; Sat,  9 Sep 2023 09:04:42 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6A010F6;
	Sat,  9 Sep 2023 02:04:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RjRr344hrz4f3kkJ;
	Sat,  9 Sep 2023 17:04:35 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgAXIgcjNfxkD6kYAA--.9853S2;
	Sat, 09 Sep 2023 17:04:36 +0800 (CST)
Message-ID: <9084901f-730c-cf33-9337-f18a3c17283f@huaweicloud.com>
Date: Sat, 9 Sep 2023 17:04:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v5 1/3] arm64: patching: Add aarch64_insn_copy()
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
 bpf@vger.kernel.org, kpsingh@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230908144320.2474-1-puranjay12@gmail.com>
 <20230908144320.2474-2-puranjay12@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20230908144320.2474-2-puranjay12@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXIgcjNfxkD6kYAA--.9853S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1DKFWkJw4xXrWUCw13twb_yoW5CF1kpF
	1DCrn5Wr48WrWxGF9xC398XrnxWa93GasxXFZxG3WYyr1DZa4UGFn5KF17ZF15Ar1j9r4I
	vrs0vrZ5W3WUtaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUOyCJDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/8/2023 10:43 PM, Puranjay Mohan wrote:
> This will be used by BPF JIT compiler to dump JITed binary to a RX huge
> page, and thus allow multiple BPF programs sharing the a huge (2MB)
> page.
> 
> The bpf_prog_pack allocator that implements the above feature allocates
> a RX/RW buffer pair. The JITed code is written to the RW buffer and then
> this function will be used to copy the code from RW to RX buffer.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
>   arch/arm64/include/asm/patching.h |  1 +
>   arch/arm64/kernel/patching.c      | 41 +++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
> index 68908b82b168..f78a0409cbdb 100644
> --- a/arch/arm64/include/asm/patching.h
> +++ b/arch/arm64/include/asm/patching.h
> @@ -8,6 +8,7 @@ int aarch64_insn_read(void *addr, u32 *insnp);
>   int aarch64_insn_write(void *addr, u32 insn);
>   
>   int aarch64_insn_write_literal_u64(void *addr, u64 val);
> +void *aarch64_insn_copy(void *dst, const void *src, size_t len);
>   
>   int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
>   int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> index b4835f6d594b..243d6ae8d2d8 100644
> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c
> @@ -105,6 +105,47 @@ noinstr int aarch64_insn_write_literal_u64(void *addr, u64 val)
>   	return ret;
>   }
>   
> +/**
> + * aarch64_insn_copy - Copy instructions into (an unused part of) RX memory
> + * @dst: address to modify
> + * @src: source of the copy
> + * @len: length to copy
> + *
> + * Useful for JITs to dump new code blocks into unused regions of RX memory.
> + */
> +noinstr void *aarch64_insn_copy(void *dst, const void *src, size_t len)
> +{
> +	unsigned long flags;
> +	size_t patched = 0;
> +	size_t size;
> +	void *waddr;
> +	void *ptr;
> +	int ret;
> +

check whether the input address and length are aligned to instruction size?

> +	raw_spin_lock_irqsave(&patch_lock, flags);
> +
> +	while (patched < len) {
> +		ptr = dst + patched;
> +		size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
> +			     len - patched);
> +
> +		waddr = patch_map(ptr, FIX_TEXT_POKE0);
> +		ret = copy_to_kernel_nofault(waddr, src + patched, size);
> +		patch_unmap(FIX_TEXT_POKE0);
> +
> +		if (ret < 0) {
> +			raw_spin_unlock_irqrestore(&patch_lock, flags);
> +			return NULL;
> +		}
> +		patched += size;
> +	}
> +	raw_spin_unlock_irqrestore(&patch_lock, flags);
> +
> +	caches_clean_inval_pou((uintptr_t)dst, (uintptr_t)dst + len);
> +

seems flush_icache_range() or something like should be called here to
ensure the other CPUs' pipelines are cleared, otherwise the old instructions
at the dst address might be executed on other CPUs after the copy is complete,
which is not expected.

> +	return dst;
> +}
> +
>   int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
>   {
>   	u32 *tp = addr;


