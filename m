Return-Path: <bpf+bounces-8132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD24781C8B
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 07:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113F2281080
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 05:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6829210F0;
	Sun, 20 Aug 2023 05:58:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1E010E1
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 05:58:13 +0000 (UTC)
Received: from out-28.mta1.migadu.com (out-28.mta1.migadu.com [95.215.58.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D941559C4
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 21:16:31 -0700 (PDT)
Message-ID: <a637d0d2-6ef7-3a16-5ea0-61936a2e3e4c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692504990; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eVRdEbN1uy+zEl8UtLy6NNgLWmtIsiFuDOxJaGzoCAk=;
	b=D6jWYsYMr2Zjjuslm7EUo2nWlrUIjY1lozk1A4zB2oWCc13QcYJB4jk9wU2TBS8brjGKbp
	VPIeT883fR8KjTbgL4DRHZodZ4QEmTn6EI7LI61u/BEyRYrCO7iCpOcwnFKpWGrm/bsy3V
	RxFltMCsHQP3YZq25JvlJqNfwKjZwx0=
Date: Sat, 19 Aug 2023 21:16:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 04/15] bpf: Add bpf_this_cpu_ptr/bpf_per_cpu_ptr
 support for allocated percpu obj
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
 <20230814172830.1363918-1-yonghong.song@linux.dev>
 <20230819010112.j7yxcihjuj2ylo4x@macbook-pro-8.dhcp.thefacebook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230819010112.j7yxcihjuj2ylo4x@macbook-pro-8.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/18/23 6:01 PM, Alexei Starovoitov wrote:
> On Mon, Aug 14, 2023 at 10:28:30AM -0700, Yonghong Song wrote:
>> The bpf helpers bpf_this_cpu_ptr() and bpf_per_cpu_ptr() are re-purposed
>> for allocated percpu objects. For an allocated percpu obj,
>> the reg type is 'PTR_TO_BTF_ID | MEM_PERCPU | MEM_RCU'.
>>
>> The return type for these two re-purposed helpera is
>> 'PTR_TO_MEM | MEM_RCU | MEM_ALLOC'.
>> The MEM_ALLOC allows that the per-cpu data can be read and written.
>>
>> Since the memory allocator bpf_mem_alloc() returns
>> a ptr to a percpu ptr for percpu data, the first argument
>> of bpf_this_cpu_ptr() and bpf_per_cpu_ptr() is patched
>> with a dereference before passing to the helper func.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf_verifier.h |  1 +
>>   kernel/bpf/verifier.c        | 51 ++++++++++++++++++++++++++++++------
>>   2 files changed, 44 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index f70f9ac884d2..e23480db37ec 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -480,6 +480,7 @@ struct bpf_insn_aux_data {
>>   	bool zext_dst; /* this insn zero extends dst reg */
>>   	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory alloc */
>>   	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
>> +	bool percpu_ptr_prog_alloc; /* {this,per}_cpu_ptr() with prog alloc */
>>   	u8 alu_state; /* used in combination with alu_limit */
>>   
>>   	/* below fields are initialized once */
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index a985fbf18a11..6fc200cb68b6 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6221,7 +6221,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>>   		}
>>   
>>   		if (type_is_alloc(reg->type) && !type_is_non_owning_ref(reg->type) &&
>> -		    !reg->ref_obj_id) {
>> +		    !(reg->type & MEM_RCU) && !reg->ref_obj_id) {
>>   			verbose(env, "verifier internal error: ref_obj_id for allocated object must be non-zero\n");
>>   			return -EFAULT;
>>   		}
>> @@ -7765,6 +7765,7 @@ static const struct bpf_reg_types btf_ptr_types = {
>>   static const struct bpf_reg_types percpu_btf_ptr_types = {
>>   	.types = {
>>   		PTR_TO_BTF_ID | MEM_PERCPU,
>> +		PTR_TO_BTF_ID | MEM_PERCPU | MEM_RCU,
>>   		PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED,
>>   	}
>>   };
>> @@ -7945,6 +7946,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>>   			return -EACCES;
>>   		break;
>>   	case PTR_TO_BTF_ID | MEM_PERCPU:
>> +	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_RCU:
>>   	case PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED:
>>   		/* Handled by helper specific checks */
>>   		break;
>> @@ -8287,6 +8289,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>>   			verbose(env, "Helper has invalid btf_id in R%d\n", regno);
>>   			return -EACCES;
>>   		}
>> +		if (reg->type & MEM_RCU) {
>> +			const struct btf_type *type = btf_type_by_id(reg->btf, reg->btf_id);
>> +
>> +			if (!type || !btf_type_is_struct(type)) {
>> +				verbose(env, "Helper has invalid btf/btf_id in R%d\n", regno);
>> +				return -EFAULT;
>> +			}
>> +			env->insn_aux_data[insn_idx].percpu_ptr_prog_alloc = true;
>> +		}
> 
> Let's move this check out of check_func_arg() and do it in check_helper_call() after the loop.
> meta has what we need.
> Also I would do it only for specific helpers like:
> case BPF_FUNC_per_cpu_ptr:
> case BPF_FUNC_this_cpu_ptr:
>     if (reg[R1]->type & MEM_RCU) {
>        const struct btf_type *type = btf_type_by_id(meta->ret_btf, ...)
>        ...
>        returns_cpu_specific_alloc_ptr = true;
>        insn_aux_datap[].call_with_percpu_alloc_ptr = ture;
>      }

This is more explicit and easier to understand. Will use the above
in v2.

>> +
>>   		meta->ret_btf = reg->btf;
>>   		meta->ret_btf_id = reg->btf_id;
>>   		break;
>> @@ -9888,14 +9900,18 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>   			regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
>>   			regs[BPF_REG_0].mem_size = tsize;
>>   		} else {
>> -			/* MEM_RDONLY may be carried from ret_flag, but it
>> -			 * doesn't apply on PTR_TO_BTF_ID. Fold it, otherwise
>> -			 * it will confuse the check of PTR_TO_BTF_ID in
>> -			 * check_mem_access().
>> -			 */
>> -			ret_flag &= ~MEM_RDONLY;
>> +			if (env->insn_aux_data[insn_idx].percpu_ptr_prog_alloc) {
> 
> and here I would only check the local bool returns_percpu_alloc_ptr.
> 
> Because returns_cpu_specific_alloc_ptr is not the same as call_with_percpu_alloc_ptr.
> 
> Like this_cpu_read() is a call_with_percpu_alloc_ptr, but it doesn't return cpu specific pointer.
> It derefs cpu specific pointer and returns the value.
> Of course, we don't have such helper today, but worth thinking ahead.

Agree. percpu_ptr_prog_alloc is a bad name. I actually spent some time
on how to name it but did not come with a good one. Will use
returns_cpu_specific_alloc_ptr as you suggested.

> 
>> +				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU;
>> +			} else {
>> +				/* MEM_RDONLY may be carried from ret_flag, but it
>> +				 * doesn't apply on PTR_TO_BTF_ID. Fold it, otherwise
>> +				 * it will confuse the check of PTR_TO_BTF_ID in
>> +				 * check_mem_access().
>> +				 */
>> +				ret_flag &= ~MEM_RDONLY;
>> +				regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
>> +			}
>>   
>> -			regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
>>   			regs[BPF_REG_0].btf = meta.ret_btf;
>>   			regs[BPF_REG_0].btf_id = meta.ret_btf_id;
>>   		}
>> @@ -18646,6 +18662,25 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>   			goto patch_call_imm;
>>   		}
>>   
>> +		/* bpf_per_cpu_ptr() and bpf_this_cpu_ptr() */
>> +		if (env->insn_aux_data[i + delta].percpu_ptr_prog_alloc) {
> 
> call_with_percpu_alloc_ptr
> 
>> +			/* patch with 'r1 = *(u64 *)(r1 + 0)' since for percpu data,
>> +			 * bpf_mem_alloc() returns a ptr to the percpu data ptr.
>> +			 */
>> +			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
> 
> here R1 is no longer a concern, since we check R1 only in check_helper_call.
> 
>> +			insn_buf[1] = *insn;
>> +			cnt = 2;
>> +
>> +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>> +			if (!new_prog)
>> +				return -ENOMEM;
>> +
>> +			delta += cnt - 1;
>> +			env->prog = prog = new_prog;
>> +			insn = new_prog->insnsi + i + delta;
>> +			goto patch_call_imm;
>> +		}
>> +
>>   		/* BPF_EMIT_CALL() assumptions in some of the map_gen_lookup
>>   		 * and other inlining handlers are currently limited to 64 bit
>>   		 * only.
>> -- 
>> 2.34.1
>>
> 

