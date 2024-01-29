Return-Path: <bpf+bounces-20529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DA083FB98
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 02:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D371C21F5E
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 01:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B162D1E88A;
	Mon, 29 Jan 2024 01:02:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47517BAF;
	Mon, 29 Jan 2024 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706490143; cv=none; b=tqpF5yHw88Rkhe2k/+JrwBOl1gWtWNpjk1TxXUiLMmqT7ftBf8eXjy9dyRMvoe73iiVgwsySXxIXfnsFtRlqucZXOBUy8IIsYFk5gHw6hdUXuAm0NIX405AJkGMD90hl1tpsLmLT/jVScxlRzNJMFGW2+qcS8crEDW3cFPxCph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706490143; c=relaxed/simple;
	bh=WW0QEjP0cSGhcPD3f64bW1BoiVnkLetBLcI/OIniZa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CRKwIPVuoM1zl2o+NkDFY+IvNaKFukO4x3PW2akbwsYP9zXv/wWw0PTSUH48qIRQz3luB+INHMQAANZ9vVlLLCDM/TUyulttkTuGDlvhBdto0CCdpa6mjGohfSdnT2rAS7jc8zu9FpVaNUUR+9MI0dbKVbEB67TOj5pgc9iYDwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TNVPn3YVjz4f3lfr;
	Mon, 29 Jan 2024 09:02:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E54121A0232;
	Mon, 29 Jan 2024 09:02:11 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgC3Cm0S+bZlkcRSCQ--.12417S2;
	Mon, 29 Jan 2024 09:02:11 +0800 (CST)
Message-ID: <79088869-a5ba-4335-b3ab-8a2a26d8be74@huaweicloud.com>
Date: Mon, 29 Jan 2024 09:02:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 1/2] arm64: patching: implement text_poke API
To: Puranjay Mohan <puranjay12@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
 bpf@vger.kernel.org, kpsingh@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240125133159.85086-1-puranjay12@gmail.com>
 <20240125133159.85086-2-puranjay12@gmail.com>
Content-Language: en-US
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20240125133159.85086-2-puranjay12@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgC3Cm0S+bZlkcRSCQ--.12417S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF17GrWkCFWkKrWUtF18Zrb_yoWrGFyfpF
	1q9rn5Gr4xuF47XFyxGrs8Xrn8u39agF9rXFZrJ3WIyr1UZFnxKFn5KF1jvF1kCa1j9r4I
	9rs0vrZagF4DJF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 1/25/2024 9:31 PM, Puranjay Mohan wrote:
> The text_poke API is used to implement functions like memcpy() and
> memset() for instruction memory (RO+X). The implementation is similar to
> the x86 version.
> 
> This will be used by the BPF JIT to write and modify BPF programs. There
> could be more users of this in the future.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>   arch/arm64/include/asm/patching.h |  2 +
>   arch/arm64/kernel/patching.c      | 80 +++++++++++++++++++++++++++++++
>   2 files changed, 82 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
> index 68908b82b168..587bdb91ab7a 100644
> --- a/arch/arm64/include/asm/patching.h
> +++ b/arch/arm64/include/asm/patching.h
> @@ -8,6 +8,8 @@ int aarch64_insn_read(void *addr, u32 *insnp);
>   int aarch64_insn_write(void *addr, u32 insn);
>   
>   int aarch64_insn_write_literal_u64(void *addr, u64 val);
> +void *aarch64_insn_set(void *dst, u32 insn, size_t len);
> +void *aarch64_insn_copy(void *dst, void *src, size_t len);
>   
>   int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
>   int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> index b4835f6d594b..5c2d34d890cf 100644
> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c
> @@ -105,6 +105,86 @@ noinstr int aarch64_insn_write_literal_u64(void *addr, u64 val)
>   	return ret;
>   }
>   
> +typedef void text_poke_f(void *dst, void *src, size_t patched, size_t len);
> +

How about removing the argument 'patched' and passing 'src + patched' as the
second argument?

> +static void *__text_poke(text_poke_f func, void *addr, void *src, size_t len)
> +{
> +	unsigned long flags;
> +	size_t patched = 0;
> +	size_t size;
> +	void *waddr;
> +	void *ptr;
> +	int ret;
> +
> +	raw_spin_lock_irqsave(&patch_lock, flags);
> +
> +	while (patched < len) {
> +		ptr = addr + patched;
> +		size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
> +			     len - patched);
> +
> +		waddr = patch_map(ptr, FIX_TEXT_POKE0);
> +		func(waddr, src, patched, size);
> +		patch_unmap(FIX_TEXT_POKE0);
> +
> +		if (ret < 0) {

Where is 'ret' assigned?

> +			raw_spin_unlock_irqrestore(&patch_lock, flags);
> +			return NULL;
> +		}
> +		patched += size;
> +	}
> +	raw_spin_unlock_irqrestore(&patch_lock, flags);
> +
> +	flush_icache_range((uintptr_t)addr, (uintptr_t)addr + len);
> +
> +	return addr;
> +}
> +
> +static void text_poke_memcpy(void *dst, void *src, size_t patched, size_t len)
> +{
> +	copy_to_kernel_nofault(dst, src + patched, len);
> +}
> +
> +static void text_poke_memset(void *dst, void *src, size_t patched, size_t len)
> +{
> +	u32 c = *(u32 *)src;
> +
> +	memset32(dst, c, len / 4);
> +}
> +
> +/**
> + * aarch64_insn_copy - Copy instructions into (an unused part of) RX memory
> + * @dst: address to modify
> + * @src: source of the copy
> + * @len: length to copy
> + *
> + * Useful for JITs to dump new code blocks into unused regions of RX memory.
> + */
> +noinstr void *aarch64_insn_copy(void *dst, void *src, size_t len)
> +{
> +	/* A64 instructions must be word aligned */
> +	if ((uintptr_t)dst & 0x3)
> +		return NULL;
> +
> +	return __text_poke(text_poke_memcpy, dst, src, len);
> +}
> +
> +/**
> + * aarch64_insn_set - memset for RX memory regions.
> + * @dst: address to modify
> + * @insn: value to set
> + * @len: length of memory region.
> + *
> + * Useful for JITs to fill regions of RX memory with illegal instructions.
> + */
> +noinstr void *aarch64_insn_set(void *dst, u32 insn, size_t len)
> +{
> +	if ((uintptr_t)dst & 0x3)
> +		return NULL;
> +
> +	return __text_poke(text_poke_memset, dst, &insn, len);
> +}
> +
>   int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
>   {
>   	u32 *tp = addr;


