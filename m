Return-Path: <bpf+bounces-10503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FB77A903A
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 02:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDF11C209C8
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 00:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98585A55;
	Thu, 21 Sep 2023 00:46:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB6A80F
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 00:46:03 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1233C6
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 17:46:00 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rrc726m6HzMlgm;
	Thu, 21 Sep 2023 08:42:22 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 21 Sep 2023 08:45:58 +0800
Message-ID: <00447f8b-bfd3-4bb0-946a-beb7f9fe0f55@huawei.com>
Date: Thu, 21 Sep 2023 08:45:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 6/8] bpf: Add arch_bpf_trampoline_size()
Content-Language: en-US
To: Song Liu <song@kernel.org>, <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@kernel.org>, <kernel-team@meta.com>
References: <20230920053158.3175043-1-song@kernel.org>
 <20230920053158.3175043-7-song@kernel.org>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20230920053158.3175043-7-song@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/20 13:31, Song Liu wrote:
> This helper will be used to calculate the size of the trampoline before
> allocating the memory.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>   arch/arm64/net/bpf_jit_comp.c   | 56 ++++++++++++++++++++++++---------
>   arch/riscv/net/bpf_jit_comp64.c | 24 +++++++++-----
>   arch/s390/net/bpf_jit_comp.c    | 52 +++++++++++++++++-------------
>   arch/x86/net/bpf_jit_comp.c     | 40 ++++++++++++++++++++---
>   include/linux/bpf.h             |  2 ++
>   kernel/bpf/trampoline.c         |  6 ++++
>   6 files changed, 131 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index d81b886ea4df..a6671253b7ed 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2026,18 +2026,10 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	return ctx->idx;
>   }
>   
> -int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
> -				void *image_end, const struct btf_func_model *m,
> -				u32 flags, struct bpf_tramp_links *tlinks,
> -				void *func_addr)
> +static int btf_func_model_nregs(const struct btf_func_model *m)
>   {
> -	int i, ret;
>   	int nregs = m->nr_args;
> -	int max_insns = ((long)image_end - (long)image) / AARCH64_INSN_SIZE;
> -	struct jit_ctx ctx = {
> -		.image = NULL,
> -		.idx = 0,
> -	};
> +	int i;
>   
>   	/* extra registers needed for struct argument */
>   	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
> @@ -2046,19 +2038,53 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
>   			nregs += (m->arg_size[i] + 7) / 8 - 1;
>   	}
>   
> +	return nregs;
> +}
> +
> +int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> +			     struct bpf_tramp_links *tlinks, void *func_addr)
> +{
> +	struct jit_ctx ctx = {
> +		.image = NULL,
> +		.idx = 0,
> +	};
> +	struct bpf_tramp_image im;
> +	int nregs, ret;
> +
> +	nregs = btf_func_model_nregs(m);
>   	/* the first 8 registers are used for arguments */
>   	if (nregs > 8)
>   		return -ENOTSUPP;
>   
> -	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
> +	ret = prepare_trampoline(&ctx, &im, tlinks, func_addr, nregs, flags);
>   	if (ret < 0)
>   		return ret;
>   
> -	if (ret > max_insns)
> -		return -EFBIG;
> +	return ret < 0 ? ret : ret * AARCH64_INSN_SIZE;
> +}
>   
> -	ctx.image = image;
> -	ctx.idx = 0;
> +int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
> +				void *image_end, const struct btf_func_model *m,
> +				u32 flags, struct bpf_tramp_links *tlinks,
> +				void *func_addr)
> +{
> +	int ret, nregs;
> +	struct jit_ctx ctx = {
> +		.image = image,
> +		.idx = 0,
> +	};
> +
> +	nregs = btf_func_model_nregs(m);
> +	/* the first 8 registers are used for arguments */
> +	if (nregs > 8)
> +		return -ENOTSUPP;
> +
> +	ret = arch_bpf_trampoline_size(m, flags, tlinks, func_addr);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret > ((long)image_end - (long)image))
> +		return -EFBIG;
>   
>   	jit_fill_hole(image, (unsigned int)(image_end - image));
>   	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index ecd3ae6f4116..4de13c4aaad1 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1024,6 +1024,20 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	return ret;
>   }
>   
> +int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> +			     struct bpf_tramp_links *tlinks, void *func_addr)
> +{
> +	struct bpf_tramp_image im;
> +	struct rv_jit_context ctx;
> +
> +	ctx.ninsns = 0;
> +	ctx.insns = NULL;
> +	ctx.ro_insns = NULL;
> +	ret = __arch_prepare_bpf_trampoline(&im, m, tlinks, func_addr, flags, &ctx);
> +
> +	return ret < 0 ? ret : ninsns_rvoff(ctx->ninsns);
> +}
> +
>   int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
>   				void *image_end, const struct btf_func_model *m,
>   				u32 flags, struct bpf_tramp_links *tlinks,
> @@ -1032,14 +1046,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
>   	int ret;
>   	struct rv_jit_context ctx;
>   
> -	ctx.ninsns = 0;
> -	ctx.insns = NULL;
> -	ctx.ro_insns = NULL;
> -	ret = __arch_prepare_bpf_trampoline(im, m, tlinks, func_addr, flags, &ctx);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (ninsns_rvoff(ret) > (long)image_end - (long)image)
> +	ret = arch_bpf_trampoline_size(im, m, flags, tlinks, func_addr);

