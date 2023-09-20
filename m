Return-Path: <bpf+bounces-10439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611C27A7467
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 09:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4AD1C20AD0
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 07:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5088F5F;
	Wed, 20 Sep 2023 07:39:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07748487
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 07:39:35 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3CA97
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 00:39:32 -0700 (PDT)
Received: from kwepemd100003.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rr9MN3Xr1zVkqB;
	Wed, 20 Sep 2023 15:36:32 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemd100003.china.huawei.com (7.221.188.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Wed, 20 Sep 2023 15:39:29 +0800
Message-ID: <61918273-1bec-d45c-09de-8fd76dec9620@huawei.com>
Date: Wed, 20 Sep 2023 15:39:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 6/8] bpf: Add arch_bpf_trampoline_size()
Content-Language: en-US
To: Song Liu <song@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@kernel.org>, <kernel-team@meta.com>
References: <20230920053158.3175043-1-song@kernel.org>
 <20230920053158.3175043-7-song@kernel.org>
From: Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <20230920053158.3175043-7-song@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100003.china.huawei.com (7.221.188.180)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Song,

On 9/20/2023 1:31 PM, Song Liu wrote:
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

Since arch_bpf_trampoline_size was already called before the trampoline
image was allocated, it seems this call to arch_bpf_trampoline_size is
unnecessary. If this call can be omitted, we can avoid one less dry run.

> +
> +	if (ret > ((long)image_end - (long)image))
> +		return -EFBIG;
>   
>   	jit_fill_hole(image, (unsigned int)(image_end - image));
>   	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);


[...]


