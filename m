Return-Path: <bpf+bounces-6676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B40F76C3CA
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 05:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8397A1C211B1
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 03:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC021109;
	Wed,  2 Aug 2023 03:57:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5484EC6
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 03:57:27 +0000 (UTC)
Received: from out-126.mta1.migadu.com (out-126.mta1.migadu.com [95.215.58.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E31E9B
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 20:57:22 -0700 (PDT)
Message-ID: <9643d04f-8102-b5b3-1edf-34b4e08485df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690948639; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmdreGqfkRiNddvK9uK6tbQpNuDRdVCA42jQ2dFkYr8=;
	b=PwLFNmWXfCGIZacWIAH3+8/ivOeErCxHtRef+dLS35vHwDBAoiCjZR8GGfCW244xhh39E2
	r9Fpk8E4nfSU98Iuqj3rQnKic7MqML3NpKgyN5JXvnCTsyLk+a4mfNXHC8mMkn3oKcMRPV
	Mu+Z2UWaYEk5X0NEx8ChN0aDUuZjPzQ=
Date: Tue, 1 Aug 2023 20:57:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v1 bpf-next 1/7] bpf: Ensure kptr_struct_meta is non-NULL
 for collection insert and refcount_acquire
Content-Language: en-US
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
 <20230801203630.3581291-2-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230801203630.3581291-2-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/1/23 1:36 PM, Dave Marchevsky wrote:
> It's straightforward to prove that kptr_struct_meta must be non-NULL for
> any valid call to these kfuncs:
> 
>    * btf_parse_struct_metas in btf.c creates a btf_struct_meta for any
>      struct in user BTF with a special field (e.g. bpf_refcount,
>      {rb,list}_node). These are stored in that BTF's struct_meta_tab.
> 
>    * __process_kf_arg_ptr_to_graph_node in verifier.c ensures that nodes
>      have {rb,list}_node field and that it's at the correct offset.
>      Similarly, check_kfunc_args ensures bpf_refcount field existence for
>      node param to bpf_refcount_acquire.
> 
>    * So a btf_struct_meta must have been created for the struct type of
>      node param to these kfuncs
> 
>    * That BTF and its struct_meta_tab are guaranteed to still be around.
>      Any arbitrary {rb,list} node the BPF program interacts with either:
>      came from bpf_obj_new or a collection removal kfunc in the same
>      program, in which case the BTF is associated with the program and
>      still around; or came from bpf_kptr_xchg, in which case the BTF was
>      associated with the map and is still around
> 
> Instead of silently continuing with NULL struct_meta, which caused
> confusing bugs such as those addressed by commit 2140a6e3422d ("bpf: Set
> kptr_struct_meta for node param to list and rbtree insert funcs"), let's
> error out. Then, at runtime, we can confidently say that the
> implementations of these kfuncs were given a non-NULL kptr_struct_meta,
> meaning that special-field-specific functionality like
> bpf_obj_free_fields and the bpf_obj_drop change introduced later in this
> series are guaranteed to execute.

The subject says '... for collection insert and refcount_acquire'.
Why picks these? We could check for all kptr_struct_meta use cases?

> 
> This patch doesn't change functionality, just makes it easier to reason
> about existing functionality.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   kernel/bpf/verifier.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e7b1af016841..ec37e84a11c6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18271,6 +18271,13 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
>   		struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
>   
> +		if (desc->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl] &&

Why check for KF_bpf_refcount_acquire_impl? We can cover all cases in 
this 'if' branch, right?

> +		    !kptr_struct_meta) {
> +			verbose(env, "verifier internal error: kptr_struct_meta expected at insn_idx %d\n",
> +				insn_idx);
> +			return -EFAULT;
> +		}
> +
>   		insn_buf[0] = addr[0];
>   		insn_buf[1] = addr[1];
>   		insn_buf[2] = *insn;
> @@ -18278,6 +18285,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   	} else if (desc->func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
>   		   desc->func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>   		   desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
> +		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
>   		int struct_meta_reg = BPF_REG_3;
>   		int node_offset_reg = BPF_REG_4;
>   
> @@ -18287,6 +18295,12 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   			node_offset_reg = BPF_REG_5;
>   		}
>   
> +		if (!kptr_struct_meta) {
> +			verbose(env, "verifier internal error: kptr_struct_meta expected at insn_idx %d\n",
> +				insn_idx);
> +			return -EFAULT;
> +		}
> +
>   		__fixup_collection_insert_kfunc(&env->insn_aux_data[insn_idx], struct_meta_reg,
>   						node_offset_reg, insn, insn_buf, cnt);
>   	} else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||

In my opinion, such selective defensive programming is not necessary. By 
searching kptr_struct_meta in the code, it is reasonably easy to find
whether we have any mismatch or not. Also self test coverage should
cover these cases (probably already) right?

If the defensive programming here is still desirable to warn at 
verification time, I think we should just check all of uses for 
kptr_struct_meta.

