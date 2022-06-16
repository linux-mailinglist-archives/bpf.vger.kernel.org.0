Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF6F54EDCB
	for <lists+bpf@lfdr.de>; Fri, 17 Jun 2022 01:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378485AbiFPXMv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 19:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiFPXMu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 19:12:50 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A571FCD5
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 16:12:47 -0700 (PDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1o1yfN-000GBH-9s; Fri, 17 Jun 2022 01:12:45 +0200
Received: from [85.1.206.226] (helo=linux-3.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1o1yfN-000HOH-36; Fri, 17 Jun 2022 01:12:45 +0200
Subject: Re: [PATCH bpf-next v7 3/5] bpf: Inline calls to bpf_loop when
 callback is known
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, kernel-team@fb.com,
        song@kernel.org, joannelkoong@gmail.com
References: <20220613205008.212724-1-eddyz87@gmail.com>
 <20220613205008.212724-4-eddyz87@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1ad45d14-e917-82f0-e4ab-121c2027c0d6@iogearbox.net>
Date:   Fri, 17 Jun 2022 01:12:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220613205008.212724-4-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26574/Thu Jun 16 10:06:40 2022)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/13/22 10:50 PM, Eduard Zingerman wrote:
[...]
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index d5d96ceca105..7e8fd49406f6 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -723,9 +723,6 @@ const struct bpf_func_proto bpf_for_each_map_elem_proto = {
>   	.arg4_type	= ARG_ANYTHING,
>   };
>   
> -/* maximum number of loops */
> -#define MAX_LOOPS	BIT(23)
> -
>   BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
>   	   u64, flags)
>   {
> @@ -733,9 +730,13 @@ BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
>   	u64 ret;
>   	u32 i;
>   
> +	/* Note: these safety checks are also verified when bpf_loop
> +	 * is inlined, be careful to modify this code in sync. See
> +	 * function verifier.c:inline_bpf_loop.
> +	 */
>   	if (flags)
>   		return -EINVAL;
> -	if (nr_loops > MAX_LOOPS)
> +	if (nr_loops > BPF_MAX_LOOPS)
>   		return -E2BIG;
>   
>   	for (i = 0; i < nr_loops; i++) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2d2872682278..db854c09b603 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7103,6 +7103,38 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
>   	return -ENOTSUPP;
>   }
>   
> +static struct bpf_insn_aux_data *cur_aux(struct bpf_verifier_env *env)
> +{
> +	return &env->insn_aux_data[env->insn_idx];
> +}
> +
> +static bool loop_flag_is_zero(struct bpf_verifier_env *env)
> +{
> +	struct bpf_reg_state *regs = cur_regs(env);
> +	struct bpf_reg_state *reg = &regs[BPF_REG_4];
> +
> +	return register_is_const(reg) && reg->var_off.value == 0;

I think you might also need to add precision tracking for the flag check :

mark_chain_precision(env, BPF_REG_4)

See also cc52d9140aa92 ("bpf: Fix record_func_key to perform backtracking on r3").. not too
much of an issue at the moment, but once we extend flags.

> +}
> +
> +static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
> +{
> +	struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
> +
> +	if (!state->initialized) {
> +		state->initialized = 1;
> +		state->fit_for_inline = loop_flag_is_zero(env);
> +		state->callback_subprogno = subprogno;
> +		return;
> +	}
> +
> +	if (!state->fit_for_inline)
> +		return;
> +
> +	state->fit_for_inline =
> +		loop_flag_is_zero(env) &&
> +		state->callback_subprogno == subprogno;
> +}
> +
>   static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   			     int *insn_idx_p)
>   {
> @@ -7255,6 +7287,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>   		err = check_bpf_snprintf_call(env, regs);
>   		break;
>   	case BPF_FUNC_loop:
> +		update_loop_inline_state(env, meta.subprogno);
>   		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
>   					set_loop_callback_state);
>   		break;
