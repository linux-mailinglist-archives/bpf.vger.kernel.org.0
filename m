Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736F853D749
	for <lists+bpf@lfdr.de>; Sat,  4 Jun 2022 16:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiFDOrQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Jun 2022 10:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiFDOrQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Jun 2022 10:47:16 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3555101E
        for <bpf@vger.kernel.org>; Sat,  4 Jun 2022 07:47:14 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q123so9427319pgq.6
        for <bpf@vger.kernel.org>; Sat, 04 Jun 2022 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lxeeD6vF5tkfQVFGzsBD6mqnJ89C/UU/nO3W0iw8/30=;
        b=cOPjHEQtTUrr+mzAJSuTkX/orSR8XENBRkTxBonPALjSF0fp2NUA9z+kIFpNW5An69
         5mMWtwaJCXLq8VDA2NEH38ULuZvB8AAoxEakDTK08Fr3kKx/QU5nadMWMTPrSTrtKi93
         wJFwcYArrdybY736fvWmGlS99Hb0KztexEVaLe/staa8tSmGa7qxPW9fJ786ZB4fNpLf
         z59fWAhRGN5PXyufiKaG99nCebOSlZa1aGWDKvkcX5/iD/Mck8pco60SBSBmiuLxfb2V
         tyUADU6swtjIZ1qlgj+FD364ToKJPnLmjcDjRYFiO/TIPK4QCaqInO9wTLXpzxgKduOl
         aStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lxeeD6vF5tkfQVFGzsBD6mqnJ89C/UU/nO3W0iw8/30=;
        b=ogDBOEWRxuLEJMvGKi2KhN2c7NfzsnOe/K0kNKqmJQtjgqY/QZWwvjtYuvHxFctTwy
         Rssasyr/J4Z1UAsudovJx8TynCGlOu7AE23in4GN6Sif1kZ8ZyeQDb1wP4N6C7nA1CJx
         9lIaM6kQY+gae0oR308C7y92Ha6/h34MDuTnpNKp/eZQPoyrBeB8iTl40JafkDL3sCXY
         UY2WVp6lMJTz9Tubglx6rVPvefWEPdYuMHY1CCFajRbahJl4NgL8ZJJ+wfNrqqYm0ulE
         37HQ0Oz/UH52FMGRx4iywdUJRHszkfNQ2IuSrr6Kj7Cu7zoT9MoRfO8XlolkkA9k++JH
         Nm1Q==
X-Gm-Message-State: AOAM532fqk4s6aCgH2RYsgOGV+QIDCHYExLnfXTvi24edYcZFThHRLTe
        o2TwNqZ+8Y1irv0tCq6SA/o=
X-Google-Smtp-Source: ABdhPJy6uwc0Es/gmNjTfT4YkSpRDvtQYxCBMLGG3hzYPMvvqDSX3Lvr4N0IQvNMLjMRUPdpASKufw==
X-Received: by 2002:a05:6a00:cca:b0:51b:ed40:b08a with SMTP id b10-20020a056a000cca00b0051bed40b08amr5545055pfv.19.1654354034160;
        Sat, 04 Jun 2022 07:47:14 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2620:10d:c090:400::4:c31b])
        by smtp.gmail.com with ESMTPSA id q68-20020a632a47000000b003fcc510d789sm6149364pgq.29.2022.06.04.07.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 07:47:13 -0700 (PDT)
Date:   Sat, 4 Jun 2022 16:47:07 +0200
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Inline calls to bpf_loop when
 callback is known
Message-ID: <20220604144707.d7ehrmys5xeijba4@MacBook-Pro-3.local>
References: <20220603141047.2163170-1-eddyz87@gmail.com>
 <20220603141047.2163170-4-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603141047.2163170-4-eddyz87@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 03, 2022 at 05:10:45PM +0300, Eduard Zingerman wrote:
