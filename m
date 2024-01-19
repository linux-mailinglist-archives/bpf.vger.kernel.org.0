Return-Path: <bpf+bounces-19917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 292EF83305D
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F371F240CF
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 21:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D5758123;
	Fri, 19 Jan 2024 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVQPXhGv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBB157888
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700286; cv=none; b=ql3GINTQl7gmCiDlHBe1bhfDkcR7Ve3Vcaj1moafc+JrxRvU9YQqxfEPo6e/Bx0n8N13qIIU6kJUSQX5N+zHJfu9yPKywKFXCFr9yg9wgiWwHG779oJEk1egQhx7jNWptx0xdXK+QV7vDrcVuWnE+ow9BQ7zlrI94bftB1gPcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700286; c=relaxed/simple;
	bh=gRTXQsfR930Qe+AyNN7ehYOSE9agAjLkhi0xsggBDJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/P0VYlr2bsR/Owt4nleWmZOgulUm0bAa5MrFfgBZeUsMKbF6HGSnbw7PNF/aKWhgfcwa4FJRQhh8PUl5n13Lpe6j5btxrTZSgyebEKH5sViB7tvJ6lMv3O/TSEzqk8x4xdtng8zekk8JMU4J3kyRCvypahKzE7o/vxVbftQ3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVQPXhGv; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ec7a5a4b34so12720927b3.0
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 13:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705700284; x=1706305084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4WFjq8Srcu3d81oabYLoCw67aTdMIp9RA9ClN0/HCbY=;
        b=YVQPXhGv8VMudUSx7ifgHP2wWYrtlE9TkxzqjmlisW2WWc29uniNDsGkdP9NGa6C5R
         GH7q8EAjih4YgvoQy0Ymw5t6LVOGBD7Ib5HicDczU3jphA1CW0r87oQOdG52Af/UlgND
         YC4t+bCMtkXtwoj3dPU1+/iGaqvv70qqDbfsTXUW/L6axA8dugQqCIIbh5dXNDlXjDmP
         Ftfwi4YakBJmKvSDhp9vg72C5zhQ7tc3OLLj2Q8xfv97khjjbt7mTwjTcmu72zaecsgm
         EhvLBS4pzXvcLNZoL7FtLTvs3qp+oG2pzqilAhnxRajNkXttM1yicbk5Z7sF/dNv0fFH
         dbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705700284; x=1706305084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4WFjq8Srcu3d81oabYLoCw67aTdMIp9RA9ClN0/HCbY=;
        b=rZwoHtddrWl6IAH/oYTV+oW/4ssfmB15TWLVJNNjiDMs8btRY9Pyy0DeSbgW7DwmSu
         O5pgwZ/c68p89sjCQHXSumGRYQyOkVKmVZinvWW0ff1lMS/NLO0zj7/K5oajqWtf1gwh
         VN5Ta9D78IpUKtlmo8NbvCd7ZdPQXNMjqUfx1c64haHPzAp9GGB/zAIkNsf1U3eRJe0U
         NiNshhnZUAns7/RDsZmUEf7nTEjIfgNZ1gH1QVLm0B5B6xgu9/4K9AOwN7rroKdXwR5W
         lq4l4IskrqebErneQbDNAfVPh57hV+sYVu1svD8RtzIPgi+WXhtAF98uYoHgjIHFOyzt
         T7IA==
X-Gm-Message-State: AOJu0Yy9ZTZ2FxQgmjlodIWBSyeZDIQJGEvgsVRqqsNLM6qO+JbwASal
	C8QARlGJrJc43JzO30EeVq8v4nTbmLekthM34uu0146z+2YWXO+z
X-Google-Smtp-Source: AGHT+IGqyq+5RgM8jn2jZsLQYL2MLq5QVeDgjLJNBgsjN02W94zIHaJeltaV5MxIv+29tD/yxlqEbw==
X-Received: by 2002:a0d:ee82:0:b0:5ff:488c:7040 with SMTP id x124-20020a0dee82000000b005ff488c7040mr582623ywe.73.1705700284102;
        Fri, 19 Jan 2024 13:38:04 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:b170:5bda:247f:8c47? ([2600:1700:6cf8:1240:b170:5bda:247f:8c47])
        by smtp.gmail.com with ESMTPSA id s188-20020a8182c5000000b005ff55a7c21esm3341062ywf.32.2024.01.19.13.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 13:38:03 -0800 (PST)
Message-ID: <ead60c36-c405-44a6-bbb4-c359bc1b9886@gmail.com>
Date: Fri, 19 Jan 2024 13:38:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v16 06/14] bpf: pass btf object id in
 bpf_map_info.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20240118014930.1992551-1-thinker.li@gmail.com>
 <20240118014930.1992551-7-thinker.li@gmail.com>
 <a504ae9d-56d3-4c45-8f75-a0a77ba998cf@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <a504ae9d-56d3-4c45-8f75-a0a77ba998cf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/18/24 13:42, Martin KaFai Lau wrote:
> On 1/17/24 5:49 PM, thinker.li@gmail.com wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index ed4352f56d21..1e969d035b42 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1732,6 +1732,7 @@ struct bpf_dummy_ops {
>>   int bpf_struct_ops_test_run(struct bpf_prog *prog, const union 
>> bpf_attr *kattr,
>>                   union bpf_attr __user *uattr);
>>   #endif
>> +void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct 
>> bpf_map *map);
> 
> Does it need an implementation for !CONFIG_BPF_JIT?


yes

> 
> -- 
> 
> pw-bot: cr

