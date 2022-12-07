Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96846451A4
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 03:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLGCBS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 21:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLGCBR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 21:01:17 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D589A532CB
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 18:01:15 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q15so15170245pja.0
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 18:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=taLX82soj4jMQVeqsS4Y4EPfdNlv0dphY/rsZiIU+Nw=;
        b=S/u7pTVwNOVXPzemGoZOAtQTGbOjskxdrRuSfJPZ5y5oJ/GLuADVs3/c5P2+6WY4NG
         uj33LmcmHTrfR+Ee+H5ec1ovmhHigdPVIo2zJDJ2+yLLnETu8D3oSsVAhn/en2lUAeAB
         +wALSRyotYYVBB/tr5g5V/W/mKPp6dhUPeqI7tp0WcND9ardlq9zSPWLZ9AFpXkycqvB
         dnQk+caCWWyrVc46tKkR6rd0NjAE0zMkqARd54T6BDElYjSuUY32tIYcuI/1f2tU4rC/
         CMpbLLiCO50kLVM2ONRu1shSP65w8X/IHG2Kty3y/Dg+XBjDRbXcMrSlUjAAJWnHLgLw
         j3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taLX82soj4jMQVeqsS4Y4EPfdNlv0dphY/rsZiIU+Nw=;
        b=fPP9E+KWie5z8quOoKqMHYF6HScKomjFYPY+cI6fpRmt7Y+OPPq/4U5/Pn4E7FFKTu
         +Xw+34bl8PHUbbFexDJa5yTnTd9vvHm0k5Dce1EfrOkaoB4TIvdizuNe9mBICU1x7xe+
         2hkOMTp3c1a9YIPZf+2HLDBumDiSQzxFeHL10f04pFiLcfN0eGNbMcw5bK/FhYiXyYVT
         09b8wO/wEIiQWkJcigR7KASeed2Q6TDNH09G0BZDMdVer3esaalM/pmNkdh1N58pme4g
         1fYqhHxbr4ttIi6PxjPNJqEfJs15QsjNTANaELloUxXFM4D6JvIbsYlhsyy/TAtZ2EEy
         vJ+w==
X-Gm-Message-State: ANoB5pmZdDajKpj1yfMq3ul7w/WeIXJa55RyPlnPSdg+R35LugWf87Yc
        O7T0RFj5LC3naa5FC1jZUmE=
X-Google-Smtp-Source: AA0mqf5Q4ecRaORbqb1UBDeio3EmqDqE8fjFwq8wRsSvCTSEJH5I4svEoHWGMeZhhcM/CeJhNEsw3g==
X-Received: by 2002:a17:90a:cf16:b0:219:861a:ac10 with SMTP id h22-20020a17090acf1600b00219861aac10mr487397pju.6.1670378475233;
        Tue, 06 Dec 2022 18:01:15 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090a3fcf00b00219feae9486sm43915pjm.7.2022.12.06.18.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 18:01:14 -0800 (PST)
Date:   Tue, 6 Dec 2022 18:01:11 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 08/13] bpf: Add callback validation to kfunc
 verifier logic
