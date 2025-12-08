Return-Path: <bpf+bounces-76243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DF9CABD5B
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 03:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03D783020CD3
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 02:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B4D1DD889;
	Mon,  8 Dec 2025 02:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdG30Q84"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466AD20ED
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 02:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765160223; cv=none; b=ZVwIez2kX5iQTTXUN+FJXAHEnY50m2ybQtR9DFTwiR8GUcviVIu982O7oQdaj4wmfzo4T1XlyJVRUA/NGezQwq53kEE7jWGJBSwVPlLR6wh1GDOGvQhQt2NLR82Id92shTliv6jjYpqOb4epeQIzQjhBmFTd6yNgchh+T9ws42Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765160223; c=relaxed/simple;
	bh=r1DUiPp0TsVrpaIPykKWOCrTNyL8ieNSupiq4rkiWhQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CRabXlsDl80m0ZtCGrPvcBAvEmHo3GZ+rthmK6nZaKvVNsq5Zt2Jynw0qqUH1fP0kY7Y6tAkiCyrXbVMgn2/XdKT1WMkUx/u3vM/YGyZZbqE5jMyKjAHcq2DOcV51bI0lJ3N9gyoQ0cy1yWhh0uyuz9+coNpPZc2Ggi0Inrs34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdG30Q84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5754C4CEFB;
	Mon,  8 Dec 2025 02:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765160222;
	bh=r1DUiPp0TsVrpaIPykKWOCrTNyL8ieNSupiq4rkiWhQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FdG30Q84gyFwfvcCArxjKo3ixP2GOjwANMfaQYWK/+7si/hI1JRz8qrvYUV1YgHwp
	 3EM3bPNW7bMQ0sv7gs+2IflrnwiFcA5X2/IXNNhncVuo8WlLdc2KkLGYwIJqKeLWkS
	 tM+S1eWq7kxRslIni4nJL8ygGCizdhZvJchDXw983cYhGk97sQ3i3cGq9bLprEi2A4
	 PvFbEDUVix+qCF1DU3mv1+25+yKSr3JDXTEMyxhltofickx3u2bQAf+qL5GMhmGbJj
	 vw9ZBHRGu1CkMwAEdq8hYKmEP3HmLDW41L3jvj8DNQfivUiykyZAqxegQE0lPdeHVL
	 jGLmmTK2p73dw==
Content-Type: multipart/mixed; boundary="===============4624510377783832461=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <082995bcd79b647fdd0bdedd2a1677f7e182cd5654baeddd3923cf886b728ce0@mail.kernel.org>
In-Reply-To: <8739a850ecbb0454e4cbb2dc1103ba9429ea0aef.1765158924.git.paul.chaignon@gmail.com>
References: <8739a850ecbb0454e4cbb2dc1103ba9429ea0aef.1765158924.git.paul.chaignon@gmail.com>
Subject: Re: [PATCH bpf-next 1/8] bpf: Save pruning point states in oracle
From: bot+bpf-ci@kernel.org
To: paul.chaignon@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,qmo@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  8 Dec 2025 02:17:01 +0000 (UTC)

--===============4624510377783832461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 130bcbd66f60..adaeff35aaa6 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -551,6 +575,7 @@ struct bpf_insn_aux_data {
>  	};
>  	struct bpf_iarray *jt;	/* jump table for gotox or bpf_tailcall call instruction */
>  	struct btf_struct_meta *kptr_struct_meta;
> +	struct list_head *oracle_states;
>  	u64 map_key_state; /* constant (32 bit) key tracking for maps */
>  	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
>  	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */

[ ... ]

> diff --git a/kernel/bpf/oracle.c b/kernel/bpf/oracle.c
> new file mode 100644
> index 000000000000..adbb153aadee
> --- /dev/null
> +++ b/kernel/bpf/oracle.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * This file implements a test oracle for the verifier. When the oracle is enabled, the verifier
> + * saves information on variables at regular points throughout the program. This information is
> + * then compared at runtime with the concrete values to ensure that the verifier's information is
> + * correct.
> + */
> +
> +#include <linux/bpf_verifier.h>
> +
> +static void convert_oracle_state(struct bpf_verifier_state *istate, struct bpf_oracle_state *ostate)
> +{

[ ... ]

> +int save_state_in_oracle(struct bpf_verifier_env *env, int insn_idx)
> +{
> +	struct bpf_verifier_state *cur = env->cur_state;
> +	struct bpf_insn_aux_data *aux = cur_aux(env);
> +	struct bpf_oracle_state_list *new_sl;
> +
> +	if (env->subprog_cnt > 1)
> +		/* Skip the oracle if subprogs are used. */
> +		return 0;
> +
> +	if (!aux->oracle_states) {
> +		aux->oracle_states = kmalloc(sizeof(*aux->oracle_states), GFP_KERNEL_ACCOUNT);
> +		if (!aux->oracle_states)
> +			return -ENOMEM;
> +
> +		INIT_LIST_HEAD(aux->oracle_states);
> +	}
> +
> +	new_sl = kzalloc(sizeof(*new_sl), GFP_KERNEL_ACCOUNT);
> +	if (!new_sl)
> +		return -ENOMEM;

Can this leak the oracle_states list_head allocated above? If the
kmalloc() succeeds but this kzalloc() fails, save_state_in_oracle()
returns -ENOMEM without freeing aux->oracle_states. Looking at
do_check()->save_state_in_oracle() error handling, the error propagates
up and the verifier fails, but aux->oracle_states remains allocated.

> +	convert_oracle_state(cur, &new_sl->state);
> +	list_add(&new_sl->node, aux->oracle_states);
> +
> +	return 0;
> +}

Also, where is the cleanup code for oracle_states? Looking at
clear_insn_aux_data() in verifier.c, it only frees the jt field:

    for (i = start; i < end; i++) {
        if (aux_data[i].jt) {
            kvfree(aux_data[i].jt);
            aux_data[i].jt = NULL;
        }
        ...
    }

Should clear_insn_aux_data() also walk through aux->oracle_states,
freeing each bpf_oracle_state_list node, then free the list_head itself?
Without this, both the list_head and all oracle_state_list nodes will
leak on every BPF program verification.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20014308092

--===============4624510377783832461==--

