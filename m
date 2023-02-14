Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CCF697247
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 00:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjBNX6c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 18:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjBNX6R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 18:58:17 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D88B2E823
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:58:10 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-52ec2c6b694so162731357b3.19
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z37xJjCP38cGL5p3cDa5h7Rch7N/PyJiPLGx4uMIlX0=;
        b=e5BzPQrQEyprndf+Mi1ws8fIAKPFdiVeE4IbbnL9knI5hPFiPOedvMDio2dTpg/ZZi
         rOxCb6GcrixsydAkp08t1hXmhGtFgAPAsjcYuhPF8KTLDpJpFzfoPCh+RgRAYBbc2EJl
         o9eYFv8FJ8idoLhwQJ+atPeYdvYJYelG/pWaZ3u7+m5yww5N74fQubYCfbTwANyzKXgq
         9UnDXDQKnQaspqaS9nV582XDMil6XjCMQet4Fw17cXPF7MpWU0htnmeHapPB14AFcB1N
         Hj/21vnn3tR1vGB0EAv+OOddA1FDbwanJX5tnSGGY0lwvMyrljUZ9pMU/JMc54RgTeSG
         wtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z37xJjCP38cGL5p3cDa5h7Rch7N/PyJiPLGx4uMIlX0=;
        b=6jBhan91dexqtGZ7rMDpQc0SCAfrqNmVy8KQ8Nj3isq0XWqMituSUn4NiPf1Ev+bko
         /u9jR+yA/1+4ZeH3tSwsWT96rI2xRjWxE4Srt7iR2r9xXEYM/QapM35w/9Dop6MZbi7l
         f1vcuy14Lokocb9PWaOrM7tMxA4cacdszOaA6ECk3i9SsFKAj+x/G+NLBWCHJzgdvzt7
         RWgYC9bl8AmsLg4ml7jNhybgq/s8XJwdCAs7rtGijfsKi/mTWFlBGJNxY4fwcjfFVejf
         WWWGFkRH0y+EfQ3Kf6M0q/Ro1+AQxAqV2BBRYJ0urzZM3QAek5yZ2D5wDsJqJ++daJkQ
         Vqpg==
X-Gm-Message-State: AO0yUKVWCtjLnNlVBxiqCo475A6dyjf4ph0ED5YoRUoIN7CoO/94rfkH
        pbyMfZqAxUM+ghZKRbmwb1x5BcA=
X-Google-Smtp-Source: AK7set8yMECZP1dYiUne3hhv5Tinxi5KRflFQIF3B2mLMN6Fwsmu2YJHGGDU9w1V+/sb3uocF+JvpQs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:d9cd:0:b0:8ef:3873:1c72 with SMTP id
 q196-20020a25d9cd000000b008ef38731c72mr0ybg.3.1676419088758; Tue, 14 Feb 2023
 15:58:08 -0800 (PST)
Date:   Tue, 14 Feb 2023 15:58:07 -0800
In-Reply-To: <20230214212809.242632-2-iii@linux.ibm.com>
Mime-Version: 1.0
References: <20230214212809.242632-1-iii@linux.ibm.com> <20230214212809.242632-2-iii@linux.ibm.com>
Message-ID: <Y+wgDzf9zjfwgFwA@google.com>
Subject: Re: [PATCH RFC bpf-next 1/1] bpf: Support 64-bit pointers to kfuncs
From:   Stanislav Fomichev <sdf@google.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/14, Ilya Leoshkevich wrote:
> test_ksyms_module fails to emit a kfunc call targeting a module on
> s390x, because the verifier stores the difference between kfunc
> address and __bpf_call_base in bpf_insn.imm, which is s32, and modules
> are roughly (1 << 42) bytes away from the kernel on s390x.

> Fix by keeping BTF id in bpf_insn.imm for BPF_PSEUDO_KFUNC_CALLs,
> and storing the absolute address in bpf_kfunc_desc, which JITs retrieve
> as usual by calling bpf_jit_get_func_addr().

