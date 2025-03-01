Return-Path: <bpf+bounces-52987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A5DA4AE0A
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 22:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D0116A7CD
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 21:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1122D1E98E3;
	Sat,  1 Mar 2025 21:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF+GPrMV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8BD1E7C1C
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740865508; cv=none; b=Z4FTWr0b31+pRymzzyKw9T9zpDKUW7Fl1MzmY1Xmawrn7EQa4+WJT1Em3X6ec/V8LKNFWeBgqsmEcGWvEwibzzDvQPnji9TKZes26P+vf2zEqOE5HxtYifWio/vhcEMkVJkJCHHjrHxQMsz+juILBxWKbc2M4SzMxC+qAC7D8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740865508; c=relaxed/simple;
	bh=TqMZ2o+xCdiLmuRdqZxsbX/Iuick2DqkdxsKofjNSOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bs78Qmyb2dqg78LxmdxtlqBmrb3/QocdHl0uU+AslLFp+2J0PpBMSo+29j1Be+fTOdQnHmnGvYDJl+KKlJQNEUWjYvOL74K4TNbIVmY21PVwlRO/qW3/S/nk8Jc8wtBm+xzy3e8CsEI25pTCxN2Dk8BUX/spcKrWW9NAxJC8xvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YF+GPrMV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43994ef3872so21036185e9.2
        for <bpf@vger.kernel.org>; Sat, 01 Mar 2025 13:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740865505; x=1741470305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ozG+qfi2vC8fQjqn0R02M1MLO6Pd3P6SeH7xMODPVp4=;
        b=YF+GPrMVvi4fJmR9lLPYTk6x8IofX82zS1roVzplHlN9BSc4OXJw89ssfkGuGr+prM
         aZOu6Js/0FKiKheetyXVHCKEZtCzeP8fJ1MghJEfy7h8btTrGMOuyE8yg8HxjjHR8z6Y
         kI0mpOwNgB/X/enU9hJ6hzEM7j5H0w6woBi/yswYT4ouwYd6eFaMD77FA6Ysh8pGTfll
         XjEPILSvcE2hdRfXZhGsVCBV3gSjpXZCn9rxxSVam/lB9EdzbR8HDThaSXQ9gUmxp8fC
         5xe9xdlk9XnmrCmk6HG2cMYfMuEyK2bQv4atyARCXh71qrP/lBydniiuq0zSta/WarnB
         k07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740865505; x=1741470305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozG+qfi2vC8fQjqn0R02M1MLO6Pd3P6SeH7xMODPVp4=;
        b=ZZkM9kZ2D/JoRgnQbWrIrVrxV2Xmi2JLqaHRnXzBp7ENtWcmPJWw8pSc8a3AgKZaL3
         F5S9vz+Y2xCvgh+3Mtp3IOgw8UrEuUAw61o24atg8NaHA0MPmJQNNaHxKxv5avaLhGKm
         +OHoevVMpHjFf7I2xiOkXSqy1tp1kP20xl4PElNPKwKymVC65OWb5QTFlY835qnFlIIf
         eKFEfgnY943i1jGe6b2vaibSuCc6QaNK2p1AKWxYfOwU27tyzNPTmOkO+TWZ6Bg+xOfc
         NnK7dFHhpM9d7Q9GC6RJLry+fRtTKBKUqEeqijiFpO2QzIlT/NS8ckHAVjNUdc8IL05w
         aLtA==
X-Forwarded-Encrypted: i=1; AJvYcCW4oxTaEcO2gnoiDOlutEXc32tNM6RJjgfESphtPcu3kwcSTfauWZYF/lPtqOdQu4eHuo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzezkN4yl38xmuTaLj6QmxNNLh7rneS1YKiPsIqSKs0xQXo744V
	+16DUrJjmEJ1ESXSW2u5YkvPa0x3KiE5PN7EaV6G8Fo/XdzS5L2r
X-Gm-Gg: ASbGncvxCO6Qc5sUD9HitFFj2g7GpwQLjijek+evEYcXEJK1Haz5ZVd6f8SgUimdw+t
	2URR5py9IEDfLQfNaAgvwwUwImdzd2EnA3wuX0JpRv1834vgUG7+oSgcIWsNHqKQ8lFIkN7tEzI
	eYHpY7q8X1lZDdnn322U6csOwTOtizOxq4cAlBbICULUdxejuMy1ac3GZ+YLVjZJ3lWEn0XrW4n
	ED9pJuFLCzqVXn4j6pcU6AjBf3rBbd1EXnQl6SoumPkNm+ZhoBD9/KdY/M2mEMdI8DPku0W9B40
	ZTX5x3/ilS/V1TDTdFNk2iqx57Nr+owBX0CqazlO7cTahMX7OFhpkDsQWIr0TPDQXs44gmjDgW3
	EGNBKfIy8jW3+ww5HI5oX9eC+1GXvn/SN/sT8Hhbe
X-Google-Smtp-Source: AGHT+IGAMIc65QeX4kNPSsgR3AH/V1fJvXXt3s56TDTUVuuwMINSBZAaAjtexI9HG8bKryNNV5HNVw==
X-Received: by 2002:a05:600c:6b65:b0:439:a6db:1824 with SMTP id 5b1f17b1804b1-43bb3c30d77mr19242075e9.16.1740865504941;
        Sat, 01 Mar 2025 13:45:04 -0800 (PST)
Received: from [192.168.0.18] (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a87sm9568107f8f.32.2025.03.01.13.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Mar 2025 13:45:04 -0800 (PST)
Message-ID: <00e385df-7ffc-4fd9-aad8-60dddef300af@gmail.com>
Date: Sat, 1 Mar 2025 21:45:03 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] libbpf: split bpf object load into
 prepare/load
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com>
 <20250228175255.254009-3-mykyta.yatsenko5@gmail.com>
 <5d7fb7202625b999cb77a1e010ba6f7099dbb561.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <5d7fb7202625b999cb77a1e010ba6f7099dbb561.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/03/2025 08:12, Eduard Zingerman wrote:
> On Fri, 2025-02-28 at 17:52 +0000, Mykyta Yatsenko wrote:
>
> [...]
>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 9ced1ce2334c..dd2f64903c3b 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -4858,7 +4858,7 @@ bool bpf_map__autocreate(const struct bpf_map *map)
>>   
>>   int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
>>   {
>> -	if (map->obj->state >= OBJ_LOADED)
>> +	if (map->obj->state >= OBJ_PREPARED)
>>   		return libbpf_err(-EBUSY);
> I looked through logic in patches #1 and #2 and changes look correct.
> Running tests under valgrind does not show issues with this feature.
> The only ask from my side is to consider doing ==/!= comparisons in
> cases like above. E.g. it seems that `map->obj->state != OBJ_OPENED`
> is a bit simpler to understand when reading condition above.
> Or maybe that's just me.
I'm not sure about this one.  >= or < checks for state relative to 
operand more
flexibly,for example `map->obj->state >= OBJ_PREPARED` is read as
"is the object in at least PREPARED state". Perhaps, if we add more states,
these >,< checks will not require any changes, while ==, != may.
I guess this also depends on what we actually want to check here, is it that
state at least PREPARED or the state is not initial OPENED.
Not a strong opinion, though, happy to flip code to ==, !=.
>   
>>   	map->autocreate = autocreate;
> [...]
>


