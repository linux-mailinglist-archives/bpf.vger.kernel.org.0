Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548F26315B4
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 19:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKTSms (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 13:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKTSmr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 13:42:47 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED8211151
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 10:42:46 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y13so9440651pfp.7
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 10:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wToHCwQdtdoesA6gN0xB9kApIxKPTDJaIe+um14oHWE=;
        b=cRbKWEgzs9Mu4D0WXN9zALewerDIP0utCFayWOJ3mx0ZewCR10TQPcVe/qtElEKbRA
         0vo1PylUJOL8IL+ayvxdyTvvk1kGcpU0AWKjcgm8EBk2rT2NSQy110m8mcCNZhMFHUms
         o9Dyj/4m69Tzau9zSdQuUpjmbHyeWxkfXjlthJzq7UygNPZLv6SCYRvy/sRq+gmCGurp
         BmivkynxUPcaum+1G+18g1CjR5w1ZdSEumvv7UcsFB7q0NmH/VKnJALgQDJCkuEa1462
         PtwxE9ZmUWJLQY2r710Wp+IqcpaRGU3YGsXTmEc/KRLqYOPizVft7YqmgssNGQc1GUCV
         WwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wToHCwQdtdoesA6gN0xB9kApIxKPTDJaIe+um14oHWE=;
        b=4Kj0PrMXJ3GKvzHthlMlcqySNGfeQevqrueAdxYBxC0KSKD3Xls2ZGR7avE0Q2AsSf
         XREV+0uGYdRwPcGNvL9ewvXRmTC/Y14hCwRbBu4oruiouUYJAEzEFjREjHvlBGpiGtZ4
         7vzZAH3glsKjUiBUmtZywRNHDq4Az1Q8zUtalDtKM7a2V4YsGBjGsmLf5VshWqAGDDM6
         byPLHIl43yTQOh0cIyhfZ+EZlBlkCXaKVtQtyZHvGe6LSIIYDfajzHOzJDEP89x5LVit
         dO5R5y43k6qM1GLWBUyjq3mJ9S5iJzvj1heCkxLZGtqYI1hp24ISlQs5BIsBMZioTROs
         U/9w==
X-Gm-Message-State: ANoB5plP17s4VmzcajQQkXTAmlFCNF40w+LkT7dslVkoN6ahC/EWiQ93
        kNBpEtIXyAYE2adY/qDtcQw=
X-Google-Smtp-Source: AA0mqf7eJ2kxfjL+iRM7eceFBcNAn/hJKgS5VKZZpdUl/GsBUB53dm+yNFn1Hb0jhZLlldkqWr9swg==
X-Received: by 2002:a05:6a00:18a9:b0:572:6da6:218e with SMTP id x41-20020a056a0018a900b005726da6218emr17554616pfh.1.1668969766320;
        Sun, 20 Nov 2022 10:42:46 -0800 (PST)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:7165])
        by smtp.gmail.com with ESMTPSA id l11-20020a170903120b00b001769e6d4fafsm7951633plh.57.2022.11.20.10.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 10:42:45 -0800 (PST)
Date:   Sun, 20 Nov 2022 10:42:43 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: Add a kfunc for generic type cast
Message-ID: <20221120184243.hkuptywax6zvftsv@macbook-pro-5.dhcp.thefacebook.com>
References: <20221120161511.831691-1-yhs@fb.com>
 <20221120161527.834759-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120161527.834759-1-yhs@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 20, 2022 at 08:15:27AM -0800, Yonghong Song wrote:
