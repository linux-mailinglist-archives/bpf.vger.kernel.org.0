Return-Path: <bpf+bounces-22641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EA58625D5
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 16:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A1B1F22202
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 15:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7799746521;
	Sat, 24 Feb 2024 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKx1he1g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4218021
	for <bpf@vger.kernel.org>; Sat, 24 Feb 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708789392; cv=none; b=d86QHdqE+25OsONaAH74JLtaKTDKnlkvR9TePkMsxnccXRmKL9Ri2I1BoMey2+uNdyGNt4Rt4+ZNNjw62DnqiNHuA6VTMwT0Ok3nzg2PHYCiUp6P/hUdl1buQPzZAo1Uf4i+2emYsGHBNrB0H9Jl9ySnnN3oeTI7OqYmRAwRPkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708789392; c=relaxed/simple;
	bh=XDViFQqg0tFsiR4sO/KFC6SSBPB3A6gfG8V921ieHFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rF9Au4TJg/4fOasWreIOcXpZiLH7yNDRJ53QJ9Gi/Ga0H3dENjCZfxQXWaN7O/L4T/8Ez/VwDR9LY0E+nFd2t3QLRbPXSDPqDMJFVpWy3TG9aT6Zw/me32eHNzt1sg7i00m2Ll58rbKV5g5jaaAWS9zCUFoG/PJdaLkZCt9zIC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKx1he1g; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso1520888276.0
        for <bpf@vger.kernel.org>; Sat, 24 Feb 2024 07:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708789389; x=1709394189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kNNRBT2NlR3oORFbXvLNJj3DNqC6KUyr47Hfg+gvCHI=;
        b=bKx1he1g08ypfLAJ48bv8ZHcV0dyq0EKEKR0wVahuXWOMlUhxOx8o/Lvie5TmJV6Fy
         6gaIJoCG8/NajTEUwLKv4eIsgGNG8IpuubmlolwH1Y7eo9Q5Xox85rg1RwlIFlg3/kog
         70Aum3tUy+rjxweCmxe1Gcn4qBfyeYH0Ck4ktCV+iqeUwPd3AQ4AyXrDy4kvEKzgbWlb
         FogPqBJbYL+o+QBm9og1UThc0RqrJOldXuvxWLSI3ab7mFv/5agjYLHGlryMXr6uWyJO
         3ekEfNG1AdB2J6E1mkPJL4UEkDR+KMHKvgZOueVJPtI1TmVcigRHNmQIZ6rbmwlTC7rI
         TGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708789389; x=1709394189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNNRBT2NlR3oORFbXvLNJj3DNqC6KUyr47Hfg+gvCHI=;
        b=O7LM8x14PVYhc7lUwOUhsDh37Zq/8UA47+BF0b+8mi5/75tMTJm5TS4jH+jGoYmQjp
         DlUyN3ioCOWYkRP3H8jo2vxQ0ygYV2ianQ5/2pcGu+WXV0nLtypB07oLhg/tdds2ig/Z
         UgE2t3yQCfiM6gRLYMWjCurLnWTT0QoNkMoU9Tsg1J134wwvemK200Zb4HEvy5nK+cVH
         tjoKnvgnHMxYiueklvP+krHG5Gz4Q3oN81Y3C/M+r10+/aLIEuWtHe7RBRa0pFVWOBk6
         OFCCk+kohjO4njrZM7pXY6E3Sx7s0W2DN1X4rzaFKUNoIVCET+mpP+Us8kCJ5i/Qmin/
         2Cxg==
X-Forwarded-Encrypted: i=1; AJvYcCXGMbRTnwAIp/oYLvrRIN1QBnL3W5I2TJbV0FHvjrwPZCgsaovzFvRqnTnA1kpPTTzJUykqTJ0XJYUOsbGZThFB/l/u
X-Gm-Message-State: AOJu0YyQIPh1OSH52vTBXnaa1vEZqHPp0UmGMT6gvmDbKIfSS+bSDv/D
	+yYIRTvXtjOZdSlScDuoZyaWCTgQeV2GvqovPpkSHREDDLqkeUpU
X-Google-Smtp-Source: AGHT+IFbjMWf08Jw+gryUDH6tDvh3+vHx7uK/wQCS3IkX+vLjQEPB6VGVDd4nExVmAnDdYa8LMvO6w==
X-Received: by 2002:a25:5842:0:b0:dbd:7383:d155 with SMTP id m63-20020a255842000000b00dbd7383d155mr1960426ybb.0.1708789389523;
        Sat, 24 Feb 2024 07:43:09 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:e361:62fc:8197:fe47? ([2600:1700:6cf8:1240:e361:62fc:8197:fe47])
        by smtp.gmail.com with ESMTPSA id x140-20020a25ce92000000b00dcc0cbb0aeesm249129ybe.27.2024.02.24.07.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 07:43:09 -0800 (PST)
Message-ID: <c3080ecb-abb0-4d47-a8f5-607e7082b1ef@gmail.com>
Date: Sat, 24 Feb 2024 07:43:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] bpf: struct_ops supports more than one
 page for trampolines.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240224030302.1500343-1-thinker.li@gmail.com>
 <20240224030302.1500343-3-thinker.li@gmail.com>
 <9d2dbd18-0d64-458a-8c95-9d549eabd3cf@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <9d2dbd18-0d64-458a-8c95-9d549eabd3cf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/23/24 22:19, Martin KaFai Lau wrote:
> On 2/23/24 7:03 PM, Kui-Feng Lee wrote:
>> +static void bpf_struct_ops_map_free_image(struct bpf_struct_ops_map 
>> *st_map)
>> +{
>> +    int i;
>> +    void *image;
>> +
>> +    bpf_jit_uncharge_modmem(PAGE_SIZE * st_map->image_pages_cnt);
>> +    for (i = 0; i < st_map->image_pages_cnt; i++) {
>> +        image = st_map->image_pages[i];
>> +        arch_free_bpf_trampoline(image, PAGE_SIZE);
>> +    }
>> +    st_map->image_pages_cnt = 0;
>> +}
>> +
> 
> [ ... ]
> 
>> @@ -133,7 +128,8 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, 
>> const union bpf_attr *kattr,
>>       err = bpf_struct_ops_prepare_trampoline(tlinks, link,
>>                           &st_ops->func_models[op_idx],
>>                           &dummy_ops_test_ret_function,
>> -                        image, image + PAGE_SIZE);
>> +                        &image, &image_off,
>> +                        true);
>>       if (err < 0)
>>           goto out;
>> @@ -147,6 +143,8 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, 
>> const union bpf_attr *kattr,
>>           err = -EFAULT;
>>   out:
>>       kfree(args);
>> +    if (image)
>> +        bpf_jit_uncharge_modmem(PAGE_SIZE);
>>       arch_free_bpf_trampoline(image, PAGE_SIZE);
> 
> It seems my last reply on v2 has crossed over with v3.
> 
> The bpf_struct_ops_free_trampoline() highlighted in my last reply should
> address your concern in v2 that the caller needs to remember
> the bpf_jit_uncharge_modmem here.
> 
> I think the trampoline alloc(aka prepare here)/free pair that you also
> suggested in v2 discussion is a nice match here and work as a
> charge+alloc and uncharge+free pair.

sure

> 
>>       if (link)
>>           bpf_link_put(&link->link);
> 

