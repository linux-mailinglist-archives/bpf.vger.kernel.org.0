Return-Path: <bpf+bounces-74961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF3DC69732
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 22F1A2AABC
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19FA33373E;
	Tue, 18 Nov 2025 12:43:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADD0276049
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469832; cv=none; b=gQILe/kX5HVxajC9VT2CGR8N48B/XBh0OtiBKdNZmYP0leTX7IFT6VJ2uyyAJtAlLNrqhIldqd4mcgduo8D5S8hLr1toCOt1k25javlqVQ18wVo/sSCzCxtks/V//lMMJ3V4CiH3P2SdiDPyWTKnHDTUf6FKEOoJI/bNIwlewXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469832; c=relaxed/simple;
	bh=3b76Dok+D9JStwoZf3mF/G1YjmjjyKzOf2fZUu00YEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVz0SI1mRlaTC6VyTXvky6P2dToqzc2B0nxhwNaY3lAeDnowKDJ08UdgrVzt3XOQ49JK+hNmKSTz0iu2rAsKeuCKB2THlMDMwIvw1plrRlg86cU9IFQs8885MQIPYjzgvoV8nLU3rQG+rVKA+zHdNg0/LjiphavDwXsF1Yg78ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d9kmQ1zkyzYQv2J
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 20:43:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BFD221A08FD
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 20:43:40 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgA3qlf7aRxpHRS2BA--.42068S2;
	Tue, 18 Nov 2025 20:43:40 +0800 (CST)
Message-ID: <471a08af-2e15-4efa-b636-852875a1c3b8@huaweicloud.com>
Date: Tue, 18 Nov 2025 20:43:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] bpf: arm64: Add support for instructions
 array
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 kernel-team@meta.com, Anton Protopopov <a.s.protopopov@gmail.com>
References: <20251117130732.11107-1-puranjay@kernel.org>
 <20251117130732.11107-2-puranjay@kernel.org>
Content-Language: en-US
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20251117130732.11107-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3qlf7aRxpHRS2BA--.42068S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW8uFWxGF47ArW5AF1UWrg_yoW8XF1Dpa
	4DC343CrWDWr4UCFW5Xa17CF1Sga1kWr43GrZ5WrWFgF90vFW8Ka4Fk3Z0kws8ArWDZw4r
	ZayjkrsxAa4DA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 11/17/2025 9:07 PM, Puranjay Mohan wrote:
> Add support for the instructions array map type in the arm64 JIT by
> calling bpf_prog_update_insn_ptrs() with the offsets that map
> xlated_offset to the jited_offset in the final image. arm64 JIT already
> has this offset array which was being used for
> bpf_prog_fill_jited_linfo() and can be used directly for
> bpf_prog_update_insn_ptrs.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 0c9a50a1e73e..4a2afc0cefc4 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2231,6 +2231,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   		for (i = 0; i <= prog->len; i++)
>   			ctx.offset[i] *= AARCH64_INSN_SIZE;
>   		bpf_prog_fill_jited_linfo(prog, ctx.offset + 1);
> +		/*
> +		 * The bpf_prog_update_insn_ptrs function expects offsets to
> +		 * point to the first byte of the jitted instruction (unlike
> +		 * the bpf_prog_fill_jited_linfo above, which, for historical
> +		 * reasons, expects to point to the next instruction)
> +		 */
> +		bpf_prog_update_insn_ptrs(prog, ctx.offset, ctx.ro_image);
>   out_off:
>   		if (!ro_header && priv_stack_ptr) {
>   			free_percpu(priv_stack_ptr);

Acked-by: Xu Kuohai <xukuohai@huawei.com>


