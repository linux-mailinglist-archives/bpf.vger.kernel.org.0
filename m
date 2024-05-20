Return-Path: <bpf+bounces-30032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692BA8CA055
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 17:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0417DB2252E
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66708137901;
	Mon, 20 May 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+/j8Al+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF714C66
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220544; cv=none; b=d/sAEtTViPzc90WtmIs3NCnP+Z8ByH77XiZwuyypYuUNwytuhdE/BTXyXlkgu9tT+2wCJsP+5wHPKxwJ5wRp2zfYPoFqgQW0tNHuXd1GH0fDng5CW6XnifYYjAd1wVsC9jV0RxvZt/yvSorfAnZ+qUURMrMVtZSy8uAz/bJ3ZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220544; c=relaxed/simple;
	bh=4s14OWQnbS3xtOapnw+0ji/s0qovYGsilGlyYBLd30M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPwRPJ8i9C4zj0Lr2qvQhFib1wFX7fcXb2DQgnu5IC+4IDgeTzTRxam0ydD9jTFgmsC1NO79cBar5Gnrq0vXsOnGmLNbzjPY/vEFxEDqmVUI9LMbQ19sGrl3aWV1sJsWFD3j3o1kYFhSKjn7bAX+QuPl7FfCD+txiWERwKyq2hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+/j8Al+; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61be74097cbso26102757b3.1
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 08:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716220540; x=1716825340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3OOowWshV3E5sO3v3ItrGU1bxx9cpf/XUDL4CipccA=;
        b=f+/j8Al+OItNANoMK1Lim1RsXWcQnMb6gOQGVXxJfALfFpfig02tuc/yR2C1ljh0RY
         5D+aZYiRakl4oHdl2/tMzZNagt0qfZG6bzz5L/xM/MyrsaFjVQAV8W2Tz7a6rOiWUXW7
         MEwa1nOaCuzAddeRL9SGoznXOFEU9Wg4RbOKK+Nrk2YFwznNbAm50ByVE8kD5kswPh5v
         HtHBIpQ5pY2MnCblvlfgwdGjD0yee/AJZbdLPXGQbSSE3DZDtgBNbEm9YYojctt3TlKE
         s3iSwzdr7uwT7bSnklkPOw63EmZiXl0j8WnHnYXuLHz/HDdwN7AHG2JPZCznRFvEY5Rp
         t2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716220540; x=1716825340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3OOowWshV3E5sO3v3ItrGU1bxx9cpf/XUDL4CipccA=;
        b=L8et4ZjIvlqXbMsK3H6f2NAxR9j6+S+PNtBpz/WdA4FWi9e/3TkFcniNdvihKhfwQz
         r3oTNQhj+k1RUDUGg4xICXs/P744+rG7+ekrQngPJQc4hSnagmLUUqu5TMcm0CHqvmBI
         2ZKtxK96XMKJltL1p2/g+i7Rm8xcaYXezTIK+oNfgPGY+WS0AzpxjmHioV8wR1RR3pHT
         lIZkb5++J30k8JLiPOqZCXJSJ0cs1hO4DatZC2WCHPuS813sRtuTpr7gij9awQ5mlM8k
         quCBJhktkGANYKcVTGvdI1pAKWk3u1z+DrwHZsp5L9Mq9gDKGJYbMmoGSKDQMZysYRft
         AeYw==
X-Forwarded-Encrypted: i=1; AJvYcCW2wIOIRctA+W4yClniiSitDNNDjootl8dPcZnJHRuxsx8+MXDevq206ELSwz45Km6DneSm6mny14HGfu6c1jHrFY7n
X-Gm-Message-State: AOJu0Yy+AxAc/mSlKyvw9+9SBfeNsoqtPl4VZTuxjBkbKf9m8zpfmpzN
	UCp9Uxib86Q+4MfLjuu85D3FIaXyvXt68wwb6JLzaZYpzC5hNwwr
X-Google-Smtp-Source: AGHT+IELsTtAf297kO2J1pjUiv4rYQsyC+1eTHf8zdY0Si3ZU/6ihwOxyt8lqAdaQPfEbqqMFHmKvQ==
X-Received: by 2002:a0d:d7ce:0:b0:615:41a4:1a8a with SMTP id 00721157ae682-622affc63fcmr286764727b3.25.1716220540498;
        Mon, 20 May 2024 08:55:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:5722:6b8c:1f6:ee82? ([2600:1700:6cf8:1240:5722:6b8c:1f6:ee82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e273844sm49656487b3.74.2024.05.20.08.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 08:55:39 -0700 (PDT)
Message-ID: <549cb94f-5084-4f37-873d-0c128c9fcfc7@gmail.com>
Date: Mon, 20 May 2024 08:55:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 7/9] selftests/bpf: Test kptr arrays and kptrs
 in nested struct fields.
To: Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240510011312.1488046-1-thinker.li@gmail.com>
 <20240510011312.1488046-8-thinker.li@gmail.com>
 <d8f2fa21a9af5bfcb2acb1addecea435285c40e6.camel@gmail.com>
 <d2b9a943-ca26-404d-899a-c7651ce18a42@gmail.com>
 <62a51fcaddbf5eb8552a96e6a24ded83f8f9fa49.camel@gmail.com>
 <aa0cb7c8-f057-4f51-84c4-2cc9bc4e2edb@gmail.com>
 <a938837ff87adcdebaa58f612395dee06a0ea94a.camel@gmail.com>
 <52912c4f-219a-45d4-bb61-aaeadaf880c5@gmail.com>
 <e65e8c7d387312f4b13a1241376ad6b959f90bf7.camel@gmail.com>
 <f2d480de-a598-4771-9c72-722dba941e83@gmail.com>
 <cfe0145e88727ccb23be8728671649eb0ffb61ae.camel@gmail.com>
 <e3dcfcf4a40cb9ee2f5a7c84b1df59eec1992664.camel@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <e3dcfcf4a40cb9ee2f5a7c84b1df59eec1992664.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/10/24 16:29, Eduard Zingerman wrote:
> On Fri, 2024-05-10 at 16:17 -0700, Eduard Zingerman wrote:
>> On Fri, 2024-05-10 at 16:04 -0700, Kui-Feng Lee wrote:
>>
>> [...]
>>
>>
>>> I am not sure if I read you question correctly.
>>>
>>> For example, we have 3 correct info.
>>>
>>>    [info(offset=0x8), info(offset=0x10), info(offset=0x18)]
>>>
>>> And We have program that includes 3 instructions to access the offset
>>> 0x8, 0x10, and 0x18. (let's assume these load instructions would be
>>> checked against infos)
>>>
>>>    load r1, [0x8]
>>>    load r1, [0x10]
>>>    load r1, [0x18]
>>>
>>> If everything works as expected, the verifier would accept the program.
>>>
>>> Otherwise, like you said, all 3 info are pointing to the same offset.
>>>
>>>    [info(0offset=0x8), info(offset=0x8), info(offset=0x8)]
>>>
>>> Then, the later two instructions should fail the check.
> 
> Ok, what you are saying is possible not with load but with some kfunc
> that accepts a special pointer. E.g. when verifier.c:check_kfunc_args()
> expects an argument of KF_ARG_PTR_TO_LIST_HEAD type it would report an
> error if special field is not found.
> 
> So the structure of the test would be:
> - define a nested data structure with list head at some leafs;
> - in the BPF program call a kfunc accessing each of the list heads;
> - if all offsets are computed correctly there would be no load time error;
> - this is a load time test, no need to actually run the BPF program.
> 
> [...]

Yes, that is what I meant.
Sorry for replying late.

