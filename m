Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069F51B2CB4
	for <lists+bpf@lfdr.de>; Tue, 21 Apr 2020 18:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDUQbK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Apr 2020 12:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgDUQbJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Apr 2020 12:31:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE25C061A10
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2020 09:31:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so4427399wma.4
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2020 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RSOD+EocmD2nnPQ6fEFXuco5ZrsyM/JYIog2Fwtffuk=;
        b=ft8fuFy8xIghnknLlyYt+6ZIx9wia3y4+8eDvov3+az4OXQrAmS7E9y/oQiK7pimgH
         VfKKRxgOGJLzUYcD2gghj1kYk1ZRjzR87Aw10JJrpfRwa2Dqhiij2IE4tHH1eavCmyY4
         rXw42hBXl7fj04aCiL4mQMtS5gAzUb8fcIUjnPyQOVkO/xnehMlec9/iJbtdMoxfXM78
         s9Ocqxj3huVlEWQcEKbKdn3t8+x1SkYwhR/vCPOQAh0o+qzot+Y1lTmJvbLVdvRaFjPJ
         gowAZhOn2cnp0JC0vZWrrIwW2IRGOsmQBhg3HriYZfwpGGB2evR6uToS+STIMEmSvNmo
         dR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RSOD+EocmD2nnPQ6fEFXuco5ZrsyM/JYIog2Fwtffuk=;
        b=L26IBrVmOMA8ppAduG6PRmLPuyyiVjE84uKq37lKfbOtqVTS7Q/Tx5a63m5sBBnOA0
         S23zZv3LkMN4MZwM2Jbwr1Wl84xH8buGJrSzjwFnSiegMqCn7214ZKv+6EQ1aNwCR0TY
         EuCRlEH3yiDfXAN6cvLIOuKTydOXERuVm1GYm45WceKltxG1L84zk+ebDn1yRccBHAzr
         OLS1S6lmEquiF+GDGLog9KY9VRlAF2YmupOuxZYgrkt0SQfl9O5SuexY5NR0G0J/ijpt
         +xJ3PbqQVzIMq223vP+elJ3ljT/jTI3PtOBW3TfWbDlSThobuCnFPOfQyoux3aTeZMKq
         9GPg==
X-Gm-Message-State: AGi0PuY1nSd9DdjxbHT3RzbaCJ8BIcK9bEgRgYMcxSub26Td5nNu7D1H
        0uIpkrrsT/ialbw5aPyIBAA=
X-Google-Smtp-Source: APiQypKfQVYWX0WziWlNiiFJTOdgMVz3Cb3Ezi8TNMYGO78ABUPI1KcgVwZ3jmH3O5jrb4DqVZNABA==
X-Received: by 2002:a1c:9e51:: with SMTP id h78mr6204059wme.177.1587486667734;
        Tue, 21 Apr 2020 09:31:07 -0700 (PDT)
Received: from localhost (host110-66-dynamic.40-79-r.retail.telecomitalia.it. [79.40.66.110])
        by smtp.gmail.com with ESMTPSA id f18sm4616967wrq.29.2020.04.21.09.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:31:07 -0700 (PDT)
Date:   Tue, 21 Apr 2020 18:31:00 +0200
From:   Lorenzo Fontana <fontanalorenz@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     gregkh@linuxfoundation.org, alexei.starovoitov@gmail.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, jannh@google.com,
        leodidonato@gmail.com, yhs@fb.com, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH stable 4.19] bpf: fix buggy r0 retval refinement for
 tracing helpers
