Return-Path: <bpf+bounces-30091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C898CA8ED
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 09:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9B8EB21471
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 07:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5881433C2;
	Tue, 21 May 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXnkkE4D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23917BA4
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276655; cv=none; b=ifzA/QLk1cr3kaYI0qW9CnEeDxe0xNLI3+kmDsS3UUYW40zErNje6vqsGOnZcYZyRw4SMszG0BO3jzStejPSa6SKdgYphsMIbFYZSjLujnyU5c+k4WAz3bRdR2gGkryCusuDkCD5I+eW3PTJruB59zES/76VWfoojlCoy5YA+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276655; c=relaxed/simple;
	bh=W3Rq2hI0Q/JHxdCv6fh/dRukXp4teV4eJt6HJQ9YsgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSbpE3gA5IdFCFOzFeERpvPgHSHbIps6CPqEBAku2zqMgp6TkRxTrw67Rbb9xNmtLpbtl2/DgmRak+82OciD89IV309A0TaM7K5PqopYB25amRFYRcj0Zj18YVkYxlBMKL3bxrTX3rDXpLL9cZ2zQoU4LyOvmCowBLsPdr59JWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXnkkE4D; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61bed5ce32fso33860767b3.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 00:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716276653; x=1716881453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6TbFLIRXmF635RXvgJFnKr/gmX1rtkb9kHouw2KUP4=;
        b=gXnkkE4Dt0tO3Xhq4DH9pzoTLh7aaPw1JywdyGFG5uvLmGQ0h5+fyPLwJEZMcrOq7C
         YQ9YllpZh4JEFpNdHUd5Vvb5fqMa04d80pr1ez5cBywN8JRuw1rBsuVNaPW4MVuL2tRF
         vtnSJrGMD3korUKH0nP46lw297K3Qa7mxIKSW+oJREnlNIQi81RXYcCPrU3tfS11mVbh
         PNzq+73ycq5NlbW+69DnBrj6wUgw8UmURrA06lfDdw9Bp8YfdG85iXEeOshmm3VzG4DT
         TpoxwONODS7MX5Jkx+E0FdOZ7IYf019LuE7XG4WdqWzoY5xsrTbyvl7+vSDVt1KGMCvZ
         F4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716276653; x=1716881453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6TbFLIRXmF635RXvgJFnKr/gmX1rtkb9kHouw2KUP4=;
        b=MVWpUtrvl7CVpmV4OMkEHa7DLaEEAp+P2uZnPd2drPgMVeyiomXpDPRlatjxxjeztm
         QqCw4ObsNcPq2SS1ZTxCvs1U/1fmJlGjPL2JFy3ay8CQ9PJWug1cqNw0gAerKyaQlLn5
         02Y3Wsqf75Dm+tQ1SPQV2B2JnIUWLrjp+0FLhw10VcccZg22CkBvHq8qenEwKfAt9luK
         ObseWuv16I+c/Qp6pBLHfoSwzIGDgQ/JvBlJMjJ1uEdivKehsQsOnOawa9lCqMbxzZWZ
         tvlAtibcg8WB/RSHTG/ZFspwY94rZwp2zRoIBLhRGy5mjaNh4KoUoNkW1LaEf4OUaBEf
         6wJw==
X-Forwarded-Encrypted: i=1; AJvYcCUxK/nCOdyZ7A9Z2E4/RNloxlj+8Ve5z15ylfdeNa7YIat8CCzFAxlEQq+82OQqDIMwr84jwQLZVsiw09PXD0oCt1Az
X-Gm-Message-State: AOJu0Yx338tuX8oPC8Ckdd40xMxeWNJvPQKltvh7DfB12+kzEMz12PMT
	GcYB6T+jzPh8PuZrknp7JKDSculNPVrtoWMqAPESlU/08wS/iki+