> Implement bpf_rdonly_cast() which tries to cast the object
> to a specified type. This tries to support use case like below:
>   #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(SKB)))
> where skb_end_pointer(SKB) is a 'unsigned char *' and needs to
> be casted to 'struct skb_shared_info *'.
> 
> The signature of bpf_rdonly_cast() looks like
>    void *bpf_rdonly_cast(void *obj, __u32 btf_id)
> The function returns the same 'obj' but with PTR_TO_BTF_ID with
> btf_id. The verifier will ensure btf_id being a struct type.
> 
> Since the supported type cast may not reflect what the 'obj'
> represents, the returned btf_id is marked as PTR_UNTRUSTED, so
> the return value and subsequent pointer chasing cannot be
> used as helper/kfunc arguments.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/helpers.c  |  6 ++++++
>  kernel/bpf/verifier.c | 26 ++++++++++++++++++++++++--
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index dc6e994feeb9..9d9b91d2d047 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1829,6 +1829,11 @@ void *bpf_cast_to_kern_ctx(void *obj)
>  	return obj;
>  }
>  
> +void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
> +{
> +	return obj__ign;
> +}
> +
>  __diag_pop();
>  
>  BTF_SET8_START(generic_btf_ids)
> @@ -1850,6 +1855,7 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
>  
>  BTF_SET8_START(common_btf_ids)
>  BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx)
> +BTF_ID_FLAGS(func, bpf_rdonly_cast)
>  BTF_SET8_END(common_btf_ids)
>  
>  static const struct btf_kfunc_id_set common_kfunc_set = {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a18b519c5225..3f1094efdb04 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8119,6 +8119,7 @@ enum special_kfunc_type {
>  	KF_bpf_list_pop_front,
>  	KF_bpf_list_pop_back,
>  	KF_bpf_cast_to_kern_ctx,
> +	KF_bpf_rdonly_cast,
>  };
>  
>  BTF_SET_START(special_kfunc_set)
> @@ -8129,6 +8130,7 @@ BTF_ID(func, bpf_list_push_back)
>  BTF_ID(func, bpf_list_pop_front)
>  BTF_ID(func, bpf_list_pop_back)
>  BTF_ID(func, bpf_cast_to_kern_ctx)
> +BTF_ID(func, bpf_rdonly_cast)
>  BTF_SET_END(special_kfunc_set)
>  
>  BTF_ID_LIST(special_kfunc_list)
> @@ -8139,6 +8141,7 @@ BTF_ID(func, bpf_list_push_back)
>  BTF_ID(func, bpf_list_pop_front)
>  BTF_ID(func, bpf_list_pop_back)
>  BTF_ID(func, bpf_cast_to_kern_ctx)
> +BTF_ID(func, bpf_rdonly_cast)
>  
>  static enum kfunc_ptr_arg_type
>  get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
> @@ -8769,6 +8772,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	u32 i, nargs, func_id, ptr_type_id;
>  	int err, insn_idx = *insn_idx_p;
>  	const struct btf_param *args;
> +	const struct btf_type *ret_t;
>  	struct btf *desc_btf;
>  	u32 *kfunc_flags;
>  
> @@ -8848,7 +8852,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  
>  		if (meta.btf == btf_vmlinux && btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
>  			if (meta.func_id == special_kfunc_list[KF_bpf_obj_new_impl]) {
> -				const struct btf_type *ret_t;
>  				struct btf *ret_btf;
>  				u32 ret_btf_id;
>  
> @@ -8898,6 +8901,24 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  				regs[BPF_REG_0].type = PTR_TO_BTF_ID;
>  				regs[BPF_REG_0].btf = desc_btf;
>  				regs[BPF_REG_0].btf_id = meta.arg_constant.value;
> +			} else if (meta.func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
> +				if (!capable(CAP_PERFMON)) {
> +					verbose(env,
> +						"kfunc bpf_rdonly_cast requires CAP_PERFMON capability\n");
> +					return -EACCES;
> +				}
> +
> +				ret_t = btf_type_by_id(desc_btf, meta.arg_constant.value);
> +				if (!ret_t || !btf_type_is_struct(ret_t)) {
> +					verbose(env,
> +						"kfunc bpf_rdonly_cast type ID argument must be of a struct\n");
> +					return -EINVAL;
> +				}
> +
> +				mark_reg_known_zero(env, regs, BPF_REG_0);
> +				regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_UNTRUSTED;
> +				regs[BPF_REG_0].btf = desc_btf;
> +				regs[BPF_REG_0].btf_id = meta.arg_constant.value;
>  			} else {
>  				verbose(env, "kernel function %s unhandled dynamic return type\n",
>  					meta.func_name);
> @@ -15148,7 +15169,8 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		insn_buf[1] = addr[1];
>  		insn_buf[2] = *insn;
>  		*cnt = 3;
> -	} else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
> +	} else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
> +		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
>  		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>  		*cnt = 1;

Nice!
After kfunc refactoring adding new special kfunc looks so clean and easy to review.

I was contemplating to suggest to replace "__k" with "__btf_struct"
to have a single place that checks for btf_type_is_struct(),
but then realized that bpf_obj_new needs prog's btf_id
while bpf_rdonly_cast needs vmlinux's btf_id.
So let's keep __k for now.
