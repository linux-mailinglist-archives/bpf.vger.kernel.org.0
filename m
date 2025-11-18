Return-Path: <bpf+bounces-74960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3480C6972F
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A9174E3DC7
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C79D3126C4;
	Tue, 18 Nov 2025 12:43:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09428D8ED
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469828; cv=none; b=V3wzKLRbDRjb8aQKpQmePwv8Umtj9hjIxpiqPu8t3KIFUIddKf3kTXn2cmvlxrvI7nx9FMn1QDGObD0lxh46CBAv9Cz2NzkQb/t0+AK8f+4Y7AN0eCmn6/se6e8ohKLWQc/ulna8asacdXqAGrdoOkJH222tc8ynmTp5k/Sz4fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469828; c=relaxed/simple;
	bh=Ez61A4MScOh5dQBXEUv8On+qvwEap1mzHj9g8DpB638=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czXjLpjFF4ETGmGsGt7qdiXIHmeZ8zp0nl395ebiFFXmDxESloPV1vFEFjZ2GjQdMGz0eFr6QHfLwKrZRVViZbhlsGdtnWXby84z8eco2r7r0rrREsxZATVi4sGx8SEbWDBHNVS7/RBkqs4k2ykmJdIwr0Pn0Mqu5a8Nb4nRrmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d9kmg3BrvzKHMfc
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 20:43:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1D0BC1A08FD
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 20:43:42 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgA3qlf7aRxpHRS2BA--.42068S3;
	Tue, 18 Nov 2025 20:43:41 +0800 (CST)
Message-ID: <be9978a6-5b22-4c52-8c7d-3a65e0fa335f@huaweicloud.com>
Date: Tue, 18 Nov 2025 20:43:41 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] bpf: arm64: Add support for indirect
 jumps
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 kernel-team@meta.com, Anton Protopopov <a.s.protopopov@gmail.com>
References: <20251117130732.11107-1-puranjay@kernel.org>
 <20251117130732.11107-3-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20251117130732.11107-3-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3qlf7aRxpHRS2BA--.42068S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy7tF4DCrW3CrWrZr47Jwb_yoW8JFW3pa
	1Duw13urWkWr13WFWUXa17Wry3Kan5Jr47ury5X3y3GFZIq3s5KF1rK3sIkrs5ArW7ua13
	uFyjkrnxCa4DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw
	0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2uyIUUUU
	U
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 11/17/2025 9:07 PM, Puranjay Mohan wrote:
> Add support for a new instruction
> 
> 	BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0, imm=0
> 
> which does an indirect jump to a location stored in Rx.  The register
> Rx should have type PTR_TO_INSN. This new type assures that the Rx
> register contains a value (or a range of values) loaded from a
> correct jump table – map of type instruction array.
> 
> ARM64 JIT supports indirect jumps to all registers through the A64_BR()
> macro, use it to implement this new instruction.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 4a2afc0cefc4..4cfb549f2b43 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1452,6 +1452,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>   		emit(A64_ASR(is64, dst, dst, imm), ctx);
>   		break;
>   
> +	/* JUMP reg */
> +	case BPF_JMP | BPF_JA | BPF_X:
> +		emit(A64_BR(dst), ctx);
> +		break;
>   	/* JUMP off */
>   	case BPF_JMP | BPF_JA:
>   	case BPF_JMP32 | BPF_JA:

Acked-by: Xu Kuohai <xukuohai@huawei.com>


