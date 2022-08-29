Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0C15A4F17
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 16:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiH2OX3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 10:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiH2OX2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 10:23:28 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38A98FD73
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 07:23:26 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSfff-0009iv-SP; Mon, 29 Aug 2022 16:23:23 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSfff-000C6I-L1; Mon, 29 Aug 2022 16:23:23 +0200
Subject: Re: [PATCH bpf-next 1/2] bpf: propagate nullness information for reg
 to reg comparisons
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, kernel-team@fb.com, yhs@fb.com,
        john.fastabend@gmail.com
References: <20220826172915.1536914-1-eddyz87@gmail.com>
 <20220826172915.1536914-2-eddyz87@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <60a49435-85b8-f752-51d6-3946fa186b24@iogearbox.net>
Date:   Mon, 29 Aug 2022 16:23:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220826172915.1536914-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26642/Mon Aug 29 09:54:26 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/26/22 7:29 PM, Eduard Zingerman wrote:
> Propagate nullness information for branches of register to register
> equality compare instructions. The following rules are used:
> - suppose register A maybe null
> - suppose register B is not null
> - for JNE A, B, ... - A is not null in the false branch
> - for JEQ A, B, ... - A is not null in the true branch
> 
[...]
>   kernel/bpf/verifier.c | 41 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0194a36d0b36..7585288e035b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -472,6 +472,11 @@ static bool type_may_be_null(u32 type)
>   	return type & PTR_MAYBE_NULL;
>   }
>   
> +static bool type_is_pointer(enum bpf_reg_type type)
> +{
> +	return type != NOT_INIT && type != SCALAR_VALUE;
> +}

We also have is_pointer_value(), semantics there are a bit different (and mainly to
prevent leakage under unpriv), but I wonder if this can be refactored to accommodate
both. My worry is that if in future we extend one but not the other bugs might slip
in.

>   static bool is_acquire_function(enum bpf_func_id func_id,
>   				const struct bpf_map *map)
>   {
> @@ -10064,6 +10069,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>   	struct bpf_verifier_state *other_branch;
>   	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
>   	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
> +	struct bpf_reg_state *eq_branch_regs;
>   	u8 opcode = BPF_OP(insn->code);
>   	bool is_jmp32;
>   	int pred = -1;
> @@ -10173,8 +10179,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>   	/* detect if we are comparing against a constant value so we can adjust
>   	 * our min/max values for our dst register.
>   	 * this is only legit if both are scalars (or pointers to the same
> -	 * object, I suppose, but we don't support that right now), because
> -	 * otherwise the different base pointers mean the offsets aren't
> +	 * object, I suppose, see the PTR_MAYBE_NULL related if block below),
> +	 * because otherwise the different base pointers mean the offsets aren't
>   	 * comparable.
>   	 */
>   	if (BPF_SRC(insn->code) == BPF_X) {
> @@ -10223,6 +10229,37 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>   		find_equal_scalars(other_branch, &other_branch_regs[insn->dst_reg]);
>   	}
>   
> +	/* if one pointer register is compared to another pointer
> +	 * register check if PTR_MAYBE_NULL could be lifted.
> +	 * E.g. register A - maybe null
> +	 *      register B - not null
> +	 * for JNE A, B, ... - A is not null in the false branch;
> +	 * for JEQ A, B, ... - A is not null in the true branch.
> +	 */
> +	if (!is_jmp32 &&
> +	    BPF_SRC(insn->code) == BPF_X &&
> +	    type_is_pointer(src_reg->type) && type_is_pointer(dst_reg->type) &&
> +	    type_may_be_null(src_reg->type) != type_may_be_null(dst_reg->type)) {
> +		eq_branch_regs = NULL;
> +		switch (opcode) {
> +		case BPF_JEQ:
> +			eq_branch_regs = other_branch_regs;
> +			break;
> +		case BPF_JNE:
> +			eq_branch_regs = regs;
> +			break;
> +		default:
> +			/* do nothing */
> +			break;
> +		}
> +		if (eq_branch_regs) {
> +			if (type_may_be_null(src_reg->type))
> +				mark_ptr_not_null_reg(&eq_branch_regs[insn->src_reg]);
> +			else
> +				mark_ptr_not_null_reg(&eq_branch_regs[insn->dst_reg]);
> +		}
> +	}
> +

Could we consolidate the logic above with the one below which deals with R == 0 checks?
There are some similarities, e.g. !is_jmp32, both test for jeq/jne and while one is based
on K, the other one on X, though we could also add check X == 0 for below. Anyway, just
a though that it may be nice to consolidate the handling.

>   	/* detect if R == 0 where R is returned from bpf_map_lookup_elem().
>   	 * NOTE: these optimizations below are related with pointer comparison
>   	 *       which will never be JMP32.
> 

