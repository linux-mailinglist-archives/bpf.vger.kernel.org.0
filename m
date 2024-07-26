Return-Path: <bpf+bounces-35750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D33293D844
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 20:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CF5282C68
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 18:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B679438F9A;
	Fri, 26 Jul 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLm0QNqo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD0142AAA;
	Fri, 26 Jul 2024 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018138; cv=none; b=hKACaLg7aAOHIu4SBvMnkN09PtUJrlouDG9xyx0tcshM4xMc8uS3QXtV5JeX1evS3RFOjkBKDR/4h+wQzXNK/Q+NGbGkM5FqQZJ/vo1wozc0ZddklvRXL7IlZBo/uaBy+WzmBNNaxgGbc2cK030DyUI4G1/onmF9SAMlI8Lpn7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018138; c=relaxed/simple;
	bh=NU+Jv0DfraapUdJKNy+J2bVvTbZcI8avxdq4SovuWck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbwC3EQa6v97wwAkGQmXhv/uQdANiNH08R7S5dGXAWeON3ggcI9V6mqvcrHAh1kopQc5kt4nwQlg86Jzly2QDAS0Mky8DKH5zNCSmb5ztwo9MbbrVorrd0VyoB2VolqLS8GCP94FAFcD0ol8CU8txU8Ap8+QXPMN4Zki7s3EKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLm0QNqo; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e03a17a50a9so2303205276.1;
        Fri, 26 Jul 2024 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722018135; x=1722622935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQsf1oGjK1jn4CBAjXqpk95n3qn94fma/VR5tQDExOM=;
        b=OLm0QNqojrHG3TXwh2zSeQ+faUe10paW2TI2yvjTt7SctFjmM6KNmTIIz2KuZTX7Ht
         fy+rCoRpd5qdggOqE+x7+6y8t4M/2gtJfX0dB7HzsgszMBaoi2gFZqWRB65MsZlc/UVH
         U5V2xwWJhsXlUyNnVtskMDoCev1q4uGcpLY0EvoC7bsQJwdQEz5zIhEQwQHzS+9WRebZ
         eRmhvcghz/CEQHL1tz+z68id4IWaajuxsAwgjFdfdYrw+x5s2uuSa8yyiJRC3+yAMVbL
         1nnDQWV3riutqkauFYXkw0pjSmEIVkiE08ogosB0uUeozmbmBKd54ip9ougpnKf1sfVz
         xtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722018135; x=1722622935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQsf1oGjK1jn4CBAjXqpk95n3qn94fma/VR5tQDExOM=;
        b=ZC2T9QAiYOva/MTOWjNFpckR0eLZqkgbNUb7yjFsaHaFtbg3SdVZbcZkoAHszJxYC2
         4d0pXA3V5JSYv9GmpXzEy6QNoU7Lxhs4rC/1nAhAdFfpTXFyK9utKxNocRVh5GVT1HXc
         aAvAs7RO317oYWFy3AHyPsZWfFFgovlhQ6UgZBmNnoPSoxrFcLGeObBMtgbS3uI1IJyL
         lnQXnv0sHbGjI5E5z50CPUzmwA00zPC8c0coK4weYbb59/AqlqRki1nOPVgn6Egbc265
         KNk39qQm/XcDdnB5V0v5WAbDFQaMwggmeiNsyNRo4DHo3t+fvoT1e8uTaPlAg0zbLlN/
         T8dw==
X-Forwarded-Encrypted: i=1; AJvYcCUvGB+nYberO46QIuz1a2LrndIvyAdxDfm6A9yebxD3LC5PUNSdhhCNECHx2OTUgAAgbxZj3Y2p+lphE3f8ZpVVEGjn
X-Gm-Message-State: AOJu0Yxeyly7G+4Z8anexZwMOqBDOHhyt2JZngiLj2KPI3T+O/u3VacD
	JEJrV7vO6Ybr/MUnZn1NaGU7UlYru7S8o1WnOQD50Mo7jECr+J8x
