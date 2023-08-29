Return-Path: <bpf+bounces-8876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A54F78BD06
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 04:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949DC280F49
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 02:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7288A51;
	Tue, 29 Aug 2023 02:49:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8505CA44
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 02:49:20 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA6919F;
	Mon, 28 Aug 2023 19:49:18 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RZWyN4LbgzLpHm;
	Tue, 29 Aug 2023 10:46:04 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 29 Aug 2023 10:49:14 +0800
Message-ID: <c21fb045-5114-2f0a-b7d5-4ee40c97c14c@huawei.com>
Date: Tue, 29 Aug 2023 10:49:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf-next v3 1/3] riscv: extend patch_text_nosync() for
 multiple pages
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <conor.dooley@microchip.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<kpsingh@kernel.org>, <bjorn@kernel.org>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230828165958.1714079-1-puranjay12@gmail.com>
 <20230828165958.1714079-2-puranjay12@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20230828165958.1714079-2-puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/29 0:59, Puranjay Mohan wrote:
> The patch_insn_write() function currently doesn't work for multiple pages
> of instructions, therefore patch_text_nosync() will fail with a page fault
> if called with lengths spanning multiple pages.
> 
> This commit extends the patch_insn_write() function to support multiple
> pages by copying at max 2 pages at a time in a loop. This implementation
> is similar to text_poke_copy() function of x86.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>   arch/riscv/kernel/patch.c | 37 ++++++++++++++++++++++++++++++++-----
>   1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 575e71d6c8ae..2c97e246f4dc 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -53,12 +53,18 @@ static void patch_unmap(int fixmap)
>   }
>   NOKPROBE_SYMBOL(patch_unmap);
>   
> -static int patch_insn_write(void *addr, const void *insn, size_t len)
> +static int __patch_insn_write(void *addr, const void *insn, size_t len)
>   {
>   	void *waddr = addr;
>   	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
>   	int ret;
>   
> +	/*
> +	 * Only two pages can be mapped at a time for writing.
> +	 */
> +	if (len + offset_in_page(addr) > 2 * PAGE_SIZE)
> +		return -EINVAL;
> +
>   	/*
>   	 * Before reaching here, it was expected to lock the text_mutex
>   	 * already, so we don't need to give another lock here and could
> @@ -74,7 +80,7 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
>   		lockdep_assert_held(&text_mutex);
>   
>   	if (across_pages)
> -		patch_map(addr + len, FIX_TEXT_POKE1);
> +		patch_map(addr + PAGE_SIZE, FIX_TEXT_POKE1);
>   
>   	waddr = patch_map(addr, FIX_TEXT_POKE0);
>   
> @@ -87,15 +93,36 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
>   
>   	return ret;
>   }
> -NOKPROBE_SYMBOL(patch_insn_write);
> +NOKPROBE_SYMBOL(__patch_insn_write);
>   #else
> -static int patch_insn_write(void *addr, const void *insn, size_t len)
> +static int __patch_insn_write(void *addr, const void *insn, size_t len)
>   {
>   	return copy_to_kernel_nofault(addr, insn, len);
>   }
> -NOKPROBE_SYMBOL(patch_insn_write);
> +NOKPROBE_SYMBOL(__patch_insn_write);
>   #endif /* CONFIG_MMU */
>   
> +static int patch_insn_write(void *addr, const void *insn, size_t len)
> +{
> +	size_t patched = 0;
> +	size_t size;
> +	int ret = 0;
> +
> +	/*
> +	 * Copy the instructions to the destination address, two pages at a time
> +	 * because __patch_insn_write() can only handle len <= 2 * PAGE_SIZE.
> +	 */
> +	while (patched < len && !ret) {
> +		size = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr + patched), len - patched);
> +		ret = __patch_insn_write(addr + patched, insn + patched, size);
> +
> +		patched += size;
> +	}
> +
> +	return ret;
> +}
> +NOKPROBE_SYMBOL(patch_insn_write);
> +
>   int patch_text_nosync(void *addr, const void *insns, size_t len)
>   {
>   	u32 *tp = addr;

Looks good to me,
Reviewed-by: Pu Lehui <pulehui@huawei.com>


