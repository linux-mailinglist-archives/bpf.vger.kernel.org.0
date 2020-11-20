Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277BE2BBA70
	for <lists+bpf@lfdr.de>; Sat, 21 Nov 2020 01:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgKTX7Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 18:59:24 -0500
Received: from www62.your-server.de ([213.133.104.62]:59428 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgKTX7X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 18:59:23 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kgGJF-0003tP-0D; Sat, 21 Nov 2020 00:59:21 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kgGJE-000HsU-RA; Sat, 21 Nov 2020 00:59:20 +0100
Subject: Re: [PATCH bpf-next] bpf: Refactor check_cfg to use a structured
 loop.
To:     Wedson Almeida Filho <wedsonaf@google.com>
References: <20201119141901.3176328-1-wedsonaf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <52d832fb-e78f-cd79-8c10-005ec75b7ec6@iogearbox.net>
Date:   Sat, 21 Nov 2020 00:59:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20201119141901.3176328-1-wedsonaf@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25994/Fri Nov 20 14:09:26 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/19/20 3:19 PM, Wedson Almeida Filho wrote:
> The current implementation uses a number of gotos to implement a loop
> and different paths within the loop, which makes the code less readable
> than it would be with an explicit while-loop. This patch also replaces a
> chain of if/if-elses keyed on the same expression with a switch
> statement.
> 
> No change in behaviour is intended.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> ---
>   kernel/bpf/verifier.c | 157 +++++++++++++++++++++---------------------
>   1 file changed, 78 insertions(+), 79 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fb2943ea715d..5dcdacce35e0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8099,16 +8099,82 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
>   	return 0;
>   }
>   
> +/* Visits instruction at index t and returns one of the following:
> + *  < 0 - an error occurred
> + *    0 - the instruction was fully explored
> + *  > 0 - there is still work to be done before it is fully explored
> + */
> +static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn *insns = env->prog->insnsi;
> +	int ret;
> +
> +	/* All non-branch instructions have a single fall-through edge. */
> +	if (BPF_CLASS(insns[t].code) != BPF_JMP &&
> +	    BPF_CLASS(insns[t].code) != BPF_JMP32)
> +		return push_insn(t, t + 1, FALLTHROUGH, env, false);
> +
> +	switch (BPF_OP(insns[t].code)) {
> +	case BPF_EXIT:
> +		return 0;
> +
> +	case BPF_CALL:
> +		ret = push_insn(t, t + 1, FALLTHROUGH, env, false);
> +		if (ret)
> +			return ret;
> +
> +		if (t + 1 < insn_cnt)
> +			init_explored_state(env, t + 1);
> +		if (insns[t].src_reg == BPF_PSEUDO_CALL) {
> +			init_explored_state(env, t);
> +			ret = push_insn(t, t + insns[t].imm + 1, BRANCH,
> +					env, false);
> +		}
> +		return ret;
> +
> +	case BPF_JA:
> +		if (BPF_SRC(insns[t].code) != BPF_K)
> +			return -EINVAL;
> +
> +		/* unconditional jump with single edge */
> +		ret = push_insn(t, t + insns[t].off + 1, FALLTHROUGH, env,
> +				true);
> +		if (ret)
> +			return ret;
> +
> +		/* unconditional jmp is not a good pruning point,
> +		 * but it's marked, since backtracking needs
> +		 * to record jmp history in is_state_visited().
> +		 */
> +		init_explored_state(env, t + insns[t].off + 1);
> +		/* tell verifier to check for equivalent states
> +		 * after every call and jump
> +		 */
> +		if (t + 1 < insn_cnt)
> +			init_explored_state(env, t + 1);
> +
> +		return ret;
> +
> +	default:
> +		/* conditional jump with two edges */
> +		init_explored_state(env, t);
> +		ret = push_insn(t, t + 1, FALLTHROUGH, env, true);
> +		if (ret)
> +			return ret;
> +
> +		return push_insn(t, t + insns[t].off + 1, BRANCH, env, true);
> +	}
> +}
> +
[...]
> +		ret = visit_insn(t, insn_cnt, env);
> +		if (ret < 0)
>   			goto err_free;
> +
> +		if (!ret) {
> +			insn_state[t] = EXPLORED;
> +			env->cfg.cur_stack--;
> +		}

Looks good to me, and it's a nice simplification, imho. Perhaps we could take that
even further while at it, make the walk opcodes more descriptive, and also reject
anything unexpected (> 1) ... uncompiled diff on top:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5dcdacce35e0..a3c58bc42b4a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8047,6 +8047,9 @@ static void init_explored_state(struct bpf_verifier_env *env, int idx)
  	env->insn_aux_data[idx].prune_point = true;
  }

+#define DONE_EXPLORING	0
+#define KEEP_EXPLORING	1
+
  /* t, w, e - match pseudo-code above:
   * t - index of current instruction
   * w - next instruction
@@ -8059,10 +8062,9 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
  	int *insn_state = env->cfg.insn_state;

  	if (e == FALLTHROUGH && insn_state[t] >= (DISCOVERED | FALLTHROUGH))
-		return 0;
-
+		return DONE_EXPLORING;
  	if (e == BRANCH && insn_state[t] >= (DISCOVERED | BRANCH))
-		return 0;
+		return DONE_EXPLORING;

  	if (w < 0 || w >= env->prog->len) {
  		verbose_linfo(env, t, "%d: ", t);
@@ -8080,11 +8082,13 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
  		insn_state[w] = DISCOVERED;
  		if (env->cfg.cur_stack >= env->prog->len)
  			return -E2BIG;
+
  		insn_stack[env->cfg.cur_stack++] = w;
-		return 1;
+		return KEEP_EXPLORING;
  	} else if ((insn_state[w] & 0xF0) == DISCOVERED) {
  		if (loop_ok && env->bpf_capable)
-			return 0;
+			return DONE_EXPLORING;
+
  		verbose_linfo(env, t, "%d: ", t);
  		verbose_linfo(env, w, "%d: ", w);
  		verbose(env, "back-edge from insn %d to %d\n", t, w);
@@ -8096,7 +8100,8 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
  		verbose(env, "insn state internal bug\n");
  		return -EFAULT;
  	}
-	return 0;
+
+	return DONE_EXPLORING;
  }

  /* Visits instruction at index t and returns one of the following:
@@ -8116,7 +8121,7 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)

  	switch (BPF_OP(insns[t].code)) {
  	case BPF_EXIT:
-		return 0;
+		return DONE_EXPLORING;

  	case BPF_CALL:
  		ret = push_insn(t, t + 1, FALLTHROUGH, env, false);
@@ -8194,12 +8199,19 @@ static int check_cfg(struct bpf_verifier_env *env)
  		int t = insn_stack[env->cfg.cur_stack - 1];

  		ret = visit_insn(t, insn_cnt, env);
-		if (ret < 0)
-			goto err_free;
-
-		if (!ret) {
+		switch (ret) {
+		case DONE_EXPLORING:
  			insn_state[t] = EXPLORED;
  			env->cfg.cur_stack--;
+			break;
+		case KEEP_EXPLORING:
+			break;
+		default:
+			if (ret > 0) {
+				verbose(env, "insn visit internal bug\n");
+				ret = -EFAULT;
+			}
+			goto err_free;
  		}
  	}