Hi Song, there is missing check for negative return values.

> +	if (ret > (long)image_end - (long)image)
>   		return -EFBIG;
>   
>   	ctx.ninsns = 0;
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index e6a643f63ebf..8fab4795b497 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -2483,6 +2483,21 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	return 0;
>   }
>   
> +int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> +			     struct bpf_tramp_links *tlinks, void *orig_call)
> +{
> +	struct bpf_tramp_image im;
> +	struct bpf_tramp_jit tjit;
> +	int ret;
> +
> +	memset(&tjit, 0, sizeof(tjit));
> +
> +	ret = __arch_prepare_bpf_trampoline(&im, &tjit, m, flags,
> +					    tlinks, orig_call);
> +
> +	return ret < 0 ? ret : tjit.common.prg;
> +}
> +
>   int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
>   				void *image_end, const struct btf_func_model *m,
>   				u32 flags, struct bpf_tramp_links *tlinks,
> @@ -2490,30 +2505,23 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
>   {
>   	struct bpf_tramp_jit tjit;
>   	int ret;
> -	int i;
>   
> -	for (i = 0; i < 2; i++) {
> -		if (i == 0) {
> -			/* Compute offsets, check whether the code fits. */
> -			memset(&tjit, 0, sizeof(tjit));
> -		} else {
> -			/* Generate the code. */
> -			tjit.common.prg = 0;
> -			tjit.common.prg_buf = image;
> -		}
> -		ret = __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
> -						    tlinks, func_addr);
> -		if (ret < 0)
> -			return ret;
> -		if (tjit.common.prg > (char *)image_end - (char *)image)
> -			/*
> -			 * Use the same error code as for exceeding
> -			 * BPF_MAX_TRAMP_LINKS.
> -			 */
> -			return -E2BIG;
> -	}
> +	ret = arch_bpf_trampoline_size(m, flags, tlinks, func_addr);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret > (char *)image_end - (char *)image)
> +		/*
> +		 * Use the same error code as for exceeding
> +		 * BPF_MAX_TRAMP_LINKS.
> +		 */
> +		return -E2BIG;
>   
> -	return tjit.common.prg;
> +	tjit.common.prg = 0;
> +	tjit.common.prg_buf = image;
> +	ret = __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
> +					    tlinks, func_addr);
> +	return ret < 0 ? ret : tjit.common.prg;
>   }
>   
>   bool bpf_jit_supports_subprog_tailcalls(void)
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 5f7528cac344..eca561621e65 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2422,10 +2422,10 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
>    * add rsp, 8                      // skip eth_type_trans's frame
>    * ret                             // return to its caller
>    */
> -int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
> -				const struct btf_func_model *m, u32 flags,
> -				struct bpf_tramp_links *tlinks,
> -				void *func_addr)
> +static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
> +					 const struct btf_func_model *m, u32 flags,
> +					 struct bpf_tramp_links *tlinks,
> +					 void *func_addr)
>   {
>   	int i, ret, nr_regs = m->nr_args, stack_size = 0;
>   	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
> @@ -2678,6 +2678,38 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   	return ret;
>   }
>   
> +int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
> +				const struct btf_func_model *m, u32 flags,
> +				struct bpf_tramp_links *tlinks,
> +				void *func_addr)
> +{
> +	return __arch_prepare_bpf_trampoline(im, image, image_end, m, flags, tlinks, func_addr);
> +}
> +
> +int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> +			     struct bpf_tramp_links *tlinks, void *func_addr)
> +{
> +	struct bpf_tramp_image im;
> +	void *image;
> +	int ret;
> +
> +	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
> +	 * This will NOT cause fragmentation in direct map, as we do not
> +	 * call set_memory_*() on this buffer.
> +	 */
> +	image = bpf_jit_alloc_exec(PAGE_SIZE);
> +	if (!image)
> +		return -ENOMEM;
> +
> +	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, m, flags,
> +					    tlinks, func_addr);
> +	bpf_jit_free_exec(image);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ret;
> +}
> +
>   static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image, u8 *buf)
>   {
>   	u8 *jg_reloc, *prog = *pprog;
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 548f3ef34ba1..5bbac549b0a0 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1087,6 +1087,8 @@ void *arch_alloc_bpf_trampoline(int size);
>   void arch_free_bpf_trampoline(void *image, int size);
>   void arch_protect_bpf_trampoline(void *image, int size);
>   void arch_unprotect_bpf_trampoline(void *image, int size);
> +int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> +			     struct bpf_tramp_links *tlinks, void *func_addr);
>   
>   u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
>   					     struct bpf_tramp_run_ctx *run_ctx);
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 5509bdf98067..285c5b7c1ea4 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -1070,6 +1070,12 @@ void __weak arch_unprotect_bpf_trampoline(void *image, int size)
>   	set_memory_rw((long)image, 1);
>   }
>   
> +int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> +				    struct bpf_tramp_links *tlinks, void *func_addr)
> +{
> +	return -ENOTSUPP;
> +}
> +
>   static int __init init_trampolines(void)
>   {
>   	int i;

