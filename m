Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2142EECA4
	for <lists+bpf@lfdr.de>; Fri,  8 Jan 2021 05:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbhAHEnp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jan 2021 23:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbhAHEnp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jan 2021 23:43:45 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B5BC0612F4
        for <bpf@vger.kernel.org>; Thu,  7 Jan 2021 20:43:05 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n10so6855871pgl.10
        for <bpf@vger.kernel.org>; Thu, 07 Jan 2021 20:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RUz+dmXZLq1E/SSoC2vmTuU0PBYo3hkfLbE9/hZCJpc=;
        b=cRs5HUOQS3hO9HgzkM4D2wW2wiOmbccPMNK1GnYHoQBCE7zwdpOxytpZX3f6V5cKaf
         J/v6smQwSrW9v2Eyfu4U7SIi6lQ/iaUyZz/64eST0j1afd2ci5xojfi+rzTmEB2ugvSi
         uprRlug8gQIFtzp2Hdp7PL0Oqa+jcpEPALw0dFYkNNByRe/jmfynQsBM4b4tPSk2GHlb
         73EHhRZrZJrdFjuvsPJWNP3BUFuHXUYxgx5Ph+ivGeB05UJAY1eTUt3BYx4/OFYHw8Kp
         PtK2KOMWO/JoQhIVFCAqqa9Iq8+ws8IFIDdUOtzLMAXpGil3NBFXm3C6C+vmHZG3yEsb
         p3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RUz+dmXZLq1E/SSoC2vmTuU0PBYo3hkfLbE9/hZCJpc=;
        b=aLzVJIDKyvABsbeYJAiQC5K7uPhopOr1+0aJVS4859/+5/Y1bDOhWlXaJZGbhVLLYm
         TkcKot4L6Dg1/KJJlPBmynr3wABsKrNQsn/4LmYR+hFI2551hfemOaYCeIMvGp0/L5g2
         W4keStSfr603m0Cs+dy5GmBRQaQsdba2eo3q0nbiKtUqhpHcy4Aq3/5wudToubMwmWpl
         KdXLseTvZfi8723BNDfkkwE8axVu6O7aflUwU9zGRBgozYBWp7VoIARfnZFI3AXlwG0U
         bjg2cMHuCKwUuFX1qWt3eLzN4rDfNce1pqnVBIlwvUzVTgXpDctqMQh+sraWupNoxiA3
         /eQA==
X-Gm-Message-State: AOAM531WolT1IM19TjOlaFr2/oCFHY0zZQ/fG94uXXtRD0+8aULKMBjq
        /AYE+DBkxbzwrDjMvRK9bQ0POe0t7TEE3A==
X-Google-Smtp-Source: ABdhPJxYX2O+yzTNemXieG8Dj83Ob8NLo2CK5FWHQ8SKuqBeDknIaW7WSQZlRK6VcQe76wV30m0/7g==
X-Received: by 2002:a62:83cf:0:b029:1a8:3b72:ebb7 with SMTP id h198-20020a6283cf0000b02901a83b72ebb7mr5096969pfe.25.1610080984287;
        Thu, 07 Jan 2021 20:43:04 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:143e])
        by smtp.gmail.com with ESMTPSA id z3sm7157818pfq.89.2021.01.07.20.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 20:43:03 -0800 (PST)
Date:   Thu, 7 Jan 2021 20:43:01 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrei Matei <andreimatei1@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: allow variable-offset stack reads
Message-ID: <20210108044301.fonis5xffhtxf6je@ast-mbp>
References: <20201230012231.1324633-1-andreimatei1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230012231.1324633-1-andreimatei1@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 29, 2020 at 08:22:31PM -0500, Andrei Matei wrote:
> Before this patch, variable offset access to the stack was dissalowed
> for regular instructions, but was allowed for "indirect" accesses (i.e.
> helpers). This patch narrows the restriction, allowing reading the stack
> through pointers with variable offsets. This makes stack-allocated
> buffers more usable in programs, and brings stack pointers closer to
> other types of pointers.
> 
> All register spilled in stack slots that might be read are marked as
> having been read, however reads through such pointers don't do register
> filling; the target register will always be either a scalar or a
> constant zero.
> 
> Notes:
> - Writes with variable offsets are still dissallowed; this patch only
>   deals with reads.

Would be great to make it symmetrical with writes as well.

