Return-Path: <bpf+bounces-10960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7097B0198
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 12:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 5BC7E1C20950
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B71273F3;
	Wed, 27 Sep 2023 10:17:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B779233F1
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 10:17:03 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4EE4218
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 03:17:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690bd59322dso8137569b3a.3
        for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 03:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695809821; x=1696414621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYa/zLWhaWlLbyEdQHtV25GBy6ERU5sz2cDVOjL/pMw=;
        b=GaseYJ1EQfoqiCJUEROuqNeR9TItOOn1+6WG85O1hkdtbm7+5ADy3SWWfvVsQtxMRD
         8zQdMn7tiMZVxUOf1Ukl2dZqx+KWEy8uPdAbdT6XTIIFE30n+V7EhhisOvCgz/jmbnPd
         gEjoRLlGnDNTnmWC2FODtAxcgZ9JLh8garnU7807OogVZxiXGuMT1Lb0qC4RuGbp6+c+
         vO1Bugbvl37ZFLIsFdxgfSSnqYd/EWObLSGuZANxSNw74iq3ejvAdYoq1qZYX3XJFDlb
         hbDgwIyEFSrJVocrwB+XpIF6CbM/YQlg4iaYU9OaasYIjWGNDAurfcXdNEouu7nvqiR8
         dUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695809821; x=1696414621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VYa/zLWhaWlLbyEdQHtV25GBy6ERU5sz2cDVOjL/pMw=;
        b=g2ZlXQ7qgvtM4ymD1S7bOPuHDHdFKS8JbcnmHd4yyzFsKeZyt4x4esxFkgd/DtM6ed
         zgBkPTEHLdAoD0ZxsbSfE4ChdTbRdOLTyvZOJs1GT3FV0VRNxabhReKCIFOVK3x4zZ1+
         vLDxIDHSzNLkP61jmaXnoHxnK3iC+k4pJ4qdvKe8YiG1xikVHBd1UlzSx8LFo0DoUQ+n
         uWsOS7sLhNFAXAbcJlLq527SB3MNj3U0qQJIV+9NhVxx6Dz60HkQnh+NEC/RXR0dMZXH
         M3guXFcCwoqbgWF42cqQy4ugZoSHDcwxLjZnenrtNL+XF3XW3Gk+MRcH6gmDz5w3wlEa
         gBzg==
X-Gm-Message-State: AOJu0YxX2pN2Dw8sxOcYSoGrgLwuldWYWdA92AQ1LoEqAfpKi7Qu+/HI
	kzNxStsVsinb2PPEOd9LKhHfhwtfbgl82MAOEtQ=
X-Google-Smtp-Source: AGHT+IG0FtIdKo4pE/Mc/4f7lWF8kAzb8tGrmno1c4Zlw+TyOskgF9G2Q1o33B/OdPikAYHuwXuP1Q==
X-Received: by 2002:a05:6a00:22cd:b0:68f:c057:b567 with SMTP id f13-20020a056a0022cd00b0068fc057b567mr1654534pfj.26.1695809820656;
        Wed, 27 Sep 2023 03:17:00 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b0068fe7c4148fsm11327222pfd.57.2023.09.27.03.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 03:17:00 -0700 (PDT)
Message-ID: <8c758106-c0a1-5eb2-83c9-ab019039cec7@bytedance.com>
Date: Wed, 27 Sep 2023 18:16:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH bpf-next v3 5/7] bpf: teach the verifier to enforce
 css_iter and task_iter in RCU CS
To: Yafang Shao <laoar.shao@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
 linux-kernel@vger.kernel.org
References: <20230925105552.817513-1-zhouchuyi@bytedance.com>
 <20230925105552.817513-6-zhouchuyi@bytedance.com>
 <CALOAHbBrSasWs1=15TB0O+DnKohVKQrRWTM6x9zP-VR1G9zehQ@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CALOAHbBrSasWs1=15TB0O+DnKohVKQrRWTM6x9zP-VR1G9zehQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/9/27 18:00, Yafang Shao 写道:
> On Mon, Sep 25, 2023 at 6:56 PM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> css_iter and task_iter should be used in rcu section. Specifically, in
>> sleepable progs explicit bpf_rcu_read_lock() is needed before use these
>> iters. In normal bpf progs that have implicit rcu_read_lock(), it's OK to
>> use them directly.
>>
>> This patch adds a new a KF flag KF_RCU_PROTECTED for bpf_iter_task_new and
>> bpf_iter_css_new. It means the kfunc should be used in RCU CS. We check
>> whether we are in rcu cs before we want to invoke this kfunc. If the rcu
>> protection is guaranteed, we would let st->type = PTR_TO_STACK | MEM_RCU.
>> Once user do rcu_unlock during the iteration, state MEM_RCU of regs would
>> be cleared. is_iter_reg_valid_init() will reject if reg->type is UNTRUSTED.
>>
>> It is worth noting that currently, bpf_rcu_read_unlock does not
>> clear the state of the STACK_ITER reg, since bpf_for_each_spilled_reg
>> only considers STACK_SPILL. This patch also let bpf_for_each_spilled_reg
>> search STACK_ITER.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> 
> This patch should be ahead of patch #2 and you introduce
> KF_RCU_PROTECTED in it then use this flag in later patches.
> BTW, I can't apply your series on bpf-next. I think you should rebase
> it on the latest bpf-next, otherwise the BPF CI can't be triggered.
> 

