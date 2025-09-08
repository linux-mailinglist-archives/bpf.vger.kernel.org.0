Return-Path: <bpf+bounces-67712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 792C5B48FE7
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 15:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18F13A2A02
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 13:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD7230B516;
	Mon,  8 Sep 2025 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccyj2lpt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DFA30B50D
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338799; cv=none; b=VjdpGzu9/6sG0/c/3yTiKZMYh7crROk1JgcbG99V8N1mDPhMG2/4NbHH1QQ/hYygabhBFmLo6PfdKTObIWuyv3g8/vWeCGi85McFeHGly5ZeE7tkYfiSovAdtU3Rt2S3wz9F2XNk/XH33j9b/bmmrAkbR0lrG8T0XuIyEBm2R7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338799; c=relaxed/simple;
	bh=tpkTRZn1CZH53uAQSsO8aGgMb1pO75avWz7vHjuk5OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKT3LQQCgfOstHenl+u7t3bnj7pmEEgippZE9Vr00o6UUcTFG5hy53ax7Om6A5agr5vPbOg2dHq8kFuIKDgUOxt7QZENNOODqnE82iTh+rYaFJ1zLJSH7cjWwBeaezE3zCN3kdkceIycJL1qdzWlk4P8Wrpk3p8CAsKA54oWRAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccyj2lpt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so15739905e9.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 06:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757338796; x=1757943596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uqrsCdzjVS3ooys85N4dJRHhoJDNu3B3HQZ9/OF7uRQ=;
        b=ccyj2lptRPkH93oal1oR3GdY57MXtK5EvYnJ7KukBBInCbYQz6oAn9H3xQ26bR2Nbf
         5G0dTMU3R3Ura1gfXn7tM6ZWbLhE1V1WnZx5HqbfRnxWja6RsY59UnCnGtC2TrULIGQW
         crFXoea6rZ5wHVYI1g5Pqs0J8SMmbXzSYdlRbBGy0960h6VliCwhlYkdIHdMC1IfQ8dY
         fc71Okfs68hP9iMDxlfZ9P85UFf0sPfWqT4yTjsKtoKfxhvmgIemrBwUq/EE756BhEm9
         GQr/2lvm/wCrGZ+GW9QaVB4OrIY+aLsKzWx47LOHC0gixzz2gNiAivfsiOJ/9gErimBf
         mszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757338796; x=1757943596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqrsCdzjVS3ooys85N4dJRHhoJDNu3B3HQZ9/OF7uRQ=;
        b=adNWhSsLXZFXXSQ8yHah2+s7ZUsU779Hbd9nE1IXL4lYmlo0R106aJ2avMS89xffWT
         PdKeF77luCAxQoMYeesFply0cawYPJUjtFb/oTkgg5Fl+ebhwOFNVAxHqOBKIPdQfJbl
         Q38eLVArxXuTgK+k2ljEkYImA8CMslaz5dY2J2+QNgMaKb4i9ag0lGl0uEzgBDMK4IFC
         hIUrJrfqqT2WIdMe8wv789qXHpNtf7QtU8iCDy59jCuFGAjkJRo/R3YAGFkKktt3mfIZ
         cQQ10wo7fQGCUGBCOptorGxAsTyqeoKdtforlBN6hAOBZakB9pzHmNnDlner3Bc5fS2O
         J+sA==
X-Forwarded-Encrypted: i=1; AJvYcCWlCbPjRlQarrmujhDIvApOrPV3apuZIyxUPa+JdWbZxlmTFazG3hwWIAEnqGObKyQ2amQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPHM1SzQXTXQHVTKm5XBEDDaTCfbQHZNDMiDrKqGDW+vLB73b
	r4FTTMkPKwt6bfWQ/P4wM3PSjgAhDIy9yASVwr4xnLSkTJbynhJq6RJp
X-Gm-Gg: ASbGncvvTfCT4Lqg6b8rzXt6C8lYuy7D31F9v4oJaGv0y8DPMqnQm7foh0fTIdkBTtp
	sDMv+twR4aG6ycTc88OwRYUbs8174U8Jqh/sWkDCH7kFW0kP3X9+Rt87gL1SMSYRVE3J3koRjq+
	z9r/e9oIaMsyXfvI9rOmJzAUojFs++tSsZkDasNx2z3z7rU6C1EQL/xMM9gYrZ0dXEWLEhBpV96
	8N2euGU3II6OJSeYiJn+Nbb44+AbkHIR3/NMcuTNjr1yWmlo9qXIMpx+BGakWHWxcwISsqRuJEH
	UHOodC21ECVcnKaWACt8eEV7QtuY04AFgWswIfZCwmKGS7f65/Us3yHlF5vl0uze0z8BDT6Zsp7
	EUnZTtCUmeetcCPSnMAsiQjoHAU5pxbUl2DRxBWbTAkLfGg0fA7aj4UwjyUegkVw=
X-Google-Smtp-Source: AGHT+IEP9nck9EUugvXQvsJvQzh92C1PUoycsJxWr5a/JLcEdP1pkHxBLPSw/zu9LjDpOYyavZp/rA==
X-Received: by 2002:a05:6000:3108:b0:3d6:212b:9ae2 with SMTP id ffacd0b85a97d-3e643ff9652mr6373025f8f.63.1757338796094;
        Mon, 08 Sep 2025 06:39:56 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:3b00:aa66:6df5:e693? ([2620:10d:c092:500::5:c63f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e74ee8cf4asm1102082f8f.29.2025.09.08.06.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 06:39:55 -0700 (PDT)
Message-ID: <07b33757-7ba7-4ddf-a4a2-3e4fc77bfecd@gmail.com>
Date: Mon, 8 Sep 2025 14:39:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 5/7] bpf: extract map key pointer calculation
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
 <20250905164508.1489482-6-mykyta.yatsenko5@gmail.com>
 <453b077245a1d42385f00ae9a30916e88b07164b.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <453b077245a1d42385f00ae9a30916e88b07164b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/25 00:19, Eduard Zingerman wrote:
> On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
>
> [...]
>
>> +static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
> `arr_idx` is unused at every call site of this function.
> And even if it was used, why both set through pointer and return same value?
this function returns the pointer to map key; in case of array map, map 
key is an array index,
which is not stored anywhere in the map explicitly.
arr_idx is a container for the array map key, we need to pass it from 
the outside so that the
lifetime is long enough.
In case of hash map, we return the pointer to the actual key, stored in 
the map,
arr_idx is not needed then.
>
>> +{
>> +	if (map->map_type == BPF_MAP_TYPE_ARRAY) {
>> +		struct bpf_array *array = container_of(map, struct bpf_array, map);
>> +
>> +		*arr_idx = ((char *)value - array->value) / array->elem_size;
>> +		return arr_idx;
>> +	}
>> +	BUG_ON(map->map_type != BPF_MAP_TYPE_HASH && map->map_type != BPF_MAP_TYPE_LRU_HASH);
>> +	return (void *)value - round_up(map->key_size, 8);
>> +}
>> +
> [...]


