Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749215B110C
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 02:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIHA1s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 20:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIHA1r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 20:27:47 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511C6D0222
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 17:27:46 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g4so1139110pgc.0
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 17:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=H/4av3KMvxgmpVRBh/8Ku/Jrn/UUQfz1tBd0dHVpSG8=;
        b=XSIN+VC1nwvBWXY89fTDGZYrE0iGepEPDQsCHv/LC0uq7OCmSkcO4i7mDI0Nm/Ph/A
         SJ+FYf9hyCyOffefXVuKytyKe2X4xJCjF5cJaWB1pWqnyzu6XUDheCSlUOUXhFB9a1HH
         JWexGyDxh5RmrY5gkDs5/pPN+NYBXNSlK8bcEnYNoazzkUM7TZnaIA6Fw3MYJO8islk2
         nnBTavtybPxG/A4+jsxJlb5WDBkfXhije6xbm1Ljvk+6tCHsajaLu991zdAk4+JzmS3N
         wM/apyhJofBvB23sYGagJQLIBwynPMbbkzyWJPxKlQYGeZ/mZ7FnZf0WOn1LyN8xvFDJ
         afEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=H/4av3KMvxgmpVRBh/8Ku/Jrn/UUQfz1tBd0dHVpSG8=;
        b=EMtUHxUiZ9o5cZBv8+ymZLwqnJJSyzHhYtLCUJQ3+pnTtEH+kV6rts0G1gppo11Ya0
         gQYqYhgYwyNtT5GDUcxirMeMBjv+nttxs0v3t0lD7VtIe6cLnmukpPd22O4+Z5CfiVhc
         PbfPOLPyyrfdq3ScJPDT32AkHgQ018M1xhm+VA8IP8RaM7ZgrQW0CgImivV/2uPPfyJ7
         iL7GrloWf9CO0QmPvhoE1/OUJQShf7St2iHQ19/hMzNs9kqSI9US23kayIOScIBzDLmW
         5kwhRx37T7pVLb1+jLTJbhf+fKlr4BIoeiL3VEWpEbKbz2nzIVlVHy70vA5hvHl23mNY
         bzlA==
X-Gm-Message-State: ACgBeo287HuPP4CdPHIshll46doS5FOwrjloXiGn619i9Jh1zTGY4uag
        5f625r7ocMHEwucWXWYhLWU=
X-Google-Smtp-Source: AA6agR6feTEUbO53yB0EhNsqdboi4A/lC78j2+eebwWExjvtwqjs4EfvK/xCRVjVxEK8uC5YmwFyDQ==
X-Received: by 2002:a05:6a00:26d1:b0:53e:1d86:bead with SMTP id p17-20020a056a0026d100b0053e1d86beadmr6515980pfw.26.1662596865634;
        Wed, 07 Sep 2022 17:27:45 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:66c4])
        by smtp.gmail.com with ESMTPSA id w13-20020a17090a780d00b002003464d81fsm298718pjk.0.2022.09.07.17.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 17:27:45 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:27:42 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
Message-ID: <20220908002742.cqwwahxa5ktaik3r@macbook-pro-4.dhcp.thefacebook.com>
References: <20220904204145.3089-1-memxor@gmail.com>
 <20220904204145.3089-22-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904204145.3089-22-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 04, 2022 at 10:41:34PM +0200, Kumar Kartikeya Dwivedi wrote:
> Global variables reside in maps accessible using direct_value_addr
> callbacks, so giving each load instruction's rewrite a unique reg->id
> disallows us from holding locks which are global.
> 
> This is not great, so refactor the active_spin_lock into two separate
> fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
> enough to allow it for global variables, map lookups, and local kptr
> registers at the same time.
> 
> Held vs non-held is indicated by active_spin_lock_ptr, which stores the
> reg->map_ptr or reg->btf pointer of the register used for locking spin
> lock. But the active_spin_lock_id also needs to be compared to ensure
> whether bpf_spin_unlock is for the same register.
> 
> Next, pseudo load instructions are not given a unique reg->id, as they
> are doing lookup for the same map value (max_entries is never greater
> than 1).
> 
> Essentially, we consider that the tuple of (active_spin_lock_ptr,
> active_spin_lock_id) will always be unique for any kind of argument to
> bpf_spin_{lock,unlock}.
> 
> Note that this can be extended in the future to also remember offset
> used for locking, so that we can introduce multiple bpf_spin_lock fields
> in the same allocation.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  3 ++-
>  kernel/bpf/verifier.c        | 39 +++++++++++++++++++++++++-----------
>  2 files changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 2a9dcefca3b6..00c21ad6f61c 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -348,7 +348,8 @@ struct bpf_verifier_state {
>  	u32 branches;
>  	u32 insn_idx;
>  	u32 curframe;
> -	u32 active_spin_lock;
> +	void *active_spin_lock_ptr;
> +	u32 active_spin_lock_id;

{map, id=0} is indeed enough to distinguish different global locks and
{map, id} for locks in map values,
but what 'btf' is for?
When is the case when reg->map_ptr is not set?
locks in allocated objects?
Feels too early to add that in this patch.

Also this patch is heavily influenced by Dave's patch with
a realization that max_entries==1 simplifies the logic.
I think you gotta give him more credit.
Maybe as much as his SOB and authorship.

>  	bool speculative;
>  
>  	/* first and last insn idx of this verifier state */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b1754fd69f7d..ed19e4036b0a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1202,7 +1202,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
>  	}
>  	dst_state->speculative = src->speculative;
>  	dst_state->curframe = src->curframe;
> -	dst_state->active_spin_lock = src->active_spin_lock;
> +	dst_state->active_spin_lock_ptr = src->active_spin_lock_ptr;
> +	dst_state->active_spin_lock_id = src->active_spin_lock_id;
>  	dst_state->branches = src->branches;
>  	dst_state->parent = src->parent;
>  	dst_state->first_insn_idx = src->first_insn_idx;
> @@ -5504,22 +5505,35 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
>  		return -EINVAL;
>  	}
>  	if (is_lock) {
> -		if (cur->active_spin_lock) {
> +		if (cur->active_spin_lock_ptr) {
>  			verbose(env,
>  				"Locking two bpf_spin_locks are not allowed\n");
>  			return -EINVAL;
>  		}
> -		cur->active_spin_lock = reg->id;
> +		if (map)
> +			cur->active_spin_lock_ptr = map;
> +		else
> +			cur->active_spin_lock_ptr = btf;
> +		cur->active_spin_lock_id = reg->id;
>  	} else {
> -		if (!cur->active_spin_lock) {
> +		void *ptr;
> +
> +		if (map)
> +			ptr = map;
> +		else
> +			ptr = btf;
> +
> +		if (!cur->active_spin_lock_ptr) {
>  			verbose(env, "bpf_spin_unlock without taking a lock\n");
>  			return -EINVAL;
>  		}
> -		if (cur->active_spin_lock != reg->id) {
> +		if (cur->active_spin_lock_ptr != ptr ||
> +		    cur->active_spin_lock_id != reg->id) {
>  			verbose(env, "bpf_spin_unlock of different lock\n");
>  			return -EINVAL;
>  		}
> -		cur->active_spin_lock = 0;
> +		cur->active_spin_lock_ptr = NULL;
> +		cur->active_spin_lock_id = 0;
>  	}
>  	return 0;
>  }
> @@ -11207,8 +11221,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
>  		dst_reg->type = PTR_TO_MAP_VALUE;
>  		dst_reg->off = aux->map_off;
> -		if (map_value_has_spin_lock(map))
> -			dst_reg->id = ++env->id_gen;
> +		WARN_ON_ONCE(map->max_entries != 1);
> +		/* We want reg->id to be same (0) as map_value is not distinct */
>  	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
>  		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
>  		dst_reg->type = CONST_PTR_TO_MAP;
> @@ -11286,7 +11300,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  		return err;
>  	}
>  
> -	if (env->cur_state->active_spin_lock) {
> +	if (env->cur_state->active_spin_lock_ptr) {
>  		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_spin_lock-ed region\n");
>  		return -EINVAL;
>  	}
> @@ -12566,7 +12580,8 @@ static bool states_equal(struct bpf_verifier_env *env,
>  	if (old->speculative && !cur->speculative)
>  		return false;
>  
> -	if (old->active_spin_lock != cur->active_spin_lock)
> +	if (old->active_spin_lock_ptr != cur->active_spin_lock_ptr ||
> +	    old->active_spin_lock_id != cur->active_spin_lock_id)
>  		return false;
>  
>  	/* for states to be equal callsites have to be the same
> @@ -13213,7 +13228,7 @@ static int do_check(struct bpf_verifier_env *env)
>  					return -EINVAL;
>  				}
>  
> -				if (env->cur_state->active_spin_lock &&
> +				if (env->cur_state->active_spin_lock_ptr &&
>  				    (insn->src_reg == BPF_PSEUDO_CALL ||
>  				     insn->imm != BPF_FUNC_spin_unlock)) {
>  					verbose(env, "function calls are not allowed while holding a lock\n");
> @@ -13250,7 +13265,7 @@ static int do_check(struct bpf_verifier_env *env)
>  					return -EINVAL;
>  				}
>  
> -				if (env->cur_state->active_spin_lock) {
> +				if (env->cur_state->active_spin_lock_ptr) {
>  					verbose(env, "bpf_spin_unlock is missing\n");
>  					return -EINVAL;
>  				}
> -- 
> 2.34.1
> 
