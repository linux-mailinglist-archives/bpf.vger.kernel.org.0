Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A2C496997
	for <lists+bpf@lfdr.de>; Sat, 22 Jan 2022 04:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiAVDbh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 22:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiAVDbg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 22:31:36 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA34CC06173B
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 19:31:36 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so14958251pjj.4
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 19:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5MHDu14fQSpZJz7j+Zy4IPZMZTay0OWmUvOWDxBw93A=;
        b=INKQo1YbvsJ0nUiqtkfzWKb8Vtrx3tcW5M0oMJk99lgsN/zaaP15TvAobfvdllaybJ
         OH0K9EBScLHP0LzJ8vVllteyICpk7IKtpoKaCdAtcFVoP6rVATpMLqGAdaMM6meB+nA+
         fSuXb/5i8qH1uvt/FvSQX+4O8tAK4q/mUU2gAOvZnTa0PjvWoPiTJkB+SbdZ8qFviiHu
         CXF7KA6+pboxfnqBKYVO/+CsEbBshyJJs+YYoSHWTau5DsiXzzk9bsOrYbuRbY3z5KL7
         9GNCLxff/BWgOHAjDbiy+MnYVhejglZxOhnSZA4EgfMi65FVA+dXJocvOS4fQYiNQ+mA
         fBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5MHDu14fQSpZJz7j+Zy4IPZMZTay0OWmUvOWDxBw93A=;
        b=mAqWcuTjW+CEQfDLE7G22vJjg6PBSgRfesaXc0oUiZTdjzJvtFJymdAgBHuTfpbphI
         bXJDUl+qQucMOnFmL/bGZzWJ12kIfe2Fl5MA/z0nUpBt4ciq3YkEFCyhDGPT3LyKn7M/
         bUje/KldrDqZEMPlg1ScDsy3s7EHmh2vCHQEdGOKKd+AW6aDKC4UjEjAVem0CadorTXK
         lhv1kQgDYAqHnQ5f9FadKOCcSgyFhnUMgWAFTWuFVcT4hYsXySjEcDjVJ2bZn/I4BxUY
         e0BFBFRfrETlJE6r5tz5PcOW2xB91I6JOPovSmvwnePT7IZgKmzWQ7gPv5Q6mrjFGsrh
         K/uw==
X-Gm-Message-State: AOAM5336Ys77qDovGhnPAXWl2MLd2bXvaQvamIOLmRxpWfJPkMC1Gddb
        +PM55DOVZzuFv02luZcDib8=
X-Google-Smtp-Source: ABdhPJzOC1oJASmXXkHRQiiIeRJmSfYlycRr4p49rgXdlGYXVTYICxrME2lwg70Waw7n768spFrwsQ==
X-Received: by 2002:a17:902:854b:b0:14a:dd78:479e with SMTP id d11-20020a170902854b00b0014add78479emr6477535plo.86.1642822296011;
        Fri, 21 Jan 2022 19:31:36 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:1fb1:21a:3dae:742c])
        by smtp.gmail.com with ESMTPSA id u30sm8691464pfg.199.2022.01.21.19.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 19:31:35 -0800 (PST)
Date:   Sat, 22 Jan 2022 09:01:33 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii.nakryiko@gmail.com, fam.zheng@bytedance.com,
        cong.wang@bytedance.com, song@kernel.org
Subject: Re: [RFC bpf-next 2/3] bpf: add support for module helpers in
 verifier
Message-ID: <20220122033133.ph4wrxcorl5uvspy@thp>
References: <20220121193956.198120-1-usama.arif@bytedance.com>
 <20220121193956.198120-3-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121193956.198120-3-usama.arif@bytedance.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 22, 2022 at 01:09:55AM IST, Usama Arif wrote:
> After the kernel module registers the helper, its BTF id
> and func_proto are available during verification. During
> verification, it is checked to see if insn->imm is available
> in the list of module helper btf ids. If it is,
> check_helper_call is called, otherwise check_kfunc_call.
> The module helper function proto is obtained in check_helper_call
> via get_mod_helper_proto function.
>
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>  kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 39 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8c5a46d41f28..bf7605664b95 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6532,19 +6532,39 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  	int insn_idx = *insn_idx_p;
>  	bool changes_data;
>  	int i, err, func_id;
> +	const struct btf_type *func;
> +	const char *func_name;
> +	struct btf *desc_btf;
>
>  	/* find function prototype */
>  	func_id = insn->imm;
> -	if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID) {
> -		verbose(env, "invalid func %s#%d\n", func_id_name(func_id),
> -			func_id);
> -		return -EINVAL;
> -	}
>
>  	if (env->ops->get_func_proto)
>  		fn = env->ops->get_func_proto(func_id, env->prog);
> -	if (!fn) {
> -		verbose(env, "unknown func %s#%d\n", func_id_name(func_id),
> +
> +	if (func_id >= __BPF_FUNC_MAX_ID) {
> +		desc_btf = find_kfunc_desc_btf(env, insn->imm, insn->off);

I am not sure this is right, even if we reached this point. add_kfunc_call would
not be called for a helper call, which means the kfunc_btf_tab will not be
populated. I think this code is not reachable from your test, which is why you
didn't see this. More below.

> +		if (IS_ERR(desc_btf))
> +			return PTR_ERR(desc_btf);
> +
> +		fn = get_mod_helper_proto(desc_btf, func_id);
> +		if (!fn) {
> +			func = btf_type_by_id(desc_btf, func_id);
> +			func_name = btf_name_by_offset(desc_btf, func->name_off);
> +			verbose(env, "unknown module helper func %s#%d\n", func_name,
> +				func_id);
> +			return -EACCES;
> +		}
> +	} else if (func_id >= 0) {
> +		if (env->ops->get_func_proto)
> +			fn = env->ops->get_func_proto(func_id, env->prog);
> +		if (!fn) {
> +			verbose(env, "unknown in-kernel helper func %s#%d\n", func_id_name(func_id),
> +				func_id);
> +			return -EINVAL;
> +		}
> +	} else {
> +		verbose(env, "invalid func %s#%d\n", func_id_name(func_id),
>  			func_id);
>  		return -EINVAL;
>  	}
> @@ -11351,6 +11371,7 @@ static int do_check(struct bpf_verifier_env *env)
>  	int insn_cnt = env->prog->len;
>  	bool do_print_state = false;
>  	int prev_insn_idx = -1;
> +	struct btf *desc_btf;
>
>  	for (;;) {
>  		struct bpf_insn *insn;
> @@ -11579,10 +11600,17 @@ static int do_check(struct bpf_verifier_env *env)
>  				}
>  				if (insn->src_reg == BPF_PSEUDO_CALL)
>  					err = check_func_call(env, insn, &env->insn_idx);
> -				else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL)
> -					err = check_kfunc_call(env, insn, &env->insn_idx);
> -				else
> -					err = check_helper_call(env, insn, &env->insn_idx);
> +				else {
> +					desc_btf = find_kfunc_desc_btf(env, insn->imm, insn->off);
> +					if (IS_ERR(desc_btf))
> +						return PTR_ERR(desc_btf);
> +

I didn't get this part at all.

At this point src_reg can be BPF_PSEUDO_KFUNC_CALL, or 0 (for helper call). If
it is a helper call, then find_kfunc_desc_btf using insn->imm and insn->off
would be a bug.

> +					if (insn->src_reg == BPF_K ||

Why are you comparing it to BPF_K? I think your patch is not going through your
logic in check_helper_call at all.

In your selftest, you declare it using __ksym. This means src_reg will be
encoded as BPF_PSEUDO_KFUNC_CALL (2), this if condition will never be hit
(because BPF_K is 0), and you will do check_kfunc_call for it.

TLDR; I think it is being checked as a normal kfunc call by the verifier.

What am I missing?

> +					   get_mod_helper_proto(desc_btf, insn->imm))
> +						err = check_helper_call(env, insn, &env->insn_idx);
> +					else
> +						err = check_kfunc_call(env, insn, &env->insn_idx);
> +				}
>  				if (err)
>  					return err;
>  			} else if (opcode == BPF_JA) {
> --
> 2.25.1
>