Message-ID: <Y4/z54TrZgQUvc2p@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-9-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206231000.3180914-9-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 06, 2022 at 03:09:55PM -0800, Dave Marchevsky wrote:
> Some BPF helpers take a callback function which the helper calls. For
> each helper that takes such a callback, there's a special call to
> __check_func_call with a callback-state-setting callback that sets up
> verifier bpf_func_state for the callback's frame.
> 
> kfuncs don't have any of this infrastructure yet, so let's add it in
> this patch, following existing helper pattern as much as possible. To
> validate functionality of this added plumbing, this patch adds
> callback handling for the bpf_rbtree_add kfunc and hopes to lay
> groundwork for future next-gen datastructure callbacks.
> 
> In the "general plumbing" category we have:
> 
>   * check_kfunc_call doing callback verification right before clearing
>     CALLER_SAVED_REGS, exactly like check_helper_call
>   * recognition of func_ptr BTF types in kfunc args as
>     KF_ARG_PTR_TO_CALLBACK + propagation of subprogno for this arg type
> 
> In the "rbtree_add / next-gen datastructure-specific plumbing" category:
> 
>   * Since bpf_rbtree_add must be called while the spin_lock associated
>     with the tree is held, don't complain when callback's func_state
>     doesn't unlock it by frame exit
>   * Mark rbtree_add callback's args PTR_UNTRUSTED to prevent rbtree
>     api functions from being called in the callback
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  kernel/bpf/verifier.c | 136 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 130 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 652112007b2c..9ad8c0b264dc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1448,6 +1448,16 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
>  	reg->type &= ~PTR_MAYBE_NULL;
>  }
>  
> +static void mark_reg_datastructure_node(struct bpf_reg_state *regs, u32 regno,
> +					struct btf_field_datastructure_head *ds_head)
> +{
> +	__mark_reg_known_zero(&regs[regno]);
> +	regs[regno].type = PTR_TO_BTF_ID | MEM_ALLOC;
> +	regs[regno].btf = ds_head->btf;
> +	regs[regno].btf_id = ds_head->value_btf_id;
> +	regs[regno].off = ds_head->node_offset;
> +}
> +
>  static bool reg_is_pkt_pointer(const struct bpf_reg_state *reg)
>  {
>  	return type_is_pkt_pointer(reg->type);
> @@ -4771,7 +4781,8 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>  			return -EACCES;
>  		}
>  
> -		if (type_is_alloc(reg->type) && !reg->ref_obj_id) {
> +		if (type_is_alloc(reg->type) && !reg->ref_obj_id &&
> +		    !cur_func(env)->in_callback_fn) {
>  			verbose(env, "verifier internal error: ref_obj_id for allocated object must be non-zero\n");
>  			return -EFAULT;
>  		}
> @@ -6952,6 +6963,8 @@ static int set_callee_state(struct bpf_verifier_env *env,
>  			    struct bpf_func_state *caller,
>  			    struct bpf_func_state *callee, int insn_idx);
>  
> +static bool is_callback_calling_kfunc(u32 btf_id);
> +
>  static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			     int *insn_idx, int subprog,
>  			     set_callee_state_fn set_callee_state_cb)
> @@ -7006,10 +7019,18 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  	 * interested in validating only BPF helpers that can call subprogs as
>  	 * callbacks
>  	 */
> -	if (set_callee_state_cb != set_callee_state && !is_callback_calling_function(insn->imm)) {
> -		verbose(env, "verifier bug: helper %s#%d is not marked as callback-calling\n",
> -			func_id_name(insn->imm), insn->imm);
> -		return -EFAULT;
> +	if (set_callee_state_cb != set_callee_state) {
> +		if (bpf_pseudo_kfunc_call(insn) &&
> +		    !is_callback_calling_kfunc(insn->imm)) {
> +			verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
> +				func_id_name(insn->imm), insn->imm);
> +			return -EFAULT;
> +		} else if (!bpf_pseudo_kfunc_call(insn) &&
> +			   !is_callback_calling_function(insn->imm)) { /* helper */
> +			verbose(env, "verifier bug: helper %s#%d not marked as callback-calling\n",
> +				func_id_name(insn->imm), insn->imm);
> +			return -EFAULT;
> +		}
>  	}
>  
>  	if (insn->code == (BPF_JMP | BPF_CALL) &&
> @@ -7275,6 +7296,67 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
>  	return 0;
>  }
>  
> +static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
> +					 struct bpf_func_state *caller,
> +					 struct bpf_func_state *callee,
> +					 int insn_idx)
> +{
> +	/* void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
> +	 *                     bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b));
> +	 *
> +	 * 'struct bpf_rb_node *node' arg to bpf_rbtree_add is the same PTR_TO_BTF_ID w/ offset
> +	 * that 'less' callback args will be receiving. However, 'node' arg was release_reference'd
> +	 * by this point, so look at 'root'
> +	 */
> +	struct btf_field *field;
> +	struct btf_record *rec;
> +
> +	rec = reg_btf_record(&caller->regs[BPF_REG_1]);
> +	if (!rec)
> +		return -EFAULT;
> +
> +	field = btf_record_find(rec, caller->regs[BPF_REG_1].off, BPF_RB_ROOT);
> +	if (!field || !field->datastructure_head.value_btf_id)
> +		return -EFAULT;
> +
> +	mark_reg_datastructure_node(callee->regs, BPF_REG_1, &field->datastructure_head);
> +	callee->regs[BPF_REG_1].type |= PTR_UNTRUSTED;
> +	mark_reg_datastructure_node(callee->regs, BPF_REG_2, &field->datastructure_head);
> +	callee->regs[BPF_REG_2].type |= PTR_UNTRUSTED;

Please add a comment here to explain that the pointers are actually trusted
and here it's a quick hack to prevent callback to call into rb_tree kfuncs.
We definitely would need to clean it up.
Have you tried to check for is_bpf_list_api_kfunc() || is_bpf_rbtree_api_kfunc()
while processing kfuncs inside callback ?

> +	callee->in_callback_fn = true;

this will give you a flag to do that check.

> +	callee->callback_ret_range = tnum_range(0, 1);
> +	return 0;
> +}
> +
> +static bool is_rbtree_lock_required_kfunc(u32 btf_id);
> +
> +/* Are we currently verifying the callback for a rbtree helper that must
> + * be called with lock held? If so, no need to complain about unreleased
> + * lock
> + */
> +static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
> +{
> +	struct bpf_verifier_state *state = env->cur_state;
> +	struct bpf_insn *insn = env->prog->insnsi;
> +	struct bpf_func_state *callee;
> +	int kfunc_btf_id;
> +
> +	if (!state->curframe)
> +		return false;
> +
> +	callee = state->frame[state->curframe];
> +
> +	if (!callee->in_callback_fn)
> +		return false;
> +
> +	kfunc_btf_id = insn[callee->callsite].imm;
> +	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
> +}
> +
>  static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  {
>  	struct bpf_verifier_state *state = env->cur_state;
> @@ -8007,6 +8089,7 @@ struct bpf_kfunc_call_arg_meta {
>  	bool r0_rdonly;
>  	u32 ret_btf_id;
>  	u64 r0_size;
> +	u32 subprogno;
>  	struct {
>  		u64 value;
>  		bool found;
> @@ -8185,6 +8268,18 @@ static bool is_kfunc_arg_rbtree_node(const struct btf *btf, const struct btf_par
>  	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_ID);
>  }
>  
> +static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, const struct btf *btf,
> +				  const struct btf_param *arg)
> +{
> +	const struct btf_type *t;
> +
> +	t = btf_type_resolve_func_ptr(btf, arg->type, NULL);
> +	if (!t)
> +		return false;
> +
> +	return true;
> +}
> +
>  /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
>  static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
>  					const struct btf *btf,
> @@ -8244,6 +8339,7 @@ enum kfunc_ptr_arg_type {
>  	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
>  	KF_ARG_PTR_TO_MEM,
>  	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip it */
> +	KF_ARG_PTR_TO_CALLBACK,
>  	KF_ARG_PTR_TO_RB_ROOT,
>  	KF_ARG_PTR_TO_RB_NODE,
>  };
> @@ -8368,6 +8464,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>  		return KF_ARG_PTR_TO_BTF_ID;
>  	}
>  
> +	if (is_kfunc_arg_callback(env, meta->btf, &args[argno]))
> +		return KF_ARG_PTR_TO_CALLBACK;
> +
>  	if (argno + 1 < nargs && is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]))
>  		arg_mem_size = true;
>  
> @@ -8585,6 +8684,16 @@ static bool is_bpf_datastructure_api_kfunc(u32 btf_id)
>  	return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(btf_id);
>  }
>  
> +static bool is_callback_calling_kfunc(u32 btf_id)
> +{
> +	return btf_id == special_kfunc_list[KF_bpf_rbtree_add];
> +}
> +
> +static bool is_rbtree_lock_required_kfunc(u32 btf_id)
> +{
> +	return is_bpf_rbtree_api_kfunc(btf_id);
> +}
> +
>  static bool check_kfunc_is_datastructure_head_api(struct bpf_verifier_env *env,
>  						  enum btf_field_type head_field_type,
>  						  u32 kfunc_btf_id)
> @@ -8920,6 +9029,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  		case KF_ARG_PTR_TO_RB_NODE:
>  		case KF_ARG_PTR_TO_MEM:
>  		case KF_ARG_PTR_TO_MEM_SIZE:
> +		case KF_ARG_PTR_TO_CALLBACK:
>  			/* Trusted by default */
>  			break;
>  		default:
> @@ -9078,6 +9188,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			/* Skip next '__sz' argument */
>  			i++;
>  			break;
> +		case KF_ARG_PTR_TO_CALLBACK:
> +			meta->subprogno = reg->subprogno;
> +			break;
>  		}
>  	}
>  
> @@ -9193,6 +9306,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		}
>  	}
>  
> +	if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_add]) {
> +		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
> +					set_rbtree_add_callback_state);
> +		if (err) {
> +			verbose(env, "kfunc %s#%d failed callback verification\n",
> +				func_name, func_id);
> +			return err;
> +		}
> +	}
> +
>  	for (i = 0; i < CALLER_SAVED_REGS; i++)
>  		mark_reg_not_init(env, regs, caller_saved[i]);
>  
> @@ -14023,7 +14146,8 @@ static int do_check(struct bpf_verifier_env *env)
>  					return -EINVAL;
>  				}
>  
> -				if (env->cur_state->active_lock.ptr) {
> +				if (env->cur_state->active_lock.ptr &&
> +				    !in_rbtree_lock_required_cb(env)) {

That looks wrong.
It will allow callbacks to use unpaired lock/unlock.
Have you tried clearing cur_state->active_lock when entering callback?
That should solve it and won't cause lock/unlock imbalance.
