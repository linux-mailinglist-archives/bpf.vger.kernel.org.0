Return-Path: <bpf+bounces-12631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EBE7CECCE
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 02:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496501C20E15
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 00:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BF19444;
	Thu, 19 Oct 2023 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7ev/Ssf"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750D9469
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 00:33:08 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B691115
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 17:33:07 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7db1f864bso88794127b3.3
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 17:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697675586; x=1698280386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ahxu/MOJZsBGN5uj/VNGyh2lXF6iZwJeHoQ/HsS0kaY=;
        b=G7ev/Ssfanme7YgexuooxW8EblPwgyy6aE81XsSDlWrvkZk5Ny75EL6mZjOZSyE1QV
         TqXpirz3JX9nJ+H/Vvf8LTb+8Dj8sUQHatEwb2WNL3sVByxE7rjaDeGOiE9BTVqYWOHb
         ebCE3xTkoIM+QkzAQLvPZbzxk+7IQgWfoYNGmFMFnn/jY9/icS8BebggydlDiw6wV+Gp
         z6Ik4n0JfINeOMbpkRoO7K9Z7pQyojJQc6hfXvkQAtEk4PpNO1cYMNDmsVya62YlCO84
         9Bq2eT3BOAFuIM55iS/009c/5McyOe6MvhhvEsna3y4hlhbQFZSS+rYqZUgqdKWtLmEY
         x5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697675586; x=1698280386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ahxu/MOJZsBGN5uj/VNGyh2lXF6iZwJeHoQ/HsS0kaY=;
        b=hQceCvif9Rygf5fGc13l+nPZiaHHccJ6df79S0ejsuQtkRqyBZDUKp4BLijWa0/1u7
         ycdh+QGywNjl2yApL3PunQAB0ekwXmRy4Di/YUHukqY2U1zSpChgQw1pvayQZfeqCyzE
         sCXVbX26+Z/aPwDAjL63BmhSXLaYL6k4YWpKUc24/MGIb6FWuhZC1ZD8F+YABIJ+t62b
         XrvRgAq9gH3PQWh9SW6TVP5erF9Sxi+d9kVOcnH3ruQg1S4dRWIDEL2P4YI0q6R29d82
         ajVGkaW8n05iNS2kVPfXUK3Z6FF32o1aEennywtbAy/Psn1oKMsctDUCOfp2RwT6Rtq0
         64AQ==
X-Gm-Message-State: AOJu0YwA3lGGo26awEmNROQhrB0gppRudvNKkuqHn/Givh2ev/EKB54K
	H8w/xEdp4tMBXAqn7lzaLRQ=
X-Google-Smtp-Source: AGHT+IE5+BIuSfLxD9BXUPdh8B97OAnwrYXj8qT1gEkbNBXtg7dIAhjd95zQ8XthNcahpy3+pV6QZg==
X-Received: by 2002:a81:4e42:0:b0:5a7:c935:6cf with SMTP id c63-20020a814e42000000b005a7c93506cfmr849604ywb.24.1697675586215;
        Wed, 18 Oct 2023 17:33:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:12b4:b461:6ecd:92b8? ([2600:1700:6cf8:1240:12b4:b461:6ecd:92b8])
        by smtp.gmail.com with ESMTPSA id h3-20020a816c03000000b005a7c969137csm1982223ywc.19.2023.10.18.17.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 17:33:05 -0700 (PDT)
Message-ID: <d3cdc18f-a692-4190-b816-4326fb7018ae@gmail.com>
Date: Wed, 18 Oct 2023 17:33:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 2/9] bpf: add struct_ops_tab to btf.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231017162306.176586-1-thinker.li@gmail.com>
 <20231017162306.176586-3-thinker.li@gmail.com>
 <f96c93dc-efde-5ec7-6a0e-3a9d166c844f@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <f96c93dc-efde-5ec7-6a0e-3a9d166c844f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/18/23 17:00, Martin KaFai Lau wrote:
> On 10/17/23 9:22 AM, thinker.li@gmail.com wrote:
>>   static const struct bpf_struct_ops *
>> -bpf_struct_ops_find_value(u32 value_id)
>> +bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
>>   {
>>       unsigned int i;
> 
> [ ... ]
> 
>> @@ -671,7 +672,7 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>       struct bpf_map *map;
>>       int ret;
>> -    st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
>> +    st_ops = 
>> bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id, btf_vmlinux);
> 
> This patch does not compile because of the argument ordering.
> 
> 
Looks like I split the patch wrongly! Will fix it!

