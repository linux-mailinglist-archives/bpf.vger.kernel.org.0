Return-Path: <bpf+bounces-10986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09D07B0D6B
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 22:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 254D2B20C49
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 20:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2BC4CFBF;
	Wed, 27 Sep 2023 20:27:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6971A589
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 20:27:43 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BB3139
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 13:27:41 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59f6441215dso105504447b3.2
        for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 13:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695846461; x=1696451261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1ygidtxEFNIIbolfDr3Tzu3aPhZd+NAaoQ+7f6fZew=;
        b=HSrN6vj/VYygRNMQFYTgCZjL4g00u5mTGt5pnPyOtq1Ec2TyHksvjYHq+D8+0w+RTE
         U4ZOy4eC8NnbFz8MjSkxh19EIyGAH1uTbR1FAZkpHK3yyRXWJOLeuh7N4zjFMmpuxTPD
         tswGe272ByPXlaScrKUcAErgATr6jRaq0ujLENKny4LrZdnjT15vcezbpkqRbzRn+aEs
         luVyQQrunv2gKskcprvPfoCM2VFmB1hZVuLffjwqs3kniC1QPvQ6noIT2cS9feytYqPG
         aEqPj+mLzpNwNwJM9YrBDv4KaCifBup6vh7JMFMvOyK2pYONeClXcmnH1aCyllZ2x59F
         JvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695846461; x=1696451261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1ygidtxEFNIIbolfDr3Tzu3aPhZd+NAaoQ+7f6fZew=;
        b=Jawpv/PPPgyXB1K5h1RexTOueSeyraIgbbSjZ/2djNsUmxbi8DGE9xP2ORTvyRjklw
         DOeTxgjpnwop32TfHsOX6PC+R7r5U3ZjeXsbBW88GmWgay1tEkZHE3tzdXYczHXnX2Ad
         WltA7JWlmkCl+YNMa0vMTJ3n26MBFz7a++eRCqcF8slwDUWKcD2Tgo+PBrMysXG/Ra22
         t2BPJ2azwkg4XABna6IpuQGlkNAV7U2oUUwQT3GQXqyDEENWhmjUUWqrhR4QAQ9NPkZw
         jjAozyeXD55G91C86PvQgHPio6ME8n7RNFuge/+qliR1lYZwKRPVNNGQjM28YCHPv8V4
         HyWg==
X-Gm-Message-State: AOJu0YxxPNSqQhaQuB6R2FLmBrpRQl++X5CYHSU/hhRAXiaL1QNB8mGG
	VfNQxRMI6AiBl+g1L67Dl/Q=
X-Google-Smtp-Source: AGHT+IGSLNbuBry63KTG+7UZVr05/QeX/eYHMgHlmdIdumdQygDCqqGqXJ3yu3oZwLLQUaInFsI5SA==
X-Received: by 2002:a0d:f503:0:b0:595:352f:2296 with SMTP id e3-20020a0df503000000b00595352f2296mr3232777ywf.25.1695846460884;
        Wed, 27 Sep 2023 13:27:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:bba7:b53:a4ac:5e9f? ([2600:1700:6cf8:1240:bba7:b53:a4ac:5e9f])
        by smtp.gmail.com with ESMTPSA id j72-20020a81924b000000b00594fff48796sm3950120ywg.75.2023.09.27.13.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 13:27:40 -0700 (PDT)
Message-ID: <4f2fa4e0-9f9a-0db9-648a-d109944d26ac@gmail.com>
Date: Wed, 27 Sep 2023 13:27:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC bpf-next v3 06/11] bpf: validate value_type
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-7-thinker.li@gmail.com>
 <cc51b582-3fbd-2236-b259-fe31aeb85d38@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <cc51b582-3fbd-2236-b259-fe31aeb85d38@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/25/23 18:03, Martin KaFai Lau wrote:
> On 9/20/23 8:59 AM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> A value_type should has three members; refcnt, state, and data.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   kernel/bpf/bpf_struct_ops.c | 75 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index ef8a1edec891..fb684d2ee99d 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -99,6 +99,79 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
>>   static const struct btf_type *module_type;
>> +static bool check_value_member(struct btf *btf,
>> +                   const struct btf_member *member,
>> +                   int index,
>> +                   const char *value_name,
>> +                   const char *name, const char *type_name,
>> +                   u16 kind)
>> +{
>> +    const char *mname, *mtname;
>> +    const struct btf_type *mt;
>> +    s32 mtype_id;
>> +
>> +    mname = btf_name_by_offset(btf, member->name_off);
>> +    if (!*mname) {
>> +        pr_warn("The member %d of %s should have a name\n",
>> +            index, value_name);
>> +        return false;
>> +    }
>> +    if (strcmp(mname, name)) {
>> +        pr_warn("The member %d of %s should be refcnt\n",
>> +            index, value_name);
>> +        return false;
>> +    }
>> +    mtype_id = member->type;
>> +    mt = btf_type_by_id(btf, mtype_id);
>> +    mtname = btf_name_by_offset(btf, mt->name_off);
>> +    if (!*mtname) {
>> +        pr_warn("The type of the member %d of %s should have a name\n",
>> +            index, value_name);
>> +        return false;
>> +    }
>> +    if (strcmp(mtname, type_name)) {
>> +        pr_warn("The type of the member %d of %s should be 
>> refcount_t\n",
>> +            index, value_name);
>> +        return false;
>> +    }
>> +    if (btf_kind(mt) != kind) {
>> +        pr_warn("The type of the member %d of %s should be %d\n",
>> +            index, value_name, btf_kind(mt));
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +static bool is_valid_value_type(struct btf *btf, s32 value_id,
>> +                const char *type_name, const char *value_name)
>> +{
>> +    const struct btf_member *member;
>> +    const struct btf_type *vt;
>> +
>> +    vt = btf_type_by_id(btf, value_id);
>> +    if (btf_vlen(vt) != 3) {
>> +        pr_warn("The number of %s's members should be 3, but we get 
>> %d\n",
>> +            value_name, btf_vlen(vt));
>> +        return false;
>> +    }
>> +    member = btf_type_member(vt);
>> +    if (!check_value_member(btf, member, 0, value_name,
>> +                "refcnt", "refcount_t", BTF_KIND_TYPEDEF))
>> +        return false;
>> +    member++;
>> +    if (!check_value_member(btf, member, 1, value_name,
>> +                "state", "bpf_struct_ops_state",
>> +                BTF_KIND_ENUM))
>> +        return false;
>> +    member++;
> 
> I wonder if giving BPF_STRUCT_OPS_COMMON_VALUE a proper struct will make 
> the validation cleaner. Like,
> 
> struct bpf_struct_ops_common {
>      refcount_t refcnt;
>      enum bpf_struct_ops_state state;
> };
> 
> wdyt?

It should work.

> 
>> +    if (!check_value_member(btf, member, 2, value_name,
>> +                "data", type_name, BTF_KIND_STRUCT))
> 
> Instead of checking name, I think this can directly check with the 
> st_ops->type.

Make sense

> 
>> +        return false;
>> +
>> +    return true;
>> +}
> 
> 