> - All the stack slots in the variable range needs to be initialized,
>   otherwise the read is rejected.
> - Variable offset direct reads remain dissallowed for non-priviledged
>   programs; they were already dissalowed for "indirect" accesses.
> - The code for checking variable-offset reads is somewhat shared with
>   the code for checking helper accesses. The fit is not quite perfect
>   as check_stack_boundary() assumes that the helpers clobber the stack
>   (which is not the case for a direct read).
> 
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>

Overall looks great.
Pls add C based test and split patches into
- refactoring that doesn't change the logic
- additional code to handle variable offsets
- asm tests
- C based test for test_progs

Few other nits below:

> ---
>  include/linux/bpf_verifier.h                  |   2 +-
>  kernel/bpf/verifier.c                         | 250 +++++++++++++-----
>  tools/testing/selftests/bpf/test_verifier.c   |  13 +-
>  .../testing/selftests/bpf/verifier/var_off.c  |  52 +++-
>  4 files changed, 241 insertions(+), 76 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index e941fe1484e5..76b2fce7e012 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -195,7 +195,7 @@ struct bpf_func_state {
>  	 * 0 = main function, 1 = first callee.
>  	 */
>  	u32 frameno;
> -	/* subprog number == index within subprog_stack_depth
> +	/* subprog number == index within subprog_info
>  	 * zero == main subprog
>  	 */
>  	u32 subprogno;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 17270b8404f1..dd0436623f2e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2400,9 +2400,63 @@ static int check_stack_write(struct bpf_verifier_env *env,
>  	return 0;
>  }
>  
> -static int check_stack_read(struct bpf_verifier_env *env,
> -			    struct bpf_func_state *reg_state /* func where register points to */,
> -			    int off, int size, int value_regno)
> +/* When register 'regno' is assigned some values from stack[min_off, max_off),
> + * we set the register's type according to the types of the respective stack
> + * slots. If all the stack values are known to be zeros, then so is the
> + * destination reg. Otherwise, the register is considered to be SCALAR. This
> + * function does not deal with register filling; the caller must ensure that
> + * all spilled registers in the stack range have been marked as read.
> + */
> +static void mark_reg_stack_read(struct bpf_verifier_env *env,
> +				/* func where src register points to */


It's a bit odd to add comments in the function proto.
pls move it into the comment immediately preceding.

> +				struct bpf_func_state *reg_state,
> +				int min_off, int max_off, int regno)
> +{
> +	struct bpf_verifier_state *vstate = env->cur_state;
> +	struct bpf_func_state *state = vstate->frame[vstate->curframe];
> +	int i, slot, spi;
> +	u8 *stype;
> +	int zeros = 0;
> +
> +	for (i = min_off; i < max_off; i++) {
> +		slot = -i - 1;
> +		spi = slot / BPF_REG_SIZE;
> +		stype = reg_state->stack[spi].slot_type;
> +		if (stype[slot % BPF_REG_SIZE] != STACK_ZERO)
> +			break;
> +		zeros++;
> +	}
> +	if (zeros == (max_off - min_off)) {

Extra () are unnecessary.

> +		/* any access_size read into register is zero extended,
> +		 * so the whole register == const_zero
> +		 */
> +		__mark_reg_const_zero(&state->regs[regno]);
> +		/* backtracking doesn't support STACK_ZERO yet,
> +		 * so mark it precise here, so that later
> +		 * backtracking can stop here.
> +		 * Backtracking may not need this if this register
> +		 * doesn't participate in pointer adjustment.
> +		 * Forward propagation of precise flag is not
> +		 * necessary either. This mark is only to stop
> +		 * backtracking. Any register that contributed
> +		 * to const 0 was marked precise before spill.
> +		 */
> +		state->regs[regno].precise = true;
> +	} else {
> +		/* have read misc data from the stack */
> +		mark_reg_unknown(env, state->regs, regno);
> +	}
> +	state->regs[regno].live |= REG_LIVE_WRITTEN;
> +}
> +
> +/* Read the stack at 'off' and put the results into the register indicated by
> + * 'value_regno'. It handles reg filling if the addressed stack slot is a
> + * spilled reg.
> + */
> +static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
> +				      /* func where src register points to */
> +				      struct bpf_func_state *reg_state,
> +				      int off, int size, int value_regno)
>  {
>  	struct bpf_verifier_state *vstate = env->cur_state;
>  	struct bpf_func_state *state = vstate->frame[vstate->curframe];
> @@ -2460,54 +2514,91 @@ static int check_stack_read(struct bpf_verifier_env *env,
>  		}
>  		mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
>  	} else {
> -		int zeros = 0;
> -
> +		u8 type;

Empty line needed after var defs.

Also pls run checkpatch.pl on your patch. It's not hard requirement,
but pls try to fix what it complains about.

>  		for (i = 0; i < size; i++) {
> -			if (stype[(slot - i) % BPF_REG_SIZE] == STACK_MISC)
> +			type = stype[(slot - i) % BPF_REG_SIZE];
> +			if (type == STACK_MISC)
>  				continue;
> -			if (stype[(slot - i) % BPF_REG_SIZE] == STACK_ZERO) {
> -				zeros++;
> +			if (type == STACK_ZERO)
>  				continue;
> -			}
>  			verbose(env, "invalid read from stack off %d+%d size %d\n",
>  				off, i, size);
>  			return -EACCES;
>  		}
>  		mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
> -		if (value_regno >= 0) {
> -			if (zeros == size) {
> -				/* any size read into register is zero extended,
> -				 * so the whole register == const_zero
> -				 */
> -				__mark_reg_const_zero(&state->regs[value_regno]);
> -				/* backtracking doesn't support STACK_ZERO yet,
> -				 * so mark it precise here, so that later
> -				 * backtracking can stop here.
> -				 * Backtracking may not need this if this register
> -				 * doesn't participate in pointer adjustment.
> -				 * Forward propagation of precise flag is not
> -				 * necessary either. This mark is only to stop
> -				 * backtracking. Any register that contributed
> -				 * to const 0 was marked precise before spill.
> -				 */
> -				state->regs[value_regno].precise = true;
> -			} else {
> -				/* have read misc data from the stack */
> -				mark_reg_unknown(env, state->regs, value_regno);
> -			}
> -			state->regs[value_regno].live |= REG_LIVE_WRITTEN;
> -		}
> +		if (value_regno >= 0)
> +			mark_reg_stack_read(env, reg_state, off, off + size, value_regno);
>  	}
>  	return 0;
>  }
>  
> -static int check_stack_access(struct bpf_verifier_env *env,
> -			      const struct bpf_reg_state *reg,
> -			      int off, int size)
> +enum stack_access_type {
> +	ACCESS_DIRECT,  /* the access is performed by an instruction */
> +	ACCESS_HELPER,  /* the access is performed by a helper*/

extra space is needed before */

> +};
> +
> +static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
> +				int off,
> +				int access_size, bool zero_size_allowed,
> +				enum stack_access_type type,
> +				struct bpf_call_arg_meta *meta);
> +
> +/* Read the stack at 'ptr_regno + off' and put the result into the register
> + * 'dst_regno'.
> + * 'off' includes the pointer register's fixed offset(i.e. 'ptr_regno.off'),
> + * but not its variable offset.
> + * 'size' is assumed to be <= reg size and the access is assumed to be aligned.
> + *
> + * As opposed to check_stack_read_fixed_off, this function doesn't deal with
> + * filling registers (i.e. reads of spilled register cannot be detected when
> + * the offset is not fixed). We conservatively mark 'dst_regno' as containing
> + * SCALAR_VALUE. That's why we assert that the 'ptr_regno' has a variable
> + * offset; for a fixed offset 'check_stack_read_fixed_off' should be used
> + * instead.
> + */
> +static int check_stack_read_var_off(struct bpf_verifier_env *env,
> +				    int ptr_regno, int off, int size, int dst_regno)
>  {
> -	/* Stack accesses must be at a fixed offset, so that we
> -	 * can determine what type of data were returned. See
> -	 * check_stack_read().
> +	int err;
> +	int min_off, max_off;
> +	struct bpf_verifier_state *vstate = env->cur_state;
> +	struct bpf_func_state *state = vstate->frame[vstate->curframe];
> +	struct bpf_reg_state *reg = state->regs + ptr_regno;
> +
> +	if (tnum_is_const(reg->var_off)) {
> +		char tn_buf[48];
> +
> +		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> +		verbose(env, "%s: fixed stack access illegal: reg=%d var_off=%s off=%d size=%d\n",
> +			__func__, ptr_regno, tn_buf, off, size);
> +		return -EINVAL;
> +	}
> +	/* Note that we pass a NULL meta, so raw access will not be permitted. Also
> +	 * note that, for simplicity, check_stack_boundary is going to pretend that
> +	 * all the stack slots in range [off, off+size) will be clobbered, although
> +	 * that's not the case for a stack read.
> +	 */
> +	err = check_stack_boundary(env, ptr_regno, off, size,
> +			false, ACCESS_DIRECT, NULL);
> +	if (err)
> +		return err;
> +
> +	min_off = reg->smin_value + off;
> +	max_off = reg->smax_value + off;
> +	mark_reg_stack_read(env, state, min_off, max_off + size, dst_regno);
> +	return 0;
> +}
> +
> +
> +// check that stack access falls within stack limits and that 'reg' doesn't
> +// have a variable offset.
> +// 'off' includes 'reg->off'.

