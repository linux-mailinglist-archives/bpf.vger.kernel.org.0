Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560F16219FF
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 18:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiKHRFC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 12:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiKHRFA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 12:05:00 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174441B9EA
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 09:04:59 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id o13so4613559pgu.7
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 09:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t8PT/sI7LbB8xs92ZEYzV7KdyM4gIu794+lDAeMz9zo=;
        b=MAbLnuHRNafr2e1H7Xaxo3GWU1yp2sqRCw5+1c0LWIwvWJWIDEjfJpKfzwaDxNZJJ9
         UPKoMCk3trApVHkfA82ReOMBySw6OvQ6miLgb5xxmRG3FtPauFPh1uBmtIGhnzxI2oGF
         evdWikwqIJKunSMjKaKVWhUx/AmjRmkMOjZMxoPgCWLx/aC6d4HcdNNHXYPo7v257Ms9
         I0G79tmtfamNUy9zcepVFXplWLoDzNHHcP3iFY3Y0T9OCFElzhszxQnUbdjQgaXzYvgu
         wJyNLxpntp33uO5j7xRREjQKxPSFUJfSZ4Ow4iYDyY4VSQa+8J+DjUUbCv590bbPkutb
         P9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8PT/sI7LbB8xs92ZEYzV7KdyM4gIu794+lDAeMz9zo=;
        b=a1mwHRNsNQXTXDfHF8B/cKQQfH/ADFU+jARQQDWSfk5SIS/2rCxL+yI4lmzR39ZGBT
         ewpgDjsWzoh8U1RZ2o8p6JbxjvjdjokA311n41nkmdjA31vS5sZas7BQTCbBHKBVmkp0
         mlb0HkoSRJ5nYxnzMFLuBPxCwyZDGf4ug4yEFMCUj7L+ax9e/ubEBGyhXXaEoQHplMV8
         cyc7FIZK5agD3nWpfT+hZumMAH12+ceRBkUwkKgmWX2AaU6FwyQud5k4vjxAgbKmMqUB
         4s75frJMILnNUkdbEoct4Ev2X0dZrG+1ZsDHbGKIz/VpMZ9lhiyyDAYadwlO+9leeMG9
         Z9qA==
X-Gm-Message-State: ACrzQf2XalGDNlEUU/dbOBw05NvaoqKEFSLj5oivLjhSjwzF9ZBWqzI4
        Oygqm24gINtUkZM4p0A/kYc=
X-Google-Smtp-Source: AMsMyM4TgnrC5Jcv8abyArYv5a/6yOzgbwmRn2uK+fAf+zA+65HTs5h/7sebJ8NJWBKL9FTPAvlC2A==
X-Received: by 2002:a05:6a02:18f:b0:44a:3972:898d with SMTP id bj15-20020a056a02018f00b0044a3972898dmr47660303pgb.525.1667927098397;
        Tue, 08 Nov 2022 09:04:58 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id o27-20020aa7979b000000b0056b932f3280sm6619570pfp.103.2022.11.08.09.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 09:04:57 -0800 (PST)
Date:   Tue, 8 Nov 2022 22:34:52 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 5/8] bpf: Add bpf_rcu_read_lock() verifier
 support
Message-ID: <20221108170452.jq24rymkfeozxtwj@apollo>
References: <20221108074047.261848-1-yhs@fb.com>
 <20221108074114.264485-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108074114.264485-1-yhs@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 08, 2022 at 01:11:14PM IST, Yonghong Song wrote:
> To simplify the design and support the common practice, no
> nested bpf_rcu_read_lock() is allowed. During verification,
> each paired bpf_rcu_read_lock()/unlock() has a unique
> region id, starting from 1. Each rcu ptr register also
> remembers the region id when the ptr reg is initialized.
> The following is a simple example to illustrate the
> rcu lock regions and usage of rcu ptr's.
>
>      ...                    <=== rcu lock region 0
>      bpf_rcu_read_lock()    <=== rcu lock region 1
>      rcu_ptr1 = ...         <=== rcu_ptr1 with region 1
>      ... using rcu_ptr1 ...
>      bpf_rcu_read_unlock()
>      ...                    <=== rcu lock region -1
>      bpf_rcu_read_lock()    <=== rcu lock region 2
>      rcu_ptr2 = ...         <=== rcu_ptr2 with region 2
>      ... using rcu_ptr2 ...
>      ... using rcu_ptr1 ... <=== wrong, region 1 rcu_ptr in region 2
>      bpf_rcu_read_unlock()
>
> Outside the rcu lock region, the rcu lock region id is 0 or negative of
> previous valid rcu lock region id, so the next valid rcu lock region
> id can be easily computed.
>
> Note that rcu protection is not needed for non-sleepable program. But
> it is supported to make cross-sleepable/nonsleepable development easier.
> For non-sleepable program, the following insns can be inside the rcu
> lock region:
>   - any non call insns except BPF_ABS/BPF_IND
>   - non sleepable helpers or kfuncs
> Also, bpf_*_storage_get() helper's 5th hidden argument (for memory
> allocation flag) should be GFP_ATOMIC.
>
> If a pointer (PTR_TO_BTF_ID) is marked as rcu, then any use of
> this pointer and the load which gets this pointer needs to be
> protected by bpf_rcu_read_lock(). The following shows a couple
> of examples:
>   struct task_struct {
>         ...
>         struct task_struct __rcu        *real_parent;
>         struct css_set __rcu            *cgroups;
>         ...
>   };
>   struct css_set {
>         ...
>         struct cgroup *dfl_cgrp;
>         ...
>   }
>   ...
>   task = bpf_get_current_task_btf();
>   cgroups = task->cgroups;
>   dfl_cgroup = cgroups->dfl_cgrp;
>   ... using dfl_cgroup ...
>
> The bpf_rcu_read_lock/unlock() should be added like below to
> avoid verification failures.
>   task = bpf_get_current_task_btf();
>   bpf_rcu_read_lock();
>   cgroups = task->cgroups;
>   dfl_cgroup = cgroups->dfl_cgrp;
>   bpf_rcu_read_unlock();
>   ... using dfl_cgroup ...
>
> The following is another example for task->real_parent.
>   task = bpf_get_current_task_btf();
>   bpf_rcu_read_lock();
>   real_parent = task->real_parent;
>   ... bpf_task_storage_get(&map, real_parent, 0, 0);
>   bpf_rcu_read_unlock();
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h          |  1 +
>  include/linux/bpf_verifier.h |  7 +++
>  kernel/bpf/btf.c             | 32 ++++++++++++-
>  kernel/bpf/verifier.c        | 92 +++++++++++++++++++++++++++++++-----
>  4 files changed, 120 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4bbcafd1c9b..98af0c9ec721 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -761,6 +761,7 @@ struct bpf_prog_ops {
>  struct btf_struct_access_info {
>  	u32 next_btf_id;
>  	enum bpf_type_flag flag;
> +	bool is_rcu;
>  };
>
>  struct bpf_verifier_ops {
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 1a32baa78ce2..5d703637bb12 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -179,6 +179,10 @@ struct bpf_reg_state {
>  	 */
>  	s32 subreg_def;
>  	enum bpf_reg_liveness live;
> +	/* 0: not rcu ptr; > 0: rcu ptr, id of the rcu read lock region where
> +	 * the rcu ptr reg is initialized.
> +	 */
> +	int active_rcu_lock;
>  	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
>  	bool precise;
>  };
> @@ -324,6 +328,8 @@ struct bpf_verifier_state {
>  	u32 insn_idx;
>  	u32 curframe;
>  	u32 active_spin_lock;
> +	/* <= 0: not in rcu read lock region; > 0: the rcu lock region id */
> +	int active_rcu_lock;
>  	bool speculative;
>
>  	/* first and last insn idx of this verifier state */
> @@ -424,6 +430,7 @@ struct bpf_insn_aux_data {
>  	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
>  	bool sanitize_stack_spill; /* subject to Spectre v4 sanitation */
>  	bool zext_dst; /* this insn zero extends dst reg */
> +	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory alloc */
>  	u8 alu_state; /* used in combination with alu_limit */
>
>  	/* below fields are initialized once */
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index d2ee1669a2f3..c5a9569f2ae0 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5831,6 +5831,7 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>  		if (btf_type_is_ptr(mtype)) {
>  			const struct btf_type *stype, *t;
>  			enum bpf_type_flag tmp_flag = 0;
> +			bool is_rcu = false;
>  			u32 id;
>
>  			if (msize != size || off != moff) {
> @@ -5850,12 +5851,16 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>  				/* check __percpu tag */
>  				if (strcmp(tag_value, "percpu") == 0)
>  					tmp_flag = MEM_PERCPU;
> +				/* check __rcu tag */
> +				if (strcmp(tag_value, "rcu") == 0)
> +					is_rcu = true;
>  			}
>
>  			stype = btf_type_skip_modifiers(btf, mtype->type, &id);
>  			if (btf_type_is_struct(stype)) {
>  				info->next_btf_id = id;
>  				info->flag = tmp_flag;
> +				info->is_rcu = is_rcu;
>  				return WALK_PTR;
>  			}
>  		}
> @@ -6317,7 +6322,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  {
>  	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>  	bool rel = false, kptr_get = false, trusted_args = false;
> -	bool sleepable = false;
> +	bool sleepable = false, rcu_lock = false, rcu_unlock = false;
>  	struct bpf_verifier_log *log = &env->log;
>  	u32 i, nargs, ref_id, ref_obj_id = 0;
>  	bool is_kfunc = btf_is_kernel(btf);
> @@ -6356,6 +6361,31 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  		kptr_get = kfunc_meta->flags & KF_KPTR_GET;
>  		trusted_args = kfunc_meta->flags & KF_TRUSTED_ARGS;
>  		sleepable = kfunc_meta->flags & KF_SLEEPABLE;
> +		rcu_lock = kfunc_meta->flags & KF_RCU_LOCK;
> +		rcu_unlock = kfunc_meta->flags & KF_RCU_UNLOCK;
> +	}
> +
> +	/* checking rcu read lock/unlock */
> +	if (env->cur_state->active_rcu_lock > 0) {
> +		if (rcu_lock) {
> +			bpf_log(log, "nested rcu read lock (kernel function %s)\n", func_name);
> +			return -EINVAL;
> +		} else if (rcu_unlock) {
> +			/* change active_rcu_lock to its corresponding negative value to
> +			 * preserve the previous lock region id.
> +			 */
> +			env->cur_state->active_rcu_lock = -env->cur_state->active_rcu_lock;
> +		} else if (sleepable) {
> +			bpf_log(log, "kernel func %s is sleepable within rcu_read_lock region\n",
> +				func_name);
> +			return -EINVAL;
> +		}
> +	} else if (rcu_lock) {
> +		/* a new lock region started, increase the region id. */
> +		env->cur_state->active_rcu_lock = (-env->cur_state->active_rcu_lock) + 1;
> +	} else if (rcu_unlock) {
> +		bpf_log(log, "unmatched rcu read unlock (kernel function %s)\n", func_name);
> +		return -EINVAL;
>  	}
>

Can you provide more context on why having ids is better than simply
invalidating the registers when the section ends, and making active_rcu_lock a
boolean instead? You can use bpf_for_each_reg_in_vstate to find every reg having
MEM_RCU and mark it unknown.

You won't have to match the id in btf_struct_access as such registers won't ever
reach that function (if marked unknown on invalidation, they become scalars).
The reg state won't need another active_rcu_lock member either, it is simply
part of reg->type.

It seems to that simply invalidating registers when rcu_read_unlock is called is
both less code to write and simpler to understand.

Having ids also makes the pruning algorithm unecessarily conservative.
Later in states_equal, the check is:

> +	if (old->active_rcu_lock != cur->active_rcu_lock)
> +		return false;

which means even though the current state just holding the RCU read lock would
be enough to prune search, it would be rejected now due to distinct IDs (e.g. if
the current path didn't make exactly the same number of rcu_read_lock calls
compared to the old state).
