Return-Path: <bpf+bounces-18048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9AB815353
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 23:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00361C24590
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 22:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA8313B12B;
	Fri, 15 Dec 2023 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNFEBAJr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF88F13B121
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-db3a09e96daso952650276.3
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 14:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702678226; x=1703283026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KLQjNrptjlWFOh1vg3VvAI1Ht/hhjafhjaDeeMvFLb8=;
        b=WNFEBAJrR8Whzfh+gH+vxtcidobgZfd1rEb8u+BJExr1fm4sJAzTwvEvpnPmTYxeXy
         fRuWrY20xGQ8PSTlRy+tuel270juhlH+dmB0I1U8S4BFMELL/PiYRA4t/mhAO5odbNVF
         xjRUuKu+KgIjs6dDMpQvwmxLv+H4zeKpXKo6MB794HLMNTUgiGeffOoR56lzgmLHCDlF
         A+6IbQ9dtpaJzNLCVmJnirjHYvYLRMXl3V25GQToTt5ip6uBZ2AYi7tGjiDw3oI2nroA
         Nz0vt05LHb8c5wa+zFEB5V4Ggn8OvSflb0IS3czyyQzmyjoX4l6qSB1fimmrRJ78WF7k
         oqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702678226; x=1703283026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLQjNrptjlWFOh1vg3VvAI1Ht/hhjafhjaDeeMvFLb8=;
        b=Ros75sODoaOS8A+QV4PM2x+yyO/+JU4ceDNfP3/QsXR6hb4X+0/yl8K1AzPzn89rB4
         eMHAyJ9FxXdTGov4BdpWam+QaSojzeFEa4mybG1MMZjbA95zjcMggPP8b0eS4DORxHgw
         8QiMfesItbrz5u2S5csCTDJTSDaZpsa4vbUlZV/4pTBSxlDPiPhVMRhXKPTu/zwkkYIh
         eDYAIr9oFi/vxkUQWW1cPR2iOu+SZeZf5yGSMxuSNQxrOV+cHfRMRvyE5GfyfxVWe+wF
         oSZOMiZ9TA+p8omb1bIOgp2E1kxuWrmfLgMML0DJh+m4227dmAwCRyYZMxJp/p48EZXj
         6eKQ==
X-Gm-Message-State: AOJu0YzYE/99FmnTJQNCuRujfYA8DcOd3D9uRpdmils/MT4oZ9a4HdBZ
	mZDdz88rILkGRcheD9gleEc=
X-Google-Smtp-Source: AGHT+IEY5XRrDXyIrbYcm2jNGNPUaihMcXVVegemTHtxZfHMAco4riXAObvZmnzR7rGZHNxDJjKy5w==
X-Received: by 2002:a25:ec06:0:b0:dbc:fca9:a1a8 with SMTP id j6-20020a25ec06000000b00dbcfca9a1a8mr1142245ybh.58.1702678225638;
        Fri, 15 Dec 2023 14:10:25 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:cff8:4904:6a61:98b6? ([2600:1700:6cf8:1240:cff8:4904:6a61:98b6])
        by smtp.gmail.com with ESMTPSA id 9-20020a5b0109000000b00dbcbfccfcc5sm2641124ybx.5.2023.12.15.14.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 14:10:25 -0800 (PST)
Message-ID: <e2222287-6438-4de7-a747-9e04c5fd3f55@gmail.com>
Date: Fri, 15 Dec 2023 14:10:23 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v13 07/14] bpf: pass attached BTF to the
 bpf_struct_ops subsystem
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-8-thinker.li@gmail.com>
 <4e6bff53-a219-4c69-a662-75e097100c9c@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <4e6bff53-a219-4c69-a662-75e097100c9c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/14/23 18:44, Martin KaFai Lau wrote:
> On 12/8/23 4:27 PM, thinker.li@gmail.com wrote:
>> @@ -681,15 +682,30 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>       struct bpf_struct_ops_map *st_map;
>>       const struct btf_type *t, *vt;
>>       struct bpf_map *map;
>> +    struct btf *btf;
>>       int ret;
>> -    st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, 
>> attr->btf_vmlinux_value_type_id);
>> -    if (!st_ops_desc)
>> -        return ERR_PTR(-ENOTSUPP);
>> +    if (attr->value_type_btf_obj_fd) {
>> +        /* The map holds btf for its whole life time. */
>> +        btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
>> +        if (IS_ERR(btf))
>> +            return ERR_PTR(PTR_ERR(btf));
> 
>              return ERR_CAST(btf);
> 
> It needs to check for btf_is_module:
> 
>          if (!btf_is_module(btf)) {
>              btf_put(btf);
>              return ERR_PTR(-EINVAL);
>          }

Even btf is btf_vmlinux the kernel's btf, it still works.
Although libbpf pass 0 as the value of value_type_btf_obj_fd for
btf_vmlinux now, it should be OK for a user space loader to
pass a fd of btf_vmlinux.

WDYT?

> 
>> +    } else {
>> +        btf = btf_vmlinux;
>> +        btf_get(btf);
> 
> btf_vmlinux could be NULL or a ERR_PTR? Lets take this chance to use 
> bpf_get_btf_vmlinux():
>          btf = bpf_get_btf_vmlinux();
>              if (IS_ERR(btf))
>                      return ERR_CAST(btf);

Sure!

> 
> Going back to patch 4. This should be the only case that btf will be 
> NULL or ERR_PTR?
> 
> will continue the remaining review later tonight.
> 
> pw-bot: cr
> 
>> +    }
>> +
>> +    st_ops_desc = bpf_struct_ops_find_value(btf, 
>> attr->btf_vmlinux_value_type_id);
>> +    if (!st_ops_desc) {
>> +        ret = -ENOTSUPP;
>> +        goto errout;
>> +    }
>>       vt = st_ops_desc->value_type;
>> -    if (attr->value_size != vt->size)
>> -        return ERR_PTR(-EINVAL);
>> +    if (attr->value_size != vt->size) {
>> +        ret = -EINVAL;
>> +        goto errout;
>> +    }
>>       t = st_ops_desc->type;
> 

