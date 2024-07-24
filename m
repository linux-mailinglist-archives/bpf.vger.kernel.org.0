Return-Path: <bpf+bounces-35550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BB693B6AE
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 20:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF872839C4
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 18:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B061A16A955;
	Wed, 24 Jul 2024 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmJKqdIl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9815FA6B;
	Wed, 24 Jul 2024 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721845639; cv=none; b=F6JAN76QPGRPKGAmXQjy8/1X7RWEYvIOfzIuIsnMsHa9sA3R9FNK6CIhV2+WHqsb2rWmGT2PPbS9I/1892t9RP730BJ1EGBOSk+WYzcqSSlI4DJmDmhNWguKVaE1ukxgyIYTeelWKQsdh5FBJfC0AKe9jLvnGiQMWBZt5pfI4T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721845639; c=relaxed/simple;
	bh=dBZ8cj0g3/7nY2SXJgaaeOu2OfqjdKlK+C6djHSiRI4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VISIQNEjhZYHhERR7Zpn96KhbQ7QofRSjbZYIHId5+34IPC1KHvLx3gqlgGlztcMMhpnFR0iqQdqJ/jlTTCIn3PdjH6hj/bYXyLMBfLUggnNku4UZ9fRecneI8EN4NBVJ7oJNEQTF2sTYZFhJ6W+MWSOHhT+8KbGS9VQmRun/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmJKqdIl; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-65cd720cee2so912407b3.1;
        Wed, 24 Jul 2024 11:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721845636; x=1722450436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bP3yGlPFYl4xKD3JQo/IrKpWzpBx1BjrkFi4uxfnWG8=;
        b=dmJKqdIlvLTm2iSMjNXMiNyJ+izng7c54uGmcb2kja1F/1lyXfGy161+0h2cUVtMMc
         Y1iAmYeZR3sWzdGBFwLNJn1ruFNszfig0HfOwU9hJha/B4Ju4Lgdnx9+Qmb1hVoXcFSK
         FMXiJmddlwAQCZE4KgZd3E5DM4GuP2yNMHm3UZ6Zv2GBSGOGpA5nxdWPCflqqDMKFI2H
         MTBiZne2b39eqQGR8tnco99FlfRLODlLDWBvUtaB8w5Z2Ke2X/bnyXN30XWpbtVH8Phu
         nH1LR3WXslTMnsVAX2ozmejZrS10yojw4YQGjzULZ5cTWiWOzSj7X35CwpPtjBtGcCa8
         GSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721845636; x=1722450436;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bP3yGlPFYl4xKD3JQo/IrKpWzpBx1BjrkFi4uxfnWG8=;
        b=jDIlpqpJh/9k/4fbirQugwin+qeE6L9HMhPLHTw5XuL644h2rdAhOhy7cZZf6PbPyw
         frKs09x/iybbr2O+mvuJWBSYxFftiu6FiD0bzMU5ih4mfGD+iA9KLNCxteJU/ZJdkar8
         lL/RLC/ugqcuV4CPqBISE6ciGNvNzj2HrgVYbFN0GHEGQ6bciv3rcDG0Q21L71GA/zhp
         TON2HENqZzqRTJFFJ3TqQWbZSBztky+slOS5GBk2f/PnOWpKDdpVWI2/pzv9xaL0JGsW
         KUauRBLH1ClX53eF4wk7SiVE+0Fmm9Mzi/+fgeSUV3oolq77279NBrSeiXkbcw5wvF8b
         svxA==
X-Forwarded-Encrypted: i=1; AJvYcCXlExY3+SQvm7ztWPqdn1iZ09TzFGaVY2TiB/xA334/FLDVSZZudcI1/3+V0U93U0t8eGCEtj8G+1mgl9ZtuSHS9o/AWF+r
X-Gm-Message-State: AOJu0YxKCa9RsPv0Dqm6RatoDbeoUH1VdaUYTVqh4ogiRyzk6R/GBUj8
	XaMpR1/dT+lTulth6tbs/QIFaRJZLXDSHVkLppQeBxAGkevW+mpB