C++ style comments are not allowed.

> +static int check_fixed_stack_access(struct bpf_verifier_env *env,
> +				    const struct bpf_reg_state *reg,
> +				    int off, int size)
> +{
> +	/* Stack accesses must be at a fixed offset for register spill tracking.
> +	 * See check_stack_write().
>  	 */
>  	if (!tnum_is_const(reg->var_off)) {
>  		char tn_buf[48];
> @@ -2980,7 +3071,7 @@ static int check_ptr_alignment(struct bpf_verifier_env *env,
>  	case PTR_TO_STACK:
>  		pointer_desc = "stack ";
>  		/* The stack spill tracking logic in check_stack_write()
> -		 * and check_stack_read() relies on stack accesses being
> +		 * and check_stack_read_fixed_off() relies on stack accesses being
>  		 * aligned.
>  		 */
>  		strict = true;
> @@ -3513,22 +3604,36 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  		}
>  
>  	} else if (reg->type == PTR_TO_STACK) {
> -		off += reg->var_off.value;
> -		err = check_stack_access(env, reg, off, size);
> -		if (err)
> -			return err;
> +		if ((t == BPF_WRITE)

unnecessary ()

> +				/* fixed offset stack reads track reg fills */
> +				|| tnum_is_const(reg->var_off)
> +				/* reads that don't go to a register need extra checks about
> +				 * what's being read in order to not leak pointers (see
> +				 * check_stack_read_fixed_off)
> +				 */

The comments inside if() look odd. Do we have a precedent for such things?
I think it would read better if they're outside.

> +				|| (value_regno < 0)) {
...

> +/* Returns true if every part of exp (tab-separated) appears in log, in order.
> + */
>  static bool cmp_str_seq(const char *log, const char *exp)
>  {
> -	char needle[80];
> +	char needle[200];

string output longer than 80 chars? where?

>  	const char *p, *q;
>  	int len;
>  
> @@ -1048,7 +1053,11 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>  			printf("FAIL\nUnexpected success to load!\n");
>  			goto fail_log;
>  		}
> -		if (!expected_err || !strstr(bpf_vlog, expected_err)) {
> +		if (!expected_err) {
> +			printf("FAIL\nTestcase bug; missing expected_err\n");
> +			goto fail_log;
> +		}
> +		if ((strlen(expected_err) > 0) && !cmp_str_seq(bpf_vlog, expected_err)) {
>  			printf("FAIL\nUnexpected error message!\n\tEXP: %s\n\tRES: %s\n",
>  			      expected_err, bpf_vlog);
>  			goto fail_log;
> diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
> index 8504ac937809..a1a46a6ec376 100644
> --- a/tools/testing/selftests/bpf/verifier/var_off.c
> +++ b/tools/testing/selftests/bpf/verifier/var_off.c
> @@ -18,7 +18,7 @@
>  	.prog_type = BPF_PROG_TYPE_LWT_IN,
>  },
>  {
> -	"variable-offset stack access",
> +	"variable-offset stack read",
>  	.insns = {
>  	/* Fill the top 8 bytes of the stack */
>  	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> @@ -31,11 +31,57 @@
>  	 * we don't know which
>  	 */
>  	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
> -	/* dereference it */
> +	/* dereference it for a stack read */
> +	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),
> +	},
> +	.result = ACCEPT,
> +	.result_unpriv = REJECT,
> +	.errstr_unpriv =
> +		"variable stack access var_off=(0xfffffffffffffff8; 0x4) off=-8 size=1\tR2 stack pointer arithmetic goes out of range, prohibited for !root",

this one?
Just trim it. The verifier messages change often. If expected string
is too strict it creates code churn.

> +	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
> +},
