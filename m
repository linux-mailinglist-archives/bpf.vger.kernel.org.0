Return-Path: <bpf+bounces-8732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3A67893BF
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 06:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3ED1C20F0F
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 04:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7803A819;
	Sat, 26 Aug 2023 04:03:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E837E
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 04:03:18 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA3EE79
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 21:03:17 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-564b8e60ce9so824164a12.2
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 21:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693022597; x=1693627397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yO5hdqKzkoqj4fQx0cvlIEzFghjOebiK+nynK1Cre7c=;
        b=VZmrPKB8xrNJyqT6RNkADREGmOjg8qCIJlMeP5SVnFRpDZ/iCnx0BTVRCoOJZj1upT
         ygl2y7wZM8DmJyku4PGBg3sryP2HDgEBRZqn2xZcbkirtqjvVgmMIuhklx5T1kxSt6yV
         hwfitgBKs4KpL7FN3h3FDuEYzVibijcfGZQFFxQ2lgh5DV2lqU1JT3+ToHsvUJy8+Gv3
         KHoiD4Ka/1eZ8tNZLuJ+tTXvjzrYDcu+cwiihI7xzYn+0OdecWM+iCjHHnFd8gQqKMWD
         6sa7rofl9N5Smi6vQxjdb5JEEJsTcQyMmTdtkjG5wEfpdTQaL8t/Xh0h/ePJ5sSZKtka
         w5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693022597; x=1693627397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yO5hdqKzkoqj4fQx0cvlIEzFghjOebiK+nynK1Cre7c=;
        b=imUrV2WUfESU4zPqOlxvRWR2hElrh6tNolU/qtL4pTBS8LJeVaSrhId70FVDC6QbrY
         7HMO5xadAy6iplrtjEMTjN+5D/zN00op4Q8qHMuN2g7NgUpy6y2t/CdsgLtWS3d/Nwlx
         VATKLo32xPAcmEiCfwV4fgBv5xlLwY5anIKIkApDmYdxhUPD4IEY9q08EMboFsQCSaBz
         Reu7yveqIdCJY0CF6ezXdlX2KBRt/RDWuwJp9R10qB2q8YpbT3xbto6sEEOoHgRtV9Ig
         md5tp5nE9usUG2k/IDJRDiRMZk8ekdJQYYs8AVujC8aTQPFo1Qp9nAb5wUG/YrwLtG9I
         Wevg==
X-Gm-Message-State: AOJu0Yy2BVXn6lk/j2xDpYcVw30v4Sqn3ESo/TAYgg8OQoVglRnivWby
	Iz8p0O1VRnPwZOprVky4UREG8cTiJy0=
X-Google-Smtp-Source: AGHT+IEGx0pZUiDS1zJEUThcOccMbrjr3kJZvzt/oryFBSs0DjPzGnROlDVCSLVeBph3tHc932EUWQ==
X-Received: by 2002:a05:6a21:7782:b0:14c:c9f6:d657 with SMTP id bd2-20020a056a21778200b0014cc9f6d657mr1292934pzc.22.1693022596603;
        Fri, 25 Aug 2023 21:03:16 -0700 (PDT)
Received: from [192.168.1.12] (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id jh15-20020a170903328f00b001bb7a736b4csm2584754plb.77.2023.08.25.21.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 21:03:16 -0700 (PDT)
Message-ID: <238be72c-2a19-f675-83cb-18051937d8fd@gmail.com>
Date: Sat, 26 Aug 2023 12:03:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH bpf-next v3 1/2] bpf, x64: Fix tailcall infinite loop
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 bpf@vger.kernel.org
References: <20230825145216.56660-1-hffilwlqm@gmail.com>
 <20230825145216.56660-2-hffilwlqm@gmail.com> <ZOjrviql/e/14X4a@boxer>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <ZOjrviql/e/14X4a@boxer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/26 01:58, Maciej Fijalkowski wrote:
> On Fri, Aug 25, 2023 at 10:52:15PM +0800, Leon Hwang wrote:
>> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
>> handling in JIT"), the tailcall on x64 works better than before.
>>
>> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
>> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
>>
>> From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF program
>> to other BPF programs"), BPF program is able to trace other BPF programs.
>>
>> How about combining them all together?
>>
>> 1. FENTRY/FEXIT on a BPF subprogram.
>> 2. A tailcall runs in the BPF subprogram.
>> 3. The tailcall calls itself.
> 
> I would be interested in seeing broken asm code TBH :)
> 
>>
>> As a result, a tailcall infinite loop comes up. And the loop would halt
>> the machine.
>>
>> As we know, in tail call context, the tail_call_cnt propagates by stack
>> and rax register between BPF subprograms. So do it in trampolines.
>>
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>> ---
>>  arch/x86/net/bpf_jit_comp.c | 32 ++++++++++++++++++++++++++------
>>  include/linux/bpf.h         |  5 +++++
>>  kernel/bpf/trampoline.c     |  4 ++--
>>  kernel/bpf/verifier.c       | 30 +++++++++++++++++++++++-------
>>  4 files changed, 56 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index a5930042139d3..2846c21d75bfa 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -303,8 +303,12 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>  	prog += X86_PATCH_SIZE;
>>  	if (!ebpf_from_cbpf) {
>>  		if (tail_call_reachable && !is_subprog)
>> +			/* When it's the entry of the whole tailcall context,
>> +			 * zeroing rax means initialising tail_call_cnt.
>> +			 */
>>  			EMIT2(0x31, 0xC0); /* xor eax, eax */
>>  		else
>> +			/* Keep the same instruction layout. */
> 
> While these comments are helpful I have mixed feelings about them residing
> in this patch - rule of thumb to me is to keep the fixes as small as
> possible.

Got it. I'll separate them into another patch.

Thanks for your rule of thumb.

> 
>>  			EMIT2(0x66, 0x90); /* nop2 */
>>  	}
>>  	EMIT1(0x55);             /* push rbp */
>> @@ -1018,6 +1022,10 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
>>  
>>  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>>  
>> +/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
>> +#define RESTORE_TAIL_CALL_CNT(stack)				\
>> +	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
>> +
>>  static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
>>  		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
>>  {
>> @@ -1623,9 +1631,7 @@ st:			if (is_imm8(insn->off))
>>  
>>  			func = (u8 *) __bpf_call_base + imm32;
>>  			if (tail_call_reachable) {
>> -				/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
>> -				EMIT3_off32(0x48, 0x8B, 0x85,
>> -					    -round_up(bpf_prog->aux->stack_depth, 8) - 8);
>> +				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
>>  				if (!imm32)
>>  					return -EINVAL;
>>  				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
>> @@ -2400,6 +2406,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>  	 *                     [ ...        ]
>>  	 *                     [ stack_arg2 ]
>>  	 * RBP - arg_stack_off [ stack_arg1 ]
>> +	 * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
>>  	 */
>>  
>>  	/* room for return value of orig_call or fentry prog */
>> @@ -2464,6 +2471,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>  	else
>>  		/* sub rsp, stack_size */
>>  		EMIT4(0x48, 0x83, 0xEC, stack_size);
>> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
>> +		EMIT1(0x50);		/* push rax */
>>  	/* mov QWORD PTR [rbp - rbx_off], rbx */
>>  	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
>>  
>> @@ -2516,9 +2525,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>  		restore_regs(m, &prog, regs_off);
>>  		save_args(m, &prog, arg_stack_off, true);
>>  
>> +		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
>> +			/* Before calling the original function, restore the
>> +			 * tail_call_cnt from stack to rax.
>> +			 */
>> +			RESTORE_TAIL_CALL_CNT(stack_size);
>> +
>>  		if (flags & BPF_TRAMP_F_ORIG_STACK) {
>> -			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
>> -			EMIT2(0xff, 0xd0); /* call *rax */
>> +			emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, 8);
>> +			EMIT2(0xff, 0xd3); /* call *rbx */
>>  		} else {
>>  			/* call original function */
>>  			if (emit_rsb_call(&prog, orig_call, prog)) {
>> @@ -2569,7 +2584,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>  			ret = -EINVAL;
>>  			goto cleanup;
>>  		}
>> -	}
>> +	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
>> +		/* Before running the original function, restore the
>> +		 * tail_call_cnt from stack to rax.
>> +		 */
>> +		RESTORE_TAIL_CALL_CNT(stack_size);
>> +
>>  	/* restore return value of orig_call or fentry prog back into RAX */
>>  	if (save_ret)
>>  		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index cfabbcf47bdb8..c8df257ea435d 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1028,6 +1028,11 @@ struct btf_func_model {
>>   */
>>  #define BPF_TRAMP_F_SHARE_IPMODIFY	BIT(6)
>>  
>> +/* Indicate that current trampoline is in a tail call context. Then, it has to
>> + * cache and restore tail_call_cnt to avoid infinite tail call loop.
>> + */
>> +#define BPF_TRAMP_F_TAIL_CALL_CTX	BIT(7)
>> +
>>  /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
>>   * bytes on x86.
>>   */
>> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>> index 78acf28d48732..16ab5da7161f2 100644
>> --- a/kernel/bpf/trampoline.c
>> +++ b/kernel/bpf/trampoline.c
>> @@ -415,8 +415,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>>  		goto out;
>>  	}
>>  
>> -	/* clear all bits except SHARE_IPMODIFY */
>> -	tr->flags &= BPF_TRAMP_F_SHARE_IPMODIFY;
>> +	/* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
>> +	tr->flags &= (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL_CTX);
>>  
>>  	if (tlinks[BPF_TRAMP_FEXIT].nr_links ||
>>  	    tlinks[BPF_TRAMP_MODIFY_RETURN].nr_links) {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 4ccca1f6c9981..6f290bc6f5f19 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -19246,6 +19246,21 @@ static int check_non_sleepable_error_inject(u32 btf_id)
>>  	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
>>  }
>>  
>> +static inline int find_subprog_index(const struct bpf_prog *prog,
> 
> FWIW please no inlines in source files, but I don't currently follow the
> need for that routine.

Got it. It's unnecessary to inline it.

> 
>> +				     u32 btf_id)
>> +{
>> +	struct bpf_prog_aux *aux = prog->aux;
>> +	int i, subprog = -1;
>> +
>> +	for (i = 0; i < aux->func_info_cnt; i++)
>> +		if (aux->func_info[i].type_id == btf_id) {
>> +			subprog = i;
>> +			break;
>> +		}
>> +
>> +	return subprog;
>> +}
>> +
>>  int bpf_check_attach_target(struct bpf_verifier_log *log,
>>  			    const struct bpf_prog *prog,
>>  			    const struct bpf_prog *tgt_prog,
>> @@ -19254,9 +19269,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>  {
>>  	bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
>>  	const char prefix[] = "btf_trace_";
>> -	int ret = 0, subprog = -1, i;
>>  	const struct btf_type *t;
>>  	bool conservative = true;
>> +	int ret = 0, subprog;
>>  	const char *tname;
>>  	struct btf *btf;
>>  	long addr = 0;
>> @@ -19291,11 +19306,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>  			return -EINVAL;
>>  		}
>>  
>> -		for (i = 0; i < aux->func_info_cnt; i++)
>> -			if (aux->func_info[i].type_id == btf_id) {
>> -				subprog = i;
>> -				break;
>> -			}
>> +		subprog = find_subprog_index(tgt_prog, btf_id);
>>  		if (subprog == -1) {
>>  			bpf_log(log, "Subprog %s doesn't exist\n", tname);
>>  			return -EINVAL;
>> @@ -19559,7 +19570,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>>  	struct bpf_attach_target_info tgt_info = {};
>>  	u32 btf_id = prog->aux->attach_btf_id;
>>  	struct bpf_trampoline *tr;
>> -	int ret;
>> +	int ret, subprog;
>>  	u64 key;
>>  
>>  	if (prog->type == BPF_PROG_TYPE_SYSCALL) {
>> @@ -19629,6 +19640,11 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>>  	if (!tr)
>>  		return -ENOMEM;
>>  
>> +	if (tgt_prog && tgt_prog->aux->tail_call_reachable) {
>> +		subprog = find_subprog_index(tgt_prog, btf_id);
>> +		tr->flags = subprog > 0 ? BPF_TRAMP_F_TAIL_CALL_CTX : 0;
>> +	}
> 
> I kinda forgot trampoline internals so please bear with me.
> Here you are checking actually...what? That current program is a subprog
> of tgt prog? My knee jerk reaction would be to propagate the
> BPF_TRAMP_F_TAIL_CALL_CTX based on just tail_call_reachable, but I need
> some more time to get my head around it again, sorry :<

Yeah, that current program must be a subprog of tgt prog.

For example:

tailcall_subprog() {
  bpf_tail_call_static(&jmp_table, 0);
}

tailcall_prog() {
  tailcall_subprog();
}

prog() {
  bpf_tail_call_static(&jmp_table, 0);
}

jmp_table populates with tailcall_prog().

When do fentry on prog(), there's no tail_call_cnt for fentry to
propagate. As we can see in emit_prologue(), fentry runs before
initialising tail_call_cnt.

When do fentry on tailcall_prog()? NO, it's impossible to do fentry on
tailcall_prog(). Because the tailcall 'jmp' skips the fentry on
tailcall_prog().

And, when do fentry on tailcall_subprog(), fentry has to propagate
tail_call_cnt properly.

In conclusion, that current program must be a subprog of tgt prog.

Thanks,
Leon

