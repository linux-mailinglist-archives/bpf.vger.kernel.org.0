Return-Path: <bpf+bounces-55709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C598FA85411
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 08:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93E49A3860
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 06:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F92027CCC7;
	Fri, 11 Apr 2025 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3Ko+ygb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDCA367
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744352652; cv=none; b=axyZaxxiiE2INTH8m4cz/zizsAcZBatYPRwVwAgf0rgpbb0UqFb2fqXVik4Y3IVKDpLHYC11BRq6jXa0EAN9ToZVHti5XrZ0PQ6WayQ7lFNRFRJdAa5ljKZIaGoqAgJYR1psZ9PquJ7EmvcAdDJQFu3SFMnf+Xgg11vVO52Y2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744352652; c=relaxed/simple;
	bh=ZlFYH6cDfcH7ITFyKJYOOsmFmpC02UABW31lsDemjDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvHesagVAwLgQ5LBZuRnQwTxEjAxZ6VDgAWPU7KmIm5QTFo6ToG6inzr4xWZoC3NaDbpNVXcOR7BsVlqMajEF3x75ZXRL0exVjp5X7kdPk1nh8iAtMLzYV1oYUusOnv79K19/86yR1y9vrxZOb+PiUvFF6UpJmqvpi144r680no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3Ko+ygb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso16269495e9.3
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744352649; x=1744957449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DodMmWsAmflDv1t1w9QYezrFNV6jGOM8UYEHcdAg7uc=;
        b=J3Ko+ygbm7ZcAOsLTBCddBnpCDsWXpT/D6d0wg2WZBbE0tlJRbIWM4ZU7k5uqCyob3
         0jgpPUB4rE1Tcd55tiEFX3hb4uk9+39vBRv9R4TQpaD2G43HRBt3PDx2rrXJztdA/XmQ
         m8hRJ6PoXyPGAl+l3oCpTjViRvrIBr06L+VOhi1L6oOjHN7au/m+6Yx44x9611hF/gaV
         5IRTtFaIcCq3wIgzmkjcg8B+CD4x6qGnMIzDg+m/ENxUy1fGG1pusiIONmgUWdm9WTGn
         ChMnITeJqRP1BKw8/mjbUP96/yRcDN04mvbFcbkGSHVEiSNr8xA4yv58sbcDxqmWAXCt
         ne1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744352649; x=1744957449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DodMmWsAmflDv1t1w9QYezrFNV6jGOM8UYEHcdAg7uc=;
        b=EnQpzeH8jtrZDd9rUMexbNVkADS+gYM/u8lU05VzpdZPfk7w9dT0pL261XZtxpC1/c
         +Kfy53t8jUKsv5kMwsPkhhdQ2btmCGZA5+rIQ2rBv2c6S9JTuo4TIJOcQJ0vOMy5VkGi
         C8fj1BIfbVLDiosPsyMArgDnX0asb29GY+5Xg8yaEXbSATFvjqq3hcY6fpJa7/GcE//b
         sIEwRhzYYv9j1z8X1GGfbi6JAMB6v8gDls5jYQEhXJsbmd/LXFqJWVxNXP4jspj9kjja
         7Sx12uBm8C5gqzYwlLjOtRm2ACjfJOPrK9YtgzWwQLb5iW1S0zKLbi7cF0cnYeylwWxI
         IO5g==
X-Gm-Message-State: AOJu0Yxpm8j+eR0jjEPiMMRk8QrVmCrCL5xJBVr3DYa1XxOkhBrRti/0
	Syk8a7f3gEsRflMYxOf7vhFU9WUnFHtvIIVavMRig0wRw1fHi9ng