> +
> +		if (fit_for_bpf_loop_inline(aux)) {
> +			if (!subprog_updated) {
> +				subprog_updated = true;
> +				subprogs[cur_subprog].stack_depth += BPF_REG_SIZE * 3;

Instead of doing += and keeping track that the stack was increased
(if multiple bpf_loop happened to be in a function)
may be add subprogs[..].stack_depth_extra variable ?
And unconditionally do subprogs[cur_subprog].stack_depth_extra = BPF_REG_SIZE * 3;
every time bpf_loop is seen?
Then we can do that during inline_bpf_loop().
Also is there a test for multiple bpf_loop in a func?

> +				stack_base = -subprogs[cur_subprog].stack_depth;
> +			}
> +			aux->loop_inline_state.stack_base = stack_base;
> +		}
> +		if (i == subprog_end - 1) {
> +			subprog_updated = false;
> +			cur_subprog++;
> +			if (cur_subprog < env->subprog_cnt)
> +				subprog_end = subprogs[cur_subprog + 1].start;
> +		}
> +	}
> +
> +	env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
> +}
> +
> +static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
> +{
> +	struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
> +	struct bpf_reg_state *regs = cur_regs(env);
> +	struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
> +
> +	int flags_is_zero =
> +		register_is_const(flags_reg) && flags_reg->var_off.value == 0;
> +
> +	if (state->initialized) {
> +		state->flags_is_zero &= flags_is_zero;
> +		state->callback_is_constant &= state->callback_subprogno == subprogno;
> +	} else {
> +		state->initialized = 1;
> +		state->callback_is_constant = 1;
> +		state->flags_is_zero = flags_is_zero;
> +		state->callback_subprogno = subprogno;
> +	}
> +}
> +
>  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			     int *insn_idx_p)
>  {
> @@ -7255,6 +7327,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		err = check_bpf_snprintf_call(env, regs);
>  		break;
>  	case BPF_FUNC_loop:
> +		update_loop_inline_state(env, meta.subprogno);
>  		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
>  					set_loop_callback_state);
>  		break;
> @@ -7661,11 +7734,6 @@ static bool check_reg_sane_offset(struct bpf_verifier_env *env,
>  	return true;
>  }
>  
> -static struct bpf_insn_aux_data *cur_aux(struct bpf_verifier_env *env)
> -{
> -	return &env->insn_aux_data[env->insn_idx];
> -}
> -
>  enum {
>  	REASON_BOUNDS	= -1,
>  	REASON_TYPE	= -2,
> @@ -12920,6 +12988,22 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
>  	return new_prog;
>  }
>  
> +static void adjust_loop_inline_subprogno(struct bpf_verifier_env *env,
> +					 u32 first_removed,
> +					 u32 first_remaining)
> +{
> +	int delta = first_remaining - first_removed;
> +
> +	for (int i = 0; i < env->prog->len; ++i) {
> +		struct bpf_loop_inline_state *state =
> +			&env->insn_aux_data[i].loop_inline_state;
> +
> +		if (state->initialized &&
> +		    state->callback_subprogno >= first_remaining)
> +			state->callback_subprogno -= delta;
> +	}
> +}
> +
>  static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
>  					      u32 off, u32 cnt)
>  {
> @@ -12963,6 +13047,8 @@ static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
>  			 * in adjust_btf_func() - no need to adjust
>  			 */
>  		}
> +
> +		adjust_loop_inline_subprogno(env, i, j);

This special case isn't great.
May be let's do inline_bpf_loop() earlier?
Instead of doing it from do_misc_fixups() how about doing it as a separate
pass right after check_max_stack_depth() ?
Then opt_remove_dead_code() will adjust BPF_CALL_REL automatically
as a part of bpf_adj_branches().