> This also fixes the problem with XDP metadata functions outlined in
> the description of commit 63d7b53ab59f ("s390/bpf: Implement
> bpf_jit_supports_kfunc_call()") by replacing address lookups with BTF
> id lookups. This eliminates the inconsistency between "abstract" XDP
> metadata functions' BTF ids and their concrete addresses.

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   include/linux/bpf.h   |  2 ++
>   kernel/bpf/core.c     | 23 ++++++++++---
>   kernel/bpf/verifier.c | 79 +++++++++++++------------------------------
>   3 files changed, 45 insertions(+), 59 deletions(-)

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index be34f7deb6c3..83ce94d11484 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2227,6 +2227,8 @@ bool bpf_prog_has_kfunc_call(const struct bpf_prog  
> *prog);
>   const struct btf_func_model *
>   bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
>   			 const struct bpf_insn *insn);
> +int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id, u16  
> offset,
> +		       u8 **func_addr);
>   struct bpf_core_ctx {
>   	struct bpf_verifier_log *log;
>   	const struct btf *btf;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 3390961c4e10..a42382afe333 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1185,10 +1185,12 @@ int bpf_jit_get_func_addr(const struct bpf_prog  
> *prog,
>   {
>   	s16 off = insn->off;
>   	s32 imm = insn->imm;
> +	bool fixed;
>   	u8 *addr;
> +	int err;

> -	*func_addr_fixed = insn->src_reg != BPF_PSEUDO_CALL;
> -	if (!*func_addr_fixed) {
> +	switch (insn->src_reg) {
> +	case BPF_PSEUDO_CALL:
>   		/* Place-holder address till the last pass has collected
>   		 * all addresses for JITed subprograms in which case we
>   		 * can pick them up from prog->aux.
> @@ -1200,16 +1202,29 @@ int bpf_jit_get_func_addr(const struct bpf_prog  
> *prog,
>   			addr = (u8 *)prog->aux->func[off]->bpf_func;
>   		else
>   			return -EINVAL;
> -	} else {
> +		fixed = false;
> +		break;

[..]

> +	case 0:

nit: Should we define BPF_HELPER_CALL here for consistency?

>   		/* Address of a BPF helper call. Since part of the core
>   		 * kernel, it's always at a fixed location. __bpf_call_base
>   		 * and the helper with imm relative to it are both in core
>   		 * kernel.
>   		 */
>   		addr = (u8 *)__bpf_call_base + imm;
> +		fixed = true;
> +		break;
> +	case BPF_PSEUDO_KFUNC_CALL:
> +		err = bpf_get_kfunc_addr(prog, imm, off, &addr);
> +		if (err)
> +			return err;
> +		fixed = true;
> +		break;
> +	default:
> +		return -EINVAL;
>   	}

> -	*func_addr = (unsigned long)addr;
> +	*func_addr_fixed = fixed;
> +	*func_addr = addr;
>   	return 0;
>   }

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 21e08c111702..aea59974f0d6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2115,8 +2115,8 @@ static int add_subprog(struct bpf_verifier_env  
> *env, int off)
>   struct bpf_kfunc_desc {
>   	struct btf_func_model func_model;
>   	u32 func_id;
> -	s32 imm;
>   	u16 offset;
> +	unsigned long addr;
>   };

>   struct bpf_kfunc_btf {
> @@ -2166,6 +2166,19 @@ find_kfunc_desc(const struct bpf_prog *prog, u32  
> func_id, u16 offset)
>   		       sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
>   }


[..]

> +int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id, u16  
> offset,
> +		       u8 **func_addr)
> +{
> +	const struct bpf_kfunc_desc *desc;
> +
> +	desc = find_kfunc_desc(prog, func_id, offset);
> +	if (WARN_ON_ONCE(!desc))
> +		return -EINVAL;
> +
> +	*func_addr = (u8 *)desc->addr;
> +	return 0;
> +}

This function isn't doing much and has a single caller. Should we just
export find_kfunc_desc?

> +
>   static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
>   					 s16 offset)
>   {
> @@ -2261,8 +2274,8 @@ static int add_kfunc_call(struct bpf_verifier_env  
> *env, u32 func_id, s16 offset)
>   	struct bpf_kfunc_desc *desc;
>   	const char *func_name;
>   	struct btf *desc_btf;
> -	unsigned long call_imm;
>   	unsigned long addr;
> +	void *xdp_kfunc;
>   	int err;

>   	prog_aux = env->prog->aux;
> @@ -2346,24 +2359,21 @@ static int add_kfunc_call(struct bpf_verifier_env  
> *env, u32 func_id, s16 offset)
>   		return -EINVAL;
>   	}

> -	call_imm = BPF_CALL_IMM(addr);
> -	/* Check whether or not the relative offset overflows desc->imm */
> -	if ((unsigned long)(s32)call_imm != call_imm) {
> -		verbose(env, "address of kernel function %s is out of range\n",
> -			func_name);
> -		return -EINVAL;
> -	}
> -
>   	if (bpf_dev_bound_kfunc_id(func_id)) {
>   		err = bpf_dev_bound_kfunc_check(&env->log, prog_aux);
>   		if (err)
>   			return err;
> +
> +		xdp_kfunc = bpf_dev_bound_resolve_kfunc(env->prog, func_id);
> +		if (xdp_kfunc)
> +			addr = (unsigned long)xdp_kfunc;
> +		/* fallback to default kfunc when not supported by netdev */
>   	}

>   	desc = &tab->descs[tab->nr_descs++];
>   	desc->func_id = func_id;
> -	desc->imm = call_imm;
>   	desc->offset = offset;
> +	desc->addr = addr;
>   	err = btf_distill_func_proto(&env->log, desc_btf,
>   				     func_proto, func_name,
>   				     &desc->func_model);
> @@ -2373,30 +2383,6 @@ static int add_kfunc_call(struct bpf_verifier_env  
> *env, u32 func_id, s16 offset)
>   	return err;
>   }

