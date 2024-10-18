Return-Path: <bpf+bounces-42406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EA99A3CCD
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 13:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54699287BE2
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 11:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B34A20370A;
	Fri, 18 Oct 2024 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="dEWaRnUZ"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A261318C938
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249444; cv=none; b=ZFPa4nMNK/UDuxFmgpYJNrHH66U2q3LTePGsrimcmFMRNJxo2TjadBsHIPrSTzALkpVO8+B0QTRsVo6Nk2YodxpcmHAGfNBT16tcnt9xOX8RR1PaWIUQnGLW/z+/3tXP7O5Fgy3InfrB4bgtJfFbDdpqv7H3FwgdGTyGRZvGGCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249444; c=relaxed/simple;
	bh=8BlWI7US2omrq6rSX95HX1nFsnpDbimPn6ya3FSoyGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9dRuNg7m9PGzG/U2acMqx+jEjEdy9X816MswJH8mmrPkdf6XqhlxbwLKkP+7hvGonaBFqAtxo8ZZyM6a/XTojsI8Qycjq7zHUPTAFs/ZaWpqN0C/mrpZ5yA6b9TZYUM9nPtdjkVBRcIf54bw9nyNziJIj7KlESlMgIIkLAqGyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=dEWaRnUZ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=SasQRu9F/Fyk3Lxd7reWioJ7ZOAPeJs53T5JPNsrGEw=; b=dEWaRnUZvBGKSGkLWiAe38cALg
	yob+0YE1N0QfKzuYVC5tdJzPdyx0dvTx8Q91VGe1Mw2awj8eVeKDz+SchyuXqgDEI2NJcrISkelIK
	ZPu26YwcYpDjbTyLpH7e1KLMCgneu/WwxSH2pAXy0/RBOmMRb86HkjW+v7yhRzKY5lkkitMFGA1D7
	UYs6f49gsaJeeBPlE3yhAYK/AhpMC+vLg4qQyOOd6o89gvvfYlzafU+Mx1DKVfYmrsXIa8cJAPi/P
	qvkuVCBYa6Jr1PCkrElWM/OjaOcuXLAbbGJrk6jmGbhy3JjsVdfeqBuewkfHJqDCgbr50TkyE/+GO
	R1WAFldA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t1kll-000Nzd-M9; Fri, 18 Oct 2024 13:03:45 +0200
Received: from [178.197.248.12] (helo=[192.168.1.114])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1t1kll-000BsF-1r;
	Fri, 18 Oct 2024 13:03:45 +0200
Message-ID: <0fd927cd-7fd2-4b15-8a17-15b907771356@iogearbox.net>
Date: Fri, 18 Oct 2024 13:03:44 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoint when jmp history is
 too long
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
References: <20241018020307.1766906-1-eddyz87@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20241018020307.1766906-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27431/Fri Oct 18 10:53:06 2024)

On 10/18/24 4:03 AM, Eduard Zingerman wrote:
> A specifically crafted program might trick verifier into growing very
> long jump history within a single bpf_verifier_state instance.
> Very long jump history makes mark_chain_precision() unreasonably slow,
> especially in case if verifier processes a loop.
> 
> Mitigate this by forcing new state in is_state_visited() in case if
> current state's jump history is too long.
> 
> Use same constant as in `skip_inf_loop_check`, but multiply it by
> arbitrarily chosen value 2 to account for jump history containing not
> only information about jumps, but also information about stack access.
[...]
> 
> The log output shows that checkpoint at label (1) is never created,
> because it is suppressed by `skip_inf_loop_check` logic:
> a. When 'if' at (2) is processed it pushes a state with insn_idx (1)
>     onto stack and proceeds to (3);
> b. At (5) checkpoint is created, and this resets
>     env->{jmps,insns}_processed.
> c. Verification proceeds and reaches `exit`;
> d. State saved at step (a) is popped from stack and is_state_visited()
>     considers if checkpoint needs to be added, but because
>     env->{jmps,insns}_processed had been just reset at step (b)
>     the `skip_inf_loop_check` logic forces `add_new_state` to false.
> e. Verifier proceeds with current state, which slowly accumulates
>     more and more entries in the jump history.
> 
> The accumulation of entries in the jump history is a problem because
> of two factors:
> - it eventually exhausts memory available for kmalloc() allocation;
> - mark_chain_precision() traverses the jump history of a state,
>    meaning that if `r7` is marked precise, verifier would iterate
>    ever growing jump history until parent state boundary is reached.
> 
> (note: the log also shows a REG INVARIANTS VIOLATION warning
>         upon jset processing, but that's another bug to fix).
> 
> With this patch applied, the example above is rejected by verifier
> under 1s of time, reaching 1M instructions limit.
> 
> The program is a simplified reproducer from syzbot report [1].
> Previous discussion could be found at [2].
> The patch does not cause any changes in verification performance,
> when tested on selftests from veristat.cfg and cilium programs taken
> from [3].
> 
> [1] https://lore.kernel.org/bpf/670429f6.050a0220.49194.0517.GAE@google.com/
> [2] https://lore.kernel.org/bpf/20241009021254.2805446-1-eddyz87@gmail.com/
> [3] https://github.com/anakryiko/cilium

Impressive that syzbot was able to generate this, and awesome analysis
as well as fix.

I guess we should also add :

Reported-by: syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com

Can we also add a Fixes tag so that this can eventually be picked up
by stable? bpf tree would be the appropriate target, no?

> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

> ---
>   kernel/bpf/verifier.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f514247ba8ba..f64c831a9278 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17873,13 +17873,23 @@ static bool iter_active_depths_differ(struct bpf_verifier_state *old, struct bpf
>   	return false;
>   }
>   
> +#define MAX_JMPS_PER_STATE 20
> +
>   static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
>   {
>   	struct bpf_verifier_state_list *new_sl;
>   	struct bpf_verifier_state_list *sl, **pprev;
>   	struct bpf_verifier_state *cur = env->cur_state, *new, *loop_entry;
>   	int i, j, n, err, states_cnt = 0;
> -	bool force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx);
> +	bool force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx) ||
> +			       /* - Long jmp history hinders mark_chain_precision performance,
> +				*   so force new state if jmp history of current state exceeds
> +				*   a threshold.
> +				* - Jmp history records not only jumps, but also stack access,
> +				*   so keep this constant 2x times the limit imposed on
> +				*   env->jmps_processed for loop cases (see skip_inf_loop_check).
> +				*/
> +			       cur->jmp_history_cnt > MAX_JMPS_PER_STATE * 2;
>   	bool add_new_state = force_new_state;
>   	bool force_exact;
>   
> @@ -18023,7 +18033,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
>   			 */
>   skip_inf_loop_check:
>   			if (!force_new_state &&
> -			    env->jmps_processed - env->prev_jmps_processed < 20 &&
> +			    env->jmps_processed - env->prev_jmps_processed < MAX_JMPS_PER_STATE &&
>   			    env->insn_processed - env->prev_insn_processed < 100)
>   				add_new_state = false;
>   			goto miss;