>  	} else {
>  		/* convert i from "first prog to remove" to "first to adjust" */
>  		if (env->subprog_info[i].start == off)
> @@ -13773,6 +13859,94 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env,
>  	return 0;
>  }
>  
> +static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
> +					int position, u32 *cnt)
> +{
> +	struct bpf_insn_aux_data *aux = &env->insn_aux_data[position];
> +	s32 stack_base = aux->loop_inline_state.stack_base;
> +	s32 r6_offset = stack_base + 0 * BPF_REG_SIZE;
> +	s32 r7_offset = stack_base + 1 * BPF_REG_SIZE;
> +	s32 r8_offset = stack_base + 2 * BPF_REG_SIZE;
> +	int reg_loop_max = BPF_REG_6;
> +	int reg_loop_cnt = BPF_REG_7;
> +	int reg_loop_ctx = BPF_REG_8;
> +
> +	struct bpf_prog *new_prog;
> +	u32 callback_subprogno = aux->loop_inline_state.callback_subprogno;
> +	u32 callback_start;
> +	u32 call_insn_offset;
> +	s32 callback_offset;
> +	struct bpf_insn insn_buf[19];
> +	struct bpf_insn *next = insn_buf;
> +	struct bpf_insn *call, *jump_to_end, *loop_header;
> +	struct bpf_insn *jump_to_header, *loop_exit;
> +
> +	/* Return error and jump to the end of the patch if
> +	 * expected number of iterations is too big.  This
> +	 * repeats the check done in bpf_loop helper function,
> +	 * be careful to modify this code in sync.
> +	 */
> +	(*next++) = BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2);
> +	(*next++) = BPF_MOV32_IMM(BPF_REG_0, -E2BIG);
> +	jump_to_end = next;
> +	(*next++) = BPF_JMP_IMM(BPF_JA, 0, 0, 0 /* set below */);
> +	/* spill R6, R7, R8 to use these as loop vars */
> +	(*next++) = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, r6_offset);
> +	(*next++) = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, r7_offset);
> +	(*next++) = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, r8_offset);
> +	/* initialize loop vars */
> +	(*next++) = BPF_MOV64_REG(reg_loop_max, BPF_REG_1);
> +	(*next++) = BPF_MOV32_IMM(reg_loop_cnt, 0);
> +	(*next++) = BPF_MOV64_REG(reg_loop_ctx, BPF_REG_3);
> +	/* loop header;
> +	 * if reg_loop_cnt >= reg_loop_max skip the loop body
> +	 */
> +	loop_header = next;
> +	(*next++) = BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max,
> +				0 /* set below */);
> +	/* callback call */
> +	(*next++) = BPF_MOV64_REG(BPF_REG_1, reg_loop_cnt);
> +	(*next++) = BPF_MOV64_REG(BPF_REG_2, reg_loop_ctx);
> +	call = next;
> +	(*next++) = BPF_CALL_REL(0 /* set below after patching */);
> +	/* increment loop counter */
> +	(*next++) = BPF_ALU64_IMM(BPF_ADD, reg_loop_cnt, 1);
> +	/* jump to loop header if callback returned 0 */
> +	jump_to_header = next;
> +	(*next++) = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 0 /* set below */);
> +	/* return value of bpf_loop;
> +	 * set R0 to the number of iterations
> +	 */
> +	loop_exit = next;
> +	(*next++) = BPF_MOV64_REG(BPF_REG_0, reg_loop_cnt);
> +	/* restore original values of R6, R7, R8 */
> +	(*next++) = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, r6_offset);
> +	(*next++) = BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offset);
> +	(*next++) = BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset);
> +
> +	*cnt = next - insn_buf;
> +	if (*cnt > ARRAY_SIZE(insn_buf)) {
> +		WARN_ONCE(1, "BUG %s: 'next' exceeds bounds for 'insn_buf'\n",
> +			  __func__);
> +		return NULL;
> +	}
> +	jump_to_end->off = next - jump_to_end - 1;
> +	loop_header->off = loop_exit - loop_header - 1;
> +	jump_to_header->off = loop_header - jump_to_header - 1;
> +
> +	new_prog = bpf_patch_insn_data(env, position, insn_buf, *cnt);
> +	if (!new_prog)
> +		return new_prog;
> +
> +	/* callback start is known only after patching */
> +	callback_start = env->subprog_info[callback_subprogno].start;
> +	call_insn_offset = position + (call - insn_buf);
> +	callback_offset = callback_start - call_insn_offset - 1;
> +	env->prog->insnsi[call_insn_offset].imm = callback_offset;
> +
> +	return new_prog;
> +}
> +
>  /* Do various post-verification rewrites in a single program pass.
>   * These rewrites simplify JIT and interpreter implementations.
>   */
> @@ -14258,6 +14432,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  			continue;
>  		}
>  
> +		if (insn->imm == BPF_FUNC_loop &&
> +		    fit_for_bpf_loop_inline(&env->insn_aux_data[i + delta])) {
> +			new_prog = inline_bpf_loop(env, i + delta, &cnt);
> +			if (!new_prog)
> +				return -ENOMEM;
> +
> +			delta    += cnt - 1;
> +			env->prog = prog = new_prog;
> +			insn      = new_prog->insnsi + i + delta;
> +			continue;
> +		}
> +
>  patch_call_imm:
>  		fn = env->ops->get_func_proto(insn->imm, env->prog);
>  		/* all functions that have prototype and verifier allowed
> @@ -15030,6 +15216,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
>  	if (ret == 0)
>  		ret = check_max_stack_depth(env);
>  
> +	if (ret == 0)
> +		adjust_stack_depth_for_loop_inlining(env);

With above two suggestions this will become
if (ret == 0)
    optimize_bpf_loop(env);

where it will call inline_bpf_loop() and will assign max_depth_extra.
And then one extra loop for_each_subporg() max_depth += max_depth_extra.

wdyt?
