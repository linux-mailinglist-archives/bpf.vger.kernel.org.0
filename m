Return-Path: <bpf+bounces-21454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DDC84D6D0
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 00:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6A31F23DF0
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 23:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7D0149E01;
	Wed,  7 Feb 2024 23:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV2lgB4F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60B200BA
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707350237; cv=none; b=GOGXbDusoD3fLTkDamNxNdEQG/70qo5Nlnez54Scx3/unVvPdNewyn+AaIHDuwI/aXG9W1EDxcDnQyl7ksaTXBEFXG5bmIpJ3uggc/5QEar/zJjev9qjHLjuZlCVwUT5v1QaQk12oYIAnQLIgANvpOV+PF3TGrexRO0lJfwHF2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707350237; c=relaxed/simple;
	bh=0/9DJApzAnMMh4hMZUXHFH3SwXNozjQ4XAHo30tLwyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euBTjG1PjBdjwTWtoLS/NtCJg1XSmzMtyy3Lk10Zb82/95y9sECAUSbOsSx1Pd5F19o95o0YFlUJJTVLtWeCt1cQ8+pUxJz1IRiL0KRwp40Jpok2sjypFwAc3Po9c9uH2FYt6y9z7+gVNpLS+9nWayKyQmJ/B9aa5DmG4LXMKcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mV2lgB4F; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6af9a988eso1045952276.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 15:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707350234; x=1707955034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XAYkn+urEb3l10XiW9bjJ2OUB8z5wrJm2GjYWiSItrc=;
        b=mV2lgB4FVPD/2KFM/FL1DT5k4wQRPnKsrseRwiPtNmyXjvXFhQqMSXur4MEm6W3H2g
         0MYgdUV4uTdXPwURW0uMtL7HHp0kLVg9lUByUTkHhwtf2tyXPKny6yPHFr/dlb13Ksw8
         kLwvMy2t7w00tTO9k3Q9tps70hzwNFCdlBf0sH6kCeEGEt9I/XaD1KBs0vPA3kRDVEoJ
         dcTZjJQicy38/Za3G9tS8wj2ygEOtVHgKROfRl8WllxE/8M0NK/uRYa+mNcHaRK/ETNi
         iGEFmAB7Dr6r0c3oBIUhTBdk5bRwd6YhqB/1ej8g9QLmVMw7YWE7/ZDCk5QeMbeSX7LI
         TwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707350234; x=1707955034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAYkn+urEb3l10XiW9bjJ2OUB8z5wrJm2GjYWiSItrc=;
        b=Liw9gjeJXxldwPBtvqyBOEdy91CWWQVGFur2BnxV6xGuHb+W/MscfzBxl/BPZRrB81
         n/wLY953JGncvc9oX7uOJiA4WIxzf9SmeeDdbRodnsv1LiPV3vOX7TnrYMSatrl9Bc0D
         9nXCuGVC8lLC8rWRQaI8BKL51b6bVuVmhsiLj0N56/YbygUClny/HmDwFYaJk80UKZrI
         W6+hFyV2FKCvbMbWkRlacLHO01zA2dQpGCMLkbdrFkrYzMA7VKwpFcYW/Qbt96bsLNjj
         Q5G4DL2ZdRBq9060Lng1hZeS05bQW/oG/nGkZ5CC/68xwaNoQShLmPpxIy9yQ8uemX7e
         WFvA==
X-Forwarded-Encrypted: i=1; AJvYcCWEg6/ihlAhmxCR/5HW4HZ36K62oPVPu8DBNvUyjC/v8tdlqX0+PT6ET1uluDgrZGwII9vSa8vy/YYsozsTJRpUeGM/
X-Gm-Message-State: AOJu0YxLrNQuVUBno/00pdAsC44T1eH0AfYD5Ewe1LAcTroxHCzfCrIi
	SX/ufyKm5PMaL40WyoXo4neT97nW2RGYdkMahOyfEZjfX5gIqziE
