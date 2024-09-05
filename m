Return-Path: <bpf+bounces-38993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6CE96D2E2
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 11:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2C51C24899
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 09:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38351198822;
	Thu,  5 Sep 2024 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrjpUrpF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CBE197A96
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527629; cv=none; b=hvFyncVWfMJmEPyzTt7jvSa3pqNxGF+p3rym8GuiMGmDqjCSRt5KO7F23FfJmT/2XOQZbKykVmA5mQtCGOhvDuY9jLBYpsHt+GwaEdNLPt2X8KiRvnDkwIw9ssCOK4RJY4JDskO/RdQvBxm7B9aLMgTEOpy3Cq4aLN0slI9LTO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527629; c=relaxed/simple;
	bh=0jDQLBhts52aBg+kgkT6SMQxIcqJy72fCXRiOdf0PIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lSJl6MdKr9YBzXrL6r6DuZfeZpOnI89qmuOzrOoPNs2F+3HDs/xpE0ury+H3oKQsZPJJgQ8M/dwEgZ/eIFqfKIMl+5ZpS9c34HkHbOcd1Tnl+zJkhRODYmi5wNuOKw7pL46bYtMRd87MQhSfUtOyyKCqj5h4u0OV9sENCejAGBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrjpUrpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9DEC4CEC3;
	Thu,  5 Sep 2024 09:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725527629;
	bh=0jDQLBhts52aBg+kgkT6SMQxIcqJy72fCXRiOdf0PIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HrjpUrpFc/EdbMWQnHmYU97oORBBTVZNswILRF9KGc+Okgeo9wmriIwOy1RjS4SXi
	 7SrVDnG0xGWgyBRCVvYLn8BUm2XfE+mnA34zSBVkjUv9928zK5AQT+ZJNBWSM4Q5XN
	 deDQD5G86hrT2WZh1DbHBLbSeiojW3bBo5apFXujTdXzZqICLbhW//zEwbj6PXWmc4
	 ekKTiw93DZpeUYOgDpxFF27eXQw35eln6mXx8eyN0qF1d/Es1eGO8U4dS00avDRfFf
	 PuWTpJrwESwHmMKjpSkXBVrMQ497Wj1oUc4ckWCK0jatggSSvb+37Zgl5LRCNuIPav
	 o85ChfRsdejUQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Xu Kuohai <xukuohai@huaweicloud.com>, Leon Hwang <leon.hwang@linux.dev>,
 bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 toke@redhat.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 eddyz87@gmail.com, iii@linux.ibm.com, kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 2/4] bpf, arm64: Fix tailcall infinite loop
 caused by freplace
In-Reply-To: <0f3c9711-3f1c-4678-9e0a-bd825c6fb78f@huaweicloud.com>
References: <20240825130943.7738-1-leon.hwang@linux.dev>
 <20240825130943.7738-3-leon.hwang@linux.dev>
 <a9ce98d0-adfb-4ed9-8500-f378fe44d634@huaweicloud.com>
 <0900df03-b1cd-41fb-be04-278e135cc730@linux.dev>
 <0f3c9711-3f1c-4678-9e0a-bd825c6fb78f@huaweicloud.com>
Date: Thu, 05 Sep 2024 09:13:43 +0000
Message-ID: <mb61ped5ysbso.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Xu Kuohai <xukuohai@huaweicloud.com> writes:

> On 8/27/2024 10:23 AM, Leon Hwang wrote:
>>=20
>>=20
>> On 26/8/24 22:32, Xu Kuohai wrote:
>>> On 8/25/2024 9:09 PM, Leon Hwang wrote:
>>>> Like "bpf, x64: Fix tailcall infinite loop caused by freplace", the sa=
me
>>>> issue happens on arm64, too.
>>>>
>>=20
>> [...]
>>=20
>>>
>>> This patch makes arm64 jited prologue even more complex. I've posted a
>>> series [1]
>>> to simplify the arm64 jited prologue/epilogue. I think we can fix this
>>> issue based
>>> on [1]. I'll give it a try.
>>>
>>> [1]
>>> https://lore.kernel.org/bpf/20240826071624.350108-1-xukuohai@huaweiclou=
d.com/
>>>
>>=20
>> Your patch series seems great. We can fix it based on it.
>>=20
>> Please notify me if you have a successful try.
>>=20
>
> I think the complexity arises from having to decide whether
> to initialize or keep the tail counter value in the prologue.
>
> To get rid of this complexity, a straightforward idea is to
> move the tail call counter initialization to the entry of
> bpf world, and in the bpf world, we only increase and check
> the tail call counter, never save/restore or set it. The
> "entry of the bpf world" here refers to mechanisms like
> bpf_prog_run, bpf dispatcher, or bpf trampoline that
> allows bpf prog to be invoked from C function.
>
> Below is a rough POC diff for arm64 that could pass all
> of your tests. The tail call counter is held in callee-saved
> register x26, and is set to 0 by arch_run_bpf.

I like this approach as it removes all the complexity of handling tcc in
different cases. Can we go ahead with this for arm64 and make
arch_run_bpf a weak function and let other architectures override this
if they want to use a similar approach to this and if other archs want to
do something else they can skip implementing arch_run_bpf.

Thanks,
Puranjay