> -static int kfunc_desc_cmp_by_imm(const void *a, const void *b)
> -{
> -	const struct bpf_kfunc_desc *d0 = a;
> -	const struct bpf_kfunc_desc *d1 = b;
> -
> -	if (d0->imm > d1->imm)
> -		return 1;
> -	else if (d0->imm < d1->imm)
> -		return -1;
> -	return 0;
> -}
> -
> -static void sort_kfunc_descs_by_imm(struct bpf_prog *prog)
> -{
> -	struct bpf_kfunc_desc_tab *tab;
> -
> -	tab = prog->aux->kfunc_tab;
> -	if (!tab)
> -		return;
> -
> -	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
> -	     kfunc_desc_cmp_by_imm, NULL);
> -}
> -
>   bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
>   {
>   	return !!prog->aux->kfunc_tab;
> @@ -2407,14 +2393,15 @@ bpf_jit_find_kfunc_model(const struct bpf_prog  
> *prog,
>   			 const struct bpf_insn *insn)
>   {
>   	const struct bpf_kfunc_desc desc = {
> -		.imm = insn->imm,
> +		.func_id = insn->imm,
> +		.offset = insn->off,
>   	};
>   	const struct bpf_kfunc_desc *res;
>   	struct bpf_kfunc_desc_tab *tab;

>   	tab = prog->aux->kfunc_tab;
>   	res = bsearch(&desc, tab->descs, tab->nr_descs,
> -		      sizeof(tab->descs[0]), kfunc_desc_cmp_by_imm);
> +		      sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);

>   	return res ? &res->func_model : NULL;
>   }
> @@ -16251,7 +16238,6 @@ static int fixup_kfunc_call(struct  
> bpf_verifier_env *env, struct bpf_insn *insn,
>   			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
>   {
>   	const struct bpf_kfunc_desc *desc;
> -	void *xdp_kfunc;

>   	if (!insn->imm) {
>   		verbose(env, "invalid kernel function call not eliminated in verifier  
> pass\n");
> @@ -16259,20 +16245,6 @@ static int fixup_kfunc_call(struct  
> bpf_verifier_env *env, struct bpf_insn *insn,
>   	}

>   	*cnt = 0;
> -
> -	if (bpf_dev_bound_kfunc_id(insn->imm)) {
> -		xdp_kfunc = bpf_dev_bound_resolve_kfunc(env->prog, insn->imm);
> -		if (xdp_kfunc) {
> -			insn->imm = BPF_CALL_IMM(xdp_kfunc);
> -			return 0;
> -		}
> -
> -		/* fallback to default kfunc when not supported by netdev */
> -	}
> -
> -	/* insn->imm has the btf func_id. Replace it with
> -	 * an address (relative to __bpf_call_base).
> -	 */
>   	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
>   	if (!desc) {
>   		verbose(env, "verifier internal error: kernel function descriptor not  
> found for func_id %u\n",
> @@ -16280,7 +16252,6 @@ static int fixup_kfunc_call(struct  
> bpf_verifier_env *env, struct bpf_insn *insn,
>   		return -EFAULT;
>   	}

> -	insn->imm = desc->imm;
>   	if (insn->off)
>   		return 0;
>   	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl]) {
> @@ -16834,8 +16805,6 @@ static int do_misc_fixups(struct bpf_verifier_env  
> *env)
>   		}
>   	}


[..]

> -	sort_kfunc_descs_by_imm(env->prog);

If we are not doing sorting here, how does the bsearch work?

> -
>   	return 0;
>   }

> --
> 2.39.1

