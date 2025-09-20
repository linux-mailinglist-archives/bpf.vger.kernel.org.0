Return-Path: <bpf+bounces-69092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6993FB8C5B6
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 12:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3594816B14D
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 10:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F7288C25;
	Sat, 20 Sep 2025 10:37:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DE8189
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758364671; cv=none; b=Khmoczv5+l4Y8rTfGv93M2EyMHOmWwKjkcKB/0Z4jXaZ5d+q8WcUj7v6CCkBD8xmJJbas/8kZs/RkAux9nXC4G/pzgbNU81OvuKHuvjNW78lNBsbwEK6l7h7Dp4QzrIUM/Dfg7yQIaw8Wnszy3nRwwSjWGgIPWrbsFNtjphmSPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758364671; c=relaxed/simple;
	bh=6dxFgjsB+dMZ+KdFqsLQGySEIK7HsNbgwY1HRWe1luw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyLB2v2IaUXG/G6XC5L9RZqTXZrmlhoJCu19HFVJ0ZeoausdU0+u5kNUMpUKulaQZHo4xOBKisfBv2QYcWSbBHwVqHg5oLNzhomWoKzyctxW/QW0/oOOYS46lMZfPkOc7aXcUSY8Zk3T/4HxiW2GNLn6cfByx1UrPQ46Fxut2wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cTQmy2FFLzKHNBp
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 18:37:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 41E641A0AC7
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 18:37:39 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgAnchbxg85odLjbAA--.10925S2;
	Sat, 20 Sep 2025 18:37:39 +0800 (CST)
Message-ID: <14c06b60-7923-4f27-ae8d-ba62ac7a2248@huaweicloud.com>
Date: Sat, 20 Sep 2025 18:37:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] bpf, arm64: Add support for signed arena
 loads
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
References: <20250915162848.54282-1-puranjay@kernel.org>
 <20250915162848.54282-3-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20250915162848.54282-3-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnchbxg85odLjbAA--.10925S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFykJrW5ArW5Ww13AFW5KFg_yoW5ur1rp3
	W7JFy3Zw1kta18uFyqqrW3Zw1rArs5CFW3Wryay348J3Z3Wrs0gF1Ut3WxWr90yry7WFWU
	JFs7uryIk3s5GFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 9/16/2025 12:28 AM, Puranjay Mohan wrote:
> Add support for signed loads from arena which are internally converted
> to loads with mode set BPF_PROBE_MEM32SX by the verifier. The
> implementation is similar to BPF_PROBE_MEMSX and BPF_MEMSX but for
> BPF_PROBE_MEM32SX, arena_vm_base is added to the src register to form
> the address.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 30 +++++++++++++++++-------------
>   1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index f2b85a10add2..7233acec69ce 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1133,12 +1133,14 @@ static int add_exception_handler(const struct bpf_insn *insn,
>   		return 0;
>   
>   	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
> -		BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
> -			BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
> -				BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
> +	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
> +	    BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
> +	    BPF_MODE(insn->code) != BPF_PROBE_MEM32SX &&
> +	    BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
>   		return 0;
>   
>   	is_arena = (BPF_MODE(insn->code) == BPF_PROBE_MEM32) ||
> +		   (BPF_MODE(insn->code) == BPF_PROBE_MEM32SX) ||
>   		   (BPF_MODE(insn->code) == BPF_PROBE_ATOMIC);
>   
>   	if (!ctx->prog->aux->extable ||
> @@ -1659,7 +1661,11 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>   	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
>   	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
>   	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
> -		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
> +	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
> +	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
> +	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
> +		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
> +		    BPF_MODE(insn->code) == BPF_PROBE_MEM32SX) {
>   			emit(A64_ADD(1, tmp2, src, arena_vm_base), ctx);
>   			src = tmp2;
>   		}
> @@ -1671,7 +1677,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>   			off_adj = off;
>   		}
>   		sign_extend = (BPF_MODE(insn->code) == BPF_MEMSX ||
> -				BPF_MODE(insn->code) == BPF_PROBE_MEMSX);
> +				BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
> +				 BPF_MODE(insn->code) == BPF_PROBE_MEM32SX);
>   		switch (BPF_SIZE(code)) {
>   		case BPF_W:
>   			if (is_lsi_offset(off_adj, 2)) {
> @@ -1879,9 +1886,11 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>   		if (ret)
>   			return ret;
>   
> -		ret = add_exception_handler(insn, ctx, dst);
> -		if (ret)
> -			return ret;
> +		if (BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {

add_exception_handler already checked this condition, why add a check here?

> +			ret = add_exception_handler(insn, ctx, dst);
> +			if (ret)
> +				return ret;
> +		}
>   		break;
>   
>   	default:
> @@ -3064,11 +3073,6 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
>   		if (!bpf_atomic_is_load_store(insn) &&
>   		    !cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
>   			return false;
> -		break;
> -	case BPF_LDX | BPF_MEMSX | BPF_B:
> -	case BPF_LDX | BPF_MEMSX | BPF_H:
> -	case BPF_LDX | BPF_MEMSX | BPF_W:
> -		return false;
>   	}
>   	return true;
>   }


