Return-Path: <bpf+bounces-21141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8828489DD
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 01:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAE31C215B8
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 00:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BCF10FF;
	Sun,  4 Feb 2024 00:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adQJmhh3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678C710E9
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707006096; cv=none; b=Q+Y+/MjxDkAa3OoqJf6CZTpEMRI2FBz0iSjotumo4OMg6x6lzAao5Vy0aC4L3dJ80WMV1H/qD0zKxTKaeHba7hKB2/KKm/JOohOtrUzsdeOVqk71bN25IrJNN/qgL/T+4XDLR0UxwyJxutl498D4P/T6JLdIOwNJFUb8Eh60Fjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707006096; c=relaxed/simple;
	bh=CvSY64xw6FoTgzEk2K1HgWfCxQ7iv5S45y1PG8A+FPo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oQCA+Bla5hVIXQ2S0Vfc6iV8Fb3hlR74z2f64aEvLfSMMaV6+wNzlsKZqUxBZ185I3WhJUXgWFnlUzg4neF3HB9byw/P0S+PEAX6ggy3NQ0vFyiByqBB+8aH2Hg+17/cTD+2yGLQv9FFUzEobiptHsT460o8wzzcNVnJYItIGBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adQJmhh3; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6043a7398fdso8590617b3.0
        for <bpf@vger.kernel.org>; Sat, 03 Feb 2024 16:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707006093; x=1707610893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mt1ozWlgombtc7iOPgviQugMEpth7Aa3tTP5zgPvhm4=;
        b=adQJmhh3J1J8lYtYgTKyOJsZ0S/u4K3dFFGy3HPCSqCI69KOI1xxgk4jaPWeeZ2ZQl
         Nyj/i8/lw/6Zy2TzDHGQcqcLe+lay6HgfqabCECCzNjczFV5rmwdDlvFI5LkEkyP85pb
         iy3+AUFvosNurVsnXpXkIjJPRMv4Cmbxif7tREmlq724APc9Orl4EKuCNqoiIuMcXipP
         2WbWf4UzAd0lksnzOEsYXSmNaP2kQZ079kYgvqDQGxEr79JwsBvLEWAUmyg4Bmp+xG7p
         T+OZRVHxroNSqvupY43WfXafzWEQSOxavlxBRKr9RhlN3G/BpO4KLey9DGW5r0WQrz4j
         spmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707006093; x=1707610893;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mt1ozWlgombtc7iOPgviQugMEpth7Aa3tTP5zgPvhm4=;
        b=OoHuNFbNz8M9CDCcTskbd1qP5QX9dnUqf+5hpsl2qa98mPntfSfqrRDs0gpV5NHADU
         Co22xnRkNSEnc4GJwdtAwu+OQxhKqZiSedv1/1s9iUwa1QwnAbUD52SPHFJFNTscGPfc
         Xh1qsOt04dgszs41VNtR80mXB65ohaRcyakVf6UX4L7XL811vhq/FhTMUAmZkkz3aVaM
         1/9CW98QA05uil9ZUVo3BgqCAxHuGKpyXas73bYwyT/ipbQtUQyaE/UxiMYbqxOARTRJ
         aqkCf1saYFd5655Ihd5Ue1WStVxDKpsBXcjn7rsN4XJSqkl7IhZ0YRqg63l7qWAaUcyB
         6TDA==
X-Gm-Message-State: AOJu0YyHGGrqw/fLfpJ4Prgf/2vLyGDyVKA44bQmsBxBfVyfjviFp4i4
	1EZwgtCCRs3+NhwnVZySiakxFh8SDiapAES1ZLEFc6QSE77Ku961
