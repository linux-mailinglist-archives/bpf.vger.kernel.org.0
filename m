Return-Path: <bpf+bounces-47586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3219FBC01
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 11:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA7F161E62
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7721B3926;
	Tue, 24 Dec 2024 10:07:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6DE19D062;
	Tue, 24 Dec 2024 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735034845; cv=none; b=hLfWV+wWiL39Lgtj+mYxdZSOel2yPSrbCMNGxFkp3hkBUGkJex4/piVly//yRazllc6IBQzKE7sax8iDx1X5Me0+a9XXWuvR/A613OjNyey49HhLdU/tTGlPL2ok/EM9FTwbpDGx8g3evYYK+WDX3ksTSSYjcDcRoH/a2qW8FL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735034845; c=relaxed/simple;
	bh=hhD+3Uj6GvwIEvyXh7wexTCQpFVVqxkrB9VRyvg2PLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzWqLCQap8HZbExdg9XRUHWnDE50/IXbYI0SnJAuOzT6Pz2KU181EjfdTjFT0BMykTPbEauAQFyrUKmil5LlOG/cIiui/s2eWVmbSTtrBKwnx/rbI/B/xGlOQ3KCmYa05kj2pjecnbJYbyxwPQTuFruoz/5CCjBhztRi9LjL53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YHVt85BCZz4f3lWF;
	Tue, 24 Dec 2024 18:06:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7888F1A06D7;
	Tue, 24 Dec 2024 18:07:17 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgA35ODSh2pneVTSFQ--.56806S2;
	Tue, 24 Dec 2024 18:07:15 +0800 (CST)
Message-ID: <f704019d-a8fa-4cf5-a606-9d8328360a3e@huaweicloud.com>
Date: Tue, 24 Dec 2024 18:07:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v1 2/4] bpf: Introduce load-acquire and
 store-release instructions
To: Peilin Ye <yepeilin@google.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Josh Don <joshdon@google.com>,
 Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>,
 Benjamin Segall <bsegall@google.com>, David Vernet <dvernet@meta.com>,
 Dave Marchevsky <davemarchevsky@meta.com>, linux-kernel@vger.kernel.org
References: <cover.1734742802.git.yepeilin@google.com>
 <6ca65dc2916dba7490c4fd7a8b727b662138d606.1734742802.git.yepeilin@google.com>
Content-Language: en-US
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <6ca65dc2916dba7490c4fd7a8b727b662138d606.1734742802.git.yepeilin@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgA35ODSh2pneVTSFQ--.56806S2
X-Coremail-Antispam: 1UD129KBjvAXoW3tw18GF4DCr1UGr45urWktFb_yoW8Zr1fGo
	Z7KF1xur48Gr97CFWakry3AFyxXwn7Gwn2vrW3Jrs5Cw4xA3sF9r47J3yxAa4fXFWUJ3yk
	Gw13Ka4j9a9IyFWrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jxCztUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 12/21/2024 9:25 AM, Peilin Ye wrote:
> Introduce BPF instructions with load-acquire and store-release
> semantics, as discussed in [1].  The following new flags are defined:
> 
>    BPF_ATOMIC_LOAD         0x10
>    BPF_ATOMIC_STORE        0x20
>    BPF_ATOMIC_TYPE(imm)    ((imm) & 0xf0)
> 
>    BPF_RELAXED        0x0
>    BPF_ACQUIRE        0x1
>    BPF_RELEASE        0x2
>    BPF_ACQ_REL        0x3
>    BPF_SEQ_CST        0x4
> 
>    BPF_LOAD_ACQ       (BPF_ATOMIC_LOAD | BPF_ACQUIRE)
>    BPF_STORE_REL      (BPF_ATOMIC_STORE | BPF_RELEASE)
> 
> A "load-acquire" is a BPF_STX | BPF_ATOMIC instruction with the 'imm'
> field set to BPF_LOAD_ACQ (0x11).
> 
> Similarly, a "store-release" is a BPF_STX | BPF_ATOMIC instruction with
> the 'imm' field set to BPF_STORE_REL (0x22).
> 
> Unlike existing atomic operations that only support BPF_W (32-bit) and
> BPF_DW (64-bit) size modifiers, load-acquires and store-releases also
> support BPF_B (8-bit) and BPF_H (16-bit).  An 8- or 16-bit load-acquire
> zero-extends the value before writing it to a 32-bit register, just like
> ARM64 instruction LDARH and friends.
> 
> As an example, consider the following 64-bit load-acquire BPF
> instruction (assuming little-endian from now on):
> 
>    db 10 00 00 11 00 00 00  r0 = load_acquire((u64 *)(r1 + 0x0))
> 
>    opcode (0xdb): BPF_ATOMIC | BPF_DW | BPF_STX
>    imm (0x00000011): BPF_LOAD_ACQ
> 
> For ARM64, an LDAR instruction will be generated by the JIT compiler for
> the above:
> 
>    ldar  x7, [x0]
> 
> Similarly, a 16-bit BPF store-release:
> 
>    cb 21 00 00 22 00 00 00  store_release((u16 *)(r1 + 0x0), w2)
> 
>    opcode (0xcb): BPF_ATOMIC | BPF_H | BPF_STX
>    imm (0x00000022): BPF_STORE_REL
> 
> An STLRH will be generated for it:
> 
>    stlrh  w1, [x0]
> 
> For a complete mapping for ARM64:
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
> Reviewed-by: Josh Don <joshdon@google.com>
> Reviewed-by: Barret Rhoden <brho@google.com>
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
>   arch/arm64/include/asm/insn.h  |  8 ++++
>   arch/arm64/lib/insn.c          | 34 ++++++++++++++
>   arch/arm64/net/bpf_jit.h       | 20 ++++++++
>   arch/arm64/net/bpf_jit_comp.c  | 85 +++++++++++++++++++++++++++++++++-
>   include/uapi/linux/bpf.h       | 13 ++++++
>   kernel/bpf/core.c              | 41 +++++++++++++++-
>   kernel/bpf/disasm.c            | 14 ++++++
>   kernel/bpf/verifier.c          | 32 +++++++++----
>   tools/include/uapi/linux/bpf.h | 13 ++++++
>   9 files changed, 246 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index e390c432f546..bbfdbe570ff6 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -188,8 +188,10 @@ enum aarch64_insn_ldst_type {
>   	AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX,
>   	AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX,
>   	AARCH64_INSN_LDST_STORE_PAIR_POST_INDEX,
> +	AARCH64_INSN_LDST_LOAD_ACQ,
>   	AARCH64_INSN_LDST_LOAD_EX,
>   	AARCH64_INSN_LDST_LOAD_ACQ_EX,
> +	AARCH64_INSN_LDST_STORE_REL,
>   	AARCH64_INSN_LDST_STORE_EX,
>   	AARCH64_INSN_LDST_STORE_REL_EX,
>   	AARCH64_INSN_LDST_SIGNED_LOAD_IMM_OFFSET,
> @@ -351,6 +353,8 @@ __AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
>   __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
>   __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
>   __AARCH64_INSN_FUNCS(exclusive,	0x3F800000, 0x08000000)
> +__AARCH64_INSN_FUNCS(load_acq,  0x3FC08000, 0x08C08000)
> +__AARCH64_INSN_FUNCS(store_rel, 0x3FC08000, 0x08808000)


I checked Arm Architecture Reference Manual [1].

Section C6.2.{168,169,170,371,372,373} state that field Rt2 (bits 10-14) and
Rs (bits 16-20) for LDARB/LDARH/LDAR/STLRB/STLRH and no offset type STLR
instructions are fixed to (1).

Section C2.2.2 explains that (1) means a Should-Be-One (SBO) bit.

And the Glossary section says "Arm strongly recommends that software writes
the field as all 1s. If software writes a value that is not all 1s, it must
expect an UNPREDICTABLE or CONSTRAINED UNPREDICTABLE result."

Although the pre-index type of STLR is an excetpion, it is not used in this
series. Therefore, both bits 10-14 and 16-20 in mask and value should be set
to 1s.

[1] https://developer.arm.com/documentation/ddi0487/latest/


>   __AARCH64_INSN_FUNCS(load_ex,	0x3F400000, 0x08400000)
>   __AARCH64_INSN_FUNCS(store_ex,	0x3F400000, 0x08000000)
>   __AARCH64_INSN_FUNCS(mops,	0x3B200C00, 0x19000400)
> @@ -602,6 +606,10 @@ u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
>   				     int offset,
>   				     enum aarch64_insn_variant variant,
>   				     enum aarch64_insn_ldst_type type);
> +u32 aarch64_insn_gen_load_acq_store_rel(enum aarch64_insn_register reg,
> +					enum aarch64_insn_register base,
> +					enum aarch64_insn_size_type size,
> +					enum aarch64_insn_ldst_type type);
>   u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
>   				   enum aarch64_insn_register base,
>   				   enum aarch64_insn_register state,
> diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
> index b008a9b46a7f..80e5b191d96a 100644
> --- a/arch/arm64/lib/insn.c
> +++ b/arch/arm64/lib/insn.c
> @@ -540,6 +540,40 @@ u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
>   					     offset >> shift);
>   }
>   
> +u32 aarch64_insn_gen_load_acq_store_rel(enum aarch64_insn_register reg,
> +					enum aarch64_insn_register base,
> +					enum aarch64_insn_size_type size,
> +					enum aarch64_insn_ldst_type type)
> +{
> +	u32 insn;
> +
> +	switch (type) {
> +	case AARCH64_INSN_LDST_LOAD_ACQ:
> +		insn = aarch64_insn_get_load_acq_value();
> +		break;
> +	case AARCH64_INSN_LDST_STORE_REL:
> +		insn = aarch64_insn_get_store_rel_value();
> +		break;
> +	default:
> +		pr_err("%s: unknown load-acquire/store-release encoding %d\n", __func__, type);
> +		return AARCH64_BREAK_FAULT;
> +	}
> +
> +	insn = aarch64_insn_encode_ldst_size(size, insn);
> +
> +	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn,
> +					    reg);
> +
> +	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn,
> +					    base);
> +
> +	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT2, insn,
> +					    AARCH64_INSN_REG_ZR);
> +
> +	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RS, insn,
> +					    AARCH64_INSN_REG_ZR);

