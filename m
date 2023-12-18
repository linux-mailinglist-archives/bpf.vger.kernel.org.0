Return-Path: <bpf+bounces-18176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2F8816B7A
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 11:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25121F22FA7
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 10:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB7F18E2D;
	Mon, 18 Dec 2023 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jWVsRnIY"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73E61A5AE
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ict6ujVKU9AnPJz7b+brdH6rE/shWm3mMk3Ray5s0l8=; b=jWVsRnIYLzxHiBeSP+RVUdRcKW
	Kl51eIVCel5aCrgYDKKZlFeTlaLhKJBeyPT6ByEYTXe20VIb9VUYcclswTlH9fHPuUCw+pNKkjGbX
	jn6EWOijlxCa0FjK8Ni8S4at5FHy/nwP0duKYOzgztqiPh9DabD/lAUxp4urtNhC9OSE3PBl4zk55
	QIKW5/kHTZCO336loQOJzx4oTEVytsR+wCUhJC0wa7bbRrWwjJv69+Vm2j7x4LSvd05+0aHB248Z3
	nrCvMlTzQFCOJuBLbvrEovxPTzouKcYwnSPFs2Sx3aLhBdHmtntZacW2HpVD54ORPpKH8GV89UPcb
	bMHEmPTg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFB8r-00040N-2Y; Mon, 18 Dec 2023 11:46:33 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFB8q-000RZV-LJ; Mon, 18 Dec 2023 11:46:32 +0100
Subject: Re: [PATCH bpf-next] bpf: ensure precise is reset to false in
 __mark_reg_const_zero()
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@kernel.org
Cc: kernel-team@meta.com, Maxim Mikityanskiy <maxtram95@gmail.com>
References: <20231215235822.908223-1-andrii@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f1161484-c38c-4178-1163-ac9b14c20715@iogearbox.net>
Date: Mon, 18 Dec 2023 11:46:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231215235822.908223-1-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27127/Mon Dec 18 10:39:04 2023)

On 12/16/23 12:58 AM, Andrii Nakryiko wrote:
> It is safe to always start with imprecise SCALAR_VALUE register.
> Previously __mark_reg_const_zero() relied on caller to reset precise
> mark, but it's very error prone and we already missed it in a few
> places. So instead make __mark_reg_const_zero() reset precision always,
> as it's a safe default for SCALAR_VALUE. Explanation is basically the
> same as for why we are resetting (or rather not setting) precision in
> current state. If necessary, precision propagation will set it to
> precise correctly.
> 
> As such, also remove a big comment about forward precision propagation
> in mark_reg_stack_read() and avoid unnecessarily setting precision to
> true after reading from STACK_ZERO stack. Again, precision propagation
> will correctly handle this, if that SCALAR_VALUE register will ever be
> needed to be precise.
> 
> Reported-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   kernel/bpf/verifier.c                            | 16 +++-------------
>   .../selftests/bpf/progs/verifier_spill_fill.c    | 10 ++++++++--
>   2 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1863826a4ac3..3009d1faec86 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1781,6 +1781,7 @@ static void __mark_reg_const_zero(struct bpf_reg_state *reg)
>   {
>   	__mark_reg_known(reg, 0);
>   	reg->type = SCALAR_VALUE;
> +	reg->precise = false; /* all scalars are assumed imprecise initially */

Could you elaborate on why it is safe to set it to false instead of using:

   reg->precise = !env->bpf_capable;

For !cap_bpf we typically always set precise requirement to true, see also
__mark_reg_unknown().

>   }
>   
>   static void mark_reg_known_zero(struct bpf_verifier_env *env,
> @@ -4706,21 +4707,10 @@ static void mark_reg_stack_read(struct bpf_verifier_env *env,
>   		zeros++;
>   	}
>   	if (zeros == max_off - min_off) {
> -		/* any access_size read into register is zero extended,
> -		 * so the whole register == const_zero
> +		/* Any access_size read into register is zero extended,
> +		 * so the whole register == const_zero.
>   		 */
>   		__mark_reg_const_zero(&state->regs[dst_regno]);
> -		/* backtracking doesn't support STACK_ZERO yet,
> -		 * so mark it precise here, so that later
> -		 * backtracking can stop here.
> -		 * Backtracking may not need this if this register
> -		 * doesn't participate in pointer adjustment.
> -		 * Forward propagation of precise flag is not
> -		 * necessary either. This mark is only to stop
> -		 * backtracking. Any register that contributed
> -		 * to const 0 was marked precise before spill.
> -		 */
> -		state->regs[dst_regno].precise = true;
>   	} else {
>   		/* have read misc data from the stack */
>   		mark_reg_unknown(env, state->regs, dst_regno);
> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> index 508f5d6c7347..39fe3372e0e0 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -499,8 +499,14 @@ __success
>   __msg("2: (7a) *(u64 *)(r10 -8) = 0          ; R10=fp0 fp-8_w=00000000")
>   /* but fp-16 is spilled IMPRECISE zero const reg */
>   __msg("4: (7b) *(u64 *)(r10 -16) = r0        ; R0_w=0 R10=fp0 fp-16_w=0")
> -/* and now check that precision propagation works even for such tricky case */
> -__msg("10: (71) r2 = *(u8 *)(r10 -9)         ; R2_w=P0 R10=fp0 fp-16_w=0")
> +/* validate that assigning R2 from STACK_ZERO doesn't mark register
> + * precise immediately; if necessary, it will be marked precise later
> + */
> +__msg("6: (71) r2 = *(u8 *)(r10 -1)          ; R2_w=0 R10=fp0 fp-8_w=00000000")
> +/* similarly, when R2 is assigned from spilled register, it is initially
> + * imprecise, but will be marked precise later once it is used in precise context
> + */
> +__msg("10: (71) r2 = *(u8 *)(r10 -9)         ; R2_w=0 R10=fp0 fp-16_w=0")
>   __msg("11: (0f) r1 += r2")
>   __msg("mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1")
>   __msg("mark_precise: frame0: regs=r2 stack= before 10: (71) r2 = *(u8 *)(r10 -9)")
> 