X-Google-Smtp-Source: AGHT+IEzgyK6XcaUGlLDeWTIUHcXOUwyF7yKKaFEvI0kDpxI8HAIGqKh0yN+jTLqYjhmMNBfuc7MQw==
X-Received: by 2002:a81:b662:0:b0:5e3:320b:7c with SMTP id h34-20020a81b662000000b005e3320b007cmr9048634ywk.37.1707006093086;
        Sat, 03 Feb 2024 16:21:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXwyl932EXl9Q8ma4xipz/kan9dPv6eUQ/usVCn5eyPfasUs2bnBihkBhD+lX0vUgm777txjuVJyZJqeVKQx4p01mOW7pnz92UBRQaguGKWFAPZOXPR7W5zB+6LzknVtMN7sqxNTwotoFamEa1D+7zJS6E2Jwu+vaLMWE1M578+Y35bS4uklg4Rt8zcqIM9m/8OVyJrjGVFQBXr+Lt4ryzBWErvJbLZD2FFXWrdttMmtK8XpNXHkBEDJ1wlND0j92IOeEmD0kNkpquj3Fmmgg==
Received: from ?IPV6:2600:1700:6cf8:1240:3731:e216:7508:9d27? ([2600:1700:6cf8:1240:3731:e216:7508:9d27])
        by smtp.gmail.com with ESMTPSA id o3-20020a817303000000b006040bff8aedsm1216380ywc.110.2024.02.03.16.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 16:21:32 -0800 (PST)
Message-ID: <dfcbed41-19a4-4212-b694-aee850beb2c9@gmail.com>
Date: Sat, 3 Feb 2024 16:21:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v4 5/6] bpf: Create argument information for
 nullable arguments.
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, davemarchevsky@meta.com,
 dvernet@meta.com
References: <20240202220516.1165466-1-thinker.li@gmail.com>
 <20240202220516.1165466-6-thinker.li@gmail.com>
 <6b1d0822-73c4-472a-a170-947b53f2c66f@linux.dev>
 <d1b97f2e-502a-494b-b873-3da8558a1081@gmail.com>