X-Google-Smtp-Source: AGHT+IFF33LQJSwFmIS4zz0DrUWtl/p3olw/yXSa849P7EZbhnWMU8vNuQ/7wHnhq98PuCpnr5efIA==
X-Received: by 2002:a05:6902:2b0d:b0:e03:adcb:f8e8 with SMTP id 3f1490d57ef6-e0b544fec79mr795802276.30.1722018135470;
        Fri, 26 Jul 2024 11:22:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:d785:ba42:22fc:942e? ([2600:1700:6cf8:1240:d785:ba42:22fc:942e])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b29f4f90asm865078276.16.2024.07.26.11.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 11:22:15 -0700 (PDT)
Message-ID: <71fa8e2c-953d-447d-905a-e2c596839cea@gmail.com>
Date: Fri, 26 Jul 2024 11:22:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 03/11] bpf: Allow struct_ops prog to return
 referenced kptr
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 sdf@google.com, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-4-amery.hung@bytedance.com>
 <5b527381-ef28-470e-954d-45ce27e8d9d9@gmail.com>
 <CAMB2axOR-9_h2wCiibRD0bwoCntZi7h_g79E1naRLFOurWscTg@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAMB2axOR-9_h2wCiibRD0bwoCntZi7h_g79E1naRLFOurWscTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/24/24 13:44, Amery Hung wrote:
> On Tue, Jul 23, 2024 at 10:36 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 7/14/24 10:51, Amery Hung wrote:
>>> Allow a struct_ops program to return a referenced kptr if the struct_ops
>>> operator has pointer to struct as the return type. To make sure the
>>> returned pointer continues to be valid in the kernel, several
>>> constraints are required:
>>>
>>> 1) The type of the pointer must matches the return type
>>> 2) The pointer originally comes from the kernel (not locally allocated)
>>> 3) The pointer is in its unmodified form
>>>
>>> In addition, since the first user, Qdisc_ops::dequeue, allows a NULL
>>> pointer to be returned when there is no skb to be dequeued, we will allow
>>> a scalar value with value equals to NULL to be returned.
>>>
>>> In the future when there is a struct_ops user that always expects a valid
>>> pointer to be returned from an operator, we may extend tagging to the
>>> return value. We can tell the verifier to only allow NULL pointer return
>>> if the return value is tagged with MAY_BE_NULL.
>>>
>>> The check is split into two parts since check_reference_leak() happens
>>> before check_return_code(). We first allow a reference object to leak
>>> through return if it is in the return register and the type matches the
>>> return type. Then, we check whether the pointer to-be-returned is valid in
>>> check_return_code().
>>>
>>> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
>>> ---
>>>    kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++++++++++++++----
>>>    1 file changed, 46 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index f614ab283c37..e7f356098902 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -10188,16 +10188,36 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>>>
>>>    static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exit)
>>>    {
>>> +     enum bpf_prog_type type = resolve_prog_type(env->prog);
>>> +     u32 regno = exception_exit ? BPF_REG_1 : BPF_REG_0;
>>> +     struct bpf_reg_state *reg = reg_state(env, regno);
>>>        struct bpf_func_state *state = cur_func(env);
>>> +     const struct bpf_prog *prog = env->prog;
>>> +     const struct btf_type *ret_type = NULL;
>>>        bool refs_lingering = false;
>>> +     struct btf *btf;
>>>        int i;
>>>
>>>        if (!exception_exit && state->frameno && !state->in_callback_fn)
>>>                return 0;
>>>
>>> +     if (type == BPF_PROG_TYPE_STRUCT_OPS &&
>>> +         reg->type & PTR_TO_BTF_ID && reg->ref_obj_id) {
>>> +             btf = bpf_prog_get_target_btf(prog);
>>> +             ret_type = btf_type_by_id(btf, prog->aux->attach_func_proto->type);
>>> +             if (reg->btf_id != ret_type->type) {
>>> +                     verbose(env, "Return kptr type, struct %s, doesn't match function prototype, struct %s\n",
>>> +                             btf_type_name(reg->btf, reg->btf_id),
>>> +                             btf_type_name(btf, ret_type->type));
>>> +                     return -EINVAL;
>>> +             }
>>> +     }
>>> +
>>>        for (i = 0; i < state->acquired_refs; i++) {
>>>                if (!exception_exit && state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
>>>                        continue;
>>> +             if (ret_type && reg->ref_obj_id == state->refs[i].id)
>>> +                     continue;
>>
>> Is it possible having two kptrs that both are in the returned type
>> passing into a function?
>>
> 
> Just to make sure I understand the question correctly: Are you asking
> what would happen here if a struct_ops operator has the following
> signature?
> 
> struct *foo xxx_ops__dummy_op(struct foo *foo_a__ref, struct foo *foo_b__ref)

Right! What would happen to this case? Could one of them leak without
being detected?

> 
>>
>>>                verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
>>>                        state->refs[i].id, state->refs[i].insn_idx);
>>>                refs_lingering = true;
>>> @@ -15677,12 +15697,15 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
>>>        const char *exit_ctx = "At program exit";
>>>        struct tnum enforce_attach_type_range = tnum_unknown;
>>>        const struct bpf_prog *prog = env->prog;
>>> -     struct bpf_reg_state *reg;
>>> +     struct bpf_reg_state *reg = reg_state(env, regno);
>>>        struct bpf_retval_range range = retval_range(0, 1);
>>>        enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>>>        int err;
>>>        struct bpf_func_state *frame = env->cur_state->frame[0];
>>>        const bool is_subprog = frame->subprogno;
>>> +     struct btf *btf = bpf_prog_get_target_btf(prog);
>>> +     bool st_ops_ret_is_kptr = false;
>>> +     const struct btf_type *t;
>>>
>>>        /* LSM and struct_ops func-ptr's return type could be "void" */
>>>        if (!is_subprog || frame->in_exception_callback_fn) {
>>> @@ -15691,10 +15714,26 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
>>>                        if (prog->expected_attach_type == BPF_LSM_CGROUP)
>>>                                /* See below, can be 0 or 0-1 depending on hook. */
>>>                                break;
>>> -                     fallthrough;
>>> +                     if (!prog->aux->attach_func_proto->type)
>>> +                             return 0;
>>> +                     break;
>>>                case BPF_PROG_TYPE_STRUCT_OPS:
>>>                        if (!prog->aux->attach_func_proto->type)
>>>                                return 0;
>>> +
>>> +                     t = btf_type_by_id(btf, prog->aux->attach_func_proto->type);
>>> +                     if (btf_type_is_ptr(t)) {
>>> +                             /* Allow struct_ops programs to return kptr or null if
>>> +                              * the return type is a pointer type.
>>> +                              * check_reference_leak has ensured the returning kptr
>>> +                              * matches the type of the function prototype and is
>>> +                              * the only leaking reference. Thus, we can safely return
>>> +                              * if the pointer is in its unmodified form
>>> +                              */
>>> +                             if (reg->type & PTR_TO_BTF_ID)
>>> +                                     return __check_ptr_off_reg(env, reg, regno, false);
>>> +                             st_ops_ret_is_kptr = true;
>>> +                     }
>>>                        break;
>>>                default:
>>>                        break;
>>> @@ -15716,8 +15755,6 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
>>>                return -EACCES;
>>>        }
>>>
>>> -     reg = cur_regs(env) + regno;
>>> -
>>>        if (frame->in_async_callback_fn) {
>>>                /* enforce return zero from async callbacks like timer */
>>>                exit_ctx = "At async callback return";
>>> @@ -15804,6 +15841,11 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
>>>        case BPF_PROG_TYPE_NETFILTER:
>>>                range = retval_range(NF_DROP, NF_ACCEPT);
>>>                break;
>>> +     case BPF_PROG_TYPE_STRUCT_OPS:
>>> +             if (!st_ops_ret_is_kptr)
>>> +                     return 0;
>>> +             range = retval_range(0, 0);
>>> +             break;
>>>        case BPF_PROG_TYPE_EXT:
>>>                /* freplace program can return anything as its return value
>>>                 * depends on the to-be-replaced kernel func or bpf program.

