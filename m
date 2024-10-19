Return-Path: <bpf+bounces-42502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17389A4C86
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 11:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1CC283E52
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 09:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9EA1DED7F;
	Sat, 19 Oct 2024 09:24:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990651DD0FE;
	Sat, 19 Oct 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729329892; cv=none; b=uVn4TyI6KgOkU79J8/W8S9LTskWLMNLa5Ry1dio01VGAEyVfXRePa5DBYgULX8VxvkQ36SNHygDeVzcs28hpP6uePtaSrP21B816wWhbMHzLYgRaUg9MlQRNCfs6gWhAwX2r3IHit6q3l0Fs0WFBBu6WVwI2JROzUy8jwvXCynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729329892; c=relaxed/simple;
	bh=+F84iLEU0t2jLjlpXp7S6SyQwR+80SpRqt0QKt/Ie+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3CFCcCqnMVFzHFugXcO5KHg7FzibaO8PQqVjEUiB4so/t5Qch0DaznHz2wN46eAzOZVwP/Kp1+BrerjLOIWXsDARbSliRLyPb3CDHBzcZoP3BzmyCY5a5hK2VFtQ1odOK/ODlXw3/gGlJoHQ/3SvDUONZ2cf0kqIZtFZ/5ZP4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XVx3d14Kpz4f3jM1;
	Sat, 19 Oct 2024 17:24:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 6281F1A0568;
	Sat, 19 Oct 2024 17:24:46 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgDXdoPbehNnDdZ_EQ--.27148S2;
	Sat, 19 Oct 2024 17:24:44 +0800 (CST)
Message-ID: <4d7a35f8-2d03-4cf6-af6a-9e8e8b374618@huaweicloud.com>
Date: Sat, 19 Oct 2024 17:24:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf, arm64: Fix address emission with tag-based KASAN
 enabled
Content-Language: en-US
To: Peter Collingbourne <pcc@google.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, stable@vger.kernel.org
References: <20241018221644.3240898-1-pcc@google.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20241018221644.3240898-1-pcc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDXdoPbehNnDdZ_EQ--.27148S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1UKF1kCr1DZFWDAr1xGrg_yoW8Kr4rpF
	ykC3y3CFWvqrn3u3WkJw4UXF1Yk3ykKF4a9FW5C3yF9an8Xr97KF1rKwsrGrW5trykCw1r
	XrZFkF1DCas5J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 10/19/2024 6:16 AM, Peter Collingbourne wrote:
> When BPF_TRAMP_F_CALL_ORIG is enabled, the address of a bpf_tramp_image
> struct on the stack is passed during the size calculation pass and
> an address on the heap is passed during code generation. This may
> cause a heap buffer overflow if the heap address is tagged because
> emit_a64_mov_i64() will emit longer code than it did during the size
> calculation pass. The same problem could occur without tag-based
> KASAN if one of the 16-bit words of the stack address happened to
> be all-ones during the size calculation pass. Fix the problem by
> assuming the worst case (4 instructions) when calculating the size
> of the bpf_tramp_image address emission.
> 
> Fixes: 19d3c179a377 ("bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG")
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/I1496f2bc24fba7a1d492e16e2b94cf43714f2d3c
> Cc: stable@vger.kernel.org
> ---
>   arch/arm64/net/bpf_jit_comp.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 8bbd0b20136a8..5db82bfc9dc11 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2220,7 +2220,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	emit(A64_STR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> -		emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
> +		/* for the first pass, assume the worst case */
> +		if (!ctx->image)
> +			ctx->idx += 4;
> +		else
> +			emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
>   		emit_call((const u64)__bpf_tramp_enter, ctx);
>   	}
>   
> @@ -2264,7 +2268,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>   		im->ip_epilogue = ctx->ro_image + ctx->idx;
> -		emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
> +		/* for the first pass, assume the worst case */
> +		if (!ctx->image)
> +			ctx->idx += 4;
> +		else
> +			emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
>   		emit_call((const u64)__bpf_tramp_exit, ctx);
>   	}
>

Acked-by: Xu Kuohai <xukuohai@huawei.com>