Sorry for the mistake, will rebase in v4.

>> ---
>>   include/linux/bpf_verifier.h | 19 ++++++++------
>>   include/linux/btf.h          |  1 +
>>   kernel/bpf/helpers.c         |  4 +--
>>   kernel/bpf/verifier.c        | 48 +++++++++++++++++++++++++++---------
>>   4 files changed, 50 insertions(+), 22 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index a3236651ec64..b5cdcc332b0a 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -385,19 +385,18 @@ struct bpf_verifier_state {
>>          u32 jmp_history_cnt;
>>   };
>>
>> -#define bpf_get_spilled_reg(slot, frame)                               \
>> +#define bpf_get_spilled_reg(slot, frame, mask)                         \
>>          (((slot < frame->allocated_stack / BPF_REG_SIZE) &&             \
>> -         (frame->stack[slot].slot_type[0] == STACK_SPILL))             \
>> +         ((1 << frame->stack[slot].slot_type[0]) & (mask))) \
>>           ? &frame->stack[slot].spilled_ptr : NULL)
>>
>>   /* Iterate over 'frame', setting 'reg' to either NULL or a spilled register. */
>> -#define bpf_for_each_spilled_reg(iter, frame, reg)                     \
>> -       for (iter = 0, reg = bpf_get_spilled_reg(iter, frame);          \
>> +#define bpf_for_each_spilled_reg(iter, frame, reg, mask)                       \
>> +       for (iter = 0, reg = bpf_get_spilled_reg(iter, frame, mask);            \
>>               iter < frame->allocated_stack / BPF_REG_SIZE;              \
>> -            iter++, reg = bpf_get_spilled_reg(iter, frame))
>> +            iter++, reg = bpf_get_spilled_reg(iter, frame, mask))
>>
>> -/* Invoke __expr over regsiters in __vst, setting __state and __reg */
>> -#define bpf_for_each_reg_in_vstate(__vst, __state, __reg, __expr)   \
>> +#define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask, __expr)   \
>>          ({                                                               \
>>                  struct bpf_verifier_state *___vstate = __vst;            \
>>                  int ___i, ___j;                                          \
>> @@ -409,7 +408,7 @@ struct bpf_verifier_state {
>>                                  __reg = &___regs[___j];                  \
>>                                  (void)(__expr);                          \
>>                          }                                                \
>> -                       bpf_for_each_spilled_reg(___j, __state, __reg) { \
>> +                       bpf_for_each_spilled_reg(___j, __state, __reg, __mask) { \
>>                                  if (!__reg)                              \
>>                                          continue;                        \
>>                                  (void)(__expr);                          \
>> @@ -417,6 +416,10 @@ struct bpf_verifier_state {
>>                  }                                                        \
>>          })
>>
>> +/* Invoke __expr over regsiters in __vst, setting __state and __reg */
>> +#define bpf_for_each_reg_in_vstate(__vst, __state, __reg, __expr) \
>> +       bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, 1 << STACK_SPILL, __expr)
>> +
>>   /* linked list of verifier states used to prune search */
>>   struct bpf_verifier_state_list {
>>          struct bpf_verifier_state state;
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index 928113a80a95..c2231c64d60b 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -74,6 +74,7 @@
>>   #define KF_ITER_NEW     (1 << 8) /* kfunc implements BPF iter constructor */
>>   #define KF_ITER_NEXT    (1 << 9) /* kfunc implements BPF iter next method */
>>   #define KF_ITER_DESTROY (1 << 10) /* kfunc implements BPF iter destructor */
>> +#define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu cs when they are invoked */
>>
>>   /*
>>    * Tag marking a kernel function as a kfunc. This is meant to minimize the
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 9c3af36249a2..aa9e03fbfe1a 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2507,10 +2507,10 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
>>   BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
>> -BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
>> +BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
>>   BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
>> -BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
>> +BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
>>   BTF_ID_FLAGS(func, bpf_iter_css_next, KF_ITER_NEXT | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 2367483bf4c2..a065e18a0b3a 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -1172,7 +1172,12 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
>>
>>   static void __mark_reg_known_zero(struct bpf_reg_state *reg);
>>
>> +static bool in_rcu_cs(struct bpf_verifier_env *env);
>> +
>> +static bool is_kfunc_rcu_protected(struct bpf_kfunc_call_arg_meta *meta);
>> +
>>   static int mark_stack_slots_iter(struct bpf_verifier_env *env,
>> +                                struct bpf_kfunc_call_arg_meta *meta,
>>                                   struct bpf_reg_state *reg, int insn_idx,
>>                                   struct btf *btf, u32 btf_id, int nr_slots)
>>   {
>> @@ -1193,6 +1198,12 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
>>
>>                  __mark_reg_known_zero(st);
>>                  st->type = PTR_TO_STACK; /* we don't have dedicated reg type */
>> +               if (is_kfunc_rcu_protected(meta)) {
>> +                       if (in_rcu_cs(env))
>> +                               st->type |= MEM_RCU;
> 
> I think this change is incorrect.  The type of st->type is enum
> bpf_reg_type, but MEM_RCU is enum bpf_type_flag.
> Or am I missing something?
Looking at is_rcu_reg(), It seems OK to add MEM_RCU flag to st->type.

static bool is_rcu_reg(const struct bpf_reg_state *reg)
{
	return reg->type & MEM_RCU;
}

Here is the previous discussion link:
https://lore.kernel.org/lkml/CAADnVQKu+a6MKKfJy8NVmwtpEw1ae-_8opsGjdvvfoUjwE1sog@mail.gmail.com/

Thanks.

> 
>> +                       else
>> +                               st->type |= PTR_UNTRUSTED;
>> +               }
>>                  st->live |= REG_LIVE_WRITTEN;
>>                  st->ref_obj_id = i == 0 ? id : 0;
>>                  st->iter.btf = btf;
>> @@ -1267,7 +1278,7 @@ static bool is_iter_reg_valid_uninit(struct bpf_verifier_env *env,
>>          return true;
>>   }
>>
>> -static bool is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>> +static int is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>>                                     struct btf *btf, u32 btf_id, int nr_slots)
>>   {
>>          struct bpf_func_state *state = func(env, reg);
>> @@ -1275,26 +1286,28 @@ static bool is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_
>>
>>          spi = iter_get_spi(env, reg, nr_slots);
>>          if (spi < 0)
>> -               return false;
>> +               return -EINVAL;
>>
>>          for (i = 0; i < nr_slots; i++) {
>>                  struct bpf_stack_state *slot = &state->stack[spi - i];
>>                  struct bpf_reg_state *st = &slot->spilled_ptr;
>>
>> +               if (st->type & PTR_UNTRUSTED)
>> +                       return -EPERM;
>>                  /* only main (first) slot has ref_obj_id set */
>>                  if (i == 0 && !st->ref_obj_id)
>> -                       return false;
>> +                       return -EINVAL;
>>                  if (i != 0 && st->ref_obj_id)
>> -                       return false;
>> +                       return -EINVAL;
>>                  if (st->iter.btf != btf || st->iter.btf_id != btf_id)
>> -                       return false;
>> +                       return -EINVAL;
>>
>>                  for (j = 0; j < BPF_REG_SIZE; j++)
>>                          if (slot->slot_type[j] != STACK_ITER)
>> -                               return false;
>> +                               return -EINVAL;
>>          }
>>
>> -       return true;
>> +       return 0;
>>   }
>>
>>   /* Check if given stack slot is "special":
>> @@ -7503,15 +7516,20 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
>>                                  return err;
>>                  }
>>
>> -               err = mark_stack_slots_iter(env, reg, insn_idx, meta->btf, btf_id, nr_slots);
>> +               err = mark_stack_slots_iter(env, meta, reg, insn_idx, meta->btf, btf_id, nr_slots);
>>                  if (err)
>>                          return err;
>>          } else {
>>                  /* iter_next() or iter_destroy() expect initialized iter state*/
>> -               if (!is_iter_reg_valid_init(env, reg, meta->btf, btf_id, nr_slots)) {
>> -                       verbose(env, "expected an initialized iter_%s as arg #%d\n",
>> +               err = is_iter_reg_valid_init(env, reg, meta->btf, btf_id, nr_slots);
>> +               switch (err) {
>> +               case -EINVAL:
>> +                       verbose(env, "expected an initialized iter_%s as arg #%d or without bpf_rcu_read_lock()\n",
>>                                  iter_type_str(meta->btf, btf_id), regno);
>> -                       return -EINVAL;
>> +                       return err;
>> +               case -EPERM:
>> +                       verbose(env, "expected an RCU CS when using %s\n", meta->func_name);
>> +                       return err;
>>                  }
>>
>>                  spi = iter_get_spi(env, reg, nr_slots);
>> @@ -10092,6 +10110,11 @@ static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
>>          return meta->kfunc_flags & KF_RCU;
>>   }
>>
>> +static bool is_kfunc_rcu_protected(struct bpf_kfunc_call_arg_meta *meta)
>> +{
>> +       return meta->kfunc_flags & KF_RCU_PROTECTED;
>> +}
>> +
>>   static bool __kfunc_param_match_suffix(const struct btf *btf,
>>                                         const struct btf_param *arg,
>>                                         const char *suffix)
>> @@ -11428,6 +11451,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>          if (env->cur_state->active_rcu_lock) {
>>                  struct bpf_func_state *state;
>>                  struct bpf_reg_state *reg;
>> +               u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
>>
>>                  if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
>>                          verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
>> @@ -11438,7 +11462,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>                          verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
>>                          return -EINVAL;
>>                  } else if (rcu_unlock) {
>> -                       bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
>> +                       bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, clear_mask, ({
>>                                  if (reg->type & MEM_RCU) {
>>                                          reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
>>                                          reg->type |= PTR_UNTRUSTED;
>> --
>> 2.20.1
>>
>>
> 
> 