X-Google-Smtp-Source: AGHT+IGV7g1bTuQcIMrvEpr1yAMf8XmcPW65dUdI7JcQzgWAAcKQkIYMMY2p7amxl+fB9VWj1XCjtA==
X-Received: by 2002:a0d:dac5:0:b0:65f:93c1:fee9 with SMTP id 00721157ae682-67510736bbbmr3529907b3.9.1721845636334;
        Wed, 24 Jul 2024 11:27:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:abc3:64f6:15ee:5e16? ([2600:1700:6cf8:1240:abc3:64f6:15ee:5e16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-669540bea2csm25928867b3.110.2024.07.24.11.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 11:27:15 -0700 (PDT)
Message-ID: <b1e119ad-5380-4fd7-a5a6-89e2204410d2@gmail.com>
Date: Wed, 24 Jul 2024 11:27:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 03/11] bpf: Allow struct_ops prog to return
 referenced kptr
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-4-amery.hung@bytedance.com>
 <5b527381-ef28-470e-954d-45ce27e8d9d9@gmail.com>
Content-Language: en-US
In-Reply-To: <5b527381-ef28-470e-954d-45ce27e8d9d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/23/24 22:36, Kui-Feng Lee wrote:
> 
> 
> On 7/14/24 10:51, Amery Hung wrote:
>> Allow a struct_ops program to return a referenced kptr if the struct_ops
>> operator has pointer to struct as the return type. To make sure the
>> returned pointer continues to be valid in the kernel, several
>> constraints are required:
>>
>> 1) The type of the pointer must matches the return type
>> 2) The pointer originally comes from the kernel (not locally allocated)
>> 3) The pointer is in its unmodified form
>>
>> In addition, since the first user, Qdisc_ops::dequeue, allows a NULL
>> pointer to be returned when there is no skb to be dequeued, we will allow
>> a scalar value with value equals to NULL to be returned.
>>
>> In the future when there is a struct_ops user that always expects a valid
>> pointer to be returned from an operator, we may extend tagging to the
>> return value. We can tell the verifier to only allow NULL pointer return
>> if the return value is tagged with MAY_BE_NULL.
>>
>> The check is split into two parts since check_reference_leak() happens
>> before check_return_code(). We first allow a reference object to leak
>> through return if it is in the return register and the type matches the
>> return type. Then, we check whether the pointer to-be-returned is 
>> valid in
>> check_return_code().
>>
>> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
>> ---
>>   kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 46 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f614ab283c37..e7f356098902 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -10188,16 +10188,36 @@ record_func_key(struct bpf_verifier_env 
>> *env, struct bpf_call_arg_meta *meta,
>>   static int check_reference_leak(struct bpf_verifier_env *env, bool 
>> exception_exit)
>>   {
>> +    enum bpf_prog_type type = resolve_prog_type(env->prog);
>> +    u32 regno = exception_exit ? BPF_REG_1 : BPF_REG_0;
>> +    struct bpf_reg_state *reg = reg_state(env, regno);
>>       struct bpf_func_state *state = cur_func(env);
>> +    const struct bpf_prog *prog = env->prog;
>> +    const struct btf_type *ret_type = NULL;
>>       bool refs_lingering = false;
>> +    struct btf *btf;
>>       int i;
>>       if (!exception_exit && state->frameno && !state->in_callback_fn)
>>           return 0;
>> +    if (type == BPF_PROG_TYPE_STRUCT_OPS &&
>> +        reg->type & PTR_TO_BTF_ID && reg->ref_obj_id) {
>> +        btf = bpf_prog_get_target_btf(prog);
>> +        ret_type = btf_type_by_id(btf, 
>> prog->aux->attach_func_proto->type);
>> +        if (reg->btf_id != ret_type->type) {
>> +            verbose(env, "Return kptr type, struct %s, doesn't match 
>> function prototype, struct %s\n",
>> +                btf_type_name(reg->btf, reg->btf_id),
>> +                btf_type_name(btf, ret_type->type));
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
>>       for (i = 0; i < state->acquired_refs; i++) {
>>           if (!exception_exit && state->in_callback_fn && 
>> state->refs[i].callback_ref != state->frameno)
>>               continue;
>> +        if (ret_type && reg->ref_obj_id == state->refs[i].id)
>> +            continue;
> 
> Is it possible having two kptrs that both are in the returned type
> passing into a function?

Does it work to remove the ref pointed by reg0 from state
at the location that handles BPF_EXIT in do_check()?

> 
> 
>>           verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
>>               state->refs[i].id, state->refs[i].insn_idx);
>>           refs_lingering = true;
>> @@ -15677,12 +15697,15 @@ static int check_return_code(struct 
>> bpf_verifier_env *env, int regno, const char
>>       const char *exit_ctx = "At program exit";
>>       struct tnum enforce_attach_type_range = tnum_unknown;
>>       const struct bpf_prog *prog = env->prog;
>> -    struct bpf_reg_state *reg;
>> +    struct bpf_reg_state *reg = reg_state(env, regno);
>>       struct bpf_retval_range range = retval_range(0, 1);
>>       enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>>       int err;
>>       struct bpf_func_state *frame = env->cur_state->frame[0];
>>       const bool is_subprog = frame->subprogno;
>> +    struct btf *btf = bpf_prog_get_target_btf(prog);
>> +    bool st_ops_ret_is_kptr = false;
>> +    const struct btf_type *t;
>>       /* LSM and struct_ops func-ptr's return type could be "void" */
>>       if (!is_subprog || frame->in_exception_callback_fn) {
>> @@ -15691,10 +15714,26 @@ static int check_return_code(struct 
>> bpf_verifier_env *env, int regno, const char
>>               if (prog->expected_attach_type == BPF_LSM_CGROUP)
>>                   /* See below, can be 0 or 0-1 depending on hook. */
>>                   break;
>> -            fallthrough;
>> +            if (!prog->aux->attach_func_proto->type)
>> +                return 0;
>> +            break;
>>           case BPF_PROG_TYPE_STRUCT_OPS:
>>               if (!prog->aux->attach_func_proto->type)
>>                   return 0;
>> +
>> +            t = btf_type_by_id(btf, prog->aux->attach_func_proto->type);
>> +            if (btf_type_is_ptr(t)) {
>> +                /* Allow struct_ops programs to return kptr or null if
>> +                 * the return type is a pointer type.
>> +                 * check_reference_leak has ensured the returning kptr
>> +                 * matches the type of the function prototype and is
>> +                 * the only leaking reference. Thus, we can safely 
>> return
>> +                 * if the pointer is in its unmodified form
>> +                 */
>> +                if (reg->type & PTR_TO_BTF_ID)
>> +                    return __check_ptr_off_reg(env, reg, regno, false);
>> +                st_ops_ret_is_kptr = true;
>> +            }
>>               break;
>>           default:
>>               break;
>> @@ -15716,8 +15755,6 @@ static int check_return_code(struct 
>> bpf_verifier_env *env, int regno, const char
>>           return -EACCES;
>>       }
>> -    reg = cur_regs(env) + regno;
>> -
>>       if (frame->in_async_callback_fn) {
>>           /* enforce return zero from async callbacks like timer */
>>           exit_ctx = "At async callback return";
>> @@ -15804,6 +15841,11 @@ static int check_return_code(struct 
>> bpf_verifier_env *env, int regno, const char
>>       case BPF_PROG_TYPE_NETFILTER:
>>           range = retval_range(NF_DROP, NF_ACCEPT);
>>           break;
>> +    case BPF_PROG_TYPE_STRUCT_OPS:
>> +        if (!st_ops_ret_is_kptr)
>> +            return 0;
>> +        range = retval_range(0, 0);
>> +        break;
>>       case BPF_PROG_TYPE_EXT:
>>           /* freplace program can return anything as its return value
>>            * depends on the to-be-replaced kernel func or bpf program.

