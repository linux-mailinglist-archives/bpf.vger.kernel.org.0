Return-Path: <bpf+bounces-15623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B3D7F3BC2
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 03:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EAD9B21865
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 02:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DD58483;
	Wed, 22 Nov 2023 02:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApmhNuy4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BB4E7
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 18:27:09 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6ce353df504so3638375a34.3
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 18:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700620029; x=1701224829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0k6Q3GV0fFEkiP7axCcds/gzz8zyXxtXEtWHY0HaUA=;
        b=ApmhNuy4rxX/dJqjdbHEEQFEdNyFJ+oc5a/sMocuZxsRUQUIpB0EjwcBroH+bmIOgq
         XRSzHtKSbV7yDCqiq5JbThKMIYwvyYNtOu0W3T4j44g2MaU//PpVYwbUefAEnVp4Vlgi
         s5NQjh/586IzA39QK9ZNY9xyau9MieJscl5R7XhmKLf/4iVTH+B2wrCDLHhinkMWTq/6
         o/2+0+i63GnPfrcIjXYHSsdJFf9m/kIMpyVAXOaKzuREKiKZz89YomknMi5lMRVUWRdh
         59NwYMKsYCQWzoT+B7F3Kr/pvsV8j//QFUdr9Pn+HJWGnKjq/uDBudDm0A0/DcLG/Rgb
         iJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700620029; x=1701224829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0k6Q3GV0fFEkiP7axCcds/gzz8zyXxtXEtWHY0HaUA=;
        b=lUD50MIiFwk7TW0WT9BvIOx5A6FxsE//Vs9cHNW6Hk2Np5STGL6l2TV6i29SPwXBn/
         53YRw5SshQorL8gPF2FWm5tvf68hUD6LWA4m+pE9Vlz7rWqaOhmGOa9wCCooulOzAIKX
         qKZah70oTCHtjaADeA7RnPFQ1OG8Pge/l+mCY9GFnyCqJq5DrlT/+3WDEuI/iQgJMqx8
         GGoVbOblVlImNcPhC2OeTpXXzO3jztyEK+xoU17llQ7PAa7D/bjSiiUg8jeodiaGG/wv
         XRsKNAkmtTh6aXE5avA8mtD5CngIZTCba3c5aggl1eR33shvVUSPDT1Yls4l9ftQTsKG
         XqMw==
X-Gm-Message-State: AOJu0YycYD64InFIRqH9SyIN47gKlQWUkCxRz3BwOHyt0+r2lLt+FNXH
	avmi2uUuzxHGW7PQggZke6E=
X-Google-Smtp-Source: AGHT+IF2x0MQows7i2em9aUUjGaNz56n2DyhkCjq2SHha/nURiPTuPVp/w1fuQM7L42zlkeSqmGWdw==
X-Received: by 2002:a05:6830:4b1:b0:6b9:9cc0:537f with SMTP id l17-20020a05683004b100b006b99cc0537fmr1303502otd.33.1700620029043;
        Tue, 21 Nov 2023 18:27:09 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:ef40:7e31:9d9d:46c4? ([2600:1700:6cf8:1240:ef40:7e31:9d9d:46c4])
        by smtp.gmail.com with ESMTPSA id z18-20020a9d7a52000000b006d7e1d3dedasm441885otm.32.2023.11.21.18.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 18:27:08 -0800 (PST)
Message-ID: <3fd2dca9-1ae4-42a9-b374-9472a3b26bde@gmail.com>
Date: Tue, 21 Nov 2023 18:27:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v11 04/13] bpf: add struct_ops_tab to btf.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-5-thinker.li@gmail.com>
 <84874366-e0bd-14ea-755b-c6151f1e28b1@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <84874366-e0bd-14ea-755b-c6151f1e28b1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/9/23 17:35, Martin KaFai Lau wrote:
> On 11/6/23 12:12 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Maintain a registry of registered struct_ops types in the per-btf 
>> (module)
>> struct_ops_tab. This registry allows for easy lookup of struct_ops types
>> that are registered by a specific module.
>>
>> It is a preparation work for supporting kernel module struct_ops in a
>> latter patch. Each struct_ops will be registered under its own kernel
>> module btf and will be stored in the newly added btf->struct_ops_tab. The
>> bpf verifier and bpf syscall (e.g. prog and map cmd) can find the
>> struct_ops and its btf type/size/id... information from
>> btf->struct_ops_tab.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/linux/btf.h |  8 +++++
>>   kernel/bpf/btf.c    | 83 +++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 91 insertions(+)
>>
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index c2231c64d60b..07ee6740e06a 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -572,4 +572,12 @@ static inline bool btf_type_is_struct_ptr(struct 
>> btf *btf, const struct btf_type
>>       return btf_type_is_struct(t);
>>   }
>> +#ifdef CONFIG_BPF_JIT
> 
> There are many new ifdef CONFIG_BPF_JIT in btf.{h,c}. Could it be 
> avoided? For example, having an empty bpf_struct_ops_desc_init() for the 
> not CONFIG_BPF_JIT case, is it enough?

It is enough. However, it also leaves dead code.
Anyway, I just removed these conditions as you said.

> 
> 
>> +struct bpf_struct_ops_desc;
>> +
>> +const struct bpf_struct_ops_desc *
>> +btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
>> +
>> +#endif /* CONFIG_BPF_JIT */
>> +
>>   #endif
> 