X-Gm-Gg: ASbGncskWAv/73IyCW6odIel8gdIr2Yse5lRDIVCbdlchLlm8DCyHj821B5xpYS1JP9
	+owSBomIgnM5+eoyfzuwTFGNioJ/1NSML6skYRKORz3E8Gx/DLxdYuTq6Ku+YGCHF2qKgBNQxxw
	phDxXWhhnQyhBMbpKdRtCeV+K0W8mJv48tgz63wE6wuRFcPQciPjHI+LdTRqabbNcYJZmQsIb0N
	L3zElB5eMu4IJirFvSXGy4wevqkiSu0F+WTZGmFZBUdPMrpCO1uSCfZsddE35481b6w9i9KYfOQ
	7F9UX+oMdzoUIlORHjXOyYRjwANK++qt1KZhODGjyRQMdEzMWXCFZe7CMEZRLiff/79BclfVyVE
	R+L6BWMiDmlJzbds0VQSnuXyrpbvGTKvl4ZcHhYqkZYHksGqhnV2i3n9v0WkPM2Pk
X-Google-Smtp-Source: AGHT+IGHpIHJjG4VACIt2V7R6sebYIXXo4TRjlTjO6ZDVrk/IgamHZ1JFkLNSsCsZXjY3inSVW5vqg==
X-Received: by 2002:a05:600c:1d83:b0:43d:300f:fa1d with SMTP id 5b1f17b1804b1-43f3a9aed73mr12273745e9.31.1744352649231;
        Thu, 10 Apr 2025 23:24:09 -0700 (PDT)
Received: from ?IPV6:2003:ed:7734:bbcd:e64:e834:bb2:71a8? (p200300ed7734bbcd0e64e8340bb271a8.dip0.t-ipconnect.de. [2003:ed:7734:bbcd:e64:e834:bb2:71a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d0fcsm76177855e9.19.2025.04.10.23.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 23:24:08 -0700 (PDT)
Message-ID: <aa2e2b6f-5db8-4ef9-bad9-dddf699afae5@gmail.com>
Date: Fri, 11 Apr 2025 08:24:07 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: filter: remove dead instructions in filter
 code
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <525d54bc-5259-49f2-acbf-7396bab48dec@gmail.com>
 <CAADnVQ+ip7yB-8deWjHNBQxZHhV1Xi-5gTiYJVRy4gU5+Chkqw@mail.gmail.com>
Content-Language: en-US
From: Lion Ackermann <nnamrec@gmail.com>
In-Reply-To: <CAADnVQ+ip7yB-8deWjHNBQxZHhV1Xi-5gTiYJVRy4gU5+Chkqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/10/25 5:05 PM, Alexei Starovoitov wrote:
> On Thu, Apr 10, 2025 at 1:32 AM Lion Ackermann <nnamrec@gmail.com> wrote:
>>
>> It is well-known to be possible to abuse the eBPF JIT to construct
>> gadgets for code re-use attacks. To hinder this constant blinding was
>> added in "bpf: add generic constant blinding for use in jits". This
>> mitigation has one weakness though: It ignores jump instructions due to
>> their correct offsets not being known when constant blinding is applied.
>> This can be abused to construct "jump-chains" with crafted offsets so
>> that certain desirable instructions are generated by the JIT compiler.
>> F.e. two consecutive BPF_JMP | BPF_JA codes with an appropriate offset
>> might generate the following jumps:
>>
>>     ...
>>     0xffffffffc000f822:    jmp    0xffffffffc00108df
>>     0xffffffffc000f827:    jmp    0xffffffffc0010861
>>     ...
>>
>> If those are hit unaligned we can get two consecutive useful
>> instructions:
>>
>>     ...
>>     0xffffffffc000f823:    mov    $0xe9000010,%eax
>>     0xffffffffc000f828:    xor    $0xe9000010,%eax
>>     ...
> 
> Nack.
> This is not exploitable.
> We're not going to complicate classic bpf because of theoretical concerns.
> 
> pw-bot: cr

This is not a theoretical concern, it is actually very practical. Sorry
for not making this clearer. I would rather not share full payloads
publicly at this point, though.
I understand that it is undesirable to complicate the code, but after
some initial discussion this seemed to be the least intrusive option.
However I would appreciate suggestions for better solutions..

Thanks,
Lion

