Return-Path: <bpf+bounces-26648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA548A365D
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D94D1F21C31
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 19:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7008A15098F;
	Fri, 12 Apr 2024 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itF3vIV1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7DB14F9FD
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712950160; cv=none; b=n87bgAdQV0aUemdxzzTNPVBKYXLfB8eLMX0yP8LJyKs4aHYLVQuqY5D1J9UFh2HcX3GnU1s/t/etnm+KanHsNFQE1FbZ9RMEoSEAKxT2DGA7IPx+RKYZV2I31KqOiwBdjKumA6rK1D2P8ZxwoMQWQyZPE9xRhHfB3cHSKSXu5ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712950160; c=relaxed/simple;
	bh=hQncIH58F6Owvx+DwWrnJUVaOnl1v2tD3johG0jx5kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Td36aqcWW2ecQK6gDsIVQTV10I9D+Qvc7f7arD4zTT0ZME1mMgOIrvXpTmNY7xYtT4BfXwrgmfss7H+AYSM4QoR9hYbVx2Zmi8VUB8PptqaPWGsDweaZzbrsl22tq7bxkpIPLSL7lyHn/dCGTOJCZ6ePQV76JUuYy6rUHvsdewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itF3vIV1; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c60bfb7b9bso323078b6e.3
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712950158; x=1713554958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Z9LmbNkiw0wlTLhlm75RqjLuw7W9dWpoA+jHHXFiL8=;
        b=itF3vIV17JQSN44vr05g31u5+mvJ6AdNCv6uS1P43qRasvNm1YkA2jJAWCoBlKoAdi
         YuEwNBDv52KokHlHXNf8M/XQJ5CEv4gGm0/Lg6+pPGgFHWB41V4RQLaj3e3v3ICB2EBI
         t3T8Shjh0M0/zcRTTeUy5/d4er2IY8lDT/VZth9JkR87gcd4P3bUEdwoXg8FL02NEs5s
         H5MSR0VUuWdHfl9Cjco9K5Ces3uzJEydeaC7vQ667SaM34WNfRRNrQqmOdx302+rYDiY
         6u6ylcJ7l7Rjn5Foi3hzAYkLf1EyMID4XiMiodKwEC8110wce5OWIEgo3mL2kGUxAeu2
         jM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712950158; x=1713554958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z9LmbNkiw0wlTLhlm75RqjLuw7W9dWpoA+jHHXFiL8=;
        b=wrwbCHJX9z7PzBtChHAK9Bk1jMiUIolECFr4cREgdckkRGQvF07uY9C2SUo2GPivi9
         If+2tJY8uX+t8rB5QzUwrLYPCDd+iR4BATcxNnpxReoio2QkAk05C/CNXgbrFG2c/DFm
         sAeKEf+l4TSv4pKWSwkmG/ir2SzjWJSrjIynfB2J7v/Vft6x5XdN58Yl6ecWcB6l7c07
         5R0sjY0Xni5xRMiWgX2RqRVctQNiDDpGwDv9MVQjRQfbCrqTKJG0uBOqtIuTZ50L185r
         EIrbt11oxlMiQOChXaiB8M1harjftlRtZrP7IjRbIzsI3L5w2cP+18HnCzVr2GyuCgOu
         3olg==
X-Forwarded-Encrypted: i=1; AJvYcCXu5Nu6InHkz1wXO1vBjStbK9+SlBPtaelod8WiJWC2qDLmjrft3eJYWpW/mfCbQi96JcItmFVlwNtNat9ZP2gMitQT
X-Gm-Message-State: AOJu0Yxh++KSje0T7Uy3rrVNQDroBqV7bS2kKo/tU+hIgSb+F+9knUYU
	armB0cbvQ9HGXV2A9xe+mRBDY60UE3ocI325Bjy/QQ25RgvdiIP6rEQ+aQ==
X-Google-Smtp-Source: AGHT+IGjfeIXtLzYpFsTiJFW2zsrYN47HFKtdP2LtyMvBMQnIEL4/rK0lGDlELTotNtcKUF2vOVcwQ==
X-Received: by 2002:a05:6808:984:b0:3c5:ee83:5205 with SMTP id a4-20020a056808098400b003c5ee835205mr3541380oic.37.1712950157681;
        Fri, 12 Apr 2024 12:29:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a1a1:7d97:cada:fa46? ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id cf1-20020a05680833c100b003c613140915sm704877oib.45.2024.04.12.12.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 12:29:17 -0700 (PDT)
Message-ID: <79781f94-11b2-452e-8a3e-0ac3cf455166@gmail.com>
Date: Fri, 12 Apr 2024 12:29:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 07/11] bpf: check_map_access() with the knowledge
 of arrays.
To: Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240410004150.2917641-1-thinker.li@gmail.com>
 <20240410004150.2917641-8-thinker.li@gmail.com>
 <c89a020a219dd2d6e781dce9986d46cbafd6499c.camel@gmail.com>
 <edea9980-f29f-4589-9a39-d92a715822ce@gmail.com>
 <520f62bee1e1a037c53dafabf4c4b71adee71cd2.camel@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <520f62bee1e1a037c53dafabf4c4b71adee71cd2.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/12/24 12:08, Eduard Zingerman wrote:
> On Fri, 2024-04-12 at 09:32 -0700, Kui-Feng Lee wrote:
>>
>> On 4/11/24 15:14, Eduard Zingerman wrote:
>>> On Tue, 2024-04-09 at 17:41 -0700, Kui-Feng Lee wrote:
>>> [...]
>>>
>>>> Any access to elements other than the first one would be rejected.
>>>
>>> I'm not sure this is true, could you please point me to a specific
>>> check in the code that enforces access to go to the first element?
>>> The check added in this patch only enforces correct alignment with
>>> array element start.
>>
>> I mean accessing to elements other than the first one would be rejected
>> if we don't have this patch.
> 
> Oh, I misunderstood the above statement then.
> The way I read it was: "after this patch access to elements other than
> the first one would be rejected". While this patch explicitly allows
> access to the subsequent array elements, hence confusion.
> Sorry for the noise.

I will rephrase it to make it more clear.

> 
>>
>> Before the change, it enforces correct alignment with the start of the
>> whole array.  Once the array feature is enabled, the "size" of struct
>> btf_field will be the size of entire array. In another word, accessing
>> to later elements, other than the first one, doesn't align with the
>> beginning of entire array, and will be rejected.
> 