>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 8aa32cb140b9..2c0f7daf1655 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -26,7 +26,7 @@
>
>   #define TMP_REG_1 (MAX_BPF_JIT_REG + 0)
>   #define TMP_REG_2 (MAX_BPF_JIT_REG + 1)
> -#define TCCNT_PTR (MAX_BPF_JIT_REG + 2)
> +#define TCALL_CNT (MAX_BPF_JIT_REG + 2)
>   #define TMP_REG_3 (MAX_BPF_JIT_REG + 3)
>   #define ARENA_VM_START (MAX_BPF_JIT_REG + 5)
>
> @@ -63,7 +63,7 @@ static const int bpf2a64[] =3D {
>   	[TMP_REG_2] =3D A64_R(11),
>   	[TMP_REG_3] =3D A64_R(12),
>   	/* tail_call_cnt_ptr */
> -	[TCCNT_PTR] =3D A64_R(26),
> +	[TCALL_CNT] =3D A64_R(26), // x26 is used to hold tail call counter
>   	/* temporary register for blinding constants */
>   	[BPF_REG_AX] =3D A64_R(9),
>   	/* callee saved register for kern_vm_start address */
> @@ -286,19 +286,6 @@ static bool is_lsi_offset(int offset, int scale)
>    *      // PROLOGUE_OFFSET
>    *	// save callee-saved registers
>    */
> -static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx)
> -{
> -	const bool is_main_prog =3D !bpf_is_subprog(ctx->prog);
> -	const u8 ptr =3D bpf2a64[TCCNT_PTR];
> -
> -	if (is_main_prog) {
> -		/* Initialize tail_call_cnt. */
> -		emit(A64_PUSH(A64_ZR, ptr, A64_SP), ctx);
> -		emit(A64_MOV(1, ptr, A64_SP), ctx);
> -	} else
> -		emit(A64_PUSH(ptr, ptr, A64_SP), ctx);
> -}
> -
>   static void find_used_callee_regs(struct jit_ctx *ctx)
>   {
>   	int i;
> @@ -419,7 +406,7 @@ static void pop_callee_regs(struct jit_ctx *ctx)
>   #define POKE_OFFSET (BTI_INSNS + 1)
>
>   /* Tail call offset to jump into */
> -#define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 4)
> +#define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 2)
>
>   static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>   {
> @@ -473,8 +460,6 @@ static int build_prologue(struct jit_ctx *ctx, bool e=
bpf_from_cbpf)
>   		emit(A64_PUSH(A64_FP, A64_LR, A64_SP), ctx);
>   		emit(A64_MOV(1, A64_FP, A64_SP), ctx);
>
> -		prepare_bpf_tail_call_cnt(ctx);
> -
>   		if (!ebpf_from_cbpf && is_main_prog) {
>   			cur_offset =3D ctx->idx - idx0;
>   			if (cur_offset !=3D PROLOGUE_OFFSET) {
> @@ -499,7 +484,7 @@ static int build_prologue(struct jit_ctx *ctx, bool e=
bpf_from_cbpf)
>   		 *
>   		 * 12 registers are on the stack
>   		 */
> -		emit(A64_SUB_I(1, A64_SP, A64_FP, 96), ctx);
> +		emit(A64_SUB_I(1, A64_SP, A64_FP, 80), ctx);
>   	}
>
>   	if (ctx->fp_used)
> @@ -527,8 +512,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>
>   	const u8 tmp =3D bpf2a64[TMP_REG_1];
>   	const u8 prg =3D bpf2a64[TMP_REG_2];
> -	const u8 tcc =3D bpf2a64[TMP_REG_3];
> -	const u8 ptr =3D bpf2a64[TCCNT_PTR];
> +	const u8 tcc =3D bpf2a64[TCALL_CNT];
>   	size_t off;
>   	__le32 *branch1 =3D NULL;
>   	__le32 *branch2 =3D NULL;
> @@ -546,16 +530,15 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>   	emit(A64_NOP, ctx);
>
>   	/*
> -	 * if ((*tail_call_cnt_ptr) >=3D MAX_TAIL_CALL_CNT)
> +	 * if (tail_call_cnt >=3D MAX_TAIL_CALL_CNT)
>   	 *     goto out;
>   	 */
>   	emit_a64_mov_i64(tmp, MAX_TAIL_CALL_CNT, ctx);
> -	emit(A64_LDR64I(tcc, ptr, 0), ctx);
>   	emit(A64_CMP(1, tcc, tmp), ctx);
>   	branch2 =3D ctx->image + ctx->idx;
>   	emit(A64_NOP, ctx);
>
> -	/* (*tail_call_cnt_ptr)++; */
> +	/* tail_call_cnt++; */
>   	emit(A64_ADD_I(1, tcc, tcc, 1), ctx);
>
>   	/* prog =3D array->ptrs[index];
> @@ -570,9 +553,6 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>   	branch3 =3D ctx->image + ctx->idx;
>   	emit(A64_NOP, ctx);
>
> -	/* Update tail_call_cnt if the slot is populated. */
> -	emit(A64_STR64I(tcc, ptr, 0), ctx);
> -
>   	/* restore SP */
>   	if (ctx->stack_size)
>   		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
> @@ -793,6 +773,27 @@ asm (
>   "	.popsection\n"
>   );
>
> +unsigned int arch_run_bpf(const void *ctx, const struct bpf_insn *insnsi=
, bpf_func_t bpf_func);
> +asm (
> +"	.pushsection .text, \"ax\", @progbits\n"
> +"	.global arch_run_bpf\n"
> +"	.type arch_run_bpf, %function\n"
> +"arch_run_bpf:\n"
> +#if IS_ENABLED(CONFIG_ARM64_BTI_KERNEL)
> +"	bti j\n"
> +#endif
> +"	stp x29, x30, [sp, #-16]!\n"
> +"	stp xzr, x26, [sp, #-16]!\n"
> +"	mov x26, #0\n"
> +"	blr x2\n"
> +"	ldp xzr, x26, [sp], #16\n"
> +"	ldp x29, x30, [sp], #16\n"
> +"	ret x30\n"
> +"	.size arch_run_bpf, . - arch_run_bpf\n"
> +"	.popsection\n"
> +);
> +EXPORT_SYMBOL_GPL(arch_run_bpf);
> +
>   /* build a plt initialized like this:
>    *
>    * plt:
> @@ -826,7 +827,6 @@ static void build_plt(struct jit_ctx *ctx)
>   static void build_epilogue(struct jit_ctx *ctx)
>   {
>   	const u8 r0 =3D bpf2a64[BPF_REG_0];
> -	const u8 ptr =3D bpf2a64[TCCNT_PTR];
>
>   	/* We're done with BPF stack */
>   	if (ctx->stack_size)
> @@ -834,8 +834,6 @@ static void build_epilogue(struct jit_ctx *ctx)
>
>   	pop_callee_regs(ctx);
>
> -	emit(A64_POP(A64_ZR, ptr, A64_SP), ctx);
> -
>   	/* Restore FP/LR registers */
>   	emit(A64_POP(A64_FP, A64_LR, A64_SP), ctx);
>
> @@ -2066,6 +2064,8 @@ static int prepare_trampoline(struct jit_ctx *ctx, =
struct bpf_tramp_image *im,
>   	bool save_ret;
>   	__le32 **branches =3D NULL;
>
> +	bool target_is_bpf =3D is_bpf_text_address((unsigned long)func_addr);
> +
>   	/* trampoline stack layout:
>   	 *                  [ parent ip         ]
>   	 *                  [ FP                ]
> @@ -2133,6 +2133,11 @@ static int prepare_trampoline(struct jit_ctx *ctx,=
 struct bpf_tramp_image *im,
>   	 */
>   	emit_bti(A64_BTI_JC, ctx);
>
> +	if (!target_is_bpf) {
> +		emit(A64_PUSH(A64_ZR, A64_R(26), A64_SP), ctx);
> +		emit(A64_MOVZ(1, A64_R(26), 0, 0), ctx);
> +	}
> +
>   	/* frame for parent function */
>   	emit(A64_PUSH(A64_FP, A64_R(9), A64_SP), ctx);
>   	emit(A64_MOV(1, A64_FP, A64_SP), ctx);
> @@ -2226,6 +2231,8 @@ static int prepare_trampoline(struct jit_ctx *ctx, =
struct bpf_tramp_image *im,
>   	/* pop frames  */
>   	emit(A64_POP(A64_FP, A64_LR, A64_SP), ctx);
>   	emit(A64_POP(A64_FP, A64_R(9), A64_SP), ctx);
> +	if (!target_is_bpf)
> +		emit(A64_POP(A64_ZR, A64_R(26), A64_SP), ctx);
>
>   	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
>   		/* skip patched function, return to parent */
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index dc63083f76b7..8660d15dd50c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1244,12 +1244,14 @@ struct bpf_dispatcher {
>   #define __bpfcall __nocfi
>   #endif
>
> +unsigned int arch_run_bpf(const void *ctx, const struct bpf_insn *insnsi=
, bpf_func_t bpf_func);
> +
>   static __always_inline __bpfcall unsigned int bpf_dispatcher_nop_func(
>   	const void *ctx,
>   	const struct bpf_insn *insnsi,
>   	bpf_func_t bpf_func)
>   {
> -	return bpf_func(ctx, insnsi);
> +	return arch_run_bpf(ctx, insnsi, bpf_func);
>   }
>
>   /* the implementation of the opaque uapi struct bpf_dynptr */
> @@ -1317,7 +1319,7 @@ int arch_prepare_bpf_dispatcher(void *image, void *=
buf, s64 *funcs, int num_func
>   #else
>   #define __BPF_DISPATCHER_SC_INIT(name)
>   #define __BPF_DISPATCHER_SC(name)
> -#define __BPF_DISPATCHER_CALL(name)		bpf_func(ctx, insnsi)
> +#define __BPF_DISPATCHER_CALL(name)		arch_run_bpf(ctx, insnsi, bpf_func);
>   #define __BPF_DISPATCHER_UPDATE(_d, _new)
>   #endif
>
>> Thanks,
>> Leon

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZtl2SBQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nREGAQCO0v8WGNqhOO9ocycOaililGA3i9Gu
RW5pPyZjzBqFYgEA0PGGL4/ufC8tG2Feh0bmv6YXfG7V/rfdo2HBnyxb7AY=
=q6va
-----END PGP SIGNATURE-----
--=-=-=--