X-Google-Smtp-Source: AGHT+IEv8LcBuxso8R0GIDFQ/BH/6V2gq091G3k85ICzKqyFYIq4v4wXMcgD+XnjufQFZyWgCmtYeg==
X-Received: by 2002:a25:83c2:0:b0:dc6:b0ce:97d with SMTP id v2-20020a2583c2000000b00dc6b0ce097dmr6226229ybm.29.1707350233664;
        Wed, 07 Feb 2024 15:57:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOBWWVbYuhnpZKhvTahfpMZdn99nVSYyh2NADJwZnLzGSoUd5qsXpUQi6EoJVHOPBcnnwgoAjBy/OsUwrL109GTKg9IzdpetkM4Xhblj22UXSopY1X5C0MJvUTO5FXNzvnh6OKtMRVi9S1dVHBDGIjpCv+g9CSkiHqrUfUSPM1y4SKRpsiaGlQ20bZvghlUSFXBN205llLRVJ6bXJttTkM5IHE0AyP0pD0WjDDyAh6zST5VpAcxC+n5kFNAKJ9GGrFa0fW4wPCEbKXptjwow==
Received: from ?IPV6:2600:1700:6cf8:1240:50ba:b8f8:e3dd:4d24? ([2600:1700:6cf8:1240:50ba:b8f8:e3dd:4d24])
        by smtp.gmail.com with ESMTPSA id g18-20020a256b12000000b00dc6d51c8555sm407749ybc.17.2024.02.07.15.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 15:57:13 -0800 (PST)
Message-ID: <106aae3b-0a35-42d2-b3ef-b61da0212e7c@gmail.com>
Date: Wed, 7 Feb 2024 15:57:11 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 2/3] bpf: Create argument information for
 nullable arguments.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, davemarchevsky@meta.com,
 dvernet@meta.com
References: <20240206063833.2520479-1-thinker.li@gmail.com>
 <20240206063833.2520479-3-thinker.li@gmail.com>
 <1122b959-9b29-42e0-9931-63aced6298f9@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <1122b959-9b29-42e0-9931-63aced6298f9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/7/24 12:45, Martin KaFai Lau wrote:
> On 2/5/24 10:38 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Collect argument information from the type information of stub 
>> functions to
>> mark arguments of BPF struct_ops programs with PTR_MAYBE_NULL if they are
>> nullable.  A nullable argument is annotated by suffixing "__nullable" at
>> the argument name of stub function.
>>
>> For nullable arguments, this patch sets an arg_info to label their 
>> reg_type
>> with PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL. This makes the 
>> verifier
>> to check programs and ensure that they properly check the pointer. The
>> programs should check if the pointer is null before accessing the pointed
>> memory.
>>
>> The implementer of a struct_ops type should annotate the arguments 
>> that can
>> be null. The implementer should define a stub function (empty) as a
>> placeholder for each defined operator. The name of a stub function should
>> be in the pattern "<st_op_type>__<operator name>". For example, for
>> test_maybe_null of struct bpf_testmod_ops, it's stub function name should
>> be "bpf_testmod_ops__test_maybe_null". You mark an argument nullable by
>> suffixing the argument name with "__nullable" at the stub function.
>>
>> Since we already has stub functions for kCFI, we just reuse these stub
>> functions with the naming convention mentioned earlier. These stub
>> functions with the naming convention is only required if there are 
>> nullable
>> arguments to annotate. For functions having not nullable arguments, stub
>> functions are not necessary for the purpose of this patch.
>>
>> This patch will prepare a list of struct bpf_ctx_arg_aux, aka 
>> arg_info, for
>> each member field of a struct_ops type.  "arg_info" will be assigned to
>> "prog->aux->ctx_arg_info" of BPF struct_ops programs in
>> check_struct_ops_btf_id() so that it can be used by btf_ctx_access() 
>> later
>> to set reg_type properly for the verifier.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/linux/bpf.h         |  18 ++++
>>   kernel/bpf/bpf_struct_ops.c | 185 ++++++++++++++++++++++++++++++++++--
>>   kernel/bpf/btf.c            |  40 ++++++++
>>   kernel/bpf/verifier.c       |   6 ++
>>   4 files changed, 242 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 9a2ee9456989..29d9ec1c4fd9 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1709,6 +1709,19 @@ struct bpf_struct_ops {
>>       struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
>>   };
>> +/* Every member of a struct_ops type has an instance even the member 
>> is not
>> + * an operator (function pointer). The "arg_info" field will be 
>> assigned to
>> + * prog->aux->arg_info of BPF struct_ops programs to provide the 
>> argument
>> + * information required by the verifier to verify the program.
>> + *
>> + * btf_ctx_access() will lookup prog->aux->arg_info to find the
>> + * corresponding entry for an given argument.
>> + */
>> +struct bpf_struct_ops_member_arg_info {
> 
> nit. Shorten it to bpf_struct_ops_arg_info.

Sure!
> 
>> +    struct bpf_ctx_arg_aux *arg_info;
>> +    u32 arg_info_cnt;
>> +};
>> +
>>   struct bpf_struct_ops_desc {
>>       struct bpf_struct_ops *st_ops;
>> @@ -1716,6 +1729,9 @@ struct bpf_struct_ops_desc {
>>       const struct btf_type *value_type;
>>       u32 type_id;
>>       u32 value_id;
>> +
>> +    /* Collection of argument information for each member */
>> +    struct bpf_struct_ops_member_arg_info *member_arg_info;
> 
> nit. Same here on the struct's field name. s/member_arg_info/arg_info(s)/.
> 

Sure!
>>   };
>>   enum bpf_struct_ops_state {
>> @@ -2500,6 +2516,8 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog 
>> *prog,
>>   int bpf_prog_test_run_nf(struct bpf_prog *prog,
>>                const union bpf_attr *kattr,
>>                union bpf_attr __user *uattr);
>> +int btf_ctx_arg_offset(struct btf *btf, const struct btf_type 
>> *func_proto,
>> +               u32 arg_no);
> 
> This should be in btf.h. Its implementation is also in btf.c in this patch.

Got it! I just followed btf_ctx_access().
But, moving to btf.h make sense.

> 
>>   bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>>               const struct bpf_prog *prog,
>>               struct bpf_insn_access_aux *info);
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index f98f580de77a..0db7e12a9244 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -116,17 +116,162 @@ static bool is_valid_value_type(struct btf 
>> *btf, s32 value_id,
>>       return true;
>>   }
>> +#define MAYBE_NULL_SUFFIX "__nullable"
>> +#define MAX_STUB_NAME 128
>> +
>> +static bool match_nullable_suffix(const char *name)
>> +{
>> +    int suffix_len, len;
>> +
>> +    if (!name)
>> +        return false;
>> +
>> +    suffix_len = sizeof(MAYBE_NULL_SUFFIX) - 1;
>> +    len = strlen(name);
>> +    if (len <= suffix_len)
> 
> This function looks almost the same as __kfunc_param_match_suffix. How 
> about refactor __kfunc_param_match_suffix (to btf.c?) and resue here to 
> avoid duplicating code?

Sure!

> 
> The only difference is between the "<=" here and the "<" there. I think 
> the "<=" here may be a little better.
> 
>> +        return false;
>> +
>> +    return !strcmp(name + len - suffix_len, MAYBE_NULL_SUFFIX);
>> +}
>> +
>> +/* Return the type info of a stub function, if it exists.
>> + *
>> + * The name of the stub function is made up of the name of the 
>> struct_ops
>> + * and the name of the function pointer member, separated by "__". For
>> + * example, if the struct_ops is named "foo_ops" and the function 
>> pointer
>> + * member is named "bar", the stub function name would be 
>> "foo_ops__bar".
>> + */
>> +static const  struct btf_type *
> 
> I think there is double spaces.
> 
>> +find_stub_func_proto(struct btf *btf, const char *st_op_name,
>> +             const char *member_name)
>> +{
>> +    char stub_func_name[MAX_STUB_NAME];
>> +    const struct btf_type *t, *func_proto;
>> +    s32 btf_id;
>> +
>> +    snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s",
>> +         st_op_name, member_name);
> 
> check truncated case.


Sure!

> 
>> +    btf_id = btf_find_by_name_kind(btf, stub_func_name, BTF_KIND_FUNC);
>> +    if (btf_id < 0)
>> +        return NULL;
>> +    t = btf_type_by_id(btf, btf_id);
>> +    if (!t)
>> +        return NULL;
>> +    func_proto = btf_type_by_id(btf, t->type);
> 
> nit. directly "return btf_type_by_id(btf, t->type);"
> 
>> +
>> +    return func_proto;
>> +}
>> +
>> +/* Prepare argument info for every nullable argument of a member of a
>> + * struct_ops type.
>> + *
>> + * Initialize a struct bpf_struct_ops_member_arg_info according to type
>> + * info of the arguments of a stub function. (Check kCFI for more
>> + * information about stub functions.)
>> + *
>> + * Each member in the struct_ops type has a struct
>> + * bpf_struct_ops_member_arg_info to provide an array of struct
>> + * bpf_ctx_arg_aux, which in turn provides the information that used 
>> by the
>> + * verifier to check the arguments of the BPF struct_ops program 
>> assigned
>> + * to the member. Here, we only care about the arguments that are 
>> marked as
>> + * __nullable.
>> + *
>> + * The array of struct bpf_ctx_arg_aux is eventually assigned to
>> + * prog->aux->ctx_arg_info of BPF struct_ops programs and passed to the
>> + * verifier. (See check_struct_ops_btf_id())
>> + *
>> + * member_arg_info->arg_info will be the list of struct 
>> bpf_ctx_arg_aux if
>> + * success. If fails, it will be kept untouched.
>> + */
>> +static int prepare_arg_info(struct btf *btf,
>> +                const char *st_ops_name,
>> +                const char *member_name,
>> +                const struct btf_type *func_proto,
>> +                struct bpf_struct_ops_member_arg_info *member_arg_info)
>> +{
>> +    const struct btf_type *stub_func_proto, *pointed_type;
>> +    const struct btf_param *args, *member_args;
>> +    struct bpf_ctx_arg_aux *arg_info, *ai_buf;
>> +    u32 nargs, arg_no, arg_info_cnt = 0;
>> +    const char *arg_name;
>> +    s32 arg_btf_id;
>> +    int offset;
>> +
>> +    stub_func_proto = find_stub_func_proto(btf, st_ops_name, 
>> member_name);
>> +    if (!stub_func_proto)
>> +        return 0;
>> +
>> +    args = btf_params(stub_func_proto);
>> +    nargs = btf_type_vlen(stub_func_proto);
>> +    if (nargs != btf_type_vlen(func_proto)) {
>> +        pr_warn("the number of arguments of the stub function %s__%s 
>> does not match the number of arguments of the member %s of struct %s\n",
>> +            st_ops_name, member_name, member_name, st_ops_name);
>> +        return -EINVAL;
>> +    }
>> +
>> +    member_args = btf_params(func_proto);
> 
> hmm... the "member_args" naming makes me come back here a few times to 
> figure out "member_args" is the original func_proto or the stub func_proto.
> 
> How about using a similar convention like you did for func_proto: 
> "func_proto" means the original func_proto and "stub_func_proto" means 
> the stub func_proto,
> 
> so something like:
> 
> "args" means the args of original func_proto and
> "stub_args" means the args of the stub_func_proto ?


ok! I will rename all member_*.

> 
>> +
>> +    ai_buf = kcalloc(nargs, sizeof(*ai_buf), GFP_KERNEL);
> 
> hmm... instead of ai, lets use a fuller name here like arg_info_buf.
> 
>> +    if (!ai_buf)
>> +        return -ENOMEM;
>> +
>> +    for (arg_no = 0; arg_no < nargs; arg_no++) {
>> +        /* Skip arguments that is not suffixed with
>> +         * "__nullable".
>> +         */
>> +        arg_name = btf_name_by_offset(btf,
>> +                          args[arg_no].name_off);
>> +        if (!match_nullable_suffix(arg_name))
>> +            continue;
>> +
>> +        /* Should be a pointer to struct, array, scalar, or enum */
>> +        pointed_type = btf_type_resolve_ptr(btf,
>> +                            member_args[arg_no].type,
>> +                            &arg_btf_id);
>> +        if (!pointed_type ||
>> +            !btf_type_is_struct(pointed_type))
>> +            goto err_out;
>> +
>> +        offset = btf_ctx_arg_offset(btf, stub_func_proto, arg_no);
> 
> The original "func_proto" should be used here.

Right!

> 
>> +        if (offset < 0)
>> +            goto err_out;
>> +
>> +        /* Fill the information of the new argument */
>> +        arg_info = ai_buf + arg_info_cnt++;
> 
> nit. just init arg_info = arg_info_buf and advance the arg_info++ and 
> arg_info_cnt++ after the offset assignment below.
> 
>> +        arg_info->reg_type =
>> +            PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
>> +        arg_info->btf_id = arg_btf_id;
>> +        arg_info->btf = btf;
>> +        arg_info->offset = offset;
>> +    }
>> +
>> +    if (arg_info_cnt) {
>> +        member_arg_info->arg_info = ai_buf;
>> +        member_arg_info->arg_info_cnt = arg_info_cnt;
>> +    } else {
>> +        kfree(ai_buf);
>> +    }
>> +
>> +    return 0;
>> +
>> +err_out:
>> +    kfree(ai_buf);
>> +
>> +    return -EINVAL;
>> +}
>> +
>>   int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>>                    struct btf *btf,
>>                    struct bpf_verifier_log *log)
>>   {
>> +    struct bpf_struct_ops_member_arg_info *member_arg_info;
>>       struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
>>       const struct btf_member *member;
>>       const struct btf_type *t;
>>       s32 type_id, value_id;
>>       char value_name[128];
>>       const char *mname;
>> -    int i;
>> +    int i, err;
>>       if (strlen(st_ops->name) + VALUE_PREFIX_LEN >=
>>           sizeof(value_name)) {
>> @@ -160,6 +305,11 @@ int bpf_struct_ops_desc_init(struct 
>> bpf_struct_ops_desc *st_ops_desc,
>>       if (!is_valid_value_type(btf, value_id, t, value_name))
>>           return -EINVAL;
>> +    member_arg_info = kcalloc(btf_type_vlen(t), 
>> sizeof(*member_arg_info),
>> +                  GFP_KERNEL);
>> +    if (!member_arg_info)
>> +        return -ENOMEM;
>> +
>>       for_each_member(i, t, member) {
>>           const struct btf_type *func_proto;
>> @@ -167,32 +317,44 @@ int bpf_struct_ops_desc_init(struct 
>> bpf_struct_ops_desc *st_ops_desc,
>>           if (!*mname) {
>>               pr_warn("anon member in struct %s is not supported\n",
>>                   st_ops->name);
>> -            return -EOPNOTSUPP;
>> +            err = -EOPNOTSUPP;
>> +            goto errout;
>>           }
>>           if (__btf_member_bitfield_size(t, member)) {
>>               pr_warn("bit field member %s in struct %s is not 
>> supported\n",
>>                   mname, st_ops->name);
>> -            return -EOPNOTSUPP;
>> +            err = -EOPNOTSUPP;
>> +            goto errout;
>>           }
>>           func_proto = btf_type_resolve_func_ptr(btf,
>>                                  member->type,
>>                                  NULL);
>> -        if (func_proto &&
>> -            btf_distill_func_proto(log, btf,
>> +        if (!func_proto)
>> +            continue;
>> +
>> +        if (btf_distill_func_proto(log, btf,
>>                          func_proto, mname,
>>                          &st_ops->func_models[i])) {
>>               pr_warn("Error in parsing func ptr %s in struct %s\n",
>>                   mname, st_ops->name);
>> -            return -EINVAL;
>> +            err = -EINVAL;
>> +            goto errout;
>>           }
>> +
>> +        err = prepare_arg_info(btf, st_ops->name, mname,
>> +                       func_proto,
>> +                       member_arg_info + i);
>> +        if (err)
>> +            goto errout;
>>       }
>>       if (st_ops->init(btf)) {
>>           pr_warn("Error in init bpf_struct_ops %s\n",
>>               st_ops->name);
>> -        return -EINVAL;
>> +        err = -EINVAL;
>> +        goto errout;
>>       }
>>       st_ops_desc->type_id = type_id;
>> @@ -200,7 +362,16 @@ int bpf_struct_ops_desc_init(struct 
>> bpf_struct_ops_desc *st_ops_desc,
>>       st_ops_desc->value_id = value_id;
>>       st_ops_desc->value_type = btf_type_by_id(btf, value_id);
>> +    st_ops_desc->member_arg_info = member_arg_info;
>> +
>>       return 0;
>> +
>> +errout:
>> +    while (i > 0)
>> +        kfree(member_arg_info[--i].arg_info);
>> +    kfree(member_arg_info);
>> +
>> +    return err;
>>   }
>>   static int bpf_struct_ops_map_get_next_key(struct bpf_map *map, void 
>> *key,
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index aa72674114af..6df390ade2c0 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -1699,6 +1699,21 @@ static void btf_free_struct_meta_tab(struct btf 
>> *btf)
>>   static void btf_free_struct_ops_tab(struct btf *btf)
>>   {
>>       struct btf_struct_ops_tab *tab = btf->struct_ops_tab;
>> +    struct bpf_struct_ops_member_arg_info *ma_info;
> 
> Please try to stay consistent with the variable naming in the same 
> patch. The other of this patch is using the "member_arg_info" name.
> 
> May be just use "arg_infos" everywhere.

I will rename all member_*.

> 
>> +    int i, j;
>> +
>> +    if (!tab)
>> +        return;
>> +
>> +    for (i = 0; i < tab->cnt; i++) {
>> +        ma_info = tab->ops[i].member_arg_info;
>> +        if (!ma_info)
>> +            continue;
>> +
>> +        for (j = 0; j < btf_type_vlen(tab->ops[i].type); j++)
>> +            kfree(ma_info[j].arg_info);
>> +        kfree(ma_info);
> 
> 
> Lets refactor this part out to "bpf_struct_ops_desc_release(struct 
> bpf_struct_ops_desc *)" such that it can be reused with the "errout" 
> path of the "bpf_struct_ops_desc_init()" above.

Sure!

> 
> 
>> +    }
>>       kfree(tab);
>>       btf->struct_ops_tab = NULL;
>> @@ -6130,6 +6145,31 @@ static bool prog_args_trusted(const struct 
>> bpf_prog *prog)
>>       }
>>   }
>> +int btf_ctx_arg_offset(struct btf *btf, const struct btf_type 
>> *func_proto,
>> +               u32 arg_no)
>> +{
>> +    const struct btf_param *args;
>> +    const struct btf_type *t;
>> +    int off = 0, i;
>> +    u32 sz, nargs;
>> +
>> +    nargs = btf_type_vlen(func_proto);
>> +    /* It is the return value if arg_no == nargs */
>> +    if (arg_no > nargs)
>> +        return -EINVAL;
>> +
>> +    args = btf_params(func_proto);
>> +    for (i = 0; i < arg_no; i++) {
>> +        t = btf_type_by_id(btf, args[i].type);
>> +        t = btf_resolve_size(btf, t, &sz);
>> +        if (IS_ERR(t))
>> +            return -EINVAL;
>> +        off += roundup(sz, 8);
>> +    }
>> +
>> +    return off;
>> +}
>> +
>>   bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>>               const struct bpf_prog *prog,
>>               struct bpf_insn_access_aux *info)
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 64fa188d00ad..8d7e761cda0d 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20433,6 +20433,12 @@ static int check_struct_ops_btf_id(struct 
>> bpf_verifier_env *env)
>>           }
>>       }
>> +    /* btf_ctx_access() used this to provide argument type info */
>> +    prog->aux->ctx_arg_info =
>> +        st_ops_desc->member_arg_info[member_idx].arg_info;
>> +    prog->aux->ctx_arg_info_size =
>> +        st_ops_desc->member_arg_info[member_idx].arg_info_cnt;
>> +
>>       prog->aux->attach_func_proto = func_proto;
>>       prog->aux->attach_func_name = mname;
>>       env->ops = st_ops->verifier_ops;
> 