As explained above, RS and RT2 fields should be fixed to 1s.

> +}
> +
>   u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
>   				   enum aarch64_insn_register base,
>   				   enum aarch64_insn_register state,
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
> index 66708b95493a..15fc0f391f14 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -634,6 +634,80 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>   	return 0;
>   }
>   
> +static inline bool is_atomic_load_store(const s32 imm)
> +{
> +	const s32 type = BPF_ATOMIC_TYPE(imm);
> +
> +	return type == BPF_ATOMIC_LOAD || type == BPF_ATOMIC_STORE;
> +}
> +
> +static int emit_atomic_load_store(const struct bpf_insn *insn, struct jit_ctx *ctx)
> +{
> +	const s16 off = insn->off;
> +	const u8 code = insn->code;
> +	const bool arena = BPF_MODE(code) == BPF_PROBE_ATOMIC;
> +	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
> +	const u8 dst = bpf2a64[insn->dst_reg];
> +	const u8 src = bpf2a64[insn->src_reg];
> +	const u8 tmp = bpf2a64[TMP_REG_1];
> +	u8 ptr;
> +
> +	if (BPF_ATOMIC_TYPE(insn->imm) == BPF_ATOMIC_LOAD)
> +		ptr = src;
> +	else
> +		ptr = dst;
> +
> +	if (off) {
> +		emit_a64_mov_i(true, tmp, off, ctx);
> +		emit(A64_ADD(true, tmp, tmp, ptr), ctx);

The mov and add instructions can be optimized to a single A64_ADD_I
if is_addsub_imm(off) is true.

> +		ptr = tmp;
> +	}
> +	if (arena) {
> +		emit(A64_ADD(true, tmp, ptr, arena_vm_base), ctx);
> +		ptr = tmp;
> +	}
> +
> +	switch (insn->imm) {
> +	case BPF_LOAD_ACQ:
> +		switch (BPF_SIZE(code)) {
> +		case BPF_B:
> +			emit(A64_LDARB(dst, ptr), ctx);
> +			break;
> +		case BPF_H:
> +			emit(A64_LDARH(dst, ptr), ctx);
> +			break;
> +		case BPF_W:
> +			emit(A64_LDAR32(dst, ptr), ctx);
> +			break;
> +		case BPF_DW:
> +			emit(A64_LDAR64(dst, ptr), ctx);
> +			break;
> +		}
> +		break;
> +	case BPF_STORE_REL:
> +		switch (BPF_SIZE(code)) {
> +		case BPF_B:
> +			emit(A64_STLRB(src, ptr), ctx);
> +			break;
> +		case BPF_H:
> +			emit(A64_STLRH(src, ptr), ctx);
> +			break;
> +		case BPF_W:
> +			emit(A64_STLR32(src, ptr), ctx);
> +			break;
> +		case BPF_DW:
> +			emit(A64_STLR64(src, ptr), ctx);
> +			break;
> +		}
> +		break;
> +	default:
> +		pr_err_once("unknown atomic load/store op code %02x\n", insn->imm);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   #ifdef CONFIG_ARM64_LSE_ATOMICS
>   static int emit_lse_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
>   {
> @@ -1641,11 +1715,17 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
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
> +		if (is_atomic_load_store(insn->imm))
> +			ret = emit_atomic_load_store(insn, ctx);
> +		else if (cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
>   			ret = emit_lse_atomic(insn, ctx);
>   		else
>   			ret = emit_ll_sc_atomic(insn, ctx);
> @@ -2669,7 +2749,8 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
>   	switch (insn->code) {
>   	case BPF_STX | BPF_ATOMIC | BPF_W:
>   	case BPF_STX | BPF_ATOMIC | BPF_DW:
> -		if (!cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
> +		if (!is_atomic_load_store(insn->imm) &&
> +		    !cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
>   			return false;
>   	}
>   	return true;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 2acf9b336371..4a20a125eb46 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -51,6 +51,19 @@
>   #define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
>   #define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
>   
> +#define BPF_ATOMIC_LOAD		0x10
> +#define BPF_ATOMIC_STORE	0x20
> +#define BPF_ATOMIC_TYPE(imm)	((imm) & 0xf0)
> +
> +#define BPF_RELAXED	0x00
> +#define BPF_ACQUIRE	0x01
> +#define BPF_RELEASE	0x02
> +#define BPF_ACQ_REL	0x03
> +#define BPF_SEQ_CST	0x04
> +
> +#define BPF_LOAD_ACQ	(BPF_ATOMIC_LOAD | BPF_ACQUIRE)		/* load-acquire */
> +#define BPF_STORE_REL	(BPF_ATOMIC_STORE | BPF_RELEASE)	/* store-release */
> +
>   enum bpf_cond_pseudo_jmp {
>   	BPF_MAY_GOTO = 0,
>   };
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index da729cbbaeb9..ab082ab9d535 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1663,14 +1663,17 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
>   	INSN_3(JMP, JSET, K),			\
>   	INSN_2(JMP, JA),			\
>   	INSN_2(JMP32, JA),			\
> +	/* Atomic operations. */		\
> +	INSN_3(STX, ATOMIC, B),			\
> +	INSN_3(STX, ATOMIC, H),			\
> +	INSN_3(STX, ATOMIC, W),			\
> +	INSN_3(STX, ATOMIC, DW),		\
>   	/* Store instructions. */		\
>   	/*   Register based. */			\
>   	INSN_3(STX, MEM,  B),			\
>   	INSN_3(STX, MEM,  H),			\
>   	INSN_3(STX, MEM,  W),			\
>   	INSN_3(STX, MEM,  DW),			\
> -	INSN_3(STX, ATOMIC, W),			\
> -	INSN_3(STX, ATOMIC, DW),		\
>   	/*   Immediate based. */		\
>   	INSN_3(ST, MEM, B),			\
>   	INSN_3(ST, MEM, H),			\
> @@ -2169,6 +2172,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>   
>   	STX_ATOMIC_DW:
>   	STX_ATOMIC_W:
> +	STX_ATOMIC_H:
> +	STX_ATOMIC_B:
>   		switch (IMM) {
>   		ATOMIC_ALU_OP(BPF_ADD, add)
>   		ATOMIC_ALU_OP(BPF_AND, and)
> @@ -2196,6 +2201,38 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>   					(atomic64_t *)(unsigned long) (DST + insn->off),
>   					(u64) BPF_R0, (u64) SRC);
>   			break;
> +		case BPF_LOAD_ACQ:
> +			switch (BPF_SIZE(insn->code)) {
> +#define LOAD_ACQUIRE(SIZEOP, SIZE)				\
> +			case BPF_##SIZEOP:			\
> +				DST = (SIZE)smp_load_acquire(	\
> +					(SIZE *)(unsigned long)(SRC + insn->off));	\
> +				break;
> +			LOAD_ACQUIRE(B,   u8)
> +			LOAD_ACQUIRE(H,  u16)
> +			LOAD_ACQUIRE(W,  u32)
> +			LOAD_ACQUIRE(DW, u64)
> +#undef LOAD_ACQUIRE
> +			default:
> +				goto default_label;
> +			}
> +			break;
> +		case BPF_STORE_REL:
> +			switch (BPF_SIZE(insn->code)) {
> +#define STORE_RELEASE(SIZEOP, SIZE)			\
> +			case BPF_##SIZEOP:		\
> +				smp_store_release(	\
> +					(SIZE *)(unsigned long)(DST + insn->off), (SIZE)SRC);	\
> +				break;
> +			STORE_RELEASE(B,   u8)
> +			STORE_RELEASE(H,  u16)
> +			STORE_RELEASE(W,  u32)
> +			STORE_RELEASE(DW, u64)
> +#undef STORE_RELEASE
> +			default:
> +				goto default_label;
> +			}
> +			break;
>   
>   		default:
>   			goto default_label;
> diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> index 309c4aa1b026..2a354a44f209 100644
> --- a/kernel/bpf/disasm.c
> +++ b/kernel/bpf/disasm.c
> @@ -267,6 +267,20 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
>   				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
>   				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
>   				insn->dst_reg, insn->off, insn->src_reg);
> +		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> +			   insn->imm == BPF_LOAD_ACQ) {
> +			verbose(cbs->private_data, "(%02x) %s%d = load_acquire((%s *)(r%d %+d))\n",
> +				insn->code,
> +				BPF_SIZE(insn->code) == BPF_DW ? "r" : "w", insn->dst_reg,
> +				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
> +				insn->src_reg, insn->off);
> +		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> +			   insn->imm == BPF_STORE_REL) {
> +			verbose(cbs->private_data, "(%02x) store_release((%s *)(r%d %+d), %s%d)\n",
> +				insn->code,
> +				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
> +				insn->dst_reg, insn->off,
> +				BPF_SIZE(insn->code) == BPF_DW ? "r" : "w", insn->src_reg);
>   		} else {
>   			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
>   		}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fa40a0440590..dc3ecc925b97 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3480,7 +3480,7 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   	}
>   
>   	if (class == BPF_STX) {
> -		/* BPF_STX (including atomic variants) has multiple source
> +		/* BPF_STX (including atomic variants) has one or more source
>   		 * operands, one of which is a ptr. Check whether the caller is
>   		 * asking about it.
>   		 */
> @@ -7550,6 +7550,8 @@ static int check_load(struct bpf_verifier_env *env, struct bpf_insn *insn, const
>   
>   static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
>   {
> +	const int bpf_size = BPF_SIZE(insn->code);
> +	bool write_only = false;
>   	int load_reg;
>   	int err;
>   
> @@ -7564,17 +7566,21 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>   	case BPF_XOR | BPF_FETCH:
>   	case BPF_XCHG:
>   	case BPF_CMPXCHG:
> +		if (bpf_size != BPF_W && bpf_size != BPF_DW) {
> +			verbose(env, "invalid atomic operand size\n");
> +			return -EINVAL;
> +		}
> +		break;
> +	case BPF_LOAD_ACQ:
> +		return check_load(env, insn, "atomic");
> +	case BPF_STORE_REL:
> +		write_only = true;
>   		break;
>   	default:
>   		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
>   		return -EINVAL;
>   	}
>   
> -	if (BPF_SIZE(insn->code) != BPF_W && BPF_SIZE(insn->code) != BPF_DW) {
> -		verbose(env, "invalid atomic operand size\n");
> -		return -EINVAL;
> -	}
> -
>   	/* check src1 operand */
>   	err = check_reg_arg(env, insn->src_reg, SRC_OP);
>   	if (err)
> @@ -7615,6 +7621,9 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>   		return -EACCES;
>   	}
>   
> +	if (write_only)
> +		goto skip_read_check;
> +
>   	if (insn->imm & BPF_FETCH) {
>   		if (insn->imm == BPF_CMPXCHG)
>   			load_reg = BPF_REG_0;
> @@ -7636,14 +7645,15 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>   	 * case to simulate the register fill.
>   	 */
>   	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> -			       BPF_SIZE(insn->code), BPF_READ, -1, true, false);
> +			       bpf_size, BPF_READ, -1, true, false);
>   	if (!err && load_reg >= 0)
>   		err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> -				       BPF_SIZE(insn->code), BPF_READ, load_reg,
> -				       true, false);
> +				       bpf_size, BPF_READ, load_reg, true,
> +				       false);
>   	if (err)
>   		return err;
>   
> +skip_read_check:
>   	if (is_arena_reg(env, insn->dst_reg)) {
>   		err = save_aux_ptr_type(env, PTR_TO_ARENA, false);
>   		if (err)
> @@ -20320,7 +20330,9 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>   			   insn->code == (BPF_ST | BPF_MEM | BPF_W) ||
>   			   insn->code == (BPF_ST | BPF_MEM | BPF_DW)) {
>   			type = BPF_WRITE;
> -		} else if ((insn->code == (BPF_STX | BPF_ATOMIC | BPF_W) ||
> +		} else if ((insn->code == (BPF_STX | BPF_ATOMIC | BPF_B) ||
> +			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_H) ||
> +			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_W) ||
>   			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_DW)) &&
>   			   env->insn_aux_data[i + delta].ptr_type == PTR_TO_ARENA) {
>   			insn->code = BPF_STX | BPF_PROBE_ATOMIC | BPF_SIZE(insn->code);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 2acf9b336371..4a20a125eb46 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -51,6 +51,19 @@
>   #define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
>   #define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
>   
> +#define BPF_ATOMIC_LOAD		0x10
> +#define BPF_ATOMIC_STORE	0x20
> +#define BPF_ATOMIC_TYPE(imm)	((imm) & 0xf0)
> +
> +#define BPF_RELAXED	0x00
> +#define BPF_ACQUIRE	0x01
> +#define BPF_RELEASE	0x02
> +#define BPF_ACQ_REL	0x03
> +#define BPF_SEQ_CST	0x04
> +
> +#define BPF_LOAD_ACQ	(BPF_ATOMIC_LOAD | BPF_ACQUIRE)		/* load-acquire */
> +#define BPF_STORE_REL	(BPF_ATOMIC_STORE | BPF_RELEASE)	/* store-release */
> +
>   enum bpf_cond_pseudo_jmp {
>   	BPF_MAY_GOTO = 0,
>   };


I think it's better to split the arm64 related changes into two separate
patches: one for adding the arm64 LDAR/STLR instruction encodings, and
the other for adding jit support.


