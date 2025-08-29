Return-Path: <bpf+bounces-66967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BD1B3B80F
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 12:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE23816D79B
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 10:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8891D305E0D;
	Fri, 29 Aug 2025 10:06:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C3019E99F
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461978; cv=none; b=pwBa8eFF/BlHQAFxOGxrdxWYwce4pqnXe26oqOCWvexeHvG6U9bug+X6xhFNnnuC1m0iEye+UP6tLcMdvTgoScGQiNlG1V2UXyqhYSbLS+4meNOk1zmcXMxxIrVqOxpHnv8xZP4r5SD0YUGLcRA1VLAzmvWKNA+Bta6c+w9ca6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461978; c=relaxed/simple;
	bh=HeCf3UZlVzfK+cVw4qRUk+uwhdpysgO7/UpT1JJ6yCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=emwhZ/kHmHdCI2JW42ZFhrBsK2YhjGXHt/e8VzmUgf0K1F/pZAE7yAZVsRKUa4F8175R9AlQrsmtzWVlJ1Ie2f/CmrIxgEubLs8v1kc1Sj9Ln4Z6W6NeM7VWArUSnYeDTu0VaaiEiXgw5D0vhGfWAo4vjiXMOLcUQVfmFbCRD2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cCv6r6F65zKHMVy
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 18:06:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 979A81A1B84
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 18:06:12 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgBnsY2Te7FoAw2_Ag--.16563S2;
	Fri, 29 Aug 2025 18:06:12 +0800 (CST)
Message-ID: <dbe808fe-211d-43cb-9cf1-8febfa0d5f06@huaweicloud.com>
Date: Fri, 29 Aug 2025 18:06:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/3] bpf: arm64: simplify exception table
 handling
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 bpf@vger.kernel.org
References: <20250827153728.28115-1-puranjay@kernel.org>
 <20250827153728.28115-2-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20250827153728.28115-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnsY2Te7FoAw2_Ag--.16563S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw15GF1UWr18CFyfKF48WFg_yoWrJr17pw
	s5Cw13Kr4vqr47uF4kXF4DJr1agw4kJr48CrZ8C34ftasFvFn3KFySya9093WUAry8uF1f
	ZF1I9rZru3ZxA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/27/2025 11:37 PM, Puranjay Mohan wrote:
> BPF loads with BPF_PROBE_MEM(SX) can load from unsafe pointers and the
> JIT adds an exception table entry for the JITed instruction which allows
> the exeption handler to set the destination register of the load to zero
> and continue execution from the next instruction.
> 
> As all arm64 instructions are AARCH64_INSN_SIZE size, the exception
> handler can just increment the pc by AARCH64_INSN_SIZE without needing
> the exact address of the instruction following the the faulting
> instruction.
> 
> Simplify the exception table usage in arm64 JIT by only saving the
> destination register in ex->fixup and drop everything related to
> the fixup_offset. The fault handler is modified to add AARCH64_INSN_SIZE
> to the pc.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 25 +++----------------------
>   1 file changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 52ffe115a8c47..42643fd9168fc 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1066,19 +1066,18 @@ static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
>   	emit(A64_RET(A64_LR), ctx);
>   }
>   
> -#define BPF_FIXUP_OFFSET_MASK	GENMASK(26, 0)
>   #define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
>   #define DONT_CLEAR 5 /* Unused ARM64 register from BPF's POV */
>   
>   bool ex_handler_bpf(const struct exception_table_entry *ex,
>   		    struct pt_regs *regs)
>   {
> -	off_t offset = FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
>   	int dst_reg = FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
>   
>   	if (dst_reg != DONT_CLEAR)
>   		regs->regs[dst_reg] = 0;
> -	regs->pc = (unsigned long)&ex->fixup - offset;
> +	/* Skip the faulting instruction */
> +	regs->pc += AARCH64_INSN_SIZE;
>   	return true;
>   }
>   
> @@ -1088,7 +1087,6 @@ static int add_exception_handler(const struct bpf_insn *insn,
>   				 int dst_reg)
>   {
>   	off_t ins_offset;
> -	off_t fixup_offset;
>   	unsigned long pc;
>   	struct exception_table_entry *ex;
>   
> @@ -1119,22 +1117,6 @@ static int add_exception_handler(const struct bpf_insn *insn,
>   	if (WARN_ON_ONCE(ins_offset >= 0 || ins_offset < INT_MIN))
>   		return -ERANGE;
>   
> -	/*
> -	 * Since the extable follows the program, the fixup offset is always
> -	 * negative and limited to BPF_JIT_REGION_SIZE. Store a positive value
> -	 * to keep things simple, and put the destination register in the upper
> -	 * bits. We don't need to worry about buildtime or runtime sort
> -	 * modifying the upper bits because the table is already sorted, and
> -	 * isn't part of the main exception table.
> -	 *
> -	 * The fixup_offset is set to the next instruction from the instruction
> -	 * that may fault. The execution will jump to this after handling the
> -	 * fault.
> -	 */
> -	fixup_offset = (long)&ex->fixup - (pc + AARCH64_INSN_SIZE);
> -	if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, fixup_offset))
> -		return -ERANGE;
> -
>   	/*
>   	 * The offsets above have been calculated using the RO buffer but we
>   	 * need to use the R/W buffer for writes.
> @@ -1147,8 +1129,7 @@ static int add_exception_handler(const struct bpf_insn *insn,
>   	if (BPF_CLASS(insn->code) != BPF_LDX)
>   		dst_reg = DONT_CLEAR;
>   
> -	ex->fixup = FIELD_PREP(BPF_FIXUP_OFFSET_MASK, fixup_offset) |
> -		    FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
> +	ex->fixup = FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
>   
>   	ex->type = EX_TYPE_BPF;
>

Nice refactor, looks good to me

Acked-by: Xu Kuohai <xukuohai@huawei.com>


