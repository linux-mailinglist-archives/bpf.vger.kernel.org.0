Return-Path: <bpf+bounces-52249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C48CA406F8
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 10:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC94B16E095
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 09:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2768C206F37;
	Sat, 22 Feb 2025 09:34:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E435B2063F4;
	Sat, 22 Feb 2025 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740216872; cv=none; b=eLIFWDBv2WornKujd9AM2wyBn2dxdVWpGTwQEb3ML3inPWdNswDKtJW/tCCAgb9DN0onZOMzDOCRcx8c8+321m7lHgXMrx+D+qN5DSlf1ewJqxErrmo5E204HkmzYdyJUNogDg8OkQvE8QN4kMnW+OpKrVWhZYc+6lXSAqGfegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740216872; c=relaxed/simple;
	bh=lMJB8OZSs5KheuLu+Yj15l5Y9Os4eQd2g8Oa2EaozC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzLRsiu86cRjw2z9qX8cUPmkRDSZOgAQE+rhcV/gG+LSt9J5wJC3atIqyZ4YGCKTbIVyBCPq+JHEsRc+znidIHtgt+rb8o+eNy0JUnpfoM1QwP8yQ4QOsmy8n/IbaLMAcMyN8sl7XN2xKNPLnrLOSl25ZxbLlDbnxbBreiqtxj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z0MJd5nzDz4f3jt4;
	Sat, 22 Feb 2025 17:34:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 308531A0F20;
	Sat, 22 Feb 2025 17:34:26 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgBH+HghmrlnZoUGEg--.59283S2;
	Sat, 22 Feb 2025 17:34:25 +0800 (CST)
Message-ID: <4f5e8270-e672-40aa-a546-b912cef3e1e9@huaweicloud.com>
Date: Sat, 22 Feb 2025 17:34:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 7/9] bpf, arm64: Support load-acquire and
 store-release instructions
Content-Language: en-US
To: Peilin Ye <yepeilin@google.com>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: bpf@ietf.org, Eduard Zingerman <eddyz87@gmail.com>,
 David Vernet <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan
 <puranjay@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Yingchi Long <longyingchi24s@ict.ac.cn>, Josh Don <joshdon@google.com>,
 Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>,
 Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
References: <cover.1740009184.git.yepeilin@google.com>
 <2a45e43866e9ff2e53e3efd2675c0b027aa07aac.1740009184.git.yepeilin@google.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <2a45e43866e9ff2e53e3efd2675c0b027aa07aac.1740009184.git.yepeilin@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBH+HghmrlnZoUGEg--.59283S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKrWkCrWxtF1rWF1kGF4Uurg_yoW7KF47pr
	4kXa1rGr4kW3ZrWr97XFy29Fs0ya18J3ZIgr1UK3yfWF42qF95GF1fKF1avFWYgryUXrWr
	WF9YvF9FkasrJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07jSiihUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 2/20/2025 9:21 AM, Peilin Ye wrote:
> Support BPF load-acquire (BPF_LOAD_ACQ) and store-release
> (BPF_STORE_REL) instructions in the arm64 JIT compiler.  For example
> (assuming little-endian):
> 
>    db 10 00 00 00 01 00 00  r0 = load_acquire((u64 *)(r1 + 0x0))
>    95 00 00 00 00 00 00 00  exit
> 
>    opcode (0xdb): BPF_ATOMIC | BPF_DW | BPF_STX
>    imm (0x00000100): BPF_LOAD_ACQ
> 
> The JIT compiler would emit an LDAR instruction for the above, e.g.:
> 
>    ldar  x7, [x0]
> 
> Similarly, consider the following 16-bit store-release:
> 
>    cb 21 00 00 10 01 00 00  store_release((u16 *)(r1 + 0x0), w2)
>    95 00 00 00 00 00 00 00  exit
> 
>    opcode (0xcb): BPF_ATOMIC | BPF_H | BPF_STX
>    imm (0x00000110): BPF_STORE_REL
> 
> An STLRH instruction would be emitted, e.g.:
> 
>    stlrh  w1, [x0]
> 
> For a complete mapping:
> 
>    load-acquire     8-bit  LDARB
>   (BPF_LOAD_ACQ)   16-bit  LDARH
>                    32-bit  LDAR (32-bit)
>                    64-bit  LDAR (64-bit)
>    store-release    8-bit  STLRB
>   (BPF_STORE_REL)  16-bit  STLRH
>                    32-bit  STLR (32-bit)
>                    64-bit  STLR (64-bit)
> 
> Arena accesses are supported.
> bpf_jit_supports_insn(..., /*in_arena=*/true) always returns true for
> BPF_LOAD_ACQ and BPF_STORE_REL instructions, as they don't depend on
> ARM64_HAS_LSE_ATOMICS.
> 
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
>   arch/arm64/net/bpf_jit.h      | 20 ++++++++
>   arch/arm64/net/bpf_jit_comp.c | 91 ++++++++++++++++++++++++++++++++---
>   2 files changed, 105 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
> index b22ab2f97a30..a3b0e693a125 100644
> --- a/arch/arm64/net/bpf_jit.h
> +++ b/arch/arm64/net/bpf_jit.h
> @@ -119,6 +119,26 @@
>   	aarch64_insn_gen_load_store_ex(Rt, Rn, Rs, A64_SIZE(sf), \
>   				       AARCH64_INSN_LDST_STORE_REL_EX)
>   
> +/* Load-acquire & store-release */
> +#define A64_LDAR(Rt, Rn, size)  \
> +	aarch64_insn_gen_load_acq_store_rel(Rt, Rn, AARCH64_INSN_SIZE_##size, \
> +					    AARCH64_INSN_LDST_LOAD_ACQ)
> +#define A64_STLR(Rt, Rn, size)  \
> +	aarch64_insn_gen_load_acq_store_rel(Rt, Rn, AARCH64_INSN_SIZE_##size, \
> +					    AARCH64_INSN_LDST_STORE_REL)
> +
> +/* Rt = [Rn] (load acquire) */
> +#define A64_LDARB(Wt, Xn)	A64_LDAR(Wt, Xn, 8)
> +#define A64_LDARH(Wt, Xn)	A64_LDAR(Wt, Xn, 16)
> +#define A64_LDAR32(Wt, Xn)	A64_LDAR(Wt, Xn, 32)
> +#define A64_LDAR64(Xt, Xn)	A64_LDAR(Xt, Xn, 64)
> +
> +/* [Rn] = Rt (store release) */
> +#define A64_STLRB(Wt, Xn)	A64_STLR(Wt, Xn, 8)
> +#define A64_STLRH(Wt, Xn)	A64_STLR(Wt, Xn, 16)
> +#define A64_STLR32(Wt, Xn)	A64_STLR(Wt, Xn, 32)
> +#define A64_STLR64(Xt, Xn)	A64_STLR(Xt, Xn, 64)
> +
>   /*
>    * LSE atomics
>    *
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 8c3b47d9e441..25562bdb8eb5 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -647,6 +647,82 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>   	return 0;
>   }
>   
> +static int emit_atomic_load_store(const struct bpf_insn *insn,
> +				  struct jit_ctx *ctx)
> +{
> +	const s32 imm = insn->imm;
> +	const s16 off = insn->off;
> +	const u8 code = insn->code;
> +	const bool arena = BPF_MODE(code) == BPF_PROBE_ATOMIC;
> +	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
> +	const u8 dst = bpf2a64[insn->dst_reg];
> +	const u8 src = bpf2a64[insn->src_reg];
> +	const u8 tmp = bpf2a64[TMP_REG_1];
> +	u8 reg;
> +
> +	switch (imm) {
> +	case BPF_LOAD_ACQ:
> +		reg = src;
> +		break;
> +	case BPF_STORE_REL:
> +		reg = dst;
> +		break;
> +	default:
> +		pr_err_once("unknown atomic load/store op code %02x\n", imm);
> +		return -EINVAL;
> +	}
> +
> +	if (off) {
> +		emit_a64_add_i(1, tmp, reg, tmp, off, ctx);
> +		reg = tmp;
> +	}
> +	if (arena) {
> +		emit(A64_ADD(1, tmp, reg, arena_vm_base), ctx);
> +		reg = tmp;
> +	}
> +
> +	switch (imm) {
> +	case BPF_LOAD_ACQ:
> +		switch (BPF_SIZE(code)) {
> +		case BPF_B:
> +			emit(A64_LDARB(dst, reg), ctx);
> +			break;
> +		case BPF_H:
> +			emit(A64_LDARH(dst, reg), ctx);
> +			break;
> +		case BPF_W:
> +			emit(A64_LDAR32(dst, reg), ctx);
> +			break;
> +		case BPF_DW:
> +			emit(A64_LDAR64(dst, reg), ctx);
> +			break;
> +		}
> +		break;
> +	case BPF_STORE_REL:
> +		switch (BPF_SIZE(code)) {
> +		case BPF_B:
> +			emit(A64_STLRB(src, reg), ctx);
> +			break;
> +		case BPF_H:
> +			emit(A64_STLRH(src, reg), ctx);
> +			break;
> +		case BPF_W:
> +			emit(A64_STLR32(src, reg), ctx);
> +			break;
> +		case BPF_DW:
> +			emit(A64_STLR64(src, reg), ctx);
> +			break;
> +		}
> +		break;
> +	default:
> +		pr_err_once("unexpected atomic load/store op code %02x\n",
> +			    imm);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   #ifdef CONFIG_ARM64_LSE_ATOMICS
>   static int emit_lse_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
>   {
> @@ -1641,11 +1717,17 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>   			return ret;
>   		break;
>   
> +	case BPF_STX | BPF_ATOMIC | BPF_B:
> +	case BPF_STX | BPF_ATOMIC | BPF_H:
>   	case BPF_STX | BPF_ATOMIC | BPF_W:
>   	case BPF_STX | BPF_ATOMIC | BPF_DW:
> +	case BPF_STX | BPF_PROBE_ATOMIC | BPF_B:
> +	case BPF_STX | BPF_PROBE_ATOMIC | BPF_H:
>   	case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
>   	case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
> -		if (cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
> +		if (bpf_atomic_is_load_store(insn))
> +			ret = emit_atomic_load_store(insn, ctx);
> +		else if (cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
>   			ret = emit_lse_atomic(insn, ctx);
>   		else
>   			ret = emit_ll_sc_atomic(insn, ctx);
> @@ -2667,13 +2749,10 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
>   	if (!in_arena)
>   		return true;
>   	switch (insn->code) {
> -	case BPF_STX | BPF_ATOMIC | BPF_B:
> -	case BPF_STX | BPF_ATOMIC | BPF_H:
>   	case BPF_STX | BPF_ATOMIC | BPF_W:
>   	case BPF_STX | BPF_ATOMIC | BPF_DW:
> -		if (bpf_atomic_is_load_store(insn))
> -			return false;
> -		if (!cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
> +		if (!bpf_atomic_is_load_store(insn) &&
> +		    !cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
>   			return false;
>   	}
>   	return true;


Acked-by: Xu Kuohai <xukuohai@huawei.com>


