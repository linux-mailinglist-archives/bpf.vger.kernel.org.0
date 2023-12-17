Return-Path: <bpf+bounces-18112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC89D815DE7
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 08:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE611C218FD
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 07:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2D6185B;
	Sun, 17 Dec 2023 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g57WsWls"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A4F1849
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-77f37772ab6so192328485a.0
        for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 23:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702798515; x=1703403315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1Tjg41kg+n8ysxIY2dEFeIhjBUVrafz5o1kk3T6Ppo=;
        b=g57WsWlsx/mUuE8Dwbe8lpTFg7mxi0Suv8k3NEMMP+MkDyMPBcEmu4LRpYnRM/00G6
         VS6YpIjRCzkylAgRS9AQkbDRKCBIycn5/w58cHwbBN8UESGPwwQQKu3bKBYuFBlXWN8W
         glIwkj/U/WlnYB0BA1BPrveTZILXDMgAfqhOtQM3TrHUTX+d1mO+sjtmhwSuWVNn2SJL
         0wr89t/lKEmesNy75z9l4gOdMLvULEFXi9QvG8igHrNiJFHI6hdywMTJY4n9LlfLPyNe
         SvSEJyBp4DlG8Ezmmk0kNiVWT8Hs4vS+o7ISzmi+418B6J2kwaQ+H6OW+fb3s8SIuVHw
         vBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702798515; x=1703403315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1Tjg41kg+n8ysxIY2dEFeIhjBUVrafz5o1kk3T6Ppo=;
        b=SXmUenxJQSiqDYGbLzYoUw5yklROP5X/Wh42PMzXjoRpwTaoQhKZi7yNUN50g+Rwxj
         bvrPc39D/EBKMrW/aX6gQ3Oo1FiA3huDFevi+WZgiNax0mEgvqmhCGZvHby61iTn2aoO
         KwltNkCjBD4xjUP0azklb46JU38No/bZi0o8T4l0Uy3dcVQLK3S1GUU762HEc9Bdvns4
         jc784q9wckUmifuFoU4M53df/EEHgbLqt+yaU1N866DpcUIEELx5rZ2twHq3wJHwo9ek
         TL6amop0uyywYR/5hvlec6+C0zPXCg8/pKeBs5cgH93Jw0/YnHeka+gUsxySlPmkRZEj
         0SZA==
X-Gm-Message-State: AOJu0Yzvft2E0ltKettyRuNIGqAq2jmSCXzFYlqiox7sEuD+msgAIR4/
	/SFUnE8CT6QYB7/IkNC6z2M=
X-Google-Smtp-Source: AGHT+IGlMkpl8oCAZG6Cx0T4lIFjpl4kqL6GVTbYE+b9ZZXaWzbFDr1NNoG6UDIiA3WmrsWH+GjHIQ==
X-Received: by 2002:a05:620a:149c:b0:77e:fba3:81f6 with SMTP id w28-20020a05620a149c00b0077efba381f6mr16308701qkj.140.1702798515008;
        Sat, 16 Dec 2023 23:35:15 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf? ([2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf])
        by smtp.gmail.com with ESMTPSA id v126-20020a818584000000b005a7aef2c1c3sm7803512ywf.132.2023.12.16.23.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 23:35:14 -0800 (PST)
Message-ID: <1e1325ea-0eec-4d9f-95d9-fb5acd3f533d@gmail.com>
Date: Sat, 16 Dec 2023 23:35:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v13 14/14] bpf: pass btf object id in
 bpf_map_info.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-15-thinker.li@gmail.com>
 <df53e635-9ba2-4dac-8aad-4aa491e61f4d@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <df53e635-9ba2-4dac-8aad-4aa491e61f4d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/14/23 23:46, Martin KaFai Lau wrote:
> On 12/8/23 4:27 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Include btf object id (btf_obj_id) in bpf_map_info so that tools (ex:
>> bpftools struct_ops dump) know the correct btf from the kernel to look up
>> type information of struct_ops types.
>>
>> Since struct_ops types can be defined and registered in a module. The
>> type information of a struct_ops type are defined in the btf of the
>> module defining it.  The userspace tools need to know which btf is for
>> the module defining a struct_ops type.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/linux/bpf.h            | 1 +
>>   include/uapi/linux/bpf.h       | 2 +-
>>   kernel/bpf/bpf_struct_ops.c    | 7 +++++++
>>   kernel/bpf/syscall.c           | 2 ++
>>   tools/include/uapi/linux/bpf.h | 2 +-
>>   5 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index c881befa35f5..26103d8a4374 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3350,5 +3350,6 @@ struct bpf_struct_ops_##_name 
>> {                    \
>>   int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>>                    struct btf *btf,
>>                    struct bpf_verifier_log *log);
>> +void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct 
>> bpf_map *map);
> 
> This needs to be in the CONFIG_BPF_JIT guard also.

Got it!
> 
>>   #endif /* _LINUX_BPF_H */
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 5c3838a97554..716c6b28764d 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -6534,7 +6534,7 @@ struct bpf_map_info {
>>       __u32 btf_id;
>>       __u32 btf_key_type_id;
>>       __u32 btf_value_type_id;
>> -    __u32 :32;    /* alignment pad */
>> +    __u32 btf_obj_id;
> 
> may be "btf_vmlinux_id" to make it clear it is a kernel btf and should 
> be used with map_info->btf_vmlinux_value_type_id.

Sure!

> 
>>       __u64 map_extra;
>>   } __attribute__((aligned(8)));
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index fd26716fa0f9..51c0de75aa85 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -979,3 +979,10 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>>       kfree(link);
>>       return err;
>>   }
>> +
>> +void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct 
>> bpf_map *map)
>> +{
>> +    struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map 
>> *)map;
>> +
>> +    info->btf_obj_id = btf_obj_id(st_map->btf);
>> +}
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 4aced7e58904..3cab56cd02ff 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -4715,6 +4715,8 @@ static int bpf_map_get_info_by_fd(struct file 
>> *file,
>>           info.btf_value_type_id = map->btf_value_type_id;
>>       }
>>       info.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
>> +    if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS)
>> +        bpf_map_struct_ops_info_fill(&info, map);
> 
> This patch should be moved earlier in the set instead of after the 
> selftest patch 13. May be after patch 5 where st_map->btf is added.

No problem

> 
> and where is the test for this?

I use bpf_map_info as a part of calling bpf_map_create() while
testmod.ko is unloaded. It check if this change work as well.

> 
>>       if (bpf_map_is_offloaded(map)) {
>>           err = bpf_map_offload_info_fill(&info, map);
>> diff --git a/tools/include/uapi/linux/bpf.h 
>> b/tools/include/uapi/linux/bpf.h
>> index 5c3838a97554..716c6b28764d 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -6534,7 +6534,7 @@ struct bpf_map_info {
>>       __u32 btf_id;
>>       __u32 btf_key_type_id;
>>       __u32 btf_value_type_id;
>> -    __u32 :32;    /* alignment pad */
>> +    __u32 btf_obj_id;
>>       __u64 map_extra;
>>   } __attribute__((aligned(8)));
> 

