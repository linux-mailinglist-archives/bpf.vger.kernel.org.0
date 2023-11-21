Return-Path: <bpf+bounces-15604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9697F3A7E
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 00:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16698B21906
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 23:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D702BB00;
	Tue, 21 Nov 2023 23:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8vYkh7T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CC69F
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 15:53:10 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1ef370c2e12so3575948fac.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 15:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700610790; x=1701215590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZpB+FK2LvDSXiXkQautuBmX/ZjDpuIE1iuU2q7dUd2w=;
        b=b8vYkh7T66/A70gxwtnfAxKpN4hP+FF/agYZozu2QHUQXwGx4eTvToTYci7vc+dcNZ
         dOgUIjaq+x8LlmBtcF1DFNXDwjG50I+KieYDTbrTEJjKEFmW/rQjhUpWoES9NAY7yBea
         p+YgwZo2jYwKGiUT+7YxWJEUeOq28vdtxqRmd1nFKRqeRR1Z3/v8WFlHxwpQ50WSmiOh
         YLaxgvbHP6CFvJG9SZAKsE+aBZJxzG7RiKa6TatsLLLxMPg+iHuSsOm9p+wAaRpxy5ev
         SQUuPizAkhVVG7PBAL+feaeE8omUzlXNidPdNCdEGi2jlM8VqMcw/okR83IAxnfQ8CwS
         z42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700610790; x=1701215590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpB+FK2LvDSXiXkQautuBmX/ZjDpuIE1iuU2q7dUd2w=;
        b=Lodty7hxiS0pWLD4v6Rg6l4cQx8qBbSqr3sMOp6MzAyefPi/vP6VxPtwCyVW7xiCdT
         HQ4cn2Pu79QColKEctX9MoJKizR78l1YlsSAStmq8hGqZvTR7iKr/J7SsEoduUbe9EIx
         P2NDM5ZwQ8U4zUHKgLVrcvkftbyV9/GWsjis2O7ZERhzcV47fn+MeQlAeT71TyBG8CAC
         /EYT7mVgnyiAwTaHTT1PxfAV4kTBqQQU52JGhJtg+ulD3gWcdEZBPK3jBO1VqjIHGPK1
         DaLOBB6dd4Fr8u0jMNMjwf3GWbRheD68qHX3SNYBx776nxhsc0v1hskzuqP5037rFEcw
         9E6w==
X-Gm-Message-State: AOJu0YxlBmz5/De8KdTiBRj1e3P+2yNDx0bSk5rSrtX6u++rKUqsLwlK
	NouC/WY40osCj7+82IPmm70=
X-Google-Smtp-Source: AGHT+IE2+b1XUyxuKlvm0FLszanYzYvqj8+BYBBMdcVAkqKou9ofqrqYj6l8XgUmhTaxotVrIgGSqg==
X-Received: by 2002:a05:6870:bacf:b0:1f9:5155:b135 with SMTP id js15-20020a056870bacf00b001f95155b135mr1120480oab.39.1700610790121;
        Tue, 21 Nov 2023 15:53:10 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:ef40:7e31:9d9d:46c4? ([2600:1700:6cf8:1240:ef40:7e31:9d9d:46c4])
        by smtp.gmail.com with ESMTPSA id h26-20020a056830165a00b006ce46212341sm1700421otr.54.2023.11.21.15.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 15:53:09 -0800 (PST)
Message-ID: <c63d2021-a10e-436e-ac67-c5c9f6a095d4@gmail.com>
Date: Tue, 21 Nov 2023 15:53:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v11 01/13] bpf: refactory struct_ops type
 initialization to a function.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-2-thinker.li@gmail.com>
 <eec08936-e001-5d7b-17b4-5074db0754f2@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <eec08936-e001-5d7b-17b4-5074db0754f2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/9/23 17:11, Martin KaFai Lau wrote:
> On 11/6/23 12:12 PM, thinker.li@gmail.com wrote:
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index db6176fb64dc..627cf1ea840a 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -110,102 +110,111 @@ const struct bpf_prog_ops 
>> bpf_struct_ops_prog_ops = {
>>   static const struct btf_type *module_type;
>> -void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
>> +static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
>> +                    struct btf *btf,
>> +                    struct bpf_verifier_log *log)
>>   {
>> -    s32 type_id, value_id, module_id;
>>       const struct btf_member *member;
>> -    struct bpf_struct_ops *st_ops;
>>       const struct btf_type *t;
>> +    s32 type_id, value_id;
>>       char value_name[128];
>>       const char *mname;
>> -    u32 i, j;
>> +    int i;
>> -    /* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
>> -#define BPF_STRUCT_OPS_TYPE(_name) BTF_TYPE_EMIT(struct 
>> bpf_struct_ops_##_name);
>> -#include "bpf_struct_ops_types.h"
>> -#undef BPF_STRUCT_OPS_TYPE
>> +    if (strlen(st_ops->name) + VALUE_PREFIX_LEN >=
>> +        sizeof(value_name)) {
>> +        pr_warn("struct_ops name %s is too long\n",
>> +            st_ops->name);
>> +        return;
>> +    }
>> +    sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
>> -    module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
>> -    if (module_id < 0) {
>> -        pr_warn("Cannot find struct module in btf_vmlinux\n");
>> +    value_id = btf_find_by_name_kind(btf, value_name,
>> +                     BTF_KIND_STRUCT);
>> +    if (value_id < 0) {
>> +        pr_warn("Cannot find struct %s in btf_vmlinux\n",
>> +            value_name);
> 
> "btf_vmlinux" needs to change in the pr_warn(). It should be btf->name 
> but that may need a helper function to return btf->name.

Right! I will add a helper function to return the name.

> 
>>           return;
>>       }
>> -    module_type = btf_type_by_id(btf, module_id);
>> -    for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
>> -        st_ops = bpf_struct_ops[i];
>> +    type_id = btf_find_by_name_kind(btf, st_ops->name,
>> +                    BTF_KIND_STRUCT);
>> +    if (type_id < 0) {
>> +        pr_warn("Cannot find struct %s in btf_vmlinux\n",
> 
> Same here.