Message-ID: <20200421163100.GA2792583@gallifrey>
References: <20200421125822.14073-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421125822.14073-1-daniel@iogearbox.net>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 21, 2020 at 02:58:22PM +0200, Daniel Borkmann wrote:
> [ no upstream commit ]
> 
> See the glory details in 100605035e15 ("bpf: Verifier, do_refine_retval_range
> may clamp umin to 0 incorrectly") for why 849fa50662fb ("bpf/verifier: refine
> retval R0 state for bpf_get_stack helper") is buggy. The whole series however
> is not suitable for stable since it adds significant amount [0] of verifier
> complexity in order to add 32bit subreg tracking. Something simpler is needed.
> 
> Unfortunately, reverting 849fa50662fb ("bpf/verifier: refine retval R0 state
> for bpf_get_stack helper") or just cherry-picking 100605035e15 ("bpf: Verifier,
> do_refine_retval_range may clamp umin to 0 incorrectly") is not an option since
> it will break existing tracing programs badly (at least those that are using
> bpf_get_stack() and bpf_probe_read_str() helpers). Not fixing it in stable is
> also not an option since on 4.19 kernels an error will cause a soft-lockup due
> to hitting dead-code sanitized branch since we don't hard-wire such branches
> in old kernels yet. But even then for 5.x 849fa50662fb ("bpf/verifier: refine
> retval R0 state for bpf_get_stack helper") would cause wrong bounds on the
> verifier simluation when an error is hit.
> 
> In one of the earlier iterations of mentioned patch series for upstream there
> was the concern that just using smax_value in do_refine_retval_range() would
> nuke bounds by subsequent <<32 >>32 shifts before the comparison against 0 [1]
> which eventually led to the 32bit subreg tracking in the first place. While I
> initially went for implementing the idea [1] to pattern match the two shift
> operations, it turned out to be more complex than actually needed, meaning, we
> could simply treat do_refine_retval_range() similarly to how we branch off
> verification for conditionals or under speculation, that is, pushing a new
> reg state to the stack for later verification. This means, instead of verifying
> the current path with the ret_reg in [S32MIN, msize_max_value] interval where
> later bounds would get nuked, we split this into two: i) for the success case
> where ret_reg can be in [0, msize_max_value], and ii) for the error case with
> ret_reg known to be in interval [S32MIN, -1]. Latter will preserve the bounds
> during these shift patterns and can match reg < 0 test. test_progs also succeed
> with this approach.
> 
>   [0] https://lore.kernel.org/bpf/158507130343.15666.8018068546764556975.stgit@john-Precision-5820-Tower/
>   [1] https://lore.kernel.org/bpf/158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370/T/#m2e0ad1d5949131014748b6daa48a3495e7f0456d
> 
> Fixes: 849fa50662fb ("bpf/verifier: refine retval R0 state for bpf_get_stack helper")
> Reported-by: Lorenzo Fontana <fontanalorenz@gmail.com>
> Reported-by: Leonardo Di Donato <leodidonato@gmail.com>
> Reported-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Tested-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  [ Lorenzo, Leonardo, I did check my local checkout of driver/bpf/probe.o,
>    but please make sure to double check 4.19 with this patch here also from
>    your side, so we can add a Tested-by from one of you before Greg takes
>    it into stable. Thanks guys! ]
> 
>  kernel/bpf/verifier.c | 45 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e85636fb81b9..daf0a9637d73 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -188,8 +188,7 @@ struct bpf_call_arg_meta {
>  	bool pkt_access;
>  	int regno;
>  	int access_size;
> -	s64 msize_smax_value;
> -	u64 msize_umax_value;
> +	u64 msize_max_value;
>  };
>  
>  static DEFINE_MUTEX(bpf_verifier_lock);
> @@ -2076,8 +2075,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
>  		/* remember the mem_size which may be used later
>  		 * to refine return values.
>  		 */
> -		meta->msize_smax_value = reg->smax_value;
> -		meta->msize_umax_value = reg->umax_value;
> +		meta->msize_max_value = reg->umax_value;
>  
>  		/* The register is SCALAR_VALUE; the access check
>  		 * happens using its boundaries.
> @@ -2448,21 +2446,44 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  	return 0;
>  }
>  
> -static void do_refine_retval_range(struct bpf_reg_state *regs, int ret_type,
> -				   int func_id,
> -				   struct bpf_call_arg_meta *meta)
> +static int do_refine_retval_range(struct bpf_verifier_env *env,
> +				  struct bpf_reg_state *regs, int ret_type,
> +				  int func_id, struct bpf_call_arg_meta *meta)
>  {
>  	struct bpf_reg_state *ret_reg = &regs[BPF_REG_0];
> +	struct bpf_reg_state tmp_reg = *ret_reg;
> +	bool ret;
>  
>  	if (ret_type != RET_INTEGER ||
>  	    (func_id != BPF_FUNC_get_stack &&
>  	     func_id != BPF_FUNC_probe_read_str))
> -		return;
> +		return 0;
> +
> +	/* Error case where ret is in interval [S32MIN, -1]. */
> +	ret_reg->smin_value = S32_MIN;
> +	ret_reg->smax_value = -1;
> +
> +	__reg_deduce_bounds(ret_reg);
> +	__reg_bound_offset(ret_reg);
> +	__update_reg_bounds(ret_reg);
> +
> +	ret = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
> +	if (!ret)
> +		return -EFAULT;
> +
> +	*ret_reg = tmp_reg;
> +
> +	/* Success case where ret is in range [0, msize_max_value]. */
> +	ret_reg->smin_value = 0;
> +	ret_reg->smax_value = meta->msize_max_value;
> +	ret_reg->umin_value = ret_reg->smin_value;
> +	ret_reg->umax_value = ret_reg->smax_value;
>  
> -	ret_reg->smax_value = meta->msize_smax_value;
> -	ret_reg->umax_value = meta->msize_umax_value;
>  	__reg_deduce_bounds(ret_reg);
>  	__reg_bound_offset(ret_reg);
> +	__update_reg_bounds(ret_reg);
> +
> +	return 0;
>  }
>  
>  static int
> @@ -2617,7 +2638,9 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>  		return -EINVAL;
>  	}
>  
> -	do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
> +	err = do_refine_retval_range(env, regs, fn->ret_type, func_id, &meta);
> +	if (err)
> +		return err;
>  
>  	err = check_map_func_compatibility(env, meta.map_ptr, func_id);
>  	if (err)
> -- 
> 2.20.1
> 

Hi Daniel,
Leonardo and I applied this on top of 8e2406c85187 and our old probe works as
expected, as well as the new one.
We produced a dot graph [0] of the in memory xlated representation [1], it clearly
shows that this patch solves the bug. A rendered [2] version is
available for the lazy.

So, Daniel please add a Tested-by for each one of us.

Thanks Daniel!
Lorenzo and Leonardo

[0] https://fs.fntlnz.wtf/kernel/bpf-retval-refinement-4-19/prog.dot
[1] https://fs.fntlnz.wtf/kernel/bpf-retval-refinement-4-19/xlated.txt
[2] https://fs.fntlnz.wtf/kernel/bpf-retval-refinement-4-19/render.png