X-Google-Smtp-Source: AGHT+IFRGvQD6ypgRIIIhCcROSlnmF1Vss8rUtQlwr1evMu87DcgDwawqMCIKVogxR/OCHtofjTcEw==
X-Received: by 2002:a05:690c:6510:b0:618:66f3:818d with SMTP id 00721157ae682-622affc3a41mr354517137b3.16.1716276652743;
        Tue, 21 May 2024 00:30:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:b99a:bfaf:f0e4:a7d6? ([2600:1700:6cf8:1240:b99a:bfaf:f0e4:a7d6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-622d1aa09d6sm39817317b3.50.2024.05.21.00.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 00:30:52 -0700 (PDT)
Message-ID: <58dcc859-45c6-4493-8760-61e469ba2e69@gmail.com>
Date: Tue, 21 May 2024 00:30:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/7] bpf: enable detaching links of struct_ops
 objects.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240510002942.1253354-1-thinker.li@gmail.com>
 <20240510002942.1253354-3-thinker.li@gmail.com>
 <fcae9370-82ab-4c2f-90f5-e3a704f6d11c@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <fcae9370-82ab-4c2f-90f5-e3a704f6d11c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/20/24 18:22, Martin KaFai Lau wrote:
> On 5/9/24 5:29 PM, Kui-Feng Lee wrote:
>> +static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
>> +{
>> +    struct bpf_struct_ops_link *st_link = container_of(link, struct 
>> bpf_struct_ops_link, link);
>> +    struct bpf_struct_ops_map *st_map;
>> +    struct bpf_map *map;
>> +
>> +    mutex_lock(&update_mutex);
>> +
>> +    map = rcu_dereference_protected(st_link->map, 
>> lockdep_is_held(&update_mutex));
>> +    if (!map) {
>> +        mutex_unlock(&update_mutex);
>> +        return -EINVAL;
>> +    }
>> +    st_map = container_of(map, struct bpf_struct_ops_map, map);
>> +
>> +    st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
>> +
>> +    rcu_assign_pointer(st_link->map, NULL);
>> +    /* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
>> +     * bpf_map_inc() in bpf_struct_ops_map_link_update().
>> +     */
>> +    bpf_map_put(&st_map->map);
>> +
>> +    mutex_unlock(&update_mutex);
>> +
>> +    return 0;
>> +}
>> +
>>   static const struct bpf_link_ops bpf_struct_ops_map_lops = {
>>       .dealloc = bpf_struct_ops_map_link_dealloc,
>> +    .detach = bpf_struct_ops_map_link_detach,
>>       .show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
>>       .fill_link_info = bpf_struct_ops_map_link_fill_link_info,
>>       .update_map = bpf_struct_ops_map_link_update,
>> @@ -1176,13 +1208,19 @@ int bpf_struct_ops_link_create(union bpf_attr 
>> *attr)
>>       if (err)
>>           goto err_out;
>> +    /* Init link->map before calling reg() in case being detached
>> +     * immediately.
>> +     */
> 
> It is not obvious in the patch how this (immediate detach by subsystem 
> after reg) may work without race, so I think it is easier to ask.
> 
> [ I put back the err_out context at the end ]
> 
>> +    RCU_INIT_POINTER(link->map, map);
>> +
>>       err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, 
>> &link->link);
>>       if (err) {
>> +        RCU_INIT_POINTER(link->map, NULL);
> 
> In the bpf_struct_ops_map_link_detach() above, the update to link->map 
> is protected by the update_mutex. Could you explain how the link->map 
> update to NULL is safe here without holding the update_mutex?

If err is not zero, it means the subsystem rejects the pair of the
object and the link passing in. So, it has no reasonable to call
bpf_struct_ops_map_link_detach() for this link.

Does it make sense to you?

> 
>>           bpf_link_cleanup(&link_primer);
>> +        /* The link has been free by bpf_link_cleanup() */
>>           link = NULL;
>>           goto err_out;
>>       }

At this point, we don't change the content of the link anymore except
changing link->fd in bpf_link_settle(). So, it should be safe to call
bpf_struct_ops_map_link_detach() from the subsystem.

Should I explain it in a comment if you think it makes sense to you?

>> -    RCU_INIT_POINTER(link->map, map);
>>       return bpf_link_settle(&link_primer);
>>
> 
> err_out:
>      bpf_map_put(map);
>      kfree(link);
>      return err;
> }
> 
> 