In-Reply-To: <d1b97f2e-502a-494b-b873-3da8558a1081@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/2/24 17:57, Kui-Feng Lee wrote:
> 
> 
> On 2/2/24 16:40, Martin KaFai Lau wrote:
>> On 2/2/24 2:05 PM, thinker.li@gmail.com wrote:
>>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>>
>>> Collect argument information from the type information of stub 
>>> functions to
>>> mark arguments of BPF struct_ops programs with PTR_MAYBE_NULL if they 
>>> are
>>> nullable.  A nullable argument is annotated by suffixing "__nullable" at
>>> the argument name of stub function.
>>>
>>> For nullable arguments, this patch sets an arg_info to label their 
>>> reg_type
>>> with PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL. This makes the 
>>> verifier
>>> to check programs and ensure that they properly check the pointer. The
>>> programs should check if the pointer is null before accessing the 
>>> pointed
>>> memory.
>>>
>>> The implementer of a struct_ops type should annotate the arguments 
>>> that can
>>> be null. The implementer should define a stub function (empty) as a
>>> placeholder for each defined operator. The name of a stub function 
>>> should
>>> be in the pattern "<st_op_type>__<operator name>". For example, for
>>> test_maybe_null of struct bpf_testmod_ops, it's stub function name 
>>> should
>>> be "bpf_testmod_ops__test_maybe_null". You mark an argument nullable by
>>> suffixing the argument name with "__nullable" at the stub function.
>>>
>>> Since we already has stub functions for kCFI, we just reuse these stub
>>> functions with the naming convention mentioned earlier. These stub
>>> functions with the naming convention is only required if there are 
>>> nullable
>>> arguments to annotate. For functions having not nullable arguments, stub
>>> functions are not necessary for the purpose of this patch.
>>>
>>> This patch will prepare a list of struct bpf_ctx_arg_aux, aka 
>>> arg_info, for
>>> each member field of a struct_ops type.  "arg_info" will be assigned to
>>> "prog->aux->ctx_arg_info" of BPF struct_ops programs in
>>> check_struct_ops_btf_id() so that it can be used by btf_ctx_access() 
>>> later
>>> to set reg_type properly for the verifier.
>>
>> I looked at the high level. Some comments below.
>>
>>>
>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>>> ---
>>>   include/linux/bpf.h         |  17 ++++
>>>   kernel/bpf/bpf_struct_ops.c | 166 ++++++++++++++++++++++++++++++++++--
>>>   kernel/bpf/btf.c            |  14 +++
>>>   kernel/bpf/verifier.c       |   6 ++
>>>   4 files changed, 198 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index 9a2ee9456989..63ef5cbfd213 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -1709,6 +1709,19 @@ struct bpf_struct_ops {
>>>       struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
>>>   };
>>> +/* Every member of a struct_ops type has an instance even the member 
>>> is not
>>> + * an operator (function pointer). The "arg_info" field will be 
>>> assigned to
>>> + * prog->aux->arg_info of BPF struct_ops programs to provide the 
>>> argument
>>> + * information required by the verifier to verify the program.
>>> + *
>>> + * btf_ctx_access() will lookup prog->aux->arg_info to find the
>>> + * corresponding entry for an given argument.
>>> + */
>>> +struct bpf_struct_ops_member_arg_info {
>>> +    struct bpf_ctx_arg_aux *arg_info;
>>> +    u32 arg_info_cnt;
>>> +};
>>> +
>>>   struct bpf_struct_ops_desc {
>>>       struct bpf_struct_ops *st_ops;
>>> @@ -1716,6 +1729,10 @@ struct bpf_struct_ops_desc {
>>>       const struct btf_type *value_type;
>>>       u32 type_id;
>>>       u32 value_id;
>>> +
>>> +    /* Collection of argument information for each member */
>>> +    struct bpf_struct_ops_member_arg_info *member_arg_info;
>>> +    u32 member_arg_info_cnt;
>>>   };
>>>   enum bpf_struct_ops_state {
>>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>>> index f98f580de77a..313f6ceabcf4 100644
>>> --- a/kernel/bpf/bpf_struct_ops.c
>>> +++ b/kernel/bpf/bpf_struct_ops.c
>>> @@ -116,17 +116,148 @@ static bool is_valid_value_type(struct btf 
>>> *btf, s32 value_id,
>>>       return true;
>>>   }
>>> +#define MAYBE_NULL_SUFFIX "__nullable"
>>> +#define MAX_STUB_NAME 128
>>> +
>>> +static int match_nullable_suffix(const char *name)
>>> +{
>>> +    int suffix_len, len;
>>> +
>>> +    if (!name)
>>> +        return 0;
>>> +
>>> +    suffix_len = sizeof(MAYBE_NULL_SUFFIX) - 1;
>>> +    len = strlen(name);
>>> +    if (len < suffix_len)
>>> +        return 0;
>>> +
>>> +    return !strcmp(name + len - suffix_len, MAYBE_NULL_SUFFIX);
>>> +}
>>> +
>>> +/* Return the type info of a stub function, if it exists.
>>> + *
>>> + * The name of the stub function is made up of the name of the 
>>> struct_ops
>>> + * and the name of the function pointer member, separated by "__". For
>>> + * example, if the struct_ops is named "foo_ops" and the function 
>>> pointer
>>> + * member is named "bar", the stub function name would be 
>>> "foo_ops__bar".
>>> + */
>>> +static const  struct btf_type *
>>> +find_stub_func_proto(struct btf *btf, const char *st_op_name,
>>> +             const char *member_name)
>>> +{
>>> +    char stub_func_name[MAX_STUB_NAME];
>>> +    const struct btf_type *t, *func_proto;
>>> +    s32 btf_id;
>>> +
>>> +    snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s",
>>> +         st_op_name, member_name);
>>> +    btf_id = btf_find_by_name_kind(btf, stub_func_name, BTF_KIND_FUNC);
>>> +    if (btf_id < 0)
>>> +        return NULL;
>>> +    t = btf_type_by_id(btf, btf_id);
>>> +    if (!t)
>>> +        return NULL;
>>> +    func_proto = btf_type_by_id(btf, t->type);
>>> +
>>> +    return func_proto;
>>> +}
>>> +
>>> +/* Prepare argument info for every nullable argument of a member of a
>>> + * struct_ops type.
>>> + *
>>> + * Create and initialize a list of struct 
>>> bpf_struct_ops_member_arg_info
>>> + * according to type info of the arguments of the stub functions. 
>>> (Check
>>> + * kCFI for more information about stub functions.)
>>> + *
>>> + * Each member in the struct_ops type has a struct
>>> + * bpf_struct_ops_member_arg_info to provide an array of struct
>>> + * bpf_ctx_arg_aux, which in turn provides the information that used 
>>> by the
>>> + * verifier to check the arguments of the BPF struct_ops program 
>>> assigned
>>> + * to the member. Here, we only care about the arguments that are 
>>> marked as
>>> + * __nullable.
>>> + *
>>> + * The array of struct bpf_ctx_arg_aux is eventually assigned to
>>> + * prog->aux->ctx_arg_info of BPF struct_ops programs and passed to the
>>> + * verifier. (See check_struct_ops_btf_id())
>>> + */
>>> +static int prepare_arg_info(struct btf *btf,
>>> +                const char *st_ops_name,
>>> +                const char *member_name,
>>> +                struct bpf_struct_ops_member_arg_info *member_arg_info)
>>> +{
>>> +    const struct btf_type *stub_func_proto, *ptr_type;
>>> +    struct bpf_ctx_arg_aux *arg_info, *ai_buf = NULL;
>>> +    const struct btf_param *args;
>>> +    u32 nargs, arg_no = 0;
>>> +    const char *arg_name;
>>> +    s32 arg_btf_id;
>>> +
>>> +    stub_func_proto = find_stub_func_proto(btf, st_ops_name, 
>>> member_name);
>>> +    if (!stub_func_proto)
>>> +        return 0;
>>> +
>>> +    nargs = btf_type_vlen(stub_func_proto);
>>> +    if (nargs > MAX_BPF_FUNC_REG_ARGS) {
>>
>> Checking MAX_BPF_FUNC_REG_ARGS on the stub_func_proto may not be the 
>> right check. It should have been done on the origin func_proto (i.e. 
>> non-stub) when preparing the func_model in btf_distill_func_proto(). 
>> Please double check.
> 
> Got it!
> 
>>
>> If it needs to do sanity check on nargs of stub_func_proto, a better 
>> check is to ensure the narg of the stub_func_proto is the same as the 
>> orig_func_proto instead. This discrepancy probably should have been 
>> complained by the compiler already but does not harm to check (==) 
>> here in case the argument type is changed and a force cast is used 
>> (more below).
> 
> Yes, it should be complained by the compiler. However, we are not sure
> if the stub function found is the one assign to .cfi_stubs, or a random
> function happening to have a matched name.
> 
>>
>>> +        pr_warn("Cannot support #%u args in stub func %s_stub_%s\n",
>>> +            nargs, st_ops_name, member_name);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    ai_buf = kcalloc(nargs, sizeof(*ai_buf), GFP_KERNEL);
>>> +    if (!ai_buf)
>>> +        return -ENOMEM;
>>> +
>>> +    args = btf_params(stub_func_proto);
>>> +    for (arg_no = 0; arg_no < nargs; arg_no++) {
>>> +        /* Skip arguments that is not suffixed with
>>> +         * "__nullable".
>>> +         */
>>> +        arg_name = btf_name_by_offset(btf,
>>> +                          args[arg_no].name_off);
>>> +        if (!match_nullable_suffix(arg_name))
>>
>> I have a question/request.
>>
>> On top of tagging nullable, can we extend the ctx_arg_info idea here 
>> to allow changing the pointer type?
>>
>> In particular, take a stub function in bpf_tcp_ca.c:
>>
>> static u32 bpf_tcp_ca_ssthresh(struct tcp_sock *tp)
>> {
>>          return 0;
>> }
>>
>> Instead of the "struct sock *sk" argument as defined in the 
>> tcp_congestion_ops, the stub function uses "struct tcp_sock *tp'. If 
>> we can reuse the ctx_arg_info idea here, then it can remove the 
>> existing way of changing the pointer type from 
>> bpf_tcp_ca_is_valid_access.
> 
> Yes, it can be. We need a way to annotate the argument we want to
> override/promote its type, or generate ctx_arg_info for each
> argument of a stub function.

By the way, should I support it with the "__override"/"__promote" suffix
or any better one?

> 
>>
>>> +            continue;
>>> +
>>> +        /* Should be a pointer to struct, array, scalar, or enum */
>>> +        ptr_type = btf_type_resolve_ptr(btf, args[arg_no].type,
>>> +                        &arg_btf_id);
>>> +        if (!ptr_type ||
>>> +            (!btf_type_is_struct(ptr_type) &&
>>> +             !btf_type_is_array(ptr_type) &&
>>> +             !btf_type_is_scalar(ptr_type) &&
>>> +             !btf_is_any_enum(ptr_type))) {
>>> +            kfree(ai_buf);
>>> +            return -EINVAL;
>>> +        }
>>> +
>>> +        /* Fill the information of the new argument */
>>> +        arg_info = ai_buf + member_arg_info->arg_info_cnt++;
>>> +        arg_info->reg_type =
>>> +            PTR_TRUSTED | PTR_MAYBE_NULL | PTR_TO_BTF_ID;
>>> +        arg_info->btf_id = arg_btf_id;
>>> +        arg_info->btf = btf;
>>> +        arg_info->offset = arg_no * sizeof(u64);
>>
>> I think for the current struct_ops users should be fine to assume 
>> sizeof(u64). The current struct_ops users should only have 
>> pointer/scalar argument (meaning there is no struct passed-by-value 
>> argument).
>>
>> I still think it is better to get it correct for all trampoline 
>> supported argument here. Take a look at 720e6a435194 ("bpf: Allow 
>> struct argument in trampoline based programs") and get_ctx_arg_idx(). 
>> It may be 
> 
> I will add another function to translate arg_no to offset.
> 
>> easier (not sure if it is cleaner) to directly store the arg_no into 
>> arg_info here but arg_info only has offset now. Please think about 
>> what could be a cleaner way to do it.
> 
> The offset here is an offset from the start of a context where
> the argument is. The BPF opcode access an argument with it's offset, so
> we eventually need to translate the arg_no into the offset. The
> difference is translating here or in btf_ctx_access().
> 
> The question here is "what is OFFSET for?"  Without explanation, it
> is hard for people to tell what it is. Maybe, we need to change the its
> to ctx_offset or alike.
> 
>>
>>> +    }
>>> +
>>> +    if (!member_arg_info->arg_info_cnt)
>>> +        kfree(ai_buf);
>>> +    else
>>> +        member_arg_info->arg_info = ai_buf;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>>>                    struct btf *btf,
>>>                    struct bpf_verifier_log *log)
>>>   {
>>> +    struct bpf_struct_ops_member_arg_info *member_arg_info;
>>>       struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
>>>       const struct btf_member *member;
>>>       const struct btf_type *t;
>>>       s32 type_id, value_id;
>>>       char value_name[128];
>>>       const char *mname;
>>> -    int i;
>>> +    int i, err;
>>>       if (strlen(st_ops->name) + VALUE_PREFIX_LEN >=
>>>           sizeof(value_name)) {
>>> @@ -160,6 +291,11 @@ int bpf_struct_ops_desc_init(struct 
>>> bpf_struct_ops_desc *st_ops_desc,
>>>       if (!is_valid_value_type(btf, value_id, t, value_name))
>>>           return -EINVAL;
>>> +    member_arg_info = kcalloc(btf_type_vlen(t), 
>>> sizeof(*member_arg_info),
>>> +                  GFP_KERNEL);
>>> +    if (!member_arg_info)
>>> +        return -ENOMEM;
>>> +
>>>       for_each_member(i, t, member) {
>>>           const struct btf_type *func_proto;
>>> @@ -167,13 +303,15 @@ int bpf_struct_ops_desc_init(struct 
>>> bpf_struct_ops_desc *st_ops_desc,
>>>           if (!*mname) {
>>>               pr_warn("anon member in struct %s is not supported\n",
>>>                   st_ops->name);
>>> -            return -EOPNOTSUPP;
>>> +            err = -EOPNOTSUPP;
>>> +            goto errout;
>>>           }
>>>           if (__btf_member_bitfield_size(t, member)) {
>>>               pr_warn("bit field member %s in struct %s is not 
>>> supported\n",
>>>                   mname, st_ops->name);
>>> -            return -EOPNOTSUPP;
>>> +            err = -EOPNOTSUPP;
>>> +            goto errout;
>>>           }
>>>           func_proto = btf_type_resolve_func_ptr(btf,
>>> @@ -185,14 +323,24 @@ int bpf_struct_ops_desc_init(struct 
>>> bpf_struct_ops_desc *st_ops_desc,
>>>                          &st_ops->func_models[i])) {
>>>               pr_warn("Error in parsing func ptr %s in struct %s\n",
>>>                   mname, st_ops->name);
>>> -            return -EINVAL;
>>> +            err = -EINVAL;
>>> +            goto errout;
>>>           }
>>> +
>>> +        err = prepare_arg_info(btf, st_ops->name, mname,
>>> +                       member_arg_info + i);
>>> +        if (err)
>>> +            goto errout;
>>>       }
>>> +    st_ops_desc->member_arg_info = member_arg_info;
>>> +    st_ops_desc->member_arg_info_cnt = btf_type_vlen(t);
>>
>> It should be the same as btf_type_vlen(st_ops_desc->type). I would 
>> avoid this duplicated info within the same st_ops_desc.
> 
> Will remove it.
> 
>>
>>> +
>>>       if (st_ops->init(btf)) {
>>>           pr_warn("Error in init bpf_struct_ops %s\n",
>>>               st_ops->name);
>>> -        return -EINVAL;
>>> +        err = -EINVAL;
>>> +        goto errout;
>>>       }
>>>       st_ops_desc->type_id = type_id;
>>> @@ -201,6 +349,14 @@ int bpf_struct_ops_desc_init(struct 
>>> bpf_struct_ops_desc *st_ops_desc,
>>>       st_ops_desc->value_type = btf_type_by_id(btf, value_id);
>>>       return 0;
>>> +
>>> +errout:
>>> +    while (i > 0)
>>> +        kfree(member_arg_info[--i].arg_info);
>>> +    kfree(member_arg_info);
>>> +    st_ops_desc->member_arg_info = NULL;
>>> +
>>> +    return err;
>>>   }
>>>   static int bpf_struct_ops_map_get_next_key(struct bpf_map *map, 
>>> void *key,
>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>> index 20d2160b3db5..fd192f69eb78 100644
>>> --- a/kernel/bpf/btf.c
>>> +++ b/kernel/bpf/btf.c
>>> @@ -1699,6 +1699,20 @@ static void btf_free_struct_meta_tab(struct 
>>> btf *btf)
>>>   static void btf_free_struct_ops_tab(struct btf *btf)
>>>   {
>>>       struct btf_struct_ops_tab *tab = btf->struct_ops_tab;
>>> +    struct bpf_struct_ops_member_arg_info *ma_info;
>>> +    int i, j;
>>> +    u32 cnt;
>>> +
>>> +    if (tab)
>>> +        for (i = 0; i < tab->cnt; i++) {
>>> +            ma_info = tab->ops[i].member_arg_info;
>>> +            if (ma_info) {
>>> +                cnt = tab->ops[i].member_arg_info_cnt;
>>> +                for (j = 0; j < cnt; j++)
>>> +                    kfree(ma_info[j].arg_info);
>>> +            }
>>> +            kfree(ma_info);
>>> +        }
>>>       kfree(tab);
>>>       btf->struct_ops_tab = NULL;
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index cd4d780e5400..d1d1c2836bc2 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -20373,6 +20373,12 @@ static int check_struct_ops_btf_id(struct 
>>> bpf_verifier_env *env)
>>>           }
>>>       }
>>> +    /* btf_ctx_access() used this to provide argument type info */
>>> +    prog->aux->ctx_arg_info =
>>> +        st_ops_desc->member_arg_info[member_idx].arg_info;
>>> +    prog->aux->ctx_arg_info_size =
>>> +        st_ops_desc->member_arg_info[member_idx].arg_info_cnt;
>>> +
>>>       prog->aux->attach_func_proto = func_proto;
>>>       prog->aux->attach_func_name = mname;
>>>       env->ops = st_ops->verifier_ops;
>>

